//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_7,CFG_Compile,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Person_S_S_N,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_FCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_S_S_N_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_7(__in,__cfg).__ENH_Person_7) __ENH_Person_7 := B_Person_7(__in,__cfg).__ENH_Person_7;
  SHARED VIRTUAL TYPEOF(E_Person_S_S_N(__in,__cfg).__Result) __E_Person_S_S_N := E_Person_S_S_N(__in,__cfg).__Result;
  SHARED __EE234656 := __E_Person_S_S_N;
  SHARED __EE1103600 := __ENH_Person_7;
  SHARED __ST234720_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Valid_S_S_N_Layout) Valid_S_S_N_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nuid UID;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.nstr Lex_I_D_Segment2_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST173912_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST215154_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P___Inp_Cln_Name_First_Raw_;
    KEL.typ.nstr P___Inp_Cln_Name_Last_Raw_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1103606(E_Person_S_S_N(__in,__cfg).Layout __EE234656, B_Person_7(__in,__cfg).__ST173907_Layout __EE1103600) := __EEQP(__EE234656.Subject_,__EE1103600.UID);
  __ST234720_Layout __JT1103606(E_Person_S_S_N(__in,__cfg).Layout __l, B_Person_7(__in,__cfg).__ST173907_Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1103607 := JOIN(__EE234656,__EE1103600,__JC1103606(LEFT,RIGHT),__JT1103606(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST167424_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.nbool Header_Hit_Flag_;
    KEL.typ.nbool F_D_N_Indicator_;
    KEL.typ.nbool Death_Master_Flag_;
    KEL.typ.nstr Translated_Source_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST167416_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Valid_S_S_N_Layout) Valid_S_S_N_;
    KEL.typ.ndataset(__ST167424_Layout) Data_Sources_;
    KEL.typ.nbool Input_S_S_N_Match_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST167416_Layout __ND1103889__Project(__ST234720_Layout __PP1103608) := TRANSFORM
    __EE1103737 := __PP1103608.Data_Sources_;
    __ST167424_Layout __ND1103742__Project(E_Person_S_S_N(__in,__cfg).Data_Sources_Layout __PP1103738) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP1103738.Source_));
      SELF := __PP1103738;
    END;
    SELF.Data_Sources_ := __PROJECT(__EE1103737,__ND1103742__Project(LEFT));
    SELF.Input_S_S_N_Match_ := FN_Compile(__cfg).FN_Edit_Distance_Within_Radius(__ECAST(KEL.typ.nstr,__PP1103608.Social_),__ECAST(KEL.typ.nstr,__PP1103608.P___Inp_Cln_S_S_N_),__ECAST(KEL.typ.nint,__CN(2)));
    SELF := __PP1103608;
  END;
  EXPORT __ENH_Person_S_S_N_6 := PROJECT(__EE1103607,__ND1103889__Project(LEFT));
END;
