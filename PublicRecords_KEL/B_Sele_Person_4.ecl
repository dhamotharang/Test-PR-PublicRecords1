//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT B_First_Degree_Relative_5,B_Sele_Person_5,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_First_Degree_Relative,E_Person,E_Sele_Person,E_Surname FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Sele_Person_4(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_First_Degree_Relative_5().__ENH_First_Degree_Relative_5) __ENH_First_Degree_Relative_5 := B_First_Degree_Relative_5(__in,__cfg).__ENH_First_Degree_Relative_5;
  SHARED VIRTUAL TYPEOF(B_Sele_Person_5().__ENH_Sele_Person_5) __ENH_Sele_Person_5 := B_Sele_Person_5(__in,__cfg).__ENH_Sele_Person_5;
  SHARED __EE712341 := __ENH_Sele_Person_5;
  SHARED __EE712284 := __ENH_First_Degree_Relative_5;
  SHARED __ST712655_Layout := RECORD
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
    KEL.typ.ndataset(E_First_Degree_Relative(__in,__cfg).Layout) First_Degree_Relative_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC712903(B_Sele_Person_5(__in,__cfg).__ST161213_Layout __EE712341, E_First_Degree_Relative(__in,__cfg).Layout __EE712284) := __EEQP(__EE712341.Contact_,__EE712284.Subject_) AND __T(__AND(__EEQ(__EE712341.Contact_,__EE712284.Subject_),__CN(__NN(__EE712341.Contact_))));
  __ST712655_Layout __Join__ST712655_Layout(B_Sele_Person_5(__in,__cfg).__ST161213_Layout __r, DATASET(E_First_Degree_Relative(__in,__cfg).Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.First_Degree_Relative_ := __CN(__recs);
  END;
  SHARED __EE712949 := DENORMALIZE(DISTRIBUTE(__EE712341,HASH(Contact_)),DISTRIBUTE(__EE712284,HASH(Subject_)),__JC712903(LEFT,RIGHT),GROUP,__Join__ST712655_Layout(LEFT,ROWS(RIGHT)),LOCAL);
  EXPORT __ST76766_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Relative_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __ST156043_Layout := RECORD
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
    KEL.typ.ndataset(__ST76766_Layout) Relatives_;
    KEL.typ.nbool Two_Years_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST156043_Layout __ND712958__Project(__ST712655_Layout __PP712954) := TRANSFORM
    __BS713011 := __T(__PP712954.Contact_Info_);
    SELF.Is_Executive_Ever_ := EXISTS(__BS713011(__T(__OP2(__T(__PP712954.Contact_Info_).Is_Executive_,=,__CN(TRUE)))));
    __EE712952 := __PP712954.First_Degree_Relative_;
    SELF.Relatives_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE712952),__ST76766_Layout)(__NN(Relative_)),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Relative_},Relative_,MERGE),__ST76766_Layout),__NL(__EE712952));
    SELF := __PP712954;
  END;
  EXPORT __ENH_Sele_Person_4 := PROJECT(PROJECT(__EE712949,__ND712958__Project(LEFT)),__ST156043_Layout);
END;
