//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Sele_Address_2,B_Sele_Address_3,CFG_Compile,E_Address,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Geo_Link,E_Sele_Address,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_Address_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Address_2(__in,__cfg).__ENH_Sele_Address_2) __ENH_Sele_Address_2 := B_Sele_Address_2(__in,__cfg).__ENH_Sele_Address_2;
  SHARED __EE3217002 := __ENH_Sele_Address_2;
  EXPORT __ST174267_Layout := RECORD
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.nkdate Date_First_Seen_Company_Address_;
    KEL.typ.nkdate Date_Last_Seen_Company_Address_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST1435342_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nint Age_Helper_Attribute_;
    KEL.typ.nbool Age_Is_Not_Zero_Helper_;
    KEL.typ.nint Last_Seen_Age_Helper_Attribute_;
    KEL.typ.nstr Translated_Date_First_Seen_;
    KEL.typ.nstr Translated_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST174211_Layout := RECORD
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
    KEL.typ.ndataset(__ST174267_Layout) Data_Sources_;
    KEL.typ.bool Is_P_O_Box_B_I_P_ := FALSE;
    KEL.typ.nbool Matches_Is_Best_Helper_Attr_;
    KEL.typ.ndataset(__ST1435342_Layout) Rolled_Source_List_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST174211_Layout __ND3216944__Project(B_Sele_Address_2(__in,__cfg).__ST184780_Layout __PP3216554) := TRANSFORM
    __EE3217005 := __PP3216554.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE3217005),__ST174267_Layout),__NL(__EE3217005));
    __BS3216669 := __T(__PP3216554.Address_Record_Type_);
    SELF.Is_P_O_Box_B_I_P_ := EXISTS(__BS3216669(__T(__OP2(__T(__PP3216554.Address_Record_Type_).Rec_Type_,=,__CN('P')))));
    __EE3216942 := __PP3216554.Rolled_Source_List_;
    __ST1435342_Layout __ND3216866__Project(B_Sele_Address_3(__in,__cfg).__ST793236_Layout __PP3216683) := TRANSFORM
      __CC13952 := '-99997';
      SELF.Translated_Date_First_Seen_ := IF(__T(__OR(__NT(__PP3216683.My_Date_First_Seen_),__OP2(__FN2(KEL.Routines.DateToString,__PP3216683.My_Date_First_Seen_,__CN('%Y%m%d')),IN,__CN(['','0'])))),__ECAST(KEL.typ.nstr,__CN(__CC13952)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP3216683.Date_First_Seen_),__CN('%Y%m%d'))));
      __CC13311 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Translated_Date_Last_Seen_ := IF(__T(__OR(__NT(__PP3216683.My_Date_Last_Seen_),__OP2(__FN2(KEL.Routines.DateToString,__PP3216683.My_Date_Last_Seen_,__CN('%Y%m%d')),IN,__CN(['','0'])))),__ECAST(KEL.typ.nstr,__CN(__CC13952)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(__CC13311,KEL.era.ToDate(__PP3216683.Date_Last_Seen_)),__CN('%Y%m%d'))));
      SELF := __PP3216683;
    END;
    SELF.Rolled_Source_List_ := __FILTER(__PROJECT(__EE3216942,__ND3216866__Project(LEFT)),__NN(Source_) OR __NN(Age_Helper_Attribute_) OR __NN(Age_Is_Not_Zero_Helper_) OR __NN(Last_Seen_Age_Helper_Attribute_) OR __NN(Translated_Date_First_Seen_) OR __NN(Translated_Date_Last_Seen_));
    SELF := __PP3216554;
  END;
  EXPORT __ENH_Sele_Address_1 := PROJECT(__EE3217002,__ND3216944__Project(LEFT));
END;
