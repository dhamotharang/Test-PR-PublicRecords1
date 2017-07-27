import ut, risk_indicators, Models, riskwise, easi;

export AMLRollAttributes(Grouped DATASET(risk_indicators.layout_bocashell_neutral) AMLAttrib) := FUNCTION



IndRecs  := AMLAttrib(~isrelat);
RelatRecs  := AMLAttrib(isrelat);


risk_indicators.layout_bocashell_neutral  GetRelatIndex(RelatRecs le)   := TRANSFORM
   
    AMLAttr := AMLAttributesMaster(le );
		self.RelIndCitizenshipIndex :=  AMLattr.RelIndCitizenshipIndex;								
		self.RelIndMobilityIndex :=  AMLattr.RelIndMobilityIndex;
		self.RelIndLegalEventsIndex :=  AMLattr.RelIndLegalEventsIndex;
		self.RelIndAccesstoFundsIndex := AMLattr.RelIndAccesstoFundsIndex;
		self.RelIndBusAssocIndex := AMLattr.RelIndBusAssocIndex;
		self.RelIndHighValAssetsIndex := AMLattr.RelIndHighValAssetsIndex;
		self.RelIndGeogIndex := AMLattr.RelIndGeogIndex;
		self.RelIndAgeIndex := AMLattr.RelIndAgeIndex;
		self := le;
	END;
	

RelatIndex := project(RelatRecs, GetRelatIndex(left));

AddIndBack := join(AMLAttrib, RelatIndex, 
									 right.seq = left.seq and
									 right.did = left.did,
									 Transform(risk_indicators.layout_bocashell_neutral, 
												self.RelIndCitizenshipIndex :=  right.RelIndCitizenshipIndex,								
												self.RelIndMobilityIndex :=  right.RelIndMobilityIndex,
												self.RelIndLegalEventsIndex :=  right.RelIndLegalEventsIndex,
												self.RelIndAccesstoFundsIndex := right.RelIndAccesstoFundsIndex,
												self.RelIndBusAssocIndex := right.RelIndBusAssocIndex,
												self.RelIndHighValAssetsIndex := right.RelIndHighValAssetsIndex,
												self.RelIndGeogIndex := right.RelIndGeogIndex,
												self.RelIndAgeIndex := right.RelIndAgeIndex,
												self := left),
										left outer);


Layouts.AMLAssocIndexLayout SetCountsIndex(AddIndBack le) := Transform

  self.seq 															:= le.seq;
	self.did                              := le.did;
	self.CLAMdid                          := le.shell_input.did;
	self.isrelat                          := le.isrelat;
	self.RelIndCitizenshipIndex5Count     := if((unsigned3)le.RelIndCitizenshipIndex = 5, 1,0) ;
	self.RelIndCitizenshipIndex6Count     := if((unsigned3)le.RelIndCitizenshipIndex = 6, 1,0) ;
	self.RelIndCitizenshipIndex7Count     := if((unsigned3)le.RelIndCitizenshipIndex = 7, 1,0) ;
	self.RelIndCitizenshipIndex8Count     := if((unsigned3)le.RelIndCitizenshipIndex = 8, 1,0) ;
	self.RelIndCitizenshipIndex9Count     := if((unsigned3)le.RelIndCitizenshipIndex = 9, 1,0) ;
	self.RelIndMobilityIndex5Count        := if((unsigned3)le.RelIndMobilityIndex = 5, 1,0) ;
	self.RelIndMobilityIndex6Count  			 := if((unsigned3)le.RelIndMobilityIndex = 6, 1,0) ;
	self.RelIndMobilityIndex7Count				 := if((unsigned3)le.RelIndMobilityIndex = 7, 1,0) ;
	self.RelIndMobilityIndex8Count				 := if((unsigned3)le.RelIndMobilityIndex = 8, 1,0) ;
	self.RelIndMobilityIndex9Count				 := if((unsigned3)le.RelIndMobilityIndex = 9, 1,0) ;
	self.RelIndLegalEventsIndex5Count				 := if((unsigned3)le.RelIndLegalEventsIndex = 5, 1,0) ;
	self.RelIndLegalEventsIndex6Count				 := if((unsigned3)le.RelIndLegalEventsIndex = 6, 1,0) ;
	self.RelIndLegalEventsIndex7Count				 := if((unsigned3)le.RelIndLegalEventsIndex = 7, 1,0) ;
	self.RelIndLegalEventsIndex8Count				 := if((unsigned3)le.RelIndLegalEventsIndex = 8, 1,0) ;
	self.RelIndLegalEventsIndex9Count				 := if((unsigned3)le.RelIndLegalEventsIndex = 9, 1,0) ;
	self.RelIndAccesstoFundsIndex5Count			 := if((unsigned3)le.RelIndAccesstoFundsIndex = 5, 1,0) ;
	self.RelIndAccesstoFundsIndex6Count			 := if((unsigned3)le.RelIndAccesstoFundsIndex = 6, 1,0) ;
	self.RelIndAccesstoFundsIndex7Count			 := if((unsigned3)le.RelIndAccesstoFundsIndex = 7, 1,0) ;
	self.RelIndAccesstoFundsIndex8Count			 := if((unsigned3)le.RelIndAccesstoFundsIndex = 8, 1,0) ;
	self.RelIndAccesstoFundsIndex9Count			 := if((unsigned3)le.RelIndAccesstoFundsIndex = 9, 1,0) ;
	self.RelIndBusAssocIndex5Count					 := if((unsigned3)le.RelIndBusAssocIndex = 5, 1,0) ;
	self.RelIndBusAssocIndex6Count					 := if((unsigned3)le.RelIndBusAssocIndex = 6, 1,0) ;
	self.RelIndBusAssocIndex7Count					 := if((unsigned3)le.RelIndBusAssocIndex = 7, 1,0) ;
	self.RelIndBusAssocIndex8Count						 := if((unsigned3)le.RelIndBusAssocIndex = 8, 1,0) ;
	self.RelIndBusAssocIndex9Count						 := if((unsigned3)le.RelIndBusAssocIndex = 9, 1,0) ;
	self.RelIndHighValAssetsIndex5Count				:= if((unsigned3)le.RelIndHighValAssetsIndex = 5, 1,0) ;
	self.RelIndHighValAssetsIndex6Count				:= if((unsigned3)le.RelIndHighValAssetsIndex = 6, 1,0) ;
	self.RelIndHighValAssetsIndex7Count				:= if((unsigned3)le.RelIndHighValAssetsIndex = 7, 1,0) ;
	self.RelIndHighValAssetsIndex8Count				:= if((unsigned3)le.RelIndHighValAssetsIndex = 8, 1,0) ;
	self.RelIndHighValAssetsIndex9Count				:= if((unsigned3)le.RelIndHighValAssetsIndex = 9, 1,0) ;
	self.RelIndGeogIndex5Count								:= if((unsigned3)le.RelIndGeogIndex = 5, 1,0) ;
	self.RelIndGeogIndex6Count								:= if((unsigned3)le.RelIndGeogIndex = 6, 1,0) ;
	self.RelIndGeogIndex7Count								:= if((unsigned3)le.RelIndGeogIndex = 7, 1,0) ;
	self.RelIndGeogIndex8Count								:= if((unsigned3)le.RelIndGeogIndex = 8, 1,0) ;
	self.RelIndGeogIndex9Count								:= if((unsigned3)le.RelIndGeogIndex = 9, 1,0) ;
	self.RelIndAssocIndex											:= 0;
	self.RelIndAgeIndex5Count								:= if((unsigned3)le.RelIndAgeIndex = 5, 1,0) ;
	self.RelIndAgeIndex6Count							  := if((unsigned3)le.RelIndAgeIndex = 6, 1,0) ;
	self.RelIndAgeIndex7Count								:= if((unsigned3)le.RelIndAgeIndex = 7, 1,0) ;
	self.RelIndAgeIndex8Count								:= if((unsigned3)le.RelIndAgeIndex = 8, 1,0) ;
	self.RelIndAgeIndex9Count								:= if((unsigned3)le.RelIndAgeIndex = 9, 1,0) ;
	
END;

RelatIndexCnt := project(AddIndBack, SetCountsIndex(left));

RelatIndexS := sort(RelatIndexCnt, seq, did);

IndexCountLayout := record
  unsigned4  seq;
	unsigned6  did;
	unsigned6  CLAMdid;
	boolean    isrelat;
  unsigned3  index5Count;
  unsigned3  index6Count;
  unsigned3  index7Count;
  unsigned3  index8Count;
  unsigned3  index9Count;
	unsigned3  SupsIndexGE8Count;
	
END;

IndexCountLayout IndexTotal(RelatIndexS le) := Transform

  self.seq 															:= le.seq;
	self.did                              := le.did;
	self.CLAMdid                          := le.CLAMdid;
	self.isrelat                          := le.isrelat;
	self.index5Count     := le.RelIndCitizenshipIndex5Count + le.RelIndMobilityIndex5Count + le.RelIndLegalEventsIndex5Count + 
	                        le.RelIndAccesstoFundsIndex5Count + le.RelIndBusAssocIndex5Count + le.RelIndHighValAssetsIndex5Count +
													le.RelIndGeogIndex5Count + le.RelIndAgeIndex5Count;
													
	self.index6Count     := le.RelIndCitizenshipIndex6Count + le.RelIndMobilityIndex6Count + le.RelIndLegalEventsIndex6Count + 
	                        le.RelIndAccesstoFundsIndex6Count + le.RelIndBusAssocIndex6Count + le.RelIndHighValAssetsIndex6Count +
													le.RelIndGeogIndex6Count + le.RelIndAgeIndex6Count;
	
	self.index7Count     := le.RelIndCitizenshipIndex7Count + le.RelIndMobilityIndex7Count + le.RelIndLegalEventsIndex7Count + 
	                        le.RelIndAccesstoFundsIndex7Count + le.RelIndBusAssocIndex7Count + le.RelIndHighValAssetsIndex7Count +
													le.RelIndGeogIndex7Count + le.RelIndAgeIndex7Count;
	
	self.index8Count     := le.RelIndCitizenshipIndex8Count + le.RelIndMobilityIndex8Count + le.RelIndLegalEventsIndex8Count + 
	                        le.RelIndAccesstoFundsIndex8Count + le.RelIndBusAssocIndex8Count + le.RelIndHighValAssetsIndex8Count +
													le.RelIndGeogIndex8Count + le.RelIndAgeIndex8Count;
	
	self.index9Count     := le.RelIndCitizenshipIndex9Count + le.RelIndMobilityIndex9Count + le.RelIndLegalEventsIndex9Count + 
	                        le.RelIndAccesstoFundsIndex9Count + le.RelIndBusAssocIndex9Count + le.RelIndHighValAssetsIndex9Count +
													le.RelIndGeogIndex9Count + le.RelIndAgeIndex9Count;
													
	self.SupsIndexGE8Count  :=  le.RelIndLegalEventsIndex9Count + le.RelIndLegalEventsIndex8Count;
	
	
END;

RelatCombineInd := project(RelatIndexS, IndexTotal(left));

tableLayout := record
	unsigned4 seq;
	unsigned6 CLAMdid;
	unsigned4 TotRelCount := Count(group);
END;

													
CountRelat := table(AMLAttrib(isrelat), { seq , 
																					CLAMdid := shell_input.did, 
																					TotRelCount := Count(group)}, 
																					seq,shell_input.did);
																					
  
																					
RelatLayout := Record
	IndexCountLayout;
	unsigned4  IndGE8CountGE4;
	unsigned4  IndGE8CountGE0;
  unsigned4  IndGE7Count;
  unsigned4  IndGE5Count;
  unsigned4  TotRelCount;
	string     IndAssociatesIndex;
	
END;
	
										 


RelatLayout CntIndexes(RelatCombineInd le)  := TRANSFORM
  self.IndGE8CountGE0  := if(le.index8Count > 0 or  le.index9Count > 0, 1, 0);
  self.IndGE8CountGE4  := if((le.index8Count + le.index9Count) >= 4, 1, 0);
	self.IndGE7Count  := if(le.index7Count + le.index8Count + le.index9Count >= 3, 1, 0);
	self.IndGE5Count  := if(le.index5Count + le.index6Count + le.index7Count + le.index8Count + le.index9Count > 0, 1, 0);
	self.TotRelCount  := 0;
	self.IndAssociatesIndex    := '';
	self   := le;
End;

IndxSmmry := project(RelatCombineInd, CntIndexes(left));

RelatLayout RollupIndexCount(IndxSmmry le, IndxSmmry ri) := Transform
  self.seq 						 := le.seq;
	self.did             := le.did;
	self.CLAMdid         := le.CLAMdid;
	self.isrelat         := le.isrelat;
	self.index5Count     := le.index5Count + ri.index5Count ;
	self.index6Count     := le.index6Count + ri.index6Count ;
	self.index7Count     := le.index7Count + ri.index7Count ;
	self.index8Count     := le.index8Count + ri.index8Count ;
	self.index9Count     := le.index9Count + ri.index9Count ;
	self.IndGE8CountGE0  := le.IndGE8CountGE0 + ri.IndGE8CountGE0;
	self.IndGE8CountGE4  := le.IndGE8CountGE4 + ri.IndGE8CountGE4;
	self.IndGE7Count     := le.IndGE7Count + ri.IndGE7Count;
	self.IndGE5Count   := le.IndGE5Count + ri.IndGE5Count;
	self.TotRelCount     := 0;
	self.IndAssociatesIndex    := '';
  self.SupsIndexGE8Count  := 	le.SupsIndexGE8Count + ri.SupsIndexGE8Count;

	
END;
	
RelatIndexTotals := rollup(IndxSmmry, left.seq=right.seq and left.CLAMdid=right.CLAMdid, RollupIndexCount(left, right));

RelatLayout AddRelCount(	RelatIndexTotals le, CountRelat ri) := TRANSFORM
   self.seq    								:= le.seq;
	 self.CLAMdid   						:= le.CLAMdid;
	 self.TotRelCount          	:= ri.TotRelCount;
	 self.IndAssociatesIndex    := '';
	 self                       := le;
End;
	
	
AddRelCnt  := 	join(RelatIndexTotals, CountRelat, 
										 right.seq=left.seq and
										 right.CLAMdid=left.CLAMdid,
										 AddRelCount(left,right), left outer);

										 
RelatLayout  GetAssocIndex(AddRelCnt le)   := TRANSFORM
   SubjectOnFile := if(le.did > 0, '1', '0');
   self.IndAssociatesIndex := Map(SubjectOnFile = '0' => '-1',
																	(le.TotRelCount*.5) < le.IndGE8CountGE4 																									=> '9', 
																	(le.TotRelCount * .5) < le.SupsIndexGE8Count 																		          => '8',
																	le.SupsIndexGE8Count > 0																																	=> '7',
																	(le.TotRelCount*.40) <	le.IndGE7Count 			 							 																=> '6',
																	(le.TotRelCount*.20) <	le.IndGE7Count 							 																			=> '5',
																	(le.TotRelCount*.60) > le.IndGE5Count	and  (le.TotRelCount*.40) < le.IndGE5Count					=> '4', 
																	(le.TotRelCount*.40) >= le.IndGE5Count and   le.IndGE5Count > 0														=> '3',
																	le.index5Count + 	le.index6Count + le.index7Count + le.index8Count + le.index9Count > 0	 	=> '2',
																	le.index5Count + 	le.index6Count + le.index7Count + le.index8Count + le.index9Count = 0		=> '1',
																	'0');
		self         :=   le;														
																		


	END;
	
AssocIndxVal := project(AddRelCnt, GetAssocIndex(left));		
	
risk_indicators.layout_bocashell_neutral GetIndvIndex(IndRecs le) := Transform

    AMLAttr := AMLAttributesMaster(le);
		self.amlAttributes.IndCitizenshipIndex :=  AMLattr.IndCitizenshipIndex;								
		self.amlAttributes.IndMobilityIndex :=  AMLattr.IndMobilityIndex;
		self.amlAttributes.IndLegalEventsIndex :=  AMLattr.IndLegalEventsIndex;
		self.amlAttributes.IndAccesstoFundsIndex := AMLattr.IndAccesstoFundsIndex;
		self.amlAttributes.IndBusinessAssocationIndex := AMLattr.IndBusAssocIndex;
		self.amlAttributes.IndHighValueAssetIndex := AMLattr.IndHighValAssetsIndex;
		self.amlAttributes.IndGeographicIndex := AMLattr.IndGeogIndex;
		self.amlAttributes.IndAMLNegativeNews90 := '0';   
		self.amlAttributes.IndAMLNegativeNews24 := '0';  
		self.amlAttributes.IndAgeRange := AMLattr.IndAgeIndex;
		self := le;
  END;
	


INDIndex := project(IndRecs, GetIndvIndex(left));

AllIndex := join(INDIndex, AssocIndxVal, right.CLAMdid=left.did and right.seq=left.seq,
										transform(risk_indicators.layout_bocashell_neutral, self.amlAttributes.IndAssociatesIndex := right.IndAssociatesIndex, self := left), left outer);



Return AllIndex; 


END;