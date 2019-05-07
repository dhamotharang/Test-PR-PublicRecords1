IMPORT FraudGovPlatform,ut, lib_fileservices;
EXPORT SprayAndQualifyNAC( string pversion ) := FUNCTION

	// DateSearch := ut.date_math(pVersion[1..8], -1);
	DateSearch := pVersion[1..8];

	sf := FraudGovPlatform.Filenames().Sprayed.NAC;
	
	FS:=fileservices;
	
	d := nothor(FS.LogicalFileList( 'nac::for_msh::fl_msh_'+DateSearch+'*.dat', TRUE, FALSE));
	fn := d[1].name;
	copy := '~fraudgov::in::'+REGEXREPLACE('nac::for_msh::', fn, '');
	
	outputwork  := sequential(
		FS.StartSuperFileTransaction(),
		nothor(FS.Copy('~'+fn,'thor400_44',copy, allowoverwrite := true)),
		nothor(FS.AddSuperFile(sf, copy)),
		FS.FinishSuperFileTransaction());
	
	RETURN outputwork;
END;
