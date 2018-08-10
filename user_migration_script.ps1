Write-Output "***Run this script as an administrator***
This script will migrate a user profile from a remote computer to the local computer `n"

$FoldersToCopy = @(
    'Desktop'
    'Documents'
    'Downloads'
    'Music'
    'Pictures'
    'Videos'
    )

$User = Read-Host "Enter a username"
$RemoteComputer = Read-Host "Enter a source computer name"
$UserPrompt = Read-Host "$User will be copied from $RemoteComputer to this local machine. Is this correct? (Y/N)"

$SourceRoot = "\\$RemoteComputer\c$\Users\$User"
$DestinationRoot = "C:\Users\$User"

if ($UserPrompt -eq 'Y')
{
    foreach ($Folder in $FoldersToCopy)
    {
        $Source = Join-Path -Path $SourceRoot -ChildPath $Folder
        $Destination = Join-Path -Path $DestinationRoot -ChildPath $Folder

        Robocopy.exe $Source $Destination /XD "Temp" "Temporary Internet Files" "OfficeFileCache" /XJ /XF *.ost pagefile.sys /z /e /r:0 /w:0
    }
}

elseif ($UserPrompt -eq 'N')
{
    Write-Host 'Quitting...'
    break
}