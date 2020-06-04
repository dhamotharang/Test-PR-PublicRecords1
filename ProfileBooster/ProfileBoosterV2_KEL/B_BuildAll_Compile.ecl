//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Person,B_Person_Vehicle,B_Vehicle,CFG_Compile FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_BuildAll_Compile(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Indexes := DATASET([
    {'Person_UID',B_Person(__cfg).IDX_Person_UID_LogicalName,B_Person(__cfg).IDX_Person_UID_SuperName},
    {'Person_Vehicle_Subject_',B_Person_Vehicle(__cfg).IDX_Person_Vehicle_Subject__LogicalName,B_Person_Vehicle(__cfg).IDX_Person_Vehicle_Subject__SuperName},
    {'Vehicle_UID',B_Vehicle(__cfg).IDX_Vehicle_UID_LogicalName,B_Vehicle(__cfg).IDX_Vehicle_UID_SuperName}]
  ,{KEL.typ.str indexName,KEL.typ.str logicalName,KEL.typ.str superName});
  EXPORT BuildAll := PARALLEL(B_Person(__cfg).BuildAll,B_Person_Vehicle(__cfg).BuildAll,B_Vehicle(__cfg).BuildAll);
END;
