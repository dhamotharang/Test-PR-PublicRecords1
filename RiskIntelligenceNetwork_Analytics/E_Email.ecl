//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Email := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Host_;
    KEL.typ.nstr Email_Last_Domain_;
    KEL.typ.nint _isdisposableemail_;
    UNSIGNED4 __Part := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'ottoemailid(DEFAULT:UID),emailaddress(DEFAULT:Email_Address_:\'\'),host(DEFAULT:Host_:\'\'),emaillastdomain(DEFAULT:Email_Last_Domain_:\'\'),isdisposableemail(DEFAULT:_isdisposableemail_:0)';
  EXPORT VIRTUAL DATASET(InLayout) InData := DATASET([],InLayout);
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Email_Address_;
    KEL.typ.nstr Host_;
    KEL.typ.nstr Email_Last_Domain_;
    KEL.typ.nint _isdisposableemail_;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,__Part,LOCAL,ALL));
  Email_Group := __PostFilter;
  Layout Email__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Email_Address_ := KEL.Intake.SingleValue(__recs,Email_Address_);
    SELF.Host_ := KEL.Intake.SingleValue(__recs,Host_);
    SELF.Email_Last_Domain_ := KEL.Intake.SingleValue(__recs,Email_Last_Domain_);
    SELF._isdisposableemail_ := KEL.Intake.SingleValue(__recs,_isdisposableemail_);
    SELF.__RecordCount := COUNT(__recs);
    SELF := __r;
  END;
  Layout Email__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Email_Group,COUNT(ROWS(LEFT))=1),GROUP,Email__Single_Rollup(LEFT)) + ROLLUP(HAVING(Email_Group,COUNT(ROWS(LEFT))>1),GROUP,Email__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Email_Address__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Email_Address_);
  EXPORT Host__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Host_);
  EXPORT Email_Last_Domain__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Email_Last_Domain_);
  EXPORT _isdisposableemail__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_isdisposableemail_);
  EXPORT SanityCheck := DATASET([{COUNT(Email_Address__SingleValue_Invalid),COUNT(Host__SingleValue_Invalid),COUNT(Email_Last_Domain__SingleValue_Invalid),COUNT(_isdisposableemail__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int Email_Address__SingleValue_Invalid,KEL.typ.int Host__SingleValue_Invalid,KEL.typ.int Email_Last_Domain__SingleValue_Invalid,KEL.typ.int _isdisposableemail__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    ]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
