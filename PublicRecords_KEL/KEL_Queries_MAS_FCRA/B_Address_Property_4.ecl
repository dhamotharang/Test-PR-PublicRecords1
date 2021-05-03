//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Address_Property_5,CFG_Compile,E_Address,E_Address_Property,E_Geo_Link,E_Property,E_Property_Event,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Address_Property_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_Property_5(__in,__cfg).__ENH_Address_Property_5) __ENH_Address_Property_5 := B_Address_Property_5(__in,__cfg).__ENH_Address_Property_5;
  SHARED __EE4761413 := __ENH_Address_Property_5;
  EXPORT __ENH_Address_Property_4 := __EE4761413;
END;
