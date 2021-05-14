//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_S_S_N_Summary_1,B_S_S_N_Summary_3,B_S_S_N_Summary_4,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_S_S_N_Summary(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_S_S_N_Summary_1(__in,__cfg).__ENH_S_S_N_Summary_1) __ENH_S_S_N_Summary_1 := B_S_S_N_Summary_1(__in,__cfg).__ENH_S_S_N_Summary_1;
  SHARED __EE3811112 := __ENH_S_S_N_Summary_1;
  EXPORT __ST156776_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(B_S_S_N_Summary_1(__in,__cfg).__ST163289_Layout) Address_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_1(__in,__cfg).__ST163298_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_1(__in,__cfg).__ST163306_Layout) Name_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_1(__in,__cfg).__ST163314_Layout) Phone_Summary_;
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
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST85356_Layout) S_S_N_Summary_Source_List_Sorted_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST156776_Layout __ND3810728__Project(B_S_S_N_Summary_1(__in,__cfg).__ST163285_Layout __PP3810113) := TRANSFORM
    __CC14078 := '-99999';
    __CC14080 := '-99998';
    __EE3810721 := __PP3810113.S_S_N_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_A_S_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP3810113.P___Inp_Cln_S_S_N_,IN,__CN([__CC14078,__CC14080])),__OP2(__PP3810113.P___Inp_Cln_Primary_Range_,IN,__CN([__CC14078,__CC14080]))),__OP2(__PP3810113.P___Inp_Cln_Primary_Name_,IN,__CN([__CC14078,__CC14080]))),__OP2(__PP3810113.P___Inp_Cln_Zip_,IN,__CN([__CC14078,__CC14080]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14078)),__T(__OP2(__PP3810113.P_I___Src_W_Inp_A_S_List_Ev_,=,__CN(__CC14080)))=>__ECAST(KEL.typ.nstr,__CN(__CC14080)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3810721,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE3810779 := __PP3810113.S_S_N_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_A_S_Last_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP3810113.P___Inp_Cln_S_S_N_,IN,__CN([__CC14078,__CC14080])),__OP2(__PP3810113.P___Inp_Cln_Primary_Range_,IN,__CN([__CC14078,__CC14080]))),__OP2(__PP3810113.P___Inp_Cln_Primary_Name_,IN,__CN([__CC14078,__CC14080]))),__OP2(__PP3810113.P___Inp_Cln_Zip_,IN,__CN([__CC14078,__CC14080]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14078)),__T(__OP2(__PP3810113.P_I___Src_W_Inp_A_S_List_Ev_,=,__CN(__CC14080)))=>__ECAST(KEL.typ.nstr,__CN(__CC14080)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3810779,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    __EE3810829 := __PP3810113.Sorted_Fn_Ln_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_F_L_S_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP3810113.P___Inp_Cln_S_S_N_,IN,__CN([__CC14078,__CC14080])),__OP2(__PP3810113.P___Inp_Cln_Name_First_,IN,__CN([__CC14078,__CC14080]))),__OP2(__PP3810113.P___Inp_Cln_Name_Last_,IN,__CN([__CC14078,__CC14080]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14078)),__T(__OP2(__PP3810113.P_I___Src_W_Inp_F_L_S_List_Ev_,=,__CN(__CC14080)))=>__ECAST(KEL.typ.nstr,__CN(__CC14080)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3810829,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE3810877 := __PP3810113.Sorted_Fn_Ln_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_F_L_S_Last_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP3810113.P___Inp_Cln_S_S_N_,IN,__CN([__CC14078,__CC14080])),__OP2(__PP3810113.P___Inp_Cln_Name_First_,IN,__CN([__CC14078,__CC14080]))),__OP2(__PP3810113.P___Inp_Cln_Name_Last_,IN,__CN([__CC14078,__CC14080]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14078)),__T(__OP2(__PP3810113.P_I___Src_W_Inp_F_L_S_List_Ev_,=,__CN(__CC14080)))=>__ECAST(KEL.typ.nstr,__CN(__CC14080)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3810877,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    __EE3810919 := __PP3810113.Phone_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_P_S_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP3810113.P___Inp_Cln_S_S_N_,IN,__CN([__CC14078,__CC14080])),__OP2(__PP3810113.P___Inp_Cln_Phone_Home_,IN,__CN([__CC14078,__CC14080]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14078)),__T(__OP2(__PP3810113.P_I___Src_W_Inp_P_S_List_Ev_,=,__CN(__CC14080)))=>__ECAST(KEL.typ.nstr,__CN(__CC14080)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3810919,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE3810959 := __PP3810113.Phone_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_P_S_Last_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP3810113.P___Inp_Cln_S_S_N_,IN,__CN([__CC14078,__CC14080])),__OP2(__PP3810113.P___Inp_Cln_Phone_Home_,IN,__CN([__CC14078,__CC14080]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14078)),__T(__OP2(__PP3810113.P_I___Src_W_Inp_P_S_List_Ev_,=,__CN(__CC14080)))=>__ECAST(KEL.typ.nstr,__CN(__CC14080)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3810959,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    __EE3811001 := __PP3810113.Sorted_D_O_B_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_S_D_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP3810113.P___Inp_Cln_S_S_N_,IN,__CN([__CC14078,__CC14080])),__OP2(__PP3810113.P___Inp_Cln_D_O_B_,IN,__CN([__CC14078,__CC14080]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14078)),__T(__OP2(__PP3810113.P_I___Src_W_Inp_S_D_List_Ev_,=,__CN(__CC14080)))=>__ECAST(KEL.typ.nstr,__CN(__CC14080)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3811001,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE3811041 := __PP3810113.Sorted_D_O_B_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_S_D_Last_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP3810113.P___Inp_Cln_S_S_N_,IN,__CN([__CC14078,__CC14080])),__OP2(__PP3810113.P___Inp_Cln_D_O_B_,IN,__CN([__CC14078,__CC14080]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14078)),__T(__OP2(__PP3810113.P_I___Src_W_Inp_S_D_List_Ev_,=,__CN(__CC14080)))=>__ECAST(KEL.typ.nstr,__CN(__CC14080)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3811041,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    SELF := __PP3810113;
  END;
  EXPORT __ENH_S_S_N_Summary := PROJECT(__EE3811112,__ND3810728__Project(LEFT));
END;
