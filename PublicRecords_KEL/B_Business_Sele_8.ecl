﻿//HPCC Systems KEL Compiler Version 1.3.0beta5
IMPORT KEL13 AS KEL;
IMPORT B_Business_Sele_9,CFG_Compile,E_Address,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Geo_Link,E_Input_B_I_I,E_Sele_Address,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Business_Sele_8(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Sele_9(__in,__cfg).__ENH_Business_Sele_9) __ENH_Business_Sele_9 := B_Business_Sele_9(__in,__cfg).__ENH_Business_Sele_9;
  SHARED VIRTUAL TYPEOF(E_Sele_Address(__in,__cfg).__Result) __E_Sele_Address := E_Sele_Address(__in,__cfg).__Result;
  SHARED __EE3509381 := __ENH_Business_Sele_9;
  SHARED __EE3509383 := __E_Sele_Address;
  SHARED __EE3509826 := __EE3509383(__NN(__EE3509383.Legal_));
  SHARED __ST269672_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC3511510(E_Sele_Address(__in,__cfg).Layout __PL3509831, E_Sele_Address(__in,__cfg).Best_Addresses_Layout __PR3509834) := FUNCTION
    __EE3509846 := __PL3509831.Best_Addresses_;
    RETURN __T(__OP2(__PR3509834.Best_Address_Rank_,=,KEL.Aggregates.MinNN(__EE3509846,__T(__EE3509846).Best_Address_Rank_)));
  END;
  __ST269672_Layout __JT3511510(E_Sele_Address(__in,__cfg).Layout __l, E_Sele_Address(__in,__cfg).Best_Addresses_Layout __r) := TRANSFORM, SKIP(NOT(__JC3511510(__l,__r)))
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE3511511 := NORMALIZE(__EE3509826,__T(LEFT.Best_Addresses_),__JT3511510(LEFT,RIGHT));
  SHARED __ST281649_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ntyp(E_Business_Org().Typ) Sele_Org_;
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
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Vendor_Identification_Layout) Vendor_Identification_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST197820_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST197831_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Employee_Counts_Layout) Employee_Counts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Sale_Amounts_Layout) Sale_Amounts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Earning_Amounts_Layout) Earning_Amounts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Asset_Amounts_Layout) Asset_Amounts_;
    KEL.typ.nkdate B_B_B_Member_Since_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).B_B_B_Categories_Layout) B_B_B_Categories_;
    KEL.typ.nstr For_Profit_Indicator_;
    KEL.typ.nstr Public_Or_Private_Indicator_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Company_Types_Layout) S_O_S_Company_Types_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Registered_Agents_Layout) S_O_S_Registered_Agents_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Statuses_Layout) S_O_S_Statuses_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Incorporation_Details_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Charter_Numbers_Layout) S_O_S_Charter_Numbers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Term_Exist_Codes_Layout) S_O_S_Term_Exist_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Government_Debarred_Layout) Government_Debarred_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Non_Profit_Layout) Non_Profit_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Retirement_Plan_Information_Layout) Retirement_Plan_Information_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Processing_Dates_Layout) Processing_Dates_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Business_Registration_Layout) Business_Registration_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_Company_Names_Layout) Best_Company_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_S_I_C_Codes_Layout) Best_S_I_C_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_N_A_I_C_S_Codes_Layout) Best_N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Business_Characteristics_Layout) Business_Characteristics_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Experian_C_R_D_B_Tradelines_Layout) Experian_C_R_D_B_Tradelines_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST248934_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) B_I_I_;
    KEL.typ.nstr Bus_Input_Name_Clean_Value_;
    KEL.typ.ndataset(__ST269672_Layout) Sele_Address_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC3511585(B_Business_Sele_9(__in,__cfg).__ST197757_Layout __EE3509381, __ST269672_Layout __EE3511511) := __EEQP(__EE3509381.UID,__EE3511511.Legal_);
  __ST281649_Layout __Join__ST281649_Layout(B_Business_Sele_9(__in,__cfg).__ST197757_Layout __r, DATASET(__ST269672_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Sele_Address_ := __CN(__recs);
  END;
  SHARED __EE3511887 := DENORMALIZE(DISTRIBUTE(__EE3509381,HASH(UID)),DISTRIBUTE(__EE3511511,HASH(Legal_)),__JC3511585(LEFT,RIGHT),GROUP,__Join__ST281649_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST196013_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST196043_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST196054_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST196065_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST196081_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST263776_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST195976_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ntyp(E_Business_Org().Typ) Sele_Org_;
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
    KEL.typ.ndataset(__ST196013_Layout) Reported_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Stock_Tickers_Layout) Stock_Tickers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).U_R_Ls_Layout) U_R_Ls_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Vendor_Identification_Layout) Vendor_Identification_;
    KEL.typ.ndataset(__ST196043_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(__ST196054_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(__ST196065_Layout) Employee_Counts_;
    KEL.typ.ndataset(__ST196081_Layout) Sale_Amounts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Earning_Amounts_Layout) Earning_Amounts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Asset_Amounts_Layout) Asset_Amounts_;
    KEL.typ.nkdate B_B_B_Member_Since_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).B_B_B_Categories_Layout) B_B_B_Categories_;
    KEL.typ.nstr For_Profit_Indicator_;
    KEL.typ.nstr Public_Or_Private_Indicator_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Company_Types_Layout) S_O_S_Company_Types_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Registered_Agents_Layout) S_O_S_Registered_Agents_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Statuses_Layout) S_O_S_Statuses_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Incorporation_Details_Layout) S_O_S_Incorporation_Details_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Charter_Numbers_Layout) S_O_S_Charter_Numbers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Term_Exist_Codes_Layout) S_O_S_Term_Exist_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Government_Debarred_Layout) Government_Debarred_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Non_Profit_Layout) Non_Profit_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Retirement_Plan_Information_Layout) Retirement_Plan_Information_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Processing_Dates_Layout) Processing_Dates_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Business_Registration_Layout) Business_Registration_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_Company_Names_Layout) Best_Company_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_S_I_C_Codes_Layout) Best_S_I_C_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_N_A_I_C_S_Codes_Layout) Best_N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Business_Characteristics_Layout) Business_Characteristics_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Experian_C_R_D_B_Tradelines_Layout) Experian_C_R_D_B_Tradelines_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST263776_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) B_I_I_;
    KEL.typ.ndataset(E_Sele_Address(__in,__cfg).Best_Addresses_Layout) Best_Addresses_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST197831_Layout) Best_N_A_I_C_S_Code1_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST197831_Layout) Best_N_A_I_C_S_Code2_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST197831_Layout) Best_N_A_I_C_S_Code3_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST197831_Layout) Best_N_A_I_C_S_Code4_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST197820_Layout) Best_Sic_Code1_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST197820_Layout) Best_Sic_Code2_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST197820_Layout) Best_Sic_Code3_Set_;
    KEL.typ.ndataset(B_Business_Sele_9(__in,__cfg).__ST197820_Layout) Best_Sic_Code4_Set_;
    KEL.typ.nstr Bus_Input_Name_Clean_Value_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST195976_Layout __ND3511916__Project(__ST281649_Layout __PP3511912) := TRANSFORM
    __EE3511890 := __PP3511912.Reported_Names_;
    __ST196013_Layout __ND3512204__Project(E_Business_Sele(__in,__cfg).Reported_Names_Layout __PP3512200) := TRANSFORM
      SELF.Slim_Corporation_Legal_Name_ := FN_Compile(__cfg).FN_Slim_Business_Name(__ECAST(KEL.typ.nstr,__PP3512200.Corporation_Legal_Name_));
      SELF.Slim_Doing_Business_As_ := FN_Compile(__cfg).FN_Slim_Business_Name(__ECAST(KEL.typ.nstr,__PP3512200.Doing_Business_As_));
      SELF.Slim_Inp_Cln_Name_ := FN_Compile(__cfg).FN_Slim_Business_Name(__ECAST(KEL.typ.nstr,__PP3511912.Bus_Input_Name_Clean_Value_));
      SELF.Slim_Name_ := FN_Compile(__cfg).FN_Slim_Business_Name(__ECAST(KEL.typ.nstr,__PP3512200.Name_));
      SELF := __PP3512200;
    END;
    SELF.Reported_Names_ := __PROJECT(__EE3511890,__ND3512204__Project(LEFT));
    __EE3511894 := __PP3511912.S_I_C_Codes_;
    SELF.S_I_C_Codes_ := __BN(PROJECT(__T(__EE3511894),__ST196043_Layout),__NL(__EE3511894));
    __EE3511898 := __PP3511912.N_A_I_C_S_Codes_;
    SELF.N_A_I_C_S_Codes_ := __BN(PROJECT(__T(__EE3511898),__ST196054_Layout),__NL(__EE3511898));
    __EE3511902 := __PP3511912.Employee_Counts_;
    __ST196065_Layout __ND3512343__Project(E_Business_Sele(__in,__cfg).Employee_Counts_Layout __PP3512339) := TRANSFORM
      __CC10818 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Date_Last_Seen_Capped_ := KEL.Routines.MinN(KEL.era.ToDate(__PP3512339.Date_Last_Seen_),__CC10818);
      SELF := __PP3512339;
    END;
    SELF.Employee_Counts_ := __PROJECT(__EE3511902,__ND3512343__Project(LEFT));
    __EE3511906 := __PP3511912.Sale_Amounts_;
    __ST196081_Layout __ND3512404__Project(E_Business_Sele(__in,__cfg).Sale_Amounts_Layout __PP3512400) := TRANSFORM
      __CC10818 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('bip_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Date_Last_Seen_Capped_ := KEL.Routines.MinN(KEL.era.ToDate(__PP3512400.Date_Last_Seen_),__CC10818);
      SELF := __PP3512400;
    END;
    SELF.Sale_Amounts_ := __PROJECT(__EE3511906,__ND3512404__Project(LEFT));
    __EE3512511 := __PP3511912.All_Lien_Data_;
    __ST263776_Layout __ND3512519__Project(B_Business_Sele_9(__in,__cfg).__ST248934_Layout __PP3512515) := TRANSFORM
      __CC25197 := ['CIVIL JUDGMENT','CIVIL JUDGMENT RELEASE','CIVIL SPECIAL JUDGMENT','CIVIL SPECIAL JUDGMENT RELEASE','FEDERAL COURT JUDGMENT','JUDGMENT','JUDGMENTS','JUDGMENTS DOCKET','RENEW/REOPEN CIVIL JUDGMENT','SATISFACTION OF JUDGMENT','SATISFIED JUDGMENT','SUBSEQUENT JUDGMENT','DOMESTIC JUDGMENT IN DIVORCE','DOMESTIC RELEASE IN DIVORCE'];
      SELF.Is_Civil_Court_Judgment_ := __AND(__CN(__PP3512515.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP3512515.Filing_Type_Description_,IN,__CN(__CC25197)));
      __CC25201 := ['FORECLOSURE (JUDGMENT)','FORECLOSURE SATISFIED'];
      SELF.Is_Foreclosure_Judgment_ := __AND(__CN(__PP3512515.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP3512515.Filing_Type_Description_,IN,__CN(__CC25201)));
      __CC25181 := ['BUILDING LIEN','BUILDING LIEN RELEASE','BUILDING RELEASE','CHILD SUPPORT LIEN','CHILD SUPPORT PAYMENT','CHILD SUPPORT PAYMENT RELEASE','JUDGEMENT LIEN','JUDGMENT LIEN RELEASE','SIDEWALK LIEN','SIDEWALK LIEN RELEASE','SIDEWALK RELEASE','WELFARE LIEN','MECHANICS LIEN','MECHANICS LIEN RELEASE'];
      SELF.Is_Other_Lien_ := __AND(__CN(__PP3512515.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP3512515.Filing_Type_Description_,IN,__CN(__CC25181)));
      __CC25206 := ['RENEW/REOPEN SMALL CLAIM JUDGM','SMALL CLAIMS JUDGMENT','SMALL CLAIMS JUDGMENT RELEASE'];
      SELF.Is_Small_Cliams_Judgment_ := __AND(__CN(__PP3512515.Landlord_Tenant_Dispute_Flag_ = FALSE),__OP2(__PP3512515.Filing_Type_Description_,IN,__CN(__CC25206)));
      SELF.Is_Total_Tax_Lien_ := __OR(__OR(__PP3512515.Is_Federal_Tax_Lien_,__PP3512515.Is_State_Tax_Lien_),__PP3512515.Is_Other_Tax_Lien_);
      SELF := __PP3512515;
    END;
    SELF.All_Lien_Data_ := __PROJECT(__EE3512511,__ND3512519__Project(LEFT));
    __EE3511910 := __PP3511912.Sele_Address_;
    SELF.Best_Addresses_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE3511910),E_Sele_Address(__in,__cfg).Best_Addresses_Layout)(__NN(Best_Primary_Range_) OR __NN(Best_Predirectional_) OR __NN(Best_Primary_Name_) OR __NN(Best_Suffix_) OR __NN(Best_Postdirectional_) OR __NN(Best_Unit_Designation_) OR __NN(Best_Secondary_Range_) OR __NN(Best_Postal_City_) OR __NN(Best_Vanity_City_) OR __NN(Best_State_) OR __NN(Best_Zip5_) OR __NN(Best_Zip4_) OR __NN(Best_Address_Rank_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,FALSE),Best_Primary_Range_,Best_Predirectional_,Best_Primary_Name_,Best_Suffix_,Best_Postdirectional_,Best_Unit_Designation_,Best_Secondary_Range_,Best_Postal_City_,Best_Vanity_City_,Best_State_,Best_Zip5_,Best_Zip4_,Best_Address_Rank_},Best_Primary_Range_,Best_Predirectional_,Best_Primary_Name_,Best_Suffix_,Best_Postdirectional_,Best_Unit_Designation_,Best_Secondary_Range_,Best_Postal_City_,Best_Vanity_City_,Best_State_,Best_Zip5_,Best_Zip4_,Best_Address_Rank_,MERGE),E_Sele_Address(__in,__cfg).Best_Addresses_Layout),__NL(__EE3511910));
    __EE3512670 := __PP3511912.N_A_I_C_S_Codes_;
    __BS3512674 := __T(__EE3512670);
    __EE3512684 := __BS3512674(__T(__AND(__T(__EE3512670).Is_N_A_I_C_S_Code_,__OP2(__T(__EE3512670).N_A_I_C_S_Code_Order_,=,__CN(1)))));
    __EE3512696 := TOPN(__EE3512684(__NN(__EE3512684.Within_Last24_Months_) AND __NN(__EE3512684.N_A_I_C_S_Code_)),1,__T(__EE3512684.Within_Last24_Months_),__EE3512684.Source_Priority_,__T(__EE3512684.N_A_I_C_S_Code_),__T(N_A_I_C_S_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_N_A_I_C_S_Code1_Set_ := __CN(__EE3512696);
    __EE3512701 := __PP3511912.N_A_I_C_S_Codes_;
    __BS3512705 := __T(__EE3512701);
    __EE3512715 := __BS3512705(__T(__AND(__T(__EE3512701).Is_N_A_I_C_S_Code_,__OP2(__T(__EE3512701).N_A_I_C_S_Code_Order_,=,__CN(2)))));
    __EE3512727 := TOPN(__EE3512715(__NN(__EE3512715.Within_Last24_Months_) AND __NN(__EE3512715.N_A_I_C_S_Code_)),1,__T(__EE3512715.Within_Last24_Months_),__EE3512715.Source_Priority_,__T(__EE3512715.N_A_I_C_S_Code_),__T(N_A_I_C_S_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_N_A_I_C_S_Code2_Set_ := __CN(__EE3512727);
    __EE3512732 := __PP3511912.N_A_I_C_S_Codes_;
    __BS3512736 := __T(__EE3512732);
    __EE3512746 := __BS3512736(__T(__AND(__T(__EE3512732).Is_N_A_I_C_S_Code_,__OP2(__T(__EE3512732).N_A_I_C_S_Code_Order_,=,__CN(3)))));
    __EE3512758 := TOPN(__EE3512746(__NN(__EE3512746.Within_Last24_Months_) AND __NN(__EE3512746.N_A_I_C_S_Code_)),1,__T(__EE3512746.Within_Last24_Months_),__EE3512746.Source_Priority_,__T(__EE3512746.N_A_I_C_S_Code_),__T(N_A_I_C_S_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_N_A_I_C_S_Code3_Set_ := __CN(__EE3512758);
    __EE3512763 := __PP3511912.N_A_I_C_S_Codes_;
    __BS3512767 := __T(__EE3512763);
    __EE3512777 := __BS3512767(__T(__AND(__T(__EE3512763).Is_N_A_I_C_S_Code_,__OP2(__T(__EE3512763).N_A_I_C_S_Code_Order_,=,__CN(4)))));
    __EE3512789 := TOPN(__EE3512777(__NN(__EE3512777.Within_Last24_Months_) AND __NN(__EE3512777.N_A_I_C_S_Code_)),1,__T(__EE3512777.Within_Last24_Months_),__EE3512777.Source_Priority_,__T(__EE3512777.N_A_I_C_S_Code_),__T(N_A_I_C_S_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_N_A_I_C_S_Code4_Set_ := __CN(__EE3512789);
    __EE3512794 := __PP3511912.S_I_C_Codes_;
    __BS3512798 := __T(__EE3512794);
    __EE3512808 := __BS3512798(__T(__AND(__T(__EE3512794).Is_Sic_Code_,__OP2(__T(__EE3512794).S_I_C_Code_Order_,=,__CN(1)))));
    __EE3512820 := TOPN(__EE3512808(__NN(__EE3512808.Within_Last24_Months_) AND __NN(__EE3512808.S_I_C_Code_)),1,__T(__EE3512808.Within_Last24_Months_),__EE3512808.Source_Priority_,__T(__EE3512808.S_I_C_Code_),__T(S_I_C_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_Sic_Code1_Set_ := __CN(__EE3512820);
    __EE3512825 := __PP3511912.S_I_C_Codes_;
    __BS3512829 := __T(__EE3512825);
    __EE3512839 := __BS3512829(__T(__AND(__T(__EE3512825).Is_Sic_Code_,__OP2(__T(__EE3512825).S_I_C_Code_Order_,=,__CN(2)))));
    __EE3512851 := TOPN(__EE3512839(__NN(__EE3512839.Within_Last24_Months_) AND __NN(__EE3512839.S_I_C_Code_)),1,__T(__EE3512839.Within_Last24_Months_),__EE3512839.Source_Priority_,__T(__EE3512839.S_I_C_Code_),__T(S_I_C_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_Sic_Code2_Set_ := __CN(__EE3512851);
    __EE3512856 := __PP3511912.S_I_C_Codes_;
    __BS3512860 := __T(__EE3512856);
    __EE3512870 := __BS3512860(__T(__AND(__T(__EE3512856).Is_Sic_Code_,__OP2(__T(__EE3512856).S_I_C_Code_Order_,=,__CN(3)))));
    __EE3512882 := TOPN(__EE3512870(__NN(__EE3512870.Within_Last24_Months_) AND __NN(__EE3512870.S_I_C_Code_)),1,__T(__EE3512870.Within_Last24_Months_),__EE3512870.Source_Priority_,__T(__EE3512870.S_I_C_Code_),__T(S_I_C_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_Sic_Code3_Set_ := __CN(__EE3512882);
    __EE3512887 := __PP3511912.S_I_C_Codes_;
    __BS3512891 := __T(__EE3512887);
    __EE3512901 := __BS3512891(__T(__AND(__T(__EE3512887).Is_Sic_Code_,__OP2(__T(__EE3512887).S_I_C_Code_Order_,=,__CN(4)))));
    __EE3512913 := TOPN(__EE3512901(__NN(__EE3512901.Within_Last24_Months_) AND __NN(__EE3512901.S_I_C_Code_)),1,__T(__EE3512901.Within_Last24_Months_),__EE3512901.Source_Priority_,__T(__EE3512901.S_I_C_Code_),__T(S_I_C_Code_Order_),__T(Source_),__T(Header_Hit_Flag_));
    SELF.Best_Sic_Code4_Set_ := __CN(__EE3512913);
    SELF := __PP3511912;
  END;
  EXPORT __ENH_Business_Sele_8 := PROJECT(PROJECT(__EE3511887,__ND3511916__Project(LEFT)),__ST195976_Layout);
END;
