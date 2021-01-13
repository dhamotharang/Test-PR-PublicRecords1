﻿//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Account_4,B_Business_4,CFG_graph,E_Account,E_Business,E_Business_Account FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Business_3(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Account_4(__in,__cfg).__ENH_Account_4) __ENH_Account_4 := B_Account_4(__in,__cfg).__ENH_Account_4;
  SHARED VIRTUAL TYPEOF(B_Business_4(__in,__cfg).__ENH_Business_4) __ENH_Business_4 := B_Business_4(__in,__cfg).__ENH_Business_4;
  SHARED VIRTUAL TYPEOF(E_Business_Account(__in,__cfg).__Result) __E_Business_Account := E_Business_Account(__in,__cfg).__Result;
  SHARED __EE9851776 := __ENH_Business_4;
  SHARED __EE9851779 := __ENH_Account_4;
  SHARED __EE489531 := __E_Business_Account;
  SHARED __EE9854666 := __EE489531(__NN(__EE489531._bus_) AND __NN(__EE489531._acc_));
  SHARED __ST504930_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nunk _seq_;
    KEL.typ.nunk _ultid_;
    KEL.typ.nunk _orgid_;
    KEL.typ.nunk _seleid_;
    KEL.typ.nunk _proxid_;
    KEL.typ.nunk _powid_;
    KEL.typ.nunk _empid_;
    KEL.typ.nunk _dotid_;
    KEL.typ.nunk _ultscore_;
    KEL.typ.nunk _orgscore_;
    KEL.typ.nunk _selescore_;
    KEL.typ.nunk _proxscore_;
    KEL.typ.nunk _powscore_;
    KEL.typ.nunk _empscore_;
    KEL.typ.nunk _dotscore_;
    KEL.typ.nunk _ultweight_;
    KEL.typ.nunk _orgweight_;
    KEL.typ.nunk _seleweight_;
    KEL.typ.nunk _proxweight_;
    KEL.typ.nunk _powweight_;
    KEL.typ.nunk _empweight_;
    KEL.typ.nunk _dotweight_;
    KEL.typ.nkdate _dt__first__seen_;
    KEL.typ.nkdate _dt__last__seen_;
    KEL.typ.nkdate _dt__vendor__first__reported_;
    KEL.typ.nkdate _dt__vendor__last__reported_;
    KEL.typ.nkdate _dt__datawarehouse__first__reported_;
    KEL.typ.nkdate _dt__datawarehouse__last__reported_;
    KEL.typ.nunk _did_;
    KEL.typ.nunk _did__score_;
    KEL.typ.nint Account_Type_;
    KEL.typ.nint Current_Credit_Limit_;
    KEL.typ.nkdate Date_Account_Opened_;
    KEL.typ.nkdate Date_Closed_;
    KEL.typ.nkdate Date_Closed_Estimated_;
    KEL.typ.bool Has_Closed_ := FALSE;
    KEL.typ.nbool Has_Closed12_Month_;
    KEL.typ.nbool Has_Closed24_Month_;
    KEL.typ.nbool Has_Closed36_Month_;
    KEL.typ.nbool Has_Closed3_Month_;
    KEL.typ.nbool Has_Closed60_Month_;
    KEL.typ.nbool Has_Closed6_Month_;
    KEL.typ.nbool Has_Closed84_Month_;
    KEL.typ.nkdate Hist03_M_Limit_Date_;
    KEL.typ.nkdate Hist03_M_Limit_Load_Date_;
    KEL.typ.nkdate Hist06_M_Limit_Date_;
    KEL.typ.nkdate Hist06_M_Limit_Load_Date_;
    KEL.typ.nkdate Hist12_M_Limit_Date_;
    KEL.typ.nkdate Hist12_M_Limit_Load_Date_;
    KEL.typ.nkdate Hist24_M_Limit_Date_;
    KEL.typ.nkdate Hist24_M_Limit_Load_Date_;
    KEL.typ.nkdate Hist36_M_Limit_Date_;
    KEL.typ.nkdate Hist36_M_Limit_Load_Date_;
    KEL.typ.nkdate Hist60_M_Limit_Date_;
    KEL.typ.nkdate Hist60_M_Limit_Load_Date_;
    KEL.typ.nkdate Hist84_M_Limit_Date_;
    KEL.typ.nkdate Hist84_M_Limit_Load_Date_;
    KEL.typ.nbool Is_Card_;
    KEL.typ.nbool Is_Line_;
    KEL.typ.nbool Is_Loan_;
    KEL.typ.nbool Is_O_Line_;
    KEL.typ.nbool Is_Open_;
    KEL.typ.nbool Is_Open12_Month_;
    KEL.typ.nbool Is_Open24_Month_;
    KEL.typ.nbool Is_Open36_Month_;
    KEL.typ.nbool Is_Open3_Month_;
    KEL.typ.nbool Is_Open60_Month_;
    KEL.typ.nbool Is_Open6_Month_;
    KEL.typ.nbool Is_Open84_Month_;
    KEL.typ.nbool Is_Revolving_Account_;
    KEL.typ.nbool Is_Stale_;
    KEL.typ.nbool Is_Stale12_Month_;
    KEL.typ.nbool Is_Stale24_Month_;
    KEL.typ.nbool Is_Stale36_Month_;
    KEL.typ.nbool Is_Stale3_Month_;
    KEL.typ.nbool Is_Stale60_Month_;
    KEL.typ.nbool Is_Stale6_Month_;
    KEL.typ.nbool Is_Stale84_Month_;
    KEL.typ.nkdate Last_Cycle_End_Date_;
    KEL.typ.nint Maximum_Credit_Used_;
    KEL.typ.nint Maximum_Currrent_Limit_;
    KEL.typ.nint Maximum_Original_Limit_;
    KEL.typ.nint Min_Days_From_One_Year_;
    KEL.typ.nint Min_Days_From_Two_Years_;
    KEL.typ.nkdate Most_Recent_Balance_Date_;
    KEL.typ.nkdate Most_Recent_Chargeoff_Date_;
    KEL.typ.nkdate Most_Recent_Closed_Report_Date_;
    KEL.typ.nkdate Most_Recent_Delinquency_Reported_Date_;
    KEL.typ.nkdate Most_Recent_Payment_Status_Date_;
    KEL.typ.nkdate Most_Recent_Type_Report_Date_;
    KEL.typ.nkdate Most_Recently_Open_Load_Date_;
    KEL.typ.nkdate Most_Recently_Reported_Limit_Date_;
    KEL.typ.nbool Opened_Last03_Month_;
    KEL.typ.nbool Opened_Last06_Month_;
    KEL.typ.nbool Opened_Last12_Month_;
    KEL.typ.nbool Opened_Last24_Month_;
    KEL.typ.nbool Opened_Last36_Month_;
    KEL.typ.nbool Opened_Last60_Month_;
    KEL.typ.nbool Opened_Last84_Month_;
    KEL.typ.nkdate Tradeline03_Month_Date_;
    KEL.typ.nkdate Tradeline03_Month_Load_Date_;
    KEL.typ.nkdate Tradeline06_Month_Date_;
    KEL.typ.nkdate Tradeline06_Month_Load_Date_;
    KEL.typ.nkdate Tradeline12_Month_Date_;
    KEL.typ.nkdate Tradeline12_Month_Load_Date_;
    KEL.typ.nkdate Tradeline24_Month_Date_;
    KEL.typ.nkdate Tradeline24_Month_Load_Date_;
    KEL.typ.nkdate Tradeline36_Month_Date_;
    KEL.typ.nkdate Tradeline36_Month_Load_Date_;
    KEL.typ.nkdate Tradeline60_Month_Date_;
    KEL.typ.nkdate Tradeline60_Month_Load_Date_;
    KEL.typ.nkdate Tradeline84_Month_Date_;
    KEL.typ.nkdate Tradeline84_Month_Load_Date_;
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Account().Typ) _acc_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC9854684(B_Account_4(__in,__cfg).__ST245745_Layout __EE9851779, E_Business_Account(__in,__cfg).Layout __EE9854666) := __EEQP(__EE9854666._acc_,__EE9851779.UID);
  __ST504930_Layout __JT9854684(B_Account_4(__in,__cfg).__ST245745_Layout __l, E_Business_Account(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE9854685 := JOIN(__EE9854666,__EE9851779,__JC9854684(RIGHT,LEFT),__JT9854684(RIGHT,LEFT),INNER,HASH);
  SHARED __ST503184_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Account().Typ) _acc_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nbool Is_Card_;
    KEL.typ.nbool Is_Open_;
    KEL.typ.nint Current_Credit_Limit_;
    KEL.typ.nint Account_Type_;
    KEL.typ.nkdate Date_Account_Opened_;
    KEL.typ.nkdate Date_Closed_;
    KEL.typ.nkdate Date_Closed_Estimated_;
    KEL.typ.bool Has_Closed_ := FALSE;
    KEL.typ.nbool Has_Closed12_Month_;
    KEL.typ.nbool Has_Closed24_Month_;
    KEL.typ.nbool Has_Closed36_Month_;
    KEL.typ.nbool Has_Closed3_Month_;
    KEL.typ.nbool Has_Closed60_Month_;
    KEL.typ.nbool Has_Closed6_Month_;
    KEL.typ.nbool Has_Closed84_Month_;
    KEL.typ.nkdate Hist03_M_Limit_Date_;
    KEL.typ.nkdate Hist03_M_Limit_Load_Date_;
    KEL.typ.nkdate Hist06_M_Limit_Date_;
    KEL.typ.nkdate Hist06_M_Limit_Load_Date_;
    KEL.typ.nkdate Hist12_M_Limit_Date_;
    KEL.typ.nkdate Hist12_M_Limit_Load_Date_;
    KEL.typ.nkdate Hist24_M_Limit_Date_;
    KEL.typ.nkdate Hist24_M_Limit_Load_Date_;
    KEL.typ.nkdate Hist36_M_Limit_Date_;
    KEL.typ.nkdate Hist36_M_Limit_Load_Date_;
    KEL.typ.nkdate Hist60_M_Limit_Date_;
    KEL.typ.nkdate Hist60_M_Limit_Load_Date_;
    KEL.typ.nkdate Hist84_M_Limit_Date_;
    KEL.typ.nkdate Hist84_M_Limit_Load_Date_;
    KEL.typ.nbool Is_Line_;
    KEL.typ.nbool Is_Loan_;
    KEL.typ.nbool Is_O_Line_;
    KEL.typ.nbool Is_Open12_Month_;
    KEL.typ.nbool Is_Open24_Month_;
    KEL.typ.nbool Is_Open36_Month_;
    KEL.typ.nbool Is_Open3_Month_;
    KEL.typ.nbool Is_Open60_Month_;
    KEL.typ.nbool Is_Open6_Month_;
    KEL.typ.nbool Is_Open84_Month_;
    KEL.typ.nbool Is_Revolving_Account_;
    KEL.typ.nbool Is_Stale_;
    KEL.typ.nbool Is_Stale12_Month_;
    KEL.typ.nbool Is_Stale24_Month_;
    KEL.typ.nbool Is_Stale36_Month_;
    KEL.typ.nbool Is_Stale3_Month_;
    KEL.typ.nbool Is_Stale60_Month_;
    KEL.typ.nbool Is_Stale6_Month_;
    KEL.typ.nbool Is_Stale84_Month_;
    KEL.typ.nkdate Last_Cycle_End_Date_;
    KEL.typ.nint Maximum_Credit_Used_;
    KEL.typ.nint Maximum_Currrent_Limit_;
    KEL.typ.nint Maximum_Original_Limit_;
    KEL.typ.nint Min_Days_From_One_Year_;
    KEL.typ.nint Min_Days_From_Two_Years_;
    KEL.typ.nkdate Most_Recent_Balance_Date_;
    KEL.typ.nkdate Most_Recent_Chargeoff_Date_;
    KEL.typ.nkdate Most_Recent_Closed_Report_Date_;
    KEL.typ.nkdate Most_Recent_Delinquency_Reported_Date_;
    KEL.typ.nkdate Most_Recent_Payment_Status_Date_;
    KEL.typ.nkdate Most_Recent_Type_Report_Date_;
    KEL.typ.nkdate Most_Recently_Open_Load_Date_;
    KEL.typ.nkdate Most_Recently_Reported_Limit_Date_;
    KEL.typ.nbool Opened_Last03_Month_;
    KEL.typ.nbool Opened_Last06_Month_;
    KEL.typ.nbool Opened_Last12_Month_;
    KEL.typ.nbool Opened_Last24_Month_;
    KEL.typ.nbool Opened_Last36_Month_;
    KEL.typ.nbool Opened_Last60_Month_;
    KEL.typ.nbool Opened_Last84_Month_;
    KEL.typ.nkdate Tradeline03_Month_Date_;
    KEL.typ.nkdate Tradeline03_Month_Load_Date_;
    KEL.typ.nkdate Tradeline06_Month_Date_;
    KEL.typ.nkdate Tradeline06_Month_Load_Date_;
    KEL.typ.nkdate Tradeline12_Month_Date_;
    KEL.typ.nkdate Tradeline12_Month_Load_Date_;
    KEL.typ.nkdate Tradeline24_Month_Date_;
    KEL.typ.nkdate Tradeline24_Month_Load_Date_;
    KEL.typ.nkdate Tradeline36_Month_Date_;
    KEL.typ.nkdate Tradeline36_Month_Load_Date_;
    KEL.typ.nkdate Tradeline60_Month_Date_;
    KEL.typ.nkdate Tradeline60_Month_Load_Date_;
    KEL.typ.nkdate Tradeline84_Month_Date_;
    KEL.typ.nkdate Tradeline84_Month_Load_Date_;
    KEL.typ.nunk _did_;
    KEL.typ.nunk _did__score_;
    KEL.typ.nunk _dotid_;
    KEL.typ.nunk _dotscore_;
    KEL.typ.nunk _dotweight_;
    KEL.typ.nkdate _dt__datawarehouse__first__reported_;
    KEL.typ.nkdate _dt__datawarehouse__last__reported_;
    KEL.typ.nkdate _dt__first__seen_;
    KEL.typ.nkdate _dt__last__seen_;
    KEL.typ.nkdate _dt__vendor__first__reported_;
    KEL.typ.nkdate _dt__vendor__last__reported_;
    KEL.typ.nunk _empid_;
    KEL.typ.nunk _empscore_;
    KEL.typ.nunk _empweight_;
    KEL.typ.nunk _orgid_;
    KEL.typ.nunk _orgscore_;
    KEL.typ.nunk _orgweight_;
    KEL.typ.nunk _powid_;
    KEL.typ.nunk _powscore_;
    KEL.typ.nunk _powweight_;
    KEL.typ.nunk _proxid_;
    KEL.typ.nunk _proxscore_;
    KEL.typ.nunk _proxweight_;
    KEL.typ.nunk _seleid_;
    KEL.typ.nunk _selescore_;
    KEL.typ.nunk _seleweight_;
    KEL.typ.nunk _seq_;
    KEL.typ.nunk _ultid_;
    KEL.typ.nunk _ultscore_;
    KEL.typ.nunk _ultweight_;
  END;
  SHARED __ST503184_Layout __ND9854807__Project(__ST504930_Layout __PP9854686) := TRANSFORM
    SELF.UID := __PP9854686._bus_;
    SELF.U_I_D__1_ := __PP9854686.UID;
    SELF := __PP9854686;
  END;
  SHARED __EE9855276 := PROJECT(__EE9854685,__ND9854807__Project(LEFT));
  SHARED __ST503625_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nbool Exp1_;
    KEL.typ.nbool Exp2_;
    KEL.typ.nint Exp3_;
    KEL.typ.nbool Exp4_;
    KEL.typ.nbool Exp5_;
    KEL.typ.nint Exp6_;
    KEL.typ.nbool Exp7_;
    KEL.typ.nbool Exp8_;
    KEL.typ.nint Exp9_;
    KEL.typ.nbool Exp10_;
    KEL.typ.nbool Exp11_;
    KEL.typ.nint Exp12_;
    KEL.typ.nbool Exp13_;
    KEL.typ.nbool Exp14_;
    KEL.typ.nbool Exp15_;
    KEL.typ.nbool Exp16_;
    KEL.typ.nbool Exp17_;
    KEL.typ.nbool Exp18_;
    KEL.typ.nbool Exp19_;
    KEL.typ.nbool Exp20_;
    KEL.typ.nbool Exp21_;
    KEL.typ.nbool Exp22_;
    KEL.typ.nbool Exp23_;
    KEL.typ.nbool Exp24_;
    KEL.typ.nbool Exp25_;
    KEL.typ.nbool Exp26_;
    KEL.typ.nbool Exp27_;
    KEL.typ.nbool Exp28_;
    KEL.typ.nbool Exp29_;
    KEL.typ.nbool Exp30_;
    KEL.typ.nbool Exp31_;
    KEL.typ.nbool Exp32_;
    KEL.typ.nbool Exp33_;
  END;
  SHARED __ST503625_Layout __ND9855281__Project(__ST503184_Layout __PP9855277) := TRANSFORM
    SELF.Exp1_ := __AND(__PP9855277.Is_Card_,__PP9855277.Is_Open_);
    SELF.Exp2_ := __AND(__AND(__PP9855277.Is_Card_,__PP9855277.Is_Open_),__NOT(__NT(__PP9855277.Current_Credit_Limit_)));
    SELF.Exp3_ := IF(__T(__AND(__PP9855277.Is_Card_,__PP9855277.Is_Open_)),__ECAST(KEL.typ.nint,__PP9855277.Current_Credit_Limit_),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
    SELF.Exp4_ := __AND(__PP9855277.Is_Line_,__PP9855277.Is_Open_);
    SELF.Exp5_ := __AND(__AND(__PP9855277.Is_Line_,__PP9855277.Is_Open_),__NOT(__NT(__PP9855277.Current_Credit_Limit_)));
    SELF.Exp6_ := IF(__T(__AND(__PP9855277.Is_Line_,__PP9855277.Is_Open_)),__ECAST(KEL.typ.nint,__PP9855277.Current_Credit_Limit_),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
    SELF.Exp7_ := __AND(__PP9855277.Is_O_Line_,__PP9855277.Is_Open_);
    SELF.Exp8_ := __AND(__AND(__PP9855277.Is_O_Line_,__PP9855277.Is_Open_),__NOT(__NT(__PP9855277.Current_Credit_Limit_)));
    SELF.Exp9_ := IF(__T(__AND(__PP9855277.Is_O_Line_,__PP9855277.Is_Open_)),__ECAST(KEL.typ.nint,__PP9855277.Current_Credit_Limit_),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
    SELF.Exp10_ := __AND(__PP9855277.Is_Revolving_Account_,__PP9855277.Is_Open_);
    SELF.Exp11_ := __AND(__AND(__PP9855277.Is_Revolving_Account_,__PP9855277.Is_Open_),__NOT(__NT(__PP9855277.Current_Credit_Limit_)));
    SELF.Exp12_ := IF(__T(__AND(__PP9855277.Is_Revolving_Account_,__PP9855277.Is_Open_)),__ECAST(KEL.typ.nint,__PP9855277.Current_Credit_Limit_),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
    SELF.Exp13_ := __AND(__PP9855277.Is_Card_,__PP9855277.Is_Open3_Month_);
    SELF.Exp14_ := __AND(__PP9855277.Is_Card_,__PP9855277.Is_Open6_Month_);
    SELF.Exp15_ := __AND(__PP9855277.Is_Card_,__PP9855277.Is_Open12_Month_);
    SELF.Exp16_ := __AND(__PP9855277.Is_Card_,__PP9855277.Is_Open24_Month_);
    SELF.Exp17_ := __AND(__PP9855277.Is_Card_,__PP9855277.Is_Open36_Month_);
    SELF.Exp18_ := __AND(__PP9855277.Is_Card_,__PP9855277.Is_Open60_Month_);
    SELF.Exp19_ := __AND(__PP9855277.Is_Card_,__PP9855277.Is_Open84_Month_);
    SELF.Exp20_ := __AND(__PP9855277.Is_Line_,__PP9855277.Is_Open3_Month_);
    SELF.Exp21_ := __AND(__PP9855277.Is_Line_,__PP9855277.Is_Open6_Month_);
    SELF.Exp22_ := __AND(__PP9855277.Is_Line_,__PP9855277.Is_Open12_Month_);
    SELF.Exp23_ := __AND(__PP9855277.Is_Line_,__PP9855277.Is_Open24_Month_);
    SELF.Exp24_ := __AND(__PP9855277.Is_Line_,__PP9855277.Is_Open36_Month_);
    SELF.Exp25_ := __AND(__PP9855277.Is_Line_,__PP9855277.Is_Open60_Month_);
    SELF.Exp26_ := __AND(__PP9855277.Is_Line_,__PP9855277.Is_Open84_Month_);
    SELF.Exp27_ := __AND(__PP9855277.Is_O_Line_,__PP9855277.Is_Open3_Month_);
    SELF.Exp28_ := __AND(__PP9855277.Is_O_Line_,__PP9855277.Is_Open6_Month_);
    SELF.Exp29_ := __AND(__PP9855277.Is_O_Line_,__PP9855277.Is_Open12_Month_);
    SELF.Exp30_ := __AND(__PP9855277.Is_O_Line_,__PP9855277.Is_Open24_Month_);
    SELF.Exp31_ := __AND(__PP9855277.Is_O_Line_,__PP9855277.Is_Open36_Month_);
    SELF.Exp32_ := __AND(__PP9855277.Is_O_Line_,__PP9855277.Is_Open60_Month_);
    SELF.Exp33_ := __AND(__PP9855277.Is_O_Line_,__PP9855277.Is_Open84_Month_);
    SELF := __PP9855277;
  END;
  SHARED __EE9855549 := PROJECT(__EE9855276,__ND9855281__Project(LEFT));
  SHARED __ST503800_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Account_ := 0;
    KEL.typ.int S_U_M___Current_Credit_Limit_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Account__1_ := 0;
    KEL.typ.int S_U_M___Current_Credit_Limit__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Account__2_ := 0;
    KEL.typ.int S_U_M___Current_Credit_Limit__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Account__3_ := 0;
    KEL.typ.int S_U_M___Current_Credit_Limit__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__6_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__7_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__8_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__9_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__10_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__11_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__12_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__13_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__14_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__15_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__16_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__17_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__18_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__19_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__20_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__21_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__22_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__23_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__24_ := 0;
    KEL.typ.ntyp(E_Business().Typ) UID;
  END;
  SHARED __EE9856118 := PROJECT(__CLEANANDDO(__EE9855549,TABLE(__EE9855549,{KEL.typ.int C_O_U_N_T___Exp1_ := COUNT(GROUP,__T(__EE9855549.Exp1_)),KEL.typ.int C_O_U_N_T___Account_ := COUNT(GROUP,__T(__EE9855549.Exp2_)),KEL.typ.int S_U_M___Current_Credit_Limit_ := KEL.Aggregates.SumNG(__EE9855549.Exp3_),KEL.typ.int C_O_U_N_T___Exp1__1_ := COUNT(GROUP,__T(__EE9855549.Exp4_)),KEL.typ.int C_O_U_N_T___Account__1_ := COUNT(GROUP,__T(__EE9855549.Exp5_)),KEL.typ.int S_U_M___Current_Credit_Limit__1_ := KEL.Aggregates.SumNG(__EE9855549.Exp6_),KEL.typ.int C_O_U_N_T___Exp1__2_ := COUNT(GROUP,__T(__EE9855549.Exp7_)),KEL.typ.int C_O_U_N_T___Account__2_ := COUNT(GROUP,__T(__EE9855549.Exp8_)),KEL.typ.int S_U_M___Current_Credit_Limit__2_ := KEL.Aggregates.SumNG(__EE9855549.Exp9_),KEL.typ.int C_O_U_N_T___Exp1__3_ := COUNT(GROUP,__T(__EE9855549.Exp10_)),KEL.typ.int C_O_U_N_T___Account__3_ := COUNT(GROUP,__T(__EE9855549.Exp11_)),KEL.typ.int S_U_M___Current_Credit_Limit__3_ := KEL.Aggregates.SumNG(__EE9855549.Exp12_),KEL.typ.int C_O_U_N_T___Exp1__4_ := COUNT(GROUP,__T(__EE9855549.Exp13_)),KEL.typ.int C_O_U_N_T___Exp1__5_ := COUNT(GROUP,__T(__EE9855549.Exp14_)),KEL.typ.int C_O_U_N_T___Exp1__6_ := COUNT(GROUP,__T(__EE9855549.Exp15_)),KEL.typ.int C_O_U_N_T___Exp1__7_ := COUNT(GROUP,__T(__EE9855549.Exp16_)),KEL.typ.int C_O_U_N_T___Exp1__8_ := COUNT(GROUP,__T(__EE9855549.Exp17_)),KEL.typ.int C_O_U_N_T___Exp1__9_ := COUNT(GROUP,__T(__EE9855549.Exp18_)),KEL.typ.int C_O_U_N_T___Exp1__10_ := COUNT(GROUP,__T(__EE9855549.Exp19_)),KEL.typ.int C_O_U_N_T___Exp1__11_ := COUNT(GROUP,__T(__EE9855549.Exp20_)),KEL.typ.int C_O_U_N_T___Exp1__12_ := COUNT(GROUP,__T(__EE9855549.Exp21_)),KEL.typ.int C_O_U_N_T___Exp1__13_ := COUNT(GROUP,__T(__EE9855549.Exp22_)),KEL.typ.int C_O_U_N_T___Exp1__14_ := COUNT(GROUP,__T(__EE9855549.Exp23_)),KEL.typ.int C_O_U_N_T___Exp1__15_ := COUNT(GROUP,__T(__EE9855549.Exp24_)),KEL.typ.int C_O_U_N_T___Exp1__16_ := COUNT(GROUP,__T(__EE9855549.Exp25_)),KEL.typ.int C_O_U_N_T___Exp1__17_ := COUNT(GROUP,__T(__EE9855549.Exp26_)),KEL.typ.int C_O_U_N_T___Exp1__18_ := COUNT(GROUP,__T(__EE9855549.Exp27_)),KEL.typ.int C_O_U_N_T___Exp1__19_ := COUNT(GROUP,__T(__EE9855549.Exp28_)),KEL.typ.int C_O_U_N_T___Exp1__20_ := COUNT(GROUP,__T(__EE9855549.Exp29_)),KEL.typ.int C_O_U_N_T___Exp1__21_ := COUNT(GROUP,__T(__EE9855549.Exp30_)),KEL.typ.int C_O_U_N_T___Exp1__22_ := COUNT(GROUP,__T(__EE9855549.Exp31_)),KEL.typ.int C_O_U_N_T___Exp1__23_ := COUNT(GROUP,__T(__EE9855549.Exp32_)),KEL.typ.int C_O_U_N_T___Exp1__24_ := COUNT(GROUP,__T(__EE9855549.Exp33_)),UID},UID,MERGE)),__ST503800_Layout);
  SHARED __ST505652_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Business_Not_On_File_ := FALSE;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.nkdate Most_Recent_N_A_I_C_S_Date_;
    KEL.typ.nkdate Most_Recent_S_I_C_Date_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.int C_O_U_N_T___Exp1_ := 0;
    KEL.typ.int C_O_U_N_T___Account_ := 0;
    KEL.typ.int S_U_M___Current_Credit_Limit_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__1_ := 0;
    KEL.typ.int C_O_U_N_T___Account__1_ := 0;
    KEL.typ.int S_U_M___Current_Credit_Limit__1_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__2_ := 0;
    KEL.typ.int C_O_U_N_T___Account__2_ := 0;
    KEL.typ.int S_U_M___Current_Credit_Limit__2_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__3_ := 0;
    KEL.typ.int C_O_U_N_T___Account__3_ := 0;
    KEL.typ.int S_U_M___Current_Credit_Limit__3_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__4_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__5_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__6_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__7_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__8_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__9_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__10_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__11_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__12_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__13_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__14_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__15_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__16_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__17_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__18_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__19_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__20_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__21_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__22_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__23_ := 0;
    KEL.typ.int C_O_U_N_T___Exp1__24_ := 0;
    KEL.typ.ntyp(E_Business().Typ) U_I_D__1_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC9856124(B_Business_4(__in,__cfg).__ST245910_Layout __EE9851776, __ST503800_Layout __EE9856118) := __EEQP(__EE9851776.UID,__EE9856118.UID);
  __ST505652_Layout __JT9856124(B_Business_4(__in,__cfg).__ST245910_Layout __l, __ST503800_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE9856170 := JOIN(__EE9851776,__EE9856118,__JC9856124(LEFT,RIGHT),__JT9856124(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST242370_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Business_Not_On_File_ := FALSE;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.nkdate Most_Recent_N_A_I_C_S_Date_;
    KEL.typ.nkdate Most_Recent_S_I_C_Date_;
    KEL.typ.int Sbfecurrentlimitcard_ := 0;
    KEL.typ.int Sbfecurrentlimitline_ := 0;
    KEL.typ.int Sbfecurrentlimitoline_ := 0;
    KEL.typ.int Sbfecurrentlimitrevolving_ := 0;
    KEL.typ.int Sbfeopencardcount03m_ := 0;
    KEL.typ.int Sbfeopencardcount06m_ := 0;
    KEL.typ.int Sbfeopencardcount12m_ := 0;
    KEL.typ.int Sbfeopencardcount24m_ := 0;
    KEL.typ.int Sbfeopencardcount36m_ := 0;
    KEL.typ.int Sbfeopencardcount60m_ := 0;
    KEL.typ.int Sbfeopencardcount84m_ := 0;
    KEL.typ.int Sbfeopenlinecount03m_ := 0;
    KEL.typ.int Sbfeopenlinecount06m_ := 0;
    KEL.typ.int Sbfeopenlinecount12m_ := 0;
    KEL.typ.int Sbfeopenlinecount24m_ := 0;
    KEL.typ.int Sbfeopenlinecount36m_ := 0;
    KEL.typ.int Sbfeopenlinecount60m_ := 0;
    KEL.typ.int Sbfeopenlinecount84m_ := 0;
    KEL.typ.int Sbfeopenoelinecount03m_ := 0;
    KEL.typ.int Sbfeopenoelinecount06m_ := 0;
    KEL.typ.int Sbfeopenoelinecount12m_ := 0;
    KEL.typ.int Sbfeopenoelinecount24m_ := 0;
    KEL.typ.int Sbfeopenoelinecount36m_ := 0;
    KEL.typ.int Sbfeopenoelinecount60m_ := 0;
    KEL.typ.int Sbfeopenoelinecount84m_ := 0;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST242370_Layout __ND9856175__Project(__ST505652_Layout __PP9856171) := TRANSFORM
    __CC326 := -99;
    __CC329 := -98;
    __CC332 := -97;
    SELF.Sbfecurrentlimitcard_ := MAP(__PP9856171.Business_Not_On_File_=>__CC326, NOT (__PP9856171.C_O_U_N_T___Exp1_ <> 0)=>__CC329, NOT (__PP9856171.C_O_U_N_T___Account_ <> 0)=>__CC332,__PP9856171.S_U_M___Current_Credit_Limit_);
    SELF.Sbfecurrentlimitline_ := MAP(__PP9856171.Business_Not_On_File_=>__CC326, NOT (__PP9856171.C_O_U_N_T___Exp1__1_ <> 0)=>__CC329, NOT (__PP9856171.C_O_U_N_T___Account__1_ <> 0)=>__CC332,__PP9856171.S_U_M___Current_Credit_Limit__1_);
    SELF.Sbfecurrentlimitoline_ := MAP(__PP9856171.Business_Not_On_File_=>__CC326, NOT (__PP9856171.C_O_U_N_T___Exp1__2_ <> 0)=>__CC329, NOT (__PP9856171.C_O_U_N_T___Account__2_ <> 0)=>__CC332,__PP9856171.S_U_M___Current_Credit_Limit__2_);
    SELF.Sbfecurrentlimitrevolving_ := MAP(__PP9856171.Business_Not_On_File_=>__CC326, NOT (__PP9856171.C_O_U_N_T___Exp1__3_ <> 0)=>__CC329, NOT (__PP9856171.C_O_U_N_T___Account__3_ <> 0)=>__CC332,__PP9856171.S_U_M___Current_Credit_Limit__3_);
    SELF.Sbfeopencardcount03m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__4_);
    SELF.Sbfeopencardcount06m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__5_);
    SELF.Sbfeopencardcount12m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__6_);
    SELF.Sbfeopencardcount24m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__7_);
    SELF.Sbfeopencardcount36m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__8_);
    SELF.Sbfeopencardcount60m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__9_);
    SELF.Sbfeopencardcount84m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__10_);
    SELF.Sbfeopenlinecount03m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__11_);
    SELF.Sbfeopenlinecount06m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__12_);
    SELF.Sbfeopenlinecount12m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__13_);
    SELF.Sbfeopenlinecount24m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__14_);
    SELF.Sbfeopenlinecount36m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__15_);
    SELF.Sbfeopenlinecount60m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__16_);
    SELF.Sbfeopenlinecount84m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__17_);
    SELF.Sbfeopenoelinecount03m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__18_);
    SELF.Sbfeopenoelinecount06m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__19_);
    SELF.Sbfeopenoelinecount12m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__20_);
    SELF.Sbfeopenoelinecount24m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__21_);
    SELF.Sbfeopenoelinecount36m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__22_);
    SELF.Sbfeopenoelinecount60m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__23_);
    SELF.Sbfeopenoelinecount84m_ := IF(__PP9856171.Business_Not_On_File_,__CC326,__PP9856171.C_O_U_N_T___Exp1__24_);
    SELF := __PP9856171;
  END;
  EXPORT __ENH_Business_3 := PROJECT(__EE9856170,__ND9856175__Project(LEFT));
END;
