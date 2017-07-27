//HPCC Systems KEL Compiler Version 0.8.2
IMPORT KEL08a AS KEL;
IMPORT B_Industry_9,CFG_graph,E_Business,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL08a.Null;
EXPORT B_Business_8(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(E_Business(__in,__cfg).__Result) __E_Business := E_Business(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_9(__in,__cfg).__ENH_Industry_9) __ENH_Industry_9 := B_Industry_9(__in,__cfg).__ENH_Industry_9;
  SHARED __EE155592 := __E_Business;
  SHARED __EE155618 := __ENH_Industry_9;
  SHARED __EE155608 := __E_Business_Industry;
  SHARED __EE156449 := __EE155608(__NN(__EE155608._bus_) AND __NN(__EE155608._industry_));
  SHARED __ST156116_Layout := RECORD
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
    KEL.typ.nbool Is_N_A_I_C_S_Code_;
    KEL.typ.nbool Is_Primary_;
    KEL.typ.nbool Is_S_I_C_Code_;
    KEL.typ.nbool Is_Valid_Code_;
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC156467(B_Industry_9(__in,__cfg).__ST147657_Layout __EE155618, E_Business_Industry(__in,__cfg).Layout __EE156449) := __EEQP(__EE156449._industry_,__EE155618.UID);
  __ST156116_Layout __JT156467(B_Industry_9(__in,__cfg).__ST147657_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE156468 := JOIN(__EE156449,__EE155618,__JC156467(RIGHT,LEFT),__JT156467(RIGHT,LEFT),INNER,HASH);
  SHARED __ST155915_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nbool Is_N_A_I_C_S_Code_;
    KEL.typ.nbool Is_Primary_;
    KEL.typ.nbool Is_Valid_Code_;
    KEL.typ.nbool Is_S_I_C_Code_;
  END;
  SHARED __EE156511 := PROJECT(__EE156468,TRANSFORM(__ST155915_Layout,SELF.UID := LEFT._bus_,SELF := LEFT));
  SHARED __ST155950_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nbool Exp1_;
    KEL.typ.nbool Exp2_;
  END;
  SHARED __ST155950_Layout __ND156516__Project(__ST155915_Layout __PP156512) := TRANSFORM
    SELF.Exp1_ := __AND(__PP156512.Is_Valid_Code_,__AND(__PP156512.Is_Primary_,__PP156512.Is_N_A_I_C_S_Code_));
    SELF.Exp2_ := __AND(__PP156512.Is_Valid_Code_,__AND(__PP156512.Is_Primary_,__PP156512.Is_S_I_C_Code_));
    SELF := __PP156512;
  END;
  SHARED __EE156541 := PROJECT(__EE156511,__ND156516__Project(LEFT));
  SHARED __ST155970_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Industry_ := 0;
    KEL.typ.int C_O_U_N_T___Industry__1_ := 0;
    KEL.typ.ntyp(E_Business().Typ) UID;
  END;
  SHARED __EE156607 := PROJECT(__CLEANANDDO(__EE156541,TABLE(__EE156541,{KEL.typ.int C_O_U_N_T___Industry_ := COUNT(GROUP,__T(__EE156541.Exp1_)),KEL.typ.int C_O_U_N_T___Industry__1_ := COUNT(GROUP,__T(__EE156541.Exp2_)),UID},UID,MERGE)),__ST155970_Layout);
  SHARED __ST156170_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.int C_O_U_N_T___Industry_ := 0;
    KEL.typ.int C_O_U_N_T___Industry__1_ := 0;
    KEL.typ.ntyp(E_Business().Typ) U_I_D__1_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC156568(E_Business(__in,__cfg).Layout __EE155592, __ST155970_Layout __EE156607) := __EEQP(__EE155592.UID,__EE156607.UID);
  __ST156170_Layout __JT156568(E_Business(__in,__cfg).Layout __l, __ST155970_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE156569 := JOIN(__EE155592,__EE156607,__JC156568(LEFT,RIGHT),__JT156568(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST155583_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST155583_Layout __ND156581__Project(__ST156170_Layout __PP156570) := TRANSFORM
    SELF.Use_Primary_N_A_I_C_S_ := __PP156570.C_O_U_N_T___Industry_ <> 0;
    SELF.Use_Primary_S_I_C_ := __PP156570.C_O_U_N_T___Industry__1_ <> 0;
    SELF := __PP156570;
  END;
  EXPORT __ENH_Business_8 := PROJECT(__EE156569,__ND156581__Project(LEFT));
END;
