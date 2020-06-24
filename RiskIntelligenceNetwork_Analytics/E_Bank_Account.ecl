//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT E_Bank FROM RiskIntelligenceNetwork_Analytics;
IMPORT * FROM KEL11.Null;
EXPORT E_Bank_Account := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nstr Otto_Bank_Account_Id_;
    UNSIGNED4 __Part := 0;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'ottobankaccountid(DEFAULT:UID|DEFAULT:Otto_Bank_Account_Id_:\'\'),routingnumber(DEFAULT:_r_Bank_:0),accountnumber(DEFAULT:Account_Number_:\'\')';
  EXPORT VIRTUAL DATASET(InLayout) InData := DATASET([],InLayout);
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Bank.Typ) _r_Bank_;
    KEL.typ.nstr Account_Number_;
    KEL.typ.nstr Otto_Bank_Account_Id_;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,__Part,LOCAL,ALL));
  Bank_Account_Group := __PostFilter;
  Layout Bank_Account__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF._r_Bank_ := KEL.Intake.SingleValue(__recs,_r_Bank_);
    SELF.Account_Number_ := KEL.Intake.SingleValue(__recs,Account_Number_);
    SELF.Otto_Bank_Account_Id_ := KEL.Intake.SingleValue(__recs,Otto_Bank_Account_Id_);
    SELF.__RecordCount := COUNT(__recs);
    SELF := __r;
  END;
  Layout Bank_Account__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Bank_Account_Group,COUNT(ROWS(LEFT))=1),GROUP,Bank_Account__Single_Rollup(LEFT)) + ROLLUP(HAVING(Bank_Account_Group,COUNT(ROWS(LEFT))>1),GROUP,Bank_Account__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT _r_Bank__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,_r_Bank_);
  EXPORT Account_Number__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Account_Number_);
  EXPORT Otto_Bank_Account_Id__SingleValue_Invalid := KEL.Intake.DetectMultipleValues(__PreResult,Otto_Bank_Account_Id_);
  EXPORT _r_Bank__Orphan := JOIN(InData(__NN(_r_Bank_)),E_Bank.__Result,__EEQP(LEFT._r_Bank_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_r_Bank__Orphan),COUNT(_r_Bank__SingleValue_Invalid),COUNT(Account_Number__SingleValue_Invalid),COUNT(Otto_Bank_Account_Id__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int _r_Bank__Orphan,KEL.typ.int _r_Bank__SingleValue_Invalid,KEL.typ.int Account_Number__SingleValue_Invalid,KEL.typ.int Otto_Bank_Account_Id__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    ]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
