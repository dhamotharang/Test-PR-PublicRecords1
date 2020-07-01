//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT B_Business_Prox,B_Business_Prox_1,B_Business_Prox_2,B_Business_Prox_3,B_Business_Prox_4,CFG_Compile,E_Address,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Ult,E_Geo_Link,E_Phone,E_Prox_Address,E_Prox_Phone_Number,E_Prox_T_I_N,E_T_I_N,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT Q_Non_F_C_R_A_Business_Prox_I_D_Attributes_V1(KEL.typ.int __PUltID_in, KEL.typ.int __POrgID_in, KEL.typ.int __PSeleID_in, KEL.typ.int __PProxID_in, DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII)) __PInputPIIDataset, DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII)) __PInputBIIDataset, KEL.typ.kdate __PP_InpClnArchDt, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Business_Prox_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Business_Prox(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.Ult_I_D_,=,__CN(__PUltID_in))))) AND EXISTS(__g(__T(__OP2(__g.Org_I_D_,=,__CN(__POrgID_in))))) AND EXISTS(__g(__T(__OP2(__g.Sele_I_D_,=,__CN(__PSeleID_in))))) AND EXISTS(__g(__T(__OP2(__g.Prox_I_D_,=,__CN(__PProxID_in)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Prox_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Prox_Phone_Number_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_Phone_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Prox_T_I_N_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Prox_T_I_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Business_Prox_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Business_Location_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Business_Prox_Filtered := E_Business_Prox_Filtered_1;
  SHARED B_Business_Prox_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Prox_4(__in,__cfg))
    SHARED TYPEOF(E_Business_Prox(__in,__cfg).__Result) __E_Business_Prox := E_Business_Prox_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Prox_Address(__in,__cfg).__Result) __E_Prox_Address := E_Prox_Address_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Business_Prox_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Prox_3(__in,__cfg))
    SHARED TYPEOF(B_Business_Prox_4(__in,__cfg).__ENH_Business_Prox_4) __ENH_Business_Prox_4 := B_Business_Prox_4_Local(__in,__cfg).__ENH_Business_Prox_4;
  END;
  SHARED B_Business_Prox_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Prox_2(__in,__cfg))
    SHARED TYPEOF(B_Business_Prox_3(__in,__cfg).__ENH_Business_Prox_3) __ENH_Business_Prox_3 := B_Business_Prox_3_Local(__in,__cfg).__ENH_Business_Prox_3;
    SHARED TYPEOF(E_Prox_Phone_Number(__in,__cfg).__Result) __E_Prox_Phone_Number := E_Prox_Phone_Number_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Prox_T_I_N(__in,__cfg).__Result) __E_Prox_T_I_N := E_Prox_T_I_N_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Business_Prox_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Prox_1(__in,__cfg))
    SHARED TYPEOF(B_Business_Prox_2(__in,__cfg).__ENH_Business_Prox_2) __ENH_Business_Prox_2 := B_Business_Prox_2_Local(__in,__cfg).__ENH_Business_Prox_2;
  END;
  SHARED B_Business_Prox_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Business_Prox(__in,__cfg))
    SHARED TYPEOF(B_Business_Prox_1(__in,__cfg).__ENH_Business_Prox_1) __ENH_Business_Prox_1 := B_Business_Prox_1_Local(__in,__cfg).__ENH_Business_Prox_1;
  END;
  SHARED TYPEOF(B_Business_Prox(__in,__cfg_Local).__ENH_Business_Prox) __ENH_Business_Prox := B_Business_Prox_Local(__in,__cfg_Local).__ENH_Business_Prox;
  SHARED __EE2748368 := __ENH_Business_Prox;
  SHARED __EE2748599 := __EE2748368(__T(__AND(__OP2(__EE2748368.Ult_I_D_,=,__CN(__PUltID_in)),__AND(__OP2(__EE2748368.Org_I_D_,=,__CN(__POrgID_in)),__AND(__OP2(__EE2748368.Sele_I_D_,=,__CN(__PSeleID_in)),__OP2(__EE2748368.Prox_I_D_,=,__CN(__PProxID_in)))))));
  SHARED __ST70947_Layout := RECORD
    KEL.typ.nint B___Lex_I_D_Ult_;
    KEL.typ.nint B___Lex_I_D_Org_;
    KEL.typ.nint B___Lex_I_D_Legal_;
    KEL.typ.nint B___Lex_I_D_Loc_;
    KEL.typ.str B___Lex_I_D_Loc_Seen_Flag_ := '';
    KEL.typ.nstr B_P___Best_Name_;
    KEL.typ.nint B_P___Best_Addr_Loc_I_D_;
    KEL.typ.nstr B_P___Best_Addr_St_;
    KEL.typ.nstr B_P___Best_Addr_City_;
    KEL.typ.nstr B_P___Best_Addr_City_Post_;
    KEL.typ.nstr B_P___Best_Addr_State_;
    KEL.typ.nstr B_P___Best_Addr_Zip_;
    KEL.typ.nstr B_P___Best_T_I_N_;
    KEL.typ.nstr B_P___Best_Phone_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST70947_Layout __ND2748604__Project(B_Business_Prox(__in,__cfg_Local).__ST75468_Layout __PP2748600) := TRANSFORM
    SELF.B___Lex_I_D_Ult_ := __PP2748600.Ult_I_D_;
    SELF.B___Lex_I_D_Org_ := __PP2748600.Org_I_D_;
    SELF.B___Lex_I_D_Legal_ := __PP2748600.Sele_I_D_;
    SELF.B___Lex_I_D_Loc_ := __PP2748600.Prox_I_D_;
    SELF := __PP2748600;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(TABLE(PROJECT(__EE2748599,__ND2748604__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),B___Lex_I_D_Ult_,B___Lex_I_D_Org_,B___Lex_I_D_Legal_,B___Lex_I_D_Loc_,B___Lex_I_D_Loc_Seen_Flag_,B_P___Best_Name_,B_P___Best_Addr_Loc_I_D_,B_P___Best_Addr_St_,B_P___Best_Addr_City_,B_P___Best_Addr_City_Post_,B_P___Best_Addr_State_,B_P___Best_Addr_Zip_,B_P___Best_T_I_N_,B_P___Best_Phone_},B___Lex_I_D_Ult_,B___Lex_I_D_Org_,B___Lex_I_D_Legal_,B___Lex_I_D_Loc_,B___Lex_I_D_Loc_Seen_Flag_,B_P___Best_Name_,B_P___Best_Addr_Loc_I_D_,B_P___Best_Addr_St_,B_P___Best_Addr_City_,B_P___Best_Addr_City_Post_,B_P___Best_Addr_State_,B_P___Best_Addr_Zip_,B_P___Best_T_I_N_,B_P___Best_Phone_,MERGE),__ST70947_Layout));
END;
