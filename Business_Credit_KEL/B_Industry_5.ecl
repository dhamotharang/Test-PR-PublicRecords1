//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Business_6,B_Industry_6,B_Industry_7,CFG_graph,E_Business,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Industry_5(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_6(__in,__cfg).__ENH_Business_6) __ENH_Business_6 := B_Business_6(__in,__cfg).__ENH_Business_6;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_6(__in,__cfg).__ENH_Industry_6) __ENH_Industry_6 := B_Industry_6(__in,__cfg).__ENH_Industry_6;
  SHARED __EE352575 := __ENH_Industry_6;
  SHARED __EE352685 := __ENH_Business_6;
  SHARED __EE352683 := __E_Business_Industry;
  SHARED __EE353517 := __EE352683(__NN(__EE352683._industry_) AND __NN(__EE352683._bus_));
  SHARED __ST353007_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC353535(B_Business_6(__in,__cfg).__ST250433_Layout __EE352685, E_Business_Industry(__in,__cfg).Layout __EE353517) := __EEQP(__EE353517._bus_,__EE352685.UID);
  __ST353007_Layout __JT353535(B_Business_6(__in,__cfg).__ST250433_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE353536 := JOIN(__EE353517,__EE352685,__JC353535(RIGHT,LEFT),__JT353535(RIGHT,LEFT),INNER,HASH);
  SHARED __ST352751_Layout := RECORD
    KEL.typ.ntyp(E_Industry().Typ) UID;
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
  END;
  SHARED __ST352751_Layout __ND353549__Project(__ST353007_Layout __PP353537) := TRANSFORM
    SELF.UID := __PP353537._industry_;
    SELF.U_I_D__1_ := __PP353537.UID;
    SELF := __PP353537;
  END;
  SHARED __EE353582 := PROJECT(__EE353536,__ND353549__Project(LEFT));
  SHARED __ST352784_Layout := RECORD
    KEL.typ.ntyp(E_Industry().Typ) UID;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
  END;
  SHARED __EE353600 := PROJECT(__EE353582,__ST352784_Layout);
  SHARED __ST352804_Layout := RECORD
    KEL.typ.nint M_A_X___Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint M_A_X___Highest_Frequency_S_I_C_;
    KEL.typ.ntyp(E_Industry().Typ) UID;
  END;
  SHARED __EE353621 := PROJECT(__CLEANANDDO(__EE353600,TABLE(__EE353600,{KEL.Aggregates.MaxNG(__EE353600.Highest_Frequency_N_A_I_C_S_) M_A_X___Highest_Frequency_N_A_I_C_S_,KEL.Aggregates.MaxNG(__EE353600.Highest_Frequency_S_I_C_) M_A_X___Highest_Frequency_S_I_C_,UID},UID,MERGE)),__ST352804_Layout);
  SHARED __ST353064_Layout := RECORD
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
  __JC353627(B_Industry_7(__in,__cfg).__ST251255_Layout __EE352575, __ST352804_Layout __EE353621) := __EEQP(__EE352575.UID,__EE353621.UID);
  __ST353064_Layout __JT353627(B_Industry_7(__in,__cfg).__ST251255_Layout __l, __ST352804_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE353628 := JOIN(__EE352575,__EE353621,__JC353627(LEFT,RIGHT),__JT353627(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST248893_Layout := RECORD
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
  SHARED __ST248893_Layout __ND353754__Project(__ST353064_Layout __PP353629) := TRANSFORM
    SELF.Is_Highest_Frequency_N_A_I_C_S_ := __AND(__PP353629.Is_Good_N_A_I_C_S_,__OP2(__CN(__PP353629.Frequency_Count_N_A_I_C_S_),=,__PP353629.M_A_X___Highest_Frequency_N_A_I_C_S_));
    SELF.Is_Highest_Frequency_S_I_C_ := __AND(__PP353629.Is_Good_S_I_C_,__OP2(__CN(__PP353629.Frequency_Count_S_I_C_),=,__PP353629.M_A_X___Highest_Frequency_S_I_C_));
    SELF := __PP353629;
  END;
  EXPORT __ENH_Industry_5 := PROJECT(__EE353628,__ND353754__Project(LEFT));
END;
