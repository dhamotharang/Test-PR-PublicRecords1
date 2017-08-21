IMPORT Infogroup;

EXPORT Promote_Input_Files(STRING  pversion,
                           BOOLEAN pUseProd = FALSE) := MODULE

  EXPORT All :=
	  SEQUENTIAL(FileServices.StartSuperFileTransaction(),

               // Delete anything in the history superfiles
							 FileServices.RemoveOwnedSubFiles(Infogroup.Filenames(, pUseProd).Data_lInputHistTemplate, TRUE),

							 // Add input files, just used, into the history superfiles
							 FileServices.AddSuperFile(Infogroup.Filenames(, pUseProd).Data_lInputHistTemplate, Infogroup.Filenames(pversion, pUseProd).Data_lInputTemplate),

							 // Empty the superfiles used to store the input when it was sprayed.
							 // No deletion.
							 FileServices.ClearSuperFile(Infogroup.Filenames(, pUseProd).Data_lInputTemplate),

							 FileServices.FinishSuperFileTransaction());

END;