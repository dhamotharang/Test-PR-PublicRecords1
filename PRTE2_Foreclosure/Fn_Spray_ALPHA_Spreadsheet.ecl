IMPORT PRTE2_Common as Common;
IMPORT PRTE2, PRTE2_Foreclosure, ut, RoxieKeyBuild;

EXPORT Fn_Spray_ALPHA_Spreadsheet(STRING CSVName, STRING fileVersion, STRING overridePath='') := FUNCTION
			// --------------------------------------------------------------------------------------			
			SourcePathForFRCLCSV := IF(overridePath<>'',overridePath,Constants.SourcePathForFRCLCSV);
			
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																								SourcePathForFRCLCSV+CSVName, 			// path to file on landing zone
																								8192,																// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Cluster(),									// destination THOR cluster
																								Files.Alpharetta_Spray_Name,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								FALSE												  			// do not compress
																								);																					 

			// --------------------------------------------------------------------------------------			
			speadsheetIncoming := Files.Alpharetta_Spray_DS;
			newPropertyFRCL := PROJECT( speadsheetIncoming ,Transforms.Spreadsheet_Expand(LEFT));

			RoxieKeyBuild.Mac_SF_BuildProcess_V2(newPropertyFRCL,
																					 Files.BASE_PREFIX_NAME, 
																					 Files.BASE_NAME_ALPHA,
																					 fileVersion, buildFRCLBase, 3,
																					 false,true);
																						 
			// --------------------------------------------------------------------------------------			
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.Alpharetta_Spray_Name);

			// --------------------------------------------------------------------------------------			
			FRCL_Scrambled := Files.Foreclosures_50k_Scrambled_SF_DS;
			ShowResults := CHOOSEN(FRCL_Scrambled, 300);	

			// --------------------------------------------------------------------------------------			
			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildFRCLBase,
															delSprayedFile,
															OUTPUT(ShowResults)
															);

			RETURN sequentialSteps;

END;