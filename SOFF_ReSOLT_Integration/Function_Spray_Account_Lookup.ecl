//----------------------------------------------------------------------
//Function to spray fixed file specified
//----------------------------------------------------------------------
IMPORT address, lib_fileservices, _control,DigsSoff;

EXPORT Function_Spray_Account_Lookup (String srcIP,
                          String targetGrp,
												  String RemoteLoc,
												  String Update_filedate
                         )  := FUNCTION


   //srcIP       := 'edata10.br.seisint.com';
   //targetGrp   := 'thor_data50';
   //RemoteLoc   := '/export/home/vchikte/AR/' ;

   LkpFileName   := 'account_idLookupFile' + Update_filedate+'.csv';

   LkpSuperFile  := ReSOLT_SuperFile_List.SOFFReSOLT_Account; 

   SprayedFile   := LkpSuperFile +'_'+Update_filedate; 
	 
	 sourceCsvSeparater := '\\,';
   sourceCsvTeminater := '\\n,\\r\\n';
   sourceCsvQuote     := '\"';

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
																											 
   Create_SuperFile    := DigsSoff.SuperFile_Functions.Fun_createSuperfile(LkpSuperFile);
													
	 SprayFile           := Fun_Sprayfile(LkpFileName,SprayedFile);                                   
                                     																		 
   ClearSuperFile      := DigsSoff.SuperFile_Functions.Fun_clearsuperfile(LkpSuperFile);
													
																 
   AddToSuperFile    	 := DigsSoff.SuperFile_Functions.Fun_AddToSuperfile(SprayedFile ,LkpSuperFile);
                          
   spray_and_add_files := IF(checkremotefileexists(LkpFileName),
	                            sequential(Create_SuperFile, 
	                                       DigsSoff.SuperFile_Functions.DoCleanup(SprayedFile,LkpSuperFile),
                                         SprayFile,
																	       FileServices.StartSuperFileTransaction(),																	                                    
																	       ClearSuperFile,
																	       AddToSuperFile,
																	       FileServices.FinishSuperFileTransaction()
																				 ),
															//sequential(
															output('Account Lookup not found'+' '+srcIP+' '+RemoteLoc+' '+LkpFileName)
															// NOTIFY('Lookup Spray','Lookup Spray complete'))
														)	;																											 

   return spray_and_add_files;

end;

