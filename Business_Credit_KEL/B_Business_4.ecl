//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Business_5,B_Business_6,B_Industry_5,CFG_graph,E_Account,E_Business,E_Business_Account,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Business_4(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_5(__in,__cfg).__ENH_Business_5) __ENH_Business_5 := B_Business_5(__in,__cfg).__ENH_Business_5;
  SHARED VIRTUAL TYPEOF(E_Business_Account(__in,__cfg).__Result) __E_Business_Account := E_Business_Account(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_5(__in,__cfg).__ENH_Industry_5) __ENH_Industry_5 := B_Industry_5(__in,__cfg).__ENH_Industry_5;
  SHARED __EE379020 := __ENH_Business_5;
  SHARED __EE379231 := __ENH_Industry_5;
  SHARED __EE379229 := __E_Business_Industry;
  SHARED __EE380536 := __EE379229(__NN(__EE379229._bus_) AND __NN(__EE379229._industry_));
  SHARED __ST379917_Layout := RECORD
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
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC380554(B_Industry_5(__in,__cfg).__ST238159_Layout __EE379231, E_Business_Industry(__in,__cfg).Layout __EE380536) := __EEQP(__EE380536._industry_,__EE379231.UID);
  __ST379917_Layout __JT380554(B_Industry_5(__in,__cfg).__ST238159_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE380555 := JOIN(__EE380536,__EE379231,__JC380554(RIGHT,LEFT),__JT380554(RIGHT,LEFT),INNER,HASH);
  SHARED __ST379599_Layout := RECORD
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
    KEL.typ.nbool Is_Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nbool Is_Highest_Frequency_S_I_C_;
    KEL.typ.nbool Is_N_A_I_C_S_Code_;
    KEL.typ.nbool Is_Primary_;
    KEL.typ.nbool Is_S_I_C_Code_;
    KEL.typ.nbool Is_Valid_Code_;
  END;
  SHARED __ST379599_Layout __ND380583__Project(__ST379917_Layout __PP380556) := TRANSFORM
    SELF.UID := __PP380556._bus_;
    SELF.U_I_D__1_ := __PP380556.UID;
    SELF := __PP380556;
  END;
  SHARED __EE380676 := PROJECT(__EE380555,__ND380583__Project(LEFT));
  SHARED __ST379664_Layout := RECORD
    KEL.typ.ntyp(E_Business().Typ) UID;
    KEL.typ.nkdate Exp1_;
    KEL.typ.nkdate Exp2_;
  END;
  SHARED __ST379664_Layout __ND380681__Project(__ST379599_Layout __PP380677) := TRANSFORM
    SELF.Exp1_ := IF(__T(__PP380677.Is_Highest_Frequency_N_A_I_C_S_),__ECAST(KEL.typ.nkdate,__PP380677._dt__last__seen_),__ECAST(KEL.typ.nkdate,__N(KEL.typ.kdate)));
    SELF.Exp2_ := IF(__T(__PP380677.Is_Highest_Frequency_S_I_C_),__ECAST(KEL.typ.nkdate,__PP380677._dt__last__seen_),__ECAST(KEL.typ.nkdate,__N(KEL.typ.kdate)));
    SELF := __PP380677;
  END;
  SHARED __EE380700 := PROJECT(__EE380676,__ND380681__Project(LEFT));
  SHARED __ST379684_Layout := RECORD
    KEL.typ.nkdate M_A_X__dt__last__seen_;
    KEL.typ.nkdate M_A_X__dt__last__seen__1_;
    KEL.typ.ntyp(E_Business().Typ) UID;
  END;
  SHARED __EE380721 := PROJECT(__CLEANANDDO(__EE380700,TABLE(__EE380700,{KEL.Aggregates.MaxNG(__EE380700.Exp1_) M_A_X__dt__last__seen_,KEL.Aggregates.MaxNG(__EE380700.Exp2_) M_A_X__dt__last__seen__1_,UID},UID,MERGE)),__ST379684_Layout);
  SHARED __ST380049_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.nkdate M_A_X__dt__last__seen_;
    KEL.typ.nkdate M_A_X__dt__last__seen__1_;
    KEL.typ.ntyp(E_Business().Typ) U_I_D__1_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC380727(B_Business_6(__in,__cfg).__ST238866_Layout __EE379020, __ST379684_Layout __EE380721) := __EEQP(__EE379020.UID,__EE380721.UID);
  __ST380049_Layout __JT380727(B_Business_6(__in,__cfg).__ST238866_Layout __l, __ST379684_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE380728 := JOIN(__EE379020,__EE380721,__JC380727(LEFT,RIGHT),__JT380727(LEFT,RIGHT),LEFT OUTER,HASH);
  SHARED __ST380121_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.nkdate M_A_X__dt__last__seen_;
    KEL.typ.nkdate M_A_X__dt__last__seen__1_;
    KEL.typ.ntyp(E_Business().Typ) U_I_D__1_;
    KEL.typ.bool Business_Account_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE378455 := __E_Business_Account;
  SHARED __EE380757 := __EE378455(__NN(__EE378455._acc_) AND __NN(__EE378455._bus_));
  __JC380777(__ST380049_Layout __EE380728, E_Business_Account(__in,__cfg).Layout __EE380757) := __EEQP(__EE380728.UID,__EE380757._bus_);
  __JF380777(E_Business_Account(__in,__cfg).Layout __EE380757) := __NN(__EE380757._bus_);
  SHARED __EE380778 := JOIN(__EE380728,__EE380757,__JC380777(LEFT,RIGHT),TRANSFORM(__ST380121_Layout,SELF:=LEFT,SELF.Business_Account_:=__JF380777(RIGHT)),HASH,LEFT OUTER,KEEP(1));
  EXPORT __ST236766_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.bool Business_Not_On_File_ := FALSE;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.nkdate Most_Recent_N_A_I_C_S_Date_;
    KEL.typ.nkdate Most_Recent_S_I_C_Date_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST236766_Layout __ND380793__Project(__ST380121_Layout __PP380779) := TRANSFORM
    SELF.Business_Not_On_File_ := NOT (__PP380779.Business_Account_);
    SELF.Most_Recent_N_A_I_C_S_Date_ := __PP380779.M_A_X__dt__last__seen_;
    SELF.Most_Recent_S_I_C_Date_ := __PP380779.M_A_X__dt__last__seen__1_;
    SELF := __PP380779;
  END;
  EXPORT __ENH_Business_4 := PROJECT(__EE380778,__ND380793__Project(LEFT));
END;
