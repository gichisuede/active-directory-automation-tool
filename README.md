# active-directory-automation-tool
An interactive PowerShell utility for streamlining Active Directory user management and logging. 

# Active Directory User Lifecycle Automation Tool

A modular, interactive PowerShell utility designed to streamline common Active Directory administration tasks, enforce security compliance, and generate auditable transaction logs.

## Features
* **Interactive Group Management:** Quickly search for and add users to AD groups via terminal prompts.
* **Secure Input Handling:** Masked password collection with mandatory double-entry validation.
* **Structured Auditing:** Utilizes `[PSCustomObject]` to output clean, trackable system change logs.

## Prerequisites
* Windows PowerShell 5.1 or PowerShell 7+
* Remote Server Administration Tools (RSAT) with the `ActiveDirectory` module installed.

## Usage
To run the interactive utility, open PowerShell as an Administrator and execute:
```powershell
.\AD-ManagementTool.ps1
```

## Key Technical Takeaways
* **Data Typing:** Transitioned from raw hashtables to typed `[PSCustomObject]` structures to ensure seamless formatting in the PowerShell pipeline.
* **Secure String Operations:** Leveraged .NET Interop libraries to securely handle and compare masked passwords without exposing plain text in memory.
