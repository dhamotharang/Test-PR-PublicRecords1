﻿//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Phone_Summary_1,B_Phone_Summary_2,B_Phone_Summary_5,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Phone_Summary(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Phone_Summary_1(__in,__cfg).__ENH_Phone_Summary_1) __ENH_Phone_Summary_1 := B_Phone_Summary_1(__in,__cfg).__ENH_Phone_Summary_1;
  SHARED __EE3835762 := __ENH_Phone_Summary_1;
  EXPORT __ST161498_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST183485_Layout) Address_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST183495_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(B_Phone_Summary_5(__in,__cfg).__ST183511_Layout) Last_Name_Summary_;
    KEL.typ.nstr P_I___Src_W_Inp_A_P_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_A_P_Last_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_A_P_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_L_P_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_L_P_Last_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_L_P_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_P_D_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_P_D_Last_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_P_D_List_Ev_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST161498_Layout __ND3835379__Project(B_Phone_Summary_1(__in,__cfg).__ST167837_Layout __PP3834780) := TRANSFORM
    __CC14282 := '-99999';
    __CC14287 := '-99998';
    __EE3835372 := __PP3834780.Sorted_Address_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_A_P_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP3834780.P___Inp_Cln_Phone_Home_,IN,__CN([__CC14282,__CC14287])),__OP2(__PP3834780.P___Inp_Cln_Addr_Prim_Name_,IN,__CN([__CC14282,__CC14287]))),__OP2(__PP3834780.P___Inp_Cln_Addr_Prim_Rng_,IN,__CN([__CC14282,__CC14287]))),__OP2(__PP3834780.P___Inp_Cln_Addr_Zip5_,IN,__CN([__CC14282,__CC14287]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14282)),__PP3834780.Src_W_Inp_A_P_List_No_Data_=>__ECAST(KEL.typ.nstr,__CN(__CC14287)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3835372,LEFT.My_Date_First_Seen_,__CN('|'))));
    __EE3835427 := __PP3834780.Sorted_Address_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_A_P_Last_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP3834780.P___Inp_Cln_Phone_Home_,IN,__CN([__CC14282,__CC14287])),__OP2(__PP3834780.P___Inp_Cln_Addr_Prim_Name_,IN,__CN([__CC14282,__CC14287]))),__OP2(__PP3834780.P___Inp_Cln_Addr_Prim_Rng_,IN,__CN([__CC14282,__CC14287]))),__OP2(__PP3834780.P___Inp_Cln_Addr_Zip5_,IN,__CN([__CC14282,__CC14287]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14282)),__PP3834780.Src_W_Inp_A_P_List_No_Data_=>__ECAST(KEL.typ.nstr,__CN(__CC14287)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3835427,LEFT.My_Date_Last_Seen_,__CN('|'))));
    __EE3835480 := __PP3834780.Sorted_Address_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_A_P_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP3834780.P___Inp_Cln_Phone_Home_,IN,__CN([__CC14282,__CC14287])),__OP2(__PP3834780.P___Inp_Cln_Addr_Prim_Name_,IN,__CN([__CC14282,__CC14287]))),__OP2(__PP3834780.P___Inp_Cln_Addr_Prim_Rng_,IN,__CN([__CC14282,__CC14287]))),__OP2(__PP3834780.P___Inp_Cln_Addr_Zip5_,IN,__CN([__CC14282,__CC14287]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14282)),__PP3834780.Src_W_Inp_A_P_List_No_Data_=>__ECAST(KEL.typ.nstr,__CN(__CC14287)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3835480,LEFT.Source_,__CN('|'))));
    __EE3835517 := __PP3834780.Sorted_Last_Name_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_L_P_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP3834780.P___Inp_Cln_Phone_Home_,IN,__CN([__CC14282,__CC14287])),__OP2(__PP3834780.P___Inp_Cln_Name_Last_,IN,__CN([__CC14282,__CC14287]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14282)),__PP3834780.Src_W_Inp_L_P_List_No_Date_=>__ECAST(KEL.typ.nstr,__CN(__CC14287)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3835517,LEFT.My_Date_First_Seen_,__CN('|'))));
    __EE3835554 := __PP3834780.Sorted_Last_Name_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_L_P_Last_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP3834780.P___Inp_Cln_Phone_Home_,IN,__CN([__CC14282,__CC14287])),__OP2(__PP3834780.P___Inp_Cln_Name_Last_,IN,__CN([__CC14282,__CC14287]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14282)),__PP3834780.Src_W_Inp_L_P_List_No_Date_=>__ECAST(KEL.typ.nstr,__CN(__CC14287)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3835554,LEFT.My_Date_Last_Seen_,__CN('|'))));
    __EE3835591 := __PP3834780.Sorted_Last_Name_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_L_P_List_Ev_ := MAP(__T(__OR(__OP2(__PP3834780.P___Inp_Cln_Phone_Home_,IN,__CN([__CC14282,__CC14287])),__OP2(__PP3834780.P___Inp_Cln_Name_Last_,IN,__CN([__CC14282,__CC14287]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14282)),__PP3834780.Src_W_Inp_L_P_List_No_Date_=>__ECAST(KEL.typ.nstr,__CN(__CC14287)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3835591,LEFT.Source_,__CN('|'))));
    __EE3835628 := __PP3834780.Sorted_D_O_B_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_P_D_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP3834780.P___Inp_Cln_Phone_Home_,IN,__CN([__CC14282,__CC14287])),__OP2(__PP3834780.P___Inp_Cln_D_O_B_,IN,__CN([__CC14282,__CC14287]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14282)),__PP3834780.Src_W_Inp_P_D_List_No_Date_=>__ECAST(KEL.typ.nstr,__CN(__CC14287)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3835628,LEFT.My_Date_First_Seen_,__CN('|'))));
    __EE3835665 := __PP3834780.Sorted_D_O_B_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_P_D_Last_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP3834780.P___Inp_Cln_Phone_Home_,IN,__CN([__CC14282,__CC14287])),__OP2(__PP3834780.P___Inp_Cln_D_O_B_,IN,__CN([__CC14282,__CC14287]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14282)),__PP3834780.Src_W_Inp_P_D_List_No_Date_=>__ECAST(KEL.typ.nstr,__CN(__CC14287)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3835665,LEFT.My_Date_Last_Seen_,__CN('|'))));
    __EE3835702 := __PP3834780.Sorted_D_O_B_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_P_D_List_Ev_ := MAP(__T(__OR(__OP2(__PP3834780.P___Inp_Cln_Phone_Home_,IN,__CN([__CC14282,__CC14287])),__OP2(__PP3834780.P___Inp_Cln_D_O_B_,IN,__CN([__CC14282,__CC14287]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14282)),__PP3834780.Src_W_Inp_P_D_List_No_Date_=>__ECAST(KEL.typ.nstr,__CN(__CC14287)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3835702,LEFT.Source_,__CN('|'))));
    SELF := __PP3834780;
  END;
  EXPORT __ENH_Phone_Summary := PROJECT(__EE3835762,__ND3835379__Project(LEFT));
END;
