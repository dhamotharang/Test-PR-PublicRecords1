//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT B_Business_Prox,B_Business_Prox_1,B_Business_Prox_2,B_Business_Prox_3,CFG_Compile,E_Business_Org,E_Business_Prox,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Prox_Address,E_Prox_Phone_Number,E_Prox_T_I_N FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT Q_Non_F_C_R_A_Business_Prox_I_D_Attributes_V1_Dynamic(KEL.typ.int __PUltID_in, KEL.typ.int __POrgID_in, KEL.typ.int __PSeleID_in, KEL.typ.int __PProxID_in, DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII)) __PInputPIIDataset, DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII)) __PInputBIIDataset, KEL.typ.kdate __PP_InpClnArchDt, DATA57 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Business_Prox_Filtered := MODULE(E_Business_Prox(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Prox_Address_Filtered := MODULE(E_Prox_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Prox_Phone_Number_Filtered := MODULE(E_Prox_Phone_Number(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Prox_T_I_N_Filtered := MODULE(E_Prox_T_I_N(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED B_Business_Prox_3_Local := MODULE(B_Business_Prox_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Business_Prox(__in,__cfg_Local).__Result) __E_Business_Prox := E_Business_Prox_Filtered.__Result;
    SHARED TYPEOF(E_Prox_Address(__in,__cfg_Local).__Result) __E_Prox_Address := E_Prox_Address_Filtered.__Result;
  END;
  SHARED B_Business_Prox_2_Local := MODULE(B_Business_Prox_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Prox_3(__in,__cfg_Local).__ENH_Business_Prox_3) __ENH_Business_Prox_3 := B_Business_Prox_3_Local.__ENH_Business_Prox_3;
    SHARED TYPEOF(E_Prox_Phone_Number(__in,__cfg_Local).__Result) __E_Prox_Phone_Number := E_Prox_Phone_Number_Filtered.__Result;
    SHARED TYPEOF(E_Prox_T_I_N(__in,__cfg_Local).__Result) __E_Prox_T_I_N := E_Prox_T_I_N_Filtered.__Result;
  END;
  SHARED B_Business_Prox_1_Local := MODULE(B_Business_Prox_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Prox_2(__in,__cfg_Local).__ENH_Business_Prox_2) __ENH_Business_Prox_2 := B_Business_Prox_2_Local.__ENH_Business_Prox_2;
  END;
  SHARED B_Business_Prox_Local := MODULE(B_Business_Prox(__in,__cfg_Local))
    SHARED TYPEOF(B_Business_Prox_1(__in,__cfg_Local).__ENH_Business_Prox_1) __ENH_Business_Prox_1 := B_Business_Prox_1_Local.__ENH_Business_Prox_1;
  END;
  SHARED TYPEOF(B_Business_Prox(__in,__cfg_Local).__ENH_Business_Prox) __ENH_Business_Prox := B_Business_Prox_Local.__ENH_Business_Prox;
  SHARED __EE3682482 := __ENH_Business_Prox;
  SHARED __EE3682745 := __EE3682482(__T(__AND(__OP2(__EE3682482.Ult_I_D_,=,__CN(__PUltID_in)),__AND(__OP2(__EE3682482.Org_I_D_,=,__CN(__POrgID_in)),__AND(__OP2(__EE3682482.Sele_I_D_,=,__CN(__PSeleID_in)),__OP2(__EE3682482.Prox_I_D_,=,__CN(__PProxID_in)))))));
  SHARED __ST109866_Layout := RECORD
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
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST109866_Layout __ND3682750__Project(B_Business_Prox(__in,__cfg_Local).__ST143777_Layout __PP3682746) := TRANSFORM
    SELF.B___Lex_I_D_Ult_ := __PP3682746.Ult_I_D_;
    SELF.B___Lex_I_D_Org_ := __PP3682746.Org_I_D_;
    SELF.B___Lex_I_D_Legal_ := __PP3682746.Sele_I_D_;
    SELF.B___Lex_I_D_Loc_ := __PP3682746.Prox_I_D_;
    SELF := __PP3682746;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(TABLE(PROJECT(__EE3682745,__ND3682750__Project(LEFT)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),B___Lex_I_D_Ult_,B___Lex_I_D_Org_,B___Lex_I_D_Legal_,B___Lex_I_D_Loc_,B___Lex_I_D_Loc_Seen_Flag_,B_P___Best_Name_,B_P___Best_Addr_Loc_I_D_,B_P___Best_Addr_St_,B_P___Best_Addr_City_,B_P___Best_Addr_City_Post_,B_P___Best_Addr_State_,B_P___Best_Addr_Zip_,B_P___Best_T_I_N_,B_P___Best_Phone_},B___Lex_I_D_Ult_,B___Lex_I_D_Org_,B___Lex_I_D_Legal_,B___Lex_I_D_Loc_,B___Lex_I_D_Loc_Seen_Flag_,B_P___Best_Name_,B_P___Best_Addr_Loc_I_D_,B_P___Best_Addr_St_,B_P___Best_Addr_City_,B_P___Best_Addr_City_Post_,B_P___Best_Addr_State_,B_P___Best_Addr_Zip_,B_P___Best_T_I_N_,B_P___Best_Phone_,MERGE),__ST109866_Layout));
  EXPORT DBG_E_Business_Prox_Result := __UNWRAP(E_Business_Prox_Filtered.__Result);
  EXPORT DBG_E_Prox_Address_Result := __UNWRAP(E_Prox_Address_Filtered.__Result);
  EXPORT DBG_E_Prox_Phone_Number_Result := __UNWRAP(E_Prox_Phone_Number_Filtered.__Result);
  EXPORT DBG_E_Prox_T_I_N_Result := __UNWRAP(E_Prox_T_I_N_Filtered.__Result);
  EXPORT DBG_E_Business_Prox_Intermediate_3 := __UNWRAP(B_Business_Prox_3_Local.__ENH_Business_Prox_3);
  EXPORT DBG_E_Business_Prox_Intermediate_2 := __UNWRAP(B_Business_Prox_2_Local.__ENH_Business_Prox_2);
  EXPORT DBG_E_Business_Prox_Intermediate_1 := __UNWRAP(B_Business_Prox_1_Local.__ENH_Business_Prox_1);
  EXPORT DBG_E_Business_Prox_Annotated := __UNWRAP(B_Business_Prox_Local.__ENH_Business_Prox);
  EXPORT DBG_OutputAll := PARALLEL(
    OUTPUT(DBG_E_Business_Prox_Result,NAMED('DBG_E_Business_Prox_Result_Q_Non_F_C_R_A_Business_Prox_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Prox_Address_Result,NAMED('DBG_E_Prox_Address_Result_Q_Non_F_C_R_A_Business_Prox_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Prox_Phone_Number_Result,NAMED('DBG_E_Prox_Phone_Number_Result_Q_Non_F_C_R_A_Business_Prox_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Prox_T_I_N_Result,NAMED('DBG_E_Prox_T_I_N_Result_Q_Non_F_C_R_A_Business_Prox_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Prox_Intermediate_3,NAMED('DBG_E_Business_Prox_Intermediate_3_Q_Non_F_C_R_A_Business_Prox_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Prox_Intermediate_2,NAMED('DBG_E_Business_Prox_Intermediate_2_Q_Non_F_C_R_A_Business_Prox_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Prox_Intermediate_1,NAMED('DBG_E_Business_Prox_Intermediate_1_Q_Non_F_C_R_A_Business_Prox_I_D_Attributes_V1_Dynamic')),
    OUTPUT(DBG_E_Business_Prox_Annotated,NAMED('DBG_E_Business_Prox_Annotated_Q_Non_F_C_R_A_Business_Prox_I_D_Attributes_V1_Dynamic'))
  );
  EXPORT DBG_Res0 := WHEN(Res0,DBG_OutputAll);
END;
