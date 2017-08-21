IMPORT Infogroup, tools;

EXPORT Create_Supers := MODULE

  EXPORT All := 
	  SEQUENTIAL(tools.mod_Utilities.createsupers(Infogroup.Filenames().base_dAll_filenames),
		           FileServices.StartSuperFileTransaction(),

							 // Create input superfile.
							 FileServices.CreateSuperFile(Infogroup.Filenames().Data_lInputTemplate, , TRUE),

							 // Create input history superfile.
							 FileServices.CreateSuperFile(Infogroup.Filenames().Data_lInputHistTemplate, , TRUE),

							 FileServices.FinishSuperFileTransaction());

END;
