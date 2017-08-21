import orbit,_Control;
export OrbitIConstants(string envment) := module
	export datasetname := 'eCrashCRUAcidentsDelta';
	export orbittoken := orbit.GetToken();
	export media := 'SFTP';
	export updatetype := 'Update-Append';
	export orbitreceivedate(string pdate) := pdate[1..4] + '-' + pdate[5..6] + '-' + pdate[7..8]+'T00:00:00Z'; 
	export platform := case(
															envment, 
															'nfcra' => 'Production NonFCRA',
															'test' => 'Production Customer Test',
															'NA'	
														);
	export buildname :=  case(
															envment, 
															'nfcra' => 'eCrashCRUAcidentsDelta',
															'test' => 'eCrashCRUAcidentsDelta Customer Test',
															'NA'
															);
	export masterbuildname := case(
															envment, 
															'nfcra' => 'eCrashCRUAcidentsDelta',
															'test' => 'eCrashCRUAcidentsDelta Customer Test',
															'NA'
															);

		
	
	export emaillist := 'Sudhir.Kasavajjala@lexisnexis.com';
	export dremaillist := if(_Control.ThisEnvironment.Name = 'Prod',
												'datareceiving@lexisnexis.com,ALP-MediaOps@choicepoint.com,Sudhir.Kasavajjala@lexisnexis.com',
												'Sudhir.Kasavajjala@lexisnexis.com');

end;