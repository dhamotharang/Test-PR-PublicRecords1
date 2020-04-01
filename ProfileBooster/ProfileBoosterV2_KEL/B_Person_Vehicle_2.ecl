﻿//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Person_Vehicle_3,B_Person_Vehicle_5,CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle FROM ProfileBooster.ProfileBoosterV2_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Person_Vehicle_2(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Vehicle_3(__cfg).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3(__cfg).__ENH_Person_Vehicle_3;
  SHARED __EE84103 := __ENH_Person_Vehicle_3;
  EXPORT __ST12773_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Registration_Layout) Registration_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Title_Layout) Title_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Counts_Model_Layout) Counts_Model_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nint Age_At_First_Seen_;
    KEL.typ.nfloat Age_Year_At_First_Seen_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.nkdate Date_Last_Seen_Capped_;
    KEL.typ.nint Depreciated_Price_;
    KEL.typ.nbool Flag_Depreciated_Price_;
    KEL.typ.nstr Vehicle_Min_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
    UNSIGNED4 __Part := 0;
  END;
  SHARED __ST12773_Layout __ND84042__Project(B_Person_Vehicle_5(__cfg).__ST10168_Layout __PP83321) := TRANSFORM
    __EE84015 := __PP83321.Counts_Model_;
    __EE84037 := __PP83321.Counts_Model_;
    SELF.Date_Last_Seen_Capped_ := IF(__T(__OP2(KEL.Aggregates.MaxNN(__EE84015,KEL.era.ToDate(__T(__EE84015).Date_Last_Seen_)),>,__PP83321.Current_Date_)),__ECAST(KEL.typ.nkdate,__PP83321.Current_Date_),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MaxNN(__EE84037,KEL.era.ToDate(__T(__EE84037).Date_Last_Seen_))));
    SELF := __PP83321;
  END;
  EXPORT __ENH_Person_Vehicle_2 := PROJECT(__EE84103,__ND84042__Project(LEFT));
END;
