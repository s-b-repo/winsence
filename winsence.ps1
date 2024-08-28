# Script to check Windows license expiration date and save the result to a file on Desktop

function Get-WindowsLicenseExpiration {
    # Get the desktop path
    $desktopPath = [System.Environment]::GetFolderPath('Desktop')
    $outputFile = "$desktopPath\WindowsLicenseExpiration.txt"

    # Get license status
    $licenseInfo = slmgr /xpr

    # Extract the expiration status and date (if available)
    $expirationDate = $licenseInfo | Select-String -Pattern "will expire on"

    if ($expirationDate) {
        $expirationDate = $expirationDate -replace '.*will expire on\s*', ''
        $outputMessage = "Your Windows license will expire on: $expirationDate"
        Write-Host $outputMessage -ForegroundColor Green
    } else {
        $outputMessage = "Your Windows license is permanently activated or the expiration date is not available."
        Write-Host $outputMessage -ForegroundColor Yellow
    }

    # Write the result to the file on the desktop
    $outputMessage | Out-File -FilePath $outputFile -Force
    Write-Host "Result saved to: $outputFile" -ForegroundColor Cyan
}

Get-WindowsLicenseExpiration
