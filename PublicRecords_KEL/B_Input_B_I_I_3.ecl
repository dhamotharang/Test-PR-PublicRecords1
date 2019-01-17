﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Input_B_I_I_4,CFG_Compile,E_Business,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Input_B_I_I_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_B_I_I_4(__in,__cfg).__ENH_Input_B_I_I_4) __ENH_Input_B_I_I_4 := B_Input_B_I_I_4(__in,__cfg).__ENH_Input_B_I_I_4;
  SHARED __EE28889 := __ENH_Input_B_I_I_4;
  EXPORT __ST22384_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Business().Typ) Company_;
    KEL.typ.nint Bus_Input_U_I_D_Append_;
    KEL.typ.nint Input_Lex_I_D_Bus_Extended_Family_Echo_;
    KEL.typ.nint Input_Lex_I_D_Bus_Legal_Family_Echo_;
    KEL.typ.nint Input_Lex_I_D_Bus_Legal_Entity_Echo_;
    KEL.typ.nint Input_Lex_I_D_Bus_Place_Group_Echo_;
    KEL.typ.nint Input_Lex_I_D_Bus_Place_Echo_;
    KEL.typ.nstr Bus_Input_Name_Echo_;
    KEL.typ.nstr Bus_Input_Alternate_Name_Echo_;
    KEL.typ.nstr Bus_Input_Street_Echo_;
    KEL.typ.nstr Bus_Input_City_Echo_;
    KEL.typ.nstr Bus_Input_State_Echo_;
    KEL.typ.nstr Bus_Input_Zip_Echo_;
    KEL.typ.nstr Bus_Input_Phone_Echo_;
    KEL.typ.nstr Business_T_I_N_;
    KEL.typ.nstr Bus_Input_I_P_Address_Echo_;
    KEL.typ.nstr Bus_Input_U_R_L_Echo_;
    KEL.typ.nstr Bus_Input_Email_Echo_;
    KEL.typ.nstr Bus_Input_S_I_C_Code_Echo_;
    KEL.typ.nstr Bus_Input_N_A_I_C_S_Code_Echo_;
    KEL.typ.nstr Bus_Input_T_I_N_Echo_;
    KEL.typ.nstr Bus_Input_Archive_Date_Echo_;
    KEL.typ.nstr Bus_Input_Name_Clean_;
    KEL.typ.nstr Bus_Input_Alternate_Name_Clean_;
    KEL.typ.nstr Bus_Input_Prim_Range_Clean_;
    KEL.typ.nstr Bus_Input_Pre_Dir_Clean_;
    KEL.typ.nstr Bus_Input_Prim_Name_Clean_;
    KEL.typ.nstr Bus_Input_Addr_Suffix_Clean_;
    KEL.typ.nstr Bus_Input_Post_Dir_Clean_;
    KEL.typ.nstr Bus_Input_Unit_Desig_Clean_;
    KEL.typ.nstr Bus_Input_Sec_Range_Clean_;
    KEL.typ.nstr Bus_Input_City_Clean_;
    KEL.typ.nstr Bus_Input_State_Clean_;
    KEL.typ.nstr Bus_Input_Zip5_Clean_;
    KEL.typ.nstr Bus_Input_Zip4_Clean_;
    KEL.typ.nstr Bus_Input_Latitude_Clean_;
    KEL.typ.nstr Bus_Input_Longitude_Clean_;
    KEL.typ.nstr Bus_Input_County_Clean_;
    KEL.typ.nstr Bus_Input_Geoblock_Clean_;
    KEL.typ.nstr Bus_Input_Addr_Type_Clean_;
    KEL.typ.nstr Bus_Input_Addr_Status_Clean_;
    KEL.typ.nstr Bus_Input_Phone_Clean_;
    KEL.typ.nstr Bus_Input_Email_Clean_;
    KEL.typ.nstr Bus_Input_T_I_N_Clean_;
    KEL.typ.nstr Bus_Input_Archive_Date_Clean_;
    KEL.typ.nstr Archive_Date_;
    KEL.typ.bool Addr_Not_Populated_ := FALSE;
    KEL.typ.nstr Bus_Input_Addr_Suffix_Clean_Value_;
    KEL.typ.nstr Bus_Input_Post_Dir_Clean_Value_;
    KEL.typ.nstr Bus_Input_Pre_Dir_Clean_Value_;
    KEL.typ.nstr Bus_Input_Prim_Name_Clean_Value_;
    KEL.typ.nstr Bus_Input_Prim_Range_Clean_Value_;
    KEL.typ.nstr Bus_Input_Sec_Range_Clean_Value_;
    KEL.typ.nstr Bus_Input_Unit_Desig_Clean_Value_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST22384_Layout __ND28951__Project(B_Input_B_I_I_4(__in,__cfg).__ST23020_Layout __PP28578) := TRANSFORM
    __CC3002 := '-99';
    __CC3007 := '-98';
    SELF.Bus_Input_Addr_Suffix_Clean_Value_ := IF(__PP28578.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3002)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP28578.Bus_Input_Addr_Suffix_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3007)))));
    SELF.Bus_Input_Post_Dir_Clean_Value_ := IF(__PP28578.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3002)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP28578.Bus_Input_Post_Dir_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3007)))));
    SELF.Bus_Input_Pre_Dir_Clean_Value_ := IF(__PP28578.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3002)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP28578.Bus_Input_Pre_Dir_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3007)))));
    SELF.Bus_Input_Prim_Name_Clean_Value_ := IF(__PP28578.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3002)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP28578.Bus_Input_Prim_Name_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3007)))));
    SELF.Bus_Input_Prim_Range_Clean_Value_ := IF(__PP28578.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3002)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP28578.Bus_Input_Prim_Range_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3007)))));
    SELF.Bus_Input_Sec_Range_Clean_Value_ := IF(__PP28578.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3002)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP28578.Bus_Input_Sec_Range_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3007)))));
    SELF.Bus_Input_Unit_Desig_Clean_Value_ := IF(__PP28578.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3002)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP28578.Bus_Input_Unit_Desig_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3007)))));
    SELF := __PP28578;
  END;
  EXPORT __ENH_Input_B_I_I_3 := PROJECT(__EE28889,__ND28951__Project(LEFT));
END;
