﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Input_P_I_I_4,B_S_S_N_Summary_4,CFG_Compile,E_Address,E_Email,E_Geo_Link,E_Input_P_I_I,E_Person,E_Phone,E_Property,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4) __ENH_Input_P_I_I_4 := B_Input_P_I_I_4(__in,__cfg).__ENH_Input_P_I_I_4;
  SHARED VIRTUAL TYPEOF(B_S_S_N_Summary_4(__in,__cfg).__ENH_S_S_N_Summary_4) __ENH_S_S_N_Summary_4 := B_S_S_N_Summary_4(__in,__cfg).__ENH_S_S_N_Summary_4;
  SHARED __EE6056997 := __ENH_S_S_N_Summary_4;
  SHARED __EE6057000 := __ENH_Input_P_I_I_4;
  SHARED __ST1133657_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST235870_Layout) Address_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST235879_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST235886_Layout) Name_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST235894_Layout) Phone_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST76019_Layout) Phone_Translated_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST75884_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST76162_Layout) Translated_Fn_Ln_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST75667_Layout) Translated_Sources_;
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
    KEL.typ.bool Addr_Not_Populated_ := FALSE;
    KEL.typ.nint At_Position_;
    KEL.typ.nbool City_State_Zip_Not_Populated_;
    KEL.typ.nbool Clean_City_State_Zip_Not_Populated_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Value_;
    KEL.typ.nstr Input_City_Clean_Value_;
    KEL.typ.nstr Input_D_O_B_Clean_Value_;
    KEL.typ.nstr Input_First_Name_Clean_Value_;
    KEL.typ.nstr Input_First_Name_Value_;
    KEL.typ.nstr Input_Full_Address_Clean_Value_;
    KEL.typ.nstr Input_Home_Phone_Clean_Value_;
    KEL.typ.nstr Input_Last_Name_Clean_Value_;
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
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC6057554(B_S_S_N_Summary_4(__in,__cfg).__ST235866_Layout __EE6056997, B_Input_P_I_I_4(__in,__cfg).__ST233115_Layout __EE6057000) := __EEQP(__EE6056997.P_I_I_,__EE6057000.UID);
  __ST1133657_Layout __JT6057554(B_S_S_N_Summary_4(__in,__cfg).__ST235866_Layout __l, B_Input_P_I_I_4(__in,__cfg).__ST233115_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE6057555 := JOIN(__EE6056997,__EE6057000,__JC6057554(LEFT,RIGHT),__JT6057554(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST225139_Layout := RECORD
    KEL.typ.nstr Address_Primary_Name_;
    KEL.typ.nstr Address_Primary_Range_;
    KEL.typ.nstr Address_Zip_;
    KEL.typ.nstr Address_Source_;
    KEL.typ.nint Address_Record_Count_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST225148_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr Dob_Source_;
    KEL.typ.nint Dob_Record_Count_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST225155_Layout := RECORD
    KEL.typ.nstr Name_First_Name_;
    KEL.typ.nstr Name_Last_Name_;
    KEL.typ.nstr Name_Source_;
    KEL.typ.nint Name_Record_Count_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST225163_Layout := RECORD
    KEL.typ.nint Phone_Number_;
    KEL.typ.nstr Phone_Source_;
    KEL.typ.nint Phone_Record_Count_;
    KEL.typ.nstr Phone_Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST76057_Layout := RECORD
    KEL.typ.nint Phone10_;
    KEL.typ.nstr Phone_Translated_Source_Code_;
    KEL.typ.nstr Source_Date_First_Seen_;
    KEL.typ.nstr Source_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST75721_Layout := RECORD
    KEL.typ.nstr Primary_Name_Address_;
    KEL.typ.nstr Primary_Range_Address_;
    KEL.typ.nstr Zip_Address_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.nstr Source_Date_First_Seen_;
    KEL.typ.nstr Source_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST75921_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.nstr Source_Date_First_Seen_;
    KEL.typ.nstr Source_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST76201_Layout := RECORD
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.nstr Source_Date_First_Seen_;
    KEL.typ.nstr Source_Date_Last_Seen_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST225135_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST225139_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST225148_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST225155_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST225163_Layout) Phone_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.nstr P___Inp_Cln_Primary_Name_;
    KEL.typ.nstr P___Inp_Cln_Primary_Range_;
    KEL.typ.nstr P___Inp_Cln_Zip_;
    KEL.typ.ndataset(__ST76057_Layout) Phone_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST76019_Layout) Phone_Translated_Sources_;
    KEL.typ.ndataset(__ST75721_Layout) S_S_N_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST75884_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(__ST75921_Layout) Translated_D_O_B_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST76162_Layout) Translated_Fn_Ln_Sources_;
    KEL.typ.ndataset(__ST76201_Layout) Translated_Fn_Ln_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST75667_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST225135_Layout __ND6058092__Project(__ST1133657_Layout __PP6057010) := TRANSFORM
    __EE6057217 := __PP6057010.Address_Summary_;
    SELF.Address_Summary_ := __BN(PROJECT(__T(__EE6057217),__ST225139_Layout),__NL(__EE6057217));
    __EE6057249 := __PP6057010.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE6057249),__ST225148_Layout),__NL(__EE6057249));
    __EE6057273 := __PP6057010.Name_Summary_;
    SELF.Name_Summary_ := __BN(PROJECT(__T(__EE6057273),__ST225155_Layout),__NL(__EE6057273));
    __EE6057301 := __PP6057010.Phone_Summary_;
    SELF.Phone_Summary_ := __BN(PROJECT(__T(__EE6057301),__ST225163_Layout),__NL(__EE6057301));
    SELF.P___Inp_Cln_D_O_B_ := __PP6057010.Input_D_O_B_Clean_Value_;
    SELF.P___Inp_Cln_Name_First_ := __PP6057010.Input_First_Name_Clean_Value_;
    SELF.P___Inp_Cln_Name_Last_ := __PP6057010.Input_Last_Name_Clean_Value_;
    SELF.P___Inp_Cln_Phone_Home_ := __PP6057010.Input_Home_Phone_Clean_Value_;
    SELF.P___Inp_Cln_Primary_Name_ := __PP6057010.Input_Primary_Name_Clean_Value_;
    SELF.P___Inp_Cln_Primary_Range_ := __PP6057010.Input_Primary_Range_Clean_Value_;
    SELF.P___Inp_Cln_Zip_ := __PP6057010.Input_Zip5_Clean_Value_;
    __EE6057341 := __PP6057010.Phone_Translated_Sources_;
    __ST76057_Layout __ND6058082__Project(B_S_S_N_Summary_4(__in,__cfg).__ST76019_Layout __PP6057342) := TRANSFORM
      SELF.Phone10_ := __PP6057342.Phone_Number_;
      __CC13726 := '-99997';
      SELF.Source_Date_First_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP6057342.Date_First_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP6057342.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13726)));
      __CC13242 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('pii_corr_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Source_Date_Last_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP6057342.Date_Last_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP6057342.Date_Last_Seen_),__CC13242),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13726)));
      SELF := __PP6057342;
    END;
    SELF.Phone_Summary_Source_List_ := __PROJECT(__EE6057341,__ND6058082__Project(LEFT));
    __EE6057382 := __PP6057010.Translated_Sources_;
    __ST75721_Layout __ND6058097__Project(B_S_S_N_Summary_4(__in,__cfg).__ST75667_Layout __PP6057383) := TRANSFORM
      SELF.Primary_Name_Address_ := __PP6057383.Address_Primary_Name_;
      SELF.Primary_Range_Address_ := __PP6057383.Address_Primary_Range_;
      SELF.Zip_Address_ := __PP6057383.Address_Zip_;
      __CC13726 := '-99997';
      SELF.Source_Date_First_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP6057383.Date_First_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP6057383.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13726)));
      __CC13242 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('pii_corr_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Source_Date_Last_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP6057383.Date_Last_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP6057383.Date_Last_Seen_),__CC13242),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13726)));
      SELF := __PP6057383;
    END;
    SELF.S_S_N_Summary_Source_List_ := __PROJECT(__EE6057382,__ND6058097__Project(LEFT));
    __EE6057431 := __PP6057010.Translated_D_O_B_Sources_;
    __ST75921_Layout __ND6058113__Project(B_S_S_N_Summary_4(__in,__cfg).__ST75884_Layout __PP6057432) := TRANSFORM
      SELF.Date_Of_Birth_ := __PP6057432.Dob_Date_Of_Birth_;
      __CC13726 := '-99997';
      SELF.Source_Date_First_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP6057432.Date_First_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP6057432.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13726)));
      __CC13242 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('pii_corr_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Source_Date_Last_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP6057432.Date_Last_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP6057432.Date_Last_Seen_),__CC13242),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13726)));
      SELF := __PP6057432;
    END;
    SELF.Translated_D_O_B_Sources_List_ := __PROJECT(__EE6057431,__ND6058113__Project(LEFT));
    __EE6057472 := __PP6057010.Translated_Fn_Ln_Sources_;
    __ST76201_Layout __ND6058127__Project(B_S_S_N_Summary_4(__in,__cfg).__ST76162_Layout __PP6057473) := TRANSFORM
      SELF.First_Name_ := __PP6057473.Name_First_Name_;
      SELF.Last_Name_ := __PP6057473.Name_Last_Name_;
      __CC13726 := '-99997';
      SELF.Source_Date_First_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP6057473.Date_First_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.era.ToDate(__PP6057473.Date_First_Seen_),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13726)));
      __CC13242 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('pii_corr_build_version'))),__CN(__cfg.CurrentDate));
      SELF.Source_Date_Last_Seen_ := IF(__T(__FN1(KEL.Routines.IsValidDate,KEL.era.ToDate(__PP6057473.Date_Last_Seen_))),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,KEL.Routines.MinN(KEL.era.ToDate(__PP6057473.Date_Last_Seen_),__CC13242),__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13726)));
      SELF := __PP6057473;
    END;
    SELF.Translated_Fn_Ln_Sources_List_ := __PROJECT(__EE6057472,__ND6058127__Project(LEFT));
    SELF := __PP6057010;
  END;
  EXPORT __ENH_S_S_N_Summary_3 := PROJECT(__EE6057555,__ND6058092__Project(LEFT));
END;
