//HPCC Systems KEL Compiler Version 0.8.2
IMPORT KEL08a AS KEL;
IMPORT B_Business_7,B_Business_8,B_Industry_7,CFG_graph,E_Business,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL08a.Null;
EXPORT B_Business_6(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_7(__in,__cfg).__ENH_Business_7) __ENH_Business_7 := B_Business_7(__in,__cfg).__ENH_Business_7;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_7(__in,__cfg).__ENH_Industry_7) __ENH_Industry_7 := B_Industry_7(__in,__cfg).__ENH_Industry_7;
  SHARED __EE176783 := __ENH_Business_7;
  SHARED __ST177558_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
  END;
  SHARED __EE177556 := PROJECT(__EE176783,__ST177558_Layout);
  SHARED __EE176813 := __ENH_Industry_7;
  SHARED __EE176803 := __E_Business_Industry;
  SHARED __EE178150 := __EE176803(__NN(__EE176803._bus_) AND __NN(__EE176803._industry_));
  SHARED __ST177725_Layout := RECORD
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
  __JC178168(B_Industry_7(__in,__cfg).__ST164175_Layout __EE176813, E_Business_Industry(__in,__cfg).Layout __EE178150) := __EEQP(__EE178150._industry_,__EE176813.UID);
  __ST177725_Layout __JT178168(B_Industry_7(__in,__cfg).__ST164175_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE178169 := JOIN(__EE178150,__EE176813,__JC178168(RIGHT,LEFT),__JT178168(RIGHT,LEFT),INNER,HASH);
  SHARED __ST177460_Layout := RECORD
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
  SHARED __ST177460_Layout __ND178195__Project(__ST177725_Layout __PP178170) := TRANSFORM
    SELF.UID := __PP178170._bus_;
    SELF.U_I_D__1_ := __PP178170.UID;
    SELF := __PP178170;
  END;
  SHARED __EE178280 := PROJECT(__EE178169,__ND178195__Project(LEFT));
  SHARED __ST177521_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nint Exp1_;
    KEL.typ.nint Exp2_;
  END;
  SHARED __ST177521_Layout __ND178370__Project(__ST177460_Layout __PP178281) := TRANSFORM
    SELF.Exp1_ := IF(__T(__PP178281.Is_Good_N_A_I_C_S_),__CN(__PP178281.Frequency_Count_N_A_I_C_S_),__N(KEL.typ.int));
    SELF.Exp2_ := IF(__T(__PP178281.Is_Good_S_I_C_),__CN(__PP178281.Frequency_Count_S_I_C_),__N(KEL.typ.int));
    SELF := __PP178281;
  END;
  SHARED __EE178377 := PROJECT(__EE178280,__ND178370__Project(LEFT));
  SHARED __ST177541_Layout := RECORD
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.ntyp(E_Business().Typ) UID;
  END;
  SHARED __EE178325 := PROJECT(__CLEANANDDO(__EE178377,TABLE(__EE178377,{KEL.Aggregates.MaxNG(__EE178377.Exp1_) Highest_Frequency_N_A_I_C_S_,KEL.Aggregates.MaxNG(__EE178377.Exp2_) Highest_Frequency_S_I_C_,UID},UID,MERGE)),__ST177541_Layout);
  SHARED __ST177571_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.ntyp(E_Business().Typ) U_I_D__1_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC178331(__ST177558_Layout __EE177556, __ST177541_Layout __EE178325) := __EEQP(__EE177556.UID,__EE178325.UID);
  __ST177571_Layout __JT178331(__ST177558_Layout __l, __ST177541_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE178332 := JOIN(__EE177556,__EE178325,__JC178331(LEFT,RIGHT),__JT178331(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST176767_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ENH_Business_6 := PROJECT(__EE178332,__ST176767_Layout);
END;
