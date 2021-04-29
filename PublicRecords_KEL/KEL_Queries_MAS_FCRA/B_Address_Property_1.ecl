//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Address_Property_2,B_Address_Property_3,CFG_Compile,E_Address,E_Address_Property,E_Geo_Link,E_Property,E_Property_Event,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Address_Property_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_Property_2(__in,__cfg).__ENH_Address_Property_2) __ENH_Address_Property_2 := B_Address_Property_2(__in,__cfg).__ENH_Address_Property_2;
  SHARED __EE5421997 := __ENH_Address_Property_2;
  EXPORT __ENH_Address_Property_1 := __EE5421997;
END;
