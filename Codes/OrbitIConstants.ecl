import orbit,_Control;
export OrbitIConstants := module
	export datasetname := 'Translation Codes';
	export sourcename := 'Translation Codes';
	export orbittoken := orbit.GetToken();
	export media := 'SFTP';
	export updatetype := 'Update-Append';
	export orbitreceivedate(string pdate) := pdate[1..4] + '-' + pdate[5..6] + '-' + pdate[7..8]+'T00:00:00Z'; 
	export platform := 'Production NonFCRA|Production Customer Test';
	export buildname := 'Translation Codes';
	export masterbuildname := 'Translation Codes';
	export orbitfilename := 'codesv3flag.txt';
	export emaillist := 'Anantha.Venkatachalam@lexisnexis.com,John.Freibaum@lexisnexis.com';
	export dremaillist := if(_Control.ThisEnvironment.Name = 'Prod',
												'Anantha.Venkatachalam@lexisnexis.com,datareceiving@lexisnexis.com,ALP-MediaOps@choicepoint.com,John.Freibaum@lexisnexis.com',
												'Anantha.Venkatachalam@lexisnexis.com');
	export platformstatus := '';
end;