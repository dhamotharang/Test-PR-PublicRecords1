//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Watercraft_Owner_4,CFG_Compile,E_Person,E_Watercraft,E_Watercraft_Owner FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Watercraft_Owner_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Watercraft_Owner_4(__in,__cfg).__ENH_Watercraft_Owner_4) __ENH_Watercraft_Owner_4 := B_Watercraft_Owner_4(__in,__cfg).__ENH_Watercraft_Owner_4;
  SHARED __EE360153 := __ENH_Watercraft_Owner_4;
  EXPORT __ST81669_Layout := RECORD
    KEL.typ.ntyp(E_Watercraft().Typ) W_Craft_;
    KEL.typ.ntyp(E_Person().Typ) Owner_;
    KEL.typ.ndataset(E_Watercraft_Owner(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST81669_Layout __ND360163__Project(B_Watercraft_Owner_4(__in,__cfg).__ST85838_Layout __PP360097) := TRANSFORM
    SELF.Date_First_Seen_Capped_ := IF(__T(__OP2(KEL.era.ToDate(__PP360097.Date_First_Seen_),>,__PP360097.Current_Date_)),__ECAST(KEL.typ.nkdate,__PP360097.Current_Date_),__ECAST(KEL.typ.nkdate,KEL.era.ToDate(__PP360097.Date_First_Seen_)));
    SELF := __PP360097;
  END;
  EXPORT __ENH_Watercraft_Owner_3 := PROJECT(__EE360153,__ND360163__Project(LEFT));
END;
