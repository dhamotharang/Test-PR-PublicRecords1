﻿//HPCC Systems KEL Compiler Version 1.5.0
IMPORT KEL15 AS KEL;
IMPORT B_S_S_N_Summary_1,B_S_S_N_Summary_3,B_S_S_N_Summary_4,CFG_Compile,E_Address,E_Email,E_Geo_Link,E_Input_P_I_I,E_Person,E_Phone,E_Property,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_S_S_N_Summary(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_S_S_N_Summary_1(__in,__cfg).__ENH_S_S_N_Summary_1) __ENH_S_S_N_Summary_1 := B_S_S_N_Summary_1(__in,__cfg).__ENH_S_S_N_Summary_1;
  SHARED __EE11548697 := __ENH_S_S_N_Summary_1;
  EXPORT __ST167550_Layout := RECORD
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
  EXPORT __ST167559_Layout := RECORD
    KEL.typ.nkdate Dob_Date_Of_Birth_;
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
  EXPORT __ST167566_Layout := RECORD
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
  EXPORT __ST167574_Layout := RECORD
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
  EXPORT __ST167546_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr S_S_N_;
    KEL.typ.ndataset(__ST167550_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST167559_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(__ST167566_Layout) Name_Summary_;
    KEL.typ.ndataset(__ST167574_Layout) Phone_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
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
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.nstr P___Inp_Cln_Primary_Name_;
    KEL.typ.nstr P___Inp_Cln_Primary_Range_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.nstr P___Inp_Cln_Zip_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST76050_Layout) Phone_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST76050_Layout) Phone_Summary_Source_List_Sorted_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST76012_Layout) Phone_Translated_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST75714_Layout) S_S_N_Summary_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST75714_Layout) S_S_N_Summary_Source_List_Sorted_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST75914_Layout) Sorted_D_O_B_Translated_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST76194_Layout) Sorted_Fn_Ln_Translated_Source_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST75877_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST75914_Layout) Translated_D_O_B_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST76155_Layout) Translated_Fn_Ln_Sources_;
    KEL.typ.ndataset(B_S_S_N_Summary_3(__in,__cfg).__ST76194_Layout) Translated_Fn_Ln_Sources_List_;
    KEL.typ.ndataset(B_S_S_N_Summary_4(__in,__cfg).__ST75660_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST167546_Layout __ND11548231__Project(B_S_S_N_Summary_1(__in,__cfg).__ST192556_Layout __PP11547306) := TRANSFORM
    __EE11548700 := __PP11547306.Address_Summary_;
    SELF.Address_Summary_ := __BN(PROJECT(__T(__EE11548700),__ST167550_Layout),__NL(__EE11548700));
    __EE11548703 := __PP11547306.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE11548703),__ST167559_Layout),__NL(__EE11548703));
    __EE11548706 := __PP11547306.Name_Summary_;
    SELF.Name_Summary_ := __BN(PROJECT(__T(__EE11548706),__ST167566_Layout),__NL(__EE11548706));
    __EE11548709 := __PP11547306.Phone_Summary_;
    SELF.Phone_Summary_ := __BN(PROJECT(__T(__EE11548709),__ST167574_Layout),__NL(__EE11548709));
    __CC13717 := '-99999';
    __CC13719 := '-99998';
    __EE11548224 := __PP11547306.S_S_N_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_A_S_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP11547306.P___Inp_Cln_S_S_N_,IN,__CN([__CC13717,__CC13719])),__OP2(__PP11547306.P___Inp_Cln_Primary_Range_,IN,__CN([__CC13717,__CC13719]))),__OP2(__PP11547306.P___Inp_Cln_Primary_Name_,IN,__CN([__CC13717,__CC13719]))),__OP2(__PP11547306.P___Inp_Cln_Zip_,IN,__CN([__CC13717,__CC13719]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13717)),__T(__OP2(__PP11547306.P_I___Src_W_Inp_A_S_List_Ev_,=,__CN(__CC13719)))=>__ECAST(KEL.typ.nstr,__CN(__CC13719)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11548224,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE11548282 := __PP11547306.S_S_N_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_A_S_Last_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP11547306.P___Inp_Cln_S_S_N_,IN,__CN([__CC13717,__CC13719])),__OP2(__PP11547306.P___Inp_Cln_Primary_Range_,IN,__CN([__CC13717,__CC13719]))),__OP2(__PP11547306.P___Inp_Cln_Primary_Name_,IN,__CN([__CC13717,__CC13719]))),__OP2(__PP11547306.P___Inp_Cln_Zip_,IN,__CN([__CC13717,__CC13719]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13717)),__T(__OP2(__PP11547306.P_I___Src_W_Inp_A_S_List_Ev_,=,__CN(__CC13719)))=>__ECAST(KEL.typ.nstr,__CN(__CC13719)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11548282,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    __EE11548332 := __PP11547306.Sorted_Fn_Ln_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_F_L_S_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP11547306.P___Inp_Cln_S_S_N_,IN,__CN([__CC13717,__CC13719])),__OP2(__PP11547306.P___Inp_Cln_Name_First_,IN,__CN([__CC13717,__CC13719]))),__OP2(__PP11547306.P___Inp_Cln_Name_Last_,IN,__CN([__CC13717,__CC13719]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13717)),__T(__OP2(__PP11547306.P_I___Src_W_Inp_F_L_S_List_Ev_,=,__CN(__CC13719)))=>__ECAST(KEL.typ.nstr,__CN(__CC13719)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11548332,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE11548380 := __PP11547306.Sorted_Fn_Ln_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_F_L_S_Last_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP11547306.P___Inp_Cln_S_S_N_,IN,__CN([__CC13717,__CC13719])),__OP2(__PP11547306.P___Inp_Cln_Name_First_,IN,__CN([__CC13717,__CC13719]))),__OP2(__PP11547306.P___Inp_Cln_Name_Last_,IN,__CN([__CC13717,__CC13719]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13717)),__T(__OP2(__PP11547306.P_I___Src_W_Inp_F_L_S_List_Ev_,=,__CN(__CC13719)))=>__ECAST(KEL.typ.nstr,__CN(__CC13719)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11548380,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    __EE11548422 := __PP11547306.Phone_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_P_S_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP11547306.P___Inp_Cln_S_S_N_,IN,__CN([__CC13717,__CC13719])),__OP2(__PP11547306.P___Inp_Cln_Phone_Home_,IN,__CN([__CC13717,__CC13719]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13717)),__T(__OP2(__PP11547306.P_I___Src_W_Inp_P_S_List_Ev_,=,__CN(__CC13719)))=>__ECAST(KEL.typ.nstr,__CN(__CC13719)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11548422,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE11548462 := __PP11547306.Phone_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_P_S_Last_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP11547306.P___Inp_Cln_S_S_N_,IN,__CN([__CC13717,__CC13719])),__OP2(__PP11547306.P___Inp_Cln_Phone_Home_,IN,__CN([__CC13717,__CC13719]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13717)),__T(__OP2(__PP11547306.P_I___Src_W_Inp_P_S_List_Ev_,=,__CN(__CC13719)))=>__ECAST(KEL.typ.nstr,__CN(__CC13719)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11548462,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    __EE11548504 := __PP11547306.Sorted_D_O_B_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_S_D_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP11547306.P___Inp_Cln_S_S_N_,IN,__CN([__CC13717,__CC13719])),__OP2(__PP11547306.P___Inp_Cln_D_O_B_,IN,__CN([__CC13717,__CC13719]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13717)),__T(__OP2(__PP11547306.P_I___Src_W_Inp_S_D_List_Ev_,=,__CN(__CC13719)))=>__ECAST(KEL.typ.nstr,__CN(__CC13719)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11548504,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE11548544 := __PP11547306.Sorted_D_O_B_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_S_D_Last_Dt_List_Ev_ := MAP(__T(__OR(__OP2(__PP11547306.P___Inp_Cln_S_S_N_,IN,__CN([__CC13717,__CC13719])),__OP2(__PP11547306.P___Inp_Cln_D_O_B_,IN,__CN([__CC13717,__CC13719]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13717)),__T(__OP2(__PP11547306.P_I___Src_W_Inp_S_D_List_Ev_,=,__CN(__CC13719)))=>__ECAST(KEL.typ.nstr,__CN(__CC13719)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE11548544,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    SELF := __PP11547306;
  END;
  EXPORT __ENH_S_S_N_Summary := PROJECT(__EE11548697,__ND11548231__Project(LEFT));
END;
