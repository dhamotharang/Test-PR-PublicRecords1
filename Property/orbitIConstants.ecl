import orbit,_Control;
export OrbitIConstants(string envment = 'nonfcra') := module
	export datasetname := 'Foreclosures';
	// export sourcename := 'LSSiData Corp';
	export orbittoken := orbit.GetToken();
	export media := 'FTP';
	export updatetype := 'Update-Append';
	export orbitreceivedate(string pdate) := pdate[1..4] + '-' + pdate[5..6] + '-' + pdate[7..8]+'T00:00:00Z'; 
	export platform := case(
															envment, 
															'nonfcra' => 'Production NonFCRA',
															'NA');
	export buildname := case(
														envment,
														'nonfcra' => 'Foreclosures',
														'NA');
	export masterbuildname := case(
														envment,
														'nonfcra' => 'Foreclosures',
														'NA');
	export orbitfilename := 'Foreclosures';
	export emaillist := 'Gavin.Witz@lexisnexis.com';
									

end;