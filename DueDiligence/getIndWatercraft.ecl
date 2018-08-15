IMPORT DueDiligence, STD, Watercraft;

/*
	Following Keys being used:
			Watercraft.key_watercraft_did
      Watercraft.key_watercraft_sid
*/
EXPORT getIndWatercraft(DATASET(DueDiligence.Layouts.Indv_Internal) inData) := FUNCTION
              
    getSpouseAsInquired := DueDiligence.CommonIndividual.getRelationship(inData, spouses, DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE);
  
    spouseAndInquired := getSpouseAsInquired + inData;
 

 
    watercraftKeys := JOIN(spouseAndInquired, Watercraft.key_watercraft_did(),
                           KEYED(LEFT.individual.did = RIGHT.l_did),
                           TRANSFORM(DueDiligence.LayoutsInternal.WatercraftSlimLayout,
                                      SELF.seq := LEFT.seq;
                                      SELF.did := LEFT.inquiredDID;
                                      SELF.historyDate := LEFT.historyDate;
                                      
                                      inquiredOwned := LEFT.indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL AND RIGHT.watercraft_key != DueDiligence.Constants.EMPTY;
                                      spouseOwned := LEFT.indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE AND RIGHT.watercraft_key != DueDiligence.Constants.EMPTY;
                                      
                                      SELF.inquiredOwned := inquiredOwned;
                                      SELF.spouseOwned := spouseOwned;
                                      
                                      SELF.watercraftOwners := IF(inquiredOwned OR spouseOwned, 
                                                            DATASET([TRANSFORM(DueDiligence.Layouts.DIDAndName, SELF := LEFT.individual;)]), 
                                                            DATASET([], DueDiligence.Layouts.DIDAndName));
                                                            
                                      SELF.watercraftKey := RIGHT.watercraft_key;
                                      SELF.sequenceKey := RIGHT.sequence_key;
                                      SELF.stateOrigin := RIGHT.state_origin;                  
                                                            
                                      SELF := [];),
                           ATMOST(LEFT.individual.did = RIGHT.l_did, DueDiligence.Constants.MAX_ATMOST_1000));
                        

    watercraftDateDetails := JOIN(watercraftKeys, Watercraft.key_watercraft_sid(),
                                   KEYED(LEFT.stateOrigin = RIGHT.state_origin AND
                                         LEFT.watercraftKey = RIGHT.watercraft_key AND
                                         LEFT.sequenceKey = RIGHT.sequence_key),
                                   TRANSFORM({RECORDOF(LEFT), STRING8 dateFirstSeen, STRING8 dateLastSeen},
                                              SELF := LEFT;
                                              SELF.dateFirstSeen := IF(RIGHT.date_first_seen = DueDiligence.Constants.EMPTY, RIGHT.date_vendor_first_reported, RIGHT.date_first_seen);
                                              SELF.dateLastSeen := IF(RIGHT.date_last_seen = DueDiligence.Constants.EMPTY, RIGHT.date_vendor_last_reported, RIGHT.date_last_seen);), 
                                   ATMOST(DueDiligence.Constants.MAX_ATMOST_1000));
                                   
    //Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
    watercraftCleanDates := DueDiligence.Common.CleanDatasetDateFields(watercraftDateDetails, 'dateFirstSeen');
    
    //Filter records based on when we first seen the data
    filteredWatercraftRecords := DueDiligence.Common.FilterRecordsSingleDate(watercraftCleanDates, dateFirstSeen);  
    
    slimWatercraft := PROJECT(filteredWatercraftRecords, TRANSFORM(DueDiligence.LayoutsInternal.WatercraftSlimLayout, SELF := LEFT;));
    
    dedupWatercraft := DEDUP(slimWatercraft, ALL);
    sortSlimWatercrafts := SORT(dedupWatercraft, seq, did, watercraftKey, sequenceKey, stateOrigin);
    
    rollSlimWatercracts := ROLLUP(sortSlimWatercrafts,
                                  LEFT.seq = RIGHT.seq AND
                                  LEFT.did = RIGHT.did AND
                                  LEFT.watercraftKey = RIGHT.watercraftKey AND
                                  LEFT.sequenceKey = RIGHT.sequenceKey AND
                                  LEFT.stateOrigin = RIGHT.stateOrigin,
                                  TRANSFORM(DueDiligence.LayoutsInternal.WatercraftSlimLayout,
                                            SELF.inquiredOwned := LEFT.inquiredOwned OR RIGHT.inquiredOwned;
                                            SELF.spouseOwned := LEFT.spouseOwned OR RIGHT.spouseOwned;
                                            SELF.watercraftOwners := LEFT.watercraftOwners + RIGHT.watercraftOwners;
                                            SELF := LEFT;));
    
    
    //Get the details about the watercraft
    watercraftDetails := DueDiligence.getSharedWatercraft(rollSlimWatercracts); 
    
    addWaterCraft := JOIN(inData, watercraftDetails,
                          LEFT.seq = RIGHT.seq AND
                          LEFT.inquiredDID = RIGHT.did,												
                          TRANSFORM(DueDiligence.Layouts.Indv_Internal, 
                                    SELF.watercraftCount := RIGHT.totalWatercraft;
                                    SELF.watercraftLength := RIGHT.maxWatercraftLength;
                                    SELF.perWatercraft := RIGHT.allwatercraft;
                                    SELF := LEFT),
                          LEFT OUTER);
    
    


    // OUTPUT(spouseAndInquired, NAMED('spouseAndInquired'));
    // OUTPUT(watercraftKeys, NAMED('watercraftKeys'));
    // OUTPUT(watercraftDateDetails, NAMED('watercraftDateDetails'));
    // OUTPUT(filteredWatercraftRecords, NAMED('filteredWatercraftRecords'));
    // OUTPUT(slimWatercraft, NAMED('slimWatercraft'));
    // OUTPUT(sortSlimWatercrafts, NAMED('sortSlimWatercrafts'));
    // OUTPUT(rollSlimWatercracts, NAMED('rollSlimWatercracts'));     
    // OUTPUT(watercraftDetails, NAMED('watercraftDetails'));
    // OUTPUT(addWaterCraft, NAMED('addWaterCraft'));
    
 
    RETURN addWaterCraft;
END;