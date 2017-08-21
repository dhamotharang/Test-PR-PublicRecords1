IMPORT VersionControl,STD,ut;

EXPORT CleanUp := MODULE

			export MoveInputFilesToHistory(string pversion) := sequential(
					FileServices.StartSuperFileTransaction(),
					FileServices.RemoveSuperFile(		bair_importer.Filenames().lInputHistTemplateEVENT_MO_CSV				,		bair_importer.Filenames().lInputTemplateEVENT_MO_CSV 				+ '::' + pversion),
					FileServices.RemoveSuperFile(		bair_importer.Filenames().lInputHistTemplateEVENT_PERSONS_CSV		,		bair_importer.Filenames().lInputTemplateEVENT_PERSONS_CSV 	+ '::' + pversion),
					FileServices.RemoveSuperFile(		bair_importer.Filenames().lInputHistTemplateEVENT_VEHICLES_CSV	,		bair_importer.Filenames().lInputTemplateEVENT_VEHICLES_CSV 	+ '::' + pversion),
					
					FileServices.RemoveSuperFile(		bair_importer.Filenames().lInputHistTemplateCFS_XML					,		bair_importer.Filenames().lInputTemplateCFS_XML 	+ '::' + pversion),
					FileServices.RemoveSuperFile(		bair_importer.Filenames().lInputHistTemplateCFS_CSV					,		bair_importer.Filenames().lInputTemplateCFS_CSV 	+ '::' + pversion),
					FileServices.RemoveSuperFile(		bair_importer.Filenames().lInputHistTemplateCFSOFFICERS_CSV	,		bair_importer.Filenames().lInputTemplateCFSOFFICERS_CSV 	+ '::' + pversion),
					FileServices.RemoveSuperFile(		bair_importer.Filenames().lInputHistTemplateCrash						,		bair_importer.Filenames().lInputTemplateCrash 		+ '::' + pversion),
					FileServices.RemoveSuperFile(		bair_importer.Filenames().lInputHistTemplateOffender				,		bair_importer.Filenames().lInputTemplateOffender + '::' + pversion),
					FileServices.RemoveSuperFile(		bair_importer.Filenames().lInputHistTemplateLPR_XML					,		bair_importer.Filenames().lInputTemplateLPR_XML	+ '::' + pversion),
					FileServices.RemoveSuperFile(		bair_importer.Filenames().lInputHistTemplateLPR_CSV					,		bair_importer.Filenames().lInputTemplateLPR_CSV	+ '::' + pversion),
					FileServices.AddSuperFile		(		bair_importer.Filenames().lInputHistTemplateEVENT_XML				,  	bair_importer.Filenames().lInputTemplateEVENT_XML		,,true),
					FileServices.AddSuperFile		(		bair_importer.Filenames().lInputHistTemplateEVENT_MO_CSV		,  	bair_importer.Filenames().lInputTemplateEVENT_MO_CSV		,,true),					
					FileServices.AddSuperFile		(		bair_importer.Filenames().lInputHistTemplateEVENT_PERSONS_CSV		,  	bair_importer.Filenames().lInputTemplateEVENT_PERSONS_CSV		,,true),					
					FileServices.AddSuperFile		(		bair_importer.Filenames().lInputHistTemplateEVENT_VEHICLES_CSV	,  	bair_importer.Filenames().lInputTemplateEVENT_VEHICLES_CSV		,,true),					
					FileServices.AddSuperFile		(		bair_importer.Filenames().lInputHistTemplateCFS_XML					,  	bair_importer.Filenames().lInputTemplateCFS_XML	,,true),
					FileServices.AddSuperFile		(		bair_importer.Filenames().lInputHistTemplateCFS_CSV					,  	bair_importer.Filenames().lInputTemplateCFS_CSV	,,true),
					FileServices.AddSuperFile		(		bair_importer.Filenames().lInputHistTemplateCFSOFFICERS_CSV	,  	bair_importer.Filenames().lInputTemplateCFSOFFICERS_CSV	,,true),
					FileServices.AddSuperFile		(		bair_importer.Filenames().lInputHistTemplateCrash						,  	bair_importer.Filenames().lInputTemplateCrash		,,true),
					FileServices.AddSuperFile		(		bair_importer.Filenames().lInputHistTemplateOffender				,	 	bair_importer.Filenames().lInputTemplateOffender	,,true),
					FileServices.AddSuperFile		(		bair_importer.Filenames().lInputHistTemplateLPR_XML					,  	bair_importer.Filenames().lInputTemplateLPR_XML	,,true),
					FileServices.AddSuperFile		(		bair_importer.Filenames().lInputHistTemplateLPR_CSV					,  	bair_importer.Filenames().lInputTemplateLPR_CSV	,,true),
					FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateEVENT_XML),
					FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateEVENT_MO_CSV),
					FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateEVENT_PERSONS_CSV),
					FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateEVENT_VEHICLES_CSV),
					FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateCFS_XML),
					FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateCFS_CSV),
					FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateCFSOFFICERS_CSV),
					FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateCrash),
					FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateOffender),
					FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateLPR_XML),
					FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateLPR_CSV),
					FileServices.FinishSuperFileTransaction()
			);

			date := ut.GetDate;
			
			
			PreviousAddressCache := sort(nothor(STD.File.LogicalFileList('thor_data400::in::prepped::ln_address_cache*')),-modified);
			AddSuper := FileServices.AddSuperFile('~thor_data400::in::prepped::ln_address_cache::built', '~'+PreviousAddressCache[1].name);
			reset_cache := if(FileServices.GetSuperFileSubCount('~thor_data400::in::prepped::ln_address_cache::built') = 0, AddSuper);
			
			export PrepareFiles(string pDaliServer, string pLandingZone, string pBuildVersion, string pReProcessFlag ):= sequential(
				reset_cache,
				FileServices.StartSuperFileTransaction(),
				// If file has been processed before, then move it back to folder Ready so it can be reprocessed 
				if (pReProcessFlag = 'Reprocess', bair_importer.fFileMoves(pDaliServer,pLandingZone,pBuildVersion).MoveDoneToReady),
				// If file has been processed before but got stucked during Spraying then move it back to folder Ready so it can be reprocessed 
				if (pReProcessFlag = 'Reprocess', bair_importer.fFileMoves(pDaliServer,pLandingZone,pBuildVersion).MoveSprayingToReady),
				// If file has been processed before but had an error then move it back to folder Ready so it can be reprocessed 
				if (pReProcessFlag = 'Reprocess', bair_importer.fFileMoves(pDaliServer,pLandingZone,pBuildVersion).MoveErrorToReady),
				// Ultimately move the file from Ready to Spraying
				bair_importer.fFileMoves(pDaliServer,pLandingZone,pBuildVersion).MoveReadyToSpraying,
				FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateEVENT_XML),
				FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateEVENT_MO_CSV),
				FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateEVENT_PERSONS_CSV),
				FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateEVENT_VEHICLES_CSV),
				FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateCFS_XML),
				FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateCFS_CSV),
				FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateCFSOFFICERS_CSV),
				FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateCrash),
				FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateOffender),
				FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateLPR_XML),
				FileServices.ClearSuperFile	(		bair_importer.Filenames().lInputTemplateLPR_CSV),
				FileServices.FinishSuperFileTransaction()
			);

END;