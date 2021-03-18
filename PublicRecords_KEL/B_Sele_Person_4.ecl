//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_First_Degree_Relative_5,B_Sele_Person_5,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_First_Degree_Relative,E_Person,E_Sele_Person,E_Surname FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_Person_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_First_Degree_Relative_5(__in,__cfg).__ENH_First_Degree_Relative_5) __ENH_First_Degree_Relative_5 := B_First_Degree_Relative_5(__in,__cfg).__ENH_First_Degree_Relative_5;
  SHARED VIRTUAL TYPEOF(B_Sele_Person_5(__in,__cfg).__ENH_Sele_Person_5) __ENH_Sele_Person_5 := B_Sele_Person_5(__in,__cfg).__ENH_Sele_Person_5;
  SHARED __EE5770350 := __ENH_Sele_Person_5;
  SHARED __EE5770353 := __ENH_First_Degree_Relative_5;
  SHARED __ST5770707_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Person().Typ) Relative_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __EE5770711 := PROJECT(TABLE(PROJECT(__EE5770353,__ST5770707_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Subject_,Relative_},Subject_,Relative_,MERGE),__ST5770707_Layout);
  SHARED __ST5770726_Layout := RECORD
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
    KEL.typ.ndataset(__ST5770707_Layout) First_Degree_Relative_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC5770887(B_Sele_Person_5(__in,__cfg).__ST254989_Layout __EE5770350, __ST5770707_Layout __EE5770711) := __EEQP(__EE5770350.Contact_,__EE5770711.Subject_) AND __T(__AND(__EEQ(__EE5770350.Contact_,__EE5770711.Subject_),__CN(__NN(__EE5770350.Contact_))));
  __ST5770726_Layout __Join__ST5770726_Layout(B_Sele_Person_5(__in,__cfg).__ST254989_Layout __r, DATASET(__ST5770707_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.First_Degree_Relative_ := __CN(__recs);
  END;
  SHARED __EE5770925 := DENORMALIZE(DISTRIBUTE(__EE5770350,HASH(Contact_)),DISTRIBUTE(__EE5770711,HASH(Subject_)),__JC5770887(LEFT,RIGHT),GROUP,__Join__ST5770726_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST117437_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Relative_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST248354_Layout := RECORD
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
    KEL.typ.ndataset(__ST117437_Layout) Relatives_;
    KEL.typ.nbool Two_Years_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST248354_Layout __ND5770934__Project(__ST5770726_Layout __PP5770930) := TRANSFORM
    __BS5770987 := __T(__PP5770930.Contact_Info_);
    SELF.Is_Executive_Ever_ := EXISTS(__BS5770987(__T(__OP2(__T(__PP5770930.Contact_Info_).Is_Executive_,=,__CN(TRUE)))));
    __EE5770928 := __PP5770930.First_Degree_Relative_;
    SELF.Relatives_ := __PROJECT(__EE5770928,__ST117437_Layout);
    SELF := __PP5770930;
  END;
  EXPORT __ENH_Sele_Person_4 := PROJECT(__EE5770925,__ND5770934__Project(LEFT));
END;
