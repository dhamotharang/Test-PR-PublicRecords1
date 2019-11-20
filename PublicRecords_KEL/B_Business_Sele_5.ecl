﻿//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Business_Sele_6,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Business_Sele_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Sele_6(__in,__cfg).__ENH_Business_Sele_6) __ENH_Business_Sele_6 := B_Business_Sele_6(__in,__cfg).__ENH_Business_Sele_6;
  SHARED __EE123245 := __ENH_Business_Sele_6;
  EXPORT __ST93904_Layout := RECORD
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
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_I_C_Codes_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).N_A_I_C_S_Codes_Layout) N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Employee_Counts_Layout) Employee_Counts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Sale_Amounts_Layout) Sale_Amounts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Earning_Amounts_Layout) Earning_Amounts_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Asset_Amounts_Layout) Asset_Amounts_;
    KEL.typ.nkdate B_B_B_Member_Since_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).B_B_B_Categories_Layout) B_B_B_Categories_;
    KEL.typ.nbool For_Profit_Indicator_;
    KEL.typ.nstr Public_Or_Private_Indicator_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Company_Types_Layout) S_O_S_Company_Types_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Registered_Agents_Layout) S_O_S_Registered_Agents_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Statuses_Layout) S_O_S_Statuses_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Incorporation_Layout) S_O_S_Incorporation_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Foreign_Information_Layout) S_O_S_Foreign_Information_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Charter_Numbers_Layout) S_O_S_Charter_Numbers_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_O_S_Term_Exist_Codes_Layout) S_O_S_Term_Exist_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Government_Debarred_Layout) Government_Debarred_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Non_Profit_Layout) Non_Profit_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Retirement_Plan_Information_Layout) Retirement_Plan_Information_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Processing_Dates_Layout) Processing_Dates_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Business_Characteristics_Layout) Business_Characteristics_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Business_Registration_Layout) Business_Registration_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_Company_Names_Layout) Best_Company_Names_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_S_I_C_Codes_Layout) Best_S_I_C_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Best_N_A_I_C_S_Codes_Layout) Best_N_A_I_C_S_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.int B_E___B2_B_Carr_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Carr_Cnt24_Mc_No_Cap_ := 0;
    KEL.typ.int B_E___B2_B_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Cnt24_Mc_No_Cap_ := 0;
    KEL.typ.int B_E___B2_B_Flt_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Flt_Cnt24_Mc_No_Cap_ := 0;
    KEL.typ.int B_E___B2_B_Mat_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Mat_Cnt24_Mc_No_Cap_ := 0;
    KEL.typ.int B_E___B2_B_Ops_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Ops_Cnt24_Mc_No_Cap_ := 0;
    KEL.typ.int B_E___B2_B_Oth_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Oth_Cnt24_Mc_No_Cap_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST93904_Layout __ND130317__Project(B_Business_Sele_6(__in,__cfg).__ST95107_Layout __PP122258) := TRANSFORM
    SELF.B_E___B2_B_Carr_Cnt24_Mc_ := KEL.Routines.BoundsFold(__PP122258.B_E___B2_B_Carr_Cnt24_Mc_No_Cap_,0,999);
    SELF.B_E___B2_B_Cnt24_Mc_ := KEL.Routines.BoundsFold(__PP122258.B_E___B2_B_Cnt24_Mc_No_Cap_,0,999);
    SELF.B_E___B2_B_Flt_Cnt24_Mc_ := KEL.Routines.BoundsFold(__PP122258.B_E___B2_B_Flt_Cnt24_Mc_No_Cap_,0,999);
    SELF.B_E___B2_B_Mat_Cnt24_Mc_ := KEL.Routines.BoundsFold(__PP122258.B_E___B2_B_Mat_Cnt24_Mc_No_Cap_,0,999);
    SELF.B_E___B2_B_Ops_Cnt24_Mc_ := KEL.Routines.BoundsFold(__PP122258.B_E___B2_B_Ops_Cnt24_Mc_No_Cap_,0,999);
    SELF.B_E___B2_B_Oth_Cnt24_Mc_ := KEL.Routines.BoundsFold(__PP122258.B_E___B2_B_Oth_Cnt24_Mc_No_Cap_,0,999);
    SELF := __PP122258;
  END;
  EXPORT __ENH_Business_Sele_5 := PROJECT(__EE123245,__ND130317__Project(LEFT));
END;
