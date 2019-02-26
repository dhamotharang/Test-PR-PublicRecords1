//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Email(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr User_Name_;
    KEL.typ.nstr Domain_Name_;
    KEL.typ.nstr Domain_Type_;
    KEL.typ.nstr Domain_Root_;
    KEL.typ.nstr Domain_Extension_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'UID(UID),clean_email(Email_Address_:\'\'),append_email_username(User_Name_:\'\'),append_domain(Domain_Name_:\'\'),append_domain_type(Domain_Type_:\'\'),append_domain_root(Domain_Root_:\'\'),append_domain_ext(Domain_Extension_:\'\'),email_src(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(__in,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.clean_email)));
  EXPORT __All_Trim := __d0_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED __SortedTable := SORT(__Table,KeyVal);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__SortedTable,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT));
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.ECL_Functions.Dataset_FDC);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(__in,Lookup,TRIM((STRING)LEFT.clean_email) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),HASH);
  EXPORT PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
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
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr User_Name_;
    KEL.typ.nstr Domain_Name_;
    KEL.typ.nstr Domain_Type_;
    KEL.typ.nstr Domain_Root_;
    KEL.typ.nstr Domain_Extension_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Email_Group := __PostFilter;
  Layout Email__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Email_Address_ := KEL.Intake.SingleValue(__recs,Email_Address_);
    SELF.User_Name_ := KEL.Intake.SingleValue(__recs,User_Name_);
    SELF.Domain_Name_ := KEL.Intake.SingleValue(__recs,Domain_Name_);
    SELF.Domain_Type_ := KEL.Intake.SingleValue(__recs,Domain_Type_);
    SELF.Domain_Root_ := KEL.Intake.SingleValue(__recs,Domain_Root_);
    SELF.Domain_Extension_ := KEL.Intake.SingleValue(__recs,Domain_Extension_);
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Email__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Email_Group,COUNT(ROWS(LEFT))=1),GROUP,Email__Single_Rollup(LEFT)) + ROLLUP(HAVING(Email_Group,COUNT(ROWS(LEFT))>1),GROUP,Email__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Email_Address__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Email_Address_);
  EXPORT User_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,User_Name_);
  EXPORT Domain_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Domain_Name_);
  EXPORT Domain_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Domain_Type_);
  EXPORT Domain_Root__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Domain_Root_);
  EXPORT Domain_Extension__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Domain_Extension_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(Email_Address__SingleValue_Invalid),COUNT(User_Name__SingleValue_Invalid),COUNT(Domain_Name__SingleValue_Invalid),COUNT(Domain_Type__SingleValue_Invalid),COUNT(Domain_Root__SingleValue_Invalid),COUNT(Domain_Extension__SingleValue_Invalid)}],{KEL.typ.int PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid,KEL.typ.int Email_Address__SingleValue_Invalid,KEL.typ.int User_Name__SingleValue_Invalid,KEL.typ.int Domain_Name__SingleValue_Invalid,KEL.typ.int Domain_Type__SingleValue_Invalid,KEL.typ.int Domain_Root__SingleValue_Invalid,KEL.typ.int Domain_Extension__SingleValue_Invalid});
  EXPORT NullCounts := DATASET([
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','UID',COUNT(PublicRecords_KEL_ECL_Functions_Dataset_FDC_Invalid),COUNT(__d0)},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','clean_email',COUNT(__d0(__NL(Email_Address_))),COUNT(__d0(__NN(Email_Address_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_email_username',COUNT(__d0(__NL(User_Name_))),COUNT(__d0(__NN(User_Name_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_domain',COUNT(__d0(__NL(Domain_Name_))),COUNT(__d0(__NN(Domain_Name_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_domain_type',COUNT(__d0(__NL(Domain_Type_))),COUNT(__d0(__NN(Domain_Type_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_domain_root',COUNT(__d0(__NL(Domain_Root_))),COUNT(__d0(__NN(Domain_Root_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','append_domain_ext',COUNT(__d0(__NL(Domain_Extension_))),COUNT(__d0(__NN(Domain_Extension_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','email_src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Email','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
