import   ut;


EXPORT AMLBusnRollAttributes(DATASET(Layouts.AMLBusnAssocLayout) BusnAttribInd) := FUNCTION


BusnRecs  := BusnAttribInd(~AssocBusn);
AssocRecs  := BusnAttribInd(AssocBusn);


Layouts.AMLBusnAssocLayout  GetAssocIndex(AssocRecs le)   := TRANSFORM
   

    AMLBusnAttr := AML.AMLBusnAttributesMaster(le );
		self.busgeographicindex :=  AMLBusnAttr.BusnGeoIndex;								
		self.busvalidityindex :=  AMLBusnAttr.BusnValidityIndex;
		self.busstabilityindex :=  AMLBusnAttr.BusnStabilityIndex;
		self.buslegaleventsindex := AMLBusnAttr.BusnLegalEventsIndex;
		self.busaccesstofundsindex := AMLBusnAttr.BusnAccessToFundsIndex;
		self.BusIndustryRiskIndex := AMLBusnAttr.BusnIndustryRiskIndex;
		self.BusAMLNegativeNews90 := '0'; 
		self.BusAMLNegativeNews24 := '0'; 
		self := le;
	END;
	

AssocIndex := project(AssocRecs, GetAssocIndex(left));

AddIndBack := join(BusnAttribInd, AssocIndex, 
									 right.seq = left.seq and
									 right.bdid = left.bdid and
									 right.assocbdid = left.assocbdid,
									 Transform(Layouts.AMLBusnAssocLayout, 
												self.busgeographicindex :=  right.busgeographicindex,								
												self.busvalidityindex :=  right.busvalidityindex,
												self.busstabilityindex :=  right.busstabilityindex,
												self.buslegaleventsindex := right.buslegaleventsindex,
												self.busaccesstofundsindex := right.busaccesstofundsindex,
												self.BusAMLNegativeNews24 := '0',
												self.BusAMLNegativeNews90 := '0',
												self := left),
										left outer);



Layouts.AMLBusnAssocIndexLayout SetCountsIndex(AddIndBack le) := Transform

  self.seq 															:= le.seq;
	self.bdid                             := le.bdid;
	self.ASSOCbdid                        := le.ASSOCbdid;
	self.isBusnAssoc                      := le.AssocBusn;
	self.BusnValidityIndex5Count          := if((unsigned3)le.busvalidityindex = 5, 1,0) ;
	self.BusnValidityIndex6Count     			:= if((unsigned3)le.busvalidityindex = 6, 1,0) ;
	self.BusnValidityIndex7Count     			:= if((unsigned3)le.busvalidityindex = 7, 1,0) ;
	self.BusnValidityIndex8Count     			:= if((unsigned3)le.busvalidityindex = 8, 1,0) ;
	self.BusnValidityIndex9Count     			:= if((unsigned3)le.busvalidityindex = 9, 1,0) ;
	self.BusnStabilityIndex5Count        	:= if((unsigned3)le.BusStabilityIndex = 5, 1,0) ;
	self.BusnStabilityIndex6Count  			 	:= if((unsigned3)le.busstabilityindex = 6, 1,0) ;
	self.BusnStabilityIndex7Count				 	:= if((unsigned3)le.busstabilityindex = 7, 1,0) ;
	self.BusnStabilityIndex8Count				 	:= if((unsigned3)le.busstabilityindex = 8, 1,0) ;
	self.BusnStabilityIndex9Count				 	:= if((unsigned3)le.busstabilityindex = 9, 1,0) ;
	self.BusnLegalEventsIndex5Count				:= if((unsigned3)le.buslegaleventsindex = 5, 1,0) ;
	self.BusnLegalEventsIndex6Count				:= if((unsigned3)le.buslegaleventsindex = 6, 1,0) ;
	self.BusnLegalEventsIndex7Count				:= if((unsigned3)le.buslegaleventsindex = 7, 1,0) ;
	self.BusnLegalEventsIndex8Count				:= if((unsigned3)le.buslegaleventsindex = 8, 1,0) ;
	self.BusnLegalEventsIndex9Count				:= if((unsigned3)le.buslegaleventsindex = 9, 1,0) ;
	self.BusnAccesstoFundsIndex5Count			:= if((unsigned3)le.busaccesstofundsindex = 5, 1,0) ;
	self.BusnAccesstoFundsIndex6Count			:= if((unsigned3)le.busaccesstofundsindex = 6, 1,0) ;
	self.BusnAccesstoFundsIndex7Count			:= if((unsigned3)le.busaccesstofundsindex = 7, 1,0) ;
	self.BusnAccesstoFundsIndex8Count			:= if((unsigned3)le.busaccesstofundsindex = 8, 1,0) ;
	self.BusnAccesstoFundsIndex9Count			:= if((unsigned3)le.busaccesstofundsindex = 9, 1,0) ;
	self.BusnAssocIndex5Count					    := if((unsigned3)le.busassociatesindex = 5, 1,0) ;
	self.BusnAssocIndex6Count					    := if((unsigned3)le.busassociatesindex = 6, 1,0) ;
	self.BusnAssocIndex7Count					    := if((unsigned3)le.busassociatesindex = 7, 1,0) ;
	self.BusnAssocIndex8Count					    := if((unsigned3)le.busassociatesindex = 8, 1,0) ;
	self.BusnAssocIndex9Count					    := if((unsigned3)le.busassociatesindex = 9, 1,0) ;
	self.BusnGeoIndex5Count					      := if((unsigned3)le.busgeographicindex = 5, 1,0) ;
	self.BusnGeoIndex6Count					      := if((unsigned3)le.busgeographicindex = 6, 1,0) ;
	self.BusnGeoIndex7Count					      := if((unsigned3)le.busgeographicindex = 7, 1,0) ;
	self.BusnGeoIndex8Count					      := if((unsigned3)le.busgeographicindex = 8, 1,0) ;
	self.BusnGeoIndex9Count					      := if((unsigned3)le.busgeographicindex = 9, 1,0) ;
	self.LegalIndexGE8Count               := 0;
	
	
END;

AssocIndexCnt := project(AddIndBack, SetCountsIndex(left));

AssocIndexS := sort(AssocIndexCnt, seq, bdid);

IndexCountLayout := record
  unsigned4 seq;
	unsigned6 bdid;
	unsigned6 Assocbdid;
	boolean   isAssocBusn;
  unsigned3  index5Count   := 0;
  unsigned3  index6Count   := 0;
  unsigned3  index7Count   := 0;
  unsigned3  index8Count   := 0;
  unsigned3  index9Count   := 0;
  unsigned3  LegalIndexGE8Count   := 0;
	
END;

IndexCountLayout IndexTotal(AssocIndexS le) := Transform

  self.seq 							:= le.seq;
	self.bdid             := le.bdid;
	self.Assocbdid        := le.Assocbdid;
	self.isAssocBusn      := le.isBusnAssoc;
	self.index5Count     := le.BusnValidityIndex5Count + le.BusnStabilityIndex5Count + le.BusnLegalEventsIndex5Count + 
	                        le.BusnAccesstoFundsIndex5Count + le.BusnGeoIndex5Count ;
													
	self.index6Count     := le.BusnValidityIndex6Count + le.BusnStabilityIndex6Count + le.BusnLegalEventsIndex6Count + 
	                        le.BusnAccesstoFundsIndex6Count + le.BusnGeoIndex6Count ;
	
	self.index7Count     := le.BusnValidityIndex7Count + le.BusnStabilityIndex7Count + le.BusnLegalEventsIndex7Count + 
	                        le.BusnAccesstoFundsIndex7Count + le.BusnGeoIndex7Count ;
	
	self.index8Count     := le.BusnValidityIndex8Count + le.BusnStabilityIndex8Count + le.BusnLegalEventsIndex8Count + 
	                        le.BusnAccesstoFundsIndex8Count + le.BusnGeoIndex8Count ;;
	
	self.index9Count     := le.BusnValidityIndex9Count + le.BusnStabilityIndex9Count + le.BusnLegalEventsIndex9Count + 
	                        le.BusnAccesstoFundsIndex9Count + le.BusnGeoIndex9Count ;
													
	self.LegalIndexGE8Count  :=  le.BusnLegalEventsIndex8Count + le.BusnLegalEventsIndex9Count;
	
	
END;

AssocCombineInd := project(AssocIndexS, IndexTotal(left));


tableLayout := record
	unsigned4 seq;
	unsigned6 bdid;
	unsigned4 TotAssocCount := Count(group);
END;

													
CountAssoc := table(BusnAttribInd, { seq , bdid , TotAssocCount := Count(group)}, 
																										seq,bdid);
																					
AssocLayout := Record
	IndexCountLayout;
	unsigned4  TotAssocCount;
	unsigned4  IndGE8CountGE3;
  unsigned4  IndGE7Count;
  unsigned4  IndGE5Count;
  string2    busassociatesindex;
END;
	
AssocLayout CntIndexes(AssocCombineInd le)  := TRANSFORM
  self.IndGE8CountGE3  := if((le.index8Count + le.index9Count) >= 3, 1, 0);
	self.IndGE7Count  := if(le.index7Count + le.index8Count + le.index9Count >= 2, 1, 0);
	self.IndGE5Count  := if(le.index5Count + le.index6Count + le.index7Count + le.index8Count + le.index9Count > 0, 1, 0);
	self.TotAssocCount  := 0;
	self.busassociatesindex    := '0';
	self   := le;
End;

IndxSmmry := project(AssocCombineInd, CntIndexes(left));	


AssocLayout RollupIndexCount(IndxSmmry le, IndxSmmry ri) := Transform
  self.seq 															:= le.seq;
	self.bdid                             := le.bdid;
	self.Assocbdid                        := le.Assocbdid;
	self.isAssocBusn                      := le.isAssocBusn;
	self.index5Count     									:= le.index5Count + ri.index5Count ;
	self.index6Count    									:= le.index6Count + ri.index6Count ;
	self.index7Count     									:= le.index7Count + ri.index7Count ;
	self.index8Count     									:= le.index8Count + ri.index8Count ;
	self.index9Count     									:= le.index9Count + ri.index9Count ;
	self.IndGE8CountGE3  	 							  := le.IndGE8CountGE3 + ri.IndGE8CountGE3;
	self.IndGE7Count     									:= le.IndGE7Count + ri.IndGE7Count;
	self.IndGE5Count    								  := le.IndGE5Count + ri.IndGE5Count;
	self.TotAssocCount     								:= 0;
	self.LegalIndexGE8Count  							:= 	le.LegalIndexGE8Count + ri.LegalIndexGE8Count;
	self.busassociatesindex     					:= '0';
END;

AssocIndexTotals := rollup(IndxSmmry, left.seq=right.seq and left.bdid=right.bdid, RollupIndexCount(left, right));

IndexTotalWCount := join(AssocIndexTotals ,CountAssoc,
                         right.seq = left.seq and
												 right.bdid = left.bdid,
												 transform(AssocLayout, 
																self.TotAssocCount := right.TotAssocCount, 
																self := left),
												 left outer);



AssocLayout GetBusnAssocIndex(IndexTotalWCount le) := Transform
 SubjectOnFile := if(le.bdid > 0, '1', '0');
 self.seq         := le.seq;
 self.bdid        := le.bdid;
 self.busassociatesindex := Map(SubjectOnFile = '0' => '-1',
																(le.TotAssocCount*.5) < le.IndGE8CountGE3 																						    => '9', 
																(le.TotAssocCount * .5) < le.LegalIndexGE8Count 	 																		    => '8',
																le.LegalIndexGE8Count > 0																																	=> '7',
																(le.TotAssocCount*.40) <	le.IndGE7Count 			 							 															=> '6',
																(le.TotAssocCount*.20) <	le.IndGE7Count 							 																		=> '5',
																(le.TotAssocCount*.60) > le.IndGE5Count	and (le.TotAssocCount*.40) < le.IndGE5Count				=> '4',
																(le.TotAssocCount*.40) >= le.IndGE5Count	and le.IndGE5Count > 0													=> '3', 
																le.IndGE5Count > 0	 																																			=> '2',
																le.IndGE5Count = 0																																				=> '1',
																'0'); 
	self := le;
END;
																				
																				
AssocIndxVal := project(IndexTotalWCount, GetBusnAssocIndex(left));																			
																				
Layouts.AMLBusnAssocLayout GetIndvIndex(BusnRecs le) := Transform

 AMLBusnAttr := AML.AMLBusnAttributesMaster(le );
		self.busgeographicindex :=  AMLBusnAttr.BusnGeoIndex;								
		self.busvalidityindex :=  AMLBusnAttr.BusnValidityIndex;
		self.busstabilityindex :=  AMLBusnAttr.BusnStabilityIndex;
		self.buslegaleventsindex := AMLBusnAttr.BusnLegalEventsIndex;
		self.busaccesstofundsindex := AMLBusnAttr.BusnAccessToFundsIndex;
		self.BusIndustryRiskIndex := AMLBusnAttr.BusnIndustryRiskIndex;
		self.BusAMLNegativeNews24 := '0'; 
		self.BusAMLNegativeNews90 := '0'; 
		self := le;
  END;
	
INDIndex := project(BusnRecs, GetIndvIndex(left));

BusnAllIndex := join(INDIndex, AssocIndxVal, right.bdid=left.bdid and right.seq=left.seq,
										transform(Layouts.AMLBusnAssocLayout, self.busassociatesindex := right.busassociatesindex, self := left), left outer);

AMLBusnIndex := BusnAllIndex;


Return AMLBusnIndex; 


END;