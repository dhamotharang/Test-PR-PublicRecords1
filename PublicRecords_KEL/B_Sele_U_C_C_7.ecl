//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Sele_U_C_C_8,B_Sele_U_C_C_9,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Sele_U_C_C,E_U_C_C FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_U_C_C_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_U_C_C_8(__in,__cfg).__ENH_Sele_U_C_C_8) __ENH_Sele_U_C_C_8 := B_Sele_U_C_C_8(__in,__cfg).__ENH_Sele_U_C_C_8;
  SHARED __EE5102252 := __ENH_Sele_U_C_C_8;
  EXPORT __ST259860_Layout := RECORD
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
  EXPORT __ST259852_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.ntyp(E_U_C_C().Typ) Filing_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(__ST259860_Layout) Sub_Filing_;
    KEL.typ.ndataset(E_Sele_U_C_C(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Sele_U_C_C_9(__in,__cfg).__ST264459_Layout) Best_Party_Types_;
    KEL.typ.nstr Filtered_Party_Type_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST259852_Layout __ND5102230__Project(B_Sele_U_C_C_8(__in,__cfg).__ST370063_Layout __PP5102097) := TRANSFORM
    __EE5102255 := __PP5102097.Sub_Filing_;
    SELF.Sub_Filing_ := __BN(PROJECT(__T(__EE5102255),__ST259860_Layout),__NL(__EE5102255));
    __EE5102225 := __PP5102097.Best_Party_Types_;
    SELF.Filtered_Party_Type_ := (__T(__EE5102225))[1].Party_Type_;
    SELF := __PP5102097;
  END;
  EXPORT __ENH_Sele_U_C_C_7 := PROJECT(__EE5102252,__ND5102230__Project(LEFT));
END;
