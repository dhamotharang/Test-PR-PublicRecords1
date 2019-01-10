import tools,FraudShared;

export Create_Supers :=
	tools.mod_Utilities.createallsupers(
		filenames().Input.dAll_filenames +
		FraudShared.filenames().Input.dAll_filenames,
		filenames().dAll_filenames //+
//		keynames().dAll_filenames +
//		FraudShared.filenames().dAll_filenames +
//		FraudShared.keynames().dAll_filenames
		)
		;

//Create manually		
	// Std.File.CreateSuperFile('~fraudgov::in::passed::knownfraud');
	// Std.File.CreateSuperFile('~fraudgov::in::passed::identitydata');
	// Std.File.CreateSuperFile('~fraudgov::in::passed::deltabase');
	// Std.File.CreateSuperFile('~fraudgov::in::passed::nac');
	// Std.File.CreateSuperFile('~fraudgov::in::passed::inquirylogs');
	// Std.File.CreateSuperFile('~fraudgov::in::rejected::knownfraud');
	// Std.File.CreateSuperFile('~fraudgov::in::rejected::identitydata');	
	// Std.File.CreateSuperFile('~fraudgov::in::rejected::deltabase');
	// Std.File.CreateSuperFile('~fraudgov::in::rejected::nac');
	// Std.File.CreateSuperFile('~fraudgov::in::rejected::inquirylogs');
	
	// Std.File.CreateSuperFile('~fraudgov::in::delete::knownfraud');
	// Std.File.CreateSuperFile('~fraudgov::in::delete::identitydata');	
	// Std.File.CreateSuperFile('~fraudgov::in::delete::deltabase');
	// Std.File.CreateSuperFile('~fraudgov::in::delete::nac');
	// Std.File.CreateSuperFile('~fraudgov::in::delete::inquirylogs');
	// Std.File.CreateSuperFile('~fraudgov::in::sprayed::mbsinclusiondemodata');
	// Std.File.CreateSuperFile('~fraudgov::out::NewHeader_flag');
	// Std.File.CreateSuperFile('~fraudgov::out::NewHeader_flag_father');
	// Std.File.CreateSuperFile('~fraudgov::out::RefreshAddresses_flag');
	// Std.File.CreateSuperFile('~fraudgov::out::RefreshAddresses_flag_father');
	// Std.File.CreateSuperFile('~fraudgov::in::sprayed::demodata');
	// Std.File.CreateSuperFile('~fraudgov::in::sprayed::sourcestoanonymize');
	// Std.File.CreateSuperFile('~fraudgov::out::NewFraudgov_flag');
	// Std.File.CreateSuperFile('~fraudgov::out::NewFraudgov_flag_father');
	
	
	

	// Std.File.CreateSuperFile('~fraudgov::Scrubs_FraudGov::Log');
	
// tools.mod_Utilities.createallsupers(FraudGovPlatform.filenames().Input.DemoData.dAll_filenames);
// tools.mod_Utilities.createallsupers(FraudGovPlatform.filenames().Input.SourcesToAnonymize.dAll_filenames);
// tools.mod_Utilities.createallsupers(FraudGovPlatform.filenames().Base.Main_Orig.dAll_filenames);	
// tools.mod_Utilities.createallsupers(FraudGovPlatform.filenames().Input.MBSInclusionDemoData.dAll_filenames);	