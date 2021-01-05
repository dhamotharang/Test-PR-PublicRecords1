﻿//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT Business_Credit_KEL;
IMPORT CFG_graph,E_Account,E_Tradeline FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT E_Account_Tradeline(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Account().Typ) _acc_;
    KEL.typ.ntyp(E_Tradeline().Typ) _trade_;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'acct_no(DEFAULT:_acc_:0),seq_num(DEFAULT:_trade_:0)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Tradelines,TRANSFORM(RECORDOF(__in.Tradelines),SELF:=RIGHT));
  SHARED __d0_Prefiltered := __d0_Norm;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping,'Business_Credit_KEL.File_SBFE_temp'));
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Account().Typ) _acc_;
    KEL.typ.ntyp(E_Tradeline().Typ) _trade_;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PreResult := PROJECT(TABLE(InData,{KEL.typ.int __RecordCount := COUNT(GROUP),_acc_,_trade_},_acc_,_trade_,MERGE),Layout);
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _acc__Orphan := JOIN(InData(__NN(_acc_)),E_Account(__in,__cfg).__Result,__EEQP(LEFT._acc_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _trade__Orphan := JOIN(InData(__NN(_trade_)),E_Tradeline(__in,__cfg).__Result,__EEQP(LEFT._trade_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_acc__Orphan),COUNT(_trade__Orphan)}],{KEL.typ.int _acc__Orphan,KEL.typ.int _trade__Orphan});
  EXPORT NullCounts := DATASET([
    {'AccountTradeline','Business_Credit_KEL.File_SBFE_temp','acct_no',COUNT(__d0(__NL(_acc_))),COUNT(__d0(__NN(_acc_)))},
    {'AccountTradeline','Business_Credit_KEL.File_SBFE_temp','seq_num',COUNT(__d0(__NL(_trade_))),COUNT(__d0(__NN(_trade_)))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
