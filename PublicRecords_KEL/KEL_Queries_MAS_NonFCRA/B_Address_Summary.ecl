//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Address_Summary_1,B_Address_Summary_3,B_Address_Summary_4,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Address_Summary(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Address_Summary_1(__in,__cfg).__ENH_Address_Summary_1) __ENH_Address_Summary_1 := B_Address_Summary_1(__in,__cfg).__ENH_Address_Summary_1;
  SHARED __EE3204937 := __ENH_Address_Summary_1;
  EXPORT __ST141333_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.ndataset(B_Address_Summary_1(__in,__cfg).__ST150914_Layout) Name_Summary_;
    KEL.typ.ndataset(B_Address_Summary_1(__in,__cfg).__ST150922_Layout) Date_Of_Birth_Summary_;
    KEL.typ.nstr P_I___Src_W_Inp_A_D_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_A_D_Last_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_A_D_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_A_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_A_Last_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_A_List_Ev_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST141333_Layout __ND3204719__Project(B_Address_Summary_1(__in,__cfg).__ST150908_Layout __PP3204356) := TRANSFORM
    __CC14252 := '-99999';
    __CC14254 := '-99998';
    __EE3204712 := __PP3204356.D_O_B_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_A_D_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP3204356.P___Inp_Cln_D_O_B_,IN,__CN([__CC14252,__CC14254])),__OP2(__PP3204356.P___Inp_Cln_Addr_Prim_Name_,IN,__CN([__CC14252,__CC14254]))),__OP2(__PP3204356.P___Inp_Cln_Addr_Prim_Rng_,IN,__CN([__CC14252,__CC14254]))),__OP2(__PP3204356.P___Inp_Cln_Addr_Zip5_,IN,__CN([__CC14252,__CC14254]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14252)),__T(__OP2(__PP3204356.P_I___Src_W_Inp_A_D_List_Ev_,=,__CN(__CC14254)))=>__ECAST(KEL.typ.nstr,__CN(__CC14254)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3204712,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE3204770 := __PP3204356.D_O_B_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_A_D_Last_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP3204356.P___Inp_Cln_D_O_B_,IN,__CN([__CC14252,__CC14254])),__OP2(__PP3204356.P___Inp_Cln_Addr_Prim_Name_,IN,__CN([__CC14252,__CC14254]))),__OP2(__PP3204356.P___Inp_Cln_Addr_Prim_Rng_,IN,__CN([__CC14252,__CC14254]))),__OP2(__PP3204356.P___Inp_Cln_Addr_Zip5_,IN,__CN([__CC14252,__CC14254]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14252)),__T(__OP2(__PP3204356.P_I___Src_W_Inp_A_D_List_Ev_,=,__CN(__CC14254)))=>__ECAST(KEL.typ.nstr,__CN(__CC14254)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3204770,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    __EE3204836 := __PP3204356.Address_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_F_L_A_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OR(__OP2(__PP3204356.P___Inp_Cln_Name_First_,IN,__CN([__CC14252,__CC14254])),__OP2(__PP3204356.P___Inp_Cln_Name_Last_,IN,__CN([__CC14252,__CC14254]))),__OP2(__PP3204356.P___Inp_Cln_Addr_Prim_Name_,IN,__CN([__CC14252,__CC14254]))),__OP2(__PP3204356.P___Inp_Cln_Addr_Prim_Rng_,IN,__CN([__CC14252,__CC14254]))),__OP2(__PP3204356.P___Inp_Cln_Addr_Zip5_,IN,__CN([__CC14252,__CC14254]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14252)),__T(__OP2(__PP3204356.P_I___Src_W_Inp_F_L_A_List_Ev_,=,__CN(__CC14254)))=>__ECAST(KEL.typ.nstr,__CN(__CC14254)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3204836,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE3204900 := __PP3204356.Address_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_F_L_A_Last_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OR(__OP2(__PP3204356.P___Inp_Cln_Name_First_,IN,__CN([__CC14252,__CC14254])),__OP2(__PP3204356.P___Inp_Cln_Name_Last_,IN,__CN([__CC14252,__CC14254]))),__OP2(__PP3204356.P___Inp_Cln_Addr_Prim_Name_,IN,__CN([__CC14252,__CC14254]))),__OP2(__PP3204356.P___Inp_Cln_Addr_Prim_Rng_,IN,__CN([__CC14252,__CC14254]))),__OP2(__PP3204356.P___Inp_Cln_Addr_Zip5_,IN,__CN([__CC14252,__CC14254]))))=>__ECAST(KEL.typ.nstr,__CN(__CC14252)),__T(__OP2(__PP3204356.P_I___Src_W_Inp_F_L_A_List_Ev_,=,__CN(__CC14254)))=>__ECAST(KEL.typ.nstr,__CN(__CC14254)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE3204900,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    SELF := __PP3204356;
  END;
  EXPORT __ENH_Address_Summary := PROJECT(__EE3204937,__ND3204719__Project(LEFT));
END;
