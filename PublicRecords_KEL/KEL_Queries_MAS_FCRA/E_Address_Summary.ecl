//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL16.Null;
EXPORT E_Address_Summary(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.nstr Name_First_Name_;
    KEL.typ.nstr Name_Last_Name_;
    KEL.typ.nstr Name_Source_;
    KEL.typ.nint Name_Record_Count_;
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr Dob_Date_Of_Birth_Padded_;
    KEL.typ.nstr Dob_Source_;
    KEL.typ.nint Dob_Record_Count_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    DATA57 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(DEFAULT:UID),primaryname(DEFAULT:Primary_Name_:\'\'),primaryrange(DEFAULT:Primary_Range_:\'\'),zip(DEFAULT:Zip_:\'\'),namefirstname(DEFAULT:Name_First_Name_:\'\'),namelastname(DEFAULT:Name_Last_Name_:\'\'),namesource(DEFAULT:Name_Source_:\'\'),namerecordcount(DEFAULT:Name_Record_Count_:0),dobdateofbirth(DEFAULT:Dob_Date_Of_Birth_:DATE),dobdateofbirthpadded(DEFAULT:Dob_Date_Of_Birth_Padded_:\'\'),dobsource(DEFAULT:Dob_Source_:\'\'),dobrecordcount(DEFAULT:Dob_Record_Count_:0),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in.Dataset_Risk_Indicators__Correlation_Risk__key_addr_name_summary,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.zip)));
  SHARED __d1_Trim := PROJECT(__in.Dataset_Risk_Indicators__Correlation_Risk__key_addr_dob_summary,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.zip)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'') + '|' + TRIM((STRING)'') + '|' + TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping0 := 'UID(DEFAULT:UID),prim_name(OVERRIDE:Primary_Name_:\'\'),prim_range(OVERRIDE:Primary_Range_:\'\'),zip(OVERRIDE:Zip_:\'\'),fname(OVERRIDE:Name_First_Name_:\'\'),lname(OVERRIDE:Name_Last_Name_:\'\'),src(OVERRIDE:Name_Source_:\'\'),record_count(OVERRIDE:Name_Record_Count_:0),dobdateofbirth(DEFAULT:Dob_Date_Of_Birth_:DATE),dobdateofbirthpadded(DEFAULT:Dob_Date_Of_Birth_Padded_:\'\'),dobsource(DEFAULT:Dob_Source_:\'\'),dobrecordcount(DEFAULT:Dob_Record_Count_:0),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Risk_Indicators__Correlation_Risk__key_addr_name_summary,TRANSFORM(RECORDOF(__in.Dataset_Risk_Indicators__Correlation_Risk__key_addr_name_summary),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Risk_Indicators__Correlation_Risk__key_addr_name_summary);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_Norm,Lookup,TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.zip) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Correlation_Risk__key_addr_name_summary_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED __Mapping1 := 'UID(DEFAULT:UID),prim_name(OVERRIDE:Primary_Name_:\'\'),prim_range(OVERRIDE:Primary_Range_:\'\'),zip(OVERRIDE:Zip_:\'\'),namefirstname(DEFAULT:Name_First_Name_:\'\'),namelastname(DEFAULT:Name_Last_Name_:\'\'),namesource(DEFAULT:Name_Source_:\'\'),namerecordcount(DEFAULT:Name_Record_Count_:0),dob(OVERRIDE:Dob_Date_Of_Birth_:DATE),dobpadded(OVERRIDE:Dob_Date_Of_Birth_Padded_:\'\'),src(OVERRIDE:Dob_Source_:\'\'),record_count(OVERRIDE:Dob_Record_Count_:0),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Risk_Indicators__Correlation_Risk__key_addr_dob_summary,TRANSFORM(RECORDOF(__in.Dataset_Risk_Indicators__Correlation_Risk__key_addr_dob_summary),SELF:=RIGHT));
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Risk_Indicators__Correlation_Risk__key_addr_dob_summary);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_Norm,Lookup,TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.zip) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Correlation_Risk__key_addr_dob_summary_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1;
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
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.ndataset(Name_Summary_Layout) Name_Summary_;
    KEL.typ.ndataset(Date_Of_Birth_Summary_Layout) Date_Of_Birth_Summary_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Address_Summary_Group := __PostFilter;
  Layout Address_Summary__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Primary_Name_ := KEL.Intake.SingleValue(__recs,Primary_Name_);
    SELF.Primary_Range_ := KEL.Intake.SingleValue(__recs,Primary_Range_);
    SELF.Zip_ := KEL.Intake.SingleValue(__recs,Zip_);
    SELF.Name_Summary_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Name_First_Name_,Name_Last_Name_,Name_Source_,Name_Record_Count_},Name_First_Name_,Name_Last_Name_,Name_Source_,Name_Record_Count_),Name_Summary_Layout)(__NN(Name_First_Name_) OR __NN(Name_Last_Name_) OR __NN(Name_Source_) OR __NN(Name_Record_Count_)));
    SELF.Date_Of_Birth_Summary_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Dob_Date_Of_Birth_,Dob_Date_Of_Birth_Padded_,Dob_Source_,Dob_Record_Count_},Dob_Date_Of_Birth_,Dob_Date_Of_Birth_Padded_,Dob_Source_,Dob_Record_Count_),Date_Of_Birth_Summary_Layout)(__NN(Dob_Date_Of_Birth_) OR __NN(Dob_Date_Of_Birth_Padded_) OR __NN(Dob_Source_) OR __NN(Dob_Record_Count_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Address_Summary__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Name_Summary_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Name_Summary_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Name_First_Name_) OR __NN(Name_Last_Name_) OR __NN(Name_Source_) OR __NN(Name_Record_Count_)));
    SELF.Date_Of_Birth_Summary_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Date_Of_Birth_Summary_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Dob_Date_Of_Birth_) OR __NN(Dob_Date_Of_Birth_Padded_) OR __NN(Dob_Source_) OR __NN(Dob_Record_Count_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Address_Summary_Group,COUNT(ROWS(LEFT))=1),GROUP,Address_Summary__Single_Rollup(LEFT)) + ROLLUP(HAVING(Address_Summary_Group,COUNT(ROWS(LEFT))>1),GROUP,Address_Summary__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Primary_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Primary_Name_);
  EXPORT Primary_Range__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Primary_Range_);
  EXPORT Zip__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Zip_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Correlation_Risk__key_addr_name_summary_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Correlation_Risk__key_addr_dob_summary_Invalid),COUNT(Primary_Name__SingleValue_Invalid),COUNT(Primary_Range__SingleValue_Invalid),COUNT(Zip__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Correlation_Risk__key_addr_name_summary_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Correlation_Risk__key_addr_dob_summary_Invalid,KEL.typ.int Primary_Name__SingleValue_Invalid,KEL.typ.int Primary_Range__SingleValue_Invalid,KEL.typ.int Zip__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Correlation_Risk__key_addr_name_summary_Invalid),COUNT(__d0)},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d0(__NL(Primary_Name_))),COUNT(__d0(__NN(Primary_Name_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d0(__NL(Primary_Range_))),COUNT(__d0(__NN(Primary_Range_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d0(__NL(Zip_))),COUNT(__d0(__NN(Zip_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','fname',COUNT(__d0(__NL(Name_First_Name_))),COUNT(__d0(__NN(Name_First_Name_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lname',COUNT(__d0(__NL(Name_Last_Name_))),COUNT(__d0(__NN(Name_Last_Name_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Name_Source_))),COUNT(__d0(__NN(Name_Source_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_count',COUNT(__d0(__NL(Name_Record_Count_))),COUNT(__d0(__NN(Name_Record_Count_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DobDateOfBirth',COUNT(__d0(__NL(Dob_Date_Of_Birth_))),COUNT(__d0(__NN(Dob_Date_Of_Birth_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DobDateOfBirthPadded',COUNT(__d0(__NL(Dob_Date_Of_Birth_Padded_))),COUNT(__d0(__NN(Dob_Date_Of_Birth_Padded_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DobSource',COUNT(__d0(__NL(Dob_Source_))),COUNT(__d0(__NN(Dob_Source_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DobRecordCount',COUNT(__d0(__NL(Dob_Record_Count_))),COUNT(__d0(__NN(Dob_Record_Count_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Risk_Indicators__Correlation_Risk__key_addr_dob_summary_Invalid),COUNT(__d1)},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_name',COUNT(__d1(__NL(Primary_Name_))),COUNT(__d1(__NN(Primary_Name_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','prim_range',COUNT(__d1(__NL(Primary_Range_))),COUNT(__d1(__NN(Primary_Range_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d1(__NL(Zip_))),COUNT(__d1(__NN(Zip_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameFirstName',COUNT(__d1(__NL(Name_First_Name_))),COUNT(__d1(__NN(Name_First_Name_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameLastName',COUNT(__d1(__NL(Name_Last_Name_))),COUNT(__d1(__NN(Name_Last_Name_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameSource',COUNT(__d1(__NL(Name_Source_))),COUNT(__d1(__NN(Name_Source_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','NameRecordCount',COUNT(__d1(__NL(Name_Record_Count_))),COUNT(__d1(__NN(Name_Record_Count_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dob',COUNT(__d1(__NL(Dob_Date_Of_Birth_))),COUNT(__d1(__NN(Dob_Date_Of_Birth_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DOBPadded',COUNT(__d1(__NL(Dob_Date_Of_Birth_Padded_))),COUNT(__d1(__NN(Dob_Date_Of_Birth_Padded_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Dob_Source_))),COUNT(__d1(__NN(Dob_Source_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_count',COUNT(__d1(__NL(Dob_Record_Count_))),COUNT(__d1(__NN(Dob_Record_Count_)))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'AddressSummary','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
