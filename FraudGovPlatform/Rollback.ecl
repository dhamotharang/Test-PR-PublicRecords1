import STD, FraudShared, FraudGovPlatform_Validation;

export Rollback(
	string	pversion	= 	'',
	string 	Test_Build,
	string	Test_RecordID,
	string	Test_RinID
)  :=
module

	Shared PreviousVersion := if(pversion	= 	'', FraudGovInfo().PreviousVersion,pversion);

	Export clear_input_files := sequential(
		// Clear MBS Files
		STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBS.Sprayed, false),
		STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Input.MbsNewGcIdExclusion.Sprayed, false),      
		STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Input.MbsIndTypeExclusion.Sprayed, false),		
		STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Input.MbsProductInclude.Sprayed, false), 
		STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSSourceGcExclusion.Sprayed, false),         
		STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSFdnIndType.Sprayed, false),
		STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSFdnCCID.Sprayed, false),
		STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSFdnHHID.Sprayed, false),		
		STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSTableCol.Sprayed, false),		
		STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSColValDesc.Sprayed, false),		
		STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSmarketAppend.Sprayed, false),
		STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Input.MbsFdnMasterIDIndTypeInclusion.Sprayed, false),	
		STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Input.MbsVelocityRules.Sprayed, false),	

	);	

	Export clear_base_files := sequential(
		// Clear Builts
		STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Base.Main.Built, false)
	);

	//Rollback Base Files to previous version known
	Export rollback_base_files := sequential(
		// Rollback Built Files
		if(FraudGovPlatform._Flags.UseDemoData, 
				STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Base.Main.Built,	FraudGovPlatform.Filenames(PreviousVersion).Input.DemoData.Sprayed)),		
		STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Base.Main.Built		,FraudShared.Filenames(PreviousVersion).Base.Main.New),
	);

	Export rollback_input_files := sequential(
		//Rollback MBS Files to previous version
		if (STD.File.FileExists(FraudShared.Filenames(PreviousVersion).Input.MBS.New(PreviousVersion)),STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBS.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MBS.New(PreviousVersion))),
		if (STD.File.FileExists(FraudShared.Filenames(PreviousVersion).Input.MbsNewGcIdExclusion.New(PreviousVersion)),STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MbsNewGcIdExclusion.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MbsNewGcIdExclusion.New(PreviousVersion))),
		if (STD.File.FileExists(FraudShared.Filenames(PreviousVersion).Input.MbsIndTypeExclusion.New(PreviousVersion)),STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MbsIndTypeExclusion.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MbsIndTypeExclusion.New(PreviousVersion))),
		if (STD.File.FileExists(FraudShared.Filenames(PreviousVersion).Input.MbsProductInclude.New(PreviousVersion)),STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MbsProductInclude.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MbsProductInclude.New(PreviousVersion))), 
		if (STD.File.FileExists(FraudShared.Filenames(PreviousVersion).Input.MBSSourceGcExclusion.New(PreviousVersion)),STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSSourceGcExclusion.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MBSSourceGcExclusion.New(PreviousVersion))),
		if (STD.File.FileExists(FraudShared.Filenames(PreviousVersion).Input.MBSFdnIndType.New(PreviousVersion)),STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSFdnIndType.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MBSFdnIndType.New(PreviousVersion))),
		if (STD.File.FileExists(FraudShared.Filenames(PreviousVersion).Input.MBSFdnCCID.New(PreviousVersion)),STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSFdnCCID.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MBSFdnCCID.New(PreviousVersion))),
		if (STD.File.FileExists(FraudShared.Filenames(PreviousVersion).Input.MBSFdnHHID.New(PreviousVersion)),STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSFdnHHID.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MBSFdnHHID.New(PreviousVersion))),		
		if (STD.File.FileExists(FraudShared.Filenames(PreviousVersion).Input.MBSTableCol.New(PreviousVersion)),STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSTableCol.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MBSTableCol.New(PreviousVersion))),
		if (STD.File.FileExists(FraudShared.Filenames(PreviousVersion).Input.MBSColValDesc.New(PreviousVersion)),STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSColValDesc.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MBSColValDesc.New(PreviousVersion))),
		if (STD.File.FileExists(FraudShared.Filenames(PreviousVersion).Input.MBSmarketAppend.New(PreviousVersion)),STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSmarketAppend.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MBSmarketAppend.New(PreviousVersion))),
		if (STD.File.FileExists(FraudShared.Filenames(PreviousVersion).Input.MbsFdnMasterIDIndTypeInclusion.New(PreviousVersion)),STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MbsFdnMasterIDIndTypeInclusion.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MbsFdnMasterIDIndTypeInclusion.New(PreviousVersion))),
		if (STD.File.FileExists(FraudShared.Filenames(PreviousVersion).Input.MbsVelocityRules.New(PreviousVersion)),STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MbsVelocityRules.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MbsVelocityRules.New(PreviousVersion))),
	);	

	
	Export All_Files := sequential(
		STD.File.StartSuperFileTransaction(),
		clear_base_files,
		rollback_base_files,
		clear_input_files,
		rollback_input_files,
		STD.File.FinishSuperFileTransaction()
	);
	
	Export All := 	
		sequential( 
			//All_Files , 	
			FraudGovPlatform_Validation.Send_Email
			(	pversion, 
				build_status := Test_Build, 
				rid_status := Test_RecordID, 
				rinid_status := Test_RinID	).build_rollback	);
end;

