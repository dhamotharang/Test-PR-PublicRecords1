IMPORT VersionControl,STD,ut,_control;

EXPORT CleanUp := MODULE

			export MoveInputFilesToHistory(string pVersion) := sequential(
					FileServices.StartSuperFileTransaction(),
					
					FileServices.RemoveSuperFile(Filenames().lInputHistTemplateEVENT_MO_CSV, Filenames().lInputTemplateEVENT_MO_CSV + '::' + pVersion),
					FileServices.RemoveSuperFile(Filenames().lInputHistTemplateEVENT_PERSONS_CSV, Filenames().lInputTemplateEVENT_PERSONS_CSV 	+ '::' + pVersion),
					FileServices.RemoveSuperFile(Filenames().lInputHistTemplateEVENT_VEHICLES_CSV, Filenames().lInputTemplateEVENT_VEHICLES_CSV 	+ '::' + pVersion),
					
					FileServices.RemoveSuperFile(Filenames().lInputHistTemplateCFS_CSV, Filenames().lInputTemplateCFS_CSV 	+ '::' + pVersion),
					FileServices.RemoveSuperFile(Filenames().lInputHistTemplateCFSOFFICERS_CSV, Filenames().lInputTemplateCFSOFFICERS_CSV 	+ '::' + pVersion),
					
					FileServices.RemoveSuperFile(Filenames().lInputHistTemplateCRASH_CSV, Filenames().lInputTemplateCRASH_PERSONS_CSV + '::' + pVersion),
					FileServices.RemoveSuperFile(Filenames().lInputHistTemplateCRASH_PERSONS_CSV, Filenames().lInputTemplateCRASH_VEHICLES_CSV + '::' + pVersion),
					FileServices.RemoveSuperFile(Filenames().lInputHistTemplateCRASH_VEHICLES_CSV, Filenames().lInputTemplateCrash_CSV + '::' + pVersion),
					
					FileServices.RemoveSuperFile(Filenames().lInputHistTemplateOffender_CSV, Filenames().lInputTemplateOffender_CSV + '::' + pVersion),
					FileServices.RemoveSuperFile(Filenames().lInputHistTemplateClassification_CSV, Filenames().lInputTemplateClassification_CSV + '::' + pVersion),
					FileServices.RemoveSuperFile(Filenames().lInputHistTemplatePictures_CSV, Filenames().lInputTemplatePictures_CSV + '::' + pVersion),
					
					FileServices.RemoveSuperFile(Filenames().lInputHistTemplateLPR_CSV, Filenames().lInputTemplateLPR_CSV	+ '::' + pVersion),

					FileServices.RemoveSuperFile(Filenames().lInputHistTemplateManifest, Filenames().lInputTemplateManifest + '::' + pVersion),
					
					FileServices.AddSuperFile		(Filenames().lInputHistTemplateEVENT_MO_CSV, Filenames().lInputTemplateEVENT_MO_CSV,,true),					
					FileServices.AddSuperFile		(Filenames().lInputHistTemplateEVENT_PERSONS_CSV, Filenames().lInputTemplateEVENT_PERSONS_CSV,,true),					
					FileServices.AddSuperFile		(Filenames().lInputHistTemplateEVENT_VEHICLES_CSV, Filenames().lInputTemplateEVENT_VEHICLES_CSV,,true),					
					
					FileServices.AddSuperFile		(Filenames().lInputHistTemplateCFS_CSV, Filenames().lInputTemplateCFS_CSV,,true),
					FileServices.AddSuperFile		(Filenames().lInputHistTemplateCFSOFFICERS_CSV, Filenames().lInputTemplateCFSOFFICERS_CSV,,true),
					
					FileServices.AddSuperFile		(Filenames().lInputHistTemplateCRASH_CSV, Filenames().lInputTemplateCRASH_CSV,,true),
					FileServices.AddSuperFile		(Filenames().lInputHistTemplateCRASH_PERSONS_CSV, Filenames().lInputTemplateCRASH_PERSONS_CSV,,true),
					FileServices.AddSuperFile		(Filenames().lInputHistTemplateCRASH_VEHICLES_CSV, Filenames().lInputTemplateCRASH_VEHICLES_CSV,,true),
					
					FileServices.AddSuperFile		(Filenames().lInputHistTemplateOffender_CSV, Filenames().lInputTemplateOffender_CSV,,true),
					FileServices.AddSuperFile		(Filenames().lInputHistTemplateClassification_CSV, Filenames().lInputTemplateClassification_CSV,,true),
					FileServices.AddSuperFile		(Filenames().lInputHistTemplatePictures_CSV, Filenames().lInputTemplatePictures_CSV,,true),
					
					FileServices.AddSuperFile		(Filenames().lInputHistTemplateLPR_CSV, Filenames().lInputTemplateLPR_CSV,,true),

					FileServices.AddSuperFile		(Filenames().lInputHistTemplateManifest, Filenames().lInputTemplateManifest ,,true),
					
					FileServices.ClearSuperFile	(Filenames().lInputTemplateEVENT_MO_CSV),
					FileServices.ClearSuperFile	(Filenames().lInputTemplateEVENT_PERSONS_CSV),
					FileServices.ClearSuperFile	(Filenames().lInputTemplateEVENT_VEHICLES_CSV),
					
					FileServices.ClearSuperFile	(Filenames().lInputTemplateCFS_CSV),
					FileServices.ClearSuperFile	(Filenames().lInputTemplateCFSOFFICERS_CSV),
					
					FileServices.ClearSuperFile	(Filenames().lInputTemplateCRASH_CSV),
					FileServices.ClearSuperFile	(Filenames().lInputTemplateCRASH_PERSONS_CSV),
					FileServices.ClearSuperFile	(Filenames().lInputTemplateCRASH_VEHICLES_CSV),
					
					FileServices.ClearSuperFile	(Filenames().lInputTemplateClassification_CSV),
					FileServices.ClearSuperFile	(Filenames().lInputTemplatePictures_CSV),
					FileServices.ClearSuperFile	(Filenames().lInputTemplateOffender_CSV),
					
					FileServices.ClearSuperFile	(Filenames().lInputTemplateLPR_CSV),
					FileServices.ClearSuperFile	(Filenames().lInputTemplateManifest),

					FileServices.FinishSuperFileTransaction()
			);

			date := ut.GetDate;
			
			
			PreviousAddressCache := sort(nothor(STD.File.LogicalFileList('thor_data400::in::prepped::ln_address_cache*')),-modified);
			AddSuper := FileServices.AddSuperFile('~thor_data400::in::prepped::ln_address_cache::built', '~'+PreviousAddressCache[1].name);
			reset_cache := if(FileServices.GetSuperFileSubCount('~thor_data400::in::prepped::ln_address_cache::built') = 0, AddSuper);
			
			export PrepareFiles(string pVersion) := sequential(
				reset_cache,
				FileServices.StartSuperFileTransaction(),
				fFileMoves(pVersion).MoveReadyToSpraying,
				FileServices.ClearSuperFile	(Filenames().lInputTemplateEVENT_MO_CSV),
				FileServices.ClearSuperFile	(Filenames().lInputTemplateEVENT_PERSONS_CSV),
				FileServices.ClearSuperFile	(Filenames().lInputTemplateEVENT_VEHICLES_CSV),

				FileServices.ClearSuperFile	(Filenames().lInputTemplateCFS_CSV),
				FileServices.ClearSuperFile	(Filenames().lInputTemplateCFSOFFICERS_CSV),

				FileServices.ClearSuperFile	(Filenames().lInputTemplateCRASH_CSV),
				FileServices.ClearSuperFile	(Filenames().lInputTemplateCRASH_PERSONS_CSV),
				FileServices.ClearSuperFile	(Filenames().lInputTemplateCRASH_VEHICLES_CSV),
				
				FileServices.ClearSuperFile	(Filenames().lInputTemplateOffender_CSV),
				FileServices.ClearSuperFile	(Filenames().lInputTemplateClassification_CSV),
				FileServices.ClearSuperFile	(Filenames().lInputTemplatePictures_CSV),

				FileServices.ClearSuperFile	(Filenames().lInputTemplateLPR_CSV),
				FileServices.ClearSuperFile	(Filenames().lInputTemplateManifest),
				FileServices.FinishSuperFileTransaction()
			);

END;