﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Input_B_I_I_8,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,FN_Compile FROM BRM_Marketing_attributes.BRM_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Input_B_I_I_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_B_I_I_8(__in,__cfg).__ENH_Input_B_I_I_8) __ENH_Input_B_I_I_8 := B_Input_B_I_I_8(__in,__cfg).__ENH_Input_B_I_I_8;
  SHARED __EE813904 := __ENH_Input_B_I_I_8;
  EXPORT __ST165023_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.nint G___Proc_Bus_U_I_D_;
    KEL.typ.nint B___Inp_Lex_I_D_Ult_;
    KEL.typ.nint B___Inp_Lex_I_D_Org_;
    KEL.typ.nint B___Inp_Lex_I_D_Legal_;
    KEL.typ.nint B___Inp_Lex_I_D_Site_;
    KEL.typ.nint B___Inp_Lex_I_D_Loc_;
    KEL.typ.nstr B___Inp_Name_;
    KEL.typ.nstr B___Inp_Alt_Name_;
    KEL.typ.nstr B___Inp_Addr_Line1_;
    KEL.typ.nstr B___Inp_Addr_Line2_;
    KEL.typ.nstr B___Inp_Addr_City_;
    KEL.typ.nstr B___Inp_Addr_State_;
    KEL.typ.nstr B___Inp_Addr_Zip_;
    KEL.typ.nstr B___Inp_Phone_;
    KEL.typ.nstr Business_T_I_N_;
    KEL.typ.nstr B___Inp_I_P_Addr_;
    KEL.typ.nstr B___Inp_U_R_L_;
    KEL.typ.nstr B___Inp_Email_;
    KEL.typ.nstr B___Inp_S_I_C_Code_;
    KEL.typ.nstr B___Inp_N_A_I_C_S_Code_;
    KEL.typ.nstr B___Inp_T_I_N_;
    KEL.typ.nstr B___Inp_Arch_Dt_;
    KEL.typ.nint B___Lex_I_D_Ult_;
    KEL.typ.nint B___Lex_I_D_Org_;
    KEL.typ.nint B___Lex_I_D_Legal_;
    KEL.typ.nint B___Lex_I_D_Site_;
    KEL.typ.nint B___Lex_I_D_Loc_;
    KEL.typ.nint B___Lex_I_D_Legal_Score_;
    KEL.typ.nint B___Lex_I_D_Legal_Wgt_;
    KEL.typ.nstr B___Inp_Cln_Name_;
    KEL.typ.nstr B___Inp_Cln_Alt_Name_;
    KEL.typ.nstr B___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr B___Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr B___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr B___Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr B___Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr B___Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr B___Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr B___Inp_Cln_Addr_City_;
    KEL.typ.nstr B___Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr B___Inp_Cln_Addr_State_;
    KEL.typ.nstr B___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr B___Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr B___Inp_Cln_Addr_Lat_;
    KEL.typ.nstr B___Inp_Cln_Addr_Lng_;
    KEL.typ.nstr B___Inp_Cln_Addr_State_Code_;
    KEL.typ.nstr B___Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr B___Inp_Cln_Addr_Geo_;
    KEL.typ.nstr B___Inp_Cln_Addr_Type_;
    KEL.typ.nstr B___Inp_Cln_Addr_Status_;
    KEL.typ.nstr B___Inp_Cln_Phone_;
    KEL.typ.nstr B___Inp_Cln_Email_;
    KEL.typ.nstr B___Inp_Cln_T_I_N_;
    KEL.typ.nint B___Inp_Cln_Arch_Dt_;
    KEL.typ.nstr Phone_Verification_Bureau_;
    KEL.typ.nstr Dial_Indicator_;
    KEL.typ.nstr Point_I_D_;
    KEL.typ.nstr N_X_X_Type_;
    KEL.typ.nbool Z_I_P_Match_;
    KEL.typ.nstr C_O_C_Type_;
    KEL.typ.nstr S_S_C_;
    KEL.typ.nstr Wireless_Indicator_;
    KEL.typ.nstr Archive_Date_;
    KEL.typ.bool Addr_Not_Populated_ := FALSE;
    KEL.typ.nstr B___Inp_Addr_;
    KEL.typ.nstr Bus_Input_Addr_Suffix_Clean_Value_;
    KEL.typ.nstr Bus_Input_Name_Clean_Value_;
    KEL.typ.nstr Bus_Input_Phone_Clean_Value_;
    KEL.typ.nstr Bus_Input_Post_Dir_Clean_Value_;
    KEL.typ.nstr Bus_Input_Pre_Dir_Clean_Value_;
    KEL.typ.nstr Bus_Input_Prim_Name_Clean_Value_;
    KEL.typ.nstr Bus_Input_Prim_Range_Clean_Value_;
    KEL.typ.nstr Bus_Input_Sec_Range_Clean_Value_;
    KEL.typ.nstr Bus_Input_T_I_N_Clean_Value_;
    KEL.typ.nstr Bus_Input_Unit_Desig_Clean_Value_;
    KEL.typ.nbool City_State_Zip_Not_Populated_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST165023_Layout __ND814270__Project(B_Input_B_I_I_8(__in,__cfg).__ST156753_Layout __PP813905) := TRANSFORM
    __CC13542 := '-99999';
    __CC13547 := '-99998';
    SELF.Bus_Input_Addr_Suffix_Clean_Value_ := MAP(__PP813905.Addr_Not_Populated_=>__ECAST(KEL.typ.nstr,__CN(__CC13542)),__T(__PP813905.City_State_Zip_Not_Populated_)=>__ECAST(KEL.typ.nstr,__CN(__CC13547)),__ECAST(KEL.typ.nstr,FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP813905.B___Inp_Cln_Addr_Sffx_),__ECAST(KEL.typ.nstr,__CN(__CC13547)))));
    SELF.Bus_Input_Post_Dir_Clean_Value_ := MAP(__PP813905.Addr_Not_Populated_=>__ECAST(KEL.typ.nstr,__CN(__CC13542)),__T(__PP813905.City_State_Zip_Not_Populated_)=>__ECAST(KEL.typ.nstr,__CN(__CC13547)),__ECAST(KEL.typ.nstr,FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP813905.B___Inp_Cln_Addr_Post_Dir_),__ECAST(KEL.typ.nstr,__CN(__CC13547)))));
    SELF.Bus_Input_Pre_Dir_Clean_Value_ := MAP(__PP813905.Addr_Not_Populated_=>__ECAST(KEL.typ.nstr,__CN(__CC13542)),__T(__PP813905.City_State_Zip_Not_Populated_)=>__ECAST(KEL.typ.nstr,__CN(__CC13547)),__ECAST(KEL.typ.nstr,FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP813905.B___Inp_Cln_Addr_Pre_Dir_),__ECAST(KEL.typ.nstr,__CN(__CC13547)))));
    SELF.Bus_Input_Prim_Name_Clean_Value_ := MAP(__PP813905.Addr_Not_Populated_=>__ECAST(KEL.typ.nstr,__CN(__CC13542)),__T(__PP813905.City_State_Zip_Not_Populated_)=>__ECAST(KEL.typ.nstr,__CN(__CC13547)),__ECAST(KEL.typ.nstr,FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP813905.B___Inp_Cln_Addr_Prim_Name_),__ECAST(KEL.typ.nstr,__CN(__CC13547)))));
    SELF.Bus_Input_Prim_Range_Clean_Value_ := MAP(__PP813905.Addr_Not_Populated_=>__ECAST(KEL.typ.nstr,__CN(__CC13542)),__T(__PP813905.City_State_Zip_Not_Populated_)=>__ECAST(KEL.typ.nstr,__CN(__CC13547)),__ECAST(KEL.typ.nstr,FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP813905.B___Inp_Cln_Addr_Prim_Rng_),__ECAST(KEL.typ.nstr,__CN(__CC13547)))));
    SELF.Bus_Input_Sec_Range_Clean_Value_ := MAP(__PP813905.Addr_Not_Populated_=>__ECAST(KEL.typ.nstr,__CN(__CC13542)),__T(__PP813905.City_State_Zip_Not_Populated_)=>__ECAST(KEL.typ.nstr,__CN(__CC13547)),__ECAST(KEL.typ.nstr,FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP813905.B___Inp_Cln_Addr_Sec_Rng_),__ECAST(KEL.typ.nstr,__CN(__CC13547)))));
    SELF.Bus_Input_Unit_Desig_Clean_Value_ := MAP(__PP813905.Addr_Not_Populated_=>__ECAST(KEL.typ.nstr,__CN(__CC13542)),__T(__PP813905.City_State_Zip_Not_Populated_)=>__ECAST(KEL.typ.nstr,__CN(__CC13547)),__ECAST(KEL.typ.nstr,FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP813905.B___Inp_Cln_Addr_Unit_Desig_),__ECAST(KEL.typ.nstr,__CN(__CC13547)))));
    SELF := __PP813905;
  END;
  EXPORT __ENH_Input_B_I_I_7 := PROJECT(__EE813904,__ND814270__Project(LEFT));
END;
