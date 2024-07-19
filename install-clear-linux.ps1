# Set the path for the tar file
$tarFilePath = Join-Path -Path "C:\wsl_distros\sources" -ChildPath "clear_linux_rootfs.tar.zst"

# Check if WSL is enabled
if ((Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-for-Linux).State -ne "Enabled") {
    try {
        Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-for-Linux -All
        Write-Host "WSL has been enabled."
    } catch {
        Write-Host "Error enabling WSL: $_.Exception.Message"
        exit
    }
}

# Check if WSL 2 is enabled
if ((Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform).State -ne "Enabled") {
    try {
        Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All
        Write-Host "WSL 2 has been enabled."
    } catch {
        Write-Host "Error enabling WSL 2: $_.Exception.Message"
        exit
    }

    # Set WSL 2 as the default version
    try {
        wsl --set-default-version 2
        Write-Host "WSL 2 has been set as the default version."
    } catch {
        Write-Host "Error setting WSL 2 as default: $_.Exception.Message"
        exit
    }
}

# Download the tar file
$tarFileUrl = "https://github.com/NextGenOP/clear-linux-on-wsl/releases/download/latest/clear_linux_rootfs.tar.zst"
try {
    Invoke-WebRequest -Uri $tarFileUrl -OutFile $tarFilePath -ErrorAction Stop
    Write-Host "Tar file downloaded successfully."
} catch {
    Write-Host "Error downloading the tar file: $_.Exception.Message"
    exit
}

# Update WSL and import the tar file
try {
    wsl.exe --update
    wsl.exe --import ClearLinux C:\wsl_distros\ClearLinux $tarFilePath --version 2
} catch {
    Write-Host "Error importing tar file: $_.Exception.Message"
    exit
}

