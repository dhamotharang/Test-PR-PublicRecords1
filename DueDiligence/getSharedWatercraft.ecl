IMPORT BIPv2, DueDiligence, Watercraft;

/*
	Following Keys being used:
			Watercraft.key_watercraft_wid
*/
EXPORT getSharedWatercraft(DATASET(DueDiligence.LayoutsInternal.WatercraftSlimLayout) inWatercraft) := FUNCTION
   
   watercraftDetails := JOIN(inWatercraft, watercraft.key_watercraft_wid(),
                             KEYED(LEFT.stateOrigin = RIGHT.state_origin AND
                                   LEFT.watercraftKey = RIGHT.watercraft_key AND
                                   LEFT.sequenceKey = RIGHT.sequence_key),		 
                             TRANSFORM(DueDiligence.LayoutsInternal.WatercraftSlimLayout,
                                       SELF.year := RIGHT.model_year;
                                       SELF.model := RIGHT.watercraft_model_description;
                                       SELF.make := RIGHT.watercraft_make_description;
                                       SELF.vesselType := RIGHT.vehicle_type_description;
                                       SELF.propulsion := RIGHT.propulsion_description;   
                                       
                                       SELF.purchasePrice := (UNSIGNED8)RIGHT.purchase_price;
                                       SELF.hullTypeDescription := RIGHT.hull_type_description;

                                       vesselLength := (UNSIGNED2)RIGHT.watercraft_length; 
                                       SELF.vesselTotalLength := vesselLength;
                                       SELF.vesselLengthFeet := vesselLength DIV 12;
                                       SELF.vesselLengthInches := vesselLength % 12;
                                                                    
                                       SELF.registrationNumber := RIGHT.registration_number;
                                       SELF.registrationState := RIGHT.st_registration;
                                       
                                       SELF.titleState := RIGHT.title_state;
                                       
                                       SELF.oldestTitleDate := (UNSIGNED4)RIGHT.title_issue_date;
                                       SELF.newestTitleDate := (UNSIGNED4)RIGHT.title_issue_date;
                                       SELF.oldestRegistrationDate := (UNSIGNED4)RIGHT.registration_date;
                                       SELF.newestRegistrationDate := (UNSIGNED4)RIGHT.registration_date;
                                       
                                       SELF := LEFT;), 
                             ATMOST(LEFT.watercraftKey = RIGHT.watercraft_key AND
                                    LEFT.stateOrigin = RIGHT.state_origin AND  
                                    LEFT.sequenceKey = RIGHT.sequence_key, DueDiligence.Constants.MAX_ATMOST_1000));
    
    slimSort := SORT(watercraftDetails, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, stateOrigin, watercraftKey, -sequenceKey);
    waterRoll := ROLLUP(slimSort,
                          #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                          LEFT.did = RIGHT.did AND
                          LEFT.watercraftKey = RIGHT.watercraftKey AND
                          LEFT.stateOrigin = RIGHT.stateOrigin,
                          TRANSFORM(DueDiligence.LayoutsInternal.WatercraftSlimLayout,
                                    boat := IF(LEFT.vesselTotalLength > RIGHT.vesselTotalLength, LEFT, RIGHT);
                                    SELF.vesselLengthFeet := boat.vesselLengthFeet;
                                    SELF.vesselLengthInches := boat.vesselLengthInches;
                                    SELF.vesselTotalLength := boat.vesselTotalLength;
                                    SELF.propulsion := IF(LEFT.propulsion = DueDiligence.Constants.Empty, RIGHT.propulsion, LEFT.propulsion);
                                    SELF.registrationNumber := IF(LEFT.registrationNumber = DueDiligence.Constants.Empty, RIGHT.registrationNumber, LEFT.registrationNumber);
                                    
                                    SELF.titleState := IF(LEFT.titleState = DueDiligence.Constants.Empty, RIGHT.titleState, LEFT.titleState);

                                    SELF.oldestTitleDate := IF(LEFT.oldestTitleDate > 0 AND RIGHT.oldestTitleDate > 0, MIN(LEFT.oldestTitleDate, RIGHT.oldestTitleDate), MAX(LEFT.oldestTitleDate, RIGHT.oldestTitleDate)); 
                                    SELF.newestTitleDate := MAX(LEFT.newestTitleDate, RIGHT.newestTitleDate);
                                    SELF.oldestRegistrationDate := IF(LEFT.oldestRegistrationDate > 0 AND RIGHT.oldestRegistrationDate > 0, MIN(LEFT.oldestRegistrationDate, RIGHT.oldestRegistrationDate), MAX(LEFT.oldestRegistrationDate, RIGHT.oldestRegistrationDate)); 
                                    SELF.newestRegistrationDate := MAX(LEFT.newestRegistrationDate, RIGHT.newestRegistrationDate);
                                    
                                    SELF.registrationState := IF(LEFT.registrationState = DueDiligence.Constants.EMPTY, RIGHT.registrationState, LEFT.registrationState);
                                    
                                    SELF := LEFT;));
                                    
    limitWatercraft := GROUP(SORT(waterRoll, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, -vesselTotalLength), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
    limitedWater := DueDiligence.Common.GetMaxRecords(limitWatercraft, DueDiligence.Constants.MAX_WATERCRAFT);                                 
                                    
    reformatWater := PROJECT(limitedWater, TRANSFORM(DueDiligence.LayoutsInternal.SharedWatercraftSlim,
                                                  SELF.allWatercraft := DATASET([TRANSFORM(DueDiligence.Layouts.WatercraftDataLayout, SELF := LEFT; SELF := [];)]);
                                                  SELF.totalWatercraft := 1;
                                                  SELF.maxWatercraftLength := LEFT.vesselLengthFeet;
                                                  SELF := LEFT;));                                

    sortWater := SORT(reformatWater, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
   
    rollWaterToBusOrPer := ROLLUP(sortWater,
                                   #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                                   LEFT.did = RIGHT.did,
                                   TRANSFORM(DueDiligence.LayoutsInternal.SharedWatercraftSlim,
                                              SELF.allWatercraft := LEFT.allWatercraft + RIGHT.allWatercraft;
                                              SELF.totalWatercraft := LEFT.totalWatercraft + RIGHT.totalWatercraft;  
                                              SELF.maxWatercraftLength := MAX(LEFT.maxWatercraftLength, RIGHT.maxWatercraftLength),
                                              SELF :=  LEFT));  


    // OUTPUT(watercraftDetails, NAMED('sharedWatercraftDetails'));
    // OUTPUT(slimSort, NAMED('slimSort'));
    // OUTPUT(waterRoll, NAMED('waterRoll'));
    // OUTPUT(limitWatercraft, NAMED('limitWatercraft'));
    // OUTPUT(limitedWater, NAMED('limitedWater'));
    // OUTPUT(reformatWater, NAMED('reformatWater'));
    // OUTPUT(sortWater, NAMED('sortWater'));
    // OUTPUT(rollWaterToBusOrPer, NAMED('rollWaterToBusOrPer'));

    RETURN rollWaterToBusOrPer;
END;