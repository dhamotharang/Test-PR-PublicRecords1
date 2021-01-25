//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Professional_License_5,CFG_Compile,E_Professional_License,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Professional_License_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Professional_License_5(__in,__cfg).__ENH_Professional_License_5) __ENH_Professional_License_5 := B_Professional_License_5(__in,__cfg).__ENH_Professional_License_5;
  SHARED __EE5125711 := __ENH_Professional_License_5;
  EXPORT __ST235537_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr License_Number_;
    KEL.typ.nstr License_State_;
    KEL.typ.nint Lex_I_D_;
    KEL.typ.nkdate Date_Created_;
    KEL.typ.nstr Legacy_Result_Code_;
    KEL.typ.ndataset(E_Professional_License(__in,__cfg).Source_Details_Layout) Source_Details_;
    KEL.typ.ndataset(E_Professional_License(__in,__cfg).License_Dates_Layout) License_Dates_;
    KEL.typ.ndataset(E_Professional_License(__in,__cfg).Status_Layout) Status_;
    KEL.typ.ndataset(E_Professional_License(__in,__cfg).License_Description_Layout) License_Description_;
    KEL.typ.ndataset(E_Professional_License(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nbool Is_Active_;
    KEL.typ.nkdate Max_Expire_Date_;
    KEL.typ.nkdate Max_Issue_Date_;
    KEL.typ.nbool Valid_Professional_License_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST235537_Layout __ND5125883__Project(B_Professional_License_5(__in,__cfg).__ST241933_Layout __PP5125712) := TRANSFORM
    __CC13066 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('proflic_build_version'))),__CN(__cfg.CurrentDate));
    SELF.Is_Active_ := __OP2(__PP5125712.Max_Expire_Date_,>,__CC13066);
    SELF.Valid_Professional_License_ := __AND(__OP2(__PP5125712.License_Number_,<>,__CN('')),__OR(__OP2(__PP5125712.Max_Issue_Date_,<,__CC13066),__NT(__PP5125712.Max_Issue_Date_)));
    SELF := __PP5125712;
  END;
  EXPORT __ENH_Professional_License_4 := PROJECT(__EE5125711,__ND5125883__Project(LEFT));
END;
