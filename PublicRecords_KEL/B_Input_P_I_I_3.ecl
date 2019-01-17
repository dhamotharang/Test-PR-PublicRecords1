﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Input_P_I_I_4,CFG_Compile,E_Person,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Input_P_I_I_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4;
  SHARED __EE25545 := __ENH_Input_P_I_I_4;
  EXPORT __ST20773_Layout := RECORD
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
    KEL.typ.nstr Input_Address_Suffix_Clean_Value_;
    KEL.typ.nstr Input_Post_Direction_Clean_Value_;
    KEL.typ.nstr Input_Pre_Direction_Clean_Value_;
    KEL.typ.nstr Input_Primary_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Range_Clean_Value_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Value_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Value_;
    KEL.typ.bool Name_Not_Populated_ := FALSE;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST20773_Layout __ND25619__Project(B_Input_P_I_I_4(__in,__cfg).__ST21093_Layout __PP25168) := TRANSFORM
    __CC3339 := '-99';
    __CC3344 := '-98';
    SELF.Input_Address_Suffix_Clean_Value_ := IF(__PP25168.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3339)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP25168.Input_Address_Suffix_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3344)))));
    SELF.Input_Post_Direction_Clean_Value_ := IF(__PP25168.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3339)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP25168.Input_Post_Direction_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3344)))));
    SELF.Input_Pre_Direction_Clean_Value_ := IF(__PP25168.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3339)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP25168.Input_Pre_Direction_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3344)))));
    SELF.Input_Primary_Name_Clean_Value_ := IF(__PP25168.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3339)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP25168.Input_Primary_Name_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3344)))));
    SELF.Input_Primary_Range_Clean_Value_ := IF(__PP25168.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3339)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP25168.Input_Primary_Range_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3344)))));
    SELF.Input_Secondary_Range_Clean_Value_ := IF(__PP25168.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3339)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP25168.Input_Secondary_Range_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3344)))));
    SELF.Input_Unit_Desig_Clean_Value_ := IF(__PP25168.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3339)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP25168.Input_Unit_Desig_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3344)))));
    SELF.Name_Not_Populated_ := IF(FN_Compile.FN_Name_Not_Populated_Check(__ECAST(KEL.typ.nstr,__PP25168.Input_First_Name_Echo_),__ECAST(KEL.typ.nstr,__PP25168.Input_Middle_Name_Echo_),__ECAST(KEL.typ.nstr,__PP25168.Input_Last_Name_Echo_)),TRUE,FALSE);
    SELF := __PP25168;
  END;
  EXPORT __ENH_Input_P_I_I_3 := PROJECT(__EE25545,__ND25619__Project(LEFT));
END;
