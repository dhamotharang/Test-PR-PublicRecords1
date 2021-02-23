//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Input_P_I_I_3,B_Input_P_I_I_4,B_Inquiry_4,B_Person_10,B_Person_4,B_Person_5,B_Person_6,B_Person_Accident_8,B_Person_Inquiry_5,B_Phone_Summary_3,B_Property_4,CFG_Compile,E_Accident,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Household,E_Input_P_I_I,E_Inquiry,E_Name_Summary,E_Person,E_Person_Accident,E_Person_Inquiry,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Utility,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Phone_Summary_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_3(__in,__cfg).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3(__in,__cfg).__ENH_Input_P_I_I_3;
  SHARED VIRTUAL TYPEOF(B_Phone_Summary_3(__in,__cfg).__ENH_Phone_Summary_3) __ENH_Phone_Summary_3 := B_Phone_Summary_3(__in,__cfg).__ENH_Phone_Summary_3;
  SHARED __EE7574231 := __ENH_Phone_Summary_3;
  SHARED __EE7574233 := __ENH_Input_P_I_I_3;
  SHARED __ST1916525_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST292469_Layout) Address_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST292479_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST292494_Layout) Last_Name_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST1183970_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST1183981_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST1183990_Layout) Translated_Last_Name_Sources_;
    KEL.typ.nuid U_I_D__1_;
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
    KEL.typ.nstr P___Inp_Cln_Name_Last__1_;
    KEL.typ.nstr P___Inp_Cln_Name_Sffx_;
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng__1_;
    KEL.typ.nstr P___Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name__1_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr P___Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5__1_;
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
    KEL.typ.nkdate P___Inp_Cln_D_O_B__1_;
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
    KEL.typ.bool Addr_Not_Populated_ := FALSE;
    KEL.typ.nint At_Position_;
    KEL.typ.nbool City_State_Zip_Not_Populated_;
    KEL.typ.nbool Clean_City_State_Zip_Not_Populated_;
    KEL.typ.nint D_P_P_A_Purpose_;
    KEL.typ.nstr Email_Domain_;
    KEL.typ.nstr Email_Username_;
    KEL.typ.nint G_L_B_Purpose_;
    KEL.typ.nbool Gateway_Is_F_C_R_A_;
    KEL.typ.ndataset(B_Input_P_I_I_3(__in,__cfg).__ST78383_Layout) Good_Inquiries_Last_Year_For_Address_;
    KEL.typ.bool Input_Address_Matches_Address_Hierarchy_Address_ := FALSE;
    KEL.typ.nbool Input_Address_Matches_Current_Address_;
    KEL.typ.ndataset(B_Input_P_I_I_3(__in,__cfg).__ST77046_Layout) Input_Address_Property_Set_;
    KEL.typ.ndataset(B_Input_P_I_I_3(__in,__cfg).__ST77097_Layout) Input_Address_Property_Set1_Y_;
    KEL.typ.ndataset(B_Input_P_I_I_3(__in,__cfg).__ST77162_Layout) Input_Address_Property_Set5_Y_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Value_;
    KEL.typ.bool Input_Addronfile_ := FALSE;
    KEL.typ.nstr Input_City_Clean_Value_;
    KEL.typ.nstr Input_D_O_B_Clean_Value_;
    KEL.typ.nstr Input_Email_Clean_Value_;
    KEL.typ.nstr Input_First_Name_Clean_Value_;
    KEL.typ.nstr Input_First_Name_Value_;
    KEL.typ.nstr Input_Full_Address_Clean_Value_;
    KEL.typ.nstr Input_Home_Phone_Clean_Value_;
    KEL.typ.nstr Input_Last_Name_Clean_Value_;
    KEL.typ.nstr Input_Last_Name_Value_;
    KEL.typ.nstr Input_Middle_Name_Value_;
    KEL.typ.nstr Input_Post_Direction_Clean_Value_;
    KEL.typ.nstr Input_Pre_Direction_Clean_Value_;
    KEL.typ.nstr Input_Primary_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Range_Clean_Value_;
    KEL.typ.nstr Input_S_S_N_Clean_Value_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Value_;
    KEL.typ.nstr Input_State_Clean_Value_;
    KEL.typ.nstr Input_Street_Clean_Value_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Value_;
    KEL.typ.nstr Input_Zip4_Clean_Value_;
    KEL.typ.nstr Input_Zip5_Clean_Value_;
    KEL.typ.bool Name_Not_Populated_ := FALSE;
    KEL.typ.nstr Net_Acuity_Gateway_I_P_;
    KEL.typ.int P_I___Inp_Addr_On_File_Flag_Ev_ := 0;
    KEL.typ.nstr P___Inp_Addr_;
    KEL.typ.str P___Inp_Addr_City_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_State_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_Zip_Flag_Value_ := '';
    KEL.typ.nstr P___Inp_Cln_Addr_Full_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_St_Flag_Value_;
    KEL.typ.str P___Inp_Val_Name_Bogus_Flag_ := '';
    KEL.typ.ndataset(B_Input_P_I_I_4(__in,__cfg).__ST77724_Layout) Phone_N_A_I_C_S_High_Risk_Pre_;
    KEL.typ.ndataset(B_Input_P_I_I_3(__in,__cfg).__ST77751_Layout) Phone_N_A_I_C_S_List_;
    KEL.typ.ndataset(B_Input_P_I_I_4(__in,__cfg).__ST77618_Layout) Phone_S_I_C_High_Risk_Pre_;
    KEL.typ.ndataset(B_Input_P_I_I_3(__in,__cfg).__ST77658_Layout) Phone_S_I_C_List_;
    KEL.typ.nstr Targus_Gateway_I_P_;
    SET OF KEL.typ.str Targus_Results_ := [];
    KEL.typ.nstr Targus_Royalty_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC7574242(B_Phone_Summary_3(__in,__cfg).__ST292456_Layout __EE7574231, B_Input_P_I_I_3(__in,__cfg).__ST972975_Layout __EE7574233) := __EEQP(__EE7574231.P_I_I_,__EE7574233.UID);
  __ST1916525_Layout __JT7574242(B_Phone_Summary_3(__in,__cfg).__ST292456_Layout __l, B_Input_P_I_I_3(__in,__cfg).__ST972975_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF.P___Inp_Cln_Name_Last__1_ := __r.P___Inp_Cln_Name_Last_;
    SELF.P___Inp_Cln_Addr_Prim_Rng__1_ := __r.P___Inp_Cln_Addr_Prim_Rng_;
    SELF.P___Inp_Cln_Addr_Prim_Name__1_ := __r.P___Inp_Cln_Addr_Prim_Name_;
    SELF.P___Inp_Cln_Addr_Zip5__1_ := __r.P___Inp_Cln_Addr_Zip5_;
    SELF.P___Inp_Cln_D_O_B__1_ := __r.P___Inp_Cln_D_O_B_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE7574498 := JOIN(__EE7574231,__EE7574233,__JC7574242(LEFT,RIGHT),__JT7574242(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST292790_Layout := RECORD
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST292800_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST292815_Layout := RECORD
    KEL.typ.nstr Last_Name_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST75273_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr My_Date_First_Seen_;
    KEL.typ.nstr My_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST74768_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr My_Date_First_Seen_;
    KEL.typ.nstr My_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST74996_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr My_Date_First_Seen_;
    KEL.typ.nstr My_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST292777_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(__ST292790_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST292800_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(__ST292815_Layout) Last_Name_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.ndataset(__ST75273_Layout) Sorted_Address_Translated_Source_List_;
    KEL.typ.ndataset(__ST74768_Layout) Sorted_D_O_B_Translated_Source_List_;
    KEL.typ.ndataset(__ST74996_Layout) Sorted_Last_Name_Translated_Source_List_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST1183970_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST1183981_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST1183990_Layout) Translated_Last_Name_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST292777_Layout __ND7574067__Project(__ST1916525_Layout __PP7572407) := TRANSFORM
    __EE7574501 := __PP7572407.Address_Summary_;
    SELF.Address_Summary_ := __BN(PROJECT(__T(__EE7574501),__ST292790_Layout),__NL(__EE7574501));
    __EE7574504 := __PP7572407.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE7574504),__ST292800_Layout),__NL(__EE7574504));
    __EE7574507 := __PP7572407.Last_Name_Summary_;
    SELF.Last_Name_Summary_ := __BN(PROJECT(__T(__EE7574507),__ST292815_Layout),__NL(__EE7574507));
    __EE7574040 := __PP7572407.Translated_Address_Sources_;
    __BS7574041 := __T(__EE7574040);
    __EE7574061 := __BS7574041(__T(__AND(__OP2(__T(__EE7574040).Primary_Name_,=,__PP7572407.P___Inp_Cln_Addr_Prim_Name_),__AND(__OP2(__T(__EE7574040).Primary_Range_,=,__PP7572407.P___Inp_Cln_Addr_Prim_Rng_),__OP2(__T(__EE7574040).Zip_,=,__PP7572407.P___Inp_Cln_Addr_Zip5_)))));
    __EE7574065 := TOPN(__EE7574061(__NN(__EE7574061.My_Date_First_Seen_) AND __NN(__EE7574061.Source_)),99999,__T(__EE7574061.My_Date_First_Seen_),__T(__EE7574061.Source_),__T(Primary_Name_),__T(Primary_Range_),__T(Zip_));
    SELF.Sorted_Address_Translated_Source_List_ := __FILTER(__CN(PROJECT(TABLE(PROJECT(__EE7574065,__ST75273_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_,My_Date_First_Seen_,My_Date_Last_Seen_},Source_,My_Date_First_Seen_,My_Date_Last_Seen_,MERGE),__ST75273_Layout)),__NN(Source_) OR __NN(My_Date_First_Seen_) OR __NN(My_Date_Last_Seen_));
    __EE7574100 := __PP7572407.Translated_D_O_B_Sources_;
    __BS7574101 := __T(__EE7574100);
    __EE7574112 := __BS7574101(__T(__OP2(__FN2(KEL.Routines.DateToString,__T(__EE7574100).Date_Of_Birth_,__CN('%Y%m%d')),=,__PP7572407.P___Inp_Cln_D_O_B_)));
    __EE7574116 := TOPN(__EE7574112(__NN(__EE7574112.My_Date_First_Seen_) AND __NN(__EE7574112.Source_)),99999,__T(__EE7574112.My_Date_First_Seen_),__T(__EE7574112.Source_),__T(Date_Of_Birth_));
    SELF.Sorted_D_O_B_Translated_Source_List_ := __FILTER(__CN(PROJECT(TABLE(PROJECT(__EE7574116,__ST74768_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_,My_Date_First_Seen_,My_Date_Last_Seen_},Source_,My_Date_First_Seen_,My_Date_Last_Seen_,MERGE),__ST74768_Layout)),__NN(Source_) OR __NN(My_Date_First_Seen_) OR __NN(My_Date_Last_Seen_));
    __EE7574150 := __PP7572407.Translated_Last_Name_Sources_;
    __BS7574151 := __T(__EE7574150);
    __EE7574159 := __BS7574151(__T(__OP2(__T(__EE7574150).Last_Name_,=,__PP7572407.P___Inp_Cln_Name_Last_)));
    __EE7574163 := TOPN(__EE7574159(__NN(__EE7574159.My_Date_First_Seen_) AND __NN(__EE7574159.Source_)),99999,__T(__EE7574159.My_Date_First_Seen_),__T(__EE7574159.Source_),__T(Last_Name_));
    SELF.Sorted_Last_Name_Translated_Source_List_ := __FILTER(__CN(PROJECT(TABLE(PROJECT(__EE7574163,__ST74996_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_,My_Date_First_Seen_,My_Date_Last_Seen_},Source_,My_Date_First_Seen_,My_Date_Last_Seen_,MERGE),__ST74996_Layout)),__NN(Source_) OR __NN(My_Date_First_Seen_) OR __NN(My_Date_Last_Seen_));
    SELF := __PP7572407;
  END;
  EXPORT __ENH_Phone_Summary_2 := PROJECT(__EE7574498,__ND7574067__Project(LEFT));
END;
