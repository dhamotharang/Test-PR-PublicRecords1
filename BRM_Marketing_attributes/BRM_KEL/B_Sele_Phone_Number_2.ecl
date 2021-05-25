﻿//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Sele_Phone_Number_3,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Phone,E_Sele_Phone_Number FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_Phone_Number_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Phone_Number_3(__in,__cfg).__ENH_Sele_Phone_Number_3) __ENH_Sele_Phone_Number_3 := B_Sele_Phone_Number_3(__in,__cfg).__ENH_Sele_Phone_Number_3;
  SHARED __EE1220248 := __ENH_Sele_Phone_Number_3;
  EXPORT __ST158015_Layout := RECORD
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST157977_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).Best_Phone_Details_Layout) Best_Phone_Details_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).Phone_Details_Layout) Phone_Details_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).Marketability_Layout) Marketability_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).S_I_C_Codes_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).N_A_I_C_S_Codes_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(__ST158015_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST157977_Layout __ND1220253__Project(B_Sele_Phone_Number_3(__in,__cfg).__ST162367_Layout __PP1220249) := TRANSFORM
    __EE1220301 := __PP1220249.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE1220301),__ST158015_Layout),__NL(__EE1220301));
    SELF := __PP1220249;
  END;
  EXPORT __ENH_Sele_Phone_Number_2 := PROJECT(__EE1220248,__ND1220253__Project(LEFT));
END;
