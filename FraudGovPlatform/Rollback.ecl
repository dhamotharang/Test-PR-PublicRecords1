import tools, STD;

lay_builds 	:= tools.Layout_FilenameVersions.builds;
lay_inputs	:= tools.Layout_FilenameVersions.Inputs;

export Rollback(
	 string								pversion						=		''
	,boolean							pDeleteInputFiles		= 	false
	,boolean							pDeleteBuildFiles		= 	false
	,boolean							pIsTesting					= 	false
	,string								pFilter							= 	''
	,dataset(lay_inputs)	pInputFilenames 		= 	Filenames	(pversion).Input.dAll_filenames
	,dataset(lay_builds)	pBuildFilenames 		= 	Filenames	(pversion).dAll_filenames
) :=
module
	export sprayedfiles := module
		export Delete2Passed := SEQUENTIAL(
		 STD.File.StartSuperFileTransaction(),
		 STD.File.AddSuperFile(FraudGovPlatform.Filenames().Sprayed._IdentityDataPassed,FraudGovPlatform.Filenames().Sprayed._IdentityDataDelete,addcontents := true),
		 STD.File.AddSuperFile(FraudGovPlatform.Filenames().Sprayed._KnownFraudPassed,FraudGovPlatform.Filenames().Sprayed._KnownFraudDelete,addcontents := true),
		 STD.File.AddSuperFile(FraudGovPlatform.Filenames().Sprayed._DeltabasePassed,FraudGovPlatform.Filenames().Sprayed._DeltabaseDelete,addcontents := true),
		 STD.File.AddSuperFile(FraudGovPlatform.Filenames().Sprayed._NACPassed,FraudGovPlatform.Filenames().Sprayed._NACDelete,addcontents := true),
		 STD.File.AddSuperFile(FraudGovPlatform.Filenames().Sprayed._InquiryLogsPassed,FraudGovPlatform.Filenames().Sprayed._InquiryLogsDelete,addcontents := true),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._IdentityDataDelete),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._KnownFraudDelete),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._DeltabaseDelete),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._NACDelete),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._InquiryLogsDelete),		 
		 STD.File.FinishSuperFileTransaction()
		);
	export Sprayed2Delete := sequential(
		STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::IdentityData', false),
		STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::bypassed_identitydata', false),                 
		STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::KnownFraud', false),      
		STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::bypassed_knownfraud', false), 
		STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::KnownFraud', false),      
		STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::bypassed_knownfraud', false), 
		STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::addresscache_iddt', false),         
		STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::addresscache_knfd', false)
		);
		
	export MBS_Sprayed2Delete := sequential(
		STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::mbsvelocityrules', true),
		STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::mbsfdnmasteridindtypeinclusion', true),                 
		STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::mbscolvaldesc', true),      
		STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::mbstablecol', true), 
		STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::mbsfdnindtype', true),      
		STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::mbssourcegcexclusion', true), 
		STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::mbsproductinclude', true),         
		STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::mbsindtypeexclusion', true),
		STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::mbsnewgcidexclusion', true),
		STD.File.ClearSuperFile('~thor_data400::in::fraudgov::sprayed::mbs', true)
	);
	end;	
	export inputfiles	:= tools.mod_RollbackInput(pInputFilenames,pFilter,pDeleteInputFiles,pIsTesting);
	export buildfiles	:= tools.mod_RollbackBuild(pversion,pBuildFilenames,pFilter,pDeleteBuildFiles,pIsTesting);
	
	export fullbuild := sequential(
		 inputfiles.Used2Sprayed
		,buildfiles.Father2QA		
	);
	
end;