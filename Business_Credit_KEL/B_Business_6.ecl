//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Business_7,B_Business_8,B_Industry_7,CFG_graph,E_Business,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Business_6(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_7(__in,__cfg).__ENH_Business_7) __ENH_Business_7 := B_Business_7(__in,__cfg).__ENH_Business_7;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_7(__in,__cfg).__ENH_Industry_7) __ENH_Industry_7 := B_Industry_7(__in,__cfg).__ENH_Industry_7;
  SHARED __EE9814955 := __ENH_Business_7;
  SHARED __ST304401_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE9815649 := PROJECT(__EE9814955,__ST304401_Layout);
  SHARED __EE9814976 := __ENH_Industry_7;
  SHARED __EE303969 := __E_Business_Industry;
  SHARED __EE9815430 := __EE303969(__NN(__EE303969._bus_) AND __NN(__EE303969._industry_));
  SHARED __ST304569_Layout := RECORD
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
  __JC9815448(B_Industry_7(__in,__cfg).__ST251294_Layout __EE9814976, E_Business_Industry(__in,__cfg).Layout __EE9815430) := __EEQP(__EE9815430._industry_,__EE9814976.UID);
  __ST304569_Layout __JT9815448(B_Industry_7(__in,__cfg).__ST251294_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE9815449 := JOIN(__EE9815430,__EE9814976,__JC9815448(RIGHT,LEFT),__JT9815448(RIGHT,LEFT),INNER,HASH);
  SHARED __ST304300_Layout := RECORD
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
  SHARED __ST304300_Layout __ND9815475__Project(__ST304569_Layout __PP9815450) := TRANSFORM
    SELF.UID := __PP9815450._bus_;
    SELF.U_I_D__1_ := __PP9815450.UID;
    SELF := __PP9815450;
  END;
  SHARED __EE9815560 := PROJECT(__EE9815449,__ND9815475__Project(LEFT));
  SHARED __ST304362_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nint Exp1_;
    KEL.typ.nint Exp2_;
  END;
  SHARED __ST304362_Layout __ND9815707__Project(__ST304300_Layout __PP9815561) := TRANSFORM
    SELF.Exp1_ := IF(__T(__PP9815561.Is_Good_N_A_I_C_S_),__ECAST(KEL.typ.nint,__CN(__PP9815561.Frequency_Count_N_A_I_C_S_)),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
    SELF.Exp2_ := IF(__T(__PP9815561.Is_Good_S_I_C_),__ECAST(KEL.typ.nint,__CN(__PP9815561.Frequency_Count_S_I_C_)),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
    SELF := __PP9815561;
  END;
  SHARED __EE9815714 := PROJECT(__EE9815560,__ND9815707__Project(LEFT));
  SHARED __ST304382_Layout := RECORD
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.ntyp(E_Business().Typ) UID;
  END;
  SHARED __EE9815735 := PROJECT(__CLEANANDDO(__EE9815714,TABLE(__EE9815714,{KEL.Aggregates.MaxNG(__EE9815714.Exp1_) Highest_Frequency_N_A_I_C_S_,KEL.Aggregates.MaxNG(__EE9815714.Exp2_) Highest_Frequency_S_I_C_,UID},UID,MERGE)),__ST304382_Layout);
  SHARED __ST304414_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.ntyp(E_Business().Typ) U_I_D__1_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC9815741(__ST304401_Layout __EE9815649, __ST304382_Layout __EE9815735) := __EEQP(__EE9815649.UID,__EE9815735.UID);
  __ST304414_Layout __JT9815741(__ST304401_Layout __l, __ST304382_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE9815751 := JOIN(__EE9815649,__EE9815735,__JC9815741(LEFT,RIGHT),__JT9815741(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST250472_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Business_6 := PROJECT(__EE9815751,__ST250472_Layout);
END;
