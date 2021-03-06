//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Input_P_I_I_1,CFG_Compile,E_Person,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Input_P_I_I(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_1(__in,__cfg).__ENH_Input_P_I_I_1) __ENH_Input_P_I_I_1 := B_Input_P_I_I_1(__in,__cfg).__ENH_Input_P_I_I_1;
  SHARED __EE280964 := __ENH_Input_P_I_I_1;
  EXPORT __ST24626_Layout := RECORD
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
    KEL.typ.nint I_Rep_Number_Value_;
    KEL.typ.str Input_Account_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_Account_Value_;
    KEL.typ.nstr Input_Address_Status_Clean_Pop_Value_;
    KEL.typ.nstr Input_Address_Status_Clean_Value_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Pop_Value_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Value_;
    KEL.typ.nstr Input_Address_Type_Clean_Pop_Value_;
    KEL.typ.nstr Input_Address_Type_Clean_Value_;
    KEL.typ.str Input_Archive_Date_Clean_Pop_Value_ := '';
    KEL.typ.str Input_Archive_Date_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_Archive_Date_Value_;
    KEL.typ.nstr Input_City_Clean_Pop_Value_;
    KEL.typ.nstr Input_City_Clean_Value_;
    KEL.typ.str Input_City_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_City_Value_;
    KEL.typ.nstr Input_County_Clean_Pop_Value_;
    KEL.typ.nstr Input_County_Clean_Value_;
    KEL.typ.nstr Input_D_L_Clean_Pop_Value_;
    KEL.typ.nstr Input_D_L_Clean_Value_;
    KEL.typ.str Input_D_L_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_D_L_State_Clean_Pop_Value_;
    KEL.typ.nstr Input_D_L_State_Clean_Value_;
    KEL.typ.str Input_D_L_State_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_D_L_State_Value_;
    KEL.typ.nstr Input_D_L_Value_;
    KEL.typ.nstr Input_D_O_B_Clean_Pop_Value_;
    KEL.typ.nstr Input_D_O_B_Clean_Value_;
    KEL.typ.str Input_D_O_B_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_D_O_B_Value_;
    KEL.typ.nstr Input_Email_Clean_Pop_Value_;
    KEL.typ.nstr Input_Email_Clean_Value_;
    KEL.typ.str Input_Email_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_Email_Value_;
    KEL.typ.nstr Input_First_Name_Clean_Pop_Value_;
    KEL.typ.nstr Input_First_Name_Clean_Value_;
    KEL.typ.str Input_First_Name_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_First_Name_Value_;
    KEL.typ.nstr Input_Full_Address_Clean_Pop_Value_;
    KEL.typ.nstr Input_Full_Address_Clean_Value_;
    KEL.typ.nstr Input_Geoblock_Clean_Pop_Value_;
    KEL.typ.nstr Input_Geoblock_Clean_Value_;
    KEL.typ.nstr Input_Home_Phone_Clean_Pop_Value_;
    KEL.typ.nstr Input_Home_Phone_Clean_Value_;
    KEL.typ.str Input_Home_Phone_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_Home_Phone_Value_;
    KEL.typ.nstr Input_Last_Name_Clean_Pop_Value_;
    KEL.typ.nstr Input_Last_Name_Clean_Value_;
    KEL.typ.str Input_Last_Name_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_Last_Name_Value_;
    KEL.typ.nstr Input_Latitude_Clean_Pop_Value_;
    KEL.typ.nstr Input_Latitude_Clean_Value_;
    KEL.typ.str Input_Lex_I_D_Echo_Pop_Value_ := '';
    KEL.typ.nint Input_Lex_I_D_Value_;
    KEL.typ.nstr Input_Longitude_Clean_Pop_Value_;
    KEL.typ.nstr Input_Longitude_Clean_Value_;
    KEL.typ.nstr Input_Middle_Name_Clean_Pop_Value_;
    KEL.typ.nstr Input_Middle_Name_Clean_Value_;
    KEL.typ.str Input_Middle_Name_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_Middle_Name_Value_;
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
    KEL.typ.nstr Input_S_S_N_Value_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Pop_Value_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Value_;
    KEL.typ.nstr Input_State_Clean_Pop_Value_;
    KEL.typ.nstr Input_State_Clean_Value_;
    KEL.typ.str Input_State_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_State_Value_;
    KEL.typ.nstr Input_Street_Clean_Pop_Value_;
    KEL.typ.nstr Input_Street_Clean_Value_;
    KEL.typ.str Input_Street_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_Street_Value_;
    KEL.typ.nstr Input_Suffix_Clean_Pop_Value_;
    KEL.typ.nstr Input_Suffix_Clean_Value_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Pop_Value_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Value_;
    KEL.typ.nstr Input_Work_Phone_Clean_Pop_Value_;
    KEL.typ.nstr Input_Work_Phone_Clean_Value_;
    KEL.typ.str Input_Work_Phone_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_Work_Phone_Value_;
    KEL.typ.nstr Input_Zip4_Clean_Pop_Value_;
    KEL.typ.nstr Input_Zip4_Clean_Value_;
    KEL.typ.nstr Input_Zip5_Clean_Pop_Value_;
    KEL.typ.nstr Input_Zip5_Clean_Value_;
    KEL.typ.str Input_Zip_Echo_Pop_Value_ := '';
    KEL.typ.nstr Input_Zip_Value_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST24626_Layout __ND281125__Project(B_Input_P_I_I_1(__in,__cfg).__ST29325_Layout __PP280169) := TRANSFORM
    SELF.I_Rep_Number_Value_ := __PP280169.Rep_Number_;
    SELF.Input_Account_Echo_Pop_Value_ := FN_Compile.FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP280169.Input_Account_Echo_));
    SELF.Input_Archive_Date_Clean_Pop_Value_ := FN_Compile.FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP280169.Input_Archive_Date_Clean_));
    SELF.Input_Archive_Date_Echo_Pop_Value_ := FN_Compile.FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP280169.Input_Archive_Date_Echo_));
    __CC3263 := '-99999';
    SELF.Input_Archive_Date_Value_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP280169.Input_Archive_Date_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC3263)));
    __CC3268 := '-99998';
    SELF.Input_Work_Phone_Clean_Pop_Value_ := FN_Compile.FN_Is_Clean_Populated(__ECAST(KEL.typ.nstr,__PP280169.Input_Work_Phone_Clean_Value_),__ECAST(KEL.typ.nstr,__CN(__CC3263)),__ECAST(KEL.typ.nstr,__CN(__CC3268)));
    SELF.Input_Work_Phone_Echo_Pop_Value_ := FN_Compile.FN_Is_Echo_Populated(__ECAST(KEL.typ.nstr,__PP280169.Input_Work_Phone_Echo_));
    SELF.Input_Work_Phone_Value_ := FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP280169.Input_Work_Phone_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC3263)));
    SELF := __PP280169;
  END;
  EXPORT __ENH_Input_P_I_I := PROJECT(__EE280964,__ND281125__Project(LEFT));
END;
