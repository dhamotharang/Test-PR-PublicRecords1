//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Aircraft_Owner_4,CFG_Compile,E_Aircraft,E_Aircraft_Owner,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Aircraft_Owner_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Aircraft_Owner_4(__in,__cfg).__ENH_Aircraft_Owner_4) __ENH_Aircraft_Owner_4 := B_Aircraft_Owner_4(__in,__cfg).__ENH_Aircraft_Owner_4;
  SHARED __EE223287 := __ENH_Aircraft_Owner_4;
  EXPORT __ST82530_Layout := RECORD
    KEL.typ.ntyp(E_Aircraft().Typ) Plane_;
    KEL.typ.ntyp(E_Person().Typ) Owner_;
    KEL.typ.nint Registrant_Type_;
    KEL.typ.nkdate Certificate_Issue_Date_;
    KEL.typ.nstr Certification_;
    KEL.typ.ndataset(E_Aircraft_Owner(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST82530_Layout __ND223300__Project(B_Aircraft_Owner_4(__in,__cfg).__ST87868_Layout __PP223214) := TRANSFORM
    SELF.Date_First_Seen_Capped_ := IF(__T(__OP2(KEL.era.ToDate(__PP223214.Date_First_Seen_),>,__PP223214.Current_Date_)),__ECAST(KEL.typ.nkdate,__PP223214.Current_Date_),__ECAST(KEL.typ.nkdate,KEL.era.ToDate(__PP223214.Date_First_Seen_)));
    SELF := __PP223214;
  END;
  EXPORT __ENH_Aircraft_Owner_3 := PROJECT(__EE223287,__ND223300__Project(LEFT));
END;
