//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Industry_9,CFG_graph,E_Business,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Business_8(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(E_Business(__in,__cfg).__Result) __E_Business := E_Business(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_9(__in,__cfg).__ENH_Industry_9) __ENH_Industry_9 := B_Industry_9(__in,__cfg).__ENH_Industry_9;
  SHARED __EE290719 := __E_Business;
  SHARED __EE290893 := __ENH_Industry_9;
  SHARED __EE291136 := __EE290893(__T(__AND(__EE290893.Is_Valid_Code_,__EE290893.Is_Primary_)));
  SHARED __EE290891 := __E_Business_Industry;
  SHARED __EE291531 := __EE290891(__NN(__EE290891._bus_) AND __NN(__EE290891._industry_));
  SHARED __ST291244_Layout := RECORD
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
  __JC291549(B_Industry_9(__in,__cfg).__ST252084_Layout __EE291136, E_Business_Industry(__in,__cfg).Layout __EE291531) := __EEQP(__EE291531._industry_,__EE291136.UID);
  __ST291244_Layout __JT291549(B_Industry_9(__in,__cfg).__ST252084_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE291550 := JOIN(__EE291531,__EE291136,__JC291549(RIGHT,LEFT),__JT291549(RIGHT,LEFT),INNER,HASH);
  SHARED __ST291040_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nbool Is_N_A_I_C_S_Code_;
    KEL.typ.nbool Is_S_I_C_Code_;
  END;
  SHARED __EE291585 := PROJECT(__EE291550,TRANSFORM(__ST291040_Layout,SELF.UID := LEFT._bus_,SELF := LEFT));
  SHARED __ST291064_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nbool Is_N_A_I_C_S_Code_;
    KEL.typ.nbool Is_S_I_C_Code_;
  END;
  SHARED __EE291603 := PROJECT(__EE291585,__ST291064_Layout);
  SHARED __ST291084_Layout := RECORD
    KEL.typ.int C_O_U_N_T___Industry_ := 0;
    KEL.typ.int C_O_U_N_T___Industry__1_ := 0;
    KEL.typ.ntyp(E_Business().Typ) UID;
  END;
  SHARED __EE291669 := PROJECT(__CLEANANDDO(__EE291603,TABLE(__EE291603,{KEL.typ.int C_O_U_N_T___Industry_ := COUNT(GROUP,__T(__EE291603.Is_N_A_I_C_S_Code_)),KEL.typ.int C_O_U_N_T___Industry__1_ := COUNT(GROUP,__T(__EE291603.Is_S_I_C_Code_)),UID},UID,MERGE)),__ST291084_Layout);
  SHARED __ST291296_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.int C_O_U_N_T___Industry_ := 0;
    KEL.typ.int C_O_U_N_T___Industry__1_ := 0;
    KEL.typ.ntyp(E_Business().Typ) U_I_D__1_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC291675(E_Business(__in,__cfg).Layout __EE290719, __ST291084_Layout __EE291669) := __EEQP(__EE290719.UID,__EE291669.UID);
  __ST291296_Layout __JT291675(E_Business(__in,__cfg).Layout __l, __ST291084_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE291683 := JOIN(__EE290719,__EE291669,__JC291675(LEFT,RIGHT),__JT291675(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST251652_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST251652_Layout __ND291688__Project(__ST291296_Layout __PP291684) := TRANSFORM
    SELF.Use_Primary_N_A_I_C_S_ := __PP291684.C_O_U_N_T___Industry_ <> 0;
    SELF.Use_Primary_S_I_C_ := __PP291684.C_O_U_N_T___Industry__1_ <> 0;
    SELF := __PP291684;
  END;
  EXPORT __ENH_Business_8 := PROJECT(__EE291683,__ND291688__Project(LEFT));
END;
