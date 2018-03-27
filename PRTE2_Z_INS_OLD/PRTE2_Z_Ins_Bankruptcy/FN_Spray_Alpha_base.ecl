//--------------------------------------------------------------------
// PRTE2_Bankruptcy.FN_Spray_Alpha_base
// Project on hold.
// CT Bankruptcy are done as part of Alpharetta based simulator CompReport
//--------------------------------------------------------------------

IMPORT ut, RoxieKeyBuild, PRTE2_Bankruptcy;
IMPORT PRTE2_Common as Common;

EXPORT FN_Spray_Alpha_base := MODULE
	//------- SPRAY status.csv ----------------------------------------------------------------------------------------------------------
	EXPORT status(	string CSVName, string fileVersion, string overridePath='') := FUNCTION
		SourcePathForCSV := IF(overridePath<>'',overridePath,Constants.SourcePathForCSV);
		VAR_FILE_SPRAY := Files.FILE_SPRAY_status;
		newBase := Files.status_DS;
		SF_NAME := 'status';
		sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																									SourcePathForCSV+CSVName, 			// path to file on landing zone
																									8192,																// maximum record size
																									Constants.CSVSprayFieldSeparator,		// field separator(s)
																									Constants.CSVSprayLineSeparator,		// line separator(s)
																									Constants.CSVSprayQuote,						// text quote character
																									ThorLib.Cluster(),									// destination THOR cluster
																									VAR_FILE_SPRAY,
																									-1,												  				// -1 means no timeout
																										,													  			// use default ESP server IP port
																										,														 	 		// use default maximum connections
																									TRUE,												 		 		// allow overwrite
																									Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																									FALSE												  			// do not compress
																									);																					 

		// This macro is what builds the super files with generations: QA, Father, Grandfater
		RoxieKeyBuild.Mac_SF_BuildProcess_V2(newBase,
																					Files.BASE_PREFIX_NAME, 
																					SF_NAME,
																					fileVersion, buildBase, 3,
																					false,true);
																							 
		delSprayedFile  := FileServices.DeleteLogicalFile (VAR_FILE_SPRAY);
		sequentialSteps	:= SEQUENTIAL (	sprayFile, buildBase,	delSprayedFile );
		RETURN sequentialSteps;
	END;
	//-------- SPRAY comments.csv---------------------------------------------------------------------------------------------------------
	EXPORT comments(	string CSVName, string fileVersion, string overridePath='') := FUNCTION
		SourcePathForCSV := IF(overridePath<>'',overridePath,Constants.SourcePathForCSV);
		VAR_FILE_SPRAY := Files.FILE_SPRAY_comments;
		newBase := Files.comments_DS;
		SF_NAME := 'comments';
		sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																									SourcePathForCSV+CSVName, 			// path to file on landing zone
																									8192,																// maximum record size
																									Constants.CSVSprayFieldSeparator,		// field separator(s)
																									Constants.CSVSprayLineSeparator,		// line separator(s)
																									Constants.CSVSprayQuote,						// text quote character
																									ThorLib.Cluster(),									// destination THOR cluster
																									VAR_FILE_SPRAY,
																									-1,												  				// -1 means no timeout
																										,													  			// use default ESP server IP port
																										,														 	 		// use default maximum connections
																									TRUE,												 		 		// allow overwrite
																									Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																									FALSE												  			// do not compress
																									);																					 

		// This macro is what builds the super files with generations: QA, Father, Grandfater
		RoxieKeyBuild.Mac_SF_BuildProcess_V2(newBase,
																					Files.BASE_PREFIX_NAME, 
																					SF_NAME,
																					fileVersion, buildBase, 3,
																					false,true);
																							 
		delSprayedFile  := FileServices.DeleteLogicalFile (VAR_FILE_SPRAY);
		sequentialSteps	:= SEQUENTIAL (	sprayFile, buildBase,	delSprayedFile );
		RETURN sequentialSteps;
	END;
	//-------- SPRAY main.csv---------------------------------------------------------------------------------------------------------
	EXPORT main(	string CSVName, string fileVersion, string overridePath='') := FUNCTION
		SourcePathForCSV := IF(overridePath<>'',overridePath,Constants.SourcePathForCSV);
		VAR_FILE_SPRAY := Files.FILE_SPRAY_main;
		newBase := Files.main_DS;
		SF_NAME := 'main';
		sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																									SourcePathForCSV+CSVName, 			// path to file on landing zone
																									8192,																// maximum record size
																									Constants.CSVSprayFieldSeparator,		// field separator(s)
																									Constants.CSVSprayLineSeparator,		// line separator(s)
																									Constants.CSVSprayQuote,						// text quote character
																									ThorLib.Cluster(),									// destination THOR cluster
																									VAR_FILE_SPRAY,
																									-1,												  				// -1 means no timeout
																										,													  			// use default ESP server IP port
																										,														 	 		// use default maximum connections
																									TRUE,												 		 		// allow overwrite
																									Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																									FALSE												  			// do not compress
																									);																					 

		// This macro is what builds the super files with generations: QA, Father, Grandfater
		RoxieKeyBuild.Mac_SF_BuildProcess_V2(newBase,
																					Files.BASE_PREFIX_NAME, 
																					SF_NAME,
																					fileVersion, buildBase, 3,
																					false,true);
																							 
		delSprayedFile  := FileServices.DeleteLogicalFile (VAR_FILE_SPRAY);
		sequentialSteps	:= SEQUENTIAL (	sprayFile, buildBase,	delSprayedFile );
		RETURN sequentialSteps;
	END;
	//-------- SPRAY search.csv---------------------------------------------------------------------------------------------------------
	EXPORT search(	string CSVName, string fileVersion, string overridePath='') := FUNCTION
		SourcePathForCSV := IF(overridePath<>'',overridePath,Constants.SourcePathForCSV);
		VAR_FILE_SPRAY := Files.FILE_SPRAY_search;
		newBase := Files.search_DS;
		SF_NAME := 'search';
		sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																									SourcePathForCSV+CSVName, 			// path to file on landing zone
																									8192,																// maximum record size
																									Constants.CSVSprayFieldSeparator,		// field separator(s)
																									Constants.CSVSprayLineSeparator,		// line separator(s)
																									Constants.CSVSprayQuote,						// text quote character
																									ThorLib.Cluster(),									// destination THOR cluster
																									VAR_FILE_SPRAY,
																									-1,												  				// -1 means no timeout
																										,													  			// use default ESP server IP port
																										,														 	 		// use default maximum connections
																									TRUE,												 		 		// allow overwrite
																									Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																									FALSE												  			// do not compress
																									);																					 

		// This macro is what builds the super files with generations: QA, Father, Grandfater
		RoxieKeyBuild.Mac_SF_BuildProcess_V2(newBase,
																					Files.BASE_PREFIX_NAME, 
																					SF_NAME,
																					fileVersion, buildBase, 3,
																					false,true);
																							 
		delSprayedFile  := FileServices.DeleteLogicalFile (VAR_FILE_SPRAY);
		sequentialSteps	:= SEQUENTIAL (	sprayFile, buildBase,	delSprayedFile );
		RETURN sequentialSteps;
	END;
	//-----------------------------------------------------------------------------------------------------------------
END;