//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Sele_Address_4,CFG_Compile,E_Address,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Geo_Link,E_Sele_Address,E_Zip_Code FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_Address_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Address_4(__in,__cfg).__ENH_Sele_Address_4) __ENH_Sele_Address_4 := B_Sele_Address_4(__in,__cfg).__ENH_Sele_Address_4;
  SHARED __EE1058343 := __ENH_Sele_Address_4;
  EXPORT __ST157196_Layout := RECORD
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
  EXPORT __ST450300_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nint Age_Helper_Attribute_;
    KEL.typ.nbool Age_Is_Not_Zero_Helper_;
    KEL.typ.nint Last_Seen_Age_Helper_Attribute_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST157140_Layout := RECORD
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
    KEL.typ.ndataset(__ST157196_Layout) Data_Sources_;
    KEL.typ.nbool Matches_Is_Best_Helper_Attr_;
    KEL.typ.ndataset(__ST450300_Layout) Rolled_Source_List_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST157140_Layout __ND1058348__Project(B_Sele_Address_4(__in,__cfg).__ST160787_Layout __PP1058344) := TRANSFORM
    __EE1058431 := __PP1058344.Data_Sources_;
    SELF.Data_Sources_ := __PROJECT(__EE1058431,__ST157196_Layout);
    __EE1058461 := __PP1058344.Rolled_Source_List_;
    __ST450300_Layout __ND1058466__Project(B_Sele_Address_4(__in,__cfg).__ST350102_Layout __PP1058462) := TRANSFORM
      SELF.My_Date_First_Seen_ := KEL.era.ToDate(__PP1058462.Date_First_Seen_);
      SELF := __PP1058462;
    END;
    SELF.Rolled_Source_List_ := __PROJECT(__EE1058461,__ND1058466__Project(LEFT));
    SELF := __PP1058344;
  END;
  EXPORT __ENH_Sele_Address_3 := PROJECT(__EE1058343,__ND1058348__Project(LEFT));
END;
