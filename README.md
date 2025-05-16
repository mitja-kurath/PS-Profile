# PowerShell Unix-like Prompt

This script provides a custom PowerShell prompt function that mimics the appearance of a Unix/Linux shell prompt. It displays the current location using forward slashes and includes the current time.

## Features

*   Displays FileSystem paths in a Unix-like format (e.g., `/c/users/username`).
*   Handles non-FileSystem locations (like `Variable:`, `Registry:`) gracefully.
*   Includes the current time in the prompt (`[HH:mm:ss] >`).

## Setup

To use this custom prompt, you need to save the script and then load it into your PowerShell session.

1.  **Save the script:** Save the provided PowerShell code into a file, for example, `unix_prompt.ps1`.

2.  **Load the script:**
    *   **For the current session:** Open PowerShell and dot-source the script:
        ```powershell
        . .\unix_prompt.ps1
        ```
    *   **To make it permanent:** Add the dot-sourcing command to your PowerShell profile file. If you don't have a profile file, you can create one.
        ```powershell
        # To find your profile path (may vary depending on user/host)
        $PROFILE

        # Example: Create the profile file if it doesn't exist
        if (!(Test-Path -Path $PROFILE)) {
            New-Item -Path $PROFILE -ItemType File -Force
        }

        # Add the dot-sourcing command to your profile file
        # (Replace .\unix_prompt.ps1 with the actual path if needed)
        Add-Content -Path $PROFILE -Value "`n. <path_to_your_script>\unix_prompt.ps1"
        ```
        *Remember to replace `<path_to_your_script>` with the actual location where you saved `unix_prompt.ps1`.*

After loading the script (either via dot-sourcing or by restarting PowerShell if added to the profile), your prompt should change.

## Usage

Once the script is loaded, the prompt will automatically update to the new format whenever you navigate or execute commands.

**Example Appearance:**

```
/c/Users/YourName
[14:30:55] > _
```

*(Where `_` represents your cursor)*

## How it Works

The script defines two functions:

1.  `ConvertTo-UnixPath`: This function takes a Windows-style path (`C:\path\to\file`) and converts it to a Unix-style path (`/c/path/to/file`) by replacing backslashes with forward slashes and transforming the drive letter part.
2.  `prompt`: This is a special PowerShell function. When defined, PowerShell executes this function to determine what to display as the command prompt. This function retrieves the current location, uses `ConvertTo-UnixPath` if it's a FileSystem path, displays the formatted path in green, adds the current time in green, and finally displays the `> ` symbol.
