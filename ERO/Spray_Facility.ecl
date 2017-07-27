IMPORT lib_stringlib, lib_fileservices, _control,digssoff;



export Spray_agency (string p_date)  := FUNCTION
	 
	srcIP       		:= 'edata14.br.seisint.com';
	targetGrp   		:= 'thor_200';
	RemoteLoc   		:= '/cx4_load01/ERO/'+p_date+'/';
	Update_filedate 	:= p_date;
	src   		      := 'FacilityList.csv'; 

	facl        := src;
	Sprayedfacl := src +'_'+Update_filedate; 
	 
	sourceCsvSeparater := '\\,';
	sourceCsvTeminater := '\\n,\\r\\n';
	sourceCsvQuote     := '';

// check if file exists in UNIX
   checkremotefileexists(STRING FileName)   := IF(count(FileServices.remotedirectory(srcIP,RemoteLoc,FileName,false)(size <>0 )) = 1,
	                                               true,
	                                               false
																							   );
	 
// Spray the file
   Fun_SprayFile(String remoteFileName, String OPFileName) := 	
	                                          IF(count(FileServices.remotedirectory(srcIP,RemoteLoc,remoteFileName,false)(size <>0 )) = 1,
	                                               FileServices.SprayVariable(
																														    srcIP,
																														    RemoteLoc + remoteFileName,,
																														    sourceCsvSeparater,
																														    sourceCsvTeminater,
																														    sourceCsvQuote,
																														    targetGrp,
																														    OPFileName,
																														    -1,,,
																														    true,
																														    true),
	                                               output('Source Lookup not found'+' '+srcIP+' '+RemoteLoc+' '+remoteFileName)
																							   );
													
	 SprayFile           := Parallel(
	                                 Fun_Sprayfile(facl,Sprayedfacl)
	                                );                                   
												
																 
	AddToSuperFile    	 :=  Parallel(
	                                digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedfacl ,'~thor_200::in::ERO::FACILITY_LIST')
	                                );
														
                          
doall :=    sequential(
	                                   digssoff.SuperFile_Functions.Fun_createSuperfile('~thor_200::in::ERO::FACILITY_LIST'),
																		 SprayFile,
																	   FileServices.StartSuperFileTransaction(),																	                                    
																	   AddToSuperFile,
																	   FileServices.FinishSuperFileTransaction()
																		);
														


	return doall;

end;
