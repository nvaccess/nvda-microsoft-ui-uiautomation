## nvda-microsoft-ui-uiautomation

Creates NVDAs binary dependencies on the microsoft-ui-uiautomation library.

Builds the open source Microsoft-UI-UIAutomation Remote Operations library from
https://github.com/microsoft/microsoft-ui-uiautomation.

This library contains both a low-level winrt API, and a higher-level pure C++ API.

### Clone
Ensure submodules are cloned.
The `microsoft-ui-uiautomation` repository is a submodule.

### Build

Use powershell:
- `mkdir out` Create an output directory.
- `build.ps1 -OutDir out`