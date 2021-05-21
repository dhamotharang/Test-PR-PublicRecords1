//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person,B_Person_1,B_Person_2,B_Person_3,B_Person_4,B_Person_5,B_Person_6,B_Person_S_S_N_1,B_Person_S_S_N_2,CFG_Compile,E_Address,E_Geo_Link,E_Person,E_Person_Address,E_Person_S_S_N,E_Social_Security_Number,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_Shared;
IMPORT * FROM KEL16.Null;
EXPORT Q_Mini_Attributes_V1_Roxie_Dynamic(SET OF KEL.typ.uid __PLexID_in, KEL.typ.kdate __PP_InpClnArchDt, DATA57 __PDPM, KEL.typ.bool __PIsFCRA, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Person_Filtered := MODULE(E_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Address_Filtered := MODULE(E_Person_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_S_S_N_Filtered := MODULE(E_Person_S_S_N(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED B_Person_6_Local := MODULE(B_Person_6(__in,__cfg_Local))
    SHARED TYPEOF(E_Person(__in,__cfg_Local).__Result) __E_Person := E_Person_Filtered.__Result;
    SHARED TYPEOF(E_Person_Address(__in,__cfg_Local).__Result) __E_Person_Address := E_Person_Address_Filtered.__Result;
  END;
  SHARED B_Person_5_Local := MODULE(B_Person_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_6(__in,__cfg_Local).__ENH_Person_6) __ENH_Person_6 := B_Person_6_Local.__ENH_Person_6;
  END;
  SHARED B_Person_4_Local := MODULE(B_Person_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_5(__in,__cfg_Local).__ENH_Person_5) __ENH_Person_5 := B_Person_5_Local.__ENH_Person_5;
  END;
  SHARED B_Person_3_Local := MODULE(B_Person_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_4(__in,__cfg_Local).__ENH_Person_4) __ENH_Person_4 := B_Person_4_Local.__ENH_Person_4;
  END;
  SHARED B_Person_2_Local := MODULE(B_Person_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_3(__in,__cfg_Local).__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local.__ENH_Person_3;
    SHARED TYPEOF(E_Person_Address(__in,__cfg_Local).__Result) __E_Person_Address := E_Person_Address_Filtered.__Result;
  END;
  SHARED B_Person_S_S_N_2_Local := MODULE(B_Person_S_S_N_2(__in,__cfg_Local))
    SHARED TYPEOF(E_Person_S_S_N(__in,__cfg_Local).__Result) __E_Person_S_S_N := E_Person_S_S_N_Filtered.__Result;
  END;
  SHARED B_Person_1_Local := MODULE(B_Person_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_2(__in,__cfg_Local).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local.__ENH_Person_2;
    SHARED TYPEOF(B_Person_S_S_N_2(__in,__cfg_Local).__ENH_Person_S_S_N_2) __ENH_Person_S_S_N_2 := B_Person_S_S_N_2_Local.__ENH_Person_S_S_N_2;
  END;
  SHARED B_Person_S_S_N_1_Local := MODULE(B_Person_S_S_N_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_S_S_N_2(__in,__cfg_Local).__ENH_Person_S_S_N_2) __ENH_Person_S_S_N_2 := B_Person_S_S_N_2_Local.__ENH_Person_S_S_N_2;
  END;
  SHARED B_Person_Local := MODULE(B_Person(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_1(__in,__cfg_Local).__ENH_Person_1) __ENH_Person_1 := B_Person_1_Local.__ENH_Person_1;
    SHARED TYPEOF(B_Person_S_S_N_1(__in,__cfg_Local).__ENH_Person_S_S_N_1) __ENH_Person_S_S_N_1 := B_Person_S_S_N_1_Local.__ENH_Person_S_S_N_1;
  END;
  SHARED TYPEOF(B_Person(__in,__cfg_Local).__ENH_Person) __ENH_Person := B_Person_Local.__ENH_Person;
  SHARED __EE194363 := __ENH_Person;
  SHARED __EE194980 := __EE194363(__T(__OP2(__EE194363.UID,IN,__CN(__PLexID_in))));
  SHARED __ST82174_Layout := RECORD
    KEL.typ.nuid Lex_I_D_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.nstr Prep_Current_Addr_Prim_Rng_;
    KEL.typ.nstr Prep_Current_Addr_Pre_Dir_;
    KEL.typ.nstr Prep_Current_Addr_Prim_Name_;
    KEL.typ.nstr Prep_Current_Postdirectional_;
    KEL.typ.nstr Prep_Current_Addr_Sffx_;
    KEL.typ.nstr Prep_Current_Addr_Sec_Rng_;
    KEL.typ.nstr Prep_Current_Addr_State_;
    KEL.typ.nstr Prep_Current_Addr_Zip5_;
    KEL.typ.nstr Prep_Current_Addr_Zip4_;
    KEL.typ.nstr Prep_Current_Addr_State_Code_;
    KEL.typ.nstr Prep_Current_Addr_Cnty_;
    KEL.typ.nstr Prep_Current_Addr_Geo_;
    KEL.typ.nstr Prep_Current_Addr_City_;
    KEL.typ.nstr Prep_Current_Addr_Lat_;
    KEL.typ.nstr Prep_Current_Addr_Lng_;
    KEL.typ.nstr Prep_Current_Addr_Unit_Designation_;
    KEL.typ.nstr Prep_Current_Addr_Type_;
    KEL.typ.nstr Prep_Current_Addr_Status_;
    KEL.typ.nstr Prep_Current_Addr_Date_First_Seen_;
    KEL.typ.nstr Prep_Current_Addr_Date_Last_Seen_;
    KEL.typ.nstr Prep_Current_Addr_Full_;
    KEL.typ.nstr Prep_Previous_Addr_Prim_Rng_;
    KEL.typ.nstr Prep_Previous_Addr_Pre_Dir_;
    KEL.typ.nstr Prep_Previous_Addr_Prim_Name_;
    KEL.typ.nstr Prep_Previous_Postdirectional_;
    KEL.typ.nstr Prep_Previous_Addr_Sffx_;
    KEL.typ.nstr Prep_Previous_Addr_Sec_Rng_;
    KEL.typ.nstr Prep_Previous_Addr_State_;
    KEL.typ.nstr Prep_Previous_Addr_Zip5_;
    KEL.typ.nstr Prep_Previous_Addr_Zip4_;
    KEL.typ.nstr Prep_Previous_Addr_State_Code_;
    KEL.typ.nstr Prep_Previous_Addr_Cnty_;
    KEL.typ.nstr Prep_Previous_Addr_Geo_;
    KEL.typ.nstr Prep_Previous_Addr_City_;
    KEL.typ.nstr Prep_Previous_Addr_Lat_;
    KEL.typ.nstr Prep_Previous_Addr_Lng_;
    KEL.typ.nstr Prep_Previous_Addr_Unit_Designation_;
    KEL.typ.nstr Prep_Previous_Addr_Type_;
    KEL.typ.nstr Prep_Previous_Addr_Status_;
    KEL.typ.nstr Prep_Previous_Addr_Date_First_Seen_;
    KEL.typ.nstr Prep_Previous_Addr_Date_Last_Seen_;
    KEL.typ.nstr Prep_Previous_Addr_Full_;
    KEL.typ.nstr Emerging_Addr_Prim_Rng_;
    KEL.typ.nstr Emerging_Addr_Pre_Dir_;
    KEL.typ.nstr Emerging_Addr_Prim_Name_;
    KEL.typ.nstr Emerging_Postdirectional_;
    KEL.typ.nstr Emerging_Addr_Sffx_;
    KEL.typ.nstr Emerging_Addr_Sec_Rng_;
    KEL.typ.nstr Emerging_Addr_State_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Emerging_Addr_Zip5_;
    KEL.typ.nstr Emerging_Addr_State_Code_;
    KEL.typ.nstr Emerging_Addr_Cnty_;
    KEL.typ.nstr Emerging_Addr_Geo_;
    KEL.typ.nstr P_L___Best_Name_First_;
    KEL.typ.nstr P_L___Best_Name_Mid_;
    KEL.typ.nstr P_L___Best_Name_Last_;
    KEL.typ.nstr P_L___Best_S_S_N_;
    KEL.typ.nstr P_L___Best_D_O_B_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST82174_Layout __ND194985__Project(B_Person(__in,__cfg_Local).__ST143059_Layout __PP194981) := TRANSFORM
    SELF.Lex_I_D_ := __PP194981.UID;
    SELF.P___Lex_I_D_Seen_Flag_ := IF(__PIsFCRA,__PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_,__PP194981.P___Lex_I_D_Seen_Flag_);
    SELF.Prep_Current_Addr_Prim_Rng_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_Prim_Rng_));
    SELF.Prep_Current_Addr_Pre_Dir_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_Pre_Dir_));
    SELF.Prep_Current_Addr_Prim_Name_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_Prim_Name_));
    SELF.Prep_Current_Postdirectional_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Postdirectional_));
    SELF.Prep_Current_Addr_Sffx_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_Sffx_));
    SELF.Prep_Current_Addr_Sec_Rng_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_Sec_Rng_));
    SELF.Prep_Current_Addr_State_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_State_));
    SELF.Prep_Current_Addr_Zip5_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_Zip5_));
    SELF.Prep_Current_Addr_Zip4_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_Zip4_));
    SELF.Prep_Current_Addr_State_Code_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_State_Code_));
    SELF.Prep_Current_Addr_Cnty_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_Cnty_));
    SELF.Prep_Current_Addr_Geo_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_Geo_));
    SELF.Prep_Current_Addr_City_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_City_));
    SELF.Prep_Current_Addr_Lat_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_Lat_));
    SELF.Prep_Current_Addr_Lng_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_Lng_));
    SELF.Prep_Current_Addr_Unit_Designation_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_Unit_Designation_));
    SELF.Prep_Current_Addr_Type_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_Type_));
    SELF.Prep_Current_Addr_Status_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_Status_));
    SELF.Prep_Current_Addr_Date_First_Seen_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_Date_First_Seen_));
    SELF.Prep_Current_Addr_Date_Last_Seen_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_Date_Last_Seen_));
    SELF.Prep_Current_Addr_Full_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Current_Addr_Full_));
    SELF.Prep_Previous_Addr_Prim_Rng_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_Prim_Rng_));
    SELF.Prep_Previous_Addr_Pre_Dir_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_Pre_Dir_));
    SELF.Prep_Previous_Addr_Prim_Name_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_Prim_Name_));
    SELF.Prep_Previous_Postdirectional_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Postdirectional_));
    SELF.Prep_Previous_Addr_Sffx_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_Sffx_));
    SELF.Prep_Previous_Addr_Sec_Rng_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_Sec_Rng_));
    SELF.Prep_Previous_Addr_State_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_State_));
    SELF.Prep_Previous_Addr_Zip5_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_Zip5_));
    SELF.Prep_Previous_Addr_Zip4_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_Zip4_));
    SELF.Prep_Previous_Addr_State_Code_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_State_Code_));
    SELF.Prep_Previous_Addr_Cnty_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_Cnty_));
    SELF.Prep_Previous_Addr_Geo_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_Geo_));
    SELF.Prep_Previous_Addr_City_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_City_));
    SELF.Prep_Previous_Addr_Lat_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_Lat_));
    SELF.Prep_Previous_Addr_Lng_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_Lng_));
    SELF.Prep_Previous_Addr_Unit_Designation_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_Unit_Designation_));
    SELF.Prep_Previous_Addr_Type_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_Type_));
    SELF.Prep_Previous_Addr_Status_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_Status_));
    SELF.Prep_Previous_Addr_Date_First_Seen_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_Date_First_Seen_));
    SELF.Prep_Previous_Addr_Date_Last_Seen_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_Date_Last_Seen_));
    SELF.Prep_Previous_Addr_Full_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP194981.Prep_Previous_Addr_Full_));
    __CC14178 := '-99999';
    SELF.P_L___Best_Name_First_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14178)),__ECAST(KEL.typ.nstr,__PP194981.P_L___Best_Name_First_));
    SELF.P_L___Best_Name_Mid_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14178)),__ECAST(KEL.typ.nstr,__PP194981.P_L___Best_Name_Mid_));
    SELF.P_L___Best_Name_Last_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14178)),__ECAST(KEL.typ.nstr,__PP194981.P_L___Best_Name_Last_));
    SELF.P_L___Best_S_S_N_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14178)),__ECAST(KEL.typ.nstr,__PP194981.P_L___Best_S_S_N_));
    SELF.P_L___Best_D_O_B_ := IF(__PIsFCRA AND __PP194981.P___Lex_I_D_Seen_Flag_F_C_R_A_ = '0',__ECAST(KEL.typ.nstr,__CN(__CC14178)),__ECAST(KEL.typ.nstr,__PP194981.P_L___Best_D_O_B_));
    SELF := __PP194981;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE194980,__ND194985__Project(LEFT)));
  EXPORT DBG_E_Person_Result := __UNWRAP(E_Person_Filtered.__Result);
  EXPORT DBG_E_Person_Address_Result := __UNWRAP(E_Person_Address_Filtered.__Result);
  EXPORT DBG_E_Person_S_S_N_Result := __UNWRAP(E_Person_S_S_N_Filtered.__Result);
  EXPORT DBG_E_Person_Intermediate_6 := __UNWRAP(B_Person_6_Local.__ENH_Person_6);
  EXPORT DBG_E_Person_Intermediate_5 := __UNWRAP(B_Person_5_Local.__ENH_Person_5);
  EXPORT DBG_E_Person_Intermediate_4 := __UNWRAP(B_Person_4_Local.__ENH_Person_4);
  EXPORT DBG_E_Person_Intermediate_3 := __UNWRAP(B_Person_3_Local.__ENH_Person_3);
  EXPORT DBG_E_Person_Intermediate_2 := __UNWRAP(B_Person_2_Local.__ENH_Person_2);
  EXPORT DBG_E_Person_S_S_N_Intermediate_2 := __UNWRAP(B_Person_S_S_N_2_Local.__ENH_Person_S_S_N_2);
  EXPORT DBG_E_Person_Intermediate_1 := __UNWRAP(B_Person_1_Local.__ENH_Person_1);
  EXPORT DBG_E_Person_S_S_N_Intermediate_1 := __UNWRAP(B_Person_S_S_N_1_Local.__ENH_Person_S_S_N_1);
  EXPORT DBG_E_Person_Annotated := __UNWRAP(B_Person_Local.__ENH_Person);
  EXPORT DBG_OutputAll := PARALLEL(
    OUTPUT(DBG_E_Person_Result,NAMED('DBG_E_Person_Result_Q_Mini_Attributes_V1_Roxie_Dynamic')),
    OUTPUT(DBG_E_Person_Address_Result,NAMED('DBG_E_Person_Address_Result_Q_Mini_Attributes_V1_Roxie_Dynamic')),
    OUTPUT(DBG_E_Person_S_S_N_Result,NAMED('DBG_E_Person_S_S_N_Result_Q_Mini_Attributes_V1_Roxie_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_6,NAMED('DBG_E_Person_Intermediate_6_Q_Mini_Attributes_V1_Roxie_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_5,NAMED('DBG_E_Person_Intermediate_5_Q_Mini_Attributes_V1_Roxie_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_4,NAMED('DBG_E_Person_Intermediate_4_Q_Mini_Attributes_V1_Roxie_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_3,NAMED('DBG_E_Person_Intermediate_3_Q_Mini_Attributes_V1_Roxie_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_2,NAMED('DBG_E_Person_Intermediate_2_Q_Mini_Attributes_V1_Roxie_Dynamic')),
    OUTPUT(DBG_E_Person_S_S_N_Intermediate_2,NAMED('DBG_E_Person_S_S_N_Intermediate_2_Q_Mini_Attributes_V1_Roxie_Dynamic')),
    OUTPUT(DBG_E_Person_Intermediate_1,NAMED('DBG_E_Person_Intermediate_1_Q_Mini_Attributes_V1_Roxie_Dynamic')),
    OUTPUT(DBG_E_Person_S_S_N_Intermediate_1,NAMED('DBG_E_Person_S_S_N_Intermediate_1_Q_Mini_Attributes_V1_Roxie_Dynamic')),
    OUTPUT(DBG_E_Person_Annotated,NAMED('DBG_E_Person_Annotated_Q_Mini_Attributes_V1_Roxie_Dynamic'))
  );
  EXPORT DBG_Res0 := WHEN(Res0,DBG_OutputAll);
END;
