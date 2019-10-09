//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Business_Sele,B_Business_Sele_1,B_Business_Sele_2,B_Business_Sele_3,B_Business_Sele_4,B_Business_Sele_5,B_Business_Sele_6,B_Sele_Tradeline_1,B_Sele_Tradeline_2,B_Sele_Tradeline_3,B_Tradeline_1,B_Tradeline_10,B_Tradeline_11,B_Tradeline_2,B_Tradeline_3,B_Tradeline_4,B_Tradeline_5,B_Tradeline_6,B_Tradeline_7,B_Tradeline_8,B_Tradeline_9,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_Tradeline,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT Q_Non_F_C_R_A_Business_Sele_I_D_No_Dates_Attributes_V1(KEL.typ.int __PUltID_in, KEL.typ.int __POrgID_in, KEL.typ.int __PSeleID_in, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED E_Business_Sele_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Sele(__in,__cfg))
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.Ult_I_D_,=,__CN(__PUltID_in))))) AND EXISTS(__g(__T(__OP2(__g.Org_I_D_,=,__CN(__POrgID_in))))) AND EXISTS(__g(__T(__OP2(__g.Sele_I_D_,=,__CN(__PSeleID_in)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__ds);
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Sele_Tradeline_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Tradeline(__in,__cfg))
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__ds);
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Company_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Tradeline_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Tradeline(__in,__cfg))
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__ds);
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Sele_Tradeline_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Account_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Business_Sele_Filtered := E_Business_Sele_Filtered_2;
  SHARED E_Sele_Tradeline_Filtered := E_Sele_Tradeline_Filtered_1;
  SHARED B_Tradeline_11_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_11(__in,__cfg))
    SHARED TYPEOF(E_Tradeline(__in,__cfg).__Result) __E_Tradeline := E_Tradeline_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_10_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_10(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_11(__in,__cfg).__ENH_Tradeline_11) __ENH_Tradeline_11 := B_Tradeline_11_Local(__in,__cfg).__ENH_Tradeline_11;
  END;
  SHARED B_Tradeline_9_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_9(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_10(__in,__cfg).__ENH_Tradeline_10) __ENH_Tradeline_10 := B_Tradeline_10_Local(__in,__cfg).__ENH_Tradeline_10;
  END;
  SHARED B_Tradeline_8_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_8(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_9(__in,__cfg).__ENH_Tradeline_9) __ENH_Tradeline_9 := B_Tradeline_9_Local(__in,__cfg).__ENH_Tradeline_9;
  END;
  SHARED B_Tradeline_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_7(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_8(__in,__cfg).__ENH_Tradeline_8) __ENH_Tradeline_8 := B_Tradeline_8_Local(__in,__cfg).__ENH_Tradeline_8;
  END;
  SHARED B_Business_Sele_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_6(__in,__cfg))
    SHARED TYPEOF(E_Business_Sele(__in,__cfg).__Result) __E_Business_Sele := E_Business_Sele_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Tradeline_7(__in,__cfg).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local(__in,__cfg).__ENH_Tradeline_7;
  END;
  SHARED B_Tradeline_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_6(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_7(__in,__cfg).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local(__in,__cfg).__ENH_Tradeline_7;
  END;
  SHARED B_Business_Sele_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_5(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_6(__in,__cfg).__ENH_Business_Sele_6) __ENH_Business_Sele_6 := B_Business_Sele_6_Local(__in,__cfg).__ENH_Business_Sele_6;
  END;
  SHARED B_Tradeline_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_5(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6) __ENH_Tradeline_6 := B_Tradeline_6_Local(__in,__cfg).__ENH_Tradeline_6;
  END;
  SHARED B_Business_Sele_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_4(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_5(__in,__cfg).__ENH_Business_Sele_5) __ENH_Business_Sele_5 := B_Business_Sele_5_Local(__in,__cfg).__ENH_Business_Sele_5;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local(__in,__cfg).__ENH_Tradeline_5;
  END;
  SHARED B_Tradeline_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_4(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local(__in,__cfg).__ENH_Tradeline_5;
  END;
  SHARED B_Business_Sele_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_3(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_4(__in,__cfg).__ENH_Business_Sele_4) __ENH_Business_Sele_4 := B_Business_Sele_4_Local(__in,__cfg).__ENH_Business_Sele_4;
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
  END;
  SHARED B_Sele_Tradeline_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Tradeline_3(__in,__cfg))
    SHARED TYPEOF(E_Sele_Tradeline(__in,__cfg).__Result) __E_Sele_Tradeline := E_Sele_Tradeline_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
  END;
  SHARED B_Tradeline_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_3(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
  END;
  SHARED B_Business_Sele_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_2(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_3(__in,__cfg).__ENH_Business_Sele_3) __ENH_Business_Sele_3 := B_Business_Sele_3_Local(__in,__cfg).__ENH_Business_Sele_3;
    SHARED TYPEOF(B_Sele_Tradeline_3(__in,__cfg).__ENH_Sele_Tradeline_3) __ENH_Sele_Tradeline_3 := B_Sele_Tradeline_3_Local(__in,__cfg).__ENH_Sele_Tradeline_3;
    SHARED TYPEOF(B_Tradeline_3(__in,__cfg).__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local(__in,__cfg).__ENH_Tradeline_3;
  END;
  SHARED B_Sele_Tradeline_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Tradeline_2(__in,__cfg))
    SHARED TYPEOF(B_Sele_Tradeline_3(__in,__cfg).__ENH_Sele_Tradeline_3) __ENH_Sele_Tradeline_3 := B_Sele_Tradeline_3_Local(__in,__cfg).__ENH_Sele_Tradeline_3;
  END;
  SHARED B_Tradeline_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_2(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_3(__in,__cfg).__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local(__in,__cfg).__ENH_Tradeline_3;
  END;
  SHARED B_Business_Sele_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele_1(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_2(__in,__cfg).__ENH_Business_Sele_2) __ENH_Business_Sele_2 := B_Business_Sele_2_Local(__in,__cfg).__ENH_Business_Sele_2;
    SHARED TYPEOF(B_Sele_Tradeline_2(__in,__cfg).__ENH_Sele_Tradeline_2) __ENH_Sele_Tradeline_2 := B_Sele_Tradeline_2_Local(__in,__cfg).__ENH_Sele_Tradeline_2;
    SHARED TYPEOF(B_Tradeline_2(__in,__cfg).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local(__in,__cfg).__ENH_Tradeline_2;
  END;
  SHARED B_Sele_Tradeline_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Sele_Tradeline_1(__in,__cfg))
    SHARED TYPEOF(B_Sele_Tradeline_2(__in,__cfg).__ENH_Sele_Tradeline_2) __ENH_Sele_Tradeline_2 := B_Sele_Tradeline_2_Local(__in,__cfg).__ENH_Sele_Tradeline_2;
  END;
  SHARED B_Tradeline_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_1(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_2(__in,__cfg).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local(__in,__cfg).__ENH_Tradeline_2;
  END;
  SHARED B_Business_Sele_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Sele(__in,__cfg))
    SHARED TYPEOF(B_Business_Sele_1(__in,__cfg).__ENH_Business_Sele_1) __ENH_Business_Sele_1 := B_Business_Sele_1_Local(__in,__cfg).__ENH_Business_Sele_1;
    SHARED TYPEOF(B_Sele_Tradeline_1(__in,__cfg).__ENH_Sele_Tradeline_1) __ENH_Sele_Tradeline_1 := B_Sele_Tradeline_1_Local(__in,__cfg).__ENH_Sele_Tradeline_1;
    SHARED TYPEOF(B_Tradeline_1(__in,__cfg).__ENH_Tradeline_1) __ENH_Tradeline_1 := B_Tradeline_1_Local(__in,__cfg).__ENH_Tradeline_1;
  END;
  SHARED TYPEOF(B_Business_Sele(__in).__ENH_Business_Sele) __ENH_Business_Sele := B_Business_Sele_Local(__in).__ENH_Business_Sele;
  SHARED __EE1455431 := __ENH_Business_Sele;
  SHARED __EE1455528 := __EE1455431(__T(__AND(__OP2(__EE1455431.Ult_I_D_,=,__CN(__PUltID_in)),__AND(__OP2(__EE1455431.Org_I_D_,=,__CN(__POrgID_in)),__OP2(__EE1455431.Sele_I_D_,=,__CN(__PSeleID_in))))));
  SHARED __ST41312_Layout := RECORD
    KEL.typ.nint B___Lex_I_D_Ult_;
    KEL.typ.nint B___Lex_I_D_Org_;
    KEL.typ.nint B___Lex_I_D_Legal_;
    KEL.typ.str B___Lex_I_D_Legal_Rstd_Only_Flag_ := '';
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST41312_Layout __ND1455533__Project(B_Business_Sele(__in).__ST51538_Layout __PP1455529) := TRANSFORM
    SELF.B___Lex_I_D_Ult_ := __PP1455529.Ult_I_D_;
    SELF.B___Lex_I_D_Org_ := __PP1455529.Org_I_D_;
    SELF.B___Lex_I_D_Legal_ := __PP1455529.Sele_I_D_;
    SELF := __PP1455529;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(TABLE(PROJECT(__EE1455528,__ND1455533__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),B___Lex_I_D_Ult_,B___Lex_I_D_Org_,B___Lex_I_D_Legal_,B___Lex_I_D_Legal_Rstd_Only_Flag_},B___Lex_I_D_Ult_,B___Lex_I_D_Org_,B___Lex_I_D_Legal_,B___Lex_I_D_Legal_Rstd_Only_Flag_,MERGE),__ST41312_Layout));
END;
