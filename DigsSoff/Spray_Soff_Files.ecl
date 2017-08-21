//----------------------------------------------------------------------
//Function to spray fixed file specified
//----------------------------------------------------------------------
IMPORT lib_stringlib, lib_fileservices, _control,lib_thorlib;

EXPORT Spray_Soff_Files (String srcIP,
                         String targetGrp,
												 String RemoteLoc,
												 String Update_filedate
                         )  := FUNCTION

//srcIP       := 'edata10.br.seisint.com';
//targetGrp   := 'thor_data50';
//RemoteLoc   := '/export/home/vchikte/AR/';

#workunit('name','SexPred Pre-process: Spray DIGS Raw Data');

IPFileName_offender  := 'offender_' + Update_filedate+'.txt';
IPFileName_offense   := 'offense_' +Update_filedate+ '.txt';
IPFileName_alias     := 'alias_' +Update_filedate+ '.txt';
IPFileName_address   := 'address_' +Update_filedate+ '.txt';
IPFileName_attribute := 'attribute_' + Update_filedate+'.txt';
IPFileName_vehicle   := 'vehicle_' +Update_filedate+ '.txt';
IPFileName_mugshot   := 'mugshot_' +Update_filedate+ '.txt';

SuperFile_offender   := digssoff.SOFF_SuperFileList.DIGSSOFFOffender; 
SuperFile_offense    := digssoff.SOFF_SuperFileList.DIGSSOFFOffense;
SuperFile_alias      := digssoff.SOFF_SuperFileList.DIGSSOFFalias;     
SuperFile_address    := digssoff.SOFF_SuperFileList.DIGSSOFFaddress;  
SuperFile_attribute  := digssoff.SOFF_SuperFileList.DIGSSOFFattribute; 
SuperFile_vehicle    := digssoff.SOFF_SuperFileList.DIGSSOFFvehicle;  
SuperFile_mugshot    := digssoff.SOFF_SuperFileList.DIGSSOFFmugshot;

Sprayed_offender     := SuperFile_Offender +'_'+Update_filedate; 
Sprayed_offense      := SuperFile_Offense  +'_'+Update_filedate;
Sprayed_alias        := SuperFile_alias    +'_'+Update_filedate;     
Sprayed_address      := SuperFile_address  +'_'+Update_filedate;  
Sprayed_attribute    := SuperFile_attribute+'_'+Update_filedate; 
Sprayed_vehicle      := SuperFile_vehicle  +'_'+Update_filedate;  
Sprayed_mugshot      := SuperFile_mugshot  +'_'+Update_filedate;

// rec_size_offender :=3695;
// rec_size_offense  :=2868;
// rec_size_alias    :=277;
// rec_size_address  :=629;
// rec_size_attribute:=577;
// rec_size_vehicle  :=577;
// rec_size_mugshot  :=167;

	 sourceCsvSeparater := '\\|';
   sourceCsvTeminater := '\\n,\\r\\n';
   sourceCsvQuote     := '~~~';

//check if file exists in UNIX
  checkremotefileexists(STRING FileName) := IF(count(FileServices.remotedirectory(srcIP,RemoteLoc,FileName,false)(size <>0 )) = 1,
	                                      true,
	                                      false);
																				
 
  All_filesExists          := IF( fileservices.FileExists (Sprayed_offender) AND
																	fileservices.FileExists (Sprayed_offense)  AND
																	fileservices.FileExists (Sprayed_alias  )  AND
																	fileservices.FileExists (Sprayed_address)  AND
																	fileservices.FileExists (Sprayed_attribute)AND
																	fileservices.FileExists (Sprayed_vehicle)  AND
																	fileservices.FileExists (Sprayed_mugshot),
																	true,
																	false
												);
	AnyOneSprayedFileExists := IF( fileservices.FileExists (Sprayed_offender) OR
	                                fileservices.FileExists (Sprayed_offense)  OR
													        fileservices.FileExists (Sprayed_alias  )  OR
													        fileservices.FileExists (Sprayed_address)  OR
													        fileservices.FileExists (Sprayed_attribute)OR
													        fileservices.FileExists (Sprayed_vehicle)  OR
													        fileservices.FileExists (Sprayed_mugshot),
															    true,
	                                false
												        );										

   // Spray the file
   // Fun_SprayFile(String IPFileName, String OPFileName,rec_size) := FileServices.sprayfixed(
                                                              // srcIP,
                                                              // RemoteLoc + IPFileName,
                                                              // rec_size,
                                                              // targetGrp,
                                                              // OPFileName,
                                                              // -1,,,
																													    // true,
																													    // true                                                         
																                             // );
																														 
   Fun_SprayFile(String remoteFileName, String OPFileName) := 	FileServices.SprayVariable(
																														    srcIP,
																														    RemoteLoc + remoteFileName,
																															3090,
																														    sourceCsvSeparater,
																														    sourceCsvTeminater,
																														    sourceCsvQuote,
																														    targetGrp,
																														    OPFileName,
																														    -1,,,
																														    true,
																														    true);																														 
																											 
   Fun_AddToSuperfile(String FileName, String SuperFile) := IF(All_filesExists, 
	                                                                       fileservices.addsuperfile(superfile,FileName), 
                                                                         output('Could not add'+ FileName+' to '+ superfile)
											                                        );
																								

   Create_AllSuperFiles := Parallel  (SuperFile_Functions.Fun_createSuperfile(Superfile_offender),
                                      SuperFile_Functions.Fun_createSuperfile(Superfile_offense),
																      SuperFile_Functions.Fun_createSuperfile(Superfile_alias),
                                      SuperFile_Functions.Fun_createSuperfile(Superfile_address),
																      SuperFile_Functions.Fun_createSuperfile(Superfile_attribute),
                                      SuperFile_Functions.Fun_createSuperfile(Superfile_vehicle),
																      SuperFile_Functions.Fun_createSuperfile(Superfile_mugshot)
																     );
																		 																					
															        	
   SprayFiles           := Parallel  (Fun_Sprayfile(IPFileName_offender ,Sprayed_offender ),  // ,rec_size_offender),
                                      Fun_Sprayfile(IPFileName_offense  ,Sprayed_offense  ),  // ,rec_size_offense),                            
                                      Fun_Sprayfile(IPFileName_alias    ,Sprayed_alias    ),  // ,rec_size_alias),
                                      Fun_Sprayfile(IPFileName_address  ,Sprayed_address  ),  // ,rec_size_address),
                                      Fun_Sprayfile(IPFileName_attribute,Sprayed_attribute),  // ,rec_size_attribute),
                                      Fun_Sprayfile(IPFileName_vehicle  ,Sprayed_vehicle  ),  // ,rec_size_vehicle),
                                      Fun_Sprayfile(IPFileName_mugshot  ,Sprayed_mugshot  )  // ,rec_size_mugshot)
                                     );
																		 
   ClearSuperFiles      := Parallel  (SuperFile_Functions.Fun_clearsuperfile(Superfile_offender),
                                      SuperFile_Functions.Fun_clearsuperfile(Superfile_offense),
													 		 	      SuperFile_Functions.Fun_clearsuperfile(Superfile_alias),
                                      SuperFile_Functions.Fun_clearsuperfile(Superfile_address),
														 		      SuperFile_Functions.Fun_clearsuperfile(Superfile_attribute),
                                      SuperFile_Functions.Fun_clearsuperfile(Superfile_vehicle),
																      SuperFile_Functions.Fun_clearsuperfile(Superfile_mugshot)
																     );															
																		 
   AddToSuperFiles    	 := Parallel (Fun_AddToSuperfile(Sprayed_offender ,Superfile_offender),
                                      Fun_AddToSuperfile(Sprayed_offense  ,Superfile_offense),                            
                                      Fun_AddToSuperfile(Sprayed_alias    ,Superfile_alias),
                                      Fun_AddToSuperfile(Sprayed_address  ,Superfile_address),
                                      Fun_AddToSuperfile(Sprayed_attribute,Superfile_attribute),
                                      Fun_AddToSuperfile(Sprayed_vehicle  ,Superfile_vehicle),
                                      Fun_AddToSuperfile(Sprayed_mugshot  ,Superfile_mugshot)
                                     );
																		 
   DoCleanup             := IF (AnyOneSprayedFileExists, sequential( ClearSuperFiles,
																												FileServices.DeleteLogicalFile(Sprayed_offender),
																												FileServices.DeleteLogicalFile(Sprayed_offense),
																												FileServices.DeleteLogicalFile(Sprayed_alias),
																												FileServices.DeleteLogicalFile(Sprayed_address),
																												FileServices.DeleteLogicalFile(Sprayed_attribute),
																												FileServices.DeleteLogicalFile(Sprayed_vehicle),
																												FileServices.DeleteLogicalFile(Sprayed_mugshot))																		 
                                );
																
   spray_and_add_files   := sequential(
	                                 Create_AllSuperFiles, 
	                                 DoCleanup, //Required  when you want to rerun a set of files
                                   Sprayfiles,
																	 FileServices.StartSuperFileTransaction(),																	                                    
																	 ClearSuperFiles,
																	 AddToSuperFiles,
																	 FileServices.FinishSuperFileTransaction(),
																	 output('Data Files Sprayed'),
																	 Spray_lookup_file (srcIP,
                                                      targetGrp,
												                              RemoteLoc,
												                              Update_filedate
                                                      ),
																	 output('Lookup File Sprayed'),
																	 Proc_SOFF_OKC_Build 
																	 //Create_AllSuperFiles, 
	                                 //DoCleanup
																   ): Failure(FileServices.SendEmail('digssoff.chikte@lexisnexis.com','SexPred Pre-Process Failed', thorlib.wuid())),
																	    Success(FileServices.SendEmail('digssoff.chikte@lexisnexis.com','SexPred Pre-Process Succeeded','Process Completed Successfully')) ;																											 

return spray_and_add_files; 

end;


