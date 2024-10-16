# Import the Active Directory module
Import-Module ActiveDirectory

# Set the number of inactive days
$inactiveDays = 10

# Calculate the date for computers inactive for more than 10 days
$inactiveDate = (Get-Date).AddDays(-$inactiveDays)

# Get the list of inactive computers
$inactiveComputers = Get-ADComputer -Filter {LastLogonDate -lt $inactiveDate} -Property LastLogonDate | 
    Select-Object Name, LastLogonDate

# Display the list of inactive computers
if ($inactiveComputers) {
    $inactiveComputers | ForEach-Object {
        Write-Output "Computer Name: $($_.Name), Last Logon: $($_.LastLogonDate)"
    }
} else {
    Write-Output "No inactive computers found for the past $inactiveDays days."
}
