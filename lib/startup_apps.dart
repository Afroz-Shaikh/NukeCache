import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

const MAX_VALUE_NAME_LENGTH = 16383; // Maximum length of a registry value name

class StartupAppsListWidget extends StatefulWidget {
  @override
  _StartupAppsListWidgetState createState() => _StartupAppsListWidgetState();
}

class _StartupAppsListWidgetState extends State<StartupAppsListWidget> {
  List<String> _startupApps = [];

  @override
  void initState() {
    super.initState();
    getStartupApps();
  }

  Future<void> getStartupApps() async {
    try {
      final registryKey = HKEY_LOCAL_MACHINE;
      final subkeyPath =
          TEXT("SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run");
      final desiredAccess = KEY_READ;

      final openResult = RegOpenKeyEx(
        registryKey,
        subkeyPath,
        0,
        desiredAccess,
        nullptr,
      );

      if (openResult == ERROR_SUCCESS) {
        final subkeyCountResult = calloc<ULONG>();
        final valueCountResult = calloc<ULONG>();
        RegQueryInfoKey(
          openResult,
          nullptr,
          nullptr,
          nullptr,
          subkeyCountResult,
          nullptr,
          nullptr,
          valueCountResult,
          nullptr,
          nullptr,
          nullptr,
          nullptr,
        );

        final valueCount = valueCountResult.value;

        for (var i = 0; i < valueCount; i++) {
          final valueName = calloc<Uint16>(MAX_VALUE_NAME_LENGTH);
          final valueNameLength = calloc<Uint32>()
            ..value = MAX_VALUE_NAME_LENGTH;

          final dataType = calloc<Uint32>();
          final dataSize = calloc<Uint32>();

          final result = RegEnumValue(
            openResult,
            i,
            valueName as Pointer<Utf16>,
            valueNameLength.value as Pointer<Uint32>,
            nullptr,
            dataType,
            nullptr,
            dataSize,
          );

          if (result == ERROR_SUCCESS) {
            final data = calloc<Uint16>(MAX_PATH);
            final dataTypeInt = dataType.value;
            RegQueryValueEx(
              openResult,
              valueName as Pointer<Utf16>,
              nullptr,
              dataType,
              data.cast(),
              dataSize,
            );

            if (dataTypeInt == REG_SZ) {
              final value = data.cast<Utf16>().toDartString();
              _startupApps.add(value);
            }

            calloc.free(data);
          }

          calloc.free(dataType);
          calloc.free(dataSize);
          calloc.free(valueName);
          calloc.free(valueNameLength);
        }

        calloc.free(subkeyCountResult);
        calloc.free(valueCountResult);
        RegCloseKey(openResult);
      }

      setState(() {});
    } catch (e) {
      print('Error getting startup apps: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Startup Apps')),
      body: ListView.builder(
        itemCount: _startupApps.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_startupApps[index]),
          );
        },
      ),
    );
  }
}
