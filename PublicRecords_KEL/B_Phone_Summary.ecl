//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Phone_Summary_1,B_Phone_Summary_2,B_Phone_Summary_3,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Phone_Summary(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Phone_Summary_1(__in,__cfg).__ENH_Phone_Summary_1) __ENH_Phone_Summary_1 := B_Phone_Summary_1(__in,__cfg).__ENH_Phone_Summary_1;
  SHARED __EE11966294 := __ENH_Phone_Summary_1;
  EXPORT __ST183062_Layout := RECORD
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
  EXPORT __ST183072_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
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
  EXPORT __ST183087_Layout := RECORD
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
  EXPORT __ST183049_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(__ST183062_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST183072_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(__ST183087_Layout) Last_Name_Summary_;
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
    KEL.typ.ndataset(B_Phone_Summary_2(__in,__cfg).__ST80640_Layout) Sorted_Address_Translated_Source_List_;
    KEL.typ.ndataset(B_Phone_Summary_2(__in,__cfg).__ST80135_Layout) Sorted_D_O_B_Translated_Source_List_;
    KEL.typ.ndataset(B_Phone_Summary_2(__in,__cfg).__ST80363_Layout) Sorted_Last_Name_Translated_Source_List_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST1277052_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST1277063_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST1277072_Layout) Translated_Last_Name_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST183049_Layout __ND11965966__Project(B_Phone_Summary_1(__in,__cfg).__ST346855_Layout __PP11965263) := TRANSFORM
    __EE11966297 := __PP11965263.Address_Summary_;
    SELF.Address_Summary_ := __BN(PROJECT(__T(__EE11966297),__ST183062_Layout),__NL(__EE11966297));
    __EE11966300 := __PP11965263.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE11966300),__ST183072_Layout),__NL(__EE11966300));
    __EE11966303 := __PP11965263.Last_Name_Summary_;
    SELF.Last_Name_Summary_ := __BN(PROJECT(__T(__EE11966303),__ST183087_Layout),__NL(__EE11966303));
    __CC14005 := '-99999';
    __CC14010 := '-99998';
    __EE11965959 := __PP11965263.Sorted_Address_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_A_P_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP11965263.P___Inp_Cln_Phone_Home_,IN,__CN([__CC14005,__CC14010])),__OP2(__PP11965263.P___Inp_Cln_Addr_Prim_Name_,IN,__CN([__CC14005,__CC14010]))),__OP2(__PP11965263.P___Inp_Cln_Addr_Prim_Rng_,IN,__CN([__CC14005,__CC14010]))),__OP2(__PP11965263.P___Inp_Cln_Addr_Zip5_,IN,__CN([__CC14005,__CC14010]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14005)),__T(__OP2(__PP11965263.P_I___Src_W_Inp_A_P_List_Ev_,=,__CN(__CC14010)))=>__ECAST(KEL.typ.nstr,__CN(__CC14010)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11965959,LEFT.My_Date_First_Seen_,__CN('|'))));
    __EE11966017 := __PP11965263.Sorted_Address_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_A_P_Last_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP11965263.P___Inp_Cln_Phone_Home_,IN,__CN([__CC14005,__CC14010])),__OP2(__PP11965263.P___Inp_Cln_Addr_Prim_Name_,IN,__CN([__CC14005,__CC14010]))),__OP2(__PP11965263.P___Inp_Cln_Addr_Prim_Rng_,IN,__CN([__CC14005,__CC14010]))),__OP2(__PP11965263.P___Inp_Cln_Addr_Zip5_,IN,__CN([__CC14005,__CC14010]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14005)),__T(__OP2(__PP11965263.P_I___Src_W_Inp_A_P_List_Ev_,=,__CN(__CC14010)))=>__ECAST(KEL.typ.nstr,__CN(__CC14010)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11966017,LEFT.My_Date_Last_Seen_,__CN('|'))));
    __EE11966059 := __PP11965263.Sorted_Last_Name_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_L_P_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP11965263.P___Inp_Cln_Phone_Home_,IN,__CN([__CC14005,__CC14010])),__OP2(__PP11965263.P___Inp_Cln_Name_Last_,IN,__CN([__CC14005,__CC14010]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14005)),__T(__OP2(__PP11965263.P_I___Src_W_Inp_L_P_List_Ev_,=,__CN(__CC14010)))=>__ECAST(KEL.typ.nstr,__CN(__CC14010)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11966059,LEFT.My_Date_First_Seen_,__CN('|'))));
    __EE11966099 := __PP11965263.Sorted_Last_Name_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_L_P_Last_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP11965263.P___Inp_Cln_Phone_Home_,IN,__CN([__CC14005,__CC14010])),__OP2(__PP11965263.P___Inp_Cln_Name_Last_,IN,__CN([__CC14005,__CC14010]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14005)),__T(__OP2(__PP11965263.P_I___Src_W_Inp_L_P_List_Ev_,=,__CN(__CC14010)))=>__ECAST(KEL.typ.nstr,__CN(__CC14010)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11966099,LEFT.My_Date_Last_Seen_,__CN('|'))));
    __EE11966141 := __PP11965263.Sorted_D_O_B_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_P_D_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP11965263.P___Inp_Cln_Phone_Home_,IN,__CN([__CC14005,__CC14010])),__OP2(__PP11965263.P___Inp_Cln_D_O_B_,IN,__CN([__CC14005,__CC14010]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14005)),__T(__OP2(__PP11965263.P_I___Src_W_Inp_P_D_List_Ev_,=,__CN(__CC14010)))=>__ECAST(KEL.typ.nstr,__CN(__CC14010)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11966141,LEFT.My_Date_First_Seen_,__CN('|'))));
    __EE11966181 := __PP11965263.Sorted_D_O_B_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_P_D_Last_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP11965263.P___Inp_Cln_Phone_Home_,IN,__CN([__CC14005,__CC14010])),__OP2(__PP11965263.P___Inp_Cln_D_O_B_,IN,__CN([__CC14005,__CC14010]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14005)),__T(__OP2(__PP11965263.P_I___Src_W_Inp_P_D_List_Ev_,=,__CN(__CC14010)))=>__ECAST(KEL.typ.nstr,__CN(__CC14010)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11966181,LEFT.My_Date_Last_Seen_,__CN('|'))));
    SELF := __PP11965263;
  END;
  EXPORT __ENH_Phone_Summary := PROJECT(__EE11966294,__ND11965966__Project(LEFT));
END;
