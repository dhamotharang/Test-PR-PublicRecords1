﻿//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Business,B_Business_1,CFG_graph FROM Business_Credit_KEL;
IMPORT * FROM KEL12.Null;
EXPORT Q_S_B_F_E___Future___Shell(CFG_graph.FDCDataset __in = CFG_graph.FDCDefault, CFG_graph __cfg = CFG_graph) := MODULE
  SHARED TYPEOF(B_Business(__in,__cfg).__ENH_Business) __ENH_Business := B_Business(__in,__cfg).__ENH_Business;
  SHARED __EE10614301 := __ENH_Business;
  SHARED __ST80501_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint Sbfeinternalobservedperf06_;
    KEL.typ.nint Sbfeinternalobservedperf12_;
    KEL.typ.nint Sbfeinternalobservedperf18_;
    KEL.typ.nint Sbfeinternalobservedperf24_;
    KEL.typ.nint Sbfeinternalobservedperf36_;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE10614301,__ST80501_Layout));
END;
