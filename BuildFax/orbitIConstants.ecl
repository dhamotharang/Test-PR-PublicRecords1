import orbit,_Control;
export OrbitIConstants(string filetype,string obuild = 'NA') := module
	CustomerTestVal     := 'N':STORED('CustomerTestEnv');
	SHARED isCust				:= CustomerTestVal = 'Y';
	export datasetname := case (
															filetype,
															Constants().inspection => 'inspection',
															Constants().correction => 'correction',
															Constants().contractor => 'contractor',
															'NA'
															);
	export sourcename := 'Insurance Transaction History';
	export orbittoken := orbit.GetToken();
	export media := 'SFTP';
	export updatetype := 'Update-Append';
	export orbitreceivedate(string pdate) := pdate[1..4] + '-' + pdate[5..6] + '-' + pdate[7..8]+'T00:00:00Z'; 
	export platform := case(
														obuild,
														'BUILDFAX' => 'Production FCRA',
														'NA'
														);	
	export buildname :=  case(
														obuild,
														'BUILDFAX' => 'NonFCRA BUILDFAX',
														'NA'
														);
	export masterbuildname := case(
														obuild,
														'BUILDFAX' => 'NonFCRA BUILDFAX',
														'NA'
														);
	export orbitfilename := filetype;
															
	export orbitpathname(string pdate) := 
	       IF(isCust,'\\\\prodlz01\\data\\orbitcust\\',orbit.EnvironmentVariables.orbitpathprefix) + 
				    trim(Constants(filetype).dirname,left,right) + '\\process\\' + pdate + '\\';
	export componentfilename(string pdate) := orbit.EnvironmentVariables.orbitcomponentpathprefix + trim(Constants(filetype).dirname,left,right) + '\\\\process\\\\' + pdate + '\\\\' + stringlib.stringtolowercase(orbitfilename);
	export emaillist := 'Anantha.Venkatachalam@lexisnexis.com, Sanjay.Kumar@lexisnexis.com';
	export dremaillist := if(_Control.ThisEnvironment.Name = 'Prod',
												'Anantha.Venkatachalam@lexisnexis.com,datareceiving@lexisnexis.com,ALP-MediaOps@choicepoint.com, Sanjay.Kumar@lexisnexis.com, Steven.Stockton@lexisnexis.com',
												'Sanjay.Kumar@lexisnexis.com, Steven.Stockton@lexisnexis.com');
	export idopsdataset := case(
														obuild,
														'NonFCRA BUILDFAX' => 'NonFCRA_BUILDFAXKeys',
														'NA'
														);

end;