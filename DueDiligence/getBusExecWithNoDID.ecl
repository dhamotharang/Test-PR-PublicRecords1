IMPORT BIPV2, DueDiligence, Business_Risk_BIP, STD, ut;

/*
	No Keys are being accessed in this function.  This logic is working with the 
  Inquired Business and the list of BEO's with no DIDS and the list of BEO's that 
  have DIDs and producing a unique set of BEO's with no DIDs for the report. 
			 
*/

EXPORT getBusExecWithNoDID(DATASET(DueDiligence.Layouts.Busn_Internal) indata,                               //***Inquired Business
                           DATASET({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout,
                                    DueDiligence.Layouts.RelatedParty relatedparty, 
                                    STRING title, 
                                    UNSIGNED4 partyFirstSeen,  
                                    UNSIGNED4 partyLastSeen, 
                                    BOOLEAN isExec}) DIDLessExecs,                                           //***The DIDless Executives
                           DATASET({DueDiligence.Layouts.RelatedParty relatedParty, 
                                    UNSIGNED4 partyFirstSeen, 
                                    UNSIGNED4 partyLastSeen, 
                                    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout}) DIDExecs) //*** Executives found with DIDs 
                                    := FUNCTION
                    
   //***remove duplicates 
   sortDIDlessExecs   := SORT (DIDlessExecs,     seq, #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), relatedParty.firstname, relatedParty.lastname, relatedParty.fullname, title, partyLastSeen, partyFirstSeen);                
   rollDIDlessExecs   := ROLLUP(sortDIDlessExecs,
																		LEFT.seq = RIGHT.seq AND
																		LEFT.ultID = RIGHT.ultID AND
																		LEFT.orgID = RIGHT.orgID AND
																		LEFT.seleID = RIGHT.seleID AND
																		LEFT.relatedParty.firstname = RIGHT.relatedParty.firstname AND
                                    LEFT.relatedParty.lastname  = RIGHT.relatedParty.lastname  AND
                                    LEFT.relatedParty.fullname  = RIGHT.relatedParty.fullname  AND
																		LEFT.title = RIGHT.title,
																		TRANSFORM(RECORDOF(LEFT),
																							SELF.partyLastSeen := MAX(LEFT.partyLastSeen, RIGHT.partyLastSeen);
																							SELF.partyFirstSeen := IF(LEFT.partyFirstSeen = DueDiligence.Constants.NUMERIC_ZERO, MAX(LEFT.partyFirstSeen, RIGHT.partyFirstSeen), MIN(LEFT.partyFirstSeen, RIGHT.partyFirstSeen));
																							SELF := LEFT;));
                                              
                                              
   sortDIDExecs    := SORT (DIDExecs, seq, #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), relatedParty.firstname, relatedParty.lastname, relatedParty.fullname);     
   
   FinalDedupingOfDIDLessExecs  :=  JOIN(rollDIDlessExecs, sortDIDExecs,
                                    LEFT.seq = RIGHT.seq AND
																		LEFT.ultID = RIGHT.ultID AND
																		LEFT.orgID = RIGHT.orgID AND
																		LEFT.seleID = RIGHT.seleID AND
																		LEFT.relatedParty.firstname = RIGHT.relatedParty.firstname AND
                                    LEFT.relatedParty.lastname  = RIGHT.relatedParty.lastname,  
                                    TRANSFORM(RECORDOF(LEFT),
                                         SELF   := LEFT;),
                                    LEFT ONLY);   
   
  //use this TRANSFORM to populate the Executive position held within the company
  //The  Related Party layout is the common layout for Business Executives
  transformDIDLessExecs := PROJECT(FinalDedupingOfDIDLessExecs, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, DueDiligence.Layouts.RelatedParty relatedParty, UNSIGNED4 partyFirstSeen, UNSIGNED4 partyLastSeen},
																																			SELF.relatedParty.numOfPositions := 1;
																																			SELF.relatedParty.positions := PROJECT(LEFT, TRANSFORM(DueDiligence.Layouts.Positions,
																																																															SELF.firstSeen := LEFT.partyFirstSeen;
																																																															SELF.lastSeen := LEFT.partyLastSeen;
																																																															SELF.title := LEFT.title;
																																																															SELF := [];));
																																			SELF := LEFT;
                                                                      SELF := [];));
                                                                      
                                                                      
  sortTransformDIDLessExecs := SORT(transformDIDLessExecs, seq, #expand(BIPV2.IDmacros.mac_ListTop3Linkids()), relatedParty.firstname, relatedParty.lastname, relatedParty.fullname, partyFirstSeen);
	
	//rollup all positions per Name (first and last)
	rollUniqueDIDLessExecs := ROLLUP(sortTransformDIDLessExecs,
																		LEFT.seq = RIGHT.seq AND
																		LEFT.ultID = RIGHT.ultID AND
																		LEFT.orgID = RIGHT.orgID AND
																		LEFT.seleID = RIGHT.seleID AND
																		LEFT.relatedParty.firstname = RIGHT.relatedParty.firstname AND
                                    LEFT.relatedParty.lastname  = RIGHT.relatedParty.lastname,  
																		TRANSFORM(RECORDOF(LEFT),
																							SELF.relatedParty.positions := LEFT.relatedParty.positions + RIGHT.relatedParty.positions;
																							SELF.relatedParty.numOfPositions := LEFT.relatedParty.numOfPositions + RIGHT.relatedParty.numOfPositions;
																							SELF := LEFT;));
    
  //SORT and GROUP the BEO's by linkID so that the Maximum number of Execs can be applied for each unique LINKID.
  sortRecentDIDLessExecs  := SORT(rollUniqueDIDLessExecs, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()), -partylastseen);
	groupRecentDIDLessExecs := GROUP(sortRecentDIDLessExecs, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()));
  
  //Define the TRANSFORM that will get the Max Execs into the related party layout.
  //This layout has a DATASET defined as "executives" that we will eventually insert into a CHILD DATASET with the Inquired Business for DID less BEO's
	DueDiligence.LayoutsInternal.RelatedPartyLayout getMaxExecs(groupRecentDIDLessExecs ge, INTEGER numExecs) := TRANSFORM, SKIP(numExecs > DueDiligence.Constants.MAX_EXECS)
			SELF.executives := PROJECT(ge.relatedParty, TRANSFORM(LEFT));
			SELF := ge;
			SELF := [];
		END;
	
	getMaxDIDlessExecutives := PROJECT(groupRecentDIDLessExecs, getMaxExecs(LEFT, COUNTER));
 
  //remove the GROUPING and finish up the process of adding these Executives to a CHILD DATASET within the Inquired Business
  sortRemainingDIDLessExecs := SORT(UNGROUP(getMaxDIDlessExecutives), seq, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()));
		
	//rollup all execs by inquired business (seq, ultID, orgID, seleID)
	rollAllDIDlessExecs := ROLLUP(sortRemainingDIDLessExecs,
													LEFT.seq = RIGHT.seq AND
													LEFT.ultID = RIGHT.ultID AND
													LEFT.orgID = RIGHT.orgID AND
													LEFT.seleID = RIGHT.seleID,	
													TRANSFORM(RECORDOF(LEFT),
																		SELF.executives := LEFT.executives + RIGHT.executives;
																		SELF := LEFT;));	
										
	addDIDLessExecs := JOIN(indata, rollAllDIDLessExecs,
																		LEFT.seq = RIGHT.seq AND
																		LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
																		LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
																		LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,	
																		TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																							SELF.DIDlessExecs    := RIGHT.executives;
																							SELF.DIDlessBEOCount := COUNT(RIGHT.executives);
																							SELF := LEFT;),
																		LEFT OUTER);
    
   
    
   //***DEBUG STATEMENTS - comment out before deployments ***//
   
   // OUTPUT(Indata,                            NAMED('Indata'));
   // OUTPUT(DIDlessExecs,                      NAMED('DIDlessExecs'));  
   // OUTPUT(rollDIDlessExecs,                  NAMED('rollDIDlessExecs'));  
   // OUTPUT(sortDIDExecs,                      NAMED('sortDIDExecs'));  
   // OUTPUT(FinalDedupingOfDIDLessExecs,       NAMED('FinalDedupingOfDIDLessExecs'));  
   // OUTPUT(transformDIDLessExecs,             NAMED('transformDIDLessExecs'));  
   // OUTPUT(rollUniqueDIDLessExecs,            NAMED('rollUniqueDIDLessExecs'));  
   // OUTPUT(sortRecentDIDLessExecs,            NAMED('sortRecentDIDLessExecs'));  
   // OUTPUT(groupRecentDIDLessExecs,           NAMED('groupRecentDIDLessExecs'));  
   // OUTPUT(getMaxDIDLessExecutives,           NAMED('getMaxDIDLessExecutives'));  
   // OUTPUT(sortRemainingDIDLessExecs,         NAMED('sortRemainingDIDLessExecs'));
   // OUTPUT(rollAllDIDlessExecs,               NAMED('rollAllDIDlessExecs'));
   // OUTPUT(addDIDLessExecs,                   NAMED('addDIDLessExecs'));
   
	
	
	RETURN addDIDLessExecs;

END;