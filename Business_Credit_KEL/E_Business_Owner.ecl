//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT Business_Credit_KEL;
IMPORT CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT E_Business_Owner(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr _sbfe__contributor__number_;
    KEL.typ.nstr _contract__account__number_;
    KEL.typ.nint _account__type__reported_;
    KEL.typ.nkdate _dt__first__seen_;
    KEL.typ.nkdate _dt__last__seen_;
    KEL.typ.nkdate _dt__vendor__first__reported_;
    KEL.typ.nkdate _dt__vendor__last__reported_;
    KEL.typ.nkdate _dt__datawarehouse__first__reported_;
    KEL.typ.nkdate _dt__datawarehouse__last__reported_;
    KEL.typ.nstr _business__name_;
    KEL.typ.nstr _web__address_;
    KEL.typ.nint _guarantor__owner__indicator_;
    KEL.typ.nunk _relationship__to__business__indicator_;
    KEL.typ.nint _percent__of__liability_;
    KEL.typ.nint _percent__of__ownership__if__owner__principal_;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'seq_num(DEFAULT:UID),sbfe_contributor_number(DEFAULT:_sbfe__contributor__number_:\'\'),contract_account_number(DEFAULT:_contract__account__number_:\'\'),account_type_reported(DEFAULT:_account__type__reported_:0),dt_first_seen(DEFAULT:_dt__first__seen_:DATE),dt_last_seen(DEFAULT:_dt__last__seen_:DATE),dt_vendor_first_reported(DEFAULT:_dt__vendor__first__reported_:DATE),dt_vendor_last_reported(DEFAULT:_dt__vendor__last__reported_:DATE),dt_datawarehouse_first_reported(DEFAULT:_dt__datawarehouse__first__reported_:DATE),dt_datawarehouse_last_reported(DEFAULT:_dt__datawarehouse__last__reported_:DATE),business_name(DEFAULT:_business__name_:\'\'),web_address(DEFAULT:_web__address_:\'\'),guarantor_owner_indicator(DEFAULT:_guarantor__owner__indicator_:0),relationship_to_business_indicator(DEFAULT:_relationship__to__business__indicator_:\'\'),percent_of_liability(DEFAULT:_percent__of__liability_:\'\'),percent_of_ownership_if_owner_principal(DEFAULT:_percent__of__ownership__if__owner__principal_:\'\')';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.BusinessOwner,TRANSFORM(RECORDOF(__in.BusinessOwner),SELF:=RIGHT));
  EXPORT Business_Credit_KEL_File_SBFE_temp_BusinessOwner_Invalid := __d0_Norm((KEL.typ.uid)seq_num = 0);
  SHARED __d0_Prefiltered := __d0_Norm((KEL.typ.uid)seq_num <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping,'Business_Credit_KEL.File_SBFE_temp'));
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr _sbfe__contributor__number_;
    KEL.typ.nstr _contract__account__number_;
    KEL.typ.nint _account__type__reported_;
    KEL.typ.nkdate _dt__first__seen_;
    KEL.typ.nkdate _dt__last__seen_;
    KEL.typ.nkdate _dt__vendor__first__reported_;
    KEL.typ.nkdate _dt__vendor__last__reported_;
    KEL.typ.nkdate _dt__datawarehouse__first__reported_;
    KEL.typ.nkdate _dt__datawarehouse__last__reported_;
    KEL.typ.nstr _business__name_;
    KEL.typ.nstr _web__address_;
    KEL.typ.nint _guarantor__owner__indicator_;
    KEL.typ.nunk _relationship__to__business__indicator_;
    KEL.typ.nint _percent__of__liability_;
    KEL.typ.nint _percent__of__ownership__if__owner__principal_;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Business_Owner_Group := __PostFilter;
  Layout Business_Owner__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF._sbfe__contributor__number_ := KEL.Intake.SingleValue(__recs,_sbfe__contributor__number_);
    SELF._contract__account__number_ := KEL.Intake.SingleValue(__recs,_contract__account__number_);
    SELF._account__type__reported_ := KEL.Intake.SingleValue(__recs,_account__type__reported_);
    SELF._dt__first__seen_ := KEL.Intake.SingleValue(__recs,_dt__first__seen_);
    SELF._dt__last__seen_ := KEL.Intake.SingleValue(__recs,_dt__last__seen_);
    SELF._dt__vendor__first__reported_ := KEL.Intake.SingleValue(__recs,_dt__vendor__first__reported_);
    SELF._dt__vendor__last__reported_ := KEL.Intake.SingleValue(__recs,_dt__vendor__last__reported_);
    SELF._dt__datawarehouse__first__reported_ := KEL.Intake.SingleValue(__recs,_dt__datawarehouse__first__reported_);
    SELF._dt__datawarehouse__last__reported_ := KEL.Intake.SingleValue(__recs,_dt__datawarehouse__last__reported_);
    SELF._business__name_ := KEL.Intake.SingleValue(__recs,_business__name_);
    SELF._web__address_ := KEL.Intake.SingleValue(__recs,_web__address_);
    SELF._guarantor__owner__indicator_ := KEL.Intake.SingleValue(__recs,_guarantor__owner__indicator_);
    SELF._relationship__to__business__indicator_ := KEL.Intake.SingleValue(__recs,_relationship__to__business__indicator_);
    SELF._percent__of__liability_ := KEL.Intake.SingleValue(__recs,_percent__of__liability_);
    SELF._percent__of__ownership__if__owner__principal_ := KEL.Intake.SingleValue(__recs,_percent__of__ownership__if__owner__principal_);
    SELF.__RecordCount := COUNT(__recs);
    SELF := __r;
  END;
  Layout Business_Owner__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Business_Owner_Group,COUNT(ROWS(LEFT))=1),GROUP,Business_Owner__Single_Rollup(LEFT)) + ROLLUP(HAVING(Business_Owner_Group,COUNT(ROWS(LEFT))>1),GROUP,Business_Owner__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT _sbfe__contributor__number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_sbfe__contributor__number_);
  EXPORT _contract__account__number__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_contract__account__number_);
  EXPORT _account__type__reported__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_account__type__reported_);
  EXPORT _dt__first__seen__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_dt__first__seen_);
  EXPORT _dt__last__seen__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_dt__last__seen_);
  EXPORT _dt__vendor__first__reported__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_dt__vendor__first__reported_);
  EXPORT _dt__vendor__last__reported__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_dt__vendor__last__reported_);
  EXPORT _dt__datawarehouse__first__reported__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_dt__datawarehouse__first__reported_);
  EXPORT _dt__datawarehouse__last__reported__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_dt__datawarehouse__last__reported_);
  EXPORT _business__name__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_business__name_);
  EXPORT _web__address__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_web__address_);
  EXPORT _guarantor__owner__indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_guarantor__owner__indicator_);
  EXPORT _relationship__to__business__indicator__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_relationship__to__business__indicator_);
  EXPORT _percent__of__liability__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_percent__of__liability_);
  EXPORT _percent__of__ownership__if__owner__principal__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_percent__of__ownership__if__owner__principal_);
  EXPORT SanityCheck := DATASET([{COUNT(Business_Credit_KEL_File_SBFE_temp_BusinessOwner_Invalid),COUNT(_sbfe__contributor__number__SingleValue_Invalid),COUNT(_contract__account__number__SingleValue_Invalid),COUNT(_account__type__reported__SingleValue_Invalid),COUNT(_dt__first__seen__SingleValue_Invalid),COUNT(_dt__last__seen__SingleValue_Invalid),COUNT(_dt__vendor__first__reported__SingleValue_Invalid),COUNT(_dt__vendor__last__reported__SingleValue_Invalid),COUNT(_dt__datawarehouse__first__reported__SingleValue_Invalid),COUNT(_dt__datawarehouse__last__reported__SingleValue_Invalid),COUNT(_business__name__SingleValue_Invalid),COUNT(_web__address__SingleValue_Invalid),COUNT(_guarantor__owner__indicator__SingleValue_Invalid),COUNT(_relationship__to__business__indicator__SingleValue_Invalid),COUNT(_percent__of__liability__SingleValue_Invalid),COUNT(_percent__of__ownership__if__owner__principal__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int Business_Credit_KEL_File_SBFE_temp_BusinessOwner_Invalid,KEL.typ.int _sbfe__contributor__number__SingleValue_Invalid,KEL.typ.int _contract__account__number__SingleValue_Invalid,KEL.typ.int _account__type__reported__SingleValue_Invalid,KEL.typ.int _dt__first__seen__SingleValue_Invalid,KEL.typ.int _dt__last__seen__SingleValue_Invalid,KEL.typ.int _dt__vendor__first__reported__SingleValue_Invalid,KEL.typ.int _dt__vendor__last__reported__SingleValue_Invalid,KEL.typ.int _dt__datawarehouse__first__reported__SingleValue_Invalid,KEL.typ.int _dt__datawarehouse__last__reported__SingleValue_Invalid,KEL.typ.int _business__name__SingleValue_Invalid,KEL.typ.int _web__address__SingleValue_Invalid,KEL.typ.int _guarantor__owner__indicator__SingleValue_Invalid,KEL.typ.int _relationship__to__business__indicator__SingleValue_Invalid,KEL.typ.int _percent__of__liability__SingleValue_Invalid,KEL.typ.int _percent__of__ownership__if__owner__principal__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'BusinessOwner','Business_Credit_KEL.File_SBFE_temp','UID',COUNT(Business_Credit_KEL_File_SBFE_temp_BusinessOwner_Invalid),COUNT(__d0)},
    {'BusinessOwner','Business_Credit_KEL.File_SBFE_temp','sbfe_contributor_number',COUNT(__d0(__NL(_sbfe__contributor__number_))),COUNT(__d0(__NN(_sbfe__contributor__number_)))},
    {'BusinessOwner','Business_Credit_KEL.File_SBFE_temp','contract_account_number',COUNT(__d0(__NL(_contract__account__number_))),COUNT(__d0(__NN(_contract__account__number_)))},
    {'BusinessOwner','Business_Credit_KEL.File_SBFE_temp','account_type_reported',COUNT(__d0(__NL(_account__type__reported_))),COUNT(__d0(__NN(_account__type__reported_)))},
    {'BusinessOwner','Business_Credit_KEL.File_SBFE_temp','dt_first_seen',COUNT(__d0(__NL(_dt__first__seen_))),COUNT(__d0(__NN(_dt__first__seen_)))},
    {'BusinessOwner','Business_Credit_KEL.File_SBFE_temp','dt_last_seen',COUNT(__d0(__NL(_dt__last__seen_))),COUNT(__d0(__NN(_dt__last__seen_)))},
    {'BusinessOwner','Business_Credit_KEL.File_SBFE_temp','dt_vendor_first_reported',COUNT(__d0(__NL(_dt__vendor__first__reported_))),COUNT(__d0(__NN(_dt__vendor__first__reported_)))},
    {'BusinessOwner','Business_Credit_KEL.File_SBFE_temp','dt_vendor_last_reported',COUNT(__d0(__NL(_dt__vendor__last__reported_))),COUNT(__d0(__NN(_dt__vendor__last__reported_)))},
    {'BusinessOwner','Business_Credit_KEL.File_SBFE_temp','dt_datawarehouse_first_reported',COUNT(__d0(__NL(_dt__datawarehouse__first__reported_))),COUNT(__d0(__NN(_dt__datawarehouse__first__reported_)))},
    {'BusinessOwner','Business_Credit_KEL.File_SBFE_temp','dt_datawarehouse_last_reported',COUNT(__d0(__NL(_dt__datawarehouse__last__reported_))),COUNT(__d0(__NN(_dt__datawarehouse__last__reported_)))},
    {'BusinessOwner','Business_Credit_KEL.File_SBFE_temp','business_name',COUNT(__d0(__NL(_business__name_))),COUNT(__d0(__NN(_business__name_)))},
    {'BusinessOwner','Business_Credit_KEL.File_SBFE_temp','web_address',COUNT(__d0(__NL(_web__address_))),COUNT(__d0(__NN(_web__address_)))},
    {'BusinessOwner','Business_Credit_KEL.File_SBFE_temp','guarantor_owner_indicator',COUNT(__d0(__NL(_guarantor__owner__indicator_))),COUNT(__d0(__NN(_guarantor__owner__indicator_)))},
    {'BusinessOwner','Business_Credit_KEL.File_SBFE_temp','relationship_to_business_indicator',COUNT(__d0(__NL(_relationship__to__business__indicator_))),COUNT(__d0(__NN(_relationship__to__business__indicator_)))},
    {'BusinessOwner','Business_Credit_KEL.File_SBFE_temp','percent_of_liability',COUNT(__d0(__NL(_percent__of__liability_))),COUNT(__d0(__NN(_percent__of__liability_)))},
    {'BusinessOwner','Business_Credit_KEL.File_SBFE_temp','percent_of_ownership_if_owner_principal',COUNT(__d0(__NL(_percent__of__ownership__if__owner__principal_))),COUNT(__d0(__NN(_percent__of__ownership__if__owner__principal_)))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
