Import INQL_FFD, PromoteSupers;

EXPORT Fn_Consolidate_Input_Files(boolean isUpdate = true, boolean isFCRA = true, 	string pVersion = '') := function

  InBuilt 	:= Files(isUpdate, isFCRA, pVersion).InputBuilding;
  hist  		:= Files(isUpdate, isFCRA, pVersion).InputHistory;

  filedate 	:= Fn_Get_Current_Version.fcra_input;

	curr 	:= PROJECT(inBuilt,TRANSFORM(layouts.Input_History,
																				SELF.first_filedate  := (unsigned)filedate;
																				SELF.last_filedate   := (unsigned)filedate;
																				SELF := LEFT;
																				SELF := [];
												             )
									);
										
	DS		:= hist + curr;
	
	ds t(ds L, ds R) := TRANSFORM
    SELF.last_filedate := if(L.last_filedate > R.last_filedate, L.last_filedate, R.last_filedate);
    SELF := L;
  END; 
    
  rolledDS := distribute(ROLLUP(DS, t(LEFT, RIGHT), record, except first_filedate, last_filedate));
															
	PromoteSupers.MAC_SF_BuildProcess(
	                                  rolledDS 																					 	//thedataset
																	 ,filenames(isUpdate, isFCRA, pVersion).InputHistory 	//basename
																	 ,DoIt 																								//seq_name
																	 ,2 																									//numgenerations
																	 ,true 																								//csvout
																	 ,true 																								//pCompress
																	 ,filedate 																						//pVersion
																	 ,'|\t|' 																							//pSeparator
																	 ,       																							//pQuote
																	 ,'|\n'  																							//pTerminator
																	 ,0      																							//pHeading
																	 );
	PostIt := sequential(DoIt);

 return postIT;

end;