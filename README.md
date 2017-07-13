# powershell-vix
Powershell cmdlets to run scripts in vmware virtual machines via VIX/vmtools

Execution example:

$file = download-gitfile -gituser "domain\username" -gitpassword "" -url "https://raw.githubusercontent.com/good-paste/powershell-vix/master/test-method.ps1"

execute-vixscript.ps1 -sdk "vcenter.domain.lan" -viusername "domain\username" -vipassword "" -vmname "test-vm" -guestuser "administrator" -guestpassword "" -file $file -args '-myparam "asdf" -myparam2 "asdf2" -myparam3 "asdf3"'
