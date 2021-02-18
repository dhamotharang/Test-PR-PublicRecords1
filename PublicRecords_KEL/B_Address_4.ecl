//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Address_5,CFG_Compile,E_Address,E_Geo_Link,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Address_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_5(__in,__cfg).__ENH_Address_5) __ENH_Address_5 := B_Address_5(__in,__cfg).__ENH_Address_5;
  SHARED __EE5193776 := __ENH_Address_5;
  EXPORT __ENH_Address_4 := __EE5193776;
END;
