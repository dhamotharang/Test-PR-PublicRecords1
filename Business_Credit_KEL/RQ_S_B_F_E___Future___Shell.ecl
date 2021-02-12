//HPCC Systems KEL Compiler Version 1.3.2
IMPORT KEL13 AS KEL;
IMPORT B_Business,B_Business_1,CFG_graph,E_Business FROM Business_Credit_KEL;
IMPORT * FROM KEL13.Null;
EXPORT RQ_S_B_F_E___Future___Shell := MODULE
  SHARED __EE9950798 := B_Business().IDX_Business_UID_Wrapped;
  SHARED __ST9939511_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Sbfeinternalobservedperf06_;
    KEL.typ.nint Sbfeinternalobservedperf12_;
    KEL.typ.nint Sbfeinternalobservedperf18_;
    KEL.typ.nint Sbfeinternalobservedperf24_;
    KEL.typ.nint Sbfeinternalobservedperf36_;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE9950798,__ST9939511_Layout));
END;
