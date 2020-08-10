//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Industry_9,CFG_graph,E_Business,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Business_8(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(E_Business(__in,__cfg).__Result) __E_Business := E_Business(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_9(__in,__cfg).__ENH_Industry_9) __ENH_Industry_9 := B_Industry_9(__in,__cfg).__ENH_Industry_9;
  SHARED __EE274056 := __E_Business;
  SHARED __EE274230 := __ENH_Industry_9;
  SHARED __EE274473 := __EE274230(__T(__AND(__EE274230.Is_Valid_Code_,__EE274230.Is_Primary_)));
  SHARED __EE274228 := __E_Business_Industry;
  SHARED __EE274868 := __EE274228(__NN(__EE274228._bus_) AND __NN(__EE274228._industry_));
  SHARED __ST274581_Layout := RECORD
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
  __JC274886(B_Industry_9(__in,__cfg).__ST240352_Layout __EE274473, E_Business_Industry(__in,__cfg).Layout __EE274868) := __EEQP(__EE274868._industry_,__EE274473.UID);
  __ST274581_Layout __JT274886(B_Industry_9(__in,__cfg).__ST240352_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE274887 := JOIN(__EE274868,__EE274473,__JC274886(RIGHT,LEFT),__JT274886(RIGHT,LEFT),INNER,HASH);
  SHARED __ST274377_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nbool Is_N_A_I_C_S_Code_;
    KEL.typ.nbool Is_S_I_C_Code_;
  END;
  SHARED __EE274922 := PROJECT(__EE274887,TRANSFORM(__ST274377_Layout,SELF.UID := LEFT._bus_,SELF := LEFT));
  SHARED __ST274401_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nbool Is_N_A_I_C_S_Code_;
    KEL.typ.nbool Is_S_I_C_Code_;
  END;
  SHARED __EE274940 := PROJECT(__EE274922,__ST274401_Layout);
  SHARED __ST274421_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Industry_ := 0;
    KEL.typ.int C_O_U_N_T___Industry__1_ := 0;
    KEL.typ.ntyp(E_Business().Typ) UID;
  END;
  SHARED __EE275006 := PROJECT(__CLEANANDDO(__EE274940,TABLE(__EE274940,{KEL.typ.int C_O_U_N_T___Industry_ := COUNT(GROUP,__T(__EE274940.Is_N_A_I_C_S_Code_)),KEL.typ.int C_O_U_N_T___Industry__1_ := COUNT(GROUP,__T(__EE274940.Is_S_I_C_Code_)),UID},UID,MERGE)),__ST274421_Layout);
  SHARED __ST274633_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.int C_O_U_N_T___Industry_ := 0;
    KEL.typ.int C_O_U_N_T___Industry__1_ := 0;
    KEL.typ.ntyp(E_Business().Typ) U_I_D__1_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC275012(E_Business(__in,__cfg).Layout __EE274056, __ST274421_Layout __EE275006) := __EEQP(__EE274056.UID,__EE275006.UID);
  __ST274633_Layout __JT275012(E_Business(__in,__cfg).Layout __l, __ST274421_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE275020 := JOIN(__EE274056,__EE275006,__JC275012(LEFT,RIGHT),__JT275012(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST239924_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST239924_Layout __ND275025__Project(__ST274633_Layout __PP275021) := TRANSFORM
    SELF.Use_Primary_N_A_I_C_S_ := __PP275021.C_O_U_N_T___Industry_ <> 0;
    SELF.Use_Primary_S_I_C_ := __PP275021.C_O_U_N_T___Industry__1_ <> 0;
    SELF := __PP275021;
  END;
  EXPORT __ENH_Business_8 := PROJECT(__EE275020,__ND275025__Project(LEFT));
END;
