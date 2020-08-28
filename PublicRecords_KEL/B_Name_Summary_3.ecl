//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT B_Input_P_I_I_4,B_Name_Summary_4,CFG_Compile,E_Address,E_Geo_Link,E_Input_P_I_I,E_Person,E_Property,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Name_Summary_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4;
  SHARED VIRTUAL TYPEOF(B_Name_Summary_4(__in,__cfg).__ENH_Name_Summary_4) __ENH_Name_Summary_4 := B_Name_Summary_4(__in,__cfg).__ENH_Name_Summary_4;
  SHARED __EE4054127 := __ENH_Name_Summary_4;
  EXPORT __ST182430_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Translated_Source_Code_;
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
  EXPORT __ST61256_Layout := RECORD
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.nstr Source_Date_First_Seen_;
    KEL.typ.nstr Source_Date_Last_Seen_;
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
  EXPORT __ST182423_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(__ST182430_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST61256_Layout) Name_Summary_Source_List_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST61207_Layout) Translated_Sources_;
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
  SHARED __ST182423_Layout __ND4054108__Project(B_Name_Summary_4(__in,__cfg).__ST192651_Layout __PP4053975) := TRANSFORM
    __EE4054130 := __PP4053975.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE4054130),__ST182430_Layout),__NL(__EE4054130));
    __EE4054133 := __PP4053975.Translated_Sources_;
    __ST61256_Layout __ND4054079__Project(B_Name_Summary_4(__in,__cfg).__ST61207_Layout __PP4054019) := TRANSFORM
      __CC10943 := '-99997';
      SELF.Source_Date_First_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP4054019.Date_First_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP4054019.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC10943)));
      __CC10523 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('pii_corr_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Source_Date_Last_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP4054019.Date_Last_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP4054019.Date_Last_Seen_),__CC10523),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC10943)));
      SELF := __PP4054019;
    END;
    SELF.Name_Summary_Source_List_ := __PROJECT(__EE4054133,__ND4054079__Project(LEFT));
    __EE4054105 := __ENH_Input_P_I_I_4;
    SELF.P_I_I_ := (__EE4054105)[1].UID;
    SELF := __PP4053975;
  END;
  EXPORT __ENH_Name_Summary_3 := PROJECT(__EE4054127,__ND4054108__Project(LEFT));
END;
