//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Address_Property_3,CFG_Compile,E_Address,E_Address_Property,E_Geo_Link,E_Property,E_Property_Event,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Address_Property_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_Property_3(__in,__cfg).__ENH_Address_Property_3) __ENH_Address_Property_3 := B_Address_Property_3(__in,__cfg).__ENH_Address_Property_3;
  SHARED __EE7987687 := __ENH_Address_Property_3;
  EXPORT __ENH_Address_Property_2 := __EE7987687;
END;
