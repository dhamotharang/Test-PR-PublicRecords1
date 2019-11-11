//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT CFG_Compile,E_Aircraft,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_Aircraft,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Sele_Aircraft_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Sele_Aircraft(__in,__cfg).__Result) __E_Sele_Aircraft := E_Sele_Aircraft(__in,__cfg).__Result;
  SHARED __EE934836 := __E_Sele_Aircraft;
  EXPORT __ST76027_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Aircraft().Typ) Plane_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr N_Number_;
    KEL.typ.ndataset(E_Sele_Aircraft(__in,__cfg).Registration_Details_Layout) Registration_Details_;
    KEL.typ.ndataset(E_Sele_Aircraft(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST76027_Layout __ND934897__Project(E_Sele_Aircraft(__in,__cfg).Layout __PP934750) := TRANSFORM
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('faa_build_version'))),__CN(__cfg.CurrentDate));
    SELF := __PP934750;
  END;
  EXPORT __ENH_Sele_Aircraft_1 := PROJECT(__EE934836,__ND934897__Project(LEFT));
END;
