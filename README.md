# Drive Wipe script

A PowerShell script for securely wiping non-system drives on Windows systems. This script provides a safe way to sanitize drives by overwriting them with zeros.

## ⚠️ Warning

This script will **permanently erase** all data on the selected drive. Use with extreme caution. Always verify your drive selection carefully before proceeding.

## Features

- Interactive drive selection
- System drive protection
- Clear warnings and confirmations
- Simple zero-fill sanitization
- Error handling and progress feedback
- Safety checks to prevent accidental system drive wiping

## Prerequisites

- Windows operating system
- PowerShell
- Administrator privileges

## Usage

1. Run PowerShell as Administrator
2. Navigate to the script directory
3. Run the script:
```powershell
.\Drive_Wipe.ps1
```
4. Select a drive from the displayed list
   
![image](https://github.com/user-attachments/assets/9dd446e5-7a88-4a85-8738-2091e260a8b5)

5. Confirm the operation when prompted
   
![image](https://github.com/user-attachments/assets/64e94645-6d9b-4a66-97ed-2bef206ad312)


## Safety Features

- Automatically excludes system drive from available options
- Requires explicit confirmation before wiping
- Validates drive selection
- Includes error handling and cleanup

## Limitations

- Basic data sanitization only (single-pass zero fill)
- Not suitable for classified or highly sensitive data
- Does not meet certified data destruction standards

## Security Note

For sensitive data destruction, consider using:
- Dedicated secure erasure tools (e.g., DBAN)
- Multiple-pass overwriting methods
- Professional data destruction services
- Physical drive destruction

## License

[MIT License](LICENSE)

## Disclaimer

This script is provided as-is, without any warranty. The author is not responsible for any data loss or damage caused by using this script. Always verify and backup important data before using any data destruction tool.
