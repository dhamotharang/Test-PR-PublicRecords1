//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Business_7,B_Business_8,B_Industry_7,CFG_graph,E_Business,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Business_6(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_7(__in,__cfg).__ENH_Business_7) __ENH_Business_7 := B_Business_7(__in,__cfg).__ENH_Business_7;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_7(__in,__cfg).__ENH_Industry_7) __ENH_Industry_7 := B_Industry_7(__in,__cfg).__ENH_Industry_7;
  SHARED __EE299658 := __ENH_Business_7;
  SHARED __ST299663_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE300463 := PROJECT(__EE299658,__ST299663_Layout);
  SHARED __EE299234 := __ENH_Industry_7;
  SHARED __EE299232 := __E_Business_Industry;
  SHARED __EE300244 := __EE299232(__NN(__EE299232._bus_) AND __NN(__EE299232._industry_));
  SHARED __ST299831_Layout := RECORD
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
  __JC300262(B_Industry_7(__in,__cfg).__ST239534_Layout __EE299234, E_Business_Industry(__in,__cfg).Layout __EE300244) := __EEQP(__EE300244._industry_,__EE299234.UID);
  __ST299831_Layout __JT300262(B_Industry_7(__in,__cfg).__ST239534_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE300263 := JOIN(__EE300244,__EE299234,__JC300262(RIGHT,LEFT),__JT300262(RIGHT,LEFT),INNER,HASH);
  SHARED __ST299563_Layout := RECORD
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
  SHARED __ST299563_Layout __ND300289__Project(__ST299831_Layout __PP300264) := TRANSFORM
    SELF.UID := __PP300264._bus_;
    SELF.U_I_D__1_ := __PP300264.UID;
    SELF := __PP300264;
  END;
  SHARED __EE300374 := PROJECT(__EE300263,__ND300289__Project(LEFT));
  SHARED __ST299624_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nint Exp1_;
    KEL.typ.nint Exp2_;
  END;
  SHARED __ST299624_Layout __ND300521__Project(__ST299563_Layout __PP300375) := TRANSFORM
    SELF.Exp1_ := IF(__T(__PP300375.Is_Good_N_A_I_C_S_),__ECAST(KEL.typ.nint,__CN(__PP300375.Frequency_Count_N_A_I_C_S_)),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
    SELF.Exp2_ := IF(__T(__PP300375.Is_Good_S_I_C_),__ECAST(KEL.typ.nint,__CN(__PP300375.Frequency_Count_S_I_C_)),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
    SELF := __PP300375;
  END;
  SHARED __EE300528 := PROJECT(__EE300374,__ND300521__Project(LEFT));
  SHARED __ST299644_Layout := RECORD
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.ntyp(E_Business().Typ) UID;
  END;
  SHARED __EE300549 := PROJECT(__CLEANANDDO(__EE300528,TABLE(__EE300528,{KEL.Aggregates.MaxNG(__EE300528.Exp1_) Highest_Frequency_N_A_I_C_S_,KEL.Aggregates.MaxNG(__EE300528.Exp2_) Highest_Frequency_S_I_C_,UID},UID,MERGE)),__ST299644_Layout);
  SHARED __ST299676_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.ntyp(E_Business().Typ) U_I_D__1_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC300555(__ST299663_Layout __EE300463, __ST299644_Layout __EE300549) := __EEQP(__EE300463.UID,__EE300549.UID);
  __ST299676_Layout __JT300555(__ST299663_Layout __l, __ST299644_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE300565 := JOIN(__EE300463,__EE300549,__JC300555(LEFT,RIGHT),__JT300555(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST238866_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Business_6 := PROJECT(__EE300565,__ST238866_Layout);
END;
