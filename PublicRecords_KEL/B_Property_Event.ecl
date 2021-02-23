//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Property_Event_1,B_Property_Event_6,CFG_Compile,E_Property,E_Property_Event,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Property_Event(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Property_Event_1(__in,__cfg).__ENH_Property_Event_1) __ENH_Property_Event_1 := B_Property_Event_1(__in,__cfg).__ENH_Property_Event_1;
  SHARED __EE11399235 := __ENH_Property_Event_1;
  EXPORT __ENH_Property_Event := __EE11399235;
END;
