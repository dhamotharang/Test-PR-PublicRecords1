//HPCC Systems KEL Compiler Version 0.8.2
IMPORT KEL08a AS KEL;
IMPORT Business_Credit_KEL;
IMPORT CFG_graph,E_Business,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL08a.Null;
EXPORT E_Business_Industry(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'seq(_bus_:0),seq_num(_industry_:0)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.BusinessClassification,TRANSFORM(RECORDOF(__in.BusinessClassification),SELF:=RIGHT));
  SHARED __d0_Prefiltered := __d0_Norm;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PreResult := PROJECT(TABLE(InData,{KEL.typ.int __RecordCount := COUNT(GROUP),_bus_,_industry_},_bus_,_industry_,MERGE),Layout);
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT NullCounts := DATASET([
    {'BusinessIndustry','Business_Credit_KEL.File_SBFE_temp','seq',COUNT(__d0(__NL(_bus_))),COUNT(__d0(__NN(_bus_)))},
    {'BusinessIndustry','Business_Credit_KEL.File_SBFE_temp','seq_num',COUNT(__d0(__NL(_industry_))),COUNT(__d0(__NN(_industry_)))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
