//HPCC Systems KEL Compiler Version 0.8.2
IMPORT KEL08a AS KEL;
IMPORT B_Business_5,B_Business_6,B_Industry_5,CFG_graph,E_Account,E_Business,E_Business_Account,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL08a.Null;
EXPORT B_Business_4(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_5(__in,__cfg).__ENH_Business_5) __ENH_Business_5 := B_Business_5(__in,__cfg).__ENH_Business_5;
  SHARED VIRTUAL TYPEOF(E_Business_Account(__in,__cfg).__Result) __E_Business_Account := E_Business_Account(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_5(__in,__cfg).__ENH_Industry_5) __ENH_Industry_5 := B_Industry_5(__in,__cfg).__ENH_Industry_5;
  SHARED __EE239586 := __ENH_Business_5;
  SHARED __EE239655 := __ENH_Industry_5;
  SHARED __EE239645 := __E_Business_Industry;
  SHARED __EE241370 := __EE239645(__NN(__EE239645._bus_) AND __NN(__EE239645._industry_));
  SHARED __ST240730_Layout := RECORD
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
  __JC241388(B_Industry_5(__in,__cfg).__ST201580_Layout __EE239655, E_Business_Industry(__in,__cfg).Layout __EE241370) := __EEQP(__EE241370._industry_,__EE239655.UID);
  __ST240730_Layout __JT241388(B_Industry_5(__in,__cfg).__ST201580_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE241389 := JOIN(__EE241370,__EE239655,__JC241388(RIGHT,LEFT),__JT241388(RIGHT,LEFT),INNER,HASH);
  SHARED __ST240417_Layout := RECORD
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
  SHARED __ST240417_Layout __ND241417__Project(__ST240730_Layout __PP241390) := TRANSFORM
    SELF.UID := __PP241390._bus_;
    SELF.U_I_D__1_ := __PP241390.UID;
    SELF := __PP241390;
  END;
  SHARED __EE241510 := PROJECT(__EE241389,__ND241417__Project(LEFT));
  SHARED __ST240482_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nkdate Exp1_;
    KEL.typ.nkdate Exp2_;
  END;
  SHARED __ST240482_Layout __ND241515__Project(__ST240417_Layout __PP241511) := TRANSFORM
    SELF.Exp1_ := IF(__T(__PP241511.Is_Highest_Frequency_N_A_I_C_S_),__PP241511._dt__last__seen_,__N(KEL.typ.kdate));
    SELF.Exp2_ := IF(__T(__PP241511.Is_Highest_Frequency_S_I_C_),__PP241511._dt__last__seen_,__N(KEL.typ.kdate));
    SELF := __PP241511;
  END;
  SHARED __EE241534 := PROJECT(__EE241510,__ND241515__Project(LEFT));
  SHARED __ST240502_Layout := RECORD
    KEL.typ.nkdate M_A_X__dt__last__seen_;
    KEL.typ.nkdate M_A_X__dt__last__seen__1_;
    KEL.typ.ntyp(E_Business().Typ) UID;
  END;
  SHARED __EE241555 := PROJECT(__CLEANANDDO(__EE241534,TABLE(__EE241534,{KEL.Aggregates.MaxNG(__EE241534.Exp1_) M_A_X__dt__last__seen_,KEL.Aggregates.MaxNG(__EE241534.Exp2_) M_A_X__dt__last__seen__1_,UID},UID,MERGE)),__ST240502_Layout);
  SHARED __ST240862_Layout := RECORD
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
  __JC241561(B_Business_6(__in,__cfg).__ST176767_Layout __EE239586, __ST240502_Layout __EE241555) := __EEQP(__EE239586.UID,__EE241555.UID);
  __ST240862_Layout __JT241561(B_Business_6(__in,__cfg).__ST176767_Layout __l, __ST240502_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE241562 := JOIN(__EE239586,__EE241555,__JC241561(LEFT,RIGHT),__JT241561(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST240925_Layout := RECORD
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
  SHARED __EE239612 := __E_Business_Account;
  SHARED __EE241591 := __EE239612(__NN(__EE239612._acc_) AND __NN(__EE239612._bus_));
  __JC241611(__ST240862_Layout __EE241562, E_Business_Account(__in,__cfg).Layout __EE241591) := __EEQP(__EE241562.UID,__EE241591._bus_);
  __JF241611(E_Business_Account(__in,__cfg).Layout __EE241591) := __NN(__EE241591._bus_);
  SHARED __EE241612 := JOIN(__EE241562,__EE241591,__JC241611(LEFT,RIGHT),TRANSFORM(__ST240925_Layout,SELF:=LEFT,SELF.Business_Account_:=__JF241611(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST239562_Layout := RECORD
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
  SHARED __ST239562_Layout __ND241627__Project(__ST240925_Layout __PP241613) := TRANSFORM
    SELF.Business_Not_On_File_ := NOT (__PP241613.Business_Account_);
    SELF.Most_Recent_N_A_I_C_S_Date_ := __PP241613.M_A_X__dt__last__seen_;
    SELF.Most_Recent_S_I_C_Date_ := __PP241613.M_A_X__dt__last__seen__1_;
    SELF := __PP241613;
  END;
  EXPORT __ENH_Business_4 := PROJECT(__EE241612,__ND241627__Project(LEFT));
END;
