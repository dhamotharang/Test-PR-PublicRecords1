IMPORT Emdeon, versioncontrol, _control, ut, tools;

EXPORT Build_all(STRING pVersion, BOOLEAN pUseProd = FALSE) := FUNCTION

	spray_  		 := Emdeon.fSprayDd(pVersion,pUseProd);

	built := SEQUENTIAL(
		spray_,
		Emdeon.consolidate_in_file(pVersion,pUseProd),				// consolidate the brand-new in file in preparation to be appended to previous version
		Emdeon.split_in_file(pVersion,pUseProd),							// raw file comes in as three file types in one, split into three before processing
		Emdeon.append_consolidated_file(pVersion,pUseProd),	// append file created in "consolidate_in_file" to consolidated file from previous build					
		Emdeon.Build_base.build_base_claims(pVersion,pUseProd).claims_all,
		Emdeon.Build_base.build_base_splits(pVersion,pUseProd).splits_all,
		Emdeon.Build_base.build_base_detail(pVersion,pUseProd).detail_all,
		Emdeon.Scrub_Emdeon(pVersion,pUseProd).Scrubit_CRecord,
		Emdeon.Scrub_Emdeon(pVersion,pUseProd).Scrubit_SRecord,
		Emdeon.Scrub_Emdeon(pVersion,pUseProd).Scrubit_DRecord,
		// Build_Keys will go here
		Emdeon.Promote.promote_claims(pVersion,pUseProd).buildfiles.Built2QA,
		Emdeon.Promote.promote_splits(pVersion,pUseProd).buildfiles.Built2QA,
		Emdeon.Promote.promote_detail(pVersion,pUseProd).buildfiles.Built2QA,
		Emdeon.Build_Strata(pVersion,pUseProd).CRecord,
		Emdeon.Build_Strata(pVersion,pUseProd).DRecord,
		Emdeon.Build_Strata(pVersion,pUseProd).SRecord,
		//Archive processed files in history					
		FileServices.StartSuperFileTransaction(),
		FileServices.AddSuperFile(Filenames(pVersion,pUseProd).claims_lInputHistTemplate,  Filenames(pVersion,pUseProd).claims_lInputTemplate,,true),
		FileServices.AddSuperFile(Filenames(pVersion,pUseProd).splits_lInputHistTemplate,  Filenames(pVersion,pUseProd).splits_lInputTemplate,,true),
		FileServices.AddSuperFile(Filenames(pVersion,pUseProd).detail_lInputHistTemplate,  Filenames(pVersion,pUseProd).detail_lInputTemplate,,true),
		FileServices.ClearSuperFile(Filenames(pVersion,pUseProd).claims_lInputTemplate),
		FileServices.ClearSuperFile(Filenames(pVersion,pUseProd).splits_lInputTemplate),
		FileServices.ClearSuperFile(Filenames(pVersion,pUseProd).detail_lInputTemplate),
		FileServices.ClearSuperFile(Emdeon.Filenames(pVersion,pUseProd).claims_lInputPreTemplate,TRUE),
		FileServices.FinishSuperFileTransaction(),
			// Basic_stats.Show_me_the_output
	): SUCCESS(Send_Email(pVersion,pUseProd).BuildSuccess), FAILURE(send_email(pVersion,pUseProd).BuildFailure

	);
	RETURN built;
	
END;