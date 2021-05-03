//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_8,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Person_S_S_N,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_S_S_N_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_8(__in,__cfg).__ENH_Person_8) __ENH_Person_8 := B_Person_8(__in,__cfg).__ENH_Person_8;
  SHARED VIRTUAL TYPEOF(E_Person_S_S_N(__in,__cfg).__Result) __E_Person_S_S_N := E_Person_S_S_N(__in,__cfg).__Result;
  SHARED __EE331149 := __E_Person_S_S_N;
  SHARED __EE4722831 := __ENH_Person_8;
  SHARED __ST331223_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Valid_S_S_N_Layout) Valid_S_S_N_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(B_Person_8(__in,__cfg).__ST211067_Layout) Data_Sources__1_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(B_Person_8(__in,__cfg).__ST305492_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P___Inp_Cln_Addr_Post_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Pre_Dir_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Name_;
    KEL.typ.nstr P___Inp_Cln_Addr_Prim_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sec_Rng_;
    KEL.typ.nstr P___Inp_Cln_Addr_Sffx_;
    KEL.typ.nstr P___Inp_Cln_Addr_Zip5_;
    KEL.typ.nstr P___Inp_Cln_Name_First_Raw_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_Raw_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.ndataset(B_Person_8(__in,__cfg).__ST109345_Layout) Person_Address_Match_Sources_All_Pre_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC4722837(E_Person_S_S_N(__in,__cfg).Layout __EE331149, B_Person_8(__in,__cfg).__ST211037_Layout __EE4722831) := __EEQP(__EE331149.Subject_,__EE4722831.UID);
  __ST331223_Layout __JT4722837(E_Person_S_S_N(__in,__cfg).Layout __l, B_Person_8(__in,__cfg).__ST211037_Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE4722838 := JOIN(__EE331149,__EE4722831,__JC4722837(LEFT,RIGHT),__JT4722837(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST209866_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool F_D_N_Indicator_;
    KEL.typ.nbool Death_Master_Flag_;
    KEL.typ.nkdate S_S_N_Source_Date_First_Seen_;
    KEL.typ.nkdate S_S_N_Source_Date_Last_Seen_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST209858_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Valid_S_S_N_Layout) Valid_S_S_N_;
    KEL.typ.ndataset(__ST209866_Layout) Data_Sources_;
    KEL.typ.nbool Input_S_S_N_Match_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST209858_Layout __ND4723149__Project(__ST331223_Layout __PP4722839) := TRANSFORM
    __EE4722978 := __PP4722839.Data_Sources_;
    __ST209866_Layout __ND4722983__Project(E_Person_S_S_N(__in,__cfg).Data_Sources_Layout __PP4722979) := TRANSFORM
      SELF.S_S_N_Source_Date_First_Seen_ := KEL.era.ToDate(__PP4722979.Date_First_Seen_);
      SELF.S_S_N_Source_Date_Last_Seen_ := KEL.era.ToDate(__PP4722979.Date_Last_Seen_);
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP4722979.Source_));
      SELF := __PP4722979;
    END;
    SELF.Data_Sources_ := __PROJECT(__EE4722978,__ND4722983__Project(LEFT));
    SELF.Input_S_S_N_Match_ := FN_Compile(__cfg).FN_Edit_Distance_Within_Radius(__ECAST(KEL.typ.nstr,__PP4722839.Social_),__ECAST(KEL.typ.nstr,__PP4722839.P___Inp_Cln_S_S_N_),__ECAST(KEL.typ.nint,__CN(2)));
    SELF := __PP4722839;
  END;
  EXPORT __ENH_Person_S_S_N_7 := PROJECT(__EE4722838,__ND4723149__Project(LEFT));
END;
