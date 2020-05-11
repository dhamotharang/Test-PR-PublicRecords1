//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Sele_Address_6,CFG_Compile,E_Address,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Geo_Link,E_Sele_Address,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Sele_Address_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Address_6().__ENH_Sele_Address_6) __ENH_Sele_Address_6 := B_Sele_Address_6(__in,__cfg).__ENH_Sele_Address_6;
  SHARED __EE512184 := __ENH_Sele_Address_6;
  EXPORT __ST161174_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST511086_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nint Age_Helper_Attribute_;
    KEL.typ.nbool Age_Is_Not_Zero_Helper_;
    KEL.typ.nint Last_Seen_Age_Helper_Attribute_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST161118_Layout := RECORD
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
    KEL.typ.ndataset(__ST161174_Layout) Data_Sources_;
    KEL.typ.nbool Input_Address_Match_;
    KEL.typ.nbool Matches_Is_Best_Helper_Attr_;
    KEL.typ.ndataset(__ST511086_Layout) Rolled_Source_List_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST161118_Layout __ND512126__Project(B_Sele_Address_6(__in,__cfg).__ST164482_Layout __PP511097) := TRANSFORM
    __EE512187 := __PP511097.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE512187),__ST161174_Layout),__NL(__EE512187));
    __EE512124 := __PP511097.Rolled_Source_List_;
    __ST511086_Layout __ND512044__Project(B_Sele_Address_6(__in,__cfg).__ST82346_Layout __PP511546) := TRANSFORM
      __CC9135 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Age_Helper_Attribute_ := IF(__T(__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP511546.Date_First_Seen_),__CN('%Y%m%d')),=,__CN('0'))),__ECAST(KEL.typ.nint,__CN(-99998)),__ECAST(KEL.typ.nint,__FN2(KEL.Routines.DaysBetween,KEL.era.ToDate(__PP511546.Date_First_Seen_),__CC9135)));
      SELF.Age_Is_Not_Zero_Helper_ := __OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP511546.Date_First_Seen_),__CN('%Y%m%d')),<>,__CN('0'));
      SELF.Last_Seen_Age_Helper_Attribute_ := IF(__T(__OR(__OP2(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP511546.Date_Last_Seen_),__CN('%Y%m%d')),=,__CN('0')),__NT(__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP511546.Date_Last_Seen_),__CN('%Y%m%d'))))),__ECAST(KEL.typ.nint,__CN(-99998)),__ECAST(KEL.typ.nint,__FN2(KEL.Routines.DaysBetween,KEL.era.ToDate(__PP511546.Date_Last_Seen_),__CC9135)));
      SELF := __PP511546;
    END;
    SELF.Rolled_Source_List_ := __PROJECT(__EE512124,__ND512044__Project(LEFT));
    SELF := __PP511097;
  END;
  EXPORT __ENH_Sele_Address_5 := PROJECT(__EE512184,__ND512126__Project(LEFT));
END;
