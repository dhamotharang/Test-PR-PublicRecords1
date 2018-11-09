IMPORT BIPV2, Business_Risk_BIP, DueDiligence, TopBusiness_Services, BIPV2_Best, iesp;

/* 
	Following Keys being used:
			BIPV2.Key_BH_Relationship_SELEID.kFetch
*/


EXPORT getBusLinkedBus(DATASET(DueDiligence.Layouts.Busn_Internal) indata,
													Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
													BIPV2.mod_sources.iParams linkingOptions) := FUNCTION

	
	relatedBusRaw := BIPV2.Key_BH_Relationship_SELEID.kFetch(PROJECT(indata, TRANSFORM(BIPV2.Key_BH_Relationship_SELEID.l_kFetch_in, 
																																											SELF.seleid := LEFT.Busn_info.BIP_IDS.SeleID.LinkID)),
																														TopBusiness_Services.Constants.ConnectedBusinessesKfetchMaxLimit);
																														
	//pull out the linkIDs - adding counter to give each row unique id																													
	pullLinkIDs := PROJECT(relatedBusRaw, TRANSFORM({UNSIGNED id, UNSIGNED6 seleid1, UNSIGNED6 seleid2, UNSIGNED6 orgid, UNSIGNED6 ultid},
																										SELF.id := COUNTER;
																										SELF := LEFT));	
	
	//sort and remove duplicate linkIDs that are not the same as the inquired business
	sortLinkIDs := SORT(pullLinkIDs(seleid1 <> seleid2), ultID, orgID, seleid2);
	dedupLinkIDs := DEDUP(sortLinkIDs, ultID, orgID, seleid2);
	
	//match the linkIDs to the same ultID as the inquired business (all businesses that are under the same ultID umbrella)
	//creating temp variables so each row can be unique since best data is looking for unqiue account number and seq
	matchUltIDs := JOIN(inData, dedupLinkIDs,
											LEFT.Busn_Info.BIP_IDs.UltID.LinkID = RIGHT.ultID,
											TRANSFORM({UNSIGNED4 tempSeq, UNSIGNED4 seq, STRING30 tempAcctNo, STRING30 acctNumber, RECORDOF(RIGHT)},
																	SELF.tempSeq := RIGHT.id;
																	SELF.seq := LEFT.seq;
																	SELF.acctNumber := LEFT.busn_info.accountNumber;
																	SELF.tempAcctNo := (STRING)RIGHT.id;
																	SELF := RIGHT; 
																	SELF := [];));	
	
	//get best data for linked business	
	transformLinkIDs := PROJECT(matchUltIDs, TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																										 SELF.seq := LEFT.tempSeq;
																										 SELF.busn_info.accountNumber := LEFT.tempAcctNo;
																										 SELF.Busn_Info.BIP_IDs.UltID.LinkID := LEFT.ultid;
																										 SELF.Busn_Info.BIP_IDs.OrgID.LinkID := LEFT.orgid;
																										 SELF.Busn_Info.BIP_IDs.SeleID.LinkID := LEFT.seleid2;
																										 SELF := [])); 
																												 
	bestDataForLinkedBus := DueDiligence.getBusBestData(DATASET([], DueDiligence.Layouts.CleanedData), transformLinkIDs, options, linkingOptions, FALSE);
	
	//tie the best data back to the unique linkIDs for the inquired business
	joinBestWithMatch := JOIN(matchUltIDs, bestDataForLinkedBus,
														LEFT.tempSeq = RIGHT.seq AND
														LEFT.tempAcctNo = RIGHT.busn_info.accountNumber,
														TRANSFORM({UNSIGNED4 parentSeq, UNSIGNED6 parentUltID, UNSIGNED6 parentOrgID, UNSIGNED6 parentSeleID, DATASET(DueDiligence.Layouts.Busn_Input) linkedBus},
																			parentSeqID := LEFT.seq;
																			parentAcctNo := LEFT.acctNumber;
																			
																			SELF.parentSeq := LEFT.seq;
																			SELF.parentUltID := LEFT.ultID;
																			SELF.parentOrgID := LEFT.orgID;
																			SELF.parentSeleID := LEFT.seleID1;
																			SELF.linkedBus := PROJECT(RIGHT.busn_info, TRANSFORM(DueDiligence.Layouts.Busn_Input,
																																													SELF.BIP_IDs.seq := parentSeqID;
																																													SELF.lexID := (STRING)LEFT.BIP_IDs.SeleID.LinkID;
																																													SELF.accountNumber := parentAcctNo;
																																													SELF := LEFT;));
																			SELF := [];));
															
	sortBestData := SORT(joinBestWithMatch, parentSeq, parentUltID, parentOrgID, parentSeleID);
	
	rollLnkedBus := ROLLUP(sortBestData,
													LEFT.parentSeq = RIGHT.parentSeq AND
													LEFT.parentUltID = RIGHT.parentUltID AND
													LEFT.parentOrgID = RIGHT.parentOrgID AND
													LEFT.parentSeleID = RIGHT.parentSeleID,
													TRANSFORM(RECORDOF(LEFT),
																			SELF.linkedBus := LEFT.linkedBus + RIGHT.linkedBus;
																			SELF := LEFT;));
										
	addLinkedBus := JOIN(indata, rollLnkedBus,
												LEFT.seq = RIGHT.parentSeq AND
												LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.parentUltID AND
												LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.parentOrgID AND
												LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.parentSeleID,
												TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																	SELF.linkedBusinesses := RIGHT.linkedBus;
																	SELF.LinkedBusncount := COUNT(RIGHT.linkedBus);
																	SELF := LEFT;),
												LEFT OUTER);
	
	
	
	

	// OUTPUT(indata, NAMED('indata'));
	// OUTPUT(pullLinkIDs, NAMED('pullLinkIDs'));
	// OUTPUT(sortLinkIDs, NAMED('sortLinkIDs'));
	// OUTPUT(dedupLinkIDs, NAMED('dedupLinkIDs'));
	// OUTPUT(matchUltIDs, NAMED('matchUltIDs'));
	// OUTPUT(bestDataForLinkedBus, NAMED('bestDataForLinkedBus'));	
	// OUTPUT(joinBestWithMatch, NAMED('joinBestWithMatch'));	
	// OUTPUT(rollLnkedBus, NAMED('rollLnkedBus'));	
	// OUTPUT(addLinkedBus, NAMED('addLinkedBus'));	
	

		
	RETURN addLinkedBus;
END;