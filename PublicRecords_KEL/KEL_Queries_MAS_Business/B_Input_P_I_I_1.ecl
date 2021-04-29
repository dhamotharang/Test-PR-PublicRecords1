﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Input_P_I_I_2,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL15.Null;
EXPORT B_Input_P_I_I_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_2(__in,__cfg).__ENH_Input_P_I_I_2) __ENH_Input_P_I_I_2 := B_Input_P_I_I_2(__in,__cfg).__ENH_Input_P_I_I_2;
  SHARED __EE3213293 := __ENH_Input_P_I_I_2;
  EXPORT __ST167951_Layout := RECORD
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
    KEL.typ.nstr Input_Account_Value_;
    KEL.typ.nstr Input_Address_Status_Clean_Value_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Value_;
    KEL.typ.nstr Input_Address_Type_Clean_Value_;
    KEL.typ.nstr Input_City_Clean_Value_;
    KEL.typ.nstr Input_City_Post_Clean_Value_;
    KEL.typ.nstr Input_City_Value_;
    KEL.typ.nstr Input_County_Clean_Value_;
    KEL.typ.nstr Input_D_L_Clean_Value_;
    KEL.typ.nstr Input_D_L_State_Clean_Value_;
    KEL.typ.nstr Input_D_L_State_Value_;
    KEL.typ.nstr Input_D_L_Value_;
    KEL.typ.nstr Input_D_O_B_Clean_Value_;
    KEL.typ.nstr Input_D_O_B_Value_;
    KEL.typ.nstr Input_Email_Clean_Value_;
    KEL.typ.nstr Input_Email_Value_;
    KEL.typ.nstr Input_First_Name_Clean_Value_;
    KEL.typ.nstr Input_First_Name_Value_;
    KEL.typ.nstr Input_Full_Address_Clean_Value_;
    KEL.typ.nstr Input_Geoblock_Clean_Value_;
    KEL.typ.nstr Input_Home_Phone_Clean_Value_;
    KEL.typ.nstr Input_Home_Phone_Value_;
    KEL.typ.nstr Input_Last_Name_Clean_Value_;
    KEL.typ.nstr Input_Last_Name_Value_;
    KEL.typ.nstr Input_Latitude_Clean_Value_;
    KEL.typ.nint Input_Lex_I_D_Value_;
    KEL.typ.nstr Input_Longitude_Clean_Value_;
    KEL.typ.nstr Input_Middle_Name_Clean_Value_;
    KEL.typ.nstr Input_Middle_Name_Value_;
    KEL.typ.nstr Input_Post_Direction_Clean_Value_;
    KEL.typ.nstr Input_Pre_Direction_Clean_Value_;
    KEL.typ.nstr Input_Prefix_Clean_Value_;
    KEL.typ.nstr Input_Primary_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Range_Clean_Value_;
    KEL.typ.nstr Input_S_S_N_Clean_Value_;
    KEL.typ.nstr Input_S_S_N_Value_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Value_;
    KEL.typ.nstr Input_State_Clean_Value_;
    KEL.typ.nstr Input_State_Code_Clean_Value_;
    KEL.typ.nstr Input_State_Value_;
    KEL.typ.nstr Input_Street_Clean_Value_;
    KEL.typ.nstr Input_Street_Value_;
    KEL.typ.nstr Input_Suffix_Clean_Value_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Value_;
    KEL.typ.nstr Input_Zip4_Clean_Value_;
    KEL.typ.nstr Input_Zip5_Clean_Value_;
    KEL.typ.nstr Input_Zip_Value_;
    KEL.typ.str P___Inp_Addr_City_Flag_Value_ := '';
    KEL.typ.nstr P___Inp_Addr_Line2_Value_;
    KEL.typ.str P___Inp_Addr_St_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_State_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_Zip_Flag_Value_ := '';
    KEL.typ.nstr P___Inp_Cln_Addr_City_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_Post_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Cnty_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Full_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Geo_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lat_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lng_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Post_Dir_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Pre_Dir_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sec_Rng_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sffx_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_St_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Status_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Type_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Unit_Desig_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip4_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_D_L_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_D_L_State_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Email_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Name_First_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Name_Mid_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Name_Prfx_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Name_Sffx_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_Flag_Value_;
    KEL.typ.str P___Inp_D_L_Flag_Value_ := '';
    KEL.typ.str P___Inp_D_L_State_Flag_Value_ := '';
    KEL.typ.str P___Inp_D_O_B_Flag_Value_ := '';
    KEL.typ.str P___Inp_Email_Flag_Value_ := '';
    KEL.typ.str P___Inp_Lex_I_D_Flag_Value_ := '';
    KEL.typ.str P___Inp_Name_First_Flag_Value_ := '';
    KEL.typ.str P___Inp_Name_Last_Flag_Value_ := '';
    KEL.typ.str P___Inp_Name_Mid_Flag_Value_ := '';
    KEL.typ.str P___Inp_Phone_Home_Flag_Value_ := '';
    KEL.typ.str P___Inp_S_S_N_Flag_Value_ := '';
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST167951_Layout __ND3214271__Project(B_Input_P_I_I_2(__in,__cfg).__ST226210_Layout __PP3213294) := TRANSFORM
    __CC13587 := '-99999';
    SELF.Input_Account_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_Acct_),__ECAST(KEL.typ.nstr,__CN(__CC13587)));
    SELF.Input_City_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_Addr_City_),__ECAST(KEL.typ.nstr,__CN(__CC13587)));
    SELF.Input_D_L_State_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_D_L_State_),__ECAST(KEL.typ.nstr,__CN(__CC13587)));
    SELF.Input_D_L_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_D_L_),__ECAST(KEL.typ.nstr,__CN(__CC13587)));
    SELF.Input_D_O_B_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_D_O_B_),__ECAST(KEL.typ.nstr,__CN(__CC13587)));
    SELF.Input_Email_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_Email_),__ECAST(KEL.typ.nstr,__CN(__CC13587)));
    SELF.Input_Home_Phone_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_Phone_Home_),__ECAST(KEL.typ.nstr,__CN(__CC13587)));
    __CC13590 := -99999;
    SELF.Input_Lex_I_D_Value_ := FN_Compile(__cfg).FN_Is_Zero(__ECAST(KEL.typ.nint,__PP3213294.P___Inp_Lex_I_D_),__ECAST(KEL.typ.nint,__CN(__CC13590)));
    SELF.Input_S_S_N_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_S_S_N_),__ECAST(KEL.typ.nstr,__CN(__CC13587)));
    __CC13592 := '-99998';
    SELF.Input_State_Code_Clean_Value_ := IF(__T(__OR(__CN(__PP3213294.Addr_Not_Populated_),__PP3213294.City_State_Zip_Not_Populated_)),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_Cln_Addr_State_Code_),__ECAST(KEL.typ.nstr,__CN(__CC13592)))));
    SELF.Input_State_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_Addr_State_),__ECAST(KEL.typ.nstr,__CN(__CC13587)));
    SELF.Input_Street_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_Addr_Line1_),__ECAST(KEL.typ.nstr,__CN(__CC13587)));
    SELF.Input_Zip_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_Addr_Zip_),__ECAST(KEL.typ.nstr,__CN(__CC13587)));
    SELF.P___Inp_Addr_Line2_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_Addr_Line2_),__ECAST(KEL.typ.nstr,__CN(__CC13587)));
    SELF.P___Inp_Addr_St_Flag_Value_ := FN_Compile(__cfg).FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_Addr_));
    SELF.P___Inp_Cln_Addr_City_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_City_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Addr_City_Post_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_City_Post_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Addr_Cnty_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_County_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Addr_Full_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Full_Address_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Addr_Geo_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Geoblock_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Addr_Lat_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Latitude_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Addr_Lng_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Longitude_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Addr_Post_Dir_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Post_Direction_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Addr_Pre_Dir_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Pre_Direction_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Addr_Prim_Name_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Primary_Name_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Addr_Prim_Rng_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Primary_Range_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Addr_Sec_Rng_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Secondary_Range_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Addr_Sffx_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Address_Suffix_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Addr_State_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_State_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Addr_Status_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Address_Status_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Addr_Type_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Address_Type_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Addr_Unit_Desig_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Unit_Desig_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Addr_Zip4_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Zip4_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Addr_Zip5_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Zip5_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_D_L_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_D_L_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_D_L_State_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_D_L_State_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_D_O_B_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_D_O_B_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Email_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Email_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_Name_First_Flag_Value_ := MAP(__PP3213294.P___Inp_Val_Name_Bogus_Flag_ = (KEL.typ.str)1=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(0))),__ECAST(KEL.typ.nstr,FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_First_Name_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)))));
    SELF.P___Inp_Cln_Name_Last_Flag_Value_ := MAP(__PP3213294.P___Inp_Val_Name_Bogus_Flag_ = (KEL.typ.str)1=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(0))),__ECAST(KEL.typ.nstr,FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Last_Name_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)))));
    SELF.P___Inp_Cln_Name_Mid_Flag_Value_ := MAP(__PP3213294.P___Inp_Val_Name_Bogus_Flag_ = (KEL.typ.str)1=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(0))),__ECAST(KEL.typ.nstr,FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Middle_Name_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)))));
    SELF.P___Inp_Cln_Name_Prfx_Flag_Value_ := MAP(__PP3213294.P___Inp_Val_Name_Bogus_Flag_ = (KEL.typ.str)1=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(0))),__ECAST(KEL.typ.nstr,FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Prefix_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)))));
    SELF.P___Inp_Cln_Name_Sffx_Flag_Value_ := MAP(__PP3213294.P___Inp_Val_Name_Bogus_Flag_ = (KEL.typ.str)1=>__ECAST(KEL.typ.nstr,__CAST(KEL.typ.str,__CN(0))),__ECAST(KEL.typ.nstr,FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Suffix_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)))));
    SELF.P___Inp_Cln_Phone_Home_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_Home_Phone_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_Cln_S_S_N_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP3213294.Input_S_S_N_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13587)),__ECAST(KEL.typ.nstr,__CN(__CC13592)));
    SELF.P___Inp_D_L_Flag_Value_ := FN_Compile(__cfg).FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_D_L_));
    SELF.P___Inp_D_L_State_Flag_Value_ := FN_Compile(__cfg).FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_D_L_State_));
    SELF.P___Inp_D_O_B_Flag_Value_ := FN_Compile(__cfg).FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_D_O_B_));
    SELF.P___Inp_Email_Flag_Value_ := FN_Compile(__cfg).FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_Email_));
    SELF.P___Inp_Lex_I_D_Flag_Value_ := FN_Compile(__cfg).FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_Lex_I_D_));
    SELF.P___Inp_Name_First_Flag_Value_ := FN_Compile(__cfg).FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_Name_First_));
    SELF.P___Inp_Name_Last_Flag_Value_ := FN_Compile(__cfg).FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_Name_Last_));
    SELF.P___Inp_Name_Mid_Flag_Value_ := FN_Compile(__cfg).FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_Name_Mid_));
    SELF.P___Inp_Phone_Home_Flag_Value_ := FN_Compile(__cfg).FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_Phone_Home_));
    SELF.P___Inp_S_S_N_Flag_Value_ := FN_Compile(__cfg).FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP3213294.P___Inp_S_S_N_));
    SELF := __PP3213294;
  END;
  EXPORT __ENH_Input_P_I_I_1 := PROJECT(__EE3213293,__ND3214271__Project(LEFT));
END;
