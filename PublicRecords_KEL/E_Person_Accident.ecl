//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Accident,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Person_Accident(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Accident().Typ) Acc_;
    KEL.typ.nstr Point_Of_Impact_;
    KEL.typ.nstr Driver_B_A_C_Test_Type_;
    KEL.typ.nint Driver_B_A_C_Test_Results_;
    KEL.typ.nint Driver_Alcohol_Drug_Code_;
    KEL.typ.nint Driver_Physical_Defects_;
    KEL.typ.nint Driver_Residence_;
    KEL.typ.nint Driver_Injury_Severity_;
    KEL.typ.nint First_Driver_Safety_;
    KEL.typ.nint Second_Driver_Safety_;
    KEL.typ.nint Driver_Eject_Code_;
    KEL.typ.nint Recommend_Reexam_;
    KEL.typ.nint First_Contributing_Cause_;
    KEL.typ.nint Second_Contributing_Cause_;
    KEL.typ.nint Third_Contributing_Cause_;
    KEL.typ.nstr Vehicle_Incident_I_D_;
    KEL.typ.nstr Vehicle_Status_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nint Airbags_Deploy_;
    KEL.typ.nint Towed_;
    KEL.typ.nstr Impact_Location_;
    KEL.typ.nint Vehicle_Owner_Driver_Code_;
    KEL.typ.nint Vehicle_Driver_Action_;
    KEL.typ.nstr Vehicle_Travel_On_;
    KEL.typ.nstr Direction_Of_Travel_;
    KEL.typ.nint Estimated_Vehicle_Speed_;
    KEL.typ.nint Posted_Speed_;
    KEL.typ.nint Estimated_Vehicle_Damage_;
    KEL.typ.nint Damage_Type_;
    KEL.typ.nstr Vehicle_Removed_By_;
    KEL.typ.nint How_Removed_Code_;
    KEL.typ.nint Vehicle_Movement_;
    KEL.typ.nint Vehicle_Function_;
    KEL.typ.nint Vehicle_First_Defect_;
    KEL.typ.nint Vehicle_Second_Defect_;
    KEL.typ.nint Vehicle_Roadway_Location_;
    KEL.typ.nint Hazardous_Material_Transport_;
    KEL.typ.nint Total_Occupancy_Vehicle_;
    KEL.typ.nint Total_Occupancy_Safety_Equipment_;
    KEL.typ.nint Moving_Violation_;
    KEL.typ.nint Vehicle_Fault_Code_;
    KEL.typ.nstr Vehicle_Insured_Code_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'subject(Subject_:0),Acc_(Acc_:0),pointofimpact(Point_Of_Impact_:\'\'),driverbactesttype(Driver_B_A_C_Test_Type_:\'\'),driverbactestresults(Driver_B_A_C_Test_Results_:\'\'),driveralcoholdrugcode(Driver_Alcohol_Drug_Code_:\'\'),driverphysicaldefects(Driver_Physical_Defects_:\'\'),driverresidence(Driver_Residence_:\'\'),driverinjuryseverity(Driver_Injury_Severity_:\'\'),firstdriversafety(First_Driver_Safety_:\'\'),seconddriversafety(Second_Driver_Safety_:\'\'),driverejectcode(Driver_Eject_Code_:\'\'),recommendreexam(Recommend_Reexam_:\'\'),firstcontributingcause(First_Contributing_Cause_:\'\'),secondcontributingcause(Second_Contributing_Cause_:\'\'),thirdcontributingcause(Third_Contributing_Cause_:\'\'),vehicleincidentid(Vehicle_Incident_I_D_:\'\'),vehiclestatus(Vehicle_Status_:\'\'),recordtype(Record_Type_:\'\'),airbagsdeploy(Airbags_Deploy_:\'\'),towed(Towed_:\'\'),impactlocation(Impact_Location_:\'\'),vehicleownerdrivercode(Vehicle_Owner_Driver_Code_:\'\'),vehicledriveraction(Vehicle_Driver_Action_:\'\'),vehicletravelon(Vehicle_Travel_On_:\'\'),directionoftravel(Direction_Of_Travel_:\'\'),estimatedvehiclespeed(Estimated_Vehicle_Speed_:0),postedspeed(Posted_Speed_:0),estimatedvehicledamage(Estimated_Vehicle_Damage_:0),damagetype(Damage_Type_:\'\'),vehicleremovedby(Vehicle_Removed_By_:\'\'),howremovedcode(How_Removed_Code_:\'\'),vehiclemovement(Vehicle_Movement_:\'\'),vehiclefunction(Vehicle_Function_:\'\'),vehiclefirstdefect(Vehicle_First_Defect_:\'\'),vehicleseconddefect(Vehicle_Second_Defect_:\'\'),vehicleroadwaylocation(Vehicle_Roadway_Location_:\'\'),hazardousmaterialtransport(Hazardous_Material_Transport_:\'\'),totaloccupancyvehicle(Total_Occupancy_Vehicle_:0),totaloccupancysafetyequipment(Total_Occupancy_Safety_Equipment_:0),movingviolation(Moving_Violation_:\'\'),vehiclefaultcode(Vehicle_Fault_Code_:\'\'),vehicleinsuredcode(Vehicle_Insured_Code_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Acc__Layout := RECORD
    RECORDOF(__in);
    KEL.typ.uid Acc_;
  END;
  SHARED __d0_Acc__Mapped := JOIN(__in,E_Accident(__in,__cfg).Lookup,TRIM((STRING)LEFT.AccidentNumber) = RIGHT.KeyVal,TRANSFORM(__d0_Acc__Layout,SELF.Acc_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Acc__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Accident().Typ) Acc_;
    KEL.typ.nstr Point_Of_Impact_;
    KEL.typ.nstr Driver_B_A_C_Test_Type_;
    KEL.typ.nint Driver_B_A_C_Test_Results_;
    KEL.typ.nint Driver_Alcohol_Drug_Code_;
    KEL.typ.nint Driver_Physical_Defects_;
    KEL.typ.nint Driver_Residence_;
    KEL.typ.nint Driver_Injury_Severity_;
    KEL.typ.nint First_Driver_Safety_;
    KEL.typ.nint Second_Driver_Safety_;
    KEL.typ.nint Driver_Eject_Code_;
    KEL.typ.nint Recommend_Reexam_;
    KEL.typ.nint First_Contributing_Cause_;
    KEL.typ.nint Second_Contributing_Cause_;
    KEL.typ.nint Third_Contributing_Cause_;
    KEL.typ.nstr Vehicle_Incident_I_D_;
    KEL.typ.nstr Vehicle_Status_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nint Airbags_Deploy_;
    KEL.typ.nint Towed_;
    KEL.typ.nstr Impact_Location_;
    KEL.typ.nint Vehicle_Owner_Driver_Code_;
    KEL.typ.nint Vehicle_Driver_Action_;
    KEL.typ.nstr Vehicle_Travel_On_;
    KEL.typ.nstr Direction_Of_Travel_;
    KEL.typ.nint Estimated_Vehicle_Speed_;
    KEL.typ.nint Posted_Speed_;
    KEL.typ.nint Estimated_Vehicle_Damage_;
    KEL.typ.nint Damage_Type_;
    KEL.typ.nstr Vehicle_Removed_By_;
    KEL.typ.nint How_Removed_Code_;
    KEL.typ.nint Vehicle_Movement_;
    KEL.typ.nint Vehicle_Function_;
    KEL.typ.nint Vehicle_First_Defect_;
    KEL.typ.nint Vehicle_Second_Defect_;
    KEL.typ.nint Vehicle_Roadway_Location_;
    KEL.typ.nint Hazardous_Material_Transport_;
    KEL.typ.nint Total_Occupancy_Vehicle_;
    KEL.typ.nint Total_Occupancy_Safety_Equipment_;
    KEL.typ.nint Moving_Violation_;
    KEL.typ.nint Vehicle_Fault_Code_;
    KEL.typ.nstr Vehicle_Insured_Code_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Subject_,Acc_,Point_Of_Impact_,Driver_B_A_C_Test_Type_,Driver_B_A_C_Test_Results_,Driver_Alcohol_Drug_Code_,Driver_Physical_Defects_,Driver_Residence_,Driver_Injury_Severity_,First_Driver_Safety_,Second_Driver_Safety_,Driver_Eject_Code_,Recommend_Reexam_,First_Contributing_Cause_,Second_Contributing_Cause_,Third_Contributing_Cause_,Vehicle_Incident_I_D_,Vehicle_Status_,Record_Type_,Airbags_Deploy_,Towed_,Impact_Location_,Vehicle_Owner_Driver_Code_,Vehicle_Driver_Action_,Vehicle_Travel_On_,Direction_Of_Travel_,Estimated_Vehicle_Speed_,Posted_Speed_,Estimated_Vehicle_Damage_,Damage_Type_,Vehicle_Removed_By_,How_Removed_Code_,Vehicle_Movement_,Vehicle_Function_,Vehicle_First_Defect_,Vehicle_Second_Defect_,Vehicle_Roadway_Location_,Hazardous_Material_Transport_,Total_Occupancy_Vehicle_,Total_Occupancy_Safety_Equipment_,Moving_Violation_,Vehicle_Fault_Code_,Vehicle_Insured_Code_,ALL));
  Person_Accident_Group := __PostFilter;
  Layout Person_Accident__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Person_Accident__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Accident_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_Accident__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Accident_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_Accident__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::PublicRecords_KEL::Person_Accident::Result' + IF(__cfg.PersistId <> '','::' + __cfg.PersistId,''),EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Acc__Orphan := JOIN(InData(__NN(Acc_)),E_Accident(__in,__cfg).__Result,__EEQP(LEFT.Acc_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Acc__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Acc__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Subject',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Acc',COUNT(__d0(__NL(Acc_))),COUNT(__d0(__NN(Acc_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PointOfImpact',COUNT(__d0(__NL(Point_Of_Impact_))),COUNT(__d0(__NN(Point_Of_Impact_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DriverBACTestType',COUNT(__d0(__NL(Driver_B_A_C_Test_Type_))),COUNT(__d0(__NN(Driver_B_A_C_Test_Type_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DriverBACTestResults',COUNT(__d0(__NL(Driver_B_A_C_Test_Results_))),COUNT(__d0(__NN(Driver_B_A_C_Test_Results_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DriverAlcoholDrugCode',COUNT(__d0(__NL(Driver_Alcohol_Drug_Code_))),COUNT(__d0(__NN(Driver_Alcohol_Drug_Code_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DriverPhysicalDefects',COUNT(__d0(__NL(Driver_Physical_Defects_))),COUNT(__d0(__NN(Driver_Physical_Defects_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DriverResidence',COUNT(__d0(__NL(Driver_Residence_))),COUNT(__d0(__NN(Driver_Residence_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DriverInjurySeverity',COUNT(__d0(__NL(Driver_Injury_Severity_))),COUNT(__d0(__NN(Driver_Injury_Severity_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FirstDriverSafety',COUNT(__d0(__NL(First_Driver_Safety_))),COUNT(__d0(__NN(First_Driver_Safety_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondDriverSafety',COUNT(__d0(__NL(Second_Driver_Safety_))),COUNT(__d0(__NN(Second_Driver_Safety_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DriverEjectCode',COUNT(__d0(__NL(Driver_Eject_Code_))),COUNT(__d0(__NN(Driver_Eject_Code_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecommendReexam',COUNT(__d0(__NL(Recommend_Reexam_))),COUNT(__d0(__NN(Recommend_Reexam_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FirstContributingCause',COUNT(__d0(__NL(First_Contributing_Cause_))),COUNT(__d0(__NN(First_Contributing_Cause_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SecondContributingCause',COUNT(__d0(__NL(Second_Contributing_Cause_))),COUNT(__d0(__NN(Second_Contributing_Cause_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ThirdContributingCause',COUNT(__d0(__NL(Third_Contributing_Cause_))),COUNT(__d0(__NN(Third_Contributing_Cause_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleIncidentID',COUNT(__d0(__NL(Vehicle_Incident_I_D_))),COUNT(__d0(__NN(Vehicle_Incident_I_D_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleStatus',COUNT(__d0(__NL(Vehicle_Status_))),COUNT(__d0(__NN(Vehicle_Status_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordType',COUNT(__d0(__NL(Record_Type_))),COUNT(__d0(__NN(Record_Type_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AirbagsDeploy',COUNT(__d0(__NL(Airbags_Deploy_))),COUNT(__d0(__NN(Airbags_Deploy_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Towed',COUNT(__d0(__NL(Towed_))),COUNT(__d0(__NN(Towed_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ImpactLocation',COUNT(__d0(__NL(Impact_Location_))),COUNT(__d0(__NN(Impact_Location_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleOwnerDriverCode',COUNT(__d0(__NL(Vehicle_Owner_Driver_Code_))),COUNT(__d0(__NN(Vehicle_Owner_Driver_Code_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleDriverAction',COUNT(__d0(__NL(Vehicle_Driver_Action_))),COUNT(__d0(__NN(Vehicle_Driver_Action_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleTravelOn',COUNT(__d0(__NL(Vehicle_Travel_On_))),COUNT(__d0(__NN(Vehicle_Travel_On_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DirectionOfTravel',COUNT(__d0(__NL(Direction_Of_Travel_))),COUNT(__d0(__NN(Direction_Of_Travel_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EstimatedVehicleSpeed',COUNT(__d0(__NL(Estimated_Vehicle_Speed_))),COUNT(__d0(__NN(Estimated_Vehicle_Speed_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PostedSpeed',COUNT(__d0(__NL(Posted_Speed_))),COUNT(__d0(__NN(Posted_Speed_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EstimatedVehicleDamage',COUNT(__d0(__NL(Estimated_Vehicle_Damage_))),COUNT(__d0(__NN(Estimated_Vehicle_Damage_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DamageType',COUNT(__d0(__NL(Damage_Type_))),COUNT(__d0(__NN(Damage_Type_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleRemovedBy',COUNT(__d0(__NL(Vehicle_Removed_By_))),COUNT(__d0(__NN(Vehicle_Removed_By_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HowRemovedCode',COUNT(__d0(__NL(How_Removed_Code_))),COUNT(__d0(__NN(How_Removed_Code_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleMovement',COUNT(__d0(__NL(Vehicle_Movement_))),COUNT(__d0(__NN(Vehicle_Movement_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleFunction',COUNT(__d0(__NL(Vehicle_Function_))),COUNT(__d0(__NN(Vehicle_Function_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleFirstDefect',COUNT(__d0(__NL(Vehicle_First_Defect_))),COUNT(__d0(__NN(Vehicle_First_Defect_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleSecondDefect',COUNT(__d0(__NL(Vehicle_Second_Defect_))),COUNT(__d0(__NN(Vehicle_Second_Defect_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleRoadwayLocation',COUNT(__d0(__NL(Vehicle_Roadway_Location_))),COUNT(__d0(__NN(Vehicle_Roadway_Location_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HazardousMaterialTransport',COUNT(__d0(__NL(Hazardous_Material_Transport_))),COUNT(__d0(__NN(Hazardous_Material_Transport_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TotalOccupancyVehicle',COUNT(__d0(__NL(Total_Occupancy_Vehicle_))),COUNT(__d0(__NN(Total_Occupancy_Vehicle_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TotalOccupancySafetyEquipment',COUNT(__d0(__NL(Total_Occupancy_Safety_Equipment_))),COUNT(__d0(__NN(Total_Occupancy_Safety_Equipment_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','MovingViolation',COUNT(__d0(__NL(Moving_Violation_))),COUNT(__d0(__NN(Moving_Violation_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleFaultCode',COUNT(__d0(__NL(Vehicle_Fault_Code_))),COUNT(__d0(__NN(Vehicle_Fault_Code_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VehicleInsuredCode',COUNT(__d0(__NL(Vehicle_Insured_Code_))),COUNT(__d0(__NN(Vehicle_Insured_Code_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonAccident','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
