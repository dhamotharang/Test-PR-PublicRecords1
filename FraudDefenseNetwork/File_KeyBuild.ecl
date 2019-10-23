IMPORT ut, Std, FraudShared;

EXPORT File_KeyBuild (
dataset(FraudShared.Layouts.Base.Main)										pBaseMainBuilt									= FraudShared.Files().Base.Main.Built ) 
:= 
Function 

  BaseMain              := pBaseMainBuilt(Record_id != 0); 	

  Outfile               := BaseMain (  (source= 'GLB5'  and Reported_Date between   ut.getDateOffset(-Mod_MbsContext.Glb5Expdays) and ut.getDateOffset(-180)) or
								                       (source= 'TIGER' and     Event_Date between  ut.getDateOffset(-Mod_MbsContext.TigerExpdays) and (STRING8)Std.Date.Today())  or
																			 (source= 'CFNA'   and   Event_Date between ut.getDateOffset(-Mod_MbsContext.CfnaExpdays) and (STRING8)Std.Date.Today())  or
																			 (source= 'ADDRESSINSPECTION'   and Reported_Date between  ut.getDateOffset(-Mod_MbsContext.AInspectionExpdays) and (STRING8)Std.Date.Today())or
																			 (source= 'SUSPECTIPADDRESS'   and Reported_Date between  ut.getDateOffset(-Mod_MbsContext.SuspectIPExpdays) and (STRING8)Std.Date.Today()) or
																			 (source= 'TEXTMINEDCRIM'   and Event_Date between  ut.getDateOffset(-Mod_MbsContext.TextMinedCrimExpdays) and (STRING8)Std.Date.Today()) or
																			 (if(Mod_MbsContext.OIGIndividualExpdays =9999, source= 'OIG_INDIVIDUAL',   (source= 'OIG_INDIVIDUAL' and Event_Date between  ut.getDateOffset(-Mod_MbsContext.OIGIndividualExpdays) and (STRING8)Std.Date.Today()))) or
																			 (if(Mod_MbsContext.OIGBusinessExpdays =9999, source= 'OIG_BUSINESS',   (source= 'OIG_BUSINESS' and Event_Date between  ut.getDateOffset(-Mod_MbsContext.OIGBusinessExpdays) and (STRING8)Std.Date.Today()))) or
																			 (source= 'ERIE' and (did>0 or seleid>0 or orgid>0 or ultid>0) and classification_Entity.Entity_sub_type ='' and (Event_Date between  ut.getDateOffset(-Mod_MbsContext.ErieExpdays) and (STRING8)Std.Date.Today())) or 
																			 (if(Mod_MbsContext.ErieWatchListExpdays =9999,(source= 'ERIE_WATCHLIST' and (did>0 or seleid>0 or orgid>0 or ultid>0) and (classification_Entity.Entity_type ='PERSON' or classification_Entity.Entity_type ='BUSINESS')),  
																			    (source= 'ERIE_WATCHLIST' and (did>0 or seleid>0 or orgid>0 or ultid>0) and  ( classification_Entity.Entity_type ='PERSON' or classification_Entity.Entity_type ='BUSINESS') and (reported_date between  ut.getDateOffset(-Mod_MbsContext.ErieWatchListExpdays) and (STRING8)Std.Date.Today())))) or 
																			 (if(Mod_MbsContext.ErieNICBWatchListExpdays =9999,(source= 'ERIE_NICB_WATCHLIST' and (did>0 or seleid>0 or orgid>0 or ultid>0) and ( classification_Entity.Entity_type ='PERSON' or classification_Entity.Entity_type ='BUSINESS')),  
																			    (source= 'ERIE_NICB_WATCHLIST' and (did>0 or seleid>0 or orgid>0 or ultid>0) and ( classification_Entity.Entity_type ='PERSON' or classification_Entity.Entity_type ='BUSINESS') and (reported_date between  ut.getDateOffset(-Mod_MbsContext.ErieNICBWatchListExpdays) and (STRING8)Std.Date.Today()))))
																		);


	DpatchGLB5did   := project ( Outfile , transform (FraudShared.Layouts.KeyBuild, 
	                            self.did  := if(left.source = 'GLB5' and left.did =0, left.Rawlinkid , left.did ); 
                              self      := left ; 
															)); 
															
	FinalValidRecs := DpatchGLB5did (~(did <> 0 and raw_first_name ='' and raw_last_name ='' and street_1 =''));	// CR 328	
													
												
 return FinalValidRecs ;

end; 