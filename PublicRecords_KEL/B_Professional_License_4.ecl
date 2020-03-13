//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Professional_License_5,CFG_Compile,E_Professional_License,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Professional_License_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Professional_License_5(__in,__cfg).__ENH_Professional_License_5) __ENH_Professional_License_5 := B_Professional_License_5(__in,__cfg).__ENH_Professional_License_5;
  SHARED __EE406036 := __ENH_Professional_License_5;
  EXPORT __ST140731_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST140731_Layout __ND406315__Project(B_Professional_License_5(__in,__cfg).__ST143371_Layout __PP405824) := TRANSFORM
    __CC9115 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('proflic_build_version'))),__CN(__cfg.CurrentDate));
    SELF.Is_Active_ := __OP2(__PP405824.Max_Expire_Date_,>,__CC9115);
    SELF.Valid_Professional_License_ := __AND(__OP2(__PP405824.License_Number_,<>,__CN('')),__OR(__OP2(__PP405824.Max_Issue_Date_,<,__CC9115),__NT(__PP405824.Max_Issue_Date_)));
    SELF := __PP405824;
  END;
  EXPORT __ENH_Professional_License_4 := PROJECT(__EE406036,__ND406315__Project(LEFT));
END;
