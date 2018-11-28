﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Input_P_I_I_2,CFG_Compile,E_Person,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Input_P_I_I_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_2(__in,__cfg).__ENH_Input_P_I_I_2) __ENH_Input_P_I_I_2 := B_Input_P_I_I_2(__in,__cfg).__ENH_Input_P_I_I_2;
  SHARED __EE51770 := __ENH_Input_P_I_I_2;
  EXPORT __ST17418_Layout := RECORD
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
    KEL.typ.nstr Input_D_L_Number_Echo_;
    KEL.typ.nstr Input_D_L_State_Echo_;
    KEL.typ.nstr Input_Balance_Echo_;
    KEL.typ.nstr Input_Charge_Offd_Echo_;
    KEL.typ.nstr Input_Former_Name_Echo_;
    KEL.typ.nstr Input_Email_Echo_;
    KEL.typ.nstr Input_Employment_Echo_;
    KEL.typ.nstr Input_Archive_Date_Echo_;
    KEL.typ.nstr Input_Account_Echo_Pop_;
    KEL.typ.nstr Input_Lex_I_D_Echo_Pop_;
    KEL.typ.nstr Input_First_Name_Echo_Pop_;
    KEL.typ.nstr Input_Street_Echo_Pop_;
    KEL.typ.nstr Input_City_Echo_Pop_;
    KEL.typ.nstr Input_State_Echo_Pop_;
    KEL.typ.nstr Input_Zip_Echo_Pop_;
    KEL.typ.nstr Input_Home_Phone_Echo_Pop_;
    KEL.typ.nstr Input_Work_Phone_Echo_Pop_;
    KEL.typ.nstr Input_Email_Echo_Pop_;
    KEL.typ.nstr Input_Archive_Date_Echo_Pop_;
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
    KEL.typ.nstr Input_D_L_Number_Clean_;
    KEL.typ.nstr Input_D_L_State_Clean_;
    KEL.typ.nkdate Input_D_O_B_Clean_;
    KEL.typ.nstr Input_S_S_N_Clean_;
    KEL.typ.nstr Input_Archive_Date_Clean_;
    KEL.typ.nstr Input_Prefix_Clean_Pop_;
    KEL.typ.nstr Input_First_Name_Clean_Pop_;
    KEL.typ.nstr Input_Suffix_Clean_Pop_;
    KEL.typ.nstr Input_Primary_Range_Clean_Pop_;
    KEL.typ.nstr Input_Pre_Direction_Clean_Pop_;
    KEL.typ.nstr Input_Primary_Name_Clean_Pop_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Pop_;
    KEL.typ.nstr Input_Post_Direction_Clean_Pop_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Pop_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Pop_;
    KEL.typ.nstr Input_City_Clean_Pop_;
    KEL.typ.nstr Input_State_Clean_Pop_;
    KEL.typ.nstr Input_Zip5_Clean_Pop_;
    KEL.typ.nstr Input_Zip4_Clean_Pop_;
    KEL.typ.nstr Input_Latitude_Clean_Pop_;
    KEL.typ.nstr Input_Longitude_Clean_Pop_;
    KEL.typ.nstr Input_County_Clean_Pop_;
    KEL.typ.nstr Input_Geoblock_Clean_Pop_;
    KEL.typ.nstr Input_Address_Type_Clean_Pop_;
    KEL.typ.nstr Input_Address_Status_Clean_Pop_;
    KEL.typ.nstr Input_Email_Clean_Pop_;
    KEL.typ.nstr Input_Home_Phone_Clean_Pop_;
    KEL.typ.nstr Input_Work_Phone_Clean_Pop_;
    KEL.typ.nstr Input_Archive_Date_Clean_Pop_;
    KEL.typ.nint Rep_Number_;
    KEL.typ.bool Addr_Not_Populated_ := FALSE;
    KEL.typ.nstr Input_Account_Value_;
    KEL.typ.nstr Input_Address_Status_Clean_Pop_Value_;
    KEL.typ.nstr Input_Address_Status_Clean_Value_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Pop_Value_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Value_;
    KEL.typ.nstr Input_Address_Type_Clean_Pop_Value_;
    KEL.typ.nstr Input_Address_Type_Clean_Value_;
    KEL.typ.nstr Input_Archive_Date_Clean_Value_;
    KEL.typ.nstr Input_City_Clean_Pop_Value_;
    KEL.typ.nstr Input_City_Clean_Value_;
    KEL.typ.str Input_City_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_City_Value_;
    KEL.typ.nstr Input_County_Clean_Pop_Value_;
    KEL.typ.nstr Input_County_Clean_Value_;
    KEL.typ.str Input_D_L_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_D_L_Number_Clean_Pop_Value_;
    KEL.typ.nstr Input_D_L_Number_Clean_Value_;
    KEL.typ.nstr Input_D_L_State_Clean_Value_;
    KEL.typ.nstr Input_D_O_B_Clean_Pop_Value_;
    KEL.typ.str Input_D_O_B_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_Email_Clean_Pop_Value_;
    KEL.typ.nstr Input_Email_Clean_Value_;
    KEL.typ.str Input_Email_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_Email_Value_;
    KEL.typ.nstr Input_First_Name_Clean_Pop_Value_;
    KEL.typ.nstr Input_First_Name_Clean_Value_;
    KEL.typ.str Input_First_Name_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_First_Name_Value_;
    KEL.typ.nstr Input_Geoblock_Clean_Pop_Value_;
    KEL.typ.nstr Input_Geoblock_Clean_Value_;
    KEL.typ.nstr Input_Home_Phone_Clean_Pop_Value_;
    KEL.typ.nstr Input_Home_Phone_Clean_Value_;
    KEL.typ.str Input_Home_Phone_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_Home_Phone_Value_;
    KEL.typ.nstr Input_Last_Name_Clean_Pop_Value_;
    KEL.typ.nstr Input_Last_Name_Clean_Value_;
    KEL.typ.str Input_Last_Name_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_Latitude_Clean_Pop_Value_;
    KEL.typ.nstr Input_Latitude_Clean_Value_;
    KEL.typ.nint Input_Lex_I_D_Value_;
    KEL.typ.nstr Input_Longitude_Clean_Pop_Value_;
    KEL.typ.nstr Input_Longitude_Clean_Value_;
    KEL.typ.nstr Input_Middle_Name_Clean_Value_;
    KEL.typ.nstr Input_Post_Direction_Clean_Pop_Value_;
    KEL.typ.nstr Input_Post_Direction_Clean_Value_;
    KEL.typ.nstr Input_Pre_Direction_Clean_Pop_Value_;
    KEL.typ.nstr Input_Pre_Direction_Clean_Value_;
    KEL.typ.nstr Input_Prefix_Clean_Pop_Value_;
    KEL.typ.nstr Input_Prefix_Clean_Value_;
    KEL.typ.nstr Input_Primary_Name_Clean_Pop_Value_;
    KEL.typ.nstr Input_Primary_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Range_Clean_Pop_Value_;
    KEL.typ.nstr Input_Primary_Range_Clean_Value_;
    KEL.typ.nstr Input_S_S_N_Clean_Pop_Value_;
    KEL.typ.nstr Input_S_S_N_Clean_Value_;
    KEL.typ.str Input_S_S_N_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_Secondary_Range_Clean_Pop_Value_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Value_;
    KEL.typ.nstr Input_State_Clean_Pop_Value_;
    KEL.typ.nstr Input_State_Clean_Value_;
    KEL.typ.str Input_State_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_State_Value_;
    KEL.typ.str Input_Street_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_Street_Value_;
    KEL.typ.nstr Input_Suffix_Clean_Value_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Pop_Value_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Value_;
    KEL.typ.nstr Input_Work_Phone_Clean_Value_;
    KEL.typ.nstr Input_Zip4_Clean_Pop_Value_;
    KEL.typ.nstr Input_Zip4_Clean_Value_;
    KEL.typ.nstr Input_Zip5_Clean_Pop_Value_;
    KEL.typ.nstr Input_Zip5_Clean_Value_;
    KEL.typ.str Input_Zip_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_Zip_Value_;
    KEL.typ.bool Name_Not_Populated_ := FALSE;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST17418_Layout __ND51943__Project(B_Input_P_I_I_2(__in,__cfg).__ST18607_Layout __PP50860) := TRANSFORM
    __CC3026 := '-99';
    SELF.Input_Account_Value_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP50860.Input_Account_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC3026)));
    __CC3031 := '-98';
    SELF.Input_Address_Status_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Address_Status_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_Address_Suffix_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Address_Suffix_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_Address_Type_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Address_Type_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_Archive_Date_Clean_Value_ := FN_Compile.FN_Is_Blank2_Fields(__ECAST(KEL.typ.nstr,__PP50860.Input_Archive_Date_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__PP50860.Input_Archive_Date_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_City_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_City_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_City_Echo_Pop_Value_ := FN_Compile.FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_City_Echo_));
    SELF.Input_City_Value_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP50860.Input_City_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC3026)));
    SELF.Input_County_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_County_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_D_L_Echo_Pop_Value_ := FN_Compile.FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_D_L_Number_Echo_));
    SELF.Input_D_L_Number_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_D_L_Number_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_D_L_State_Clean_Value_ := FN_Compile.FN_Is_Blank2_Fields(__ECAST(KEL.typ.nstr,__PP50860.Input_D_L_State_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__PP50860.Input_D_L_State_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_D_O_B_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_D_O_B_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_D_O_B_Echo_Pop_Value_ := FN_Compile.FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_D_O_B_Echo_));
    SELF.Input_Email_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Email_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_Email_Echo_Pop_Value_ := FN_Compile.FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Email_Echo_));
    SELF.Input_Email_Value_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP50860.Input_Email_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC3026)));
    SELF.Input_First_Name_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_First_Name_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_First_Name_Echo_Pop_Value_ := FN_Compile.FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_First_Name_Echo_));
    SELF.Input_First_Name_Value_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP50860.Input_First_Name_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC3026)));
    SELF.Input_Geoblock_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Geoblock_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_Home_Phone_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Home_Phone_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_Home_Phone_Echo_Pop_Value_ := FN_Compile.FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Home_Phone_Echo_));
    SELF.Input_Home_Phone_Value_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP50860.Input_Home_Phone_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC3026)));
    SELF.Input_Last_Name_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Last_Name_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_Last_Name_Echo_Pop_Value_ := FN_Compile.FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Last_Name_Echo_));
    SELF.Input_Latitude_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Latitude_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    __CC3029 := -99;
    SELF.Input_Lex_I_D_Value_ := FN_Compile.FN_Is_Zero(__ECAST(KEL.typ.nint,__PP50860.Input_Lex_I_D_Echo_),__ECAST(KEL.typ.nint,__CN(__CC3029)));
    SELF.Input_Longitude_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Longitude_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_Middle_Name_Clean_Value_ := IF(__PP50860.Name_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP50860.Input_Middle_Name_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3031)))));
    SELF.Input_Post_Direction_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Post_Direction_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_Pre_Direction_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Pre_Direction_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_Prefix_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Prefix_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_Primary_Name_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Primary_Name_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_Primary_Range_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Primary_Range_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_S_S_N_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_S_S_N_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_S_S_N_Echo_Pop_Value_ := FN_Compile.FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_S_S_N_Echo_));
    SELF.Input_Secondary_Range_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Secondary_Range_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_State_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_State_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_State_Echo_Pop_Value_ := FN_Compile.FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_State_Echo_));
    SELF.Input_State_Value_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP50860.Input_State_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC3026)));
    SELF.Input_Street_Echo_Pop_Value_ := FN_Compile.FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Street_Echo_));
    SELF.Input_Street_Value_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP50860.Input_Street_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC3026)));
    SELF.Input_Suffix_Clean_Value_ := IF(__PP50860.Name_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP50860.Input_Suffix_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3031)))));
    SELF.Input_Unit_Desig_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Unit_Desig_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_Work_Phone_Clean_Value_ := FN_Compile.FN_Is_Blank2_Fields(__ECAST(KEL.typ.nstr,__PP50860.Input_Work_Phone_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__PP50860.Input_Work_Phone_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_Zip4_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Zip4_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_Zip5_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Zip5_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3026)),__ECAST(KEL.typ.nstr,__CN(__CC3031)));
    SELF.Input_Zip_Echo_Pop_Value_ := FN_Compile.FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP50860.Input_Zip_Echo_));
    SELF.Input_Zip_Value_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP50860.Input_Zip_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC3026)));
    SELF := __PP50860;
  END;
  EXPORT __ENH_Input_P_I_I_1 := PROJECT(__EE51770,__ND51943__Project(LEFT));
END;
