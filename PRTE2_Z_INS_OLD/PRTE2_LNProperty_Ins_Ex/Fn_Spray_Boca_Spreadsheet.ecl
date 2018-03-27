﻿IMPORT ut, RoxieKeyBuild;
IMPORT PRTE2_Common as Common;

EXPORT Fn_Spray_Boca_Spreadsheet(STRING CSVName, STRING fileVersion, STRING overridePath='') := FUNCTION

			// --------------------------------------------------
			SourcePathForLNPCSV := IF(overridePath<>'',overridePath,Constants.SourcePathForLNPCSV);
			
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																								SourcePathForLNPCSV+CSVName, 			// path to file on landing zone
																								8192,																// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Cluster(),									// destination THOR cluster
																								Files.BOCA_SPRAY_NAME,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								FALSE												  			// do not compress
																								);																					 


			// --------------------------------------------------
			speadsheetIncoming := Files.BOCA_SPRAY_DS;
			RoxieKeyBuild.Mac_SF_BuildProcess_V2(speadsheetIncoming,
																					 Files.BASE_PREFIX_NAME, 
																					 Files.BOCA_BASE_PERM_SUFFIX,
																					 fileVersion, buildLNPBase, 3,
																					 false,true);
																						 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.BOCA_SPRAY_NAME);

			// --------------------------------------------------
			LNP_Boca_Base := Files.BOCA_BASE_SF_DS;
			ShowResults := CHOOSEN(LNP_Boca_Base, 400);	
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildLNPBase,
															delSprayedFile,
															OUTPUT(ShowResults)
															);

			RETURN sequentialSteps;

END;