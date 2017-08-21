IMPORT ut, HealthCareProvider;
#OPTION('multiplePersistInstances',FALSE);
EXPORT Build_Base (STRING fileVersion = thorlib.wuid()) := FUNCTION 
	#WORKUNIT ('NAME','Health Care Facility - Build Salt Input');
	ds := HealthCareFacility.Files.facility_Salt_Output_DS; //DATASET ([],HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header);
	// ds := DATASET ([],HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header);

	hdrData	:=	Add_Update_FacilityData (DS, fileVersion);

	patchRID	:=	HealthCareProvider.updateRID (hdrData);
	
	HealthCareProvider.Mac_SF_BuildProcess(patchRID,
																				 HealthCareFacility.Files.HealthCare_Prefix, 
																				 HealthCareFacility.Files.Facility_in_Suffix, 
																				 fileVersion, FacilityBase, 3, ,true, false);

	// RETURN patchRID;
	RETURN IF (FileServices.GetSuperFileSubCount(HealthCareFacility.Files.Facility_in_SF) > 0,OUTPUT('Header Input File Exist, Please Verify if the prior iteration finished'),sequential (FacilityBase));
End;

