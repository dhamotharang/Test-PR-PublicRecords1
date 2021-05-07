//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Name_Summary_2,B_Name_Summary_3,B_Name_Summary_4,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Name_Summary_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Name_Summary_2(__in,__cfg).__ENH_Name_Summary_2) __ENH_Name_Summary_2 := B_Name_Summary_2(__in,__cfg).__ENH_Name_Summary_2;
  SHARED __EE2552612 := __ENH_Name_Summary_2;
  EXPORT __ST152825_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST152817_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(__ST152825_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Name_Summary_3(__in,__cfg).__ST82942_Layout) Name_Summary_Source_List_Sorted_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_D_List_Ev_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST152817_Layout __ND2552584__Project(B_Name_Summary_2(__in,__cfg).__ST160240_Layout __PP2552414) := TRANSFORM
    __EE2552615 := __PP2552414.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE2552615),__ST152825_Layout),__NL(__EE2552615));
    __CC14111 := '-99999';
    __CC14113 := '-99998';
    __EE2552577 := __PP2552414.Name_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_F_L_D_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP2552414.P___Inp_Cln_Name_First_,IN,__CN([__CC14111,__CC14113])),__OP2(__PP2552414.P___Inp_Cln_Name_Last_,IN,__CN([__CC14111,__CC14113]))),__OP2(__PP2552414.P___Inp_Cln_D_O_B_,IN,__CN([__CC14111,__CC14113]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14111)),__T(__NOT(__CN(EXISTS(__T(__PP2552414.Name_Summary_Source_List_Sorted_)))))=>__ECAST(KEL.typ.nstr,__CN(__CC14113)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE2552577,LEFT.Translated_Source_Code_,__CN('|'))));
    SELF := __PP2552414;
  END;
  EXPORT __ENH_Name_Summary_1 := PROJECT(__EE2552612,__ND2552584__Project(LEFT));
END;
