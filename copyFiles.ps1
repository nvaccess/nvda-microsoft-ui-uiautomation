param(
    [String]$RepoRoot = $(Get-Location),
    [String]$BuildDir = $(Join-Path $(Get-Location) "build"),
    [String]$DestDir = $(Join-Path $(Get-Location)"out")
)
##
# Collects files from the build of the Microsoft-UI-UIAutomation Remote Operations library.

function CopyFileStructure(
    [String]$OriginRelativeDir,  # Origin files are all relative to this dir.
    [String]$DestDir,  # Destination relative to this dir.
    [String[]]$RelativeOriginFiles
){
    Write-Output $("From: " + $OriginRelativeDir)
    Write-Output $("To: " + $DestDir)
    $RelativeOriginFiles.ForEach({
        Write-Output $("Copying: " + $_)
        $itemOrigin = Join-Path $OriginRelativeDir $_
        $itemDest = Join-Path $DestDir $_
         # Ensure the dest path exists
        $null = New-Item -ItemType File -Path $itemDest -Force
        # Overwrite the blank file
        $null = Copy-Item $itemOrigin -Destination $itemDest -Force
    })
    Write-Output " "
}

# Populate Lib dir
$libDir = Join-Path $DestDir "lib"
CopyFileStructure -OriginRelativeDir $RepoRoot -DestDir $libDir -RelativeOriginFiles @(
    $("Microsoft.UI.UIAutomation.dll.manifest")
)

CopyFileStructure -OriginRelativeDir $BuildDir -DestDir $libDir -RelativeOriginFiles @(
    $("winmd/Microsoft.UI.UIAutomation.winmd"),

    $("Microsoft.UI.UIAutomation.dll"),
    $("Microsoft.UI.UIAutomation.lib"),
    $("Microsoft.UI.UIAutomation.exp"),
    $("Microsoft.UI.UIAutomation.pdb"),

    $("UiaOperationAbstraction.lib"),
    $("UiaOperationAbstraction.pdb")
)

$MsUiaSubModuleSrcDir = Join-Path $RepoRoot "microsoft-ui-uiautomation\src\UIAutomation\"

$includesDir = Join-Path $DestDir 'include'
CopyFileStructure -OriginRelativeDir $MsUiaSubModuleSrcDir -DestDir $includesDir -RelativeOriginFiles @(
    $('UiaOperationAbstraction/UiaOperationAbstraction.h'),
    $('UiaOperationAbstraction/UiaTypeAbstractionEnums.g.h'),
    $('UiaOperationAbstraction/UiaTypeAbstraction.g.h'),
    $('UiaOperationAbstraction/SafeArrayUtil.h')
)

$genSrcDir = Join-Path $MsUiaSubModuleSrcDir "microsoft.ui.uiautomation/Generated Files"
CopyFileStructure -OriginRelativeDir $genSrcDir -DestDir $includesDir -RelativeOriginFiles @(
    $('winrt/microsoft.ui.uiautomation.h'),
    $('winrt/impl/microsoft.ui.uiautomation.0.h'),
    $('winrt/impl/microsoft.ui.uiautomation.1.h'),
    $('winrt/impl/microsoft.ui.uiautomation.2.h')
)
