IMPORT STD;

EXPORT Spray_MBSAgency(STRING pDate = mod_Utilities.strCurrentDateTimeStamp) := FUNCTION   

  agencySourceFile := SprayProcess_MBSAgencyFileNames(pDate).AgencyProcessFile; 
	agencyDestFile := Files_MBSAgency.FILE_SPRAY_AGENCY_LF(pDate);
 
  sprayAgency := STD.File.SprayVariable(Constants_MBSAgency.LandingZone,                // landing zone 
																							agencySourceFile,                          		// input file
																							,        																			// max rec
																							Constants_MBSAgency.RecordSeparator,          // field sep
																							,                                          		// rec sep (use default)
																							,                                          		// quote
																							Constants_MBSAgency.ThorDest,                 // destination group
																							agencyDestFile,     											 		// destination logical name
																							-1,                                        		// time
																							,                                          		// esp server IP port
																							,                                          		// max connections
																							TRUE,                                      		// overwrite
																							FALSE,                                     		// replicate
																							TRUE,                                      		// compress
																							,                                          		// source CSV escape
																							,                                          		// fail if no source file
																							,                                          		// record structure present
																							,                                          		// quoted terminator
																							,                                          		// encoding
																							Constants_MBSAgency.SprayFileDaysToExpire);   // days to expire	
  
	addLogicalToSF := mod_Utilities.fn_AddSuperFile(Files_MBSAgency.FILE_SPRAY_AGENCY_SF, agencyDestFile);	
	
  RETURN SEQUENTIAL(sprayAgency, addLogicalToSF);
	
END;