import orbit,_Control;
export OrbitIConstants(string version,string envment = 'nonfcra') := module
	export datasetname := if( version <> 'V2','Global Watch Lists','Global Watch ListsV2');
	export sourcename := if( version <> 'V2','Global Watch Lists','Global Watch ListsV2');
	export orbittoken := orbit.GetToken();
	export media := 'SFTP';
	export updatetype := 'Update-Append';
	export orbitreceivedate(string pdate) := pdate[1..4] + '-' + pdate[5..6] + '-' + pdate[7..8]+'T00:00:00Z'; 
	export platform := case(
															envment, 
															'nonfcra' => 'Production NonFCRA',
															
															'NA'	
														);
	export buildname := map( version <> 'V2' and envment = 'nonfcra' => 'Global Watch Lists',
							 version = 'V2' and envment = 'nonfcra' => 'Global Watch ListsV2',						
														'NA'
														);
	export masterbuildname := map( version <> 'V2' and envment = 'nonfcra' => 'Global Watch Lists',
							 version = 'V2' and envment = 'nonfcra' => 'Global Watch ListsV2',						
														'NA'
														);
	export orbitfilename := 'gwlflag.txt';
	export emaillist := 'Sudhir.Kasavajjala@lexisnexis.com';
	export dremaillist := if(_Control.ThisEnvironment.Name = 'Prod',
												'Sudhir.Kasavajjala@lexisnexis.com,datareceiving@lexisnexis.com,ALP-MediaOps@choicepoint.com',
												'Sudhir.Kasavajjala@lexisnexis.com');

end;