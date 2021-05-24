//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Sele_T_I_N_4,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_T_I_N FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_T_I_N_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_T_I_N_4(__in,__cfg).__ENH_Sele_T_I_N_4) __ENH_Sele_T_I_N_4 := B_Sele_T_I_N_4(__in,__cfg).__ENH_Sele_T_I_N_4;
  SHARED __EE1059169 := __ENH_Sele_T_I_N_4;
  EXPORT __ST157466_Layout := RECORD
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST157457_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_T_I_N().Typ) Tax_I_D_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nint Best_T_I_N_;
    KEL.typ.nint Best_T_I_N_Rank_;
    KEL.typ.ndataset(__ST157466_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST157457_Layout __ND1059174__Project(B_Sele_T_I_N_4(__in,__cfg).__ST161139_Layout __PP1059170) := TRANSFORM
    __EE1059198 := __PP1059170.Data_Sources_;
    SELF.Data_Sources_ := __PROJECT(__EE1059198,__ST157466_Layout);
    SELF := __PP1059170;
  END;
  EXPORT __ENH_Sele_T_I_N_3 := PROJECT(__EE1059169,__ND1059174__Project(LEFT));
END;
