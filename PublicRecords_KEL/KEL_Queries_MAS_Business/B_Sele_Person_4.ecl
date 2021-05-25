//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT B_First_Degree_Relative_5,B_Sele_Person_5,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_First_Degree_Relative,E_Person,E_Sele_Person,E_Surname FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_Person_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_First_Degree_Relative_5(__in,__cfg).__ENH_First_Degree_Relative_5) __ENH_First_Degree_Relative_5 := B_First_Degree_Relative_5(__in,__cfg).__ENH_First_Degree_Relative_5;
  SHARED VIRTUAL TYPEOF(B_Sele_Person_5(__in,__cfg).__ENH_Sele_Person_5) __ENH_Sele_Person_5 := B_Sele_Person_5(__in,__cfg).__ENH_Sele_Person_5;
  SHARED __EE2124520 := __ENH_Sele_Person_5;
  SHARED __EE2124523 := __ENH_First_Degree_Relative_5;
  SHARED __ST2124877_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Person().Typ) Relative_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE2124881 := PROJECT(TABLE(PROJECT(__EE2124523,__ST2124877_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Subject_,Relative_},Subject_,Relative_,MERGE),__ST2124877_Layout);
  SHARED __ST2124896_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Contact_Info_Layout) Contact_Info_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.nkdate Assoc_Date_;
    KEL.typ.nbool Two_Years_;
    KEL.typ.ndataset(__ST2124877_Layout) First_Degree_Relative_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC2125057(B_Sele_Person_5(__in,__cfg).__ST217466_Layout __EE2124520, __ST2124877_Layout __EE2124881) := __EEQP(__EE2124520.Contact_,__EE2124881.Subject_) AND __T(__AND(__EEQ(__EE2124520.Contact_,__EE2124881.Subject_),__CN(__NN(__EE2124520.Contact_))));
  __ST2124896_Layout __Join__ST2124896_Layout(B_Sele_Person_5(__in,__cfg).__ST217466_Layout __r, DATASET(__ST2124877_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.First_Degree_Relative_ := __CN(__recs);
  END;
  SHARED __EE2125095 := DENORMALIZE(DISTRIBUTE(__EE2124520,HASH(Contact_)),DISTRIBUTE(__EE2124881,HASH(Subject_)),__JC2125057(LEFT,RIGHT),GROUP,__Join__ST2124896_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST106737_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Relative_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST213095_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Contact_Info_Layout) Contact_Info_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint Age_In_Days_;
    KEL.typ.nkdate Assoc_Date_;
    KEL.typ.bool Is_Executive_Ever_ := FALSE;
    KEL.typ.ndataset(__ST106737_Layout) Relatives_;
    KEL.typ.nbool Two_Years_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST213095_Layout __ND2125104__Project(__ST2124896_Layout __PP2125100) := TRANSFORM
    __BS2125157 := __T(__PP2125100.Contact_Info_);
    SELF.Is_Executive_Ever_ := EXISTS(__BS2125157(__T(__OP2(__T(__PP2125100.Contact_Info_).Is_Executive_,=,__CN(TRUE)))));
    __EE2125098 := __PP2125100.First_Degree_Relative_;
    SELF.Relatives_ := __PROJECT(__EE2125098,__ST106737_Layout);
    SELF := __PP2125100;
  END;
  EXPORT __ENH_Sele_Person_4 := PROJECT(__EE2125095,__ND2125104__Project(LEFT));
END;
