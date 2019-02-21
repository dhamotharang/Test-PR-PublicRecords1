//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Education(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr College_Name_;
    KEL.typ.nstr Tier_;
    KEL.typ.nstr Tier2_;
    KEL.typ.nstr School_Size_Code_;
    KEL.typ.nstr File_Type_;
    KEL.typ.nstr College_Major_;
    KEL.typ.nstr College_Class_;
    KEL.typ.nstr Class_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr Rec_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'key(UID),collegename(College_Name_:\'\'),tier(Tier_:\'\'),tier2(Tier2_:\'\'),schoolsizecode(School_Size_Code_:\'\'),filetype(File_Type_:\'\'),collegemajor(College_Major_:\'\'),collegeclass(College_Class_:\'\'),class(Class_:\'\'),source(Source_:\'\'),rectype(Rec_Type_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid := __in((KEL.typ.uid)Key = 0);
  SHARED __d0_Prefiltered := __in((KEL.typ.uid)Key <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
  EXPORT File_Types_Layout := RECORD
    KEL.typ.nstr File_Type_;
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
    KEL.typ.ndataset(File_Types_Layout) File_Types_;
    KEL.typ.nstr College_Name_;
    KEL.typ.nstr Tier_;
    KEL.typ.nstr Tier2_;
    KEL.typ.nstr School_Size_Code_;
    KEL.typ.nstr College_Major_;
    KEL.typ.nstr College_Class_;
    KEL.typ.nstr Class_;
    KEL.typ.nstr Rec_Type_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Education_Group := __PostFilter;
  Layout Education__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.File_Types_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),File_Type_},File_Type_),File_Types_Layout)(__NN(File_Type_)));
    SELF.College_Name_ := KEL.Intake.SingleValue(__recs,College_Name_);
    SELF.Tier_ := KEL.Intake.SingleValue(__recs,Tier_);
    SELF.Tier2_ := KEL.Intake.SingleValue(__recs,Tier2_);
    SELF.School_Size_Code_ := KEL.Intake.SingleValue(__recs,School_Size_Code_);
    SELF.College_Major_ := KEL.Intake.SingleValue(__recs,College_Major_);
    SELF.College_Class_ := KEL.Intake.SingleValue(__recs,College_Class_);
    SELF.Class_ := KEL.Intake.SingleValue(__recs,Class_);
    SELF.Rec_Type_ := KEL.Intake.SingleValue(__recs,Rec_Type_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Education__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.File_Types_ := __CN(PROJECT(DATASET(__r),TRANSFORM(File_Types_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(File_Type_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Education_Group,COUNT(ROWS(LEFT))=1),GROUP,Education__Single_Rollup(LEFT)) + ROLLUP(HAVING(Education_Group,COUNT(ROWS(LEFT))>1),GROUP,Education__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::PublicRecords_KEL::Education::Result' + IF(__cfg.PersistId <> '','::' + __cfg.PersistId,''),EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT College_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,College_Name_);
  EXPORT Tier__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Tier_);
  EXPORT Tier2__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Tier2_);
  EXPORT School_Size_Code__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,School_Size_Code_);
  EXPORT College_Major__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,College_Major_);
  EXPORT College_Class__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,College_Class_);
  EXPORT Class__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Class_);
  EXPORT Rec_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Rec_Type_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(College_Name__SingleValue_Invalid),COUNT(Tier__SingleValue_Invalid),COUNT(Tier2__SingleValue_Invalid),COUNT(School_Size_Code__SingleValue_Invalid),COUNT(College_Major__SingleValue_Invalid),COUNT(College_Class__SingleValue_Invalid),COUNT(Class__SingleValue_Invalid),COUNT(Rec_Type__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid,KEL.typ.int College_Name__SingleValue_Invalid,KEL.typ.int Tier__SingleValue_Invalid,KEL.typ.int Tier2__SingleValue_Invalid,KEL.typ.int School_Size_Code__SingleValue_Invalid,KEL.typ.int College_Major__SingleValue_Invalid,KEL.typ.int College_Class__SingleValue_Invalid,KEL.typ.int Class__SingleValue_Invalid,KEL.typ.int Rec_Type__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(__d0)},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeName',COUNT(__d0(__NL(College_Name_))),COUNT(__d0(__NN(College_Name_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Tier',COUNT(__d0(__NL(Tier_))),COUNT(__d0(__NN(Tier_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Tier2',COUNT(__d0(__NL(Tier2_))),COUNT(__d0(__NN(Tier2_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','SchoolSizeCode',COUNT(__d0(__NL(School_Size_Code_))),COUNT(__d0(__NN(School_Size_Code_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FileType',COUNT(__d0(__NL(File_Type_))),COUNT(__d0(__NN(File_Type_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeMajor',COUNT(__d0(__NL(College_Major_))),COUNT(__d0(__NN(College_Major_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CollegeClass',COUNT(__d0(__NL(College_Class_))),COUNT(__d0(__NN(College_Class_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Class',COUNT(__d0(__NL(Class_))),COUNT(__d0(__NN(Class_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RecType',COUNT(__d0(__NL(Rec_Type_))),COUNT(__d0(__NN(Rec_Type_)))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Education','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
