//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Sele_Address_5,CFG_Compile,E_Address,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Geo_Link,E_Sele_Address,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_Address_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Address_5(__in,__cfg).__ENH_Sele_Address_5) __ENH_Sele_Address_5 := B_Sele_Address_5(__in,__cfg).__ENH_Sele_Address_5;
  SHARED __EE4964388 := __ENH_Sele_Address_5;
  EXPORT __ST239966_Layout := RECORD
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.nkdate Date_First_Seen_Company_Address_;
    KEL.typ.nkdate Date_Last_Seen_Company_Address_;
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
  EXPORT __ST697566_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nint Age_Helper_Attribute_;
    KEL.typ.nbool Age_Is_Not_Zero_Helper_;
    KEL.typ.nint Last_Seen_Age_Helper_Attribute_;
    KEL.typ.nkdate My_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST239910_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ndataset(E_Sele_Address(__in,__cfg).Address_Record_Type_Layout) Address_Record_Type_;
    KEL.typ.ndataset(E_Sele_Address(__in,__cfg).Other_Location_Details_Layout) Other_Location_Details_;
    KEL.typ.ndataset(E_Sele_Address(__in,__cfg).Address_Types_Layout) Address_Types_;
    KEL.typ.ndataset(E_Sele_Address(__in,__cfg).S_I_C_Codes_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(E_Sele_Address(__in,__cfg).N_A_I_C_S_Codes_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Sele_Address(__in,__cfg).Best_Addresses_Layout) Best_Addresses_;
    KEL.typ.ndataset(__ST239966_Layout) Data_Sources_;
    KEL.typ.nbool Input_Address_Match_;
    KEL.typ.nbool Matches_Is_Best_Helper_Attr_;
    KEL.typ.ndataset(__ST697566_Layout) Rolled_Source_List_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST239910_Layout __ND4964330__Project(B_Sele_Address_5(__in,__cfg).__ST246210_Layout __PP4963951) := TRANSFORM
    __EE4964391 := __PP4963951.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE4964391),__ST239966_Layout),__NL(__EE4964391));
    __EE4964328 := __PP4963951.Rolled_Source_List_;
    __ST697566_Layout __ND4964247__Project(B_Sele_Address_5(__in,__cfg).__ST120418_Layout __PP4964080) := TRANSFORM
      __CC13226 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Age_Helper_Attribute_ := IF(__T(__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP4964080.Date_First_Seen_),__CN('%Y%m%d')),=,__CN('0'))),__ECAST(KEL.typ.nint,__CN(-99998)),__ECAST(KEL.typ.nint,__FN2(KEL.Routines.DaysBetween,KEL.era.ToDate(__PP4964080.Date_First_Seen_),__CC13226)));
      SELF.Age_Is_Not_Zero_Helper_ := __OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP4964080.Date_First_Seen_),__CN('%Y%m%d')),<>,__CN('0'));
      SELF.Last_Seen_Age_Helper_Attribute_ := IF(__T(__OR(__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP4964080.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('0')),__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP4964080.Date_Last_Seen_),__CN('%Y%m%d'))))),__ECAST(KEL.typ.nint,__CN(-99998)),__ECAST(KEL.typ.nint,__FN2(KEL.Routines.DaysBetween,KEL.era.ToDate(__PP4964080.Date_Last_Seen_),__CC13226)));
      SELF.My_Date_Last_Seen_ := KEL.era.ToDate(__PP4964080.Date_Last_Seen_);
      SELF := __PP4964080;
    END;
    SELF.Rolled_Source_List_ := __PROJECT(__EE4964328,__ND4964247__Project(LEFT));
    SELF := __PP4963951;
  END;
  EXPORT __ENH_Sele_Address_4 := PROJECT(__EE4964388,__ND4964330__Project(LEFT));
END;
