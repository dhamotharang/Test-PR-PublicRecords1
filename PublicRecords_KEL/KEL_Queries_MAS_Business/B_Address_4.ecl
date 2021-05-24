//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Address_5,CFG_Compile,E_Address,E_Geo_Link,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Address_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_5(__in,__cfg).__ENH_Address_5) __ENH_Address_5 := B_Address_5(__in,__cfg).__ENH_Address_5;
  SHARED __EE1990957 := __ENH_Address_5;
  EXPORT __ENH_Address_4 := __EE1990957;
END;
