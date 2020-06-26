//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Address_1,CFG_Compile,E_Address,E_Geo_Link,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Address(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_1().__ENH_Address_1) __ENH_Address_1 := B_Address_1(__in,__cfg).__ENH_Address_1;
  SHARED __EE3207215 := __ENH_Address_1;
  EXPORT __ENH_Address := __EE3207215;
END;
