//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Aircraft,CFG_Compile,E_Address,E_Aircraft,E_Aircraft_Address,E_Aircraft_Owner,E_Person,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT Q_Aircraft_Entity(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED TYPEOF(B_Aircraft(__in).__ENH_Aircraft) __ENH_Aircraft := B_Aircraft(__in).__ENH_Aircraft;
  SHARED TYPEOF(E_Aircraft_Address(__in).__Result) __E_Aircraft_Address := E_Aircraft_Address(__in).__Result;
  SHARED TYPEOF(E_Aircraft_Owner(__in).__Result) __E_Aircraft_Owner := E_Aircraft_Owner(__in).__Result;
  SHARED __EE458201 := __ENH_Aircraft;
  SHARED __EE458203 := __EE458201;
  EXPORT Res0 := __UNWRAP(__EE458203);
  SHARED __EE458205 := __E_Aircraft_Owner;
  SHARED __EE458207 := __EE458205;
  EXPORT Res1 := __UNWRAP(__EE458207);
  SHARED __EE458209 := __E_Aircraft_Address;
  EXPORT Res2 := __UNWRAP(__EE458209);
END;
