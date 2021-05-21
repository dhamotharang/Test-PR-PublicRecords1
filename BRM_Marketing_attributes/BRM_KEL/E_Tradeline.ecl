//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL16.Null;
EXPORT E_Tradeline(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.nkdate A_R_Date_;
    KEL.typ.nstr Status_;
    KEL.typ.nint Total_A_R_;
    KEL.typ.nint Current_A_R_;
    KEL.typ.nint Aging1_To30_;
    KEL.typ.nint Aging31_To60_;
    KEL.typ.nint Aging61_To90_;
    KEL.typ.nint Aging91_Plus_;
    KEL.typ.nint Credit_Limit_;
    KEL.typ.nint Segment_I_D_;
    KEL.typ.nkdate Dt_Vendor_First_Reported_;
    KEL.typ.nkdate Dt_Vendor_Last_Reported_;
    KEL.typ.nkdate File_Date_;
    KEL.typ.nkdate First_Sale_Date_;
    KEL.typ.nkdate Last_Sale_Date_;
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
  SHARED __Mapping := 'UID(DEFAULT:UID),ultid(DEFAULT:Ult_I_D_:0),orgid(DEFAULT:Org_I_D_:0),seleid(DEFAULT:Sele_I_D_:0),accountkey(DEFAULT:Account_Key_:\'\'),ardate(DEFAULT:A_R_Date_:DATE),status(DEFAULT:Status_),totalar(DEFAULT:Total_A_R_:\'\'),currentar(DEFAULT:Current_A_R_:\'\'),aging1to30(DEFAULT:Aging1_To30_:\'\'),aging31to60(DEFAULT:Aging31_To60_:\'\'),aging61to90(DEFAULT:Aging61_To90_:\'\'),aging91plus(DEFAULT:Aging91_Plus_:\'\'),creditlimit(DEFAULT:Credit_Limit_:\'\'),segmentid(DEFAULT:Segment_I_D_:\'\'),dtvendorfirstreported(DEFAULT:Dt_Vendor_First_Reported_:DATE),dtvendorlastreported(DEFAULT:Dt_Vendor_Last_Reported_:DATE),filedate(DEFAULT:File_Date_:DATE),firstsaledate(DEFAULT:First_Sale_Date_:DATE),lastsaledate(DEFAULT:Last_Sale_Date_:DATE),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_KELfiltered := __in.Dataset_Cortera_Tradeline__Key_LinkIds(status NOT IN ['D', 'R']);
  SHARED __d0_Trim := PROJECT(__d0_KELfiltered,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.account_key)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)0) + '|' + TRIM((STRING)0) + '|' + TRIM((STRING)0) + '|' + TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __Mapping0 := 'UID(DEFAULT:UID),ultid(OVERRIDE:Ult_I_D_:0),orgid(OVERRIDE:Org_I_D_:0),seleid(OVERRIDE:Sele_I_D_:0),account_key(OVERRIDE:Account_Key_:\'\'),ar_date(OVERRIDE:A_R_Date_:DATE),status(OVERRIDE:Status_),total_ar(OVERRIDE:Total_A_R_:\'\'),current_ar(OVERRIDE:Current_A_R_:\'\'),aging_1to30(OVERRIDE:Aging1_To30_:\'\'),aging_31to60(OVERRIDE:Aging31_To60_:\'\'),aging_61to90(OVERRIDE:Aging61_To90_:\'\'),aging_91plus(OVERRIDE:Aging91_Plus_:\'\'),credit_limit(OVERRIDE:Credit_Limit_:\'\'),segment_id(OVERRIDE:Segment_I_D_:\'\'),dtvendorfirstreported(DEFAULT:Dt_Vendor_First_Reported_:DATE),dtvendorlastreported(DEFAULT:Dt_Vendor_Last_Reported_:DATE),filedate(OVERRIDE:File_Date_:DATE),first_sale_date(OVERRIDE:First_Sale_Date_:DATE),last_sale_date(OVERRIDE:Last_Sale_Date_:DATE),source(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),dt_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),dt_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Cortera_Tradeline__Key_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_Cortera_Tradeline__Key_LinkIds),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Cortera_Tradeline__Key_LinkIds);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.account_key) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Cortera_Tradeline__Key_LinkIds_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0;
  EXPORT Records_Layout := RECORD
    KEL.typ.nkdate A_R_Date_;
    KEL.typ.nint Total_A_R_;
    KEL.typ.nint Current_A_R_;
    KEL.typ.nint Aging1_To30_;
    KEL.typ.nint Aging31_To60_;
    KEL.typ.nint Aging61_To90_;
    KEL.typ.nint Aging91_Plus_;
    KEL.typ.nint Credit_Limit_;
    KEL.typ.nint Segment_I_D_;
    KEL.typ.nkdate File_Date_;
    KEL.typ.nstr Status_;
    KEL.typ.nkdate First_Sale_Date_;
    KEL.typ.nkdate Last_Sale_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Vendor_Dates_Layout := RECORD
    KEL.typ.nkdate Dt_Vendor_First_Reported_;
    KEL.typ.nkdate Dt_Vendor_Last_Reported_;
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
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(Records_Layout) Records_;
    KEL.typ.ndataset(Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Tradeline_Group := __PostFilter;
  Layout Tradeline__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Ult_I_D_ := KEL.Intake.SingleValue(__recs,Ult_I_D_);
    SELF.Org_I_D_ := KEL.Intake.SingleValue(__recs,Org_I_D_);
    SELF.Sele_I_D_ := KEL.Intake.SingleValue(__recs,Sele_I_D_);
    SELF.Account_Key_ := KEL.Intake.SingleValue(__recs,Account_Key_);
    SELF.Records_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),A_R_Date_,Total_A_R_,Current_A_R_,Aging1_To30_,Aging31_To60_,Aging61_To90_,Aging91_Plus_,Credit_Limit_,Segment_I_D_,File_Date_,Status_,First_Sale_Date_,Last_Sale_Date_},A_R_Date_,Total_A_R_,Current_A_R_,Aging1_To30_,Aging31_To60_,Aging61_To90_,Aging91_Plus_,Credit_Limit_,Segment_I_D_,File_Date_,Status_,First_Sale_Date_,Last_Sale_Date_),Records_Layout)(__NN(A_R_Date_) OR __NN(Total_A_R_) OR __NN(Current_A_R_) OR __NN(Aging1_To30_) OR __NN(Aging31_To60_) OR __NN(Aging61_To90_) OR __NN(Aging91_Plus_) OR __NN(Credit_Limit_) OR __NN(Segment_I_D_) OR __NN(File_Date_) OR __NN(Status_) OR __NN(First_Sale_Date_) OR __NN(Last_Sale_Date_)));
    SELF.Vendor_Dates_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Dt_Vendor_First_Reported_,Dt_Vendor_Last_Reported_},Dt_Vendor_First_Reported_,Dt_Vendor_Last_Reported_),Vendor_Dates_Layout)(__NN(Dt_Vendor_First_Reported_) OR __NN(Dt_Vendor_Last_Reported_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Tradeline__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Records_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Records_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(A_R_Date_) OR __NN(Total_A_R_) OR __NN(Current_A_R_) OR __NN(Aging1_To30_) OR __NN(Aging31_To60_) OR __NN(Aging61_To90_) OR __NN(Aging91_Plus_) OR __NN(Credit_Limit_) OR __NN(Segment_I_D_) OR __NN(File_Date_) OR __NN(Status_) OR __NN(First_Sale_Date_) OR __NN(Last_Sale_Date_)));
    SELF.Vendor_Dates_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Vendor_Dates_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Dt_Vendor_First_Reported_) OR __NN(Dt_Vendor_Last_Reported_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Tradeline_Group,COUNT(ROWS(LEFT))=1),GROUP,Tradeline__Single_Rollup(LEFT)) + ROLLUP(HAVING(Tradeline_Group,COUNT(ROWS(LEFT))>1),GROUP,Tradeline__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Ult_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Ult_I_D_);
  EXPORT Org_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Org_I_D_);
  EXPORT Sele_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Sele_I_D_);
  EXPORT Account_Key__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Account_Key_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Cortera_Tradeline__Key_LinkIds_Invalid),COUNT(Ult_I_D__SingleValue_Invalid),COUNT(Org_I_D__SingleValue_Invalid),COUNT(Sele_I_D__SingleValue_Invalid),COUNT(Account_Key__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Cortera_Tradeline__Key_LinkIds_Invalid,KEL.typ.int Ult_I_D__SingleValue_Invalid,KEL.typ.int Org_I_D__SingleValue_Invalid,KEL.typ.int Sele_I_D__SingleValue_Invalid,KEL.typ.int Account_Key__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Cortera_Tradeline__Key_LinkIds_Invalid),COUNT(__d0)},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ultid',COUNT(__d0(__NL(Ult_I_D_))),COUNT(__d0(__NN(Ult_I_D_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','orgid',COUNT(__d0(__NL(Org_I_D_))),COUNT(__d0(__NN(Org_I_D_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','seleid',COUNT(__d0(__NL(Sele_I_D_))),COUNT(__d0(__NN(Sele_I_D_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','account_key',COUNT(__d0(__NL(Account_Key_))),COUNT(__d0(__NN(Account_Key_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ar_date',COUNT(__d0(__NL(A_R_Date_))),COUNT(__d0(__NN(A_R_Date_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','status',COUNT(__d0(__NL(Status_))),COUNT(__d0(__NN(Status_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','total_ar',COUNT(__d0(__NL(Total_A_R_))),COUNT(__d0(__NN(Total_A_R_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','current_ar',COUNT(__d0(__NL(Current_A_R_))),COUNT(__d0(__NN(Current_A_R_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','aging_1to30',COUNT(__d0(__NL(Aging1_To30_))),COUNT(__d0(__NN(Aging1_To30_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','aging_31to60',COUNT(__d0(__NL(Aging31_To60_))),COUNT(__d0(__NN(Aging31_To60_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','aging_61to90',COUNT(__d0(__NL(Aging61_To90_))),COUNT(__d0(__NN(Aging61_To90_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','aging_91plus',COUNT(__d0(__NL(Aging91_Plus_))),COUNT(__d0(__NN(Aging91_Plus_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','credit_limit',COUNT(__d0(__NL(Credit_Limit_))),COUNT(__d0(__NN(Credit_Limit_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','segment_id',COUNT(__d0(__NL(Segment_I_D_))),COUNT(__d0(__NN(Segment_I_D_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DtVendorFirstReported',COUNT(__d0(__NL(Dt_Vendor_First_Reported_))),COUNT(__d0(__NN(Dt_Vendor_First_Reported_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DtVendorLastReported',COUNT(__d0(__NL(Dt_Vendor_Last_Reported_))),COUNT(__d0(__NN(Dt_Vendor_Last_Reported_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','filedate',COUNT(__d0(__NL(File_Date_))),COUNT(__d0(__NN(File_Date_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','first_sale_date',COUNT(__d0(__NL(First_Sale_Date_))),COUNT(__d0(__NN(First_Sale_Date_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','last_sale_date',COUNT(__d0(__NL(Last_Sale_Date_))),COUNT(__d0(__NN(Last_Sale_Date_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
