//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Business_6,B_Industry_6,B_Industry_7,CFG_graph,E_Business,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Industry_5(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_6(__in,__cfg).__ENH_Business_6) __ENH_Business_6 := B_Business_6(__in,__cfg).__ENH_Business_6;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_6(__in,__cfg).__ENH_Industry_6) __ENH_Industry_6 := B_Industry_6(__in,__cfg).__ENH_Industry_6;
  SHARED __EE9994544 := __ENH_Industry_6;
  SHARED __EE9994547 := __ENH_Business_6;
  SHARED __EE342446 := __E_Business_Industry;
  SHARED __EE9995033 := __EE342446(__NN(__EE342446._industry_) AND __NN(__EE342446._bus_));
  SHARED __ST342771_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC9995051(B_Business_6(__in,__cfg).__ST251000_Layout __EE9994547, E_Business_Industry(__in,__cfg).Layout __EE9995033) := __EEQP(__EE9995033._bus_,__EE9994547.UID);
  __ST342771_Layout __JT9995051(B_Business_6(__in,__cfg).__ST251000_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE9995052 := JOIN(__EE9995033,__EE9994547,__JC9995051(RIGHT,LEFT),__JT9995051(RIGHT,LEFT),INNER,HASH);
  SHARED __ST342514_Layout := RECORD
    KEL.typ.ntyp(E_Industry().Typ) UID;
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
  END;
  SHARED __ST342514_Layout __ND9995065__Project(__ST342771_Layout __PP9995053) := TRANSFORM
    SELF.UID := __PP9995053._industry_;
    SELF.U_I_D__1_ := __PP9995053.UID;
    SELF := __PP9995053;
  END;
  SHARED __EE9995098 := PROJECT(__EE9995052,__ND9995065__Project(LEFT));
  SHARED __ST342548_Layout := RECORD
    KEL.typ.ntyp(E_Industry().Typ) UID;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
  END;
  SHARED __EE9995116 := PROJECT(__EE9995098,__ST342548_Layout);
  SHARED __ST342568_Layout := RECORD
    KEL.typ.nint M_A_X___Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint M_A_X___Highest_Frequency_S_I_C_;
    KEL.typ.ntyp(E_Industry().Typ) UID;
  END;
  SHARED __EE9995137 := PROJECT(__CLEANANDDO(__EE9995116,TABLE(__EE9995116,{KEL.Aggregates.MaxNG(__EE9995116.Highest_Frequency_N_A_I_C_S_) M_A_X___Highest_Frequency_N_A_I_C_S_,KEL.Aggregates.MaxNG(__EE9995116.Highest_Frequency_S_I_C_) M_A_X___Highest_Frequency_S_I_C_,UID},UID,MERGE)),__ST342568_Layout);
  SHARED __ST342839_Layout := RECORD
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
    KEL.typ.nbool Is_N_A_I_C_S_Code_;
    KEL.typ.nbool Is_Primary_;
    KEL.typ.nbool Is_S_I_C_Code_;
    KEL.typ.nbool Is_Valid_Code_;
    KEL.typ.nint M_A_X___Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint M_A_X___Highest_Frequency_S_I_C_;
    KEL.typ.ntyp(E_Industry().Typ) U_I_D__1_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC9995143(B_Industry_7(__in,__cfg).__ST251889_Layout __EE9994544, __ST342568_Layout __EE9995137) := __EEQP(__EE9994544.UID,__EE9995137.UID);
  __ST342839_Layout __JT9995143(B_Industry_7(__in,__cfg).__ST251889_Layout __l, __ST342568_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE9995144 := JOIN(__EE9994544,__EE9995137,__JC9995143(LEFT,RIGHT),__JT9995143(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST249383_Layout := RECORD
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
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST249383_Layout __ND9995270__Project(__ST342839_Layout __PP9995145) := TRANSFORM
    SELF.Is_Highest_Frequency_N_A_I_C_S_ := __AND(__PP9995145.Is_Good_N_A_I_C_S_,__OP2(__CN(__PP9995145.Frequency_Count_N_A_I_C_S_),=,__PP9995145.M_A_X___Highest_Frequency_N_A_I_C_S_));
    SELF.Is_Highest_Frequency_S_I_C_ := __AND(__PP9995145.Is_Good_S_I_C_,__OP2(__CN(__PP9995145.Frequency_Count_S_I_C_),=,__PP9995145.M_A_X___Highest_Frequency_S_I_C_));
    SELF := __PP9995145;
  END;
  EXPORT __ENH_Industry_5 := PROJECT(__EE9995144,__ND9995270__Project(LEFT));
END;
