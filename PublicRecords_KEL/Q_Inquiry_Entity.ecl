//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Inquiry_10,B_Inquiry_11,B_Inquiry_9,B_Person_Inquiry,B_Person_Inquiry_1,B_Person_Inquiry_2,B_Person_Inquiry_3,B_Person_Inquiry_4,B_Person_Inquiry_5,B_Person_Inquiry_6,B_Person_Inquiry_7,B_Person_Inquiry_8,CFG_Compile,E_Inquiry,E_Person,E_Person_Inquiry FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT Q_Inquiry_Entity(DATA57 __PPermitsValue, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED E_Inquiry_Filtered := MODULE(E_Inquiry(__in))
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PPermitsValue) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__ds);
  END;
  SHARED E_Person_Inquiry_Filtered := MODULE(E_Person_Inquiry(__in))
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PPermitsValue) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__ds);
  END;
  SHARED B_Inquiry_11_Local := MODULE(B_Inquiry_11(__in))
    SHARED TYPEOF(E_Inquiry().__Result) __E_Inquiry := E_Inquiry_Filtered.__Result;
  END;
  SHARED B_Inquiry_10_Local := MODULE(B_Inquiry_10(__in))
    SHARED TYPEOF(B_Inquiry_11().__ENH_Inquiry_11) __ENH_Inquiry_11 := B_Inquiry_11_Local.__ENH_Inquiry_11;
  END;
  SHARED B_Inquiry_9_Local := MODULE(B_Inquiry_9(__in))
    SHARED TYPEOF(B_Inquiry_10().__ENH_Inquiry_10) __ENH_Inquiry_10 := B_Inquiry_10_Local.__ENH_Inquiry_10;
  END;
  SHARED B_Person_Inquiry_8_Local := MODULE(B_Person_Inquiry_8(__in))
    SHARED TYPEOF(B_Inquiry_9().__ENH_Inquiry_9) __ENH_Inquiry_9 := B_Inquiry_9_Local.__ENH_Inquiry_9;
    SHARED TYPEOF(E_Person_Inquiry().__Result) __E_Person_Inquiry := E_Person_Inquiry_Filtered.__Result;
  END;
  SHARED B_Person_Inquiry_7_Local := MODULE(B_Person_Inquiry_7(__in))
    SHARED TYPEOF(B_Person_Inquiry_8().__ENH_Person_Inquiry_8) __ENH_Person_Inquiry_8 := B_Person_Inquiry_8_Local.__ENH_Person_Inquiry_8;
  END;
  SHARED B_Person_Inquiry_6_Local := MODULE(B_Person_Inquiry_6(__in))
    SHARED TYPEOF(B_Person_Inquiry_7().__ENH_Person_Inquiry_7) __ENH_Person_Inquiry_7 := B_Person_Inquiry_7_Local.__ENH_Person_Inquiry_7;
  END;
  SHARED B_Person_Inquiry_5_Local := MODULE(B_Person_Inquiry_5(__in))
    SHARED TYPEOF(B_Person_Inquiry_6().__ENH_Person_Inquiry_6) __ENH_Person_Inquiry_6 := B_Person_Inquiry_6_Local.__ENH_Person_Inquiry_6;
  END;
  SHARED B_Person_Inquiry_4_Local := MODULE(B_Person_Inquiry_4(__in))
    SHARED TYPEOF(B_Person_Inquiry_5().__ENH_Person_Inquiry_5) __ENH_Person_Inquiry_5 := B_Person_Inquiry_5_Local.__ENH_Person_Inquiry_5;
  END;
  SHARED B_Person_Inquiry_3_Local := MODULE(B_Person_Inquiry_3(__in))
    SHARED TYPEOF(B_Person_Inquiry_4().__ENH_Person_Inquiry_4) __ENH_Person_Inquiry_4 := B_Person_Inquiry_4_Local.__ENH_Person_Inquiry_4;
  END;
  SHARED B_Person_Inquiry_2_Local := MODULE(B_Person_Inquiry_2(__in))
    SHARED TYPEOF(B_Person_Inquiry_3().__ENH_Person_Inquiry_3) __ENH_Person_Inquiry_3 := B_Person_Inquiry_3_Local.__ENH_Person_Inquiry_3;
  END;
  SHARED B_Person_Inquiry_1_Local := MODULE(B_Person_Inquiry_1(__in))
    SHARED TYPEOF(B_Person_Inquiry_2().__ENH_Person_Inquiry_2) __ENH_Person_Inquiry_2 := B_Person_Inquiry_2_Local.__ENH_Person_Inquiry_2;
  END;
  SHARED B_Person_Inquiry_Local := MODULE(B_Person_Inquiry(__in))
    SHARED TYPEOF(B_Person_Inquiry_1().__ENH_Person_Inquiry_1) __ENH_Person_Inquiry_1 := B_Person_Inquiry_1_Local.__ENH_Person_Inquiry_1;
  END;
  SHARED TYPEOF(B_Person_Inquiry(__in).__ENH_Person_Inquiry) __ENH_Person_Inquiry := B_Person_Inquiry_Local.__ENH_Person_Inquiry;
  SHARED __EE12627888 := __ENH_Person_Inquiry;
  EXPORT Res0 := __UNWRAP(__EE12627888);
  EXPORT DBG_E_Inquiry_Result := __UNWRAP(E_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Person_Inquiry_Result := __UNWRAP(E_Person_Inquiry_Filtered.__Result);
  EXPORT DBG_E_Inquiry_Intermediate_11 := __UNWRAP(B_Inquiry_11_Local.__ENH_Inquiry_11);
  EXPORT DBG_E_Inquiry_Intermediate_10 := __UNWRAP(B_Inquiry_10_Local.__ENH_Inquiry_10);
  EXPORT DBG_E_Inquiry_Intermediate_9 := __UNWRAP(B_Inquiry_9_Local.__ENH_Inquiry_9);
  EXPORT DBG_E_Person_Inquiry_Intermediate_8 := __UNWRAP(B_Person_Inquiry_8_Local.__ENH_Person_Inquiry_8);
  EXPORT DBG_E_Person_Inquiry_Intermediate_7 := __UNWRAP(B_Person_Inquiry_7_Local.__ENH_Person_Inquiry_7);
  EXPORT DBG_E_Person_Inquiry_Intermediate_6 := __UNWRAP(B_Person_Inquiry_6_Local.__ENH_Person_Inquiry_6);
  EXPORT DBG_E_Person_Inquiry_Intermediate_5 := __UNWRAP(B_Person_Inquiry_5_Local.__ENH_Person_Inquiry_5);
  EXPORT DBG_E_Person_Inquiry_Intermediate_4 := __UNWRAP(B_Person_Inquiry_4_Local.__ENH_Person_Inquiry_4);
  EXPORT DBG_E_Person_Inquiry_Intermediate_3 := __UNWRAP(B_Person_Inquiry_3_Local.__ENH_Person_Inquiry_3);
  EXPORT DBG_E_Person_Inquiry_Intermediate_2 := __UNWRAP(B_Person_Inquiry_2_Local.__ENH_Person_Inquiry_2);
  EXPORT DBG_E_Person_Inquiry_Intermediate_1 := __UNWRAP(B_Person_Inquiry_1_Local.__ENH_Person_Inquiry_1);
  EXPORT DBG_E_Person_Inquiry_Annotated := __UNWRAP(B_Person_Inquiry_Local.__ENH_Person_Inquiry);
  EXPORT DBG_OutputAll := PARALLEL(
    OUTPUT(DBG_E_Inquiry_Result,NAMED('DBG_E_Inquiry_Result_Q_Inquiry_Entity')),
    OUTPUT(DBG_E_Person_Inquiry_Result,NAMED('DBG_E_Person_Inquiry_Result_Q_Inquiry_Entity')),
    OUTPUT(DBG_E_Inquiry_Intermediate_11,NAMED('DBG_E_Inquiry_Intermediate_11_Q_Inquiry_Entity')),
    OUTPUT(DBG_E_Inquiry_Intermediate_10,NAMED('DBG_E_Inquiry_Intermediate_10_Q_Inquiry_Entity')),
    OUTPUT(DBG_E_Inquiry_Intermediate_9,NAMED('DBG_E_Inquiry_Intermediate_9_Q_Inquiry_Entity')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_8,NAMED('DBG_E_Person_Inquiry_Intermediate_8_Q_Inquiry_Entity')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_7,NAMED('DBG_E_Person_Inquiry_Intermediate_7_Q_Inquiry_Entity')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_6,NAMED('DBG_E_Person_Inquiry_Intermediate_6_Q_Inquiry_Entity')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_5,NAMED('DBG_E_Person_Inquiry_Intermediate_5_Q_Inquiry_Entity')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_4,NAMED('DBG_E_Person_Inquiry_Intermediate_4_Q_Inquiry_Entity')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_3,NAMED('DBG_E_Person_Inquiry_Intermediate_3_Q_Inquiry_Entity')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_2,NAMED('DBG_E_Person_Inquiry_Intermediate_2_Q_Inquiry_Entity')),
    OUTPUT(DBG_E_Person_Inquiry_Intermediate_1,NAMED('DBG_E_Person_Inquiry_Intermediate_1_Q_Inquiry_Entity')),
    OUTPUT(DBG_E_Person_Inquiry_Annotated,NAMED('DBG_E_Person_Inquiry_Annotated_Q_Inquiry_Entity'))
  );
  EXPORT DBG_Res0 := WHEN(Res0,DBG_OutputAll);
END;
