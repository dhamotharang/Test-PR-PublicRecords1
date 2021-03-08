//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Person_Vehicle_12,CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Person_Vehicle_11(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Vehicle_12(__cfg).__ENH_Person_Vehicle_12) __ENH_Person_Vehicle_12 := B_Person_Vehicle_12(__cfg).__ENH_Person_Vehicle_12;
  SHARED __EE15585 := __ENH_Person_Vehicle_12;
  EXPORT __ST12271_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Registration_Layout) Registration_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Title_Layout) Title_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Counts_Model_Layout) Counts_Model_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  SHARED __ST12271_Layout __ND15536__Project(B_Person_Vehicle_12(__cfg).__ST12565_Layout __PP14887) := TRANSFORM
    __EE15509 := __PP14887.Counts_Model_;
    __EE15531 := __PP14887.Counts_Model_;
    SELF.Date_First_Seen_Capped_ := IF(__T(__OP2(KEL.Aggregates.MinNN(__EE15509,KEL.era.ToDate(__T(__EE15509).Date_First_Seen_)),>,__PP14887.Current_Date_)),__ECAST(KEL.typ.nkdate,__PP14887.Current_Date_),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MinNN(__EE15531,KEL.era.ToDate(__T(__EE15531).Date_First_Seen_))));
    SELF := __PP14887;
  END;
  EXPORT __ENH_Person_Vehicle_11 := PROJECT(__EE15585,__ND15536__Project(LEFT));
END;
