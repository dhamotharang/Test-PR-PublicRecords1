//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Person,E_Sele_Person,E_Surname FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Sele_Person_6(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Sele_Person(__in,__cfg).__Result) __E_Sele_Person := E_Sele_Person(__in,__cfg).__Result;
  SHARED __EE236533 := __E_Sele_Person;
  EXPORT __ST145577_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Contact_Info_Layout) Contact_Info_;
    KEL.typ.ndataset(E_Sele_Person(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Assoc_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST145577_Layout __ND236500__Project(E_Sele_Person(__in,__cfg).Layout __PP236173) := TRANSFORM
    __EE236495 := __PP236173.Contact_Info_;
    SELF.Assoc_Date_ := KEL.Aggregates.MaxNN(__EE236495,KEL.era.ToDate(__T(__EE236495).Date_Last_Seen_));
    SELF := __PP236173;
  END;
  EXPORT __ENH_Sele_Person_6 := PROJECT(__EE236533,__ND236500__Project(LEFT));
END;
