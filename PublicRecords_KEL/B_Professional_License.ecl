//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT CFG_Compile,E_Professional_License,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Professional_License(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Professional_License(__in,__cfg).__Result) __E_Professional_License := E_Professional_License(__in,__cfg).__Result;
  SHARED __EE434281 := __E_Professional_License;
  EXPORT __ST27043_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr License_State_;
    KEL.typ.nkdate Date_Created_;
    KEL.typ.nstr Legacy_Result_Code_;
    KEL.typ.nstr Source_Description_;
    KEL.typ.nstr Source_Code_;
    KEL.typ.ndataset(E_Professional_License(__in,__cfg).License_Dates_Layout) License_Dates_;
    KEL.typ.ndataset(E_Professional_License(__in,__cfg).Status_Layout) Status_;
    KEL.typ.ndataset(E_Professional_License(__in,__cfg).License_Description_Layout) License_Description_;
    KEL.typ.ndataset(E_Professional_License(__in,__cfg).Mortgage_Licensing_System_Layout) Mortgage_Licensing_System_;
    KEL.typ.ndataset(E_Professional_License(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST27043_Layout __ND434537__Project(E_Professional_License(__in,__cfg).Layout __PP434097) := TRANSFORM
    SELF.Current_Date_ := KEL.Routines.MinN(FN_Compile.FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('proflic_build_version'))),__CN(__cfg.CurrentDate));
    SELF := __PP434097;
  END;
  EXPORT __ENH_Professional_License := PROJECT(__EE434281,__ND434537__Project(LEFT));
END;
