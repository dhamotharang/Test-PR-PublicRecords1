//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT CFG_Compile,E_Aircraft,E_Aircraft_Owner,E_Person,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Aircraft_Owner_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Aircraft_Owner(__in,__cfg).__Result) __E_Aircraft_Owner := E_Aircraft_Owner(__in,__cfg).__Result;
  SHARED __EE642650 := __E_Aircraft_Owner;
  EXPORT __ST171755_Layout := RECORD
    KEL.typ.ntyp(E_Aircraft().Typ) Plane_;
    KEL.typ.ntyp(E_Person().Typ) Owner_;
    KEL.typ.nint Registrant_Type_;
    KEL.typ.nkdate Certificate_Issue_Date_;
    KEL.typ.nstr Certification_;
    KEL.typ.ndataset(E_Aircraft_Owner(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST171755_Layout __ND642662__Project(E_Aircraft_Owner(__in,__cfg).Layout __PP642588) := TRANSFORM
    __CC10182 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('faa_build_version'))),__CN(__cfg.CurrentDate));
    SELF.Date_First_Seen_Capped_ := IF(__T(__OP2(KEL.era.ToDate(__PP642588.Date_First_Seen_),>,__CC10182)),__ECAST(KEL.typ.nkdate,__CC10182),__ECAST(KEL.typ.nkdate,KEL.era.ToDate(__PP642588.Date_First_Seen_)));
    SELF := __PP642588;
  END;
  EXPORT __ENH_Aircraft_Owner_3 := PROJECT(__EE642650,__ND642662__Project(LEFT));
END;
