//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Person_Vehicle_4,CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Person_Vehicle_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Vehicle_4(__in,__cfg).__ENH_Person_Vehicle_4) __ENH_Person_Vehicle_4 := B_Person_Vehicle_4(__in,__cfg).__ENH_Person_Vehicle_4;
  SHARED __EE380316 := __ENH_Person_Vehicle_4;
  EXPORT __ST88630_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Registration_Layout) Registration_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Title_Layout) Title_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Counts_Model_Layout) Counts_Model_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST88630_Layout __ND380267__Project(B_Person_Vehicle_4(__in,__cfg).__ST93047_Layout __PP379618) := TRANSFORM
    __EE380240 := __PP379618.Counts_Model_;
    __EE380262 := __PP379618.Counts_Model_;
    SELF.Date_First_Seen_Capped_ := IF(__T(__OP2(KEL.Aggregates.MinNN(__EE380240,KEL.era.ToDate(__T(__EE380240).Date_First_Seen_)),>,__PP379618.Current_Date_)),__ECAST(KEL.typ.nkdate,__PP379618.Current_Date_),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MinNN(__EE380262,KEL.era.ToDate(__T(__EE380262).Date_First_Seen_))));
    SELF := __PP379618;
  END;
  EXPORT __ENH_Person_Vehicle_3 := PROJECT(__EE380316,__ND380267__Project(LEFT));
END;
