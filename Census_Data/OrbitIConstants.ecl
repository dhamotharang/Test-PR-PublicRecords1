import orbit,_Control;
export OrbitIConstants(string pname = 'fips',string envment = 'nonfcra') := module
	export datasetname := map(pname = 'fips' => 'FIPS Counties',
	                          pname = 'zip' => 'Zip By County','NA') ;
	export sourcename := map(pname = 'fips' => 'FIPS Counties',
	                          pname = 'zip' => 'Zip By County','NA');
														
	export orbittoken := orbit.GetToken();
	export media := 'SFTP';
	export updatetype := 'Update-Append';
	export orbitreceivedate(string pdate) := pdate[1..4] + '-' + pdate[5..6] + '-' + pdate[7..8]+'T00:00:00Z'; 
	export platform := case(
															envment, 
															'nonfcra' => 'Production NonFCRA',
															
															'NA'	
														);
	export buildname := map(pname = 'fips' => 'FIPS Counties',
	                          pname = 'zip' => 'Zip By County','NA');
														
	export masterbuildname := map(pname = 'fips' => 'FIPS Counties',
	                          pname = 'zip' => 'Zip By County','NA');
														
	export emaillist := 'Sudhir.Kasavajjala@lexisnexis.com';
	export dremaillist := if(_Control.ThisEnvironment.Name = 'Prod',
												'Sudhir.Kasavajjala@lexisnexis.com,datareceiving@lexisnexis.com,ALP-MediaOps@choicepoint.com',
												'Sudhir.Kasavajjala@lexisnexis.com');

end;