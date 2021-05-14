//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Sele_Address_6,CFG_Compile,E_Address,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Geo_Link,E_Sele_Address,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_Address_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Address_6(__in,__cfg).__ENH_Sele_Address_6) __ENH_Sele_Address_6 := B_Sele_Address_6(__in,__cfg).__ENH_Sele_Address_6;
  SHARED __EE1987998 := __ENH_Sele_Address_6;
  EXPORT __ST212147_Layout := RECORD
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
  EXPORT __ST110401_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST212091_Layout := RECORD
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
    KEL.typ.ndataset(__ST212147_Layout) Data_Sources_;
    KEL.typ.nbool Input_Address_Match_;
    KEL.typ.nbool Matches_Is_Best_Helper_Attr_;
    KEL.typ.ndataset(__ST110401_Layout) Rolled_Source_List_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST212091_Layout __ND1988003__Project(B_Sele_Address_6(__in,__cfg).__ST215466_Layout __PP1987999) := TRANSFORM
    __EE1988087 := __PP1987999.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE1988087),__ST212147_Layout),__NL(__EE1988087));
    __EE1988127 := __PP1987999.Data_Sources_;
    __BS1988128 := __T(__EE1988127);
    __EE1988133 := __BS1988128(__T(__T(__EE1988127).Header_Hit_Flag_));
    SELF.Rolled_Source_List_ := __CN(PROJECT(TABLE(PROJECT(__EE1988133,TRANSFORM(__ST110401_Layout,SELF.Source_ := LEFT.Translated_Source_,SELF := LEFT))(__NN(Source_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_,MERGE),__ST110401_Layout));
    SELF := __PP1987999;
  END;
  EXPORT __ENH_Sele_Address_5 := PROJECT(PROJECT(__EE1987998,__ND1988003__Project(LEFT)),__ST212091_Layout);
END;
