// NOT NEEDED IN PROD: Preliminary steps done in DEV prior to creating base file

IMPORT ut, PRTE2, PRTE2_Foreclosure, RoxieKeyBuild;
IMPORT PRTE2_Common as Common;

EXPORT U_Fn_Spray_Gateway(STRING CSVName, STRING fileVersion, STRING overridePath='') := FUNCTION

			// --------------------------------------------------
			SourcePathForFRCLCSV := IF(overridePath<>'',overridePath,Constants.SourcePathForFRCLCSV);
			
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,							 // file LZ
																								SourcePathForFRCLCSV+CSVName, // path to file on landing zone
																								8192,																// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Cluster(),									// destination THOR cluster
																								Files.FILE_SPRAY,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								FALSE												  			// do not compress
																								);																					 


			// --------------------------------------------------
			newPropertyFRCL := Files.SPRAYED_DS;

			RoxieKeyBuild.Mac_SF_BuildProcess_V2(newPropertyFRCL,
																					 Files.BASE_PREFIX_NAME, 
																					 Files.GATEWAY_NAME,
																					 fileVersion, buildFRCLBase, 3,
																					 false,true);
																						 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.FILE_SPRAY);

			// --------------------------------------------------
			FRCL_Gateway := Files.FRCL_Gateway_Base_SF_DS;
			ShowResults := CHOOSEN(FRCL_Gateway, 200);	
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildFRCLBase,
															delSprayedFile,
															OUTPUT(ShowResults)
															);

			RETURN sequentialSteps;

END;