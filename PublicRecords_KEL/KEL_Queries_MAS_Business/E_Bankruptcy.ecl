//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT E_Bankruptcy(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.nstr Source_Description_;
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nstr Filing_Type_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Corporate_Flag_;
    KEL.typ.nkdate Discharged_Date_;
    KEL.typ.nstr Disposition_;
    KEL.typ.nstr Debtor_Type_;
    KEL.typ.nint Debtor_Sequence_;
    KEL.typ.nint Disposition_Type_;
    KEL.typ.nint Disposition_Reason_;
    KEL.typ.nstr Disposition_Type_Description_;
    KEL.typ.nstr Name_Type_;
    KEL.typ.nstr Screen_Description_;
    KEL.typ.nstr Decoded_Description_;
    KEL.typ.nkdate Date_Filed_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nint Case_I_D_;
    KEL.typ.nint Defendant_I_D_;
    KEL.typ.nkdate Last_Status_Update_;
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
  SHARED __Mapping := 'UID(DEFAULT:UID),tmsid(DEFAULT:T_M_S_I_D_),courtcode(DEFAULT:Court_Code_),casenumber(DEFAULT:Case_Number_),originalcasenumber(DEFAULT:Original_Case_Number_:\'\'),sourcedescription(DEFAULT:Source_Description_:\'\'),originalchapter(DEFAULT:Original_Chapter_:\'\'),filingtype(DEFAULT:Filing_Type_:\'\'),businessflag(DEFAULT:Business_Flag_:\'\'),corporateflag(DEFAULT:Corporate_Flag_:\'\'),dischargeddate(DEFAULT:Discharged_Date_:DATE),disposition(DEFAULT:Disposition_:\'\'),debtortype(DEFAULT:Debtor_Type_:\'\'),debtorsequence(DEFAULT:Debtor_Sequence_:0),dispositiontype(DEFAULT:Disposition_Type_:0),dispositionreason(DEFAULT:Disposition_Reason_:0),dispositiontypedescription(DEFAULT:Disposition_Type_Description_:\'\'),nametype(DEFAULT:Name_Type_:\'\'),screendescription(DEFAULT:Screen_Description_:\'\'),decodeddescription(DEFAULT:Decoded_Description_:\'\'),datefiled(DEFAULT:Date_Filed_:DATE),recordtype(DEFAULT:Record_Type_:\'\'),caseid(DEFAULT:Case_I_D_:0),defendantid(DEFAULT:Defendant_I_D_:0),laststatusupdate(DEFAULT:Last_Status_Update_:DATE),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := __in.Dataset_Bankruptcy_Files__Key_Search(name_type = 'D');
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.TMSID) + '|' + TRIM((STRING)LEFT.Court_Code) + '|' + TRIM((STRING)LEFT.Case_Number) + '|' + TRIM((STRING)LEFT.did)));
  SHARED __d1_KELfiltered := __in.Dataset_Bankruptcy_Files__Linkids_Key_Search(name_type = 'D');
  SHARED __d1_Trim := PROJECT(__d1_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.TMSID) + '|' + TRIM((STRING)LEFT.Court_Code) + '|' + TRIM((STRING)LEFT.Case_Number) + '|' + TRIM((STRING)LEFT.did)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  SHARED __Table := TABLE(__All_Trim,__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  EXPORT Lookup := PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __Mapping0 := 'UID(DEFAULT:UID),tmsid(OVERRIDE:T_M_S_I_D_),court_code(OVERRIDE:Court_Code_),case_number(OVERRIDE:Case_Number_),orig_case_number(OVERRIDE:Original_Case_Number_:\'\'),srcdesc(OVERRIDE:Source_Description_:\'\'),chapter(OVERRIDE:Original_Chapter_:\'\'),filing_type(OVERRIDE:Filing_Type_:\'\'),business_flag(OVERRIDE:Business_Flag_:\'\'),corp_flag(OVERRIDE:Corporate_Flag_:\'\'),discharged(OVERRIDE:Discharged_Date_:DATE),disposition(OVERRIDE:Disposition_:\'\'),debtor_type(OVERRIDE:Debtor_Type_:\'\'),debtor_seq(OVERRIDE:Debtor_Sequence_:0),disptype(OVERRIDE:Disposition_Type_:0),dispreason(OVERRIDE:Disposition_Reason_:0),disptypedesc(OVERRIDE:Disposition_Type_Description_:\'\'),name_type(OVERRIDE:Name_Type_:\'\'),screendesc(OVERRIDE:Screen_Description_:\'\'),dcodedesc(OVERRIDE:Decoded_Description_:\'\'),date_filed(OVERRIDE:Date_Filed_:DATE),record_type(OVERRIDE:Record_Type_:\'\'),caseid(OVERRIDE:Case_I_D_:0),defendantid(OVERRIDE:Defendant_I_D_:0),statusdate(OVERRIDE:Last_Status_Update_:DATE),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('BA');
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Bankruptcy_Files__Key_Search,TRANSFORM(RECORDOF(__in.Dataset_Bankruptcy_Files__Key_Search),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Bankruptcy_Files__Key_Search);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.TMSID) + '|' + TRIM((STRING)LEFT.Court_Code) + '|' + TRIM((STRING)LEFT.Case_Number) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  SHARED __Mapping1 := 'UID(DEFAULT:UID),tmsid(OVERRIDE:T_M_S_I_D_),court_code(OVERRIDE:Court_Code_),case_number(OVERRIDE:Case_Number_),orig_case_number(OVERRIDE:Original_Case_Number_:\'\'),srcdesc(OVERRIDE:Source_Description_:\'\'),chapter(OVERRIDE:Original_Chapter_:\'\'),filing_type(OVERRIDE:Filing_Type_:\'\'),business_flag(OVERRIDE:Business_Flag_:\'\'),corp_flag(OVERRIDE:Corporate_Flag_:\'\'),discharged(OVERRIDE:Discharged_Date_:DATE),disposition(OVERRIDE:Disposition_:\'\'),debtor_type(OVERRIDE:Debtor_Type_:\'\'),debtor_seq(OVERRIDE:Debtor_Sequence_:0),disptype(OVERRIDE:Disposition_Type_:0),dispreason(OVERRIDE:Disposition_Reason_:0),disptypedesc(OVERRIDE:Disposition_Type_Description_:\'\'),name_type(OVERRIDE:Name_Type_:\'\'),screendesc(OVERRIDE:Screen_Description_:\'\'),dcodedesc(OVERRIDE:Decoded_Description_:\'\'),date_filed(OVERRIDE:Date_Filed_:DATE),record_type(OVERRIDE:Record_Type_:\'\'),caseid(OVERRIDE:Case_I_D_:0),defendantid(OVERRIDE:Defendant_I_D_:0),statusdate(OVERRIDE:Last_Status_Update_:DATE),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Bankruptcy_Files__Linkids_Key_Search,TRANSFORM(RECORDOF(__in.Dataset_Bankruptcy_Files__Linkids_Key_Search),SELF:=RIGHT));
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Bankruptcy_Files__Linkids_Key_Search);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(__d1_KELfiltered,Lookup,TRIM((STRING)LEFT.TMSID) + '|' + TRIM((STRING)LEFT.Court_Code) + '|' + TRIM((STRING)LEFT.Case_Number) + '|' + TRIM((STRING)LEFT.did) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Linkids_Key_Search_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1;
  EXPORT Records_Layout := RECORD
    KEL.typ.nstr Source_Description_;
    KEL.typ.nstr Original_Chapter_;
    KEL.typ.nstr Filing_Type_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nstr Corporate_Flag_;
    KEL.typ.nkdate Discharged_Date_;
    KEL.typ.nstr Disposition_;
    KEL.typ.nstr Debtor_Type_;
    KEL.typ.nint Debtor_Sequence_;
    KEL.typ.nint Disposition_Type_;
    KEL.typ.nint Disposition_Reason_;
    KEL.typ.nstr Disposition_Type_Description_;
    KEL.typ.nstr Name_Type_;
    KEL.typ.nstr Screen_Description_;
    KEL.typ.nstr Decoded_Description_;
    KEL.typ.nkdate Date_Filed_;
    KEL.typ.nstr Record_Type_;
    KEL.typ.nkdate Last_Status_Update_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Case_Details_Layout := RECORD
    KEL.typ.nint Case_I_D_;
    KEL.typ.nint Defendant_I_D_;
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
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Court_Code_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Original_Case_Number_;
    KEL.typ.ndataset(Records_Layout) Records_;
    KEL.typ.ndataset(Case_Details_Layout) Case_Details_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Bankruptcy_Group := __PostFilter;
  Layout Bankruptcy__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.T_M_S_I_D_ := KEL.Intake.SingleValue(__recs,T_M_S_I_D_);
    SELF.Court_Code_ := KEL.Intake.SingleValue(__recs,Court_Code_);
    SELF.Case_Number_ := KEL.Intake.SingleValue(__recs,Case_Number_);
    SELF.Original_Case_Number_ := KEL.Intake.SingleValue(__recs,Original_Case_Number_);
    SELF.Records_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_Description_,Original_Chapter_,Filing_Type_,Business_Flag_,Corporate_Flag_,Discharged_Date_,Disposition_,Debtor_Type_,Debtor_Sequence_,Disposition_Type_,Disposition_Reason_,Disposition_Type_Description_,Name_Type_,Screen_Description_,Decoded_Description_,Date_Filed_,Record_Type_,Last_Status_Update_},Source_Description_,Original_Chapter_,Filing_Type_,Business_Flag_,Corporate_Flag_,Discharged_Date_,Disposition_,Debtor_Type_,Debtor_Sequence_,Disposition_Type_,Disposition_Reason_,Disposition_Type_Description_,Name_Type_,Screen_Description_,Decoded_Description_,Date_Filed_,Record_Type_,Last_Status_Update_),Records_Layout)(__NN(Source_Description_) OR __NN(Original_Chapter_) OR __NN(Filing_Type_) OR __NN(Business_Flag_) OR __NN(Corporate_Flag_) OR __NN(Discharged_Date_) OR __NN(Disposition_) OR __NN(Debtor_Type_) OR __NN(Debtor_Sequence_) OR __NN(Disposition_Type_) OR __NN(Disposition_Reason_) OR __NN(Disposition_Type_Description_) OR __NN(Name_Type_) OR __NN(Screen_Description_) OR __NN(Decoded_Description_) OR __NN(Date_Filed_) OR __NN(Record_Type_) OR __NN(Last_Status_Update_)));
    SELF.Case_Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Case_I_D_,Defendant_I_D_},Case_I_D_,Defendant_I_D_),Case_Details_Layout)(__NN(Case_I_D_) OR __NN(Defendant_I_D_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Bankruptcy__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Records_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Records_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_Description_) OR __NN(Original_Chapter_) OR __NN(Filing_Type_) OR __NN(Business_Flag_) OR __NN(Corporate_Flag_) OR __NN(Discharged_Date_) OR __NN(Disposition_) OR __NN(Debtor_Type_) OR __NN(Debtor_Sequence_) OR __NN(Disposition_Type_) OR __NN(Disposition_Reason_) OR __NN(Disposition_Type_Description_) OR __NN(Name_Type_) OR __NN(Screen_Description_) OR __NN(Decoded_Description_) OR __NN(Date_Filed_) OR __NN(Record_Type_) OR __NN(Last_Status_Update_)));
    SELF.Case_Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Case_Details_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Case_I_D_) OR __NN(Defendant_I_D_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Bankruptcy_Group,COUNT(ROWS(LEFT))=1),GROUP,Bankruptcy__Single_Rollup(LEFT)) + ROLLUP(HAVING(Bankruptcy_Group,COUNT(ROWS(LEFT))>1),GROUP,Bankruptcy__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT T_M_S_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,T_M_S_I_D_);
  EXPORT Court_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Court_Code_);
  EXPORT Case_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Case_Number_);
  EXPORT Original_Case_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Original_Case_Number_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Linkids_Key_Search_Invalid),COUNT(T_M_S_I_D__SingleValue_Invalid),COUNT(Court_Code__SingleValue_Invalid),COUNT(Case_Number__SingleValue_Invalid),COUNT(Original_Case_Number__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Linkids_Key_Search_Invalid,KEL.typ.int T_M_S_I_D__SingleValue_Invalid,KEL.typ.int Court_Code__SingleValue_Invalid,KEL.typ.int Case_Number__SingleValue_Invalid,KEL.typ.int Original_Case_Number__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Key_Search_Invalid),COUNT(__d0)},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TMSID',COUNT(__d0(__NL(T_M_S_I_D_))),COUNT(__d0(__NN(T_M_S_I_D_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Court_Code',COUNT(__d0(__NL(Court_Code_))),COUNT(__d0(__NN(Court_Code_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Case_Number',COUNT(__d0(__NL(Case_Number_))),COUNT(__d0(__NN(Case_Number_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_case_number',COUNT(__d0(__NL(Original_Case_Number_))),COUNT(__d0(__NN(Original_Case_Number_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','srcdesc',COUNT(__d0(__NL(Source_Description_))),COUNT(__d0(__NN(Source_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','chapter',COUNT(__d0(__NL(Original_Chapter_))),COUNT(__d0(__NN(Original_Chapter_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','filing_type',COUNT(__d0(__NL(Filing_Type_))),COUNT(__d0(__NN(Filing_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','business_flag',COUNT(__d0(__NL(Business_Flag_))),COUNT(__d0(__NN(Business_Flag_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_flag',COUNT(__d0(__NL(Corporate_Flag_))),COUNT(__d0(__NN(Corporate_Flag_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','discharged',COUNT(__d0(__NL(Discharged_Date_))),COUNT(__d0(__NN(Discharged_Date_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','disposition',COUNT(__d0(__NL(Disposition_))),COUNT(__d0(__NN(Disposition_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','debtor_type',COUNT(__d0(__NL(Debtor_Type_))),COUNT(__d0(__NN(Debtor_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','debtor_seq',COUNT(__d0(__NL(Debtor_Sequence_))),COUNT(__d0(__NN(Debtor_Sequence_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','disptype',COUNT(__d0(__NL(Disposition_Type_))),COUNT(__d0(__NN(Disposition_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dispreason',COUNT(__d0(__NL(Disposition_Reason_))),COUNT(__d0(__NN(Disposition_Reason_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','disptypedesc',COUNT(__d0(__NL(Disposition_Type_Description_))),COUNT(__d0(__NN(Disposition_Type_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_type',COUNT(__d0(__NL(Name_Type_))),COUNT(__d0(__NN(Name_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','screendesc',COUNT(__d0(__NL(Screen_Description_))),COUNT(__d0(__NN(Screen_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dcodedesc',COUNT(__d0(__NL(Decoded_Description_))),COUNT(__d0(__NN(Decoded_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_filed',COUNT(__d0(__NL(Date_Filed_))),COUNT(__d0(__NN(Date_Filed_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_type',COUNT(__d0(__NL(Record_Type_))),COUNT(__d0(__NN(Record_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','caseid',COUNT(__d0(__NL(Case_I_D_))),COUNT(__d0(__NN(Case_I_D_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','defendantid',COUNT(__d0(__NL(Defendant_I_D_))),COUNT(__d0(__NN(Defendant_I_D_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','statusdate',COUNT(__d0(__NL(Last_Status_Update_))),COUNT(__d0(__NN(Last_Status_Update_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Bankruptcy_Files__Linkids_Key_Search_Invalid),COUNT(__d1)},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TMSID',COUNT(__d1(__NL(T_M_S_I_D_))),COUNT(__d1(__NN(T_M_S_I_D_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Court_Code',COUNT(__d1(__NL(Court_Code_))),COUNT(__d1(__NN(Court_Code_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Case_Number',COUNT(__d1(__NL(Case_Number_))),COUNT(__d1(__NN(Case_Number_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_case_number',COUNT(__d1(__NL(Original_Case_Number_))),COUNT(__d1(__NN(Original_Case_Number_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','srcdesc',COUNT(__d1(__NL(Source_Description_))),COUNT(__d1(__NN(Source_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','chapter',COUNT(__d1(__NL(Original_Chapter_))),COUNT(__d1(__NN(Original_Chapter_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','filing_type',COUNT(__d1(__NL(Filing_Type_))),COUNT(__d1(__NN(Filing_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','business_flag',COUNT(__d1(__NL(Business_Flag_))),COUNT(__d1(__NN(Business_Flag_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','corp_flag',COUNT(__d1(__NL(Corporate_Flag_))),COUNT(__d1(__NN(Corporate_Flag_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','discharged',COUNT(__d1(__NL(Discharged_Date_))),COUNT(__d1(__NN(Discharged_Date_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','disposition',COUNT(__d1(__NL(Disposition_))),COUNT(__d1(__NN(Disposition_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','debtor_type',COUNT(__d1(__NL(Debtor_Type_))),COUNT(__d1(__NN(Debtor_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','debtor_seq',COUNT(__d1(__NL(Debtor_Sequence_))),COUNT(__d1(__NN(Debtor_Sequence_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','disptype',COUNT(__d1(__NL(Disposition_Type_))),COUNT(__d1(__NN(Disposition_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dispreason',COUNT(__d1(__NL(Disposition_Reason_))),COUNT(__d1(__NN(Disposition_Reason_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','disptypedesc',COUNT(__d1(__NL(Disposition_Type_Description_))),COUNT(__d1(__NN(Disposition_Type_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','name_type',COUNT(__d1(__NL(Name_Type_))),COUNT(__d1(__NN(Name_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','screendesc',COUNT(__d1(__NL(Screen_Description_))),COUNT(__d1(__NN(Screen_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dcodedesc',COUNT(__d1(__NL(Decoded_Description_))),COUNT(__d1(__NN(Decoded_Description_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_filed',COUNT(__d1(__NL(Date_Filed_))),COUNT(__d1(__NN(Date_Filed_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_type',COUNT(__d1(__NL(Record_Type_))),COUNT(__d1(__NN(Record_Type_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','caseid',COUNT(__d1(__NL(Case_I_D_))),COUNT(__d1(__NN(Case_I_D_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','defendantid',COUNT(__d1(__NL(Defendant_I_D_))),COUNT(__d1(__NN(Defendant_I_D_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','statusdate',COUNT(__d1(__NL(Last_Status_Update_))),COUNT(__d1(__NN(Last_Status_Update_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'Bankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
