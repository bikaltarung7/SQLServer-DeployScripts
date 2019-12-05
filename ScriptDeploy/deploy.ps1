$server = Read-Host 'Server'
$path = pwd;

$credential = Get-Credential;

echo ""
foreach($database in Get-Content $path\databases.txt){
    
    echo "Running Scripts in $database"
    foreach($script in Get-ChildItem $path\Scripts){
        echo "    Executing script $script"
        Invoke-Sqlcmd -ServerInstance $server -Username $credential.UserName -Password $credential.GetNetworkCredential().Password -Database $database -InputFile "$path\Scripts\$script"
    }
    echo ""
}

pause

