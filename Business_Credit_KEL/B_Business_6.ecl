//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Business_7,B_Business_8,B_Industry_7,CFG_graph,E_Business,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Business_6(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_7(__in,__cfg).__ENH_Business_7) __ENH_Business_7 := B_Business_7(__in,__cfg).__ENH_Business_7;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_7(__in,__cfg).__ENH_Industry_7) __ENH_Industry_7 := B_Industry_7(__in,__cfg).__ENH_Industry_7;
  SHARED __EE9986838 := __ENH_Business_7;
  SHARED __ST308253_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE9987532 := PROJECT(__EE9986838,__ST308253_Layout);
  SHARED __EE9986859 := __ENH_Industry_7;
  SHARED __EE307821 := __E_Business_Industry;
  SHARED __EE9987313 := __EE307821(__NN(__EE307821._bus_) AND __NN(__EE307821._industry_));
  SHARED __ST308421_Layout := RECORD
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
  __JC9987331(B_Industry_7(__in,__cfg).__ST251889_Layout __EE9986859, E_Business_Industry(__in,__cfg).Layout __EE9987313) := __EEQP(__EE9987313._industry_,__EE9986859.UID);
  __ST308421_Layout __JT9987331(B_Industry_7(__in,__cfg).__ST251889_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE9987332 := JOIN(__EE9987313,__EE9986859,__JC9987331(RIGHT,LEFT),__JT9987331(RIGHT,LEFT),INNER,HASH);
  SHARED __ST308152_Layout := RECORD
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
  SHARED __ST308152_Layout __ND9987358__Project(__ST308421_Layout __PP9987333) := TRANSFORM
    SELF.UID := __PP9987333._bus_;
    SELF.U_I_D__1_ := __PP9987333.UID;
    SELF := __PP9987333;
  END;
  SHARED __EE9987443 := PROJECT(__EE9987332,__ND9987358__Project(LEFT));
  SHARED __ST308214_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nint Exp1_;
    KEL.typ.nint Exp2_;
  END;
  SHARED __ST308214_Layout __ND9987590__Project(__ST308152_Layout __PP9987444) := TRANSFORM
    SELF.Exp1_ := IF(__T(__PP9987444.Is_Good_N_A_I_C_S_),__ECAST(KEL.typ.nint,__CN(__PP9987444.Frequency_Count_N_A_I_C_S_)),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
    SELF.Exp2_ := IF(__T(__PP9987444.Is_Good_S_I_C_),__ECAST(KEL.typ.nint,__CN(__PP9987444.Frequency_Count_S_I_C_)),__ECAST(KEL.typ.nint,__N(KEL.typ.int)));
    SELF := __PP9987444;
  END;
  SHARED __EE9987597 := PROJECT(__EE9987443,__ND9987590__Project(LEFT));
  SHARED __ST308234_Layout := RECORD
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.ntyp(E_Business().Typ) UID;
  END;
  SHARED __EE9987618 := PROJECT(__CLEANANDDO(__EE9987597,TABLE(__EE9987597,{KEL.Aggregates.MaxNG(__EE9987597.Exp1_) Highest_Frequency_N_A_I_C_S_,KEL.Aggregates.MaxNG(__EE9987597.Exp2_) Highest_Frequency_S_I_C_,UID},UID,MERGE)),__ST308234_Layout);
  SHARED __ST308266_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.ntyp(E_Business().Typ) U_I_D__1_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC9987624(__ST308253_Layout __EE9987532, __ST308234_Layout __EE9987618) := __EEQP(__EE9987532.UID,__EE9987618.UID);
  __ST308266_Layout __JT9987624(__ST308253_Layout __l, __ST308234_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE9987634 := JOIN(__EE9987532,__EE9987618,__JC9987624(LEFT,RIGHT),__JT9987624(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST251000_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Business_6 := PROJECT(__EE9987634,__ST251000_Layout);
END;
