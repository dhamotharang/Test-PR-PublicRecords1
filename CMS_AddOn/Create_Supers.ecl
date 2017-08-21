IMPORT CMS_AddOn, tools;

EXPORT Create_Supers := MODULE

  EXPORT All := 
	  SEQUENTIAL(tools.mod_Utilities.createsupers(CMS_AddOn.Filenames().base_dAll_filenames),
		           FileServices.StartSuperFileTransaction(),

							 // Create input superfiles.
							 FileServices.CreateSuperFile(CMS_AddOn.Filenames().lInputTemplate, , TRUE),

							 // Create input history superfiles.
							 FileServices.CreateSuperFile(CMS_AddOn.Filenames().lInputHistTemplate, , TRUE),

							 // Create Alpharetta superfile.
							 FileServices.CreateSuperFile('~thor::base::qa::addson_codes_reference_data', , TRUE),

							 FileServices.FinishSuperFileTransaction());

END;
