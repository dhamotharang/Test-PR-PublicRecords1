/********************************************************************************************************** 
	Name: 			fSpray_And_Append_New
	Created On: 07/20/2013
	By: 				ssivasubramanian
	Desc: 			This does the following:
							1. Spray the new file from the landing zone
							2. Over write the last sprayed file (while keeping old copies)
							3. Expand the file to the full layout by applying default values
							4. Append the new records to the existing full dataset
							5. Overwrite the last expanded full data file with the latest combined dataset (while keeping old copies)
							5. Delete the sprayed file (since a copy is already maintained now - Step 2)
***********************************************************************************************************/

IMPORT RoxieKeyBuild, ut;

EXPORT fSpray_And_Append_New(STRING lzFilePath, STRING fileVersion) := FUNCTION
	// spray file from landing zone
	sprayFile 									:= FileServices.SprayVariable(_LandingZoneConfig.IP,		 									// file landing zone
																														lzFilePath,																	// path to file on landing zone
																														8192,																				// maximum record size
																														_LandingZoneConfig.CSVSprayFieldSeparator,	// field separator(s)
																														_LandingZoneConfig.CSVSprayLineSeparator,		// line separator(s)
																														_LandingZoneConfig.CSVSprayQuote,						// text quote character
																														ThorLib.Cluster(),													// destination THOR cluster
																														_Files.SubFile.Input_New_Slim,							// destination file
																														-1,												  								// -1 means no timeout
																															,													 		 						// use default ESP server IP port
																															,																					// use default maximum connections
																														TRUE,												 								// allow overwrite
																														TRUE,												  							// replicate
																														FALSE												  							// do not compress
																														);
	
	
	
	
	// associate to superfile (and move older files into older generation superfiles)
	RoxieKeyBuild.Mac_SF_BuildProcess_V2(_Datasets.New_Slim_Subfile,
																			 _Files.Input_Prefix, 
																		   _Files.New_Slim_Suffix, 
																			 fileVersion, buildNewFileSlim, 3);
	
	// Expand the slim dataset to include default columns
	NewDataExpanded							:= PROJECT(_Datasets.New_Slim, 
																					TRANSFORM(PRTE2_Watercraft._Layouts.Base, 
																										SELF.Watercraft_key			:= LEFT.hull_number_Main;
																										SELF.sequence_key				:= LEFT.date_vendor_first_reported;
																										SELF.source_code_Main 	:= LEFT.source_code_Main;
																										SELF.source_code_CG   	:= LEFT.source_code_Main;
																										SELF.source_code_Search	:= LEFT.source_code_Main;
																										SELF.hull_number_Main		:= LEFT.hull_number_Main;
																										SELF.hull_number_CG			:= LEFT.hull_number_Main;
																										SELF.history_flag_Main	:= LEFT.history_flag_Main;
																										SELF.history_flag_Search:= LEFT.history_flag_Main;
																										SELF 										:= LEFT; 
																										SELF 										:= [];));
	
  
	// combine data into a single data set	
	AllDataExpanded							:= _Datasets.All + NewDataExpanded;
	
	// associate expanded file to superfile (and move older files into older generation superfiles)
	RoxieKeyBuild.Mac_SF_BuildProcess_V2(AllDataExpanded,
																			 _Files.Base_Prefix, 
																		   _Files.AllData_Suffix, 
																			 fileVersion, buildBaseFile, 3);
	
	// delete sprayed file
	deleteSpray 								:= FileServices.DeleteLogicalFile(_Files.SubFile.Input_New_Slim);

	sequentialSteps 						:= SEQUENTIAL(sprayFile,
																						buildNewFileSlim,
																						buildBaseFile,
																						deleteSpray);
	
	RETURN sequentialSteps;
	
END;