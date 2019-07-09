IMPORT FraudGovPlatform,ut, lib_fileservices;
EXPORT SprayAndQualifyNAC( string pversion ) := FUNCTION

	// DateSearch := ut.date_math(pVersion[1..8], -1);
	DateSearch := pVersion[1..8];

	sf := FraudGovPlatform.Filenames().Sprayed.NAC;
	
	FS:=fileservices;
	
	d := nothor(FS.LogicalFileList( 'nac::for_msh::fl_msh_'+DateSearch+'*.dat', TRUE, FALSE));
	fn := d[1].name;
<<<<<<< HEAD
	copy := '~fraudgov::in::'+REGEXREPLACE('nac::for_msh::', fn, '');
	
=======
	Customer_Settings := FraudGovPlatform.mbs_mappings(contribution_source = 'NAC');

	copy := (string)(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ Customer_Settings[1].Customer_Account_Number + '_' + Customer_Settings[1].Customer_State + '_' + Customer_Settings[1].Customer_Agency_Vertical_Type + '_' + Customer_Settings[1].Customer_Program + '_' + trim(Customer_Settings[1].Contribution_Source) + '_' + DateSearch + '_' + Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S')):independent ;
>>>>>>> ThorProd
	outputwork  := sequential(
		FS.StartSuperFileTransaction(),
		nothor(FS.Copy('~'+fn,'thor400_44',copy, allowoverwrite := true)),
		nothor(FS.AddSuperFile(sf, copy)),
		FS.FinishSuperFileTransaction());
	
	RETURN outputwork;
END;
