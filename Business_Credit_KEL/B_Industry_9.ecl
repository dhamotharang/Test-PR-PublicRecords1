//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Industry_10,CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Industry_9(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED VIRTUAL TYPEOF(B_Industry_10(__in,__cfg).__ENH_Industry_10) __ENH_Industry_10 := B_Industry_10(__in,__cfg).__ENH_Industry_10;
  SHARED __EE9798102 := __ENH_Industry_10;
  EXPORT __ST252123_Layout := RECORD
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
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST252123_Layout __ND9798185__Project(B_Industry_10(__in,__cfg).__ST252386_Layout __PP9798103) := TRANSFORM
    SELF.Is_Primary_ := __OP2(__PP9798103._primary__industry__code__indicator_,=,__CN('Y'));
    SELF.Is_Valid_Code_ := MAP(__T(__PP9798103.Is_S_I_C_Code_)=>__ECAST(KEL.typ.nbool,__AND(__OP2(__PP9798103._classification__code_,>,__CN(0)),__OP2(__PP9798103._classification__code_,<,__CN(10000)))),__T(__PP9798103.Is_N_A_I_C_S_Code_)=>__ECAST(KEL.typ.nbool,__AND(__OP2(__PP9798103._classification__code_,>,__CN(0)),__OP2(__PP9798103._classification__code_,<,__CN(1000000)))),__ECAST(KEL.typ.nbool,__CN(FALSE)));
    SELF := __PP9798103;
  END;
  EXPORT __ENH_Industry_9 := PROJECT(__EE9798102,__ND9798185__Project(LEFT));
END;
