//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Business_Sele_9,CFG_Compile,E_Address,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Geo_Link,E_Input_B_I_I,E_Sele_Address,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Business_Sele_8(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Sele_9(__in,__cfg).__ENH_Business_Sele_9) __ENH_Business_Sele_9 := B_Business_Sele_9(__in,__cfg).__ENH_Business_Sele_9;
  SHARED VIRTUAL TYPEOF(E_Sele_Address(__in,__cfg).__Result) __E_Sele_Address := E_Sele_Address(__in,__cfg).__Result;
  SHARED __EE5441999 := __ENH_Business_Sele_9;
  SHARED __EE5442001 := __E_Sele_Address;
  SHARED __EE5443218 := __EE5442001(__NN(__EE5442001.Legal_));
  SHARED __ST394625_Layout := RECORD
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
    KEL.typ.nstr Best_Primary_Range_;
    KEL.typ.nstr Best_Predirectional_;
    KEL.typ.nstr Best_Primary_Name_;
    KEL.typ.nstr Best_Suffix_;
    KEL.typ.nstr Best_Postdirectional_;
    KEL.typ.nstr Best_Unit_Designation_;
    KEL.typ.nstr Best_Secondary_Range_;
    KEL.typ.nstr Best_Postal_City_;
    KEL.typ.nstr Best_Vanity_City_;
    KEL.typ.nstr Best_State_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Best_Zip5_;
    KEL.typ.nint Best_Zip4_;
    KEL.typ.nint Best_Address_Rank_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5446134(E_Sele_Address(__in,__cfg).Layout __PL5443223, E_Sele_Address(__in,__cfg).Best_Addresses_Layout __PR5443226) := FUNCTION
    __EE5443238 := __PL5443223.Best_Addresses_;
    RETURN __T(__OP2(__PR5443226.Best_Address_Rank_,=,KEL.Aggregates.MinNN(__EE5443238,__T(__EE5443238).Best_Address_Rank_)));
  END;
  __ST394625_Layout __JT5446134(E_Sele_Address(__in,__cfg).Layout __l, E_Sele_Address(__in,__cfg).Best_Addresses_Layout __r) := TRANSFORM, SKIP(NOT(__JC5446134(__l,__r)))
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE5446135 := NORMALIZE(__EE5443218,__T(LEFT.Best_Addresses_),__JT5446134(LEFT,RIGHT));
  SHARED __ST5444765_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nstr Best_Primary_Range_;
    KEL.typ.nstr Best_Predirectional_;
    KEL.typ.nstr Best_Primary_Name_;
    KEL.typ.nstr Best_Suffix_;
    KEL.typ.nstr Best_Postdirectional_;
    KEL.typ.nstr Best_Unit_Designation_;
    KEL.typ.nstr Best_Secondary_Range_;
    KEL.typ.nstr Best_Postal_City_;
    KEL.typ.nstr Best_Vanity_City_;
    KEL.typ.nstr Best_State_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Best_Zip5_;
    KEL.typ.nint Best_Zip4_;
    KEL.typ.nint Best_Address_Rank_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE5446265 := PROJECT(TABLE(PROJECT(__EE5446135,__ST5444765_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Legal_,Best_Primary_Range_,Best_Predirectional_,Best_Primary_Name_,Best_Suffix_,Best_Postdirectional_,Best_Unit_Designation_,Best_Secondary_Range_,Best_Postal_City_,Best_Vanity_City_,Best_State_,Best_Zip5_,Best_Zip4_,Best_Address_Rank_},Legal_,Best_Primary_Range_,Best_Predirectional_,Best_Primary_Name_,Best_Suffix_,Best_Postdirectional_,Best_Unit_Designation_,Best_Secondary_Range_,Best_Postal_City_,Best_Vanity_City_,Best_State_,Best_Zip5_,Best_Zip4_,Best_Address_Rank_,MERGE),__ST5444765_Layout);
  SHARED __ST5444819_Layout := RECORD
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
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST268358_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST268369_Layout) N_A_I_C_S_Codes_;
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
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST373617_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) B_I_I_;
    KEL.typ.nstr Bus_Input_Name_Clean_Value_;
    KEL.typ.ndataset(__ST5444765_Layout) Sele_Address_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5446271(B_Business_Sele_9(__in,__cfg).__ST268301_Layout __EE5441999, __ST5444765_Layout __EE5446265) := __EEQP(__EE5441999.UID,__EE5446265.Legal_);
  __ST5444819_Layout __Join__ST5444819_Layout(B_Business_Sele_9(__in,__cfg).__ST268301_Layout __r, DATASET(__ST5444765_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Sele_Address_ := __CN(__recs);
  END;
  SHARED __EE5446451 := DENORMALIZE(DISTRIBUTE(__EE5441999,HASH(UID)),DISTRIBUTE(__EE5446265,HASH(Legal_)),__JC5446271(LEFT,RIGHT),GROUP,__Join__ST5444819_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST265932_Layout := RECORD
    KEL.typ.nstr Name_;
    KEL.typ.nstr Name_Type_;
    KEL.typ.nstr Name_Status_;
    KEL.typ.nstr Corporation_Legal_Name_;
    KEL.typ.nstr Doing_Business_As_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
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
  EXPORT __ST265955_Layout := RECORD
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
  EXPORT __ST265966_Layout := RECORD
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
  EXPORT __ST265977_Layout := RECORD
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
  EXPORT __ST265993_Layout := RECORD
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
  EXPORT __ST389784_Layout := RECORD
    KEL.typ.nstr T_M_S_I_D_;
    KEL.typ.nstr Filing_Type_Description_;
    KEL.typ.nint Amount_;
    KEL.typ.bool Landlord_Tenant_Dispute_Flag_ := FALSE;
    KEL.typ.nkdate Original_Filing_Date_;
    KEL.typ.nbool Is_Civil_Court_Judgment_;
    KEL.typ.nbool Is_Federal_Tax_Lien_;
    KEL.typ.nbool Is_Foreclosure_Judgment_;
    KEL.typ.nbool Is_Other_Lien_;
    KEL.typ.nbool Is_Other_Tax_Lien_;
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
  EXPORT __ST265894_Layout := RECORD
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
    KEL.typ.ndataset(__ST265932_Layout) Reported_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Stock_Tickers_Layout) Stock_Tickers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).U_R_Ls_Layout) U_R_Ls_;
    KEL.typ.ndataset(__ST265955_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(__ST265966_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(__ST265977_Layout) Employee_Counts_;
    KEL.typ.ndataset(__ST265993_Layout) Sale_Amounts_;
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
    KEL.typ.ndataset(__ST389784_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) B_I_I_;
    KEL.typ.ndataset(E_Sele_Address(__in,__cfg).Best_Addresses_Layout) Best_Addresses_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST268369_Layout) Best_N_A_I_C_S_Code1_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST268369_Layout) Best_N_A_I_C_S_Code2_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST268369_Layout) Best_N_A_I_C_S_Code3_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST268369_Layout) Best_N_A_I_C_S_Code4_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST268358_Layout) Best_Sic_Code1_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST268358_Layout) Best_Sic_Code2_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST268358_Layout) Best_Sic_Code3_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST268358_Layout) Best_Sic_Code4_Set_;
    KEL.typ.nstr Bus_Input_Name_Clean_Value_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST265894_Layout __ND5446480__Project(__ST5444819_Layout __PP5446476) := TRANSFORM
    __EE5446454 := __PP5446476.Reported_Names_;
    __ST265932_Layout __ND5446701__Project(E_Business_Sele(__in,__cfg).Reported_Names_Layout __PP5446697) := TRANSFORM
      SELF.Slim_Corporation_Legal_Name_ := FN_Compile(__cfg).FN_Slim_Business_Name(__ECAST(KEL.typ.nstr,__PP5446697.Corporation_Legal_Name_));
      SELF.Slim_Doing_Business_As_ := FN_Compile(__cfg).FN_Slim_Business_Name(__ECAST(KEL.typ.nstr,__PP5446697.Doing_Business_As_));
      SELF.Slim_Inp_Cln_Name_ := FN_Compile(__cfg).FN_Slim_Business_Name(__ECAST(KEL.typ.nstr,__PP5446476.Bus_Input_Name_Clean_Value_));
      SELF.Slim_Name_ := FN_Compile(__cfg).FN_Slim_Business_Name(__ECAST(KEL.typ.nstr,__PP5446697.Name_));
      SELF := __PP5446697;
    END;
    SELF.Reported_Names_ := __PROJECT(__EE5446454,__ND5446701__Project(LEFT));
    __EE5446458 := __PP5446476.S_I_C_Codes_;
    SELF.S_I_C_Codes_ := __BN(PROJECT(__T(__EE5446458),__ST265955_Layout),__NL(__EE5446458));
    __EE5446462 := __PP5446476.N_A_I_C_S_Codes_;
    SELF.N_A_I_C_S_Codes_ := __BN(PROJECT(__T(__EE5446462),__ST265966_Layout),__NL(__EE5446462));
    __EE5446466 := __PP5446476.Employee_Counts_;
    __ST265977_Layout __ND5446838__Project(E_Business_Sele(__in,__cfg).Employee_Counts_Layout __PP5446834) := TRANSFORM
      __CC13153 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Date_Last_Seen_Capped_ := KEL.Routines.MinN(KEL.era.ToDate(__PP5446834.Date_Last_Seen_),__CC13153);
      SELF := __PP5446834;
    END;
    SELF.Employee_Counts_ := __PROJECT(__EE5446466,__ND5446838__Project(LEFT));
    __EE5446470 := __PP5446476.Sale_Amounts_;
    __ST265993_Layout __ND5446899__Project(E_Business_Sele(__in,__cfg).Sale_Amounts_Layout __PP5446895) := TRANSFORM
      __CC13153 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Date_Last_Seen_Capped_ := KEL.Routines.MinN(KEL.era.ToDate(__PP5446895.Date_Last_Seen_),__CC13153);
      SELF := __PP5446895;
    END;
    SELF.Sale_Amounts_ := __PROJECT(__EE5446470,__ND5446899__Project(LEFT));
    __EE5446986 := __PP5446476.All_Lien_Data_;
    __ST389784_Layout __ND5446994__Project(B_Business_Sele_9(__in,__cfg).__ST373617_Layout __PP5446990) := TRANSFORM
      __CC31895 := ['CIVIL JUDGMENT','CIVIL JUDGMENT RELEASE','CIVIL SPECIAL JUDGMENT','CIVIL SPECIAL JUDGMENT RELEASE','FEDERAL COURT JUDGMENT','JUDGMENT','JUDGMENTS','JUDGMENTS DOCKET','RENEW/REOPEN CIVIL JUDGMENT','SATISFACTION OF JUDGMENT','SATISFIED JUDGMENT','SUBSEQUENT JUDGMENT','DOMESTIC JUDGMENT IN DIVORCE','DOMESTIC RELEASE IN DIVORCE'];
      SELF.Is_Civil_Court_Judgment_ := __AND(__CN(__PP5446990.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP5446990.Filing_Type_Description_,IN,__CN(__CC31895)));
      __CC31899 := ['FORECLOSURE (JUDGMENT)','FORECLOSURE SATISFIED'];
      SELF.Is_Foreclosure_Judgment_ := __AND(__CN(__PP5446990.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP5446990.Filing_Type_Description_,IN,__CN(__CC31899)));
      __CC31865 := ['BUILDING LIEN','BUILDING LIEN RELEASE','BUILDING RELEASE','CHILD SUPPORT LIEN','CHILD SUPPORT PAYMENT','CHILD SUPPORT PAYMENT RELEASE','JUDGEMENT LIEN','JUDGMENT LIEN RELEASE','SIDEWALK LIEN','SIDEWALK LIEN RELEASE','SIDEWALK RELEASE','WELFARE LIEN','MECHANICS LIEN','MECHANICS LIEN RELEASE'];
      SELF.Is_Other_Lien_ := __AND(__CN(__PP5446990.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP5446990.Filing_Type_Description_,IN,__CN(__CC31865)));
      __CC31904 := ['RENEW/REOPEN SMALL CLAIM JUDGM','SMALL CLAIMS JUDGMENT','SMALL CLAIMS JUDGMENT RELEASE'];
      SELF.Is_Small_Cliams_Judgment_ := __AND(__CN(__PP5446990.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP5446990.Filing_Type_Description_,IN,__CN(__CC31904)));
      SELF.Is_Total_Tax_Lien_ := __OR(__OR(__PP5446990.Is_Federal_Tax_Lien_,__PP5446990.Is_State_Tax_Lien_),__PP5446990.Is_Other_Tax_Lien_);
      SELF := __PP5446990;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE5446986,__ND5446994__Project(LEFT));
    __EE5446474 := __PP5446476.Sele_Address_;
    SELF.Best_Addresses_ := __PROJECT(__EE5446474,E_Sele_Address(__in,__cfg).Best_Addresses_Layout);
    __EE5447145 := __PP5446476.N_A_I_C_S_Codes_;
    __BS5447149 := __T(__EE5447145);
    __EE5447159 := __BS5447149(__T(__AND(__T(__EE5447145).Is_N_A_I_C_S_Code_,__OP2(__T(__EE5447145).N_A_I_C_S_Code_Order_,=,__CN(1)))));
    __EE5447171 := TOPN(__EE5447159(__NN(__EE5447159.Within_Last24_Months_) AND __NN(__EE5447159.N_A_I_C_S_Code_)),1,__T(__EE5447159.Within_Last24_Months_),__EE5447159.Source_Priority_,__T(__EE5447159.N_A_I_C_S_Code_),__T(N_A_I_C_S_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_N_A_I_C_S_Code1_Set_ := __CN(__EE5447171);
    __EE5447176 := __PP5446476.N_A_I_C_S_Codes_;
    __BS5447180 := __T(__EE5447176);
    __EE5447190 := __BS5447180(__T(__AND(__T(__EE5447176).Is_N_A_I_C_S_Code_,__OP2(__T(__EE5447176).N_A_I_C_S_Code_Order_,=,__CN(2)))));
    __EE5447202 := TOPN(__EE5447190(__NN(__EE5447190.Within_Last24_Months_) AND __NN(__EE5447190.N_A_I_C_S_Code_)),1,__T(__EE5447190.Within_Last24_Months_),__EE5447190.Source_Priority_,__T(__EE5447190.N_A_I_C_S_Code_),__T(N_A_I_C_S_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_N_A_I_C_S_Code2_Set_ := __CN(__EE5447202);
    __EE5447207 := __PP5446476.N_A_I_C_S_Codes_;
    __BS5447211 := __T(__EE5447207);
    __EE5447221 := __BS5447211(__T(__AND(__T(__EE5447207).Is_N_A_I_C_S_Code_,__OP2(__T(__EE5447207).N_A_I_C_S_Code_Order_,=,__CN(3)))));
    __EE5447233 := TOPN(__EE5447221(__NN(__EE5447221.Within_Last24_Months_) AND __NN(__EE5447221.N_A_I_C_S_Code_)),1,__T(__EE5447221.Within_Last24_Months_),__EE5447221.Source_Priority_,__T(__EE5447221.N_A_I_C_S_Code_),__T(N_A_I_C_S_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_N_A_I_C_S_Code3_Set_ := __CN(__EE5447233);
    __EE5447238 := __PP5446476.N_A_I_C_S_Codes_;
    __BS5447242 := __T(__EE5447238);
    __EE5447252 := __BS5447242(__T(__AND(__T(__EE5447238).Is_N_A_I_C_S_Code_,__OP2(__T(__EE5447238).N_A_I_C_S_Code_Order_,=,__CN(4)))));
    __EE5447264 := TOPN(__EE5447252(__NN(__EE5447252.Within_Last24_Months_) AND __NN(__EE5447252.N_A_I_C_S_Code_)),1,__T(__EE5447252.Within_Last24_Months_),__EE5447252.Source_Priority_,__T(__EE5447252.N_A_I_C_S_Code_),__T(N_A_I_C_S_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_N_A_I_C_S_Code4_Set_ := __CN(__EE5447264);
    __EE5447269 := __PP5446476.S_I_C_Codes_;
    __BS5447273 := __T(__EE5447269);
    __EE5447283 := __BS5447273(__T(__AND(__T(__EE5447269).Is_Sic_Code_,__OP2(__T(__EE5447269).S_I_C_Code_Order_,=,__CN(1)))));
    __EE5447295 := TOPN(__EE5447283(__NN(__EE5447283.Within_Last24_Months_) AND __NN(__EE5447283.S_I_C_Code_)),1,__T(__EE5447283.Within_Last24_Months_),__EE5447283.Source_Priority_,__T(__EE5447283.S_I_C_Code_),__T(S_I_C_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_Sic_Code1_Set_ := __CN(__EE5447295);
    __EE5447300 := __PP5446476.S_I_C_Codes_;
    __BS5447304 := __T(__EE5447300);
    __EE5447314 := __BS5447304(__T(__AND(__T(__EE5447300).Is_Sic_Code_,__OP2(__T(__EE5447300).S_I_C_Code_Order_,=,__CN(2)))));
    __EE5447326 := TOPN(__EE5447314(__NN(__EE5447314.Within_Last24_Months_) AND __NN(__EE5447314.S_I_C_Code_)),1,__T(__EE5447314.Within_Last24_Months_),__EE5447314.Source_Priority_,__T(__EE5447314.S_I_C_Code_),__T(S_I_C_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_Sic_Code2_Set_ := __CN(__EE5447326);
    __EE5447331 := __PP5446476.S_I_C_Codes_;
    __BS5447335 := __T(__EE5447331);
    __EE5447345 := __BS5447335(__T(__AND(__T(__EE5447331).Is_Sic_Code_,__OP2(__T(__EE5447331).S_I_C_Code_Order_,=,__CN(3)))));
    __EE5447357 := TOPN(__EE5447345(__NN(__EE5447345.Within_Last24_Months_) AND __NN(__EE5447345.S_I_C_Code_)),1,__T(__EE5447345.Within_Last24_Months_),__EE5447345.Source_Priority_,__T(__EE5447345.S_I_C_Code_),__T(S_I_C_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_Sic_Code3_Set_ := __CN(__EE5447357);
    __EE5447362 := __PP5446476.S_I_C_Codes_;
    __BS5447366 := __T(__EE5447362);
    __EE5447376 := __BS5447366(__T(__AND(__T(__EE5447362).Is_Sic_Code_,__OP2(__T(__EE5447362).S_I_C_Code_Order_,=,__CN(4)))));
    __EE5447388 := TOPN(__EE5447376(__NN(__EE5447376.Within_Last24_Months_) AND __NN(__EE5447376.S_I_C_Code_)),1,__T(__EE5447376.Within_Last24_Months_),__EE5447376.Source_Priority_,__T(__EE5447376.S_I_C_Code_),__T(S_I_C_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_Sic_Code4_Set_ := __CN(__EE5447388);
    SELF := __PP5446476;
  END;
  EXPORT __ENH_Business_Sele_8 := PROJECT(__EE5446451,__ND5446480__Project(LEFT));
END;
