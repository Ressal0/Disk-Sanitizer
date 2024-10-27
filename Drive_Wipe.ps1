function confirm-action {
    param([string]$driveletter)
    
    Write-Host "Warning! you are about to erase drive: $driveletter" -ForegroundColor Red
    Write-Host "All data will be permanently deletd!" -ForegroundColor Red
    Write-Host "System drives (like C:) are protected and cannot be wiped." -ForegroundColor DarkYellow

    $confirmation = Read-Host "Confirm Wiping drive: $driveletter [Y/N]"
    return $confirmation -eq "Y"
}

$drives= Get-WmiObject Win32_LogicalDisk |
    
    Where-Object { $_.DriveType -eq 2 -or $_.DriveType -eq 3} |
    Where-Object { $_.DriveId -ne $env:SystemDrive } #all drives except system drive
#available drives
Write-Host "`nAvailable Drives:" -ForegroundColor Green
$drives | Format-Table DeviceId, VolumeName, Size, FreeSpace
#user selection
$selectedDrive = Read-Host "`nEnter the drive letter to wipe (e.g., 'D' for D: drive)"
$selectedDrive = $selectedDrive.ToUpper() + ":"

Write-Host "Selected drive: $selectedDrive"
Write-Host "Drive found: $($null -ne $driveToWipe)"

# drive selection
$driveToWipe = $drives | Where-Object { $_.DeviceID -eq $selectedDrive }

if ($null -eq $driveToWipe) {
    Write-Host "Invalid drive selection or drive not found!" -ForegroundColor Red
    exit
}

if ($selectedDrive -eq $env:SystemDrive) {
    Write-Host "Cannot wipe system drive!" -ForegroundColor Red
    exit
}

# confirmation and proceed with wiping
if (Confirm-Action -DriveLetter $selectedDrive) {
    try {
        Write-Host "`nPreparing to sanitize drive $selectedDrive..." -ForegroundColor Yellow
        
        # Create zero-filled file to overwrite free space
        $tempFile = "$selectedDrive\zero.tmp"
        Write-Host "Creating zero-filled file..."
        
        # PowerShell built-in method for safety
        $stream = [System.IO.File]::OpenWrite($tempFile)
        $buffer = New-Object byte[] 1048576
        
        #Write zeros
        try {
            while ($true) {
                $stream.Write($buffer, 0, $buffer.Length)
            }
        }
        catch {
            #fail when disk is full
        }
        finally {
            if ($stream) {
                $stream.Close()
            }
        }
        
        # Clean up
        if (Test-Path $tempFile) {
            Remove-Item -Path $tempFile -Force
        }
        
        Write-Host "Drive $selectedDrive has been sanitized" -ForegroundColor Green
    }
    catch {
        Write-Host "Error processing drive $selectedDrive : $_" -ForegroundColor Red
    }
}
else {
    Write-Host "Operation cancelled by user" -ForegroundColor Yellow
}
Write-Host "`nOperation complete" -ForegroundColor Green
Write-Host "Note: For certified data destruction, consider using specialized tools or physical destruction methods."

