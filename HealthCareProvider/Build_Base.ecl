IMPORT ut;
#OPTION('multiplePersistInstances',FALSE);
EXPORT Build_Base (STRING fileVersion = thorlib.wuid()) := FUNCTION 
	#WORKUNIT ('NAME','Health Care Provider - Build Salt Input');
	// ds := HealthCareProvider.Files.Person_Salt_Output_DS; //DATASET ([],HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header);
	ds := HealthCareProvider.Files.Provider_Header_DS; //DATASET ([],HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header);

	hdrData	:=	Add_Update_ProviderData (DS, fileVersion);

	patchRID	:=	updateRID (hdrData);
	
	HealthCareProvider.Mac_SF_BuildProcess(patchRID,
																				 HealthCareProvider.Files.HealthCare_Prefix, 
																				 HealthCareProvider.Files.person_in_Suffix, 
																				 fileVersion, PersonBase, 3, ,true, false);

	// RETURN patchRID;
	RETURN IF (FileServices.GetSuperFileSubCount(HealthCareProvider.Files.Person_in_SF) > 0,OUTPUT('Header Input File Exist, Please Verify if the prior iteration finished'),sequential (PersonBase));
End;

