//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Business_Sele_7,B_Business_Sele_9,CFG_Compile,E_Address,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Geo_Link,E_Input_B_I_I,E_Sele_Address,E_Sele_T_I_N,E_T_I_N,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_T_I_N_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Sele_7(__in,__cfg).__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7(__in,__cfg).__ENH_Business_Sele_7;
  SHARED VIRTUAL TYPEOF(E_Sele_T_I_N(__in,__cfg).__Result) __E_Sele_T_I_N := E_Sele_T_I_N(__in,__cfg).__Result;
  SHARED __EE516426 := __E_Sele_T_I_N;
  SHARED __EE5582863 := __ENH_Business_Sele_7;
  SHARED __ST516498_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_T_I_N().Typ) Tax_I_D_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nint Best_T_I_N_;
    KEL.typ.nint Best_T_I_N_Rank_;
    KEL.typ.ndataset(E_Sele_T_I_N(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D__1_;
    KEL.typ.nint Org_I_D__1_;
    KEL.typ.nint Sele_I_D__1_;
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
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST269428_Layout) Reported_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Stock_Tickers_Layout) Stock_Tickers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).U_R_Ls_Layout) U_R_Ls_;
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST269457_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST269468_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST269479_Layout) Employee_Counts_;
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST269496_Layout) Sale_Amounts_;
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
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST269573_Layout) Data_Sources__1_;
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST424344_Layout) All_Lien_Data_;
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
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST275024_Layout) Best_N_A_I_C_S_Code1_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST275024_Layout) Best_N_A_I_C_S_Code2_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST275024_Layout) Best_N_A_I_C_S_Code3_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST275024_Layout) Best_N_A_I_C_S_Code4_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST275013_Layout) Best_Sic_Code1_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST275013_Layout) Best_Sic_Code2_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST275013_Layout) Best_Sic_Code3_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST275013_Layout) Best_Sic_Code4_Set_;
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
  __JC5582869(E_Sele_T_I_N(__in,__cfg).Layout __EE516426, B_Business_Sele_7(__in,__cfg).__ST269390_Layout __EE5582863) := __EEQP(__EE516426.Legal_,__EE5582863.UID);
  __ST516498_Layout __JT5582869(E_Sele_T_I_N(__in,__cfg).Layout __l, B_Business_Sele_7(__in,__cfg).__ST269390_Layout __r) := TRANSFORM
    SELF.Ult_I_D__1_ := __r.Ult_I_D_;
    SELF.Org_I_D__1_ := __r.Org_I_D_;
    SELF.Sele_I_D__1_ := __r.Sele_I_D_;
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE5582870 := JOIN(__EE516426,__EE5582863,__JC5582869(LEFT,RIGHT),__JT5582869(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST268350_Layout := RECORD
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
  EXPORT __ST268341_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_T_I_N().Typ) Tax_I_D_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nint Best_T_I_N_;
    KEL.typ.nint Best_T_I_N_Rank_;
    KEL.typ.ndataset(__ST268350_Layout) Data_Sources_;
    KEL.typ.nbool Input_T_I_N_Match_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST268341_Layout __ND5583586__Project(__ST516498_Layout __PP5582871) := TRANSFORM
    __EE5583232 := __PP5582871.Data_Sources_;
    __ST268350_Layout __ND5583237__Project(E_Sele_T_I_N(__in,__cfg).Data_Sources_Layout __PP5583233) := TRANSFORM
      SELF.My_Date_First_Seen_ := KEL.era.ToDate(__PP5583233.Date_First_Seen_);
      SELF.My_Date_Last_Seen_ := KEL.era.ToDate(__PP5583233.Date_Last_Seen_);
      SELF.Translated_Source_ := FN_Compile(__cfg).FN_Source_Group(__ECAST(KEL.typ.nstr,__PP5583233.Source_));
      SELF := __PP5583233;
    END;
    SELF.Data_Sources_ := __PROJECT(__EE5583232,__ND5583237__Project(LEFT));
    SELF.Input_T_I_N_Match_ := FN_Compile(__cfg).FN_Edit_Distance_Within_Radius(__ECAST(KEL.typ.nstr,__PP5582871.Tax_I_D_),__ECAST(KEL.typ.nstr,__PP5582871.B___Inp_Cln_T_I_N_),__ECAST(KEL.typ.nint,__CN(2)));
    SELF := __PP5582871;
  END;
  EXPORT __ENH_Sele_T_I_N_6 := PROJECT(__EE5582870,__ND5583586__Project(LEFT));
END;
