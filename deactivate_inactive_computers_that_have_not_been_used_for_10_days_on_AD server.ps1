# Import the Active Directory module
Import-Module ActiveDirectory

# Set the number of inactive days
$inactiveDays = 10

# Calculate the date for computers inactive for more than 10 days
$inactiveDate = (Get-Date).AddDays(-$inactiveDays)

# Get the list of inactive computers
$inactiveComputers = Get-ADComputer -Filter {LastLogonDate -lt $inactiveDate} -Property LastLogonDate | 
    Select-Object Name, LastLogonDate

# Initialize an array to store deactivated computers
$deactivatedComputers = @()

# Check if there are inactive computers
if ($inactiveComputers) {
    # Deactivate (Disable) each inactive computer
    foreach ($computer in $inactiveComputers) {
        Disable-ADAccount -Identity $computer.Name
        $deactivatedComputers += $computer
        Write-Output "Deactivated: $($computer.Name), Last Logon: $($computer.LastLogonDate)"
    }
    
    # Print the list of deactivated computers
    Write-Output "`nList of Deactivated Computers:"
    foreach ($comp in $deactivatedComputers) {
        Write-Output "$($comp.Name), Last Logon: $($comp.LastLogonDate)"
    }
} else {
    Write-Output "No inactive computers found for the past $inactiveDays days."
}
