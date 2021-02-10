//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT CFG_graph,E_Industry FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Industry_10(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(E_Industry(__in,__cfg).__Result) __E_Industry := E_Industry(__in,__cfg).__Result;
  SHARED __EE276261 := __E_Industry;
  EXPORT __ST253028_Layout := RECORD
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
    KEL.typ.nbool Is_S_I_C_Code_;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST253028_Layout __ND9965827__Project(E_Industry(__in,__cfg).Layout __PP276191) := TRANSFORM
    SELF.Is_N_A_I_C_S_Code_ := __OP2(__PP276191._classification__code__type_,=,__CN(2));
    SELF.Is_S_I_C_Code_ := __OP2(__PP276191._classification__code__type_,=,__CN(1));
    SELF := __PP276191;
  END;
  EXPORT __ENH_Industry_10 := PROJECT(__EE276261,__ND9965827__Project(LEFT));
END;
