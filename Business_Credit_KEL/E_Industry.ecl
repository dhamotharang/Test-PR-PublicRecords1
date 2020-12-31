//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT Business_Credit_KEL;
IMPORT CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT E_Industry(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint _record__type_;
    KEL.typ.nstr _sbfe__contributor__number_;
    KEL.typ.nunk _contract__account__number_;
    KEL.typ.nkdate _dt__first__seen_;
    KEL.typ.nkdate _dt__last__seen_;
    KEL.typ.nint _classification__code__type_;
    KEL.typ.nint _classification__code_;
    KEL.typ.nstr _primary__industry__code__indicator_;
    KEL.typ.nstr _privacy__indicator_;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'seq_num(DEFAULT:UID),record_type(DEFAULT:_record__type_:0),sbfe_contributor_number(DEFAULT:_sbfe__contributor__number_:\'\'),contract_account_number(DEFAULT:_contract__account__number_:\'\'),dt_first_seen(DEFAULT:_dt__first__seen_:DATE),dt_last_seen(DEFAULT:_dt__last__seen_:DATE),classification_code_type(DEFAULT:_classification__code__type_:0),classification_code(DEFAULT:_classification__code_:0),primary_industry_code_indicator(DEFAULT:_primary__industry__code__indicator_:\'\'),privacy_indicator(DEFAULT:_privacy__indicator_:\'\')';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.BusinessClassification,TRANSFORM(RECORDOF(__in.BusinessClassification),SELF:=RIGHT));
  EXPORT Business_Credit_KEL_File_SBFE_temp_BusinessClassification_Invalid := __d0_Norm((KEL.typ.uid)seq_num = 0);
  SHARED __d0_Prefiltered := __d0_Norm((KEL.typ.uid)seq_num <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping,'Business_Credit_KEL.File_SBFE_temp'));
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint _record__type_;
    KEL.typ.nstr _sbfe__contributor__number_;
    KEL.typ.nunk _contract__account__number_;
    KEL.typ.nkdate _dt__first__seen_;
    KEL.typ.nkdate _dt__last__seen_;
    KEL.typ.nint _classification__code__type_;
    KEL.typ.nint _classification__code_;
    KEL.typ.nstr _primary__industry__code__indicator_;
    KEL.typ.nstr _privacy__indicator_;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Industry_Group := __PostFilter;
  Layout Industry__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF._record__type_ := KEL.Intake.SingleValue(__recs,_record__type_);
    SELF._sbfe__contributor__number_ := KEL.Intake.SingleValue(__recs,_sbfe__contributor__number_);
    SELF._contract__account__number_ := KEL.Intake.SingleValue(__recs,_contract__account__number_);
    SELF._dt__first__seen_ := KEL.Intake.SingleValue(__recs,_dt__first__seen_);
    SELF._dt__last__seen_ := KEL.Intake.SingleValue(__recs,_dt__last__seen_);
    SELF._classification__code__type_ := KEL.Intake.SingleValue(__recs,_classification__code__type_);
    SELF._classification__code_ := KEL.Intake.SingleValue(__recs,_classification__code_);
    SELF._primary__industry__code__indicator_ := KEL.Intake.SingleValue(__recs,_primary__industry__code__indicator_);
    SELF._privacy__indicator_ := KEL.Intake.SingleValue(__recs,_privacy__indicator_);
    SELF.__RecordCount := COUNT(__recs);
    SELF := __r;
  END;
  Layout Industry__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Industry_Group,COUNT(ROWS(LEFT))=1),GROUP,Industry__Single_Rollup(LEFT)) + ROLLUP(HAVING(Industry_Group,COUNT(ROWS(LEFT))>1),GROUP,Industry__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT _record__type__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_record__type_);
  EXPORT _sbfe__contributor__number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_sbfe__contributor__number_);
  EXPORT _contract__account__number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_contract__account__number_);
  EXPORT _dt__first__seen__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_dt__first__seen_);
  EXPORT _dt__last__seen__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_dt__last__seen_);
  EXPORT _classification__code__type__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_classification__code__type_);
  EXPORT _classification__code__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_classification__code_);
  EXPORT _primary__industry__code__indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_primary__industry__code__indicator_);
  EXPORT _privacy__indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_privacy__indicator_);
  EXPORT SanityCheck := DATASET([{COUNT(Business_Credit_KEL_File_SBFE_temp_BusinessClassification_Invalid),COUNT(_record__type__SingleValue_Invalid),COUNT(_sbfe__contributor__number__SingleValue_Invalid),COUNT(_contract__account__number__SingleValue_Invalid),COUNT(_dt__first__seen__SingleValue_Invalid),COUNT(_dt__last__seen__SingleValue_Invalid),COUNT(_classification__code__type__SingleValue_Invalid),COUNT(_classification__code__SingleValue_Invalid),COUNT(_primary__industry__code__indicator__SingleValue_Invalid),COUNT(_privacy__indicator__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int Business_Credit_KEL_File_SBFE_temp_BusinessClassification_Invalid,KEL.typ.int _record__type__SingleValue_Invalid,KEL.typ.int _sbfe__contributor__number__SingleValue_Invalid,KEL.typ.int _contract__account__number__SingleValue_Invalid,KEL.typ.int _dt__first__seen__SingleValue_Invalid,KEL.typ.int _dt__last__seen__SingleValue_Invalid,KEL.typ.int _classification__code__type__SingleValue_Invalid,KEL.typ.int _classification__code__SingleValue_Invalid,KEL.typ.int _primary__industry__code__indicator__SingleValue_Invalid,KEL.typ.int _privacy__indicator__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Industry','Business_Credit_KEL.File_SBFE_temp','UID',COUNT(Business_Credit_KEL_File_SBFE_temp_BusinessClassification_Invalid),COUNT(__d0)},
    {'Industry','Business_Credit_KEL.File_SBFE_temp','record_type',COUNT(__d0(__NL(_record__type_))),COUNT(__d0(__NN(_record__type_)))},
    {'Industry','Business_Credit_KEL.File_SBFE_temp','sbfe_contributor_number',COUNT(__d0(__NL(_sbfe__contributor__number_))),COUNT(__d0(__NN(_sbfe__contributor__number_)))},
    {'Industry','Business_Credit_KEL.File_SBFE_temp','contract_account_number',COUNT(__d0(__NL(_contract__account__number_))),COUNT(__d0(__NN(_contract__account__number_)))},
    {'Industry','Business_Credit_KEL.File_SBFE_temp','dt_first_seen',COUNT(__d0(__NL(_dt__first__seen_))),COUNT(__d0(__NN(_dt__first__seen_)))},
    {'Industry','Business_Credit_KEL.File_SBFE_temp','dt_last_seen',COUNT(__d0(__NL(_dt__last__seen_))),COUNT(__d0(__NN(_dt__last__seen_)))},
    {'Industry','Business_Credit_KEL.File_SBFE_temp','classification_code_type',COUNT(__d0(__NL(_classification__code__type_))),COUNT(__d0(__NN(_classification__code__type_)))},
    {'Industry','Business_Credit_KEL.File_SBFE_temp','classification_code',COUNT(__d0(__NL(_classification__code_))),COUNT(__d0(__NN(_classification__code_)))},
    {'Industry','Business_Credit_KEL.File_SBFE_temp','primary_industry_code_indicator',COUNT(__d0(__NL(_primary__industry__code__indicator_))),COUNT(__d0(__NN(_primary__industry__code__indicator_)))},
    {'Industry','Business_Credit_KEL.File_SBFE_temp','privacy_indicator',COUNT(__d0(__NL(_privacy__indicator_))),COUNT(__d0(__NN(_privacy__indicator_)))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
