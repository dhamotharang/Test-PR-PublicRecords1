//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_S_S_N_3,CFG_Compile,E_Person,E_Person_S_S_N,E_Social_Security_Number FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_S_S_N_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_S_S_N_3(__in,__cfg).__ENH_Person_S_S_N_3) __ENH_Person_S_S_N_3 := B_Person_S_S_N_3(__in,__cfg).__ENH_Person_S_S_N_3;
  SHARED __EE8208159 := __ENH_Person_S_S_N_3;
  EXPORT __ST292530_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool F_D_N_Indicator_;
    KEL.typ.nbool Death_Master_Flag_;
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
  EXPORT __ST292522_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Valid_S_S_N_Layout) Valid_S_S_N_;
    KEL.typ.ndataset(__ST292530_Layout) Data_Sources_;
    KEL.typ.nbool Input_S_S_N_Match_;
    KEL.typ.bool Is_Best_S_S_N_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST292522_Layout __ND8208282__Project(B_Person_S_S_N_3(__in,__cfg).__ST292470_Layout __PP8208160) := TRANSFORM
    __EE8208180 := __PP8208160.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE8208180),__ST292530_Layout),__NL(__EE8208180));
    __BS8208217 := __T(__PP8208160.Data_Sources_);
    SELF.Is_Best_S_S_N_ := EXISTS(__BS8208217(__T(__OP2(__T(__PP8208160.Data_Sources_).Source_,IN,__CN(['BP','NEN','NEQ'])))));
    SELF := __PP8208160;
  END;
  EXPORT __ENH_Person_S_S_N_2 := PROJECT(__EE8208159,__ND8208282__Project(LEFT));
END;
