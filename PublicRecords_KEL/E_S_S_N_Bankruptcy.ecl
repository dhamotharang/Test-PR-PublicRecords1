﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Bankruptcy,E_Social_Security_Number FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_S_S_N_Bankruptcy(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'social(Social_:0),Bankrupt_(Bankrupt_:0),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'ssn(Social_:0),Bankrupt_(Bankrupt_:0),date_first_seen(Date_First_Seen_:EPOCH),date_last_seen(Date_Last_Seen_:EPOCH),DPMBitmap(__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('BA');
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Bankruptcy_Files__Key_Search,TRANSFORM(RECORDOF(__in.Dataset_Bankruptcy_Files__Key_Search),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)ssn != 0);
  SHARED __d0_Bankrupt__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Bankrupt_;
  END;
  SHARED __d0_Bankrupt__Mapped := JOIN(__d0_KELfiltered,E_Bankruptcy(__in,__cfg).Lookup,TRIM((STRING)LEFT.TMSID) + '|' + TRIM((STRING)LEFT.Court_Code) + '|' + TRIM((STRING)LEFT.Case_Number) + '|' + TRIM((STRING)LEFT.DID) = RIGHT.KeyVal,TRANSFORM(__d0_Bankrupt__Layout,SELF.Bankrupt_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Bankrupt__Mapped;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0),__Mapping0_Transform(LEFT)));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ntyp(E_Bankruptcy().Typ) Bankrupt_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Social_,Bankrupt_,ALL));
  S_S_N_Bankruptcy_Group := __PostFilter;
  Layout S_S_N_Bankruptcy__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout S_S_N_Bankruptcy__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(S_S_N_Bankruptcy_Group,COUNT(ROWS(LEFT))=1),GROUP,S_S_N_Bankruptcy__Single_Rollup(LEFT)) + ROLLUP(HAVING(S_S_N_Bankruptcy_Group,COUNT(ROWS(LEFT))>1),GROUP,S_S_N_Bankruptcy__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Social__Orphan := JOIN(InData(__NN(Social_)),E_Social_Security_Number(__in,__cfg).__Result,__EEQP(LEFT.Social_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Bankrupt__Orphan := JOIN(InData(__NN(Bankrupt_)),E_Bankruptcy(__in,__cfg).__Result,__EEQP(LEFT.Bankrupt_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Social__Orphan),COUNT(Bankrupt__Orphan)}],{KEL.typ.int Social__Orphan,KEL.typ.int Bankrupt__Orphan});
  EXPORT NullCounts := DATASET([
    {'SSNBankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d0(__NL(Social_))),COUNT(__d0(__NN(Social_)))},
    {'SSNBankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Bankrupt',COUNT(__d0(__NL(Bankrupt_))),COUNT(__d0(__NN(Bankrupt_)))},
    {'SSNBankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'SSNBankruptcy','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
