
IMPORT PRTE2_PropertyInfo, ut, RoxieKeyBuild;
IMPORT PRTE2_Common as Common;

EXPORT Fn_Spray_Alpharetta_Spreadsheet(STRING CSVName, STRING fileVersion, STRING overridePath='') := FUNCTION

			// Everything in the fn_Spray process should happen in the CSV layout
			AlphaPropertyCSVRec := Layouts.AlphaPropertyCSVRec;

			// --------------------------------------------------
			SourcePathForPIICSV := IF(overridePath<>'',overridePath,Constants.SourcePathForPIICSV);
			
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																								SourcePathForPIICSV+CSVName, 			// path to file on landing zone
																								8192,																// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Cluster(),									// destination THOR cluster
																								Files.SCRAMBLE_SPRAY,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								FALSE												  			// do not compress
																								);																					 


			// --------------------------------------------------
			// just to be safe, transform and clean the base file.
			speadsheetIncoming := Files.SCRAMBLE_SPRAY_DS;
			speadsheetCleaned := PROJECT(speadsheetIncoming, Transforms.spreadsheet_clean(LEFT));
			RoxieKeyBuild.Mac_SF_BuildProcess_V2(speadsheetCleaned,
																					 Files.BASE_PREFIX_NAME, 
																					 Files.SCRAMBLE_NAME,
																					 fileVersion, buildPIIBase, 3,
																					 false,true);
																						 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.SCRAMBLE_SPRAY);

			// --------------------------------------------------
			PII_Scrambled := Files.PII_ALPHA_BASE_SF_DS;
			ShowResults := CHOOSEN(PII_Scrambled, 200);	
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildPIIBase,
															delSprayedFile,
															OUTPUT(ShowResults)
															);

			RETURN sequentialSteps;

END;