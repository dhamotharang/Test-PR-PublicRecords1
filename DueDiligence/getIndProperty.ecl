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
                              
                              inquiredOwned := LEFT.indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL AND RIGHT.ln_fares_id != DueDiligence.Constants.EMPTY;
                              spouseOwned := LEFT.indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE AND RIGHT.ln_fares_id != DueDiligence.Constants.EMPTY;
                              
                              SELF.inquiredOwned := inquiredOwned;
                              SELF.spouseOwned := spouseOwned;
                              
                              SELF.ownerNames := IF(inquiredOwned OR spouseOwned, 
                                                    DATASET([TRANSFORM(DueDiligence.Layouts.DIDAndName, SELF := LEFT.individual;)]), 
                                                    DATASET([], DueDiligence.Layouts.DIDAndName));
                              
                              SELF.sourceCode := RIGHT.source_code;
                              SELF.LNFaresId := RIGHT.ln_fares_id;
                                
                              SELF.prim_range := RIGHT.prim_range;
                              SELF.predir := RIGHT.predir;
                              SELF.prim_name := RIGHT.prim_name;
                              SELF.addr_suffix := RIGHT.suffix;
                              SELF.postdir := RIGHT.postdir;
                              SELF.sec_range := RIGHT.sec_range;
                              SELF.city := RIGHT.p_city_name;
                              SELF.state := RIGHT.st;
                              SELF.zip5 := RIGHT.zip;
                              SELF.county := RIGHT.county[3..5];
                              SELF.geo_blk := RIGHT.geo_blk;
                              
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
                                  SELF.ownerNames := LEFT.ownerNames + RIGHT.ownerNames;
                                  SELF := LEFT;));

    propDetails := DueDiligence.getSharedProperty(rollProps);
    
    //convert the data to what will be used for the person report
    reportProp := PROJECT(propDetails, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, INTEGER8 totalPropertySumAssedValue, 
                                                                    UNSIGNED2 soldCnt, UNSIGNED2 ownCnt, DATASET(DueDiligence.Layouts.IndPropertyDataLayout) propReport},
                                                
                                                  SELF.totalPropertySumAssedValue := LEFT.totalSumAssessedValue;
                                                  SELF.soldCnt := LEFT.soldPropCnt;
                                                  SELF.ownCnt := LEFT.ownPropCnt;
                                                  SELF.propReport := PROJECT(LEFT.ownedProps, TRANSFORM(DueDiligence.Layouts.IndPropertyDataLayout,
                                                                                                        SELF.prim_range := LEFT.prim_range;
                                                                                                        SELF.predir := LEFT.predir;
                                                                                                        SELF.prim_name := LEFT.prim_name;
                                                                                                        SELF.addr_suffix := LEFT.addr_suffix;
                                                                                                        SELF.postdir := LEFT.postdir;
                                                                                                        SELF.unit_desig := LEFT.unit_desig;
                                                                                                        SELF.sec_range := LEFT.sec_range;
                                                                                                        SELF.city := LEFT.city;
                                                                                                        SELF.state := LEFT.state;
                                                                                                        SELF.zip5 := LEFT.zip5;
                                                                                                        SELF.zip4 := LEFT.zip4;
                                                                                                        SELF.county := LEFT.county;
                                                                                                        SELF.geo_blk := LEFT.geo_blk;
                                                                                                        SELF.addressType := LEFT.addressType;
                                                                                                        SELF.purchaseDate := LEFT.purchaseDate;
                                                                                                        SELF.purchasePrice := LEFT.purchasePrice;
                                                                                                        SELF.lengthOfOwnership := LEFT.lengthOfOwnership;
                                                                                                        SELF.assessedYear := LEFT.assessedYear;
                                                                                                        SELF.assessedValue := LEFT.assessedTotalValue;
                                                                                                        SELF.propertyOwners := LEFT.ownerNames;
                                                                                                        SELF.inquiredOwned := LEFT.inquiredOwned;
                                                                                                        SELF.spouseOwned := LEFT.spouseOwned;
                                                                                                        SELF.ownerOccupied := LEFT.ownerOccupied;
                                                                                                        SELF := [];));
                                                  SELF := LEFT;));
      
    addPropCounts := JOIN(inData, reportProp,
                          LEFT.seq = RIGHT.seq AND
                          LEFT.inquiredDID = RIGHT.did,
                          TRANSFORM(RECORDOF(LEFT),
                                    SELF.ownedPropCount := RIGHT.ownCnt;
                                    SELF.totalAssesedValue := RIGHT.totalPropertySumAssedValue;
                                    SELF.previouslyOwnedPropCount := RIGHT.soldCnt;
                                    SELF.perProperties := RIGHT.propReport;
                                    SELF := LEFT),
                          LEFT OUTER,
                          ATMOST(1));
    
    
    
    
    // OUTPUT(inData, NAMED('inData'));
    // OUTPUT(getSpouseAsInquired, NAMED('getSpouseAsInquired'));
    // OUTPUT(spouseAndInquired, NAMED('spouseAndInquired'));
    // OUTPUT(propByDID, NAMED('propByDID'));
    // OUTPUT(rollProps, NAMED('rollProps'));
    // OUTPUT(propDetails, NAMED('propDetails'));
    // OUTPUT(reportProp, NAMED('reportProp'));
    // OUTPUT(addPropCounts, NAMED('addPropCounts'));
    
    RETURN addPropCounts;
END;