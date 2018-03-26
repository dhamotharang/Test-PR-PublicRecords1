// PRTE2_LNProperty.U_Fn_Spray_Gateway Preliminary steps done in DEV prior to creating base file, not needed in PROD code

IMPORT PRTE2_LNProperty, ut, RoxieKeyBuild;
IMPORT PRTE2_Common as Common;

EXPORT U_Fn_Spray_Gateway(STRING CSVName, STRING fileVersion, STRING overridePath='') := FUNCTION
// 'PChar_batchGateway_20131023_Append.csv'
			// --------------------------------------------------
			SourcePathForLNPCSV := IF(overridePath<>'',overridePath,Constants.SourcePathForLNPCSV);
			
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,				// file LZ
																								SourcePathForLNPCSV+CSVName, 		// path to file on landing zone
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
																								Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								FALSE												  			// do not compress
																								);																					 


			// --------------------------------------------------
			newPropertyLNP := Files.ALP_SPRAY_DS;

			RoxieKeyBuild.Mac_SF_BuildProcess_V2(newPropertyLNP,
																					 Files.BASE_PREFIX_NAME, 
																					 Files.GATEWAY_NAME,
																					 fileVersion, buildLNPBase, 3,
																					 false,true);
																						 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.FILE_SPRAY);

			// --------------------------------------------------
			LNP_Gateway := Files.LNP_Gateway_Base_SF_DS;
			ShowResults := CHOOSEN(LNP_Gateway, 200);	
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildLNPBase,
															delSprayedFile,
															OUTPUT(ShowResults)
															);

			RETURN sequentialSteps;

END;