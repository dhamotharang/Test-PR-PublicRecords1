//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_10,B_Person_Address_10,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Person_Address,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Address_9(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_10(__in,__cfg).__ENH_Person_10) __ENH_Person_10 := B_Person_10(__in,__cfg).__ENH_Person_10;
  SHARED VIRTUAL TYPEOF(B_Person_Address_10(__in,__cfg).__ENH_Person_Address_10) __ENH_Person_Address_10 := B_Person_Address_10(__in,__cfg).__ENH_Person_Address_10;
  SHARED __EE4689518 := __ENH_Person_Address_10;
  SHARED __EE4689521 := __ENH_Person_10;
  SHARED __ST301464_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Cart_;
    KEL.typ.nstr C_R_Sort_Sz_;
    KEL.typ.nstr Lot_;
    KEL.typ.nstr Lot_Order_;
    KEL.typ.nstr D_P_B_C_;
    KEL.typ.nstr C_H_K_Digit_;
    KEL.typ.nstr Ace_Fips_St_;
    KEL.typ.nstr Ace_Fips_County_;
    KEL.typ.nstr M_S_A_;
    KEL.typ.nstr Verified_City_;
    KEL.typ.ndataset(E_Person_Address(__in,__cfg).Address_Rank_Details_Layout) Address_Rank_Details_;
    KEL.typ.ndataset(E_Person_Address(__in,__cfg).Address_Hierarchy_Layout) Address_Hierarchy_;
    KEL.typ.ndataset(E_Person_Address(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nstr Grouped_Address_;
    KEL.typ.nstr Grouped_Input_Address_;
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(B_Person_10(__in,__cfg).__ST293866_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P___Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4689529(B_Person_Address_10(__in,__cfg).__ST213411_Layout __EE4689518, B_Person_10(__in,__cfg).__ST216333_Layout __EE4689521) := __EEQP(__EE4689518.Subject_,__EE4689521.UID);
  __ST301464_Layout __JT4689529(B_Person_Address_10(__in,__cfg).__ST213411_Layout __l, B_Person_10(__in,__cfg).__ST216333_Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4689530 := JOIN(__EE4689518,__EE4689521,__JC4689529(LEFT,RIGHT),__JT4689529(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST217220_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool F_D_N_Indicator_;
    KEL.typ.nkdate Address_Source_Date_First_Seen_;
    KEL.typ.nkdate Address_Source_Date_Last_Seen_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST217164_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Primary_Range_;
    KEL.typ.nstr Predirectional_;
    KEL.typ.nstr Primary_Name_;
    KEL.typ.nstr Suffix_;
    KEL.typ.nstr Postdirectional_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Z_I_P5_;
    KEL.typ.nstr Secondary_Range_;
    KEL.typ.nstr Cart_;
    KEL.typ.nstr C_R_Sort_Sz_;
    KEL.typ.nstr Lot_;
    KEL.typ.nstr Lot_Order_;
    KEL.typ.nstr D_P_B_C_;
    KEL.typ.nstr C_H_K_Digit_;
    KEL.typ.nstr Ace_Fips_St_;
    KEL.typ.nstr Ace_Fips_County_;
    KEL.typ.nstr M_S_A_;
    KEL.typ.nstr Verified_City_;
    KEL.typ.ndataset(E_Person_Address(__in,__cfg).Address_Rank_Details_Layout) Address_Rank_Details_;
    KEL.typ.ndataset(E_Person_Address(__in,__cfg).Address_Hierarchy_Layout) Address_Hierarchy_;
    KEL.typ.ndataset(__ST217220_Layout) Data_Sources_;
    KEL.typ.int Address_Similarity_Match_ := 0;
    KEL.typ.nstr Grouped_Address_;
    KEL.typ.nstr Grouped_Input_Address_;
    KEL.typ.nbool Input_Address_Match_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST217164_Layout __ND4690176__Project(__ST301464_Layout __PP4689531) := TRANSFORM
    __EE4689788 := __PP4689531.Data_Sources_;
    __ST217220_Layout __ND4689793__Project(E_Person_Address(__in,__cfg).Data_Sources_Layout __PP4689789) := TRANSFORM
      SELF.Address_Source_Date_First_Seen_ := KEL.era.ToDate(__PP4689789.Date_First_Seen_);
      SELF.Address_Source_Date_Last_Seen_ := KEL.era.ToDate(__PP4689789.Date_Last_Seen_);
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP4689789.Source_));
      SELF := __PP4689789;
    END;
    SELF.Data_Sources_ := __PROJECT(__EE4689788,__ND4689793__Project(LEFT));
    SELF.Address_Similarity_Match_ := IF(__T(__OP2(FN_Compile(__cfg).FN_Levenshtein_Similarity(__ECAST(KEL.typ.nstr,__PP4689531.Grouped_Address_),__ECAST(KEL.typ.nstr,__PP4689531.Grouped_Input_Address_)),>=,__CN(0.75))),1,0);
    SELF.Input_Address_Match_ := __AND(__AND(__AND(__AND(__AND(__AND(__OP2(__PP4689531.P___Inp_Cln_Addr_Prim_Rng_,=,__PP4689531.Primary_Range_),__OP2(__PP4689531.P___Inp_Cln_Addr_Prim_Name_,=,__PP4689531.Primary_Name_)),__OP2(__PP4689531.P___Inp_Cln_Addr_Pre_Dir_,=,__PP4689531.Predirectional_)),__OP2(__PP4689531.P___Inp_Cln_Addr_Post_Dir_,=,__PP4689531.Postdirectional_)),__OP2(__PP4689531.P___Inp_Cln_Addr_Sffx_,=,__PP4689531.Suffix_)),__OP2(__PP4689531.P___Inp_Cln_Addr_Zip5_,=,__CAST(KEL.typ.str,__PP4689531.Z_I_P5_))),__OR(__OR(__OP2(__PP4689531.P___Inp_Cln_Addr_Sec_Rng_,=,__PP4689531.Secondary_Range_),__AND(__OR(__OP2(__PP4689531.P___Inp_Cln_Addr_Sec_Rng_,=,__CN('')),__NT(__PP4689531.P___Inp_Cln_Addr_Sec_Rng_)),__OP2(__PP4689531.Secondary_Range_,<>,__CN('')))),__AND(__OP2(__PP4689531.P___Inp_Cln_Addr_Sec_Rng_,<>,__CN('')),__OR(__OP2(__PP4689531.Secondary_Range_,=,__CN('')),__NT(__PP4689531.Secondary_Range_)))));
    SELF := __PP4689531;
  END;
  EXPORT __ENH_Person_Address_9 := PROJECT(__EE4689530,__ND4690176__Project(LEFT));
END;
