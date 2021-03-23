//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Input_P_I_I_3,B_Inquiry_4,B_Property_4,B_S_S_N_Summary_3,B_S_S_N_Summary_4,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Inquiry,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_3(__in,__cfg).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3(__in,__cfg).__ENH_Input_P_I_I_3;
  SHARED VIRTUAL TYPEOF(B_S_S_N_Summary_3(__in,__cfg).__ENH_S_S_N_Summary_3) __ENH_S_S_N_Summary_3 := B_S_S_N_Summary_3(__in,__cfg).__ENH_S_S_N_Summary_3;
  SHARED __EE8063540 := __ENH_S_S_N_Summary_3;
  SHARED __EE8063542 := __ENH_Input_P_I_I_3;
  SHARED __ST2081640_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST239542_Layout) Address_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST239551_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST239559_Layout) Name_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST239567_Layout) Phone_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.nstr P___Inp_Cln_Primary_Name_;
    KEL.typ.nstr P___Inp_Cln_Primary_Range_;
    KEL.typ.nstr P___Inp_Cln_Zip_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81449_Layout) Phone_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST81411_Layout) Phone_Translated_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81113_Layout) S_S_N_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST81276_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81313_Layout) Translated_D_O_B_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST81554_Layout) Translated_Fn_Ln_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81593_Layout) Translated_Fn_Ln_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST81059_Layout) Translated_Sources_;
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
    KEL.typ.nstr P___Inp_Cln_Name_First__1_;
    KEL.typ.nstr P___Inp_Cln_Name_Mid_;
    KEL.typ.nstr P___Inp_Cln_Name_Last__1_;
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
    KEL.typ.nstr P___Inp_Cln_Phone_Home__1_;
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
    KEL.typ.ndataset(B_Input_P_I_I_3(__in,__cfg).__ST80170_Layout) Good_Inquiries_Last_Year_For_Address_;
    KEL.typ.ndataset(B_Input_P_I_I_3(__in,__cfg).__ST79087_Layout) Input_Address_Property_Set_;
    KEL.typ.ndataset(B_Input_P_I_I_3(__in,__cfg).__ST79138_Layout) Input_Address_Property_Set1_Y_;
    KEL.typ.ndataset(B_Input_P_I_I_3(__in,__cfg).__ST79203_Layout) Input_Address_Property_Set5_Y_;
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
    KEL.typ.nstr P___Inp_Addr_;
    KEL.typ.str P___Inp_Addr_City_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_State_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_Zip_Flag_Value_ := '';
    KEL.typ.nstr P___Inp_Cln_Addr_Full_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_St_Flag_Value_;
    KEL.typ.str P___Inp_Val_Name_Bogus_Flag_ := '';
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
  __JC8063551(B_S_S_N_Summary_3(__in,__cfg).__ST239538_Layout __EE8063540, B_Input_P_I_I_3(__in,__cfg).__ST1034704_Layout __EE8063542) := __EEQP(__EE8063540.P_I_I_,__EE8063542.UID);
  __ST2081640_Layout __JT8063551(B_S_S_N_Summary_3(__in,__cfg).__ST239538_Layout __l, B_Input_P_I_I_3(__in,__cfg).__ST1034704_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF.P___Inp_Cln_Name_First__1_ := __r.P___Inp_Cln_Name_First_;
    SELF.P___Inp_Cln_Name_Last__1_ := __r.P___Inp_Cln_Name_Last_;
    SELF.P___Inp_Cln_Phone_Home__1_ := __r.P___Inp_Cln_Phone_Home_;
    SELF.P___Inp_Cln_D_O_B__1_ := __r.P___Inp_Cln_D_O_B_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE8063795 := JOIN(__EE8063540,__EE8063542,__JC8063551(LEFT,RIGHT),__JT8063551(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST224434_Layout := RECORD
    KEL.typ.nstr Address_Primary_Name_;
    KEL.typ.nstr Address_Primary_Range_;
    KEL.typ.nstr Address_Zip_;
    KEL.typ.nstr Address_Source_;
    KEL.typ.nint Address_Record_Count_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST224443_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr Dob_Date_Of_Birth_Padded_;
    KEL.typ.nstr Dob_Source_;
    KEL.typ.nint Dob_Record_Count_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST224451_Layout := RECORD
    KEL.typ.nstr Name_First_Name_;
    KEL.typ.nstr Name_Last_Name_;
    KEL.typ.nstr Name_Source_;
    KEL.typ.nint Name_Record_Count_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST224459_Layout := RECORD
    KEL.typ.nint Phone_Number_;
    KEL.typ.nstr Phone_Source_;
    KEL.typ.nint Phone_Record_Count_;
    KEL.typ.nstr Phone_Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST224430_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST224434_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST224443_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST224451_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST224459_Layout) Phone_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.nstr P___Inp_Cln_Primary_Name_;
    KEL.typ.nstr P___Inp_Cln_Primary_Range_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.nstr P___Inp_Cln_Zip_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81449_Layout) Phone_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81449_Layout) Phone_Summary_Source_List_Sorted_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST81411_Layout) Phone_Translated_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81113_Layout) S_S_N_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81113_Layout) S_S_N_Summary_Source_List_Sorted_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81313_Layout) Sorted_D_O_B_Translated_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81593_Layout) Sorted_Fn_Ln_Translated_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST81276_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81313_Layout) Translated_D_O_B_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST81554_Layout) Translated_Fn_Ln_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81593_Layout) Translated_Fn_Ln_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST81059_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST224430_Layout __ND8063279__Project(__ST2081640_Layout __PP8061473) := TRANSFORM
    __EE8063798 := __PP8061473.Address_Summary_;
    SELF.Address_Summary_ := __BN(PROJECT(__T(__EE8063798),__ST224434_Layout),__NL(__EE8063798));
    __EE8063801 := __PP8061473.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE8063801),__ST224443_Layout),__NL(__EE8063801));
    __EE8063804 := __PP8061473.Name_Summary_;
    SELF.Name_Summary_ := __BN(PROJECT(__T(__EE8063804),__ST224451_Layout),__NL(__EE8063804));
    __EE8063807 := __PP8061473.Phone_Summary_;
    SELF.Phone_Summary_ := __BN(PROJECT(__T(__EE8063807),__ST224459_Layout),__NL(__EE8063807));
    SELF.P___Inp_Cln_S_S_N_ := __PP8061473.Input_S_S_N_Clean_Value_;
    __EE8063264 := __PP8061473.Phone_Summary_Source_List_;
    __BS8063265 := __T(__EE8063264);
    __EE8063273 := __BS8063265(__T(__OP2(__CAST(KEL.typ.str,__T(__EE8063264).Phone10_),=,__PP8061473.P___Inp_Cln_Phone_Home_)));
    __CC13985 := '-99997';
    __EE8063277 := TOPN(__EE8063273(__NN(__OP2(__EE8063273.Source_Date_First_Seen_,=,__CN(__CC13985))) AND __NN(IF(__T(__OP2(__EE8063273.Source_Date_First_Seen_,=,__CN(__CC13985))),__ECAST(KEL.typ.nstr,__EE8063273.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE8063273.Source_Date_First_Seen_))) AND __NN(__EE8063273.Phone_Translated_Source_Code_)),1000,__T(__OP2(__EE8063273.Source_Date_First_Seen_,=,__CN(__CC13985))),__T(IF(__T(__OP2(__EE8063273.Source_Date_First_Seen_,=,__CN(__CC13985))),__ECAST(KEL.typ.nstr,__EE8063273.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE8063273.Source_Date_First_Seen_))),__T(__EE8063273.Phone_Translated_Source_Code_),__T(Phone10_));
    SELF.Phone_Summary_Source_List_Sorted_ := __CN(__EE8063277);
    __EE8063313 := __PP8061473.S_S_N_Summary_Source_List_;
    __BS8063314 := __T(__EE8063313);
    __EE8063334 := __BS8063314(__T(__AND(__OP2(__T(__EE8063313).Primary_Name_Address_,=,__PP8061473.P___Inp_Cln_Primary_Name_),__AND(__OP2(__T(__EE8063313).Primary_Range_Address_,=,__PP8061473.P___Inp_Cln_Primary_Range_),__OP2(__T(__EE8063313).Zip_Address_,=,__PP8061473.P___Inp_Cln_Zip_)))));
    __EE8063338 := TOPN(__EE8063334(__NN(__OP2(__EE8063334.Source_Date_First_Seen_,=,__CN(__CC13985))) AND __NN(IF(__T(__OP2(__EE8063334.Source_Date_First_Seen_,=,__CN(__CC13985))),__ECAST(KEL.typ.nstr,__EE8063334.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE8063334.Source_Date_First_Seen_))) AND __NN(__EE8063334.Translated_Source_Code_)),1000,__T(__OP2(__EE8063334.Source_Date_First_Seen_,=,__CN(__CC13985))),__T(IF(__T(__OP2(__EE8063334.Source_Date_First_Seen_,=,__CN(__CC13985))),__ECAST(KEL.typ.nstr,__EE8063334.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE8063334.Source_Date_First_Seen_))),__T(__EE8063334.Translated_Source_Code_),__T(Primary_Name_Address_),__T(Primary_Range_Address_),__T(Zip_Address_));
    SELF.S_S_N_Summary_Source_List_Sorted_ := __CN(__EE8063338);
    __EE8063369 := __PP8061473.Translated_D_O_B_Sources_List_;
    __BS8063370 := __T(__EE8063369);
    __EE8063381 := __BS8063370(__T(__OP2(__FN2(KEL.Routines.DateToString,__T(__EE8063369).Date_Of_Birth_,__CN('%Y%m%d')),=,__PP8061473.P___Inp_Cln_D_O_B_)));
    __EE8063385 := TOPN(__EE8063381(__NN(__OP2(__EE8063381.Source_Date_First_Seen_,=,__CN(__CC13985))) AND __NN(IF(__T(__OP2(__EE8063381.Source_Date_First_Seen_,=,__CN(__CC13985))),__ECAST(KEL.typ.nstr,__EE8063381.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE8063381.Source_Date_First_Seen_))) AND __NN(__EE8063381.Translated_Source_Code_)),1000,__T(__OP2(__EE8063381.Source_Date_First_Seen_,=,__CN(__CC13985))),__T(IF(__T(__OP2(__EE8063381.Source_Date_First_Seen_,=,__CN(__CC13985))),__ECAST(KEL.typ.nstr,__EE8063381.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE8063381.Source_Date_First_Seen_))),__T(__EE8063381.Translated_Source_Code_),__T(Date_Of_Birth_));
    SELF.Sorted_D_O_B_Translated_Source_List_ := __CN(__EE8063385);
    __EE8063416 := __PP8061473.Translated_Fn_Ln_Sources_List_;
    __BS8063417 := __T(__EE8063416);
    __EE8063431 := __BS8063417(__T(__AND(__OP2(__T(__EE8063416).First_Name_,=,__PP8061473.P___Inp_Cln_Name_First_),__OP2(__T(__EE8063416).Last_Name_,=,__PP8061473.P___Inp_Cln_Name_Last_))));
    __EE8063435 := TOPN(__EE8063431(__NN(__OP2(__EE8063431.Source_Date_First_Seen_,=,__CN(__CC13985))) AND __NN(IF(__T(__OP2(__EE8063431.Source_Date_First_Seen_,=,__CN(__CC13985))),__ECAST(KEL.typ.nstr,__EE8063431.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE8063431.Source_Date_First_Seen_))) AND __NN(__EE8063431.Translated_Source_Code_)),1000,__T(__OP2(__EE8063431.Source_Date_First_Seen_,=,__CN(__CC13985))),__T(IF(__T(__OP2(__EE8063431.Source_Date_First_Seen_,=,__CN(__CC13985))),__ECAST(KEL.typ.nstr,__EE8063431.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE8063431.Source_Date_First_Seen_))),__T(__EE8063431.Translated_Source_Code_),__T(First_Name_),__T(Last_Name_));
    SELF.Sorted_Fn_Ln_Translated_Source_List_ := __CN(__EE8063435);
    SELF := __PP8061473;
  END;
  EXPORT __ENH_S_S_N_Summary_2 := PROJECT(__EE8063795,__ND8063279__Project(LEFT));
END;
