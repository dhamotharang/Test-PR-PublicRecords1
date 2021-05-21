//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT E_S_S_N_Summary(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.nstr Address_Primary_Name_;
    KEL.typ.nstr Address_Primary_Range_;
    KEL.typ.nstr Address_Zip_;
    KEL.typ.nstr Address_Source_;
    KEL.typ.nint Address_Record_Count_;
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr Dob_Date_Of_Birth_Padded_;
    KEL.typ.nstr Dob_Source_;
    KEL.typ.nint Dob_Record_Count_;
    KEL.typ.nstr Name_First_Name_;
    KEL.typ.nstr Name_Last_Name_;
    KEL.typ.nstr Name_Source_;
    KEL.typ.nint Name_Record_Count_;
    KEL.typ.nint Phone_Number_;
    KEL.typ.nstr Phone_Source_;
    KEL.typ.nint Phone_Record_Count_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    DATA57 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'ssn(DEFAULT:UID|DEFAULT:S_S_N_:\'\'),addressprimaryname(DEFAULT:Address_Primary_Name_:\'\'),addressprimaryrange(DEFAULT:Address_Primary_Range_:\'\'),addresszip(DEFAULT:Address_Zip_:\'\'),addresssource(DEFAULT:Address_Source_:\'\'),addressrecordcount(DEFAULT:Address_Record_Count_:0),dobdateofbirth(DEFAULT:Dob_Date_Of_Birth_:DATE),dobdateofbirthpadded(DEFAULT:Dob_Date_Of_Birth_Padded_:\'\'),dobsource(DEFAULT:Dob_Source_:\'\'),dobrecordcount(DEFAULT:Dob_Record_Count_:0),namefirstname(DEFAULT:Name_First_Name_:\'\'),namelastname(DEFAULT:Name_Last_Name_:\'\'),namesource(DEFAULT:Name_Source_:\'\'),namerecordcount(DEFAULT:Name_Record_Count_:0),phonenumber(DEFAULT:Phone_Number_:0),phonesource(DEFAULT:Phone_Source_:\'\'),phonerecordcount(DEFAULT:Phone_Record_Count_:0),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping0 := 'ssn(OVERRIDE:UID|OVERRIDE:S_S_N_:\'\'),prim_name(OVERRIDE:Address_Primary_Name_:\'\'),prim_range(OVERRIDE:Address_Primary_Range_:\'\'),zip(OVERRIDE:Address_Zip_:\'\'),src(OVERRIDE:Address_Source_:\'\'),record_count(OVERRIDE:Address_Record_Count_:0),dobdateofbirth(DEFAULT:Dob_Date_Of_Birth_:DATE),dobdateofbirthpadded(DEFAULT:Dob_Date_Of_Birth_Padded_:\'\'),dobsource(DEFAULT:Dob_Source_:\'\'),dobrecordcount(DEFAULT:Dob_Record_Count_:0),namefirstname(DEFAULT:Name_First_Name_:\'\'),namelastname(DEFAULT:Name_Last_Name_:\'\'),namesource(DEFAULT:Name_Source_:\'\'),namerecordcount(DEFAULT:Name_Record_Count_:0),phonenumber(DEFAULT:Phone_Number_:0),phonesource(DEFAULT:Phone_Source_:\'\'),phonerecordcount(DEFAULT:Phone_Record_Count_:0),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Risk_Indicators__Key_SSN_Addr_Summary,TRANSFORM(RECORDOF(__in.Dataset_Risk_Indicators__Key_SSN_Addr_Summary),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Key_SSN_Addr_Summary_Invalid := __d0_Norm((KEL.typ.uid)ssn = 0);
  SHARED __d0_Prefiltered := __d0_Norm((KEL.typ.uid)ssn <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping1 := 'ssn(OVERRIDE:UID|OVERRIDE:S_S_N_:\'\'),addressprimaryname(DEFAULT:Address_Primary_Name_:\'\'),addressprimaryrange(DEFAULT:Address_Primary_Range_:\'\'),addresszip(DEFAULT:Address_Zip_:\'\'),addresssource(DEFAULT:Address_Source_:\'\'),addressrecordcount(DEFAULT:Address_Record_Count_:0),dob(OVERRIDE:Dob_Date_Of_Birth_:DATE),dobpadded(OVERRIDE:Dob_Date_Of_Birth_Padded_:\'\'),src(OVERRIDE:Dob_Source_:\'\'),record_count(OVERRIDE:Dob_Record_Count_:0),namefirstname(DEFAULT:Name_First_Name_:\'\'),namelastname(DEFAULT:Name_Last_Name_:\'\'),namesource(DEFAULT:Name_Source_:\'\'),namerecordcount(DEFAULT:Name_Record_Count_:0),phonenumber(DEFAULT:Phone_Number_:0),phonesource(DEFAULT:Phone_Source_:\'\'),phonerecordcount(DEFAULT:Phone_Record_Count_:0),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Risk_Indicators__Key_SSN_dob_Summary,TRANSFORM(RECORDOF(__in.Dataset_Risk_Indicators__Key_SSN_dob_Summary),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Key_SSN_dob_Summary_Invalid := __d1_Norm((KEL.typ.uid)ssn = 0);
  SHARED __d1_Prefiltered := __d1_Norm((KEL.typ.uid)ssn <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_Last_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping2 := 'ssn(OVERRIDE:UID|OVERRIDE:S_S_N_:\'\'),addressprimaryname(DEFAULT:Address_Primary_Name_:\'\'),addressprimaryrange(DEFAULT:Address_Primary_Range_:\'\'),addresszip(DEFAULT:Address_Zip_:\'\'),addresssource(DEFAULT:Address_Source_:\'\'),addressrecordcount(DEFAULT:Address_Record_Count_:0),dobdateofbirth(DEFAULT:Dob_Date_Of_Birth_:DATE),dobdateofbirthpadded(DEFAULT:Dob_Date_Of_Birth_Padded_:\'\'),dobsource(DEFAULT:Dob_Source_:\'\'),dobrecordcount(DEFAULT:Dob_Record_Count_:0),fname(OVERRIDE:Name_First_Name_:\'\'),lname(OVERRIDE:Name_Last_Name_:\'\'),src(OVERRIDE:Name_Source_:\'\'),record_count(OVERRIDE:Name_Record_Count_:0),phonenumber(DEFAULT:Phone_Number_:0),phonesource(DEFAULT:Phone_Source_:\'\'),phonerecordcount(DEFAULT:Phone_Record_Count_:0),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_2Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Risk_Indicators__Key_SSN_Name_Summary,TRANSFORM(RECORDOF(__in.Dataset_Risk_Indicators__Key_SSN_Name_Summary),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Key_SSN_Name_Summary_Invalid := __d2_Norm((KEL.typ.uid)ssn = 0);
  SHARED __d2_Prefiltered := __d2_Norm((KEL.typ.uid)ssn <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_Last_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping3 := 'ssn(OVERRIDE:UID|OVERRIDE:S_S_N_:\'\'),addressprimaryname(DEFAULT:Address_Primary_Name_:\'\'),addressprimaryrange(DEFAULT:Address_Primary_Range_:\'\'),addresszip(DEFAULT:Address_Zip_:\'\'),addresssource(DEFAULT:Address_Source_:\'\'),addressrecordcount(DEFAULT:Address_Record_Count_:0),dobdateofbirth(DEFAULT:Dob_Date_Of_Birth_:DATE),dobdateofbirthpadded(DEFAULT:Dob_Date_Of_Birth_Padded_:\'\'),dobsource(DEFAULT:Dob_Source_:\'\'),dobrecordcount(DEFAULT:Dob_Record_Count_:0),namefirstname(DEFAULT:Name_First_Name_:\'\'),namelastname(DEFAULT:Name_Last_Name_:\'\'),namesource(DEFAULT:Name_Source_:\'\'),namerecordcount(DEFAULT:Name_Record_Count_:0),phone(OVERRIDE:Phone_Number_:0),src(OVERRIDE:Phone_Source_:\'\'),record_count(OVERRIDE:Phone_Record_Count_:0),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_3Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Risk_Indicators__Key_SSN_Phone_Summary,TRANSFORM(RECORDOF(__in.Dataset_Risk_Indicators__Key_SSN_Phone_Summary),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Key_SSN_Phone_Summary_Invalid := __d3_Norm((KEL.typ.uid)ssn = 0);
  SHARED __d3_Prefiltered := __d3_Norm((KEL.typ.uid)ssn <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3;
  EXPORT Address_Summary_Layout := RECORD
    KEL.typ.nstr Address_Primary_Name_;
    KEL.typ.nstr Address_Primary_Range_;
    KEL.typ.nstr Address_Zip_;
    KEL.typ.nstr Address_Source_;
    KEL.typ.nint Address_Record_Count_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Date_Of_Birth_Summary_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr Dob_Date_Of_Birth_Padded_;
    KEL.typ.nstr Dob_Source_;
    KEL.typ.nint Dob_Record_Count_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Name_Summary_Layout := RECORD
    KEL.typ.nstr Name_First_Name_;
    KEL.typ.nstr Name_Last_Name_;
    KEL.typ.nstr Name_Source_;
    KEL.typ.nint Name_Record_Count_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Phone_Summary_Layout := RECORD
    KEL.typ.nint Phone_Number_;
    KEL.typ.nstr Phone_Source_;
    KEL.typ.nint Phone_Record_Count_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(Address_Summary_Layout) Address_Summary_;
    KEL.typ.ndataset(Date_Of_Birth_Summary_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(Name_Summary_Layout) Name_Summary_;
    KEL.typ.ndataset(Phone_Summary_Layout) Phone_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  S_S_N_Summary_Group := __PostFilter;
  Layout S_S_N_Summary__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.S_S_N_ := KEL.Intake.SingleValue(__recs,S_S_N_);
    SELF.Address_Summary_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Address_Primary_Name_,Address_Primary_Range_,Address_Zip_,Address_Source_,Address_Record_Count_},Address_Primary_Name_,Address_Primary_Range_,Address_Zip_,Address_Source_,Address_Record_Count_),Address_Summary_Layout)(__NN(Address_Primary_Name_) OR __NN(Address_Primary_Range_) OR __NN(Address_Zip_) OR __NN(Address_Source_) OR __NN(Address_Record_Count_)));
    SELF.Date_Of_Birth_Summary_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Dob_Date_Of_Birth_,Dob_Date_Of_Birth_Padded_,Dob_Source_,Dob_Record_Count_},Dob_Date_Of_Birth_,Dob_Date_Of_Birth_Padded_,Dob_Source_,Dob_Record_Count_),Date_Of_Birth_Summary_Layout)(__NN(Dob_Date_Of_Birth_) OR __NN(Dob_Date_Of_Birth_Padded_) OR __NN(Dob_Source_) OR __NN(Dob_Record_Count_)));
    SELF.Name_Summary_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Name_First_Name_,Name_Last_Name_,Name_Source_,Name_Record_Count_},Name_First_Name_,Name_Last_Name_,Name_Source_,Name_Record_Count_),Name_Summary_Layout)(__NN(Name_First_Name_) OR __NN(Name_Last_Name_) OR __NN(Name_Source_) OR __NN(Name_Record_Count_)));
    SELF.Phone_Summary_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Phone_Number_,Phone_Source_,Phone_Record_Count_},Phone_Number_,Phone_Source_,Phone_Record_Count_),Phone_Summary_Layout)(__NN(Phone_Number_) OR __NN(Phone_Source_) OR __NN(Phone_Record_Count_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout S_S_N_Summary__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Address_Summary_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Address_Summary_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Address_Primary_Name_) OR __NN(Address_Primary_Range_) OR __NN(Address_Zip_) OR __NN(Address_Source_) OR __NN(Address_Record_Count_)));
    SELF.Date_Of_Birth_Summary_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Date_Of_Birth_Summary_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Dob_Date_Of_Birth_) OR __NN(Dob_Date_Of_Birth_Padded_) OR __NN(Dob_Source_) OR __NN(Dob_Record_Count_)));
    SELF.Name_Summary_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Name_Summary_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Name_First_Name_) OR __NN(Name_Last_Name_) OR __NN(Name_Source_) OR __NN(Name_Record_Count_)));
    SELF.Phone_Summary_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Phone_Summary_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Phone_Number_) OR __NN(Phone_Source_) OR __NN(Phone_Record_Count_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(S_S_N_Summary_Group,COUNT(ROWS(LEFT))=1),GROUP,S_S_N_Summary__Single_Rollup(LEFT)) + ROLLUP(HAVING(S_S_N_Summary_Group,COUNT(ROWS(LEFT))>1),GROUP,S_S_N_Summary__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT S_S_N__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,S_S_N_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Key_SSN_Addr_Summary_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Key_SSN_dob_Summary_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Key_SSN_Name_Summary_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Key_SSN_Phone_Summary_Invalid),COUNT(S_S_N__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Key_SSN_Addr_Summary_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Key_SSN_dob_Summary_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Key_SSN_Name_Summary_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Key_SSN_Phone_Summary_Invalid,KEL.typ.int S_S_N__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Key_SSN_Addr_Summary_Invalid),COUNT(__d0)},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d0(__NL(S_S_N_))),COUNT(__d0(__NN(S_S_N_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d0(__NL(Address_Primary_Name_))),COUNT(__d0(__NN(Address_Primary_Name_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d0(__NL(Address_Primary_Range_))),COUNT(__d0(__NN(Address_Primary_Range_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d0(__NL(Address_Zip_))),COUNT(__d0(__NN(Address_Zip_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Address_Source_))),COUNT(__d0(__NN(Address_Source_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_count',COUNT(__d0(__NL(Address_Record_Count_))),COUNT(__d0(__NN(Address_Record_Count_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DobDateOfBirth',COUNT(__d0(__NL(Dob_Date_Of_Birth_))),COUNT(__d0(__NN(Dob_Date_Of_Birth_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DobDateOfBirthPadded',COUNT(__d0(__NL(Dob_Date_Of_Birth_Padded_))),COUNT(__d0(__NN(Dob_Date_Of_Birth_Padded_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DobSource',COUNT(__d0(__NL(Dob_Source_))),COUNT(__d0(__NN(Dob_Source_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DobRecordCount',COUNT(__d0(__NL(Dob_Record_Count_))),COUNT(__d0(__NN(Dob_Record_Count_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameFirstName',COUNT(__d0(__NL(Name_First_Name_))),COUNT(__d0(__NN(Name_First_Name_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameLastName',COUNT(__d0(__NL(Name_Last_Name_))),COUNT(__d0(__NN(Name_Last_Name_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameSource',COUNT(__d0(__NL(Name_Source_))),COUNT(__d0(__NN(Name_Source_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameRecordCount',COUNT(__d0(__NL(Name_Record_Count_))),COUNT(__d0(__NN(Name_Record_Count_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumber',COUNT(__d0(__NL(Phone_Number_))),COUNT(__d0(__NN(Phone_Number_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneSource',COUNT(__d0(__NL(Phone_Source_))),COUNT(__d0(__NN(Phone_Source_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneRecordCount',COUNT(__d0(__NL(Phone_Record_Count_))),COUNT(__d0(__NN(Phone_Record_Count_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Key_SSN_dob_Summary_Invalid),COUNT(__d1)},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d1(__NL(S_S_N_))),COUNT(__d1(__NN(S_S_N_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressPrimaryName',COUNT(__d1(__NL(Address_Primary_Name_))),COUNT(__d1(__NN(Address_Primary_Name_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressPrimaryRange',COUNT(__d1(__NL(Address_Primary_Range_))),COUNT(__d1(__NN(Address_Primary_Range_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressZip',COUNT(__d1(__NL(Address_Zip_))),COUNT(__d1(__NN(Address_Zip_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressSource',COUNT(__d1(__NL(Address_Source_))),COUNT(__d1(__NN(Address_Source_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressRecordCount',COUNT(__d1(__NL(Address_Record_Count_))),COUNT(__d1(__NN(Address_Record_Count_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d1(__NL(Dob_Date_Of_Birth_))),COUNT(__d1(__NN(Dob_Date_Of_Birth_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DOBPadded',COUNT(__d1(__NL(Dob_Date_Of_Birth_Padded_))),COUNT(__d1(__NN(Dob_Date_Of_Birth_Padded_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Dob_Source_))),COUNT(__d1(__NN(Dob_Source_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_count',COUNT(__d1(__NL(Dob_Record_Count_))),COUNT(__d1(__NN(Dob_Record_Count_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameFirstName',COUNT(__d1(__NL(Name_First_Name_))),COUNT(__d1(__NN(Name_First_Name_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameLastName',COUNT(__d1(__NL(Name_Last_Name_))),COUNT(__d1(__NN(Name_Last_Name_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameSource',COUNT(__d1(__NL(Name_Source_))),COUNT(__d1(__NN(Name_Source_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameRecordCount',COUNT(__d1(__NL(Name_Record_Count_))),COUNT(__d1(__NN(Name_Record_Count_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumber',COUNT(__d1(__NL(Phone_Number_))),COUNT(__d1(__NN(Phone_Number_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneSource',COUNT(__d1(__NL(Phone_Source_))),COUNT(__d1(__NN(Phone_Source_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneRecordCount',COUNT(__d1(__NL(Phone_Record_Count_))),COUNT(__d1(__NN(Phone_Record_Count_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Key_SSN_Name_Summary_Invalid),COUNT(__d2)},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d2(__NL(S_S_N_))),COUNT(__d2(__NN(S_S_N_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressPrimaryName',COUNT(__d2(__NL(Address_Primary_Name_))),COUNT(__d2(__NN(Address_Primary_Name_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressPrimaryRange',COUNT(__d2(__NL(Address_Primary_Range_))),COUNT(__d2(__NN(Address_Primary_Range_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressZip',COUNT(__d2(__NL(Address_Zip_))),COUNT(__d2(__NN(Address_Zip_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressSource',COUNT(__d2(__NL(Address_Source_))),COUNT(__d2(__NN(Address_Source_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressRecordCount',COUNT(__d2(__NL(Address_Record_Count_))),COUNT(__d2(__NN(Address_Record_Count_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DobDateOfBirth',COUNT(__d2(__NL(Dob_Date_Of_Birth_))),COUNT(__d2(__NN(Dob_Date_Of_Birth_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DobDateOfBirthPadded',COUNT(__d2(__NL(Dob_Date_Of_Birth_Padded_))),COUNT(__d2(__NN(Dob_Date_Of_Birth_Padded_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DobSource',COUNT(__d2(__NL(Dob_Source_))),COUNT(__d2(__NN(Dob_Source_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DobRecordCount',COUNT(__d2(__NL(Dob_Record_Count_))),COUNT(__d2(__NN(Dob_Record_Count_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d2(__NL(Name_First_Name_))),COUNT(__d2(__NN(Name_First_Name_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d2(__NL(Name_Last_Name_))),COUNT(__d2(__NN(Name_Last_Name_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Name_Source_))),COUNT(__d2(__NN(Name_Source_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_count',COUNT(__d2(__NL(Name_Record_Count_))),COUNT(__d2(__NN(Name_Record_Count_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneNumber',COUNT(__d2(__NL(Phone_Number_))),COUNT(__d2(__NN(Phone_Number_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneSource',COUNT(__d2(__NL(Phone_Source_))),COUNT(__d2(__NN(Phone_Source_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PhoneRecordCount',COUNT(__d2(__NL(Phone_Record_Count_))),COUNT(__d2(__NN(Phone_Record_Count_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Key_SSN_Phone_Summary_Invalid),COUNT(__d3)},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d3(__NL(S_S_N_))),COUNT(__d3(__NN(S_S_N_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressPrimaryName',COUNT(__d3(__NL(Address_Primary_Name_))),COUNT(__d3(__NN(Address_Primary_Name_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressPrimaryRange',COUNT(__d3(__NL(Address_Primary_Range_))),COUNT(__d3(__NN(Address_Primary_Range_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressZip',COUNT(__d3(__NL(Address_Zip_))),COUNT(__d3(__NN(Address_Zip_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressSource',COUNT(__d3(__NL(Address_Source_))),COUNT(__d3(__NN(Address_Source_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AddressRecordCount',COUNT(__d3(__NL(Address_Record_Count_))),COUNT(__d3(__NN(Address_Record_Count_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DobDateOfBirth',COUNT(__d3(__NL(Dob_Date_Of_Birth_))),COUNT(__d3(__NN(Dob_Date_Of_Birth_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DobDateOfBirthPadded',COUNT(__d3(__NL(Dob_Date_Of_Birth_Padded_))),COUNT(__d3(__NN(Dob_Date_Of_Birth_Padded_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DobSource',COUNT(__d3(__NL(Dob_Source_))),COUNT(__d3(__NN(Dob_Source_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DobRecordCount',COUNT(__d3(__NL(Dob_Record_Count_))),COUNT(__d3(__NN(Dob_Record_Count_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameFirstName',COUNT(__d3(__NL(Name_First_Name_))),COUNT(__d3(__NN(Name_First_Name_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameLastName',COUNT(__d3(__NL(Name_Last_Name_))),COUNT(__d3(__NN(Name_Last_Name_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameSource',COUNT(__d3(__NL(Name_Source_))),COUNT(__d3(__NN(Name_Source_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameRecordCount',COUNT(__d3(__NL(Name_Record_Count_))),COUNT(__d3(__NN(Name_Record_Count_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d3(__NL(Phone_Number_))),COUNT(__d3(__NN(Phone_Number_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Phone_Source_))),COUNT(__d3(__NN(Phone_Source_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_count',COUNT(__d3(__NL(Phone_Record_Count_))),COUNT(__d3(__NN(Phone_Record_Count_)))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'SSNSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
