//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Business_6,B_Industry_6,B_Industry_7,CFG_graph,E_Business,E_Business_Industry,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Industry_5(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Business_6(__in,__cfg).__ENH_Business_6) __ENH_Business_6 := B_Business_6(__in,__cfg).__ENH_Business_6;
  SHARED VIRTUAL TYPEOF(E_Business_Industry(__in,__cfg).__Result) __E_Business_Industry := E_Business_Industry(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Industry_6(__in,__cfg).__ENH_Industry_6) __ENH_Industry_6 := B_Industry_6(__in,__cfg).__ENH_Industry_6;
  SHARED __EE332378 := __ENH_Industry_6;
  SHARED __EE332488 := __ENH_Business_6;
  SHARED __EE332486 := __E_Business_Industry;
  SHARED __EE333320 := __EE332486(__NN(__EE332486._industry_) AND __NN(__EE332486._bus_));
  SHARED __ST332810_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC333338(B_Business_6(__in,__cfg).__ST238866_Layout __EE332488, E_Business_Industry(__in,__cfg).Layout __EE333320) := __EEQP(__EE333320._bus_,__EE332488.UID);
  __ST332810_Layout __JT333338(B_Business_6(__in,__cfg).__ST238866_Layout __l, E_Business_Industry(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE333339 := JOIN(__EE333320,__EE332488,__JC333338(RIGHT,LEFT),__JT333338(RIGHT,LEFT),INNER,HASH);
  SHARED __ST332554_Layout := RECORD
    KEL.typ.ntyp(E_Industry().Typ) UID;
    KEL.typ.ntyp(E_Business().Typ) _bus_;
    KEL.typ.ntyp(E_Industry().Typ) _industry_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
    KEL.typ.bool Use_Primary_N_A_I_C_S_ := FALSE;
    KEL.typ.bool Use_Primary_S_I_C_ := FALSE;
  END;
  SHARED __ST332554_Layout __ND333352__Project(__ST332810_Layout __PP333340) := TRANSFORM
    SELF.UID := __PP333340._industry_;
    SELF.U_I_D__1_ := __PP333340.UID;
    SELF := __PP333340;
  END;
  SHARED __EE333385 := PROJECT(__EE333339,__ND333352__Project(LEFT));
  SHARED __ST332587_Layout := RECORD
    KEL.typ.ntyp(E_Industry().Typ) UID;
    KEL.typ.nint Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint Highest_Frequency_S_I_C_;
  END;
  SHARED __EE333403 := PROJECT(__EE333385,__ST332587_Layout);
  SHARED __ST332607_Layout := RECORD
    KEL.typ.nint M_A_X___Highest_Frequency_N_A_I_C_S_;
    KEL.typ.nint M_A_X___Highest_Frequency_S_I_C_;
    KEL.typ.ntyp(E_Industry().Typ) UID;
  END;
  SHARED __EE333424 := PROJECT(__CLEANANDDO(__EE333403,TABLE(__EE333403,{KEL.Aggregates.MaxNG(__EE333403.Highest_Frequency_N_A_I_C_S_) M_A_X___Highest_Frequency_N_A_I_C_S_,KEL.Aggregates.MaxNG(__EE333403.Highest_Frequency_S_I_C_) M_A_X___Highest_Frequency_S_I_C_,UID},UID,MERGE)),__ST332607_Layout);
  SHARED __ST332867_Layout := RECORD
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
  __JC333430(B_Industry_7(__in,__cfg).__ST239534_Layout __EE332378, __ST332607_Layout __EE333424) := __EEQP(__EE332378.UID,__EE333424.UID);
  __ST332867_Layout __JT333430(B_Industry_7(__in,__cfg).__ST239534_Layout __l, __ST332607_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE333431 := JOIN(__EE332378,__EE333424,__JC333430(LEFT,RIGHT),__JT333430(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST238159_Layout := RECORD
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
  SHARED __ST238159_Layout __ND333557__Project(__ST332867_Layout __PP333432) := TRANSFORM
    SELF.Is_Highest_Frequency_N_A_I_C_S_ := __AND(__PP333432.Is_Good_N_A_I_C_S_,__OP2(__CN(__PP333432.Frequency_Count_N_A_I_C_S_),=,__PP333432.M_A_X___Highest_Frequency_N_A_I_C_S_));
    SELF.Is_Highest_Frequency_S_I_C_ := __AND(__PP333432.Is_Good_S_I_C_,__OP2(__CN(__PP333432.Frequency_Count_S_I_C_),=,__PP333432.M_A_X___Highest_Frequency_S_I_C_));
    SELF := __PP333432;
  END;
  EXPORT __ENH_Industry_5 := PROJECT(__EE333431,__ND333557__Project(LEFT));
END;
