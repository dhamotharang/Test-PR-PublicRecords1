//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_Address_3,CFG_Compile,E_Address,E_Geo_Link,E_Person,E_Person_Address,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Address_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Address_3(__in,__cfg).__ENH_Person_Address_3) __ENH_Person_Address_3 := B_Person_Address_3(__in,__cfg).__ENH_Person_Address_3;
  SHARED __EE6901295 := __ENH_Person_Address_3;
  EXPORT __ENH_Person_Address_2 := __EE6901295;
END;
