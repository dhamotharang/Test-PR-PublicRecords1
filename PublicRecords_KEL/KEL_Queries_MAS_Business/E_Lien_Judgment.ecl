//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT E_Lien_Judgment(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.nstr Filing_Number_;
    KEL.typ.nstr Original_Filing_Number_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.nstr Landlord_Tenant_Dispute_Flag_;
    KEL.typ.nstr Certificate_Number_;
    KEL.typ.nstr I_R_S_Serial_Number_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Case_Link_I_D_;
    KEL.typ.nstr Filing_Book_;
    KEL.typ.nstr Filing_Page_;
    KEL.typ.nstr Filing_State_;
    KEL.typ.nstr Filing_Status_Description_;
    KEL.typ.nstr Agency_I_D_;
    KEL.typ.nstr Agency_;
    KEL.typ.nstr Agency_County_;
    KEL.typ.nstr Agency_State_;
    KEL.typ.nbool Sent_To_Credit_Bureau_Flag_;
    KEL.typ.nstr Satisfaction_Type_;
    KEL.typ.nkdate Original_Filing_Date_;
    KEL.typ.nkdate Collection_Date_;
    KEL.typ.nkdate Effective_Date_;
    KEL.typ.nkdate Expiration_Date_;
    KEL.typ.nint Lapse_Date_;
    KEL.typ.nkdate Process_Date_;
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
  SHARED __Mapping := 'UID(DEFAULT:UID),tmsid(DEFAULT:T_M_S_I_D_),rmsid(DEFAULT:R_M_S_I_D_),filingnumber(DEFAULT:Filing_Number_:\'\'),originalfilingnumber(DEFAULT:Original_Filing_Number_:\'\'),filingtypedescription(DEFAULT:Filing_Type_Description_:\'\'),amount(DEFAULT:Amount_:\'\'),landlordtenantdisputeflag(DEFAULT:Landlord_Tenant_Dispute_Flag_:\'\'),certificatenumber(DEFAULT:Certificate_Number_:\'\'),irsserialnumber(DEFAULT:I_R_S_Serial_Number_:\'\'),casenumber(DEFAULT:Case_Number_:\'\'),caselinkid(DEFAULT:Case_Link_I_D_:\'\'),filingbook(DEFAULT:Filing_Book_:\'\'),filingpage(DEFAULT:Filing_Page_:\'\'),filingstate(DEFAULT:Filing_State_:\'\'),filingstatusdescription(DEFAULT:Filing_Status_Description_:\'\'),agencyid(DEFAULT:Agency_I_D_:\'\'),agency(DEFAULT:Agency_:\'\'),agencycounty(DEFAULT:Agency_County_:\'\'),agencystate(DEFAULT:Agency_State_:\'\'),senttocreditbureauflag(DEFAULT:Sent_To_Credit_Bureau_Flag_),satisfactiontype(DEFAULT:Satisfaction_Type_:\'\'),originalfilingdate(DEFAULT:Original_Filing_Date_:DATE),collectiondate(DEFAULT:Collection_Date_:DATE),effectivedate(DEFAULT:Effective_Date_:DATE),expirationdate(DEFAULT:Expiration_Date_:DATE),lapsedate(DEFAULT:Lapse_Date_:0),processdate(DEFAULT:Process_Date_:DATE),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in.Dataset_LiensV2_key_liens_main_ID_Records,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.tmsid) + '|' + TRIM((STRING)LEFT.rmsid)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  SHARED __Table := TABLE(__All_Trim,__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  EXPORT Lookup := PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __Mapping0 := 'UID(DEFAULT:UID),tmsid(OVERRIDE:T_M_S_I_D_),rmsid(OVERRIDE:R_M_S_I_D_),filing_number(OVERRIDE:Filing_Number_:\'\'),orig_filing_number(OVERRIDE:Original_Filing_Number_:\'\'),filing_type_desc(OVERRIDE:Filing_Type_Description_:\'\'),amount(OVERRIDE:Amount_:\'\'),eviction(OVERRIDE:Landlord_Tenant_Dispute_Flag_:\'\'),certificate_number(OVERRIDE:Certificate_Number_:\'\'),irs_serial_number(OVERRIDE:I_R_S_Serial_Number_:\'\'),case_number(OVERRIDE:Case_Number_:\'\'),caselinkid(OVERRIDE:Case_Link_I_D_:\'\'),filing_book(OVERRIDE:Filing_Book_:\'\'),filing_page(OVERRIDE:Filing_Page_:\'\'),filing_state(OVERRIDE:Filing_State_:\'\'),filingstatusdescription(OVERRIDE:Filing_Status_Description_:\'\'),agencyid(OVERRIDE:Agency_I_D_:\'\'),agency(OVERRIDE:Agency_:\'\'),agency_county(OVERRIDE:Agency_County_:\'\'),agency_state(OVERRIDE:Agency_State_:\'\'),bcbflag(OVERRIDE:Sent_To_Credit_Bureau_Flag_),satisifaction_type(OVERRIDE:Satisfaction_Type_:\'\'),orig_filing_date(OVERRIDE:Original_Filing_Date_:DATE),collection_date(OVERRIDE:Collection_Date_:DATE),effective_date(OVERRIDE:Effective_Date_:DATE),expiration_date(OVERRIDE:Expiration_Date_:DATE),lapse_date(OVERRIDE:Lapse_Date_:0),process_date(OVERRIDE:Process_Date_:DATE),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_LiensV2_key_liens_main_ID_Records,TRANSFORM(RECORDOF(__in.Dataset_LiensV2_key_liens_main_ID_Records),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_LiensV2_key_liens_main_ID_Records);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_Norm,Lookup,TRIM((STRING)LEFT.tmsid) + '|' + TRIM((STRING)LEFT.rmsid) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_LiensV2_key_liens_main_ID_Records_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0;
  EXPORT Filing_Layout := RECORD
    KEL.typ.nstr Filing_Number_;
    KEL.typ.nstr Original_Filing_Number_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nstr Filing_Status_Description_;
    KEL.typ.nstr Satisfaction_Type_;
    KEL.typ.nint Amount_;
    KEL.typ.nstr Filing_State_;
    KEL.typ.nstr Landlord_Tenant_Dispute_Flag_;
    KEL.typ.nkdate Original_Filing_Date_;
    KEL.typ.nkdate Effective_Date_;
    KEL.typ.nkdate Collection_Date_;
    KEL.typ.nkdate Expiration_Date_;
    KEL.typ.nint Lapse_Date_;
    KEL.typ.nkdate Process_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Book_Filing_Details_Layout := RECORD
    KEL.typ.nstr Filing_Number_;
    KEL.typ.nstr Filing_Book_;
    KEL.typ.nstr Filing_Page_;
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
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.ndataset(Filing_Layout) Filing_;
    KEL.typ.ndataset(Book_Filing_Details_Layout) Book_Filing_Details_;
    KEL.typ.nstr Agency_I_D_;
    KEL.typ.nstr Agency_;
    KEL.typ.nstr Agency_County_;
    KEL.typ.nstr Agency_State_;
    KEL.typ.nbool Sent_To_Credit_Bureau_Flag_;
    KEL.typ.nstr I_R_S_Serial_Number_;
    KEL.typ.nstr Case_Number_;
    KEL.typ.nstr Case_Link_I_D_;
    KEL.typ.nstr Certificate_Number_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Lien_Judgment_Group := __PostFilter;
  Layout Lien_Judgment__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.T_M_S_I_D_ := KEL.Intake.SingleValue(__recs,T_M_S_I_D_);
    SELF.R_M_S_I_D_ := KEL.Intake.SingleValue(__recs,R_M_S_I_D_);
    SELF.Filing_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Filing_Number_,Original_Filing_Number_,Filing_Type_Description_,Filing_Status_Description_,Satisfaction_Type_,Amount_,Filing_State_,Landlord_Tenant_Dispute_Flag_,Original_Filing_Date_,Effective_Date_,Collection_Date_,Expiration_Date_,Lapse_Date_,Process_Date_},Filing_Number_,Original_Filing_Number_,Filing_Type_Description_,Filing_Status_Description_,Satisfaction_Type_,Amount_,Filing_State_,Landlord_Tenant_Dispute_Flag_,Original_Filing_Date_,Effective_Date_,Collection_Date_,Expiration_Date_,Lapse_Date_,Process_Date_),Filing_Layout)(__NN(Filing_Number_) OR __NN(Original_Filing_Number_) OR __NN(Filing_Type_Description_) OR __NN(Filing_Status_Description_) OR __NN(Satisfaction_Type_) OR __NN(Amount_) OR __NN(Filing_State_) OR __NN(Landlord_Tenant_Dispute_Flag_) OR __NN(Original_Filing_Date_) OR __NN(Effective_Date_) OR __NN(Collection_Date_) OR __NN(Expiration_Date_) OR __NN(Lapse_Date_) OR __NN(Process_Date_)));
    SELF.Book_Filing_Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Filing_Number_,Filing_Book_,Filing_Page_},Filing_Number_,Filing_Book_,Filing_Page_),Book_Filing_Details_Layout)(__NN(Filing_Number_) OR __NN(Filing_Book_) OR __NN(Filing_Page_)));
    SELF.Agency_I_D_ := KEL.Intake.SingleValue(__recs,Agency_I_D_);
    SELF.Agency_ := KEL.Intake.SingleValue(__recs,Agency_);
    SELF.Agency_County_ := KEL.Intake.SingleValue(__recs,Agency_County_);
    SELF.Agency_State_ := KEL.Intake.SingleValue(__recs,Agency_State_);
    SELF.Sent_To_Credit_Bureau_Flag_ := KEL.Intake.SingleValue(__recs,Sent_To_Credit_Bureau_Flag_);
    SELF.I_R_S_Serial_Number_ := KEL.Intake.SingleValue(__recs,I_R_S_Serial_Number_);
    SELF.Case_Number_ := KEL.Intake.SingleValue(__recs,Case_Number_);
    SELF.Case_Link_I_D_ := KEL.Intake.SingleValue(__recs,Case_Link_I_D_);
    SELF.Certificate_Number_ := KEL.Intake.SingleValue(__recs,Certificate_Number_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Lien_Judgment__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Filing_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Filing_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Filing_Number_) OR __NN(Original_Filing_Number_) OR __NN(Filing_Type_Description_) OR __NN(Filing_Status_Description_) OR __NN(Satisfaction_Type_) OR __NN(Amount_) OR __NN(Filing_State_) OR __NN(Landlord_Tenant_Dispute_Flag_) OR __NN(Original_Filing_Date_) OR __NN(Effective_Date_) OR __NN(Collection_Date_) OR __NN(Expiration_Date_) OR __NN(Lapse_Date_) OR __NN(Process_Date_)));
    SELF.Book_Filing_Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Book_Filing_Details_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Filing_Number_) OR __NN(Filing_Book_) OR __NN(Filing_Page_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Lien_Judgment_Group,COUNT(ROWS(LEFT))=1),GROUP,Lien_Judgment__Single_Rollup(LEFT)) + ROLLUP(HAVING(Lien_Judgment_Group,COUNT(ROWS(LEFT))>1),GROUP,Lien_Judgment__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT T_M_S_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,T_M_S_I_D_);
  EXPORT R_M_S_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,R_M_S_I_D_);
  EXPORT Agency_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Agency_I_D_);
  EXPORT Agency__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Agency_);
  EXPORT Agency_County__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Agency_County_);
  EXPORT Agency_State__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Agency_State_);
  EXPORT Sent_To_Credit_Bureau_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Sent_To_Credit_Bureau_Flag_);
  EXPORT I_R_S_Serial_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,I_R_S_Serial_Number_);
  EXPORT Case_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Case_Number_);
  EXPORT Case_Link_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Case_Link_I_D_);
  EXPORT Certificate_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Certificate_Number_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_LiensV2_key_liens_main_ID_Records_Invalid),COUNT(T_M_S_I_D__SingleValue_Invalid),COUNT(R_M_S_I_D__SingleValue_Invalid),COUNT(Agency_I_D__SingleValue_Invalid),COUNT(Agency__SingleValue_Invalid),COUNT(Agency_County__SingleValue_Invalid),COUNT(Agency_State__SingleValue_Invalid),COUNT(Sent_To_Credit_Bureau_Flag__SingleValue_Invalid),COUNT(I_R_S_Serial_Number__SingleValue_Invalid),COUNT(Case_Number__SingleValue_Invalid),COUNT(Case_Link_I_D__SingleValue_Invalid),COUNT(Certificate_Number__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_LiensV2_key_liens_main_ID_Records_Invalid,KEL.typ.int T_M_S_I_D__SingleValue_Invalid,KEL.typ.int R_M_S_I_D__SingleValue_Invalid,KEL.typ.int Agency_I_D__SingleValue_Invalid,KEL.typ.int Agency__SingleValue_Invalid,KEL.typ.int Agency_County__SingleValue_Invalid,KEL.typ.int Agency_State__SingleValue_Invalid,KEL.typ.int Sent_To_Credit_Bureau_Flag__SingleValue_Invalid,KEL.typ.int I_R_S_Serial_Number__SingleValue_Invalid,KEL.typ.int Case_Number__SingleValue_Invalid,KEL.typ.int Case_Link_I_D__SingleValue_Invalid,KEL.typ.int Certificate_Number__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_LiensV2_key_liens_main_ID_Records_Invalid),COUNT(__d0)},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','tmsid',COUNT(__d0(__NL(T_M_S_I_D_))),COUNT(__d0(__NN(T_M_S_I_D_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','rmsid',COUNT(__d0(__NL(R_M_S_I_D_))),COUNT(__d0(__NN(R_M_S_I_D_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','filing_number',COUNT(__d0(__NL(Filing_Number_))),COUNT(__d0(__NN(Filing_Number_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_filing_number',COUNT(__d0(__NL(Original_Filing_Number_))),COUNT(__d0(__NN(Original_Filing_Number_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','filing_type_desc',COUNT(__d0(__NL(Filing_Type_Description_))),COUNT(__d0(__NN(Filing_Type_Description_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','amount',COUNT(__d0(__NL(Amount_))),COUNT(__d0(__NN(Amount_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','eviction',COUNT(__d0(__NL(Landlord_Tenant_Dispute_Flag_))),COUNT(__d0(__NN(Landlord_Tenant_Dispute_Flag_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','certificate_number',COUNT(__d0(__NL(Certificate_Number_))),COUNT(__d0(__NN(Certificate_Number_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','irs_serial_number',COUNT(__d0(__NL(I_R_S_Serial_Number_))),COUNT(__d0(__NN(I_R_S_Serial_Number_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','case_number',COUNT(__d0(__NL(Case_Number_))),COUNT(__d0(__NN(Case_Number_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','caselinkid',COUNT(__d0(__NL(Case_Link_I_D_))),COUNT(__d0(__NN(Case_Link_I_D_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','filing_book',COUNT(__d0(__NL(Filing_Book_))),COUNT(__d0(__NN(Filing_Book_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','filing_page',COUNT(__d0(__NL(Filing_Page_))),COUNT(__d0(__NN(Filing_Page_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','filing_state',COUNT(__d0(__NL(Filing_State_))),COUNT(__d0(__NN(Filing_State_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','filingstatusdescription',COUNT(__d0(__NL(Filing_Status_Description_))),COUNT(__d0(__NN(Filing_Status_Description_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','agencyid',COUNT(__d0(__NL(Agency_I_D_))),COUNT(__d0(__NN(Agency_I_D_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','agency',COUNT(__d0(__NL(Agency_))),COUNT(__d0(__NN(Agency_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','agency_county',COUNT(__d0(__NL(Agency_County_))),COUNT(__d0(__NN(Agency_County_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','agency_state',COUNT(__d0(__NL(Agency_State_))),COUNT(__d0(__NN(Agency_State_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','bcbflag',COUNT(__d0(__NL(Sent_To_Credit_Bureau_Flag_))),COUNT(__d0(__NN(Sent_To_Credit_Bureau_Flag_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','satisifaction_type',COUNT(__d0(__NL(Satisfaction_Type_))),COUNT(__d0(__NN(Satisfaction_Type_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orig_filing_date',COUNT(__d0(__NL(Original_Filing_Date_))),COUNT(__d0(__NN(Original_Filing_Date_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','collection_date',COUNT(__d0(__NL(Collection_Date_))),COUNT(__d0(__NN(Collection_Date_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','effective_date',COUNT(__d0(__NL(Effective_Date_))),COUNT(__d0(__NN(Effective_Date_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','expiration_date',COUNT(__d0(__NL(Expiration_Date_))),COUNT(__d0(__NN(Expiration_Date_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','lapse_date',COUNT(__d0(__NL(Lapse_Date_))),COUNT(__d0(__NN(Lapse_Date_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','process_date',COUNT(__d0(__NL(Process_Date_))),COUNT(__d0(__NN(Process_Date_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
