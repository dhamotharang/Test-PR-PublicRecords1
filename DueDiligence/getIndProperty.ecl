IMPORT DueDiligence, LN_PropertyV2, Risk_Indicators;

/*
	Following Keys being used:
			LN_PropertyV2.key_Property_did
*/
EXPORT getIndProperty(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
                      STRING dataRestrictionMask) := FUNCTION


  getSpouseAsInquired := DueDiligence.CommonIndividual.getRelationship(inData, spouses, DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE);
  
  spouseAndInquired := getSpouseAsInquired + inData;


  propByDID := JOIN(spouseAndInquired, LN_PropertyV2.key_Property_did(), 
                    KEYED(LEFT.individual.did = RIGHT.s_did) AND
                    KEYED(RIGHT.source_code_2 = 'P'),
                    TRANSFORM(DueDiligence.LayoutsInternal.PropertySlimLayout,
                              SELF.seq := LEFT.seq;
                              SELF.did := LEFT.inquiredDID;
                              SELF.inquiredOwned := LEFT.indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL AND RIGHT.ln_fares_id != DueDiligence.Constants.EMPTY;
                              SELF.spouseOwned := LEFT.indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE AND RIGHT.ln_fares_id != DueDiligence.Constants.EMPTY;
                              
                              SELF.sourceCode := RIGHT.source_code;
                              SELF.LNFaresId := RIGHT.ln_fares_id;
                              SELF := RIGHT;
                              SELF := [];),
                    KEEP(100), 
                    ATMOST(DueDiligence.Constants.MAX_ATMOST_1000));
                    
    //do we have access to fares data
    restrictFaresData := dataRestrictionMask[Risk_Indicators.iid_constants.posFaresRestriction] = Risk_Indicators.iid_constants.sTrue;
    
    propDataToUse := IF(restrictFaresData, propByDID(LNFaresId[1] != 'R'), propByDID);
                    
                    
    //unique fares_ids based on seq (could have both inquired and spouse or one of the other)
    sortIndProps := SORT(propDataToUse, seq, did, LNFaresId);
    
    rollProps := ROLLUP(sortIndProps,
                        LEFT.seq = RIGHT.seq AND
                        LEFT.did = RIGHT.did AND
                        LEFT.LNFaresId = RIGHT.LNFaresId,
                        TRANSFORM(RECORDOF(LEFT),
                                  SELF.inquiredOwned := LEFT.inquiredOwned OR RIGHT.inquiredOwned;
                                  SELF.spouseOwned := LEFT.spouseOwned OR RIGHT.spouseOwned;
                                  SELF := LEFT;));

    propDetails := DueDiligence.getSharedProperty(rollProps);
    
    addPropCounts := JOIN(inData, propDetails,
                          LEFT.seq = RIGHT.seq AND
                          LEFT.inquiredDID = RIGHT.did,
                          TRANSFORM(RECORDOF(LEFT),
                                    SELF.ownedPropCount := RIGHT.ownPropCnt;
                                    SELF.totalAssesedValue := RIGHT.totalSumAssessedValue;
                                    SELF.previouslyOwnedPropCount := RIGHT.soldPropCnt;
                                    SELF := LEFT),
                          LEFT OUTER,
                          ATMOST(1));
    
    
    
    
    // OUTPUT(inData, NAMED('inData'));
    // OUTPUT(getSpouseAsInquired, NAMED('getSpouseAsInquired'));
    // OUTPUT(spouseAndInquired, NAMED('spouseAndInquired'));
    // OUTPUT(propByDID, NAMED('propByDID'));
    // OUTPUT(rollProps, NAMED('rollProps'));
    // OUTPUT(propDetails, NAMED('propDetails'));
    // OUTPUT(addPropCounts, NAMED('addPropCounts'));
    
    RETURN addPropCounts;
END;