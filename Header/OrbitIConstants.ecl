import orbit,_Control;
export OrbitIConstants(string envment = 'nonfcra') := module
	export datasetname := 'Header';
	export sourcename := '';
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
														'nonfcra' => 'Header',
														'test' => 'Header Customer Test',
														'NA'
														);
	export masterbuildname := case(
														envment,
														'nonfcra' => 'Header',
														'test' => 'Header Customer Test',
														'NA'
														);
	export orbitfilename := '';
	export emaillist := 'Jose.bello@lexisnexis.com';
	export dremaillist := if(_Control.ThisEnvironment.Name = 'Prod_Thor',
												'Jose.bello@lexisnexis.com,datareceiving@lexisnexis.com','ALP-MediaOps@choicepoint.com');
												

end;