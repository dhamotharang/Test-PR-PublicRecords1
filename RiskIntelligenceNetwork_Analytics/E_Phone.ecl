//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Phone := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    UNSIGNED4 __Part := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'phonenumber(DEFAULT:UID|DEFAULT:Phone_Number_:\'\'),phoneformatted(DEFAULT:Phone_Formatted_:\'\'),iscellphone(DEFAULT:_is_Cell_Phone_)';
  EXPORT VIRTUAL DATASET(InLayout) InData := DATASET([],InLayout);
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone_Formatted_;
    KEL.typ.nstr Phone_Number_;
    KEL.typ.nbool _is_Cell_Phone_;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,__Part,LOCAL,ALL));
  Phone_Group := __PostFilter;
  Layout Phone__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Phone_Formatted_ := KEL.Intake.SingleValue(__recs,Phone_Formatted_);
    SELF.Phone_Number_ := KEL.Intake.SingleValue(__recs,Phone_Number_);
    SELF._is_Cell_Phone_ := KEL.Intake.SingleValue(__recs,_is_Cell_Phone_);
    SELF.__RecordCount := COUNT(__recs);
    SELF := __r;
  END;
  Layout Phone__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Phone_Group,COUNT(ROWS(LEFT))=1),GROUP,Phone__Single_Rollup(LEFT)) + ROLLUP(HAVING(Phone_Group,COUNT(ROWS(LEFT))>1),GROUP,Phone__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Phone_Formatted__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Phone_Formatted_);
  EXPORT Phone_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Phone_Number_);
  EXPORT _is_Cell_Phone__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_is_Cell_Phone_);
  EXPORT SanityCheck := DATASET([{COUNT(Phone_Formatted__SingleValue_Invalid),COUNT(Phone_Number__SingleValue_Invalid),COUNT(_is_Cell_Phone__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int Phone_Formatted__SingleValue_Invalid,KEL.typ.int Phone_Number__SingleValue_Invalid,KEL.typ.int _is_Cell_Phone__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    ]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
