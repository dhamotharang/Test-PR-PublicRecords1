﻿//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_S_S_N_Summary_1,B_S_S_N_Summary_3,B_S_S_N_Summary_4,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_S_S_N_Summary(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_S_S_N_Summary_1(__in,__cfg).__ENH_S_S_N_Summary_1) __ENH_S_S_N_Summary_1 := B_S_S_N_Summary_1(__in,__cfg).__ENH_S_S_N_Summary_1;
  SHARED __EE4005662 := __ENH_S_S_N_Summary_1;
  EXPORT __ST151934_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(B_S_S_N_Summary_1(__in,__cfg).__ST158901_Layout) Address_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_1(__in,__cfg).__ST158910_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_1(__in,__cfg).__ST158918_Layout) Name_Summary_;
    KEL.typ.ndataset(B_S_S_N_Summary_1(__in,__cfg).__ST158926_Layout) Phone_Summary_;
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
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST82254_Layout) S_S_N_Summary_Source_List_Sorted_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST151934_Layout __ND4005278__Project(B_S_S_N_Summary_1(__in,__cfg).__ST158897_Layout __PP4004663) := TRANSFORM
    __CC14250 := '-99999';
    __CC14252 := '-99998';
    __EE4005271 := __PP4004663.S_S_N_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_A_S_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP4004663.P___Inp_Cln_S_S_N_,IN,__CN([__CC14250,__CC14252])),__OP2(__PP4004663.P___Inp_Cln_Primary_Range_,IN,__CN([__CC14250,__CC14252]))),__OP2(__PP4004663.P___Inp_Cln_Primary_Name_,IN,__CN([__CC14250,__CC14252]))),__OP2(__PP4004663.P___Inp_Cln_Zip_,IN,__CN([__CC14250,__CC14252]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14250)),__T(__OP2(__PP4004663.P_I___Src_W_Inp_A_S_List_Ev_,=,__CN(__CC14252)))=>__ECAST(KEL.typ.nstr,__CN(__CC14252)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE4005271,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE4005329 := __PP4004663.S_S_N_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_A_S_Last_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP4004663.P___Inp_Cln_S_S_N_,IN,__CN([__CC14250,__CC14252])),__OP2(__PP4004663.P___Inp_Cln_Primary_Range_,IN,__CN([__CC14250,__CC14252]))),__OP2(__PP4004663.P___Inp_Cln_Primary_Name_,IN,__CN([__CC14250,__CC14252]))),__OP2(__PP4004663.P___Inp_Cln_Zip_,IN,__CN([__CC14250,__CC14252]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14250)),__T(__OP2(__PP4004663.P_I___Src_W_Inp_A_S_List_Ev_,=,__CN(__CC14252)))=>__ECAST(KEL.typ.nstr,__CN(__CC14252)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE4005329,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    __EE4005379 := __PP4004663.Sorted_Fn_Ln_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_F_L_S_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP4004663.P___Inp_Cln_S_S_N_,IN,__CN([__CC14250,__CC14252])),__OP2(__PP4004663.P___Inp_Cln_Name_First_,IN,__CN([__CC14250,__CC14252]))),__OP2(__PP4004663.P___Inp_Cln_Name_Last_,IN,__CN([__CC14250,__CC14252]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14250)),__T(__OP2(__PP4004663.P_I___Src_W_Inp_F_L_S_List_Ev_,=,__CN(__CC14252)))=>__ECAST(KEL.typ.nstr,__CN(__CC14252)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE4005379,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE4005427 := __PP4004663.Sorted_Fn_Ln_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_F_L_S_Last_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP4004663.P___Inp_Cln_S_S_N_,IN,__CN([__CC14250,__CC14252])),__OP2(__PP4004663.P___Inp_Cln_Name_First_,IN,__CN([__CC14250,__CC14252]))),__OP2(__PP4004663.P___Inp_Cln_Name_Last_,IN,__CN([__CC14250,__CC14252]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14250)),__T(__OP2(__PP4004663.P_I___Src_W_Inp_F_L_S_List_Ev_,=,__CN(__CC14252)))=>__ECAST(KEL.typ.nstr,__CN(__CC14252)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE4005427,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    __EE4005469 := __PP4004663.Phone_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_P_S_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP4004663.P___Inp_Cln_S_S_N_,IN,__CN([__CC14250,__CC14252])),__OP2(__PP4004663.P___Inp_Cln_Phone_Home_,IN,__CN([__CC14250,__CC14252]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14250)),__T(__OP2(__PP4004663.P_I___Src_W_Inp_P_S_List_Ev_,=,__CN(__CC14252)))=>__ECAST(KEL.typ.nstr,__CN(__CC14252)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE4005469,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE4005509 := __PP4004663.Phone_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_P_S_Last_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP4004663.P___Inp_Cln_S_S_N_,IN,__CN([__CC14250,__CC14252])),__OP2(__PP4004663.P___Inp_Cln_Phone_Home_,IN,__CN([__CC14250,__CC14252]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14250)),__T(__OP2(__PP4004663.P_I___Src_W_Inp_P_S_List_Ev_,=,__CN(__CC14252)))=>__ECAST(KEL.typ.nstr,__CN(__CC14252)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE4005509,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    __EE4005551 := __PP4004663.Sorted_D_O_B_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_S_D_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP4004663.P___Inp_Cln_S_S_N_,IN,__CN([__CC14250,__CC14252])),__OP2(__PP4004663.P___Inp_Cln_D_O_B_,IN,__CN([__CC14250,__CC14252]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14250)),__T(__OP2(__PP4004663.P_I___Src_W_Inp_S_D_List_Ev_,=,__CN(__CC14252)))=>__ECAST(KEL.typ.nstr,__CN(__CC14252)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE4005551,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE4005591 := __PP4004663.Sorted_D_O_B_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_S_D_Last_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP4004663.P___Inp_Cln_S_S_N_,IN,__CN([__CC14250,__CC14252])),__OP2(__PP4004663.P___Inp_Cln_D_O_B_,IN,__CN([__CC14250,__CC14252]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14250)),__T(__OP2(__PP4004663.P_I___Src_W_Inp_S_D_List_Ev_,=,__CN(__CC14252)))=>__ECAST(KEL.typ.nstr,__CN(__CC14252)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE4005591,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    SELF := __PP4004663;
  END;
  EXPORT __ENH_S_S_N_Summary := PROJECT(__EE4005662,__ND4005278__Project(LEFT));
END;
