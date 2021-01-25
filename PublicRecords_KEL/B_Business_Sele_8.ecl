﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Business_Sele_9,CFG_Compile,E_Address,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Geo_Link,E_Input_B_I_I,E_Sele_Address,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Business_Sele_8(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Sele_9(__in,__cfg).__ENH_Business_Sele_9) __ENH_Business_Sele_9 := B_Business_Sele_9(__in,__cfg).__ENH_Business_Sele_9;
  SHARED VIRTUAL TYPEOF(E_Sele_Address(__in,__cfg).__Result) __E_Sele_Address := E_Sele_Address(__in,__cfg).__Result;
  SHARED __EE4804812 := __ENH_Business_Sele_9;
  SHARED __EE4804814 := __E_Sele_Address;
  SHARED __EE4806031 := __EE4804814(__NN(__EE4804814.Legal_));
  SHARED __ST337053_Layout := RECORD
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
  __JC4808947(E_Sele_Address(__in,__cfg).Layout __PL4806036, E_Sele_Address(__in,__cfg).Best_Addresses_Layout __PR4806039) := FUNCTION
    __EE4806051 := __PL4806036.Best_Addresses_;
    RETURN __T(__OP2(__PR4806039.Best_Address_Rank_,=,KEL.Aggregates.MinNN(__EE4806051,__T(__EE4806051).Best_Address_Rank_)));
  END;
  __ST337053_Layout __JT4808947(E_Sele_Address(__in,__cfg).Layout __l, E_Sele_Address(__in,__cfg).Best_Addresses_Layout __r) := TRANSFORM, SKIP(NOT(__JC4808947(__l,__r)))
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4808948 := NORMALIZE(__EE4806031,__T(LEFT.Best_Addresses_),__JT4808947(LEFT,RIGHT));
  SHARED __ST4807578_Layout := RECORD
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
  SHARED __EE4809078 := PROJECT(TABLE(PROJECT(__EE4808948,__ST4807578_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Legal_,Best_Primary_Range_,Best_Predirectional_,Best_Primary_Name_,Best_Suffix_,Best_Postdirectional_,Best_Unit_Designation_,Best_Secondary_Range_,Best_Postal_City_,Best_Vanity_City_,Best_State_,Best_Zip5_,Best_Zip4_,Best_Address_Rank_},Legal_,Best_Primary_Range_,Best_Predirectional_,Best_Primary_Name_,Best_Suffix_,Best_Postdirectional_,Best_Unit_Designation_,Best_Secondary_Range_,Best_Postal_City_,Best_Vanity_City_,Best_State_,Best_Zip5_,Best_Zip4_,Best_Address_Rank_,MERGE),__ST4807578_Layout);
  SHARED __ST4807632_Layout := RECORD
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
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST253287_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST253298_Layout) N_A_I_C_S_Codes_;
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
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST318412_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) B_I_I_;
    KEL.typ.nstr Bus_Input_Name_Clean_Value_;
    KEL.typ.ndataset(__ST4807578_Layout) Sele_Address_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4809084(B_Business_Sele_9(__in,__cfg).__ST253230_Layout __EE4804812, __ST4807578_Layout __EE4809078) := __EEQP(__EE4804812.UID,__EE4809078.Legal_);
  __ST4807632_Layout __Join__ST4807632_Layout(B_Business_Sele_9(__in,__cfg).__ST253230_Layout __r, DATASET(__ST4807578_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Sele_Address_ := __CN(__recs);
  END;
  SHARED __EE4809264 := DENORMALIZE(DISTRIBUTE(__EE4804812,HASH(UID)),DISTRIBUTE(__EE4809078,HASH(Legal_)),__JC4809084(LEFT,RIGHT),GROUP,__Join__ST4807632_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST251155_Layout := RECORD
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
  EXPORT __ST251178_Layout := RECORD
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
  EXPORT __ST251189_Layout := RECORD
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
  EXPORT __ST251200_Layout := RECORD
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
  EXPORT __ST251216_Layout := RECORD
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
  EXPORT __ST332212_Layout := RECORD
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
  EXPORT __ST251117_Layout := RECORD
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
    KEL.typ.ndataset(__ST251155_Layout) Reported_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Stock_Tickers_Layout) Stock_Tickers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).U_R_Ls_Layout) U_R_Ls_;
    KEL.typ.ndataset(__ST251178_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(__ST251189_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(__ST251200_Layout) Employee_Counts_;
    KEL.typ.ndataset(__ST251216_Layout) Sale_Amounts_;
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
    KEL.typ.ndataset(__ST332212_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) B_I_I_;
    KEL.typ.ndataset(E_Sele_Address(__in,__cfg).Best_Addresses_Layout) Best_Addresses_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST253298_Layout) Best_N_A_I_C_S_Code1_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST253298_Layout) Best_N_A_I_C_S_Code2_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST253298_Layout) Best_N_A_I_C_S_Code3_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST253298_Layout) Best_N_A_I_C_S_Code4_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST253287_Layout) Best_Sic_Code1_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST253287_Layout) Best_Sic_Code2_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST253287_Layout) Best_Sic_Code3_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST253287_Layout) Best_Sic_Code4_Set_;
    KEL.typ.nstr Bus_Input_Name_Clean_Value_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST251117_Layout __ND4809293__Project(__ST4807632_Layout __PP4809289) := TRANSFORM
    __EE4809267 := __PP4809289.Reported_Names_;
    __ST251155_Layout __ND4809514__Project(E_Business_Sele(__in,__cfg).Reported_Names_Layout __PP4809510) := TRANSFORM
      SELF.Slim_Corporation_Legal_Name_ := FN_Compile(__cfg).FN_Slim_Business_Name(__ECAST(KEL.typ.nstr,__PP4809510.Corporation_Legal_Name_));
      SELF.Slim_Doing_Business_As_ := FN_Compile(__cfg).FN_Slim_Business_Name(__ECAST(KEL.typ.nstr,__PP4809510.Doing_Business_As_));
      SELF.Slim_Inp_Cln_Name_ := FN_Compile(__cfg).FN_Slim_Business_Name(__ECAST(KEL.typ.nstr,__PP4809289.Bus_Input_Name_Clean_Value_));
      SELF.Slim_Name_ := FN_Compile(__cfg).FN_Slim_Business_Name(__ECAST(KEL.typ.nstr,__PP4809510.Name_));
      SELF := __PP4809510;
    END;
    SELF.Reported_Names_ := __PROJECT(__EE4809267,__ND4809514__Project(LEFT));
    __EE4809271 := __PP4809289.S_I_C_Codes_;
    SELF.S_I_C_Codes_ := __BN(PROJECT(__T(__EE4809271),__ST251178_Layout),__NL(__EE4809271));
    __EE4809275 := __PP4809289.N_A_I_C_S_Codes_;
    SELF.N_A_I_C_S_Codes_ := __BN(PROJECT(__T(__EE4809275),__ST251189_Layout),__NL(__EE4809275));
    __EE4809279 := __PP4809289.Employee_Counts_;
    __ST251200_Layout __ND4809651__Project(E_Business_Sele(__in,__cfg).Employee_Counts_Layout __PP4809647) := TRANSFORM
      __CC12986 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Date_Last_Seen_Capped_ := KEL.Routines.MinN(KEL.era.ToDate(__PP4809647.Date_Last_Seen_),__CC12986);
      SELF := __PP4809647;
    END;
    SELF.Employee_Counts_ := __PROJECT(__EE4809279,__ND4809651__Project(LEFT));
    __EE4809283 := __PP4809289.Sale_Amounts_;
    __ST251216_Layout __ND4809712__Project(E_Business_Sele(__in,__cfg).Sale_Amounts_Layout __PP4809708) := TRANSFORM
      __CC12986 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Date_Last_Seen_Capped_ := KEL.Routines.MinN(KEL.era.ToDate(__PP4809708.Date_Last_Seen_),__CC12986);
      SELF := __PP4809708;
    END;
    SELF.Sale_Amounts_ := __PROJECT(__EE4809283,__ND4809712__Project(LEFT));
    __EE4809799 := __PP4809289.All_Lien_Data_;
    __ST332212_Layout __ND4809807__Project(B_Business_Sele_9(__in,__cfg).__ST318412_Layout __PP4809803) := TRANSFORM
      __CC29878 := ['CIVIL JUDGMENT','CIVIL JUDGMENT RELEASE','CIVIL SPECIAL JUDGMENT','CIVIL SPECIAL JUDGMENT RELEASE','FEDERAL COURT JUDGMENT','JUDGMENT','JUDGMENTS','JUDGMENTS DOCKET','RENEW/REOPEN CIVIL JUDGMENT','SATISFACTION OF JUDGMENT','SATISFIED JUDGMENT','SUBSEQUENT JUDGMENT','DOMESTIC JUDGMENT IN DIVORCE','DOMESTIC RELEASE IN DIVORCE'];
      SELF.Is_Civil_Court_Judgment_ := __AND(__CN(__PP4809803.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP4809803.Filing_Type_Description_,IN,__CN(__CC29878)));
      __CC29882 := ['FORECLOSURE (JUDGMENT)','FORECLOSURE SATISFIED'];
      SELF.Is_Foreclosure_Judgment_ := __AND(__CN(__PP4809803.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP4809803.Filing_Type_Description_,IN,__CN(__CC29882)));
      __CC29848 := ['BUILDING LIEN','BUILDING LIEN RELEASE','BUILDING RELEASE','CHILD SUPPORT LIEN','CHILD SUPPORT PAYMENT','CHILD SUPPORT PAYMENT RELEASE','JUDGEMENT LIEN','JUDGMENT LIEN RELEASE','SIDEWALK LIEN','SIDEWALK LIEN RELEASE','SIDEWALK RELEASE','WELFARE LIEN','MECHANICS LIEN','MECHANICS LIEN RELEASE'];
      SELF.Is_Other_Lien_ := __AND(__CN(__PP4809803.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP4809803.Filing_Type_Description_,IN,__CN(__CC29848)));
      __CC29887 := ['RENEW/REOPEN SMALL CLAIM JUDGM','SMALL CLAIMS JUDGMENT','SMALL CLAIMS JUDGMENT RELEASE'];
      SELF.Is_Small_Cliams_Judgment_ := __AND(__CN(__PP4809803.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP4809803.Filing_Type_Description_,IN,__CN(__CC29887)));
      SELF.Is_Total_Tax_Lien_ := __OR(__OR(__PP4809803.Is_Federal_Tax_Lien_,__PP4809803.Is_State_Tax_Lien_),__PP4809803.Is_Other_Tax_Lien_);
      SELF := __PP4809803;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE4809799,__ND4809807__Project(LEFT));
    __EE4809287 := __PP4809289.Sele_Address_;
    SELF.Best_Addresses_ := __PROJECT(__EE4809287,E_Sele_Address(__in,__cfg).Best_Addresses_Layout);
    __EE4809958 := __PP4809289.N_A_I_C_S_Codes_;
    __BS4809962 := __T(__EE4809958);
    __EE4809972 := __BS4809962(__T(__AND(__T(__EE4809958).Is_N_A_I_C_S_Code_,__OP2(__T(__EE4809958).N_A_I_C_S_Code_Order_,=,__CN(1)))));
    __EE4809984 := TOPN(__EE4809972(__NN(__EE4809972.Within_Last24_Months_) AND __NN(__EE4809972.N_A_I_C_S_Code_)),1,__T(__EE4809972.Within_Last24_Months_),__EE4809972.Source_Priority_,__T(__EE4809972.N_A_I_C_S_Code_),__T(N_A_I_C_S_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_N_A_I_C_S_Code1_Set_ := __CN(__EE4809984);
    __EE4809989 := __PP4809289.N_A_I_C_S_Codes_;
    __BS4809993 := __T(__EE4809989);
    __EE4810003 := __BS4809993(__T(__AND(__T(__EE4809989).Is_N_A_I_C_S_Code_,__OP2(__T(__EE4809989).N_A_I_C_S_Code_Order_,=,__CN(2)))));
    __EE4810015 := TOPN(__EE4810003(__NN(__EE4810003.Within_Last24_Months_) AND __NN(__EE4810003.N_A_I_C_S_Code_)),1,__T(__EE4810003.Within_Last24_Months_),__EE4810003.Source_Priority_,__T(__EE4810003.N_A_I_C_S_Code_),__T(N_A_I_C_S_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_N_A_I_C_S_Code2_Set_ := __CN(__EE4810015);
    __EE4810020 := __PP4809289.N_A_I_C_S_Codes_;
    __BS4810024 := __T(__EE4810020);
    __EE4810034 := __BS4810024(__T(__AND(__T(__EE4810020).Is_N_A_I_C_S_Code_,__OP2(__T(__EE4810020).N_A_I_C_S_Code_Order_,=,__CN(3)))));
    __EE4810046 := TOPN(__EE4810034(__NN(__EE4810034.Within_Last24_Months_) AND __NN(__EE4810034.N_A_I_C_S_Code_)),1,__T(__EE4810034.Within_Last24_Months_),__EE4810034.Source_Priority_,__T(__EE4810034.N_A_I_C_S_Code_),__T(N_A_I_C_S_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_N_A_I_C_S_Code3_Set_ := __CN(__EE4810046);
    __EE4810051 := __PP4809289.N_A_I_C_S_Codes_;
    __BS4810055 := __T(__EE4810051);
    __EE4810065 := __BS4810055(__T(__AND(__T(__EE4810051).Is_N_A_I_C_S_Code_,__OP2(__T(__EE4810051).N_A_I_C_S_Code_Order_,=,__CN(4)))));
    __EE4810077 := TOPN(__EE4810065(__NN(__EE4810065.Within_Last24_Months_) AND __NN(__EE4810065.N_A_I_C_S_Code_)),1,__T(__EE4810065.Within_Last24_Months_),__EE4810065.Source_Priority_,__T(__EE4810065.N_A_I_C_S_Code_),__T(N_A_I_C_S_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_N_A_I_C_S_Code4_Set_ := __CN(__EE4810077);
    __EE4810082 := __PP4809289.S_I_C_Codes_;
    __BS4810086 := __T(__EE4810082);
    __EE4810096 := __BS4810086(__T(__AND(__T(__EE4810082).Is_Sic_Code_,__OP2(__T(__EE4810082).S_I_C_Code_Order_,=,__CN(1)))));
    __EE4810108 := TOPN(__EE4810096(__NN(__EE4810096.Within_Last24_Months_) AND __NN(__EE4810096.S_I_C_Code_)),1,__T(__EE4810096.Within_Last24_Months_),__EE4810096.Source_Priority_,__T(__EE4810096.S_I_C_Code_),__T(S_I_C_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_Sic_Code1_Set_ := __CN(__EE4810108);
    __EE4810113 := __PP4809289.S_I_C_Codes_;
    __BS4810117 := __T(__EE4810113);
    __EE4810127 := __BS4810117(__T(__AND(__T(__EE4810113).Is_Sic_Code_,__OP2(__T(__EE4810113).S_I_C_Code_Order_,=,__CN(2)))));
    __EE4810139 := TOPN(__EE4810127(__NN(__EE4810127.Within_Last24_Months_) AND __NN(__EE4810127.S_I_C_Code_)),1,__T(__EE4810127.Within_Last24_Months_),__EE4810127.Source_Priority_,__T(__EE4810127.S_I_C_Code_),__T(S_I_C_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_Sic_Code2_Set_ := __CN(__EE4810139);
    __EE4810144 := __PP4809289.S_I_C_Codes_;
    __BS4810148 := __T(__EE4810144);
    __EE4810158 := __BS4810148(__T(__AND(__T(__EE4810144).Is_Sic_Code_,__OP2(__T(__EE4810144).S_I_C_Code_Order_,=,__CN(3)))));
    __EE4810170 := TOPN(__EE4810158(__NN(__EE4810158.Within_Last24_Months_) AND __NN(__EE4810158.S_I_C_Code_)),1,__T(__EE4810158.Within_Last24_Months_),__EE4810158.Source_Priority_,__T(__EE4810158.S_I_C_Code_),__T(S_I_C_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_Sic_Code3_Set_ := __CN(__EE4810170);
    __EE4810175 := __PP4809289.S_I_C_Codes_;
    __BS4810179 := __T(__EE4810175);
    __EE4810189 := __BS4810179(__T(__AND(__T(__EE4810175).Is_Sic_Code_,__OP2(__T(__EE4810175).S_I_C_Code_Order_,=,__CN(4)))));
    __EE4810201 := TOPN(__EE4810189(__NN(__EE4810189.Within_Last24_Months_) AND __NN(__EE4810189.S_I_C_Code_)),1,__T(__EE4810189.Within_Last24_Months_),__EE4810189.Source_Priority_,__T(__EE4810189.S_I_C_Code_),__T(S_I_C_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_Sic_Code4_Set_ := __CN(__EE4810201);
    SELF := __PP4809289;
  END;
  EXPORT __ENH_Business_Sele_8 := PROJECT(__EE4809264,__ND4809293__Project(LEFT));
END;
