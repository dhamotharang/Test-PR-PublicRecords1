//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Name_Summary_2,B_Name_Summary_3,B_Name_Summary_4,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Name_Summary_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Name_Summary_2(__in,__cfg).__ENH_Name_Summary_2) __ENH_Name_Summary_2 := B_Name_Summary_2(__in,__cfg).__ENH_Name_Summary_2;
  SHARED __EE8440285 := __ENH_Name_Summary_2;
  EXPORT __ST193108_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST193100_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(__ST193108_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Name_Summary_3(__in,__cfg).__ST81042_Layout) Name_Summary_Source_List_;
    KEL.typ.ndataset(B_Name_Summary_3(__in,__cfg).__ST81042_Layout) Name_Summary_Source_List_Sorted_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_D_List_Ev_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST80993_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST193100_Layout __ND8440246__Project(B_Name_Summary_2(__in,__cfg).__ST215996_Layout __PP8440041) := TRANSFORM
    __EE8440288 := __PP8440041.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE8440288),__ST193108_Layout),__NL(__EE8440288));
    __CC13975 := '-99999';
    __CC13977 := '-99998';
    __EE8440239 := __PP8440041.Name_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_F_L_D_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP8440041.P___Inp_Cln_Name_First_,IN,__CN([__CC13975,__CC13977])),__OP2(__PP8440041.P___Inp_Cln_Name_Last_,IN,__CN([__CC13975,__CC13977]))),__OP2(__PP8440041.P___Inp_Cln_D_O_B_,IN,__CN([__CC13975,__CC13977]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13975)),__T(__NOT(__CN(EXISTS(__T(__PP8440041.Name_Summary_Source_List_Sorted_)))))=>__ECAST(KEL.typ.nstr,__CN(__CC13977)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE8440239,LEFT.Translated_Source_Code_,__CN('|'))));
    SELF := __PP8440041;
  END;
  EXPORT __ENH_Name_Summary_1 := PROJECT(__EE8440285,__ND8440246__Project(LEFT));
END;
