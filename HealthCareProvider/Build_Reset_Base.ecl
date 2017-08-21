IMPORT ut;
#OPTION('multiplePersistInstances',FALSE);
EXPORT Build_Reset_Base (STRING fileVersion = thorlib.wuid()) := FUNCTION 
	#WORKUNIT ('NAME','Health Care Provider - Reset Salt Input');
	OverGrouped_LNPID_Ds := DATASET ('~thor::healthcareproviderheader::overlink::lnpid',{UNSIGNED8 LNPID},THOR); //DATASET ([],{UNSIGNED8 LNPID});

	hdrResetData	:=	HealthCareProvider.UpdateDidtoRid (OverGrouped_LNPID_Ds);

	HealthCareProvider.Mac_SF_BuildProcess(hdrResetData,
																				 HealthCareProvider.Files.HealthCare_Prefix, 
																				 HealthCareProvider.Files.person_in_Suffix, 
																				 fileVersion, PersonBase, 3, ,true, false);

	RETURN sequential (PersonBase);
End;

