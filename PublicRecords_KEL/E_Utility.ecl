//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Utility(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Utility_I_D_;
    KEL.typ.nkdate Date_Added_To_Exchange_;
    KEL.typ.nkdate Connect_Date_;
    KEL.typ.nstr Utility_Type_;
    KEL.typ.nkdate Record_Date_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Original_First_Name_;
    KEL.typ.nstr Original_Last_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nint Phone_;
    KEL.typ.nint Work_Phone_;
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
  SHARED __Mapping := 'id(DEFAULT:UID),utilityid(DEFAULT:Utility_I_D_:\'\'),dateaddedtoexchange(DEFAULT:Date_Added_To_Exchange_:DATE),connectdate(DEFAULT:Connect_Date_:DATE),utilitytype(DEFAULT:Utility_Type_:\'\'),recorddate(DEFAULT:Record_Date_:DATE),firstname(DEFAULT:First_Name_:\'\'),lastname(DEFAULT:Last_Name_:\'\'),originalfirstname(DEFAULT:Original_First_Name_:\'\'),originallastname(DEFAULT:Original_Last_Name_:\'\'),primaryrange(DEFAULT:Primary_Range_:\'\'),primaryname(DEFAULT:Primary_Name_:\'\'),postdirectional(DEFAULT:Postdirectional_:\'\'),predirectional(DEFAULT:Predirectional_:\'\'),suffix(DEFAULT:Suffix_:\'\'),zip5(DEFAULT:Z_I_P5_:\'\'),secondaryrange(DEFAULT:Secondary_Range_:\'\'),phone(DEFAULT:Phone_:0),workphone(DEFAULT:Work_Phone_:0),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Hybrid_Archive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'id(OVERRIDE:UID|OVERRIDE:Utility_I_D_:\'\'),date_added_to_exchange(OVERRIDE:Date_Added_To_Exchange_:DATE),connect_date(OVERRIDE:Connect_Date_:DATE),util_type(OVERRIDE:Utility_Type_:\'\'),record_date(OVERRIDE:Record_Date_:DATE),fname(OVERRIDE:First_Name_:\'\'),lname(OVERRIDE:Last_Name_:\'\'),orig_fname(OVERRIDE:Original_First_Name_:\'\'),orig_lname(OVERRIDE:Original_Last_Name_:\'\'),prim_range(OVERRIDE:Primary_Range_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),zip(OVERRIDE:Z_I_P5_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),phone(OVERRIDE:Phone_:0),work_phone(OVERRIDE:Work_Phone_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT PublicRecords_KEL_Files_NonFCRA_UtilFile__Key_Address_Vault_Invalid := PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault((KEL.typ.uid)id = 0);
  SHARED __d0_Prefiltered := PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault((KEL.typ.uid)id <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault'));
  SHARED Hybrid_Archive_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'id(OVERRIDE:UID|OVERRIDE:Utility_I_D_:\'\'),date_added_to_exchange(OVERRIDE:Date_Added_To_Exchange_:DATE),connect_date(OVERRIDE:Connect_Date_:DATE),util_type(OVERRIDE:Utility_Type_:\'\'),record_date(OVERRIDE:Record_Date_:DATE),fname(OVERRIDE:First_Name_:\'\'),lname(OVERRIDE:Last_Name_:\'\'),orig_fname(OVERRIDE:Original_First_Name_:\'\'),orig_lname(OVERRIDE:Original_Last_Name_:\'\'),prim_range(OVERRIDE:Primary_Range_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),zip(OVERRIDE:Z_I_P5_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),phone(OVERRIDE:Phone_:0),work_phone(OVERRIDE:Work_Phone_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_1Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT PublicRecords_KEL_Files_NonFCRA_UtilFile__Key_DID_Vault_Invalid := PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault((KEL.typ.uid)id = 0);
  SHARED __d1_Prefiltered := PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault((KEL.typ.uid)id <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault'));
  SHARED Hybrid_Archive_Date_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping2 := 'id(OVERRIDE:UID|OVERRIDE:Utility_I_D_:\'\'),date_added_to_exchange(OVERRIDE:Date_Added_To_Exchange_:DATE),connect_date(OVERRIDE:Connect_Date_:DATE),util_type(OVERRIDE:Utility_Type_:\'\'),record_date(OVERRIDE:Record_Date_:DATE|OVERRIDE:Date_Last_Seen_:EPOCH),fname(OVERRIDE:First_Name_:\'\'),lname(OVERRIDE:Last_Name_:\'\'),orig_fname(OVERRIDE:Original_First_Name_:\'\'),orig_lname(OVERRIDE:Original_Last_Name_:\'\'),prim_range(OVERRIDE:Primary_Range_:\'\'),prim_name(OVERRIDE:Primary_Name_:\'\'),postdir(OVERRIDE:Postdirectional_:\'\'),predir(OVERRIDE:Predirectional_:\'\'),addr_suffix(OVERRIDE:Suffix_:\'\'),zip(OVERRIDE:Z_I_P5_:\'\'),sec_range(OVERRIDE:Secondary_Range_:\'\'),phone(OVERRIDE:Phone_:0),work_phone(OVERRIDE:Work_Phone_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_2Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT PublicRecords_KEL_Files_NonFCRA_UtilFile__Key_LinkIds_Vault_Invalid := PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault((KEL.typ.uid)id = 0);
  SHARED __d2_Prefiltered := PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault((KEL.typ.uid)id <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault'));
  EXPORT InData := __d0 + __d1 + __d2;
  EXPORT Account_Holder_Layout := RECORD
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Original_First_Name_;
    KEL.typ.nstr Original_Last_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nint Phone_;
    KEL.typ.nint Work_Phone_;
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
    KEL.typ.nuid UID;
    KEL.typ.nstr Utility_I_D_;
    KEL.typ.nkdate Date_Added_To_Exchange_;
    KEL.typ.nkdate Connect_Date_;
    KEL.typ.nstr Utility_Type_;
    KEL.typ.nkdate Record_Date_;
    KEL.typ.ndataset(Account_Holder_Layout) Account_Holder_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Utility_Group := __PostFilter;
  Layout Utility__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Utility_I_D_ := KEL.Intake.SingleValue(__recs,Utility_I_D_);
    SELF.Date_Added_To_Exchange_ := KEL.Intake.SingleValue(__recs,Date_Added_To_Exchange_);
    SELF.Connect_Date_ := KEL.Intake.SingleValue(__recs,Connect_Date_);
    SELF.Utility_Type_ := KEL.Intake.SingleValue(__recs,Utility_Type_);
    SELF.Record_Date_ := KEL.Intake.SingleValue(__recs,Record_Date_);
    SELF.Account_Holder_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),First_Name_,Last_Name_,Original_First_Name_,Original_Last_Name_,Primary_Range_,Primary_Name_,Postdirectional_,Predirectional_,Suffix_,Z_I_P5_,Secondary_Range_,Phone_,Work_Phone_},First_Name_,Last_Name_,Original_First_Name_,Original_Last_Name_,Primary_Range_,Primary_Name_,Postdirectional_,Predirectional_,Suffix_,Z_I_P5_,Secondary_Range_,Phone_,Work_Phone_),Account_Holder_Layout)(__NN(First_Name_) OR __NN(Last_Name_) OR __NN(Original_First_Name_) OR __NN(Original_Last_Name_) OR __NN(Primary_Range_) OR __NN(Primary_Name_) OR __NN(Postdirectional_) OR __NN(Predirectional_) OR __NN(Suffix_) OR __NN(Z_I_P5_) OR __NN(Secondary_Range_) OR __NN(Phone_) OR __NN(Work_Phone_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Utility__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Account_Holder_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Account_Holder_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(First_Name_) OR __NN(Last_Name_) OR __NN(Original_First_Name_) OR __NN(Original_Last_Name_) OR __NN(Primary_Range_) OR __NN(Primary_Name_) OR __NN(Postdirectional_) OR __NN(Predirectional_) OR __NN(Suffix_) OR __NN(Z_I_P5_) OR __NN(Secondary_Range_) OR __NN(Phone_) OR __NN(Work_Phone_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Utility_Group,COUNT(ROWS(LEFT))=1),GROUP,Utility__Single_Rollup(LEFT)) + ROLLUP(HAVING(Utility_Group,COUNT(ROWS(LEFT))>1),GROUP,Utility__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Utility_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Utility_I_D_);
  EXPORT Date_Added_To_Exchange__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Date_Added_To_Exchange_);
  EXPORT Connect_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Connect_Date_);
  EXPORT Utility_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Utility_Type_);
  EXPORT Record_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Record_Date_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_Files_NonFCRA_UtilFile__Key_Address_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_UtilFile__Key_DID_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_UtilFile__Key_LinkIds_Vault_Invalid),COUNT(Utility_I_D__SingleValue_Invalid),COUNT(Date_Added_To_Exchange__SingleValue_Invalid),COUNT(Connect_Date__SingleValue_Invalid),COUNT(Utility_Type__SingleValue_Invalid),COUNT(Record_Date__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_Files_NonFCRA_UtilFile__Key_Address_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_UtilFile__Key_DID_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_UtilFile__Key_LinkIds_Vault_Invalid,KEL.typ.int Utility_I_D__SingleValue_Invalid,KEL.typ.int Date_Added_To_Exchange__SingleValue_Invalid,KEL.typ.int Connect_Date__SingleValue_Invalid,KEL.typ.int Utility_Type__SingleValue_Invalid,KEL.typ.int Record_Date__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_UtilFile__Key_Address_Vault_Invalid),COUNT(__d0)},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','id',COUNT(__d0(__NL(Utility_I_D_))),COUNT(__d0(__NN(Utility_I_D_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','date_added_to_exchange',COUNT(__d0(__NL(Date_Added_To_Exchange_))),COUNT(__d0(__NN(Date_Added_To_Exchange_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','connect_date',COUNT(__d0(__NL(Connect_Date_))),COUNT(__d0(__NN(Connect_Date_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','util_type',COUNT(__d0(__NL(Utility_Type_))),COUNT(__d0(__NN(Utility_Type_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','record_date',COUNT(__d0(__NL(Record_Date_))),COUNT(__d0(__NN(Record_Date_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','fname',COUNT(__d0(__NL(First_Name_))),COUNT(__d0(__NN(First_Name_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','lname',COUNT(__d0(__NL(Last_Name_))),COUNT(__d0(__NN(Last_Name_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','orig_fname',COUNT(__d0(__NL(Original_First_Name_))),COUNT(__d0(__NN(Original_First_Name_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','orig_lname',COUNT(__d0(__NL(Original_Last_Name_))),COUNT(__d0(__NN(Original_Last_Name_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','prim_range',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','prim_name',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','postdir',COUNT(__d0(__NL(Postdirectional_))),COUNT(__d0(__NN(Postdirectional_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','predir',COUNT(__d0(__NL(Predirectional_))),COUNT(__d0(__NN(Predirectional_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','addr_suffix',COUNT(__d0(__NL(Suffix_))),COUNT(__d0(__NN(Suffix_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','zip',COUNT(__d0(__NL(Z_I_P5_))),COUNT(__d0(__NN(Z_I_P5_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','sec_range',COUNT(__d0(__NL(Secondary_Range_))),COUNT(__d0(__NN(Secondary_Range_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','phone',COUNT(__d0(__NL(Phone_))),COUNT(__d0(__NN(Phone_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','work_phone',COUNT(__d0(__NL(Work_Phone_))),COUNT(__d0(__NN(Work_Phone_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_Address_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_UtilFile__Key_DID_Vault_Invalid),COUNT(__d1)},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','id',COUNT(__d1(__NL(Utility_I_D_))),COUNT(__d1(__NN(Utility_I_D_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','date_added_to_exchange',COUNT(__d1(__NL(Date_Added_To_Exchange_))),COUNT(__d1(__NN(Date_Added_To_Exchange_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','connect_date',COUNT(__d1(__NL(Connect_Date_))),COUNT(__d1(__NN(Connect_Date_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','util_type',COUNT(__d1(__NL(Utility_Type_))),COUNT(__d1(__NN(Utility_Type_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','record_date',COUNT(__d1(__NL(Record_Date_))),COUNT(__d1(__NN(Record_Date_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','fname',COUNT(__d1(__NL(First_Name_))),COUNT(__d1(__NN(First_Name_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','lname',COUNT(__d1(__NL(Last_Name_))),COUNT(__d1(__NN(Last_Name_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','orig_fname',COUNT(__d1(__NL(Original_First_Name_))),COUNT(__d1(__NN(Original_First_Name_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','orig_lname',COUNT(__d1(__NL(Original_Last_Name_))),COUNT(__d1(__NN(Original_Last_Name_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','prim_range',COUNT(__d1(__NL(Primary_Range_))),COUNT(__d1(__NN(Primary_Range_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','prim_name',COUNT(__d1(__NL(Primary_Name_))),COUNT(__d1(__NN(Primary_Name_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','postdir',COUNT(__d1(__NL(Postdirectional_))),COUNT(__d1(__NN(Postdirectional_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','predir',COUNT(__d1(__NL(Predirectional_))),COUNT(__d1(__NN(Predirectional_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','addr_suffix',COUNT(__d1(__NL(Suffix_))),COUNT(__d1(__NN(Suffix_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','zip',COUNT(__d1(__NL(Z_I_P5_))),COUNT(__d1(__NN(Z_I_P5_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','sec_range',COUNT(__d1(__NL(Secondary_Range_))),COUNT(__d1(__NN(Secondary_Range_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','phone',COUNT(__d1(__NL(Phone_))),COUNT(__d1(__NN(Phone_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','work_phone',COUNT(__d1(__NL(Work_Phone_))),COUNT(__d1(__NN(Work_Phone_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_DID_Vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_UtilFile__Key_LinkIds_Vault_Invalid),COUNT(__d2)},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','id',COUNT(__d2(__NL(Utility_I_D_))),COUNT(__d2(__NN(Utility_I_D_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','date_added_to_exchange',COUNT(__d2(__NL(Date_Added_To_Exchange_))),COUNT(__d2(__NN(Date_Added_To_Exchange_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','connect_date',COUNT(__d2(__NL(Connect_Date_))),COUNT(__d2(__NN(Connect_Date_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','util_type',COUNT(__d2(__NL(Utility_Type_))),COUNT(__d2(__NN(Utility_Type_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','record_date',COUNT(__d2(__NL(Record_Date_))),COUNT(__d2(__NN(Record_Date_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','fname',COUNT(__d2(__NL(First_Name_))),COUNT(__d2(__NN(First_Name_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','lname',COUNT(__d2(__NL(Last_Name_))),COUNT(__d2(__NN(Last_Name_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','orig_fname',COUNT(__d2(__NL(Original_First_Name_))),COUNT(__d2(__NN(Original_First_Name_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','orig_lname',COUNT(__d2(__NL(Original_Last_Name_))),COUNT(__d2(__NN(Original_Last_Name_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','prim_range',COUNT(__d2(__NL(Primary_Range_))),COUNT(__d2(__NN(Primary_Range_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','prim_name',COUNT(__d2(__NL(Primary_Name_))),COUNT(__d2(__NN(Primary_Name_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','postdir',COUNT(__d2(__NL(Postdirectional_))),COUNT(__d2(__NN(Postdirectional_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','predir',COUNT(__d2(__NL(Predirectional_))),COUNT(__d2(__NN(Predirectional_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','addr_suffix',COUNT(__d2(__NL(Suffix_))),COUNT(__d2(__NN(Suffix_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','zip',COUNT(__d2(__NL(Z_I_P5_))),COUNT(__d2(__NN(Z_I_P5_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','sec_range',COUNT(__d2(__NL(Secondary_Range_))),COUNT(__d2(__NN(Secondary_Range_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','phone',COUNT(__d2(__NL(Phone_))),COUNT(__d2(__NN(Phone_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','work_phone',COUNT(__d2(__NL(Work_Phone_))),COUNT(__d2(__NN(Work_Phone_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'Utility','PublicRecords_KEL.Files.NonFCRA.UtilFile__Key_LinkIds_Vault','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
