//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Aircraft_Owner_4,CFG_Compile,E_Aircraft,E_Aircraft_Owner,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Aircraft_Owner_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Aircraft_Owner_4(__in,__cfg).__ENH_Aircraft_Owner_4) __ENH_Aircraft_Owner_4 := B_Aircraft_Owner_4(__in,__cfg).__ENH_Aircraft_Owner_4;
  SHARED __EE209600 := __ENH_Aircraft_Owner_4;
  EXPORT __ST76570_Layout := RECORD
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
  SHARED __ST76570_Layout __ND209613__Project(B_Aircraft_Owner_4(__in,__cfg).__ST81691_Layout __PP209527) := TRANSFORM
    SELF.Date_First_Seen_Capped_ := IF(__T(__OP2(KEL.era.ToDate(__PP209527.Date_First_Seen_),>,__PP209527.Current_Date_)),__ECAST(KEL.typ.nkdate,__PP209527.Current_Date_),__ECAST(KEL.typ.nkdate,KEL.era.ToDate(__PP209527.Date_First_Seen_)));
    SELF := __PP209527;
  END;
  EXPORT __ENH_Aircraft_Owner_3 := PROJECT(__EE209600,__ND209613__Project(LEFT));
END;
