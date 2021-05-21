﻿//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Business_Sele_8,B_Business_Sele_9,B_Input_B_I_I_8,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Input_B_I_I,FN_Compile FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL16.Null;
EXPORT B_Business_Sele_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Sele_8(__in,__cfg).__ENH_Business_Sele_8) __ENH_Business_Sele_8 := B_Business_Sele_8(__in,__cfg).__ENH_Business_Sele_8;
  SHARED VIRTUAL TYPEOF(B_Input_B_I_I_8(__in,__cfg).__ENH_Input_B_I_I_8) __ENH_Input_B_I_I_8 := B_Input_B_I_I_8(__in,__cfg).__ENH_Input_B_I_I_8;
  SHARED __EE826519 := __ENH_Business_Sele_8;
  SHARED __EE826521 := __ENH_Input_B_I_I_8;
  SHARED __ST224838_Layout := RECORD
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
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Reported_Names_Layout) Reported_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Stock_Tickers_Layout) Stock_Tickers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).U_R_Ls_Layout) U_R_Ls_;
    KEL.typ.ndataset(B_Business_Sele_8(__in,__cfg).__ST168172_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(B_Business_Sele_8(__in,__cfg).__ST168183_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Employee_Counts_Layout) Employee_Counts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Sale_Amounts_Layout) Sale_Amounts_;
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
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Business_Sele_8(__in,__cfg).__ST86549_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) B_I_I_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST169023_Layout) Best_N_A_I_C_S_Code1_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST169023_Layout) Best_N_A_I_C_S_Code2_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST169023_Layout) Best_N_A_I_C_S_Code3_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST169023_Layout) Best_N_A_I_C_S_Code4_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST169012_Layout) Best_Sic_Code1_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST169012_Layout) Best_Sic_Code2_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST169012_Layout) Best_Sic_Code3_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST169012_Layout) Best_Sic_Code4_Set_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nint G___Proc_Bus_U_I_D_;
    KEL.typ.nint B___Inp_Lex_I_D_Ult_;
    KEL.typ.nint B___Inp_Lex_I_D_Org_;
    KEL.typ.nint B___Inp_Lex_I_D_Legal_;
    KEL.typ.nint B___Inp_Lex_I_D_Site_;
    KEL.typ.nint B___Inp_Lex_I_D_Loc_;
    KEL.typ.nstr B___Inp_Name_;
    KEL.typ.nstr B___Inp_Alt_Name_;
    KEL.typ.nstr B___Inp_Addr_Line1_;
    KEL.typ.nstr B___Inp_Addr_Line2_;
    KEL.typ.nstr B___Inp_Addr_City_;
    KEL.typ.nstr B___Inp_Addr_State_;
    KEL.typ.nstr B___Inp_Addr_Zip_;
    KEL.typ.nstr B___Inp_Phone_;
    KEL.typ.nstr Business_T_I_N_;
    KEL.typ.nstr B___Inp_I_P_Addr_;
    KEL.typ.nstr B___Inp_U_R_L_;
    KEL.typ.nstr B___Inp_Email_;
    KEL.typ.nstr B___Inp_S_I_C_Code_;
    KEL.typ.nstr B___Inp_N_A_I_C_S_Code_;
    KEL.typ.nstr B___Inp_T_I_N_;
    KEL.typ.nstr B___Inp_Arch_Dt_;
    KEL.typ.nint B___Lex_I_D_Ult_;
    KEL.typ.nint B___Lex_I_D_Org_;
    KEL.typ.nint B___Lex_I_D_Legal_;
    KEL.typ.nint B___Lex_I_D_Site_;
    KEL.typ.nint B___Lex_I_D_Loc_;
    KEL.typ.nint B___Lex_I_D_Legal_Score_;
    KEL.typ.nint B___Lex_I_D_Legal_Wgt_;
    KEL.typ.nstr B___Inp_Cln_Name_;
    KEL.typ.nstr B___Inp_Cln_Alt_Name_;
    KEL.typ.nstr B___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr B___Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr B___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr B___Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr B___Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr B___Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr B___Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr B___Inp_Cln_Addr_City_;
    KEL.typ.nstr B___Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr B___Inp_Cln_Addr_State_;
    KEL.typ.nstr B___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr B___Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr B___Inp_Cln_Addr_Lat_;
    KEL.typ.nstr B___Inp_Cln_Addr_Lng_;
    KEL.typ.nstr B___Inp_Cln_Addr_State_Code_;
    KEL.typ.nstr B___Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr B___Inp_Cln_Addr_Geo_;
    KEL.typ.nstr B___Inp_Cln_Addr_Type_;
    KEL.typ.nstr B___Inp_Cln_Addr_Status_;
    KEL.typ.nstr B___Inp_Cln_Phone_;
    KEL.typ.nstr B___Inp_Cln_Email_;
    KEL.typ.nstr B___Inp_Cln_T_I_N_;
    KEL.typ.nint B___Inp_Cln_Arch_Dt_;
    KEL.typ.nstr Phone_Verification_Bureau_;
    KEL.typ.nstr Dial_Indicator_;
    KEL.typ.nstr Point_I_D_;
    KEL.typ.nstr N_X_X_Type_;
    KEL.typ.nbool Z_I_P_Match_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_S_C_;
    KEL.typ.nstr Wireless_Indicator_;
    KEL.typ.nstr Archive_Date_;
    KEL.typ.bool Addr_Not_Populated_ := FALSE;
    KEL.typ.nstr B___Inp_Addr_;
    KEL.typ.nstr Bus_Input_Name_Clean_Value_;
    KEL.typ.nstr Bus_Input_Phone_Clean_Value_;
    KEL.typ.nstr Bus_Input_T_I_N_Clean_Value_;
    KEL.typ.nbool City_State_Zip_Not_Populated_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC826530(B_Business_Sele_8(__in,__cfg).__ST168115_Layout __EE826519, B_Input_B_I_I_8(__in,__cfg).__ST168406_Layout __EE826521) := __EEQP(__EE826519.B_I_I_,__EE826521.UID);
  __ST224838_Layout __JT826530(B_Business_Sele_8(__in,__cfg).__ST168115_Layout __l, B_Input_B_I_I_8(__in,__cfg).__ST168406_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE826843 := JOIN(__EE826519,__EE826521,__JC826530(LEFT,RIGHT),__JT826530(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST167040_Layout := RECORD
    KEL.typ.nint S_I_C_Code_;
    KEL.typ.nint S_I_C_Code_Order_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nint Days_Since_Code_;
    KEL.typ.nbool Is_Sic_Code_;
    KEL.typ.int Source_Priority_ := 0;
    KEL.typ.nbool Within_Last24_Months_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST167051_Layout := RECORD
    KEL.typ.nint N_A_I_C_S_Code_;
    KEL.typ.nint N_A_I_C_S_Code_Order_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nint Days_Since_Code_;
    KEL.typ.nbool Is_N_A_I_C_S_Code_;
    KEL.typ.int Source_Priority_ := 0;
    KEL.typ.nbool Within_Last24_Months_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST167062_Layout := RECORD
    KEL.typ.nint Total_Employees_;
    KEL.typ.nint Employee_Count_;
    KEL.typ.nstr N_A_R_B_Employee_Code_;
    KEL.typ.nstr E_B_R_Employee_Size_Code_;
    KEL.typ.nint Estimated_Number_Of_Employees_;
    KEL.typ.nint D_C_A_Enterprise_Number_;
    KEL.typ.nint Cortera_Ultimate_Link_I_D_;
    KEL.typ.nint Equifax_I_D_;
    KEL.typ.nstr N_A_R_B_Record_I_D_;
    KEL.typ.nstr E_B_R_Number_;
    KEL.typ.nint Experian_Business_I_D_;
    KEL.typ.nstr Source_;
    KEL.typ.nkdate Date_Last_Seen_Capped_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST167078_Layout := RECORD
    KEL.typ.nint Total_Sales_;
    KEL.typ.nint Financial_Amount_Figure_;
    KEL.typ.nstr N_A_R_B_Sales_Code_;
    KEL.typ.nstr Total_Sales_Precision_;
    KEL.typ.nint Reported_Sales_;
    KEL.typ.nint Estimated_Annual_Sales_Amount_;
    KEL.typ.nint D_C_A_Enterprise_Number_;
    KEL.typ.nint Cortera_Ultimate_Link_I_D_;
    KEL.typ.nint Equifax_I_D_;
    KEL.typ.nstr N_A_R_B_Record_I_D_;
    KEL.typ.nstr E_B_R_Number_;
    KEL.typ.nint Experian_Business_I_D_;
    KEL.typ.nstr Source_;
    KEL.typ.nkdate Date_Last_Seen_Capped_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST167154_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST221654_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.bool Landlord_Tenant_Dispute_Flag_ := FALSE;
    KEL.typ.nkdate Original_Filing_Date_;
    KEL.typ.nbool Is_Federal_Tax_Lien_;
    KEL.typ.nbool Is_Other_Tax_Lien_;
    KEL.typ.nbool Is_State_Tax_Lien_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST166983_Layout := RECORD
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
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Reported_Names_Layout) Reported_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Stock_Tickers_Layout) Stock_Tickers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).U_R_Ls_Layout) U_R_Ls_;
    KEL.typ.ndataset(__ST167040_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(__ST167051_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(__ST167062_Layout) Employee_Counts_;
    KEL.typ.ndataset(__ST167078_Layout) Sale_Amounts_;
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
    KEL.typ.ndataset(__ST167154_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST221654_Layout) All_Lien_Data_;
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
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST169023_Layout) Best_N_A_I_C_S_Code1_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST169023_Layout) Best_N_A_I_C_S_Code2_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST169023_Layout) Best_N_A_I_C_S_Code3_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST169023_Layout) Best_N_A_I_C_S_Code4_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST169012_Layout) Best_Sic_Code1_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST169012_Layout) Best_Sic_Code2_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST169012_Layout) Best_Sic_Code3_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST169012_Layout) Best_Sic_Code4_Set_;
    KEL.typ.nstr Bus_Input_Name_Clean_Value_;
    KEL.typ.nstr Bus_N_A_I_C_S_Code1_;
    KEL.typ.nstr Bus_N_A_I_C_S_Code2_;
    KEL.typ.nstr Bus_N_A_I_C_S_Code3_;
    KEL.typ.nstr Bus_N_A_I_C_S_Code4_;
    KEL.typ.nstr Bus_S_I_C_Code1_;
    KEL.typ.nstr Bus_S_I_C_Code2_;
    KEL.typ.nstr Bus_S_I_C_Code3_;
    KEL.typ.nstr Bus_S_I_C_Code4_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST166983_Layout __ND826133__Project(__ST224838_Layout __PP823442) := TRANSFORM
    __EE826846 := __PP823442.S_I_C_Codes_;
    SELF.S_I_C_Codes_ := __BN(PROJECT(__T(__EE826846),__ST167040_Layout),__NL(__EE826846));
    __EE826849 := __PP823442.N_A_I_C_S_Codes_;
    SELF.N_A_I_C_S_Codes_ := __BN(PROJECT(__T(__EE826849),__ST167051_Layout),__NL(__EE826849));
    __EE826852 := __PP823442.Employee_Counts_;
    __ST167062_Layout __ND824087__Project(E_Business_Sele(__in,__cfg).Employee_Counts_Layout __PP824083) := TRANSFORM
      __CC13311 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Date_Last_Seen_Capped_ := KEL.Routines.MinN(KEL.era.ToDate(__PP824083.Date_Last_Seen_),__CC13311);
      SELF := __PP824083;
    END;
    SELF.Employee_Counts_ := __PROJECT(__EE826852,__ND824087__Project(LEFT));
    __EE826855 := __PP823442.Sale_Amounts_;
    __ST167078_Layout __ND824149__Project(E_Business_Sele(__in,__cfg).Sale_Amounts_Layout __PP824145) := TRANSFORM
      __CC13311 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Date_Last_Seen_Capped_ := KEL.Routines.MinN(KEL.era.ToDate(__PP824145.Date_Last_Seen_),__CC13311);
      SELF := __PP824145;
    END;
    SELF.Sale_Amounts_ := __PROJECT(__EE826855,__ND824149__Project(LEFT));
    __EE826858 := __PP823442.Data_Sources_;
    __ST167154_Layout __ND824239__Project(E_Business_Sele(__in,__cfg).Data_Sources_Layout __PP824235) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Source_Group(__ECAST(KEL.typ.nstr,__PP824235.Source_));
      SELF := __PP824235;
    END;
    SELF.Data_Sources_ := __PROJECT(__EE826858,__ND824239__Project(LEFT));
    __EE826131 := __PP823442.All_Lien_Data_;
    __ST221654_Layout __ND825871__Project(B_Business_Sele_8(__in,__cfg).__ST86549_Layout __PP824256) := TRANSFORM
      __CC33977 := ['CORRECTED FEDERAL TAX LIEN','FEDERAL TAX LIEN','FEDERAL TAX LIEN RELEASE','FEDERAL TAX RELEASE'];
      SELF.Is_Federal_Tax_Lien_ := __AND(__CN(__PP824256.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP824256.Filing_Type_Description_,IN,__CN(__CC33977)));
      __CC33998 := ['CITY TAX LIEN','COUNTY TAX LIEN','COUNTY TAX LIEN RELEASE','CITY TAX LIEN RELEASE','ILLINOIS TAX LIEN','ILLINOIS TAX RELEASE','PROPERTY TAX LIEN','PROPERTY TAX RELEASE'];
      SELF.Is_Other_Tax_Lien_ := __AND(__CN(__PP824256.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP824256.Filing_Type_Description_,IN,__CN(__CC33998)));
      __CC33988 := ['JUDGMENT or STATE TAX LIEN','STATE TAX LIEN','STATE TAX LIEN RELEASE','STATE TAX LIEN RENEWAL','STATE TAX LIEN RENEWED','STATE TAX RELEASE','STATE TAX WARRANT','STATE TAX WARRANT RELEASE','STATE TAX WARRANT RENEWED'];
      SELF.Is_State_Tax_Lien_ := __AND(__CN(__PP824256.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP824256.Filing_Type_Description_,IN,__CN(__CC33988)));
      SELF := __PP824256;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE826131,__ND825871__Project(LEFT));
    SELF.B___Inp_Cln_Phone_ := __PP823442.Bus_Input_Phone_Clean_Value_;
    SELF.B___Inp_Cln_T_I_N_ := __PP823442.Bus_Input_T_I_N_Clean_Value_;
    __EE826181 := __PP823442.Best_N_A_I_C_S_Code1_Set_;
    __CC13944 := '-99998';
    SELF.Bus_N_A_I_C_S_Code1_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,(__T(__EE826181))[1].N_A_I_C_S_Code_),__ECAST(KEL.typ.nstr,__CN(__CC13944)));
    __EE826198 := __PP823442.Best_N_A_I_C_S_Code2_Set_;
    SELF.Bus_N_A_I_C_S_Code2_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,(__T(__EE826198))[1].N_A_I_C_S_Code_),__ECAST(KEL.typ.nstr,__CN(__CC13944)));
    __EE826215 := __PP823442.Best_N_A_I_C_S_Code3_Set_;
    SELF.Bus_N_A_I_C_S_Code3_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,(__T(__EE826215))[1].N_A_I_C_S_Code_),__ECAST(KEL.typ.nstr,__CN(__CC13944)));
    __EE826232 := __PP823442.Best_N_A_I_C_S_Code4_Set_;
    SELF.Bus_N_A_I_C_S_Code4_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,(__T(__EE826232))[1].N_A_I_C_S_Code_),__ECAST(KEL.typ.nstr,__CN(__CC13944)));
    __EE826250 := __PP823442.Best_Sic_Code1_Set_;
    SELF.Bus_S_I_C_Code1_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,(PROJECT(__T(__EE826250),TRANSFORM({KEL.typ.nstr __value},SELF.__value:=FN_Compile(__cfg).FN_Map_Sic_Code_Padding(__ECAST(KEL.typ.nstr,LEFT.S_I_C_Code_)))))[1].__value),__ECAST(KEL.typ.nstr,__CN(__CC13944)));
    __EE826268 := __PP823442.Best_Sic_Code2_Set_;
    SELF.Bus_S_I_C_Code2_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,(PROJECT(__T(__EE826268),TRANSFORM({KEL.typ.nstr __value},SELF.__value:=FN_Compile(__cfg).FN_Map_Sic_Code_Padding(__ECAST(KEL.typ.nstr,LEFT.S_I_C_Code_)))))[1].__value),__ECAST(KEL.typ.nstr,__CN(__CC13944)));
    __EE826286 := __PP823442.Best_Sic_Code3_Set_;
    SELF.Bus_S_I_C_Code3_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,(PROJECT(__T(__EE826286),TRANSFORM({KEL.typ.nstr __value},SELF.__value:=FN_Compile(__cfg).FN_Map_Sic_Code_Padding(__ECAST(KEL.typ.nstr,LEFT.S_I_C_Code_)))))[1].__value),__ECAST(KEL.typ.nstr,__CN(__CC13944)));
    __EE826304 := __PP823442.Best_Sic_Code4_Set_;
    SELF.Bus_S_I_C_Code4_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,(PROJECT(__T(__EE826304),TRANSFORM({KEL.typ.nstr __value},SELF.__value:=FN_Compile(__cfg).FN_Map_Sic_Code_Padding(__ECAST(KEL.typ.nstr,LEFT.S_I_C_Code_)))))[1].__value),__ECAST(KEL.typ.nstr,__CN(__CC13944)));
    SELF := __PP823442;
  END;
  EXPORT __ENH_Business_Sele_7 := PROJECT(__EE826843,__ND826133__Project(LEFT));
END;
