//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_Person_7,B_Person_Accident_8,CFG_Compile,E_Accident,E_Address,E_Address_Slim,E_Address_Summary,E_Email,E_Geo_Link,E_Input_P_I_I,E_Name_Summary,E_Person,E_Person_Accident,E_Person_S_S_N,E_Phone,E_Phone_Summary,E_Property,E_S_S_N_Summary,E_Social_Security_Number,E_Surname,E_Zip_Code,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_S_S_N_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_7(__in,__cfg).__ENH_Person_7) __ENH_Person_7 := B_Person_7(__in,__cfg).__ENH_Person_7;
  SHARED VIRTUAL TYPEOF(E_Person_S_S_N(__in,__cfg).__Result) __E_Person_S_S_N := E_Person_S_S_N(__in,__cfg).__Result;
  SHARED __EE261266 := __E_Person_S_S_N;
  SHARED __EE1640594 := __ENH_Person_7;
  SHARED __ST261330_Layout := RECORD
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
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST177600_Layout) Data_Sources__1_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Conceal_Carry_Layout) Conceal_Carry_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Hunt_Fish_Layout) Hunt_Fish_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Consumer_Statement_Flags_Layout) Consumer_Statement_Flags_;
    KEL.typ.ndataset(E_Person(__in,__cfg).Thrive_Layout) Thrive_;
    KEL.typ.ndataset(B_Person_Accident_8(__in,__cfg).__ST178950_Layout) Accident_Recs_;
    KEL.typ.ndataset(B_Person_7(__in,__cfg).__ST231209_Layout) All_Lien_Data_;
    KEL.typ.ntyp(E_Input_P_I_I().Typ) P_I_I_;
    KEL.typ.nstr P___Inp_Cln_S_S_N_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC1640600(E_Person_S_S_N(__in,__cfg).Layout __EE261266, B_Person_7(__in,__cfg).__ST177570_Layout __EE1640594) := __EEQP(__EE261266.Subject_,__EE1640594.UID);
  __ST261330_Layout __JT1640600(E_Person_S_S_N(__in,__cfg).Layout __l, B_Person_7(__in,__cfg).__ST177570_Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE1640601 := JOIN(__EE261266,__EE1640594,__JC1640600(LEFT,RIGHT),__JT1640600(LEFT,RIGHT),LEFT OUTER,HASH);
  EXPORT __ST176703_Layout := RECORD
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
  EXPORT __ST176695_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg).Valid_S_S_N_Layout) Valid_S_S_N_;
    KEL.typ.ndataset(__ST176703_Layout) Data_Sources_;
    KEL.typ.nbool Input_S_S_N_Match_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST176695_Layout __ND1640971__Project(__ST261330_Layout __PP1640602) := TRANSFORM
    __EE1640776 := __PP1640602.Data_Sources_;
    __ST176703_Layout __ND1640781__Project(E_Person_S_S_N(__in,__cfg).Data_Sources_Layout __PP1640777) := TRANSFORM
      SELF.Translated_Source_Code_ := FN_Compile(__cfg).FN_Consumer_Source_Group(__ECAST(KEL.typ.nstr,__PP1640777.Source_));
      SELF := __PP1640777;
    END;
    SELF.Data_Sources_ := __PROJECT(__EE1640776,__ND1640781__Project(LEFT));
    SELF.Input_S_S_N_Match_ := FN_Compile(__cfg).FN_Edit_Distance_Within_Radius(__ECAST(KEL.typ.nstr,__PP1640602.Social_),__ECAST(KEL.typ.nstr,__PP1640602.P___Inp_Cln_S_S_N_),__ECAST(KEL.typ.nint,__CN(2)));
    SELF := __PP1640602;
  END;
  EXPORT __ENH_Person_S_S_N_6 := PROJECT(__EE1640601,__ND1640971__Project(LEFT));
END;
