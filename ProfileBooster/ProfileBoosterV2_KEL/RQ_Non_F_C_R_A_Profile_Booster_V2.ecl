//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Person,B_Person_1,B_Person_2,B_Person_3,B_Person_4,B_Person_5,B_Person_6,B_Person_7,B_Person_Vehicle,B_Person_Vehicle_1,B_Person_Vehicle_10,B_Person_Vehicle_2,B_Person_Vehicle_3,B_Person_Vehicle_4,B_Person_Vehicle_5,B_Person_Vehicle_6,B_Person_Vehicle_7,B_Person_Vehicle_8,B_Person_Vehicle_9,B_Vehicle,B_Vehicle_1,B_Vehicle_2,B_Vehicle_3,B_Vehicle_4,B_Vehicle_5,B_Vehicle_6,B_Vehicle_7,B_Vehicle_8,B_Vehicle_9,CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
EXPORT RQ_Non_F_C_R_A_Profile_Booster_V2(DATASET(CFG_Compile.Non_F_C_R_A_Profile_Booster_V2_Params_Layout) __Non_F_C_R_A_Profile_Booster_V2_Params, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED __ExtParams := TABLE(__Non_F_C_R_A_Profile_Booster_V2_Params,{__Non_F_C_R_A_Profile_Booster_V2_Params,KEL.typ.kdate __Asof := P___Inp_Cln_Arch_Dt_,UNSIGNED8 __Using := D_P_M_});
  SHARED __FilterValues := DEDUP(SORT(__ExtParams,__Asof,__Using),__Asof,__Using);
  SHARED __Partitions := PROJECT(__FilterValues,TRANSFORM({UNSIGNED4 __Part,KEL.typ.kdate __Asof,UNSIGNED8 __Using},SELF.__Part:=COUNTER,SELF:=LEFT));
  SHARED __Params := JOIN(__ExtParams,__Partitions,LEFT.__Asof = RIGHT.__Asof AND LEFT.__Using = RIGHT.__Using,TRANSFORM(CFG_Compile.Non_F_C_R_A_Profile_Booster_V2_Params_Layout,SELF.__Part:=RIGHT.__Part,SELF:=LEFT));
  SHARED __PartDict := DICTIONARY(__Partitions,{__Part=>__Partitions});
  SHARED __cfg_Local := MODULE(CFG_Compile)
    SHARED DATASET(CurrentDateLayout) CurrentDateData := PROJECT(__Partitions,CurrentDateLayout);
    EXPORT KEL.typ.str LogicalFileFragment := __cfg.LogicalFileFragment;
    EXPORT KEL.typ.str SuperFileFragment := __cfg.SuperFileFragment;
    EXPORT KEL.typ.str PersistId := __cfg.PersistId;
  END;
  SHARED __UIDLayout := RECORD
    KEL.typ.nuid UID;
    UNSIGNED4 __Part;
  END;
  SHARED __Person_KeyList_2 := PROJECT(__Params,TRANSFORM(__UIDLayout,SELF.UID:=__CN(LEFT.Lex_I_D__in_),SELF.__Part:=LEFT.__Part));
  SHARED __FC355121(__UIDLayout __l, B_Person_Vehicle(__cfg_Local).__ST469118_Layout __r) := KEYED(KEL.Indexing.Key(__r.Subject_) = __T(__l.UID));
  SHARED __Person_Vehicle_KeyList_1 := JOIN(__Person_KeyList_2,B_Person_Vehicle(__cfg_Local).IDX_Person_Vehicle_Subject_,__FC355121(LEFT,RIGHT),TRANSFORM(E_Person_Vehicle(__cfg_Local).PreEntityLayout,SELF.__Part:=LEFT.__Part,SELF.Subject_:=__CN(RIGHT.Subject_),SELF:=RIGHT),ATMOST(10000));
  SHARED __Vehicle_KeyList := PROJECT(__Person_Vehicle_KeyList_1,TRANSFORM(__UIDLayout,SELF.UID:=LEFT.Automobile_,SELF.__Part:=LEFT.__Part));
  SHARED __Person_KeyList := __Person_KeyList_2;
  SHARED __Person_Vehicle_KeyList := __Person_Vehicle_KeyList_1;
  SHARED E_Person_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person(__cfg))
    EXPORT __PreEntities := JOIN(DEDUP(__Person_KeyList,RECORD,ALL),B_Person(__cfg).IDX_Person_UID,KEYED(KEL.Indexing.Key(RIGHT.UID) = __T(LEFT.UID)),TRANSFORM(PreEntityLayout,SELF.__Part:=LEFT.__Part,SELF.UID:=__CN(RIGHT.UID),SELF:=RIGHT),ATMOST(10000));
    __PreEntityPayloadFilter(DATASET(PreEntityPayloadLayout) __ds, RECORDOF(__Partitions) __p) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__p.__Asof))) AND (__ds.__Permits & __p.__Using) = __ds.__Permits);
    __PreentitiesFiltered := PROJECT(__PreEntities,TRANSFORM(PreEntityLayout,SELF.__Payload:=__PreEntityPayloadFilter(LEFT.__Payload,ROW((__PartDict)[LEFT.__Part],RECORDOF(__Partitions))),SELF:=LEFT));
    ExpandedPreEntityLayout ToExpandedPreEntity(PreEntityLayout __r) := TRANSFORM
      SELF.__Payload := PROJECT(__r.__Payload,TRANSFORM(InLayout,SELF:=__r,SELF:=LEFT));
      SELF := __r;
    END;
    __PreentitiesExpandedFiltered := PROJECT(__PreentitiesFiltered,ToExpandedPreEntity(LEFT));
    SHARED VIRTUAL __PreEntityFilter(DATASET(ExpandedPreEntityLayout) __ds) := __PreentitiesExpandedFiltered;
  END;
  SHARED E_Person_Vehicle_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Vehicle(__cfg))
    EXPORT __PreEntities := DEDUP(__Person_Vehicle_KeyList,RECORD,ALL);
    __PreEntityPayloadFilter(DATASET(PreEntityPayloadLayout) __ds, RECORDOF(__Partitions) __p) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__p.__Asof))) AND (__ds.__Permits & __p.__Using) = __ds.__Permits);
    __PreentitiesFiltered := PROJECT(__PreEntities,TRANSFORM(PreEntityLayout,SELF.__Payload:=__PreEntityPayloadFilter(LEFT.__Payload,ROW((__PartDict)[LEFT.__Part],RECORDOF(__Partitions))),SELF:=LEFT));
    ExpandedPreEntityLayout ToExpandedPreEntity(PreEntityLayout __r) := TRANSFORM
      SELF.__Payload := PROJECT(__r.__Payload,TRANSFORM(InLayout,SELF:=__r,SELF:=LEFT));
      SELF := __r;
    END;
    __PreentitiesExpandedFiltered := PROJECT(__PreentitiesFiltered,ToExpandedPreEntity(LEFT));
    SHARED VIRTUAL __PreEntityFilter(DATASET(ExpandedPreEntityLayout) __ds) := __PreentitiesExpandedFiltered;
  END;
  SHARED E_Vehicle_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(E_Vehicle(__cfg))
    EXPORT __PreEntities := JOIN(DEDUP(__Vehicle_KeyList,RECORD,ALL),B_Vehicle(__cfg).IDX_Vehicle_UID,KEYED(KEL.Indexing.Key(RIGHT.UID) = __T(LEFT.UID)),TRANSFORM(PreEntityLayout,SELF.__Part:=LEFT.__Part,SELF.UID:=__CN(RIGHT.UID),SELF:=RIGHT),ATMOST(10000));
    __PreEntityPayloadFilter(DATASET(PreEntityPayloadLayout) __ds, RECORDOF(__Partitions) __p) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__p.__Asof))) AND (__ds.__Permits & __p.__Using) = __ds.__Permits);
    __PreentitiesFiltered := PROJECT(__PreEntities,TRANSFORM(PreEntityLayout,SELF.__Payload:=__PreEntityPayloadFilter(LEFT.__Payload,ROW((__PartDict)[LEFT.__Part],RECORDOF(__Partitions))),SELF:=LEFT));
    ExpandedPreEntityLayout ToExpandedPreEntity(PreEntityLayout __r) := TRANSFORM
      SELF.__Payload := PROJECT(__r.__Payload,TRANSFORM(InLayout,SELF:=__r,SELF:=LEFT));
      SELF := __r;
    END;
    __PreentitiesExpandedFiltered := PROJECT(__PreentitiesFiltered,ToExpandedPreEntity(LEFT));
    SHARED VIRTUAL __PreEntityFilter(DATASET(ExpandedPreEntityLayout) __ds) := __PreentitiesExpandedFiltered;
  END;
  SHARED B_Person_Vehicle_10_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_10(__cfg))
    SHARED TYPEOF(E_Person_Vehicle(__cfg).__Result) __E_Person_Vehicle := E_Person_Vehicle_Local(__cfg).__Result;
  END;
  SHARED B_Person_Vehicle_9_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_9(__cfg))
    SHARED TYPEOF(B_Person_Vehicle_10(__cfg).__ENH_Person_Vehicle_10) __ENH_Person_Vehicle_10 := B_Person_Vehicle_10_Local(__cfg).__ENH_Person_Vehicle_10;
  END;
  SHARED B_Vehicle_9_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Vehicle_9(__cfg))
    SHARED TYPEOF(E_Vehicle(__cfg).__Result) __E_Vehicle := E_Vehicle_Local(__cfg).__Result;
  END;
  SHARED B_Person_Vehicle_8_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_8(__cfg))
    SHARED TYPEOF(B_Person_Vehicle_9(__cfg).__ENH_Person_Vehicle_9) __ENH_Person_Vehicle_9 := B_Person_Vehicle_9_Local(__cfg).__ENH_Person_Vehicle_9;
    SHARED TYPEOF(B_Vehicle_9(__cfg).__ENH_Vehicle_9) __ENH_Vehicle_9 := B_Vehicle_9_Local(__cfg).__ENH_Vehicle_9;
  END;
  SHARED B_Vehicle_8_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Vehicle_8(__cfg))
    SHARED TYPEOF(B_Vehicle_9(__cfg).__ENH_Vehicle_9) __ENH_Vehicle_9 := B_Vehicle_9_Local(__cfg).__ENH_Vehicle_9;
  END;
  SHARED B_Person_7_Local(CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_7(__cfg))
    SHARED TYPEOF(E_Person(__cfg).__Result) __E_Person := E_Person_Local(__cfg).__Result;
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
  SHARED __EE342536 := __Params;
  SHARED __EE342541 := __ENH_Person;
  SHARED __ST343772_Layout := RECORD
    KEL.typ.uid __QueryId := 0;
    KEL.typ.uid Lex_I_D__in_ := 0;
    KEL.typ.kdate P___Inp_Cln_Arch_Dt_ := 0;
    UNSIGNED8 D_P_M_ := 0;
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__cfg_Local).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__cfg_Local).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__cfg_Local).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__cfg_Local).Dunn_Data_Layout) Dunn_Data_;
    KEL.typ.nstr P_L___Ast_Veh_Auto2nd_Freq_Make_;
    KEL.typ.int P_L___Ast_Veh_Auto2nd_Freq_Make_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_Car_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_Elite_Cnt_Ev_ := 0;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_Age_Avg_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_Age_Max_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_Age_Min_;
    KEL.typ.nstr P_L___Ast_Veh_Auto_Emrg_Price_Avg_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_Price_Diff_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_Price_Max_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_Price_Min_;
    KEL.typ.nfloat P_L___Ast_Veh_Auto_Emrg_Span_Avg_;
    KEL.typ.int P_L___Ast_Veh_Auto_Exp_Cnt_Ev_ := 0;
    KEL.typ.nstr P_L___Ast_Veh_Auto_Freq_Make_;
    KEL.typ.int P_L___Ast_Veh_Auto_Freq_Make_Cnt_Ev_ := 0;
    KEL.typ.nint P_L___Ast_Veh_Auto_Last_Age_Avg_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Last_Age_Max_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Last_Age_Min_;
    KEL.typ.int P_L___Ast_Veh_Auto_Luxury_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_Make_Cnt_Ev_ := 0;
    KEL.typ.nint P_L___Ast_Veh_Auto_New_Msnc_;
    KEL.typ.nint P_L___Ast_Veh_Auto_New_Price_;
    KEL.typ.int P_L___Ast_Veh_Auto_New_Type_Indx_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_Orig_Own_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_S_U_V_Cnt_Ev_ := 0;
    KEL.typ.nint P_L___Ast_Veh_Auto_Time_Own_Span_Avg_;
    KEL.typ.int P_L___Ast_Veh_Auto_Truck_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_Van_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Other_A_T_V_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Other_Camper_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Other_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Other_Comm_Cnt_Ev_ := 0;
    KEL.typ.int P_L___Ast_Veh_Other_Mtr_Cnt_Ev_ := 0;
    KEL.typ.nint P_L___Ast_Veh_Other_New_Msnc_;
    KEL.typ.nint P_L___Ast_Veh_Other_New_Price_;
    KEL.typ.int P_L___Ast_Veh_Other_New_Type_Indx_ := 0;
    KEL.typ.int P_L___Ast_Veh_Other_Orig_Own_Cnt_Ev_ := 0;
    KEL.typ.nfloat P_L___Ast_Veh_Other_Price_Avg_;
    KEL.typ.nint P_L___Ast_Veh_Other_Price_Max_;
    KEL.typ.nint P_L___Ast_Veh_Other_Price_Min_;
    KEL.typ.int P_L___Ast_Veh_Other_Scooter_Cnt_Ev_ := 0;
    KEL.typ.nint P_L___Purch_Age_;
    KEL.typ.nint P_L___Purch_Amt_Avg_;
    KEL.typ.nint P_L___Purch_Cnt_Ev_;
    KEL.typ.nstr P_L___Purch_D_O_B_;
    KEL.typ.nstr P_L___Purch_Gender_;
    KEL.typ.nint P_L___Purch_Item_Cnt_Ev_;
    KEL.typ.nstr P_L___Purch_Marital_Status_;
    KEL.typ.nstr P_L___Purch_Max_Date_;
    KEL.typ.nstr P_L___Purch_Min_Date_;
    KEL.typ.nint P_L___Purch_New_Age_Months_;
    KEL.typ.nint P_L___Purch_New_Amt_;
    KEL.typ.nint P_L___Purch_Old_Age_Months_;
    KEL.typ.nint P_L___Purch_Tot_Ev_;
    KEL.typ.nstr P_L___Vehicle_Max_Date_;
    KEL.typ.nstr P_L___Vehicle_Min_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  __JC467974(CFG_Compile.Non_F_C_R_A_Profile_Booster_V2_Params_Layout __EE342536, B_Person(__cfg_Local).__ST7659_Layout __EE342541) := __NNEQ(__EE342541.UID,__CN(__EE342536.Lex_I_D__in_)) AND __T(__OP2(__EE342541.UID,=,__CN(__EE342536.Lex_I_D__in_))) AND __EE342536.__Part = __EE342541.__Part;
  __ST343772_Layout __JT467974(CFG_Compile.Non_F_C_R_A_Profile_Booster_V2_Params_Layout __l, B_Person(__cfg_Local).__ST7659_Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE468076 := JOIN(__EE342541,__EE342536,__JC467974(RIGHT,LEFT),__JT467974(RIGHT,LEFT),INNER,SMART);
  SHARED __ST342337_Layout := RECORD
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
    KEL.typ.uid __QueryId := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE468076,TRANSFORM(__ST342337_Layout,SELF.Lex_I_D_ := LEFT.UID,SELF := LEFT)),'__Part');
  EXPORT DBG_Params := __UNWRAP(__Params);
  EXPORT DBG_E_Person_PreEntity := __UNWRAP(E_Person_Local(__cfg_Local).__PreEntities);
  EXPORT DBG_E_Person_FilteredPreEntity := __UNWRAP(E_Person_Local(__cfg_Local).__PostFilter);
  EXPORT DBG_E_Person_Result := __UNWRAP(E_Person_Local(__cfg_Local).__Result);
  EXPORT DBG_E_Person_Vehicle_PreEntity := __UNWRAP(E_Person_Vehicle_Local(__cfg_Local).__PreEntities);
  EXPORT DBG_E_Person_Vehicle_FilteredPreEntity := __UNWRAP(E_Person_Vehicle_Local(__cfg_Local).__PostFilter);
  EXPORT DBG_E_Person_Vehicle_Result := __UNWRAP(E_Person_Vehicle_Local(__cfg_Local).__Result);
  EXPORT DBG_E_Vehicle_PreEntity := __UNWRAP(E_Vehicle_Local(__cfg_Local).__PreEntities);
  EXPORT DBG_E_Vehicle_FilteredPreEntity := __UNWRAP(E_Vehicle_Local(__cfg_Local).__PostFilter);
  EXPORT DBG_E_Vehicle_Result := __UNWRAP(E_Vehicle_Local(__cfg_Local).__Result);
  EXPORT DBG_E_Person_Vehicle_Intermediate_10 := __UNWRAP(B_Person_Vehicle_10_Local(__cfg_Local).__ENH_Person_Vehicle_10);
  EXPORT DBG_E_Person_Vehicle_Intermediate_9 := __UNWRAP(B_Person_Vehicle_9_Local(__cfg_Local).__ENH_Person_Vehicle_9);
  EXPORT DBG_E_Vehicle_Intermediate_9 := __UNWRAP(B_Vehicle_9_Local(__cfg_Local).__ENH_Vehicle_9);
  EXPORT DBG_E_Person_Vehicle_Intermediate_8 := __UNWRAP(B_Person_Vehicle_8_Local(__cfg_Local).__ENH_Person_Vehicle_8);
  EXPORT DBG_E_Vehicle_Intermediate_8 := __UNWRAP(B_Vehicle_8_Local(__cfg_Local).__ENH_Vehicle_8);
  EXPORT DBG_E_Person_Intermediate_7 := __UNWRAP(B_Person_7_Local(__cfg_Local).__ENH_Person_7);
  EXPORT DBG_E_Person_Vehicle_Intermediate_7 := __UNWRAP(B_Person_Vehicle_7_Local(__cfg_Local).__ENH_Person_Vehicle_7);
  EXPORT DBG_E_Vehicle_Intermediate_7 := __UNWRAP(B_Vehicle_7_Local(__cfg_Local).__ENH_Vehicle_7);
  EXPORT DBG_E_Person_Intermediate_6 := __UNWRAP(B_Person_6_Local(__cfg_Local).__ENH_Person_6);
  EXPORT DBG_E_Person_Vehicle_Intermediate_6 := __UNWRAP(B_Person_Vehicle_6_Local(__cfg_Local).__ENH_Person_Vehicle_6);
  EXPORT DBG_E_Vehicle_Intermediate_6 := __UNWRAP(B_Vehicle_6_Local(__cfg_Local).__ENH_Vehicle_6);
  EXPORT DBG_E_Person_Intermediate_5 := __UNWRAP(B_Person_5_Local(__cfg_Local).__ENH_Person_5);
  EXPORT DBG_E_Person_Vehicle_Intermediate_5 := __UNWRAP(B_Person_Vehicle_5_Local(__cfg_Local).__ENH_Person_Vehicle_5);
  EXPORT DBG_E_Vehicle_Intermediate_5 := __UNWRAP(B_Vehicle_5_Local(__cfg_Local).__ENH_Vehicle_5);
  EXPORT DBG_E_Person_Intermediate_4 := __UNWRAP(B_Person_4_Local(__cfg_Local).__ENH_Person_4);
  EXPORT DBG_E_Person_Vehicle_Intermediate_4 := __UNWRAP(B_Person_Vehicle_4_Local(__cfg_Local).__ENH_Person_Vehicle_4);
  EXPORT DBG_E_Vehicle_Intermediate_4 := __UNWRAP(B_Vehicle_4_Local(__cfg_Local).__ENH_Vehicle_4);
  EXPORT DBG_E_Person_Intermediate_3 := __UNWRAP(B_Person_3_Local(__cfg_Local).__ENH_Person_3);
  EXPORT DBG_E_Person_Vehicle_Intermediate_3 := __UNWRAP(B_Person_Vehicle_3_Local(__cfg_Local).__ENH_Person_Vehicle_3);
  EXPORT DBG_E_Vehicle_Intermediate_3 := __UNWRAP(B_Vehicle_3_Local(__cfg_Local).__ENH_Vehicle_3);
  EXPORT DBG_E_Person_Intermediate_2 := __UNWRAP(B_Person_2_Local(__cfg_Local).__ENH_Person_2);
  EXPORT DBG_E_Person_Vehicle_Intermediate_2 := __UNWRAP(B_Person_Vehicle_2_Local(__cfg_Local).__ENH_Person_Vehicle_2);
  EXPORT DBG_E_Vehicle_Intermediate_2 := __UNWRAP(B_Vehicle_2_Local(__cfg_Local).__ENH_Vehicle_2);
  EXPORT DBG_E_Person_Intermediate_1 := __UNWRAP(B_Person_1_Local(__cfg_Local).__ENH_Person_1);
  EXPORT DBG_E_Person_Vehicle_Intermediate_1 := __UNWRAP(B_Person_Vehicle_1_Local(__cfg_Local).__ENH_Person_Vehicle_1);
  EXPORT DBG_E_Vehicle_Intermediate_1 := __UNWRAP(B_Vehicle_1_Local(__cfg_Local).__ENH_Vehicle_1);
  EXPORT DBG_E_Person_Annotated := __UNWRAP(B_Person_Local(__cfg_Local).__ENH_Person);
END;
