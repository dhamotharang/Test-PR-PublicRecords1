﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Input_P_I_I_3,CFG_Compile,E_Person,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Input_P_I_I_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_3(__in,__cfg).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3(__in,__cfg).__ENH_Input_P_I_I_3;
  SHARED __EE28021 := __ENH_Input_P_I_I_3;
  EXPORT __ST19721_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr Input_Account_Echo_;
    KEL.typ.nint Input_Lex_I_D_Echo_;
    KEL.typ.nstr Input_First_Name_Echo_;
    KEL.typ.nstr Input_Middle_Name_Echo_;
    KEL.typ.nstr Input_Last_Name_Echo_;
    KEL.typ.nstr Input_Street_Echo_;
    KEL.typ.nstr Input_City_Echo_;
    KEL.typ.nstr Input_State_Echo_;
    KEL.typ.nstr Input_Zip_Echo_;
    KEL.typ.nstr Input_Home_Phone_Echo_;
    KEL.typ.nstr Input_S_S_N_Echo_;
    KEL.typ.nstr Input_D_O_B_Echo_;
    KEL.typ.nstr Input_Work_Phone_Echo_;
    KEL.typ.nstr Input_Income_Echo_;
    KEL.typ.nstr Input_D_L_Echo_;
    KEL.typ.nstr Input_D_L_State_Echo_;
    KEL.typ.nstr Input_Balance_Echo_;
    KEL.typ.nstr Input_Charge_Offd_Echo_;
    KEL.typ.nstr Input_Former_Name_Echo_;
    KEL.typ.nstr Input_Email_Echo_;
    KEL.typ.nstr Input_Employment_Echo_;
    KEL.typ.nstr Input_Archive_Date_Echo_;
    KEL.typ.nint Lex_I_D_Append_;
    KEL.typ.nint Lex_I_D_Score_Append_;
    KEL.typ.nstr Input_Prefix_Clean_;
    KEL.typ.nstr Input_First_Name_Clean_;
    KEL.typ.nstr Input_Middle_Name_Clean_;
    KEL.typ.nstr Input_Last_Name_Clean_;
    KEL.typ.nstr Input_Suffix_Clean_;
    KEL.typ.nstr Input_Primary_Range_Clean_;
    KEL.typ.nstr Input_Pre_Direction_Clean_;
    KEL.typ.nstr Input_Primary_Name_Clean_;
    KEL.typ.nstr Input_Address_Suffix_Clean_;
    KEL.typ.nstr Input_Post_Direction_Clean_;
    KEL.typ.nstr Input_Unit_Desig_Clean_;
    KEL.typ.nstr Input_Secondary_Range_Clean_;
    KEL.typ.nstr Input_City_Clean_;
    KEL.typ.nstr Input_State_Clean_;
    KEL.typ.nstr Input_Zip5_Clean_;
    KEL.typ.nstr Input_Zip4_Clean_;
    KEL.typ.nstr Input_Latitude_Clean_;
    KEL.typ.nstr Input_Longitude_Clean_;
    KEL.typ.nstr Input_County_Clean_;
    KEL.typ.nstr Input_Geoblock_Clean_;
    KEL.typ.nstr Input_Address_Type_Clean_;
    KEL.typ.nstr Input_Address_Status_Clean_;
    KEL.typ.nstr Input_Email_Clean_;
    KEL.typ.nstr Input_Home_Phone_Clean_;
    KEL.typ.nstr Input_Work_Phone_Clean_;
    KEL.typ.nstr Input_D_L_Clean_;
    KEL.typ.nstr Input_D_L_State_Clean_;
    KEL.typ.nkdate Input_D_O_B_Clean_;
    KEL.typ.nstr Input_S_S_N_Clean_;
    KEL.typ.nstr Input_Archive_Date_Clean_;
    KEL.typ.nint Bus_Input_U_I_D_Append_;
    KEL.typ.nint Rep_Number_;
    KEL.typ.bool Addr_Not_Populated_ := FALSE;
    KEL.typ.nstr Input_Address_Status_Clean_Value_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Value_;
    KEL.typ.nstr Input_Address_Type_Clean_Value_;
    KEL.typ.nstr Input_City_Clean_Value_;
    KEL.typ.nstr Input_County_Clean_Value_;
    KEL.typ.nstr Input_D_L_Clean_Value_;
    KEL.typ.nstr Input_D_O_B_Clean_Value_;
    KEL.typ.nstr Input_Email_Clean_Value_;
    KEL.typ.nstr Input_First_Name_Clean_Value_;
    KEL.typ.nstr Input_Geoblock_Clean_Value_;
    KEL.typ.nstr Input_Home_Phone_Clean_Value_;
    KEL.typ.nstr Input_Last_Name_Clean_Value_;
    KEL.typ.nstr Input_Latitude_Clean_Value_;
    KEL.typ.nstr Input_Longitude_Clean_Value_;
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
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST19721_Layout __ND28113__Project(B_Input_P_I_I_3(__in,__cfg).__ST20218_Layout __PP27409) := TRANSFORM
    __CC2994 := '-99';
    __CC2999 := '-98';
    SELF.Input_Address_Status_Clean_Value_ := IF(__PP27409.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC2994)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP27409.Input_Address_Status_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC2999)))));
    SELF.Input_Address_Type_Clean_Value_ := IF(__PP27409.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC2994)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP27409.Input_Address_Type_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC2999)))));
    SELF.Input_City_Clean_Value_ := IF(__PP27409.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC2994)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP27409.Input_City_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC2999)))));
    SELF.Input_County_Clean_Value_ := IF(__PP27409.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC2994)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP27409.Input_County_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC2999)))));
    SELF.Input_D_L_Clean_Value_ := FN_Compile.FN_Is_Blank2_Fields(__ECAST(KEL.typ.nstr,__PP27409.Input_D_L_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC2994)),__ECAST(KEL.typ.nstr,__PP27409.Input_D_L_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC2999)));
    SELF.Input_D_O_B_Clean_Value_ := FN_Compile.FN_Is_Blank2_Fields(__ECAST(KEL.typ.nstr,__PP27409.Input_D_O_B_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC2994)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,__PP27409.Input_D_O_B_Clean_,__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC2999)));
    SELF.Input_Email_Clean_Value_ := FN_Compile.FN_Is_Blank2_Fields(__ECAST(KEL.typ.nstr,__PP27409.Input_Email_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC2994)),__ECAST(KEL.typ.nstr,__PP27409.Input_Email_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC2999)));
    SELF.Input_First_Name_Clean_Value_ := IF(__PP27409.Name_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC2994)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP27409.Input_First_Name_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC2999)))));
    SELF.Input_Geoblock_Clean_Value_ := IF(__PP27409.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC2994)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP27409.Input_Geoblock_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC2999)))));
    SELF.Input_Home_Phone_Clean_Value_ := FN_Compile.FN_Is_Blank2_Fields(__ECAST(KEL.typ.nstr,__PP27409.Input_Home_Phone_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC2994)),__ECAST(KEL.typ.nstr,__PP27409.Input_Home_Phone_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC2999)));
    SELF.Input_Last_Name_Clean_Value_ := IF(__PP27409.Name_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC2994)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP27409.Input_Last_Name_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC2999)))));
    SELF.Input_Latitude_Clean_Value_ := IF(__PP27409.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC2994)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP27409.Input_Latitude_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC2999)))));
    SELF.Input_Longitude_Clean_Value_ := IF(__PP27409.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC2994)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP27409.Input_Longitude_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC2999)))));
    SELF.Input_S_S_N_Clean_Value_ := FN_Compile.FN_Is_Blank2_Fields(__ECAST(KEL.typ.nstr,__PP27409.Input_S_S_N_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC2994)),__ECAST(KEL.typ.nstr,__PP27409.Input_S_S_N_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC2999)));
    SELF.Input_State_Clean_Value_ := IF(__PP27409.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC2994)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP27409.Input_State_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC2999)))));
    SELF.Input_Street_Clean_Value_ := MAP(__T(__OR(__OR(__OR(__OR(__OR(__OR(__OP2(__PP27409.Input_Primary_Range_Clean_Value_,=,__CN(__CC2994)),__OP2(__PP27409.Input_Pre_Direction_Clean_Value_,=,__CN(__CC2994))),__OP2(__PP27409.Input_Primary_Name_Clean_Value_,=,__CN(__CC2994))),__OP2(__PP27409.Input_Address_Suffix_Clean_Value_,=,__CN(__CC2994))),__OP2(__PP27409.Input_Post_Direction_Clean_Value_,=,__CN(__CC2994))),__OP2(__PP27409.Input_Unit_Desig_Clean_Value_,=,__CN(__CC2994))),__OP2(__PP27409.Input_Secondary_Range_Clean_Value_,=,__CN(__CC2994))))=>__ECAST(KEL.typ.nstr,__CN(__CC2994)),__T(__AND(__AND(__AND(__AND(__AND(__AND(__OP2(__PP27409.Input_Primary_Range_Clean_Value_,=,__CN(__CC2999)),__OP2(__PP27409.Input_Pre_Direction_Clean_Value_,=,__CN(__CC2999))),__OP2(__PP27409.Input_Primary_Name_Clean_Value_,=,__CN(__CC2999))),__OP2(__PP27409.Input_Address_Suffix_Clean_Value_,=,__CN(__CC2999))),__OP2(__PP27409.Input_Post_Direction_Clean_Value_,=,__CN(__CC2999))),__OP2(__PP27409.Input_Unit_Desig_Clean_Value_,=,__CN(__CC2999))),__OP2(__PP27409.Input_Secondary_Range_Clean_Value_,=,__CN(__CC2999))))=>__ECAST(KEL.typ.nstr,__CN(__CC2999)),__ECAST(KEL.typ.nstr,__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(IF(__T(__OP2(__PP27409.Input_Primary_Range_Clean_Value_,=,__CN(__CC2999))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP27409.Input_Primary_Range_Clean_),+,__CN(' ')))),+,IF(__T(__OP2(__PP27409.Input_Pre_Direction_Clean_Value_,=,__CN(__CC2999))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP27409.Input_Pre_Direction_Clean_),+,__CN(' '))))),+,IF(__T(__OP2(__PP27409.Input_Primary_Name_Clean_Value_,=,__CN(__CC2999))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP27409.Input_Primary_Name_Clean_),+,__CN(' '))))),+,IF(__T(__OP2(__PP27409.Input_Address_Suffix_Clean_Value_,=,__CN(__CC2999))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP27409.Input_Address_Suffix_Clean_),+,__CN(' '))))),+,IF(__T(__OP2(__PP27409.Input_Post_Direction_Clean_Value_,=,__CN(__CC2999))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP27409.Input_Post_Direction_Clean_),+,__CN(' '))))),+,IF(__T(__OP2(__PP27409.Input_Unit_Desig_Clean_Value_,=,__CN(__CC2999))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP27409.Input_Unit_Desig_Clean_),+,__CN(' '))))),+,IF(__T(__OP2(__PP27409.Input_Secondary_Range_Clean_Value_,=,__CN(__CC2999))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP27409.Input_Secondary_Range_Clean_),+,__CN(' ')))))));
    SELF.Input_Zip4_Clean_Value_ := IF(__PP27409.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC2994)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP27409.Input_Zip4_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC2999)))));
    SELF.Input_Zip5_Clean_Value_ := IF(__PP27409.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC2994)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP27409.Input_Zip5_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC2999)))));
    SELF := __PP27409;
  END;
  EXPORT __ENH_Input_P_I_I_2 := PROJECT(__EE28021,__ND28113__Project(LEFT));
END;
