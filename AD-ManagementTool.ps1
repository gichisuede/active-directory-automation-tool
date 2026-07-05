<#
.SYNOPSIS
    Administrator tool form user management.

.DESCRIPTION
    This tool can be used to do the following:
	-Create a User
	-Disable a User
	-Unlock User
	-Add User to Group
	-Generate Report

.NOTES
    Author: Tony Garza
    Project: AD User Management Tool
#>

# -----------------------------
# Configuration
# -----------------------------

$OU = 'OU=remote users,DC=corp,DC=contoso,DC=com'
$ReportPath = C:\project\destinationfolder\csv\UserManagementReport.csv

# -----------------------------
# Functions
# -----------------------------

function Create-User {
	$UserToCreate = Read-Host "Enter username to create:"
	$SecurePassword = Read-Host "Please enter temporary password:" -AsSecureString

	New-ADUser `
	-Name $UserToCreate `
	-SamAccountName $UserToCreate `
	-AccountPassword $SecurePassword `
	-Path $OU `
	-Enabled $true `
	-ChangePasswordAtLogon $True
	
	$Result = [PSCustomObject]@{
		Time   = Get-Date
		Action = 'Create User'
		Target = $UserToCreate
		Status = 'Completed'
    }
    return $Result
}

function Disable-User{
	$UserToDisable = Read-Host "Enter username to disable:"

	Set-ADUser `
	-Identity $UserToDisable `
	-Enabled $False

	$Result = [PSCustomObject]@{
		Time	=  Get-Date
		Action	=  'Disable User'
		Target 	=  $UserToDisable
		Status	=  'Completed'	
	}
	return $Result
}

function Unlock-User{
	$UserToUnlock = Read-Host "Enter username to unlock"

	Unlock-ADAccount `
	-Identity $UserToUnlock 
	
	$Result = [PSCustomObject]@{
		Time	=  Get-Date
		Action	=  'Unlock User'
		Target	=  $UserToUnlock
		Status	=  'Completed'
	}
	return $Result
}

function AddUserTo-Group {
	$UserToAdd = Read-Host "Please enter username:"
	$Group = Read-Host "Please enter target group:"

	Add-ADGroupMember `
	-Identity $Group `
	-Members $UserToAdd

	$Result = [PSCustomObject]@{
		Time	=  Get-Date
		Action	=  'Add User to Group'
		Target	=  $UserToAdd
		Group	=  $Group
		Status	=  'Completed'
	}
	return $Result
}

function Generate-Report{
		$ReportFolder = Split-Path -Path $ReportPath
		$ReportList | Export-Csv -Path $ReportPath -NoTypeInformation
		Write-Host "Report has been created in $ReportFolder"
	}


# -----------------------------
# Import Data
# -----------------------------

$ReportList = @()

# -----------------------------
# Main Processing
# -----------------------------

do{
	'Please select from the following options:'

	'1. Create User'
	'2. Disable User'
	'3. Unlock User'
	'4. Add User to Group'
	'5. Create a report'
	'6. Exit'

	$Choice = Read-Host "Enter your selection"

	switch ($Choice) {
		
		"1"{
			$Result = Create-User
			$ReportList += $Result
			}

		"2" {
			$Result = Disable-User
			$ReportList += $Result
			}
			
		"3" {
			$Result = Unlock-User
			$ReportList += $Result
			}
		"4" {
			$Result = AddUserTo-Group
			$ReportList += $Result
			}
		"5" {
			Generate-Report
			}
		"6" {
			'Exit'
			}

}


		

} until ($Choice -eq '6')
##### Gitupdate
