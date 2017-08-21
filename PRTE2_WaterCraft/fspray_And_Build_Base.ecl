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

IMPORT RoxieKeyBuild;

EXPORT fspray_And_Build_Base(STRING lzFilePath, STRING fileVersion) := FUNCTION
	
	// spray file from landing zone
	sprayFile 							:= FileServices.SprayVariable(_LandingZoneConfig.IP,		 									// file landing zone
																												lzFilePath,																	// path to file on landing zone
																												8192,																				// maximum record size
																												_LandingZoneConfig.CSVSprayFieldSeparator,	// field separator(s)
																												_LandingZoneConfig.CSVSprayLineSeparator,		// line separator(s)
																												_LandingZoneConfig.CSVSprayQuote,						// text quote character
																												ThorLib.Cluster(),													// destination THOR cluster
																												_Files.SubFile.Input_All_Slim,							// destination file
																												-1,												  								// -1 means no timeout
																													,													 		 						// use default ESP server IP port
																													,																					// use default maximum connections
																												TRUE,												 								// allow overwrite
																												TRUE,												  							// replicate
																												FALSE												  							// do not compress
																												);
	
	
	
	// associate to superfile (and move older files into older generation superfiles)
	RoxieKeyBuild.Mac_SF_BuildProcess_V2(_Datasets.All_Slim_SubFile,
																			 _Files.Input_Prefix, 
																		   _Files.AllData_Slim_Suffix, 
																			 fileVersion, buildBaseFileSlim, 3);
	
	
	AllDataExpanded					:= PROJECT(_Datasets.All_Slim, 
																			TRANSFORM(PRTE2_Watercraft._Layouts.Base, 
																								SELF := LEFT; 
																								SELF := [];));
	
	// associate expanded file to superfile (and move older files into older generation superfiles)
	RoxieKeyBuild.Mac_SF_BuildProcess_V2(AllDataExpanded,
																			 _Files.Base_Prefix, 
																		   _Files.AllData_Suffix, 
																			 fileVersion, buildBaseFile, 3);
	
	// delete sprayed file
	deleteSpray 						:= FileServices.DeleteLogicalFile(_Files.SubFile.Input_All_Slim);
		
	sequentialSteps 				:= SEQUENTIAL(sprayFile,
																				buildBaseFileSlim,
																				buildBaseFile,
																				deleteSpray);
	
	RETURN sequentialSteps;
	
END;