IMPORT BIPv2, DueDiligence, iesp;

 EXPORT reportSharedVehicle (DATASET(DueDiligence.LayoutsInternal.SharedVehicleSlim) inVehicles) := FUNCTION

    //***normalize the data and produce a simple list of vehicles***    
    flattenVehicle := NORMALIZE(inVehicles, LEFT.allVehicles, 
                              TRANSFORM(DueDiligence.LayoutsInternalReport.SharedVehicleLayout,
                                        SELF.seq          := LEFT.seq;
                                        SELF.ultID        := LEFT.ultID;
                                        SELF.orgID        := LEFT.orgID;
                                        SELF.seleID       := LEFT.seleID;
                                        SELF.did          := LEFT.did;
                                        //***Extract the data from the DATASET from the RIGHT
                                        SELF.inquiredOwned                := RIGHT.inquiredOwned;
                                        SELF.spouseOwned                  := RIGHT.spouseOwned;
                                        SELF.owners                       := RIGHT.vehicleOwners;    //***This is a DATASET/List of vehicle owners
                                        SELF.vehicle.year                 := RIGHT.Orig_Year; 
                                        SELF.vehicle.make                 := RIGHT.Orig_Make_Desc;
                                        SELF.vehicle.model                := RIGHT.Orig_Model_Desc;
                                        SELF.LicensePlateType.detailType  := RIGHT.license_Plate_Type;
                                        SELF.ClassType.detailType         := RIGHT.Class_Type;
                                        SELF.BasePrice                    := RIGHT.Vina_Price;
                                        SELF.MotorVehicle.vin             := RIGHT.Orig_VIN;
                                        SELF.Title.state                  := RIGHT.Title_State; 
                                        SELF.Title.date.year              := RIGHT.Title_Year;
                                        SELF.Title.date.month             := RIGHT.Title_Month;
                                        SELF.Title.date.day               := RIGHT.Title_Day;
                                        SELF.Registration.state           := RIGHT.Registered_State;
                                        SELF.Registration.date.year       := RIGHT.Registered_Year;
                                        SELF.Registration.date.month      := RIGHT.Registered_Month;
                                        SELF.Registration.date.day        := RIGHT.Registered_Day;
                                        SELF                              :=[];));

    //***Sort the data in the seqence needed to 
    sortGroupVehicle := GROUP(SORT(flattenVehicle, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
    limitedVehicles := DueDiligence.Common.GetMaxRecords(sortGroupVehicle, iesp.constants.DDRAttributesConst.MaxVehicles);                                 

        
    RETURN limitedVehicles;
END;