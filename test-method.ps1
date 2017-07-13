function test-method {
	param
	(
		$myparam,
		$myparam2,
		$myparam3
	)
	write-host "Test function"
	
	if(!$myparam){
	}else{
		write-host "My parameter" $myparam
	}
	if(!$myparam2){
	}else{
		write-host "My parameter2" $myparam2
	}
	if(!$myparam3){
	}else{
		write-host "My parameter3" $myparam3
	}
}
