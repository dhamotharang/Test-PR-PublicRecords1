//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(DEFAULT:UID),tmsid(DEFAULT:T_M_S_I_D_),rmsid(DEFAULT:R_M_S_I_D_),filingnumber(DEFAULT:Filing_Number_:\'\'),originalfilingnumber(DEFAULT:Original_Filing_Number_:\'\'),filingtypedescription(DEFAULT:Filing_Type_Description_:\'\'),amount(DEFAULT:Amount_:\'\'),landlordtenantdisputeflag(DEFAULT:Landlord_Tenant_Dispute_Flag_:\'\'),certificatenumber(DEFAULT:Certificate_Number_:\'\'),irsserialnumber(DEFAULT:I_R_S_Serial_Number_:\'\'),casenumber(DEFAULT:Case_Number_:\'\'),caselinkid(DEFAULT:Case_Link_I_D_:\'\'),filingbook(DEFAULT:Filing_Book_:\'\'),filingpage(DEFAULT:Filing_Page_:\'\'),filingstate(DEFAULT:Filing_State_:\'\'),filingstatusdescription(DEFAULT:Filing_Status_Description_:\'\'),agencyid(DEFAULT:Agency_I_D_:\'\'),agency(DEFAULT:Agency_:\'\'),agencycounty(DEFAULT:Agency_County_:\'\'),agencystate(DEFAULT:Agency_State_:\'\'),senttocreditbureauflag(DEFAULT:Sent_To_Credit_Bureau_Flag_),satisfactiontype(DEFAULT:Satisfaction_Type_:\'\'),originalfilingdate(DEFAULT:Original_Filing_Date_:DATE),collectiondate(DEFAULT:Collection_Date_:DATE),effectivedate(DEFAULT:Effective_Date_:DATE),expirationdate(DEFAULT:Expiration_Date_:DATE),lapsedate(DEFAULT:Lapse_Date_:0),processdate(DEFAULT:Process_Date_:DATE),source(DEFAULT:Source_:\'\'),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.TMSID) + '|' + TRIM((STRING)LEFT.RMSID)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  SHARED __Table := TABLE(__All_Trim,__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  EXPORT Lookup := PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__in,Lookup,TRIM((STRING)LEFT.TMSID) + '|' + TRIM((STRING)LEFT.RMSID) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Book_Filing_Details_Layout := RECORD
    KEL.typ.nstr Filing_Number_;
    KEL.typ.nstr Filing_Book_;
    KEL.typ.nstr Filing_Page_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Lien_Judgment_Group := __PostFilter;
  Layout Lien_Judgment__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.T_M_S_I_D_ := KEL.Intake.SingleValue(__recs,T_M_S_I_D_);
    SELF.R_M_S_I_D_ := KEL.Intake.SingleValue(__recs,R_M_S_I_D_);
    SELF.Filing_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Filing_Number_,Original_Filing_Number_,Filing_Type_Description_,Filing_Status_Description_,Satisfaction_Type_,Amount_,Filing_State_,Landlord_Tenant_Dispute_Flag_,Original_Filing_Date_,Effective_Date_,Collection_Date_,Expiration_Date_,Lapse_Date_,Process_Date_},Filing_Number_,Original_Filing_Number_,Filing_Type_Description_,Filing_Status_Description_,Satisfaction_Type_,Amount_,Filing_State_,Landlord_Tenant_Dispute_Flag_,Original_Filing_Date_,Effective_Date_,Collection_Date_,Expiration_Date_,Lapse_Date_,Process_Date_),Filing_Layout)(__NN(Filing_Number_) OR __NN(Original_Filing_Number_) OR __NN(Filing_Type_Description_) OR __NN(Filing_Status_Description_) OR __NN(Satisfaction_Type_) OR __NN(Amount_) OR __NN(Filing_State_) OR __NN(Landlord_Tenant_Dispute_Flag_) OR __NN(Original_Filing_Date_) OR __NN(Effective_Date_) OR __NN(Collection_Date_) OR __NN(Expiration_Date_) OR __NN(Lapse_Date_) OR __NN(Process_Date_)));
    SELF.Book_Filing_Details_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Filing_Number_,Filing_Book_,Filing_Page_},Filing_Number_,Filing_Book_,Filing_Page_),Book_Filing_Details_Layout)(__NN(Filing_Number_) OR __NN(Filing_Book_) OR __NN(Filing_Page_)));
    SELF.Agency_I_D_ := KEL.Intake.SingleValue(__recs,Agency_I_D_);
    SELF.Agency_ := KEL.Intake.SingleValue(__recs,Agency_);
    SELF.Agency_County_ := KEL.Intake.SingleValue(__recs,Agency_County_);
    SELF.Agency_State_ := KEL.Intake.SingleValue(__recs,Agency_State_);
    SELF.Sent_To_Credit_Bureau_Flag_ := KEL.Intake.SingleValue(__recs,Sent_To_Credit_Bureau_Flag_);
    SELF.I_R_S_Serial_Number_ := KEL.Intake.SingleValue(__recs,I_R_S_Serial_Number_);
    SELF.Case_Number_ := KEL.Intake.SingleValue(__recs,Case_Number_);
    SELF.Case_Link_I_D_ := KEL.Intake.SingleValue(__recs,Case_Link_I_D_);
    SELF.Certificate_Number_ := KEL.Intake.SingleValue(__recs,Certificate_Number_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Lien_Judgment__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Filing_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Filing_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Filing_Number_) OR __NN(Original_Filing_Number_) OR __NN(Filing_Type_Description_) OR __NN(Filing_Status_Description_) OR __NN(Satisfaction_Type_) OR __NN(Amount_) OR __NN(Filing_State_) OR __NN(Landlord_Tenant_Dispute_Flag_) OR __NN(Original_Filing_Date_) OR __NN(Effective_Date_) OR __NN(Collection_Date_) OR __NN(Expiration_Date_) OR __NN(Lapse_Date_) OR __NN(Process_Date_)));
    SELF.Book_Filing_Details_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Book_Filing_Details_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Filing_Number_) OR __NN(Filing_Book_) OR __NN(Filing_Page_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Lien_Judgment_Group,COUNT(ROWS(LEFT))=1),GROUP,Lien_Judgment__Single_Rollup(LEFT)) + ROLLUP(HAVING(Lien_Judgment_Group,COUNT(ROWS(LEFT))>1),GROUP,Lien_Judgment__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT T_M_S_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,T_M_S_I_D_);
  EXPORT R_M_S_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,R_M_S_I_D_);
  EXPORT Agency_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Agency_I_D_);
  EXPORT Agency__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Agency_);
  EXPORT Agency_County__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Agency_County_);
  EXPORT Agency_State__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Agency_State_);
  EXPORT Sent_To_Credit_Bureau_Flag__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sent_To_Credit_Bureau_Flag_);
  EXPORT I_R_S_Serial_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,I_R_S_Serial_Number_);
  EXPORT Case_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Case_Number_);
  EXPORT Case_Link_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Case_Link_I_D_);
  EXPORT Certificate_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Certificate_Number_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(T_M_S_I_D__SingleValue_Invalid),COUNT(R_M_S_I_D__SingleValue_Invalid),COUNT(Agency_I_D__SingleValue_Invalid),COUNT(Agency__SingleValue_Invalid),COUNT(Agency_County__SingleValue_Invalid),COUNT(Agency_State__SingleValue_Invalid),COUNT(Sent_To_Credit_Bureau_Flag__SingleValue_Invalid),COUNT(I_R_S_Serial_Number__SingleValue_Invalid),COUNT(Case_Number__SingleValue_Invalid),COUNT(Case_Link_I_D__SingleValue_Invalid),COUNT(Certificate_Number__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid,KEL.typ.int T_M_S_I_D__SingleValue_Invalid,KEL.typ.int R_M_S_I_D__SingleValue_Invalid,KEL.typ.int Agency_I_D__SingleValue_Invalid,KEL.typ.int Agency__SingleValue_Invalid,KEL.typ.int Agency_County__SingleValue_Invalid,KEL.typ.int Agency_State__SingleValue_Invalid,KEL.typ.int Sent_To_Credit_Bureau_Flag__SingleValue_Invalid,KEL.typ.int I_R_S_Serial_Number__SingleValue_Invalid,KEL.typ.int Case_Number__SingleValue_Invalid,KEL.typ.int Case_Link_I_D__SingleValue_Invalid,KEL.typ.int Certificate_Number__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(__d0)},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TMSID',COUNT(__d0(__NL(T_M_S_I_D_))),COUNT(__d0(__NN(T_M_S_I_D_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RMSID',COUNT(__d0(__NL(R_M_S_I_D_))),COUNT(__d0(__NN(R_M_S_I_D_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FilingNumber',COUNT(__d0(__NL(Filing_Number_))),COUNT(__d0(__NN(Filing_Number_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalFilingNumber',COUNT(__d0(__NL(Original_Filing_Number_))),COUNT(__d0(__NN(Original_Filing_Number_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FilingTypeDescription',COUNT(__d0(__NL(Filing_Type_Description_))),COUNT(__d0(__NN(Filing_Type_Description_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Amount',COUNT(__d0(__NL(Amount_))),COUNT(__d0(__NN(Amount_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LandlordTenantDisputeFlag',COUNT(__d0(__NL(Landlord_Tenant_Dispute_Flag_))),COUNT(__d0(__NN(Landlord_Tenant_Dispute_Flag_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CertificateNumber',COUNT(__d0(__NL(Certificate_Number_))),COUNT(__d0(__NN(Certificate_Number_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','IRSSerialNumber',COUNT(__d0(__NL(I_R_S_Serial_Number_))),COUNT(__d0(__NN(I_R_S_Serial_Number_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CaseNumber',COUNT(__d0(__NL(Case_Number_))),COUNT(__d0(__NN(Case_Number_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CaseLinkID',COUNT(__d0(__NL(Case_Link_I_D_))),COUNT(__d0(__NN(Case_Link_I_D_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FilingBook',COUNT(__d0(__NL(Filing_Book_))),COUNT(__d0(__NN(Filing_Book_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FilingPage',COUNT(__d0(__NL(Filing_Page_))),COUNT(__d0(__NN(Filing_Page_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FilingState',COUNT(__d0(__NL(Filing_State_))),COUNT(__d0(__NN(Filing_State_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FilingStatusDescription',COUNT(__d0(__NL(Filing_Status_Description_))),COUNT(__d0(__NN(Filing_Status_Description_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AgencyID',COUNT(__d0(__NL(Agency_I_D_))),COUNT(__d0(__NN(Agency_I_D_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Agency',COUNT(__d0(__NL(Agency_))),COUNT(__d0(__NN(Agency_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AgencyCounty',COUNT(__d0(__NL(Agency_County_))),COUNT(__d0(__NN(Agency_County_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','AgencyState',COUNT(__d0(__NL(Agency_State_))),COUNT(__d0(__NN(Agency_State_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SentToCreditBureauFlag',COUNT(__d0(__NL(Sent_To_Credit_Bureau_Flag_))),COUNT(__d0(__NN(Sent_To_Credit_Bureau_Flag_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SatisfactionType',COUNT(__d0(__NL(Satisfaction_Type_))),COUNT(__d0(__NN(Satisfaction_Type_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OriginalFilingDate',COUNT(__d0(__NL(Original_Filing_Date_))),COUNT(__d0(__NN(Original_Filing_Date_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollectionDate',COUNT(__d0(__NL(Collection_Date_))),COUNT(__d0(__NN(Collection_Date_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','EffectiveDate',COUNT(__d0(__NL(Effective_Date_))),COUNT(__d0(__NN(Effective_Date_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ExpirationDate',COUNT(__d0(__NL(Expiration_Date_))),COUNT(__d0(__NN(Expiration_Date_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','LapseDate',COUNT(__d0(__NL(Lapse_Date_))),COUNT(__d0(__NN(Lapse_Date_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ProcessDate',COUNT(__d0(__NL(Process_Date_))),COUNT(__d0(__NN(Process_Date_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'LienJudgment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
