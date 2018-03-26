
IMPORT ut, RoxieKeyBuild, PRTE2_Common;

EXPORT Fn_Spray_Alpha_Spreadsheet(STRING CSVName, STRING fileVersion, STRING overridePath='') := FUNCTION

			// --------------------------------------------------
			SourcePathForLNPCSV := IF(overridePath<>'',overridePath,Constants.SourcePathForLNPCSV);
			
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																								SourcePathForLNPCSV+CSVName, 			// path to file on landing zone
																								8192,																// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Cluster(),									// destination THOR cluster
																								Files.FILE_SPRAY_NAME,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								PRTE2_Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								FALSE												  			// do not compress
																								);																					 

			// --------------------------------------------------
			newPropertyLNP := Files.ALP_SPRAY_DS;
			//***********************************************************************************************
			Alp_LNP_Data := PROJECT(newPropertyLNP, Transforms.spreadsheet_clean(LEFT));
		
			RoxieKeyBuild.Mac_SF_BuildProcess_V2(Alp_LNP_Data,
																					 Files.BASE_PREFIX_NAME, 
																					 Files.ALP_BASE_NAME,
																					 fileVersion, buildLNPBase, 3,
																					 false,true);
																						 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.FILE_SPRAY_NAME);

			// --------------------------------------------------
			LNP_Scrambled := Files.ALP_LNP_SF_DS;
			ShowResults := CHOOSEN(LNP_Scrambled, 200);	
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildLNPBase,
															delSprayedFile,
															OUTPUT(ShowResults)
															);

			RETURN sequentialSteps;

END;