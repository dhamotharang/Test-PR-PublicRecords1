/* *********************************************************************************************
	PRTE2_Liens_Ins.fSprays
********************************************************************************************* */

IMPORT PRTE2_Liens_Ins,LiensV2,PromoteSupers,PRTE2_Common;

EXPORT fSprays := MODULE


	//***************************************************************************************************************************
	// PRTE2_Liens_Ins.fSprays.fSpray_Main()
	EXPORT fSpray_Main (STRING CSVName) := FUNCTION

			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																								Constants.SourcePathForCSV+CSVName, 			// path to file on landing zone
																								8192,																// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Group(),									// destination THOR cluster
																								Files.main_TmpFile_Name,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								PRTE2_Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								TRUE												  			// compress
																								);																					 

			//**** Any preprocessing needed *****************************************************************
			//TODO - eventually we will need an "ADD" process to initialize the tnsid, rnsid, etc - must be init in the IN file to despray
			//  ??? How to sync tnsid, etc between new records in MAIN and PARTY ???????????????????
			// 6/12/17 - for now this may be handled by using IHDR records and these DEV processes
			// 			PRTE2_Liens_Ins_DataPrep.BWR_Gather_PROD_PartyMain_perState
			// 			PRTE2_Liens_Ins_DataPrep.BWR_Generate_1a_Spray_IHDR_Records
			// 			PRTE2_Liens_Ins_DataPrep.BWR_Generate_1b_Read_IHDR_Foreign
			// 			PRTE2_Liens_Ins_DataPrep.BWR_Generate_2_From_IHDR_Records
			//***********************************************************************************************
			newMainData0 := Files.main_TmpFile_DS;
			newMainData := PROJECT(newMainData0,TRANSFORM({newMainData0},SELF.bcbflag:=TRUE, SELF := LEFT));
			//***********************************************************************************************
			// newMainData := PROJECT(Files.main_TmpFile_DS,tBaseStatus(LEFT));
			//TODO - I think we need to intialize some fields in there too.
			// No let's leave the "IN" file in the raw layout, then do the TRANSFORM above before writing the final base file.
			// 		The IN file will be the pure CSV file, the BASE file then will be the Boca Compatible base file
			//    and BASE is prepared by second step after the spray PRTE2_Liens_Ins.proc_build_base
			//***********************************************************************************************
			
			// PRTE2_Common.Mac_SF_BuildProcess(newMainData, Files.Main_IN_Name, build_main_in,,TargetCluster);		// BUGGY
			PromoteSupers.Mac_SF_BuildProcess(newMainData, Files.Main_IN_Name, build_main_in);
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.main_TmpFile_Name);
			RETURN SEQUENTIAL( sprayFile, build_main_in, delSprayedFile );
			
	END;
	//***************************************************************************************************************************

	//***************************************************************************************************************************
	// PRTE2_Liens_Ins.fSprays.fSpray_Party()
	EXPORT fSpray_Party(STRING CSVName)  := FUNCTION

			sprayFile    := FileServices.SprayVariable(Constants.LandingZoneIP,					// file LZ
																								Constants.SourcePathForCSV+CSVName, 			// path to file on landing zone
																								8192,																// maximum record size
																								Constants.CSVSprayFieldSeparator,		// field separator(s)
																								Constants.CSVSprayLineSeparator,		// line separator(s)
																								Constants.CSVSprayQuote,						// text quote character
																								ThorLib.Group(),									// destination THOR cluster
																								Files.party_TmpFile_Name,
																								-1,												  				// -1 means no timeout
																									,													  			// use default ESP server IP port
																									,														 	 		// use default maximum connections
																								TRUE,												 		 		// allow overwrite
																								PRTE2_Common.Constants.SPRAY_REPLICATE,		// replicate if in PROD
																								TRUE												  			// compress
																								);																					 

			//**** Any preprocessing needed *****************************************************************
			//TODO - eventually we will need an "ADD" process to initialize the tnsid, rnsid, etc - must be init in the IN file to despray
			//  ??? How to sync tnsid, etc between new records in MAIN and PARTY ???????????????????
			//***********************************************************************************************
			newpartyData := PRTE2_Common.mac_ConvertToUpperCase(Files.party_TmpFile_DS , fname, mname, lname);
			//***********************************************************************************************
			PromoteSupers.Mac_SF_BuildProcess(newpartyData, Files.party_IN_Name, build_party_in);
			// party_In := Files.Party_IN_DS;
			// PromoteSupers.Mac_SF_BuildProcess(party_In, Files.Party_Name_SF, build_party_base);
			delSprayedFile  := FileServices.DeleteLogicalFile (Files.party_TmpFile_Name);
			RETURN SEQUENTIAL( sprayFile, build_party_in, delSprayedFile );
	END;
	//***************************************************************************************************************************

// Not needed?
	// EXPORT fSpray_Status() := FUNCTION
	// END;

END;