param(
    [Parameter(Mandatory=$true)]
    [System.String]
    $Target
)

if (!(Get-Command -ErrorAction Ignore -Type Application dotnet))
{
    Write-Warning 'dotnet was not found'
    Write-Host 'you have to install .NET SDK 7.0 to build this application'
    Write-Host 'you can download it here https://dotnet.microsoft.com/en-us/download/dotnet/'
    return
}

$ErrorActionPreference = "Stop"

if (($Target -ne 'android') -and ($Target -ne 'windows'))
{
    Write-Warning "'$Target' is not supported"
    Write-Host 'Available targets: android, windows'
    return
}

if ($Target -eq 'android')
{
    dotnet publish MauiApp1 --configuration Release --output publish/android --runtime android-arm64 --self-contained --property:JavaSdkDirectory="c:\Program Files (x86)\Android\openjdk\jdk-17.0.8.101-hotspot" --property:TargetFramework=net7.0-android
}
elseif ($Target -eq 'windows')
{
    dotnet publish MauiApp1 --configuration Release --output publish/windows --runtime win10-x64 --self-contained --property:DebugType=None --property:DebugSymbols=false --property:TargetFramework=net7.0-windows10.0.19041.0
}
