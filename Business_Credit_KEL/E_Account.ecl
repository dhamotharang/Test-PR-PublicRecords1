//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT Business_Credit_KEL;
IMPORT CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT E_Account(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nunk _seq_;
    KEL.typ.nunk _ultid_;
    KEL.typ.nunk _orgid_;
    KEL.typ.nunk _seleid_;
    KEL.typ.nunk _proxid_;
    KEL.typ.nunk _powid_;
    KEL.typ.nunk _empid_;
    KEL.typ.nunk _dotid_;
    KEL.typ.nunk _ultscore_;
    KEL.typ.nunk _orgscore_;
    KEL.typ.nunk _selescore_;
    KEL.typ.nunk _proxscore_;
    KEL.typ.nunk _powscore_;
    KEL.typ.nunk _empscore_;
    KEL.typ.nunk _dotscore_;
    KEL.typ.nunk _ultweight_;
    KEL.typ.nunk _orgweight_;
    KEL.typ.nunk _seleweight_;
    KEL.typ.nunk _proxweight_;
    KEL.typ.nunk _powweight_;
    KEL.typ.nunk _empweight_;
    KEL.typ.nunk _dotweight_;
    KEL.typ.nkdate _dt__first__seen_;
    KEL.typ.nkdate _dt__last__seen_;
    KEL.typ.nkdate _dt__vendor__first__reported_;
    KEL.typ.nkdate _dt__vendor__last__reported_;
    KEL.typ.nkdate _dt__datawarehouse__first__reported_;
    KEL.typ.nkdate _dt__datawarehouse__last__reported_;
    KEL.typ.nunk _did_;
    KEL.typ.nunk _did__score_;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'acct_no(DEFAULT:UID),seq(DEFAULT:_seq_:\'\'),ultid(DEFAULT:_ultid_:\'\'),orgid(DEFAULT:_orgid_:\'\'),seleid(DEFAULT:_seleid_:\'\'),proxid(DEFAULT:_proxid_:\'\'),powid(DEFAULT:_powid_:\'\'),empid(DEFAULT:_empid_:\'\'),dotid(DEFAULT:_dotid_:\'\'),ultscore(DEFAULT:_ultscore_:\'\'),orgscore(DEFAULT:_orgscore_:\'\'),selescore(DEFAULT:_selescore_:\'\'),proxscore(DEFAULT:_proxscore_:\'\'),powscore(DEFAULT:_powscore_:\'\'),empscore(DEFAULT:_empscore_:\'\'),dotscore(DEFAULT:_dotscore_:\'\'),ultweight(DEFAULT:_ultweight_:\'\'),orgweight(DEFAULT:_orgweight_:\'\'),seleweight(DEFAULT:_seleweight_:\'\'),proxweight(DEFAULT:_proxweight_:\'\'),powweight(DEFAULT:_powweight_:\'\'),empweight(DEFAULT:_empweight_:\'\'),dotweight(DEFAULT:_dotweight_:\'\'),dt_first_seen(DEFAULT:_dt__first__seen_:DATE),dt_last_seen(DEFAULT:_dt__last__seen_:DATE),dt_vendor_first_reported(DEFAULT:_dt__vendor__first__reported_:DATE),dt_vendor_last_reported(DEFAULT:_dt__vendor__last__reported_:DATE),dt_datawarehouse_first_reported(DEFAULT:_dt__datawarehouse__first__reported_:DATE),dt_datawarehouse_last_reported(DEFAULT:_dt__datawarehouse__last__reported_:DATE),did(DEFAULT:_did_:\'\'),did_score(DEFAULT:_did__score_:\'\')';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Linkids,TRANSFORM(RECORDOF(__in.Linkids),SELF:=RIGHT));
  EXPORT Business_Credit_KEL_File_SBFE_temp_Linkids_Invalid := __d0_Norm((KEL.typ.uid)acct_no = 0);
  SHARED __d0_Prefiltered := __d0_Norm((KEL.typ.uid)acct_no <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping,'Business_Credit_KEL.File_SBFE_temp'));
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nunk _seq_;
    KEL.typ.nunk _ultid_;
    KEL.typ.nunk _orgid_;
    KEL.typ.nunk _seleid_;
    KEL.typ.nunk _proxid_;
    KEL.typ.nunk _powid_;
    KEL.typ.nunk _empid_;
    KEL.typ.nunk _dotid_;
    KEL.typ.nunk _ultscore_;
    KEL.typ.nunk _orgscore_;
    KEL.typ.nunk _selescore_;
    KEL.typ.nunk _proxscore_;
    KEL.typ.nunk _powscore_;
    KEL.typ.nunk _empscore_;
    KEL.typ.nunk _dotscore_;
    KEL.typ.nunk _ultweight_;
    KEL.typ.nunk _orgweight_;
    KEL.typ.nunk _seleweight_;
    KEL.typ.nunk _proxweight_;
    KEL.typ.nunk _powweight_;
    KEL.typ.nunk _empweight_;
    KEL.typ.nunk _dotweight_;
    KEL.typ.nkdate _dt__first__seen_;
    KEL.typ.nkdate _dt__last__seen_;
    KEL.typ.nkdate _dt__vendor__first__reported_;
    KEL.typ.nkdate _dt__vendor__last__reported_;
    KEL.typ.nkdate _dt__datawarehouse__first__reported_;
    KEL.typ.nkdate _dt__datawarehouse__last__reported_;
    KEL.typ.nunk _did_;
    KEL.typ.nunk _did__score_;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Account_Group := __PostFilter;
  Layout Account__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF._seq_ := KEL.Intake.SingleValue(__recs,_seq_);
    SELF._ultid_ := KEL.Intake.SingleValue(__recs,_ultid_);
    SELF._orgid_ := KEL.Intake.SingleValue(__recs,_orgid_);
    SELF._seleid_ := KEL.Intake.SingleValue(__recs,_seleid_);
    SELF._proxid_ := KEL.Intake.SingleValue(__recs,_proxid_);
    SELF._powid_ := KEL.Intake.SingleValue(__recs,_powid_);
    SELF._empid_ := KEL.Intake.SingleValue(__recs,_empid_);
    SELF._dotid_ := KEL.Intake.SingleValue(__recs,_dotid_);
    SELF._ultscore_ := KEL.Intake.SingleValue(__recs,_ultscore_);
    SELF._orgscore_ := KEL.Intake.SingleValue(__recs,_orgscore_);
    SELF._selescore_ := KEL.Intake.SingleValue(__recs,_selescore_);
    SELF._proxscore_ := KEL.Intake.SingleValue(__recs,_proxscore_);
    SELF._powscore_ := KEL.Intake.SingleValue(__recs,_powscore_);
    SELF._empscore_ := KEL.Intake.SingleValue(__recs,_empscore_);
    SELF._dotscore_ := KEL.Intake.SingleValue(__recs,_dotscore_);
    SELF._ultweight_ := KEL.Intake.SingleValue(__recs,_ultweight_);
    SELF._orgweight_ := KEL.Intake.SingleValue(__recs,_orgweight_);
    SELF._seleweight_ := KEL.Intake.SingleValue(__recs,_seleweight_);
    SELF._proxweight_ := KEL.Intake.SingleValue(__recs,_proxweight_);
    SELF._powweight_ := KEL.Intake.SingleValue(__recs,_powweight_);
    SELF._empweight_ := KEL.Intake.SingleValue(__recs,_empweight_);
    SELF._dotweight_ := KEL.Intake.SingleValue(__recs,_dotweight_);
    SELF._dt__first__seen_ := KEL.Intake.SingleValue(__recs,_dt__first__seen_);
    SELF._dt__last__seen_ := KEL.Intake.SingleValue(__recs,_dt__last__seen_);
    SELF._dt__vendor__first__reported_ := KEL.Intake.SingleValue(__recs,_dt__vendor__first__reported_);
    SELF._dt__vendor__last__reported_ := KEL.Intake.SingleValue(__recs,_dt__vendor__last__reported_);
    SELF._dt__datawarehouse__first__reported_ := KEL.Intake.SingleValue(__recs,_dt__datawarehouse__first__reported_);
    SELF._dt__datawarehouse__last__reported_ := KEL.Intake.SingleValue(__recs,_dt__datawarehouse__last__reported_);
    SELF._did_ := KEL.Intake.SingleValue(__recs,_did_);
    SELF._did__score_ := KEL.Intake.SingleValue(__recs,_did__score_);
    SELF.__RecordCount := COUNT(__recs);
    SELF := __r;
  END;
  Layout Account__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Account_Group,COUNT(ROWS(LEFT))=1),GROUP,Account__Single_Rollup(LEFT)) + ROLLUP(HAVING(Account_Group,COUNT(ROWS(LEFT))>1),GROUP,Account__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT _seq__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_seq_);
  EXPORT _ultid__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_ultid_);
  EXPORT _orgid__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_orgid_);
  EXPORT _seleid__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_seleid_);
  EXPORT _proxid__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_proxid_);
  EXPORT _powid__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_powid_);
  EXPORT _empid__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_empid_);
  EXPORT _dotid__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_dotid_);
  EXPORT _ultscore__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_ultscore_);
  EXPORT _orgscore__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_orgscore_);
  EXPORT _selescore__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_selescore_);
  EXPORT _proxscore__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_proxscore_);
  EXPORT _powscore__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_powscore_);
  EXPORT _empscore__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_empscore_);
  EXPORT _dotscore__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_dotscore_);
  EXPORT _ultweight__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_ultweight_);
  EXPORT _orgweight__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_orgweight_);
  EXPORT _seleweight__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_seleweight_);
  EXPORT _proxweight__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_proxweight_);
  EXPORT _powweight__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_powweight_);
  EXPORT _empweight__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_empweight_);
  EXPORT _dotweight__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_dotweight_);
  EXPORT _dt__first__seen__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_dt__first__seen_);
  EXPORT _dt__last__seen__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_dt__last__seen_);
  EXPORT _dt__vendor__first__reported__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_dt__vendor__first__reported_);
  EXPORT _dt__vendor__last__reported__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_dt__vendor__last__reported_);
  EXPORT _dt__datawarehouse__first__reported__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_dt__datawarehouse__first__reported_);
  EXPORT _dt__datawarehouse__last__reported__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_dt__datawarehouse__last__reported_);
  EXPORT _did__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_did_);
  EXPORT _did__score__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,_did__score_);
  EXPORT SanityCheck := DATASET([{COUNT(Business_Credit_KEL_File_SBFE_temp_Linkids_Invalid),COUNT(_seq__SingleValue_Invalid),COUNT(_ultid__SingleValue_Invalid),COUNT(_orgid__SingleValue_Invalid),COUNT(_seleid__SingleValue_Invalid),COUNT(_proxid__SingleValue_Invalid),COUNT(_powid__SingleValue_Invalid),COUNT(_empid__SingleValue_Invalid),COUNT(_dotid__SingleValue_Invalid),COUNT(_ultscore__SingleValue_Invalid),COUNT(_orgscore__SingleValue_Invalid),COUNT(_selescore__SingleValue_Invalid),COUNT(_proxscore__SingleValue_Invalid),COUNT(_powscore__SingleValue_Invalid),COUNT(_empscore__SingleValue_Invalid),COUNT(_dotscore__SingleValue_Invalid),COUNT(_ultweight__SingleValue_Invalid),COUNT(_orgweight__SingleValue_Invalid),COUNT(_seleweight__SingleValue_Invalid),COUNT(_proxweight__SingleValue_Invalid),COUNT(_powweight__SingleValue_Invalid),COUNT(_empweight__SingleValue_Invalid),COUNT(_dotweight__SingleValue_Invalid),COUNT(_dt__first__seen__SingleValue_Invalid),COUNT(_dt__last__seen__SingleValue_Invalid),COUNT(_dt__vendor__first__reported__SingleValue_Invalid),COUNT(_dt__vendor__last__reported__SingleValue_Invalid),COUNT(_dt__datawarehouse__first__reported__SingleValue_Invalid),COUNT(_dt__datawarehouse__last__reported__SingleValue_Invalid),COUNT(_did__SingleValue_Invalid),COUNT(_did__score__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int Business_Credit_KEL_File_SBFE_temp_Linkids_Invalid,KEL.typ.int _seq__SingleValue_Invalid,KEL.typ.int _ultid__SingleValue_Invalid,KEL.typ.int _orgid__SingleValue_Invalid,KEL.typ.int _seleid__SingleValue_Invalid,KEL.typ.int _proxid__SingleValue_Invalid,KEL.typ.int _powid__SingleValue_Invalid,KEL.typ.int _empid__SingleValue_Invalid,KEL.typ.int _dotid__SingleValue_Invalid,KEL.typ.int _ultscore__SingleValue_Invalid,KEL.typ.int _orgscore__SingleValue_Invalid,KEL.typ.int _selescore__SingleValue_Invalid,KEL.typ.int _proxscore__SingleValue_Invalid,KEL.typ.int _powscore__SingleValue_Invalid,KEL.typ.int _empscore__SingleValue_Invalid,KEL.typ.int _dotscore__SingleValue_Invalid,KEL.typ.int _ultweight__SingleValue_Invalid,KEL.typ.int _orgweight__SingleValue_Invalid,KEL.typ.int _seleweight__SingleValue_Invalid,KEL.typ.int _proxweight__SingleValue_Invalid,KEL.typ.int _powweight__SingleValue_Invalid,KEL.typ.int _empweight__SingleValue_Invalid,KEL.typ.int _dotweight__SingleValue_Invalid,KEL.typ.int _dt__first__seen__SingleValue_Invalid,KEL.typ.int _dt__last__seen__SingleValue_Invalid,KEL.typ.int _dt__vendor__first__reported__SingleValue_Invalid,KEL.typ.int _dt__vendor__last__reported__SingleValue_Invalid,KEL.typ.int _dt__datawarehouse__first__reported__SingleValue_Invalid,KEL.typ.int _dt__datawarehouse__last__reported__SingleValue_Invalid,KEL.typ.int _did__SingleValue_Invalid,KEL.typ.int _did__score__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Account','Business_Credit_KEL.File_SBFE_temp','UID',COUNT(Business_Credit_KEL_File_SBFE_temp_Linkids_Invalid),COUNT(__d0)},
    {'Account','Business_Credit_KEL.File_SBFE_temp','seq',COUNT(__d0(__NL(_seq_))),COUNT(__d0(__NN(_seq_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','ultid',COUNT(__d0(__NL(_ultid_))),COUNT(__d0(__NN(_ultid_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','orgid',COUNT(__d0(__NL(_orgid_))),COUNT(__d0(__NN(_orgid_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','seleid',COUNT(__d0(__NL(_seleid_))),COUNT(__d0(__NN(_seleid_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','proxid',COUNT(__d0(__NL(_proxid_))),COUNT(__d0(__NN(_proxid_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','powid',COUNT(__d0(__NL(_powid_))),COUNT(__d0(__NN(_powid_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','empid',COUNT(__d0(__NL(_empid_))),COUNT(__d0(__NN(_empid_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','dotid',COUNT(__d0(__NL(_dotid_))),COUNT(__d0(__NN(_dotid_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','ultscore',COUNT(__d0(__NL(_ultscore_))),COUNT(__d0(__NN(_ultscore_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','orgscore',COUNT(__d0(__NL(_orgscore_))),COUNT(__d0(__NN(_orgscore_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','selescore',COUNT(__d0(__NL(_selescore_))),COUNT(__d0(__NN(_selescore_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','proxscore',COUNT(__d0(__NL(_proxscore_))),COUNT(__d0(__NN(_proxscore_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','powscore',COUNT(__d0(__NL(_powscore_))),COUNT(__d0(__NN(_powscore_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','empscore',COUNT(__d0(__NL(_empscore_))),COUNT(__d0(__NN(_empscore_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','dotscore',COUNT(__d0(__NL(_dotscore_))),COUNT(__d0(__NN(_dotscore_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','ultweight',COUNT(__d0(__NL(_ultweight_))),COUNT(__d0(__NN(_ultweight_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','orgweight',COUNT(__d0(__NL(_orgweight_))),COUNT(__d0(__NN(_orgweight_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','seleweight',COUNT(__d0(__NL(_seleweight_))),COUNT(__d0(__NN(_seleweight_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','proxweight',COUNT(__d0(__NL(_proxweight_))),COUNT(__d0(__NN(_proxweight_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','powweight',COUNT(__d0(__NL(_powweight_))),COUNT(__d0(__NN(_powweight_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','empweight',COUNT(__d0(__NL(_empweight_))),COUNT(__d0(__NN(_empweight_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','dotweight',COUNT(__d0(__NL(_dotweight_))),COUNT(__d0(__NN(_dotweight_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','dt_first_seen',COUNT(__d0(__NL(_dt__first__seen_))),COUNT(__d0(__NN(_dt__first__seen_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','dt_last_seen',COUNT(__d0(__NL(_dt__last__seen_))),COUNT(__d0(__NN(_dt__last__seen_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','dt_vendor_first_reported',COUNT(__d0(__NL(_dt__vendor__first__reported_))),COUNT(__d0(__NN(_dt__vendor__first__reported_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','dt_vendor_last_reported',COUNT(__d0(__NL(_dt__vendor__last__reported_))),COUNT(__d0(__NN(_dt__vendor__last__reported_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','dt_datawarehouse_first_reported',COUNT(__d0(__NL(_dt__datawarehouse__first__reported_))),COUNT(__d0(__NN(_dt__datawarehouse__first__reported_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','dt_datawarehouse_last_reported',COUNT(__d0(__NL(_dt__datawarehouse__last__reported_))),COUNT(__d0(__NN(_dt__datawarehouse__last__reported_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','did',COUNT(__d0(__NL(_did_))),COUNT(__d0(__NN(_did_)))},
    {'Account','Business_Credit_KEL.File_SBFE_temp','did_score',COUNT(__d0(__NL(_did__score_))),COUNT(__d0(__NN(_did__score_)))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
