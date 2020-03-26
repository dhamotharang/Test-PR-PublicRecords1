IMPORT BKForeclosure;

//Nod or Reo for InputType
EXPORT run_base_stats := FUNCTION
//Previous Nod Base File Results
 NodFather	:= DATASET('~thor_data400::base::BKForeclosure::Nod_father', BKForeclosure.layout_BK.base_nod,THOR);
									
	dNodCurrentPrev		:=	NodFather(Delete_Flag <> 'DELETE');
	dNodDeletesPrev		:=	NodFather(Delete_Flag = 'DELETE');
	
	TempDIDSlim	:= RECORD
		UNSIGNED6 DID;
		UNSIGNED6 BDID;
	END;
	
	TempDIDSlim	NodLexIDOnly(BKForeclosure.layout_BK.base_nod L, INTEGER C) := TRANSFORM
		SELF.DID := CHOOSE(C,(INTEGER)L.name1_did,(INTEGER)L.name2_did,(INTEGER)L.name3_did,(INTEGER)L.name4_did,
													(INTEGER)L.name5_did, (INTEGER)L.name6_did);
		SELF.BDID := CHOOSE(C,(INTEGER)L.name1_bdid,(INTEGER)L.name2_bdid,(INTEGER)L.name3_bdid,(INTEGER)L.name4_bdid,
													(INTEGER)L.name5_bdid, (INTEGER)L.name6_bdid);
	END;
	
	PrevNodNormLexID 		:= NORMALIZE(dNodCurrentPrev,6,NodLexIDOnly(LEFT,COUNTER));
	PrevNodUniqueLexID 	:= DEDUP(SORT(DISTRIBUTE(PrevNodNormLexID(did > 0),HASH(did)),did,LOCAL),did,LOCAL);
	PrevNodUniqueBDID 	:= DEDUP(SORT(DISTRIBUTE(PrevNodNormLexID(bdid > 0),HASH(bdid)),bdid,LOCAL),bdid,LOCAL);
	
	PrevNodResults := SEQUENTIAL(OUTPUT(COUNT(dNodCurrentPrev),NAMED('PrevNodCurrentBaseCount'))
															,OUTPUT(COUNT(dNodDeletesPrev),NAMED('PrevNodDeleteRecordCount'))
															,OUTPUT(COUNT(PrevNodUniqueLexID),NAMED('PrevNodUniqueLexIDCount'))
															,OUTPUT(COUNT(PrevNodUniqueBDID),NAMED('PrevNodUniqueBDIDCount'))
															);

	//New Base file results
	NodBaseFile	:= BKForeclosure.File_BK_Foreclosure.fNod;
									
	NodBaseCurrent				:=	NodBaseFile(Delete_Flag <> 'DELETE');
	NodBaseDeletes				:=	NodBaseFile(Delete_Flag = 'DELETE');
		
	NodNormLexID 		:= NORMALIZE(NodBaseCurrent,6,NodLexIDOnly(LEFT,COUNTER));
	NodUniqueLexID 	:= DEDUP(SORT(DISTRIBUTE(NodNormLexID(did > 0),HASH(did)),did,LOCAL),did,LOCAL);
	NodUniqueBDID 	:= DEDUP(SORT(DISTRIBUTE(NodNormLexID(bdid > 0),HASH(bdid)),bdid,LOCAL),bdid,LOCAL);
	
	NodResults := SEQUENTIAL(OUTPUT(COUNT(NodBaseCurrent),NAMED('NodCurrentBaseCount'))
													,OUTPUT(COUNT(NodBaseDeletes),NAMED('NodDeleteRecordCount'))
													,OUTPUT(COUNT(NodUniqueLexID),NAMED('NodUniqueLexIDCount'))
													,OUTPUT(COUNT(NodUniqueBDID),NAMED('NodUniqueBDIDCount'))
													);
													
	//Previous Reo Base File Results
 ReoFather	:= DATASET('~thor_data400::base::BKForeclosure::Reo_father', BKForeclosure.layout_BK.base_reo,THOR);
									
	dReoCurrentPrev		:=	ReoFather(Delete_Flag <> 'DELETE');
	dReoDeletesPrev		:=	ReoFather(Delete_Flag = 'DELETE');
	
	TempDIDSlim	ReoLexIDOnly(BKForeclosure.layout_BK.base_reo L, INTEGER C) := TRANSFORM
		SELF.DID := CHOOSE(C,(INTEGER)L.name1_did,(INTEGER)L.name2_did,(INTEGER)L.name3_did,(INTEGER)L.name4_did,
													(INTEGER)L.name5_did, (INTEGER)L.name6_did, (INTEGER)L.name7_did, (INTEGER)L.name8_did);
		SELF.BDID := CHOOSE(C,(INTEGER)L.name1_bdid,(INTEGER)L.name2_bdid,(INTEGER)L.name3_bdid,(INTEGER)L.name4_bdid,
													(INTEGER)L.name5_bdid, (INTEGER)L.name6_bdid, (INTEGER)L.name7_bdid, (INTEGER)L.name8_bdid);
	END;
	
	PrevReoNormLexID 		:= NORMALIZE(dReoCurrentPrev,8,ReoLexIDOnly(LEFT,COUNTER));
	PrevReoUniqueLexID 	:= DEDUP(SORT(DISTRIBUTE(PrevReoNormLexID(did > 0),HASH(did)),did,LOCAL),did,LOCAL);
	PrevReoUniqueBDID 	:= DEDUP(SORT(DISTRIBUTE(PrevReoNormLexID(bdid > 0),HASH(bdid)),bdid,LOCAL),bdid,LOCAL);
	
	PrevReoResults := SEQUENTIAL(OUTPUT(COUNT(dReoCurrentPrev),NAMED('PrevReoCurrentBaseCount'))
															,OUTPUT(COUNT(dReoDeletesPrev),NAMED('PrevReoDeleteRecordCount'))
															,OUTPUT(COUNT(PrevReoUniqueLexID),NAMED('PrevReoUniqueLexIDCount'))
															,OUTPUT(COUNT(PrevReoUniqueBDID),NAMED('PrevReoUniqueBDIDCount'))
															);

	//New Base file results
	ReoBaseFile	:= BKForeclosure.File_BK_Foreclosure.fReo;
									
	ReoBaseCurrent				:=	ReoBaseFile(Delete_Flag <> 'DELETE');
	ReoBaseDeletes				:=	ReoBaseFile(Delete_Flag = 'DELETE');
	
	ReoNormLexID 		:= NORMALIZE(ReoBaseCurrent,8,ReoLexIDOnly(LEFT,COUNTER));
	ReoUniqueLexID 	:= DEDUP(SORT(DISTRIBUTE(ReoNormLexID(did > 0),HASH(did)),did,LOCAL),did,LOCAL);
	ReoUniqueBDID 	:= DEDUP(SORT(DISTRIBUTE(ReoNormLexID(bdid > 0),HASH(bdid)),bdid,LOCAL),bdid,LOCAL);
	
	ReoResults := SEQUENTIAL(OUTPUT(COUNT(ReoBaseCurrent),NAMED('ReoCurrentBaseCount'))
													,OUTPUT(COUNT(ReoBaseDeletes),NAMED('ReoDeleteRecordCount'))
													,OUTPUT(COUNT(ReoUniqueLexID),NAMED('ReoUniqueLexIDCount'))
													,OUTPUT(COUNT(ReoUniqueBDID),NAMED('ReoUniqueBDIDCount'))
													);
												
	RETURN SEQUENTIAL(PrevNodResults, NodResults, PrevReoResults, ReoResults);
END;