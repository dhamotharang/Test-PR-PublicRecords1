﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Business_Sele_10,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Business_Sele_9(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_Sele_10(__in,__cfg).__ENH_Business_Sele_10) __ENH_Business_Sele_10 := B_Business_Sele_10(__in,__cfg).__ENH_Business_Sele_10;
  SHARED __EE799789 := __ENH_Business_Sele_10;
  EXPORT __ST163139_Layout := RECORD
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
  EXPORT __ST163150_Layout := RECORD
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
  EXPORT __ST163082_Layout := RECORD
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
    KEL.typ.ndataset(__ST163139_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(__ST163150_Layout) N_A_I_C_S_Codes_;
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
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST163082_Layout __ND800460__Project(B_Business_Sele_10(__in,__cfg).__ST163806_Layout __PP799790) := TRANSFORM
    __EE799968 := __PP799790.S_I_C_Codes_;
    __ST163139_Layout __ND800425__Project(B_Business_Sele_10(__in,__cfg).__ST163863_Layout __PP799969) := TRANSFORM
      SELF.Is_Sic_Code_ := __AND(__AND(__OP2(__PP799969.S_I_C_Code_,<>,__CN(0)),__NOT(__NT(__PP799969.S_I_C_Code_))),__OP2(__FN1(LENGTH,__ECAST(KEL.typ.nstr,__PP799969.S_I_C_Code_)),<=,__CN(4)));
      SELF.Source_Priority_ := MAP(__T(__OP2(__PP799969.Source_,=,__CN('DF')))=>1,__T(__OP2(__PP799969.Source_,=,__CN('Z1')))=>2,__T(__OP2(__PP799969.Source_,=,__CN('D')))=>3,__T(__OP2(__PP799969.Source_,=,__CN('RQ')))=>4,__T(__OP2(__PP799969.Source_,=,__CN('Z2')))=>5,__T(__OP2(__PP799969.Source_,=,__CN('RR')))=>6,__T(__OP2(__PP799969.Source_,=,__CN('DN')))=>7,__T(__OP2(__PP799969.Source_,=,__CN('ER')))=>8,__T(__OP2(__PP799969.Source_,=,__CN('Q3')))=>9,__T(__OP2(__PP799969.Source_,=,__CN('L0')))=>10,__T(__OP2(__PP799969.Source_,=,__CN('Y')))=>11,12);
      SELF.Within_Last24_Months_ := __OP2(__PP799969.Days_Since_Code_,<,__CN(730));
      SELF := __PP799969;
    END;
    SELF.S_I_C_Codes_ := __PROJECT(__EE799968,__ND800425__Project(LEFT));
    __EE800053 := __PP799790.N_A_I_C_S_Codes_;
    __ST163150_Layout __ND800467__Project(B_Business_Sele_10(__in,__cfg).__ST163871_Layout __PP800054) := TRANSFORM
      SELF.Is_N_A_I_C_S_Code_ := __AND(__AND(__OP2(__PP800054.N_A_I_C_S_Code_,<>,__CN(0)),__NOT(__NT(__PP800054.N_A_I_C_S_Code_))),__OP2(__FN1(LENGTH,__ECAST(KEL.typ.nstr,__PP800054.N_A_I_C_S_Code_)),<=,__CN(6)));
      SELF.Source_Priority_ := MAP(__T(__OP2(__PP800054.Source_,=,__CN('DF')))=>1,__T(__OP2(__PP800054.Source_,=,__CN('Z1')))=>2,__T(__OP2(__PP800054.Source_,=,__CN('RR')))=>3,__T(__OP2(__PP800054.Source_,=,__CN('C#')))=>4,__T(__OP2(__PP800054.Source_,=,__CN('TX')))=>5,__T(__OP2(__PP800054.Source_,=,__CN('CP')))=>6,__T(__OP2(__PP800054.Source_,=,__CN('C?')))=>7,__T(__OP2(__PP800054.Source_,=,__CN('CI')))=>8,__T(__OP2(__PP800054.Source_,=,__CN('Q3')))=>9,__T(__OP2(__PP800054.Source_,=,__CN('Y')))=>10,11);
      SELF.Within_Last24_Months_ := __OP2(__PP800054.Days_Since_Code_,<,__CN(730));
      SELF := __PP800054;
    END;
    SELF.N_A_I_C_S_Codes_ := __PROJECT(__EE800053,__ND800467__Project(LEFT));
    SELF := __PP799790;
  END;
  EXPORT __ENH_Business_Sele_9 := PROJECT(__EE799789,__ND800460__Project(LEFT));
END;
