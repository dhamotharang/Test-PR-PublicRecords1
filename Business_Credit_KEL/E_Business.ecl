//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT Business_Credit_KEL;
IMPORT CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT E_Business(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'seq(DEFAULT:UID)';
  EXPORT Business_Credit_KEL_File_SBFE_temp_Invalid := __in((KEL.typ.uid)seq = 0);
  SHARED __d0_Prefiltered := __in((KEL.typ.uid)seq <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping,'Business_Credit_KEL.File_SBFE_temp'));
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PreResult := PROJECT(TABLE(InData,{KEL.typ.int __RecordCount := COUNT(GROUP),UID},UID,MERGE),Layout);
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := TABLE(InData,{KEL.typ.uid UID := MIN(GROUP,__T(UID)),KEL.typ.int Cnt := COUNT(GROUP)},UID);
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT SanityCheck := DATASET([{COUNT(Business_Credit_KEL_File_SBFE_temp_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int Business_Credit_KEL_File_SBFE_temp_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Business','Business_Credit_KEL.File_SBFE_temp','UID',COUNT(Business_Credit_KEL_File_SBFE_temp_Invalid),COUNT(__d0)}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
