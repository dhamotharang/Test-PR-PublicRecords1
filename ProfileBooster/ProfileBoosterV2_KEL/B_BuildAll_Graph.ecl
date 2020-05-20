//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Person,B_Person_Vehicle,B_Vehicle,CFG_Graph FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_BuildAll_Graph := MODULE
  EXPORT Indexes := DATASET([
    {'Person_UID',B_Person().IDX_Person_UID_Name,B_Person().IDX_Person_UID_Name},
    {'Person_Vehicle_Subject_',B_Person_Vehicle().IDX_Person_Vehicle_Subject__Name,B_Person_Vehicle().IDX_Person_Vehicle_Subject__Name},
    {'Vehicle_UID',B_Vehicle().IDX_Vehicle_UID_Name,B_Vehicle().IDX_Vehicle_UID_Name}]
  ,{KEL.typ.str indexName,KEL.typ.str logicalName,KEL.typ.str superName});
  EXPORT BuildAll := PARALLEL(B_Person().BuildAll,B_Person_Vehicle().BuildAll,B_Vehicle().BuildAll);
END;
