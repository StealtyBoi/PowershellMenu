Function MENU{
    "___________________________________"
    "Welcome! Please select an Option..."
    "1.) Ping a Network with a /24 CIDR "
    "2.) See Current User"
    "3.) Retreive List of Users"
    "4.) Retreive Group Information"
    "5.) List Admin Group Users"
    "6.) Get System Info"
    "7.) See Running Services"
    "8.) See Running Processes"
    "9.) Scheduled Tasks"
    "10) Check Network Adapter Connection"
    "11) Print ARP Cache"
    "12) Print Routing Table"
    "13) Show TCP Connections"
    "14) Check DNS Entries"
    "15) Check Local Network Shares"
    "16) Get Other Network Shares"
    "0.) Exit                           "
    "___________________________________"
    $choice=Read-Host
    switch ($choice) { 
        1 {PING} 
        2 {CurrentUser} 
        3 {GetUserList} 
        4 {GetGroupList} 
        5 {ListAdminGroup}
        6 {SysInfo}
    default {ErrorMessage}
}
}
Function ErrorMessage {
    "Sorry, you entered an invalid option."
    sleep 1
    MENU

}
Function PING{
    "Enter the first three Octets of the network you would like to ping"
    $3octets=Read-Host
    $array=$3octets.split(".")
    try{
        if (([int]$array[0] -gt 0 ) -and ([int]$array[1] -gt 0) -and ([int]$array[2] -gt 0)) {
            1..254 | ForEach-Object {$status=Test-Connection "$3octets.$_" -count 1 -quiet; "$3octets.$_ $status"}
        }
        else {
            "Please only enter integers for your octets."
            sleep 1
            PING
        }
    }
    catch { 
        "Please only enter integers for your octets."
        sleep 1
        PING
    }
}
Function CurrentUser{
    Write-Host "Current User: " -ForegroundColor Cyan;
    $user= [System.Security.Principal.WindowsIdentity]::GetCurrent().Name;
    Write-Host $user;
}
Function GetUserList{
    Write-Host "User Information: " -ForegroundColor Cyan
    Get-LocalUser | ft -AutoSize
}
Function GetGroupList{
    Write-Host "Group Information: " -ForegroundColor Cyan
    Get-LocalGroup | ft -AutoSize
}
Function ListAdminGroup{
    Write-Host "List of users in Administrators: " -ForegroundColor Cyan
    Get-LocalGroupMember -Group Administrators | ft -Autosize
}
Function SysInfo{
    Write-Host "System Information: " -ForegroundColor Cyan;
    Get-ComputerInfo | fl;
    #TODO: Limit output to useful fields such as architecture, OS etc.
}
MENU