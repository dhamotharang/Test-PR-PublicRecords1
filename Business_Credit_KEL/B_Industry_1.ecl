﻿//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Business_2,B_Industry_2,B_Industry_3,CFG_graph,E_Business,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Industry_1(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_2(__in,__cfg).__ENH_Business_2) __ENH_Business_2 := B_Business_2(__in,__cfg).__ENH_Business_2;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_2(__in,__cfg).__ENH_Industry_2) __ENH_Industry_2 := B_Industry_2(__in,__cfg).__ENH_Industry_2;
  SHARED __EE10475769 := __ENH_Industry_2;
  SHARED __EE10475772 := __ENH_Business_2;
  SHARED __EE2609587 := __E_Business_Industry;
  SHARED __EE10477458 := __EE2609587(__NN(__EE2609587._industry_) AND __NN(__EE2609587._bus_));
  SHARED __ST2611077_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Business_Not_On_File_ := FALSE;
    KEL.typ.bool Cannot_Calculate_Utilization_Card_ := FALSE;
    KEL.typ.bool Cannot_Calculate_Utilization_Line_ := FALSE;
    KEL.typ.bool Cannot_Calculate_Utilization_O_Line_ := FALSE;
    KEL.typ.bool Cannot_Calculate_Utilization_Revolving_ := FALSE;
    KEL.typ.nkdate Chargeoff_Date_Last_Seen_;
    KEL.typ.nkdate D_P_D_Date_Last_Seen_;
    KEL.typ.nkdate Date_Closed_Most_Recent_All_;
    KEL.typ.nkdate Date_Closed_Most_Recent_Card_;
    KEL.typ.nkdate Date_Closed_Most_Recent_Lease_;
    KEL.typ.nkdate Date_Closed_Most_Recent_Letter_;
    KEL.typ.nkdate Date_Closed_Most_Recent_Line_;
    KEL.typ.nkdate Date_Closed_Most_Recent_Loan_;
    KEL.typ.nkdate Date_Closed_Most_Recent_O_Line_;
    KEL.typ.nkdate Date_Closed_Most_Recent_Other_;
    KEL.typ.nkdate Date_Open_First_Seen_All_;
    KEL.typ.nkdate Date_Open_First_Seen_Card_;
    KEL.typ.nkdate Date_Open_First_Seen_Lease_;
    KEL.typ.nkdate Date_Open_First_Seen_Letter_;
    KEL.typ.nkdate Date_Open_First_Seen_Line_;
    KEL.typ.nkdate Date_Open_First_Seen_Loan_;
    KEL.typ.nkdate Date_Open_First_Seen_O_Line_;
    KEL.typ.nkdate Date_Open_First_Seen_Other_;
    KEL.typ.nkdate Date_Open_Most_Recent_All_;
    KEL.typ.nkdate Date_Open_Most_Recent_Card_;
    KEL.typ.nkdate Date_Open_Most_Recent_Lease_;
    KEL.typ.nkdate Date_Open_Most_Recent_Letter_;
    KEL.typ.nkdate Date_Open_Most_Recent_Line_;
    KEL.typ.nkdate Date_Open_Most_Recent_Loan_;
    KEL.typ.nkdate Date_Open_Most_Recent_O_Line_;
    KEL.typ.nkdate Date_Open_Most_Recent_Other_;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.nkdate Most_Recent_N_A_I_C_S_Date_;
    KEL.typ.nkdate Most_Recent_S_I_C_Date_;
    KEL.typ.nkdate Most_Recently_Opened_N_A_I_C_S_;
    KEL.typ.nkdate Most_Recently_Opened_S_I_C_;
    KEL.typ.int Remaining_Balance_Card_ := 0;
    KEL.typ.int Remaining_Balance_Line_ := 0;
    KEL.typ.int Remaining_Balance_O_Line_ := 0;
    KEL.typ.int Remaining_Balance_Revolving_ := 0;
    KEL.typ.int Sbfecardcount_ := 0;
    KEL.typ.int Sbfechargeoffcount_ := 0;
    KEL.typ.int Sbfecurrentlimitcard_ := 0;
    KEL.typ.int Sbfecurrentlimitline_ := 0;
    KEL.typ.int Sbfecurrentlimitoline_ := 0;
    KEL.typ.int Sbfecurrentlimitrevolving_ := 0;
    KEL.typ.int Sbfeleasecount_ := 0;
    KEL.typ.int Sbfelettercount_ := 0;
    KEL.typ.int Sbfelimitcardamt03m_ := 0;
    KEL.typ.int Sbfelimitcardamt06m_ := 0;
    KEL.typ.int Sbfelimitcardamt12m_ := 0;
    KEL.typ.int Sbfelimitcardamt24m_ := 0;
    KEL.typ.int Sbfelimitcardamt36m_ := 0;
    KEL.typ.int Sbfelimitcardamt60m_ := 0;
    KEL.typ.int Sbfelimitcardamt84m_ := 0;
    KEL.typ.int Sbfelimitlineamt03m_ := 0;
    KEL.typ.int Sbfelimitlineamt06m_ := 0;
    KEL.typ.int Sbfelimitlineamt12m_ := 0;
    KEL.typ.int Sbfelimitlineamt24m_ := 0;
    KEL.typ.int Sbfelimitlineamt36m_ := 0;
    KEL.typ.int Sbfelimitlineamt60m_ := 0;
    KEL.typ.int Sbfelimitlineamt84m_ := 0;
    KEL.typ.int Sbfelimitoelineamt03m_ := 0;
    KEL.typ.int Sbfelimitoelineamt06m_ := 0;
    KEL.typ.int Sbfelimitoelineamt12m_ := 0;
    KEL.typ.int Sbfelimitoelineamt24m_ := 0;
    KEL.typ.int Sbfelimitoelineamt36m_ := 0;
    KEL.typ.int Sbfelimitoelineamt60m_ := 0;
    KEL.typ.int Sbfelimitoelineamt84m_ := 0;
    KEL.typ.int Sbfelimitrevamt03m_ := 0;
    KEL.typ.int Sbfelimitrevamt06m_ := 0;
    KEL.typ.int Sbfelimitrevamt12m_ := 0;
    KEL.typ.int Sbfelimitrevamt24m_ := 0;
    KEL.typ.int Sbfelimitrevamt36m_ := 0;
    KEL.typ.int Sbfelimitrevamt60m_ := 0;
    KEL.typ.int Sbfelimitrevamt84m_ := 0;
    KEL.typ.int Sbfelinecount_ := 0;
    KEL.typ.int Sbfeloancount_ := 0;
    KEL.typ.int Sbfeolinecount_ := 0;
    KEL.typ.int Sbfeopenallcount_ := 0;
    KEL.typ.int Sbfeopencardcount_ := 0;
    KEL.typ.int Sbfeopencardcount03m_ := 0;
    KEL.typ.int Sbfeopencardcount06m_ := 0;
    KEL.typ.int Sbfeopencardcount12m_ := 0;
    KEL.typ.int Sbfeopencardcount24m_ := 0;
    KEL.typ.int Sbfeopencardcount36m_ := 0;
    KEL.typ.int Sbfeopencardcount60m_ := 0;
    KEL.typ.int Sbfeopencardcount84m_ := 0;
    KEL.typ.int Sbfeopencounthist03m_ := 0;
    KEL.typ.int Sbfeopencounthist06m_ := 0;
    KEL.typ.int Sbfeopencounthist12m_ := 0;
    KEL.typ.int Sbfeopencounthist24m_ := 0;
    KEL.typ.int Sbfeopencounthist36m_ := 0;
    KEL.typ.int Sbfeopencounthist60m_ := 0;
    KEL.typ.int Sbfeopencounthist84m_ := 0;
    KEL.typ.int Sbfeopenleasecount_ := 0;
    KEL.typ.int Sbfeopenlettercount_ := 0;
    KEL.typ.int Sbfeopenlinecount_ := 0;
    KEL.typ.int Sbfeopenlinecount03m_ := 0;
    KEL.typ.int Sbfeopenlinecount06m_ := 0;
    KEL.typ.int Sbfeopenlinecount12m_ := 0;
    KEL.typ.int Sbfeopenlinecount24m_ := 0;
    KEL.typ.int Sbfeopenlinecount36m_ := 0;
    KEL.typ.int Sbfeopenlinecount60m_ := 0;
    KEL.typ.int Sbfeopenlinecount84m_ := 0;
    KEL.typ.int Sbfeopenloancount_ := 0;
    KEL.typ.int Sbfeopenoelinecount03m_ := 0;
    KEL.typ.int Sbfeopenoelinecount06m_ := 0;
    KEL.typ.int Sbfeopenoelinecount12m_ := 0;
    KEL.typ.int Sbfeopenoelinecount24m_ := 0;
    KEL.typ.int Sbfeopenoelinecount36m_ := 0;
    KEL.typ.int Sbfeopenoelinecount60m_ := 0;
    KEL.typ.int Sbfeopenoelinecount84m_ := 0;
    KEL.typ.int Sbfeopenolinecount_ := 0;
    KEL.typ.int Sbfeopenothercount_ := 0;
    KEL.typ.int Sbfeothercount_ := 0;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC10477476(B_Business_2(__in,__cfg).__ST238273_Layout __EE10475772, E_Business_Industry(__in,__cfg).Layout __EE10477458) := __EEQP(__EE10477458._bus_,__EE10475772.UID);
  __ST2611077_Layout __JT10477476(B_Business_2(__in,__cfg).__ST238273_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE10477477 := JOIN(__EE10477458,__EE10475772,__JC10477476(RIGHT,LEFT),__JT10477476(RIGHT,LEFT),INNER,HASH);
  SHARED __ST2610345_Layout := RECORD
    KEL.typ.ntyp(E_Industry().Typ) UID;
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.bool Business_Not_On_File_ := FALSE;
    KEL.typ.bool Cannot_Calculate_Utilization_Card_ := FALSE;
    KEL.typ.bool Cannot_Calculate_Utilization_Line_ := FALSE;
    KEL.typ.bool Cannot_Calculate_Utilization_O_Line_ := FALSE;
    KEL.typ.bool Cannot_Calculate_Utilization_Revolving_ := FALSE;
    KEL.typ.nkdate Chargeoff_Date_Last_Seen_;
    KEL.typ.nkdate D_P_D_Date_Last_Seen_;
    KEL.typ.nkdate Date_Closed_Most_Recent_All_;
    KEL.typ.nkdate Date_Closed_Most_Recent_Card_;
    KEL.typ.nkdate Date_Closed_Most_Recent_Lease_;
    KEL.typ.nkdate Date_Closed_Most_Recent_Letter_;
    KEL.typ.nkdate Date_Closed_Most_Recent_Line_;
    KEL.typ.nkdate Date_Closed_Most_Recent_Loan_;
    KEL.typ.nkdate Date_Closed_Most_Recent_O_Line_;
    KEL.typ.nkdate Date_Closed_Most_Recent_Other_;
    KEL.typ.nkdate Date_Open_First_Seen_All_;
    KEL.typ.nkdate Date_Open_First_Seen_Card_;
    KEL.typ.nkdate Date_Open_First_Seen_Lease_;
    KEL.typ.nkdate Date_Open_First_Seen_Letter_;
    KEL.typ.nkdate Date_Open_First_Seen_Line_;
    KEL.typ.nkdate Date_Open_First_Seen_Loan_;
    KEL.typ.nkdate Date_Open_First_Seen_O_Line_;
    KEL.typ.nkdate Date_Open_First_Seen_Other_;
    KEL.typ.nkdate Date_Open_Most_Recent_All_;
    KEL.typ.nkdate Date_Open_Most_Recent_Card_;
    KEL.typ.nkdate Date_Open_Most_Recent_Lease_;
    KEL.typ.nkdate Date_Open_Most_Recent_Letter_;
    KEL.typ.nkdate Date_Open_Most_Recent_Line_;
    KEL.typ.nkdate Date_Open_Most_Recent_Loan_;
    KEL.typ.nkdate Date_Open_Most_Recent_O_Line_;
    KEL.typ.nkdate Date_Open_Most_Recent_Other_;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.nkdate Most_Recent_N_A_I_C_S_Date_;
    KEL.typ.nkdate Most_Recent_S_I_C_Date_;
    KEL.typ.nkdate Most_Recently_Opened_N_A_I_C_S_;
    KEL.typ.nkdate Most_Recently_Opened_S_I_C_;
    KEL.typ.int Remaining_Balance_Card_ := 0;
    KEL.typ.int Remaining_Balance_Line_ := 0;
    KEL.typ.int Remaining_Balance_O_Line_ := 0;
    KEL.typ.int Remaining_Balance_Revolving_ := 0;
    KEL.typ.int Sbfecardcount_ := 0;
    KEL.typ.int Sbfechargeoffcount_ := 0;
    KEL.typ.int Sbfecurrentlimitcard_ := 0;
    KEL.typ.int Sbfecurrentlimitline_ := 0;
    KEL.typ.int Sbfecurrentlimitoline_ := 0;
    KEL.typ.int Sbfecurrentlimitrevolving_ := 0;
    KEL.typ.int Sbfeleasecount_ := 0;
    KEL.typ.int Sbfelettercount_ := 0;
    KEL.typ.int Sbfelimitcardamt03m_ := 0;
    KEL.typ.int Sbfelimitcardamt06m_ := 0;
    KEL.typ.int Sbfelimitcardamt12m_ := 0;
    KEL.typ.int Sbfelimitcardamt24m_ := 0;
    KEL.typ.int Sbfelimitcardamt36m_ := 0;
    KEL.typ.int Sbfelimitcardamt60m_ := 0;
    KEL.typ.int Sbfelimitcardamt84m_ := 0;
    KEL.typ.int Sbfelimitlineamt03m_ := 0;
    KEL.typ.int Sbfelimitlineamt06m_ := 0;
    KEL.typ.int Sbfelimitlineamt12m_ := 0;
    KEL.typ.int Sbfelimitlineamt24m_ := 0;
    KEL.typ.int Sbfelimitlineamt36m_ := 0;
    KEL.typ.int Sbfelimitlineamt60m_ := 0;
    KEL.typ.int Sbfelimitlineamt84m_ := 0;
    KEL.typ.int Sbfelimitoelineamt03m_ := 0;
    KEL.typ.int Sbfelimitoelineamt06m_ := 0;
    KEL.typ.int Sbfelimitoelineamt12m_ := 0;
    KEL.typ.int Sbfelimitoelineamt24m_ := 0;
    KEL.typ.int Sbfelimitoelineamt36m_ := 0;
    KEL.typ.int Sbfelimitoelineamt60m_ := 0;
    KEL.typ.int Sbfelimitoelineamt84m_ := 0;
    KEL.typ.int Sbfelimitrevamt03m_ := 0;
    KEL.typ.int Sbfelimitrevamt06m_ := 0;
    KEL.typ.int Sbfelimitrevamt12m_ := 0;
    KEL.typ.int Sbfelimitrevamt24m_ := 0;
    KEL.typ.int Sbfelimitrevamt36m_ := 0;
    KEL.typ.int Sbfelimitrevamt60m_ := 0;
    KEL.typ.int Sbfelimitrevamt84m_ := 0;
    KEL.typ.int Sbfelinecount_ := 0;
    KEL.typ.int Sbfeloancount_ := 0;
    KEL.typ.int Sbfeolinecount_ := 0;
    KEL.typ.int Sbfeopenallcount_ := 0;
    KEL.typ.int Sbfeopencardcount_ := 0;
    KEL.typ.int Sbfeopencardcount03m_ := 0;
    KEL.typ.int Sbfeopencardcount06m_ := 0;
    KEL.typ.int Sbfeopencardcount12m_ := 0;
    KEL.typ.int Sbfeopencardcount24m_ := 0;
    KEL.typ.int Sbfeopencardcount36m_ := 0;
    KEL.typ.int Sbfeopencardcount60m_ := 0;
    KEL.typ.int Sbfeopencardcount84m_ := 0;
    KEL.typ.int Sbfeopencounthist03m_ := 0;
    KEL.typ.int Sbfeopencounthist06m_ := 0;
    KEL.typ.int Sbfeopencounthist12m_ := 0;
    KEL.typ.int Sbfeopencounthist24m_ := 0;
    KEL.typ.int Sbfeopencounthist36m_ := 0;
    KEL.typ.int Sbfeopencounthist60m_ := 0;
    KEL.typ.int Sbfeopencounthist84m_ := 0;
    KEL.typ.int Sbfeopenleasecount_ := 0;
    KEL.typ.int Sbfeopenlettercount_ := 0;
    KEL.typ.int Sbfeopenlinecount_ := 0;
    KEL.typ.int Sbfeopenlinecount03m_ := 0;
    KEL.typ.int Sbfeopenlinecount06m_ := 0;
    KEL.typ.int Sbfeopenlinecount12m_ := 0;
    KEL.typ.int Sbfeopenlinecount24m_ := 0;
    KEL.typ.int Sbfeopenlinecount36m_ := 0;
    KEL.typ.int Sbfeopenlinecount60m_ := 0;
    KEL.typ.int Sbfeopenlinecount84m_ := 0;
    KEL.typ.int Sbfeopenloancount_ := 0;
    KEL.typ.int Sbfeopenoelinecount03m_ := 0;
    KEL.typ.int Sbfeopenoelinecount06m_ := 0;
    KEL.typ.int Sbfeopenoelinecount12m_ := 0;
    KEL.typ.int Sbfeopenoelinecount24m_ := 0;
    KEL.typ.int Sbfeopenoelinecount36m_ := 0;
    KEL.typ.int Sbfeopenoelinecount60m_ := 0;
    KEL.typ.int Sbfeopenoelinecount84m_ := 0;
    KEL.typ.int Sbfeopenolinecount_ := 0;
    KEL.typ.int Sbfeopenothercount_ := 0;
    KEL.typ.int Sbfeothercount_ := 0;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
  END;
  SHARED __ST2610345_Layout __ND10477605__Project(__ST2611077_Layout __PP10477478) := TRANSFORM
    SELF.UID := __PP10477478._industry_;
    SELF.U_I_D__1_ := __PP10477478.UID;
    SELF := __PP10477478;
  END;
  SHARED __EE10478098 := PROJECT(__EE10477477,__ND10477605__Project(LEFT));
  SHARED __ST2610609_Layout := RECORD
    KEL.typ.ntyp(E_Industry().Typ) UID;
    KEL.typ.nkdate Most_Recently_Opened_N_A_I_C_S_;
    KEL.typ.nkdate Most_Recently_Opened_S_I_C_;
  END;
  SHARED __EE10478116 := PROJECT(__EE10478098,__ST2610609_Layout);
  SHARED __ST2610629_Layout := RECORD
    KEL.typ.nkdate M_A_X___Most_Recently_Opened_N_A_I_C_S_;
    KEL.typ.nkdate M_A_X___Most_Recently_Opened_S_I_C_;
    KEL.typ.ntyp(E_Industry().Typ) UID;
  END;
  SHARED __EE10478137 := PROJECT(__CLEANANDDO(__EE10478116,TABLE(__EE10478116,{KEL.Aggregates.MaxNG(__EE10478116.Most_Recently_Opened_N_A_I_C_S_) M_A_X___Most_Recently_Opened_N_A_I_C_S_,KEL.Aggregates.MaxNG(__EE10478116.Most_Recently_Opened_S_I_C_) M_A_X___Most_Recently_Opened_S_I_C_,UID},UID,MERGE)),__ST2610629_Layout);
  SHARED __ST2611835_Layout := RECORD
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
    KEL.typ.nkdate M_A_X___Most_Recently_Opened_N_A_I_C_S_;
    KEL.typ.nkdate M_A_X___Most_Recently_Opened_S_I_C_;
    KEL.typ.ntyp(E_Industry().Typ) U_I_D__1_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC10478143(B_Industry_3(__in,__cfg).__ST242949_Layout __EE10475769, __ST2610629_Layout __EE10478137) := __EEQP(__EE10475769.UID,__EE10478137.UID);
  __ST2611835_Layout __JT10478143(B_Industry_3(__in,__cfg).__ST242949_Layout __l, __ST2610629_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE10478144 := JOIN(__EE10475769,__EE10478137,__JC10478143(LEFT,RIGHT),__JT10478143(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST232502_Layout := RECORD
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
    KEL.typ.nbool Is_Most_Recently_Opened_N_A_I_C_S_;
    KEL.typ.nbool Is_Most_Recently_Opened_S_I_C_;
    KEL.typ.nbool Is_N_A_I_C_S_Code_;
    KEL.typ.nbool Is_Primary_;
    KEL.typ.nbool Is_S_I_C_Code_;
    KEL.typ.nbool Is_Valid_Code_;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST232502_Layout __ND10478178__Project(__ST2611835_Layout __PP10478145) := TRANSFORM
    SELF.Is_Most_Recently_Opened_N_A_I_C_S_ := __AND(__PP10478145.Is_Most_Recent_N_A_I_C_S_,__OP2(__PP10478145.Date_Account_Opened_,=,__PP10478145.M_A_X___Most_Recently_Opened_N_A_I_C_S_));
    SELF.Is_Most_Recently_Opened_S_I_C_ := __AND(__PP10478145.Is_Most_Recent_S_I_C_,__OP2(__PP10478145.Date_Account_Opened_,=,__PP10478145.M_A_X___Most_Recently_Opened_S_I_C_));
    SELF := __PP10478145;
  END;
  EXPORT __ENH_Industry_1 := PROJECT(__EE10478144,__ND10478178__Project(LEFT));
END;
