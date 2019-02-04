$FoldersToCopy = @(
    'Desktop'
    'Documents'
    'Downloads'
    'Music'
    'Pictures'
    'Videos'
    'Favorites'
    )

$User = Read-Host "Enter a username"
$RemoteComputer = Read-Host "Enter a source computer name"
$UserPrompt = Read-Host "$User will be copied from $RemoteComputer to this local machine. Is this correct? (Y/N)"

$SourceRoot = "\\$RemoteComputer\c$\Users\$User"
$DestinationRoot = "C:\Users\$User"

if ($UserPrompt -eq 'Y' -or 'y')
{
    foreach ($Folder in $FoldersToCopy)
    {
        $Source = Join-Path -Path $SourceRoot -ChildPath $Folder
        $Destination = Join-Path -Path $DestinationRoot -ChildPath $Folder

        Robocopy.exe $Source $Destination /XD "Temp" "Temporary Internet Files" "OfficeFileCache" /XJ /XF *.ost pagefile.sys /z /e /r:0 /w:0
    }
}

elseif ($UserPrompt -eq 'N' -or 'n')
{
    break
}

Write-Output "User profile migration for $User on destination computer $RemoteComputer complete"