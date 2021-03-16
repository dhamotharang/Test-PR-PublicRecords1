//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Phone_Summary_1,B_Phone_Summary_2,B_Phone_Summary_3,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Phone_Summary(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Phone_Summary_1(__in,__cfg).__ENH_Phone_Summary_1) __ENH_Phone_Summary_1 := B_Phone_Summary_1(__in,__cfg).__ENH_Phone_Summary_1;
  SHARED __EE12132311 := __ENH_Phone_Summary_1;
  EXPORT __ST184363_Layout := RECORD
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST184373_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST184389_Layout := RECORD
    KEL.typ.nstr Last_Name_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST184350_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(__ST184363_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST184373_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(__ST184389_Layout) Last_Name_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P_I___Src_W_Inp_A_P_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_A_P_Last_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_A_P_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_L_P_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_L_P_Last_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_L_P_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_P_D_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_P_D_Last_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_P_D_List_Ev_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.ndataset(B_Phone_Summary_2(__in,__cfg).__ST81221_Layout) Sorted_Address_Translated_Source_List_;
    KEL.typ.ndataset(B_Phone_Summary_2(__in,__cfg).__ST80716_Layout) Sorted_D_O_B_Translated_Source_List_;
    KEL.typ.ndataset(B_Phone_Summary_2(__in,__cfg).__ST80944_Layout) Sorted_Last_Name_Translated_Source_List_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST1284666_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST1284677_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST1284686_Layout) Translated_Last_Name_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST184350_Layout __ND12131983__Project(B_Phone_Summary_1(__in,__cfg).__ST317881_Layout __PP12131275) := TRANSFORM
    __EE12132314 := __PP12131275.Address_Summary_;
    SELF.Address_Summary_ := __BN(PROJECT(__T(__EE12132314),__ST184363_Layout),__NL(__EE12132314));
    __EE12132317 := __PP12131275.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE12132317),__ST184373_Layout),__NL(__EE12132317));
    __EE12132320 := __PP12131275.Last_Name_Summary_;
    SELF.Last_Name_Summary_ := __BN(PROJECT(__T(__EE12132320),__ST184389_Layout),__NL(__EE12132320));
    __CC13993 := '-99999';
    __CC13998 := '-99998';
    __EE12131976 := __PP12131275.Sorted_Address_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_A_P_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP12131275.P___Inp_Cln_Phone_Home_,IN,__CN([__CC13993,__CC13998])),__OP2(__PP12131275.P___Inp_Cln_Addr_Prim_Name_,IN,__CN([__CC13993,__CC13998]))),__OP2(__PP12131275.P___Inp_Cln_Addr_Prim_Rng_,IN,__CN([__CC13993,__CC13998]))),__OP2(__PP12131275.P___Inp_Cln_Addr_Zip5_,IN,__CN([__CC13993,__CC13998]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13993)),__T(__OP2(__PP12131275.P_I___Src_W_Inp_A_P_List_Ev_,=,__CN(__CC13998)))=>__ECAST(KEL.typ.nstr,__CN(__CC13998)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE12131976,LEFT.My_Date_First_Seen_,__CN('|'))));
    __EE12132034 := __PP12131275.Sorted_Address_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_A_P_Last_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP12131275.P___Inp_Cln_Phone_Home_,IN,__CN([__CC13993,__CC13998])),__OP2(__PP12131275.P___Inp_Cln_Addr_Prim_Name_,IN,__CN([__CC13993,__CC13998]))),__OP2(__PP12131275.P___Inp_Cln_Addr_Prim_Rng_,IN,__CN([__CC13993,__CC13998]))),__OP2(__PP12131275.P___Inp_Cln_Addr_Zip5_,IN,__CN([__CC13993,__CC13998]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13993)),__T(__OP2(__PP12131275.P_I___Src_W_Inp_A_P_List_Ev_,=,__CN(__CC13998)))=>__ECAST(KEL.typ.nstr,__CN(__CC13998)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE12132034,LEFT.My_Date_Last_Seen_,__CN('|'))));
    __EE12132076 := __PP12131275.Sorted_Last_Name_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_L_P_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP12131275.P___Inp_Cln_Phone_Home_,IN,__CN([__CC13993,__CC13998])),__OP2(__PP12131275.P___Inp_Cln_Name_Last_,IN,__CN([__CC13993,__CC13998]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13993)),__T(__OP2(__PP12131275.P_I___Src_W_Inp_L_P_List_Ev_,=,__CN(__CC13998)))=>__ECAST(KEL.typ.nstr,__CN(__CC13998)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE12132076,LEFT.My_Date_First_Seen_,__CN('|'))));
    __EE12132116 := __PP12131275.Sorted_Last_Name_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_L_P_Last_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP12131275.P___Inp_Cln_Phone_Home_,IN,__CN([__CC13993,__CC13998])),__OP2(__PP12131275.P___Inp_Cln_Name_Last_,IN,__CN([__CC13993,__CC13998]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13993)),__T(__OP2(__PP12131275.P_I___Src_W_Inp_L_P_List_Ev_,=,__CN(__CC13998)))=>__ECAST(KEL.typ.nstr,__CN(__CC13998)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE12132116,LEFT.My_Date_Last_Seen_,__CN('|'))));
    __EE12132158 := __PP12131275.Sorted_D_O_B_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_P_D_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP12131275.P___Inp_Cln_Phone_Home_,IN,__CN([__CC13993,__CC13998])),__OP2(__PP12131275.P___Inp_Cln_D_O_B_,IN,__CN([__CC13993,__CC13998]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13993)),__T(__OP2(__PP12131275.P_I___Src_W_Inp_P_D_List_Ev_,=,__CN(__CC13998)))=>__ECAST(KEL.typ.nstr,__CN(__CC13998)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE12132158,LEFT.My_Date_First_Seen_,__CN('|'))));
    __EE12132198 := __PP12131275.Sorted_D_O_B_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_P_D_Last_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP12131275.P___Inp_Cln_Phone_Home_,IN,__CN([__CC13993,__CC13998])),__OP2(__PP12131275.P___Inp_Cln_D_O_B_,IN,__CN([__CC13993,__CC13998]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13993)),__T(__OP2(__PP12131275.P_I___Src_W_Inp_P_D_List_Ev_,=,__CN(__CC13998)))=>__ECAST(KEL.typ.nstr,__CN(__CC13998)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE12132198,LEFT.My_Date_Last_Seen_,__CN('|'))));
    SELF := __PP12131275;
  END;
  EXPORT __ENH_Phone_Summary := PROJECT(__EE12132311,__ND12131983__Project(LEFT));
END;
