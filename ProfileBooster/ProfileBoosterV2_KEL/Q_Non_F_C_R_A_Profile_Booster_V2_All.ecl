//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Person,B_Person_1,B_Person_2,B_Person_3,B_Person_4,B_Person_5,B_Person_6,B_Person_7,B_Person_Vehicle_1,B_Person_Vehicle_10,B_Person_Vehicle_2,B_Person_Vehicle_3,B_Person_Vehicle_4,B_Person_Vehicle_5,B_Person_Vehicle_6,B_Person_Vehicle_7,B_Person_Vehicle_8,B_Person_Vehicle_9,B_Vehicle_1,B_Vehicle_2,B_Vehicle_3,B_Vehicle_4,B_Vehicle_5,B_Vehicle_6,B_Vehicle_7,B_Vehicle_8,B_Vehicle_9,CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
EXPORT Q_Non_F_C_R_A_Profile_Booster_V2_All(KEL.typ.kdate __PInputArchiveDateClean, UNSIGNED8 __PDPM) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    SHARED DATASET(CurrentDateLayout) CurrentDateData := DATASET([{0,__PInputArchiveDateClean}],CurrentDateLayout);
    EXPORT KEL.typ.str PersistId := (KEL.typ.str)HASH32(4911992);
  END;
  SHARED E_Person_Filtered(CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person(__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Vehicle_Filtered(CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Vehicle(__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Vehicle_Filtered(CFG_Compile __cfg = CFG_Compile) := MODULE(E_Vehicle(__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED B_Person_Vehicle_10_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_10(__cfg))
    SHARED TYPEOF(E_Person_Vehicle(__cfg).__Result) __E_Person_Vehicle := E_Person_Vehicle_Filtered(__cfg).__Result;
  END;
  SHARED B_Person_Vehicle_9_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_9(__cfg))
    SHARED TYPEOF(B_Person_Vehicle_10(__cfg).__ENH_Person_Vehicle_10) __ENH_Person_Vehicle_10 := B_Person_Vehicle_10_Local(__cfg).__ENH_Person_Vehicle_10;
  END;
  SHARED B_Vehicle_9_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Vehicle_9(__cfg))
    SHARED TYPEOF(E_Vehicle(__cfg).__Result) __E_Vehicle := E_Vehicle_Filtered(__cfg).__Result;
  END;
  SHARED B_Person_Vehicle_8_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_8(__cfg))
    SHARED TYPEOF(B_Person_Vehicle_9(__cfg).__ENH_Person_Vehicle_9) __ENH_Person_Vehicle_9 := B_Person_Vehicle_9_Local(__cfg).__ENH_Person_Vehicle_9;
    SHARED TYPEOF(B_Vehicle_9(__cfg).__ENH_Vehicle_9) __ENH_Vehicle_9 := B_Vehicle_9_Local(__cfg).__ENH_Vehicle_9;
  END;
  SHARED B_Vehicle_8_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Vehicle_8(__cfg))
    SHARED TYPEOF(B_Vehicle_9(__cfg).__ENH_Vehicle_9) __ENH_Vehicle_9 := B_Vehicle_9_Local(__cfg).__ENH_Vehicle_9;
  END;
  SHARED B_Person_7_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_7(__cfg))
    SHARED TYPEOF(E_Person(__cfg).__Result) __E_Person := E_Person_Filtered(__cfg).__Result;
  END;
  SHARED B_Person_Vehicle_7_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_7(__cfg))
    SHARED TYPEOF(B_Person_Vehicle_8(__cfg).__ENH_Person_Vehicle_8) __ENH_Person_Vehicle_8 := B_Person_Vehicle_8_Local(__cfg).__ENH_Person_Vehicle_8;
  END;
  SHARED B_Vehicle_7_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Vehicle_7(__cfg))
    SHARED TYPEOF(B_Vehicle_8(__cfg).__ENH_Vehicle_8) __ENH_Vehicle_8 := B_Vehicle_8_Local(__cfg).__ENH_Vehicle_8;
  END;
  SHARED B_Person_6_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_6(__cfg))
    SHARED TYPEOF(B_Person_7(__cfg).__ENH_Person_7) __ENH_Person_7 := B_Person_7_Local(__cfg).__ENH_Person_7;
    SHARED TYPEOF(B_Person_Vehicle_7(__cfg).__ENH_Person_Vehicle_7) __ENH_Person_Vehicle_7 := B_Person_Vehicle_7_Local(__cfg).__ENH_Person_Vehicle_7;
    SHARED TYPEOF(B_Vehicle_7(__cfg).__ENH_Vehicle_7) __ENH_Vehicle_7 := B_Vehicle_7_Local(__cfg).__ENH_Vehicle_7;
  END;
  SHARED B_Person_Vehicle_6_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_6(__cfg))
    SHARED TYPEOF(B_Person_Vehicle_7(__cfg).__ENH_Person_Vehicle_7) __ENH_Person_Vehicle_7 := B_Person_Vehicle_7_Local(__cfg).__ENH_Person_Vehicle_7;
    SHARED TYPEOF(B_Vehicle_7(__cfg).__ENH_Vehicle_7) __ENH_Vehicle_7 := B_Vehicle_7_Local(__cfg).__ENH_Vehicle_7;
  END;
  SHARED B_Vehicle_6_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Vehicle_6(__cfg))
    SHARED TYPEOF(B_Vehicle_7(__cfg).__ENH_Vehicle_7) __ENH_Vehicle_7 := B_Vehicle_7_Local(__cfg).__ENH_Vehicle_7;
  END;
  SHARED B_Person_5_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_5(__cfg))
    SHARED TYPEOF(B_Person_6(__cfg).__ENH_Person_6) __ENH_Person_6 := B_Person_6_Local(__cfg).__ENH_Person_6;
    SHARED TYPEOF(B_Person_Vehicle_6(__cfg).__ENH_Person_Vehicle_6) __ENH_Person_Vehicle_6 := B_Person_Vehicle_6_Local(__cfg).__ENH_Person_Vehicle_6;
    SHARED TYPEOF(B_Vehicle_6(__cfg).__ENH_Vehicle_6) __ENH_Vehicle_6 := B_Vehicle_6_Local(__cfg).__ENH_Vehicle_6;
  END;
  SHARED B_Person_Vehicle_5_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_5(__cfg))
    SHARED TYPEOF(B_Person_Vehicle_6(__cfg).__ENH_Person_Vehicle_6) __ENH_Person_Vehicle_6 := B_Person_Vehicle_6_Local(__cfg).__ENH_Person_Vehicle_6;
  END;
  SHARED B_Vehicle_5_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Vehicle_5(__cfg))
    SHARED TYPEOF(B_Vehicle_6(__cfg).__ENH_Vehicle_6) __ENH_Vehicle_6 := B_Vehicle_6_Local(__cfg).__ENH_Vehicle_6;
  END;
  SHARED B_Person_4_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_4(__cfg))
    SHARED TYPEOF(B_Person_5(__cfg).__ENH_Person_5) __ENH_Person_5 := B_Person_5_Local(__cfg).__ENH_Person_5;
    SHARED TYPEOF(B_Person_Vehicle_5(__cfg).__ENH_Person_Vehicle_5) __ENH_Person_Vehicle_5 := B_Person_Vehicle_5_Local(__cfg).__ENH_Person_Vehicle_5;
    SHARED TYPEOF(B_Vehicle_5(__cfg).__ENH_Vehicle_5) __ENH_Vehicle_5 := B_Vehicle_5_Local(__cfg).__ENH_Vehicle_5;
  END;
  SHARED B_Person_Vehicle_4_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_4(__cfg))
    SHARED TYPEOF(B_Person_Vehicle_5(__cfg).__ENH_Person_Vehicle_5) __ENH_Person_Vehicle_5 := B_Person_Vehicle_5_Local(__cfg).__ENH_Person_Vehicle_5;
  END;
  SHARED B_Vehicle_4_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Vehicle_4(__cfg))
    SHARED TYPEOF(B_Vehicle_5(__cfg).__ENH_Vehicle_5) __ENH_Vehicle_5 := B_Vehicle_5_Local(__cfg).__ENH_Vehicle_5;
  END;
  SHARED B_Person_3_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_3(__cfg))
    SHARED TYPEOF(B_Person_4(__cfg).__ENH_Person_4) __ENH_Person_4 := B_Person_4_Local(__cfg).__ENH_Person_4;
    SHARED TYPEOF(B_Person_Vehicle_4(__cfg).__ENH_Person_Vehicle_4) __ENH_Person_Vehicle_4 := B_Person_Vehicle_4_Local(__cfg).__ENH_Person_Vehicle_4;
    SHARED TYPEOF(B_Vehicle_4(__cfg).__ENH_Vehicle_4) __ENH_Vehicle_4 := B_Vehicle_4_Local(__cfg).__ENH_Vehicle_4;
  END;
  SHARED B_Person_Vehicle_3_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_3(__cfg))
    SHARED TYPEOF(B_Person_Vehicle_4(__cfg).__ENH_Person_Vehicle_4) __ENH_Person_Vehicle_4 := B_Person_Vehicle_4_Local(__cfg).__ENH_Person_Vehicle_4;
  END;
  SHARED B_Vehicle_3_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Vehicle_3(__cfg))
    SHARED TYPEOF(B_Vehicle_4(__cfg).__ENH_Vehicle_4) __ENH_Vehicle_4 := B_Vehicle_4_Local(__cfg).__ENH_Vehicle_4;
  END;
  SHARED B_Person_2_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_2(__cfg))
    SHARED TYPEOF(B_Person_3(__cfg).__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local(__cfg).__ENH_Person_3;
    SHARED TYPEOF(B_Person_Vehicle_3(__cfg).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3_Local(__cfg).__ENH_Person_Vehicle_3;
    SHARED TYPEOF(B_Vehicle_3(__cfg).__ENH_Vehicle_3) __ENH_Vehicle_3 := B_Vehicle_3_Local(__cfg).__ENH_Vehicle_3;
  END;
  SHARED B_Person_Vehicle_2_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_2(__cfg))
    SHARED TYPEOF(B_Person_Vehicle_3(__cfg).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3_Local(__cfg).__ENH_Person_Vehicle_3;
  END;
  SHARED B_Vehicle_2_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Vehicle_2(__cfg))
    SHARED TYPEOF(B_Vehicle_3(__cfg).__ENH_Vehicle_3) __ENH_Vehicle_3 := B_Vehicle_3_Local(__cfg).__ENH_Vehicle_3;
  END;
  SHARED B_Person_1_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_1(__cfg))
    SHARED TYPEOF(B_Person_2(__cfg).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local(__cfg).__ENH_Person_2;
    SHARED TYPEOF(B_Person_Vehicle_2(__cfg).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2_Local(__cfg).__ENH_Person_Vehicle_2;
    SHARED TYPEOF(B_Vehicle_2(__cfg).__ENH_Vehicle_2) __ENH_Vehicle_2 := B_Vehicle_2_Local(__cfg).__ENH_Vehicle_2;
  END;
  SHARED B_Person_Vehicle_1_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_1(__cfg))
    SHARED TYPEOF(B_Person_Vehicle_2(__cfg).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2_Local(__cfg).__ENH_Person_Vehicle_2;
    SHARED TYPEOF(B_Vehicle_2(__cfg).__ENH_Vehicle_2) __ENH_Vehicle_2 := B_Vehicle_2_Local(__cfg).__ENH_Vehicle_2;
  END;
  SHARED B_Vehicle_1_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Vehicle_1(__cfg))
    SHARED TYPEOF(B_Vehicle_2(__cfg).__ENH_Vehicle_2) __ENH_Vehicle_2 := B_Vehicle_2_Local(__cfg).__ENH_Vehicle_2;
  END;
  SHARED B_Person_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person(__cfg))
    SHARED TYPEOF(B_Person_1(__cfg).__ENH_Person_1) __ENH_Person_1 := B_Person_1_Local(__cfg).__ENH_Person_1;
    SHARED TYPEOF(B_Person_Vehicle_1(__cfg).__ENH_Person_Vehicle_1) __ENH_Person_Vehicle_1 := B_Person_Vehicle_1_Local(__cfg).__ENH_Person_Vehicle_1;
    SHARED TYPEOF(B_Vehicle_1(__cfg).__ENH_Vehicle_1) __ENH_Vehicle_1 := B_Vehicle_1_Local(__cfg).__ENH_Vehicle_1;
  END;
  SHARED TYPEOF(B_Person(__cfg_Local).__ENH_Person) __ENH_Person := B_Person_Local(__cfg_Local).__ENH_Person;
  SHARED __EE290550 := __ENH_Person;
  SHARED __ST5579_Layout := RECORD
    KEL.typ.nuid Lex_I_D_;
    KEL.typ.nint P_L___Purch_New_Amt_;
    KEL.typ.nint P_L___Purch_Tot_Ev_;
    KEL.typ.nint P_L___Purch_Cnt_Ev_;
    KEL.typ.nint P_L___Purch_New_Age_Months_;
    KEL.typ.nint P_L___Purch_Old_Age_Months_;
    KEL.typ.nint P_L___Purch_Item_Cnt_Ev_;
    KEL.typ.nint P_L___Purch_Amt_Avg_;
    KEL.typ.nint P_L___Purch_Age_;
    KEL.typ.nstr P_L___Purch_D_O_B_;
    KEL.typ.nstr P_L___Purch_Marital_Status_;
    KEL.typ.nstr P_L___Purch_Gender_;
    KEL.typ.int P_L___Ast_Veh_Auto_Car_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_Elite_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_Exp_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_Luxury_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_Make_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_Orig_Own_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_S_U_V_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_Truck_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_Van_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Ast_Veh_Auto2nd_Freq_Make_;
    KEL.typ.int P_L___Ast_Veh_Auto2nd_Freq_Make_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Ast_Veh_Auto_Freq_Make_;
    KEL.typ.int P_L___Ast_Veh_Auto_Freq_Make_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_New_Type_Indx_ := 0;
    KEL.typ.nstr P_L___Ast_Veh_Auto_Emrg_Price_Avg_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_Price_Diff_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_Price_Max_;
    KEL.typ.nint P_L___Ast_Veh_Auto_New_Price_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_Age_Avg_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_Age_Max_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_Age_Min_;
    KEL.typ.nfloat P_L___Ast_Veh_Auto_Emrg_Span_Avg_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Last_Age_Avg_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Last_Age_Max_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Last_Age_Min_;
    KEL.typ.nint P_L___Ast_Veh_Auto_New_Msnc_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Time_Own_Span_Avg_;
    KEL.typ.int P_L___Ast_Veh_Other_A_T_V_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Other_Camper_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Other_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Other_Comm_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Other_Mtr_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Other_Orig_Own_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Other_Scooter_Cnt_Ev_ := 0;
    KEL.typ.nint P_L___Ast_Veh_Other_New_Msnc_;
    KEL.typ.int P_L___Ast_Veh_Other_New_Type_Indx_ := 0;
    KEL.typ.nint P_L___Ast_Veh_Other_New_Price_;
    KEL.typ.nfloat P_L___Ast_Veh_Other_Price_Avg_;
    KEL.typ.nint P_L___Ast_Veh_Other_Price_Max_;
    KEL.typ.nint P_L___Ast_Veh_Other_Price_Min_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_Price_Min_;
    KEL.typ.nstr P_L___Purch_Min_Date_;
    KEL.typ.nstr P_L___Purch_Max_Date_;
    KEL.typ.nstr P_L___Vehicle_Min_Date_;
    KEL.typ.nstr P_L___Vehicle_Max_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE290550,TRANSFORM(__ST5579_Layout,SELF.Lex_I_D_ := LEFT.UID,SELF := LEFT)),'__Part');
END;
