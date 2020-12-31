//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Industry_9,CFG_graph,E_Business,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Business_8(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(E_Business(__in,__cfg).__Result) __E_Business := E_Business(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_9(__in,__cfg).__ENH_Industry_9) __ENH_Industry_9 := B_Industry_9(__in,__cfg).__ENH_Industry_9;
  SHARED __EE285720 := __E_Business;
  SHARED __EE9802657 := __ENH_Industry_9;
  SHARED __EE9802666 := __EE9802657(__T(__AND(__EE9802657.Is_Valid_Code_,__EE9802657.Is_Primary_)));
  SHARED __EE285892 := __E_Business_Industry;
  SHARED __EE9802938 := __EE285892(__NN(__EE285892._bus_) AND __NN(__EE285892._industry_));
  SHARED __ST286245_Layout := RECORD
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
  __JC9802956(B_Industry_9(__in,__cfg).__ST252123_Layout __EE9802666, E_Business_Industry(__in,__cfg).Layout __EE9802938) := __EEQP(__EE9802938._industry_,__EE9802666.UID);
  __ST286245_Layout __JT9802956(B_Industry_9(__in,__cfg).__ST252123_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE9802957 := JOIN(__EE9802938,__EE9802666,__JC9802956(RIGHT,LEFT),__JT9802956(RIGHT,LEFT),INNER,HASH);
  SHARED __ST286041_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nbool Is_N_A_I_C_S_Code_;
    KEL.typ.nbool Is_S_I_C_Code_;
  END;
  SHARED __EE9802992 := PROJECT(__EE9802957,TRANSFORM(__ST286041_Layout,SELF.UID := LEFT._bus_,SELF := LEFT));
  SHARED __ST286065_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nbool Is_N_A_I_C_S_Code_;
    KEL.typ.nbool Is_S_I_C_Code_;
  END;
  SHARED __EE9803010 := PROJECT(__EE9802992,__ST286065_Layout);
  SHARED __ST286085_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Industry_ := 0;
    KEL.typ.int C_O_U_N_T___Industry__1_ := 0;
    KEL.typ.ntyp(E_Business().Typ) UID;
  END;
  SHARED __EE9803076 := PROJECT(__CLEANANDDO(__EE9803010,TABLE(__EE9803010,{KEL.typ.int C_O_U_N_T___Industry_ := COUNT(GROUP,__T(__EE9803010.Is_N_A_I_C_S_Code_)),KEL.typ.int C_O_U_N_T___Industry__1_ := COUNT(GROUP,__T(__EE9803010.Is_S_I_C_Code_)),UID},UID,MERGE)),__ST286085_Layout);
  SHARED __ST286297_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.int C_O_U_N_T___Industry_ := 0;
    KEL.typ.int C_O_U_N_T___Industry__1_ := 0;
    KEL.typ.ntyp(E_Business().Typ) U_I_D__1_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC9803082(E_Business(__in,__cfg).Layout __EE285720, __ST286085_Layout __EE9803076) := __EEQP(__EE285720.UID,__EE9803076.UID);
  __ST286297_Layout __JT9803082(E_Business(__in,__cfg).Layout __l, __ST286085_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE9803090 := JOIN(__EE285720,__EE9803076,__JC9803082(LEFT,RIGHT),__JT9803082(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST251691_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST251691_Layout __ND9803095__Project(__ST286297_Layout __PP9803091) := TRANSFORM
    SELF.Use_Primary_N_A_I_C_S_ := __PP9803091.C_O_U_N_T___Industry_ <> 0;
    SELF.Use_Primary_S_I_C_ := __PP9803091.C_O_U_N_T___Industry__1_ <> 0;
    SELF := __PP9803091;
  END;
  EXPORT __ENH_Business_8 := PROJECT(__EE9803090,__ND9803095__Project(LEFT));
END;
