#include "flutter_window.h"

#include <optional>

#include <flutter/standard_method_codec.h>

#include "flutter/generated_plugin_registrant.h"

FlutterWindow::FlutterWindow(const flutter::DartProject& project)
    : project_(project) {}

FlutterWindow::~FlutterWindow() {}

bool FlutterWindow::OnCreate() {
  if (!Win32Window::OnCreate()) {
    return false;
  }

  RECT frame = GetClientArea();

  // The size here must match the window dimensions to avoid unnecessary surface
  // creation / destruction in the startup path.
  flutter_controller_ = std::make_unique<flutter::FlutterViewController>(
      frame.right - frame.left, frame.bottom - frame.top, project_);
  // Ensure that basic setup of the controller was successful.
  if (!flutter_controller_->engine() || !flutter_controller_->view()) {
    return false;
  }
  RegisterPlugins(flutter_controller_->engine());
  SetChildContent(flutter_controller_->view()->GetNativeWindow());

  window_channel_ =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          flutter_controller_->engine()->messenger(), "tdance/window",
          &flutter::StandardMethodCodec::GetInstance());
  window_channel_->SetMethodCallHandler(
      [this](const flutter::MethodCall<flutter::EncodableValue>& call,
             std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>>
                 result) {
        if (call.method_name() == "enterRestMode") {
          EnterRestMode();
          result->Success();
          return;
        }
        if (call.method_name() == "exitRestMode") {
          ExitRestMode();
          result->Success();
          return;
        }
        result->NotImplemented();
      });

  flutter_controller_->engine()->SetNextFrameCallback([&]() {
    this->Show();
  });

  // Flutter can complete the first frame before the "show window" callback is
  // registered. The following call ensures a frame is pending to ensure the
  // window is shown. It is a no-op if the first frame hasn't completed yet.
  flutter_controller_->ForceRedraw();

  return true;
}

void FlutterWindow::OnDestroy() {
  window_channel_ = nullptr;
  if (flutter_controller_) {
    flutter_controller_ = nullptr;
  }

  Win32Window::OnDestroy();
}

LRESULT
FlutterWindow::MessageHandler(HWND hwnd, UINT const message,
                              WPARAM const wparam,
                              LPARAM const lparam) noexcept {
  if (rest_mode_) {
    if (message == WM_CLOSE) {
      return 0;
    }
    if (message == WM_SYSCOMMAND) {
      const auto command = wparam & 0xfff0;
      if (command == SC_CLOSE || command == SC_MINIMIZE ||
          command == SC_MAXIMIZE) {
        return 0;
      }
    }
    if (message == WM_DISPLAYCHANGE || message == WM_DPICHANGED) {
      UpdateRestModeBounds();
      return 0;
    }
  }

  // Give Flutter, including plugins, an opportunity to handle window messages.
  if (flutter_controller_) {
    std::optional<LRESULT> result =
        flutter_controller_->HandleTopLevelWindowProc(hwnd, message, wparam,
                                                      lparam);
    if (result) {
      return *result;
    }
  }

  switch (message) {
    case WM_ACTIVATE:
      if (rest_mode_ && LOWORD(wparam) == WA_INACTIVE) {
        SetWindowPos(hwnd, HWND_TOPMOST, 0, 0, 0, 0,
                     SWP_NOMOVE | SWP_NOSIZE | SWP_SHOWWINDOW);
        SetForegroundWindow(hwnd);
        return 0;
      }
      break;
    case WM_FONTCHANGE:
      flutter_controller_->engine()->ReloadSystemFonts();
      break;
  }

  return Win32Window::MessageHandler(hwnd, message, wparam, lparam);
}

void FlutterWindow::EnterRestMode() {
  if (rest_mode_) {
    return;
  }

  const HWND hwnd = GetHandle();
  if (hwnd == nullptr) {
    return;
  }

  saved_window_style_ = GetWindowLongPtr(hwnd, GWL_STYLE);
  saved_window_ex_style_ = GetWindowLongPtr(hwnd, GWL_EXSTYLE);
  saved_window_visible_ = IsWindowVisible(hwnd);
  saved_window_placement_.length = sizeof(WINDOWPLACEMENT);
  GetWindowPlacement(hwnd, &saved_window_placement_);

  SetWindowLongPtr(hwnd, GWL_STYLE, WS_POPUP | WS_VISIBLE);
  SetWindowLongPtr(hwnd, GWL_EXSTYLE,
                   (saved_window_ex_style_ | WS_EX_TOOLWINDOW) &
                       ~static_cast<LONG_PTR>(WS_EX_APPWINDOW));

  rest_mode_ = true;
  UpdateRestModeBounds();
  ShowWindow(hwnd, SW_SHOW);
  SetForegroundWindow(hwnd);
  SetFocus(hwnd);
}

void FlutterWindow::ExitRestMode() {
  if (!rest_mode_) {
    return;
  }

  const HWND hwnd = GetHandle();
  if (hwnd == nullptr) {
    return;
  }

  rest_mode_ = false;
  SetWindowLongPtr(hwnd, GWL_STYLE, saved_window_style_);
  SetWindowLongPtr(hwnd, GWL_EXSTYLE, saved_window_ex_style_);
  SetWindowPlacement(hwnd, &saved_window_placement_);
  SetWindowPos(hwnd, HWND_NOTOPMOST, 0, 0, 0, 0,
               SWP_FRAMECHANGED | SWP_NOMOVE | SWP_NOSIZE);
  if (saved_window_visible_) {
    ShowWindow(hwnd, saved_window_placement_.showCmd);
    SetForegroundWindow(hwnd);
  } else {
    ShowWindow(hwnd, SW_HIDE);
  }
}

void FlutterWindow::UpdateRestModeBounds() {
  const HWND hwnd = GetHandle();
  if (hwnd == nullptr) {
    return;
  }

  const int x = GetSystemMetrics(SM_XVIRTUALSCREEN);
  const int y = GetSystemMetrics(SM_YVIRTUALSCREEN);
  const int width = GetSystemMetrics(SM_CXVIRTUALSCREEN);
  const int height = GetSystemMetrics(SM_CYVIRTUALSCREEN);
  SetWindowPos(hwnd, HWND_TOPMOST, x, y, width, height,
               SWP_FRAMECHANGED | SWP_SHOWWINDOW);
}
