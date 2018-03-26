
IMPORT PRTE2_LNProperty as LNP;
IMPORT ut, RoxieKeyBuild;
IMPORT PRTE2_Common as Common;

EXPORT Fn_Spray_Scrambled_Spreadsheet(STRING CSVName, STRING fileVersion, STRING overridePath='') := FUNCTION

			// --------------------------------------------------
			SourcePathForLNPCSV := IF(overridePath<>'',overridePath,LNP.Constants.SourcePathForLNPCSV);
			
			sprayFile    := FileServices.SprayVariable(LNP.Constants.LandingZoneIP,					// file LZ
																								SourcePathForLNPCSV+CSVName, 			// path to file on landing zone
																								8192,																// maximum record size
																								LNP.Constants.CSVSprayFieldSeparator,		// field separator(s)
																								LNP.Constants.CSVSprayLineSeparator,		// line separator(s)
																								LNP.Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Cluster(),									// destination THOR cluster
																								LNP.Files.SCRAMBLE_SPRAY,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								FALSE												  			// do not compress
																								);																					 


			// --------------------------------------------------
			speadsheetIncoming := LNP.Files.SCRAMBLE_SPRAY_DS;
			newPropertyLNP := PROJECT( speadsheetIncoming ,LNP.Constants.Spreadsheet_Expand(LEFT));

			RoxieKeyBuild.Mac_SF_BuildProcess_V2(newPropertyLNP,
																					 LNP.Files.BASE_PREFIX_NAME, 
																					 LNP.Files.SCRAMBLE_NAME,
																					 fileVersion, buildLNPBase, 3,
																					 false,true);
																						 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (LNP.Files.SCRAMBLE_SPRAY);

			// --------------------------------------------------
			LNP_Scrambled := LNP.Files.LNP_Scramble_SF_DS;
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