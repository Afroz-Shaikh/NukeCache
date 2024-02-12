
#include "windows_settings_launcher_plugin.h"

#include <windows.h>
#include <string>
#include <flutter/binary_messenger.h>
#include <flutter/standard_method_codec.h>
#include <flutter/method_channel.h>
#include <flutter/method_result_functions.h>

#pragma comment(lib, "Shell32.lib")

namespace {

std::wstring GetSettingsUri() {
  return L"ms-settings:about";
}

}  // namespace

WindowsSettingsLauncherPlugin::WindowsSettingsLauncherPlugin() = default;

WindowsSettingsLauncherPlugin::~WindowsSettingsLauncherPlugin() = default;

void WindowsSettingsLauncherPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<>>(
          registrar->messenger(), "windows_settings_launcher",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<WindowsSettingsLauncherPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddMethodCallDelegate("windows_settings_launcher",
                                   std::move(plugin));
}

void WindowsSettingsLauncherPlugin::HandleMethodCall(
    const flutter::MethodCall<> &method_call,
    std::unique_ptr<flutter::MethodResult<>> result) {
  if (method_call.method_name().compare("launchWindowsSettings") == 0) {
    auto uri = GetSettingsUri();
    ShellExecuteW(NULL, L"open", uri.c_str(), NULL, NULL, SW_SHOWNORMAL);
    result->Success();
  } else {
    result->NotImplemented();
  }
}
