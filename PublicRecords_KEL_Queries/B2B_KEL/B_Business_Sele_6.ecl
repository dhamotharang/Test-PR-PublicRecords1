﻿//HPCC Systems KEL Compiler Version 1.5.0
IMPORT KEL15 AS KEL;
IMPORT B_Tradeline_7,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Sele_Tradeline,E_Tradeline FROM PublicRecords_KEL_Queries.B2B_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Business_Sele_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Business_Sele(__in,__cfg).__Result) __E_Business_Sele := E_Business_Sele(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Tradeline_7(__in,__cfg).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7(__in,__cfg).__ENH_Tradeline_7;
  SHARED __EE149055 := __E_Business_Sele;
  SHARED __EE412462 := __ENH_Tradeline_7;
  SHARED __EE412473 := __EE412462.Records_;
  __JC412476(B_Tradeline_7(__in,__cfg).__ST144136_Layout __EE412473) := __T(__EE412473.Is_Two_Year_Full_Record_);
  SHARED __EE412477 := __EE412462(EXISTS(__CHILDJOINFILTER(__EE412473,__JC412476)));
  SHARED __EE149386 := __E_Sele_Tradeline;
  SHARED __EE415178 := __EE149386(__NN(__EE149386.Legal_) AND __NN(__EE149386.Account_));
  SHARED __ST151098_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Account_Key_;
    KEL.typ.ndataset(B_Tradeline_7(__in,__cfg).__ST144136_Layout) Records_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Vendor_Dates_Layout) Vendor_Dates_;
    KEL.typ.ndataset(E_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_First_Of_Month_;
    KEL.typ.nint Current_Month_;
    KEL.typ.nint Current_Year_;
    KEL.typ.nkdate Two_Year_Full_Date_;
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Sele_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC415196(B_Tradeline_7(__in,__cfg).__ST144129_Layout __EE412477, E_Sele_Tradeline(__in,__cfg).Layout __EE415178) := __EEQP(__EE415178.Account_,__EE412477.UID);
  __ST151098_Layout __JT415196(B_Tradeline_7(__in,__cfg).__ST144129_Layout __l, E_Sele_Tradeline(__in,__cfg).Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE415197 := JOIN(__EE415178,__EE412477,__JC415196(RIGHT,LEFT),__JT415196(RIGHT,LEFT),INNER,HASH);
  SHARED __ST150020_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Tradeline().Typ) Account_;
    KEL.typ.ndataset(E_Sele_Tradeline(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ndataset(B_Tradeline_7(__in,__cfg).__ST144136_Layout) Records_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST150020_Layout __ND415251__Project(__ST151098_Layout __PP415198) := TRANSFORM
    SELF.UID := __PP415198.Legal_;
    SELF.Data_Sources_ := __PP415198.Data_Sources__1_;
    SELF.U_I_D__1_ := __PP415198.UID;
    SELF := __PP415198;
  END;
  SHARED __EE415328 := PROJECT(__EE415197,__ND415251__Project(LEFT));
  SHARED __ST150156_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.bool Exp1_ := FALSE;
    KEL.typ.bool Exp2_ := FALSE;
    KEL.typ.bool Exp3_ := FALSE;
    KEL.typ.bool Exp4_ := FALSE;
    KEL.typ.bool Exp5_ := FALSE;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __ST150156_Layout __ND415333__Project(__ST150020_Layout __PP415329) := TRANSFORM
    __BS415365 := __T(__PP415329.Records_);
    SELF.Exp1_ := EXISTS(__BS415365(__T(__AND(__T(__PP415329.Records_).Carrier_Segment_,__T(__PP415329.Records_).Is_Two_Year_Full_Record_))));
    __BS415401 := __T(__PP415329.Records_);
    SELF.Exp2_ := EXISTS(__BS415401(__T(__AND(__T(__PP415329.Records_).Fleet_Segment_,__T(__PP415329.Records_).Is_Two_Year_Full_Record_))));
    __BS415437 := __T(__PP415329.Records_);
    SELF.Exp3_ := EXISTS(__BS415437(__T(__AND(__T(__PP415329.Records_).Materials_Segment_,__T(__PP415329.Records_).Is_Two_Year_Full_Record_))));
    __BS415473 := __T(__PP415329.Records_);
    SELF.Exp4_ := EXISTS(__BS415473(__T(__AND(__T(__PP415329.Records_).Operations_Segment_,__T(__PP415329.Records_).Is_Two_Year_Full_Record_))));
    __BS415509 := __T(__PP415329.Records_);
    SELF.Exp5_ := EXISTS(__BS415509(__T(__AND(__T(__PP415329.Records_).Other_Segment_,__T(__PP415329.Records_).Is_Two_Year_Full_Record_))));
    SELF := __PP415329;
  END;
  SHARED __EE415528 := PROJECT(__EE415328,__ND415333__Project(LEFT));
  SHARED __ST150192_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Business_Sele().Typ) UID;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
  END;
  SHARED __EE415566 := PROJECT(__CLEANANDDO(__EE415528,TABLE(__EE415528,{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP,__EE415528.Exp1_),KEL.typ.int C_O_U_N_T___Exp1__1_ := COUNT(GROUP),KEL.typ.int C_O_U_N_T___Exp1__2_ := COUNT(GROUP,__EE415528.Exp2_),KEL.typ.int C_O_U_N_T___Exp1__3_ := COUNT(GROUP,__EE415528.Exp3_),KEL.typ.int C_O_U_N_T___Exp1__4_ := COUNT(GROUP,__EE415528.Exp4_),KEL.typ.int C_O_U_N_T___Exp1__5_ := COUNT(GROUP,__EE415528.Exp5_),UID},UID,MERGE)),__ST150192_Layout);
  SHARED __ST151279_Layout := RECORD
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
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_I_C_Codes_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).N_A_I_C_S_Codes_Layout) N_A_I_C_S_Codes_;
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
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.ntyp(E_Business_Sele().Typ) U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC415572(E_Business_Sele(__in,__cfg).Layout __EE149055, __ST150192_Layout __EE415566) := __EEQP(__EE149055.UID,__EE415566.UID);
  __ST151279_Layout __JT415572(E_Business_Sele(__in,__cfg).Layout __l, __ST150192_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE415573 := JOIN(__EE149055,__EE415566,__JC415572(LEFT,RIGHT),__JT415572(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST143665_Layout := RECORD
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
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).S_I_C_Codes_Layout) S_I_C_Codes_;
    KEL.typ.ndataset(E_Business_Sele(__in,__cfg).N_A_I_C_S_Codes_Layout) N_A_I_C_S_Codes_;
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
    KEL.typ.int B_E___B2_B_Carr_Cnt24_Mc_No_Cap_ := 0;
    KEL.typ.int B_E___B2_B_Cnt24_Mc_No_Cap_ := 0;
    KEL.typ.int B_E___B2_B_Flt_Cnt24_Mc_No_Cap_ := 0;
    KEL.typ.int B_E___B2_B_Mat_Cnt24_Mc_No_Cap_ := 0;
    KEL.typ.int B_E___B2_B_Ops_Cnt24_Mc_No_Cap_ := 0;
    KEL.typ.int B_E___B2_B_Oth_Cnt24_Mc_No_Cap_ := 0;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST143665_Layout __ND415730__Project(__ST151279_Layout __PP415574) := TRANSFORM
    SELF.B_E___B2_B_Carr_Cnt24_Mc_No_Cap_ := __PP415574.C_O_U_N_T___Exp1_;
    SELF.B_E___B2_B_Cnt24_Mc_No_Cap_ := __PP415574.C_O_U_N_T___Exp1__1_;
    SELF.B_E___B2_B_Flt_Cnt24_Mc_No_Cap_ := __PP415574.C_O_U_N_T___Exp1__2_;
    SELF.B_E___B2_B_Mat_Cnt24_Mc_No_Cap_ := __PP415574.C_O_U_N_T___Exp1__3_;
    SELF.B_E___B2_B_Ops_Cnt24_Mc_No_Cap_ := __PP415574.C_O_U_N_T___Exp1__4_;
    SELF.B_E___B2_B_Oth_Cnt24_Mc_No_Cap_ := __PP415574.C_O_U_N_T___Exp1__5_;
    SELF := __PP415574;
  END;
  EXPORT __ENH_Business_Sele_6 := PROJECT(__EE415573,__ND415730__Project(LEFT));
END;
