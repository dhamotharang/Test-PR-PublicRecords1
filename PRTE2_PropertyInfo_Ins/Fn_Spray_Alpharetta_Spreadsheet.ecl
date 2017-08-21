
IMPORT PRTE2_PropertyInfo_Ins, ut, RoxieKeyBuild;
IMPORT PRTE2_Common as Common;

EXPORT Fn_Spray_Alpharetta_Spreadsheet(STRING CSVName, STRING fileVersion, STRING overridePath='') := FUNCTION

			// Everything in the fn_Spray process should happen in the CSV layout (AlphaPropertyCSVRec)

			// --------------------------------------------------
			SourcePathForPIICSV := IF(overridePath<>'',overridePath,Constants.SourcePathForPIICSV);
			
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																								SourcePathForPIICSV+CSVName, 			// path to file on landing zone
																								8192,																// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Cluster(),									// destination THOR cluster
																								Files.Alpha_Spray_Name,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								FALSE												  			// do not compress
																								);																					 


			// --------------------------------------------------
			// just to be safe, transform and clean the base file.
			speadsheetIncoming := Files.Alpha_Spray_DS;
			speadsheetCleaned := PROJECT(speadsheetIncoming, Transforms.spreadsheet_clean(LEFT));
			RoxieKeyBuild.Mac_SF_BuildProcess_V2(speadsheetCleaned,
																					 Files.BASE_PREFIX_NAME, 
																					 Files.ALPHA_Base_Name,
																					 fileVersion, buildPIIBase, 3,
																					 false,true);
																						 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.Alpha_Spray_Name);

			// --------------------------------------------------
			PII_BaseBuilt := Files.PII_ALPHA_BASE_SF_DS;
			ShowResults := CHOOSEN(PII_BaseBuilt, 200);	
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildPIIBase,
															delSprayedFile,
															OUTPUT(ShowResults),
															// OUTPUT(COUNT(speadsheetCleaned(roof_type<>''))),
															// OUTPUT(COUNT(PII_Scrambled(roof_type<>'')))
															);

			RETURN sequentialSteps;

END;