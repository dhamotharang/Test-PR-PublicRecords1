﻿//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Aircraft_Owner_3,CFG_Compile,E_Aircraft,E_Aircraft_Owner,E_Person FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Aircraft_Owner_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Aircraft_Owner_3(__in,__cfg).__ENH_Aircraft_Owner_3) __ENH_Aircraft_Owner_3 := B_Aircraft_Owner_3(__in,__cfg).__ENH_Aircraft_Owner_3;
  SHARED __EE1261435 := __ENH_Aircraft_Owner_3;
  EXPORT __ST165691_Layout := RECORD
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
  SHARED __ST165691_Layout __ND1261491__Project(B_Aircraft_Owner_3(__in,__cfg).__ST169499_Layout __PP1261436) := TRANSFORM
    __CC14096 := '-99997';
    SELF.Aircraft_Min_Date_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP1261436.Date_First_Seen_Capped_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,__PP1261436.Date_First_Seen_Capped_,__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14096)));
    SELF := __PP1261436;
  END;
  EXPORT __ENH_Aircraft_Owner_2 := PROJECT(__EE1261435,__ND1261491__Project(LEFT));
END;
