function download-gitfile {
	param
		(
			$gituser,
			$gitpassword,
			$url
		)

		$username = $gituser
		$password = $gitpassword
		$path = $env:temp + "\" + $url.split('/')[$url.split('/').length-1] + ".tmp"
		$path2 = $path.substring(0,$path.Length-4)
		$webclient = New-Object System.Net.webclient
		$webclient.Credentials = New-Object System.Net.Networkcredential($gituser,$gitpassword)
		$webclient.DownloadFile( $url, $path )
		Get-Content $path | Set-Content -Path $path2

		return $path2
}


function execute-vixscript {
param
	(
		[Parameter(Mandatory=$true)]$sdk,
		$viusername,
		$vipassword,
		$vmname,
		$guestuser,
		$guestpassword,
		$file,
		$args
	)
	
	$copyname = $file.split('\')[$file.split('\').length-1]
	$copyfolder = "C:\provisioning\"
	$executionfile = $copyfolder + $copyname
	$logfile = ".\execute-vxscript-" + $(Get-Date -format "MM-dd-yyyy_hh_ss") + ".log"
	if ( !(Get-Module -Name VMware.VimAutomation.Core -ErrorAction SilentlyContinue) ) {. "C:\Program Files (x86)\VMware\Infrastructure\vSphere PowerCLI\Scripts\Initialize-PowerCLIEnvironment.ps1"}
	Import-Module VMware.VimAutomation.Core
	$viconnection = Connect-viserver -Server $sdk -User $viusername -Password $vipassword
$buildfolder = @"
If(!(test-path '$copyfolder'))
{New-Item -ItemType Directory -Force -Path '$copyfolder'}
"@
if(!$args){
write-host "args not present"
$runmethodinguest = @"
. $executionfile
test-method
"@
}else{
write-host "args present"
$runmethodinguest = @"
. $executionfile
test-method $args
"@
}
	$vm = get-vm $vmname
	Invoke-VMScript -VM $vmname -ScriptText $buildfolder -GuestUser $guestuser -GuestPassword $guestpassword
	Copy-VMGuestFile -Source $file -Destination $copyfolder -VM $vm -LocalToGuest -GuestUser $guestuser -GuestPassword $guestpassword -force
	$result = Invoke-VMScript -ScriptText $runmethodinguest -VM $vmname -GuestUser $guestuser -GuestPassword $guestpassword -scripttype "powershell"
	$retcode = $result.ExitCode
	if ($retcode = "0") {
		write-host $vmname returned exit code $retcode -ForegroundColor Green
	}
	Else {
		write-host $vmname returned exit code $retcode -ForegroundColor Red
	}

	return $result
}
