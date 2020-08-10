//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Business,B_Business_1,CFG_graph,E_Business FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT RQ_S_B_F_E___Future___Shell := MODULE
  SHARED __EE9642933 := B_Business().IDX_Business_UID_Wrapped;
  SHARED __ST9631681_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Sbfeinternalobservedperf06_;
    KEL.typ.nint Sbfeinternalobservedperf12_;
    KEL.typ.nint Sbfeinternalobservedperf18_;
    KEL.typ.nint Sbfeinternalobservedperf24_;
    KEL.typ.nint Sbfeinternalobservedperf36_;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE9642933,__ST9631681_Layout));
END;
