import tools, STD, FraudShared;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
lay_inputs	:= tools.Layout_FilenameVersions.Inputs;

export Promote(

	 string pversion = ''
	,string pFilter = ''
	,boolean pDelete = false
	,boolean pIsTesting = false
	,dataset(lay_inputs) pInputFilenames = 	Filenames(pversion).Input.dAll_filenames
	,dataset(lay_builds) pBuildFilenames = 	Filenames(pversion).dAll_filenames
											+ Keynames  (pversion).dAll_filenames
																					
) :=
module
	export sprayedfiles := module
		export Passed2Delete := SEQUENTIAL(
		 STD.File.StartSuperFileTransaction(),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._IdentityDataDelete, true),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._KnownFraudDelete, true),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._DeltabaseDelete, true),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._NACDelete, true),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._InquiryLogsDelete, true),
		 STD.File.AddSuperFile(FraudGovPlatform.Filenames().Sprayed._IdentityDataDelete		,FraudGovPlatform.Filenames().Sprayed._IdentityDataPassed,addcontents := true),
		 STD.File.AddSuperFile(FraudGovPlatform.Filenames().Sprayed._KnownFraudDelete		,FraudGovPlatform.Filenames().Sprayed._KnownFraudPassed,addcontents := true),
		 STD.File.AddSuperFile(FraudGovPlatform.Filenames().Sprayed._DeltabaseDelete			,FraudGovPlatform.Filenames().Sprayed._DeltabasePassed,addcontents := true),
		 STD.File.AddSuperFile(FraudGovPlatform.Filenames().Sprayed._NACDelete					,FraudGovPlatform.Filenames().Sprayed._NACPassed,addcontents := true),
		 STD.File.AddSuperFile(FraudGovPlatform.Filenames().Sprayed._InquiryLogsDelete		,FraudGovPlatform.Filenames().Sprayed._InquiryLogsPassed,addcontents := true),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._IdentityDataPassed),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._KnownFraudPassed),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._DeltabasePassed),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._NACPassed),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._InquiryLogsPassed),		 
		 STD.File.FinishSuperFileTransaction()
		);
		export Rejected2Delete := SEQUENTIAL(
		 STD.File.StartSuperFileTransaction(),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._IdentityDataRejected, true),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._KnownFraudRejected, true),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._DeltabaseRejected, true),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._NACRejected, true),
		 STD.File.ClearSuperFile(FraudGovPlatform.Filenames().Sprayed._InquiryLogsRejected, true),	
		 STD.File.FinishSuperFileTransaction()
		);

	end;
	export inputfiles	:= tools.mod_PromoteInput(pversion,pInputFilenames,pFilter,pDelete,pIsTesting);
	export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pIsTesting);

	export promote_inputs := sequential(
			 inputfiles.Sprayed2Using
			,inputfiles.Using2Used
			,inputfiles.New2Sprayed
	);
	export promote_base := sequential(
			 buildfiles.Built2QA			
	);

	export promote_keys := sequential(
			 sprayedfiles.Passed2Delete
			,sprayedfiles.Rejected2Delete
			// Promote Shared Files
			,FraudShared.Promote().buildfiles.Built2QA			
			// Clean Up Shared Files	
			,FraudShared.Promote().buildfiles.cleanup	
			//Remove the Demo file from father sf, which was moved from qa as a promote routeine
			,STD.File.RemoveSuperFile(FraudShared.Filenames().Base.Main.Father,	Filenames().Input.DemoData.Sprayed)
	);
end;
