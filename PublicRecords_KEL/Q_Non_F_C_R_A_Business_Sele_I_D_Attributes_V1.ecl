//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Business_Sele,B_Business_Sele_1,B_Business_Sele_2,B_Business_Sele_3,B_Business_Sele_4,B_Business_Sele_5,B_Business_Sele_6,B_Sele_Tradeline_1,B_Sele_Tradeline_2,B_Sele_Tradeline_3,B_Tradeline_1,B_Tradeline_10,B_Tradeline_11,B_Tradeline_2,B_Tradeline_3,B_Tradeline_4,B_Tradeline_5,B_Tradeline_6,B_Tradeline_7,B_Tradeline_8,B_Tradeline_9,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_Tradeline,E_Tradeline FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1(KEL.typ.int __PUltID_in, KEL.typ.int __POrgID_in, KEL.typ.int __PSeleID_in, KEL.typ.kdate __PP_InpClnArchDt, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Business_Sele_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Sele(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.Ult_I_D_,=,__CN(__PUltID_in))))) AND EXISTS(__g(__T(__OP2(__g.Org_I_D_,=,__CN(__POrgID_in))))) AND EXISTS(__g(__T(__OP2(__g.Sele_I_D_,=,__CN(__PSeleID_in)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Sele_Tradeline_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Sele_Tradeline(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Sele_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Company_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Tradeline_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Tradeline(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
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
  SHARED TYPEOF(B_Business_Sele(__in,__cfg_Local).__ENH_Business_Sele) __ENH_Business_Sele := B_Business_Sele_Local(__in,__cfg_Local).__ENH_Business_Sele;
  SHARED __EE1447000 := __ENH_Business_Sele;
  SHARED __EE1449583 := __EE1447000(__T(__AND(__OP2(__EE1447000.Ult_I_D_,=,__CN(__PUltID_in)),__AND(__OP2(__EE1447000.Org_I_D_,=,__CN(__POrgID_in)),__OP2(__EE1447000.Sele_I_D_,=,__CN(__PSeleID_in))))));
  SHARED __ST41093_Layout := RECORD
    KEL.typ.nint B___Lex_I_D_Ult_;
    KEL.typ.nint B___Lex_I_D_Org_;
    KEL.typ.nint B___Lex_I_D_Legal_;
    KEL.typ.str B___Lex_I_D_Legal_Seen_Flag_ := '';
    KEL.typ.ndataset(B_Business_Sele(__in,__cfg_Local).__ST35944_Layout) B_E___Ver_Src_List_;
    KEL.typ.nint B_E___B2_B_Cnt_Ev_;
    KEL.typ.int B_E___B2_B_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Carr_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Flt_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Mat_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Ops_Cnt2_Y_ := 0;
    KEL.typ.int B_E___B2_B_Oth_Cnt2_Y_ := 0;
    KEL.typ.float B_E___B2_B_Carr_Pct2_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Flt_Pct2_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Mat_Pct2_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Ops_Pct2_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Oth_Pct2_Y_ := 0.0;
    KEL.typ.nstr B_E___B2_B_Old_Dt_Ev_;
    KEL.typ.nint B_E___B2_B_Old_Msnc_Ev_;
    KEL.typ.nstr B_E___B2_B_Old_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_New_Dt2_Y_;
    KEL.typ.nint B_E___B2_B_Old_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_New_Msnc2_Y_;
    KEL.typ.int B_E___B2_B_Actv_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Cnt_ := 0;
    KEL.typ.float B_E___B2_B_Actv_Carr_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Flt_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Mat_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Ops_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Oth_Pct_ := 0.0;
    KEL.typ.int B_E___B2_B_Actv_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Cnt_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Cnt_A1_Y_ := 0;
    KEL.typ.float B_E___B2_B_Actv_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Carr_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Flt_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Mat_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Ops_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv_Oth_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.int B_E___B2_B_Actv_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Bal_Tot_ := 0;
    KEL.typ.nfloat B_E___B2_B_Actv_Carr_Bal_Tot_Pct_;
    KEL.typ.nfloat B_E___B2_B_Actv_Flt_Bal_Pct_;
    KEL.typ.nfloat B_E___B2_B_Actv_Mat_Bal_Pct_;
    KEL.typ.nfloat B_E___B2_B_Actv_Ops_Bal_Pct_;
    KEL.typ.nfloat B_E___B2_B_Actv_Oth_Bal_Pct_;
    KEL.typ.nstr B_E___B2_B_Actv_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Carr_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Flt_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Mat_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Ops_Bal_Tot_Rnge_;
    KEL.typ.nstr B_E___B2_B_Actv_Oth_Bal_Tot_Rnge_;
    KEL.typ.int B_E___B2_B_Actv_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Bal_Avg_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Carr_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Flt_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Mat_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Ops_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv_Oth_Bal_Tot_A1_Y_ := 0;
    KEL.typ.nfloat B_E___B2_B_Actv_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Carr_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Flt_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Mat_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Ops_Bal_Tot_Grow1_Y_;
    KEL.typ.nfloat B_E___B2_B_Actv_Oth_Bal_Tot_Grow1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Carr_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Flt_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Mat_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Ops_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Oth_Bal_Tot_Grow_Indx1_Y_;
    KEL.typ.nint B_E___B2_B_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Carr_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Flt_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Mat_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Ops_Bal_Max2_Y_;
    KEL.typ.nint B_E___B2_B_Oth_Bal_Max2_Y_;
    KEL.typ.nstr B_E___B2_B_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Carr_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Flt_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Mat_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Ops_Bal_Max_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Oth_Bal_Max_Dt2_Y_;
    KEL.typ.nint B_E___B2_B_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Carr_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Flt_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Mat_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Ops_Bal_Max_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Oth_Bal_Max_Msnc2_Y_;
    KEL.typ.nstr B_E___B2_B_Bal_Max_Seg_Type2_Y_;
    KEL.typ.nstr B_E___B2_B_Actv_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Carr_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Flt_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Mat_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Ops_Worst_Perf_Indx_;
    KEL.typ.nstr B_E___B2_B_Actv_Oth_Worst_Perf_Indx_;
    KEL.typ.int B_E___B2_B_Actv1p_Dpd_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv31p_Dpd_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv61p_Dpd_Cnt_ := 0;
    KEL.typ.int B_E___B2_B_Actv91p_Dpd_Cnt_ := 0;
    KEL.typ.float B_E___B2_B_Actv1p_Dpd_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv31p_Dpd_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv61p_Dpd_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv91p_Dpd_Pct_ := 0.0;
    KEL.typ.int B_E___B2_B_Actv1p_Dpd_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv31p_Dpd_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv61p_Dpd_Bal_Tot_ := 0;
    KEL.typ.int B_E___B2_B_Actv91p_Dpd_Bal_Tot_ := 0;
    KEL.typ.float B_E___B2_B_Actv1p_Dpd_Bal_Tot_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv31p_Dpd_Bal_Tot_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv61p_Dpd_Bal_Tot_Pct_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv91p_Dpd_Bal_Tot_Pct_ := 0.0;
    KEL.typ.int B_E___B2_B_Actv1p_Dpd_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv31p_Dpd_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv61p_Dpd_Bal_Tot_A1_Y_ := 0;
    KEL.typ.int B_E___B2_B_Actv91p_Dpd_Bal_Tot_A1_Y_ := 0;
    KEL.typ.float B_E___B2_B_Actv1p_Dpd_Bal_Tot_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv31p_Dpd_Bal_Tot_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv61p_Dpd_Bal_Tot_Grow1_Y_ := 0.0;
    KEL.typ.float B_E___B2_B_Actv91p_Dpd_Bal_Tot_Grow1_Y_ := 0.0;
    KEL.typ.str B_E___B2_B_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Carr_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Flt_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Mat_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Ops_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.str B_E___B2_B_Oth_Worst_Perf_Indx2_Y_ := '';
    KEL.typ.nstr B_E___B2_B_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Carr_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Flt_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Mat_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Ops_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B_E___B2_B_Oth_Worst_Perf_Dt2_Y_;
    KEL.typ.nint B_E___B2_B_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Carr_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Flt_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Mat_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Ops_Worst_Perf_Msnc2_Y_;
    KEL.typ.nint B_E___B2_B_Oth_Worst_Perf_Msnc2_Y_;
    KEL.typ.int B_E___B2_B_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Carr_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Flt_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Mat_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Ops_Cnt24_Mc_ := 0;
    KEL.typ.int B_E___B2_B_Oth_Cnt24_Mc_ := 0;
    KEL.typ.str B_E___B2_B_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Carr_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Flt_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Mat_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Ops_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.str B_E___B2_B_Oth_Rec_Flag_By_Mon_Str24_Mc_ := '';
    KEL.typ.nint B_E___B2_B_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Carr_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Flt_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Mat_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Ops_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nint B_E___B2_B_Oth_Rec_Flag_By_Mon_Sum24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Carr_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Flt_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Mat_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Ops_Bal_Vol24_Mc_;
    KEL.typ.nfloat B_E___B2_B_Oth_Bal_Vol24_Mc_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST41093_Layout __ND1449588__Project(B_Business_Sele(__in,__cfg_Local).__ST51538_Layout __PP1449584) := TRANSFORM
    SELF.B___Lex_I_D_Ult_ := __PP1449584.Ult_I_D_;
    SELF.B___Lex_I_D_Org_ := __PP1449584.Org_I_D_;
    SELF.B___Lex_I_D_Legal_ := __PP1449584.Sele_I_D_;
    SELF := __PP1449584;
  END;
  SHARED __ST41093_Layout __ND1449588__Rollup(__ST41093_Layout __r, DATASET(__ST41093_Layout) __recs) := TRANSFORM
    __recs_B_E___Ver_Src_List_ := NORMALIZE(__recs,__T(LEFT.B_E___Ver_Src_List_),TRANSFORM(B_Business_Sele(__in,__cfg_Local).__ST35944_Layout,SELF:=RIGHT));
    __recs_B_E___Ver_Src_List__allnull := NOT EXISTS(__recs(__NN(B_E___Ver_Src_List_)));
    SELF.B_E___Ver_Src_List_ := __BN(PROJECT(TABLE(__recs_B_E___Ver_Src_List_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Translated_Source_Code_,Source_Date_First_Seen_,Source_Date_Last_Seen_},Translated_Source_Code_,Source_Date_First_Seen_,Source_Date_Last_Seen_),B_Business_Sele(__in,__cfg_Local).__ST35944_Layout),__recs_B_E___Ver_Src_List__allnull);
    SELF.__RecordCount := SUM(__recs,__RecordCount);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  EXPORT Res0 := __UNWRAP(ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__EE1449583,__ND1449588__Project(LEFT)),'B_E___Ver_Src_List_','b_e___ver_src_list_','clean','__recordcount,date_first_seen_,date_last_seen_'),B___Lex_I_D_Ult_,B___Lex_I_D_Org_,B___Lex_I_D_Legal_,B___Lex_I_D_Legal_Seen_Flag_,B_E___Ver_Src_List_Clean,B_E___B2_B_Cnt_Ev_,B_E___B2_B_Cnt2_Y_,B_E___B2_B_Carr_Cnt2_Y_,B_E___B2_B_Flt_Cnt2_Y_,B_E___B2_B_Mat_Cnt2_Y_,B_E___B2_B_Ops_Cnt2_Y_,B_E___B2_B_Oth_Cnt2_Y_,B_E___B2_B_Carr_Pct2_Y_,B_E___B2_B_Flt_Pct2_Y_,B_E___B2_B_Mat_Pct2_Y_,B_E___B2_B_Ops_Pct2_Y_,B_E___B2_B_Oth_Pct2_Y_,B_E___B2_B_Old_Dt_Ev_,B_E___B2_B_Old_Msnc_Ev_,B_E___B2_B_Old_Dt2_Y_,B_E___B2_B_New_Dt2_Y_,B_E___B2_B_Old_Msnc2_Y_,B_E___B2_B_New_Msnc2_Y_,B_E___B2_B_Actv_Cnt_,B_E___B2_B_Actv_Carr_Cnt_,B_E___B2_B_Actv_Flt_Cnt_,B_E___B2_B_Actv_Mat_Cnt_,B_E___B2_B_Actv_Ops_Cnt_,B_E___B2_B_Actv_Oth_Cnt_,B_E___B2_B_Actv_Carr_Pct_,B_E___B2_B_Actv_Flt_Pct_,B_E___B2_B_Actv_Mat_Pct_,B_E___B2_B_Actv_Ops_Pct_,B_E___B2_B_Actv_Oth_Pct_,B_E___B2_B_Actv_Cnt_A1_Y_,B_E___B2_B_Actv_Carr_Cnt_A1_Y_,B_E___B2_B_Actv_Flt_Cnt_A1_Y_,B_E___B2_B_Actv_Mat_Cnt_A1_Y_,B_E___B2_B_Actv_Ops_Cnt_A1_Y_,B_E___B2_B_Actv_Oth_Cnt_A1_Y_,B_E___B2_B_Actv_Cnt_Grow1_Y_,B_E___B2_B_Actv_Carr_Cnt_Grow1_Y_,B_E___B2_B_Actv_Flt_Cnt_Grow1_Y_,B_E___B2_B_Actv_Mat_Cnt_Grow1_Y_,B_E___B2_B_Actv_Ops_Cnt_Grow1_Y_,B_E___B2_B_Actv_Oth_Cnt_Grow1_Y_,B_E___B2_B_Actv_Bal_Tot_,B_E___B2_B_Actv_Carr_Bal_Tot_,B_E___B2_B_Actv_Flt_Bal_Tot_,B_E___B2_B_Actv_Mat_Bal_Tot_,B_E___B2_B_Actv_Ops_Bal_Tot_,B_E___B2_B_Actv_Oth_Bal_Tot_,B_E___B2_B_Actv_Carr_Bal_Tot_Pct_,B_E___B2_B_Actv_Flt_Bal_Pct_,B_E___B2_B_Actv_Mat_Bal_Pct_,B_E___B2_B_Actv_Ops_Bal_Pct_,B_E___B2_B_Actv_Oth_Bal_Pct_,B_E___B2_B_Actv_Bal_Tot_Rnge_,B_E___B2_B_Actv_Carr_Bal_Tot_Rnge_,B_E___B2_B_Actv_Flt_Bal_Tot_Rnge_,B_E___B2_B_Actv_Mat_Bal_Tot_Rnge_,B_E___B2_B_Actv_Ops_Bal_Tot_Rnge_,B_E___B2_B_Actv_Oth_Bal_Tot_Rnge_,B_E___B2_B_Actv_Bal_Avg_,B_E___B2_B_Actv_Carr_Bal_Avg_,B_E___B2_B_Actv_Flt_Bal_Avg_,B_E___B2_B_Actv_Mat_Bal_Avg_,B_E___B2_B_Actv_Ops_Bal_Avg_,B_E___B2_B_Actv_Oth_Bal_Avg_,B_E___B2_B_Actv_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Carr_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Flt_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Mat_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Ops_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Oth_Bal_Tot_A1_Y_,B_E___B2_B_Actv_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Carr_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Flt_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Mat_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Ops_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Oth_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Carr_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Flt_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Mat_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Ops_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Actv_Oth_Bal_Tot_Grow_Indx1_Y_,B_E___B2_B_Bal_Max2_Y_,B_E___B2_B_Carr_Bal_Max2_Y_,B_E___B2_B_Flt_Bal_Max2_Y_,B_E___B2_B_Mat_Bal_Max2_Y_,B_E___B2_B_Ops_Bal_Max2_Y_,B_E___B2_B_Oth_Bal_Max2_Y_,B_E___B2_B_Bal_Max_Dt2_Y_,B_E___B2_B_Carr_Bal_Max_Dt2_Y_,B_E___B2_B_Flt_Bal_Max_Dt2_Y_,B_E___B2_B_Mat_Bal_Max_Dt2_Y_,B_E___B2_B_Ops_Bal_Max_Dt2_Y_,B_E___B2_B_Oth_Bal_Max_Dt2_Y_,B_E___B2_B_Bal_Max_Msnc2_Y_,B_E___B2_B_Carr_Bal_Max_Msnc2_Y_,B_E___B2_B_Flt_Bal_Max_Msnc2_Y_,B_E___B2_B_Mat_Bal_Max_Msnc2_Y_,B_E___B2_B_Ops_Bal_Max_Msnc2_Y_,B_E___B2_B_Oth_Bal_Max_Msnc2_Y_,B_E___B2_B_Bal_Max_Seg_Type2_Y_,B_E___B2_B_Actv_Worst_Perf_Indx_,B_E___B2_B_Actv_Carr_Worst_Perf_Indx_,B_E___B2_B_Actv_Flt_Worst_Perf_Indx_,B_E___B2_B_Actv_Mat_Worst_Perf_Indx_,B_E___B2_B_Actv_Ops_Worst_Perf_Indx_,B_E___B2_B_Actv_Oth_Worst_Perf_Indx_,B_E___B2_B_Actv1p_Dpd_Cnt_,B_E___B2_B_Actv31p_Dpd_Cnt_,B_E___B2_B_Actv61p_Dpd_Cnt_,B_E___B2_B_Actv91p_Dpd_Cnt_,B_E___B2_B_Actv1p_Dpd_Pct_,B_E___B2_B_Actv31p_Dpd_Pct_,B_E___B2_B_Actv61p_Dpd_Pct_,B_E___B2_B_Actv91p_Dpd_Pct_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_Pct_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_A1_Y_,B_E___B2_B_Actv1p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv31p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv61p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Actv91p_Dpd_Bal_Tot_Grow1_Y_,B_E___B2_B_Worst_Perf_Indx2_Y_,B_E___B2_B_Carr_Worst_Perf_Indx2_Y_,B_E___B2_B_Flt_Worst_Perf_Indx2_Y_,B_E___B2_B_Mat_Worst_Perf_Indx2_Y_,B_E___B2_B_Ops_Worst_Perf_Indx2_Y_,B_E___B2_B_Oth_Worst_Perf_Indx2_Y_,B_E___B2_B_Worst_Perf_Dt2_Y_,B_E___B2_B_Carr_Worst_Perf_Dt2_Y_,B_E___B2_B_Flt_Worst_Perf_Dt2_Y_,B_E___B2_B_Mat_Worst_Perf_Dt2_Y_,B_E___B2_B_Ops_Worst_Perf_Dt2_Y_,B_E___B2_B_Oth_Worst_Perf_Dt2_Y_,B_E___B2_B_Worst_Perf_Msnc2_Y_,B_E___B2_B_Carr_Worst_Perf_Msnc2_Y_,B_E___B2_B_Flt_Worst_Perf_Msnc2_Y_,B_E___B2_B_Mat_Worst_Perf_Msnc2_Y_,B_E___B2_B_Ops_Worst_Perf_Msnc2_Y_,B_E___B2_B_Oth_Worst_Perf_Msnc2_Y_,B_E___B2_B_Cnt24_Mc_,B_E___B2_B_Carr_Cnt24_Mc_,B_E___B2_B_Flt_Cnt24_Mc_,B_E___B2_B_Mat_Cnt24_Mc_,B_E___B2_B_Ops_Cnt24_Mc_,B_E___B2_B_Oth_Cnt24_Mc_,B_E___B2_B_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Carr_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Flt_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Mat_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Ops_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Oth_Rec_Flag_By_Mon_Str24_Mc_,B_E___B2_B_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Carr_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Flt_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Mat_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Ops_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Oth_Rec_Flag_By_Mon_Sum24_Mc_,B_E___B2_B_Bal_Vol24_Mc_,B_E___B2_B_Carr_Bal_Vol24_Mc_,B_E___B2_B_Flt_Bal_Vol24_Mc_,B_E___B2_B_Mat_Bal_Vol24_Mc_,B_E___B2_B_Ops_Bal_Vol24_Mc_,B_E___B2_B_Oth_Bal_Vol24_Mc_,ALL),GROUP,__ND1449588__Rollup(ROW(LEFT,__ST41093_Layout), PROJECT(ROWS(LEFT),__ST41093_Layout))));
END;
