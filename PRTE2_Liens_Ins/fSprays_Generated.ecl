/* *********************************************************************************************
	PRTE2_Liens_Ins.fSprays_Generated
NOTE: Linda handed over tab separated files.
********************************************************************************************* */

IMPORT PRTE2_Liens_Ins,LiensV2, PromoteSupers, PRTE2_Common, Address;

EXPORT fSprays_Generated := MODULE


	//***************************************************************************************************************************
	// PRTE2_Liens_Ins.fSprays.fSpray_Main()
	EXPORT fSpray_Main (STRING CSVName) := FUNCTION

			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																								Constants.SourcePathForCSV+CSVName, 			// path to file on landing zone
																								8192,																// maximum record size
																								'\t',		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Group(),									// destination THOR cluster
																								Files.TmpGeneratedMAIN_Name,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								PRTE2_Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								TRUE												  			// compress
																								);																					 

			RETURN SEQUENTIAL( sprayFile );
			
	END;

	//***************************************************************************************************************************

	EXPORT fSpray_Party(STRING CSVName)  := FUNCTION

			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																								Constants.SourcePathForCSV+CSVName, 			// path to file on landing zone
																								8192,																// maximum record size
																								'\t',		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Group(),									// destination THOR cluster
																								Files.TmpGeneratedPARTY_Name,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								PRTE2_Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								TRUE												  			// compress
																								);																					 

			RETURN SEQUENTIAL( sprayFile );
	END;
	//***************************************************************************************************************************


END;