IMPORT _Control,tools,STD,NAC,FraudGovPlatform;

EXPORT SprayAndQualifyNAC( string pversion ) := FUNCTION	

	cs := dedup(table(FraudGovPlatform.Files().CustomerSettings,{MSH_Prefix}),all);

	msh_files := nothor(STD.File.LogicalFileList( 'nac::for_msh::*', TRUE, FALSE));


	vDate := (string8)((unsigned)pversion[1..8]);

	f := join(
		cs,
		msh_files,
		left.msh_prefix[1..21]+vDate = right.name[1..29] );
	
	copyMSH := STD.File.Copy('~'+f[1].name,'thor400_44','~fraudgov::in::'+f[1].name , allowoverwrite := true);

	supername := FraudGovPlatform.Filenames().Sprayed.NAC;
	subname := 'fraudgov::in::'+f[1].name;

	outputwork := sequential(
		copyMSH,
		STD.File.AddSuperFile(supername, '~' + subname),
	);

	RETURN outputwork;
END;