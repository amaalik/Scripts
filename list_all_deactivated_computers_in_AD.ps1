# Import the Active Directory module
Import-Module ActiveDirectory

# Get the list of deactivated (disabled) computers
$disabledComputers = Get-ADComputer -Filter {Enabled -eq $false} -Property Name, LastLogonDate

# Check if there are any deactivated computers
if ($disabledComputers) {
    Write-Output "`nList of Deactivated (Disabled) Computers:`n"
    
    # Print the list of disabled computers with their last logon date
    foreach ($computer in $disabledComputers) {
        $lastLogon = $computer.LastLogonDate
        if (!$lastLogon) { $lastLogon = "Never" }  # If LastLogonDate is null, set it to "Never"
        
        Write-Output "Computer Name: $($computer.Name), Last Logon Date: $lastLogon"
    }
} else {
    Write-Output "No deactivated (disabled) computers found in Active Directory."
}
