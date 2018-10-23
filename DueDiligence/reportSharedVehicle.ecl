IMPORT BIPv2, DueDiligence, iesp;

 EXPORT reportSharedVehicle (DATASET(DueDiligence.LayoutsInternal.SharedVehicleSlim) inVehicles) := FUNCTION

    //***normalize the data and produce a simple list of vehicles***    
    flattenVehicle := NORMALIZE(inVehicles, LEFT.allVehicles, 
                              TRANSFORM(DueDiligence.LayoutsInternalReport.SharedVehicleLayout,
                                        SELF.seq := LEFT.seq;
                                        SELF.ultID := LEFT.ultID;
                                        SELF.orgID := LEFT.orgID;
                                        SELF.seleID := LEFT.seleID;
                                        SELF.did := LEFT.did;
                                        //***Extract the data from the DATASET from the RIGHT
                                        SELF.inquiredOwned := RIGHT.inquiredOwned;
                                        SELF.spouseOwned := RIGHT.spouseOwned;
                                        SELF.owners := RIGHT.vehicleOwners;    //***This is a DATASET/List of vehicle owners
                                        SELF.vehicle.year := RIGHT.year; 
                                        SELF.vehicle.make := RIGHT.make;
                                        SELF.vehicle.model := RIGHT.model;
                                        SELF.LicensePlateType.detailType := RIGHT.licensePlateType;
                                        SELF.ClassType.detailType := RIGHT.classType;
                                        SELF.BasePrice  := RIGHT.basePrice;
                                        SELF.MotorVehicle.vin := RIGHT.vin;
                                        SELF.Title.state := RIGHT.titleState; 
                                        SELF.Title.date := iesp.ECL2ESP.toDatestring8(RIGHT.titleDate);
                                        SELF.Registration.state := RIGHT.registeredState;
                                        SELF.Registration.date := iesp.ECL2ESP.toDatestring8(RIGHT.registeredDate);
                                        SELF :=[];));

    //***Sort the data in the seqence needed to 
    sortGroupVehicle := GROUP(SORT(flattenVehicle, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
    limitedVehicles := DueDiligence.Common.GetMaxRecords(sortGroupVehicle, iesp.constants.DDRAttributesConst.MaxVehicles);                                 

        
    RETURN limitedVehicles;
END;