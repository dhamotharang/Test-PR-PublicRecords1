//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Sele_U_C_C_7,B_Sele_U_C_C_9,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Sele_U_C_C,E_U_C_C FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_U_C_C_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_U_C_C_7(__in,__cfg).__ENH_Sele_U_C_C_7) __ENH_Sele_U_C_C_7 := B_Sele_U_C_C_7(__in,__cfg).__ENH_Sele_U_C_C_7;
  SHARED __EE851828 := __ENH_Sele_U_C_C_7;
  EXPORT __ST166243_Layout := RECORD
    KEL.typ.nstr R_M_S_I_D_;
    KEL.typ.nstr Party_Type_;
    KEL.typ.int Party_Sort_List_ := 0;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST166235_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(__ST166243_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_U_C_C_9(__in,__cfg).__ST169447_Layout) Best_Party_Types_;
    KEL.typ.nstr Filtered_Party_Type_;
    KEL.typ.bool Is_Filing_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST166235_Layout __ND851933__Project(B_Sele_U_C_C_7(__in,__cfg).__ST167604_Layout __PP851829) := TRANSFORM
    __EE851864 := __PP851829.Sub_Filing_;
    SELF.Sub_Filing_ := __BN(PROJECT(__T(__EE851864),__ST166243_Layout),__NL(__EE851864));
    SELF.Is_Filing_ := IF(__T(__OP2(__FN1(KEL.Routines.ToUpperCase,__FN1(TRIM,__PP851829.Filtered_Party_Type_)),IN,__CN(['D','S','C','A']))),TRUE,FALSE);
    SELF := __PP851829;
  END;
  EXPORT __ENH_Sele_U_C_C_6 := PROJECT(__EE851828,__ND851933__Project(LEFT));
END;
