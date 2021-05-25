﻿//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Business_Sele_7,B_Business_Sele_9,CFG_Compile,E_Address,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Geo_Link,E_Input_B_I_I,E_Phone,E_Sele_Address,E_Sele_Phone_Number,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_Phone_Number_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Sele_7(__in,__cfg).__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7(__in,__cfg).__ENH_Business_Sele_7;
  SHARED VIRTUAL TYPEOF(E_Sele_Phone_Number(__in,__cfg).__Result) __E_Sele_Phone_Number := E_Sele_Phone_Number(__in,__cfg).__Result;
  SHARED __EE371387 := __E_Sele_Phone_Number;
  SHARED __EE1945111 := __ENH_Business_Sele_7;
  SHARED __ST371531_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).Best_Phone_Details_Layout) Best_Phone_Details_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).Phone_Details_Layout) Phone_Details_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).Marketability_Layout) Marketability_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).S_I_C_Codes_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).N_A_I_C_S_Codes_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).Data_Sources_Layout) Data_Sources_;
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
    KEL.typ.ndataset(E_Sele_Address(__in,__cfg).Best_Addresses_Layout) Best_Addresses_;
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
  __JC1945117(E_Sele_Phone_Number(__in,__cfg).Layout __EE371387, B_Business_Sele_7(__in,__cfg).__ST221981_Layout __EE1945111) := __EEQP(__EE371387.Legal_,__EE1945111.UID);
  __ST371531_Layout __JT1945117(E_Sele_Phone_Number(__in,__cfg).Layout __l, B_Business_Sele_7(__in,__cfg).__ST221981_Layout __r) := TRANSFORM
    SELF.S_I_C_Codes__1_ := __r.S_I_C_Codes_;
    SELF.N_A_I_C_S_Codes__1_ := __r.N_A_I_C_S_Codes_;
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1945118 := JOIN(__EE371387,__EE1945111,__JC1945117(LEFT,RIGHT),__JT1945117(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST220942_Layout := RECORD
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
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
  EXPORT __ST220904_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Phone().Typ) Phone_Number_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).Best_Phone_Details_Layout) Best_Phone_Details_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).Phone_Details_Layout) Phone_Details_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).Marketability_Layout) Marketability_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).S_I_C_Codes_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(E_Sele_Phone_Number(__in,__cfg).N_A_I_C_S_Codes_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(__ST220942_Layout) Data_Sources_;
    KEL.typ.nbool Input_Phone_Match_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST220904_Layout __ND1945477__Project(__ST371531_Layout __PP1945119) := TRANSFORM
    __EE1945526 := __PP1945119.Data_Sources_;
    __ST220942_Layout __ND1945531__Project(E_Sele_Phone_Number(__in,__cfg).Data_Sources_Layout __PP1945527) := TRANSFORM
      SELF.My_Date_First_Seen_ := KEL.era.ToDate(__PP1945527.Date_First_Seen_);
      SELF.My_Date_Last_Seen_ := KEL.era.ToDate(__PP1945527.Date_Last_Seen_);
      SELF.Translated_Source_ := FN_Compile(__cfg).FN_Source_Group(__ECAST(KEL.typ.nstr,__PP1945527.Source_));
      SELF := __PP1945527;
    END;
    SELF.Data_Sources_ := __PROJECT(__EE1945526,__ND1945531__Project(LEFT));
    SELF.Input_Phone_Match_ := FN_Compile(__cfg).FN_Is_Phone_Match(__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,__PP1945119.Phone_Number_)),__ECAST(KEL.typ.nstr,__PP1945119.B___Inp_Cln_Phone_));
    SELF := __PP1945119;
  END;
  EXPORT __ENH_Sele_Phone_Number_6 := PROJECT(__EE1945118,__ND1945477__Project(LEFT));
END;
