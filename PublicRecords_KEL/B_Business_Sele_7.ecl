//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Business_Sele_8,B_Business_Sele_9,B_Input_B_I_I_8,CFG_Compile,E_Address,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Geo_Link,E_Input_B_I_I,E_Sele_Address,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Business_Sele_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Sele_8(__in,__cfg).__ENH_Business_Sele_8) __ENH_Business_Sele_8 := B_Business_Sele_8(__in,__cfg).__ENH_Business_Sele_8;
  SHARED VIRTUAL TYPEOF(B_Input_B_I_I_8(__in,__cfg).__ENH_Input_B_I_I_8) __ENH_Input_B_I_I_8 := B_Input_B_I_I_8(__in,__cfg).__ENH_Input_B_I_I_8;
  SHARED __EE5090757 := __ENH_Business_Sele_8;
  SHARED __EE5090759 := __ENH_Input_B_I_I_8;
  SHARED __ST377531_Layout := RECORD
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
    KEL.typ.ndataset(B_Business_Sele_8(__in,__cfg).__ST260737_Layout) Reported_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Stock_Tickers_Layout) Stock_Tickers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).U_R_Ls_Layout) U_R_Ls_;
    KEL.typ.ndataset(B_Business_Sele_8(__in,__cfg).__ST260760_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(B_Business_Sele_8(__in,__cfg).__ST260771_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(B_Business_Sele_8(__in,__cfg).__ST260782_Layout) Employee_Counts_;
    KEL.typ.ndataset(B_Business_Sele_8(__in,__cfg).__ST260798_Layout) Sale_Amounts_;
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
    KEL.typ.ndataset(B_Business_Sele_8(__in,__cfg).__ST347990_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) B_I_I_;
    KEL.typ.ndataset(E_Sele_Address(__in,__cfg).Best_Addresses_Layout) Best_Addresses_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST263151_Layout) Best_N_A_I_C_S_Code1_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST263151_Layout) Best_N_A_I_C_S_Code2_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST263151_Layout) Best_N_A_I_C_S_Code3_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST263151_Layout) Best_N_A_I_C_S_Code4_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST263140_Layout) Best_Sic_Code1_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST263140_Layout) Best_Sic_Code2_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST263140_Layout) Best_Sic_Code3_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST263140_Layout) Best_Sic_Code4_Set_;
    KEL.typ.nstr Bus_Input_Name_Clean_Value_;
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
    KEL.typ.nstr Bus_Input_Name_Clean_Value__1_;
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
  __JC5090768(B_Business_Sele_8(__in,__cfg).__ST260699_Layout __EE5090757, B_Input_B_I_I_8(__in,__cfg).__ST261022_Layout __EE5090759) := __EEQP(__EE5090757.B_I_I_,__EE5090759.UID);
  __ST377531_Layout __JT5090768(B_Business_Sele_8(__in,__cfg).__ST260699_Layout __l, B_Input_B_I_I_8(__in,__cfg).__ST261022_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF.Bus_Input_Name_Clean_Value__1_ := __r.Bus_Input_Name_Clean_Value_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE5091113 := JOIN(__EE5090757,__EE5090759,__JC5090768(LEFT,RIGHT),__JT5090768(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST257622_Layout := RECORD
    KEL.typ.nstr Name_;
    KEL.typ.nstr Name_Type_;
    KEL.typ.nstr Name_Status_;
    KEL.typ.nstr Corporation_Legal_Name_;
    KEL.typ.nstr Doing_Business_As_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Corporation_Legal_Name_Match_;
    KEL.typ.nfloat Corporation_Legal_Name_Similarity_;
    KEL.typ.nbool Doing_Business_As_Match_;
    KEL.typ.nfloat Doing_Business_As_Similarity_;
    KEL.typ.nbool Name_Match_;
    KEL.typ.nfloat Name_Similarity_;
    KEL.typ.nstr Slim_Corporation_Legal_Name_;
    KEL.typ.nstr Slim_Doing_Business_As_;
    KEL.typ.nstr Slim_Inp_Cln_Name_;
    KEL.typ.nstr Slim_Name_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST257651_Layout := RECORD
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
  EXPORT __ST257662_Layout := RECORD
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
  EXPORT __ST257673_Layout := RECORD
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
    KEL.typ.nint Age_In_Days_;
    KEL.typ.nkdate Date_Last_Seen_Capped_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST257690_Layout := RECORD
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
    KEL.typ.nint Age_In_Days_;
    KEL.typ.nkdate Date_Last_Seen_Capped_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST257767_Layout := RECORD
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
  EXPORT __ST373969_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.bool Landlord_Tenant_Dispute_Flag_ := FALSE;
    KEL.typ.nkdate Original_Filing_Date_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.nbool Is_Civil_Court_Judgment_;
    KEL.typ.nbool Is_Federal_Tax_Lien_;
    KEL.typ.nbool Is_Foreclosure_Judgment_;
    KEL.typ.nbool Is_Other_Lien_;
    KEL.typ.nbool Is_Other_Tax_Lien_;
    KEL.typ.nbool Is_Over_All_Judgment_;
    KEL.typ.nbool Is_Over_All_Lien_;
    KEL.typ.nbool Is_Small_Cliams_Judgment_;
    KEL.typ.nbool Is_State_Tax_Lien_;
    KEL.typ.nbool Is_Total_Tax_Lien_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST257584_Layout := RECORD
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
    KEL.typ.ndataset(__ST257622_Layout) Reported_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Stock_Tickers_Layout) Stock_Tickers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).U_R_Ls_Layout) U_R_Ls_;
    KEL.typ.ndataset(__ST257651_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(__ST257662_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(__ST257673_Layout) Employee_Counts_;
    KEL.typ.ndataset(__ST257690_Layout) Sale_Amounts_;
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
    KEL.typ.ndataset(__ST257767_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST373969_Layout) All_Lien_Data_;
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
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST263151_Layout) Best_N_A_I_C_S_Code1_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST263151_Layout) Best_N_A_I_C_S_Code2_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST263151_Layout) Best_N_A_I_C_S_Code3_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST263151_Layout) Best_N_A_I_C_S_Code4_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST263140_Layout) Best_Sic_Code1_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST263140_Layout) Best_Sic_Code2_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST263140_Layout) Best_Sic_Code3_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST263140_Layout) Best_Sic_Code4_Set_;
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
  SHARED __ST257584_Layout __ND5090358__Project(__ST377531_Layout __PP5087367) := TRANSFORM
    __EE5091116 := __PP5087367.Reported_Names_;
    __ST257622_Layout __ND5087966__Project(B_Business_Sele_8(__in,__cfg).__ST260737_Layout __PP5087962) := TRANSFORM
      SELF.Corporation_Legal_Name_Match_ := FN_Compile(__cfg).FN_Is_Found(__ECAST(KEL.typ.nstr,__PP5087962.Slim_Corporation_Legal_Name_),__ECAST(KEL.typ.nstr,__PP5087962.Slim_Inp_Cln_Name_));
      SELF.Corporation_Legal_Name_Similarity_ := FN_Compile(__cfg).FN_Levenshtein_Similarity(__ECAST(KEL.typ.nstr,__PP5087962.Slim_Corporation_Legal_Name_),__ECAST(KEL.typ.nstr,__PP5087962.Slim_Inp_Cln_Name_));
      SELF.Doing_Business_As_Match_ := FN_Compile(__cfg).FN_Is_Found(__ECAST(KEL.typ.nstr,__PP5087962.Slim_Doing_Business_As_),__ECAST(KEL.typ.nstr,__PP5087962.Slim_Inp_Cln_Name_));
      SELF.Doing_Business_As_Similarity_ := FN_Compile(__cfg).FN_Levenshtein_Similarity(__ECAST(KEL.typ.nstr,__PP5087962.Slim_Doing_Business_As_),__ECAST(KEL.typ.nstr,__PP5087962.Slim_Inp_Cln_Name_));
      SELF.Name_Match_ := FN_Compile(__cfg).FN_Is_Found(__ECAST(KEL.typ.nstr,__PP5087962.Slim_Name_),__ECAST(KEL.typ.nstr,__PP5087962.Slim_Inp_Cln_Name_));
      SELF.Name_Similarity_ := FN_Compile(__cfg).FN_Levenshtein_Similarity(__ECAST(KEL.typ.nstr,__PP5087962.Slim_Name_),__ECAST(KEL.typ.nstr,__PP5087962.Slim_Inp_Cln_Name_));
      SELF := __PP5087962;
    END;
    SELF.Reported_Names_ := __PROJECT(__EE5091116,__ND5087966__Project(LEFT));
    __EE5091119 := __PP5087367.S_I_C_Codes_;
    SELF.S_I_C_Codes_ := __BN(PROJECT(__T(__EE5091119),__ST257651_Layout),__NL(__EE5091119));
    __EE5091122 := __PP5087367.N_A_I_C_S_Codes_;
    SELF.N_A_I_C_S_Codes_ := __BN(PROJECT(__T(__EE5091122),__ST257662_Layout),__NL(__EE5091122));
    __EE5091125 := __PP5087367.Employee_Counts_;
    __ST257673_Layout __ND5088144__Project(B_Business_Sele_8(__in,__cfg).__ST260782_Layout __PP5088140) := TRANSFORM
      __CC13079 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP5088140.Date_Last_Seen_Capped_),__ECAST(KEL.typ.nkdate,__CC13079));
      SELF := __PP5088140;
    END;
    SELF.Employee_Counts_ := __PROJECT(__EE5091125,__ND5088144__Project(LEFT));
    __EE5091128 := __PP5087367.Sale_Amounts_;
    __ST257690_Layout __ND5088209__Project(B_Business_Sele_8(__in,__cfg).__ST260798_Layout __PP5088205) := TRANSFORM
      __CC13079 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP5088205.Date_Last_Seen_Capped_),__ECAST(KEL.typ.nkdate,__CC13079));
      SELF := __PP5088205;
    END;
    SELF.Sale_Amounts_ := __PROJECT(__EE5091128,__ND5088209__Project(LEFT));
    __EE5091131 := __PP5087367.Data_Sources_;
    __ST257767_Layout __ND5088302__Project(E_Business_Sele(__in,__cfg).Data_Sources_Layout __PP5088298) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Source_Group(__ECAST(KEL.typ.nstr,__PP5088298.Source_));
      SELF := __PP5088298;
    END;
    SELF.Data_Sources_ := __PROJECT(__EE5091131,__ND5088302__Project(LEFT));
    __EE5090356 := __PP5087367.All_Lien_Data_;
    __ST373969_Layout __ND5088323__Project(B_Business_Sele_8(__in,__cfg).__ST347990_Layout __PP5088319) := TRANSFORM
      __CC13287 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('liens_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,__PP5088319.Original_Filing_Date_),__ECAST(KEL.typ.nkdate,__CC13287));
      SELF.Is_Over_All_Judgment_ := __OR(__OR(__PP5088319.Is_Civil_Court_Judgment_,__PP5088319.Is_Foreclosure_Judgment_),__PP5088319.Is_Small_Cliams_Judgment_);
      SELF.Is_Over_All_Lien_ := __OR(__PP5088319.Is_Total_Tax_Lien_,__PP5088319.Is_Other_Lien_);
      SELF := __PP5088319;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE5090356,__ND5088323__Project(LEFT));
    SELF.B___Inp_Cln_Phone_ := __PP5087367.Bus_Input_Phone_Clean_Value_;
    SELF.B___Inp_Cln_T_I_N_ := __PP5087367.Bus_Input_T_I_N_Clean_Value_;
    __EE5090408 := __PP5087367.Best_N_A_I_C_S_Code1_Set_;
    __CC13548 := '-99998';
    SELF.Bus_N_A_I_C_S_Code1_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,(__T(__EE5090408))[1].N_A_I_C_S_Code_),__ECAST(KEL.typ.nstr,__CN(__CC13548)));
    __EE5090425 := __PP5087367.Best_N_A_I_C_S_Code2_Set_;
    SELF.Bus_N_A_I_C_S_Code2_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,(__T(__EE5090425))[1].N_A_I_C_S_Code_),__ECAST(KEL.typ.nstr,__CN(__CC13548)));
    __EE5090442 := __PP5087367.Best_N_A_I_C_S_Code3_Set_;
    SELF.Bus_N_A_I_C_S_Code3_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,(__T(__EE5090442))[1].N_A_I_C_S_Code_),__ECAST(KEL.typ.nstr,__CN(__CC13548)));
    __EE5090459 := __PP5087367.Best_N_A_I_C_S_Code4_Set_;
    SELF.Bus_N_A_I_C_S_Code4_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,(__T(__EE5090459))[1].N_A_I_C_S_Code_),__ECAST(KEL.typ.nstr,__CN(__CC13548)));
    __EE5090477 := __PP5087367.Best_Sic_Code1_Set_;
    SELF.Bus_S_I_C_Code1_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,(PROJECT(__T(__EE5090477),TRANSFORM({KEL.typ.nstr __value},SELF.__value:=FN_Compile(__cfg).FN_Map_Sic_Code_Padding(__ECAST(KEL.typ.nstr,LEFT.S_I_C_Code_)))))[1].__value),__ECAST(KEL.typ.nstr,__CN(__CC13548)));
    __EE5090495 := __PP5087367.Best_Sic_Code2_Set_;
    SELF.Bus_S_I_C_Code2_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,(PROJECT(__T(__EE5090495),TRANSFORM({KEL.typ.nstr __value},SELF.__value:=FN_Compile(__cfg).FN_Map_Sic_Code_Padding(__ECAST(KEL.typ.nstr,LEFT.S_I_C_Code_)))))[1].__value),__ECAST(KEL.typ.nstr,__CN(__CC13548)));
    __EE5090513 := __PP5087367.Best_Sic_Code3_Set_;
    SELF.Bus_S_I_C_Code3_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,(PROJECT(__T(__EE5090513),TRANSFORM({KEL.typ.nstr __value},SELF.__value:=FN_Compile(__cfg).FN_Map_Sic_Code_Padding(__ECAST(KEL.typ.nstr,LEFT.S_I_C_Code_)))))[1].__value),__ECAST(KEL.typ.nstr,__CN(__CC13548)));
    __EE5090531 := __PP5087367.Best_Sic_Code4_Set_;
    SELF.Bus_S_I_C_Code4_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,(PROJECT(__T(__EE5090531),TRANSFORM({KEL.typ.nstr __value},SELF.__value:=FN_Compile(__cfg).FN_Map_Sic_Code_Padding(__ECAST(KEL.typ.nstr,LEFT.S_I_C_Code_)))))[1].__value),__ECAST(KEL.typ.nstr,__CN(__CC13548)));
    __EE5090540 := __PP5087367.Best_Addresses_;
    SELF.Only_Best_Address_ := (__T(__EE5090540))[1];
    SELF := __PP5087367;
  END;
  EXPORT __ENH_Business_Sele_7 := PROJECT(__EE5091113,__ND5090358__Project(LEFT));
END;
