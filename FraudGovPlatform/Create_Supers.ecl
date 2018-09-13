import tools,FraudShared;

export Create_Supers :=
	tools.mod_Utilities.createallsupers(
		filenames().Input.dAll_filenames +
		FraudShared.filenames().Input.dAll_filenames,
		filenames().dAll_filenames +
		keynames().dAll_filenames +
		FraudShared.filenames().dAll_filenames +
		FraudShared.keynames().dAll_filenames
		)
		;

//Create manually		
	// Std.File.CreateSuperFile('~thor_data400::in::fraudgov::passed::knownfraud');
	// Std.File.CreateSuperFile('~thor_data400::in::fraudgov::passed::identitydata');
	// Std.File.CreateSuperFile('~thor_data400::in::fraudgov::passed::deltabase');
	// Std.File.CreateSuperFile('~thor_data400::in::fraudgov::passed::nac');
	// Std.File.CreateSuperFile('~thor_data400::in::fraudgov::passed::inquirylogs');
	// Std.File.CreateSuperFile('~thor_data400::in::fraudgov::rejected::knownfraud');
	// Std.File.CreateSuperFile('~thor_data400::in::fraudgov::rejected::identitydata');	
	// Std.File.CreateSuperFile('~thor_data400::in::fraudgov::rejected::deltabase');
	// Std.File.CreateSuperFile('~thor_data400::in::fraudgov::rejected::nac');
	// Std.File.CreateSuperFile('~thor_data400::in::fraudgov::rejected::inquirylogs');
	
	// Std.File.CreateSuperFile('~thor_data400::in::fraudgov::delete::knownfraud');
	// Std.File.CreateSuperFile('~thor_data400::in::fraudgov::delete::identitydata');	
	// Std.File.CreateSuperFile('~thor_data400::in::fraudgov::delete::deltabase');
	// Std.File.CreateSuperFile('~thor_data400::in::fraudgov::delete::nac');
	// Std.File.CreateSuperFile('~thor_data400::in::fraudgov::delete::inquirylogs');	

	// Std.File.CreateSuperFile('~thor_data400::Scrubs_FraudGov::Log');
	
// tools.mod_Utilities.createallsupers(FraudGovPlatform.filenames().Input.DemoData.dAll_filenames);
// tools.mod_Utilities.createallsupers(FraudGovPlatform.filenames().Input.SourcesToAnonymize.dAll_filenames);
// tools.mod_Utilities.createallsupers(FraudGovPlatform.filenames().Base.Main_Orig.dAll_filenames);	