//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Sele_Address_3,CFG_Compile,E_Address,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Geo_Link,E_Sele_Address,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_Address_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Address_3(__in,__cfg).__ENH_Sele_Address_3) __ENH_Sele_Address_3 := B_Sele_Address_3(__in,__cfg).__ENH_Sele_Address_3;
  SHARED __EE2866097 := __ENH_Sele_Address_3;
  EXPORT __ST183581_Layout := RECORD
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
  EXPORT __ST183525_Layout := RECORD
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
    KEL.typ.ndataset(__ST183581_Layout) Data_Sources_;
    KEL.typ.nbool Matches_Is_Best_Helper_Attr_;
    KEL.typ.ndataset(B_Sele_Address_3(__in,__cfg).__ST791752_Layout) Rolled_Source_List_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST183525_Layout __ND2866102__Project(B_Sele_Address_3(__in,__cfg).__ST193133_Layout __PP2866098) := TRANSFORM
    __EE2866192 := __PP2866098.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE2866192),__ST183581_Layout),__NL(__EE2866192));
    SELF := __PP2866098;
  END;
  EXPORT __ENH_Sele_Address_2 := PROJECT(__EE2866097,__ND2866102__Project(LEFT));
END;
