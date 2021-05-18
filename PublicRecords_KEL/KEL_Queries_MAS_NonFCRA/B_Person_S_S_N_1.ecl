//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_S_S_N_2,CFG_Compile,E_Person,E_Person_S_S_N,E_Social_Security_Number FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_S_S_N_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_S_S_N_2(__in,__cfg).__ENH_Person_S_S_N_2) __ENH_Person_S_S_N_2 := B_Person_S_S_N_2(__in,__cfg).__ENH_Person_S_S_N_2;
  SHARED __EE3292972 := __ENH_Person_S_S_N_2;
  EXPORT __ST161860_Layout := RECORD
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
  EXPORT __ST161852_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Valid_S_S_N_Layout) Valid_S_S_N_;
    KEL.typ.ndataset(__ST161860_Layout) Data_Sources_;
    KEL.typ.bool Is_Best_S_S_N_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST161852_Layout __ND3292977__Project(B_Person_S_S_N_2(__in,__cfg).__ST167023_Layout __PP3292973) := TRANSFORM
    __EE3292992 := __PP3292973.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE3292992),__ST161860_Layout),__NL(__EE3292992));
    SELF := __PP3292973;
  END;
  EXPORT __ENH_Person_S_S_N_1 := PROJECT(__EE3292972,__ND3292977__Project(LEFT));
END;
