//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_S_S_N_6,CFG_Compile,E_Person,E_Person_S_S_N,E_Social_Security_Number FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_S_S_N_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_S_S_N_6(__in,__cfg).__ENH_Person_S_S_N_6) __ENH_Person_S_S_N_6 := B_Person_S_S_N_6(__in,__cfg).__ENH_Person_S_S_N_6;
  SHARED __EE1123164 := __ENH_Person_S_S_N_6;
  EXPORT __ST171084_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool F_D_N_Indicator_;
    KEL.typ.nbool Death_Master_Flag_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST171076_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Valid_S_S_N_Layout) Valid_S_S_N_;
    KEL.typ.ndataset(__ST171084_Layout) Data_Sources_;
    KEL.typ.bool Is_Best_S_S_N_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST171076_Layout __ND1123265__Project(B_Person_S_S_N_6(__in,__cfg).__ST172323_Layout __PP1123165) := TRANSFORM
    __EE1123184 := __PP1123165.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE1123184),__ST171084_Layout),__NL(__EE1123184));
    __BS1123211 := __T(__PP1123165.Data_Sources_);
    SELF.Is_Best_S_S_N_ := EXISTS(__BS1123211(__T(__OP2(__T(__PP1123165.Data_Sources_).Source_,IN,__CN(['BP','NEN','NEQ'])))));
    SELF := __PP1123165;
  END;
  EXPORT __ENH_Person_S_S_N_5 := PROJECT(__EE1123164,__ND1123265__Project(LEFT));
END;
