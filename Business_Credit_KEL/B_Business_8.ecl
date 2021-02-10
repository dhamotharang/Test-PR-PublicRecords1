//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Industry_9,CFG_graph,E_Business,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Business_8(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(E_Business(__in,__cfg).__Result) __E_Business := E_Business(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_9(__in,__cfg).__ENH_Industry_9) __ENH_Industry_9 := B_Industry_9(__in,__cfg).__ENH_Industry_9;
  SHARED __EE289058 := __E_Business;
  SHARED __EE9974146 := __ENH_Industry_9;
  SHARED __EE9974155 := __EE9974146(__T(__AND(__EE9974146.Is_Valid_Code_,__EE9974146.Is_Primary_)));
  SHARED __EE289230 := __E_Business_Industry;
  SHARED __EE9974427 := __EE289230(__NN(__EE289230._bus_) AND __NN(__EE289230._industry_));
  SHARED __ST289583_Layout := RECORD
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
  __JC9974445(B_Industry_9(__in,__cfg).__ST252763_Layout __EE9974155, E_Business_Industry(__in,__cfg).Layout __EE9974427) := __EEQP(__EE9974427._industry_,__EE9974155.UID);
  __ST289583_Layout __JT9974445(B_Industry_9(__in,__cfg).__ST252763_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE9974446 := JOIN(__EE9974427,__EE9974155,__JC9974445(RIGHT,LEFT),__JT9974445(RIGHT,LEFT),INNER,HASH);
  SHARED __ST289379_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nbool Is_N_A_I_C_S_Code_;
    KEL.typ.nbool Is_S_I_C_Code_;
  END;
  SHARED __EE9974481 := PROJECT(__EE9974446,TRANSFORM(__ST289379_Layout,SELF.UID := LEFT._bus_,SELF := LEFT));
  SHARED __ST289403_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nbool Is_N_A_I_C_S_Code_;
    KEL.typ.nbool Is_S_I_C_Code_;
  END;
  SHARED __EE9974499 := PROJECT(__EE9974481,__ST289403_Layout);
  SHARED __ST289423_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Industry_ := 0;
    KEL.typ.int C_O_U_N_T___Industry__1_ := 0;
    KEL.typ.ntyp(E_Business().Typ) UID;
  END;
  SHARED __EE9974565 := PROJECT(__CLEANANDDO(__EE9974499,TABLE(__EE9974499,{KEL.typ.int C_O_U_N_T___Industry_ := COUNT(GROUP,__T(__EE9974499.Is_N_A_I_C_S_Code_)),KEL.typ.int C_O_U_N_T___Industry__1_ := COUNT(GROUP,__T(__EE9974499.Is_S_I_C_Code_)),UID},UID,MERGE)),__ST289423_Layout);
  SHARED __ST289635_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.int C_O_U_N_T___Industry_ := 0;
    KEL.typ.int C_O_U_N_T___Industry__1_ := 0;
    KEL.typ.ntyp(E_Business().Typ) U_I_D__1_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC9974571(E_Business(__in,__cfg).Layout __EE289058, __ST289423_Layout __EE9974565) := __EEQP(__EE289058.UID,__EE9974565.UID);
  __ST289635_Layout __JT9974571(E_Business(__in,__cfg).Layout __l, __ST289423_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE9974579 := JOIN(__EE289058,__EE9974565,__JC9974571(LEFT,RIGHT),__JT9974571(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST252329_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST252329_Layout __ND9974584__Project(__ST289635_Layout __PP9974580) := TRANSFORM
    SELF.Use_Primary_N_A_I_C_S_ := __PP9974580.C_O_U_N_T___Industry_ <> 0;
    SELF.Use_Primary_S_I_C_ := __PP9974580.C_O_U_N_T___Industry__1_ <> 0;
    SELF := __PP9974580;
  END;
  EXPORT __ENH_Business_8 := PROJECT(__EE9974579,__ND9974584__Project(LEFT));
END;
