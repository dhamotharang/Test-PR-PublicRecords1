//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Input_P_I_I_6,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Input_P_I_I_5(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_6(__in,__cfg).__ENH_Input_P_I_I_6) __ENH_Input_P_I_I_6 := B_Input_P_I_I_6(__in,__cfg).__ENH_Input_P_I_I_6;
  SHARED __EE5557300 := __ENH_Input_P_I_I_6;
  EXPORT __ST278520_Layout := RECORD
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
    KEL.typ.bool Addr_Not_Populated_ := FALSE;
    KEL.typ.nbool City_State_Zip_Not_Populated_;
    KEL.typ.nbool Clean_City_State_Zip_Not_Populated_;
    KEL.typ.nint D_P_P_A_Purpose_;
    KEL.typ.nint G_L_B_Purpose_;
    KEL.typ.nbool Gateway_Is_F_C_R_A_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Value_;
    KEL.typ.nstr Input_City_Clean_Value_;
    KEL.typ.nstr Input_First_Name_Value_;
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
    KEL.typ.nstr P___Inp_Addr_;
    KEL.typ.str P___Inp_Addr_City_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_State_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_Zip_Flag_Value_ := '';
    KEL.typ.nstr P___Inp_Cln_Addr_St_Flag_Value_;
    KEL.typ.str P___Inp_Val_Name_Bogus_Flag_ := '';
    KEL.typ.nstr Targus_Gateway_I_P_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST278520_Layout __ND5557866__Project(B_Input_P_I_I_6(__in,__cfg).__ST278012_Layout __PP5557301) := TRANSFORM
    SELF.Clean_City_State_Zip_Not_Populated_ := FN_Compile(__cfg).FN_City_State_Zip_Not_Populated_Check(__ECAST(KEL.typ.nstr,__PP5557301.P___Inp_Cln_Addr_City_),__ECAST(KEL.typ.nstr,__PP5557301.P___Inp_Cln_Addr_State_),__ECAST(KEL.typ.nstr,__PP5557301.P___Inp_Cln_Addr_Zip5_));
    SELF.D_P_P_A_Purpose_ := FN_Compile(__cfg).FN_G_E_T___S_T_O_R_E_D___D_P_P_A_P_U_R_P_O_S_E(__ECAST(KEL.typ.nstr,__CN('DummyValue')));
    SELF.G_L_B_Purpose_ := FN_Compile(__cfg).FN_G_E_T___S_T_O_R_E_D___G_L_B_P_U_R_P_O_S_E(__ECAST(KEL.typ.nstr,__CN('DummyValue')));
    SELF.Gateway_Is_F_C_R_A_ := FN_Compile(__cfg).FN_G_E_T___S_T_O_R_E_D___I_S___F_C_R_A(__ECAST(KEL.typ.nstr,__CN('DummyValue')));
    __CC13564 := '-99999';
    __CC13569 := '-99998';
    SELF.Input_City_Clean_Value_ := MAP(__T(__AND(__CN(__PP5557301.P___Inp_Addr_City_Flag_Value_ = '0'),__OR(__CN(__PP5557301.Addr_Not_Populated_),__PP5557301.City_State_Zip_Not_Populated_)))=>__ECAST(KEL.typ.nstr,__CN(__CC13564)),__T(__AND(__CN(__PP5557301.P___Inp_Addr_City_Flag_Value_ = '1'),__OR(__CN(__PP5557301.Addr_Not_Populated_),__PP5557301.City_State_Zip_Not_Populated_)))=>__ECAST(KEL.typ.nstr,__CN(__CC13569)),__ECAST(KEL.typ.nstr,FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP5557301.P___Inp_Cln_Addr_City_),__ECAST(KEL.typ.nstr,__CN(__CC13569)))));
    SELF.Input_State_Clean_Value_ := MAP(__T(__AND(__CN(__PP5557301.P___Inp_Addr_State_Flag_Value_ = '0'),__OR(__CN(__PP5557301.Addr_Not_Populated_),__PP5557301.City_State_Zip_Not_Populated_)))=>__ECAST(KEL.typ.nstr,__CN(__CC13564)),__T(__AND(__CN(__PP5557301.P___Inp_Addr_State_Flag_Value_ = '1'),__OR(__CN(__PP5557301.Addr_Not_Populated_),__PP5557301.City_State_Zip_Not_Populated_)))=>__ECAST(KEL.typ.nstr,__CN(__CC13569)),__ECAST(KEL.typ.nstr,FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP5557301.P___Inp_Cln_Addr_State_),__ECAST(KEL.typ.nstr,__CN(__CC13569)))));
    SELF.Input_Zip4_Clean_Value_ := MAP(__T(__AND(__CN(__PP5557301.P___Inp_Addr_Zip_Flag_Value_ = '0'),__OR(__CN(__PP5557301.Addr_Not_Populated_),__PP5557301.City_State_Zip_Not_Populated_)))=>__ECAST(KEL.typ.nstr,__CN(__CC13564)),__T(__AND(__CN(__PP5557301.P___Inp_Addr_Zip_Flag_Value_ = '1'),__OR(__CN(__PP5557301.Addr_Not_Populated_),__PP5557301.City_State_Zip_Not_Populated_)))=>__ECAST(KEL.typ.nstr,__CN(__CC13569)),__ECAST(KEL.typ.nstr,FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP5557301.P___Inp_Cln_Addr_Zip4_),__ECAST(KEL.typ.nstr,__CN(__CC13569)))));
    SELF.Input_Zip5_Clean_Value_ := MAP(__T(__AND(__CN(__PP5557301.P___Inp_Addr_Zip_Flag_Value_ = '0'),__OR(__CN(__PP5557301.Addr_Not_Populated_),__PP5557301.City_State_Zip_Not_Populated_)))=>__ECAST(KEL.typ.nstr,__CN(__CC13564)),__T(__AND(__CN(__PP5557301.P___Inp_Addr_Zip_Flag_Value_ = '1'),__OR(__CN(__PP5557301.Addr_Not_Populated_),__PP5557301.City_State_Zip_Not_Populated_)))=>__ECAST(KEL.typ.nstr,__CN(__CC13569)),__ECAST(KEL.typ.nstr,FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP5557301.P___Inp_Cln_Addr_Zip5_),__ECAST(KEL.typ.nstr,__CN(__CC13569)))));
    SELF.Name_Not_Populated_ := IF(FN_Compile(__cfg).FN_Name_Not_Populated_Check(__ECAST(KEL.typ.nstr,__PP5557301.P___Inp_Name_First_),__ECAST(KEL.typ.nstr,__PP5557301.P___Inp_Name_Mid_),__ECAST(KEL.typ.nstr,__PP5557301.P___Inp_Name_Last_)),TRUE,FALSE);
    SELF.P___Inp_Cln_Addr_St_Flag_Value_ := FN_Compile(__cfg).FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP5557301.Input_Street_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC13564)),__ECAST(KEL.typ.nstr,__CN(__CC13569)));
    SELF.P___Inp_Val_Name_Bogus_Flag_ := MAP(__T(__AND(__AND(__OP2(__PP5557301.Input_First_Name_Value_,=,__CN(__CC13564)),__OP2(__PP5557301.Input_Middle_Name_Value_,=,__CN(__CC13564))),__OP2(__PP5557301.Input_Last_Name_Value_,=,__CN(__CC13564))))=>__CC13564,__T(__OP2(FN_Compile(__cfg).FN__fn_Bogus_Names(__ECAST(KEL.typ.nstr,__FN1(KEL.Routines.ToUpperCase,__PP5557301.P___Inp_Name_First_)),__ECAST(KEL.typ.nstr,__FN1(KEL.Routines.ToUpperCase,__PP5557301.Input_Middle_Name_Value_)),__ECAST(KEL.typ.nstr,__FN1(KEL.Routines.ToUpperCase,__PP5557301.Input_Last_Name_Value_))),=,__CAST(KEL.typ.str,__CN(1))))=>(KEL.typ.str)1,(KEL.typ.str)0);
    SELF.Targus_Gateway_I_P_ := FN_Compile(__cfg).FN_G_E_T___T_A_R_G_U_S___U_R_L(__ECAST(KEL.typ.nstr,__CN('DummyValue')));
    SELF := __PP5557301;
  END;
  EXPORT __ENH_Input_P_I_I_5 := PROJECT(__EE5557300,__ND5557866__Project(LEFT));
END;
