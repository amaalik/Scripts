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
    Write-Output "`nList of Users Inactive for Over $inactiveDays Days:`n"
    
    # Print the list of inactive users with their last logon date
    foreach ($user in $inactiveUsers) {
        $lastLogon = $user.LastLogonDate
        if (!$lastLogon) { $lastLogon = "Never" }  # If LastLogonDate is null, set it to "Never"
        
        Write-Output "User Name: $($user.Name), Last Logon Date: $lastLogon"
    }
} else {
    Write-Output "No inactive users found in Active Directory for over $inactiveDays days."
}
