//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Input_P_I_I_3,B_S_S_N_Summary_3,B_S_S_N_Summary_4,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_S_S_N_Summary_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_3(__in,__cfg).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3(__in,__cfg).__ENH_Input_P_I_I_3;
  SHARED VIRTUAL TYPEOF(B_S_S_N_Summary_3(__in,__cfg).__ENH_S_S_N_Summary_3) __ENH_S_S_N_Summary_3 := B_S_S_N_Summary_3(__in,__cfg).__ENH_S_S_N_Summary_3;
  SHARED __EE2549050 := __ENH_S_S_N_Summary_3;
  SHARED __EE2549052 := __ENH_Input_P_I_I_3;
  SHARED __ST770903_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST167894_Layout) Address_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST167903_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST167911_Layout) Name_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST167919_Layout) Phone_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.nstr P___Inp_Cln_Primary_Name_;
    KEL.typ.nstr P___Inp_Cln_Primary_Range_;
    KEL.typ.nstr P___Inp_Cln_Zip_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81943_Layout) Phone_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST81905_Layout) Phone_Translated_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81607_Layout) S_S_N_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST81770_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81807_Layout) Translated_D_O_B_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST82057_Layout) Translated_Fn_Ln_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST82096_Layout) Translated_Fn_Ln_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST81553_Layout) Translated_Sources_;
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
    KEL.typ.nstr Input_D_O_B_Clean_Value_;
    KEL.typ.nstr Input_First_Name_Clean_Value_;
    KEL.typ.nstr Input_Home_Phone_Clean_Value_;
    KEL.typ.nstr Input_Last_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Range_Clean_Value_;
    KEL.typ.nstr Input_S_S_N_Clean_Value_;
    KEL.typ.nstr Input_Zip5_Clean_Value_;
    KEL.typ.bool Name_Not_Populated_ := FALSE;
    KEL.typ.str P___Inp_Addr_Zip_Flag_Value_ := '';
    KEL.typ.str P___Inp_Val_Name_Bogus_Flag_ := '';
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC2549061(B_S_S_N_Summary_3(__in,__cfg).__ST167890_Layout __EE2549050, B_Input_P_I_I_3(__in,__cfg).__ST164378_Layout __EE2549052) := __EEQP(__EE2549050.P_I_I_,__EE2549052.UID);
  __ST770903_Layout __JT2549061(B_S_S_N_Summary_3(__in,__cfg).__ST167890_Layout __l, B_Input_P_I_I_3(__in,__cfg).__ST164378_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF.P___Inp_Cln_Name_First__1_ := __r.P___Inp_Cln_Name_First_;
    SELF.P___Inp_Cln_Name_Last__1_ := __r.P___Inp_Cln_Name_Last_;
    SELF.P___Inp_Cln_Phone_Home__1_ := __r.P___Inp_Cln_Phone_Home_;
    SELF.P___Inp_Cln_D_O_B__1_ := __r.P___Inp_Cln_D_O_B_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE2549297 := JOIN(__EE2549050,__EE2549052,__JC2549061(LEFT,RIGHT),__JT2549061(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST163198_Layout := RECORD
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
  EXPORT __ST163207_Layout := RECORD
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
  EXPORT __ST163215_Layout := RECORD
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
  EXPORT __ST163223_Layout := RECORD
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
  EXPORT __ST163194_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST163198_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST163207_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST163215_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST163223_Layout) Phone_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.nstr P___Inp_Cln_Primary_Name_;
    KEL.typ.nstr P___Inp_Cln_Primary_Range_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.nstr P___Inp_Cln_Zip_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81943_Layout) Phone_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81943_Layout) Phone_Summary_Source_List_Sorted_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81607_Layout) S_S_N_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81607_Layout) S_S_N_Summary_Source_List_Sorted_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81807_Layout) Sorted_D_O_B_Translated_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST82096_Layout) Sorted_Fn_Ln_Translated_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81807_Layout) Translated_D_O_B_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST82096_Layout) Translated_Fn_Ln_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST81553_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST163194_Layout __ND2548808__Project(__ST770903_Layout __PP2547075) := TRANSFORM
    __EE2549300 := __PP2547075.Address_Summary_;
    SELF.Address_Summary_ := __BN(PROJECT(__T(__EE2549300),__ST163198_Layout),__NL(__EE2549300));
    __EE2549303 := __PP2547075.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE2549303),__ST163207_Layout),__NL(__EE2549303));
    __EE2549306 := __PP2547075.Name_Summary_;
    SELF.Name_Summary_ := __BN(PROJECT(__T(__EE2549306),__ST163215_Layout),__NL(__EE2549306));
    __EE2549309 := __PP2547075.Phone_Summary_;
    SELF.Phone_Summary_ := __BN(PROJECT(__T(__EE2549309),__ST163223_Layout),__NL(__EE2549309));
    SELF.P___Inp_Cln_S_S_N_ := __PP2547075.Input_S_S_N_Clean_Value_;
    __EE2548793 := __PP2547075.Phone_Summary_Source_List_;
    __BS2548794 := __T(__EE2548793);
    __EE2548802 := __BS2548794(__T(__OP2(__CAST(KEL.typ.str,__T(__EE2548793).Phone10_),=,__PP2547075.P___Inp_Cln_Phone_Home_)));
    __CC14250 := '-99997';
    __EE2548806 := TOPN(__EE2548802(__NN(__OP2(__EE2548802.Source_Date_First_Seen_,=,__CN(__CC14250))) AND __NN(IF(__T(__OP2(__EE2548802.Source_Date_First_Seen_,=,__CN(__CC14250))),__ECAST(KEL.typ.nstr,__EE2548802.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE2548802.Source_Date_First_Seen_))) AND __NN(__EE2548802.Phone_Translated_Source_Code_)),1000,__T(__OP2(__EE2548802.Source_Date_First_Seen_,=,__CN(__CC14250))),__T(IF(__T(__OP2(__EE2548802.Source_Date_First_Seen_,=,__CN(__CC14250))),__ECAST(KEL.typ.nstr,__EE2548802.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE2548802.Source_Date_First_Seen_))),__T(__EE2548802.Phone_Translated_Source_Code_),__T(Phone10_));
    SELF.Phone_Summary_Source_List_Sorted_ := __CN(__EE2548806);
    __EE2548840 := __PP2547075.S_S_N_Summary_Source_List_;
    __BS2548841 := __T(__EE2548840);
    __EE2548861 := __BS2548841(__T(__AND(__OP2(__T(__EE2548840).Primary_Name_Address_,=,__PP2547075.P___Inp_Cln_Primary_Name_),__AND(__OP2(__T(__EE2548840).Primary_Range_Address_,=,__PP2547075.P___Inp_Cln_Primary_Range_),__OP2(__T(__EE2548840).Zip_Address_,=,__PP2547075.P___Inp_Cln_Zip_)))));
    __EE2548865 := TOPN(__EE2548861(__NN(__OP2(__EE2548861.Source_Date_First_Seen_,=,__CN(__CC14250))) AND __NN(IF(__T(__OP2(__EE2548861.Source_Date_First_Seen_,=,__CN(__CC14250))),__ECAST(KEL.typ.nstr,__EE2548861.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE2548861.Source_Date_First_Seen_))) AND __NN(__EE2548861.Translated_Source_Code_)),1000,__T(__OP2(__EE2548861.Source_Date_First_Seen_,=,__CN(__CC14250))),__T(IF(__T(__OP2(__EE2548861.Source_Date_First_Seen_,=,__CN(__CC14250))),__ECAST(KEL.typ.nstr,__EE2548861.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE2548861.Source_Date_First_Seen_))),__T(__EE2548861.Translated_Source_Code_),__T(Primary_Name_Address_),__T(Primary_Range_Address_),__T(Zip_Address_));
    SELF.S_S_N_Summary_Source_List_Sorted_ := __CN(__EE2548865);
    __EE2548896 := __PP2547075.Translated_D_O_B_Sources_List_;
    __BS2548897 := __T(__EE2548896);
    __EE2548908 := __BS2548897(__T(__OP2(__FN2(KEL.Routines.DateToString,__T(__EE2548896).Date_Of_Birth_,__CN('%Y%m%d')),=,__PP2547075.P___Inp_Cln_D_O_B_)));
    __EE2548912 := TOPN(__EE2548908(__NN(__OP2(__EE2548908.Source_Date_First_Seen_,=,__CN(__CC14250))) AND __NN(IF(__T(__OP2(__EE2548908.Source_Date_First_Seen_,=,__CN(__CC14250))),__ECAST(KEL.typ.nstr,__EE2548908.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE2548908.Source_Date_First_Seen_))) AND __NN(__EE2548908.Translated_Source_Code_)),1000,__T(__OP2(__EE2548908.Source_Date_First_Seen_,=,__CN(__CC14250))),__T(IF(__T(__OP2(__EE2548908.Source_Date_First_Seen_,=,__CN(__CC14250))),__ECAST(KEL.typ.nstr,__EE2548908.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE2548908.Source_Date_First_Seen_))),__T(__EE2548908.Translated_Source_Code_),__T(Date_Of_Birth_));
    SELF.Sorted_D_O_B_Translated_Source_List_ := __CN(__EE2548912);
    __EE2548943 := __PP2547075.Translated_Fn_Ln_Sources_List_;
    __BS2548944 := __T(__EE2548943);
    __EE2548958 := __BS2548944(__T(__AND(__OP2(__T(__EE2548943).First_Name_,=,__PP2547075.P___Inp_Cln_Name_First_),__OP2(__T(__EE2548943).Last_Name_,=,__PP2547075.P___Inp_Cln_Name_Last_))));
    __EE2548962 := TOPN(__EE2548958(__NN(__OP2(__EE2548958.Source_Date_First_Seen_,=,__CN(__CC14250))) AND __NN(IF(__T(__OP2(__EE2548958.Source_Date_First_Seen_,=,__CN(__CC14250))),__ECAST(KEL.typ.nstr,__EE2548958.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE2548958.Source_Date_First_Seen_))) AND __NN(__EE2548958.Translated_Source_Code_)),1000,__T(__OP2(__EE2548958.Source_Date_First_Seen_,=,__CN(__CC14250))),__T(IF(__T(__OP2(__EE2548958.Source_Date_First_Seen_,=,__CN(__CC14250))),__ECAST(KEL.typ.nstr,__EE2548958.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE2548958.Source_Date_First_Seen_))),__T(__EE2548958.Translated_Source_Code_),__T(First_Name_),__T(Last_Name_));
    SELF.Sorted_Fn_Ln_Translated_Source_List_ := __CN(__EE2548962);
    SELF := __PP2547075;
  END;
  EXPORT __ENH_S_S_N_Summary_2 := PROJECT(__EE2549297,__ND2548808__Project(LEFT));
END;
