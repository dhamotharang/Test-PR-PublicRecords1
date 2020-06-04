//SprayProcess_FileNames

IMPORT STD, orbit;
fileservices := STD.File;

EXPORT SprayProcess_FileNames(STRING iFileName = 'ZZZZ', STRING build_date = mod_Utilities.strSysDate) := MODULE 

  SHARED sFileName                               := TRIM(iFileName, LEFT, RIGHT);	
  EXPORT InputFile                               := sFileName + '*';
	
// ###############################################################################
// Directory settings used on Unix Landing zone for Insurance NAccidentsInquiry Input Files
// ############################################################################### 	
	EXPORT NAccidentsInquirySprayDirPath         := Constants.NAccidentsInquiryExtractsSprayDirPath 
	                                                + Constants.FileSeparator 
	                                                + 'process' 
																								  + Constants.FileSeparator 
																									+ build_date;
																										
// ###########################################################################
// Directory path selection using the file name on Unix Landing zone 
// for Insurance NAccidentsInquiry Input Files
// ########################################################################### 																									
	EXPORT NAccidentsInquiryProcessFile          := NAccidentsInquirySprayDirPath + Constants.FileSeparator + sFileName + Constants.NAccidentsInquiryFileType; 
	
// ###########################################################################
//        BOOLEAN Expressions for File Name based on the input.  
// ###########################################################################	
	EXPORT isNAccidentsInquiryClient             := STD.Str.Find(sFileName, FileNames.CLIENT_FILE_NAME, 1)  			   > 0;	
	EXPORT isNAccidentsInquiryIntOrder           := STD.Str.Find(sFileName, FileNames.INT_ORDER_FILE_NAME, 1)        > 0;	
	EXPORT isNAccidentsInquiryOrderVersion       := STD.Str.Find(sFileName, FileNames.ORDER_VERSION_FILE_NAME, 1)    > 0;		
	EXPORT isNAccidentsInquiryVehicleParty       := STD.Str.Find(sFileName, FileNames.VEHICLE_PARTY_FILE_NAME, 1)    > 0;	
	EXPORT isNAccidentsInquiryVehicleIncident    := STD.Str.Find(sFileName, FileNames.VEHICLE_INCIDENT_FILE_NAME, 1) > 0;	
	EXPORT isNAccidentsInquiryVehicle            := STD.Str.Find(sFileName, FileNames.VEHICLE_FILE_NAME, 1)          > 0;	
	EXPORT isNAccidentsInquiryResult             := STD.Str.Find(sFileName, FileNames.RESULT_FILE_NAME, 1)           > 0;	
	EXPORT isNAccidentsInquiryVehicleInscr       := STD.Str.Find(sFileName, FileNames.VEHICLE_INSCR_FILE_NAME, 1)    > 0;
	
	
// ###########################################################################
//      BOOLEAN Expressions for Deltabase and Database Extracts.  
// ###########################################################################	
	EXPORT isNAccidentsInquiryExtract            :=  isNAccidentsInquiryClient 
	                                                 OR isNAccidentsInquiryIntOrder 
																									 OR isNAccidentsInquiryOrderVersion 
																									 OR isNAccidentsInquiryVehicleParty
																									 OR isNAccidentsInquiryVehicleIncident
																									 OR isNAccidentsInquiryVehicle
																									 OR isNAccidentsInquiryResult
																									 OR isNAccidentsInquiryVehicleInscr:INDEPENDENT;																										
																										
// ###########################################################################
// File masks for Telematics Driver Input files. 
// This includes Input, Process and Output File names used in Build process
// ########################################################################### 
	EXPORT ProcessFile                             := MAP(isNAccidentsInquiryExtract  => NAccidentsInquiryProcessFile,
																												'INVALID_PROCESS_PATH');
																										
// ###########################################################################
// Max Record Length of the Telematics Consolidation Input Datasets.
// ###########################################################################																											
  EXPORT UNSIGNED3 MaxRecLength                  := MAP(sFileName = FileNames.CLIENT_FILE_NAME              => Constants.ClientRecordLength,
                                                        sFileName = FileNames.INT_ORDER_FILE_NAME           => Constants.IntOrderRecordLength,
                                                        sFileName = FileNames.ORDER_VERSION_FILE_NAME       => Constants.OrderVersionRecordLength,
	                                                      sFileName = FileNames.VEHICLE_PARTY_FILE_NAME       => Constants.VehiclePartyRecordLength,		
																												sFileName = FileNames.VEHICLE_INCIDENT_FILE_NAME    => Constants.VehicleIncidentRecordLength,
                                                        sFileName = FileNames.VEHICLE_FILE_NAME             => Constants.VehicleRecordLength,
                                                        sFileName = FileNames.RESULT_FILE_NAME              => Constants.ResultRecordLength,
	                                                      sFileName = FileNames.VEHICLE_INSCR_FILE_NAME       => Constants.VehicleInscrRecordLength,			
																												Constants.MaxRecordLength);
																										
// ###########################################################################
// Max Record Length of the Telematics Consolidation Input Datasets.
// ###########################################################################																											
  EXPORT FieldSeparator                          := MAP(sFileName = FileNames.VEHICLE_INCIDENT_FILE_NAME    =>  Constants.VehicleIncidentFieldSeparator,															
																												Constants.FieldSeparator);	
																																								
// ###########################################################################
//  Orbit Entry for the directory Name defined on Landing Zone for 
//  Insurance NAccidentsInquiry Files Build   
// ###########################################################################																
  EXPORT NAccidentsInquiryOrbitPath             := Constants.OrbitPathPrefix + 'NAccidentsInquiry\\process' + '\\' + build_date + '\\';
																										
	EXPORT NAccidentsInquiryOrbitComponentPath    := Constants.OrbitComponentPathPrefix + 'NAccidentsInquiry\\\\process' + '\\\\' + build_date + '\\\\';																												
																												
  EXPORT OrbitPath                              := MAP(isNAccidentsInquiryExtract   => NAccidentsInquiryOrbitPath,
																			                 'NA');
																												
	EXPORT OrbitCompFile                          := MAP(isNAccidentsInquiryExtract => NAccidentsInquiryOrbitComponentPath,
																			                 'NA');
																												
// ###########################################################################
//    File name settings used for Spray logical and Base  files  
// ###########################################################################
	SHARED SPRAY_PREFIX                            := Files_NAccidentsInquiry.SPRAY_PREFIX;
	EXPORT SPRAY_BASE_FILE                         := SPRAY_PREFIX + '::QA::' + sFileName;
	EXPORT SPRAY_SUB_FILE                          := SPRAY_PREFIX + '::' + WORKUNIT + '::' + sFileName;

END;