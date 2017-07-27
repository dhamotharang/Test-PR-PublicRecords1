//HPCC Systems KEL Compiler Version 0.8.2
IMPORT KEL08a AS KEL;
IMPORT B_Business_6,B_Industry_6,B_Industry_7,CFG_graph,E_Business,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL08a.Null;
EXPORT B_Industry_5(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_6(__in,__cfg).__ENH_Business_6) __ENH_Business_6 := B_Business_6(__in,__cfg).__ENH_Business_6;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_6(__in,__cfg).__ENH_Industry_6) __ENH_Industry_6 := B_Industry_6(__in,__cfg).__ENH_Industry_6;
  SHARED __EE201632 := __ENH_Industry_6;
  SHARED __EE201724 := __ENH_Business_6;
  SHARED __EE201714 := __E_Business_Industry;
  SHARED __EE202818 := __EE201714(__NN(__EE201714._industry_) AND __NN(__EE201714._bus_));
  SHARED __ST202296_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC202836(B_Business_6(__in,__cfg).__ST176767_Layout __EE201724, E_Business_Industry(__in,__cfg).Layout __EE202818) := __EEQP(__EE202818._bus_,__EE201724.UID);
  __ST202296_Layout __JT202836(B_Business_6(__in,__cfg).__ST176767_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE202837 := JOIN(__EE202818,__EE201724,__JC202836(RIGHT,LEFT),__JT202836(RIGHT,LEFT),INNER,HASH);
  SHARED __ST202044_Layout := RECORD
    KEL.typ.ntyp(E_Industry().Typ) UID;
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
  END;
  SHARED __ST202044_Layout __ND202850__Project(__ST202296_Layout __PP202838) := TRANSFORM
    SELF.UID := __PP202838._industry_;
    SELF.U_I_D__1_ := __PP202838.UID;
    SELF := __PP202838;
  END;
  SHARED __EE202883 := PROJECT(__EE202837,__ND202850__Project(LEFT));
  SHARED __ST202077_Layout := RECORD
    KEL.typ.ntyp(E_Industry().Typ) UID;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
  END;
  SHARED __EE202901 := PROJECT(__EE202883,__ST202077_Layout);
  SHARED __ST202097_Layout := RECORD
    KEL.typ.nint M_A_X___Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint M_A_X___Highest_Frequency_S_I_C_;
    KEL.typ.ntyp(E_Industry().Typ) UID;
  END;
  SHARED __EE202922 := PROJECT(__CLEANANDDO(__EE202901,TABLE(__EE202901,{KEL.Aggregates.MaxNG(__EE202901.Highest_Frequency_N_A_I_C_S_) M_A_X___Highest_Frequency_N_A_I_C_S_,KEL.Aggregates.MaxNG(__EE202901.Highest_Frequency_S_I_C_) M_A_X___Highest_Frequency_S_I_C_,UID},UID,MERGE)),__ST202097_Layout);
  SHARED __ST202353_Layout := RECORD
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
  __JC202928(B_Industry_7(__in,__cfg).__ST164175_Layout __EE201632, __ST202097_Layout __EE202922) := __EEQP(__EE201632.UID,__EE202922.UID);
  __ST202353_Layout __JT202928(B_Industry_7(__in,__cfg).__ST164175_Layout __l, __ST202097_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE202929 := JOIN(__EE201632,__EE202922,__JC202928(LEFT,RIGHT),__JT202928(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST201580_Layout := RECORD
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
  SHARED __ST201580_Layout __ND203055__Project(__ST202353_Layout __PP202930) := TRANSFORM
    SELF.Is_Highest_Frequency_N_A_I_C_S_ := __AND(__PP202930.Is_Good_N_A_I_C_S_,__OP2(__CN(__PP202930.Frequency_Count_N_A_I_C_S_),=,__PP202930.M_A_X___Highest_Frequency_N_A_I_C_S_));
    SELF.Is_Highest_Frequency_S_I_C_ := __AND(__PP202930.Is_Good_S_I_C_,__OP2(__CN(__PP202930.Frequency_Count_S_I_C_),=,__PP202930.M_A_X___Highest_Frequency_S_I_C_));
    SELF := __PP202930;
  END;
  EXPORT __ENH_Industry_5 := PROJECT(__EE202929,__ND203055__Project(LEFT));
END;
