//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Business,B_Tradeline,CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_BuildAll_graph(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault) := MODULE
  EXPORT Indexes := DATASET([
    {'Business_UID',B_Business(__in).IDX_Business_UID_Name,B_Business(__in).IDX_Business_UID_Name},
    {'Tradeline_UID',B_Tradeline(__in).IDX_Tradeline_UID_Name,B_Tradeline(__in).IDX_Tradeline_UID_Name}]
  ,{KEL.typ.str indexName,KEL.typ.str logicalName,KEL.typ.str superName});
  EXPORT BuildAll := PARALLEL(B_Business(__in).BuildAll,B_Tradeline(__in).BuildAll);
END;
