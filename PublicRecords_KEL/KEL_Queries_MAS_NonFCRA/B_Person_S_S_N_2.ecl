//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_S_S_N_3,CFG_Compile,E_Person,E_Person_S_S_N,E_Social_Security_Number FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_S_S_N_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_S_S_N_3(__in,__cfg).__ENH_Person_S_S_N_3) __ENH_Person_S_S_N_3 := B_Person_S_S_N_3(__in,__cfg).__ENH_Person_S_S_N_3;
  SHARED __EE2611254 := __ENH_Person_S_S_N_3;
  EXPORT __ST169323_Layout := RECORD
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
  EXPORT __ST169315_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Valid_S_S_N_Layout) Valid_S_S_N_;
    KEL.typ.ndataset(__ST169323_Layout) Data_Sources_;
    KEL.typ.bool Is_Best_S_S_N_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST169315_Layout __ND2611259__Project(B_Person_S_S_N_3(__in,__cfg).__ST194645_Layout __PP2611255) := TRANSFORM
    __EE2611274 := __PP2611255.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE2611274),__ST169323_Layout),__NL(__EE2611274));
    SELF := __PP2611255;
  END;
  EXPORT __ENH_Person_S_S_N_2 := PROJECT(__EE2611254,__ND2611259__Project(LEFT));
END;
