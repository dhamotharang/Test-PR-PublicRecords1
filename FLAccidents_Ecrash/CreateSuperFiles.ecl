IMPORT STD;
fileservices := STD.File;

CreateSuperFile(STRING File) := IF (~FileServices.FileExists(File), FileServices.CreateSuperFile(File));

  CreateSFBase := SEQUENTIAL(			
                       CreateSuperFile('~thor_data400::base::InseCrashSlim'),
                       CreateSuperFile('~thor_data400::base::InseCrashSlim_father'),
                       CreateSuperFile('~thor_data400::base::InseCrashSlim_grandfather'),
                       CreateSuperFile('~thor_data400::base::InseCrashSlim_delete'),
											 CreateSuperFile('~thor::base::ecrash::qa::consolidation_ecrash'),
                       CreateSuperFile('~thor::base::ecrash::father::consolidation_ecrash'),
                       CreateSuperFile('~thor::base::ecrash::grandfather::consolidation_ecrash'),
                       CreateSuperFile('~thor::base::ecrash::delete::consolidation_ecrash'),
											 CreateSuperFile('~thor::base::ecrash::qa::consolidation_pr'),
                       CreateSuperFile('~thor::base::ecrash::father::consolidation_pr'),
                       CreateSuperFile('~thor::base::ecrash::grandfather::consolidation_pr'),
                       CreateSuperFile('~thor::base::ecrash::delete::consolidation_pr')
											  );

  CreateSFKeys := SEQUENTIAL(			
                       CreateSuperFile('~thor_data400::key::ecrashv2_dlnnbrdlstate_qa'),											 
                       CreateSuperFile('~thor_data400::key::ecrashv2_dlnnbrdlstate_built'),											 
                       CreateSuperFile('~thor_data400::key::ecrashv2_dlnnbrdlstate_father'),						
	                     CreateSuperFile('~thor_data400::key::ecrashv2_dlnnbrdlstate_grandfather'),											 
                       CreateSuperFile('~thor_data400::key::ecrashv2_dlnnbrdlstate_delete'),
                       CreateSuperFile('~thor_data400::key::ecrashv2_licenseplatenbr_qa'),
                       CreateSuperFile('~thor_data400::key::ecrashv2_licenseplatenbr_built'),
                       CreateSuperFile('~thor_data400::key::ecrashv2_licenseplatenbr_father'),
                       CreateSuperFile('~thor_data400::key::ecrashv2_licenseplatenbr_grandfather'),
                       CreateSuperFile('~thor_data400::key::ecrashv2_licenseplatenbr_delete'),
											 CreateSuperFile('~thor_data400::key::ecrashv2_officerbadgenbr_qa'),
                       CreateSuperFile('~thor_data400::key::ecrashv2_officerbadgenbr_built'),
                       CreateSuperFile('~thor_data400::key::ecrashv2_officerbadgenbr_father'),
                       CreateSuperFile('~thor_data400::key::ecrashv2_officerbadgenbr_grandfather'),
                       CreateSuperFile('~thor_data400::key::ecrashv2_officerbadgenbr_delete'),
											 CreateSuperFile('~thor_data400::key::ecrashv2_vinnbr_qa'),
                       CreateSuperFile('~thor_data400::key::ecrashv2_vinnbr_built'),
                       CreateSuperFile('~thor_data400::key::ecrashv2_vinnbr_father'),
                       CreateSuperFile('~thor_data400::key::ecrashv2_vinnbr_grandfather'),
                       CreateSuperFile('~thor_data400::key::ecrashv2_vinnbr_delete'),
											 CreateSuperFile('~thor_data400::key::ecrashv2_Unrestricted_accnbrv1_qa'),
                       CreateSuperFile('~thor_data400::key::ecrashv2_Unrestricted_accnbrv1_built'),
                       CreateSuperFile('~thor_data400::key::ecrashv2_Unrestricted_accnbrv1_father'),
                       CreateSuperFile('~thor_data400::key::ecrashv2_Unrestricted_accnbrv1_grandfather'),
                       CreateSuperFile('~thor_data400::key::ecrashv2_Unrestricted_accnbrv1_delete')
                       );

  CreateSF := SEQUENTIAL (CreateSFBase, CreateSFKeys);
	
	EXPORT CreateSuperFiles := CreateSF;
	