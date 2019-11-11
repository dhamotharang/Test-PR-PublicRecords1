﻿//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Input_P_I_I_5,CFG_Compile,E_Person,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Input_P_I_I_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5) __ENH_Input_P_I_I_5 := B_Input_P_I_I_5(__in,__cfg).__ENH_Input_P_I_I_5;
  SHARED __EE220623 := __ENH_Input_P_I_I_5;
  EXPORT __ST92951_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr P___Inp_Acct_;
    KEL.typ.nint P___Inp_Lex_I_D_;
    KEL.typ.nstr P___Inp_Name_First_;
    KEL.typ.nstr P___Inp_Name_Mid_;
    KEL.typ.nstr P___Inp_Name_Last_;
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
    KEL.typ.nstr Input_Employment_Echo_;
    KEL.typ.nstr P___Inp_Arch_Dt_;
    KEL.typ.nint P___Lex_I_D_;
    KEL.typ.nint P___Lex_I_D_Score_;
    KEL.typ.nstr P___Inp_Cln_Name_Prfx_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Mid_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Name_Sffx_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr P___Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lat_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr P___Inp_Cln_Addr_Geo_;
    KEL.typ.nstr P___Inp_Cln_Addr_Type_;
    KEL.typ.nstr P___Inp_Cln_Addr_Status_;
    KEL.typ.nstr P___Inp_Cln_Email_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.nstr P___Inp_Cln_Phone_Work_;
    KEL.typ.nstr P___Inp_Cln_D_L_;
    KEL.typ.nstr P___Inp_Cln_D_L_State_;
    KEL.typ.nkdate P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
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
    KEL.typ.nstr Input_Address_Suffix_Clean_Value_;
    KEL.typ.nstr Input_Post_Direction_Clean_Value_;
    KEL.typ.nstr Input_Pre_Direction_Clean_Value_;
    KEL.typ.nstr Input_Primary_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Range_Clean_Value_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Value_;
    KEL.typ.nstr Input_Street_Clean_Value_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Value_;
    KEL.typ.nstr P___Inp_Addr_;
    KEL.typ.str P___Inp_Addr_City_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_State_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_Zip_Flag_Value_ := '';
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST92951_Layout __ND220710__Project(B_Input_P_I_I_5(__in,__cfg).__ST94441_Layout __PP220111) := TRANSFORM
    SELF.At_Position_ := FN_Compile(__cfg).FN_Find_Last_String_Instance(__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP220111.P___Inp_Email_)),__ECAST(KEL.typ.nstr,__CN('@')));
    __CC7890 := '-99999';
    __CC7895 := '-99998';
    SELF.Input_Street_Clean_Value_ := MAP(__PP220111.Addr_Not_Populated_=>__ECAST(KEL.typ.nstr,__CN(__CC7890)),__T(__AND(__AND(__AND(__AND(__AND(__AND(__OP2(__PP220111.Input_Primary_Range_Clean_Value_,=,__CN(__CC7895)),__OP2(__PP220111.Input_Pre_Direction_Clean_Value_,=,__CN(__CC7895))),__OP2(__PP220111.Input_Primary_Name_Clean_Value_,=,__CN(__CC7895))),__OP2(__PP220111.Input_Address_Suffix_Clean_Value_,=,__CN(__CC7895))),__OP2(__PP220111.Input_Post_Direction_Clean_Value_,=,__CN(__CC7895))),__OP2(__PP220111.Input_Unit_Desig_Clean_Value_,=,__CN(__CC7895))),__OP2(__PP220111.Input_Secondary_Range_Clean_Value_,=,__CN(__CC7895))))=>__ECAST(KEL.typ.nstr,__CN(__CC7895)),__ECAST(KEL.typ.nstr,__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(IF(__T(__OP2(__PP220111.Input_Primary_Range_Clean_Value_,=,__CN(__CC7895))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP220111.P___Inp_Cln_Addr_Prim_Rng_),+,__CN(' ')))),+,IF(__T(__OP2(__PP220111.Input_Pre_Direction_Clean_Value_,=,__CN(__CC7895))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP220111.P___Inp_Cln_Addr_Pre_Dir_),+,__CN(' '))))),+,IF(__T(__OP2(__PP220111.Input_Primary_Name_Clean_Value_,=,__CN(__CC7895))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP220111.P___Inp_Cln_Addr_Prim_Name_),+,__CN(' '))))),+,IF(__T(__OP2(__PP220111.Input_Address_Suffix_Clean_Value_,=,__CN(__CC7895))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP220111.P___Inp_Cln_Addr_Sffx_),+,__CN(' '))))),+,IF(__T(__OP2(__PP220111.Input_Post_Direction_Clean_Value_,=,__CN(__CC7895))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP220111.P___Inp_Cln_Addr_Post_Dir_),+,__CN(' '))))),+,IF(__T(__OP2(__PP220111.Input_Unit_Desig_Clean_Value_,=,__CN(__CC7895))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP220111.P___Inp_Cln_Addr_Unit_Desig_),+,__CN(' '))))),+,IF(__T(__OP2(__PP220111.Input_Secondary_Range_Clean_Value_,=,__CN(__CC7895))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP220111.P___Inp_Cln_Addr_Sec_Rng_))))));
    SELF.P___Inp_Addr_City_Flag_Value_ := FN_Compile(__cfg).FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP220111.P___Inp_Addr_City_));
    SELF.P___Inp_Addr_State_Flag_Value_ := FN_Compile(__cfg).FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP220111.P___Inp_Addr_State_));
    SELF.P___Inp_Addr_Zip_Flag_Value_ := FN_Compile(__cfg).FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP220111.P___Inp_Addr_Zip_));
    SELF := __PP220111;
  END;
  EXPORT __ENH_Input_P_I_I_4 := PROJECT(__EE220623,__ND220710__Project(LEFT));
END;
