# Import the Active Directory module
Import-Module ActiveDirectory

# Get the list of disabled (deactivated) users
$disabledUsers = Get-ADUser -Filter {Enabled -eq $false} -Property Name, SamAccountName, DistinguishedName

# Check if there are any deactivated users
if ($disabledUsers) {
    Write-Output "`nList of Deactivated (Disabled) Users:`n"

    # Loop through and display each deactivated user
    foreach ($user in $disabledUsers) {
        Write-Output "Name: $($user.Name), Username: $($user.SamAccountName), Distinguished Name: $($user.DistinguishedName)"
    }
} else {
    Write-Output "No deactivated users found in Active Directory."
}
