//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Business,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Tradeline_Business(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Business().Typ) Company_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Company_(Company_:0),Account_(Account_:0),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'Company_(Company_:0),Account_(Account_:0),source(Source_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH),dt_last_seen(Date_Last_Seen_:EPOCH),DPMBitmap(__Permits:PERMITS)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Cortera_Tradeline__Key_LinkIds,TRANSFORM(RECORDOF(__in.Dataset_Cortera_Tradeline__Key_LinkIds),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm(status != 'D');
  SHARED __d0_Company__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Company_;
  END;
  SHARED __d0_Company__Mapped := JOIN(__d0_KELfiltered,E_Business(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) = RIGHT.KeyVal,TRANSFORM(__d0_Company__Layout,SELF.Company_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Account__Layout := RECORD
    RECORDOF(__d0_Company__Mapped);
    KEL.typ.uid Account_;
  END;
  SHARED __d0_Account__Mapped := JOIN(__d0_Company__Mapped,E_Tradeline(__in,__cfg).Lookup,TRIM((STRING)LEFT.ultid) + '|' + TRIM((STRING)LEFT.orgid) + '|' + TRIM((STRING)LEFT.seleid) + '|' + TRIM((STRING)LEFT.account_key) = RIGHT.KeyVal,TRANSFORM(__d0_Account__Layout,SELF.Account_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Account__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) Company_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Company_,Account_,ALL));
  Tradeline_Business_Group := __PostFilter;
  Layout Tradeline_Business__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Tradeline_Business__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Tradeline_Business_Group,COUNT(ROWS(LEFT))=1),GROUP,Tradeline_Business__Single_Rollup(LEFT)) + ROLLUP(HAVING(Tradeline_Business_Group,COUNT(ROWS(LEFT))>1),GROUP,Tradeline_Business__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Company__Orphan := JOIN(InData(__NN(Company_)),E_Business(__in,__cfg).__Result,__EEQP(LEFT.Company_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Account__Orphan := JOIN(InData(__NN(Account_)),E_Tradeline(__in,__cfg).__Result,__EEQP(LEFT.Account_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Company__Orphan),COUNT(Account__Orphan)}],{KEL.typ.int Company__Orphan,KEL.typ.int Account__Orphan});
  EXPORT NullCounts := DATASET([
    {'TradelineBusiness','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Company',COUNT(__d0(__NL(Company_))),COUNT(__d0(__NN(Company_)))},
    {'TradelineBusiness','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Account',COUNT(__d0(__NL(Account_))),COUNT(__d0(__NN(Account_)))},
    {'TradelineBusiness','PublicRecords_KEL.ECL_Functions.Dataset_FDC','source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'TradelineBusiness','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'TradelineBusiness','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
