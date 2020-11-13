IMPORT ALC;

EXPORT Promote_Input_Files(STRING  pversion,
                           BOOLEAN pUseProd = FALSE) := MODULE

  EXPORT All := 
	  SEQUENTIAL(FileServices.StartSuperFileTransaction(),
							
               // Delete anything in the history superfiles
							 FileServices.RemoveOwnedSubFiles(ALC.Filenames(, pUseProd).Accountants_lInputHistTemplate, TRUE),
							 FileServices.RemoveOwnedSubFiles(ALC.Filenames(, pUseProd).Dental_Professionals_lInputHistTemplate, TRUE),
							 FileServices.RemoveOwnedSubFiles(ALC.Filenames(, pUseProd).Insurance_Agents_lInputHistTemplate, TRUE),
							 FileServices.RemoveOwnedSubFiles(ALC.Filenames(, pUseProd).Lawyers_lInputHistTemplate, TRUE),
							 FileServices.RemoveOwnedSubFiles(ALC.Filenames(, pUseProd).Nurses1_lInputHistTemplate, TRUE),
							 FileServices.RemoveOwnedSubFiles(ALC.Filenames(, pUseProd).Nurses2_lInputHistTemplate, TRUE),
							 FileServices.RemoveOwnedSubFiles(ALC.Filenames(, pUseProd).Nurses3_lInputHistTemplate, TRUE),
							 FileServices.RemoveOwnedSubFiles(ALC.Filenames(, pUseProd).Nurses4_lInputHistTemplate, TRUE),
							 FileServices.RemoveOwnedSubFiles(ALC.Filenames(, pUseProd).Pharmacists_lInputHistTemplate, TRUE),
							 FileServices.RemoveOwnedSubFiles(ALC.Filenames(, pUseProd).Pilots_lInputHistTemplate, TRUE),
							 FileServices.RemoveOwnedSubFiles(ALC.Filenames(, pUseProd).Professionals1_lInputHistTemplate, TRUE),
							 FileServices.RemoveOwnedSubFiles(ALC.Filenames(, pUseProd).Professionals2_lInputHistTemplate, TRUE),
							 FileServices.RemoveOwnedSubFiles(ALC.Filenames(, pUseProd).Professionals3_lInputHistTemplate, TRUE),

							 // Add input files, just used, into the history superfiles
							 FileServices.AddSuperFile(ALC.Filenames(, pUseProd).Accountants_lInputHistTemplate, ALC.Filenames(pversion, pUseProd).Accountants_lInputTemplate),
							 FileServices.AddSuperFile(ALC.Filenames(, pUseProd).Dental_Professionals_lInputHistTemplate, ALC.Filenames(pversion, pUseProd).Dental_Professionals_lInputTemplate),
							 FileServices.AddSuperFile(ALC.Filenames(, pUseProd).Insurance_Agents_lInputHistTemplate, ALC.Filenames(pversion, pUseProd).Insurance_Agents_lInputTemplate),
							 FileServices.AddSuperFile(ALC.Filenames(, pUseProd).Lawyers_lInputHistTemplate, ALC.Filenames(pversion, pUseProd).Lawyers_lInputTemplate),
							 FileServices.AddSuperFile(ALC.Filenames(, pUseProd).Nurses1_lInputHistTemplate, ALC.Filenames(pversion, pUseProd).Nurses1_lInputTemplate),
							 FileServices.AddSuperFile(ALC.Filenames(, pUseProd).Nurses2_lInputHistTemplate, ALC.Filenames(pversion, pUseProd).Nurses2_lInputTemplate),
							 FileServices.AddSuperFile(ALC.Filenames(, pUseProd).Nurses3_lInputHistTemplate, ALC.Filenames(pversion, pUseProd).Nurses3_lInputTemplate),
							 FileServices.AddSuperFile(ALC.Filenames(, pUseProd).Nurses4_lInputHistTemplate, ALC.Filenames(pversion, pUseProd).Nurses4_lInputTemplate),
							 FileServices.AddSuperFile(ALC.Filenames(, pUseProd).Pharmacists_lInputHistTemplate, ALC.Filenames(pversion, pUseProd).Pharmacists_lInputTemplate),
							 FileServices.AddSuperFile(ALC.Filenames(, pUseProd).Pilots_lInputHistTemplate, ALC.Filenames(pversion, pUseProd).Pilots_lInputTemplate),
							 FileServices.AddSuperFile(ALC.Filenames(, pUseProd).Professionals1_lInputHistTemplate, ALC.Filenames(pversion, pUseProd).Professionals1_lInputTemplate),
							 FileServices.AddSuperFile(ALC.Filenames(, pUseProd).Professionals2_lInputHistTemplate, ALC.Filenames(pversion, pUseProd).Professionals2_lInputTemplate),
							 FileServices.AddSuperFile(ALC.Filenames(, pUseProd).Professionals3_lInputHistTemplate, ALC.Filenames(pversion, pUseProd).Professionals3_lInputTemplate),

							 // Empty the superfiles used to store the input when it was sprayed.
							 // No deletion.
							 FileServices.ClearSuperFile(ALC.Filenames(, pUseProd).Accountants_lInputTemplate),
							 FileServices.ClearSuperFile(ALC.Filenames(, pUseProd).Dental_Professionals_lInputTemplate),
							 FileServices.ClearSuperFile(ALC.Filenames(, pUseProd).Insurance_Agents_lInputTemplate),
							 FileServices.ClearSuperFile(ALC.Filenames(, pUseProd).Lawyers_lInputTemplate),
							 FileServices.ClearSuperFile(ALC.Filenames(, pUseProd).Nurses1_lInputTemplate),
							 FileServices.ClearSuperFile(ALC.Filenames(, pUseProd).Nurses2_lInputTemplate),
							 FileServices.ClearSuperFile(ALC.Filenames(, pUseProd).Nurses3_lInputTemplate),
							 FileServices.ClearSuperFile(ALC.Filenames(, pUseProd).Nurses4_lInputTemplate),
							 FileServices.ClearSuperFile(ALC.Filenames(, pUseProd).Pharmacists_lInputTemplate),
							 FileServices.ClearSuperFile(ALC.Filenames(, pUseProd).Pilots_lInputTemplate),
							 FileServices.ClearSuperFile(ALC.Filenames(, pUseProd).Professionals1_lInputTemplate),
							 FileServices.ClearSuperFile(ALC.Filenames(, pUseProd).Professionals2_lInputTemplate),
							 FileServices.ClearSuperFile(ALC.Filenames(, pUseProd).Professionals3_lInputTemplate),

							 FileServices.FinishSuperFileTransaction());

END;