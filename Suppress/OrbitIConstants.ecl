import orbit,_Control;
export OrbitIConstants(string envment = 'nonfcra') := module
	export datasetname := 'Suppressions';
	export sourcename := 'LexisNexis/Seisint';
	export orbittoken := orbit.GetToken();
	export media := 'FTP';
	export updatetype := 'As-Required';
	export orbitreceivedate(string pdate) := pdate[1..4] + '-' + pdate[5..6] + '-' + pdate[7..8]+'T00:00:00Z'; 
	export platform := case(
															envment, 
															'nonfcra' => 'Production NonFCRA',
															'test' => 'Production Customer Test',
															
															'NA'	
														);
	export buildname := case(
														envment,
														'nonfcra' => 'Suppressions',
														'test' => 'Suppressions Customer Test',
														'NA'
														);
	export masterbuildname := case(
														envment,
														'nonfcra' => 'Suppressions',
														'test' => 'Suppression Customer Test',
														'NA'
														);
	export orbitfilename := 'PeopleWise Opt-Out Requests';
	export emaillist := 'Christopher.Brodeur@lexisnexis.com';
	export dremaillist := if(_Control.ThisEnvironment.Name = 'Prod_Thor',
												'Christopher.Brodeur@lexisnexis.com,datareceiving@lexisnexis.com','ALP-MediaOps@choicepoint.com');
												

end;