import tools, STD, FraudShared;

export Rollback(
	string	pversion	= 	''
)  :=
module

	Shared PreviousVersion := if(pversion	= 	'', FraudGovInfo().PreviousVersion,pversion);
	
	Export clear_input_files := sequential(
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Input.IdentityData.Sprayed, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Input.KnownFraud.Sprayed, false),      
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Input.bypassed_identitydata.Sprayed, false),		
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Input.bypassed_knownfraud.Sprayed, false), 
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Input.addresscache_iddt.Sprayed, false),         
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Input.addresscache_knfd.Sprayed, false),
	);
	
	Export clear_base_files := sequential(
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.IdentityData.Built, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.KnownFraud.Built, false),
		STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Base.Main.Built, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.addresscache.Built, false), 
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.IdentityData.QA, false),	
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.KnownFraud.QA, false),      
		STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Base.Main.QA, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.addresscache.QA, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.IdentityData.Father, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.KnownFraud.Father, false),
		STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Base.Main.Father, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.addresscache.Father, false),  
	);

	Export rollback_input_files := sequential(
		STD.File.AddSuperFile(Filenames(PreviousVersion).Input.IdentityData.Sprayed	,Filenames(PreviousVersion).Input.IdentityData.New(PreviousVersion)),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Input.KnownFraud.Sprayed		,Filenames(PreviousVersion).Input.KnownFraud.New(PreviousVersion)),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Input.bypassed_identitydata.Sprayed		,Filenames(PreviousVersion).Input.bypassed_identitydata.New(PreviousVersion)),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Input.bypassed_knownfraud.Sprayed		,Filenames(PreviousVersion).Input.bypassed_knownfraud.New(PreviousVersion)),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Input.addresscache_iddt.Sprayed		,Filenames(PreviousVersion).Input.addresscache_iddt.New(PreviousVersion)),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Input.addresscache_knfd.Sprayed		,Filenames(PreviousVersion).Input.addresscache_knfd.New(PreviousVersion)),	
	);
	
	Export rollback_base_files := sequential(
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.IdentityData.Built		,Filenames(PreviousVersion).Base.IdentityData.New),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.KnownFraud.Built		,Filenames(PreviousVersion).Base.KnownFraud.New),	
		STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Base.Main.Built		,FraudShared.Filenames(PreviousVersion).Base.Main.New),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.addresscache.Built		,Filenames(PreviousVersion).Base.addresscache.New),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.IdentityData.QA		,Filenames(PreviousVersion).Base.IdentityData.New),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.KnownFraud.QA		,Filenames(PreviousVersion).Base.KnownFraud.New),	
		STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Base.Main.QA		,FraudShared.Filenames(PreviousVersion).Base.Main.New),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.addresscache.QA		,Filenames(PreviousVersion).Base.addresscache.New),	
	);
	
	Export inputFiles := sequential(
		STD.File.StartSuperFileTransaction(),
		clear_input_files,
		rollback_input_files,
		STD.File.FinishSuperFileTransaction(),
	);
	
	Export baseFiles := sequential(
		STD.File.StartSuperFileTransaction(),
		clear_input_files,
		rollback_input_files,
		clear_base_files,
		rollback_base_files,
		STD.File.FinishSuperFileTransaction()
	);
	
	Export All := map(	FraudgovInfo().CurrentStatus = 'Input_Phase' 									=> 	sequential(inputFiles, 	Send_Emails(pversion).BuildFailure),
									FraudgovInfo().CurrentStatus = 'Base_Completed' 								=> 	sequential(baseFiles, 	Send_Emails(pversion).BuildFailure)									
								);
end;

