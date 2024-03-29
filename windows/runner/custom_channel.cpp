#include "flutter_window.h"
#include "flutter/generated_plugin_registrant.h"
#include <string>
#include <windows.h>

#include <flutter/binary_messenger.h>
#include <flutter/standard_method_codec.h>
#include <flutter/method_channel.h>
#include <flutter/method_result_functions.h>
#include <flutter/encodable_value.h>
#include <../standard_codec.cc>

namespace custom_channels {
    class createChannelSettingsLauncher {
    public:
        createChannelSettingsLauncher(flutter::FlutterEngine *engine) {
            initialize(engine);
        }

        void initialize(flutter::FlutterEngine *FlEngine) {
            const static std::string channel_name("windows_settings_launcher");
            flutter::BinaryMessenger *messenger = FlEngine->messenger();
            const flutter::StandardMethodCodec *codec = &flutter::StandardMethodCodec::GetInstance();
            auto channel = std::make_unique<flutter::MethodChannel<>>(messenger, channel_name, codec);

            channel->SetMethodCallHandler(
                [&](const flutter::MethodCall<>& call, std::unique_ptr<flutter::MethodResult<>> result) {
                    AddMethodHandlers(call, &result);
                });
        }
void AddMethodHandlers(const flutter::MethodCall<>& call, std::unique_ptr<flutter::MethodResult<>> *result) {
    if (call.method_name().compare("launchAboutSettings") == 0) {
        try {
            LaunchWindowsSettings(L"ms-settings:about", result);
        }
        catch (...) {
            (*result)->Error("An error occurred while launching Windows settings");
        }
    }
    else if (call.method_name().compare("launchStartupAppsSettings") == 0) {
        try {
            LaunchWindowsSettings(L"ms-settings:startupapps", result);
        }
        catch (...) {
            (*result)->Error("An error occurred while launching Windows settings");
        }
    }
    else if (call.method_name().compare("launchDefaultAppsSettings") == 0) {
        try {
            LaunchWindowsSettings(L"ms-settings:defaultapps", result);
        }
        catch (...) {
            (*result)->Error("An error occurred while launching Windows settings");
        }
    }
    else {
        (*result)->NotImplemented();
    }
}

void LaunchWindowsSettings(LPCWSTR settingsCommand, std::unique_ptr<flutter::MethodResult<>> *result) {
    // Launch Windows settings
    ShellExecuteW(NULL, L"open", settingsCommand, NULL, NULL, SW_SHOWNORMAL);
    (*result)->Success(nullptr);
}

     
    };
}
