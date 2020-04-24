﻿//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Business_Sele_7,B_Business_Sele_8,CFG_Compile,E_Address,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Geo_Link,E_Input_B_I_I,E_Sele_Address,E_Sele_T_I_N,E_T_I_N,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Sele_T_I_N_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Sele_7().__ENH_Business_Sele_7) __ENH_Business_Sele_7 := B_Business_Sele_7(__in,__cfg).__ENH_Business_Sele_7;
  SHARED VIRTUAL TYPEOF(E_Sele_T_I_N().__Result) __E_Sele_T_I_N := E_Sele_T_I_N(__in,__cfg).__Result;
  SHARED __EE375924 := __E_Sele_T_I_N;
  SHARED __EE375904 := __ENH_Business_Sele_7;
  SHARED __ST375996_Layout := RECORD
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
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST165196_Layout) Reported_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Stock_Tickers_Layout) Stock_Tickers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).U_R_Ls_Layout) U_R_Ls_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Vendor_Identification_Layout) Vendor_Identification_;
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST165232_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST165243_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST165254_Layout) Employee_Counts_;
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST165269_Layout) Sale_Amounts_;
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
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST165411_Layout) Data_Sources__1_;
    KEL.typ.ndataset(B_Business_Sele_7(__in,__cfg).__ST272020_Layout) All_Lien_Data_;
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
    KEL.typ.nstr Bus_Input_Name_Clean_Value_;
    B_Business_Sele_8(__in,__cfg).__NS263640_Layout Only_Best_Address_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC375993(E_Sele_T_I_N(__in,__cfg).Layout __EE375924, B_Business_Sele_7(__in,__cfg).__ST165159_Layout __EE375904) := __EEQP(__EE375924.Legal_,__EE375904.UID);
  __ST375996_Layout __JT375993(E_Sele_T_I_N(__in,__cfg).Layout __l, B_Business_Sele_7(__in,__cfg).__ST165159_Layout __r) := TRANSFORM
    SELF.Ult_I_D__1_ := __r.Ult_I_D_;
    SELF.Org_I_D__1_ := __r.Org_I_D_;
    SELF.Sele_I_D__1_ := __r.Sele_I_D_;
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE375994 := JOIN(__EE375924,__EE375904,__JC375993(LEFT,RIGHT),__JT375993(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST164299_Layout := RECORD
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Source_;
    KEL.typ.nkdate My_Date_First_Seen_;
    KEL.typ.nkdate My_Date_Last_Seen_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST164290_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_T_I_N().Typ) Tax_I_D_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nint Best_T_I_N_;
    KEL.typ.nint Best_T_I_N_Rank_;
    KEL.typ.ndataset(__ST164299_Layout) Data_Sources_;
    KEL.typ.nbool Input_T_I_N_Match_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST164290_Layout __ND376445__Project(__ST375996_Layout __PP376417) := TRANSFORM
    __EE376366 := __PP376417.Data_Sources_;
    __ST164299_Layout __ND376371__Project(E_Sele_T_I_N(__in,__cfg).Data_Sources_Layout __PP376367) := TRANSFORM
      SELF.My_Date_First_Seen_ := KEL.era.ToDate(__PP376367.Date_First_Seen_);
      SELF.My_Date_Last_Seen_ := KEL.era.ToDate(__PP376367.Date_Last_Seen_);
      SELF.Translated_Source_ := FN_Compile(__cfg).FN_Source_Group(__ECAST(KEL.typ.nstr,__PP376367.Source_));
      SELF := __PP376367;
    END;
    SELF.Data_Sources_ := __PROJECT(__EE376366,__ND376371__Project(LEFT));
    SELF.Input_T_I_N_Match_ := FN_Compile(__cfg).FN_Edit_Distance_Within_Radius(__ECAST(KEL.typ.nstr,__PP376417.Tax_I_D_),__ECAST(KEL.typ.nstr,__PP376417.B___Inp_Cln_T_I_N_),__ECAST(KEL.typ.nint,__CN(2)));
    SELF := __PP376417;
  END;
  EXPORT __ENH_Sele_T_I_N_6 := PROJECT(__EE375994,__ND376445__Project(LEFT));
END;
