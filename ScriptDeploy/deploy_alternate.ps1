[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | out-null 

$server = Read-Host 'Server'
$path = pwd;
#$loginname = 'sa'
#$password = 'sa'

$SMOserver = New-Object ('Microsoft.SqlServer.Management.Smo.Server') -argumentlist $server 
$SMOserver.ConnectionContext.LoginSecure = $False

#$SMOserver.ConnectionContext.set_Login($loginname); 
#$SMOserver.ConnectionContext.set_Password($password) 
$credential = Get-Credential;
$SMOserver.ConnectionContext.set_login($credential.UserName);
$SMOserver.ConnectionContext.set_SecurePassword($credential.Password);

echo ""
foreach($database in Get-Content $path\databases.txt){
    $db = $SMOserver.databases["$database"]
    echo "Running Scripts in $database"
    foreach($s in Get-ChildItem $path\Scripts){
        $script = Get-Content $path\Scripts\$s
        $db.ExecuteNonQuery("$script")
        echo "    Executing script $s"
    }
    echo ""
}

pause
