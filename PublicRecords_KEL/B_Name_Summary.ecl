﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Name_Summary_1,B_Name_Summary_3,B_Name_Summary_4,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Name_Summary(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Name_Summary_1(__in,__cfg).__ENH_Name_Summary_1) __ENH_Name_Summary_1 := B_Name_Summary_1(__in,__cfg).__ENH_Name_Summary_1;
  SHARED __EE10949641 := __ENH_Name_Summary_1;
  EXPORT __ST168566_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST168558_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr First_Name_;
    KEL.typ.nstr Last_Name_;
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nint Record_Count_;
    KEL.typ.ndataset(__ST168566_Layout) Data_Sources_;
    KEL.typ.ndataset(B_Name_Summary_3(__in,__cfg).__ST86247_Layout) Name_Summary_Source_List_;
    KEL.typ.ndataset(B_Name_Summary_3(__in,__cfg).__ST86247_Layout) Name_Summary_Source_List_Sorted_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_D_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_D_Last_Dt_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_F_L_D_List_Ev_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_First_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.ndataset(B_Name_Summary_4(__in,__cfg).__ST86198_Layout) Translated_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST168558_Layout __ND10949550__Project(B_Name_Summary_1(__in,__cfg).__ST206526_Layout __PP10949295) := TRANSFORM
    __EE10949644 := __PP10949295.Data_Sources_;
    SELF.Data_Sources_ := __BN(PROJECT(__T(__EE10949644),__ST168566_Layout),__NL(__EE10949644));
    __CC13945 := '-99999';
    __CC13947 := '-99998';
    __EE10949543 := __PP10949295.Name_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_F_L_D_Emrg_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP10949295.P___Inp_Cln_Name_First_,IN,__CN([__CC13945,__CC13947])),__OP2(__PP10949295.P___Inp_Cln_Name_Last_,IN,__CN([__CC13945,__CC13947]))),__OP2(__PP10949295.P___Inp_Cln_D_O_B_,IN,__CN([__CC13945,__CC13947]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13945)),__T(__OP2(__PP10949295.P_I___Src_W_Inp_F_L_D_List_Ev_,=,__CN(__CC13947)))=>__ECAST(KEL.typ.nstr,__CN(__CC13947)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE10949543,LEFT.Source_Date_First_Seen_,__CN('|'))));
    __EE10949593 := __PP10949295.Name_Summary_Source_List_Sorted_;
    SELF.P_I___Src_W_Inp_F_L_D_Last_Dt_List_Ev_ := MAP(__T(__OR(__OR(__OP2(__PP10949295.P___Inp_Cln_Name_First_,IN,__CN([__CC13945,__CC13947])),__OP2(__PP10949295.P___Inp_Cln_Name_Last_,IN,__CN([__CC13945,__CC13947]))),__OP2(__PP10949295.P___Inp_Cln_D_O_B_,IN,__CN([__CC13945,__CC13947]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13945)),__T(__OP2(__PP10949295.P_I___Src_W_Inp_F_L_D_List_Ev_,=,__CN(__CC13947)))=>__ECAST(KEL.typ.nstr,__CN(__CC13947)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE10949593,LEFT.Source_Date_Last_Seen_,__CN('|'))));
    SELF := __PP10949295;
  END;
  EXPORT __ENH_Name_Summary := PROJECT(__EE10949641,__ND10949550__Project(LEFT));
END;
