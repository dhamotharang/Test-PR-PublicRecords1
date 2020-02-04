// Preliminary steps done in DEV prior to creating base file, not needed in PROD code
// The gateway is preliminary production data that we then scramble producing the final CT data.

IMPORT PRTE2_PropertyInfo, ut, RoxieKeyBuild;
IMPORT PRTE2_Common as Common;

EXPORT U_Fn_Spray_Gateway(STRING CSVName, STRING fileVersion, STRING overridePath='') := FUNCTION
			// --------------------------------------------------
			SourcePathForPIICSV := IF(overridePath<>'',overridePath,Constants.SourcePathForPIICSV);
			
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,							 // file LZ
																								SourcePathForPIICSV+CSVName, // path to file on landing zone
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
			newPropertyPII := Files.SPRAYED_DS;

			RoxieKeyBuild.Mac_SF_BuildProcess_V2(newPropertyPII,
																					 Files.BASE_PREFIX_NAME, 
																					 Files.GATEWAY_NAME,
																					 fileVersion, buildPIIBase, 3,
																					 false,true);
																						 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.FILE_SPRAY);

			// --------------------------------------------------
			PII_Gateway := Files.PII_Gateway_Base_SF_DS;
			ShowResults := CHOOSEN(PII_Gateway, 200);	
			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildPIIBase,
															delSprayedFile,
															OUTPUT(ShowResults)
															);

			RETURN sequentialSteps;

END;