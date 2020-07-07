//HPCC Systems KEL Compiler Version 1.2.0beta2
IMPORT KEL12 AS KEL;
IMPORT CFG_Compile,E_Aircraft,E_Aircraft_Owner,E_Person,FN_Compile FROM $;
IMPORT * FROM KEL12.Null;
EXPORT B_Aircraft_Owner_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Aircraft_Owner(__in,__cfg).__Result) __E_Aircraft_Owner := E_Aircraft_Owner(__in,__cfg).__Result;
  SHARED __EE185765 := __E_Aircraft_Owner;
  EXPORT __ST107722_Layout := RECORD
    KEL.typ.ntyp(E_Aircraft().Typ) Plane_;
    KEL.typ.ntyp(E_Person().Typ) Owner_;
    KEL.typ.nint Registrant_Type_;
    KEL.typ.nkdate Certificate_Issue_Date_;
    KEL.typ.nstr Certification_;
    KEL.typ.ndataset(E_Aircraft_Owner(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST107722_Layout __ND185793__Project(E_Aircraft_Owner(__in,__cfg).Layout __PP185711) := TRANSFORM
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('faa_build_version'))),__CN(__cfg.CurrentDate));
    SELF := __PP185711;
  END;
  EXPORT __ENH_Aircraft_Owner_4 := PROJECT(__EE185765,__ND185793__Project(LEFT));
END;
