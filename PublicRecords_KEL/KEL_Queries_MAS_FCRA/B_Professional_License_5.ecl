//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_Professional_License,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Professional_License_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Professional_License(__in,__cfg).__Result) __E_Professional_License := E_Professional_License(__in,__cfg).__Result;
  SHARED __EE1123499 := __E_Professional_License;
  EXPORT __ST171085_Layout := RECORD
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
  SHARED __ST171085_Layout __ND1123426__Project(E_Professional_License(__in,__cfg).Layout __PP266631) := TRANSFORM
    __BS266780 := __T(__PP266631.License_Dates_);
    __CC13219 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('proflic_build_version'))),__CN(__cfg.CurrentDate));
    __CC13227 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('mari_build_version'))),__CN(__cfg.CurrentDate));
    SELF.B_U_I_L_D___D_A_T_E_ := KEL.Routines.MinN(IF(EXISTS(__BS266780(__T(__OP2(__T(__PP266631.License_Dates_).Source_,=,__CN('PL'))))),__ECAST(KEL.typ.nkdate,__CC13219),__ECAST(KEL.typ.nkdate,__CC13227)),__CN(__cfg.CurrentDate));
    __EE1123421 := __PP266631.License_Dates_;
    SELF.Max_Expire_Date_ := KEL.Aggregates.MaxNN(__EE1123421,__T(__EE1123421).Date_Of_Expiration_);
    __EE1123446 := __PP266631.License_Dates_;
    SELF.Max_Issue_Date_ := KEL.Aggregates.MaxNN(__EE1123446,IF(__T(__OP2(__T(__EE1123446).Original_Date_Of_Issuance_,<,KEL.Routines.CastStringToDate(__CN('19000101')))),__ECAST(KEL.typ.nkdate,KEL.Routines.CastStringToDate(__CN(''))),__ECAST(KEL.typ.nkdate,__T(__EE1123446).Original_Date_Of_Issuance_)));
    SELF := __PP266631;
  END;
  EXPORT __ENH_Professional_License_5 := PROJECT(__EE1123499,__ND1123426__Project(LEFT));
END;
