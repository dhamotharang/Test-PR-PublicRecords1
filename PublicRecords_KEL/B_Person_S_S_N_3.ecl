﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_S_S_N_4,CFG_Compile,E_Person,E_Person_S_S_N,E_Social_Security_Number FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_S_S_N_3(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_S_S_N_4(__cfg).__ENH_Person_S_S_N_4) __ENH_Person_S_S_N_4 := B_Person_S_S_N_4(__cfg).__ENH_Person_S_S_N_4;
  SHARED __EE6525224 := __ENH_Person_S_S_N_4;
  EXPORT __ST297878_Layout := RECORD
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
  EXPORT __ST297870_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N(__cfg).Valid_S_S_N_Layout) Valid_S_S_N_;
    KEL.typ.ndataset(__ST297878_Layout) Data_Sources_;
    KEL.typ.nbool Input_S_S_N_Match_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST297870_Layout __ND6525229__Project(B_Person_S_S_N_4(__cfg).__ST297827_Layout __PP6525225) := TRANSFORM
    __EE6525244 := __PP6525225.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE6525244),__ST297878_Layout),__NL(__EE6525244));
    SELF := __PP6525225;
  END;
  EXPORT __ENH_Person_S_S_N_3 := PROJECT(__EE6525224,__ND6525229__Project(LEFT));
END;
