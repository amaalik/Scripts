# Import the Active Directory module
Import-Module ActiveDirectory

# Set the number of inactive days (in this case, 30 days)
$inactiveDays = 30

# Calculate the date 30 days ago from today
$lastActiveDate = (Get-Date).AddDays(-$inactiveDays)

# Get the list of users who have not been active for over 30 days
$inactiveUsers = Get-ADUser -Filter {LastLogonDate -lt $lastActiveDate -and Enabled -eq $true} -Property Name, LastLogonDate

# Check if there are any inactive users
if ($inactiveUsers) {
    Write-Output "`nList of Users Inactive for Over $inactiveDays Days and Deactivated Successfully:`n"

    # Loop through each inactive user
    foreach ($user in $inactiveUsers) {
        # Disable (deactivate) the user account
        Disable-ADAccount -Identity $user.SamAccountName

        # Confirm and list the deactivated user
        Write-Output "User: $($user.Name) has been deactivated successfully."
    }
} else {
    Write-Output "No inactive users found in Active Directory for over $inactiveDays days."
}
