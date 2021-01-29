//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Accident,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Person_Accident(CFG_Compile __cfg = CFG_Compile) := MODULE
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
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    DATA57 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'subject(DEFAULT:Subject_:0),Acc_(DEFAULT:Acc_:0),pointofimpact(DEFAULT:Point_Of_Impact_:\'\'),driverbactesttype(DEFAULT:Driver_B_A_C_Test_Type_:\'\'),driverbactestresults(DEFAULT:Driver_B_A_C_Test_Results_:\'\'),driveralcoholdrugcode(DEFAULT:Driver_Alcohol_Drug_Code_:\'\'),driverphysicaldefects(DEFAULT:Driver_Physical_Defects_:\'\'),driverresidence(DEFAULT:Driver_Residence_:\'\'),driverinjuryseverity(DEFAULT:Driver_Injury_Severity_:\'\'),firstdriversafety(DEFAULT:First_Driver_Safety_:\'\'),seconddriversafety(DEFAULT:Second_Driver_Safety_:\'\'),driverejectcode(DEFAULT:Driver_Eject_Code_:\'\'),recommendreexam(DEFAULT:Recommend_Reexam_:\'\'),firstcontributingcause(DEFAULT:First_Contributing_Cause_:\'\'),secondcontributingcause(DEFAULT:Second_Contributing_Cause_:\'\'),thirdcontributingcause(DEFAULT:Third_Contributing_Cause_:\'\'),vehicleincidentid(DEFAULT:Vehicle_Incident_I_D_:\'\'),vehiclestatus(DEFAULT:Vehicle_Status_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),airbagsdeploy(DEFAULT:Airbags_Deploy_:\'\'),towed(DEFAULT:Towed_:\'\'),impactlocation(DEFAULT:Impact_Location_:\'\'),vehicleownerdrivercode(DEFAULT:Vehicle_Owner_Driver_Code_:\'\'),vehicledriveraction(DEFAULT:Vehicle_Driver_Action_:\'\'),vehicletravelon(DEFAULT:Vehicle_Travel_On_:\'\'),directionoftravel(DEFAULT:Direction_Of_Travel_:\'\'),estimatedvehiclespeed(DEFAULT:Estimated_Vehicle_Speed_:0),postedspeed(DEFAULT:Posted_Speed_:0),estimatedvehicledamage(DEFAULT:Estimated_Vehicle_Damage_:0),damagetype(DEFAULT:Damage_Type_:\'\'),vehicleremovedby(DEFAULT:Vehicle_Removed_By_:\'\'),howremovedcode(DEFAULT:How_Removed_Code_:\'\'),vehiclemovement(DEFAULT:Vehicle_Movement_:\'\'),vehiclefunction(DEFAULT:Vehicle_Function_:\'\'),vehiclefirstdefect(DEFAULT:Vehicle_First_Defect_:\'\'),vehicleseconddefect(DEFAULT:Vehicle_Second_Defect_:\'\'),vehicleroadwaylocation(DEFAULT:Vehicle_Roadway_Location_:\'\'),hazardousmaterialtransport(DEFAULT:Hazardous_Material_Transport_:\'\'),totaloccupancyvehicle(DEFAULT:Total_Occupancy_Vehicle_:0),totaloccupancysafetyequipment(DEFAULT:Total_Occupancy_Safety_Equipment_:0),movingviolation(DEFAULT:Moving_Violation_:\'\'),vehiclefaultcode(DEFAULT:Vehicle_Fault_Code_:\'\'),vehicleinsuredcode(DEFAULT:Vehicle_Insured_Code_:\'\'),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'did(OVERRIDE:Subject_:0),Acc_(DEFAULT:Acc_:0),point_of_impact(OVERRIDE:Point_Of_Impact_:\'\'),driver_bac_test_type(OVERRIDE:Driver_B_A_C_Test_Type_:\'\'),driver_bac_test_results(OVERRIDE:Driver_B_A_C_Test_Results_:\'\'),driver_alco_drug_code(OVERRIDE:Driver_Alcohol_Drug_Code_:\'\'),driver_physical_defects(OVERRIDE:Driver_Physical_Defects_:\'\'),driver_residence(OVERRIDE:Driver_Residence_:\'\'),driver_injury_severity(OVERRIDE:Driver_Injury_Severity_:\'\'),first_driver_safety(OVERRIDE:First_Driver_Safety_:\'\'),second_driver_safety(OVERRIDE:Second_Driver_Safety_:\'\'),driver_eject_code(OVERRIDE:Driver_Eject_Code_:\'\'),recommand_reexam(OVERRIDE:Recommend_Reexam_:\'\'),first_contrib_cause(OVERRIDE:First_Contributing_Cause_:\'\'),second_contrib_cause(OVERRIDE:Second_Contributing_Cause_:\'\'),third_contrib_cause(OVERRIDE:Third_Contributing_Cause_:\'\'),vehicleincidentid(DEFAULT:Vehicle_Incident_I_D_:\'\'),vehiclestatus(DEFAULT:Vehicle_Status_:\'\'),recordtype(DEFAULT:Record_Type_:\'\'),airbagsdeploy(DEFAULT:Airbags_Deploy_:\'\'),towed(DEFAULT:Towed_:\'\'),impactlocation(DEFAULT:Impact_Location_:\'\'),vehicleownerdrivercode(DEFAULT:Vehicle_Owner_Driver_Code_:\'\'),vehicledriveraction(DEFAULT:Vehicle_Driver_Action_:\'\'),vehicletravelon(DEFAULT:Vehicle_Travel_On_:\'\'),directionoftravel(DEFAULT:Direction_Of_Travel_:\'\'),estimatedvehiclespeed(DEFAULT:Estimated_Vehicle_Speed_:0),postedspeed(DEFAULT:Posted_Speed_:0),estimatedvehicledamage(DEFAULT:Estimated_Vehicle_Damage_:0),damagetype(DEFAULT:Damage_Type_:\'\'),vehicleremovedby(DEFAULT:Vehicle_Removed_By_:\'\'),howremovedcode(DEFAULT:How_Removed_Code_:\'\'),vehiclemovement(DEFAULT:Vehicle_Movement_:\'\'),vehiclefunction(DEFAULT:Vehicle_Function_:\'\'),vehiclefirstdefect(DEFAULT:Vehicle_First_Defect_:\'\'),vehicleseconddefect(DEFAULT:Vehicle_Second_Defect_:\'\'),vehicleroadwaylocation(DEFAULT:Vehicle_Roadway_Location_:\'\'),hazardousmaterialtransport(DEFAULT:Hazardous_Material_Transport_:\'\'),totaloccupancyvehicle(DEFAULT:Total_Occupancy_Vehicle_:0),totaloccupancysafetyequipment(DEFAULT:Total_Occupancy_Safety_Equipment_:0),movingviolation(DEFAULT:Moving_Violation_:\'\'),vehiclefaultcode(DEFAULT:Vehicle_Fault_Code_:\'\'),vehicleinsuredcode(DEFAULT:Vehicle_Insured_Code_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d0_KELfiltered := PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault((UNSIGNED)did <> 0 AND l_acc_nbr NOT IN ['','0']);
  SHARED __d0_Acc__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Acc_;
  END;
  SHARED __d0_Missing_Acc__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_KELfiltered,'l_acc_nbr','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault');
  SHARED __d0_Acc__Mapped := IF(__d0_Missing_Acc__UIDComponents = 'l_acc_nbr',PROJECT(__d0_KELfiltered,TRANSFORM(__d0_Acc__Layout,SELF.Acc_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_KELfiltered,__d0_Missing_Acc__UIDComponents),E_Accident(__cfg).Lookup,TRIM((STRING)LEFT.l_acc_nbr) = RIGHT.KeyVal,TRANSFORM(__d0_Acc__Layout,SELF.Acc_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_Acc__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault'));
  SHARED Hybrid_Archive_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'did(OVERRIDE:Subject_:0),Acc_(DEFAULT:Acc_:0),point_of_impact(OVERRIDE:Point_Of_Impact_:\'\'),driverbactesttype(DEFAULT:Driver_B_A_C_Test_Type_:\'\'),driverbactestresults(DEFAULT:Driver_B_A_C_Test_Results_:\'\'),driveralcoholdrugcode(DEFAULT:Driver_Alcohol_Drug_Code_:\'\'),driverphysicaldefects(DEFAULT:Driver_Physical_Defects_:\'\'),driverresidence(DEFAULT:Driver_Residence_:\'\'),driverinjuryseverity(DEFAULT:Driver_Injury_Severity_:\'\'),firstdriversafety(DEFAULT:First_Driver_Safety_:\'\'),seconddriversafety(DEFAULT:Second_Driver_Safety_:\'\'),driverejectcode(DEFAULT:Driver_Eject_Code_:\'\'),recommendreexam(DEFAULT:Recommend_Reexam_:\'\'),firstcontributingcause(DEFAULT:First_Contributing_Cause_:\'\'),secondcontributingcause(DEFAULT:Second_Contributing_Cause_:\'\'),thirdcontributingcause(DEFAULT:Third_Contributing_Cause_:\'\'),vehicle_incident_id(OVERRIDE:Vehicle_Incident_I_D_:\'\'),vehicle_status(OVERRIDE:Vehicle_Status_:\'\'),record_type(OVERRIDE:Record_Type_:\'\'),airbags_deploy(OVERRIDE:Airbags_Deploy_:\'\'),towed(OVERRIDE:Towed_:\'\'),impact_location(OVERRIDE:Impact_Location_:\'\'),vehicle_owner_driver_code(OVERRIDE:Vehicle_Owner_Driver_Code_:\'\'),vehicle_driver_action(OVERRIDE:Vehicle_Driver_Action_:\'\'),vehicle_travel_on(OVERRIDE:Vehicle_Travel_On_:\'\'),direction_travel(OVERRIDE:Direction_Of_Travel_:\'\'),est_vehicle_speed(OVERRIDE:Estimated_Vehicle_Speed_:0),posted_speed(OVERRIDE:Posted_Speed_:0),est_vehicle_damage(OVERRIDE:Estimated_Vehicle_Damage_:0),damage_type(OVERRIDE:Damage_Type_:\'\'),vehicle_removed_by(OVERRIDE:Vehicle_Removed_By_:\'\'),how_removed_code(OVERRIDE:How_Removed_Code_:\'\'),vehicle_movement(OVERRIDE:Vehicle_Movement_:\'\'),vehicle_function(OVERRIDE:Vehicle_Function_:\'\'),vehs_first_defect(OVERRIDE:Vehicle_First_Defect_:\'\'),vehs_second_defect(OVERRIDE:Vehicle_Second_Defect_:\'\'),vehicle_roadway_loc(OVERRIDE:Vehicle_Roadway_Location_:\'\'),hazard_material_transport(OVERRIDE:Hazardous_Material_Transport_:\'\'),total_occu_vehicle(OVERRIDE:Total_Occupancy_Vehicle_:0),total_occu_saf_equip(OVERRIDE:Total_Occupancy_Safety_Equipment_:0),moving_violation(OVERRIDE:Moving_Violation_:\'\'),vehicle_fault_code(OVERRIDE:Vehicle_Fault_Code_:\'\'),vehicle_insur_code(OVERRIDE:Vehicle_Insured_Code_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_1Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d1_KELfiltered := PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault((UNSIGNED)did <> 0 AND l_accnbr NOT IN ['','0']);
  SHARED __d1_Acc__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Acc_;
  END;
  SHARED __d1_Missing_Acc__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_KELfiltered,'l_accnbr','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault');
  SHARED __d1_Acc__Mapped := IF(__d1_Missing_Acc__UIDComponents = 'l_accnbr',PROJECT(__d1_KELfiltered,TRANSFORM(__d1_Acc__Layout,SELF.Acc_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_KELfiltered,__d1_Missing_Acc__UIDComponents),E_Accident(__cfg).Lookup,TRIM((STRING)LEFT.l_accnbr) = RIGHT.KeyVal,TRANSFORM(__d1_Acc__Layout,SELF.Acc_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Prefiltered := __d1_Acc__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault'));
  EXPORT InData := __d0 + __d1;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
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
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Subject_,Acc_,Point_Of_Impact_,Driver_B_A_C_Test_Type_,Driver_B_A_C_Test_Results_,Driver_Alcohol_Drug_Code_,Driver_Physical_Defects_,Driver_Residence_,Driver_Injury_Severity_,First_Driver_Safety_,Second_Driver_Safety_,Driver_Eject_Code_,Recommend_Reexam_,First_Contributing_Cause_,Second_Contributing_Cause_,Third_Contributing_Cause_,Vehicle_Incident_I_D_,Vehicle_Status_,Record_Type_,Airbags_Deploy_,Towed_,Impact_Location_,Vehicle_Owner_Driver_Code_,Vehicle_Driver_Action_,Vehicle_Travel_On_,Direction_Of_Travel_,Estimated_Vehicle_Speed_,Posted_Speed_,Estimated_Vehicle_Damage_,Damage_Type_,Vehicle_Removed_By_,How_Removed_Code_,Vehicle_Movement_,Vehicle_Function_,Vehicle_First_Defect_,Vehicle_Second_Defect_,Vehicle_Roadway_Location_,Hazardous_Material_Transport_,Total_Occupancy_Vehicle_,Total_Occupancy_Safety_Equipment_,Moving_Violation_,Vehicle_Fault_Code_,Vehicle_Insured_Code_,ALL));
  Person_Accident_Group := __PostFilter;
  Layout Person_Accident__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Person_Accident__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Accident_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_Accident__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Accident_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_Accident__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Acc__Orphan := JOIN(InData(__NN(Acc_)),E_Accident(__cfg).__Result,__EEQP(LEFT.Acc_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Acc__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Acc__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','did',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','Acc',COUNT(__d0(__NL(Acc_))),COUNT(__d0(__NN(Acc_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','point_of_impact',COUNT(__d0(__NL(Point_Of_Impact_))),COUNT(__d0(__NN(Point_Of_Impact_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','driver_bac_test_type',COUNT(__d0(__NL(Driver_B_A_C_Test_Type_))),COUNT(__d0(__NN(Driver_B_A_C_Test_Type_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','driver_bac_test_results',COUNT(__d0(__NL(Driver_B_A_C_Test_Results_))),COUNT(__d0(__NN(Driver_B_A_C_Test_Results_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','driver_alco_drug_code',COUNT(__d0(__NL(Driver_Alcohol_Drug_Code_))),COUNT(__d0(__NN(Driver_Alcohol_Drug_Code_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','driver_physical_defects',COUNT(__d0(__NL(Driver_Physical_Defects_))),COUNT(__d0(__NN(Driver_Physical_Defects_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','driver_residence',COUNT(__d0(__NL(Driver_Residence_))),COUNT(__d0(__NN(Driver_Residence_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','driver_injury_severity',COUNT(__d0(__NL(Driver_Injury_Severity_))),COUNT(__d0(__NN(Driver_Injury_Severity_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','first_driver_safety',COUNT(__d0(__NL(First_Driver_Safety_))),COUNT(__d0(__NN(First_Driver_Safety_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','second_driver_safety',COUNT(__d0(__NL(Second_Driver_Safety_))),COUNT(__d0(__NN(Second_Driver_Safety_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','driver_eject_code',COUNT(__d0(__NL(Driver_Eject_Code_))),COUNT(__d0(__NN(Driver_Eject_Code_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','recommand_reexam',COUNT(__d0(__NL(Recommend_Reexam_))),COUNT(__d0(__NN(Recommend_Reexam_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','first_contrib_cause',COUNT(__d0(__NL(First_Contributing_Cause_))),COUNT(__d0(__NN(First_Contributing_Cause_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','second_contrib_cause',COUNT(__d0(__NL(Second_Contributing_Cause_))),COUNT(__d0(__NN(Second_Contributing_Cause_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','third_contrib_cause',COUNT(__d0(__NL(Third_Contributing_Cause_))),COUNT(__d0(__NN(Third_Contributing_Cause_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','VehicleIncidentID',COUNT(__d0(__NL(Vehicle_Incident_I_D_))),COUNT(__d0(__NN(Vehicle_Incident_I_D_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','VehicleStatus',COUNT(__d0(__NL(Vehicle_Status_))),COUNT(__d0(__NN(Vehicle_Status_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','RecordType',COUNT(__d0(__NL(Record_Type_))),COUNT(__d0(__NN(Record_Type_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','AirbagsDeploy',COUNT(__d0(__NL(Airbags_Deploy_))),COUNT(__d0(__NN(Airbags_Deploy_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','Towed',COUNT(__d0(__NL(Towed_))),COUNT(__d0(__NN(Towed_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','ImpactLocation',COUNT(__d0(__NL(Impact_Location_))),COUNT(__d0(__NN(Impact_Location_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','VehicleOwnerDriverCode',COUNT(__d0(__NL(Vehicle_Owner_Driver_Code_))),COUNT(__d0(__NN(Vehicle_Owner_Driver_Code_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','VehicleDriverAction',COUNT(__d0(__NL(Vehicle_Driver_Action_))),COUNT(__d0(__NN(Vehicle_Driver_Action_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','VehicleTravelOn',COUNT(__d0(__NL(Vehicle_Travel_On_))),COUNT(__d0(__NN(Vehicle_Travel_On_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','DirectionOfTravel',COUNT(__d0(__NL(Direction_Of_Travel_))),COUNT(__d0(__NN(Direction_Of_Travel_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','EstimatedVehicleSpeed',COUNT(__d0(__NL(Estimated_Vehicle_Speed_))),COUNT(__d0(__NN(Estimated_Vehicle_Speed_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','PostedSpeed',COUNT(__d0(__NL(Posted_Speed_))),COUNT(__d0(__NN(Posted_Speed_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','EstimatedVehicleDamage',COUNT(__d0(__NL(Estimated_Vehicle_Damage_))),COUNT(__d0(__NN(Estimated_Vehicle_Damage_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','DamageType',COUNT(__d0(__NL(Damage_Type_))),COUNT(__d0(__NN(Damage_Type_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','VehicleRemovedBy',COUNT(__d0(__NL(Vehicle_Removed_By_))),COUNT(__d0(__NN(Vehicle_Removed_By_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','HowRemovedCode',COUNT(__d0(__NL(How_Removed_Code_))),COUNT(__d0(__NN(How_Removed_Code_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','VehicleMovement',COUNT(__d0(__NL(Vehicle_Movement_))),COUNT(__d0(__NN(Vehicle_Movement_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','VehicleFunction',COUNT(__d0(__NL(Vehicle_Function_))),COUNT(__d0(__NN(Vehicle_Function_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','VehicleFirstDefect',COUNT(__d0(__NL(Vehicle_First_Defect_))),COUNT(__d0(__NN(Vehicle_First_Defect_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','VehicleSecondDefect',COUNT(__d0(__NL(Vehicle_Second_Defect_))),COUNT(__d0(__NN(Vehicle_Second_Defect_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','VehicleRoadwayLocation',COUNT(__d0(__NL(Vehicle_Roadway_Location_))),COUNT(__d0(__NN(Vehicle_Roadway_Location_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','HazardousMaterialTransport',COUNT(__d0(__NL(Hazardous_Material_Transport_))),COUNT(__d0(__NN(Hazardous_Material_Transport_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','TotalOccupancyVehicle',COUNT(__d0(__NL(Total_Occupancy_Vehicle_))),COUNT(__d0(__NN(Total_Occupancy_Vehicle_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','TotalOccupancySafetyEquipment',COUNT(__d0(__NL(Total_Occupancy_Safety_Equipment_))),COUNT(__d0(__NN(Total_Occupancy_Safety_Equipment_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','MovingViolation',COUNT(__d0(__NL(Moving_Violation_))),COUNT(__d0(__NN(Moving_Violation_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','VehicleFaultCode',COUNT(__d0(__NL(Vehicle_Fault_Code_))),COUNT(__d0(__NN(Vehicle_Fault_Code_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','VehicleInsuredCode',COUNT(__d0(__NL(Vehicle_Insured_Code_))),COUNT(__d0(__NN(Vehicle_Insured_Code_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__Key_ECrash4_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','did',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','Acc',COUNT(__d1(__NL(Acc_))),COUNT(__d1(__NN(Acc_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','point_of_impact',COUNT(__d1(__NL(Point_Of_Impact_))),COUNT(__d1(__NN(Point_Of_Impact_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','DriverBACTestType',COUNT(__d1(__NL(Driver_B_A_C_Test_Type_))),COUNT(__d1(__NN(Driver_B_A_C_Test_Type_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','DriverBACTestResults',COUNT(__d1(__NL(Driver_B_A_C_Test_Results_))),COUNT(__d1(__NN(Driver_B_A_C_Test_Results_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','DriverAlcoholDrugCode',COUNT(__d1(__NL(Driver_Alcohol_Drug_Code_))),COUNT(__d1(__NN(Driver_Alcohol_Drug_Code_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','DriverPhysicalDefects',COUNT(__d1(__NL(Driver_Physical_Defects_))),COUNT(__d1(__NN(Driver_Physical_Defects_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','DriverResidence',COUNT(__d1(__NL(Driver_Residence_))),COUNT(__d1(__NN(Driver_Residence_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','DriverInjurySeverity',COUNT(__d1(__NL(Driver_Injury_Severity_))),COUNT(__d1(__NN(Driver_Injury_Severity_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','FirstDriverSafety',COUNT(__d1(__NL(First_Driver_Safety_))),COUNT(__d1(__NN(First_Driver_Safety_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','SecondDriverSafety',COUNT(__d1(__NL(Second_Driver_Safety_))),COUNT(__d1(__NN(Second_Driver_Safety_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','DriverEjectCode',COUNT(__d1(__NL(Driver_Eject_Code_))),COUNT(__d1(__NN(Driver_Eject_Code_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','RecommendReexam',COUNT(__d1(__NL(Recommend_Reexam_))),COUNT(__d1(__NN(Recommend_Reexam_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','FirstContributingCause',COUNT(__d1(__NL(First_Contributing_Cause_))),COUNT(__d1(__NN(First_Contributing_Cause_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','SecondContributingCause',COUNT(__d1(__NL(Second_Contributing_Cause_))),COUNT(__d1(__NN(Second_Contributing_Cause_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','ThirdContributingCause',COUNT(__d1(__NL(Third_Contributing_Cause_))),COUNT(__d1(__NN(Third_Contributing_Cause_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','vehicle_incident_id',COUNT(__d1(__NL(Vehicle_Incident_I_D_))),COUNT(__d1(__NN(Vehicle_Incident_I_D_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','vehicle_status',COUNT(__d1(__NL(Vehicle_Status_))),COUNT(__d1(__NN(Vehicle_Status_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','record_type',COUNT(__d1(__NL(Record_Type_))),COUNT(__d1(__NN(Record_Type_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','airbags_deploy',COUNT(__d1(__NL(Airbags_Deploy_))),COUNT(__d1(__NN(Airbags_Deploy_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','towed',COUNT(__d1(__NL(Towed_))),COUNT(__d1(__NN(Towed_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','impact_location',COUNT(__d1(__NL(Impact_Location_))),COUNT(__d1(__NN(Impact_Location_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','vehicle_owner_driver_code',COUNT(__d1(__NL(Vehicle_Owner_Driver_Code_))),COUNT(__d1(__NN(Vehicle_Owner_Driver_Code_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','vehicle_driver_action',COUNT(__d1(__NL(Vehicle_Driver_Action_))),COUNT(__d1(__NN(Vehicle_Driver_Action_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','vehicle_travel_on',COUNT(__d1(__NL(Vehicle_Travel_On_))),COUNT(__d1(__NN(Vehicle_Travel_On_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','direction_travel',COUNT(__d1(__NL(Direction_Of_Travel_))),COUNT(__d1(__NN(Direction_Of_Travel_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','est_vehicle_speed',COUNT(__d1(__NL(Estimated_Vehicle_Speed_))),COUNT(__d1(__NN(Estimated_Vehicle_Speed_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','posted_speed',COUNT(__d1(__NL(Posted_Speed_))),COUNT(__d1(__NN(Posted_Speed_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','est_vehicle_damage',COUNT(__d1(__NL(Estimated_Vehicle_Damage_))),COUNT(__d1(__NN(Estimated_Vehicle_Damage_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','damage_type',COUNT(__d1(__NL(Damage_Type_))),COUNT(__d1(__NN(Damage_Type_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','vehicle_removed_by',COUNT(__d1(__NL(Vehicle_Removed_By_))),COUNT(__d1(__NN(Vehicle_Removed_By_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','how_removed_code',COUNT(__d1(__NL(How_Removed_Code_))),COUNT(__d1(__NN(How_Removed_Code_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','vehicle_movement',COUNT(__d1(__NL(Vehicle_Movement_))),COUNT(__d1(__NN(Vehicle_Movement_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','vehicle_function',COUNT(__d1(__NL(Vehicle_Function_))),COUNT(__d1(__NN(Vehicle_Function_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','vehs_first_defect',COUNT(__d1(__NL(Vehicle_First_Defect_))),COUNT(__d1(__NN(Vehicle_First_Defect_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','vehs_second_defect',COUNT(__d1(__NL(Vehicle_Second_Defect_))),COUNT(__d1(__NN(Vehicle_Second_Defect_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','vehicle_roadway_loc',COUNT(__d1(__NL(Vehicle_Roadway_Location_))),COUNT(__d1(__NN(Vehicle_Roadway_Location_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','hazard_material_transport',COUNT(__d1(__NL(Hazardous_Material_Transport_))),COUNT(__d1(__NN(Hazardous_Material_Transport_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','total_occu_vehicle',COUNT(__d1(__NL(Total_Occupancy_Vehicle_))),COUNT(__d1(__NN(Total_Occupancy_Vehicle_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','total_occu_saf_equip',COUNT(__d1(__NL(Total_Occupancy_Safety_Equipment_))),COUNT(__d1(__NN(Total_Occupancy_Safety_Equipment_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','moving_violation',COUNT(__d1(__NL(Moving_Violation_))),COUNT(__d1(__NN(Moving_Violation_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','vehicle_fault_code',COUNT(__d1(__NL(Vehicle_Fault_Code_))),COUNT(__d1(__NN(Vehicle_Fault_Code_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','vehicle_insur_code',COUNT(__d1(__NL(Vehicle_Insured_Code_))),COUNT(__d1(__NN(Vehicle_Insured_Code_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'PersonAccident','PublicRecords_KEL.Files.NonFCRA.FLAccidents_Ecrash__key_EcrashV2_accnbr_Vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
