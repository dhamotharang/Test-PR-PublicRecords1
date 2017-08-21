import ut, RoxieKeyBuild;
EXPORT Build_Header (STRING fileDate = thorlib.wuid () [2..9] + thorlib.wuid () [11..16]) := FUNCTION

	RoxieKeyBuild.Mac_SF_BuildProcess_V2(HealthCareProvider.Files.Person_Salt_Output_DS,
																			 HealthCareProvider.Files.HealthCare_Prefix, 
																		   HealthCareProvider.Files.Header_Suffix, 
																			 fileDate, HeaderIn, 3);
	
	RETURN SEQUENTIAL (HeaderIn);
END;
