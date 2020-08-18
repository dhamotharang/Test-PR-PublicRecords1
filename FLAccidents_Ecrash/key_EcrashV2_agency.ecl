agency :=  PROJECT(Files.Base.AgencyCmbd, TRANSFORM(Layout_Keys_eCrash.Agency, SELF := LEFT;));

EXPORT key_EcrashV2_agency := INDEX(agency
																		,{Agency_State_Abbr,Agency_Name,Agency_ori}
																		,{agency}
																		,Files_eCrash.FILE_KEY_AGENCY_SF);		
																		
