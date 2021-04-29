//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Name_Summary_1,B_Name_Summary_3,B_Name_Summary_4,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Name_Summary(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Name_Summary_1(__in,__cfg).__ENH_Name_Summary_1) __ENH_Name_Summary_1 := B_Name_Summary_1(__in,__cfg).__ENH_Name_Summary_1;
  SHARED __EE6491913 := __ENH_Name_Summary_1;
  EXPORT __ST136846_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(B_Name_Summary_1(__in,__cfg).__ST159940_Layout) Data_Sources_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_D_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_D_Last_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_D_List_Ev_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST136846_Layout __ND6491844__Project(B_Name_Summary_1(__in,__cfg).__ST159932_Layout __PP6491666) := TRANSFORM
    __CC14003 := '-99999';
    __CC14005 := '-99998';
    __EE6491837 := __PP6491666.Name_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_F_L_D_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP6491666.P___Inp_Cln_Name_First_,IN,__CN([__CC14003,__CC14005])),__OP2(__PP6491666.P___Inp_Cln_Name_Last_,IN,__CN([__CC14003,__CC14005]))),__OP2(__PP6491666.P___Inp_Cln_D_O_B_,IN,__CN([__CC14003,__CC14005]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14003)),__T(__OP2(__PP6491666.P_I___Src_W_Inp_F_L_D_List_Ev_,=,__CN(__CC14005)))=>__ECAST(KEL.typ.nstr,__CN(__CC14005)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE6491837,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE6491887 := __PP6491666.Name_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_F_L_D_Last_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP6491666.P___Inp_Cln_Name_First_,IN,__CN([__CC14003,__CC14005])),__OP2(__PP6491666.P___Inp_Cln_Name_Last_,IN,__CN([__CC14003,__CC14005]))),__OP2(__PP6491666.P___Inp_Cln_D_O_B_,IN,__CN([__CC14003,__CC14005]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14003)),__T(__OP2(__PP6491666.P_I___Src_W_Inp_F_L_D_List_Ev_,=,__CN(__CC14005)))=>__ECAST(KEL.typ.nstr,__CN(__CC14005)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE6491887,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    SELF := __PP6491666;
  END;
  EXPORT __ENH_Name_Summary := PROJECT(__EE6491913,__ND6491844__Project(LEFT));
END;
