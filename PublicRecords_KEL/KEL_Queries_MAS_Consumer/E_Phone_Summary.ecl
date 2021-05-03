//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Consumer;
IMPORT * FROM KEL16.Null;
EXPORT E_Phone_Summary(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    DATA57 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'phone10(DEFAULT:UID|DEFAULT:Phone10_:\'\'),primaryname(DEFAULT:Primary_Name_:\'\'),primaryrange(DEFAULT:Primary_Range_:\'\'),zip(DEFAULT:Zip_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),lastname(DEFAULT:Last_Name_:\'\'),recordcount(DEFAULT:Record_Count_:0),source(DEFAULT:Source_:\'\'),headerhitflag(DEFAULT:Header_Hit_Flag_),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping0 := 'phone10(DEFAULT:UID|OVERRIDE:Phone10_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),prim_range(OVERRIDE:Primary_Range_:\'\'),zip(OVERRIDE:Zip_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),lastname(DEFAULT:Last_Name_:\'\'),record_count(OVERRIDE:Record_Count_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(FALSE);
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_RiskTable__Key_Phone_Addr_Header_Summary,TRANSFORM(RECORDOF(__in.Dataset_RiskTable__Key_Phone_Addr_Header_Summary),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Addr_Header_Summary_Invalid := __d0_Norm((KEL.typ.uid)Phone10 = 0);
  SHARED __d0_Prefiltered := __d0_Norm((KEL.typ.uid)Phone10 <> 0);
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping1 := 'phone10(DEFAULT:UID|OVERRIDE:Phone10_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),prim_range(OVERRIDE:Primary_Range_:\'\'),zip(OVERRIDE:Zip_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),lastname(DEFAULT:Last_Name_:\'\'),record_count(OVERRIDE:Record_Count_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(FALSE);
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_RiskTable__Key_Phone_Addr_Summary,TRANSFORM(RECORDOF(__in.Dataset_RiskTable__Key_Phone_Addr_Summary),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Addr_Summary_Invalid := __d1_Norm((KEL.typ.uid)Phone10 = 0);
  SHARED __d1_Prefiltered := __d1_Norm((KEL.typ.uid)Phone10 <> 0);
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping1_Transform(LEFT)));
  SHARED Date_Last_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping2 := 'phone10(DEFAULT:UID|OVERRIDE:Phone10_:\'\'),primaryname(DEFAULT:Primary_Name_:\'\'),primaryrange(DEFAULT:Primary_Range_:\'\'),zip(DEFAULT:Zip_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),lname(OVERRIDE:Last_Name_:\'\'),record_count(OVERRIDE:Record_Count_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_2Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(FALSE);
    SELF := __r;
  END;
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_RiskTable__Key_Phone_Lname_Summary,TRANSFORM(RECORDOF(__in.Dataset_RiskTable__Key_Phone_Lname_Summary),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Lname_Summary_Invalid := __d2_Norm((KEL.typ.uid)Phone10 = 0);
  SHARED __d2_Prefiltered := __d2_Norm((KEL.typ.uid)Phone10 <> 0);
  SHARED __d2 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping2_Transform(LEFT)));
  SHARED Date_Last_Seen_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping3 := 'phone10(DEFAULT:UID|OVERRIDE:Phone10_:\'\'),primaryname(DEFAULT:Primary_Name_:\'\'),primaryrange(DEFAULT:Primary_Range_:\'\'),zip(DEFAULT:Zip_:\'\'),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),dateofbirthpadded(DEFAULT:Date_Of_Birth_Padded_:\'\'),lname(OVERRIDE:Last_Name_:\'\'),record_count(OVERRIDE:Record_Count_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_3Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping3_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(FALSE);
    SELF := __r;
  END;
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_RiskTable__Key_Phone_Lname_Header_Summary,TRANSFORM(RECORDOF(__in.Dataset_RiskTable__Key_Phone_Lname_Header_Summary),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Lname_Header_Summary_Invalid := __d3_Norm((KEL.typ.uid)Phone10 = 0);
  SHARED __d3_Prefiltered := __d3_Norm((KEL.typ.uid)Phone10 <> 0);
  SHARED __d3 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping3_Transform(LEFT)));
  SHARED Date_Last_Seen_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping4 := 'phone(OVERRIDE:UID|OVERRIDE:Phone10_:\'\'),primaryname(DEFAULT:Primary_Name_:\'\'),primaryrange(DEFAULT:Primary_Range_:\'\'),zip(DEFAULT:Zip_:\'\'),dob(OVERRIDE:Date_Of_Birth_:DATE),dobpadded(OVERRIDE:Date_Of_Birth_Padded_:\'\'),lastname(DEFAULT:Last_Name_:\'\'),record_count(OVERRIDE:Record_Count_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_4Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping4_Transform(InLayout __r) := TRANSFORM
    SELF.Header_Hit_Flag_ := __CN(FALSE);
    SELF := __r;
  END;
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_RiskTable__Key_Phone_Dob_Summary,TRANSFORM(RECORDOF(__in.Dataset_RiskTable__Key_Phone_Dob_Summary),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Dob_Summary_Invalid := __d4_Norm((KEL.typ.uid)phone = 0);
  SHARED __d4_Prefiltered := __d4_Norm((KEL.typ.uid)phone <> 0);
  SHARED __d4 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping4_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4;
  EXPORT Address_Header_Summary_Layout := RECORD
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Address_Summary_Layout := RECORD
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Date_Of_Birth_Summary_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Last_Name_Header_Summary_Layout := RECORD
    KEL.typ.nstr Last_Name_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Last_Name_Summary_Layout := RECORD
    KEL.typ.nstr Last_Name_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(Address_Summary_Layout) Address_Summary_;
    KEL.typ.ndataset(Date_Of_Birth_Summary_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(Last_Name_Summary_Layout) Last_Name_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Phone_Summary_Group := __PostFilter;
  Layout Phone_Summary__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Phone10_ := KEL.Intake.SingleValue(__recs,Phone10_);
    SELF.Address_Header_Summary_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Primary_Name_,Primary_Range_,Zip_,Record_Count_,Source_,Header_Hit_Flag_},Primary_Name_,Primary_Range_,Zip_,Record_Count_,Source_,Header_Hit_Flag_),Address_Header_Summary_Layout)(__NN(Primary_Name_) OR __NN(Primary_Range_) OR __NN(Zip_) OR __NN(Record_Count_) OR __NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.Address_Summary_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Primary_Name_,Primary_Range_,Zip_,Record_Count_,Source_,Header_Hit_Flag_},Primary_Name_,Primary_Range_,Zip_,Record_Count_,Source_,Header_Hit_Flag_),Address_Summary_Layout)(__NN(Primary_Name_) OR __NN(Primary_Range_) OR __NN(Zip_) OR __NN(Record_Count_) OR __NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.Date_Of_Birth_Summary_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Date_Of_Birth_,Date_Of_Birth_Padded_,Record_Count_,Source_,Header_Hit_Flag_},Date_Of_Birth_,Date_Of_Birth_Padded_,Record_Count_,Source_,Header_Hit_Flag_),Date_Of_Birth_Summary_Layout)(__NN(Date_Of_Birth_) OR __NN(Date_Of_Birth_Padded_) OR __NN(Record_Count_) OR __NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.Last_Name_Header_Summary_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Last_Name_,Record_Count_,Source_,Header_Hit_Flag_},Last_Name_,Record_Count_,Source_,Header_Hit_Flag_),Last_Name_Header_Summary_Layout)(__NN(Last_Name_) OR __NN(Record_Count_) OR __NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.Last_Name_Summary_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Last_Name_,Record_Count_,Source_,Header_Hit_Flag_},Last_Name_,Record_Count_,Source_,Header_Hit_Flag_),Last_Name_Summary_Layout)(__NN(Last_Name_) OR __NN(Record_Count_) OR __NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Phone_Summary__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Address_Header_Summary_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Address_Header_Summary_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Primary_Name_) OR __NN(Primary_Range_) OR __NN(Zip_) OR __NN(Record_Count_) OR __NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.Address_Summary_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Address_Summary_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Primary_Name_) OR __NN(Primary_Range_) OR __NN(Zip_) OR __NN(Record_Count_) OR __NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.Date_Of_Birth_Summary_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Date_Of_Birth_Summary_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Date_Of_Birth_) OR __NN(Date_Of_Birth_Padded_) OR __NN(Record_Count_) OR __NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.Last_Name_Header_Summary_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Last_Name_Header_Summary_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Last_Name_) OR __NN(Record_Count_) OR __NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.Last_Name_Summary_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Last_Name_Summary_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Last_Name_) OR __NN(Record_Count_) OR __NN(Source_) OR __NN(Header_Hit_Flag_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Phone_Summary_Group,COUNT(ROWS(LEFT))=1),GROUP,Phone_Summary__Single_Rollup(LEFT)) + ROLLUP(HAVING(Phone_Summary_Group,COUNT(ROWS(LEFT))>1),GROUP,Phone_Summary__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Phone10__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Phone10_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Addr_Header_Summary_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Addr_Summary_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Lname_Summary_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Lname_Header_Summary_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Dob_Summary_Invalid),COUNT(Phone10__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Addr_Header_Summary_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Addr_Summary_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Lname_Summary_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Lname_Header_Summary_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Dob_Summary_Invalid,KEL.typ.int Phone10__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Addr_Header_Summary_Invalid),COUNT(__d0)},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Phone10',COUNT(__d0(__NL(Phone10_))),COUNT(__d0(__NN(Phone10_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Prim_Name',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Prim_Range',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Zip',COUNT(__d0(__NL(Zip_))),COUNT(__d0(__NN(Zip_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirth',COUNT(__d0(__NL(Date_Of_Birth_))),COUNT(__d0(__NN(Date_Of_Birth_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d0(__NL(Date_Of_Birth_Padded_))),COUNT(__d0(__NN(Date_Of_Birth_Padded_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LastName',COUNT(__d0(__NL(Last_Name_))),COUNT(__d0(__NN(Last_Name_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_count',COUNT(__d0(__NL(Record_Count_))),COUNT(__d0(__NN(Record_Count_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Addr_Summary_Invalid),COUNT(__d1)},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Phone10',COUNT(__d1(__NL(Phone10_))),COUNT(__d1(__NN(Phone10_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Prim_Name',COUNT(__d1(__NL(Primary_Name_))),COUNT(__d1(__NN(Primary_Name_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Prim_Range',COUNT(__d1(__NL(Primary_Range_))),COUNT(__d1(__NN(Primary_Range_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Zip',COUNT(__d1(__NL(Zip_))),COUNT(__d1(__NN(Zip_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirth',COUNT(__d1(__NL(Date_Of_Birth_))),COUNT(__d1(__NN(Date_Of_Birth_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d1(__NL(Date_Of_Birth_Padded_))),COUNT(__d1(__NN(Date_Of_Birth_Padded_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LastName',COUNT(__d1(__NL(Last_Name_))),COUNT(__d1(__NN(Last_Name_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_count',COUNT(__d1(__NL(Record_Count_))),COUNT(__d1(__NN(Record_Count_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Lname_Summary_Invalid),COUNT(__d2)},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Phone10',COUNT(__d2(__NL(Phone10_))),COUNT(__d2(__NN(Phone10_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryName',COUNT(__d2(__NL(Primary_Name_))),COUNT(__d2(__NN(Primary_Name_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryRange',COUNT(__d2(__NL(Primary_Range_))),COUNT(__d2(__NN(Primary_Range_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Zip',COUNT(__d2(__NL(Zip_))),COUNT(__d2(__NN(Zip_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirth',COUNT(__d2(__NL(Date_Of_Birth_))),COUNT(__d2(__NN(Date_Of_Birth_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d2(__NL(Date_Of_Birth_Padded_))),COUNT(__d2(__NN(Date_Of_Birth_Padded_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d2(__NL(Last_Name_))),COUNT(__d2(__NN(Last_Name_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_count',COUNT(__d2(__NL(Record_Count_))),COUNT(__d2(__NN(Record_Count_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Lname_Header_Summary_Invalid),COUNT(__d3)},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Phone10',COUNT(__d3(__NL(Phone10_))),COUNT(__d3(__NN(Phone10_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryName',COUNT(__d3(__NL(Primary_Name_))),COUNT(__d3(__NN(Primary_Name_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryRange',COUNT(__d3(__NL(Primary_Range_))),COUNT(__d3(__NN(Primary_Range_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Zip',COUNT(__d3(__NL(Zip_))),COUNT(__d3(__NN(Zip_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirth',COUNT(__d3(__NL(Date_Of_Birth_))),COUNT(__d3(__NN(Date_Of_Birth_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateOfBirthPadded',COUNT(__d3(__NL(Date_Of_Birth_Padded_))),COUNT(__d3(__NN(Date_Of_Birth_Padded_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d3(__NL(Last_Name_))),COUNT(__d3(__NN(Last_Name_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_count',COUNT(__d3(__NL(Record_Count_))),COUNT(__d3(__NN(Record_Count_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_RiskTable__Key_Phone_Dob_Summary_Invalid),COUNT(__d4)},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','phone',COUNT(__d4(__NL(Phone10_))),COUNT(__d4(__NN(Phone10_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryName',COUNT(__d4(__NL(Primary_Name_))),COUNT(__d4(__NN(Primary_Name_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','PrimaryRange',COUNT(__d4(__NL(Primary_Range_))),COUNT(__d4(__NN(Primary_Range_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Zip',COUNT(__d4(__NL(Zip_))),COUNT(__d4(__NN(Zip_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d4(__NL(Date_Of_Birth_))),COUNT(__d4(__NN(Date_Of_Birth_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DOBPadded',COUNT(__d4(__NL(Date_Of_Birth_Padded_))),COUNT(__d4(__NN(Date_Of_Birth_Padded_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LastName',COUNT(__d4(__NL(Last_Name_))),COUNT(__d4(__NN(Last_Name_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_count',COUNT(__d4(__NL(Record_Count_))),COUNT(__d4(__NN(Record_Count_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d4(Archive___Date_=0)),COUNT(__d4(Archive___Date_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d4(Hybrid_Archive_Date_=0)),COUNT(__d4(Hybrid_Archive_Date_!=0))},
    {'PhoneSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d4(Vault_Date_Last_Seen_=0)),COUNT(__d4(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
