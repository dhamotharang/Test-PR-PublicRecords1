﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Input_B_I_I_2,B_Input_P_I_I_2,CFG_Compile,E_Business,E_Input_B_I_I,E_Input_B_I_I_Input_P_I_I,E_Input_P_I_I,E_Person,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT B_Input_B_I_I_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_B_I_I_2(__in,__cfg).__ENH_Input_B_I_I_2) __ENH_Input_B_I_I_2 := B_Input_B_I_I_2(__in,__cfg).__ENH_Input_B_I_I_2;
  SHARED VIRTUAL TYPEOF(E_Input_B_I_I_Input_P_I_I(__in,__cfg).__Result) __E_Input_B_I_I_Input_P_I_I := E_Input_B_I_I_Input_P_I_I(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_2(__in,__cfg).__ENH_Input_P_I_I_2) __ENH_Input_P_I_I_2 := B_Input_P_I_I_2(__in,__cfg).__ENH_Input_P_I_I_2;
  SHARED __EE50652 := __ENH_Input_B_I_I_2;
  SHARED __EE51224 := __ENH_Input_P_I_I_2;
  SHARED __EE51222 := __E_Input_B_I_I_Input_P_I_I;
  SHARED __EE56618 := __EE51222(__NN(__EE51222.B_I_I_) AND __NN(__EE51222.P_I_I_));
  SHARED __ST54246_Layout := RECORD
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
    KEL.typ.nstr Input_D_L_State_Clean_Value_;
    KEL.typ.nstr Input_D_O_B_Clean_Value_;
    KEL.typ.nstr Input_Email_Clean_Value_;
    KEL.typ.nstr Input_First_Name_Clean_Value_;
    KEL.typ.nstr Input_Full_Address_Clean_Value_;
    KEL.typ.nstr Input_Geoblock_Clean_Value_;
    KEL.typ.nstr Input_Home_Phone_Clean_Value_;
    KEL.typ.nstr Input_Last_Name_Clean_Value_;
    KEL.typ.nstr Input_Latitude_Clean_Value_;
    KEL.typ.nstr Input_Longitude_Clean_Value_;
    KEL.typ.nstr Input_Middle_Name_Clean_Value_;
    KEL.typ.nstr Input_Post_Direction_Clean_Value_;
    KEL.typ.nstr Input_Pre_Direction_Clean_Value_;
    KEL.typ.nstr Input_Prefix_Clean_Value_;
    KEL.typ.nstr Input_Primary_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Range_Clean_Value_;
    KEL.typ.nstr Input_S_S_N_Clean_Value_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Value_;
    KEL.typ.nstr Input_State_Clean_Value_;
    KEL.typ.nstr Input_Street_Clean_Value_;
    KEL.typ.nstr Input_Suffix_Clean_Value_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Value_;
    KEL.typ.nstr Input_Zip4_Clean_Value_;
    KEL.typ.nstr Input_Zip5_Clean_Value_;
    KEL.typ.bool Name_Not_Populated_ := FALSE;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) B_I_I_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC56636(B_Input_P_I_I_2(__in,__cfg).__ST24692_Layout __EE51224, E_Input_B_I_I_Input_P_I_I(__in,__cfg).Layout __EE56618) := __EEQP(__EE56618.P_I_I_,__EE51224.UID);
  __ST54246_Layout __JT56636(B_Input_P_I_I_2(__in,__cfg).__ST24692_Layout __l, E_Input_B_I_I_Input_P_I_I(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE56637 := JOIN(__EE56618,__EE51224,__JC56636(RIGHT,LEFT),__JT56636(RIGHT,LEFT),INNER,MANY LOOKUP);
  SHARED __ST53385_Layout := RECORD
    KEL.typ.ntyp(E_Input_B_I_I().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) B_I_I_;
    KEL.typ.nuid U_I_D__1_;
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
    KEL.typ.nstr Input_D_L_State_Clean_Value_;
    KEL.typ.nstr Input_D_O_B_Clean_Value_;
    KEL.typ.nstr Input_Email_Clean_Value_;
    KEL.typ.nstr Input_First_Name_Clean_Value_;
    KEL.typ.nstr Input_Full_Address_Clean_Value_;
    KEL.typ.nstr Input_Geoblock_Clean_Value_;
    KEL.typ.nstr Input_Home_Phone_Clean_Value_;
    KEL.typ.nstr Input_Last_Name_Clean_Value_;
    KEL.typ.nstr Input_Latitude_Clean_Value_;
    KEL.typ.nstr Input_Longitude_Clean_Value_;
    KEL.typ.nstr Input_Middle_Name_Clean_Value_;
    KEL.typ.nstr Input_Post_Direction_Clean_Value_;
    KEL.typ.nstr Input_Pre_Direction_Clean_Value_;
    KEL.typ.nstr Input_Prefix_Clean_Value_;
    KEL.typ.nstr Input_Primary_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Range_Clean_Value_;
    KEL.typ.nstr Input_S_S_N_Clean_Value_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Value_;
    KEL.typ.nstr Input_State_Clean_Value_;
    KEL.typ.nstr Input_Street_Clean_Value_;
    KEL.typ.nstr Input_Suffix_Clean_Value_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Value_;
    KEL.typ.nstr Input_Zip4_Clean_Value_;
    KEL.typ.nstr Input_Zip5_Clean_Value_;
    KEL.typ.bool Name_Not_Populated_ := FALSE;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST53385_Layout __ND56735__Project(__ST54246_Layout __PP56638) := TRANSFORM
    SELF.UID := __PP56638.B_I_I_;
    SELF.U_I_D__1_ := __PP56638.UID;
    SELF := __PP56638;
  END;
  SHARED __EE57108 := PROJECT(__EE56637,__ND56735__Project(LEFT));
  SHARED __ST53610_Layout := RECORD
    KEL.typ.ntyp(E_Input_B_I_I().Typ) UID;
    KEL.typ.nuid Exp1_;
    KEL.typ.nuid Exp2_;
    KEL.typ.nuid Exp3_;
    KEL.typ.nuid Exp4_;
    KEL.typ.nuid Exp5_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __ST53610_Layout __ND57742__Project(__ST53385_Layout __PP57109) := TRANSFORM
    SELF.Exp1_ := IF(__T(__OP2(__PP57109.Rep_Number_,=,__CN(1))),__ECAST(KEL.typ.nuid,__PP57109.U_I_D__1_),__ECAST(KEL.typ.nuid,__N(KEL.typ.uid)));
    SELF.Exp2_ := IF(__T(__OP2(__PP57109.Rep_Number_,=,__CN(2))),__ECAST(KEL.typ.nuid,__PP57109.U_I_D__1_),__ECAST(KEL.typ.nuid,__N(KEL.typ.uid)));
    SELF.Exp3_ := IF(__T(__OP2(__PP57109.Rep_Number_,=,__CN(3))),__ECAST(KEL.typ.nuid,__PP57109.U_I_D__1_),__ECAST(KEL.typ.nuid,__N(KEL.typ.uid)));
    SELF.Exp4_ := IF(__T(__OP2(__PP57109.Rep_Number_,=,__CN(4))),__ECAST(KEL.typ.nuid,__PP57109.U_I_D__1_),__ECAST(KEL.typ.nuid,__N(KEL.typ.uid)));
    SELF.Exp5_ := IF(__T(__OP2(__PP57109.Rep_Number_,=,__CN(5))),__ECAST(KEL.typ.nuid,__PP57109.U_I_D__1_),__ECAST(KEL.typ.nuid,__N(KEL.typ.uid)));
    SELF := __PP57109;
  END;
  SHARED __EE57762 := PROJECT(__EE57108,__ND57742__Project(LEFT));
  SHARED __ST53645_Layout := RECORD
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D__2_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D__3_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D__4_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) UID;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
  END;
  SHARED __EE57798 := PROJECT(__CLEANANDDO(__EE57762,TABLE(__EE57762,{KEL.Aggregates.MaxNG(__EE57762.Exp1_) O_N_L_Y___U_I_D_,KEL.Aggregates.MaxNG(__EE57762.Exp2_) O_N_L_Y___U_I_D__1_,KEL.Aggregates.MaxNG(__EE57762.Exp3_) O_N_L_Y___U_I_D__2_,KEL.Aggregates.MaxNG(__EE57762.Exp4_) O_N_L_Y___U_I_D__3_,KEL.Aggregates.MaxNG(__EE57762.Exp5_) O_N_L_Y___U_I_D__4_,UID},UID,MERGE)),__ST53645_Layout);
  SHARED __ST54728_Layout := RECORD
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
    KEL.typ.nstr Bus_Input_City_Clean_Value_;
    KEL.typ.nstr Bus_Input_Post_Dir_Clean_Value_;
    KEL.typ.nstr Bus_Input_Pre_Dir_Clean_Value_;
    KEL.typ.nstr Bus_Input_Prim_Name_Clean_Value_;
    KEL.typ.nstr Bus_Input_Prim_Range_Clean_Value_;
    KEL.typ.nstr Bus_Input_Sec_Range_Clean_Value_;
    KEL.typ.nstr Bus_Input_State_Clean_Value_;
    KEL.typ.nstr Bus_Input_Street_Clean_Value_;
    KEL.typ.nstr Bus_Input_Unit_Desig_Clean_Value_;
    KEL.typ.nstr Bus_Input_Zip4_Clean_Value_;
    KEL.typ.nstr Bus_Input_Zip5_Clean_Value_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D__2_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D__3_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D__4_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) U_I_D__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC57804(B_Input_B_I_I_2(__in,__cfg).__ST24140_Layout __EE50652, __ST53645_Layout __EE57798) := __EEQP(__EE50652.UID,__EE57798.UID);
  __ST54728_Layout __JT57804(B_Input_B_I_I_2(__in,__cfg).__ST24140_Layout __l, __ST53645_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE57874 := JOIN(__EE50652,__EE57798,__JC57804(LEFT,RIGHT),__JT57804(LEFT,RIGHT),LEFT OUTER,MANY LOOKUP);
  EXPORT __ST22093_Layout := RECORD
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
    KEL.typ.ntyp(E_Input_P_I_I().Typ) Auth_Rep1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) Auth_Rep2_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) Auth_Rep3_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) Auth_Rep4_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) Auth_Rep5_;
    KEL.typ.nstr Bus_Input_Addr_Status_Clean_Value_;
    KEL.typ.nstr Bus_Input_Addr_Suffix_Clean_Value_;
    KEL.typ.nstr Bus_Input_Addr_Type_Clean_Value_;
    KEL.typ.nstr Bus_Input_Alternate_Name_Clean_Value_;
    KEL.typ.nstr Bus_Input_City_Clean_Value_;
    KEL.typ.nstr Bus_Input_County_Clean_Value_;
    KEL.typ.nstr Bus_Input_Email_Clean_Value_;
    KEL.typ.nstr Bus_Input_Full_Address_Clean_Value_;
    KEL.typ.nstr Bus_Input_Geoblock_Clean_Value_;
    KEL.typ.nstr Bus_Input_Latitude_Clean_Value_;
    KEL.typ.nstr Bus_Input_Longitude_Clean_Value_;
    KEL.typ.nstr Bus_Input_Name_Clean_Value_;
    KEL.typ.nstr Bus_Input_Phone_Clean_Value_;
    KEL.typ.nstr Bus_Input_Post_Dir_Clean_Value_;
    KEL.typ.nstr Bus_Input_Pre_Dir_Clean_Value_;
    KEL.typ.nstr Bus_Input_Prim_Name_Clean_Value_;
    KEL.typ.nstr Bus_Input_Prim_Range_Clean_Value_;
    KEL.typ.nstr Bus_Input_Sec_Range_Clean_Value_;
    KEL.typ.nstr Bus_Input_State_Clean_Value_;
    KEL.typ.nstr Bus_Input_Street_Clean_Value_;
    KEL.typ.nstr Bus_Input_T_I_N_Clean_Value_;
    KEL.typ.nstr Bus_Input_Unit_Desig_Clean_Value_;
    KEL.typ.nstr Bus_Input_Zip4_Clean_Value_;
    KEL.typ.nstr Bus_Input_Zip5_Clean_Value_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST22093_Layout __ND57879__Project(__ST54728_Layout __PP57875) := TRANSFORM
    SELF.Auth_Rep1_ := __PP57875.O_N_L_Y___U_I_D_;
    SELF.Auth_Rep2_ := __PP57875.O_N_L_Y___U_I_D__1_;
    SELF.Auth_Rep3_ := __PP57875.O_N_L_Y___U_I_D__2_;
    SELF.Auth_Rep4_ := __PP57875.O_N_L_Y___U_I_D__3_;
    SELF.Auth_Rep5_ := __PP57875.O_N_L_Y___U_I_D__4_;
    __CC3201 := '-99999';
    __CC3206 := '-99998';
    SELF.Bus_Input_Addr_Status_Clean_Value_ := IF(__PP57875.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3201)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP57875.Bus_Input_Addr_Status_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3206)))));
    SELF.Bus_Input_Addr_Type_Clean_Value_ := IF(__PP57875.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3201)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP57875.Bus_Input_Addr_Type_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3206)))));
    SELF.Bus_Input_Alternate_Name_Clean_Value_ := FN_Compile.FN_Is_Blank2_Fields(__ECAST(KEL.typ.nstr,__PP57875.Bus_Input_Alternate_Name_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC3201)),__ECAST(KEL.typ.nstr,__PP57875.Bus_Input_Alternate_Name_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3206)));
    SELF.Bus_Input_County_Clean_Value_ := IF(__PP57875.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3201)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP57875.Bus_Input_County_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3206)))));
    SELF.Bus_Input_Email_Clean_Value_ := FN_Compile.FN_Is_Blank2_Fields(__ECAST(KEL.typ.nstr,__PP57875.Bus_Input_Email_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC3201)),__ECAST(KEL.typ.nstr,__PP57875.Bus_Input_Email_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3206)));
    SELF.Bus_Input_Full_Address_Clean_Value_ := MAP(__T(__OR(__AND(__AND(__OP2(__PP57875.Bus_Input_Street_Clean_Value_,=,__CN(__CC3201)),__OP2(__PP57875.Bus_Input_City_Clean_Value_,=,__CN(__CC3201))),__OP2(__PP57875.Bus_Input_State_Clean_Value_,=,__CN(__CC3201))),__AND(__OP2(__PP57875.Bus_Input_Street_Clean_Value_,=,__CN(__CC3201)),__OP2(__PP57875.Bus_Input_Zip5_Clean_Value_,=,__CN(__CC3201)))))=>__ECAST(KEL.typ.nstr,__CN(__CC3201)),__ECAST(KEL.typ.nstr,__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(__OP2(IF(__T(__OP2(__PP57875.Bus_Input_Prim_Range_Clean_Value_,=,__CN(__CC3206))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP57875.Bus_Input_Prim_Range_Clean_),+,__CN(' ')))),+,IF(__T(__OP2(__PP57875.Bus_Input_Pre_Dir_Clean_Value_,=,__CN(__CC3206))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP57875.Bus_Input_Pre_Dir_Clean_),+,__CN(' '))))),+,IF(__T(__OP2(__PP57875.Bus_Input_Prim_Name_Clean_Value_,=,__CN(__CC3206))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP57875.Bus_Input_Prim_Name_Clean_),+,__CN(' '))))),+,IF(__T(__OP2(__PP57875.Bus_Input_Addr_Suffix_Clean_Value_,=,__CN(__CC3206))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP57875.Bus_Input_Addr_Suffix_Clean_),+,__CN(' '))))),+,IF(__T(__OP2(__PP57875.Bus_Input_Post_Dir_Clean_Value_,=,__CN(__CC3206))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP57875.Bus_Input_Post_Dir_Clean_),+,__CN(' '))))),+,IF(__T(__OP2(__PP57875.Bus_Input_Unit_Desig_Clean_Value_,=,__CN(__CC3206))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP57875.Bus_Input_Unit_Desig_Clean_),+,__CN(' '))))),+,IF(__T(__OP2(__PP57875.Bus_Input_Sec_Range_Clean_Value_,=,__CN(__CC3206))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP57875.Bus_Input_Sec_Range_Clean_),+,__CN(' '))))),+,IF(__T(__OP2(__PP57875.Bus_Input_City_Clean_Value_,=,__CN(__CC3206))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP57875.Bus_Input_City_Clean_),+,__CN(' '))))),+,IF(__T(__OP2(__PP57875.Bus_Input_State_Clean_Value_,=,__CN(__CC3206))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP57875.Bus_Input_State_Clean_),+,__CN(' '))))),+,IF(__T(__OP2(__PP57875.Bus_Input_Zip5_Clean_Value_,=,__CN(__CC3206))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__FN1(TRIM,__PP57875.Bus_Input_Zip5_Clean_),+,__CN(' '))))),+,IF(__T(__OP2(__PP57875.Bus_Input_Zip4_Clean_Value_,=,__CN(__CC3206))),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__FN1(TRIM,__PP57875.Bus_Input_Zip4_Clean_))))));
    SELF.Bus_Input_Geoblock_Clean_Value_ := IF(__PP57875.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3201)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP57875.Bus_Input_Geoblock_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3206)))));
    SELF.Bus_Input_Latitude_Clean_Value_ := IF(__PP57875.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3201)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP57875.Bus_Input_Latitude_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3206)))));
    SELF.Bus_Input_Longitude_Clean_Value_ := IF(__PP57875.Addr_Not_Populated_,__ECAST(KEL.typ.nstr,__CN(__CC3201)),__ECAST(KEL.typ.nstr,FN_Compile.FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP57875.Bus_Input_Longitude_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3206)))));
    SELF.Bus_Input_Name_Clean_Value_ := FN_Compile.FN_Is_Blank2_Fields(__ECAST(KEL.typ.nstr,__PP57875.Bus_Input_Name_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC3201)),__ECAST(KEL.typ.nstr,__PP57875.Bus_Input_Name_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3206)));
    SELF.Bus_Input_Phone_Clean_Value_ := FN_Compile.FN_Is_Blank2_Fields(__ECAST(KEL.typ.nstr,__PP57875.Bus_Input_Phone_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC3201)),__ECAST(KEL.typ.nstr,__PP57875.Bus_Input_Phone_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3206)));
    SELF.Bus_Input_T_I_N_Clean_Value_ := FN_Compile.FN_Is_Blank2_Fields(__ECAST(KEL.typ.nstr,__PP57875.Bus_Input_T_I_N_Echo_),__ECAST(KEL.typ.nstr,__CN(__CC3201)),__ECAST(KEL.typ.nstr,__PP57875.Bus_Input_T_I_N_Clean_),__ECAST(KEL.typ.nstr,__CN(__CC3206)));
    SELF := __PP57875;
  END;
  EXPORT __ENH_Input_B_I_I_1 := PROJECT(__EE57874,__ND57879__Project(LEFT));
END;
