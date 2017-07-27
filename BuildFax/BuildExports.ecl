// This attribute has 3 functions: pull data from the landing zone and spray the data on thor, 
//                                 build the key file on transaction id,
//                                 build the superkey.

EXPORT BuildExports(STRING build_date, string bFileName) := MODULE

  SHARED FileList           := FileServices.RemoteDirectory(Constants().landingzone,
																								            Constants(bFileName,build_date).processDir, 
																														Constants(bFileName,build_date).fname):INDEPENDENT;

	SHARED sprayFile          := SEQUENTIAL(FileServices.SprayVariable(
																					Constants().landingzone,                     // landing zone 
																					Constants(bFileName, build_date).processFile, // input file
																					Constants().MAX_RECORD_SIZE,                 // max rec
																					Constants().FieldSeparator,                  // field sep
																					,                                            // rec sep (use default)
																					,                                            // quote
																					Constants().thor_dest,                       // destination group
																					Constants(bFileName).spray_subfile,          // destination logical name
																					-1,                                          // time
																					Constants().devespserverIPport,              // esp server IP port
																					,                                            // max connections
																					TRUE,                                        // overwrite
																					FALSE,                                       // replicate
																					TRUE )                                       // compress
																				);
	EXPORT Spray_Data         := sprayFile;

	EXPORT Base_Build         := BuildBase(bFileName, build_date);

	SHARED emailList          := 'Sanjay.Kumar@lexisnexis.com,' + Constants().QC_email_target;

	SHARED envVal							:= 'N';
	
	// SHARED updateBuildVersion := if(_control.ThisEnvironment.Name = 'Prod', 
																	// idops.UpdateBuildVersion(OrbitIConstants(trim(bFileName,left,right)).idopsdataset,trim(build_date,left,right), emailList,,envVal),
															    // OUTPUT('No idops updates for dev environment'));

	SHARED buildBaseProcess   := SEQUENTIAL (Spray_Data, Base_Build);
	
  EXPORT SprayBuild_Base    := buildBaseProcess;
END;