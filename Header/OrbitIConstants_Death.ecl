import orbit,_Control;
export OrbitIConstants_Death(string envment = 'nonfcra') := module
	export datasetname := 'Death Master';
	export sourcename := 'National Technical Information Service (NTIS)';
	export orbittoken := orbit.GetToken();
	export media := 'FTP';
	export updatetype := 'Update-Append';
	export orbitreceivedate(string pdate) := pdate[1..4] + '-' + pdate[5..6] + '-' + pdate[7..8]+'T00:00:00Z'; 
	export platform := case(
															envment, 
															'nonfcra' => 'Production NonFCRA',
															'FCRA'   => 'Production FCRA',
															'test' => 'Production Customer Test',
															'NA'	
														);
	export buildname := case(
														envment,
														'nonfcra' => 'Death Master SSA',
														'FCRA'    => 'FCRA Death Master SSA',
														'test' => 'Death Master Weekly Test',
														'NA'
														);
	export masterbuildname := case(
														envment,
														'nonfcra' => 'Death Master SSA',
														'FCRA'    => 'FCRA Death Master SSA',
														'test' => 'Death Maste Weekly Test',
														'NA'
														);
	export orbitfilename := 'Death Master';
	export emaillist := 'kevin.reeder@lexisnexis.com';
	export dremaillist := if(_Control.ThisEnvironment.Name = 'Prod_Thor',
												'kevin.reeder@lexisnexis.com,datareceiving@lexisnexis.com','ALP-MediaOps@choicepoint.com');
												

end;