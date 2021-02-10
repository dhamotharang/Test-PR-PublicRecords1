//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Business_5,B_Business_6,B_Industry_5,CFG_graph,E_Account,E_Business,E_Business_Account,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Business_4(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_5(__in,__cfg).__ENH_Business_5) __ENH_Business_5 := B_Business_5(__in,__cfg).__ENH_Business_5;
  SHARED VIRTUAL TYPEOF(E_Business_Account(__in,__cfg).__Result) __E_Business_Account := E_Business_Account(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_5(__in,__cfg).__ENH_Industry_5) __ENH_Industry_5 := B_Industry_5(__in,__cfg).__ENH_Industry_5;
  SHARED __EE10010480 := __ENH_Business_5;
  SHARED __EE10010483 := __ENH_Industry_5;
  SHARED __EE411309 := __E_Business_Industry;
  SHARED __EE10011036 := __EE411309(__NN(__EE411309._bus_) AND __NN(__EE411309._industry_));
  SHARED __ST411998_Layout := RECORD
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
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC10011054(B_Industry_5(__in,__cfg).__ST249383_Layout __EE10010483, E_Business_Industry(__in,__cfg).Layout __EE10011036) := __EEQP(__EE10011036._industry_,__EE10010483.UID);
  __ST411998_Layout __JT10011054(B_Industry_5(__in,__cfg).__ST249383_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE10011055 := JOIN(__EE10011036,__EE10010483,__JC10011054(RIGHT,LEFT),__JT10011054(RIGHT,LEFT),INNER,HASH);
  SHARED __ST411679_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.nuid U_I_D__1_;
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
  END;
  SHARED __ST411679_Layout __ND10011083__Project(__ST411998_Layout __PP10011056) := TRANSFORM
    SELF.UID := __PP10011056._bus_;
    SELF.U_I_D__1_ := __PP10011056.UID;
    SELF := __PP10011056;
  END;
  SHARED __EE10011176 := PROJECT(__EE10011055,__ND10011083__Project(LEFT));
  SHARED __ST411745_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nkdate Exp1_;
    KEL.typ.nkdate Exp2_;
  END;
  SHARED __ST411745_Layout __ND10011181__Project(__ST411679_Layout __PP10011177) := TRANSFORM
    SELF.Exp1_ := IF(__T(__PP10011177.Is_Highest_Frequency_N_A_I_C_S_),__ECAST(KEL.typ.nkdate,__PP10011177._dt__last__seen_),__ECAST(KEL.typ.nkdate,__N(KEL.typ.kdate)));
    SELF.Exp2_ := IF(__T(__PP10011177.Is_Highest_Frequency_S_I_C_),__ECAST(KEL.typ.nkdate,__PP10011177._dt__last__seen_),__ECAST(KEL.typ.nkdate,__N(KEL.typ.kdate)));
    SELF := __PP10011177;
  END;
  SHARED __EE10011200 := PROJECT(__EE10011176,__ND10011181__Project(LEFT));
  SHARED __ST411765_Layout := RECORD
    KEL.typ.nkdate M_A_X__dt__last__seen_;
    KEL.typ.nkdate M_A_X__dt__last__seen__1_;
    KEL.typ.ntyp(E_Business().Typ) UID;
  END;
  SHARED __EE10011221 := PROJECT(__CLEANANDDO(__EE10011200,TABLE(__EE10011200,{KEL.Aggregates.MaxNG(__EE10011200.Exp1_) M_A_X__dt__last__seen_,KEL.Aggregates.MaxNG(__EE10011200.Exp2_) M_A_X__dt__last__seen__1_,UID},UID,MERGE)),__ST411765_Layout);
  SHARED __ST412156_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.nkdate M_A_X__dt__last__seen_;
    KEL.typ.nkdate M_A_X__dt__last__seen__1_;
    KEL.typ.ntyp(E_Business().Typ) U_I_D__1_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC10011227(B_Business_6(__in,__cfg).__ST251000_Layout __EE10010480, __ST411765_Layout __EE10011221) := __EEQP(__EE10010480.UID,__EE10011221.UID);
  __ST412156_Layout __JT10011227(B_Business_6(__in,__cfg).__ST251000_Layout __l, __ST411765_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE10011228 := JOIN(__EE10010480,__EE10011221,__JC10011227(LEFT,RIGHT),__JT10011227(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST412228_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.nkdate M_A_X__dt__last__seen_;
    KEL.typ.nkdate M_A_X__dt__last__seen__1_;
    KEL.typ.ntyp(E_Business().Typ) U_I_D__1_;
    KEL.typ.bool Business_Account_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE410481 := __E_Business_Account;
  SHARED __EE10011257 := __EE410481(__NN(__EE410481._acc_) AND __NN(__EE410481._bus_));
  __JC10011277(__ST412156_Layout __EE10011228, E_Business_Account(__in,__cfg).Layout __EE10011257) := __EEQP(__EE10011228.UID,__EE10011257._bus_);
  __JF10011277(E_Business_Account(__in,__cfg).Layout __EE10011257) := __NN(__EE10011257._bus_);
  SHARED __EE10011278 := JOIN(__EE10011228,__EE10011257,__JC10011277(LEFT,RIGHT),TRANSFORM(__ST412228_Layout,SELF:=LEFT,SELF.Business_Account_:=__JF10011277(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST246291_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Business_Not_On_File_ := FALSE;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.nkdate Most_Recent_N_A_I_C_S_Date_;
    KEL.typ.nkdate Most_Recent_S_I_C_Date_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST246291_Layout __ND10011293__Project(__ST412228_Layout __PP10011279) := TRANSFORM
    SELF.Business_Not_On_File_ := NOT (__PP10011279.Business_Account_);
    SELF.Most_Recent_N_A_I_C_S_Date_ := __PP10011279.M_A_X__dt__last__seen_;
    SELF.Most_Recent_S_I_C_Date_ := __PP10011279.M_A_X__dt__last__seen__1_;
    SELF := __PP10011279;
  END;
  EXPORT __ENH_Business_4 := PROJECT(__EE10011278,__ND10011293__Project(LEFT));
END;
