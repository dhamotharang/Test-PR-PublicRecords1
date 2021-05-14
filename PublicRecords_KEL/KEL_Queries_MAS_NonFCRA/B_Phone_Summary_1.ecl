//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Input_P_I_I_2,B_Phone_Summary_2,B_Phone_Summary_5,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Phone_Summary_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_2(__in,__cfg).__ENH_Input_P_I_I_2) __ENH_Input_P_I_I_2 := B_Input_P_I_I_2(__in,__cfg).__ENH_Input_P_I_I_2;
  SHARED VIRTUAL TYPEOF(B_Phone_Summary_2(__in,__cfg).__ENH_Phone_Summary_2) __ENH_Phone_Summary_2 := B_Phone_Summary_2(__in,__cfg).__ENH_Phone_Summary_2;
  SHARED __EE3278281 := __ENH_Phone_Summary_2;
  SHARED __EE3278283 := __ENH_Input_P_I_I_2;
  SHARED __ST1319501_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST178335_Layout) Address_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST178345_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST178361_Layout) Last_Name_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.ndataset(B_Phone_Summary_2(__in,__cfg).__ST793199_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_2(__in,__cfg).__ST793210_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_2(__in,__cfg).__ST793219_Layout) Translated_Last_Name_Sources_;
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
    KEL.typ.nstr Input_D_O_B_Clean_Value_;
    KEL.typ.nstr Input_First_Name_Clean_Value_;
    KEL.typ.nstr Input_Home_Phone_Clean_Value_;
    KEL.typ.nstr Input_Last_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Range_Clean_Value_;
    KEL.typ.nstr Input_S_S_N_Clean_Value_;
    KEL.typ.nstr Input_Zip5_Clean_Value_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC3278292(B_Phone_Summary_2(__in,__cfg).__ST167897_Layout __EE3278281, B_Input_P_I_I_2(__in,__cfg).__ST164336_Layout __EE3278283) := __EEQP(__EE3278281.P_I_I_,__EE3278283.UID);
  __ST1319501_Layout __JT3278292(B_Phone_Summary_2(__in,__cfg).__ST167897_Layout __l, B_Input_P_I_I_2(__in,__cfg).__ST164336_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF.P___Inp_Cln_Name_Last__1_ := __r.P___Inp_Cln_Name_Last_;
    SELF.P___Inp_Cln_Addr_Prim_Rng__1_ := __r.P___Inp_Cln_Addr_Prim_Rng_;
    SELF.P___Inp_Cln_Addr_Prim_Name__1_ := __r.P___Inp_Cln_Addr_Prim_Name_;
    SELF.P___Inp_Cln_Addr_Zip5__1_ := __r.P___Inp_Cln_Addr_Zip5_;
    SELF.P___Inp_Cln_D_O_B__1_ := __r.P___Inp_Cln_D_O_B_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE3278517 := JOIN(__EE3278281,__EE3278283,__JC3278292(LEFT,RIGHT),__JT3278292(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST85038_Layout := RECORD
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
  EXPORT __ST84533_Layout := RECORD
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
  EXPORT __ST84761_Layout := RECORD
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
  EXPORT __ST162715_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST178335_Layout) Address_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST178345_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST178361_Layout) Last_Name_Summary_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.ndataset(__ST85038_Layout) Sorted_Address_Translated_Source_List_;
    KEL.typ.ndataset(__ST84533_Layout) Sorted_D_O_B_Translated_Source_List_;
    KEL.typ.ndataset(__ST84761_Layout) Sorted_Last_Name_Translated_Source_List_;
    KEL.typ.bool Src_W_Inp_A_P_List_No_Data_ := FALSE;
    KEL.typ.bool Src_W_Inp_L_P_List_No_Date_ := FALSE;
    KEL.typ.bool Src_W_Inp_P_D_List_No_Date_ := FALSE;
    KEL.typ.ndataset(B_Phone_Summary_2(__in,__cfg).__ST793199_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_2(__in,__cfg).__ST793210_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_2(__in,__cfg).__ST793219_Layout) Translated_Last_Name_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST162715_Layout __ND3278038__Project(__ST1319501_Layout __PP3276371) := TRANSFORM
    __EE3278011 := __PP3276371.Translated_Address_Sources_;
    __BS3278012 := __T(__EE3278011);
    __EE3278032 := __BS3278012(__T(__AND(__OP2(__T(__EE3278011).Primary_Name_,=,__PP3276371.P___Inp_Cln_Addr_Prim_Name_),__AND(__OP2(__T(__EE3278011).Primary_Range_,=,__PP3276371.P___Inp_Cln_Addr_Prim_Rng_),__OP2(__T(__EE3278011).Zip_,=,__PP3276371.P___Inp_Cln_Addr_Zip5_)))));
    __EE3278036 := TOPN(__EE3278032(__NN(__EE3278032.My_Date_First_Seen_) AND __NN(__EE3278032.Source_)),99999,__T(__EE3278032.My_Date_First_Seen_),__T(__EE3278032.Source_),__T(Primary_Name_),__T(Primary_Range_),__T(Zip_));
    SELF.Sorted_Address_Translated_Source_List_ := __FILTER(__CN(PROJECT(TABLE(PROJECT(__EE3278036,__ST85038_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_,My_Date_First_Seen_,My_Date_Last_Seen_},Source_,My_Date_First_Seen_,My_Date_Last_Seen_,MERGE),__ST85038_Layout)),__NN(Source_) OR __NN(My_Date_First_Seen_) OR __NN(My_Date_Last_Seen_));
    __EE3278071 := __PP3276371.Translated_D_O_B_Sources_;
    __BS3278072 := __T(__EE3278071);
    __EE3278083 := __BS3278072(__T(__OP2(__FN2(KEL.Routines.DateToString,__T(__EE3278071).Date_Of_Birth_,__CN('%Y%m%d')),=,__PP3276371.P___Inp_Cln_D_O_B_)));
    __EE3278087 := TOPN(__EE3278083(__NN(__EE3278083.My_Date_First_Seen_) AND __NN(__EE3278083.Source_)),99999,__T(__EE3278083.My_Date_First_Seen_),__T(__EE3278083.Source_),__T(Date_Of_Birth_));
    SELF.Sorted_D_O_B_Translated_Source_List_ := __FILTER(__CN(PROJECT(TABLE(PROJECT(__EE3278087,__ST84533_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_,My_Date_First_Seen_,My_Date_Last_Seen_},Source_,My_Date_First_Seen_,My_Date_Last_Seen_,MERGE),__ST84533_Layout)),__NN(Source_) OR __NN(My_Date_First_Seen_) OR __NN(My_Date_Last_Seen_));
    __EE3278121 := __PP3276371.Translated_Last_Name_Sources_;
    __BS3278122 := __T(__EE3278121);
    __EE3278130 := __BS3278122(__T(__OP2(__T(__EE3278121).Last_Name_,=,__PP3276371.P___Inp_Cln_Name_Last_)));
    __EE3278134 := TOPN(__EE3278130(__NN(__EE3278130.My_Date_First_Seen_) AND __NN(__EE3278130.Source_)),99999,__T(__EE3278130.My_Date_First_Seen_),__T(__EE3278130.Source_),__T(Last_Name_));
    SELF.Sorted_Last_Name_Translated_Source_List_ := __FILTER(__CN(PROJECT(TABLE(PROJECT(__EE3278134,__ST84761_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_,My_Date_First_Seen_,My_Date_Last_Seen_},Source_,My_Date_First_Seen_,My_Date_Last_Seen_,MERGE),__ST84761_Layout)),__NN(Source_) OR __NN(My_Date_First_Seen_) OR __NN(My_Date_Last_Seen_));
    __BS3278137 := __T(__PP3276371.Translated_Address_Sources_);
    SELF.Src_W_Inp_A_P_List_No_Data_ := NOT EXISTS(__BS3278137(__T(__AND(__OP2(__T(__PP3276371.Translated_Address_Sources_).Primary_Name_,=,__PP3276371.P___Inp_Cln_Addr_Prim_Name_),__AND(__OP2(__T(__PP3276371.Translated_Address_Sources_).Primary_Range_,=,__PP3276371.P___Inp_Cln_Addr_Prim_Rng_),__OP2(__T(__PP3276371.Translated_Address_Sources_).Zip_,=,__PP3276371.P___Inp_Cln_Addr_Zip5_))))));
    __BS3278164 := __T(__PP3276371.Translated_Last_Name_Sources_);
    SELF.Src_W_Inp_L_P_List_No_Date_ := NOT EXISTS(__BS3278164(__T(__OP2(__T(__PP3276371.Translated_Last_Name_Sources_).Last_Name_,=,__PP3276371.P___Inp_Cln_Name_Last_))));
    __BS3278177 := __T(__PP3276371.Translated_D_O_B_Sources_);
    SELF.Src_W_Inp_P_D_List_No_Date_ := NOT EXISTS(__BS3278177(__T(__OP2(__FN2(KEL.Routines.DateToString,__T(__PP3276371.Translated_D_O_B_Sources_).Date_Of_Birth_,__CN('%Y%m%d')),=,__PP3276371.P___Inp_Cln_D_O_B_))));
    SELF := __PP3276371;
  END;
  EXPORT __ENH_Phone_Summary_1 := PROJECT(__EE3278517,__ND3278038__Project(LEFT));
END;
