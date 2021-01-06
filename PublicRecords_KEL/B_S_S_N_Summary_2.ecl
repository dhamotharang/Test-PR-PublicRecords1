﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Input_P_I_I_3,B_Inquiry_4,B_Property_4,B_S_S_N_Summary_3,B_S_S_N_Summary_4,CFG_Compile,E_Address,E_Email,E_Geo_Link,E_Input_P_I_I,E_Inquiry,E_Person,E_Phone,E_Property,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Input_P_I_I_3(__in,__cfg).__ENH_Input_P_I_I_3) __ENH_Input_P_I_I_3 := B_Input_P_I_I_3(__in,__cfg).__ENH_Input_P_I_I_3;
  SHARED VIRTUAL TYPEOF(B_S_S_N_Summary_3(__in,__cfg).__ENH_S_S_N_Summary_3) __ENH_S_S_N_Summary_3 := B_S_S_N_Summary_3(__in,__cfg).__ENH_S_S_N_Summary_3;
  SHARED __EE7202003 := __ENH_S_S_N_Summary_3;
  SHARED __EE7202005 := __ENH_Input_P_I_I_3;
  SHARED __ST1845463_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST224676_Layout) Address_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST224685_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST224692_Layout) Name_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST224700_Layout) Phone_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.nstr P___Inp_Cln_Primary_Name_;
    KEL.typ.nstr P___Inp_Cln_Primary_Range_;
    KEL.typ.nstr P___Inp_Cln_Zip_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST75702_Layout) Phone_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST75664_Layout) Phone_Translated_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST75368_Layout) S_S_N_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST75530_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST75567_Layout) Translated_D_O_B_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST75806_Layout) Translated_Fn_Ln_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST75845_Layout) Translated_Fn_Ln_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST75314_Layout) Translated_Sources_;
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
    KEL.typ.nstr P___Inp_Cln_Name_First__1_;
    KEL.typ.nstr P___Inp_Cln_Name_Mid_;
    KEL.typ.nstr P___Inp_Cln_Name_Last__1_;
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
    KEL.typ.nstr P___Inp_Cln_Phone_Home__1_;
    KEL.typ.ntyp(E_Phone().Typ) Input_Clean_Phone_;
    KEL.typ.nstr P___Inp_Cln_Phone_Work_;
    KEL.typ.nstr P___Inp_Cln_D_L_;
    KEL.typ.nstr P___Inp_Cln_D_L_State_;
    KEL.typ.nkdate P___Inp_Cln_D_O_B__1_;
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
    KEL.typ.nstr Email_Domain_;
    KEL.typ.nstr Email_Username_;
    KEL.typ.ndataset(B_Input_P_I_I_3(__in,__cfg).__ST74659_Layout) Good_Inquiries_Last_Year_For_Address_;
    KEL.typ.ndataset(B_Input_P_I_I_3(__in,__cfg).__ST73577_Layout) Input_Address_Property_Set_;
    KEL.typ.ndataset(B_Input_P_I_I_3(__in,__cfg).__ST73628_Layout) Input_Address_Property_Set1_Y_;
    KEL.typ.ndataset(B_Input_P_I_I_3(__in,__cfg).__ST73693_Layout) Input_Address_Property_Set5_Y_;
    KEL.typ.nstr Input_Address_Suffix_Clean_Value_;
    KEL.typ.bool Input_Addronfile_ := FALSE;
    KEL.typ.nstr Input_City_Clean_Value_;
    KEL.typ.nstr Input_D_O_B_Clean_Value_;
    KEL.typ.nstr Input_Email_Clean_Value_;
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
    KEL.typ.nstr Input_S_S_N_Clean_Value_;
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
    KEL.typ.nstr P___Inp_Cln_Addr_Full_Flag_Value_;
    KEL.typ.nstr P___Inp_Cln_Addr_St_Flag_Value_;
    KEL.typ.str P___Inp_Val_Name_Bogus_Flag_ := '';
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC7202014(B_S_S_N_Summary_3(__in,__cfg).__ST224672_Layout __EE7202003, B_Input_P_I_I_3(__in,__cfg).__ST931861_Layout __EE7202005) := __EEQP(__EE7202003.P_I_I_,__EE7202005.UID);
  __ST1845463_Layout __JT7202014(B_S_S_N_Summary_3(__in,__cfg).__ST224672_Layout __l, B_Input_P_I_I_3(__in,__cfg).__ST931861_Layout __r) := TRANSFORM
    SELF.U_I_D__1_ := __r.UID;
    SELF.P___Inp_Cln_Name_First__1_ := __r.P___Inp_Cln_Name_First_;
    SELF.P___Inp_Cln_Name_Last__1_ := __r.P___Inp_Cln_Name_Last_;
    SELF.P___Inp_Cln_Phone_Home__1_ := __r.P___Inp_Cln_Phone_Home_;
    SELF.P___Inp_Cln_D_O_B__1_ := __r.P___Inp_Cln_D_O_B_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE7202244 := JOIN(__EE7202003,__EE7202005,__JC7202014(LEFT,RIGHT),__JT7202014(LEFT,RIGHT),LEFT OUTER,SMART);
  EXPORT __ST210330_Layout := RECORD
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
  EXPORT __ST210339_Layout := RECORD
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
  EXPORT __ST210346_Layout := RECORD
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
  EXPORT __ST210354_Layout := RECORD
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
  EXPORT __ST210326_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST210330_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST210339_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST210346_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST210354_Layout) Phone_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.nstr P___Inp_Cln_Primary_Name_;
    KEL.typ.nstr P___Inp_Cln_Primary_Range_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.nstr P___Inp_Cln_Zip_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST75702_Layout) Phone_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST75702_Layout) Phone_Summary_Source_List_Sorted_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST75664_Layout) Phone_Translated_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST75368_Layout) S_S_N_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST75368_Layout) S_S_N_Summary_Source_List_Sorted_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST75567_Layout) Sorted_D_O_B_Translated_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST75845_Layout) Sorted_Fn_Ln_Translated_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST75530_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST75567_Layout) Translated_D_O_B_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST75806_Layout) Translated_Fn_Ln_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST75845_Layout) Translated_Fn_Ln_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST75314_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST210326_Layout __ND7201757__Project(__ST1845463_Layout __PP7200042) := TRANSFORM
    __EE7202247 := __PP7200042.Address_Summary_;
    SELF.Address_Summary_ := __BN(PROJECT(__T(__EE7202247),__ST210330_Layout),__NL(__EE7202247));
    __EE7202250 := __PP7200042.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE7202250),__ST210339_Layout),__NL(__EE7202250));
    __EE7202253 := __PP7200042.Name_Summary_;
    SELF.Name_Summary_ := __BN(PROJECT(__T(__EE7202253),__ST210346_Layout),__NL(__EE7202253));
    __EE7202256 := __PP7200042.Phone_Summary_;
    SELF.Phone_Summary_ := __BN(PROJECT(__T(__EE7202256),__ST210354_Layout),__NL(__EE7202256));
    SELF.P___Inp_Cln_S_S_N_ := __PP7200042.Input_S_S_N_Clean_Value_;
    __EE7201742 := __PP7200042.Phone_Summary_Source_List_;
    __BS7201743 := __T(__EE7201742);
    __EE7201751 := __BS7201743(__T(__OP2(__CAST(KEL.typ.str,__T(__EE7201742).Phone10_),=,__PP7200042.P___Inp_Cln_Phone_Home_)));
    __CC13690 := '-99997';
    __EE7201755 := TOPN(__EE7201751(__NN(__OP2(__EE7201751.Source_Date_First_Seen_,=,__CN(__CC13690))) AND __NN(__EE7201751.Source_Date_First_Seen_) AND __NN(__EE7201751.Source_Date_Last_Seen_) AND __NN(__EE7201751.Phone_Translated_Source_Code_)),1000,__T(__OP2(__EE7201751.Source_Date_First_Seen_,=,__CN(__CC13690))),__T(__EE7201751.Source_Date_First_Seen_), -__T(__EE7201751.Source_Date_Last_Seen_),__T(__EE7201751.Phone_Translated_Source_Code_),__T(Phone10_));
    SELF.Phone_Summary_Source_List_Sorted_ := __CN(__EE7201755);
    __EE7201786 := __PP7200042.S_S_N_Summary_Source_List_;
    __BS7201787 := __T(__EE7201786);
    __EE7201807 := __BS7201787(__T(__AND(__OP2(__T(__EE7201786).Primary_Name_Address_,=,__PP7200042.P___Inp_Cln_Primary_Name_),__AND(__OP2(__T(__EE7201786).Primary_Range_Address_,=,__PP7200042.P___Inp_Cln_Primary_Range_),__OP2(__T(__EE7201786).Zip_Address_,=,__PP7200042.P___Inp_Cln_Zip_)))));
    __EE7201811 := TOPN(__EE7201807(__NN(__OP2(__EE7201807.Source_Date_First_Seen_,=,__CN(__CC13690))) AND __NN(__EE7201807.Source_Date_First_Seen_) AND __NN(__EE7201807.Source_Date_Last_Seen_) AND __NN(__EE7201807.Translated_Source_Code_)),1000,__T(__OP2(__EE7201807.Source_Date_First_Seen_,=,__CN(__CC13690))),__T(__EE7201807.Source_Date_First_Seen_), -__T(__EE7201807.Source_Date_Last_Seen_),__T(__EE7201807.Translated_Source_Code_),__T(Primary_Name_Address_),__T(Primary_Range_Address_),__T(Zip_Address_));
    SELF.S_S_N_Summary_Source_List_Sorted_ := __CN(__EE7201811);
    __EE7201837 := __PP7200042.Translated_D_O_B_Sources_List_;
    __BS7201838 := __T(__EE7201837);
    __EE7201849 := __BS7201838(__T(__OP2(__FN2(KEL.Routines.DateToString,__T(__EE7201837).Date_Of_Birth_,__CN('%Y%m%d')),=,__PP7200042.P___Inp_Cln_D_O_B_)));
    __EE7201853 := TOPN(__EE7201849(__NN(__OP2(__EE7201849.Source_Date_First_Seen_,=,__CN(__CC13690))) AND __NN(__EE7201849.Source_Date_First_Seen_) AND __NN(__EE7201849.Source_Date_Last_Seen_) AND __NN(__EE7201849.Translated_Source_Code_)),1000,__T(__OP2(__EE7201849.Source_Date_First_Seen_,=,__CN(__CC13690))),__T(__EE7201849.Source_Date_First_Seen_), -__T(__EE7201849.Source_Date_Last_Seen_),__T(__EE7201849.Translated_Source_Code_),__T(Date_Of_Birth_));
    SELF.Sorted_D_O_B_Translated_Source_List_ := __CN(__EE7201853);
    __EE7201879 := __PP7200042.Translated_Fn_Ln_Sources_List_;
    __BS7201880 := __T(__EE7201879);
    __EE7201894 := __BS7201880(__T(__AND(__OP2(__T(__EE7201879).First_Name_,=,__PP7200042.P___Inp_Cln_Name_First_),__OP2(__T(__EE7201879).Last_Name_,=,__PP7200042.P___Inp_Cln_Name_Last_))));
    __EE7201898 := TOPN(__EE7201894(__NN(__OP2(__EE7201894.Source_Date_First_Seen_,=,__CN(__CC13690))) AND __NN(__EE7201894.Source_Date_First_Seen_) AND __NN(__EE7201894.Source_Date_Last_Seen_) AND __NN(__EE7201894.Translated_Source_Code_)),1000,__T(__OP2(__EE7201894.Source_Date_First_Seen_,=,__CN(__CC13690))),__T(__EE7201894.Source_Date_First_Seen_), -__T(__EE7201894.Source_Date_Last_Seen_),__T(__EE7201894.Translated_Source_Code_),__T(First_Name_),__T(Last_Name_));
    SELF.Sorted_Fn_Ln_Translated_Source_List_ := __CN(__EE7201898);
    SELF := __PP7200042;
  END;
  EXPORT __ENH_S_S_N_Summary_2 := PROJECT(__EE7202244,__ND7201757__Project(LEFT));
END;
