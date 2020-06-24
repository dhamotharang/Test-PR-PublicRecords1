//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Customer := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nstr Jurisdiction_State_;
    UNSIGNED4 __Part := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'gc_id(DEFAULT:UID),customerid(DEFAULT:Customer_Id_:0),industrytype(DEFAULT:Industry_Type_:0),jurisdictionstate(DEFAULT:Jurisdiction_State_:\'\')';
  EXPORT VIRTUAL DATASET(InLayout) InData := DATASET([],InLayout);
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Customer_Id_;
    KEL.typ.nint Industry_Type_;
    KEL.typ.nstr Jurisdiction_State_;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,__Part,LOCAL,ALL));
  Customer_Group := __PostFilter;
  Layout Customer__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Customer_Id_ := KEL.Intake.SingleValue(__recs,Customer_Id_);
    SELF.Industry_Type_ := KEL.Intake.SingleValue(__recs,Industry_Type_);
    SELF.Jurisdiction_State_ := KEL.Intake.SingleValue(__recs,Jurisdiction_State_);
    SELF.__RecordCount := COUNT(__recs);
    SELF := __r;
  END;
  Layout Customer__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Customer_Group,COUNT(ROWS(LEFT))=1),GROUP,Customer__Single_Rollup(LEFT)) + ROLLUP(HAVING(Customer_Group,COUNT(ROWS(LEFT))>1),GROUP,Customer__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Customer_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Customer_Id_);
  EXPORT Industry_Type__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Industry_Type_);
  EXPORT Jurisdiction_State__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Jurisdiction_State_);
  EXPORT SanityCheck := DATASET([{COUNT(Customer_Id__SingleValue_Invalid),COUNT(Industry_Type__SingleValue_Invalid),COUNT(Jurisdiction_State__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int Customer_Id__SingleValue_Invalid,KEL.typ.int Industry_Type__SingleValue_Invalid,KEL.typ.int Jurisdiction_State__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    ]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
