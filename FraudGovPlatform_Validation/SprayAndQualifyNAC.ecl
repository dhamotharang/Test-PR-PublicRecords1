IMPORT FraudGovPlatform,ut, lib_fileservices,Std;
EXPORT SprayAndQualifyNAC( string pversion ) := FUNCTION

	DateSearch := pVersion[1..8];

	sf := FraudGovPlatform.Filenames().Sprayed.NAC;
	
	FS:=fileservices;
	
	d := nothor(FS.LogicalFileList( 'nac::for_msh::fl_msh_'+DateSearch+'*.dat', TRUE, FALSE));
	fn := d[1].name;
	Customer_Settings := FraudGovPlatform.mbs_mappings(contribution_source = 'NAC');

	copy := (string)(FraudGovPlatform.Filenames().Sprayed.FileSprayed+'::'+ Customer_Settings[1].Customer_Id + '_' + Customer_Settings[1].Customer_State + '_' + Customer_Settings[1].Customer_Agency_Vertical_Type + '_' + Customer_Settings[1].Customer_Program + '_' + trim(Customer_Settings[1].Contribution_Source) + '_' + DateSearch + '_' + Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S')):independent ;
	outputwork  := sequential(
		FS.StartSuperFileTransaction(),
		nothor(FS.Copy('~'+fn,thorlib.group(),copy, allowoverwrite := true)),
		nothor(FS.AddSuperFile(sf, copy)),
		FS.FinishSuperFileTransaction());
	
	RETURN outputwork;
END;
