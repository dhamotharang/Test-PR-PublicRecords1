import tools, STD, FraudShared;

export Rollback  :=
module

	Shared PreviousVersion := FraudGovInfo().PreviousVersion;
	
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

		// STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.pii.Built, false),
		// STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.ciid.Built, false),
		// STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.death.Built, false),
		// STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.fraudpoint.Built, false),
		// STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.crim.Built, false),

		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.IdentityData.QA, false),	
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.KnownFraud.QA, false),      
		STD.File.ClearSuperFile(FraudShared.Filenames(PreviousVersion).Base.Main.QA, false),
		STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.addresscache.QA, false),
		
		// STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.pii.QA, false),
		// STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.ciid.QA, false),
		// STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.death.QA, false),
		// STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.fraudpoint.QA, false),
		// STD.File.ClearSuperFile(Filenames(PreviousVersion).Base.crim.QA, false),
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
		// STD.File.AddSuperFile(Filenames(PreviousVersion).Base.pii.Built		,Filenames(PreviousVersion).Base.pii.New),	
		// STD.File.AddSuperFile(Filenames(PreviousVersion).Base.ciid.Built		,Filenames(PreviousVersion).Base.ciid.New),	
		// STD.File.AddSuperFile(Filenames(PreviousVersion).Base.death.Built		,Filenames(PreviousVersion).Base.death.New),	
		// STD.File.AddSuperFile(Filenames(PreviousVersion).Base.fraudpoint.Built		,Filenames(PreviousVersion).Base.fraudpoint.New),	
		// STD.File.AddSuperFile(Filenames(PreviousVersion).Base.crim.Built		,Filenames(PreviousVersion).Base.crim.New),	

		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.IdentityData.QA		,Filenames(PreviousVersion).Base.IdentityData.New),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.KnownFraud.QA		,Filenames(PreviousVersion).Base.KnownFraud.New),	
		STD.File.AddSuperFile(FraudShared.Filenames(PreviousVersion).Base.Main.QA		,FraudShared.Filenames(PreviousVersion).Base.Main.New),	
		STD.File.AddSuperFile(Filenames(PreviousVersion).Base.addresscache.QA		,Filenames(PreviousVersion).Base.addresscache.New),	
		// STD.File.AddSuperFile(Filenames(PreviousVersion).Base.pii.QA		,Filenames(PreviousVersion).Base.pii.New),	
		// STD.File.AddSuperFile(Filenames(PreviousVersion).Base.ciid.QA		,Filenames(PreviousVersion).Base.ciid.New),	
		// STD.File.AddSuperFile(Filenames(PreviousVersion).Base.death.QA		,Filenames(PreviousVersion).Base.death.New),	
		// STD.File.AddSuperFile(Filenames(PreviousVersion).Base.fraudpoint.QA		,Filenames(PreviousVersion).Base.fraudpoint.New),	
		// STD.File.AddSuperFile(Filenames(PreviousVersion).Base.crim.QA		,Filenames(PreviousVersion).Base.crim.New),			
	);
	
	Export inputFiles := sequential(
		STD.File.StartSuperFileTransaction(),
		clear_input_files,
		rollback_input_files,
		STD.File.FinishSuperFileTransaction()
	);
	
	Export baseFiles := sequential(
		STD.File.StartSuperFileTransaction(),
		clear_input_files,
		rollback_input_files,
		clear_base_files,
		rollback_base_files,
		STD.File.FinishSuperFileTransaction()
	);
	
	Export All := map(	FraudgovInfo().CurrentStatus = 'Input_Phase' => inputFiles,
									FraudgovInfo().CurrentStatus in  ['Base_Phase','Base_Completed'] => baseFiles									
								);
end;

