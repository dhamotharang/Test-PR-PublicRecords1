EXPORT SprayProcess_MBSAgencyFileNames(STRING pDate = mod_Utilities.strCurrentDateTimeStamp) := MODULE 
	
// ###############################################################################
// Directory settings used on Unix Landing zone for Agency Input File
// ############################################################################### 	
  EXPORT AgencySprayProcessDirPath := Constants_MBSAgency.AgencyLZPathPrefix + 
																			Constants_MBSAgency.FileSeparator + 
																			TRIM(pDate, ALL);
																									
// ###########################################################################
// Directory path selection using the file name on Unix Landing zone 
// for DLCorrections Input Files
// ########################################################################### 																									
  EXPORT AgencyProcessFile := AgencySprayProcessDirPath + Constants_MBSAgency.FileSeparator + Constants_MBSAgency.AgencyLZFilename; 
																																																	
																																			
// ###########################################################################
//  Orbit Entry for the directory Name defined on Landing Zone for 
//  DLCorrections Files Build   
// ###########################################################################																
 // EXPORT DLCOrbitPath := Constants.OrbitPathPrefix + 'DLCorrections\\process' + '\\' + build_date + '\\';
																										
 // EXPORT DLCOrbitComponentPath := Constants.OrbitComponentPathPrefix + 'DLCorrections\\\\process' + '\\\\' + build_date + '\\\\';																												

END;