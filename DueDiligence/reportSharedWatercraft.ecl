IMPORT BIPv2, DueDiligence, iesp;

EXPORT reportSharedWatercraft (DATASET(DueDiligence.LayoutsInternal.SharedWatercraftSlim) inWatercraft) := FUNCTION

    flattenWater := NORMALIZE(inWatercraft, LEFT.allWatercraft, 
                              TRANSFORM(DueDiligence.LayoutsInternalReport.SharedWatercraftLayout,
                                        SELF.seq := LEFT.seq;
                                        SELF.ultID := LEFT.ultID;
                                        SELF.orgID := LEFT.orgID;
                                        SELF.seleID := LEFT.seleID;
                                        SELF.did := LEFT.did;
                                        
                                        SELF.inquiredOwned := RIGHT.inquiredOwned;
                                        SELF.spouseOwned := RIGHT.spouseOwned;
                                        SELF.owners := RIGHT.watercraftOwners;
                                        
                                        SELF.yearMakeModel.year := RIGHT.year;
																				SELF.yearMakeModel.make := RIGHT.make;
																				SELF.yearMakeModel.model := RIGHT.model;
                                        
																				SELF.vesselType.detailType := RIGHT.vesselType;
                                        
																				SELF.lengthFeet := RIGHT.vesselLengthFeet;
																				SELF.lengthInches := RIGHT.vesselLengthInches;
																				SELF.title.state := RIGHT.titleState;
																				SELF.title.date := iesp.ECL2ESP.toDate(RIGHT.oldestTitleDate);
																				
                                        SELF.registration.state := RIGHT.registrationState;
                                        SELF.registration.date := iesp.ECL2ESP.toDate(RIGHT.newestRegistrationDate);
																																																											
																				SELF.VINNumber.vin := RIGHT.registrationNumber;
                                        SELF.Propulsion := RIGHT.propulsion;
                                        
                                        SELF := [];));

    sortGroupWatercraft := GROUP(SORT(flattenWater, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, -lengthFeet, -lengthInches), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
    limitedWater := DueDiligence.Common.GetMaxRecords(sortGroupWatercraft, iesp.constants.DDRAttributesConst.MaxWatercraft);                                 

        
    RETURN limitedWater;
END;