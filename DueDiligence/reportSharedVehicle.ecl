IMPORT BIPv2, DueDiligence, iesp;

 EXPORT reportSharedVehicle (DATASET(DueDiligence.LayoutsInternal.SharedVehicleSlim) inVehicles) := FUNCTION

    //normalize the data and produce a simple list of vehicles  
    flattenVehicle := NORMALIZE(inVehicles, LEFT.allVehicles, 
                              TRANSFORM(DueDiligence.LayoutsInternalReport.SharedVehicleLayout,
                                        SELF.seq := LEFT.seq;
                                        SELF.ultID := LEFT.ultID;
                                        SELF.orgID := LEFT.orgID;
                                        SELF.seleID := LEFT.seleID;
                                        SELF.did := LEFT.did;
                                        //Extract the data from the DATASET from the RIGHT
                                        SELF.inquiredOwned := RIGHT.inquiredOwned;
                                        SELF.spouseOwned := RIGHT.spouseOwned;
                                        SELF.owners := RIGHT.vehicleOwners;
                                        SELF.vehicle.year := RIGHT.year; 
                                        SELF.vehicle.make := RIGHT.make;
                                        SELF.vehicle.model := RIGHT.model;
                                        SELF.licensePlateType.detailType := RIGHT.licensePlateType;
                                        SELF.classType.detailType := RIGHT.classType;
                                        SELF.basePrice  := RIGHT.basePrice;
                                        SELF.motorVehicle.vin := RIGHT.vin;
                                        SELF.title.state := RIGHT.titleState; 
                                        SELF.title.date := iesp.ECL2ESP.toDatestring8(RIGHT.titleDate);
                                        SELF.registration.state := RIGHT.registeredState;
                                        SELF.registration.date := iesp.ECL2ESP.toDatestring8(RIGHT.registeredDate);
                                        SELF :=[];));

    //Sort the data to keep max records in check
    sortGroupVehicle := GROUP(SORT(flattenVehicle, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, -basePrice, - vehicle.year, vehicle.make, vehicle.model), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
    limitedVehicles := DueDiligence.Common.GetMaxRecords(sortGroupVehicle, iesp.constants.DDRAttributesConst.MaxVehicles);  
    
    reportVehicle := PROJECT(limitedVehicles, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, iesp.duediligencepersonreport.t_DDRPersonVehicleOwnership},
                                                            SELF.MotorVehicles := DATASET([TRANSFORM(iesp.duediligencepersonreport.t_DDRPersonVehicle,
                                                                                                SELF.OwnershipType.SubjectOwned := LEFT.inquiredOwned;
                                                                                                SELF.OwnershipType.SpouseOwned  := LEFT.spouseOwned;
                                                                                                SELF.OwnershipType.Owners := PROJECT(LEFT.owners, TRANSFORM(iesp.duediligenceshared.t_DDRPersonNameWithLexID,
                                                                                                                                                            SELF.lexID := (STRING)LEFT.did;
                                                                                                                                                            SELF.Name := iesp.ECL2ESP.SetName(LEFT.firstName, LEFT.middleName, LEFT.lastName, LEFT.suffix, DueDiligence.Constants.EMPTY))); //to add when added to iesp
                                                                                                SELF := LEFT;)]); 
                                                            SELF := LEFT;));
                                                                                                    
                                                                                                    
    rollReportVehicle := ROLLUP(SORT(reportVehicle, seq, did),
                                LEFT.seq = RIGHT.seq AND
                                LEFT.ultID = RIGHT.ultID AND
                                LEFT.orgID = RIGHT.orgID AND
                                LEFT.seleID = RIGHT.seleID AND
                                LEFT.did = RIGHT.did,
                                TRANSFORM(RECORDOF(LEFT),
                                          SELF.MotorVehicles := LEFT.MotorVehicles + RIGHT.MotorVehicles;
                                          SELF := LEFT;));

        
    RETURN rollReportVehicle;
END;