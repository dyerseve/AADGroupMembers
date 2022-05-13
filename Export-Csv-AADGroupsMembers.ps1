Connect-AzureAD
$groups=Get-AzureADGroup -All $true
$resultsarray =@()
ForEach ($group in $groups){
    $members = Get-AzureADGroupMember -ObjectId $group.ObjectId -All $true
    ForEach ($member in $members){
        If ($group.ProxyAddresses -like "SPO*") {
            $UserObject | add-member  -membertype NoteProperty -name "Type" -Value "Microsoft 365 Group (Teams)"
        }
        elseif ($grouptest.MailEnabled -eq $False) {
            $UserObject | add-member  -membertype NoteProperty -name "Type" -Value "Security Group"
        }
        else {
            $UserObject | add-member  -membertype NoteProperty -name "Type" -Value "Distribution Group"
        }
        $UserObject = new-object PSObject
        $UserObject | add-member  -membertype NoteProperty -name "Group Name" -Value $group.DisplayName
        $UserObject | add-member  -membertype NoteProperty -name "Group Email" -Value $group.Mail
        $UserObject | add-member  -membertype NoteProperty -name "Member Name" -Value $member.DisplayName
        $UserObject | add-member  -membertype NoteProperty -name "ObjType" -Value $member.ObjectType
        $UserObject | add-member  -membertype NoteProperty -name "UserType" -Value $member.UserType
        $UserObject | add-member  -membertype NoteProperty -name "UserPrinicpalName" -Value $member.UserPrincipalName
        $resultsarray += $UserObject
    }
}
$resultsarray | Export-Csv .\groupmember.csv