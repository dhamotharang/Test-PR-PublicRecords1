﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT CFG_Compile,E_Input_P_I_I,E_Person,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Input_P_I_I_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Input_P_I_I(__in,__cfg).__Result) __E_Input_P_I_I := E_Input_P_I_I(__in,__cfg).__Result;
  SHARED __EE23384 := __E_Input_P_I_I;
  EXPORT __ST19132_Layout := RECORD
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
    KEL.typ.bool Name_Not_Populated_ := FALSE;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST19132_Layout __ND23382__Project(E_Input_P_I_I(__in,__cfg).Layout __PP22892) := TRANSFORM
    SELF.Addr_Not_Populated_ := IF(FN_Compile.FN_Addr_Not_Populated_Check(__ECAST(KEL.typ.nstr,__PP22892.Input_Street_Echo_),__ECAST(KEL.typ.nstr,__PP22892.Input_City_Echo_),__ECAST(KEL.typ.nstr,__PP22892.Input_State_Echo_),__ECAST(KEL.typ.nstr,__PP22892.Input_Zip_Echo_)),TRUE,FALSE);
    SELF.Name_Not_Populated_ := IF(FN_Compile.FN_Name_Not_Populated_Check(__ECAST(KEL.typ.nstr,__PP22892.Input_First_Name_Echo_),__ECAST(KEL.typ.nstr,__PP22892.Input_Middle_Name_Echo_),__ECAST(KEL.typ.nstr,__PP22892.Input_Last_Name_Echo_)),TRUE,FALSE);
    SELF := __PP22892;
  END;
  EXPORT __ENH_Input_P_I_I_3 := PROJECT(__EE23384,__ND23382__Project(LEFT));
END;
