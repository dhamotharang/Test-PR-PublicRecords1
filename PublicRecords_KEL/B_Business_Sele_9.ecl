//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Business_Sele_10,B_Input_B_I_I_10,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Input_B_I_I FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Business_Sele_9(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Sele_10(__in,__cfg).__ENH_Business_Sele_10) __ENH_Business_Sele_10 := B_Business_Sele_10(__in,__cfg).__ENH_Business_Sele_10;
  SHARED VIRTUAL TYPEOF(B_Input_B_I_I_10(__in,__cfg).__ENH_Input_B_I_I_10) __ENH_Input_B_I_I_10 := B_Input_B_I_I_10(__in,__cfg).__ENH_Input_B_I_I_10;
  SHARED __EE6486366 := __ENH_Business_Sele_10;
  SHARED __EE6486368 := __ENH_Input_B_I_I_10;
  SHARED __ST404846_Layout := RECORD
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
    KEL.typ.ndataset(B_Business_Sele_10(__in,__cfg).__ST293821_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(B_Business_Sele_10(__in,__cfg).__ST293829_Layout) N_A_I_C_S_Codes_;
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
    KEL.typ.ndataset(B_Business_Sele_10(__in,__cfg).__ST127816_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) B_I_I_;
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
    KEL.typ.nstr Bus_Input_Name_Clean_Value_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC6486377(B_Business_Sele_10(__in,__cfg).__ST293764_Layout __EE6486366, B_Input_B_I_I_10(__in,__cfg).__ST294012_Layout __EE6486368) := __EEQP(__EE6486366.B_I_I_,__EE6486368.UID);
  __ST404846_Layout __JT6486377(B_Business_Sele_10(__in,__cfg).__ST293764_Layout __l, B_Input_B_I_I_10(__in,__cfg).__ST294012_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE6486599 := JOIN(__EE6486366,__EE6486368,__JC6486377(LEFT,RIGHT),__JT6486377(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST292357_Layout := RECORD
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
  EXPORT __ST292368_Layout := RECORD
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
  EXPORT __ST403266_Layout := RECORD
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
  EXPORT __ST292300_Layout := RECORD
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
    KEL.typ.ndataset(__ST292357_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(__ST292368_Layout) N_A_I_C_S_Codes_;
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
    KEL.typ.ndataset(__ST403266_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) B_I_I_;
    KEL.typ.nstr Bus_Input_Name_Clean_Value_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST292300_Layout __ND6486221__Project(__ST404846_Layout __PP6484371) := TRANSFORM
    __EE6486602 := __PP6484371.S_I_C_Codes_;
    __ST292357_Layout __ND6485980__Project(B_Business_Sele_10(__in,__cfg).__ST293821_Layout __PP6484774) := TRANSFORM
      SELF.Is_Sic_Code_ := __AND(__AND(__OP2(__PP6484774.S_I_C_Code_,<>,__CN(0)),__NOT(__NT(__PP6484774.S_I_C_Code_))),__OP2(__FN1(LENGTH,__ECAST(KEL.typ.nstr,__PP6484774.S_I_C_Code_)),<=,__CN(4)));
      SELF.Source_Priority_ := MAP(__T(__OP2(__PP6484774.Source_,=,__CN('DF')))=>1,__T(__OP2(__PP6484774.Source_,=,__CN('Z1')))=>2,__T(__OP2(__PP6484774.Source_,=,__CN('D')))=>3,__T(__OP2(__PP6484774.Source_,=,__CN('RQ')))=>4,__T(__OP2(__PP6484774.Source_,=,__CN('Z2')))=>5,__T(__OP2(__PP6484774.Source_,=,__CN('RR')))=>6,__T(__OP2(__PP6484774.Source_,=,__CN('DN')))=>7,__T(__OP2(__PP6484774.Source_,=,__CN('ER')))=>8,__T(__OP2(__PP6484774.Source_,=,__CN('Q3')))=>9,__T(__OP2(__PP6484774.Source_,=,__CN('L0')))=>10,__T(__OP2(__PP6484774.Source_,=,__CN('Y')))=>11,12);
      SELF.Within_Last24_Months_ := __OP2(__PP6484774.Days_Since_Code_,<,__CN(730));
      SELF := __PP6484774;
    END;
    SELF.S_I_C_Codes_ := __PROJECT(__EE6486602,__ND6485980__Project(LEFT));
    __EE6486605 := __PP6484371.N_A_I_C_S_Codes_;
    __ST292368_Layout __ND6486022__Project(B_Business_Sele_10(__in,__cfg).__ST293829_Layout __PP6484859) := TRANSFORM
      SELF.Is_N_A_I_C_S_Code_ := __AND(__AND(__OP2(__PP6484859.N_A_I_C_S_Code_,<>,__CN(0)),__NOT(__NT(__PP6484859.N_A_I_C_S_Code_))),__OP2(__FN1(LENGTH,__ECAST(KEL.typ.nstr,__PP6484859.N_A_I_C_S_Code_)),<=,__CN(6)));
      SELF.Source_Priority_ := MAP(__T(__OP2(__PP6484859.Source_,=,__CN('DF')))=>1,__T(__OP2(__PP6484859.Source_,=,__CN('Z1')))=>2,__T(__OP2(__PP6484859.Source_,=,__CN('RR')))=>3,__T(__OP2(__PP6484859.Source_,=,__CN('C#')))=>4,__T(__OP2(__PP6484859.Source_,=,__CN('TX')))=>5,__T(__OP2(__PP6484859.Source_,=,__CN('CP')))=>6,__T(__OP2(__PP6484859.Source_,=,__CN('C?')))=>7,__T(__OP2(__PP6484859.Source_,=,__CN('CI')))=>8,__T(__OP2(__PP6484859.Source_,=,__CN('Q3')))=>9,__T(__OP2(__PP6484859.Source_,=,__CN('Y')))=>10,11);
      SELF.Within_Last24_Months_ := __OP2(__PP6484859.Days_Since_Code_,<,__CN(730));
      SELF := __PP6484859;
    END;
    SELF.N_A_I_C_S_Codes_ := __PROJECT(__EE6486605,__ND6486022__Project(LEFT));
    __EE6486219 := __PP6484371.All_Lien_Data_;
    __ST403266_Layout __ND6486059__Project(B_Business_Sele_10(__in,__cfg).__ST127816_Layout __PP6484971) := TRANSFORM
      __CC32784 := ['CORRECTED FEDERAL TAX LIEN','FEDERAL TAX LIEN','FEDERAL TAX LIEN RELEASE','FEDERAL TAX RELEASE'];
      SELF.Is_Federal_Tax_Lien_ := __AND(__CN(__PP6484971.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP6484971.Filing_Type_Description_,IN,__CN(__CC32784)));
      __CC32805 := ['CITY TAX LIEN','COUNTY TAX LIEN','COUNTY TAX LIEN RELEASE','CITY TAX LIEN RELEASE','ILLINOIS TAX LIEN','ILLINOIS TAX RELEASE','PROPERTY TAX LIEN','PROPERTY TAX RELEASE'];
      SELF.Is_Other_Tax_Lien_ := __AND(__CN(__PP6484971.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP6484971.Filing_Type_Description_,IN,__CN(__CC32805)));
      __CC32795 := ['JUDGMENT or STATE TAX LIEN','STATE TAX LIEN','STATE TAX LIEN RELEASE','STATE TAX LIEN RENEWAL','STATE TAX LIEN RENEWED','STATE TAX RELEASE','STATE TAX WARRANT','STATE TAX WARRANT RELEASE','STATE TAX WARRANT RENEWED'];
      SELF.Is_State_Tax_Lien_ := __AND(__CN(__PP6484971.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP6484971.Filing_Type_Description_,IN,__CN(__CC32795)));
      SELF := __PP6484971;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE6486219,__ND6486059__Project(LEFT));
    SELF := __PP6484371;
  END;
  EXPORT __ENH_Business_Sele_9 := PROJECT(__EE6486599,__ND6486221__Project(LEFT));
END;
