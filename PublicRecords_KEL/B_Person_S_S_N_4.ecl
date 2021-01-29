﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_S_S_N_5,CFG_Compile,E_Person,E_Person_S_S_N,E_Social_Security_Number FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_S_S_N_4(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_S_S_N_5(__cfg).__ENH_Person_S_S_N_5) __ENH_Person_S_S_N_5 := B_Person_S_S_N_5(__cfg).__ENH_Person_S_S_N_5;
  SHARED __EE5578600 := __ENH_Person_S_S_N_5;
  EXPORT __ST297835_Layout := RECORD
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
  EXPORT __ST297827_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N(__cfg).Valid_S_S_N_Layout) Valid_S_S_N_;
    KEL.typ.ndataset(__ST297835_Layout) Data_Sources_;
    KEL.typ.nbool Input_S_S_N_Match_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST297827_Layout __ND5578605__Project(B_Person_S_S_N_5(__cfg).__ST297784_Layout __PP5578601) := TRANSFORM
    __EE5578620 := __PP5578601.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE5578620),__ST297835_Layout),__NL(__EE5578620));
    SELF := __PP5578601;
  END;
  EXPORT __ENH_Person_S_S_N_4 := PROJECT(__EE5578600,__ND5578605__Project(LEFT));
END;
