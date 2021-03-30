//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_S_S_N_Summary_1,B_S_S_N_Summary_3,B_S_S_N_Summary_4,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_S_S_N_Summary_1(__in,__cfg).__ENH_S_S_N_Summary_1) __ENH_S_S_N_Summary_1 := B_S_S_N_Summary_1(__in,__cfg).__ENH_S_S_N_Summary_1;
  SHARED __EE11952907 := __ENH_S_S_N_Summary_1;
  EXPORT __ST181119_Layout := RECORD
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
  EXPORT __ST181128_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
    KEL.typ.nstr Dob_Date_Of_Birth_Padded_;
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
  EXPORT __ST181136_Layout := RECORD
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
  EXPORT __ST181144_Layout := RECORD
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
  EXPORT __ST181115_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST181119_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST181128_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST181136_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST181144_Layout) Phone_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P_I___Src_W_Inp_A_S_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_A_S_Last_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_A_S_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_S_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_S_Last_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_S_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_P_S_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_P_S_Last_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_P_S_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_S_D_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_S_D_Last_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_S_D_List_Ev_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.nstr P___Inp_Cln_Primary_Name_;
    KEL.typ.nstr P___Inp_Cln_Primary_Range_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.nstr P___Inp_Cln_Zip_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST82464_Layout) Phone_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST82464_Layout) Phone_Summary_Source_List_Sorted_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST82426_Layout) Phone_Translated_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST82128_Layout) S_S_N_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST82128_Layout) S_S_N_Summary_Source_List_Sorted_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST82328_Layout) Sorted_D_O_B_Translated_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST82608_Layout) Sorted_Fn_Ln_Translated_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST82291_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST82328_Layout) Translated_D_O_B_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST82569_Layout) Translated_Fn_Ln_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST82608_Layout) Translated_Fn_Ln_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST82074_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST181115_Layout __ND11952441__Project(B_S_S_N_Summary_1(__in,__cfg).__ST208360_Layout __PP11951511) := TRANSFORM
    __EE11952910 := __PP11951511.Address_Summary_;
    SELF.Address_Summary_ := __BN(PROJECT(__T(__EE11952910),__ST181119_Layout),__NL(__EE11952910));
    __EE11952913 := __PP11951511.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE11952913),__ST181128_Layout),__NL(__EE11952913));
    __EE11952916 := __PP11951511.Name_Summary_;
    SELF.Name_Summary_ := __BN(PROJECT(__T(__EE11952916),__ST181136_Layout),__NL(__EE11952916));
    __EE11952919 := __PP11951511.Phone_Summary_;
    SELF.Phone_Summary_ := __BN(PROJECT(__T(__EE11952919),__ST181144_Layout),__NL(__EE11952919));
    __CC13944 := '-99999';
    __CC13946 := '-99998';
    __EE11952434 := __PP11951511.S_S_N_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_A_S_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP11951511.P___Inp_Cln_S_S_N_,IN,__CN([__CC13944,__CC13946])),__OP2(__PP11951511.P___Inp_Cln_Primary_Range_,IN,__CN([__CC13944,__CC13946]))),__OP2(__PP11951511.P___Inp_Cln_Primary_Name_,IN,__CN([__CC13944,__CC13946]))),__OP2(__PP11951511.P___Inp_Cln_Zip_,IN,__CN([__CC13944,__CC13946]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13944)),__T(__OP2(__PP11951511.P_I___Src_W_Inp_A_S_List_Ev_,=,__CN(__CC13946)))=>__ECAST(KEL.typ.nstr,__CN(__CC13946)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11952434,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE11952492 := __PP11951511.S_S_N_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_A_S_Last_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP11951511.P___Inp_Cln_S_S_N_,IN,__CN([__CC13944,__CC13946])),__OP2(__PP11951511.P___Inp_Cln_Primary_Range_,IN,__CN([__CC13944,__CC13946]))),__OP2(__PP11951511.P___Inp_Cln_Primary_Name_,IN,__CN([__CC13944,__CC13946]))),__OP2(__PP11951511.P___Inp_Cln_Zip_,IN,__CN([__CC13944,__CC13946]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13944)),__T(__OP2(__PP11951511.P_I___Src_W_Inp_A_S_List_Ev_,=,__CN(__CC13946)))=>__ECAST(KEL.typ.nstr,__CN(__CC13946)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11952492,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    __EE11952542 := __PP11951511.Sorted_Fn_Ln_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_F_L_S_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP11951511.P___Inp_Cln_S_S_N_,IN,__CN([__CC13944,__CC13946])),__OP2(__PP11951511.P___Inp_Cln_Name_First_,IN,__CN([__CC13944,__CC13946]))),__OP2(__PP11951511.P___Inp_Cln_Name_Last_,IN,__CN([__CC13944,__CC13946]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13944)),__T(__OP2(__PP11951511.P_I___Src_W_Inp_F_L_S_List_Ev_,=,__CN(__CC13946)))=>__ECAST(KEL.typ.nstr,__CN(__CC13946)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11952542,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE11952590 := __PP11951511.Sorted_Fn_Ln_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_F_L_S_Last_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP11951511.P___Inp_Cln_S_S_N_,IN,__CN([__CC13944,__CC13946])),__OP2(__PP11951511.P___Inp_Cln_Name_First_,IN,__CN([__CC13944,__CC13946]))),__OP2(__PP11951511.P___Inp_Cln_Name_Last_,IN,__CN([__CC13944,__CC13946]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13944)),__T(__OP2(__PP11951511.P_I___Src_W_Inp_F_L_S_List_Ev_,=,__CN(__CC13946)))=>__ECAST(KEL.typ.nstr,__CN(__CC13946)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11952590,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    __EE11952632 := __PP11951511.Phone_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_P_S_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP11951511.P___Inp_Cln_S_S_N_,IN,__CN([__CC13944,__CC13946])),__OP2(__PP11951511.P___Inp_Cln_Phone_Home_,IN,__CN([__CC13944,__CC13946]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13944)),__T(__OP2(__PP11951511.P_I___Src_W_Inp_P_S_List_Ev_,=,__CN(__CC13946)))=>__ECAST(KEL.typ.nstr,__CN(__CC13946)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11952632,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE11952672 := __PP11951511.Phone_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_P_S_Last_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP11951511.P___Inp_Cln_S_S_N_,IN,__CN([__CC13944,__CC13946])),__OP2(__PP11951511.P___Inp_Cln_Phone_Home_,IN,__CN([__CC13944,__CC13946]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13944)),__T(__OP2(__PP11951511.P_I___Src_W_Inp_P_S_List_Ev_,=,__CN(__CC13946)))=>__ECAST(KEL.typ.nstr,__CN(__CC13946)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11952672,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    __EE11952714 := __PP11951511.Sorted_D_O_B_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_S_D_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP11951511.P___Inp_Cln_S_S_N_,IN,__CN([__CC13944,__CC13946])),__OP2(__PP11951511.P___Inp_Cln_D_O_B_,IN,__CN([__CC13944,__CC13946]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13944)),__T(__OP2(__PP11951511.P_I___Src_W_Inp_S_D_List_Ev_,=,__CN(__CC13946)))=>__ECAST(KEL.typ.nstr,__CN(__CC13946)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11952714,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE11952754 := __PP11951511.Sorted_D_O_B_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_S_D_Last_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP11951511.P___Inp_Cln_S_S_N_,IN,__CN([__CC13944,__CC13946])),__OP2(__PP11951511.P___Inp_Cln_D_O_B_,IN,__CN([__CC13944,__CC13946]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13944)),__T(__OP2(__PP11951511.P_I___Src_W_Inp_S_D_List_Ev_,=,__CN(__CC13946)))=>__ECAST(KEL.typ.nstr,__CN(__CC13946)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11952754,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    SELF := __PP11951511;
  END;
  EXPORT __ENH_S_S_N_Summary := PROJECT(__EE11952907,__ND11952441__Project(LEFT));
END;
