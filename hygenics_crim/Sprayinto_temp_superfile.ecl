IMPORT lib_stringlib, lib_fileservices, _control,digssoff;

export Sprayinto_temp_superfile  := MODULE 


export DOC (string p_date, string p_source)  := FUNCTION
	 
	docsrcIP       		:= 'edata11.br.seisint.com';
	doctargetGrp   		:= 'thor_200';
	docRemoteLoc   		:= '/load01/hygenics/'+p_date+'/doc/';
	docUpdate_filedate 	:= p_date;
	docsrc_state   		:= p_source ;//'UTAH'; 

	docdef   := docsrc_state+'_DEFENDANT.csv';
	docoff   := docsrc_state+'_OFFENSE.csv';
	docchg   := docsrc_state+'_CHARGE.csv';
	docsen   := docsrc_state+'_SENTENCE.csv';
	docali   := docsrc_state+'_ALIAS.csv';
	docpri   := docsrc_state+'_PRIORS.csv';
	docoth   := docsrc_state+'_OTHER.csv';
	docadd   := docsrc_state+'_ADDRESS_HISTORY.csv';
	docpho   := docsrc_state+'_PHONE_HISTORY.csv';

	docSprayeddef := docdef +'_'+docUpdate_filedate; 
	docSprayedoff := docoff +'_'+docUpdate_filedate; 
	docSprayedchg := docchg +'_'+docUpdate_filedate; 
	docSprayedsen := docsen +'_'+docUpdate_filedate; 
	docSprayedadd := docadd +'_'+docUpdate_filedate; 
	docSprayedali := docali +'_'+docUpdate_filedate; 
	docSprayedoth := docoth +'_'+docUpdate_filedate;
	docSprayedpri := docpri +'_'+docUpdate_filedate;
	docSprayedpho := docpho +'_'+docUpdate_filedate;
	 
	docsourceCsvSeparater := '\\,';
	docsourceCsvTeminater := '\\n,\\r\\n';
	docsourceCsvQuote     := '';

// check if file exists in UNIX
   checkremotefileexists(STRING FileName)   := IF(count(FileServices.remotedirectory(docsrcIP,docRemoteLoc,FileName,false)(size <>0 )) = 1,
	                                               true,
	                                               false
																							   );
	 
// Spray the file
   Fun_SprayFile(String remoteFileName, String OPFileName) := 	
	                                          IF(count(FileServices.remotedirectory(docsrcIP,docRemoteLoc,remoteFileName,false)(size <>0 )) = 1,
	                                               FileServices.SprayVariable(
																														    docsrcIP,
																														    docRemoteLoc + remoteFileName,,
																														    docsourceCsvSeparater,
																														    docsourceCsvTeminater,
																														    docsourceCsvQuote,
																														    doctargetGrp,
																														    OPFileName,
																														    -1,,,
																														    true,
																														    true),
	                                               output('Source Lookup not found'+' '+docsrcIP+' '+docRemoteLoc+' '+remoteFileName)
																							   );
																											 

																		 
																		 
													
	 docSprayFile           := Parallel(
	                                 Fun_Sprayfile(docdef,docSprayeddef),
	                                 Fun_Sprayfile(docoff,docSprayedoff),
																	 Fun_Sprayfile(docchg,docSprayedchg),
	                                 Fun_Sprayfile(docali,docSprayedali),
																	 
	                                 Fun_Sprayfile(docpri,docSprayedpri),
																	 Fun_Sprayfile(docoth,docSprayedoth),
																	 Fun_Sprayfile(docsen,docSprayedsen),
																	 Fun_Sprayfile(docadd,docSprayedadd),
																	 Fun_Sprayfile(docpho,docSprayedpho)
	                                );                                   
												
																 
	docAddToSuperFile    	 :=  Parallel(
	                                 digssoff.SuperFile_Functions .Fun_AddToSuperfile(docSprayeddef ,'~thor_200::in::crimtemp::HD::DOC_DEFENDANT'),
																	 digssoff.SuperFile_Functions .Fun_AddToSuperfile(docSprayedoff ,'~thor_200::in::crimtemp::HD::DOC_OFFENSE'),
																	 digssoff.SuperFile_Functions .Fun_AddToSuperfile(docSprayedchg ,'~thor_200::in::crimtemp::HD::DOC_CHARGE'),
	                                 digssoff.SuperFile_Functions .Fun_AddToSuperfile(docSprayedali ,'~thor_200::in::crimtemp::HD::DOC_ALIAS'),
	                                 digssoff.SuperFile_Functions .Fun_AddToSuperfile(docSprayedpri ,'~thor_200::in::crimtemp::HD::DOC_PRIOR'),
																   digssoff.SuperFile_Functions .Fun_AddToSuperfile(docSprayedoth ,'~thor_200::in::crimtemp::HD::DOC_OTHER'),
	                                 digssoff.SuperFile_Functions .Fun_AddToSuperfile(docSprayedsen ,'~thor_200::in::crimtemp::HD::DOC_SENTENCE'),
																	 digssoff.SuperFile_Functions .Fun_AddToSuperfile(docSprayedpho ,'~thor_200::in::crimtemp::HD::DOC_PHONE_HISTORY'),
																	 digssoff.SuperFile_Functions .Fun_AddToSuperfile(docSprayedadd ,'~thor_200::in::crimtemp::HD::DOC_ADDRESS_HISTORY')
	                                );
														
                          
doall :=    sequential(
	                                   //docCreate_SuperFile, 
	                                   docSprayFile,
																	   FileServices.StartSuperFileTransaction(),																	                                    
																	   docAddToSuperFile,
																	   FileServices.FinishSuperFileTransaction()
																		);
														


	return doall;

end;

export AOC (string p_date, string p_source)  := FUNCTION

	srcIP       	:= 'edata11.br.seisint.com';
	targetGrp   	:= 'thor_200';	 
	RemoteLoc   	:= '/load01/hygenics/'+p_date+'/aoc/';
	Update_filedate := p_date;
	src_state   	:= p_source ;//'UTAH'; 
											 
	def   := src_state+'_DEFENDANT.csv';
	off   := src_state+'_OFFENSE.csv';
	chg   := src_state+'_CHARGE.csv';
	sen   := src_state+'_SENTENCE.csv';
	add   := src_state+'_ADDRESS_HISTORY.csv';
	ali   := src_state+'_ALIAS.csv';
	pri   := src_state+'_PRIORS.csv';	 
	oth   := src_state+'_OTHER.csv';
	pho   := src_state+'_PHONE_HISTORY.csv';
	 

	Sprayeddef := def +'_'+Update_filedate; 
	Sprayedoff := off +'_'+Update_filedate; 
	Sprayedchg := chg +'_'+Update_filedate; 
	Sprayedsen := sen +'_'+Update_filedate; 
	Sprayedadd := add +'_'+Update_filedate; 
	Sprayedali := ali +'_'+Update_filedate; 
	Sprayedoth := oth +'_'+Update_filedate;
	Sprayedpri := pri +'_'+Update_filedate;
	Sprayedpho := pho +'_'+Update_filedate;
	 
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
	                                 Fun_Sprayfile(def,Sprayeddef),
	                                 Fun_Sprayfile(off,Sprayedoff),
																	 Fun_Sprayfile(chg,Sprayedchg),
	                                 Fun_Sprayfile(ali,Sprayedali),
																	 
	                                 Fun_Sprayfile(pri,Sprayedpri),
																	 Fun_Sprayfile(oth,Sprayedoth),
																	 Fun_Sprayfile(sen,Sprayedsen),
																	 Fun_Sprayfile(add,Sprayedadd),
																	 Fun_Sprayfile(pho,Sprayedpho)
	                                );                                   
                                     																		 
																 
	AddToSuperFile    	 :=  Parallel(
		                               digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayeddef ,'~thor_200::in::crimtemp::HD::AOC_DEFENDANT'),
																	 digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedoff ,'~thor_200::in::crimtemp::HD::AOC_OFFENSE'),
																	 digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedchg ,'~thor_200::in::crimtemp::HD::AOC_CHARGE'),
	                                 digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedsen ,'~thor_200::in::crimtemp::HD::AOC_SENTENCE'),
	                                 digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedali ,'~thor_200::in::crimtemp::HD::AOC_ALIAS'),
	                                 digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedoth ,'~thor_200::in::crimtemp::HD::AOC_OTHER'),
																	 digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedpho ,'~thor_200::in::crimtemp::HD::AOC_PHONE_HISTORY'),
	                                 digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedadd ,'~thor_200::in::crimtemp::HD::AOC_ADDRESS_HISTORY')
	                                 );																	
                          
	doallaoc :=    sequential(
	                                   //Create_SuperFile, 
	                                   SprayFile,
																	   FileServices.StartSuperFileTransaction(),																	                                    
																	   AddToSuperFile,
																	   FileServices.FinishSuperFileTransaction()
																		);
														
	return doallaoc;

end;


export CTY (string p_date, string p_source )  := FUNCTION

	 srcIP       		:= 'edata11.br.seisint.com';
	 targetGrp   		:= 'thor_200';	 
	 RemoteLoc   		:= '/load01/hygenics/'+p_date+'/county/';
	 Update_filedate 	:= p_date;
	 src_state   		:= p_source ;//'UTAH'; 
											 
	 def   := src_state+'_DEFENDANT.csv';
	 off   := src_state+'_OFFENSE.csv';
	 chg   := src_state+'_CHARGE.csv';
	 sen   := src_state+'_SENTENCE.csv';
	 add   := src_state+'_ADDRESS_HISTORY.csv';
	 ali   := src_state+'_ALIAS.csv';
	 pri   := src_state+'_PRIORS.csv';	 
	 oth   := src_state+'_OTHER.csv';
	 pho   := src_state+'_PHONE_HISTORY.csv';
	 
	 Sprayeddef := def +'_'+Update_filedate; 
	 Sprayedoff := off +'_'+Update_filedate; 
	 Sprayedchg := chg +'_'+Update_filedate; 
	 Sprayedsen := sen +'_'+Update_filedate; 
	 Sprayedadd := add +'_'+Update_filedate; 
	 Sprayedali := ali +'_'+Update_filedate; 
	 Sprayedoth := oth +'_'+Update_filedate;
	 Sprayedpri := pri +'_'+Update_filedate;
	 Sprayedpho := pho +'_'+Update_filedate;
	 
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
	                                 Fun_Sprayfile(def,Sprayeddef),
	                                 Fun_Sprayfile(off,Sprayedoff),
																	 Fun_Sprayfile(chg,Sprayedchg),
	                                 Fun_Sprayfile(ali,Sprayedali),																	 
	                                 Fun_Sprayfile(pri,Sprayedpri),
																	 //Fun_Sprayfile(oth,Sprayedoth),
																	 Fun_Sprayfile(sen,Sprayedsen),
																	 Fun_Sprayfile(add,Sprayedadd)
																	 //Fun_Sprayfile(pho,Sprayedpho)
	                                );                                   
                                     																		 
																 
	AddToSuperFile    	 :=  Parallel(
		                               digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayeddef ,'~thor_200::in::crimtemp::HD::COUNTY_DEFENDANT'),
																	 digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedoff ,'~thor_200::in::crimtemp::HD::COUNTY_OFFENSE'),
																	 digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedchg ,'~thor_200::in::crimtemp::HD::COUNTY_CHARGE'),
	                                 digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedsen ,'~thor_200::in::crimtemp::HD::COUNTY_SENTENCE'),
	                                 digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedali ,'~thor_200::in::crimtemp::HD::COUNTY_ALIAS'),
	                                 //digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedoth ,'~thor_200::in::crimtemp::HD::COUNTY_OTHER'),
																	 //digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedpho ,'~thor_200::in::crimtemp::HD::COUNTY_PHONE_HISTORY'),
	                                 digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedadd ,'~thor_200::in::crimtemp::HD::COUNTY_ADDRESS_HISTORY')
	                                 );																	
                          
	doallcty :=    sequential(
	                                   //Create_SuperFile, 
	                                   SprayFile,
																	   FileServices.StartSuperFileTransaction(),																	                                    
																	   AddToSuperFile,
																	   FileServices.FinishSuperFileTransaction()
																		);
														


	return doallcty;

end;

//added by Tarun
export ARRESTS (string p_date, string p_source)  := FUNCTION

	srcIP       		:= 'edata11.br.seisint.com';
	targetGrp   		:= 'thor_200';	 
	RemoteLoc   		:= '/load01/hygenics/'+p_date+'/arrest/';
    Update_filedate 	:= p_date;
	src_state   		:= p_source ;//'UTAH'; 
											 
	def   := src_state+'_DEFENDANT.csv';
	off   := src_state+'_OFFENSE.csv';
	chg   := src_state+'_CHARGE.csv';
	sen   := src_state+'_SENTENCE.csv';
	add   := src_state+'_ADDRESS_HISTORY.csv';
	ali   := src_state+'_ALIAS.csv';
	pri   := src_state+'_PRIORS.csv';	 
	oth   := src_state+'_OTHER.csv';
	pho   := src_state+'_PHONE_HISTORY.csv';
	 

	Sprayeddef := def +'_'+Update_filedate; 
	Sprayedoff := off +'_'+Update_filedate; 
	Sprayedchg := chg +'_'+Update_filedate; 
	Sprayedsen := sen +'_'+Update_filedate; 
	Sprayedadd := add +'_'+Update_filedate; 
	Sprayedali := ali +'_'+Update_filedate; 
	Sprayedoth := oth +'_'+Update_filedate;
	Sprayedpri := pri +'_'+Update_filedate;
	Sprayedpho := pho +'_'+Update_filedate;
	 
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
	                                 Fun_Sprayfile(def,Sprayeddef),
	                                 Fun_Sprayfile(off,Sprayedoff),
																	 Fun_Sprayfile(chg,Sprayedchg),
	                                 Fun_Sprayfile(ali,Sprayedali),																	 
	                                 //Fun_Sprayfile(pri,Sprayedpri),
																	 //Fun_Sprayfile(oth,Sprayedoth),
																	 Fun_Sprayfile(sen,Sprayedsen),
																	 Fun_Sprayfile(add,Sprayedadd)
																	 //Fun_Sprayfile(pho,Sprayedpho)
	                                );                                   
                                     																		 
																 
	AddToSuperFile    	 :=  Parallel(
		                               digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayeddef ,'~thor_200::in::crimtemp::HD::ARREST_DEFENDANT'),
																	 digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedoff ,'~thor_200::in::crimtemp::HD::ARREST_OFFENSE'),
																	 digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedchg ,'~thor_200::in::crimtemp::HD::ARREST_CHARGE'),
	                                 digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedsen ,'~thor_200::in::crimtemp::HD::ARREST_SENTENCE'),
	                                 digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedali ,'~thor_200::in::crimtemp::HD::ARREST_ALIAS'),
	                                 //digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedoth ,'~thor_200::in::crimtemp::HD::ARREST_OTHER'),
																	 //digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedpho ,'~thor_200::in::crimtemp::HD::ARREST_PHONE_HISTORY'),
	                                 digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedadd ,'~thor_200::in::crimtemp::HD::ARREST_ADDRESS_HISTORY')
																	 //digssoff.SuperFile_Functions .Fun_AddToSuperfile(Sprayedpri ,'~thor_200::in::crimtemp::HD::ARREST_PRIORS_HISTORY')
	                                 );																	
                          
	doallarr :=    sequential(
	                                   //Create_SuperFile, 
	                                   SprayFile,
																	   FileServices.StartSuperFileTransaction(),																	                                    
																	   AddToSuperFile,
																	   FileServices.FinishSuperFileTransaction()
																		);
	return doallarr;

end;

end; 

