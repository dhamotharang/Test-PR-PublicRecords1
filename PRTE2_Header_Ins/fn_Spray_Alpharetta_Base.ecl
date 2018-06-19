/* ********************************************************************************************
PRTE2_Header_Ins.fn_Spray_Alpharetta_Base
MUST SWITCH TO THE NEW BOCA BUSINESS CASE BUILD PROCESSES - FOR NOW MUST KEEP THE SAME FILE NAMES
NOTE: We only need file info here for 
a) Spray/DeSpray and the data preparation we used to do during the build before the append.
b) Our Base file and 
c) any research/maintenance
************************************************************************************ */
IMPORT ut, RoxieKeyBuild;
IMPORT PRTE2_Common as Common;

EXPORT fn_Spray_Alpharetta_Base(STRING CSVName, STRING fileVersion, STRING overridePath='') := FUNCTION

			// --------------------------------------------------
			SourcePathForHDRCSV := IF(overridePath<>'',overridePath,Constants.SourcePathForHDRCSV);
			
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																								SourcePathForHDRCSV+CSVName, 			// path to file on landing zone
																								8192,																// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.GROUP(),									// destination THOR cluster
																								Files.FILE_SPRAY_NAME,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								FALSE												  			// do not compress
																								);																					 


			// --------------------------------------------------
			speadsheetIncoming := Files.SPRAYED_DS;
			
			speadsheetIncomingUpper := Common.mac_ConvertToUpperCase(speadsheetIncoming , fname, mname, lname);
			
			buildSteps := fn_Save_BaseAndRels_Alpharetta_Base(speadsheetIncomingUpper, fileVersion);
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.FILE_SPRAY_NAME);
			ShowResults := CHOOSEN(Files.HDR_BASE_ALPHA_DS, 400);	
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildSteps,
															delSprayedFile,
															OUTPUT(ShowResults)
															);

			RETURN sequentialSteps;

END;