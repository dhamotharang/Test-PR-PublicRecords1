//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Employment(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Job_Title_;
    KEL.typ.nstr Internal_Source_Score_;
    KEL.typ.nstr From_H_D_R_;
    KEL.typ.nstr Old_Internal_Source_Score_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr G_L_B_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'contact_id(UID),jobtitle(Job_Title_:\'\'),internalsourcescore(Internal_Source_Score_:\'\'),fromhdr(From_H_D_R_:\'\'),oldinternalsourcescore(Old_Internal_Source_Score_:\'\'),source(Source_:\'\'),glb(G_L_B_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid := __in((KEL.typ.uid)contact_id = 0);
  SHARED __d0_Prefiltered := __in((KEL.typ.uid)contact_id <> 0);
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
    KEL.typ.nstr Job_Title_;
    KEL.typ.nstr Internal_Source_Score_;
    KEL.typ.nstr From_H_D_R_;
    KEL.typ.nstr Old_Internal_Source_Score_;
    KEL.typ.nstr G_L_B_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Employment_Group := __PostFilter;
  Layout Employment__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Job_Title_ := KEL.Intake.SingleValue(__recs,Job_Title_);
    SELF.Internal_Source_Score_ := KEL.Intake.SingleValue(__recs,Internal_Source_Score_);
    SELF.From_H_D_R_ := KEL.Intake.SingleValue(__recs,From_H_D_R_);
    SELF.Old_Internal_Source_Score_ := KEL.Intake.SingleValue(__recs,Old_Internal_Source_Score_);
    SELF.G_L_B_ := KEL.Intake.SingleValue(__recs,G_L_B_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Employment__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Employment_Group,COUNT(ROWS(LEFT))=1),GROUP,Employment__Single_Rollup(LEFT)) + ROLLUP(HAVING(Employment_Group,COUNT(ROWS(LEFT))>1),GROUP,Employment__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Job_Title__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Job_Title_);
  EXPORT Internal_Source_Score__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Internal_Source_Score_);
  EXPORT From_H_D_R__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,From_H_D_R_);
  EXPORT Old_Internal_Source_Score__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Old_Internal_Source_Score_);
  EXPORT G_L_B__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,G_L_B_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(Job_Title__SingleValue_Invalid),COUNT(Internal_Source_Score__SingleValue_Invalid),COUNT(From_H_D_R__SingleValue_Invalid),COUNT(Old_Internal_Source_Score__SingleValue_Invalid),COUNT(G_L_B__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid,KEL.typ.int Job_Title__SingleValue_Invalid,KEL.typ.int Internal_Source_Score__SingleValue_Invalid,KEL.typ.int From_H_D_R__SingleValue_Invalid,KEL.typ.int Old_Internal_Source_Score__SingleValue_Invalid,KEL.typ.int G_L_B__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Employment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(__d0)},
    {'Employment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','JobTitle',COUNT(__d0(__NL(Job_Title_))),COUNT(__d0(__NN(Job_Title_)))},
    {'Employment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','InternalSourceScore',COUNT(__d0(__NL(Internal_Source_Score_))),COUNT(__d0(__NN(Internal_Source_Score_)))},
    {'Employment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','FromHDR',COUNT(__d0(__NL(From_H_D_R_))),COUNT(__d0(__NN(From_H_D_R_)))},
    {'Employment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','OldInternalSourceScore',COUNT(__d0(__NL(Old_Internal_Source_Score_))),COUNT(__d0(__NN(Old_Internal_Source_Score_)))},
    {'Employment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Employment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','GLB',COUNT(__d0(__NL(G_L_B_))),COUNT(__d0(__NN(G_L_B_)))},
    {'Employment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Employment','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
