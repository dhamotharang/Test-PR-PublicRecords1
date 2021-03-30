//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Phone_Summary_2,B_Phone_Summary_3,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Phone_Summary_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Phone_Summary_2(__in,__cfg).__ENH_Phone_Summary_2) __ENH_Phone_Summary_2 := B_Phone_Summary_2(__in,__cfg).__ENH_Phone_Summary_2;
  SHARED __EE9546242 := __ENH_Phone_Summary_2;
  EXPORT __ST343085_Layout := RECORD
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Zip_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST343095_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
    KEL.typ.nstr Date_Of_Birth_Padded_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST343111_Layout := RECORD
    KEL.typ.nstr Last_Name_;
    KEL.typ.nint Record_Count_;
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nstr Translated_Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST343072_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(__ST343085_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST343095_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(__ST343111_Layout) Last_Name_Summary_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P_I___Src_W_Inp_A_P_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_L_P_List_Ev_;
    KEL.typ.nstr P_I___Src_W_Inp_P_D_List_Ev_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr P___Inp_Cln_D_O_B_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_;
    KEL.typ.nstr P___Inp_Cln_Phone_Home_;
    KEL.typ.ndataset(B_Phone_Summary_2(__in,__cfg).__ST78320_Layout) Sorted_Address_Translated_Source_List_;
    KEL.typ.ndataset(B_Phone_Summary_2(__in,__cfg).__ST77815_Layout) Sorted_D_O_B_Translated_Source_List_;
    KEL.typ.ndataset(B_Phone_Summary_2(__in,__cfg).__ST78043_Layout) Sorted_Last_Name_Translated_Source_List_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST1269998_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST1270009_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST1270018_Layout) Translated_Last_Name_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST343072_Layout __ND9546043__Project(B_Phone_Summary_2(__in,__cfg).__ST342626_Layout __PP9545358) := TRANSFORM
    __EE9546245 := __PP9545358.Address_Summary_;
    SELF.Address_Summary_ := __BN(PROJECT(__T(__EE9546245),__ST343085_Layout),__NL(__EE9546245));
    __EE9546248 := __PP9545358.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE9546248),__ST343095_Layout),__NL(__EE9546248));
    __EE9546251 := __PP9545358.Last_Name_Summary_;
    SELF.Last_Name_Summary_ := __BN(PROJECT(__T(__EE9546251),__ST343111_Layout),__NL(__EE9546251));
    __CC13956 := '-99999';
    __CC13961 := '-99998';
    __BS9545555 := __T(__PP9545358.Translated_Address_Sources_);
    __EE9546036 := __PP9545358.Sorted_Address_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_A_P_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP9545358.P___Inp_Cln_Phone_Home_,IN,__CN([__CC13956,__CC13961])),__OP2(__PP9545358.P___Inp_Cln_Addr_Prim_Name_,IN,__CN([__CC13956,__CC13961]))),__OP2(__PP9545358.P___Inp_Cln_Addr_Prim_Rng_,IN,__CN([__CC13956,__CC13961]))),__OP2(__PP9545358.P___Inp_Cln_Addr_Zip5_,IN,__CN([__CC13956,__CC13961]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13956)), NOT EXISTS(__BS9545555(__T(__AND(__OP2(__T(__PP9545358.Translated_Address_Sources_).Primary_Name_,=,__PP9545358.P___Inp_Cln_Addr_Prim_Name_),__AND(__OP2(__T(__PP9545358.Translated_Address_Sources_).Primary_Range_,=,__PP9545358.P___Inp_Cln_Addr_Prim_Rng_),__OP2(__T(__PP9545358.Translated_Address_Sources_).Zip_,=,__PP9545358.P___Inp_Cln_Addr_Zip5_))))))=>__ECAST(KEL.typ.nstr,__CN(__CC13961)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE9546036,LEFT.Source_,__CN('|'))));
    __BS9546063 := __T(__PP9545358.Translated_Last_Name_Sources_);
    __EE9546086 := __PP9545358.Sorted_Last_Name_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_L_P_List_Ev_ := MAP(__T(__OR(__OP2(__PP9545358.P___Inp_Cln_Phone_Home_,IN,__CN([__CC13956,__CC13961])),__OP2(__PP9545358.P___Inp_Cln_Name_Last_,IN,__CN([__CC13956,__CC13961]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13956)), NOT EXISTS(__BS9546063(__T(__OP2(__T(__PP9545358.Translated_Last_Name_Sources_).Last_Name_,=,__PP9545358.P___Inp_Cln_Name_Last_))))=>__ECAST(KEL.typ.nstr,__CN(__CC13961)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE9546086,LEFT.Source_,__CN('|'))));
    __BS9546111 := __T(__PP9545358.Translated_D_O_B_Sources_);
    __EE9546137 := __PP9545358.Sorted_D_O_B_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_P_D_List_Ev_ := MAP(__T(__OR(__OP2(__PP9545358.P___Inp_Cln_Phone_Home_,IN,__CN([__CC13956,__CC13961])),__OP2(__PP9545358.P___Inp_Cln_D_O_B_,IN,__CN([__CC13956,__CC13961]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13956)), NOT EXISTS(__BS9546111(__T(__OP2(__FN2(KEL.Routines.DateToString,__T(__PP9545358.Translated_D_O_B_Sources_).Date_Of_Birth_,__CN('%Y%m%d')),=,__PP9545358.P___Inp_Cln_D_O_B_))))=>__ECAST(KEL.typ.nstr,__CN(__CC13961)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE9546137,LEFT.Source_,__CN('|'))));
    SELF := __PP9545358;
  END;
  EXPORT __ENH_Phone_Summary_1 := PROJECT(__EE9546242,__ND9546043__Project(LEFT));
END;
