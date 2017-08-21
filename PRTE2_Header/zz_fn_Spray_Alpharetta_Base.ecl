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
			speadsheetIncoming := Files.SPRAYED_DS;
			RoxieKeyBuild.Mac_SF_BuildProcess_V2(speadsheetIncoming,
																					 Files.Base_Prefix, 
																					 Files.Base_Name,
																					 fileVersion, buildHDRBase, 3,
																					 false,true);
																						 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.FILE_SPRAY_NAME);

			// --------------------------------------------------
			HDR_Alpha_Base := Files.HDR_BASE_ALPHA_DS;
			ShowResults := CHOOSEN(HDR_Alpha_Base, 400);	
			// --------------------------------------------------
			relationFile := fn_generate_relation_base();		// this depends on the Files.HDR_BASE_ALPHA_DS being completed
			RoxieKeyBuild.Mac_SF_BuildProcess_V2(relationFile,
																		 Files.Base_Prefix, 
																		 Files.Relationship_Suffix,
																		 fileVersion, buildHDRRelatives, 3,
																		 false,true);

			// --------------------------------------------------

			sequentialSteps	:= SEQUENTIAL (
															sprayFile,
															buildHDRBase,
															buildHDRRelatives,	// must happen after buildHDRBase
															delSprayedFile,
															OUTPUT(ShowResults)
															);

			RETURN sequentialSteps;

END;