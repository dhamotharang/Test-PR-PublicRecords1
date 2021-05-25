﻿//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Business_Sele_7,B_Business_Sele_9,CFG_Compile,E_Address,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Geo_Link,E_Input_B_I_I,E_Sele_Address,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_Address_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Sele_7(__in,__cfg).__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7(__in,__cfg).__ENH_Business_Sele_7;
  SHARED VIRTUAL TYPEOF(E_Sele_Address(__in,__cfg).__Result) __E_Sele_Address := E_Sele_Address(__in,__cfg).__Result;
  SHARED __EE369184 := __E_Sele_Address;
  SHARED __EE1943040 := __ENH_Business_Sele_7;
  SHARED __ST369485_Layout := RECORD
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
    KEL.typ.ndataset(E_Sele_Address(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ntyp(E_Business_Org().Typ) Sele_Org_;
    KEL.typ.ntyp(E_Business_Sele_Overflow().Typ) Sele_Overflow_;
    KEL.typ.nbool Sele_Gold_;
    KEL.typ.nbool Is_Sele_Level_;
    KEL.typ.nbool Is_Org_Level_;
    KEL.typ.nbool Is_Ult_Level_;
    KEL.typ.nstr Sele_Segment_;
    KEL.typ.nbool Is_Corporation_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Business_Structure_Layout) Business_Structure_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Ownership_Layout) Ownership_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Industry_Layout) Industry_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Company_Statuses_Layout) Company_Statuses_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Age_Layout) Age_;
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST222019_Layout) Reported_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Stock_Tickers_Layout) Stock_Tickers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).U_R_Ls_Layout) U_R_Ls_;
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST222048_Layout) S_I_C_Codes__1_;
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST222059_Layout) N_A_I_C_S_Codes__1_;
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST222070_Layout) Employee_Counts_;
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST222087_Layout) Sale_Amounts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Earning_Amounts_Layout) Earning_Amounts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Asset_Amounts_Layout) Asset_Amounts_;
    KEL.typ.nkdate B_B_B_Member_Since_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).B_B_B_Categories_Layout) B_B_B_Categories_;
    KEL.typ.nstr For_Profit_Indicator_;
    KEL.typ.nstr Public_Or_Private_Indicator_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Non_Profit_Layout) Non_Profit_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_Company_Names_Layout) Best_Company_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_S_I_C_Codes_Layout) Best_S_I_C_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_N_A_I_C_S_Codes_Layout) Best_N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Business_Characteristics_Layout) Business_Characteristics_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Experian_C_R_D_B_Tradelines_Layout) Experian_C_R_D_B_Tradelines_;
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST222164_Layout) Data_Sources__1_;
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST305692_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) B_I_I_;
    KEL.typ.nstr B___Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr B___Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr B___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr B___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr B___Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr B___Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr B___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr B___Inp_Cln_Phone_;
    KEL.typ.nstr B___Inp_Cln_T_I_N_;
    KEL.typ.ndataset(E_Sele_Address(__in,__cfg).Best_Addresses_Layout) Best_Addresses__1_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST225265_Layout) Best_N_A_I_C_S_Code1_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST225265_Layout) Best_N_A_I_C_S_Code2_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST225265_Layout) Best_N_A_I_C_S_Code3_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST225265_Layout) Best_N_A_I_C_S_Code4_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST225254_Layout) Best_Sic_Code1_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST225254_Layout) Best_Sic_Code2_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST225254_Layout) Best_Sic_Code3_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST225254_Layout) Best_Sic_Code4_Set_;
    KEL.typ.nstr Bus_Input_Name_Clean_Value_;
    KEL.typ.nstr Bus_N_A_I_C_S_Code1_;
    KEL.typ.nstr Bus_N_A_I_C_S_Code2_;
    KEL.typ.nstr Bus_N_A_I_C_S_Code3_;
    KEL.typ.nstr Bus_N_A_I_C_S_Code4_;
    KEL.typ.nstr Bus_S_I_C_Code1_;
    KEL.typ.nstr Bus_S_I_C_Code2_;
    KEL.typ.nstr Bus_S_I_C_Code3_;
    KEL.typ.nstr Bus_S_I_C_Code4_;
    E_Sele_Address(__in,__cfg).Best_Addresses_Layout Only_Best_Address_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1943046(E_Sele_Address(__in,__cfg).Layout __EE369184, B_Business_Sele_7(__in,__cfg).__ST221981_Layout __EE1943040) := __EEQP(__EE369184.Legal_,__EE1943040.UID);
  __ST369485_Layout __JT1943046(E_Sele_Address(__in,__cfg).Layout __l, B_Business_Sele_7(__in,__cfg).__ST221981_Layout __r) := TRANSFORM
    SELF.S_I_C_Codes__1_ := __r.S_I_C_Codes_;
    SELF.N_A_I_C_S_Codes__1_ := __r.N_A_I_C_S_Codes_;
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF.Best_Addresses__1_ := __r.Best_Addresses_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1943047 := JOIN(__EE369184,__EE1943040,__JC1943046(LEFT,RIGHT),__JT1943046(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST220805_Layout := RECORD
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
  EXPORT __ST220749_Layout := RECORD
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
    KEL.typ.ndataset(__ST220805_Layout) Data_Sources_;
    KEL.typ.nbool Input_Address_Match_;
    KEL.typ.nbool Matches_Is_Best_Helper_Attr_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST220749_Layout __ND1944097__Project(__ST369485_Layout __PP1943048) := TRANSFORM
    __EE1943510 := __PP1943048.Data_Sources_;
    __ST220805_Layout __ND1943515__Project(E_Sele_Address(__in,__cfg).Data_Sources_Layout __PP1943511) := TRANSFORM
      SELF.My_Date_First_Seen_ := KEL.era.ToDate(__PP1943511.Date_First_Seen_);
      SELF.My_Date_Last_Seen_ := KEL.era.ToDate(__PP1943511.Date_Last_Seen_);
      SELF.Translated_Source_ := FN_Compile(__cfg).FN_Source_Group(__ECAST(KEL.typ.nstr,__PP1943511.Source_));
      SELF := __PP1943511;
    END;
    SELF.Data_Sources_ := __PROJECT(__EE1943510,__ND1943515__Project(LEFT));
    SELF.Input_Address_Match_ := __AND(__AND(__AND(__AND(__AND(__AND(FN_Compile(__cfg).FN_Is_Null_Or_Equal(__ECAST(KEL.typ.nunk,__PP1943048.Primary_Range_),__ECAST(KEL.typ.nunk,__PP1943048.B___Inp_Cln_Addr_Prim_Rng_)),FN_Compile(__cfg).FN_Is_Null_Or_Equal(__ECAST(KEL.typ.nunk,__PP1943048.Predirectional_),__ECAST(KEL.typ.nunk,__PP1943048.B___Inp_Cln_Addr_Pre_Dir_))),FN_Compile(__cfg).FN_Is_Null_Or_Equal(__ECAST(KEL.typ.nunk,__PP1943048.Primary_Name_),__ECAST(KEL.typ.nunk,__PP1943048.B___Inp_Cln_Addr_Prim_Name_))),FN_Compile(__cfg).FN_Is_Null_Or_Equal(__ECAST(KEL.typ.nunk,__PP1943048.Suffix_),__ECAST(KEL.typ.nunk,__PP1943048.B___Inp_Cln_Addr_Sffx_))),FN_Compile(__cfg).FN_Is_Null_Or_Equal(__ECAST(KEL.typ.nunk,__PP1943048.Postdirectional_),__ECAST(KEL.typ.nunk,__PP1943048.B___Inp_Cln_Addr_Post_Dir_))),FN_Compile(__cfg).FN_Is_Null_Or_Equal(__ECAST(KEL.typ.nunk,__PP1943048.Z_I_P5_),__ECAST(KEL.typ.nunk,__PP1943048.B___Inp_Cln_Addr_Zip5_))),FN_Compile(__cfg).FN_Is_Null_Or_Equal(__ECAST(KEL.typ.nunk,__PP1943048.Secondary_Range_),__ECAST(KEL.typ.nunk,__PP1943048.B___Inp_Cln_Addr_Sec_Rng_)));
    SELF.Matches_Is_Best_Helper_Attr_ := __AND(__AND(__AND(__AND(__AND(__CN(__DEFAULT(__PP1943048.Only_Best_Address_.Best_Primary_Range_,'') = __DEFAULT(__PP1943048.Primary_Range_,'') AND __DEFAULT(__PP1943048.Only_Best_Address_.Best_Predirectional_,'') = __DEFAULT(__PP1943048.Predirectional_,'')),__OP2(__PP1943048.Only_Best_Address_.Best_Primary_Name_,=,__PP1943048.Primary_Name_)),__CN(__DEFAULT(__PP1943048.Only_Best_Address_.Best_Suffix_,'') = __DEFAULT(__PP1943048.Suffix_,''))),__CN(__DEFAULT(__PP1943048.Only_Best_Address_.Best_Postdirectional_,'') = __DEFAULT(__PP1943048.Postdirectional_,''))),__OP2(__PP1943048.Z_I_P5_,=,__PP1943048.Only_Best_Address_.Best_Zip5_)),__CN(__DEFAULT(__PP1943048.Only_Best_Address_.Best_Secondary_Range_,'') = __DEFAULT(__PP1943048.Secondary_Range_,'')));
    SELF := __PP1943048;
  END;
  EXPORT __ENH_Sele_Address_6 := PROJECT(__EE1943047,__ND1944097__Project(LEFT));
END;
