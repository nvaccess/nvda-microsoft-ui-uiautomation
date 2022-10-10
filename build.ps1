param(
    [String]$SubmoduleDir = "microsoft-ui-uiautomation",
    [String]$OutDir = "./build"
)
# Build the projects required by NVDA:
# - Prepare to build by restoring nuget packages
# - Build vcxproj projects: Microsoft_UI_UIAutomation, UiaOperationAbstraction

$ErrorActionPreference = "Stop"  # Powershell directive
$outPath = Convert-Path -LiteralPath $OutDir

# Building with msbuild requires windir to be set as environment variable,
# otherwise the build fails with Visual Studio 2022
# This should already be set, but test to ensure:
if (!$env:windir){
    throw "windir environment variable was expected to be set."
}

$outDirProp = "OutDir=${outPath}/"
$slnFile = "${SubmoduleDir}/src/uiAutomation/UIAutomation.sln"
$buildConfigProp = "Configuration=Release,Platform=x86"
$restorePackagesProp = "RestorePackagesConfig=true"

# restore nuget packages
msbuild $slnFile -t:Restore -p:$restorePackagesProp,$buildConfigProp

# If the project name contains any of the characters %, $, @, ;, ., (, ), or ',
# replace them with an _ in the specified target name.
$UIAutomationProj = "Microsoft_UI_UIAutomation" # vcxproj: Microsoft.UI.UIAutomation
$OpAbstractionProj = "UiaOperationAbstraction" # vcxproj: UiaOperationAbstraction

# Build vcxproj projects: Microsoft.UI.UIAutomation, UiaOperationAbstraction
msbuild $slnFile -t:$UIAutomationProj,$OpAbstractionProj -p:$buildConfigProp,$outDirProp
