﻿//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Account_4,B_Business_4,B_Industry_4,B_Industry_5,CFG_graph,E_Account,E_Account_Industry,E_Business,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Industry_3(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Account_4(__in,__cfg).__ENH_Account_4) __ENH_Account_4 := B_Account_4(__in,__cfg).__ENH_Account_4;
  SHARED VIRTUAL TYPEOF(E_Account_Industry(__in,__cfg).__Result) __E_Account_Industry := E_Account_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Business_4(__in,__cfg).__ENH_Business_4) __ENH_Business_4 := B_Business_4(__in,__cfg).__ENH_Business_4;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_4(__in,__cfg).__ENH_Industry_4) __ENH_Industry_4 := B_Industry_4(__in,__cfg).__ENH_Industry_4;
  SHARED __EE9857069 := __ENH_Industry_4;
  SHARED __EE9857072 := __ENH_Business_4;
  SHARED __EE510337 := __E_Business_Industry;
  SHARED __EE9858970 := __EE510337(__NN(__EE510337._industry_) AND __NN(__EE510337._bus_));
  SHARED __ST511415_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Business_Not_On_File_ := FALSE;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.nkdate Most_Recent_N_A_I_C_S_Date_;
    KEL.typ.nkdate Most_Recent_S_I_C_Date_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC9858988(B_Business_4(__in,__cfg).__ST245910_Layout __EE9857072, E_Business_Industry(__in,__cfg).Layout __EE9858970) := __EEQP(__EE9858970._bus_,__EE9857072.UID);
  __ST511415_Layout __JT9858988(B_Business_4(__in,__cfg).__ST245910_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE9858989 := JOIN(__EE9858970,__EE9857072,__JC9858988(RIGHT,LEFT),__JT9858988(RIGHT,LEFT),INNER,HASH);
  SHARED __ST510423_Layout := RECORD
    KEL.typ.ntyp(E_Industry().Typ) UID;
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.bool Business_Not_On_File_ := FALSE;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.nkdate Most_Recent_N_A_I_C_S_Date_;
    KEL.typ.nkdate Most_Recent_S_I_C_Date_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
  END;
  SHARED __ST510423_Layout __ND9859005__Project(__ST511415_Layout __PP9858990) := TRANSFORM
    SELF.UID := __PP9858990._industry_;
    SELF.U_I_D__1_ := __PP9858990.UID;
    SELF := __PP9858990;
  END;
  SHARED __EE9859050 := PROJECT(__EE9858989,__ND9859005__Project(LEFT));
  SHARED __ST510463_Layout := RECORD
    KEL.typ.ntyp(E_Industry().Typ) UID;
    KEL.typ.nkdate Most_Recent_N_A_I_C_S_Date_;
    KEL.typ.nkdate Most_Recent_S_I_C_Date_;
  END;
  SHARED __EE9859068 := PROJECT(__EE9859050,__ST510463_Layout);
  SHARED __ST510483_Layout := RECORD
    KEL.typ.nkdate M_A_X___Most_Recent_N_A_I_C_S_Date_;
    KEL.typ.nkdate M_A_X___Most_Recent_S_I_C_Date_;
    KEL.typ.ntyp(E_Industry().Typ) UID;
  END;
  SHARED __EE9859089 := PROJECT(__CLEANANDDO(__EE9859068,TABLE(__EE9859068,{KEL.Aggregates.MaxNG(__EE9859068.Most_Recent_N_A_I_C_S_Date_) M_A_X___Most_Recent_N_A_I_C_S_Date_,KEL.Aggregates.MaxNG(__EE9859068.Most_Recent_S_I_C_Date_) M_A_X___Most_Recent_S_I_C_Date_,UID},UID,MERGE)),__ST510483_Layout);
  SHARED __ST511503_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint _record__type_;
    KEL.typ.nstr _sbfe__contributor__number_;
    KEL.typ.nunk _contract__account__number_;
    KEL.typ.nkdate _dt__first__seen_;
    KEL.typ.nkdate _dt__last__seen_;
    KEL.typ.nint _classification__code__type_;
    KEL.typ.nint _classification__code_;
    KEL.typ.nstr _primary__industry__code__indicator_;
    KEL.typ.nstr _privacy__indicator_;
    KEL.typ.int Frequency_Count_N_A_I_C_S_ := 0;
    KEL.typ.int Frequency_Count_S_I_C_ := 0;
    KEL.typ.nbool Is_Good_N_A_I_C_S_;
    KEL.typ.nbool Is_Good_S_I_C_;
    KEL.typ.nbool Is_Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nbool Is_Highest_Frequency_S_I_C_;
    KEL.typ.nbool Is_N_A_I_C_S_Code_;
    KEL.typ.nbool Is_Primary_;
    KEL.typ.nbool Is_S_I_C_Code_;
    KEL.typ.nbool Is_Valid_Code_;
    KEL.typ.nkdate M_A_X___Most_Recent_N_A_I_C_S_Date_;
    KEL.typ.nkdate M_A_X___Most_Recent_S_I_C_Date_;
    KEL.typ.ntyp(E_Industry().Typ) U_I_D__1_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC9859095(B_Industry_5(__in,__cfg).__ST248927_Layout __EE9857069, __ST510483_Layout __EE9859089) := __EEQP(__EE9857069.UID,__EE9859089.UID);
  __ST511503_Layout __JT9859095(B_Industry_5(__in,__cfg).__ST248927_Layout __l, __ST510483_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE9859096 := JOIN(__EE9857069,__EE9859089,__JC9859095(LEFT,RIGHT),__JT9859095(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __EE9857217 := __ENH_Account_4;
  SHARED __EE508752 := __E_Account_Industry;
  SHARED __EE9859140 := __EE508752(__NN(__EE508752._industry_) AND __NN(__EE508752._acc_));
  SHARED __ST510696_Layout := RECORD
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
    KEL.typ.ntyp(E_Account().Typ) _acc_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC9859158(B_Account_4(__in,__cfg).__ST245745_Layout __EE9857217, E_Account_Industry(__in,__cfg).Layout __EE9859140) := __EEQP(__EE9859140._acc_,__EE9857217.UID);
  __ST510696_Layout __JT9859158(B_Account_4(__in,__cfg).__ST245745_Layout __l, E_Account_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE9859159 := JOIN(__EE9859140,__EE9857217,__JC9859158(RIGHT,LEFT),__JT9859158(RIGHT,LEFT),INNER,HASH);
  SHARED __ST509591_Layout := RECORD
    KEL.typ.ntyp(E_Industry().Typ) UID;
    KEL.typ.ntyp(E_Account().Typ) _acc_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.nuid U_I_D__1_;
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
  END;
  SHARED __ST509591_Layout __ND9859281__Project(__ST510696_Layout __PP9859160) := TRANSFORM
    SELF.UID := __PP9859160._industry_;
    SELF.U_I_D__1_ := __PP9859160.UID;
    SELF := __PP9859160;
  END;
  SHARED __EE9859750 := PROJECT(__EE9859159,__ND9859281__Project(LEFT));
  SHARED __ST509839_Layout := RECORD
    KEL.typ.ntyp(E_Industry().Typ) UID;
    KEL.typ.nkdate Date_Account_Opened_;
  END;
  SHARED __EE9859764 := PROJECT(__EE9859750,__ST509839_Layout);
  SHARED __ST509854_Layout := RECORD
    KEL.typ.nkdate M_A_X___Date_Account_Opened_;
    KEL.typ.ntyp(E_Industry().Typ) UID;
  END;
  SHARED __EE9859780 := PROJECT(__CLEANANDDO(__EE9859764,TABLE(__EE9859764,{KEL.Aggregates.MaxNG(__EE9859764.Date_Account_Opened_) M_A_X___Date_Account_Opened_,UID},UID,MERGE)),__ST509854_Layout);
  SHARED __ST511647_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint _record__type_;
    KEL.typ.nstr _sbfe__contributor__number_;
    KEL.typ.nunk _contract__account__number_;
    KEL.typ.nkdate _dt__first__seen_;
    KEL.typ.nkdate _dt__last__seen_;
    KEL.typ.nint _classification__code__type_;
    KEL.typ.nint _classification__code_;
    KEL.typ.nstr _primary__industry__code__indicator_;
    KEL.typ.nstr _privacy__indicator_;
    KEL.typ.int Frequency_Count_N_A_I_C_S_ := 0;
    KEL.typ.int Frequency_Count_S_I_C_ := 0;
    KEL.typ.nbool Is_Good_N_A_I_C_S_;
    KEL.typ.nbool Is_Good_S_I_C_;
    KEL.typ.nbool Is_Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nbool Is_Highest_Frequency_S_I_C_;
    KEL.typ.nbool Is_N_A_I_C_S_Code_;
    KEL.typ.nbool Is_Primary_;
    KEL.typ.nbool Is_S_I_C_Code_;
    KEL.typ.nbool Is_Valid_Code_;
    KEL.typ.nkdate M_A_X___Most_Recent_N_A_I_C_S_Date_;
    KEL.typ.nkdate M_A_X___Most_Recent_S_I_C_Date_;
    KEL.typ.ntyp(E_Industry().Typ) U_I_D__1_;
    KEL.typ.nkdate M_A_X___Date_Account_Opened_;
    KEL.typ.ntyp(E_Industry().Typ) U_I_D__2_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC9859788(__ST511503_Layout __EE9859096, __ST509854_Layout __EE9859780) := __EEQP(__EE9859096.UID,__EE9859780.UID);
  __ST511647_Layout __JT9859788(__ST511503_Layout __l, __ST509854_Layout __r) := TRANSFORM
    SELF.U_I_D__2_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE9859789 := JOIN(__EE9859096,__EE9859780,__JC9859788(LEFT,RIGHT),__JT9859788(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST242629_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint _record__type_;
    KEL.typ.nstr _sbfe__contributor__number_;
    KEL.typ.nunk _contract__account__number_;
    KEL.typ.nkdate _dt__first__seen_;
    KEL.typ.nkdate _dt__last__seen_;
    KEL.typ.nint _classification__code__type_;
    KEL.typ.nint _classification__code_;
    KEL.typ.nstr _primary__industry__code__indicator_;
    KEL.typ.nstr _privacy__indicator_;
    KEL.typ.nkdate Date_Account_Opened_;
    KEL.typ.int Frequency_Count_N_A_I_C_S_ := 0;
    KEL.typ.int Frequency_Count_S_I_C_ := 0;
    KEL.typ.nbool Is_Good_N_A_I_C_S_;
    KEL.typ.nbool Is_Good_S_I_C_;
    KEL.typ.nbool Is_Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nbool Is_Highest_Frequency_S_I_C_;
    KEL.typ.nbool Is_Most_Recent_N_A_I_C_S_;
    KEL.typ.nbool Is_Most_Recent_S_I_C_;
    KEL.typ.nbool Is_N_A_I_C_S_Code_;
    KEL.typ.nbool Is_Primary_;
    KEL.typ.nbool Is_S_I_C_Code_;
    KEL.typ.nbool Is_Valid_Code_;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST242629_Layout __ND9859822__Project(__ST511647_Layout __PP9859790) := TRANSFORM
    SELF.Date_Account_Opened_ := __PP9859790.M_A_X___Date_Account_Opened_;
    SELF.Is_Most_Recent_N_A_I_C_S_ := __AND(__PP9859790.Is_Highest_Frequency_N_A_I_C_S_,__OP2(__PP9859790._dt__last__seen_,=,__PP9859790.M_A_X___Most_Recent_N_A_I_C_S_Date_));
    SELF.Is_Most_Recent_S_I_C_ := __AND(__PP9859790.Is_Highest_Frequency_S_I_C_,__OP2(__PP9859790._dt__last__seen_,=,__PP9859790.M_A_X___Most_Recent_S_I_C_Date_));
    SELF := __PP9859790;
  END;
  EXPORT __ENH_Industry_3 := PROJECT(__EE9859789,__ND9859822__Project(LEFT));
END;
