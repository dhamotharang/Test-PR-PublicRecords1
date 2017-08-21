//----------------------------------------------------------------------
//Function to spray fixed file specified
//----------------------------------------------------------------------
IMPORT lib_stringlib, lib_fileservices, _control;

EXPORT Spray_lookup_file (String srcIP,
                          String targetGrp,
												  String RemoteLoc,
												  String Update_filedate
                         )  := FUNCTION


   //srcIP       := 'edata10.br.seisint.com';
   //targetGrp   := 'thor_data50';
   //RemoteLoc   := '/export/home/vchikte/AR/' ;

   LkpFileName  := 'Source_lookup_' + Update_filedate+'.csv';

   LkpSuperFile   := SOFF_SuperFileList.DIGSSOFFSource; 

   SprayedFile := LkpSuperFile +'_'+Update_filedate; 
	 
	 sourceCsvSeparater := '\\,';
   sourceCsvTeminater := '\\n,\\r\\n';
   sourceCsvQuote     := '';

// check if file exists in UNIX
   checkremotefileexists(STRING FileName)   := IF(count(FileServices.remotedirectory(srcIP,RemoteLoc,FileName,false)(size <>0 )) = 1,
	                                               true,
	                                               false
																							   );
	 
// Spray the file
   Fun_SprayFile(String remoteFileName, String OPFileName) := 	FileServices.SprayVariable(
																														    srcIP,
																														    RemoteLoc + remoteFileName,,
																														    sourceCsvSeparater,
																														    sourceCsvTeminater,
																														    sourceCsvQuote,
																														    targetGrp,
																														    OPFileName,
																														    -1,,,
																														    true,
																														    true);
																											 
   Create_SuperFile    := SuperFile_Functions.Fun_createSuperfile(LkpSuperFile);
													
	 SprayFile           := Fun_Sprayfile(LkpFileName,SprayedFile);                                   
                                     																		 
   ClearSuperFile      := SuperFile_Functions.Fun_clearsuperfile(LkpSuperFile);
													
																 
   AddToSuperFile    	 := SuperFile_Functions.Fun_AddToSuperfile(SprayedFile ,LkpSuperFile);
                          
   spray_and_add_files := IF(checkremotefileexists(LkpFileName),
	                            sequential(Create_SuperFile, 
	                                       SuperFile_Functions.DoCleanup(SprayedFile,LkpSuperFile),
                                         SprayFile,
																	       FileServices.StartSuperFileTransaction(),																	                                    
																	       ClearSuperFile,
																	       AddToSuperFile,
																	       FileServices.FinishSuperFileTransaction()
																				 ),
															//sequential(
															output('Source Lookup not found'+' '+srcIP+' '+RemoteLoc+' '+LkpFileName)
															// NOTIFY('Lookup Spray','Lookup Spray complete'))
														)	;																											 

   return spray_and_add_files;

end;
