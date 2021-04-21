﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Aircraft_Owner_2,CFG_Compile,E_Aircraft,E_Aircraft_Owner,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Aircraft_Owner_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Aircraft_Owner_2(__in,__cfg).__ENH_Aircraft_Owner_2) __ENH_Aircraft_Owner_2 := B_Aircraft_Owner_2(__in,__cfg).__ENH_Aircraft_Owner_2;
  SHARED __EE8891885 := __ENH_Aircraft_Owner_2;
  EXPORT __ST190841_Layout := RECORD
    KEL.typ.ntyp(E_Aircraft().Typ) Plane_;
    KEL.typ.ntyp(E_Person().Typ) Owner_;
    KEL.typ.nint Registrant_Type_;
    KEL.typ.nkdate Certificate_Issue_Date_;
    KEL.typ.nstr Certification_;
    KEL.typ.ndataset(E_Aircraft_Owner(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nstr Aircraft_Min_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Aircraft_Owner_1 := PROJECT(__EE8891885,__ST190841_Layout);
END;
