IMPORT ut, RoxieKeyBuild, PRTE2_FAA_Data;
IMPORT PRTE2_Common as Common;
Constants := PRTE2_FAA_Data.Constants;
Files := PRTE2_FAA_Data.Files;

EXPORT Fn_Spray_And_Build_BaseMain(STRING CSVName, STRING fileVersion, STRING fileSpray, STRING overridePath='') := FUNCTION

			// --------------------------------------------------
			SourcePathForCSV := IF(overridePath<>'',overridePath,Constants.SourcePathForCSV);
			
			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					  // file LZ
																								SourcePathForCSV+CSVName, 		  	  // path to file on landing zone
																								Constants.CSVMaxCount,							// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Cluster(),									// destination THOR cluster
																								Files.FILE_SPRAY(fileSpray),
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								FALSE												  			// do not compress
																								);																					 


			// --------------------------------------------------
			// If you need to TRANSFORM Spreadsheet ... see how this worked in PRTE2_PropertyInfo.Fn_Spray_Scrambled_Spreadsheet
			// speadsheetIncoming := Files.SPRAYED_DS;
			// newBase := PROJECT( speadsheetIncoming ,Transforms.Spreadsheet_Expand(LEFT));
			
			// otherwise it is simple


			// This macro is what builds the super files with generations: QA, Father, Grandfater
		  RoxieKeyBuild.Mac_SF_BuildProcess_V2(Files.SPRAY_aircraft_reg_DS,
																				   Files.BASE_PREFIX_NAME, 
																				   Files.aircraft_reg_Name,
																				   fileVersion, buildAircraft_reg, 3,
																				   false,true);
	
		  RoxieKeyBuild.Mac_SF_BuildProcess_V2(Files.SPRAY_airmen_DS,
																				   Files.BASE_PREFIX_NAME, 
																				   Files.airmen_Name,
																				   fileVersion, buildAirmen, 3,
																				   false,true);

		  RoxieKeyBuild.Mac_SF_BuildProcess_V2(Files.SPRAY_airmen_certs_DS,
																				   Files.BASE_PREFIX_NAME, 
																				   Files.airmen_certs_Name,
																				   fileVersion, buildAirmen_Certs, 3,
																				   false,true);
																						 
			// --------------------------------------------------
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.FILE_SPRAY(fileSpray)); //Files.FILE_SPRAY


			sequentialSteps	:= SEQUENTIAL (sprayFile,
															       IF(fileSpray = 'aircraft_reg', buildAircraft_reg, IF(fileSpray = 'airmen', buildAirmen, buildAirmen_Certs)),
															       delSprayedFile);

			RETURN sequentialSteps;

END;
