//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_S_S_N_4,CFG_Compile,E_Person,E_Person_S_S_N,E_Social_Security_Number FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_S_S_N_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_S_S_N_4(__in,__cfg).__ENH_Person_S_S_N_4) __ENH_Person_S_S_N_4 := B_Person_S_S_N_4(__in,__cfg).__ENH_Person_S_S_N_4;
  SHARED __EE1261808 := __ENH_Person_S_S_N_4;
  EXPORT __ST162075_Layout := RECORD
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
  EXPORT __ST162067_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Valid_S_S_N_Layout) Valid_S_S_N_;
    KEL.typ.ndataset(__ST162075_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST162067_Layout __ND1261813__Project(B_Person_S_S_N_4(__in,__cfg).__ST164515_Layout __PP1261809) := TRANSFORM
    __EE1261827 := __PP1261809.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE1261827),__ST162075_Layout),__NL(__EE1261827));
    SELF := __PP1261809;
  END;
  EXPORT __ENH_Person_S_S_N_3 := PROJECT(__EE1261808,__ND1261813__Project(LEFT));
END;
