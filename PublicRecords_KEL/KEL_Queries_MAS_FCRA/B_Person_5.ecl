//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Input_P_I_I_6,B_Input_P_I_I_8,B_Person_6,B_Person_7,B_Person_S_S_N_6,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Person_S_S_N,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_6(__in,__cfg).__ENH_Input_P_I_I_6) __ENH_Input_P_I_I_6 := B_Input_P_I_I_6(__in,__cfg).__ENH_Input_P_I_I_6;
  SHARED VIRTUAL TYPEOF(B_Person_6(__in,__cfg).__ENH_Person_6) __ENH_Person_6 := B_Person_6(__in,__cfg).__ENH_Person_6;
  SHARED VIRTUAL TYPEOF(B_Person_S_S_N_6(__in,__cfg).__ENH_Person_S_S_N_6) __ENH_Person_S_S_N_6 := B_Person_S_S_N_6(__in,__cfg).__ENH_Person_S_S_N_6;
  SHARED __EE1110639 := __ENH_Person_6;
  SHARED __EE1110641 := __ENH_Input_P_I_I_6;
  SHARED __ST253314_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST182698_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST223118_Layout) All_Lien_Data_;
    KEL.typ.nkdate B_U_I_L_D___D_A_T_E_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST94049_Layout) Edu_Rec_Ver_Source_List_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST94009_Layout) Edu_Rec_Ver_Source_List_Pre_;
    KEL.typ.nstr L_T_D7_Y_New_Date_;
    KEL.typ.nstr Ln_J7_Y_New_Date_;
    KEL.typ.nstr Ln_J7_Y_Old_Date_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.int P_L___Drg_L_T_D_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Ln_J_Cnt7_Y_ := 0;
    KEL.typ.nstr P___Inp_Cln_Name_First_Raw_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_Raw_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST98478_Layout) Verified_First_Name_Sources_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST98703_Layout) Verified_Last_Name_Sources_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr P___Inp_Acct_;
    KEL.typ.nint P___Inp_Lex_I_D_;
    KEL.typ.nstr P___Inp_Name_First_;
    KEL.typ.nstr P___Inp_Name_Mid_;
    KEL.typ.nstr P___Inp_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Surname1_;
    KEL.typ.nstr P___Inp_Cln_Surname2_;
    KEL.typ.ntyp(E_Surname().Typ) Last_Name1_;
    KEL.typ.ntyp(E_Surname().Typ) Last_Name2_;
    KEL.typ.nstr Address_Geo_Link_;
    KEL.typ.nstr P___Inp_Addr_Line1_;
    KEL.typ.nstr P___Inp_Addr_Line2_;
    KEL.typ.nstr P___Inp_Addr_City_;
    KEL.typ.nstr P___Inp_Addr_State_;
    KEL.typ.nstr P___Inp_Addr_Zip_;
    KEL.typ.nstr P___Inp_Phone_Home_;
    KEL.typ.nstr P___Inp_S_S_N_;
    KEL.typ.nstr P___Inp_D_O_B_;
    KEL.typ.nstr P___Inp_Phone_Work_;
    KEL.typ.nstr Input_Income_Echo_;
    KEL.typ.nstr P___Inp_D_L_;
    KEL.typ.nstr P___Inp_D_L_State_;
    KEL.typ.nstr Input_Balance_Echo_;
    KEL.typ.nstr Input_Charge_Offd_Echo_;
    KEL.typ.nstr Input_Former_Name_Echo_;
    KEL.typ.nstr P___Inp_Email_;
    KEL.typ.nstr P___Inp_I_P_Addr_;
    KEL.typ.nstr Input_Employment_Echo_;
    KEL.typ.nstr P___Inp_Arch_Dt_;
    KEL.typ.nint P___Lex_I_D_;
    KEL.typ.nint P___Lex_I_D_Score_;
    KEL.typ.nstr P___Inp_Cln_Name_Prfx_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Mid_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Name_Sffx_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr P___Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lat_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lng_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_Code_;
    KEL.typ.nstr P___Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr P___Inp_Cln_Addr_Geo_;
    KEL.typ.ntyp(E_Geo_Link().Typ) Geo_Link_I_D_;
    KEL.typ.nstr P___Inp_Cln_Addr_Type_;
    KEL.typ.nstr P___Inp_Cln_Addr_Status_;
    KEL.typ.nstr P___Inp_Cln_Email_;
    KEL.typ.ntyp(E_Email().Typ) Input_Clean_Email_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.ntyp(E_Phone().Typ) Input_Clean_Phone_;
    KEL.typ.nstr P___Inp_Cln_Phone_Work_;
    KEL.typ.nstr P___Inp_Cln_D_L_;
    KEL.typ.nstr P___Inp_Cln_D_L_State_;
    KEL.typ.nkdate P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_S_S_N__1_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Input_Clean_S_S_N_;
    KEL.typ.nint P___Inp_Cln_Arch_Dt_;
    KEL.typ.nint G___Proc_Bus_U_I_D_;
    KEL.typ.nstr Phone_Verification_Bureau_;
    KEL.typ.nstr Dial_Indicator_;
    KEL.typ.nstr Point_I_D_;
    KEL.typ.nstr N_X_X_Type_;
    KEL.typ.nbool Z_I_P_Match_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_S_C_;
    KEL.typ.nstr Wireless_Indicator_;
    KEL.typ.nint Rep_Number_;
    KEL.typ.ntyp(E_Address_Slim().Typ) Slim_Location_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ntyp(E_S_S_N_Summary().Typ) Social_Summary_;
    KEL.typ.ntyp(E_Name_Summary().Typ) Name_Summ_;
    KEL.typ.ntyp(E_Phone_Summary().Typ) Telephone_Summary_;
    KEL.typ.ntyp(E_Address_Summary().Typ) Location_Summary_;
    KEL.typ.nstr Current_Addr_Prim_Rng_;
    KEL.typ.nstr Current_Addr_Pre_Dir_;
    KEL.typ.nstr Current_Addr_Prim_Name_;
    KEL.typ.nstr Current_Addr_Sffx_;
    KEL.typ.nstr Current_Addr_Sec_Rng_;
    KEL.typ.nstr Current_Addr_State_;
    KEL.typ.nstr Current_Addr_Zip5_;
    KEL.typ.nstr Current_Addr_Zip4_;
    KEL.typ.nstr Current_Addr_State_Code_;
    KEL.typ.nstr Current_Addr_Cnty_;
    KEL.typ.nstr Current_Addr_Geo_;
    KEL.typ.nstr Current_Addr_City_;
    KEL.typ.nstr Current_Addr_Post_Dir_;
    KEL.typ.nstr Current_Addr_Lat_;
    KEL.typ.nstr Current_Addr_Lng_;
    KEL.typ.nstr Current_Addr_Unit_Designation_;
    KEL.typ.nstr Current_Addr_Type_;
    KEL.typ.nstr Current_Addr_Status_;
    KEL.typ.nkdate Current_Addr_Date_First_Seen_;
    KEL.typ.nkdate Current_Addr_Date_Last_Seen_;
    KEL.typ.nstr Current_Addr_Full_;
    KEL.typ.ntyp(E_Address().Typ) Current_Address_;
    KEL.typ.nstr Previous_Addr_Prim_Rng_;
    KEL.typ.nstr Previous_Addr_Pre_Dir_;
    KEL.typ.nstr Previous_Addr_Prim_Name_;
    KEL.typ.nstr Previous_Addr_Sffx_;
    KEL.typ.nstr Previous_Addr_Sec_Rng_;
    KEL.typ.nstr Previous_Addr_State_;
    KEL.typ.nstr Previous_Addr_Zip5_;
    KEL.typ.nstr Previous_Addr_Zip4_;
    KEL.typ.nstr Previous_Addr_State_Code_;
    KEL.typ.nstr Previous_Addr_Cnty_;
    KEL.typ.nstr Previous_Addr_Geo_;
    KEL.typ.nstr Previous_Addr_City_;
    KEL.typ.nstr Previous_Addr_Post_Dir_;
    KEL.typ.nstr Previous_Addr_Lat_;
    KEL.typ.nstr Previous_Addr_Lng_;
    KEL.typ.nstr Previous_Addr_Unit_Designation_;
    KEL.typ.nstr Previous_Addr_Type_;
    KEL.typ.nstr Previous_Addr_Status_;
    KEL.typ.nkdate Previous_Addr_Date_First_Seen_;
    KEL.typ.nkdate Previous_Addr_Date_Last_Seen_;
    KEL.typ.nstr Previous_Addr_Full_;
    KEL.typ.ntyp(E_Address().Typ) Previous_Address_;
    KEL.typ.nstr Input_S_S_N_Clean_Value_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1110650(B_Person_6(__in,__cfg).__ST182693_Layout __EE1110639, B_Input_P_I_I_8(__in,__cfg).__ST174910_Layout __EE1110641) := __EEQP(__EE1110639.P_I_I_,__EE1110641.UID);
  __ST253314_Layout __JT1110650(B_Person_6(__in,__cfg).__ST182693_Layout __l, B_Input_P_I_I_8(__in,__cfg).__ST174910_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF.P___Inp_Cln_S_S_N__1_ := __r.P___Inp_Cln_S_S_N_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1110913 := JOIN(__EE1110639,__EE1110641,__JC1110650(LEFT,RIGHT),__JT1110650(LEFT,RIGHT),LEFT OUTER,SMART);
  SHARED __EE1110915 := __ENH_Person_S_S_N_6;
  SHARED __EE1114965 := __EE1110915(__T(__AND(__EE1110915.Input_S_S_N_Match_,__CN(__NN(__EE1110915.Subject_)))));
  SHARED __EE1114981 := __EE1114965.Valid_S_S_N_;
  __JC1114984(E_Person_S_S_N(__in,__cfg).Valid_S_S_N_Layout __EE1114981) := __T(__OP2(__EE1114981.Valid_S_S_N_,IN,__CN(['G','Z','R','O','F'])));
  SHARED __EE1114985 := __EE1114965(EXISTS(__CHILDJOINFILTER(__EE1114981,__JC1114984)));
  SHARED __ST253148_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Valid_S_S_N_Layout) Valid_S_S_N_;
    KEL.typ.ndataset(B_Person_S_S_N_6(__in,__cfg).__ST173384_Layout) Data_Sources_;
    KEL.typ.nbool Input_S_S_N_Match_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool F_D_N_Indicator_;
    KEL.typ.nbool Death_Master_Flag_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1115021(B_Person_S_S_N_6(__in,__cfg).__ST173376_Layout __EE1114985, B_Person_S_S_N_6(__in,__cfg).__ST173384_Layout __EE1115002) := __T(__AND(__EE1115002.Header_Hit_Flag_,__OP2(__EE1115002.Translated_Source_Code_,<>,__CN(''))));
  __ST253148_Layout __JT1115021(B_Person_S_S_N_6(__in,__cfg).__ST173376_Layout __l, B_Person_S_S_N_6(__in,__cfg).__ST173384_Layout __r) := TRANSFORM, SKIP(NOT(__JC1115021(__l,__r)))
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1115022 := NORMALIZE(__EE1114985,__T(LEFT.Data_Sources_),__JT1115021(LEFT,RIGHT));
  SHARED __ST1114028_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE1115055 := PROJECT(TABLE(PROJECT(__EE1115022,__ST1114028_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Subject_,Translated_Source_Code_},Subject_,Translated_Source_Code_,MERGE),__ST1114028_Layout);
  SHARED __ST1114046_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST182698_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST223118_Layout) All_Lien_Data_;
    KEL.typ.nkdate B_U_I_L_D___D_A_T_E_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST94049_Layout) Edu_Rec_Ver_Source_List_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST94009_Layout) Edu_Rec_Ver_Source_List_Pre_;
    KEL.typ.nstr L_T_D7_Y_New_Date_;
    KEL.typ.nstr Ln_J7_Y_New_Date_;
    KEL.typ.nstr Ln_J7_Y_Old_Date_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.int P_L___Drg_L_T_D_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Ln_J_Cnt7_Y_ := 0;
    KEL.typ.nstr P___Inp_Cln_Name_First_Raw_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_Raw_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST98478_Layout) Verified_First_Name_Sources_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST98703_Layout) Verified_Last_Name_Sources_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr P___Inp_Acct_;
    KEL.typ.nint P___Inp_Lex_I_D_;
    KEL.typ.nstr P___Inp_Name_First_;
    KEL.typ.nstr P___Inp_Name_Mid_;
    KEL.typ.nstr P___Inp_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Surname1_;
    KEL.typ.nstr P___Inp_Cln_Surname2_;
    KEL.typ.ntyp(E_Surname().Typ) Last_Name1_;
    KEL.typ.ntyp(E_Surname().Typ) Last_Name2_;
    KEL.typ.nstr Address_Geo_Link_;
    KEL.typ.nstr P___Inp_Addr_Line1_;
    KEL.typ.nstr P___Inp_Addr_Line2_;
    KEL.typ.nstr P___Inp_Addr_City_;
    KEL.typ.nstr P___Inp_Addr_State_;
    KEL.typ.nstr P___Inp_Addr_Zip_;
    KEL.typ.nstr P___Inp_Phone_Home_;
    KEL.typ.nstr P___Inp_S_S_N_;
    KEL.typ.nstr P___Inp_D_O_B_;
    KEL.typ.nstr P___Inp_Phone_Work_;
    KEL.typ.nstr Input_Income_Echo_;
    KEL.typ.nstr P___Inp_D_L_;
    KEL.typ.nstr P___Inp_D_L_State_;
    KEL.typ.nstr Input_Balance_Echo_;
    KEL.typ.nstr Input_Charge_Offd_Echo_;
    KEL.typ.nstr Input_Former_Name_Echo_;
    KEL.typ.nstr P___Inp_Email_;
    KEL.typ.nstr P___Inp_I_P_Addr_;
    KEL.typ.nstr Input_Employment_Echo_;
    KEL.typ.nstr P___Inp_Arch_Dt_;
    KEL.typ.nint P___Lex_I_D_;
    KEL.typ.nint P___Lex_I_D_Score_;
    KEL.typ.nstr P___Inp_Cln_Name_Prfx_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Mid_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Name_Sffx_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr P___Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lat_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lng_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_Code_;
    KEL.typ.nstr P___Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr P___Inp_Cln_Addr_Geo_;
    KEL.typ.ntyp(E_Geo_Link().Typ) Geo_Link_I_D_;
    KEL.typ.nstr P___Inp_Cln_Addr_Type_;
    KEL.typ.nstr P___Inp_Cln_Addr_Status_;
    KEL.typ.nstr P___Inp_Cln_Email_;
    KEL.typ.ntyp(E_Email().Typ) Input_Clean_Email_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.ntyp(E_Phone().Typ) Input_Clean_Phone_;
    KEL.typ.nstr P___Inp_Cln_Phone_Work_;
    KEL.typ.nstr P___Inp_Cln_D_L_;
    KEL.typ.nstr P___Inp_Cln_D_L_State_;
    KEL.typ.nkdate P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_S_S_N__1_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Input_Clean_S_S_N_;
    KEL.typ.nint P___Inp_Cln_Arch_Dt_;
    KEL.typ.nint G___Proc_Bus_U_I_D_;
    KEL.typ.nstr Phone_Verification_Bureau_;
    KEL.typ.nstr Dial_Indicator_;
    KEL.typ.nstr Point_I_D_;
    KEL.typ.nstr N_X_X_Type_;
    KEL.typ.nbool Z_I_P_Match_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_S_C_;
    KEL.typ.nstr Wireless_Indicator_;
    KEL.typ.nint Rep_Number_;
    KEL.typ.ntyp(E_Address_Slim().Typ) Slim_Location_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ntyp(E_S_S_N_Summary().Typ) Social_Summary_;
    KEL.typ.ntyp(E_Name_Summary().Typ) Name_Summ_;
    KEL.typ.ntyp(E_Phone_Summary().Typ) Telephone_Summary_;
    KEL.typ.ntyp(E_Address_Summary().Typ) Location_Summary_;
    KEL.typ.nstr Current_Addr_Prim_Rng_;
    KEL.typ.nstr Current_Addr_Pre_Dir_;
    KEL.typ.nstr Current_Addr_Prim_Name_;
    KEL.typ.nstr Current_Addr_Sffx_;
    KEL.typ.nstr Current_Addr_Sec_Rng_;
    KEL.typ.nstr Current_Addr_State_;
    KEL.typ.nstr Current_Addr_Zip5_;
    KEL.typ.nstr Current_Addr_Zip4_;
    KEL.typ.nstr Current_Addr_State_Code_;
    KEL.typ.nstr Current_Addr_Cnty_;
    KEL.typ.nstr Current_Addr_Geo_;
    KEL.typ.nstr Current_Addr_City_;
    KEL.typ.nstr Current_Addr_Post_Dir_;
    KEL.typ.nstr Current_Addr_Lat_;
    KEL.typ.nstr Current_Addr_Lng_;
    KEL.typ.nstr Current_Addr_Unit_Designation_;
    KEL.typ.nstr Current_Addr_Type_;
    KEL.typ.nstr Current_Addr_Status_;
    KEL.typ.nkdate Current_Addr_Date_First_Seen_;
    KEL.typ.nkdate Current_Addr_Date_Last_Seen_;
    KEL.typ.nstr Current_Addr_Full_;
    KEL.typ.ntyp(E_Address().Typ) Current_Address_;
    KEL.typ.nstr Previous_Addr_Prim_Rng_;
    KEL.typ.nstr Previous_Addr_Pre_Dir_;
    KEL.typ.nstr Previous_Addr_Prim_Name_;
    KEL.typ.nstr Previous_Addr_Sffx_;
    KEL.typ.nstr Previous_Addr_Sec_Rng_;
    KEL.typ.nstr Previous_Addr_State_;
    KEL.typ.nstr Previous_Addr_Zip5_;
    KEL.typ.nstr Previous_Addr_Zip4_;
    KEL.typ.nstr Previous_Addr_State_Code_;
    KEL.typ.nstr Previous_Addr_Cnty_;
    KEL.typ.nstr Previous_Addr_Geo_;
    KEL.typ.nstr Previous_Addr_City_;
    KEL.typ.nstr Previous_Addr_Post_Dir_;
    KEL.typ.nstr Previous_Addr_Lat_;
    KEL.typ.nstr Previous_Addr_Lng_;
    KEL.typ.nstr Previous_Addr_Unit_Designation_;
    KEL.typ.nstr Previous_Addr_Type_;
    KEL.typ.nstr Previous_Addr_Status_;
    KEL.typ.nkdate Previous_Addr_Date_First_Seen_;
    KEL.typ.nkdate Previous_Addr_Date_Last_Seen_;
    KEL.typ.nstr Previous_Addr_Full_;
    KEL.typ.ntyp(E_Address().Typ) Previous_Address_;
    KEL.typ.nstr Input_S_S_N_Clean_Value_;
    KEL.typ.ndataset(__ST1114028_Layout) Person_S_S_N_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1115061(__ST253314_Layout __EE1110913, __ST1114028_Layout __EE1115055) := __EEQP(__EE1110913.UID,__EE1115055.Subject_);
  __ST1114046_Layout __Join__ST1114046_Layout(__ST253314_Layout __r, DATASET(__ST1114028_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Person_S_S_N_ := __CN(__recs);
  END;
  SHARED __EE1115324 := DENORMALIZE(DISTRIBUTE(__EE1110913,HASH(UID)),DISTRIBUTE(__EE1115055,HASH(Subject_)),__JC1115061(LEFT,RIGHT),GROUP,__Join__ST1114046_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST183310_Layout := RECORD
    KEL.typ.nstr Title_;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Middle_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Name_Suffix_;
    KEL.typ.nstr Name_Score_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool Best_;
    KEL.typ.nstr Source_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST183336_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool F_D_N_Indicator_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST98938_Layout := RECORD
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST98540_Layout := RECORD
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.nstr Source_Date_First_Seen_;
    KEL.typ.nstr First_Seen_Date_;
    KEL.typ.nstr Source_Date_Last_Seen_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST98765_Layout := RECORD
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.nstr Source_Date_First_Seen_;
    KEL.typ.nstr First_Seen_Date_;
    KEL.typ.nstr Source_Date_Last_Seen_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST183305_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(__ST183310_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(__ST183336_Layout) Data_Sources_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST223118_Layout) All_Lien_Data_;
    KEL.typ.nkdate B_U_I_L_D___D_A_T_E_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST94049_Layout) Edu_Rec_Ver_Source_List_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST94009_Layout) Edu_Rec_Ver_Source_List_Pre_;
    KEL.typ.ndataset(B_Person_6(__in,__cfg).__ST94049_Layout) Edu_Rec_Ver_Source_List_Sorted_;
    KEL.typ.nstr L_T_D7_Y_New_Date_;
    KEL.typ.nstr L_T_D7_Y_Old_Date_;
    KEL.typ.nstr Ln_J7_Y_New_Date_;
    KEL.typ.nstr Ln_J7_Y_Old_Date_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.int P_L___Drg_L_T_D_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_L_T_D_New_Dt7_Y_;
    KEL.typ.int P_L___Drg_Ln_J_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Ln_J_New_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Ln_J_Old_Dt7_Y_;
    KEL.typ.nstr P___Inp_Cln_Name_First_Raw_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_Raw_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.nstr P___Inp_S_S_N_Raw_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.ndataset(__ST98938_Layout) S_S_N_Translated_Sources_;
    KEL.typ.ndataset(__ST98540_Layout) Verified_First_Name_Sources_With_Dates_;
    KEL.typ.ndataset(__ST98765_Layout) Verified_Last_Name_Sources_With_Dates_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST183305_Layout __ND1115349__Project(__ST1114046_Layout __PP1115345) := TRANSFORM
    __EE1115327 := __PP1115345.Full_Name_;
    SELF.Full_Name_ := __BN(PROJECT(__T(__EE1115327),__ST183310_Layout),__NL(__EE1115327));
    __EE1115331 := __PP1115345.Data_Sources_;
    __ST183336_Layout __ND1115534__Project(E_Person(__in,__cfg).Data_Sources_Layout __PP1115530) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP1115530.Source_));
      SELF := __PP1115530;
    END;
    SELF.Data_Sources_ := __PROJECT(__EE1115331,__ND1115534__Project(LEFT));
    __EE1115570 := __PP1115345.Edu_Rec_Ver_Source_List_;
    __CC13980 := '-99997';
    __BS1115574 := __T(__EE1115570);
    __EE1115587 := __BN(TOPN(__BS1115574(__NN(__OP2(__T(__EE1115570).Source_Date_Last_Seen_,=,__CN(__CC13980))) AND __NN(__T(__EE1115570).Source_Date_Last_Seen_) AND __NN(__T(__EE1115570).Source_Date_First_Seen_)),1000,__T(__OP2(__T(__EE1115570).Source_Date_Last_Seen_,=,__CN(__CC13980))),__T(__T(__EE1115570).Source_Date_Last_Seen_),__T(__T(__EE1115570).Source_Date_First_Seen_),__T(College_Code_),__T(College_Type_),__T(File_Type_),__T(Tier_),__T(Tier2_)),__NL(__EE1115570));
    SELF.Edu_Rec_Ver_Source_List_Sorted_ := __EE1115587;
    __EE1115594 := __PP1115345.All_Lien_Data_;
    __BS1115598 := __T(__EE1115594);
    __EE1115606 := __BS1115598(__T(__AND(__T(__EE1115594).Seen___In___Seven___Years_,__T(__EE1115594).Is_Landlord_Tenant_Dispute_)));
    __CC13950 := '-99997';
    SELF.L_T_D7_Y_Old_Date_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__ECAST(KEL.typ.nstr,KEL.Aggregates.MinN(__EE1115606,__EE1115606.Original_Filing_Date_))),__ECAST(KEL.typ.nstr,__CN(__CC13950)));
    __CC13940 := '-99999';
    __CC13945 := '-99998';
    __BS1115635 := __T(__PP1115345.All_Lien_Data_);
    SELF.P_L___Drg_L_T_D_New_Dt7_Y_ := MAP(__PP1115345.P___Lex_I_D_Seen_Flag_ = '0'=>__ECAST(KEL.typ.nstr,__CN(__CC13940)),__PP1115345.P_L___Drg_L_T_D_Cnt7_Y_ < 1=>__ECAST(KEL.typ.nstr,__CN(__CC13945)), NOT EXISTS(__BS1115635(__T(__AND(__NOT(__OP2(__ECAST(KEL.typ.nstr,__T(__PP1115345.All_Lien_Data_).Original_Filing_Date_),=,__CN(__CC13950))),__AND(__T(__PP1115345.All_Lien_Data_).Seen___In___Seven___Years_,__T(__PP1115345.All_Lien_Data_).Is_Landlord_Tenant_Dispute_)))))=>__ECAST(KEL.typ.nstr,__CN(__CC13950)),__ECAST(KEL.typ.nstr,__PP1115345.L_T_D7_Y_New_Date_));
    __BS1115671 := __T(__PP1115345.All_Lien_Data_);
    SELF.P_L___Drg_Ln_J_New_Dt7_Y_ := MAP(__PP1115345.P___Lex_I_D_Seen_Flag_ = '0'=>__ECAST(KEL.typ.nstr,__CN(__CC13940)),__PP1115345.P_L___Drg_Ln_J_Cnt7_Y_ < 1=>__ECAST(KEL.typ.nstr,__CN(__CC13945)), NOT EXISTS(__BS1115671(__T(__AND(__NOT(__OP2(__ECAST(KEL.typ.nstr,__T(__PP1115345.All_Lien_Data_).Original_Filing_Date_),=,__CN(__CC13950))),__AND(__T(__PP1115345.All_Lien_Data_).Seen___In___Seven___Years_,__T(__PP1115345.All_Lien_Data_).Is_Over_All_Lien_Judgment_)))))=>__ECAST(KEL.typ.nstr,__CN(__CC13950)),__ECAST(KEL.typ.nstr,__PP1115345.Ln_J7_Y_New_Date_));
    __BS1115705 := __T(__PP1115345.All_Lien_Data_);
    SELF.P_L___Drg_Ln_J_Old_Dt7_Y_ := MAP(__PP1115345.P___Lex_I_D_Seen_Flag_ = '0'=>__ECAST(KEL.typ.nstr,__CN(__CC13940)),__PP1115345.P_L___Drg_Ln_J_Cnt7_Y_ < 1=>__ECAST(KEL.typ.nstr,__CN(__CC13945)), NOT EXISTS(__BS1115705(__T(__AND(__NOT(__OP2(__ECAST(KEL.typ.nstr,__T(__PP1115345.All_Lien_Data_).Original_Filing_Date_),=,__CN(__CC13950))),__AND(__T(__PP1115345.All_Lien_Data_).Seen___In___Seven___Years_,__T(__PP1115345.All_Lien_Data_).Is_Over_All_Lien_Judgment_)))))=>__ECAST(KEL.typ.nstr,__CN(__CC13950)),__ECAST(KEL.typ.nstr,__PP1115345.Ln_J7_Y_Old_Date_));
    SELF.P___Inp_S_S_N_Raw_ := __PP1115345.P___Inp_S_S_N_;
    __EE1115343 := __PP1115345.Person_S_S_N_;
    SELF.S_S_N_Translated_Sources_ := __PROJECT(__EE1115343,__ST98938_Layout);
    __EE1115335 := __PP1115345.Verified_First_Name_Sources_;
    __ST98540_Layout __ND1115756__Project(B_Person_6(__in,__cfg).__ST98478_Layout __PP1115752) := TRANSFORM
      __CC13154 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('header_build_version'))),__CN(__cfg.CurrentDate));
      __CC13980 := '-99997';
      SELF.Source_Date_First_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP1115752.Date_First_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1115752.Date_First_Seen_),__CC13154),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13980)));
      __CC74388 := '99999999';
      SELF.First_Seen_Date_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP1115752.Date_First_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1115752.Date_First_Seen_),__CC13154),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC74388)));
      SELF.Source_Date_Last_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP1115752.Date_Last_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1115752.Date_Last_Seen_),__CC13154),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13980)));
      SELF.Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,KEL.era.ToDate(__PP1115752.Date_Last_Seen_)),__ECAST(KEL.typ.nkdate,__CC13154));
      SELF := __PP1115752;
    END;
    SELF.Verified_First_Name_Sources_With_Dates_ := __PROJECT(__EE1115335,__ND1115756__Project(LEFT));
    __EE1115339 := __PP1115345.Verified_Last_Name_Sources_;
    __ST98765_Layout __ND1115815__Project(B_Person_6(__in,__cfg).__ST98703_Layout __PP1115811) := TRANSFORM
      __CC13154 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('header_build_version'))),__CN(__cfg.CurrentDate));
      __CC13980 := '-99997';
      SELF.Source_Date_First_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP1115811.Date_First_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1115811.Date_First_Seen_),__CC13154),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13980)));
      __CC74388 := '99999999';
      SELF.First_Seen_Date_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP1115811.Date_First_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1115811.Date_First_Seen_),__CC13154),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC74388)));
      SELF.Source_Date_Last_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP1115811.Date_Last_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP1115811.Date_Last_Seen_),__CC13154),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13980)));
      SELF.Age_In_Days_ := FN_Compile(__cfg).FN_A_B_S_D_A_Y_S_B_E_T_W_E_E_N(__ECAST(KEL.typ.nkdate,KEL.era.ToDate(__PP1115811.Date_Last_Seen_)),__ECAST(KEL.typ.nkdate,__CC13154));
      SELF := __PP1115811;
    END;
    SELF.Verified_Last_Name_Sources_With_Dates_ := __PROJECT(__EE1115339,__ND1115815__Project(LEFT));
    SELF := __PP1115345;
  END;
  EXPORT __ENH_Person_5 := PROJECT(__EE1115324,__ND1115349__Project(LEFT));
END;
