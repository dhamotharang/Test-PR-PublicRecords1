﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Input_P_I_I_7,B_Input_P_I_I_9,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Input_P_I_I_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_7(__in,__cfg).__ENH_Input_P_I_I_7) __ENH_Input_P_I_I_7 := B_Input_P_I_I_7(__in,__cfg).__ENH_Input_P_I_I_7;
  SHARED __EE3974663 := __ENH_Input_P_I_I_7;
  EXPORT __ST202927_Layout := RECORD
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
    KEL.typ.ntyp(E_Property().Typ) Prop_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
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
    KEL.typ.ntyp(E_Email().Typ) Input_Clean_Email_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.ntyp(E_Phone().Typ) Input_Clean_Phone_;
    KEL.typ.nstr P___Inp_Cln_Phone_Work_;
    KEL.typ.nstr P___Inp_Cln_D_L_;
    KEL.typ.nstr P___Inp_Cln_D_L_State_;
    KEL.typ.nkdate P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Input_Clean_S_S_N_;
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
    KEL.typ.ntyp(E_Address_Slim().Typ) Slim_Location_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.ntyp(E_S_S_N_Summary().Typ) Social_Summary_;
    KEL.typ.ntyp(E_Name_Summary().Typ) Name_Summ_;
    KEL.typ.ntyp(E_Phone_Summary().Typ) Telephone_Summary_;
    KEL.typ.ntyp(E_Address_Summary().Typ) Location_Summary_;
    KEL.typ.nstr Current_Addr_Prim_Rng_;
    KEL.typ.nstr Current_Addr_Pre_Dir_;
    KEL.typ.nstr Current_Addr_Prim_Name_;
    KEL.typ.nstr Current_Addr_Sffx_;
    KEL.typ.nstr Current_Addr_Sec_Rng_;
    KEL.typ.nstr Current_Addr_State_;
    KEL.typ.nstr Current_Addr_Zip5_;
    KEL.typ.nstr Current_Addr_Zip4_;
    KEL.typ.nstr Current_Addr_State_Code_;
    KEL.typ.nstr Current_Addr_Cnty_;
    KEL.typ.nstr Current_Addr_Geo_;
    KEL.typ.nstr Current_Addr_City_;
    KEL.typ.nstr Current_Addr_Post_Dir_;
    KEL.typ.nstr Current_Addr_Lat_;
    KEL.typ.nstr Current_Addr_Lng_;
    KEL.typ.nstr Current_Addr_Unit_Designation_;
    KEL.typ.nstr Current_Addr_Type_;
    KEL.typ.nstr Current_Addr_Status_;
    KEL.typ.nkdate Current_Addr_Date_First_Seen_;
    KEL.typ.nkdate Current_Addr_Date_Last_Seen_;
    KEL.typ.nstr Current_Addr_Full_;
    KEL.typ.ntyp(E_Address().Typ) Current_Address_;
    KEL.typ.nstr Previous_Addr_Prim_Rng_;
    KEL.typ.nstr Previous_Addr_Pre_Dir_;
    KEL.typ.nstr Previous_Addr_Prim_Name_;
    KEL.typ.nstr Previous_Addr_Sffx_;
    KEL.typ.nstr Previous_Addr_Sec_Rng_;
    KEL.typ.nstr Previous_Addr_State_;
    KEL.typ.nstr Previous_Addr_Zip5_;
    KEL.typ.nstr Previous_Addr_Zip4_;
    KEL.typ.nstr Previous_Addr_State_Code_;
    KEL.typ.nstr Previous_Addr_Cnty_;
    KEL.typ.nstr Previous_Addr_Geo_;
    KEL.typ.nstr Previous_Addr_City_;
    KEL.typ.nstr Previous_Addr_Post_Dir_;
    KEL.typ.nstr Previous_Addr_Lat_;
    KEL.typ.nstr Previous_Addr_Lng_;
    KEL.typ.nstr Previous_Addr_Unit_Designation_;
    KEL.typ.nstr Previous_Addr_Type_;
    KEL.typ.nstr Previous_Addr_Status_;
    KEL.typ.nkdate Previous_Addr_Date_First_Seen_;
    KEL.typ.nkdate Previous_Addr_Date_Last_Seen_;
    KEL.typ.nstr Previous_Addr_Full_;
    KEL.typ.ntyp(E_Address().Typ) Previous_Address_;
    KEL.typ.nstr Input_First_Name_Value_;
    KEL.typ.nstr Input_Last_Name_Value_;
    KEL.typ.nstr Input_Middle_Name_Value_;
    KEL.typ.nstr Input_S_S_N_Clean_Value_;
    KEL.typ.nstr P___Inp_Addr_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST202927_Layout __ND3975215__Project(B_Input_P_I_I_9(__in,__cfg).__ST199833_Layout __PP3974664) := TRANSFORM
    __CC13587 := '-99999';
    SELF.Input_First_Name_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP3974664.P___Inp_Name_First_),__ECAST(KEL.typ.nstr,__CN(__CC13587)));
    SELF.Input_Last_Name_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP3974664.P___Inp_Name_Last_),__ECAST(KEL.typ.nstr,__CN(__CC13587)));
    SELF.Input_Middle_Name_Value_ := FN_Compile(__cfg).FN_Is_Blank(__ECAST(KEL.typ.nstr,__PP3974664.P___Inp_Name_Mid_),__ECAST(KEL.typ.nstr,__CN(__CC13587)));
    SELF.P___Inp_Addr_ := __OP2(IF(__T(__NT(__PP3974664.P___Inp_Addr_Line1_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__OP2(__PP3974664.P___Inp_Addr_Line1_,+,__CN(' ')))),+,IF(__T(__NT(__PP3974664.P___Inp_Addr_Line2_)),__ECAST(KEL.typ.nstr,__CN('')),__ECAST(KEL.typ.nstr,__PP3974664.P___Inp_Addr_Line2_)));
    SELF := __PP3974664;
  END;
  EXPORT __ENH_Input_P_I_I_6 := PROJECT(__EE3974663,__ND3975215__Project(LEFT));
END;
