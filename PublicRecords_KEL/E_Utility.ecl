//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT E_Utility(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Utility_I_D_;
    KEL.typ.nkdate Date_Added_To_Exchange_;
    KEL.typ.nkdate Connect_Date_;
    KEL.typ.nstr Utility_Type_;
    KEL.typ.nkdate Record_Date_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'id(DEFAULT:UID),utilityid(DEFAULT:Utility_I_D_:\'\'),dateaddedtoexchange(DEFAULT:Date_Added_To_Exchange_:DATE),connectdate(DEFAULT:Connect_Date_:DATE),utilitytype(DEFAULT:Utility_Type_:\'\'),recorddate(DEFAULT:Record_Date_:DATE),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH)';
  SHARED __Mapping0 := 'id(OVERRIDE:UID|OVERRIDE:Utility_I_D_:\'\'),date_added_to_exchange(OVERRIDE:Date_Added_To_Exchange_:DATE),connect_date(OVERRIDE:Connect_Date_:DATE),util_type(OVERRIDE:Utility_Type_:\'\'),record_date(OVERRIDE:Record_Date_:DATE),src(OVERRIDE:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_UtilFile__Key_Address,TRANSFORM(RECORDOF(__in.Dataset_UtilFile__Key_Address),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_Address_Invalid := __d0_Norm((KEL.typ.uid)id = 0);
  SHARED __d0_Prefiltered := __d0_Norm((KEL.typ.uid)id <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping1 := 'id(OVERRIDE:UID|OVERRIDE:Utility_I_D_:\'\'),date_added_to_exchange(OVERRIDE:Date_Added_To_Exchange_:DATE),connect_date(OVERRIDE:Connect_Date_:DATE),util_type(OVERRIDE:Utility_Type_:\'\'),record_date(OVERRIDE:Record_Date_:DATE),src(OVERRIDE:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_UtilFile__Key_DID,TRANSFORM(RECORDOF(__in.Dataset_UtilFile__Key_DID),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_DID_Invalid := __d1_Norm((KEL.typ.uid)id = 0);
  SHARED __d1_Prefiltered := __d1_Norm((KEL.typ.uid)id <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping2 := 'id(OVERRIDE:UID|OVERRIDE:Utility_I_D_:\'\'),date_added_to_exchange(OVERRIDE:Date_Added_To_Exchange_:DATE),connect_date(OVERRIDE:Connect_Date_:DATE),util_type(OVERRIDE:Utility_Type_:\'\'),record_date(OVERRIDE:Record_Date_:DATE),src(OVERRIDE:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_UtilFile__Kfetch2_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_UtilFile__Kfetch2_LinkIds),SELF:=RIGHT));
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Kfetch2_LinkIds_Invalid := __d2_Norm((KEL.typ.uid)id = 0);
  SHARED __d2_Prefiltered := __d2_Norm((KEL.typ.uid)id <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Utility_I_D_;
    KEL.typ.nkdate Date_Added_To_Exchange_;
    KEL.typ.nkdate Connect_Date_;
    KEL.typ.nstr Utility_Type_;
    KEL.typ.nkdate Record_Date_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
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
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_First_Reported_,MIN,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_Last_Reported_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Utility__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_First_Reported_,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_Last_Reported_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Utility_Group,COUNT(ROWS(LEFT))=1),GROUP,Utility__Single_Rollup(LEFT)) + ROLLUP(HAVING(Utility_Group,COUNT(ROWS(LEFT))>1),GROUP,Utility__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Utility_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Utility_I_D_);
  EXPORT Date_Added_To_Exchange__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Added_To_Exchange_);
  EXPORT Connect_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Connect_Date_);
  EXPORT Utility_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Utility_Type_);
  EXPORT Record_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Record_Date_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_Address_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_DID_Invalid),COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Kfetch2_LinkIds_Invalid),COUNT(Utility_I_D__SingleValue_Invalid),COUNT(Date_Added_To_Exchange__SingleValue_Invalid),COUNT(Connect_Date__SingleValue_Invalid),COUNT(Utility_Type__SingleValue_Invalid),COUNT(Record_Date__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_Address_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_DID_Invalid,KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Kfetch2_LinkIds_Invalid,KEL.typ.int Utility_I_D__SingleValue_Invalid,KEL.typ.int Date_Added_To_Exchange__SingleValue_Invalid,KEL.typ.int Connect_Date__SingleValue_Invalid,KEL.typ.int Utility_Type__SingleValue_Invalid,KEL.typ.int Record_Date__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_Address_Invalid),COUNT(__d0)},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','id',COUNT(__d0(__NL(Utility_I_D_))),COUNT(__d0(__NN(Utility_I_D_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_added_to_exchange',COUNT(__d0(__NL(Date_Added_To_Exchange_))),COUNT(__d0(__NN(Date_Added_To_Exchange_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','connect_date',COUNT(__d0(__NL(Connect_Date_))),COUNT(__d0(__NN(Connect_Date_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','util_type',COUNT(__d0(__NL(Utility_Type_))),COUNT(__d0(__NN(Utility_Type_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_date',COUNT(__d0(__NL(Record_Date_))),COUNT(__d0(__NN(Record_Date_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(Date_Vendor_First_Reported_=0)),COUNT(__d0(Date_Vendor_First_Reported_!=0))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(Date_Vendor_Last_Reported_=0)),COUNT(__d0(Date_Vendor_Last_Reported_!=0))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Key_DID_Invalid),COUNT(__d1)},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','id',COUNT(__d1(__NL(Utility_I_D_))),COUNT(__d1(__NN(Utility_I_D_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_added_to_exchange',COUNT(__d1(__NL(Date_Added_To_Exchange_))),COUNT(__d1(__NN(Date_Added_To_Exchange_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','connect_date',COUNT(__d1(__NL(Connect_Date_))),COUNT(__d1(__NN(Connect_Date_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','util_type',COUNT(__d1(__NL(Utility_Type_))),COUNT(__d1(__NN(Utility_Type_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_date',COUNT(__d1(__NL(Record_Date_))),COUNT(__d1(__NN(Record_Date_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d1(Date_Vendor_First_Reported_=0)),COUNT(__d1(Date_Vendor_First_Reported_!=0))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d1(Date_Vendor_Last_Reported_=0)),COUNT(__d1(Date_Vendor_Last_Reported_!=0))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_UtilFile__Kfetch2_LinkIds_Invalid),COUNT(__d2)},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','id',COUNT(__d2(__NL(Utility_I_D_))),COUNT(__d2(__NN(Utility_I_D_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','date_added_to_exchange',COUNT(__d2(__NL(Date_Added_To_Exchange_))),COUNT(__d2(__NN(Date_Added_To_Exchange_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','connect_date',COUNT(__d2(__NL(Connect_Date_))),COUNT(__d2(__NN(Connect_Date_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','util_type',COUNT(__d2(__NL(Utility_Type_))),COUNT(__d2(__NN(Utility_Type_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','record_date',COUNT(__d2(__NL(Record_Date_))),COUNT(__d2(__NN(Record_Date_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d2(Date_Vendor_First_Reported_=0)),COUNT(__d2(Date_Vendor_First_Reported_!=0))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d2(Date_Vendor_Last_Reported_=0)),COUNT(__d2(Date_Vendor_Last_Reported_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
