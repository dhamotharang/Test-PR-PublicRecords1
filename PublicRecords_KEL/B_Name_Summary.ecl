//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Name_Summary_1,B_Name_Summary_3,B_Name_Summary_4,CFG_Compile,E_Address,E_Email,E_Geo_Link,E_Input_P_I_I,E_Person,E_Phone,E_Property,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Name_Summary(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Name_Summary_1(__in,__cfg).__ENH_Name_Summary_1) __ENH_Name_Summary_1 := B_Name_Summary_1(__in,__cfg).__ENH_Name_Summary_1;
  SHARED __EE8714357 := __ENH_Name_Summary_1;
  EXPORT __ST153007_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST153000_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(__ST153007_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Name_Summary_3(__in,__cfg).__ST76395_Layout) Name_Summary_Source_List_;
    KEL.typ.ndataset(B_Name_Summary_3(__in,__cfg).__ST76395_Layout) Name_Summary_Source_List_Sorted_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_D_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_D_Last_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_D_List_Ev_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST76346_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST153000_Layout __ND8714267__Project(B_Name_Summary_1(__in,__cfg).__ST184589_Layout __PP8714018) := TRANSFORM
    __EE8714360 := __PP8714018.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE8714360),__ST153007_Layout),__NL(__EE8714360));
    __CC13704 := '-99999';
    __CC13706 := '-99998';
    __EE8714260 := __PP8714018.Name_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_F_L_D_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP8714018.P___Inp_Cln_Name_First_,IN,__CN([__CC13704,__CC13706])),__OP2(__PP8714018.P___Inp_Cln_Name_Last_,IN,__CN([__CC13704,__CC13706]))),__OP2(__PP8714018.P___Inp_Cln_D_O_B_,IN,__CN([__CC13704,__CC13706]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13704)),__T(__OP2(__PP8714018.P_I___Src_W_Inp_F_L_D_List_Ev_,=,__CN(__CC13706)))=>__ECAST(KEL.typ.nstr,__CN(__CC13706)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE8714260,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE8714310 := __PP8714018.Name_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_F_L_D_Last_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP8714018.P___Inp_Cln_Name_First_,IN,__CN([__CC13704,__CC13706])),__OP2(__PP8714018.P___Inp_Cln_Name_Last_,IN,__CN([__CC13704,__CC13706]))),__OP2(__PP8714018.P___Inp_Cln_D_O_B_,IN,__CN([__CC13704,__CC13706]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13704)),__T(__OP2(__PP8714018.P_I___Src_W_Inp_F_L_D_List_Ev_,=,__CN(__CC13706)))=>__ECAST(KEL.typ.nstr,__CN(__CC13706)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE8714310,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    SELF := __PP8714018;
  END;
  EXPORT __ENH_Name_Summary := PROJECT(__EE8714357,__ND8714267__Project(LEFT));
END;
