# powershell-vix
Powershell cmdlets to run scripts in vmware virtual machines via VIX/vmtools

Execution example:

$file = download-gitfile -gituser "domain\username" -gitpassword "" -url "https://raw.githubusercontent.com/good-paste/powershell-vix/master/test-method.ps1"

execute-vixscript.ps1 -sdk "vcenter.domain.lan" -viusername "domain\username" -vipassword "" -vmname "test-vm" -guestuser "Administrator" -guestpassword "" -file $file -args '-myparam "asdf" -myparam2 "ljkadfjklsdfjkl" -myparam3 "uevfnuienrvieurvnie"'
