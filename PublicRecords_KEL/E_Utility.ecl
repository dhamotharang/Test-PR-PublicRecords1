//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'id(UID),utilityid(Utility_I_D_:\'\'),dateaddedtoexchange(Date_Added_To_Exchange_:DATE),connectdate(Connect_Date_:DATE),utilitytype(Utility_Type_:\'\'),recorddate(Record_Date_:DATE),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid := __in((KEL.typ.uid)ID = 0);
  SHARED __d0_Prefiltered := __in((KEL.typ.uid)ID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
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
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Utility__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Utility_Group,COUNT(ROWS(LEFT))=1),GROUP,Utility__Single_Rollup(LEFT)) + ROLLUP(HAVING(Utility_Group,COUNT(ROWS(LEFT))>1),GROUP,Utility__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::PublicRecords_KEL::Utility::Result' + IF(__cfg.PersistId <> '','::' + __cfg.PersistId,''),EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Utility_I_D__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Utility_I_D_);
  EXPORT Date_Added_To_Exchange__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Added_To_Exchange_);
  EXPORT Connect_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Connect_Date_);
  EXPORT Utility_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Utility_Type_);
  EXPORT Record_Date__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Record_Date_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(Utility_I_D__SingleValue_Invalid),COUNT(Date_Added_To_Exchange__SingleValue_Invalid),COUNT(Connect_Date__SingleValue_Invalid),COUNT(Utility_Type__SingleValue_Invalid),COUNT(Record_Date__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid,KEL.typ.int Utility_I_D__SingleValue_Invalid,KEL.typ.int Date_Added_To_Exchange__SingleValue_Invalid,KEL.typ.int Connect_Date__SingleValue_Invalid,KEL.typ.int Utility_Type__SingleValue_Invalid,KEL.typ.int Record_Date__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(__d0)},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UtilityID',COUNT(__d0(__NL(Utility_I_D_))),COUNT(__d0(__NN(Utility_I_D_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateAddedToExchange',COUNT(__d0(__NL(Date_Added_To_Exchange_))),COUNT(__d0(__NN(Date_Added_To_Exchange_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ConnectDate',COUNT(__d0(__NL(Connect_Date_))),COUNT(__d0(__NN(Connect_Date_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UtilityType',COUNT(__d0(__NL(Utility_Type_))),COUNT(__d0(__NN(Utility_Type_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecordDate',COUNT(__d0(__NL(Record_Date_))),COUNT(__d0(__NN(Record_Date_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Utility','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
