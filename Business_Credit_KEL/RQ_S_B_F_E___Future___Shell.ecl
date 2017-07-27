//HPCC Systems KEL Compiler Version 0.8.2
IMPORT KEL08a AS KEL;
IMPORT B_Business,B_Business_1,CFG_graph,E_Business FROM Business_Credit_KEL;
IMPORT * FROM KEL08a.Null;
EXPORT RQ_S_B_F_E___Future___Shell := MODULE
  SHARED __EE5607816 := B_Business().IDX_Business_UID_Wrapped;
  SHARED __ST85597_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Sbfeinternalobservedperf06_;
    KEL.typ.nint Sbfeinternalobservedperf12_;
    KEL.typ.nint Sbfeinternalobservedperf18_;
    KEL.typ.nint Sbfeinternalobservedperf24_;
    KEL.typ.nint Sbfeinternalobservedperf36_;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE5607816,__ST85597_Layout));
END;
