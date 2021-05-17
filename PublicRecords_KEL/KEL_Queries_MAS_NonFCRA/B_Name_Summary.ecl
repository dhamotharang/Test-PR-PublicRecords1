//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Name_Summary_1,B_Name_Summary_3,B_Name_Summary_4,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Name_Summary(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Name_Summary_1(__in,__cfg).__ENH_Name_Summary_1) __ENH_Name_Summary_1 := B_Name_Summary_1(__in,__cfg).__ENH_Name_Summary_1;
  SHARED __EE3280453 := __ENH_Name_Summary_1;
  EXPORT __ST147647_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(B_Name_Summary_1(__in,__cfg).__ST156962_Layout) Data_Sources_;
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
  SHARED __ST147647_Layout __ND3280384__Project(B_Name_Summary_1(__in,__cfg).__ST156954_Layout __PP3280206) := TRANSFORM
    __CC14066 := '-99999';
    __CC14068 := '-99998';
    __EE3280377 := __PP3280206.Name_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_F_L_D_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP3280206.P___Inp_Cln_Name_First_,IN,__CN([__CC14066,__CC14068])),__OP2(__PP3280206.P___Inp_Cln_Name_Last_,IN,__CN([__CC14066,__CC14068]))),__OP2(__PP3280206.P___Inp_Cln_D_O_B_,IN,__CN([__CC14066,__CC14068]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14066)),__T(__OP2(__PP3280206.P_I___Src_W_Inp_F_L_D_List_Ev_,=,__CN(__CC14068)))=>__ECAST(KEL.typ.nstr,__CN(__CC14068)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3280377,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE3280427 := __PP3280206.Name_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_F_L_D_Last_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP3280206.P___Inp_Cln_Name_First_,IN,__CN([__CC14066,__CC14068])),__OP2(__PP3280206.P___Inp_Cln_Name_Last_,IN,__CN([__CC14066,__CC14068]))),__OP2(__PP3280206.P___Inp_Cln_D_O_B_,IN,__CN([__CC14066,__CC14068]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14066)),__T(__OP2(__PP3280206.P_I___Src_W_Inp_F_L_D_List_Ev_,=,__CN(__CC14068)))=>__ECAST(KEL.typ.nstr,__CN(__CC14068)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3280427,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    SELF := __PP3280206;
  END;
  EXPORT __ENH_Name_Summary := PROJECT(__EE3280453,__ND3280384__Project(LEFT));
END;
