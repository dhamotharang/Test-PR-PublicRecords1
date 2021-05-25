//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Sele_T_I_N_6,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_T_I_N FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_T_I_N_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_T_I_N_6(__in,__cfg).__ENH_Sele_T_I_N_6) __ENH_Sele_T_I_N_6 := B_Sele_T_I_N_6(__in,__cfg).__ENH_Sele_T_I_N_6;
  SHARED __EE1994548 := __ENH_Sele_T_I_N_6;
  EXPORT __ST217610_Layout := RECORD
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
  EXPORT __ST217601_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_T_I_N().Typ) Tax_I_D_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nint Best_T_I_N_;
    KEL.typ.nint Best_T_I_N_Rank_;
    KEL.typ.ndataset(__ST217610_Layout) Data_Sources_;
    KEL.typ.nbool Input_T_I_N_Match_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST217601_Layout __ND1994553__Project(B_Sele_T_I_N_6(__in,__cfg).__ST220977_Layout __PP1994549) := TRANSFORM
    __EE1994578 := __PP1994549.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE1994578),__ST217610_Layout),__NL(__EE1994578));
    SELF := __PP1994549;
  END;
  EXPORT __ENH_Sele_T_I_N_5 := PROJECT(__EE1994548,__ND1994553__Project(LEFT));
END;
