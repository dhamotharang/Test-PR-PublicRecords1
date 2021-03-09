//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Sele_T_I_N_6,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_T_I_N FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_T_I_N_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_T_I_N_6(__in,__cfg).__ENH_Sele_T_I_N_6) __ENH_Sele_T_I_N_6 := B_Sele_T_I_N_6(__in,__cfg).__ENH_Sele_T_I_N_6;
  SHARED __EE5744943 := __ENH_Sele_T_I_N_6;
  EXPORT __ST265029_Layout := RECORD
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.nkdate My_Date_Last_Seen_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST265020_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_T_I_N().Typ) Tax_I_D_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nint Best_T_I_N_;
    KEL.typ.nint Best_T_I_N_Rank_;
    KEL.typ.ndataset(__ST265029_Layout) Data_Sources_;
    KEL.typ.nbool Input_T_I_N_Match_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST265020_Layout __ND5744948__Project(B_Sele_T_I_N_6(__in,__cfg).__ST269977_Layout __PP5744944) := TRANSFORM
    __EE5744973 := __PP5744944.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE5744973),__ST265029_Layout),__NL(__EE5744973));
    SELF := __PP5744944;
  END;
  EXPORT __ENH_Sele_T_I_N_5 := PROJECT(__EE5744943,__ND5744948__Project(LEFT));
END;
