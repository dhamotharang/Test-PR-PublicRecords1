﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT CFG_Compile,E_Input_P_I_I,E_Person,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Input_P_I_I_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Input_P_I_I(__in,__cfg).__Result) __E_Input_P_I_I := E_Input_P_I_I(__in,__cfg).__Result;
  SHARED __EE36375 := __E_Input_P_I_I;
  EXPORT __ST12763_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr Input_Account_Echo_;
    KEL.typ.nint Input_Lex_I_D_Echo_;
    KEL.typ.nstr Input_First_Name_Echo_;
    KEL.typ.nstr Input_Middle_Name_Echo_;
    KEL.typ.nstr Input_Last_Name_Echo_;
    KEL.typ.nstr Input_Address_Echo_;
    KEL.typ.nstr Input_City_Echo_;
    KEL.typ.nstr Input_State_Echo_;
    KEL.typ.nstr Input_Zip_Echo_;
    KEL.typ.nstr Input_Home_Phone_Echo_;
    KEL.typ.nstr Input_S_S_N_Echo_;
    KEL.typ.nstr Input_D_O_B_Echo_;
    KEL.typ.nstr Input_Work_Phone_Echo_;
    KEL.typ.nstr Input_Income_Echo_;
    KEL.typ.nstr Input_D_L_Number_Echo_;
    KEL.typ.nstr Input_D_L_State_Echo_;
    KEL.typ.nstr Input_Balance_Echo_;
    KEL.typ.nstr Input_Charge_Offd_Echo_;
    KEL.typ.nstr Input_Former_Name_Echo_;
    KEL.typ.nstr Input_Email_Echo_;
    KEL.typ.nstr Input_Employment_Echo_;
    KEL.typ.nstr Input_Archive_Date_Echo_;
    KEL.typ.nint Appended_Lex_I_D_;
    KEL.typ.nint Appended_Lex_I_D_Score_;
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
    KEL.typ.nstr Input_City_Name_Clean_;
    KEL.typ.nstr Input_State_Clean_;
    KEL.typ.nstr Input_Zip5_Clean_;
    KEL.typ.nstr Input_Zip4_Clean_;
    KEL.typ.nstr Input_Latitude_Clean_;
    KEL.typ.nstr Input_Longitude_Clean_;
    KEL.typ.nstr Input_County_Clean_;
    KEL.typ.nstr Input_Geoblock_Clean_;
    KEL.typ.nstr Input_Address_Type_Clean_;
    KEL.typ.nstr Input_Address_Status_Clean_;
    KEL.typ.nstr Input_E_Mail_Clean_;
    KEL.typ.nstr Input_Home_Phone_Clean_;
    KEL.typ.nstr Input_Work_Phone_Clean_;
    KEL.typ.nstr Input_D_L_Number_Clean_;
    KEL.typ.nstr Input_D_L_State_Clean_;
    KEL.typ.nkdate Input_D_O_B_Clean_;
    KEL.typ.nstr Input_S_S_N_Clean_;
    KEL.typ.nstr Input_Archive_Date_Clean_;
    KEL.typ.nint Rep_Number_;
    KEL.typ.nstr Input_Account_Value_;
    KEL.typ.nstr Input_Address_Value_;
    KEL.typ.nstr Input_City_Value_;
    KEL.typ.nstr Input_Email_Value_;
    KEL.typ.nstr Input_First_Name_Value_;
    KEL.typ.nstr Input_Home_Phone_Value_;
    KEL.typ.nint Input_Lex_I_D_Value_;
    KEL.typ.nstr Input_State_Value_;
    KEL.typ.nstr Input_Zip_Value_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST12763_Layout __ND36446__Project(E_Input_P_I_I(__in,__cfg).Layout __PP36028) := TRANSFORM
    __CC1830 := '-99';
    SELF.Input_Account_Value_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP36028.Input_Account_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC1830)));
    SELF.Input_Address_Value_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP36028.Input_Address_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC1830)));
    SELF.Input_City_Value_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP36028.Input_City_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC1830)));
    SELF.Input_Email_Value_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP36028.Input_Email_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC1830)));
    SELF.Input_First_Name_Value_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP36028.Input_First_Name_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC1830)));
    SELF.Input_Home_Phone_Value_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP36028.Input_Home_Phone_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC1830)));
    __CC1833 := -99;
    SELF.Input_Lex_I_D_Value_ := FN_Compile.FN_Is_Zero(__ECAST(KEL.typ.nint,__PP36028.Input_Lex_I_D_Echo_),__ECAST(KEL.typ.nint,__CN(__CC1833)));
    SELF.Input_State_Value_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP36028.Input_State_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC1830)));
    SELF.Input_Zip_Value_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP36028.Input_Zip_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC1830)));
    SELF := __PP36028;
  END;
  EXPORT __ENH_Input_P_I_I_1 := PROJECT(__EE36375,__ND36446__Project(LEFT));
END;
