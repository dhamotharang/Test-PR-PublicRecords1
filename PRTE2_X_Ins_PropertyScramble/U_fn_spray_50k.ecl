﻿
IMPORT PRTE2_X_Ins_PropertyScramble, ut, RoxieKeyBuild;
IMPORT PRTE2_Common as Common;

EXPORT U_fn_spray_50k (STRING CSVName, STRING fileVersion, STRING overridePath='') := FUNCTION

			// --------------------------------------------------
			SourcePathForXRefCSV := IF(overridePath<>'',overridePath,PRTE2_X_Ins_PropertyScramble.Constants.SourcePathForXRefCSV);
			
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																								SourcePathForXRefCSV+CSVName, 			// path to file on landing zone
																								8192,																// maximum record size
																								PRTE2_X_Ins_PropertyScramble.Constants.CSVSprayFieldSeparator,		// field separator(s)
																								PRTE2_X_Ins_PropertyScramble.Constants.CSVSprayLineSeparator,		// line separator(s)
																								PRTE2_X_Ins_PropertyScramble.Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Cluster(),									// destination THOR cluster
																								PRTE2_X_Ins_PropertyScramble.Files.SPRAY_50_Name,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								TRUE												  			// do compress
																								);																					 


			// --------------------------------------------------
			speadsheetIncoming := PRTE2_X_Ins_PropertyScramble.Files.SPRAY_50_DS;
			buildHDRBase := output(speadsheetIncoming, , PRTE2_X_Ins_PropertyScramble.Files.BASE_50k_Name, overwrite);
																						 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.SPRAY_50_Name);

			// --------------------------------------------------
			HDR_50_Base := PRTE2_X_Ins_PropertyScramble.Files.BASE_50k_DS;
			ShowResults := CHOOSEN(HDR_50_Base, 400);	
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildHDRBase,
															delSprayedFile,
															OUTPUT(ShowResults)
															);

			RETURN sequentialSteps;

END;