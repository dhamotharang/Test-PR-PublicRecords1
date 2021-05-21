//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Professional_License_5,CFG_Compile,E_Professional_License FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Professional_License_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Professional_License_5(__in,__cfg).__ENH_Professional_License_5) __ENH_Professional_License_5 := B_Professional_License_5(__in,__cfg).__ENH_Professional_License_5;
  SHARED __EE1715396 := __ENH_Professional_License_5;
  EXPORT __ST172199_Layout := RECORD
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
  SHARED __ST172199_Layout __ND1715580__Project(B_Professional_License_5(__in,__cfg).__ST174834_Layout __PP1715397) := TRANSFORM
    SELF.Is_Active_ := __OP2(__PP1715397.Max_Expire_Date_,>,__PP1715397.B_U_I_L_D___D_A_T_E_);
    SELF.Valid_Professional_License_ := __AND(__OP2(__PP1715397.License_Number_,<>,__CN('')),__OR(__OP2(__PP1715397.Max_Issue_Date_,<,__PP1715397.B_U_I_L_D___D_A_T_E_),__NT(__PP1715397.Max_Issue_Date_)));
    SELF := __PP1715397;
  END;
  EXPORT __ENH_Professional_License_4 := PROJECT(__EE1715396,__ND1715580__Project(LEFT));
END;
