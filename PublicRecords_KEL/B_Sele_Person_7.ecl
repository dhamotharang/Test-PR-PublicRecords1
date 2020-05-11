//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Person,E_Sele_Person,E_Surname FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Sele_Person_7(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Sele_Person().__Result) __E_Sele_Person := E_Sele_Person(__in,__cfg).__Result;
  SHARED __EE327185 := __E_Sele_Person;
  EXPORT __ST167249_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Person().Typ) Contact_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
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
  SHARED __ST167249_Layout __ND327149__Project(E_Sele_Person(__in,__cfg).Layout __PP326792) := TRANSFORM
    __EE327144 := __PP326792.Contact_Info_;
    SELF.Assoc_Date_ := KEL.Aggregates.MaxNN(__EE327144,KEL.era.ToDate(__T(__EE327144).Date_Last_Seen_));
    SELF := __PP326792;
  END;
  EXPORT __ENH_Sele_Person_7 := PROJECT(__EE327185,__ND327149__Project(LEFT));
END;
