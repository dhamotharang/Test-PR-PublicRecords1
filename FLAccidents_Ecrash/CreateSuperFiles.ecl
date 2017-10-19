IMPORT STD;
fileservices := STD.File;

CreateSuperFile(STRING File) := IF (~FileServices.FileExists(File), FileServices.CreateSuperFile(File));

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
                       CreateSuperFile('~thor_data400::key::ecrashv2_vinnbr_delete')
                       );

  CreateSF := SEQUENTIAL (CreateSFKeys);
	
	EXPORT CreateSuperFiles := CreateSF;
	