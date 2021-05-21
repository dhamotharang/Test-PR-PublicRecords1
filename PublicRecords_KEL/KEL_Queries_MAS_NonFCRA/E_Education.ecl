//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT E_Education(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Sequence_;
    KEL.typ.nstr Key_;
    KEL.typ.nstr Raw_A_I_D_;
    KEL.typ.nstr College_Name_;
    KEL.typ.nstr L_N_College_Name_;
    KEL.typ.nstr College_Code_;
    KEL.typ.nstr College_Type_;
    KEL.typ.nstr File_Type_;
    KEL.typ.nstr School_Size_Code_;
    KEL.typ.nstr Competitive_Code_;
    KEL.typ.nstr Tuition_Code_;
    KEL.typ.nstr Tier_;
    KEL.typ.nstr Tier2_;
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
  SHARED __Mapping := 'UID(DEFAULT:UID),sequence(DEFAULT:Sequence_:\'\'),key(DEFAULT:Key_:\'\'),rawaid(DEFAULT:Raw_A_I_D_:\'\'),collegename(DEFAULT:College_Name_:\'\'),lncollegename(DEFAULT:L_N_College_Name_:\'\'),collegecode(DEFAULT:College_Code_:\'\'),collegetype(DEFAULT:College_Type_:\'\'),filetype(DEFAULT:File_Type_:\'\'),schoolsizecode(DEFAULT:School_Size_Code_:\'\'),competitivecode(DEFAULT:Competitive_Code_:\'\'),tuitioncode(DEFAULT:Tuition_Code_:\'\'),tier(DEFAULT:Tier_:\'\'),tier2(DEFAULT:Tier2_:\'\'),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in.Dataset_American_student_list__key_DID,TRANSFORM(__Trimmed,SELF.KeyVal:='' + '|' + TRIM((STRING)LEFT.Key) + '|' + ''));
  SHARED __d1_Trim := PROJECT(__in.Dataset_AlloyMedia_student_list__Key_DID,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.Sequence_Number) + '|' + TRIM((STRING)LEFT.key_code) + '|' + TRIM((STRING)LEFT.rawaid)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := '' + '|' + TRIM((STRING)'') + '|' + '';
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __Mapping0 := 'UID(DEFAULT:UID),key(OVERRIDE:Key_:\'\'),college_name(OVERRIDE:College_Name_:\'\'),ln_college_name(OVERRIDE:L_N_College_Name_:\'\'),college_code(OVERRIDE:College_Code_:\'\'),college_type(OVERRIDE:College_Type_:\'\'),file_type(OVERRIDE:File_Type_:\'\'),school_size_code(OVERRIDE:School_Size_Code_:\'\'),competitive_code(OVERRIDE:Competitive_Code_:\'\'),tuition_code(OVERRIDE:Tuition_Code_:\'\'),tier(OVERRIDE:Tier_:\'\'),tier2(OVERRIDE:Tier2_:\'\'),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Sequence_ := __CN('');
    SELF.Raw_A_I_D_ := __CN('');
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_American_student_list__key_DID,TRANSFORM(RECORDOF(__in.Dataset_American_student_list__key_DID),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_American_student_list__key_DID);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_Norm,Lookup,'' + '|' + TRIM((STRING)LEFT.Key) + '|' + '' = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_American_student_list__key_DID_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  SHARED __Mapping1 := 'UID(DEFAULT:UID),sequence_number(OVERRIDE:Sequence_:\'\'),key_code(OVERRIDE:Key_:\'\'),rawaid(OVERRIDE:Raw_A_I_D_:\'\'),school_name(OVERRIDE:College_Name_:\'\'),ln_college_name(OVERRIDE:L_N_College_Name_:\'\'),public_private_code(OVERRIDE:College_Code_:\'\'|OVERRIDE:College_Type_:\'\'),file_type(OVERRIDE:File_Type_:\'\'),school_size_code(OVERRIDE:School_Size_Code_:\'\'),competitive_code(OVERRIDE:Competitive_Code_:\'\'),tuition_code(OVERRIDE:Tuition_Code_:\'\'),tier(OVERRIDE:Tier_:\'\'),tier2(OVERRIDE:Tier2_:\'\'),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_vendor_first_reported(OVERRIDE:Date_First_Seen_:EPOCH),date_vendor_last_reported(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_AlloyMedia_student_list__Key_DID,TRANSFORM(RECORDOF(__in.Dataset_AlloyMedia_student_list__Key_DID),SELF:=RIGHT));
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_AlloyMedia_student_list__Key_DID);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_Norm,Lookup,TRIM((STRING)LEFT.Sequence_Number) + '|' + TRIM((STRING)LEFT.key_code) + '|' + TRIM((STRING)LEFT.rawaid) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_AlloyMedia_student_list__Key_DID_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1;
  EXPORT College_Characteristics_Layout := RECORD
    KEL.typ.nstr College_Code_;
    KEL.typ.nstr College_Type_;
    KEL.typ.nstr File_Type_;
    KEL.typ.nstr School_Size_Code_;
    KEL.typ.nstr Competitive_Code_;
    KEL.typ.nstr Tuition_Code_;
    KEL.typ.nstr Tier_;
    KEL.typ.nstr Tier2_;
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
    KEL.typ.nstr College_Name_;
    KEL.typ.nstr L_N_College_Name_;
    KEL.typ.nstr Sequence_;
    KEL.typ.nstr Key_;
    KEL.typ.nstr Raw_A_I_D_;
    KEL.typ.ndataset(College_Characteristics_Layout) College_Characteristics_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Education_Group := __PostFilter;
  Layout Education__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.College_Name_ := KEL.Intake.SingleValue(__recs,College_Name_);
    SELF.L_N_College_Name_ := KEL.Intake.SingleValue(__recs,L_N_College_Name_);
    SELF.Sequence_ := KEL.Intake.SingleValue(__recs,Sequence_);
    SELF.Key_ := KEL.Intake.SingleValue(__recs,Key_);
    SELF.Raw_A_I_D_ := KEL.Intake.SingleValue(__recs,Raw_A_I_D_);
    SELF.College_Characteristics_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),College_Code_,College_Type_,File_Type_,School_Size_Code_,Competitive_Code_,Tuition_Code_,Tier_,Tier2_},College_Code_,College_Type_,File_Type_,School_Size_Code_,Competitive_Code_,Tuition_Code_,Tier_,Tier2_),College_Characteristics_Layout)(__NN(College_Code_) OR __NN(College_Type_) OR __NN(File_Type_) OR __NN(School_Size_Code_) OR __NN(Competitive_Code_) OR __NN(Tuition_Code_) OR __NN(Tier_) OR __NN(Tier2_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Education__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.College_Characteristics_ := __CN(PROJECT(DATASET(__r),TRANSFORM(College_Characteristics_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(College_Code_) OR __NN(College_Type_) OR __NN(File_Type_) OR __NN(School_Size_Code_) OR __NN(Competitive_Code_) OR __NN(Tuition_Code_) OR __NN(Tier_) OR __NN(Tier2_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Education_Group,COUNT(ROWS(LEFT))=1),GROUP,Education__Single_Rollup(LEFT)) + ROLLUP(HAVING(Education_Group,COUNT(ROWS(LEFT))>1),GROUP,Education__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT College_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,College_Name_);
  EXPORT L_N_College_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,L_N_College_Name_);
  EXPORT Sequence__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Sequence_);
  EXPORT Key__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Key_);
  EXPORT Raw_A_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Raw_A_I_D_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_American_student_list__key_DID_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_AlloyMedia_student_list__Key_DID_Invalid),COUNT(College_Name__SingleValue_Invalid),COUNT(L_N_College_Name__SingleValue_Invalid),COUNT(Sequence__SingleValue_Invalid),COUNT(Key__SingleValue_Invalid),COUNT(Raw_A_I_D__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_American_student_list__key_DID_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_AlloyMedia_student_list__Key_DID_Invalid,KEL.typ.int College_Name__SingleValue_Invalid,KEL.typ.int L_N_College_Name__SingleValue_Invalid,KEL.typ.int Sequence__SingleValue_Invalid,KEL.typ.int Key__SingleValue_Invalid,KEL.typ.int Raw_A_I_D__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_American_student_list__key_DID_Invalid),COUNT(__d0)},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Key',COUNT(__d0(__NL(Key_))),COUNT(__d0(__NN(Key_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','college_name',COUNT(__d0(__NL(College_Name_))),COUNT(__d0(__NN(College_Name_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_college_name',COUNT(__d0(__NL(L_N_College_Name_))),COUNT(__d0(__NN(L_N_College_Name_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','college_code',COUNT(__d0(__NL(College_Code_))),COUNT(__d0(__NN(College_Code_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','college_type',COUNT(__d0(__NL(College_Type_))),COUNT(__d0(__NN(College_Type_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','file_type',COUNT(__d0(__NL(File_Type_))),COUNT(__d0(__NN(File_Type_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','school_size_code',COUNT(__d0(__NL(School_Size_Code_))),COUNT(__d0(__NN(School_Size_Code_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','competitive_code',COUNT(__d0(__NL(Competitive_Code_))),COUNT(__d0(__NN(Competitive_Code_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tuition_code',COUNT(__d0(__NL(Tuition_Code_))),COUNT(__d0(__NN(Tuition_Code_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tier',COUNT(__d0(__NL(Tier_))),COUNT(__d0(__NN(Tier_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tier2',COUNT(__d0(__NL(Tier2_))),COUNT(__d0(__NN(Tier2_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_AlloyMedia_student_list__Key_DID_Invalid),COUNT(__d1)},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Sequence_Number',COUNT(__d1(__NL(Sequence_))),COUNT(__d1(__NN(Sequence_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','key_code',COUNT(__d1(__NL(Key_))),COUNT(__d1(__NN(Key_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rawaid',COUNT(__d1(__NL(Raw_A_I_D_))),COUNT(__d1(__NN(Raw_A_I_D_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','school_name',COUNT(__d1(__NL(College_Name_))),COUNT(__d1(__NN(College_Name_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ln_college_name',COUNT(__d1(__NL(L_N_College_Name_))),COUNT(__d1(__NN(L_N_College_Name_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','public_private_code',COUNT(__d1(__NL(College_Code_))),COUNT(__d1(__NN(College_Code_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','public_private_code',COUNT(__d1(__NL(College_Type_))),COUNT(__d1(__NN(College_Type_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','file_type',COUNT(__d1(__NL(File_Type_))),COUNT(__d1(__NN(File_Type_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','school_size_code',COUNT(__d1(__NL(School_Size_Code_))),COUNT(__d1(__NN(School_Size_Code_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','competitive_code',COUNT(__d1(__NL(Competitive_Code_))),COUNT(__d1(__NN(Competitive_Code_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tuition_code',COUNT(__d1(__NL(Tuition_Code_))),COUNT(__d1(__NN(Tuition_Code_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tier',COUNT(__d1(__NL(Tier_))),COUNT(__d1(__NN(Tier_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tier2',COUNT(__d1(__NL(Tier2_))),COUNT(__d1(__NN(Tier2_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
