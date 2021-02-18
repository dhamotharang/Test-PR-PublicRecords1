//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Phone_Summary_2,B_Phone_Summary_3,CFG_Compile,E_Address,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Phone_Summary_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Phone_Summary_2(__in,__cfg).__ENH_Phone_Summary_2) __ENH_Phone_Summary_2 := B_Phone_Summary_2(__in,__cfg).__ENH_Phone_Summary_2;
  SHARED __EE8373982 := __ENH_Phone_Summary_2;
  EXPORT __ST281826_Layout := RECORD
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
  EXPORT __ST281836_Layout := RECORD
    KEL.typ.nkdate Date_Of_Birth_;
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
  EXPORT __ST281851_Layout := RECORD
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
  EXPORT __ST281813_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Phone10_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Address_Header_Summary_Layout) Address_Header_Summary_;
    KEL.typ.ndataset(__ST281826_Layout) Address_Summary_;
    KEL.typ.ndataset(__ST281836_Layout) Date_Of_Birth_Summary_;
    KEL.typ.ndataset(E_Phone_Summary(__in,__cfg).Last_Name_Header_Summary_Layout) Last_Name_Header_Summary_;
    KEL.typ.ndataset(__ST281851_Layout) Last_Name_Summary_;
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
    KEL.typ.ndataset(B_Phone_Summary_2(__in,__cfg).__ST74681_Layout) Sorted_Address_Translated_Source_List_;
    KEL.typ.ndataset(B_Phone_Summary_2(__in,__cfg).__ST74176_Layout) Sorted_D_O_B_Translated_Source_List_;
    KEL.typ.ndataset(B_Phone_Summary_2(__in,__cfg).__ST74404_Layout) Sorted_Last_Name_Translated_Source_List_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST1174683_Layout) Translated_Address_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST1174694_Layout) Translated_D_O_B_Sources_;
    KEL.typ.ndataset(B_Phone_Summary_3(__in,__cfg).__ST1174703_Layout) Translated_Last_Name_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST281813_Layout __ND8373783__Project(B_Phone_Summary_2(__in,__cfg).__ST281369_Layout __PP8373103) := TRANSFORM
    __EE8373985 := __PP8373103.Address_Summary_;
    SELF.Address_Summary_ := __BN(PROJECT(__T(__EE8373985),__ST281826_Layout),__NL(__EE8373985));
    __EE8373988 := __PP8373103.Date_Of_Birth_Summary_;
    SELF.Date_Of_Birth_Summary_ := __BN(PROJECT(__T(__EE8373988),__ST281836_Layout),__NL(__EE8373988));
    __EE8373991 := __PP8373103.Last_Name_Summary_;
    SELF.Last_Name_Summary_ := __BN(PROJECT(__T(__EE8373991),__ST281851_Layout),__NL(__EE8373991));
    __CC13760 := '-99999';
    __CC13765 := '-99998';
    __BS8373296 := __T(__PP8373103.Translated_Address_Sources_);
    __EE8373776 := __PP8373103.Sorted_Address_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_A_P_List_Ev_ := MAP(__T(__OR(__OR(__OR(__OP2(__PP8373103.P___Inp_Cln_Phone_Home_,IN,__CN([__CC13760,__CC13765])),__OP2(__PP8373103.P___Inp_Cln_Addr_Prim_Name_,IN,__CN([__CC13760,__CC13765]))),__OP2(__PP8373103.P___Inp_Cln_Addr_Prim_Rng_,IN,__CN([__CC13760,__CC13765]))),__OP2(__PP8373103.P___Inp_Cln_Addr_Zip5_,IN,__CN([__CC13760,__CC13765]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13760)), NOT EXISTS(__BS8373296(__T(__AND(__OP2(__T(__PP8373103.Translated_Address_Sources_).Primary_Name_,=,__PP8373103.P___Inp_Cln_Addr_Prim_Name_),__AND(__OP2(__T(__PP8373103.Translated_Address_Sources_).Primary_Range_,=,__PP8373103.P___Inp_Cln_Addr_Prim_Rng_),__OP2(__T(__PP8373103.Translated_Address_Sources_).Zip_,=,__PP8373103.P___Inp_Cln_Addr_Zip5_))))))=>__ECAST(KEL.typ.nstr,__CN(__CC13765)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE8373776,LEFT.Source_,__CN('|'))));
    __BS8373803 := __T(__PP8373103.Translated_Last_Name_Sources_);
    __EE8373826 := __PP8373103.Sorted_Last_Name_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_L_P_List_Ev_ := MAP(__T(__OR(__OP2(__PP8373103.P___Inp_Cln_Phone_Home_,IN,__CN([__CC13760,__CC13765])),__OP2(__PP8373103.P___Inp_Cln_Name_Last_,IN,__CN([__CC13760,__CC13765]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13760)), NOT EXISTS(__BS8373803(__T(__OP2(__T(__PP8373103.Translated_Last_Name_Sources_).Last_Name_,=,__PP8373103.P___Inp_Cln_Name_Last_))))=>__ECAST(KEL.typ.nstr,__CN(__CC13765)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE8373826,LEFT.Source_,__CN('|'))));
    __BS8373851 := __T(__PP8373103.Translated_D_O_B_Sources_);
    __EE8373877 := __PP8373103.Sorted_D_O_B_Translated_Source_List_;
    SELF.P_I___Src_W_Inp_P_D_List_Ev_ := MAP(__T(__OR(__OP2(__PP8373103.P___Inp_Cln_Phone_Home_,IN,__CN([__CC13760,__CC13765])),__OP2(__PP8373103.P___Inp_Cln_D_O_B_,IN,__CN([__CC13760,__CC13765]))))=>__ECAST(KEL.typ.nstr,__CN(__CC13760)), NOT EXISTS(__BS8373851(__T(__OP2(__FN2(KEL.Routines.DateToString,__T(__PP8373103.Translated_D_O_B_Sources_).Date_Of_Birth_,__CN('%Y%m%d')),=,__PP8373103.P___Inp_Cln_D_O_B_))))=>__ECAST(KEL.typ.nstr,__CN(__CC13765)),__ECAST(KEL.typ.nstr,KEL.Aggregates.ConcatNN(__EE8373877,LEFT.Source_,__CN('|'))));
    SELF := __PP8373103;
  END;
  EXPORT __ENH_Phone_Summary_1 := PROJECT(__EE8373982,__ND8373783__Project(LEFT));
END;
