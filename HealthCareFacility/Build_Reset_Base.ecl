IMPORT ut, HealthCareProvider;
#OPTION('multiplePersistInstances',FALSE);
EXPORT Build_Reset_Base (STRING fileVersion = thorlib.wuid()) := FUNCTION 
	#WORKUNIT ('NAME','Health Care Facility - Reset Salt Input');
	OverGrouped_LNPID_Ds := DATASET ('~thor::healthcarefacilityheader::overlink::lnpid',{UNSIGNED8 LNPID},THOR); //DATASET ([],{UNSIGNED8 LNPID});

	hdrResetData	:=	HealthCareProvider.UpdateDidtoRid (OverGrouped_LNPID_Ds, HealthCareFacility.Files.Facility_Salt_Input_DS);

	HealthCareProvider.Mac_SF_BuildProcess(hdrResetData,
																					HealthCareFacility.Files.HealthCare_Prefix, 
																					HealthCareFacility.Files.Facility_In_Suffix, 
																				 fileVersion, FacilityBase, 3, ,true, false);

	RETURN sequential (FacilityBase);
End;

