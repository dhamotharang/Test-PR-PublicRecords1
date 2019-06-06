//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Business,B_Business_1,B_Business_2,B_Business_3,B_Business_4,B_Business_5,B_Business_6,B_Tradeline_1,B_Tradeline_10,B_Tradeline_11,B_Tradeline_2,B_Tradeline_3,B_Tradeline_4,B_Tradeline_5,B_Tradeline_6,B_Tradeline_7,B_Tradeline_8,B_Tradeline_9,B_Tradeline_Business_1,B_Tradeline_Business_2,B_Tradeline_Business_3,CFG_Compile,E_Business,E_Tradeline,E_Tradeline_Business FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT Q_Non_F_C_R_A_Business_Sele_I_D_Attributes_V1(KEL.typ.int __PUltID_in, KEL.typ.int __POrgID_in, KEL.typ.int __PSeleID_in, KEL.typ.kdate __PInputArchiveDateClean, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PInputArchiveDateClean;
  END;
  SHARED E_Business_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.Ult_I_D_,=,__CN(__PUltID_in))))) AND EXISTS(__g(__T(__OP2(__g.Org_I_D_,=,__CN(__POrgID_in))))) AND EXISTS(__g(__T(__OP2(__g.Sele_I_D_,=,__CN(__PSeleID_in)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Tradeline_Business_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Tradeline_Business(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Company_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Tradeline_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Tradeline(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Tradeline_Business_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Account_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Business_Filtered := E_Business_Filtered_2;
  SHARED E_Tradeline_Business_Filtered := E_Tradeline_Business_Filtered_1;
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
  SHARED B_Business_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_6(__in,__cfg))
    SHARED TYPEOF(E_Business(__in,__cfg).__Result) __E_Business := E_Business_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Tradeline_7(__in,__cfg).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local(__in,__cfg).__ENH_Tradeline_7;
    SHARED TYPEOF(E_Tradeline_Business(__in,__cfg).__Result) __E_Tradeline_Business := E_Tradeline_Business_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_6(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_7(__in,__cfg).__ENH_Tradeline_7) __ENH_Tradeline_7 := B_Tradeline_7_Local(__in,__cfg).__ENH_Tradeline_7;
  END;
  SHARED B_Business_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_5(__in,__cfg))
    SHARED TYPEOF(B_Business_6(__in,__cfg).__ENH_Business_6) __ENH_Business_6 := B_Business_6_Local(__in,__cfg).__ENH_Business_6;
  END;
  SHARED B_Tradeline_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_5(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_6(__in,__cfg).__ENH_Tradeline_6) __ENH_Tradeline_6 := B_Tradeline_6_Local(__in,__cfg).__ENH_Tradeline_6;
  END;
  SHARED B_Business_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_4(__in,__cfg))
    SHARED TYPEOF(B_Business_5(__in,__cfg).__ENH_Business_5) __ENH_Business_5 := B_Business_5_Local(__in,__cfg).__ENH_Business_5;
    SHARED TYPEOF(B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local(__in,__cfg).__ENH_Tradeline_5;
    SHARED TYPEOF(E_Tradeline_Business(__in,__cfg).__Result) __E_Tradeline_Business := E_Tradeline_Business_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_4(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_5(__in,__cfg).__ENH_Tradeline_5) __ENH_Tradeline_5 := B_Tradeline_5_Local(__in,__cfg).__ENH_Tradeline_5;
  END;
  SHARED B_Business_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_3(__in,__cfg))
    SHARED TYPEOF(B_Business_4(__in,__cfg).__ENH_Business_4) __ENH_Business_4 := B_Business_4_Local(__in,__cfg).__ENH_Business_4;
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
    SHARED TYPEOF(E_Tradeline_Business(__in,__cfg).__Result) __E_Tradeline_Business := E_Tradeline_Business_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Tradeline_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_3(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
  END;
  SHARED B_Tradeline_Business_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_Business_3(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_4(__in,__cfg).__ENH_Tradeline_4) __ENH_Tradeline_4 := B_Tradeline_4_Local(__in,__cfg).__ENH_Tradeline_4;
    SHARED TYPEOF(E_Tradeline_Business(__in,__cfg).__Result) __E_Tradeline_Business := E_Tradeline_Business_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Business_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_2(__in,__cfg))
    SHARED TYPEOF(B_Business_3(__in,__cfg).__ENH_Business_3) __ENH_Business_3 := B_Business_3_Local(__in,__cfg).__ENH_Business_3;
    SHARED TYPEOF(B_Tradeline_3(__in,__cfg).__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local(__in,__cfg).__ENH_Tradeline_3;
    SHARED TYPEOF(B_Tradeline_Business_3(__in,__cfg).__ENH_Tradeline_Business_3) __ENH_Tradeline_Business_3 := B_Tradeline_Business_3_Local(__in,__cfg).__ENH_Tradeline_Business_3;
  END;
  SHARED B_Tradeline_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_2(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_3(__in,__cfg).__ENH_Tradeline_3) __ENH_Tradeline_3 := B_Tradeline_3_Local(__in,__cfg).__ENH_Tradeline_3;
  END;
  SHARED B_Tradeline_Business_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_Business_2(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_Business_3(__in,__cfg).__ENH_Tradeline_Business_3) __ENH_Tradeline_Business_3 := B_Tradeline_Business_3_Local(__in,__cfg).__ENH_Tradeline_Business_3;
  END;
  SHARED B_Business_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_1(__in,__cfg))
    SHARED TYPEOF(B_Business_2(__in,__cfg).__ENH_Business_2) __ENH_Business_2 := B_Business_2_Local(__in,__cfg).__ENH_Business_2;
    SHARED TYPEOF(B_Tradeline_2(__in,__cfg).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local(__in,__cfg).__ENH_Tradeline_2;
    SHARED TYPEOF(B_Tradeline_Business_2(__in,__cfg).__ENH_Tradeline_Business_2) __ENH_Tradeline_Business_2 := B_Tradeline_Business_2_Local(__in,__cfg).__ENH_Tradeline_Business_2;
  END;
  SHARED B_Tradeline_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_1(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_2(__in,__cfg).__ENH_Tradeline_2) __ENH_Tradeline_2 := B_Tradeline_2_Local(__in,__cfg).__ENH_Tradeline_2;
  END;
  SHARED B_Tradeline_Business_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Tradeline_Business_1(__in,__cfg))
    SHARED TYPEOF(B_Tradeline_Business_2(__in,__cfg).__ENH_Tradeline_Business_2) __ENH_Tradeline_Business_2 := B_Tradeline_Business_2_Local(__in,__cfg).__ENH_Tradeline_Business_2;
  END;
  SHARED B_Business_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business(__in,__cfg))
    SHARED TYPEOF(B_Business_1(__in,__cfg).__ENH_Business_1) __ENH_Business_1 := B_Business_1_Local(__in,__cfg).__ENH_Business_1;
    SHARED TYPEOF(B_Tradeline_1(__in,__cfg).__ENH_Tradeline_1) __ENH_Tradeline_1 := B_Tradeline_1_Local(__in,__cfg).__ENH_Tradeline_1;
    SHARED TYPEOF(B_Tradeline_Business_1(__in,__cfg).__ENH_Tradeline_Business_1) __ENH_Tradeline_Business_1 := B_Tradeline_Business_1_Local(__in,__cfg).__ENH_Tradeline_Business_1;
  END;
  SHARED TYPEOF(B_Business(__in,__cfg_Local).__ENH_Business) __ENH_Business := B_Business_Local(__in,__cfg_Local).__ENH_Business;
  SHARED __EE815945 := __ENH_Business;
  SHARED __EE818528 := __EE815945(__T(__AND(__OP2(__EE815945.Ult_I_D_,=,__CN(__PUltID_in)),__AND(__OP2(__EE815945.Org_I_D_,=,__CN(__POrgID_in)),__OP2(__EE815945.Sele_I_D_,=,__CN(__PSeleID_in))))));
  SHARED __ST32205_Layout := RECORD
    KEL.typ.nint Lex_I_D_Bus_Extended_Family_Append_;
    KEL.typ.nint Lex_I_D_Bus_Legal_Family_Append_;
    KEL.typ.nint Lex_I_D_Bus_Legal_Entity_Append_;
    KEL.typ.str Lex_I_D_Bus_Legal_Entity_Seen_ := '';
    KEL.typ.ndataset(B_Business(__in,__cfg_Local).__ST27060_Layout) Src_Ver_Bus_Legal_Entity_List_;
    KEL.typ.nint B2b_T_L_Cnt_Ev_;
    KEL.typ.int B2b_T_L_Cnt2_Y_ := 0;
    KEL.typ.int B2b_T_L_In_Carr_Cnt2_Y_ := 0;
    KEL.typ.int B2b_T_L_In_Flt_Cnt2_Y_ := 0;
    KEL.typ.int B2b_T_L_In_Mat_Cnt2_Y_ := 0;
    KEL.typ.int B2b_T_L_In_Ops_Cnt2_Y_ := 0;
    KEL.typ.int B2b_T_L_In_Oth_Cnt2_Y_ := 0;
    KEL.typ.float B2b_T_L_In_Carr_Pct2_Y_ := 0.0;
    KEL.typ.float B2b_T_L_In_Flt_Pct2_Y_ := 0.0;
    KEL.typ.float B2b_T_L_In_Mat_Pct2_Y_ := 0.0;
    KEL.typ.float B2b_T_L_In_Ops_Pct2_Y_ := 0.0;
    KEL.typ.float B2b_T_L_In_Oth_Pct2_Y_ := 0.0;
    KEL.typ.nstr B2b_Oldest_T_L_Dt_Ev_;
    KEL.typ.nint B2b_Oldest_T_L_Msince_Ev_;
    KEL.typ.nstr B2b_Oldest_T_L_Dt2_Y_;
    KEL.typ.nstr B2b_Newest_T_L_Dt2_Y_;
    KEL.typ.nint B2b_Oldest_T_L_Msince2_Y_;
    KEL.typ.nint B2b_Newest_T_L_Msince2_Y_;
    KEL.typ.int B2b_Actv_T_L_Cnt_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Carr_Cnt_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Flt_Cnt_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Mat_Cnt_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Ops_Cnt_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Oth_Cnt_ := 0;
    KEL.typ.float B2b_Actv_T_L_In_Carr_Pct_ := 0.0;
    KEL.typ.float B2b_Actv_T_L_In_Flt_Pct_ := 0.0;
    KEL.typ.float B2b_Actv_T_L_In_Mat_Pct_ := 0.0;
    KEL.typ.float B2b_Actv_T_L_In_Ops_Pct_ := 0.0;
    KEL.typ.float B2b_Actv_T_L_In_Oth_Pct_ := 0.0;
    KEL.typ.int B2b_Actv_T_L_Cnt_Arch1_Y_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Carr_Cnt_Arch1_Y_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Flt_Cnt_Arch1_Y_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Mat_Cnt_Arch1_Y_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Ops_Cnt_Arch1_Y_ := 0;
    KEL.typ.int B2b_Actv_T_L_In_Oth_Cnt_Arch1_Y_ := 0;
    KEL.typ.float B2b_Actv_T_L_Cnt_Grow1_Y_ := 0.0;
    KEL.typ.float B2b_Actv_T_L_Cnt_In_Carr_Grow1_Y_ := 0.0;
    KEL.typ.float B2b_Actv_T_L_Cnt_In_Flt_Grow1_Y_ := 0.0;
    KEL.typ.float B2b_Actv_T_L_Cnt_In_Mat_Grow1_Y_ := 0.0;
    KEL.typ.float B2b_Actv_T_L_Cnt_In_Ops_Grow1_Y_ := 0.0;
    KEL.typ.float B2b_Actv_T_L_Cnt_In_Oth_Grow1_Y_ := 0.0;
    KEL.typ.int B2b_Actv_T_L_Bal_Tot_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Carr_Tot_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Flt_Tot_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Mat_Tot_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Ops_Tot_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Oth_Tot_ := 0;
    KEL.typ.nfloat B2b_Actv_T_L_Bal_In_Carr_Pct_;
    KEL.typ.nfloat B2b_Actv_T_L_Bal_In_Flt_Pct_;
    KEL.typ.nfloat B2b_Actv_T_L_Bal_In_Mat_Pct_;
    KEL.typ.nfloat B2b_Actv_T_L_Bal_In_Ops_Pct_;
    KEL.typ.nfloat B2b_Actv_T_L_Bal_In_Oth_Pct_;
    KEL.typ.nstr B2b_Actv_T_L_Bal_Tot_Bin_;
    KEL.typ.nstr B2b_Actv_T_L_Bal_In_Carr_Tot_Bin_;
    KEL.typ.nstr B2b_Actv_T_L_Bal_In_Flt_Tot_Bin_;
    KEL.typ.nstr B2b_Actv_T_L_Bal_In_Mat_Tot_Bin_;
    KEL.typ.nstr B2b_Actv_T_L_Bal_In_Ops_Tot_Bin_;
    KEL.typ.nstr B2b_Actv_T_L_Bal_In_Oth_Tot_Bin_;
    KEL.typ.int B2b_Actv_T_L_Bal_Avg_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Carr_Avg_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Flt_Avg_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Mat_Avg_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Ops_Avg_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Oth_Avg_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_Arch1_Y_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Carr_Arch1_Y_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Flt_Arch1_Y_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Mat_Arch1_Y_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Ops_Arch1_Y_ := 0;
    KEL.typ.int B2b_Actv_T_L_Bal_In_Oth_Arch1_Y_ := 0;
    KEL.typ.nfloat B2b_Actv_T_L_Bal_Grow1_Y_;
    KEL.typ.nfloat B2b_Actv_T_L_Bal_In_Carr_Grow1_Y_;
    KEL.typ.nfloat B2b_Actv_T_L_Bal_In_Flt_Grow1_Y_;
    KEL.typ.nfloat B2b_Actv_T_L_Bal_In_Mat_Grow1_Y_;
    KEL.typ.nfloat B2b_Actv_T_L_Bal_In_Ops_Grow1_Y_;
    KEL.typ.nfloat B2b_Actv_T_L_Bal_In_Oth_Grow1_Y_;
    KEL.typ.nstr B2b_Actv_T_L_Bal_Grow_Index1_Y_;
    KEL.typ.nstr B2b_Actv_T_L_Bal_In_Carr_Grow_Index1_Y_;
    KEL.typ.nstr B2b_Actv_T_L_Bal_In_Flt_Grow_Index1_Y_;
    KEL.typ.nstr B2b_Actv_T_L_Bal_In_Mat_Grow_Index1_Y_;
    KEL.typ.nstr B2b_Actv_T_L_Bal_In_Ops_Grow_Index1_Y_;
    KEL.typ.nstr B2b_Actv_T_L_Bal_In_Oth_Grow_Index1_Y_;
    KEL.typ.nint B2b_T_L_Bal_Max2_Y_;
    KEL.typ.nint B2b_T_L_Bal_In_Carr_Max2_Y_;
    KEL.typ.nint B2b_T_L_Bal_In_Flt_Max2_Y_;
    KEL.typ.nint B2b_T_L_Bal_In_Mat_Max2_Y_;
    KEL.typ.nint B2b_T_L_Bal_In_Ops_Max2_Y_;
    KEL.typ.nint B2b_T_L_Bal_In_Oth_Max2_Y_;
    KEL.typ.nstr B2b_Max_T_L_Bal_Dt2_Y_;
    KEL.typ.nstr B2b_Max_T_L_Bal_In_Carr_Dt2_Y_;
    KEL.typ.nstr B2b_Max_T_L_Bal_In_Flt_Dt2_Y_;
    KEL.typ.nstr B2b_Max_T_L_Bal_In_Mat_Dt2_Y_;
    KEL.typ.nstr B2b_Max_T_L_Bal_In_Ops_Dt2_Y_;
    KEL.typ.nstr B2b_Max_T_L_Bal_In_Oth_Dt2_Y_;
    KEL.typ.nint B2b_Max_T_L_Bal_Msince2_Y_;
    KEL.typ.nint B2b_Max_T_L_Bal_In_Carr_Msince2_Y_;
    KEL.typ.nint B2b_Max_T_L_Bal_In_Flt_Msince2_Y_;
    KEL.typ.nint B2b_Max_T_L_Bal_In_Mat_Msince2_Y_;
    KEL.typ.nint B2b_Max_T_L_Bal_In_Ops_Msince2_Y_;
    KEL.typ.nint B2b_Max_T_L_Bal_In_Oth_Msince2_Y_;
    KEL.typ.nstr B2b_T_L_W_Max_Bal_Seg2_Y_;
    KEL.typ.nstr B2b_Actv_T_L_Worst_Perf_Index_;
    KEL.typ.nstr B2b_Actv_T_L_Worst_Perf_In_Carr_Index_;
    KEL.typ.nstr B2b_Actv_T_L_Worst_Perf_In_Flt_Index_;
    KEL.typ.nstr B2b_Actv_T_L_Worst_Perf_In_Mat_Index_;
    KEL.typ.nstr B2b_Actv_T_L_Worst_Perf_In_Ops_Index_;
    KEL.typ.nstr B2b_Actv_T_L_Worst_Perf_In_Oth_Index_;
    KEL.typ.int B2b_Actv_T_L_W1p_Dpd_Cnt_ := 0;
    KEL.typ.int B2b_Actv_T_L_W31p_Dpd_Cnt_ := 0;
    KEL.typ.int B2b_Actv_T_L_W61p_Dpd_Cnt_ := 0;
    KEL.typ.int B2b_Actv_T_L_W91p_Dpd_Cnt_ := 0;
    KEL.typ.float B2b_Actv_T_L_W1p_Dpd_Pct_ := 0.0;
    KEL.typ.float B2b_Actv_T_L_W31p_Dpd_Pct_ := 0.0;
    KEL.typ.float B2b_Actv_T_L_W61p_Dpd_Pct_ := 0.0;
    KEL.typ.float B2b_Actv_T_L_W91p_Dpd_Pct_ := 0.0;
    KEL.typ.int B2b_Bal_On_Actv_T_L1p_Dpd_Tot_ := 0;
    KEL.typ.int B2b_Bal_On_Actv_T_L31p_Dpd_Tot_ := 0;
    KEL.typ.int B2b_Bal_On_Actv_T_L61p_Dpd_Tot_ := 0;
    KEL.typ.int B2b_Bal_On_Actv_T_L91p_Dpd_Tot_ := 0;
    KEL.typ.float B2b_Bal_On_Actv_T_L1p_Dpd_Pct_ := 0.0;
    KEL.typ.float B2b_Bal_On_Actv_T_L31p_Dpd_Pct_ := 0.0;
    KEL.typ.float B2b_Bal_On_Actv_T_L61p_Dpd_Pct_ := 0.0;
    KEL.typ.float B2b_Bal_On_Actv_T_L91p_Dpd_Pct_ := 0.0;
    KEL.typ.int B2b_Bal_On_Actv_T_L1p_Dpd_Tot_Arch1_Y_ := 0;
    KEL.typ.int B2b_Bal_On_Actv_T_L31p_Dpd_Tot_Arch1_Y_ := 0;
    KEL.typ.int B2b_Bal_On_Actv_T_L61p_Dpd_Tot_Arch1_Y_ := 0;
    KEL.typ.int B2b_Bal_On_Actv_T_L91p_Dpd_Tot_Arch1_Y_ := 0;
    KEL.typ.float B2b_Bal_On_Actv_T_L1p_Dpd_Grow1_Y_ := 0.0;
    KEL.typ.float B2b_Bal_On_Actv_T_L31p_Dpd_Grow1_Y_ := 0.0;
    KEL.typ.float B2b_Bal_On_Actv_T_L61p_Dpd_Grow1_Y_ := 0.0;
    KEL.typ.float B2b_Bal_On_Actv_T_L91p_Dpd_Grow1_Y_ := 0.0;
    KEL.typ.str B2b_T_L_Worst_Perf_Index2_Y_ := '';
    KEL.typ.str B2b_T_L_Worst_Perf_In_Carr_Index2_Y_ := '';
    KEL.typ.str B2b_T_L_Worst_Perf_In_Flt_Index2_Y_ := '';
    KEL.typ.str B2b_T_L_Worst_Perf_In_Mat_Index2_Y_ := '';
    KEL.typ.str B2b_T_L_Worst_Perf_In_Ops_Index2_Y_ := '';
    KEL.typ.str B2b_T_L_Worst_Perf_In_Oth_Index2_Y_ := '';
    KEL.typ.nstr B2b_T_L_Worst_Perf_Dt2_Y_;
    KEL.typ.nstr B2b_T_L_Worst_Perf_In_Carr_Dt2_Y_;
    KEL.typ.nstr B2b_T_L_Worst_Perf_In_Flt_Dt2_Y_;
    KEL.typ.nstr B2b_T_L_Worst_Perf_In_Mat_Dt2_Y_;
    KEL.typ.nstr B2b_T_L_Worst_Perf_In_Ops_Dt2_Y_;
    KEL.typ.nstr B2b_T_L_Worst_Perf_In_Oth_Dt2_Y_;
    KEL.typ.nint B2b_T_L_Worst_Perf_Msince2_Y_;
    KEL.typ.nint B2b_T_L_Worst_Perf_In_Carr_Msince2_Y_;
    KEL.typ.nint B2b_T_L_Worst_Perf_In_Flt_Msince2_Y_;
    KEL.typ.nint B2b_T_L_Worst_Perf_In_Mat_Msince2_Y_;
    KEL.typ.nint B2b_T_L_Worst_Perf_In_Ops_Msince2_Y_;
    KEL.typ.nint B2b_T_L_Worst_Perf_In_Oth_Msince2_Y_;
    KEL.typ.int B2b_T_L_Cnt24_Mfull_ := 0;
    KEL.typ.int B2b_T_L_In_Carr_Cnt24_Mfull_ := 0;
    KEL.typ.int B2b_T_L_In_Flt_Cnt24_Mfull_ := 0;
    KEL.typ.int B2b_T_L_In_Mat_Cnt24_Mfull_ := 0;
    KEL.typ.int B2b_T_L_In_Ops_Cnt24_Mfull_ := 0;
    KEL.typ.int B2b_T_L_In_Oth_Cnt24_Mfull_ := 0;
    KEL.typ.str B2b_Ind_Of_Mon_W_T_L_Str24_Mfull_ := '';
    KEL.typ.str B2b_Ind_Of_Mon_W_T_L_In_Carr_Str24_Mfull_ := '';
    KEL.typ.str B2b_Ind_Of_Mon_W_T_L_In_Flt_Str24_Mfull_ := '';
    KEL.typ.str B2b_Ind_Of_Mon_W_T_L_In_Mat_Str24_Mfull_ := '';
    KEL.typ.str B2b_Ind_Of_Mon_W_T_L_In_Ops_Str24_Mfull_ := '';
    KEL.typ.str B2b_Ind_Of_Mon_W_T_L_In_Oth_Str24_Mfull_ := '';
    KEL.typ.nint B2b_Mon_W_T_L_Cnt24_Mfull_;
    KEL.typ.nint B2b_Mon_W_T_L_In_Carr_Cnt24_Mfull_;
    KEL.typ.nint B2b_Mon_W_T_L_In_Flt_Cnt24_Mfull_;
    KEL.typ.nint B2b_Mon_W_T_L_In_Mat_Cnt24_Mfull_;
    KEL.typ.nint B2b_Mon_W_T_L_In_Ops_Cnt24_Mfull_;
    KEL.typ.nint B2b_Mon_W_T_L_In_Oth_Cnt24_Mfull_;
    KEL.typ.nfloat B2b_T_L_Bal_Vol24_Mfull_;
    KEL.typ.nfloat B2b_T_L_Bal_In_Carr_Vol24_Mfull_;
    KEL.typ.nfloat B2b_T_L_Bal_In_Flt_Vol24_Mfull_;
    KEL.typ.nfloat B2b_T_L_Bal_In_Mat_Vol24_Mfull_;
    KEL.typ.nfloat B2b_T_L_Bal_In_Ops_Vol24_Mfull_;
    KEL.typ.nfloat B2b_T_L_Bal_In_Oth_Vol24_Mfull_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST32205_Layout __ND818533__Project(B_Business(__in,__cfg_Local).__ST41486_Layout __PP818529) := TRANSFORM
    SELF.Lex_I_D_Bus_Extended_Family_Append_ := __PP818529.Ult_I_D_;
    SELF.Lex_I_D_Bus_Legal_Family_Append_ := __PP818529.Org_I_D_;
    SELF.Lex_I_D_Bus_Legal_Entity_Append_ := __PP818529.Sele_I_D_;
    SELF := __PP818529;
  END;
  SHARED __ST32205_Layout __ND818533__Rollup(__ST32205_Layout __r, DATASET(__ST32205_Layout) __recs) := TRANSFORM
    __recs_Src_Ver_Bus_Legal_Entity_List_ := NORMALIZE(__recs,__T(LEFT.Src_Ver_Bus_Legal_Entity_List_),TRANSFORM(B_Business(__in,__cfg_Local).__ST27060_Layout,SELF:=RIGHT));
    __recs_Src_Ver_Bus_Legal_Entity_List__allnull := NOT EXISTS(__recs(__NN(Src_Ver_Bus_Legal_Entity_List_)));
    SELF.Src_Ver_Bus_Legal_Entity_List_ := __BN(PROJECT(TABLE(__recs_Src_Ver_Bus_Legal_Entity_List_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Translated_Source_Code_,Source_Date_First_Seen_,Source_Date_Last_Seen_},Translated_Source_Code_,Source_Date_First_Seen_,Source_Date_Last_Seen_),B_Business(__in,__cfg_Local).__ST27060_Layout),__recs_Src_Ver_Bus_Legal_Entity_List__allnull);
    SELF.__RecordCount := SUM(__recs,__RecordCount);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  EXPORT Res0 := __UNWRAP(ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__EE818528,__ND818533__Project(LEFT)),'Src_Ver_Bus_Legal_Entity_List_','src_ver_bus_legal_entity_list_','clean','__recordcount,date_first_seen_,date_last_seen_'),Lex_I_D_Bus_Extended_Family_Append_,Lex_I_D_Bus_Legal_Family_Append_,Lex_I_D_Bus_Legal_Entity_Append_,Lex_I_D_Bus_Legal_Entity_Seen_,Src_Ver_Bus_Legal_Entity_List_Clean,B2b_T_L_Cnt_Ev_,B2b_T_L_Cnt2_Y_,B2b_T_L_In_Carr_Cnt2_Y_,B2b_T_L_In_Flt_Cnt2_Y_,B2b_T_L_In_Mat_Cnt2_Y_,B2b_T_L_In_Ops_Cnt2_Y_,B2b_T_L_In_Oth_Cnt2_Y_,B2b_T_L_In_Carr_Pct2_Y_,B2b_T_L_In_Flt_Pct2_Y_,B2b_T_L_In_Mat_Pct2_Y_,B2b_T_L_In_Ops_Pct2_Y_,B2b_T_L_In_Oth_Pct2_Y_,B2b_Oldest_T_L_Dt_Ev_,B2b_Oldest_T_L_Msince_Ev_,B2b_Oldest_T_L_Dt2_Y_,B2b_Newest_T_L_Dt2_Y_,B2b_Oldest_T_L_Msince2_Y_,B2b_Newest_T_L_Msince2_Y_,B2b_Actv_T_L_Cnt_,B2b_Actv_T_L_In_Carr_Cnt_,B2b_Actv_T_L_In_Flt_Cnt_,B2b_Actv_T_L_In_Mat_Cnt_,B2b_Actv_T_L_In_Ops_Cnt_,B2b_Actv_T_L_In_Oth_Cnt_,B2b_Actv_T_L_In_Carr_Pct_,B2b_Actv_T_L_In_Flt_Pct_,B2b_Actv_T_L_In_Mat_Pct_,B2b_Actv_T_L_In_Ops_Pct_,B2b_Actv_T_L_In_Oth_Pct_,B2b_Actv_T_L_Cnt_Arch1_Y_,B2b_Actv_T_L_In_Carr_Cnt_Arch1_Y_,B2b_Actv_T_L_In_Flt_Cnt_Arch1_Y_,B2b_Actv_T_L_In_Mat_Cnt_Arch1_Y_,B2b_Actv_T_L_In_Ops_Cnt_Arch1_Y_,B2b_Actv_T_L_In_Oth_Cnt_Arch1_Y_,B2b_Actv_T_L_Cnt_Grow1_Y_,B2b_Actv_T_L_Cnt_In_Carr_Grow1_Y_,B2b_Actv_T_L_Cnt_In_Flt_Grow1_Y_,B2b_Actv_T_L_Cnt_In_Mat_Grow1_Y_,B2b_Actv_T_L_Cnt_In_Ops_Grow1_Y_,B2b_Actv_T_L_Cnt_In_Oth_Grow1_Y_,B2b_Actv_T_L_Bal_Tot_,B2b_Actv_T_L_Bal_In_Carr_Tot_,B2b_Actv_T_L_Bal_In_Flt_Tot_,B2b_Actv_T_L_Bal_In_Mat_Tot_,B2b_Actv_T_L_Bal_In_Ops_Tot_,B2b_Actv_T_L_Bal_In_Oth_Tot_,B2b_Actv_T_L_Bal_In_Carr_Pct_,B2b_Actv_T_L_Bal_In_Flt_Pct_,B2b_Actv_T_L_Bal_In_Mat_Pct_,B2b_Actv_T_L_Bal_In_Ops_Pct_,B2b_Actv_T_L_Bal_In_Oth_Pct_,B2b_Actv_T_L_Bal_Tot_Bin_,B2b_Actv_T_L_Bal_In_Carr_Tot_Bin_,B2b_Actv_T_L_Bal_In_Flt_Tot_Bin_,B2b_Actv_T_L_Bal_In_Mat_Tot_Bin_,B2b_Actv_T_L_Bal_In_Ops_Tot_Bin_,B2b_Actv_T_L_Bal_In_Oth_Tot_Bin_,B2b_Actv_T_L_Bal_Avg_,B2b_Actv_T_L_Bal_In_Carr_Avg_,B2b_Actv_T_L_Bal_In_Flt_Avg_,B2b_Actv_T_L_Bal_In_Mat_Avg_,B2b_Actv_T_L_Bal_In_Ops_Avg_,B2b_Actv_T_L_Bal_In_Oth_Avg_,B2b_Actv_T_L_Bal_Arch1_Y_,B2b_Actv_T_L_Bal_In_Carr_Arch1_Y_,B2b_Actv_T_L_Bal_In_Flt_Arch1_Y_,B2b_Actv_T_L_Bal_In_Mat_Arch1_Y_,B2b_Actv_T_L_Bal_In_Ops_Arch1_Y_,B2b_Actv_T_L_Bal_In_Oth_Arch1_Y_,B2b_Actv_T_L_Bal_Grow1_Y_,B2b_Actv_T_L_Bal_In_Carr_Grow1_Y_,B2b_Actv_T_L_Bal_In_Flt_Grow1_Y_,B2b_Actv_T_L_Bal_In_Mat_Grow1_Y_,B2b_Actv_T_L_Bal_In_Ops_Grow1_Y_,B2b_Actv_T_L_Bal_In_Oth_Grow1_Y_,B2b_Actv_T_L_Bal_Grow_Index1_Y_,B2b_Actv_T_L_Bal_In_Carr_Grow_Index1_Y_,B2b_Actv_T_L_Bal_In_Flt_Grow_Index1_Y_,B2b_Actv_T_L_Bal_In_Mat_Grow_Index1_Y_,B2b_Actv_T_L_Bal_In_Ops_Grow_Index1_Y_,B2b_Actv_T_L_Bal_In_Oth_Grow_Index1_Y_,B2b_T_L_Bal_Max2_Y_,B2b_T_L_Bal_In_Carr_Max2_Y_,B2b_T_L_Bal_In_Flt_Max2_Y_,B2b_T_L_Bal_In_Mat_Max2_Y_,B2b_T_L_Bal_In_Ops_Max2_Y_,B2b_T_L_Bal_In_Oth_Max2_Y_,B2b_Max_T_L_Bal_Dt2_Y_,B2b_Max_T_L_Bal_In_Carr_Dt2_Y_,B2b_Max_T_L_Bal_In_Flt_Dt2_Y_,B2b_Max_T_L_Bal_In_Mat_Dt2_Y_,B2b_Max_T_L_Bal_In_Ops_Dt2_Y_,B2b_Max_T_L_Bal_In_Oth_Dt2_Y_,B2b_Max_T_L_Bal_Msince2_Y_,B2b_Max_T_L_Bal_In_Carr_Msince2_Y_,B2b_Max_T_L_Bal_In_Flt_Msince2_Y_,B2b_Max_T_L_Bal_In_Mat_Msince2_Y_,B2b_Max_T_L_Bal_In_Ops_Msince2_Y_,B2b_Max_T_L_Bal_In_Oth_Msince2_Y_,B2b_T_L_W_Max_Bal_Seg2_Y_,B2b_Actv_T_L_Worst_Perf_Index_,B2b_Actv_T_L_Worst_Perf_In_Carr_Index_,B2b_Actv_T_L_Worst_Perf_In_Flt_Index_,B2b_Actv_T_L_Worst_Perf_In_Mat_Index_,B2b_Actv_T_L_Worst_Perf_In_Ops_Index_,B2b_Actv_T_L_Worst_Perf_In_Oth_Index_,B2b_Actv_T_L_W1p_Dpd_Cnt_,B2b_Actv_T_L_W31p_Dpd_Cnt_,B2b_Actv_T_L_W61p_Dpd_Cnt_,B2b_Actv_T_L_W91p_Dpd_Cnt_,B2b_Actv_T_L_W1p_Dpd_Pct_,B2b_Actv_T_L_W31p_Dpd_Pct_,B2b_Actv_T_L_W61p_Dpd_Pct_,B2b_Actv_T_L_W91p_Dpd_Pct_,B2b_Bal_On_Actv_T_L1p_Dpd_Tot_,B2b_Bal_On_Actv_T_L31p_Dpd_Tot_,B2b_Bal_On_Actv_T_L61p_Dpd_Tot_,B2b_Bal_On_Actv_T_L91p_Dpd_Tot_,B2b_Bal_On_Actv_T_L1p_Dpd_Pct_,B2b_Bal_On_Actv_T_L31p_Dpd_Pct_,B2b_Bal_On_Actv_T_L61p_Dpd_Pct_,B2b_Bal_On_Actv_T_L91p_Dpd_Pct_,B2b_Bal_On_Actv_T_L1p_Dpd_Tot_Arch1_Y_,B2b_Bal_On_Actv_T_L31p_Dpd_Tot_Arch1_Y_,B2b_Bal_On_Actv_T_L61p_Dpd_Tot_Arch1_Y_,B2b_Bal_On_Actv_T_L91p_Dpd_Tot_Arch1_Y_,B2b_Bal_On_Actv_T_L1p_Dpd_Grow1_Y_,B2b_Bal_On_Actv_T_L31p_Dpd_Grow1_Y_,B2b_Bal_On_Actv_T_L61p_Dpd_Grow1_Y_,B2b_Bal_On_Actv_T_L91p_Dpd_Grow1_Y_,B2b_T_L_Worst_Perf_Index2_Y_,B2b_T_L_Worst_Perf_In_Carr_Index2_Y_,B2b_T_L_Worst_Perf_In_Flt_Index2_Y_,B2b_T_L_Worst_Perf_In_Mat_Index2_Y_,B2b_T_L_Worst_Perf_In_Ops_Index2_Y_,B2b_T_L_Worst_Perf_In_Oth_Index2_Y_,B2b_T_L_Worst_Perf_Dt2_Y_,B2b_T_L_Worst_Perf_In_Carr_Dt2_Y_,B2b_T_L_Worst_Perf_In_Flt_Dt2_Y_,B2b_T_L_Worst_Perf_In_Mat_Dt2_Y_,B2b_T_L_Worst_Perf_In_Ops_Dt2_Y_,B2b_T_L_Worst_Perf_In_Oth_Dt2_Y_,B2b_T_L_Worst_Perf_Msince2_Y_,B2b_T_L_Worst_Perf_In_Carr_Msince2_Y_,B2b_T_L_Worst_Perf_In_Flt_Msince2_Y_,B2b_T_L_Worst_Perf_In_Mat_Msince2_Y_,B2b_T_L_Worst_Perf_In_Ops_Msince2_Y_,B2b_T_L_Worst_Perf_In_Oth_Msince2_Y_,B2b_T_L_Cnt24_Mfull_,B2b_T_L_In_Carr_Cnt24_Mfull_,B2b_T_L_In_Flt_Cnt24_Mfull_,B2b_T_L_In_Mat_Cnt24_Mfull_,B2b_T_L_In_Ops_Cnt24_Mfull_,B2b_T_L_In_Oth_Cnt24_Mfull_,B2b_Ind_Of_Mon_W_T_L_Str24_Mfull_,B2b_Ind_Of_Mon_W_T_L_In_Carr_Str24_Mfull_,B2b_Ind_Of_Mon_W_T_L_In_Flt_Str24_Mfull_,B2b_Ind_Of_Mon_W_T_L_In_Mat_Str24_Mfull_,B2b_Ind_Of_Mon_W_T_L_In_Ops_Str24_Mfull_,B2b_Ind_Of_Mon_W_T_L_In_Oth_Str24_Mfull_,B2b_Mon_W_T_L_Cnt24_Mfull_,B2b_Mon_W_T_L_In_Carr_Cnt24_Mfull_,B2b_Mon_W_T_L_In_Flt_Cnt24_Mfull_,B2b_Mon_W_T_L_In_Mat_Cnt24_Mfull_,B2b_Mon_W_T_L_In_Ops_Cnt24_Mfull_,B2b_Mon_W_T_L_In_Oth_Cnt24_Mfull_,B2b_T_L_Bal_Vol24_Mfull_,B2b_T_L_Bal_In_Carr_Vol24_Mfull_,B2b_T_L_Bal_In_Flt_Vol24_Mfull_,B2b_T_L_Bal_In_Mat_Vol24_Mfull_,B2b_T_L_Bal_In_Ops_Vol24_Mfull_,B2b_T_L_Bal_In_Oth_Vol24_Mfull_,ALL),GROUP,__ND818533__Rollup(ROW(LEFT,__ST32205_Layout), PROJECT(ROWS(LEFT),__ST32205_Layout))));
END;
