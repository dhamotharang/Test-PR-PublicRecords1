﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),ultid(Ult_I_D_:0),orgid(Org_I_D_:0),seleid(Sele_I_D_:0),accountkey(Account_Key_:\'\'),ardate(A_R_Date_:DATE),status(Status_),totalar(Total_A_R_:\'\'),currentar(Current_A_R_:\'\'),aging1to30(Aging1_To30_:\'\'),aging31to60(Aging31_To60_:\'\'),aging61to90(Aging61_To90_:\'\'),aging91plus(Aging91_Plus_:\'\'),creditlimit(Credit_Limit_:\'\'),segmentid(Segment_I_D_:\'\'),dtvendorfirstreported(Dt_Vendor_First_Reported_:DATE),dtvendorlastreported(Dt_Vendor_Last_Reported_:DATE),filedate(File_Date_:DATE),firstsaledate(First_Sale_Date_:DATE),lastsaledate(Last_Sale_Date_:DATE),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
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
  SHARED __Mapping0 := 'UID(UID),ultid(Ult_I_D_:0),orgid(Org_I_D_:0),seleid(Sele_I_D_:0),account_key(Account_Key_:\'\'),ar_date(A_R_Date_:DATE),status(Status_),total_ar(Total_A_R_:\'\'),current_ar(Current_A_R_:\'\'),aging_1to30(Aging1_To30_:\'\'),aging_31to60(Aging31_To60_:\'\'),aging_61to90(Aging61_To90_:\'\'),aging_91plus(Aging91_Plus_:\'\'),credit_limit(Credit_Limit_:\'\'),segment_id(Segment_I_D_:\'\'),dt_vendor_first_reported(Dt_Vendor_First_Reported_:DATE),dt_vendor_last_reported(Dt_Vendor_Last_Reported_:DATE),filedate(File_Date_:DATE),first_sale_date(First_Sale_Date_:DATE),last_sale_date(Last_Sale_Date_:DATE),source(Source_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH),dt_last_seen(Date_Last_Seen_:EPOCH),DPMBitmap(__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Cortera_Tradeline__Key_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_Cortera_Tradeline__Key_LinkIds),SELF:=RIGHT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC.Dataset_Cortera_Tradeline__Key_LinkIds);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__d0_KELfiltered,Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.account_key) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Cortera_Tradeline__Key_LinkIds_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Vendor_Dates_Layout := RECORD
    KEL.typ.nkdate Dt_Vendor_First_Reported_;
    KEL.typ.nkdate Dt_Vendor_Last_Reported_;
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
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(Records_Layout) Records_;
    KEL.typ.ndataset(Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Tradeline_Group := __PostFilter;
  Layout Tradeline__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Ult_I_D_ := KEL.Intake.SingleValue(__recs,Ult_I_D_);
    SELF.Org_I_D_ := KEL.Intake.SingleValue(__recs,Org_I_D_);
    SELF.Sele_I_D_ := KEL.Intake.SingleValue(__recs,Sele_I_D_);
    SELF.Account_Key_ := KEL.Intake.SingleValue(__recs,Account_Key_);
    SELF.Records_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),A_R_Date_,Total_A_R_,Current_A_R_,Aging1_To30_,Aging31_To60_,Aging61_To90_,Aging91_Plus_,Credit_Limit_,Segment_I_D_,File_Date_,Status_,First_Sale_Date_,Last_Sale_Date_},A_R_Date_,Total_A_R_,Current_A_R_,Aging1_To30_,Aging31_To60_,Aging61_To90_,Aging91_Plus_,Credit_Limit_,Segment_I_D_,File_Date_,Status_,First_Sale_Date_,Last_Sale_Date_),Records_Layout)(__NN(A_R_Date_) OR __NN(Total_A_R_) OR __NN(Current_A_R_) OR __NN(Aging1_To30_) OR __NN(Aging31_To60_) OR __NN(Aging61_To90_) OR __NN(Aging91_Plus_) OR __NN(Credit_Limit_) OR __NN(Segment_I_D_) OR __NN(File_Date_) OR __NN(Status_) OR __NN(First_Sale_Date_) OR __NN(Last_Sale_Date_)));
    SELF.Vendor_Dates_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Dt_Vendor_First_Reported_,Dt_Vendor_Last_Reported_},Dt_Vendor_First_Reported_,Dt_Vendor_Last_Reported_),Vendor_Dates_Layout)(__NN(Dt_Vendor_First_Reported_) OR __NN(Dt_Vendor_Last_Reported_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Tradeline__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Records_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Records_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(A_R_Date_) OR __NN(Total_A_R_) OR __NN(Current_A_R_) OR __NN(Aging1_To30_) OR __NN(Aging31_To60_) OR __NN(Aging61_To90_) OR __NN(Aging91_Plus_) OR __NN(Credit_Limit_) OR __NN(Segment_I_D_) OR __NN(File_Date_) OR __NN(Status_) OR __NN(First_Sale_Date_) OR __NN(Last_Sale_Date_)));
    SELF.Vendor_Dates_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Vendor_Dates_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Dt_Vendor_First_Reported_) OR __NN(Dt_Vendor_Last_Reported_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Tradeline_Group,COUNT(ROWS(LEFT))=1),GROUP,Tradeline__Single_Rollup(LEFT)) + ROLLUP(HAVING(Tradeline_Group,COUNT(ROWS(LEFT))>1),GROUP,Tradeline__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Ult_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ult_I_D_);
  EXPORT Org_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Org_I_D_);
  EXPORT Sele_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Sele_I_D_);
  EXPORT Account_Key__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Account_Key_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Cortera_Tradeline__Key_LinkIds_Invalid),COUNT(Ult_I_D__SingleValue_Invalid),COUNT(Org_I_D__SingleValue_Invalid),COUNT(Sele_I_D__SingleValue_Invalid),COUNT(Account_Key__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Cortera_Tradeline__Key_LinkIds_Invalid,KEL.typ.int Ult_I_D__SingleValue_Invalid,KEL.typ.int Org_I_D__SingleValue_Invalid,KEL.typ.int Sele_I_D__SingleValue_Invalid,KEL.typ.int Account_Key__SingleValue_Invalid});
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
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_first_reported',COUNT(__d0(__NL(Dt_Vendor_First_Reported_))),COUNT(__d0(__NN(Dt_Vendor_First_Reported_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','dt_vendor_last_reported',COUNT(__d0(__NL(Dt_Vendor_Last_Reported_))),COUNT(__d0(__NN(Dt_Vendor_Last_Reported_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','filedate',COUNT(__d0(__NL(File_Date_))),COUNT(__d0(__NN(File_Date_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','first_sale_date',COUNT(__d0(__NL(First_Sale_Date_))),COUNT(__d0(__NN(First_Sale_Date_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','last_sale_date',COUNT(__d0(__NL(Last_Sale_Date_))),COUNT(__d0(__NN(Last_Sale_Date_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Tradeline','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
