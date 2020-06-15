//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT * FROM KEL11.Null;
EXPORT E_Bank := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Routing_Number_;
    KEL.typ.nstr Full_Bankname_;
    KEL.typ.nstr Abbreviated_Bankname_;
    KEL.typ.nstr Fractional_Routingnumber_;
    KEL.typ.nstr Headoffice_Routingnumber_;
    KEL.typ.nstr Headoffice_Branchcodes_;
    KEL.typ.nstr _hit_;
    UNSIGNED4 __Part := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'routingnumber(DEFAULT:UID|DEFAULT:Routing_Number_:\'\'),fullbankname(DEFAULT:Full_Bankname_:\'\'),abbreviatedbankname(DEFAULT:Abbreviated_Bankname_:\'\'),fractionalroutingnumber(DEFAULT:Fractional_Routingnumber_:\'\'),headofficeroutingnumber(DEFAULT:Headoffice_Routingnumber_:\'\'),headofficebranchcodes(DEFAULT:Headoffice_Branchcodes_:\'\'),hit(DEFAULT:_hit_:\'\')';
  EXPORT VIRTUAL DATASET(InLayout) InData := DATASET([],InLayout);
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Routing_Number_;
    KEL.typ.nstr Full_Bankname_;
    KEL.typ.nstr Abbreviated_Bankname_;
    KEL.typ.nstr Fractional_Routingnumber_;
    KEL.typ.nstr Headoffice_Routingnumber_;
    KEL.typ.nstr Headoffice_Branchcodes_;
    KEL.typ.nstr _hit_;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,__Part,LOCAL,ALL));
  Bank_Group := __PostFilter;
  Layout Bank__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Routing_Number_ := KEL.Intake.SingleValue(__recs,Routing_Number_);
    SELF.Full_Bankname_ := KEL.Intake.SingleValue(__recs,Full_Bankname_);
    SELF.Abbreviated_Bankname_ := KEL.Intake.SingleValue(__recs,Abbreviated_Bankname_);
    SELF.Fractional_Routingnumber_ := KEL.Intake.SingleValue(__recs,Fractional_Routingnumber_);
    SELF.Headoffice_Routingnumber_ := KEL.Intake.SingleValue(__recs,Headoffice_Routingnumber_);
    SELF.Headoffice_Branchcodes_ := KEL.Intake.SingleValue(__recs,Headoffice_Branchcodes_);
    SELF._hit_ := KEL.Intake.SingleValue(__recs,_hit_);
    SELF.__RecordCount := COUNT(__recs);
    SELF := __r;
  END;
  Layout Bank__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Bank_Group,COUNT(ROWS(LEFT))=1),GROUP,Bank__Single_Rollup(LEFT)) + ROLLUP(HAVING(Bank_Group,COUNT(ROWS(LEFT))>1),GROUP,Bank__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Routing_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Routing_Number_);
  EXPORT Full_Bankname__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Full_Bankname_);
  EXPORT Abbreviated_Bankname__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Abbreviated_Bankname_);
  EXPORT Fractional_Routingnumber__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Fractional_Routingnumber_);
  EXPORT Headoffice_Routingnumber__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Headoffice_Routingnumber_);
  EXPORT Headoffice_Branchcodes__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Headoffice_Branchcodes_);
  EXPORT _hit__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_hit_);
  EXPORT SanityCheck := DATASET([{COUNT(Routing_Number__SingleValue_Invalid),COUNT(Full_Bankname__SingleValue_Invalid),COUNT(Abbreviated_Bankname__SingleValue_Invalid),COUNT(Fractional_Routingnumber__SingleValue_Invalid),COUNT(Headoffice_Routingnumber__SingleValue_Invalid),COUNT(Headoffice_Branchcodes__SingleValue_Invalid),COUNT(_hit__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int Routing_Number__SingleValue_Invalid,KEL.typ.int Full_Bankname__SingleValue_Invalid,KEL.typ.int Abbreviated_Bankname__SingleValue_Invalid,KEL.typ.int Fractional_Routingnumber__SingleValue_Invalid,KEL.typ.int Headoffice_Routingnumber__SingleValue_Invalid,KEL.typ.int Headoffice_Branchcodes__SingleValue_Invalid,KEL.typ.int _hit__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    ]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
