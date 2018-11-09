/********************************************************************************************************** 
	Name: 			fspray_And_Build_Base
	Created On: 07/20/2013
	By: 				ssivasubramanian
	Desc: 			This does the following:
							1. Spray the base file from the landing zone
							2. Over write the last sprayed file (while keeping old copies)
							3. Expand the file to the full layout by applying default values
							4. Overwrite the last expanded file with the latest (while keeping old copies)
							5. Delete the sprayed file (since a copy is already maintained now - Step 2)
***********************************************************************************************************/

IMPORT RoxieKeyBuild, promotesupers, ut, PRTE2_Common, Address, STD;

EXPORT fspray_And_Build_Base(STRING lzFilePath, STRING fileVersion) := FUNCTION
	// spray file from landing zone
	sprayFile 									:= FileServices.SprayVariable(Constants.LandingZoneIP,		 									// file landing zone
																												lzFilePath,																	// path to file on landing zone
																												8192,																				// maximum record size
																												Constants.CSVSprayFieldSeparator,	// field separator(s)
																												Constants.CSVSprayLineSeparator,		// line separator(s)
																												Constants.CSVSprayQuote,						// text quote character
																												ThorLib.Group(),													// destination THOR cluster
																												Files.SubFile.Input_All_Slim,							// destination file
																												-1,												  								// -1 means no timeout
																													,													 		 						// use default ESP server IP port
																													,																					// use default maximum connections
																												TRUE,												 								// allow overwrite
																												TRUE,												  							// replicate
																												FALSE												  							// do not compress
																												);

	
	All_Slim_SubFile_Upper := PRTE2_Common.mac_ConvertToUpperCase(	Datasets.All_Slim_SubFile , fname, mname, lname);
	
	PickOne(STRING s1, STRING s2) := IF(TRIM(s1,left,right)<>'',s1,s2);
	
	// Expand the slim dataset to include default columns doing MINIMAL changes during full build this is because data out there is so bad
   // later we may want more initializing in case addresses were modified, etc...
	AllSlimInitialized						:= PROJECT(All_Slim_SubFile_Upper, 
																					TRANSFORM(Layouts.BaseInput_Slim_Common, 
																										bestHullNumber 	:= PickOne(LEFT.hull_number_Main, LEFT.hull_number_cg);
																										bestSourceCode 	:= PickOne(LEFT.source_code_Main, LEFT.source_code_CG);
																										SELF.Watercraft_key	:= IF(LEFT.Watercraft_key <> '', LEFT.Watercraft_key, bestHullNumber) ;
																										SELF.sequence_key	:= IF(LEFT.sequence_key <> '', LEFT.sequence_key, LEFT.date_vendor_last_reported) ;
																										SELF.source_code_CG := IF(LEFT.source_code_CG <> '', LEFT.source_code_CG, bestSourceCode) ;
																										SELF 								:= LEFT; 
																										SELF 								:= [];));
	
	// ***********************************************************************************************
	// *** before we save the Boca expanded layout, save the slim (Nancy's spreadsheet) version ******
	// ***********************************************************************************************
	
	// ******************************************************************************************
	// *** saving the slim (Nancy's spreadsheet) version of the data ****************************
	PromoteSupers.Mac_SF_BuildProcess(AllSlimInitialized, Files.SuperFile.Internal_All_Slim_Name, build_internal_base,,,TRUE);

	//TODO stop building the secondary slim once I know it's not needed.
	// associate to superfile (and move older files into older generation superfiles)
	RoxieKeyBuild.Mac_SF_BuildProcess_V2(AllSlimInitialized,
																			 Files.Input_Prefix, 
																		   Files.AllData_Slim_Suffix, 
																			 fileVersion, buildBaseFileSlim, 3);
																			 
	// ******************************************************************************************
	// ******************************************************************************************
	// ******************************************************************************************
	AllDataExpanded							:= PROJECT(AllSlimInitialized, 
																					TRANSFORM(Layouts.Base, 
																										SELF.persistent_record_id := COUNTER;
																										bestHullNumber 	:= PickOne(LEFT.hull_number_main, LEFT.hull_number_cg);
																										bestSourceCode 	:= PickOne(LEFT.source_code_Main, LEFT.source_code_CG);
																										bestHistoryFlag 	:= PickOne(LEFT.history_flag_Main, LEFT.history_flag_Search);
																										SELF.Source_code  	:= bestSourceCode; 
																										SELF.history_flag 	:= bestHistoryFlag;
																										SELF.Hull_number  	:= bestHullNumber;
																										SELF 										:= LEFT; 
																										SELF 										:= [];));

	
	// associate expanded file to superfile (and move older files into older generation superfiles)
	RoxieKeyBuild.Mac_SF_BuildProcess_V2(AllDataExpanded,
																			 Files.Base_Prefix, 
																		   Files.AllData_Suffix, 
																			 fileVersion, buildBaseFile, 3);
	
	// delete sprayed file
	deleteSpray 						:= FileServices.DeleteLogicalFile(Files.SubFile.Input_All_Slim);
		
	sequentialSteps 				:= SEQUENTIAL(sprayFile,
																				buildBaseFileSlim,
																				build_internal_base,
																				buildBaseFile,
																				deleteSpray);
	
	RETURN sequentialSteps;
	
END;