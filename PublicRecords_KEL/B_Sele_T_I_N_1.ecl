﻿//HPCC Systems KEL Compiler Version 1.3.0beta5
IMPORT KEL13 AS KEL;
IMPORT B_Sele_T_I_N_2,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_T_I_N FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Sele_T_I_N_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_T_I_N_2(__in,__cfg).__ENH_Sele_T_I_N_2) __ENH_Sele_T_I_N_2 := B_Sele_T_I_N_2(__in,__cfg).__ENH_Sele_T_I_N_2;
  SHARED __EE5513752 := __ENH_Sele_T_I_N_2;
  EXPORT __ST147790_Layout := RECORD
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.nkdate My_Date_Last_Seen_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST147781_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_T_I_N().Typ) Tax_I_D_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nint Best_T_I_N_;
    KEL.typ.nint Best_T_I_N_Rank_;
    KEL.typ.ndataset(__ST147790_Layout) Data_Sources_;
    KEL.typ.nbool Input_T_I_N_Match_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST147781_Layout __ND5513757__Project(B_Sele_T_I_N_2(__in,__cfg).__ST162439_Layout __PP5513753) := TRANSFORM
    __EE5513782 := __PP5513753.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE5513782),__ST147790_Layout),__NL(__EE5513782));
    SELF := __PP5513753;
  END;
  EXPORT __ENH_Sele_T_I_N_1 := PROJECT(__EE5513752,__ND5513757__Project(LEFT));
END;
