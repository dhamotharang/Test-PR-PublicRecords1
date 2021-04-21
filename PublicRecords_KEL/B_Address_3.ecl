//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Address_4,B_Address_5,CFG_Compile,E_Address,E_Geo_Link,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Address_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_4(__in,__cfg).__ENH_Address_4) __ENH_Address_4 := B_Address_4(__in,__cfg).__ENH_Address_4;
  SHARED __EE6551705 := __ENH_Address_4;
  EXPORT __ENH_Address_3 := __EE6551705;
END;
