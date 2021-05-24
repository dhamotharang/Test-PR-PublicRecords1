//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Person,E_Vehicle FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT E_Person_Vehicle(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.nkdate Registration_First_Date_;
    KEL.typ.nkdate Registration_Earliest_Effective_Date_;
    KEL.typ.nkdate Registration_Latest_Effective_Date_;
    KEL.typ.nkdate Registration_Latest_Expiratione_Date_;
    KEL.typ.nint Registration_Record_Count_;
    KEL.typ.nstr Registration_Decal_Number_;
    KEL.typ.nint Registratoin_Decal_Year_;
    KEL.typ.nstr Registration_Status_Code_;
    KEL.typ.nstr Registration_Status_Description_;
    KEL.typ.nstr Registration_True_License_Plate_;
    KEL.typ.nstr Registration_License_Plate_;
    KEL.typ.nstr Registration_License_State_;
    KEL.typ.nstr Registration_License_Plate_Type_Code_;
    KEL.typ.nstr Registration_License_Plate_Type_Description_;
    KEL.typ.nstr Registration_Previous_License_State_;
    KEL.typ.nstr Registration_Previous_License_Plate_;
    KEL.typ.nstr Title_Number_;
    KEL.typ.nkdate Title_Earliest_Issue_Date_;
    KEL.typ.nkdate Title_Latest_Issue_Date_;
    KEL.typ.nkdate Title_Previous_Issue_Date_;
    KEL.typ.nint Title_Record_Count_;
    KEL.typ.nstr Title_Status_Code_;
    KEL.typ.nstr Title_Status_Description_;
    KEL.typ.nint Title_Odometer_Mileage_;
    KEL.typ.nstr Title_Odometer_Status_Code_;
    KEL.typ.nstr Title_Odometer_Status_Description_;
    KEL.typ.nkdate Title_Odometer_Date_;
    KEL.typ.nstr Sequence_Key_;
    KEL.typ.nstr History_;
    KEL.typ.nbool History_Source_;
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
  SHARED __Mapping := 'subject(DEFAULT:Subject_:0),Automobile_(DEFAULT:Automobile_:0),registrationfirstdate(DEFAULT:Registration_First_Date_:DATE),registrationearliesteffectivedate(DEFAULT:Registration_Earliest_Effective_Date_:DATE),registrationlatesteffectivedate(DEFAULT:Registration_Latest_Effective_Date_:DATE),registrationlatestexpirationedate(DEFAULT:Registration_Latest_Expiratione_Date_:DATE),registrationrecordcount(DEFAULT:Registration_Record_Count_:0),registrationdecalnumber(DEFAULT:Registration_Decal_Number_:\'\'),registratoindecalyear(DEFAULT:Registratoin_Decal_Year_:0),registrationstatuscode(DEFAULT:Registration_Status_Code_:\'\'),registrationstatusdescription(DEFAULT:Registration_Status_Description_:\'\'),registrationtruelicenseplate(DEFAULT:Registration_True_License_Plate_:\'\'),registrationlicenseplate(DEFAULT:Registration_License_Plate_:\'\'),registrationlicensestate(DEFAULT:Registration_License_State_:\'\'),registrationlicenseplatetypecode(DEFAULT:Registration_License_Plate_Type_Code_:\'\'),registrationlicenseplatetypedescription(DEFAULT:Registration_License_Plate_Type_Description_:\'\'),registrationpreviouslicensestate(DEFAULT:Registration_Previous_License_State_:\'\'),registrationpreviouslicenseplate(DEFAULT:Registration_Previous_License_Plate_:\'\'),titlenumber(DEFAULT:Title_Number_:\'\'),titleearliestissuedate(DEFAULT:Title_Earliest_Issue_Date_:DATE),titlelatestissuedate(DEFAULT:Title_Latest_Issue_Date_:DATE),titlepreviousissuedate(DEFAULT:Title_Previous_Issue_Date_:DATE),titlerecordcount(DEFAULT:Title_Record_Count_:0),titlestatuscode(DEFAULT:Title_Status_Code_:\'\'),titlestatusdescription(DEFAULT:Title_Status_Description_:\'\'),titleodometermileage(DEFAULT:Title_Odometer_Mileage_:0),titleodometerstatuscode(DEFAULT:Title_Odometer_Status_Code_:\'\'),titleodometerstatusdescription(DEFAULT:Title_Odometer_Status_Description_:\'\'),titleodometerdate(DEFAULT:Title_Odometer_Date_:DATE),sequencekey(DEFAULT:Sequence_Key_:\'\'),history(DEFAULT:History_:\'\'),historysource(DEFAULT:History_Source_),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'append_did(OVERRIDE:Subject_:0),Automobile_(DEFAULT:Automobile_:0),reg_first_date(OVERRIDE:Registration_First_Date_:DATE),reg_earliest_effective_date(OVERRIDE:Registration_Earliest_Effective_Date_:DATE),reg_latest_effective_date(OVERRIDE:Registration_Latest_Effective_Date_:DATE),reg_latest_expiration_date(OVERRIDE:Registration_Latest_Expiratione_Date_:DATE),reg_rollup_count(OVERRIDE:Registration_Record_Count_:0),reg_decal_number(OVERRIDE:Registration_Decal_Number_:\'\'),reg_decal_year(OVERRIDE:Registratoin_Decal_Year_:0),reg_status_code(OVERRIDE:Registration_Status_Code_:\'\'),reg_status_desc(OVERRIDE:Registration_Status_Description_:\'\'),reg_true_license_plate(OVERRIDE:Registration_True_License_Plate_:\'\'),reg_license_plate(OVERRIDE:Registration_License_Plate_:\'\'),reg_license_state(OVERRIDE:Registration_License_State_:\'\'),reg_license_plate_type_code(OVERRIDE:Registration_License_Plate_Type_Code_:\'\'),reg_license_plate_type_desc(OVERRIDE:Registration_License_Plate_Type_Description_:\'\'),reg_previous_license_state(OVERRIDE:Registration_Previous_License_State_:\'\'),reg_previous_license_plate(OVERRIDE:Registration_Previous_License_Plate_:\'\'),ttl_number(OVERRIDE:Title_Number_:\'\'),ttl_earliest_issue_date(OVERRIDE:Title_Earliest_Issue_Date_:DATE),ttl_latest_issue_date(OVERRIDE:Title_Latest_Issue_Date_:DATE),ttl_previous_issue_date(OVERRIDE:Title_Previous_Issue_Date_:DATE),ttl_rollup_count(OVERRIDE:Title_Record_Count_:0),ttl_status_code(OVERRIDE:Title_Status_Code_:\'\'),ttl_status_desc(OVERRIDE:Title_Status_Description_:\'\'),ttl_odometer_mileage(OVERRIDE:Title_Odometer_Mileage_:0),ttl_odometer_status_code(OVERRIDE:Title_Odometer_Status_Code_:\'\'),ttl_odometer_status_desc(OVERRIDE:Title_Odometer_Status_Description_:\'\'),ttl_odometer_date(OVERRIDE:Title_Odometer_Date_:DATE),sequence_key(OVERRIDE:Sequence_Key_:\'\'),history(OVERRIDE:History_:\'\'),source_code(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.History_Source_ := __CN(TRUE);
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_VehicleV2__Key_Vehicle_Party_Key,TRANSFORM(RECORDOF(__in.Dataset_VehicleV2__Key_Vehicle_Party_Key),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((STRING20)vehicle_key <> '' AND (UNSIGNED)append_did != 0);
  SHARED __d0_Automobile__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Automobile_;
  END;
  SHARED __d0_Missing_Automobile__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_KELfiltered,'vehicle_key','__in');
  SHARED __d0_Automobile__Mapped := IF(__d0_Missing_Automobile__UIDComponents = 'vehicle_key',PROJECT(__d0_KELfiltered,TRANSFORM(__d0_Automobile__Layout,SELF.Automobile_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_KELfiltered,__d0_Missing_Automobile__UIDComponents),E_Vehicle(__in,__cfg).Lookup,TRIM((STRING)LEFT.vehicle_key) = RIGHT.KeyVal,TRANSFORM(__d0_Automobile__Layout,SELF.Automobile_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_Automobile__Mapped;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  EXPORT InData := __d0;
  EXPORT Registration_Layout := RECORD
    KEL.typ.nkdate Registration_First_Date_;
    KEL.typ.nkdate Registration_Earliest_Effective_Date_;
    KEL.typ.nkdate Registration_Latest_Effective_Date_;
    KEL.typ.nkdate Registration_Latest_Expiratione_Date_;
    KEL.typ.nint Registration_Record_Count_;
    KEL.typ.nstr Registration_Decal_Number_;
    KEL.typ.nint Registratoin_Decal_Year_;
    KEL.typ.nstr Registration_Status_Code_;
    KEL.typ.nstr Registration_Status_Description_;
    KEL.typ.nstr Registration_True_License_Plate_;
    KEL.typ.nstr Registration_License_Plate_;
    KEL.typ.nstr Registration_License_State_;
    KEL.typ.nstr Registration_License_Plate_Type_Code_;
    KEL.typ.nstr Registration_License_Plate_Type_Description_;
    KEL.typ.nstr Registration_Previous_License_State_;
    KEL.typ.nstr Registration_Previous_License_Plate_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Title_Layout := RECORD
    KEL.typ.nstr Title_Number_;
    KEL.typ.nkdate Title_Earliest_Issue_Date_;
    KEL.typ.nkdate Title_Latest_Issue_Date_;
    KEL.typ.nkdate Title_Previous_Issue_Date_;
    KEL.typ.nint Title_Record_Count_;
    KEL.typ.nstr Title_Status_Code_;
    KEL.typ.nstr Title_Status_Description_;
    KEL.typ.nint Title_Odometer_Mileage_;
    KEL.typ.nstr Title_Odometer_Status_Code_;
    KEL.typ.nstr Title_Odometer_Status_Description_;
    KEL.typ.nkdate Title_Odometer_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Counts_Model_Layout := RECORD
    KEL.typ.nstr Sequence_Key_;
    KEL.typ.nstr History_;
    KEL.typ.nbool History_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
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
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.ndataset(Registration_Layout) Registration_;
    KEL.typ.ndataset(Title_Layout) Title_;
    KEL.typ.ndataset(Counts_Model_Layout) Counts_Model_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Subject_,Automobile_,ALL));
  Person_Vehicle_Group := __PostFilter;
  Layout Person_Vehicle__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Registration_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Registration_First_Date_,Registration_Earliest_Effective_Date_,Registration_Latest_Effective_Date_,Registration_Latest_Expiratione_Date_,Registration_Record_Count_,Registration_Decal_Number_,Registratoin_Decal_Year_,Registration_Status_Code_,Registration_Status_Description_,Registration_True_License_Plate_,Registration_License_Plate_,Registration_License_State_,Registration_License_Plate_Type_Code_,Registration_License_Plate_Type_Description_,Registration_Previous_License_State_,Registration_Previous_License_Plate_},Registration_First_Date_,Registration_Earliest_Effective_Date_,Registration_Latest_Effective_Date_,Registration_Latest_Expiratione_Date_,Registration_Record_Count_,Registration_Decal_Number_,Registratoin_Decal_Year_,Registration_Status_Code_,Registration_Status_Description_,Registration_True_License_Plate_,Registration_License_Plate_,Registration_License_State_,Registration_License_Plate_Type_Code_,Registration_License_Plate_Type_Description_,Registration_Previous_License_State_,Registration_Previous_License_Plate_),Registration_Layout)(__NN(Registration_First_Date_) OR __NN(Registration_Earliest_Effective_Date_) OR __NN(Registration_Latest_Effective_Date_) OR __NN(Registration_Latest_Expiratione_Date_) OR __NN(Registration_Record_Count_) OR __NN(Registration_Decal_Number_) OR __NN(Registratoin_Decal_Year_) OR __NN(Registration_Status_Code_) OR __NN(Registration_Status_Description_) OR __NN(Registration_True_License_Plate_) OR __NN(Registration_License_Plate_) OR __NN(Registration_License_State_) OR __NN(Registration_License_Plate_Type_Code_) OR __NN(Registration_License_Plate_Type_Description_) OR __NN(Registration_Previous_License_State_) OR __NN(Registration_Previous_License_Plate_)));
    SELF.Title_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Title_Number_,Title_Earliest_Issue_Date_,Title_Latest_Issue_Date_,Title_Previous_Issue_Date_,Title_Record_Count_,Title_Status_Code_,Title_Status_Description_,Title_Odometer_Mileage_,Title_Odometer_Status_Code_,Title_Odometer_Status_Description_,Title_Odometer_Date_},Title_Number_,Title_Earliest_Issue_Date_,Title_Latest_Issue_Date_,Title_Previous_Issue_Date_,Title_Record_Count_,Title_Status_Code_,Title_Status_Description_,Title_Odometer_Mileage_,Title_Odometer_Status_Code_,Title_Odometer_Status_Description_,Title_Odometer_Date_),Title_Layout)(__NN(Title_Number_) OR __NN(Title_Earliest_Issue_Date_) OR __NN(Title_Latest_Issue_Date_) OR __NN(Title_Previous_Issue_Date_) OR __NN(Title_Record_Count_) OR __NN(Title_Status_Code_) OR __NN(Title_Status_Description_) OR __NN(Title_Odometer_Mileage_) OR __NN(Title_Odometer_Status_Code_) OR __NN(Title_Odometer_Status_Description_) OR __NN(Title_Odometer_Date_)));
    SELF.Counts_Model_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Sequence_Key_,History_,History_Source_},Sequence_Key_,History_,History_Source_),Counts_Model_Layout)(__NN(Sequence_Key_) OR __NN(History_) OR __NN(History_Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Person_Vehicle__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Registration_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Registration_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Registration_First_Date_) OR __NN(Registration_Earliest_Effective_Date_) OR __NN(Registration_Latest_Effective_Date_) OR __NN(Registration_Latest_Expiratione_Date_) OR __NN(Registration_Record_Count_) OR __NN(Registration_Decal_Number_) OR __NN(Registratoin_Decal_Year_) OR __NN(Registration_Status_Code_) OR __NN(Registration_Status_Description_) OR __NN(Registration_True_License_Plate_) OR __NN(Registration_License_Plate_) OR __NN(Registration_License_State_) OR __NN(Registration_License_Plate_Type_Code_) OR __NN(Registration_License_Plate_Type_Description_) OR __NN(Registration_Previous_License_State_) OR __NN(Registration_Previous_License_Plate_)));
    SELF.Title_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Title_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Title_Number_) OR __NN(Title_Earliest_Issue_Date_) OR __NN(Title_Latest_Issue_Date_) OR __NN(Title_Previous_Issue_Date_) OR __NN(Title_Record_Count_) OR __NN(Title_Status_Code_) OR __NN(Title_Status_Description_) OR __NN(Title_Odometer_Mileage_) OR __NN(Title_Odometer_Status_Code_) OR __NN(Title_Odometer_Status_Description_) OR __NN(Title_Odometer_Date_)));
    SELF.Counts_Model_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Counts_Model_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Sequence_Key_) OR __NN(History_) OR __NN(History_Source_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Vehicle_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_Vehicle__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Vehicle_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_Vehicle__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Automobile__Orphan := JOIN(InData(__NN(Automobile_)),E_Vehicle(__in,__cfg).__Result,__EEQP(LEFT.Automobile_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Automobile__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Automobile__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_did',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Automobile',COUNT(__d0(__NL(Automobile_))),COUNT(__d0(__NN(Automobile_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','reg_first_date',COUNT(__d0(__NL(Registration_First_Date_))),COUNT(__d0(__NN(Registration_First_Date_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','reg_earliest_effective_date',COUNT(__d0(__NL(Registration_Earliest_Effective_Date_))),COUNT(__d0(__NN(Registration_Earliest_Effective_Date_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','reg_latest_effective_date',COUNT(__d0(__NL(Registration_Latest_Effective_Date_))),COUNT(__d0(__NN(Registration_Latest_Effective_Date_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','reg_latest_expiration_date',COUNT(__d0(__NL(Registration_Latest_Expiratione_Date_))),COUNT(__d0(__NN(Registration_Latest_Expiratione_Date_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','reg_rollup_count',COUNT(__d0(__NL(Registration_Record_Count_))),COUNT(__d0(__NN(Registration_Record_Count_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','reg_decal_number',COUNT(__d0(__NL(Registration_Decal_Number_))),COUNT(__d0(__NN(Registration_Decal_Number_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','reg_decal_year',COUNT(__d0(__NL(Registratoin_Decal_Year_))),COUNT(__d0(__NN(Registratoin_Decal_Year_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','reg_status_code',COUNT(__d0(__NL(Registration_Status_Code_))),COUNT(__d0(__NN(Registration_Status_Code_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','reg_status_desc',COUNT(__d0(__NL(Registration_Status_Description_))),COUNT(__d0(__NN(Registration_Status_Description_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','reg_true_license_plate',COUNT(__d0(__NL(Registration_True_License_Plate_))),COUNT(__d0(__NN(Registration_True_License_Plate_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','reg_license_plate',COUNT(__d0(__NL(Registration_License_Plate_))),COUNT(__d0(__NN(Registration_License_Plate_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','reg_license_state',COUNT(__d0(__NL(Registration_License_State_))),COUNT(__d0(__NN(Registration_License_State_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','reg_license_plate_type_code',COUNT(__d0(__NL(Registration_License_Plate_Type_Code_))),COUNT(__d0(__NN(Registration_License_Plate_Type_Code_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','reg_license_plate_type_desc',COUNT(__d0(__NL(Registration_License_Plate_Type_Description_))),COUNT(__d0(__NN(Registration_License_Plate_Type_Description_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','reg_previous_license_state',COUNT(__d0(__NL(Registration_Previous_License_State_))),COUNT(__d0(__NN(Registration_Previous_License_State_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','reg_previous_license_plate',COUNT(__d0(__NL(Registration_Previous_License_Plate_))),COUNT(__d0(__NN(Registration_Previous_License_Plate_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ttl_number',COUNT(__d0(__NL(Title_Number_))),COUNT(__d0(__NN(Title_Number_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ttl_earliest_issue_date',COUNT(__d0(__NL(Title_Earliest_Issue_Date_))),COUNT(__d0(__NN(Title_Earliest_Issue_Date_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ttl_latest_issue_date',COUNT(__d0(__NL(Title_Latest_Issue_Date_))),COUNT(__d0(__NN(Title_Latest_Issue_Date_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ttl_previous_issue_date',COUNT(__d0(__NL(Title_Previous_Issue_Date_))),COUNT(__d0(__NN(Title_Previous_Issue_Date_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ttl_rollup_count',COUNT(__d0(__NL(Title_Record_Count_))),COUNT(__d0(__NN(Title_Record_Count_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ttl_status_code',COUNT(__d0(__NL(Title_Status_Code_))),COUNT(__d0(__NN(Title_Status_Code_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ttl_status_desc',COUNT(__d0(__NL(Title_Status_Description_))),COUNT(__d0(__NN(Title_Status_Description_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ttl_odometer_mileage',COUNT(__d0(__NL(Title_Odometer_Mileage_))),COUNT(__d0(__NN(Title_Odometer_Mileage_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ttl_odometer_status_code',COUNT(__d0(__NL(Title_Odometer_Status_Code_))),COUNT(__d0(__NN(Title_Odometer_Status_Code_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ttl_odometer_status_desc',COUNT(__d0(__NL(Title_Odometer_Status_Description_))),COUNT(__d0(__NN(Title_Odometer_Status_Description_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ttl_odometer_date',COUNT(__d0(__NL(Title_Odometer_Date_))),COUNT(__d0(__NN(Title_Odometer_Date_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sequence_key',COUNT(__d0(__NL(Sequence_Key_))),COUNT(__d0(__NN(Sequence_Key_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','history',COUNT(__d0(__NL(History_))),COUNT(__d0(__NN(History_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source_code',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'PersonVehicle','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
