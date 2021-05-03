//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Professional_License,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Professional_License_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Professional_License(__in,__cfg).__Result) __E_Professional_License := E_Professional_License(__in,__cfg).__Result;
  SHARED __EE4761362 := __E_Professional_License;
  EXPORT __ST203063_Layout := RECORD
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
    KEL.typ.nkdate B_U_I_L_D___D_A_T_E_;
    KEL.typ.nkdate Max_Expire_Date_;
    KEL.typ.nkdate Max_Issue_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST203063_Layout __ND4761289__Project(E_Professional_License(__in,__cfg).Layout __PP403894) := TRANSFORM
    __BS404043 := __T(__PP403894.License_Dates_);
    __CC13387 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('proflic_build_version'))),__CN(__cfg.CurrentDate));
    __CC13395 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('mari_build_version'))),__CN(__cfg.CurrentDate));
    SELF.B_U_I_L_D___D_A_T_E_ := KEL.Routines.MinN(IF(EXISTS(__BS404043(__T(__OP2(__T(__PP403894.License_Dates_).Source_,=,__CN('PL'))))),__ECAST(KEL.typ.nkdate,__CC13387),__ECAST(KEL.typ.nkdate,__CC13395)),__CN(__cfg.CurrentDate));
    __EE4761284 := __PP403894.License_Dates_;
    SELF.Max_Expire_Date_ := KEL.Aggregates.MaxNN(__EE4761284,__T(__EE4761284).Date_Of_Expiration_);
    __EE4761309 := __PP403894.License_Dates_;
    SELF.Max_Issue_Date_ := KEL.Aggregates.MaxNN(__EE4761309,IF(__T(__OP2(__T(__EE4761309).Original_Date_Of_Issuance_,<,KEL.Routines.CastStringToDate(__CN('19000101')))),__ECAST(KEL.typ.nkdate,KEL.Routines.CastStringToDate(__CN(''))),__ECAST(KEL.typ.nkdate,__T(__EE4761309).Original_Date_Of_Issuance_)));
    SELF := __PP403894;
  END;
  EXPORT __ENH_Professional_License_5 := PROJECT(__EE4761362,__ND4761289__Project(LEFT));
END;
