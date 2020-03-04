//HPCC Systems KEL Compiler Version 1.2.0beta4
IMPORT KEL12 AS KEL;
IMPORT B_Person_Vehicle_10,CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Person_Vehicle_9(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Vehicle_10(__cfg).__ENH_Person_Vehicle_10) __ENH_Person_Vehicle_10 := B_Person_Vehicle_10(__cfg).__ENH_Person_Vehicle_10;
  SHARED __EE14152 := __ENH_Person_Vehicle_10;
  EXPORT __ST11726_Layout := RECORD
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
  SHARED __ST11726_Layout __ND14103__Project(B_Person_Vehicle_10(__cfg).__ST12028_Layout __PP13454) := TRANSFORM
    __EE14076 := __PP13454.Counts_Model_;
    __EE14098 := __PP13454.Counts_Model_;
    SELF.Date_First_Seen_Capped_ := IF(__T(__OP2(KEL.Aggregates.MinNN(__EE14076,KEL.era.ToDate(__T(__EE14076).Date_First_Seen_)),>,__PP13454.Current_Date_)),__ECAST(KEL.typ.nkdate,__PP13454.Current_Date_),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MinNN(__EE14098,KEL.era.ToDate(__T(__EE14098).Date_First_Seen_))));
    SELF := __PP13454;
  END;
  EXPORT __ENH_Person_Vehicle_9 := PROJECT(__EE14152,__ND14103__Project(LEFT));
END;
