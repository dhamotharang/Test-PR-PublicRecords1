//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Input_P_I_I_5,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Consumer;
IMPORT * FROM KEL16.Null;
EXPORT B_Input_P_I_I_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5;
  SHARED VIRTUAL TYPEOF(E_Phone(__in,__cfg).__Result) __E_Phone := E_Phone(__in,__cfg).__Result;
  SHARED __EE290224 := __ENH_Input_P_I_I_5;
  SHARED __EE166315 := __E_Phone;
  SHARED __EE295506 := __EE290224(__NN(__EE290224.Input_Clean_Phone_));
  __JC293693(E_Phone(__in,__cfg).Layout __EE166315, B_Input_P_I_I_5(__in,__cfg).__ST149696_Layout __EE295506) := __EEQP(__EE295506.Input_Clean_Phone_,__EE166315.UID);
  SHARED __EE293694 := JOIN(__EE166315,__EE295506,__JC293693(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST166958_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.nint Portability_Indicator_;
    KEL.typ.nstr Current_Flag_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nint N_X_X_Type_;
    KEL.typ.nstr Publish_Code_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_C_C_;
    KEL.typ.nint Phone_Number_Company_Type_;
    KEL.typ.nint Ported_Match_;
    KEL.typ.nstr Phone_Use_;
    KEL.typ.nstr No_Solicit_Code_;
    KEL.typ.nstr Omit_Indicator_;
    KEL.typ.nint Source_File_;
    KEL.typ.nint Iver_Indicator_;
    KEL.typ.nstr Validation_Flag_;
    KEL.typ.nstr Validation_Date_;
    KEL.typ.nstr Carrier_Name_;
    KEL.typ.nint Record_S_I_D_;
    KEL.typ.nbool Household_Flag_;
    KEL.typ.nstr Cell_Phone_;
    KEL.typ.nstr N_P_A_;
    KEL.typ.nstr Phone7_;
    KEL.typ.nint D_I_D_;
    KEL.typ.nstr D_I_D_Score_;
    KEL.typ.nkdate Phone_Date_First_Seen_;
    KEL.typ.nkdate Phone_Date_Last_Seen_;
    KEL.typ.nkdate Phone_Date_Vendor_First_Reported_;
    KEL.typ.nkdate Phone_Date_Vendor_Last_Reported_;
    KEL.typ.nint D_T_Non_G_L_B_Last_Seen_;
    KEL.typ.nstr G_L_B_D_P_P_A_Flag_;
    KEL.typ.nstr D_I_D_Type_;
    KEL.typ.nstr Orig_Phone_;
    KEL.typ.nstr Orig_Carrier_Name_;
    KEL.typ.nstr Rec_Type_;
    KEL.typ.nstr Err_Stat_;
    KEL.typ.nint Rawaid_;
    KEL.typ.nint Cleanaid_;
    KEL.typ.nbool Current_Rec_;
    KEL.typ.nkdate First_Build_Date_;
    KEL.typ.nkdate Last_Build_Date_;
    KEL.typ.nint Ingest_T_P_E_;
    KEL.typ.nstr Verified_;
    KEL.typ.nstr Cord_Cutter_;
    KEL.typ.nstr Activity_Status_;
    KEL.typ.nstr Prepaid_;
    KEL.typ.nint Global_S_I_D_;
    KEL.typ.nstr Serv_;
    KEL.typ.nstr Line_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Prior_Area_Codes_Layout) Prior_Area_Codes_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Active_Layout) Active_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Confidence_Scores_Layout) Confidence_Scores_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Listing_Types_Layout) Listing_Types_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Phone_Types_Layout) Phone_Types_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Record_Types_Layout) Record_Types_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).High_Risk_Phone_Layout) High_Risk_Phone_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint High_Risk_S_I_C_;
    KEL.typ.nint High_Risk_N_A_I_C_S_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST166958_Layout __JT293791(E_Phone(__in,__cfg).Layout __l, E_Phone(__in,__cfg).High_Risk_Phone_Layout __r) := TRANSFORM
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE293792 := NORMALIZE(__EE293694,__T(LEFT.High_Risk_Phone_),__JT293791(LEFT,RIGHT));
  SHARED __ST301015_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint High_Risk_N_A_I_C_S_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE301019 := PROJECT(TABLE(PROJECT(__EE293792,__ST301015_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),UID,High_Risk_N_A_I_C_S_},UID,High_Risk_N_A_I_C_S_,MERGE),__ST301015_Layout);
  SHARED __ST301033_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr P___Inp_Acct_;
    KEL.typ.nint P___Inp_Lex_I_D_;
    KEL.typ.nstr P___Inp_Name_First_;
    KEL.typ.nstr P___Inp_Name_Mid_;
    KEL.typ.nstr P___Inp_Name_Last_;
    KEL.typ.ntyp(E_Surname().Typ) Last_Name_;
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
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
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
    KEL.typ.bool Addr_Not_Populated_ := FALSE;
    KEL.typ.nbool City_State_Zip_Not_Populated_;
    KEL.typ.nbool Clean_City_State_Zip_Not_Populated_;
    KEL.typ.nint D_P_P_A_Purpose_;
    KEL.typ.nint G_L_B_Purpose_;
    KEL.typ.nbool Gateway_Is_F_C_R_A_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Value_;
    KEL.typ.nstr Input_City_Clean_Value_;
    KEL.typ.nstr Input_Post_Direction_Clean_Value_;
    KEL.typ.nstr Input_Pre_Direction_Clean_Value_;
    KEL.typ.nstr Input_Primary_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Range_Clean_Value_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Value_;
    KEL.typ.nstr Input_State_Clean_Value_;
    KEL.typ.nstr Input_Street_Clean_Value_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Value_;
    KEL.typ.nstr Input_Zip4_Clean_Value_;
    KEL.typ.nstr Input_Zip5_Clean_Value_;
    KEL.typ.nstr P___Inp_Addr_;
    KEL.typ.str P___Inp_Addr_City_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_State_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_Zip_Flag_Value_ := '';
    KEL.typ.nstr P___Inp_Cln_Addr_St_Flag_Value_;
    KEL.typ.nstr Targus_Gateway_I_P_;
    KEL.typ.ndataset(__ST301015_Layout) Input_Clean_Phone__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC301030(B_Input_P_I_I_5(__in,__cfg).__ST149696_Layout __EE290224, __ST301015_Layout __EE301019) := __EEQP(__EE290224.Input_Clean_Phone_,__EE301019.UID);
  __ST301033_Layout __Join__ST301033_Layout(B_Input_P_I_I_5(__in,__cfg).__ST149696_Layout __r, DATASET(__ST301015_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Input_Clean_Phone__1_ := __CN(__recs);
  END;
  SHARED __EE301031 := DENORMALIZE(DISTRIBUTE(__EE290224,HASH(Input_Clean_Phone_)),DISTRIBUTE(__EE301019,HASH(UID)),__JC301030(LEFT,RIGHT),GROUP,__Join__ST301033_Layout(LEFT,ROWS(RIGHT)),LOCAL,SMART);
  SHARED __EE299681 := __EE166315;
  SHARED __ST301195_Layout := RECORD
    KEL.typ.ntyp(E_Phone().Typ) Input_Clean_Phone_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE301198 := PROJECT(TABLE(PROJECT(__EE290224,__ST301195_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Input_Clean_Phone_},Input_Clean_Phone_,MERGE),__ST301195_Layout);
  SHARED __ST301216_Layout := RECORD
    KEL.typ.ntyp(E_Phone().Typ) Input_Clean_Phone_;
    KEL.typ.ndataset(__ST301015_Layout) Input_Clean_Phone__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC301213(__ST301195_Layout __EE301198, __ST301015_Layout __EE301019) := __EEQP(__EE301198.Input_Clean_Phone_,__EE301019.UID);
  __ST301216_Layout __Join__ST301216_Layout(__ST301195_Layout __r, DATASET(__ST301015_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Input_Clean_Phone__1_ := __CN(__recs);
  END;
  SHARED __EE301214 := DENORMALIZE(DISTRIBUTE(__EE301198,HASH(Input_Clean_Phone_)),DISTRIBUTE(__EE301019,HASH(UID)),__JC301213(LEFT,RIGHT),GROUP,__Join__ST301216_Layout(LEFT,ROWS(RIGHT)),LOCAL,SMART);
  SHARED __EE301229 := __EE301214(__NN(__EE301214.Input_Clean_Phone_));
  __JC301235(E_Phone(__in,__cfg).Layout __EE299681, __ST301216_Layout __EE301229) := __EEQP(__EE301229.Input_Clean_Phone_,__EE299681.UID);
  SHARED __EE301319 := JOIN(__EE299681,__EE301229,__JC301235(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg).Layout,SELF:=LEFT),SMART,KEEP(1));
  SHARED __ST167082_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.nint Portability_Indicator_;
    KEL.typ.nstr Current_Flag_;
    KEL.typ.nstr Business_Flag_;
    KEL.typ.nint N_X_X_Type_;
    KEL.typ.nstr Publish_Code_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_C_C_;
    KEL.typ.nint Phone_Number_Company_Type_;
    KEL.typ.nint Ported_Match_;
    KEL.typ.nstr Phone_Use_;
    KEL.typ.nstr No_Solicit_Code_;
    KEL.typ.nstr Omit_Indicator_;
    KEL.typ.nint Source_File_;
    KEL.typ.nint Iver_Indicator_;
    KEL.typ.nstr Validation_Flag_;
    KEL.typ.nstr Validation_Date_;
    KEL.typ.nstr Carrier_Name_;
    KEL.typ.nint Record_S_I_D_;
    KEL.typ.nbool Household_Flag_;
    KEL.typ.nstr Cell_Phone_;
    KEL.typ.nstr N_P_A_;
    KEL.typ.nstr Phone7_;
    KEL.typ.nint D_I_D_;
    KEL.typ.nstr D_I_D_Score_;
    KEL.typ.nkdate Phone_Date_First_Seen_;
    KEL.typ.nkdate Phone_Date_Last_Seen_;
    KEL.typ.nkdate Phone_Date_Vendor_First_Reported_;
    KEL.typ.nkdate Phone_Date_Vendor_Last_Reported_;
    KEL.typ.nint D_T_Non_G_L_B_Last_Seen_;
    KEL.typ.nstr G_L_B_D_P_P_A_Flag_;
    KEL.typ.nstr D_I_D_Type_;
    KEL.typ.nstr Orig_Phone_;
    KEL.typ.nstr Orig_Carrier_Name_;
    KEL.typ.nstr Rec_Type_;
    KEL.typ.nstr Err_Stat_;
    KEL.typ.nint Rawaid_;
    KEL.typ.nint Cleanaid_;
    KEL.typ.nbool Current_Rec_;
    KEL.typ.nkdate First_Build_Date_;
    KEL.typ.nkdate Last_Build_Date_;
    KEL.typ.nint Ingest_T_P_E_;
    KEL.typ.nstr Verified_;
    KEL.typ.nstr Cord_Cutter_;
    KEL.typ.nstr Activity_Status_;
    KEL.typ.nstr Prepaid_;
    KEL.typ.nint Global_S_I_D_;
    KEL.typ.nstr Serv_;
    KEL.typ.nstr Line_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Prior_Area_Codes_Layout) Prior_Area_Codes_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Active_Layout) Active_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Confidence_Scores_Layout) Confidence_Scores_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Listing_Types_Layout) Listing_Types_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Phone_Types_Layout) Phone_Types_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Record_Types_Layout) Record_Types_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).High_Risk_Phone_Layout) High_Risk_Phone_;
    KEL.typ.ndataset(E_Phone(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint High_Risk_S_I_C_;
    KEL.typ.nint High_Risk_N_A_I_C_S_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __ST167082_Layout __JT301416(E_Phone(__in,__cfg).Layout __l, E_Phone(__in,__cfg).High_Risk_Phone_Layout __r) := TRANSFORM
    SELF.Archive___Date_ := __r.Archive___Date_;
    SELF.Date_First_Seen_ := __r.Date_First_Seen_;
    SELF.Date_Last_Seen_ := __r.Date_Last_Seen_;
    SELF.Hybrid_Archive_Date_ := __r.Hybrid_Archive_Date_;
    SELF.Vault_Date_Last_Seen_ := __r.Vault_Date_Last_Seen_;
    SELF.__RecordCount := __r.__RecordCount;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE301502 := NORMALIZE(__EE301319,__T(LEFT.High_Risk_Phone_),__JT301416(LEFT,RIGHT));
  SHARED __ST301844_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nint High_Risk_S_I_C_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE301848 := PROJECT(TABLE(PROJECT(__EE301502,__ST301844_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),UID,High_Risk_S_I_C_},UID,High_Risk_S_I_C_,MERGE),__ST301844_Layout);
  SHARED __ST301862_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr P___Inp_Acct_;
    KEL.typ.nint P___Inp_Lex_I_D_;
    KEL.typ.nstr P___Inp_Name_First_;
    KEL.typ.nstr P___Inp_Name_Mid_;
    KEL.typ.nstr P___Inp_Name_Last_;
    KEL.typ.ntyp(E_Surname().Typ) Last_Name_;
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
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
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
    KEL.typ.bool Addr_Not_Populated_ := FALSE;
    KEL.typ.nbool City_State_Zip_Not_Populated_;
    KEL.typ.nbool Clean_City_State_Zip_Not_Populated_;
    KEL.typ.nint D_P_P_A_Purpose_;
    KEL.typ.nint G_L_B_Purpose_;
    KEL.typ.nbool Gateway_Is_F_C_R_A_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Value_;
    KEL.typ.nstr Input_City_Clean_Value_;
    KEL.typ.nstr Input_Post_Direction_Clean_Value_;
    KEL.typ.nstr Input_Pre_Direction_Clean_Value_;
    KEL.typ.nstr Input_Primary_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Range_Clean_Value_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Value_;
    KEL.typ.nstr Input_State_Clean_Value_;
    KEL.typ.nstr Input_Street_Clean_Value_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Value_;
    KEL.typ.nstr Input_Zip4_Clean_Value_;
    KEL.typ.nstr Input_Zip5_Clean_Value_;
    KEL.typ.nstr P___Inp_Addr_;
    KEL.typ.str P___Inp_Addr_City_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_State_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_Zip_Flag_Value_ := '';
    KEL.typ.nstr P___Inp_Cln_Addr_St_Flag_Value_;
    KEL.typ.nstr Targus_Gateway_I_P_;
    KEL.typ.ndataset(__ST301015_Layout) Input_Clean_Phone__1_;
    KEL.typ.ndataset(__ST301844_Layout) Input_Clean_Phone__2_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC301859(__ST301033_Layout __EE301031, __ST301844_Layout __EE301848) := __EEQP(__EE301031.Input_Clean_Phone_,__EE301848.UID);
  __ST301862_Layout __Join__ST301862_Layout(__ST301033_Layout __r, DATASET(__ST301844_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Input_Clean_Phone__2_ := __CN(__recs);
  END;
  SHARED __EE301860 := DENORMALIZE(DISTRIBUTE(__EE301031,HASH(Input_Clean_Phone_)),DISTRIBUTE(__EE301848,HASH(UID)),__JC301859(LEFT,RIGHT),GROUP,__Join__ST301862_Layout(LEFT,ROWS(RIGHT)),LOCAL,SMART);
  EXPORT __ST82222_Layout := RECORD
    KEL.typ.nint High_Risk_N_A_I_C_S_;
    KEL.typ.nkdate Date_First_Seen_Min_N_A_I_C_S_Phone_;
    KEL.typ.nkdate Date_Last_Seen_Min_N_A_I_C_S_Phone_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST82116_Layout := RECORD
    KEL.typ.nint High_Risk_S_I_C_;
    KEL.typ.nkdate Date_First_Seen_Min_S_I_C_Phone_;
    KEL.typ.nkdate Date_Last_Seen_Min_S_I_C_Phone_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST148882_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr P___Inp_Acct_;
    KEL.typ.nint P___Inp_Lex_I_D_;
    KEL.typ.nstr P___Inp_Name_First_;
    KEL.typ.nstr P___Inp_Name_Mid_;
    KEL.typ.nstr P___Inp_Name_Last_;
    KEL.typ.ntyp(E_Surname().Typ) Last_Name_;
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
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
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
    KEL.typ.bool Addr_Not_Populated_ := FALSE;
    KEL.typ.nint At_Position_;
    KEL.typ.nbool City_State_Zip_Not_Populated_;
    KEL.typ.nbool Clean_City_State_Zip_Not_Populated_;
    KEL.typ.nint D_P_P_A_Purpose_;
    KEL.typ.nint G_L_B_Purpose_;
    KEL.typ.nbool Gateway_Is_F_C_R_A_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Value_;
    KEL.typ.nstr Input_City_Clean_Value_;
    KEL.typ.nstr Input_First_Name_Value_;
    KEL.typ.nstr Input_Full_Address_Clean_Value_;
    KEL.typ.nstr Input_Last_Name_Value_;
    KEL.typ.nstr Input_Middle_Name_Value_;
    KEL.typ.nstr Input_Post_Direction_Clean_Value_;
    KEL.typ.nstr Input_Pre_Direction_Clean_Value_;
    KEL.typ.nstr Input_Primary_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Range_Clean_Value_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Value_;
    KEL.typ.nstr Input_State_Clean_Value_;
    KEL.typ.nstr Input_Street_Clean_Value_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Value_;
    KEL.typ.nstr Input_Zip4_Clean_Value_;
    KEL.typ.nstr Input_Zip5_Clean_Value_;
    KEL.typ.nstr P___Inp_Addr_;
    KEL.typ.str P___Inp_Addr_City_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_State_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_Zip_Flag_Value_ := '';
    KEL.typ.nstr P___Inp_Cln_Addr_St_Flag_Value_;
    KEL.typ.ndataset(__ST82222_Layout) Phone_N_A_I_C_S_High_Risk_Pre_;
    KEL.typ.ndataset(__ST82116_Layout) Phone_S_I_C_High_Risk_Pre_;
    KEL.typ.nstr Targus_Gateway_I_P_;
    SET OF KEL.typ.str Targus_Results_ := [];
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST148882_Layout __ND302839__Project(__ST301862_Layout __PP302032) := TRANSFORM
    SELF.At_Position_ := FN_Compile(__cfg).FN_Find_Last_String_Instance(__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP302032.P___Inp_Email_)),__ECAST(KEL.typ.nstr,__CN('@')));
    __CC13660 := '-99999';
    SELF.Input_First_Name_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP302032.P___Inp_Name_First_),__ECAST(KEL.typ.nstr,__CN(__CC13660)));
    __CC13665 := '-99998';
    SELF.Input_Full_Address_Clean_Value_ := MAP(__T(__OR(__CN(__PP302032.Addr_Not_Populated_),__PP302032.City_State_Zip_Not_Populated_))=>__ECAST(KEL.typ.nstr,__CN(__CC13660)),__T(__OR(__OP2(__PP302032.P___Inp_Cln_Addr_St_Flag_Value_,=,__CN('0')),__PP302032.Clean_City_State_Zip_Not_Populated_))=>__ECAST(KEL.typ.nstr,__CN(__CC13665)),__ECAST(KEL.typ.nstr,__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(IF(__T(__OP2(__PP302032.Input_Primary_Range_Clean_Value_,=,__CN(__CC13665))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP302032.P___Inp_Cln_Addr_Prim_Rng_),+,__CN(' ')))),+,IF(__T(__OP2(__PP302032.Input_Pre_Direction_Clean_Value_,=,__CN(__CC13665))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP302032.P___Inp_Cln_Addr_Pre_Dir_),+,__CN(' '))))),+,IF(__T(__OP2(__PP302032.Input_Primary_Name_Clean_Value_,=,__CN(__CC13665))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP302032.P___Inp_Cln_Addr_Prim_Name_),+,__CN(' '))))),+,IF(__T(__OP2(__PP302032.Input_Address_Suffix_Clean_Value_,=,__CN(__CC13665))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP302032.P___Inp_Cln_Addr_Sffx_),+,__CN(' '))))),+,IF(__T(__OP2(__PP302032.Input_Post_Direction_Clean_Value_,=,__CN(__CC13665))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP302032.P___Inp_Cln_Addr_Post_Dir_),+,__CN(' '))))),+,IF(__T(__OP2(__PP302032.Input_Unit_Desig_Clean_Value_,=,__CN(__CC13665))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP302032.P___Inp_Cln_Addr_Unit_Desig_),+,__CN(' '))))),+,IF(__T(__OP2(__PP302032.Input_Secondary_Range_Clean_Value_,=,__CN(__CC13665))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP302032.P___Inp_Cln_Addr_Sec_Rng_),+,__CN(' '))))),+,IF(__T(__OP2(__PP302032.Input_City_Clean_Value_,=,__CN(__CC13665))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP302032.P___Inp_Cln_Addr_City_),+,__CN(' '))))),+,IF(__T(__OP2(__PP302032.Input_State_Clean_Value_,=,__CN(__CC13665))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP302032.P___Inp_Cln_Addr_State_),+,__CN(' '))))),+,IF(__T(__OP2(__PP302032.Input_Zip5_Clean_Value_,=,__CN(__CC13665))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP302032.P___Inp_Cln_Addr_Zip5_),+,__CN(' '))))),+,IF(__T(__OP2(__PP302032.Input_Zip4_Clean_Value_,=,__CN(__CC13665))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP302032.P___Inp_Cln_Addr_Zip4_))))));
    SELF.Input_Last_Name_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP302032.P___Inp_Name_Last_),__ECAST(KEL.typ.nstr,__CN(__CC13660)));
    SELF.Input_Middle_Name_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP302032.P___Inp_Name_Mid_),__ECAST(KEL.typ.nstr,__CN(__CC13660)));
    __EE302026 := __PP302032.Input_Clean_Phone__1_;
    __ST82222_Layout __ND302623__Project(__ST301015_Layout __PP302619) := TRANSFORM
      SELF.Date_First_Seen_Min_N_A_I_C_S_Phone_ := KEL.era.ToDate(__PP302619.Date_First_Seen_);
      SELF.Date_Last_Seen_Min_N_A_I_C_S_Phone_ := KEL.era.ToDate(__PP302619.Date_Last_Seen_);
      SELF := __PP302619;
    END;
    SELF.Phone_N_A_I_C_S_High_Risk_Pre_ := __PROJECT(__EE302026,__ND302623__Project(LEFT));
    __EE302030 := __PP302032.Input_Clean_Phone__2_;
    __ST82116_Layout __ND302644__Project(__ST301844_Layout __PP302640) := TRANSFORM
      SELF.Date_First_Seen_Min_S_I_C_Phone_ := KEL.era.ToDate(__PP302640.Date_First_Seen_);
      SELF.Date_Last_Seen_Min_S_I_C_Phone_ := KEL.era.ToDate(__PP302640.Date_Last_Seen_);
      SELF := __PP302640;
    END;
    SELF.Phone_S_I_C_High_Risk_Pre_ := __PROJECT(__EE302030,__ND302644__Project(LEFT));
    SELF.Targus_Results_ := FN_Compile(__cfg).FN_G_A_T_E_W_A_Y___T_A_R_G_U_S(__ECAST(KEL.typ.nstr,__PP302032.Targus_Gateway_I_P_),__ECAST(KEL.typ.nstr,__PP302032.P___Inp_Name_First_),__ECAST(KEL.typ.nstr,__PP302032.P___Inp_Name_Last_),__ECAST(KEL.typ.nstr,__PP302032.P___Inp_Phone_Home_),__ECAST(KEL.typ.nint,__PP302032.G_L_B_Purpose_),__ECAST(KEL.typ.nint,__PP302032.D_P_P_A_Purpose_),__ECAST(KEL.typ.nbool,__PP302032.Gateway_Is_F_C_R_A_));
    SELF := __PP302032;
  END;
  EXPORT __ENH_Input_P_I_I_4 := PROJECT(__EE301860,__ND302839__Project(LEFT));
END;
