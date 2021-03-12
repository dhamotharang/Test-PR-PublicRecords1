//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Sele_T_I_N_3,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_T_I_N FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_T_I_N_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_T_I_N_3(__in,__cfg).__ENH_Sele_T_I_N_3) __ENH_Sele_T_I_N_3 := B_Sele_T_I_N_3(__in,__cfg).__ENH_Sele_T_I_N_3;
  SHARED __EE8286112 := __ENH_Sele_T_I_N_3;
  EXPORT __ST232218_Layout := RECORD
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
  EXPORT __ST232209_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_T_I_N().Typ) Tax_I_D_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nint Best_T_I_N_;
    KEL.typ.nint Best_T_I_N_Rank_;
    KEL.typ.ndataset(__ST232218_Layout) Data_Sources_;
    KEL.typ.nbool Input_T_I_N_Match_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST232209_Layout __ND8286117__Project(B_Sele_T_I_N_3(__in,__cfg).__ST247179_Layout __PP8286113) := TRANSFORM
    __EE8286142 := __PP8286113.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE8286142),__ST232218_Layout),__NL(__EE8286142));
    SELF := __PP8286113;
  END;
  EXPORT __ENH_Sele_T_I_N_2 := PROJECT(__EE8286112,__ND8286117__Project(LEFT));
END;
