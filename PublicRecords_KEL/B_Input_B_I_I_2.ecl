﻿//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_Input_B_I_I_3,B_Input_P_I_I_3,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Geo_Link,E_Input_B_I_I,E_Input_B_I_I_Input_P_I_I,E_Input_P_I_I,E_Person,E_Surname,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Input_B_I_I_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_B_I_I_3().__ENH_Input_B_I_I_3) __ENH_Input_B_I_I_3 := B_Input_B_I_I_3(__in,__cfg).__ENH_Input_B_I_I_3;
  SHARED VIRTUAL TYPEOF(E_Input_B_I_I_Input_P_I_I().__Result) __E_Input_B_I_I_Input_P_I_I := E_Input_B_I_I_Input_P_I_I(__in,__cfg).__Result;
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_3().__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3(__in,__cfg).__ENH_Input_P_I_I_3;
  SHARED __EE1751355 := __ENH_Input_B_I_I_3;
  SHARED __EE1752002 := __ENH_Input_P_I_I_3;
  SHARED __EE1752000 := __E_Input_B_I_I_Input_P_I_I;
  SHARED __EE1757929 := __EE1752000(__NN(__EE1752000.B_I_I_) AND __NN(__EE1752000.P_I_I_));
  SHARED __ST1755392_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr P___Inp_Acct_;
    KEL.typ.nint P___Inp_Lex_I_D_;
    KEL.typ.nstr P___Inp_Name_First_;
    KEL.typ.nstr P___Inp_Name_Mid_;
    KEL.typ.nstr P___Inp_Name_Last_;
    KEL.typ.ntyp(E_Surname().Typ) Last_Name_;
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
    KEL.typ.nstr P___Inp_I_P_Addr_;
    KEL.typ.nstr Input_Employment_Echo_;
    KEL.typ.nstr P___Inp_Arch_Dt_;
    KEL.typ.nint P___Lex_I_D_;
    KEL.typ.nint P___Lex_I_D_Score_;
    KEL.typ.nstr P___Inp_Cln_Name_Prfx_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Mid_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Name_Sffx_;
    KEL.typ.nint P___Inp_Cln_Addr_Property_U_I_D_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr P___Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lat_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lng_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_Code_;
    KEL.typ.nstr P___Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr P___Inp_Cln_Addr_Geo_;
    KEL.typ.ntyp(E_Geo_Link().Typ) Geo_Link_I_D_;
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
    KEL.typ.nbool Clean_City_State_Zip_Not_Populated_;
    KEL.typ.nstr Email_Domain_;
    KEL.typ.nstr Email_Username_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Value_;
    KEL.typ.nstr Input_City_Clean_Value_;
    KEL.typ.nstr Input_First_Name_Value_;
    KEL.typ.nstr Input_Last_Name_Value_;
    KEL.typ.nstr Input_Middle_Name_Value_;
    KEL.typ.nstr Input_Post_Direction_Clean_Value_;
    KEL.typ.nstr Input_Pre_Direction_Clean_Value_;
    KEL.typ.nstr Input_Primary_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Range_Clean_Value_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Value_;
    KEL.typ.nstr Input_State_Clean_Value_;
    KEL.typ.nstr Input_Street_Clean_Value_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Value_;
    KEL.typ.nstr Input_Zip4_Clean_Value_;
    KEL.typ.nstr Input_Zip5_Clean_Value_;
    KEL.typ.bool Name_Not_Populated_ := FALSE;
    KEL.typ.nstr P___Inp_Addr_;
    KEL.typ.str P___Inp_Addr_City_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_State_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_Zip_Flag_Value_ := '';
    KEL.typ.nstr P___Inp_Cln_Addr_St_Flag_Value_;
    KEL.typ.str P___Inp_Val_Name_Bogus_Flag_ := '';
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) B_I_I_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1757947(B_Input_P_I_I_3(__in,__cfg).__ST145245_Layout __EE1752002, E_Input_B_I_I_Input_P_I_I(__in,__cfg).Layout __EE1757929) := __EEQP(__EE1757929.P_I_I_,__EE1752002.UID);
  __ST1755392_Layout __JT1757947(B_Input_P_I_I_3(__in,__cfg).__ST145245_Layout __l, E_Input_B_I_I_Input_P_I_I(__in,__cfg).Layout __r) := TRANSFORM
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1757948 := JOIN(__EE1757929,__EE1752002,__JC1757947(RIGHT,LEFT),__JT1757947(RIGHT,LEFT),INNER,SMART);
  SHARED __ST1754394_Layout := RECORD
    KEL.typ.ntyp(E_Input_B_I_I().Typ) UID;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) B_I_I_;
    KEL.typ.nuid U_I_D__1_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.nstr P___Inp_Acct_;
    KEL.typ.nint P___Inp_Lex_I_D_;
    KEL.typ.nstr P___Inp_Name_First_;
    KEL.typ.nstr P___Inp_Name_Mid_;
    KEL.typ.nstr P___Inp_Name_Last_;
    KEL.typ.ntyp(E_Surname().Typ) Last_Name_;
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
    KEL.typ.nstr P___Inp_I_P_Addr_;
    KEL.typ.nstr Input_Employment_Echo_;
    KEL.typ.nstr P___Inp_Arch_Dt_;
    KEL.typ.nint P___Lex_I_D_;
    KEL.typ.nint P___Lex_I_D_Score_;
    KEL.typ.nstr P___Inp_Cln_Name_Prfx_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Mid_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Name_Sffx_;
    KEL.typ.nint P___Inp_Cln_Addr_Property_U_I_D_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr P___Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Unit_Desig_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_;
    KEL.typ.nstr P___Inp_Cln_Addr_City_Post_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip4_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lat_;
    KEL.typ.nstr P___Inp_Cln_Addr_Lng_;
    KEL.typ.nstr P___Inp_Cln_Addr_State_Code_;
    KEL.typ.nstr P___Inp_Cln_Addr_Cnty_;
    KEL.typ.nstr P___Inp_Cln_Addr_Geo_;
    KEL.typ.ntyp(E_Geo_Link().Typ) Geo_Link_I_D_;
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
    KEL.typ.nbool Clean_City_State_Zip_Not_Populated_;
    KEL.typ.nstr Email_Domain_;
    KEL.typ.nstr Email_Username_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Value_;
    KEL.typ.nstr Input_City_Clean_Value_;
    KEL.typ.nstr Input_First_Name_Value_;
    KEL.typ.nstr Input_Last_Name_Value_;
    KEL.typ.nstr Input_Middle_Name_Value_;
    KEL.typ.nstr Input_Post_Direction_Clean_Value_;
    KEL.typ.nstr Input_Pre_Direction_Clean_Value_;
    KEL.typ.nstr Input_Primary_Name_Clean_Value_;
    KEL.typ.nstr Input_Primary_Range_Clean_Value_;
    KEL.typ.nstr Input_Secondary_Range_Clean_Value_;
    KEL.typ.nstr Input_State_Clean_Value_;
    KEL.typ.nstr Input_Street_Clean_Value_;
    KEL.typ.nstr Input_Unit_Desig_Clean_Value_;
    KEL.typ.nstr Input_Zip4_Clean_Value_;
    KEL.typ.nstr Input_Zip5_Clean_Value_;
    KEL.typ.bool Name_Not_Populated_ := FALSE;
    KEL.typ.nstr P___Inp_Addr_;
    KEL.typ.str P___Inp_Addr_City_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_State_Flag_Value_ := '';
    KEL.typ.str P___Inp_Addr_Zip_Flag_Value_ := '';
    KEL.typ.nstr P___Inp_Cln_Addr_St_Flag_Value_;
    KEL.typ.str P___Inp_Val_Name_Bogus_Flag_ := '';
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __ST1754394_Layout __ND1758057__Project(__ST1755392_Layout __PP1757949) := TRANSFORM
    SELF.UID := __PP1757949.B_I_I_;
    SELF.U_I_D__1_ := __PP1757949.UID;
    SELF := __PP1757949;
  END;
  SHARED __EE1758474 := PROJECT(__EE1757948,__ND1758057__Project(LEFT));
  SHARED __ST1754641_Layout := RECORD
    KEL.typ.ntyp(E_Input_B_I_I().Typ) UID;
    KEL.typ.nuid Exp1_;
    KEL.typ.nuid Exp2_;
    KEL.typ.nuid Exp3_;
    KEL.typ.nuid Exp4_;
    KEL.typ.nuid Exp5_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __ST1754641_Layout __ND1759125__Project(__ST1754394_Layout __PP1758475) := TRANSFORM
    SELF.Exp1_ := IF(__T(__OP2(__PP1758475.Rep_Number_,=,__CN(1))),__ECAST(KEL.typ.nuid,__PP1758475.U_I_D__1_),__ECAST(KEL.typ.nuid,__N(KEL.typ.uid)));
    SELF.Exp2_ := IF(__T(__OP2(__PP1758475.Rep_Number_,=,__CN(2))),__ECAST(KEL.typ.nuid,__PP1758475.U_I_D__1_),__ECAST(KEL.typ.nuid,__N(KEL.typ.uid)));
    SELF.Exp3_ := IF(__T(__OP2(__PP1758475.Rep_Number_,=,__CN(3))),__ECAST(KEL.typ.nuid,__PP1758475.U_I_D__1_),__ECAST(KEL.typ.nuid,__N(KEL.typ.uid)));
    SELF.Exp4_ := IF(__T(__OP2(__PP1758475.Rep_Number_,=,__CN(4))),__ECAST(KEL.typ.nuid,__PP1758475.U_I_D__1_),__ECAST(KEL.typ.nuid,__N(KEL.typ.uid)));
    SELF.Exp5_ := IF(__T(__OP2(__PP1758475.Rep_Number_,=,__CN(5))),__ECAST(KEL.typ.nuid,__PP1758475.U_I_D__1_),__ECAST(KEL.typ.nuid,__N(KEL.typ.uid)));
    SELF := __PP1758475;
  END;
  SHARED __EE1759145 := PROJECT(__EE1758474,__ND1759125__Project(LEFT));
  SHARED __ST1754676_Layout := RECORD
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D__2_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D__3_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D__4_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) UID;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
  END;
  SHARED __EE1759181 := PROJECT(__CLEANANDDO(__EE1759145,TABLE(__EE1759145,{KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),KEL.Aggregates.MaxNG(__EE1759145.Exp1_) O_N_L_Y___U_I_D_,KEL.Aggregates.MaxNG(__EE1759145.Exp2_) O_N_L_Y___U_I_D__1_,KEL.Aggregates.MaxNG(__EE1759145.Exp3_) O_N_L_Y___U_I_D__2_,KEL.Aggregates.MaxNG(__EE1759145.Exp4_) O_N_L_Y___U_I_D__3_,KEL.Aggregates.MaxNG(__EE1759145.Exp5_) O_N_L_Y___U_I_D__4_,UID},UID,MERGE)),__ST1754676_Layout);
  SHARED __ST1755929_Layout := RECORD
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
    KEL.typ.nint At_Position_;
    KEL.typ.nstr B___Inp_Addr_;
    KEL.typ.str B___Inp_Addr_City_Flag_Value_ := '';
    KEL.typ.str B___Inp_Addr_State_Flag_Value_ := '';
    KEL.typ.str B___Inp_Addr_Zip_Flag_Value_ := '';
    KEL.typ.nstr B___Inp_Cln_Addr_Full_Flag_Value_;
    KEL.typ.nstr B___Inp_Cln_Addr_St_Flag_Value_;
    KEL.typ.nstr Bus_Input_Addr_Suffix_Clean_Value_;
    KEL.typ.nstr Bus_Input_City_Clean_Value_;
    KEL.typ.nstr Bus_Input_Full_Address_Clean_Value_;
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
    KEL.typ.nbool City_State_Zip_Not_Populated_;
    KEL.typ.nbool Clean_City_State_Zip_Not_Populated_;
    KEL.typ.nstr Email_Domain_;
    KEL.typ.nstr Email_Username_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D__1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D__2_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D__3_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) O_N_L_Y___U_I_D__4_;
    KEL.typ.ntyp(E_Input_B_I_I().Typ) U_I_D__1_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1759187(B_Input_B_I_I_3(__in,__cfg).__ST144748_Layout __EE1751355, __ST1754676_Layout __EE1759181) := __EEQP(__EE1751355.UID,__EE1759181.UID);
  __ST1755929_Layout __JT1759187(B_Input_B_I_I_3(__in,__cfg).__ST144748_Layout __l, __ST1754676_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1759290 := JOIN(__EE1751355,__EE1759181,__JC1759187(LEFT,RIGHT),__JT1759187(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST133719_Layout := RECORD
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
    KEL.typ.nint At_Position_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) Auth_Rep1_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) Auth_Rep2_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) Auth_Rep3_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) Auth_Rep4_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) Auth_Rep5_;
    KEL.typ.nstr B___Inp_Addr_;
    KEL.typ.str B___Inp_Addr_City_Flag_Value_ := '';
    KEL.typ.str B___Inp_Addr_State_Flag_Value_ := '';
    KEL.typ.str B___Inp_Addr_Zip_Flag_Value_ := '';
    KEL.typ.nstr B___Inp_Cln_Addr_Full_Flag_Value_;
    KEL.typ.nstr B___Inp_Cln_Addr_St_Flag_Value_;
    KEL.typ.nstr Bus_Input_Addr_Suffix_Clean_Value_;
    KEL.typ.nstr Bus_Input_Alternate_Name_Clean_Value_;
    KEL.typ.nstr Bus_Input_City_Clean_Value_;
    KEL.typ.nstr Bus_Input_Email_Clean_Value_;
    KEL.typ.nstr Bus_Input_Email_Echo_Value_;
    KEL.typ.nstr Bus_Input_Full_Address_Clean_Value_;
    KEL.typ.nstr Bus_Input_I_P_Address_Echo_Value_;
    KEL.typ.nstr Bus_Input_Name_Clean_Value_;
    KEL.typ.nstr Bus_Input_Phone_Clean_Value_;
    KEL.typ.nstr Bus_Input_Post_Dir_Clean_Value_;
    KEL.typ.nstr Bus_Input_Pre_Dir_Clean_Value_;
    KEL.typ.nstr Bus_Input_Prim_Name_Clean_Value_;
    KEL.typ.nstr Bus_Input_Prim_Range_Clean_Value_;
    KEL.typ.nstr Bus_Input_Sec_Range_Clean_Value_;
    KEL.typ.nstr Bus_Input_State_Clean_Value_;
    KEL.typ.nstr Bus_Input_State_Echo_Value_;
    KEL.typ.nstr Bus_Input_Street_Clean_Value_;
    KEL.typ.nstr Bus_Input_T_I_N_Clean_Value_;
    KEL.typ.nstr Bus_Input_T_I_N_Echo_Value_;
    KEL.typ.nstr Bus_Input_Unit_Desig_Clean_Value_;
    KEL.typ.nstr Bus_Input_Zip4_Clean_Value_;
    KEL.typ.nstr Bus_Input_Zip5_Clean_Value_;
    KEL.typ.nstr Bus_Input_Zip_Echo_Value_;
    KEL.typ.nbool City_State_Zip_Not_Populated_;
    KEL.typ.nbool Clean_City_State_Zip_Not_Populated_;
    KEL.typ.nstr Clean_Email_Username_;
    KEL.typ.nstr Email_Domain_;
    KEL.typ.nint Email_Domain_Length_;
    KEL.typ.nstr Email_Username_;
    KEL.typ.nint Email_Username_Length_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST133719_Layout __ND1759295__Project(__ST1755929_Layout __PP1759291) := TRANSFORM
    SELF.Auth_Rep1_ := __PP1759291.O_N_L_Y___U_I_D_;
    SELF.Auth_Rep2_ := __PP1759291.O_N_L_Y___U_I_D__1_;
    SELF.Auth_Rep3_ := __PP1759291.O_N_L_Y___U_I_D__2_;
    SELF.Auth_Rep4_ := __PP1759291.O_N_L_Y___U_I_D__3_;
    SELF.Auth_Rep5_ := __PP1759291.O_N_L_Y___U_I_D__4_;
    __CC9349 := '-99999';
    __CC9354 := '-99998';
    SELF.Bus_Input_Alternate_Name_Clean_Value_ := FN_Compile(__cfg).FN_Is_Blank2_Fields(__ECAST(KEL.typ.nstr,__PP1759291.B___Inp_Alt_Name_),__ECAST(KEL.typ.nstr,__CN(__CC9349)),__ECAST(KEL.typ.nstr,__PP1759291.B___Inp_Cln_Alt_Name_),__ECAST(KEL.typ.nstr,__CN(__CC9354)));
    SELF.Bus_Input_Email_Clean_Value_ := FN_Compile(__cfg).FN_Is_Blank2_Fields(__ECAST(KEL.typ.nstr,__PP1759291.B___Inp_Email_),__ECAST(KEL.typ.nstr,__CN(__CC9349)),__ECAST(KEL.typ.nstr,__PP1759291.B___Inp_Cln_Email_),__ECAST(KEL.typ.nstr,__CN(__CC9354)));
    SELF.Bus_Input_Email_Echo_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP1759291.B___Inp_Email_),__ECAST(KEL.typ.nstr,__CN(__CC9349)));
    SELF.Bus_Input_I_P_Address_Echo_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP1759291.B___Inp_I_P_Addr_),__ECAST(KEL.typ.nstr,__CN(__CC9349)));
    SELF.Bus_Input_State_Echo_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP1759291.B___Inp_Addr_State_),__ECAST(KEL.typ.nstr,__CN(__CC9349)));
    SELF.Bus_Input_T_I_N_Echo_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP1759291.B___Inp_T_I_N_),__ECAST(KEL.typ.nstr,__CN(__CC9349)));
    SELF.Bus_Input_Zip_Echo_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP1759291.B___Inp_Addr_Zip_),__ECAST(KEL.typ.nstr,__CN(__CC9349)));
    SELF.Clean_Email_Username_ := FN_Compile(__cfg).FN_Get_Clean_Email_Username(__ECAST(KEL.typ.nstr,__PP1759291.B___Inp_Email_));
    SELF.Email_Domain_Length_ := __FN1(LENGTH,__PP1759291.Email_Domain_);
    SELF.Email_Username_Length_ := __FN1(LENGTH,__PP1759291.Email_Username_);
    SELF := __PP1759291;
  END;
  EXPORT __ENH_Input_B_I_I_2 := PROJECT(__EE1759290,__ND1759295__Project(LEFT));
END;
