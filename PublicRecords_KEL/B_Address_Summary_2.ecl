﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Address_Summary_3,B_Address_Summary_4,B_Input_P_I_I_3,B_Inquiry_4,B_Property_4,CFG_Compile,E_Address,E_Email,E_Geo_Link,E_Input_P_I_I,E_Inquiry,E_Person,E_Phone,E_Property,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Address_Summary_2(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_Summary_3(__cfg).__ENH_Address_Summary_3) __ENH_Address_Summary_3 := B_Address_Summary_3(__cfg).__ENH_Address_Summary_3;
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_3(__cfg).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3(__cfg).__ENH_Input_P_I_I_3;
  SHARED __EE6539926 := __ENH_Address_Summary_3;
  SHARED __EE6539928 := __ENH_Input_P_I_I_3;
  SHARED __ST1239405_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.ndataset(B_Address_Summary_3(__cfg).__ST219537_Layout) Name_Summary_;
    KEL.typ.ndataset(B_Address_Summary_3(__cfg).__ST219545_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(B_Address_Summary_3(__cfg).__ST80009_Layout) Address_Summary_Source_List_;
    KEL.typ.ndataset(B_Address_Summary_3(__cfg).__ST80192_Layout) D_O_B_Source_List_;
    KEL.typ.ndataset(B_Address_Summary_4(__cfg).__ST80154_Layout) D_O_B_Translated_Sources_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.ndataset(B_Address_Summary_4(__cfg).__ST79956_Layout) Translated_Sources_;
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
    KEL.typ.bool Addr_Not_Populated_ := FALSE;
    KEL.typ.nint At_Position_;
    KEL.typ.nbool City_State_Zip_Not_Populated_;
    KEL.typ.nbool Clean_City_State_Zip_Not_Populated_;
    KEL.typ.nint D_P_P_A_Purpose_;
    KEL.typ.nstr Email_Domain_;
    KEL.typ.nstr Email_Username_;
    KEL.typ.nint G_L_B_Purpose_;
    KEL.typ.ndataset(B_Input_P_I_I_3(__cfg).__ST78009_Layout) Good_Inquiries_Last_Year_For_Address_;
    KEL.typ.ndataset(B_Input_P_I_I_3(__cfg).__ST76927_Layout) Input_Address_Property_Set_;
    KEL.typ.ndataset(B_Input_P_I_I_3(__cfg).__ST76978_Layout) Input_Address_Property_Set1_Y_;
    KEL.typ.ndataset(B_Input_P_I_I_3(__cfg).__ST77043_Layout) Input_Address_Property_Set5_Y_;
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
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC6539937(B_Address_Summary_3(__cfg).__ST219531_Layout __EE6539926, B_Input_P_I_I_3(__cfg).__ST1003794_Layout __EE6539928) := __EEQP(__EE6539926.P_I_I_,__EE6539928.UID);
  __ST1239405_Layout __JT6539937(B_Address_Summary_3(__cfg).__ST219531_Layout __l, B_Input_P_I_I_3(__cfg).__ST1003794_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF.P___Inp_Cln_Name_First__1_ := __r.P___Inp_Cln_Name_First_;
    SELF.P___Inp_Cln_Name_Last__1_ := __r.P___Inp_Cln_Name_Last_;
    SELF.P___Inp_Cln_D_O_B__1_ := __r.P___Inp_Cln_D_O_B_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE6540128 := JOIN(__EE6539926,__EE6539928,__JC6539937(LEFT,RIGHT),__JT6539937(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST200970_Layout := RECORD
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
  EXPORT __ST200978_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr Dob_Source_;
    KEL.typ.nint Dob_Record_Count_;
    KEL.typ.nstr D_O_B_Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST200964_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.ndataset(__ST200970_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST200978_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(B_Address_Summary_3(__cfg).__ST80009_Layout) Address_Summary_Source_List_;
    KEL.typ.ndataset(B_Address_Summary_3(__cfg).__ST80009_Layout) Address_Summary_Source_List_Sorted_;
    KEL.typ.ndataset(B_Address_Summary_3(__cfg).__ST80192_Layout) D_O_B_Source_List_;
    KEL.typ.ndataset(B_Address_Summary_3(__cfg).__ST80192_Layout) D_O_B_Source_List_Sorted_;
    KEL.typ.ndataset(B_Address_Summary_4(__cfg).__ST80154_Layout) D_O_B_Translated_Sources_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.ndataset(B_Address_Summary_4(__cfg).__ST79956_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST200964_Layout __ND6539805__Project(__ST1239405_Layout __PP6538574) := TRANSFORM
    __EE6540131 := __PP6538574.Name_Summary_;
    SELF.Name_Summary_ := __BN(PROJECT(__T(__EE6540131),__ST200970_Layout),__NL(__EE6540131));
    __EE6540134 := __PP6538574.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE6540134),__ST200978_Layout),__NL(__EE6540134));
    __EE6539784 := __PP6538574.Address_Summary_Source_List_;
    __BS6539785 := __T(__EE6539784);
    __EE6539799 := __BS6539785(__T(__AND(__OP2(__T(__EE6539784).First_Name_,=,__PP6538574.P___Inp_Cln_Name_First_),__OP2(__T(__EE6539784).Last_Name_,=,__PP6538574.P___Inp_Cln_Name_Last_))));
    __CC15132 := '-99997';
    __EE6539803 := TOPN(__EE6539799(__NN(__OP2(__EE6539799.Source_Date_First_Seen_,=,__CN(__CC15132))) AND __NN(IF(__T(__OP2(__EE6539799.Source_Date_First_Seen_,=,__CN(__CC15132))),__ECAST(KEL.typ.nstr,__EE6539799.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE6539799.Source_Date_First_Seen_))) AND __NN(__EE6539799.Translated_Source_Code_)),1000,__T(__OP2(__EE6539799.Source_Date_First_Seen_,=,__CN(__CC15132))),__T(IF(__T(__OP2(__EE6539799.Source_Date_First_Seen_,=,__CN(__CC15132))),__ECAST(KEL.typ.nstr,__EE6539799.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE6539799.Source_Date_First_Seen_))),__T(__EE6539799.Translated_Source_Code_),__T(First_Name_),__T(Last_Name_));
    SELF.Address_Summary_Source_List_Sorted_ := __CN(__EE6539803);
    __EE6539837 := __PP6538574.D_O_B_Source_List_;
    __BS6539838 := __T(__EE6539837);
    __EE6539849 := __BS6539838(__T(__OP2(__FN2(KEL.Routines.DateToString,__T(__EE6539837).Date_Of_Birth_,__CN('%Y%m%d')),=,__PP6538574.P___Inp_Cln_D_O_B_)));
    __EE6539853 := TOPN(__EE6539849(__NN(__OP2(__EE6539849.Source_Date_First_Seen_,=,__CN(__CC15132))) AND __NN(IF(__T(__OP2(__EE6539849.Source_Date_First_Seen_,=,__CN(__CC15132))),__ECAST(KEL.typ.nstr,__EE6539849.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE6539849.Source_Date_First_Seen_))) AND __NN(__EE6539849.D_O_B_Translated_Source_Code_)),1000,__T(__OP2(__EE6539849.Source_Date_First_Seen_,=,__CN(__CC15132))),__T(IF(__T(__OP2(__EE6539849.Source_Date_First_Seen_,=,__CN(__CC15132))),__ECAST(KEL.typ.nstr,__EE6539849.Source_Date_Last_Seen_),__ECAST(KEL.typ.nstr,__EE6539849.Source_Date_First_Seen_))),__T(__EE6539849.D_O_B_Translated_Source_Code_),__T(Date_Of_Birth_));
    SELF.D_O_B_Source_List_Sorted_ := __CN(__EE6539853);
    SELF.P___Inp_Cln_Addr_Prim_Name_ := __PP6538574.Input_Primary_Name_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Prim_Rng_ := __PP6538574.Input_Primary_Range_Clean_Value_;
    SELF.P___Inp_Cln_Addr_Zip5_ := __PP6538574.Input_Zip5_Clean_Value_;
    SELF := __PP6538574;
  END;
  EXPORT __ENH_Address_Summary_2 := PROJECT(__EE6540128,__ND6539805__Project(LEFT));
END;
