//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Business_5,B_Business_6,B_Industry_5,CFG_graph,E_Account,E_Business,E_Business_Account,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Business_4(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_5(__in,__cfg).__ENH_Business_5) __ENH_Business_5 := B_Business_5(__in,__cfg).__ENH_Business_5;
  SHARED VIRTUAL TYPEOF(E_Business_Account(__in,__cfg).__Result) __E_Business_Account := E_Business_Account(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_5(__in,__cfg).__ENH_Industry_5) __ENH_Industry_5 := B_Industry_5(__in,__cfg).__ENH_Industry_5;
  SHARED __EE9837885 := __ENH_Business_5;
  SHARED __EE9837888 := __ENH_Industry_5;
  SHARED __EE401800 := __E_Business_Industry;
  SHARED __EE9838441 := __EE401800(__NN(__EE401800._bus_) AND __NN(__EE401800._industry_));
  SHARED __ST402489_Layout := RECORD
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
  __JC9838459(B_Industry_5(__in,__cfg).__ST248927_Layout __EE9837888, E_Business_Industry(__in,__cfg).Layout __EE9838441) := __EEQP(__EE9838441._industry_,__EE9837888.UID);
  __ST402489_Layout __JT9838459(B_Industry_5(__in,__cfg).__ST248927_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE9838460 := JOIN(__EE9838441,__EE9837888,__JC9838459(RIGHT,LEFT),__JT9838459(RIGHT,LEFT),INNER,HASH);
  SHARED __ST402170_Layout := RECORD
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
  SHARED __ST402170_Layout __ND9838488__Project(__ST402489_Layout __PP9838461) := TRANSFORM
    SELF.UID := __PP9838461._bus_;
    SELF.U_I_D__1_ := __PP9838461.UID;
    SELF := __PP9838461;
  END;
  SHARED __EE9838581 := PROJECT(__EE9838460,__ND9838488__Project(LEFT));
  SHARED __ST402236_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nkdate Exp1_;
    KEL.typ.nkdate Exp2_;
  END;
  SHARED __ST402236_Layout __ND9838586__Project(__ST402170_Layout __PP9838582) := TRANSFORM
    SELF.Exp1_ := IF(__T(__PP9838582.Is_Highest_Frequency_N_A_I_C_S_),__ECAST(KEL.typ.nkdate,__PP9838582._dt__last__seen_),__ECAST(KEL.typ.nkdate,__N(KEL.typ.kdate)));
    SELF.Exp2_ := IF(__T(__PP9838582.Is_Highest_Frequency_S_I_C_),__ECAST(KEL.typ.nkdate,__PP9838582._dt__last__seen_),__ECAST(KEL.typ.nkdate,__N(KEL.typ.kdate)));
    SELF := __PP9838582;
  END;
  SHARED __EE9838605 := PROJECT(__EE9838581,__ND9838586__Project(LEFT));
  SHARED __ST402256_Layout := RECORD
    KEL.typ.nkdate M_A_X__dt__last__seen_;
    KEL.typ.nkdate M_A_X__dt__last__seen__1_;
    KEL.typ.ntyp(E_Business().Typ) UID;
  END;
  SHARED __EE9838626 := PROJECT(__CLEANANDDO(__EE9838605,TABLE(__EE9838605,{KEL.Aggregates.MaxNG(__EE9838605.Exp1_) M_A_X__dt__last__seen_,KEL.Aggregates.MaxNG(__EE9838605.Exp2_) M_A_X__dt__last__seen__1_,UID},UID,MERGE)),__ST402256_Layout);
  SHARED __ST402647_Layout := RECORD
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
  __JC9838632(B_Business_6(__in,__cfg).__ST250472_Layout __EE9837885, __ST402256_Layout __EE9838626) := __EEQP(__EE9837885.UID,__EE9838626.UID);
  __ST402647_Layout __JT9838632(B_Business_6(__in,__cfg).__ST250472_Layout __l, __ST402256_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE9838633 := JOIN(__EE9837885,__EE9838626,__JC9838632(LEFT,RIGHT),__JT9838632(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST402719_Layout := RECORD
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
  SHARED __EE400972 := __E_Business_Account;
  SHARED __EE9838662 := __EE400972(__NN(__EE400972._acc_) AND __NN(__EE400972._bus_));
  __JC9838682(__ST402647_Layout __EE9838633, E_Business_Account(__in,__cfg).Layout __EE9838662) := __EEQP(__EE9838633.UID,__EE9838662._bus_);
  __JF9838682(E_Business_Account(__in,__cfg).Layout __EE9838662) := __NN(__EE9838662._bus_);
  SHARED __EE9838683 := JOIN(__EE9838633,__EE9838662,__JC9838682(LEFT,RIGHT),TRANSFORM(__ST402719_Layout,SELF:=LEFT,SELF.Business_Account_:=__JF9838682(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST245910_Layout := RECORD
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
  SHARED __ST245910_Layout __ND9838698__Project(__ST402719_Layout __PP9838684) := TRANSFORM
    SELF.Business_Not_On_File_ := NOT (__PP9838684.Business_Account_);
    SELF.Most_Recent_N_A_I_C_S_Date_ := __PP9838684.M_A_X__dt__last__seen_;
    SELF.Most_Recent_S_I_C_Date_ := __PP9838684.M_A_X__dt__last__seen__1_;
    SELF := __PP9838684;
  END;
  EXPORT __ENH_Business_4 := PROJECT(__EE9838683,__ND9838698__Project(LEFT));
END;
