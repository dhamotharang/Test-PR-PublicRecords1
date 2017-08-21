import orbit,_Control;
export OrbitIConstants(string envment = 'nonfcra') := module
	export datasetname := 'Directory Assistance Daily';
	export sourcename := 'LSSiData Corp';
	export orbittoken := orbit.GetToken();
	export media := 'FTP';
	export updatetype := 'Update-Append';
	export orbitreceivedate(string pdate) := pdate[1..4] + '-' + pdate[5..6] + '-' + pdate[7..8]+'T00:00:00Z'; 
	export platform := case(
															envment, 
															'nonfcra' => 'Production NonFCRA',
															'test' => 'Production Customer Test',
															
															'NA'	
														);
	export buildname := case(
														envment,
														'nonfcra' => 'Directory Assistance Daily',
														'test' => 'Directory Assistance Daily Customer Test',
														'NA'
														);
	export masterbuildname := case(
														envment,
														'nonfcra' => 'Directory Assistance Daily',
														'test' => 'Directory Assistance Daily Customer Test',
														'NA'
														);
	export orbitfilename := 'National Directory Assistance';
	export emaillist := 'Christopher.Brodeur@lexisnexis.com';
	export dremaillist := if(_Control.ThisEnvironment.Name = 'Prod_Thor',
												'Christopher.Brodeur@lexisnexis.com,datareceiving@lexisnexis.com','ALP-MediaOps@choicepoint.com');
												

end;