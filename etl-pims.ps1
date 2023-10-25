$ServerSQL = $env:ServerSQL    
$inAFServer = $env:inAFServer           
$inAFDatabase = $env:inAFDatabase                         
$inAFTemplate = $env:inAFTemplate                      
$inAFElement = $env:inAFElemente                       
$User = $env:User
$Pword = ConvertTo-SecureString -String "$env:Pword" -AsPlainText -Force                                       # Password
$Credential= New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord         # Credenciais para a Maquina do PIMS
$DadosPims = $null 

Connect-PIDataArchive -PIDataArchiveMachineName $inAFServer 
Connect-AFServer -WindowsCredential (Get-Credential -Credential $Credential ) -AFServer (Get-AFServer -Name $inAFServer) 
$afDB = Get-AFDatabase $inAFDatabase -AFServer (Get-AFServer -Name $inAFServer) 
$afTemplate = Get-AFElementTemplate -AFDatabase $afDB -Name $inAFTemplate 

function Get-AFElements() {
    if($ele.Template.Name -eq $inAfTemplate) {
        foreach($attri in $afTemplate.attributeTemplates)
        {
            $AttriName = $attri.Name
            $ele.Attributes[$AttriName].GetValue()
        }
    }
}

foreach($ele in $afTemplate.Elements) {
    $ele.Name
    $PimsData += Get-AFElements $ele
}