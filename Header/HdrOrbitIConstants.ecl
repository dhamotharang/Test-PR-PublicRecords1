import orbit,_Control;
export HdrOrbitIConstants(string envment = 'nonfcra') := module
	export datasetname := 'HeaderNonUpdating';
	export sourcename := 'HeaderNonUpdating';
	export orbittoken := orbit.GetToken();
	export media := 'SFTP';
	export updatetype := 'Update-Append';
	export orbitreceivedate(string pdate) := pdate[1..4] + '-' + pdate[5..6] + '-' + pdate[7..8]+'T00:00:00Z'; 
	export platform := case(
															envment, 
															'nonfcra' => 'Production NonFCRA',
															
															'NA'	
														);
	export buildname := case(
														envment,
														'nonfcra' => 'HeaderNonUpdating',
														'NA'
														);
	export masterbuildname := case(
														envment,
														'nonfcra' => 'HeaderNonUpdating',
														'NA'
														);
	export emaillist := 'Sudhir.Kasavajjala@lexisnexis.com';
	export dremaillist := if(_Control.ThisEnvironment.Name = 'Prod',
												'Sudhir.Kasavajjala@lexisnexis.com,datareceiving@lexisnexis.com,ALP-MediaOps@choicepoint.com',
												'Sudhir.Kasavajjala@lexisnexis.com');

end;