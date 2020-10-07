//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Business_5,B_Business_6,B_Industry_5,CFG_graph,E_Account,E_Business,E_Business_Account,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Business_4(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_5(__in,__cfg).__ENH_Business_5) __ENH_Business_5 := B_Business_5(__in,__cfg).__ENH_Business_5;
  SHARED VIRTUAL TYPEOF(E_Business_Account(__in,__cfg).__Result) __E_Business_Account := E_Business_Account(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_5(__in,__cfg).__ENH_Industry_5) __ENH_Industry_5 := B_Industry_5(__in,__cfg).__ENH_Industry_5;
  SHARED __EE425023 := __ENH_Business_5;
  SHARED __EE425234 := __ENH_Industry_5;
  SHARED __EE425232 := __E_Business_Industry;
  SHARED __EE426539 := __EE425232(__NN(__EE425232._bus_) AND __NN(__EE425232._industry_));
  SHARED __ST425920_Layout := RECORD
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
  __JC426557(B_Industry_5(__in,__cfg).__ST248893_Layout __EE425234, E_Business_Industry(__in,__cfg).Layout __EE426539) := __EEQP(__EE426539._industry_,__EE425234.UID);
  __ST425920_Layout __JT426557(B_Industry_5(__in,__cfg).__ST248893_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE426558 := JOIN(__EE426539,__EE425234,__JC426557(RIGHT,LEFT),__JT426557(RIGHT,LEFT),INNER,HASH);
  SHARED __ST425602_Layout := RECORD
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
  SHARED __ST425602_Layout __ND426586__Project(__ST425920_Layout __PP426559) := TRANSFORM
    SELF.UID := __PP426559._bus_;
    SELF.U_I_D__1_ := __PP426559.UID;
    SELF := __PP426559;
  END;
  SHARED __EE426679 := PROJECT(__EE426558,__ND426586__Project(LEFT));
  SHARED __ST425667_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nkdate Exp1_;
    KEL.typ.nkdate Exp2_;
  END;
  SHARED __ST425667_Layout __ND426684__Project(__ST425602_Layout __PP426680) := TRANSFORM
    SELF.Exp1_ := IF(__T(__PP426680.Is_Highest_Frequency_N_A_I_C_S_),__ECAST(KEL.typ.nkdate,__PP426680._dt__last__seen_),__ECAST(KEL.typ.nkdate,__N(KEL.typ.kdate)));
    SELF.Exp2_ := IF(__T(__PP426680.Is_Highest_Frequency_S_I_C_),__ECAST(KEL.typ.nkdate,__PP426680._dt__last__seen_),__ECAST(KEL.typ.nkdate,__N(KEL.typ.kdate)));
    SELF := __PP426680;
  END;
  SHARED __EE426703 := PROJECT(__EE426679,__ND426684__Project(LEFT));
  SHARED __ST425687_Layout := RECORD
    KEL.typ.nkdate M_A_X__dt__last__seen_;
    KEL.typ.nkdate M_A_X__dt__last__seen__1_;
    KEL.typ.ntyp(E_Business().Typ) UID;
  END;
  SHARED __EE426724 := PROJECT(__CLEANANDDO(__EE426703,TABLE(__EE426703,{KEL.Aggregates.MaxNG(__EE426703.Exp1_) M_A_X__dt__last__seen_,KEL.Aggregates.MaxNG(__EE426703.Exp2_) M_A_X__dt__last__seen__1_,UID},UID,MERGE)),__ST425687_Layout);
  SHARED __ST426052_Layout := RECORD
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
  __JC426730(B_Business_6(__in,__cfg).__ST250433_Layout __EE425023, __ST425687_Layout __EE426724) := __EEQP(__EE425023.UID,__EE426724.UID);
  __ST426052_Layout __JT426730(B_Business_6(__in,__cfg).__ST250433_Layout __l, __ST425687_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE426731 := JOIN(__EE425023,__EE426724,__JC426730(LEFT,RIGHT),__JT426730(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST426124_Layout := RECORD
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
  SHARED __EE424458 := __E_Business_Account;
  SHARED __EE426760 := __EE424458(__NN(__EE424458._acc_) AND __NN(__EE424458._bus_));
  __JC426780(__ST426052_Layout __EE426731, E_Business_Account(__in,__cfg).Layout __EE426760) := __EEQP(__EE426731.UID,__EE426760._bus_);
  __JF426780(E_Business_Account(__in,__cfg).Layout __EE426760) := __NN(__EE426760._bus_);
  SHARED __EE426781 := JOIN(__EE426731,__EE426760,__JC426780(LEFT,RIGHT),TRANSFORM(__ST426124_Layout,SELF:=LEFT,SELF.Business_Account_:=__JF426780(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST245881_Layout := RECORD
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
  SHARED __ST245881_Layout __ND426796__Project(__ST426124_Layout __PP426782) := TRANSFORM
    SELF.Business_Not_On_File_ := NOT (__PP426782.Business_Account_);
    SELF.Most_Recent_N_A_I_C_S_Date_ := __PP426782.M_A_X__dt__last__seen_;
    SELF.Most_Recent_S_I_C_Date_ := __PP426782.M_A_X__dt__last__seen__1_;
    SELF := __PP426782;
  END;
  EXPORT __ENH_Business_4 := PROJECT(__EE426781,__ND426796__Project(LEFT));
END;
