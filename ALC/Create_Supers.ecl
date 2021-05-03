IMPORT ALC, tools;

EXPORT Create_Supers := MODULE

  EXPORT All := 
	  SEQUENTIAL(tools.mod_Utilities.createsupers(ALC.Filenames().base_dAll_filenames),
		           FileServices.StartSuperFileTransaction(),

							 // Create input superfiles.
							 FileServices.CreateSuperFile(ALC.Filenames().Accountants_lInputTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Dental_Professionals_lInputTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Insurance_Agents_lInputTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Lawyers_lInputTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Nurses1_lInputTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Nurses2_lInputTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Nurses3_lInputTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Nurses4_lInputTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Pharmacists_lInputTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Pilots_lInputTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Professionals1_lInputTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Professionals2_lInputTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Professionals3_lInputTemplate, , TRUE),

							 // Create input history superfiles.
							 FileServices.CreateSuperFile(ALC.Filenames().Accountants_lInputHistTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Dental_Professionals_lInputHistTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Insurance_Agents_lInputHistTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Lawyers_lInputHistTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Nurses1_lInputHistTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Nurses2_lInputHistTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Nurses3_lInputHistTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Nurses4_lInputHistTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Pharmacists_lInputHistTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Pilots_lInputHistTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Professionals1_lInputHistTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Professionals2_lInputHistTemplate, , TRUE),
							 FileServices.CreateSuperFile(ALC.Filenames().Professionals3_lInputHistTemplate, , TRUE),

							 FileServices.FinishSuperFileTransaction());

END;
