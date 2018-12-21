import tools, STD, FraudShared;

export Rollback(
	string	pversion	= 	''
)  :=
module

	Shared PreviousVersion := if(pversion	= 	'', FraudGovInfo().PreviousVersion,pversion);
	
	Export clear_input_files := sequential(
		//Clear Input Files
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Input.IdentityData.Sprayed, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Input.KnownFraud.Sprayed, false), 
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Input.Deltabase.Sprayed, false), 
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Input.bypassed_identitydata.Sprayed, false),		
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Input.bypassed_knownfraud.Sprayed, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Input.bypassed_deltabase.Sprayed, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Input.addresscache_iddt.Sprayed, false),         
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Input.addresscache_knfd.Sprayed, false),
		//Clear Sprayed Files
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Sprayed._DeltabasePassed, true),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Sprayed._DeltabaseRejected, true),
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
		// Clear Fathers
		//STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Base.Main.Father, false),  // this file is not modified by the base_portion 
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.Main_Orig.Father, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.Main_Anon.Father, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.addresscache.Father, false),  
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.IdentityData.Father, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.KnownFraud.Father, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.Deltabase.Father, false),
		// Clear QAs
		//STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Base.Main.QA, false),  // this file is not modified by the base_portion 
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.Main_Orig.QA, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.Main_Anon.QA, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.addresscache.QA, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.IdentityData.QA, false),	
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.KnownFraud.QA, false), 
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.Deltabase.QA, false),
		// Clear Builts
		STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Base.Main.Built, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.Main_Orig.Built, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.Main_Anon.Built, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.addresscache.Built, false), 
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.IdentityData.Built, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.KnownFraud.Built, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.Deltabase.Built, false)
	);

	//Rollback Base Files to previous version known
	Export rollback_base_files := sequential(
		// Rollback QA Files
		//STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Base.Main.QA		,FraudShared.Filenames(PreviousVersion).Base.Main.New),	// this file is not modified by the base_portion 
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.Main_Orig.QA		, Filenames(PreviousVersion).Base.Main_Orig.New),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.Main_Anon.QA		, Filenames(PreviousVersion).Base.Main_Anon.New),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.addresscache.QA		,Filenames(PreviousVersion).Base.addresscache.New),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.IdentityData.QA		,Filenames(PreviousVersion).Base.IdentityData.New),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.KnownFraud.QA		,Filenames(PreviousVersion).Base.KnownFraud.New),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.Deltabase.QA		,Filenames(PreviousVersion).Base.Deltabase.New),	
		// Rollback Built Files
		STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Base.Main.Built		,FraudShared.Filenames(PreviousVersion).Base.Main.New),
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.Main_Orig.Built		, Filenames(PreviousVersion).Base.Main_Orig.New),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.Main_Anon.Built		, Filenames(PreviousVersion).Base.Main_Anon.New),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.addresscache.Built		,Filenames(PreviousVersion).Base.addresscache.New),
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.IdentityData.Built		,Filenames(PreviousVersion).Base.IdentityData.New),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.KnownFraud.Built	,Filenames(PreviousVersion).Base.KnownFraud.New),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.Deltabase.Built	,Filenames(PreviousVersion).Base.Deltabase.New),
	);
	
	Export rollback_input_files := sequential(
		//Rollback Sprayed Inputs to previous version
		STD.File.AddSuperFile(Filenames(PreviousVersion).Input.IdentityData.Sprayed	,Filenames(PreviousVersion).Input.IdentityData.New(PreviousVersion)),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Input.KnownFraud.Sprayed		,Filenames(PreviousVersion).Input.KnownFraud.New(PreviousVersion)),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Input.Deltabase.Sprayed		,Filenames(PreviousVersion).Input.Deltabase.New(PreviousVersion)),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Input.bypassed_identitydata.Sprayed		,Filenames(PreviousVersion).Input.bypassed_identitydata.New(PreviousVersion)),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Input.bypassed_knownfraud.Sprayed		,Filenames(PreviousVersion).Input.bypassed_knownfraud.New(PreviousVersion)),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Input.bypassed_deltabase.Sprayed		,Filenames(PreviousVersion).Input.bypassed_deltabase.New(PreviousVersion)),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Input.AddressCache_IDDT.Sprayed		,Filenames(PreviousVersion).Input.AddressCache_IDDT.New(PreviousVersion)),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Input.AddressCache_KNFD.Sprayed		,Filenames(PreviousVersion).Input.AddressCache_KNFD.New(PreviousVersion)),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Input.AddressCache_Deltabase.Sprayed		,Filenames(PreviousVersion).Input.AddressCache_Deltabase.New(PreviousVersion)),	
		//Rollback MBS Files to previous version
		STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBS.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MBS.New(PreviousVersion)),
		STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MbsNewGcIdExclusion.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MbsNewGcIdExclusion.New(PreviousVersion)),      
		STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MbsIndTypeExclusion.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MbsIndTypeExclusion.New(PreviousVersion)),		
		STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MbsProductInclude.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MbsProductInclude.New(PreviousVersion)), 
		STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSSourceGcExclusion.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MBSSourceGcExclusion.New(PreviousVersion)),         
		STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSFdnIndType.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MBSFdnIndType.New(PreviousVersion)),
		STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSFdnCCID.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MBSFdnCCID.New(PreviousVersion)),
		STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSFdnHHID.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MBSFdnHHID.New(PreviousVersion)),		
		STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSTableCol.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MBSTableCol.New(PreviousVersion)),		
		STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSColValDesc.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MBSColValDesc.New(PreviousVersion)),		
		STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MBSmarketAppend.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MBSmarketAppend.New(PreviousVersion)),
		STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MbsFdnMasterIDIndTypeInclusion.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MbsFdnMasterIDIndTypeInclusion.New(PreviousVersion)),	
		STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Input.MbsVelocityRules.Sprayed, FraudShared.Filenames(PreviousVersion).Input.MbsVelocityRules.New(PreviousVersion)),	
	);

	
	Export All_Files := sequential(
		STD.File.StartSuperFileTransaction(),
		clear_base_files,
		rollback_base_files,
		clear_input_files,		
		rollback_input_files,
		STD.File.FinishSuperFileTransaction()
	);
	
	Export All := 	sequential( All_Files , 	Send_Emails(pversion).BuildFailure );
end;

