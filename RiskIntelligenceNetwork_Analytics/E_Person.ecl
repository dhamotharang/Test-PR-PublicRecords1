//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Person := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Lex_Id_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Ssn_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Title_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Middle_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Name_Suffix_;
    UNSIGNED4 __Part := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'lexid(DEFAULT:UID|DEFAULT:Lex_Id_:0),dateofbirth(DEFAULT:Date_Of_Birth_:DATE),ssn(DEFAULT:Ssn_:\'\'),emailaddress(DEFAULT:Email_Address_:\'\'),title(DEFAULT:Title_),firstname(DEFAULT:First_Name_),middlename(DEFAULT:Middle_Name_),lastname(DEFAULT:Last_Name_),namesuffix(DEFAULT:Name_Suffix_)';
  EXPORT VIRTUAL DATASET(InLayout) InData := DATASET([],InLayout);
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Lex_Id_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Ssn_;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Title_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Middle_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Name_Suffix_;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,__Part,LOCAL,ALL));
  Person_Group := __PostFilter;
  Layout Person__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Lex_Id_ := KEL.Intake.SingleValue(__recs,Lex_Id_);
    SELF.Date_Of_Birth_ := KEL.Intake.SingleValue(__recs,Date_Of_Birth_);
    SELF.Ssn_ := KEL.Intake.SingleValue(__recs,Ssn_);
    SELF.Email_Address_ := KEL.Intake.SingleValue(__recs,Email_Address_);
    SELF.Title_ := KEL.Intake.SingleValue(__recs,Title_);
    SELF.First_Name_ := KEL.Intake.SingleValue(__recs,First_Name_);
    SELF.Middle_Name_ := KEL.Intake.SingleValue(__recs,Middle_Name_);
    SELF.Last_Name_ := KEL.Intake.SingleValue(__recs,Last_Name_);
    SELF.Name_Suffix_ := KEL.Intake.SingleValue(__recs,Name_Suffix_);
    SELF.__RecordCount := COUNT(__recs);
    SELF := __r;
  END;
  Layout Person__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Group,COUNT(ROWS(LEFT))=1),GROUP,Person__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Group,COUNT(ROWS(LEFT))>1),GROUP,Person__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Lex_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Lex_Id_);
  EXPORT Date_Of_Birth__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Date_Of_Birth_);
  EXPORT Ssn__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Ssn_);
  EXPORT Email_Address__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Email_Address_);
  EXPORT Title__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Title_);
  EXPORT First_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,First_Name_);
  EXPORT Middle_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Middle_Name_);
  EXPORT Last_Name__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Last_Name_);
  EXPORT Name_Suffix__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Name_Suffix_);
  EXPORT SanityCheck := DATASET([{COUNT(Lex_Id__SingleValue_Invalid),COUNT(Date_Of_Birth__SingleValue_Invalid),COUNT(Ssn__SingleValue_Invalid),COUNT(Email_Address__SingleValue_Invalid),COUNT(Title__SingleValue_Invalid),COUNT(First_Name__SingleValue_Invalid),COUNT(Middle_Name__SingleValue_Invalid),COUNT(Last_Name__SingleValue_Invalid),COUNT(Name_Suffix__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int Lex_Id__SingleValue_Invalid,KEL.typ.int Date_Of_Birth__SingleValue_Invalid,KEL.typ.int Ssn__SingleValue_Invalid,KEL.typ.int Email_Address__SingleValue_Invalid,KEL.typ.int Title__SingleValue_Invalid,KEL.typ.int First_Name__SingleValue_Invalid,KEL.typ.int Middle_Name__SingleValue_Invalid,KEL.typ.int Last_Name__SingleValue_Invalid,KEL.typ.int Name_Suffix__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    ]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
