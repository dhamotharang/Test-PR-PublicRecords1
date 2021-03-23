//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_S_S_N_Summary_2,B_S_S_N_Summary_3,B_S_S_N_Summary_4,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_S_S_N_Summary_2(__in,__cfg).__ENH_S_S_N_Summary_2) __ENH_S_S_N_Summary_2 := B_S_S_N_Summary_2(__in,__cfg).__ENH_S_S_N_Summary_2;
  SHARED __EE9385564 := __ENH_S_S_N_Summary_2;
  EXPORT __ST205300_Layout := RECORD
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
  EXPORT __ST205309_Layout := RECORD
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
  EXPORT __ST205317_Layout := RECORD
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
  EXPORT __ST205325_Layout := RECORD
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
  EXPORT __ST205296_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST205300_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST205309_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST205317_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST205325_Layout) Phone_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P_I___Src_W_Inp_A_S_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_S_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_P_S_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_S_D_List_Ev_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.nstr P___Inp_Cln_Primary_Name_;
    KEL.typ.nstr P___Inp_Cln_Primary_Range_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.nstr P___Inp_Cln_Zip_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81449_Layout) Phone_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81449_Layout) Phone_Summary_Source_List_Sorted_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST81411_Layout) Phone_Translated_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81113_Layout) S_S_N_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81113_Layout) S_S_N_Summary_Source_List_Sorted_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81313_Layout) Sorted_D_O_B_Translated_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81593_Layout) Sorted_Fn_Ln_Translated_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST81276_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81313_Layout) Translated_D_O_B_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST81554_Layout) Translated_Fn_Ln_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST81593_Layout) Translated_Fn_Ln_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST81059_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST205296_Layout __ND9385295__Project(B_S_S_N_Summary_2(__in,__cfg).__ST224430_Layout __PP9384565) := TRANSFORM
    __EE9385567 := __PP9384565.Address_Summary_;
    SELF.Address_Summary_ := __BN(PROJECT(__T(__EE9385567),__ST205300_Layout),__NL(__EE9385567));
    __EE9385570 := __PP9384565.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE9385570),__ST205309_Layout),__NL(__EE9385570));
    __EE9385573 := __PP9384565.Name_Summary_;
    SELF.Name_Summary_ := __BN(PROJECT(__T(__EE9385573),__ST205317_Layout),__NL(__EE9385573));
    __EE9385576 := __PP9384565.Phone_Summary_;
    SELF.Phone_Summary_ := __BN(PROJECT(__T(__EE9385576),__ST205325_Layout),__NL(__EE9385576));
    __CC13981 := '-99999';
    __CC13983 := '-99998';
    __EE9385288 := __PP9384565.S_S_N_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_A_S_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP9384565.P___Inp_Cln_S_S_N_,IN,__CN([__CC13981,__CC13983])),__OP2(__PP9384565.P___Inp_Cln_Primary_Range_,IN,__CN([__CC13981,__CC13983]))),__OP2(__PP9384565.P___Inp_Cln_Primary_Name_,IN,__CN([__CC13981,__CC13983]))),__OP2(__PP9384565.P___Inp_Cln_Zip_,IN,__CN([__CC13981,__CC13983]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13981)),__T(__NOT(__CN(EXISTS(__T(__PP9384565.S_S_N_Summary_Source_List_Sorted_)))))=>__ECAST(KEL.typ.nstr,__CN(__CC13983)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE9385288,LEFT.Translated_Source_Code_,__CN('|'))));
    __EE9385339 := __PP9384565.Sorted_Fn_Ln_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_F_L_S_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP9384565.P___Inp_Cln_S_S_N_,IN,__CN([__CC13981,__CC13983])),__OP2(__PP9384565.P___Inp_Cln_Name_First_,IN,__CN([__CC13981,__CC13983]))),__OP2(__PP9384565.P___Inp_Cln_Name_Last_,IN,__CN([__CC13981,__CC13983]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13981)),__T(__NOT(__CN(EXISTS(__T(__PP9384565.Sorted_Fn_Ln_Translated_Source_List_)))))=>__ECAST(KEL.typ.nstr,__CN(__CC13983)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE9385339,LEFT.Translated_Source_Code_,__CN('|'))));
    __EE9385380 := __PP9384565.Phone_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_P_S_List_Ev_ := MAP(__T(__OR(__OP2(__PP9384565.P___Inp_Cln_S_S_N_,IN,__CN([__CC13981,__CC13983])),__OP2(__PP9384565.P___Inp_Cln_Phone_Home_,IN,__CN([__CC13981,__CC13983]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13981)),__T(__NOT(__CN(EXISTS(__T(__PP9384565.Phone_Summary_Source_List_Sorted_)))))=>__ECAST(KEL.typ.nstr,__CN(__CC13983)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE9385380,LEFT.Phone_Translated_Source_Code_,__CN('|'))));
    __EE9385421 := __PP9384565.Sorted_D_O_B_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_S_D_List_Ev_ := MAP(__T(__OR(__OP2(__PP9384565.P___Inp_Cln_S_S_N_,IN,__CN([__CC13981,__CC13983])),__OP2(__PP9384565.P___Inp_Cln_D_O_B_,IN,__CN([__CC13981,__CC13983]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13981)),__T(__NOT(__CN(EXISTS(__T(__PP9384565.Sorted_D_O_B_Translated_Source_List_)))))=>__ECAST(KEL.typ.nstr,__CN(__CC13983)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE9385421,LEFT.Translated_Source_Code_,__CN('|'))));
    SELF := __PP9384565;
  END;
  EXPORT __ENH_S_S_N_Summary_1 := PROJECT(__EE9385564,__ND9385295__Project(LEFT));
END;
