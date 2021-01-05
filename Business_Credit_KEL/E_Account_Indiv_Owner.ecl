//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT Business_Credit_KEL;
IMPORT CFG_graph,E_Account,E_Individual_Owner FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT E_Account_Indiv_Owner(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Account().Typ) _acc_;
    KEL.typ.ntyp(E_Individual_Owner().Typ) _owner_;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'acct_no(DEFAULT:_acc_:0),seq_num(DEFAULT:_owner_:0)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.IndividualOwner,TRANSFORM(RECORDOF(__in.IndividualOwner),SELF:=RIGHT));
  SHARED __d0_Prefiltered := __d0_Norm;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping,'Business_Credit_KEL.File_SBFE_temp'));
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Account().Typ) _acc_;
    KEL.typ.ntyp(E_Individual_Owner().Typ) _owner_;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PreResult := PROJECT(TABLE(InData,{KEL.typ.int __RecordCount := COUNT(GROUP),_acc_,_owner_},_acc_,_owner_,MERGE),Layout);
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT _acc__Orphan := JOIN(InData(__NN(_acc_)),E_Account(__in,__cfg).__Result,__EEQP(LEFT._acc_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT _owner__Orphan := JOIN(InData(__NN(_owner_)),E_Individual_Owner(__in,__cfg).__Result,__EEQP(LEFT._owner_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(_acc__Orphan),COUNT(_owner__Orphan)}],{KEL.typ.int _acc__Orphan,KEL.typ.int _owner__Orphan});
  EXPORT NullCounts := DATASET([
    {'AccountIndivOwner','Business_Credit_KEL.File_SBFE_temp','acct_no',COUNT(__d0(__NL(_acc_))),COUNT(__d0(__NN(_acc_)))},
    {'AccountIndivOwner','Business_Credit_KEL.File_SBFE_temp','seq_num',COUNT(__d0(__NL(_owner_))),COUNT(__d0(__NN(_owner_)))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
