AgencyBase :=  PROJECT(Files.Base.AgencyCmbd, TRANSFORM(Layout_Keys_eCrash.Agency, SELF := LEFT; SELF := [];));

EXPORT key_EcrashV2_agency := INDEX(AgencyBase,
																	  {Agency_State_Abbr, Agency_Name, Agency_Ori},
																		{AgencyBase},
																		Files_eCrash.FILE_KEY_AGENCY_SF);		
																		
