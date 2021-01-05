//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Business_7,B_Business_8,B_Industry_7,CFG_graph,E_Business,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Business_6(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_7(__in,__cfg).__ENH_Business_7) __ENH_Business_7 := B_Business_7(__in,__cfg).__ENH_Business_7;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_7(__in,__cfg).__ENH_Industry_7) __ENH_Industry_7 := B_Industry_7(__in,__cfg).__ENH_Industry_7;
  SHARED __EE317401 := __ENH_Business_7;
  SHARED __ST317406_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE318206 := PROJECT(__EE317401,__ST317406_Layout);
  SHARED __EE316977 := __ENH_Industry_7;
  SHARED __EE316975 := __E_Business_Industry;
  SHARED __EE317987 := __EE316975(__NN(__EE316975._bus_) AND __NN(__EE316975._industry_));
  SHARED __ST317574_Layout := RECORD
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
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC318005(B_Industry_7(__in,__cfg).__ST251255_Layout __EE316977, E_Business_Industry(__in,__cfg).Layout __EE317987) := __EEQP(__EE317987._industry_,__EE316977.UID);
  __ST317574_Layout __JT318005(B_Industry_7(__in,__cfg).__ST251255_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE318006 := JOIN(__EE317987,__EE316977,__JC318005(RIGHT,LEFT),__JT318005(RIGHT,LEFT),INNER,HASH);
  SHARED __ST317306_Layout := RECORD
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
    KEL.typ.nbool Is_N_A_I_C_S_Code_;
    KEL.typ.nbool Is_Primary_;
    KEL.typ.nbool Is_S_I_C_Code_;
    KEL.typ.nbool Is_Valid_Code_;
  END;
  SHARED __ST317306_Layout __ND318032__Project(__ST317574_Layout __PP318007) := TRANSFORM
    SELF.UID := __PP318007._bus_;
    SELF.U_I_D__1_ := __PP318007.UID;
    SELF := __PP318007;
  END;
  SHARED __EE318117 := PROJECT(__EE318006,__ND318032__Project(LEFT));
  SHARED __ST317367_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nint Exp1_;
    KEL.typ.nint Exp2_;
  END;
  SHARED __ST317367_Layout __ND318264__Project(__ST317306_Layout __PP318118) := TRANSFORM
    SELF.Exp1_ := IF(__T(__PP318118.Is_Good_N_A_I_C_S_),__ECAST(KEL.typ.nint,__CN(__PP318118.Frequency_Count_N_A_I_C_S_)),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
    SELF.Exp2_ := IF(__T(__PP318118.Is_Good_S_I_C_),__ECAST(KEL.typ.nint,__CN(__PP318118.Frequency_Count_S_I_C_)),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
    SELF := __PP318118;
  END;
  SHARED __EE318271 := PROJECT(__EE318117,__ND318264__Project(LEFT));
  SHARED __ST317387_Layout := RECORD
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.ntyp(E_Business().Typ) UID;
  END;
  SHARED __EE318292 := PROJECT(__CLEANANDDO(__EE318271,TABLE(__EE318271,{KEL.Aggregates.MaxNG(__EE318271.Exp1_) Highest_Frequency_N_A_I_C_S_,KEL.Aggregates.MaxNG(__EE318271.Exp2_) Highest_Frequency_S_I_C_,UID},UID,MERGE)),__ST317387_Layout);
  SHARED __ST317419_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.ntyp(E_Business().Typ) U_I_D__1_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC318298(__ST317406_Layout __EE318206, __ST317387_Layout __EE318292) := __EEQP(__EE318206.UID,__EE318292.UID);
  __ST317419_Layout __JT318298(__ST317406_Layout __l, __ST317387_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE318308 := JOIN(__EE318206,__EE318292,__JC318298(LEFT,RIGHT),__JT318298(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST250433_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Business_6 := PROJECT(__EE318308,__ST250433_Layout);
END;
