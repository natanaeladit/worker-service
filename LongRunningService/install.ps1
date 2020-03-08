$serviceName = "LongRunningService"
$displayName = "Long Running Service"
$description = "Long Running Service"
$currentDir = get-location
$binaryPath = "$($currentDir)\LongRunningService.exe"
$credential = "$($env:computername)\$($env:username)"
$acl = Get-Acl $currentDir
$aclRuleArgs = $credential, "Read,Write,ReadAndExecute", "ContainerInherit,ObjectInherit", "None", "Allow"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($aclRuleArgs)
$acl.SetAccessRule($accessRule)
$acl | Set-Acl $currentDir

New-Service -Name $serviceName -BinaryPathName $binaryPath -Credential $credential -Description $description -DisplayName $displayName -StartupType Automatic