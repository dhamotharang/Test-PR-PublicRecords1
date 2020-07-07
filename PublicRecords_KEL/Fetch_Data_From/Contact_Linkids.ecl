IMPORT BIPV2_Build, BIPV2, doxie, PublicRecords_KEL;

EXPORT Contact_LinkIDs(DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC(PublicRecords_KEL.Interface_Options).Layout_FDC) shell, 
											INTEGER LinkidSearchLevel, 
											BIPV2.mod_sources.iParams LinkingOptions, 
											doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess)END,
											JoinLimit = PublicRecords_KEL.ECL_Functions.Constants.BUSINESS_HEADER_CONTACT_LIMIT
											) := FUNCTION


	contact_linkid_data := BIPV2_Build.key_contact_linkids.kfetch(PublicRecords_KEL.ECL_Functions.Common_Functions.GetLinkIDs(shell),
																								PublicRecords_KEL.ECL_Functions.Constants.SetLinkSearchLevel(LinkidSearchLevel),
																								0,
																								linkingOptions,
																								JoinLimit,					
																								FALSE,
																								mod_access); /*ScoreThreshold --> 0 = Give me everything*/	
																								
	RETURN contact_linkid_data;
END;																						