import orbit,_Control;
export OrbitIConstants(string envment,string bname) := module
	export datasetname :=  map(
															envment = 'nonfcra' and bname = 'PP' => 'Phonesplus',
															envment = 'nonfcra' and bname = 'QS' => 'Qsent as Phonesplus',
															envment = 'nonfcra' and bname = 'PPV2' => 'Phonesplus V2',
																'NA'
															);
	export orbittoken := orbit.GetToken();
	export media := 'SFTP';
	export updatetype := 'Update-Append';
	export orbitreceivedate(string pdate) := pdate[1..4] + '-' + pdate[5..6] + '-' + pdate[7..8]+'T00:00:00Z'; 
	export platform := case(
															envment, 
															'nonfcra' => 'Production NonFCRA',
															'NA'	
														);
	export buildname :=  map(
															envment = 'nonfcra' and bname = 'PP' => 'Phonesplus',
															envment = 'nonfcra' and bname = 'QS' => 'Qsent as Phonesplus',
															envment = 'nonfcra' and bname = 'PPV2' => 'Phonesplus V2',
														
															'NA'
															);
	export masterbuildname := map(
															envment = 'nonfcra' and bname = 'PP' => 'Phonesplus',
															envment = 'nonfcra' and bname = 'QS' => 'Qsent as Phonesplus',
															envment = 'nonfcra' and bname = 'PPV2' => 'Phonesplus V2',
														
															'NA'
															);

		
	
	export emaillist := 'Sudhir.Kasavajjala@lexisnexisrisk.com, Jason.Allerdings@lexisnexisrisk.com';
	export dremaillist := if(_Control.ThisEnvironment.Name = 'Prod',
												'datareceiving@lexisnexis.com,ALP-MediaOps@choicepoint.com,Sudhir.Kasavajjala@lexisnexis.com',
												'Sudhir.Kasavajjala@lexisnexis.com');

end;