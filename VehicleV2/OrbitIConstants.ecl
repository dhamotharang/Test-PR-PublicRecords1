import orbit,_Control;
export OrbitIConstants(string envment = 'nonfcra') := module
	export datasetname := 'Motor Vehicle Registrations';
	export sourcename := 'Vehicle';
	export orbittoken := orbit.GetToken();
	export media := 'SFTP';
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
														'nonfcra' => 'Motor Vehicle Registrations',
														'test' => 'Vehicle Customer Test',
														'NA'
														);
	export masterbuildname := case(
														envment,
														'nonfcra' => 'Motor Vehicle Registrations',
														'test' => 'Vehicle Customer Test',
														'NA'
														);
	export orbitfilename := 'vehicleflag.txt';
	export emaillist := 'Anantha.Venkatachalam@lexisnexis.com';
	export dremaillist := if(_Control.ThisEnvironment.Name = 'Prod',
												'Anantha.Venkatachalam@lexisnexis.com,datareceiving@lexisnexis.com,ALP-MediaOps@choicepoint.com',
												'Anantha.Venkatachalam@lexisnexis.com');

end;