## nvda-microsoft-ui-uiautomation

Creates NVDAs binary dependencies on the microsoft-ui-uiautomation library.

Builds the open source Microsoft-UI-UIAutomation Remote Operations library from
https://github.com/microsoft/microsoft-ui-uiautomation.

This library contains both a low-level winrt API, and a higher-level pure C++ API.
Once built, the following outputs are copied and committed to the `main-out` branch.

The outputs:
* `lib` directory:
  * `microsoft.ui.uiAutomation[.dll .lib .dll.manifest]`:
    The shared libraries containing the low-level winrt implementation.
    To use in other code, link against the `.lib`, and load the included `.manifest` file into
    an activation context and activate it.
  * `UiaOperationAbstraction.lib`:
    A static library containing runtime code for the higher-level pure C++ API.
    This should be linked into any compiled executable or library that needs to use the
    higher-level C++ API.
* `include` directory:
  * `UIAOperationAbstraction` directory: All public headers for the high-level C++ API.
  * `winrt` directory: The generated C++/winrt language bindings of the low-level API,
    required by the high-level C++ API headers.

### Clone
Ensure submodules are cloned.
The `microsoft-ui-uiautomation` repository is a submodule.

### Generate outputs

Use powershell:
- `mkdir out` Create an output directory.
- `./build.ps1 -OutDir build`  Build the libraries.
- `./copyFiles.ps1 -RepoRoot "./" -BuildDir "build" -DestDir "out"`  Generate complete structure.

### Notes on generate.yml workflow
Directories:
- `source`: tracks `main`
- `out`: tracks `main-out`
- `build`: binary output from building `source`
- Headers are copied from `source` to `out`
- Binaries are copied from `build` to `out`
- Changes in `out` are added/commited to the `main-out` branch.
