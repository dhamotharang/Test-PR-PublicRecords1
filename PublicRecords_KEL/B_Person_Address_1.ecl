﻿//HPCC Systems KEL Compiler Version 1.3.0beta5
IMPORT KEL13 AS KEL;
IMPORT B_Person_Address_2,B_Person_Address_3,CFG_Compile,E_Address,E_Geo_Link,E_Person,E_Person_Address,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Person_Address_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Address_2(__in,__cfg).__ENH_Person_Address_2) __ENH_Person_Address_2 := B_Person_Address_2(__in,__cfg).__ENH_Person_Address_2;
  SHARED __EE5496708 := __ENH_Person_Address_2;
  EXPORT __ENH_Person_Address_1 := __EE5496708;
END;
