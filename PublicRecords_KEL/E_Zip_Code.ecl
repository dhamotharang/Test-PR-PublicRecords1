//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Zip_Code(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Zip_Class_;
    KEL.typ.nstr City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr County_;
    KEL.typ.nstr City_Name_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'zip5(UID),zipclass(Zip_Class_:\'\'),city(City_:\'\'),state(State_:\'\'),county(County_:\'\'),cityname(City_Name_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'zip(UID),zipclass(Zip_Class_:\'\'),city(City_:\'\'),state(State_:\'\'),county(County_:\'\'),cityname(City_Name_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED3)zip !=0);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid := __d0_KELfiltered((KEL.typ.uid)zip = 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered((KEL.typ.uid)zip <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Zip_Class_;
    KEL.typ.nstr City_;
    KEL.typ.nstr State_;
    KEL.typ.nstr County_;
    KEL.typ.nstr City_Name_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Zip_Code_Group := __PostFilter;
  Layout Zip_Code__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Zip_Class_ := KEL.Intake.SingleValue(__recs,Zip_Class_);
    SELF.City_ := KEL.Intake.SingleValue(__recs,City_);
    SELF.State_ := KEL.Intake.SingleValue(__recs,State_);
    SELF.County_ := KEL.Intake.SingleValue(__recs,County_);
    SELF.City_Name_ := KEL.Intake.SingleValue(__recs,City_Name_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Zip_Code__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Zip_Code_Group,COUNT(ROWS(LEFT))=1),GROUP,Zip_Code__Single_Rollup(LEFT)) + ROLLUP(HAVING(Zip_Code_Group,COUNT(ROWS(LEFT))>1),GROUP,Zip_Code__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Zip_Class__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Zip_Class_);
  EXPORT City__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,City_);
  EXPORT State__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,State_);
  EXPORT County__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,County_);
  EXPORT City_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,City_Name_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid),COUNT(Zip_Class__SingleValue_Invalid),COUNT(City__SingleValue_Invalid),COUNT(State__SingleValue_Invalid),COUNT(County__SingleValue_Invalid),COUNT(City_Name__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid,KEL.typ.int Zip_Class__SingleValue_Invalid,KEL.typ.int City__SingleValue_Invalid,KEL.typ.int State__SingleValue_Invalid,KEL.typ.int County__SingleValue_Invalid,KEL.typ.int City_Name__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'ZipCode','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Dataset_Doxie__Key_Header_Invalid),COUNT(__d0)},
    {'ZipCode','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ZipClass',COUNT(__d0(__NL(Zip_Class_))),COUNT(__d0(__NN(Zip_Class_)))},
    {'ZipCode','PublicRecords_KEL.ECL_Functions.Dataset_FDC','City',COUNT(__d0(__NL(City_))),COUNT(__d0(__NN(City_)))},
    {'ZipCode','PublicRecords_KEL.ECL_Functions.Dataset_FDC','State',COUNT(__d0(__NL(State_))),COUNT(__d0(__NN(State_)))},
    {'ZipCode','PublicRecords_KEL.ECL_Functions.Dataset_FDC','County',COUNT(__d0(__NL(County_))),COUNT(__d0(__NN(County_)))},
    {'ZipCode','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CityName',COUNT(__d0(__NL(City_Name_))),COUNT(__d0(__NN(City_Name_)))},
    {'ZipCode','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'ZipCode','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'ZipCode','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
