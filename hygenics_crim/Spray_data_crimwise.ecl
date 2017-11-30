// EXPORT spray_data_new := 'todo';
 IMPORT lib_stringlib, lib_fileservices, _control,digssoff;

export spray_data_crimwise  := MODULE 

	export srcIP       := 'bctlpedata11.risk.regn.net';
	export targetGrp   := 'thor400_44';
	export src_root    := '/data/stub_cleaning/court/hygenics/criminal/';
	
	sourceCsvSeparater := '\\,';
	sourceCsvTeminater := '\\n,\\r\\n';
	sourceCsvQuote     := '';
	
	export  Fun_SprayFile(String remoteFileName, String OPFileName, String RemoteLoc) := 	
	                                          
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
																														    true,
																																true);
																											 

export DOC_def (string p_date, string p_source)  := FUNCTION
 docRemoteLoc := src_root+p_date+'/doc/'; 
 doc_file     := p_source;
 docSprayed   := 'HD_DOC_DEFENDANT'+'_'+p_date+'_CW';
																	                       									
doall :=    sequential( Fun_Sprayfile(doc_file,docSprayed,docRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions.Fun_AddToSuperfile(docSprayed ,'~thor_200::in::crim::HD::DOC_DEFENDANT_CW');
											  FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export DOC_off (string p_date, string p_source)  := FUNCTION
 docRemoteLoc := src_root+p_date+'/doc/'; 
 doc_file     := p_source;
 docSprayed   := 'HD_DOC_OFFENSE'+'_'+p_date+'_CW';
																												
                          
doall :=    sequential( Fun_Sprayfile(doc_file,docSprayed,docRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(docSprayed,'~thor_200::in::crim::HD::DOC_OFFENSE_CW'),
											  FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export DOC_chg (string p_date, string p_source)  := FUNCTION
 docRemoteLoc := src_root+p_date+'/doc/'; 
 doc_file     := p_source;
 docSprayed   := 'HD_DOC_CHARGE'+ '_'+p_date+'_CW'; 
                          
 doall :=    sequential( Fun_Sprayfile(doc_file,docSprayed,docRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(docSprayed,'~thor_200::in::crim::HD::DOC_CHARGE_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export DOC_alias (string p_date, string p_source)  := FUNCTION
 docRemoteLoc := src_root+p_date+'/doc/'; 
 doc_file     := p_source;
 docSprayed   := 'HD_DOC_ALIAS'+ '_'+p_date+'_CW'; 
                          
 doall :=    sequential( Fun_Sprayfile(doc_file,docSprayed,docRemoteLoc),
												FileServices.StartSuperFileTransaction(),
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(docSprayed ,'~thor_200::in::crim::HD::DOC_ALIAS_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export DOC_pri (string p_date, string p_source)  := FUNCTION
 docRemoteLoc := src_root+p_date+'/doc/'; 
 doc_file     := p_source;
 docSprayed   := 'HD_DOC_PRIOR'+ '_'+p_date+'_CW';  
                          
 doall :=    sequential( Fun_Sprayfile(doc_file,docSprayed,docRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(docSprayed ,'~thor_200::in::crim::HD::DOC_PRIOR_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export DOC_oth (string p_date, string p_source)  := FUNCTION
 docRemoteLoc := src_root+p_date+'/doc/'; 
 doc_file     := p_source;
 docSprayed   := 'HD_DOC_OTHER'+ '_'+p_date+'_CW'; 
                          
 doall :=    sequential( Fun_Sprayfile(doc_file,docSprayed,docRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(docSprayed ,'~thor_200::in::crim::HD::DOC_OTHER_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export DOC_Sent (string p_date, string p_source)  := FUNCTION
 docRemoteLoc := src_root+p_date+'/doc/'; 
 doc_file     := p_source;
 docSprayed   := 'HD_DOC_SENTENCE'+ '_'+p_date+'_CW';  
                          
 doall :=    sequential( Fun_Sprayfile(doc_file,docSprayed,docRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
                        digssoff.SuperFile_Functions .Fun_AddToSuperfile(docSprayed ,'~thor_200::in::crim::HD::DOC_SENTENCE_CW'),												
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export DOC_pho (string p_date, string p_source)  := FUNCTION
 docRemoteLoc := src_root+p_date+'/doc/'; 
 doc_file     := p_source;
 docSprayed   := 'HD_DOC_PHONE_HISTORY'+ '_'+p_date+'_CW';  
																												
                          
doall :=    sequential( Fun_Sprayfile(doc_file,docSprayed,docRemoteLoc),
												FileServices.StartSuperFileTransaction(),	
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(docSprayed ,'~thor_200::in::crim::HD::DOC_PHONE_HISTORY_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export DOC_add (string p_date, string p_source)  := FUNCTION
 docRemoteLoc := src_root+p_date+'/doc/'; 
 doc_file     := p_source;
 docSprayed   := 'HD_DOC_ADDRESS_HISTORY'+ '_'+p_date+'_CW'; 
																												
                          
doall :=    sequential( Fun_Sprayfile(doc_file,docSprayed,docRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(docSprayed ,'~thor_200::in::crim::HD::DOC_ADDRESS_HISTORY_CW'),
											  FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

//county

export county_def (string p_date, string p_source)  := FUNCTION
 COUNTYRemoteLoc := src_root+p_date+'/cty/'; 
 COUNTY_file     := p_source;
 COUNTYSprayed   := /*COUNTY_file*/ 'HD_COUNTY_DEFENDANT'+'_'+p_date+'_CW'; 
																	                       									
doall :=    sequential( Fun_Sprayfile(COUNTY_file,COUNTYSprayed,COUNTYRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions.Fun_AddToSuperfile(COUNTYSprayed ,'~thor_200::in::crim::HD::COUNTY_DEFENDANT_CW'),
											  FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export COUNTY_off (string p_date, string p_source)  := FUNCTION
 COUNTYRemoteLoc := src_root+p_date+'/cty/'; 
 COUNTY_file     := p_source;
 COUNTYSprayed   := 'HD_COUNTY_OFFENSE'+'_'+p_date+'_CW'; 
																												
                          
doall :=    sequential( Fun_Sprayfile(COUNTY_file,COUNTYSprayed,COUNTYRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(COUNTYSprayed,'~thor_200::in::crim::HD::COUNTY_OFFENSE_CW'),
											  FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export COUNTY_chg (string p_date, string p_source)  := FUNCTION
 COUNTYRemoteLoc := src_root+p_date+'/cty/'; 
 COUNTY_file     := p_source;
 COUNTYSprayed   := 'HD_COUNTY_CHARGE'+ '_'+p_date+'_CW'; 
                          
 doall :=    sequential( Fun_Sprayfile(COUNTY_file,COUNTYSprayed,COUNTYRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(COUNTYSprayed,'~thor_200::in::crim::HD::COUNTY_CHARGE_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export COUNTY_alias (string p_date, string p_source)  := FUNCTION
 COUNTYRemoteLoc := src_root+p_date+'/cty/'; 
 COUNTY_file     := p_source;
 COUNTYSprayed   := 'HD_COUNTY_ALIAS'+ '_'+p_date+'_CW'; 
                          
 doall :=    sequential( Fun_Sprayfile(COUNTY_file,COUNTYSprayed,COUNTYRemoteLoc),
												FileServices.StartSuperFileTransaction(),
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(COUNTYSprayed ,'~thor_200::in::crim::HD::COUNTY_ALIAS_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export COUNTY_pri (string p_date, string p_source)  := FUNCTION
 COUNTYRemoteLoc := src_root+p_date+'/cty/'; 
 COUNTY_file     := p_source;
 COUNTYSprayed   := 'HD_COUNTY_PRIOR'+'_'+p_date+'_CW'; 
                          
 doall :=    sequential( Fun_Sprayfile(COUNTY_file,COUNTYSprayed,COUNTYRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(COUNTYSprayed ,'~thor_200::in::crim::HD::COUNTY_PRIOR_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export COUNTY_oth (string p_date, string p_source)  := FUNCTION
 COUNTYRemoteLoc := src_root+p_date+'/cty/'; 
 COUNTY_file     := p_source;
 COUNTYSprayed   := 'HD_COUNTY_OTHER'+ '_'+p_date+'_CW'; 
                          
 doall :=    sequential( Fun_Sprayfile(COUNTY_file,COUNTYSprayed,COUNTYRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(COUNTYSprayed ,'~thor_200::in::crim::HD::COUNTY_OTHER_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export COUNTY_Sent (string p_date, string p_source)  := FUNCTION
 COUNTYRemoteLoc := src_root+p_date+'/cty/'; 
 COUNTY_file     := p_source;
 COUNTYSprayed   := 'HD_COUNTY_SENTENCE'+ '_'+p_date+'_CW'; 
                          
 doall :=    sequential( Fun_Sprayfile(COUNTY_file,COUNTYSprayed,COUNTYRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
                        digssoff.SuperFile_Functions .Fun_AddToSuperfile(COUNTYSprayed ,'~thor_200::in::crim::HD::COUNTY_SENTENCE_CW'),												
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export COUNTY_pho (string p_date, string p_source)  := FUNCTION
 COUNTYRemoteLoc := src_root+p_date+'/cty/'; 
 COUNTY_file     := p_source;
 COUNTYSprayed   := 'HD_COUNTY_PHONE_HISTORY'+ '_'+p_date+'_CW'; 
																												
                          
doall :=    sequential( Fun_Sprayfile(COUNTY_file,COUNTYSprayed,COUNTYRemoteLoc),
												FileServices.StartSuperFileTransaction(),	
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(COUNTYSprayed ,'~thor_200::in::crim::HD::COUNTY_PHONE_HISTORY_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export COUNTY_add (string p_date, string p_source)  := FUNCTION
 COUNTYRemoteLoc := src_root+p_date+'/cty/'; 
 COUNTY_file     := p_source;
 COUNTYSprayed   := 'HD_COUNTY_ADDRESS_HISTORY'+ '_'+p_date+'_CW'; 
																												
                          
doall :=    sequential( Fun_Sprayfile(COUNTY_file,COUNTYSprayed,COUNTYRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(COUNTYSprayed ,'~thor_200::in::crim::HD::COUNTY_ADDRESS_HISTORY_CW'),
											  FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

//aocs

export aoc_def (string p_date, string p_source)  := FUNCTION
 aocRemoteLoc := src_root+p_date+'/aoc/'; 
 aoc_file     := p_source;
 aocSprayed   := 'HD_AOC_DEFENDANT'+'_'+p_date+'_CW';
																	                       									
doall :=    sequential( Fun_Sprayfile(aoc_file,aocSprayed,aocRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions.Fun_AddToSuperfile(aocSprayed ,'~thor_200::in::crim::HD::aoc_DEFENDANT_CW'),
											  FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export aoc_off (string p_date, string p_source)  := FUNCTION
 aocRemoteLoc := src_root+p_date+'/aoc/'; 
 aoc_file     := p_source;
 aocSprayed   := 'HD_AOC_OFFENSE'+'_'+p_date+'_CW';
																												
                          
doall :=    sequential( Fun_Sprayfile(aoc_file,aocSprayed,aocRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(aocSprayed,'~thor_200::in::crim::HD::aoc_OFFENSE_CW'),
											  FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export aoc_chg (string p_date, string p_source)  := FUNCTION
 aocRemoteLoc := src_root+p_date+'/aoc/'; 
 aoc_file     := p_source;
 aocSprayed   := 'HD_AOC_CHARGE'+ '_'+p_date+'_CW'; 
                          
 doall :=    sequential( Fun_Sprayfile(aoc_file,aocSprayed,aocRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(aocSprayed,'~thor_200::in::crim::HD::aoc_CHARGE_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export aoc_alias (string p_date, string p_source)  := FUNCTION
 aocRemoteLoc := src_root+p_date+'/aoc/'; 
 aoc_file     := p_source;
 aocSprayed   := 'HD_AOC_ALIAS'+ '_'+p_date+'_CW';
                          
 doall :=    sequential( Fun_Sprayfile(aoc_file,aocSprayed,aocRemoteLoc),
												FileServices.StartSuperFileTransaction(),
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(aocSprayed ,'~thor_200::in::crim::HD::aoc_ALIAS_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export aoc_pri (string p_date, string p_source)  := FUNCTION
 aocRemoteLoc := src_root+p_date+'/aoc/'; 
 aoc_file     := p_source;
 aocSprayed   := 'HD_AOC_PRIOR'+ '_'+p_date+'_CW';
                          
 doall :=    sequential( Fun_Sprayfile(aoc_file,aocSprayed,aocRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(aocSprayed ,'~thor_200::in::crim::HD::aoc_PRIOR_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export aoc_oth (string p_date, string p_source)  := FUNCTION
 aocRemoteLoc := src_root+p_date+'/aoc/'; 
 aoc_file     := p_source;
 aocSprayed   := 'HD_AOC_OTHER'+ '_'+p_date+'_CW'; 
                          
 doall :=    sequential( Fun_Sprayfile(aoc_file,aocSprayed,aocRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(aocSprayed ,'~thor_200::in::crim::HD::aoc_OTHER_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export aoc_Sent (string p_date, string p_source)  := FUNCTION
 aocRemoteLoc := src_root+p_date+'/aoc/'; 
 aoc_file     := p_source;
 aocSprayed   := 'HD_AOC_SENTENCE'+ '_'+p_date+'_CW'; 
                          
 doall :=    sequential( Fun_Sprayfile(aoc_file,aocSprayed,aocRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
                        digssoff.SuperFile_Functions .Fun_AddToSuperfile(aocSprayed ,'~thor_200::in::crim::HD::aoc_SENTENCE_CW'),												
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export aoc_pho (string p_date, string p_source)  := FUNCTION
 aocRemoteLoc := src_root+p_date+'/aoc/'; 
 aoc_file     := p_source;
 aocSprayed   := 'HD_AOC_PHONE_HISTORY'+ '_'+p_date+'_CW'; 
																												
                          
doall :=    sequential( Fun_Sprayfile(aoc_file,aocSprayed,aocRemoteLoc),
												FileServices.StartSuperFileTransaction(),	
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(aocSprayed ,'~thor_200::in::crim::HD::aoc_PHONE_HISTORY_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export aoc_add (string p_date, string p_source)  := FUNCTION
 aocRemoteLoc := src_root+p_date+'/aoc/'; 
 aoc_file     := p_source;
 aocSprayed   := 'HD_AOC_ADDRESS_HISTORY'+ '_'+p_date+'_CW';  
																												
                          
doall :=    sequential( Fun_Sprayfile(aoc_file,aocSprayed,aocRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(aocSprayed ,'~thor_200::in::crim::HD::aoc_ADDRESS_HISTORY_CW'),
											  FileServices.FinishSuperFileTransaction()
											);
return doall;
end;


//arrest

export arrest_def (string p_date, string p_source)  := FUNCTION
 arrestRemoteLoc := src_root+p_date+'/arrest/'; 
 arrest_file     := p_source;
 arrestSprayed   := 'HD_ARREST_DEFENDANT'+'_'+p_date+'_CW';
 //arrest_file +'ARR_DEF_'+p_date;  - Use this if we go back to spraying separately
																	                       									
doall :=    sequential( Fun_Sprayfile(arrest_file,arrestSprayed,arrestRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions.Fun_AddToSuperfile(arrestSprayed ,'~thor_200::in::crim::HD::arrest_DEFENDANT_CW'),
											  FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export arrest_off (string p_date, string p_source)  := FUNCTION
 arrestRemoteLoc := src_root+p_date+'/arrest/'; 
 arrest_file     := p_source;
 arrestSprayed   := 'HD_ARREST_OFFENSE'+'_'+p_date+'_CW';
 //arrest_file +'ARR_OFF_'+p_date; 
																												
                          
doall :=    sequential( Fun_Sprayfile(arrest_file,arrestSprayed,arrestRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(arrestSprayed,'~thor_200::in::crim::HD::arrest_OFFENSE_CW'),
											  FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export arrest_chg (string p_date, string p_source)  := FUNCTION
 arrestRemoteLoc := src_root+p_date+'/arrest/'; 
 arrest_file     := p_source;
 arrestSprayed   := 'HD_ARREST_CHARGE'+ '_'+p_date+'_CW'; 
 //arrest_file +'ARR_CHG_'+p_date; 
                          
 doall :=    sequential( Fun_Sprayfile(arrest_file,arrestSprayed,arrestRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(arrestSprayed,'~thor_200::in::crim::HD::arrest_CHARGE_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export arrest_alias (string p_date, string p_source)  := FUNCTION
 arrestRemoteLoc := src_root+p_date+'/arrest/'; 
 arrest_file     := p_source;
 arrestSprayed   := 'HD_ARREST_ALIAS'+ '_'+p_date+'_CW';
//arrest_file +'ARR_ALI_'+p_date; 
                          
 doall :=    sequential( Fun_Sprayfile(arrest_file,arrestSprayed,arrestRemoteLoc),
												FileServices.StartSuperFileTransaction(),
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(arrestSprayed ,'~thor_200::in::crim::HD::arrest_ALIAS_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export arrest_pri (string p_date, string p_source)  := FUNCTION
 arrestRemoteLoc := src_root+p_date+'/arrest/'; 
 arrest_file     := p_source;
 arrestSprayed   := 'HD_ARREST_PRIOR'+ '_'+p_date+'_CW';
 //arrest_file +'ARR_PRI_'+p_date; 
                          
 doall :=    sequential( Fun_Sprayfile(arrest_file,arrestSprayed,arrestRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(arrestSprayed ,'~thor_200::in::crim::HD::arrest_PRIOR_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export arrest_oth (string p_date, string p_source)  := FUNCTION
 arrestRemoteLoc := src_root+p_date+'/arrest/'; 
 arrest_file     := p_source;
 arrestSprayed   := 'HD_ARREST_OTHER'+ '_'+p_date+'_CW';
 //arrest_file +'ARR_OTH_'+p_date; 
                          
 doall :=    sequential( Fun_Sprayfile(arrest_file,arrestSprayed,arrestRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(arrestSprayed ,'~thor_200::in::crim::HD::arrest_OTHER_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export arrest_Sent (string p_date, string p_source)  := FUNCTION
 arrestRemoteLoc := src_root+p_date+'/arrest/'; 
 arrest_file     := p_source;
 arrestSprayed   := 'HD_ARREST_SENTENCE'+ '_'+p_date+'_CW';
 //arrest_file +'ARR_SEN_'+p_date; 
                          
 doall :=    sequential( Fun_Sprayfile(arrest_file,arrestSprayed,arrestRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
                        digssoff.SuperFile_Functions .Fun_AddToSuperfile(arrestSprayed ,'~thor_200::in::crim::HD::arrest_SENTENCE_CW'),												
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export arrest_pho (string p_date, string p_source)  := FUNCTION
 arrestRemoteLoc := src_root+p_date+'/arrest/'; 
 arrest_file     := p_source;
 arrestSprayed   := 'HD_ARREST_PHONE_HISTORY'+ '_'+p_date+'_CW';
 //arrest_file +'ARR_PHO_'+p_date; 
																												
                          
doall :=    sequential( Fun_Sprayfile(arrest_file,arrestSprayed,arrestRemoteLoc),
												FileServices.StartSuperFileTransaction(),	
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(arrestSprayed ,'~thor_200::in::crim::HD::arrest_PHONE_HISTORY_CW'),
												FileServices.FinishSuperFileTransaction()
											);
return doall;
end;

export arrest_add (string p_date, string p_source)  := FUNCTION
 arrestRemoteLoc := src_root+p_date+'/arrest/'; 
 arrest_file     := p_source;
 arrestSprayed   := 'HD_ARREST_ADDRESS_HISTORY'+ '_'+p_date+'_CW';  
																												
                          
doall :=    sequential( Fun_Sprayfile(arrest_file,arrestSprayed,arrestRemoteLoc),
												FileServices.StartSuperFileTransaction(),																	                                    
												digssoff.SuperFile_Functions .Fun_AddToSuperfile(arrestSprayed ,'~thor_200::in::crim::HD::arrest_ADDRESS_HISTORY_CW'),
											  FileServices.FinishSuperFileTransaction()
											);
return doall;
end;
end; 

