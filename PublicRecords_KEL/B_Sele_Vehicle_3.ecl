﻿//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Sele_Vehicle_4,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_Vehicle,E_Vehicle FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Sele_Vehicle_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Vehicle_4(__in,__cfg).__ENH_Sele_Vehicle_4) __ENH_Sele_Vehicle_4 := B_Sele_Vehicle_4(__in,__cfg).__ENH_Sele_Vehicle_4;
  SHARED __EE382126 := __ENH_Sele_Vehicle_4;
  EXPORT __ST88837_Layout := RECORD
    KEL.typ.ntyp(E_Business_Sele().Typ) Legal_;
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.nint Ult_I_D_;
    KEL.typ.nint Org_I_D_;
    KEL.typ.nint Sele_I_D_;
    KEL.typ.nstr Vehicle_Key_;
    KEL.typ.ndataset(E_Sele_Vehicle(__in,__cfg).Party_Layout) Party_;
    KEL.typ.ndataset(E_Sele_Vehicle(__in,__cfg).Registration_Layout) Registration_;
    KEL.typ.ndataset(E_Sele_Vehicle(__in,__cfg).Title_Layout) Title_;
    KEL.typ.ndataset(E_Sele_Vehicle(__in,__cfg).Counts_Model_Layout) Counts_Model_;
    KEL.typ.ndataset(E_Sele_Vehicle(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.nkdate Date_Last_Seen_Capped_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST88837_Layout __ND382021__Project(B_Sele_Vehicle_4(__in,__cfg).__ST93206_Layout __PP381001) := TRANSFORM
    __EE381994 := __PP381001.Counts_Model_;
    __EE382016 := __PP381001.Counts_Model_;
    SELF.Date_First_Seen_Capped_ := IF(__T(__OP2(KEL.Aggregates.MinNN(__EE381994,KEL.era.ToDate(__T(__EE381994).Date_First_Seen_)),>,__PP381001.Current_Date_)),__ECAST(KEL.typ.nkdate,__PP381001.Current_Date_),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MinNN(__EE382016,KEL.era.ToDate(__T(__EE382016).Date_First_Seen_))));
    __EE382033 := __PP381001.Counts_Model_;
    __EE382055 := __PP381001.Counts_Model_;
    SELF.Date_Last_Seen_Capped_ := IF(__T(__OP2(KEL.Aggregates.MaxNN(__EE382033,KEL.era.ToDate(__T(__EE382033).Date_Last_Seen_)),>,__PP381001.Current_Date_)),__ECAST(KEL.typ.nkdate,__PP381001.Current_Date_),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MaxNN(__EE382055,KEL.era.ToDate(__T(__EE382055).Date_Last_Seen_))));
    SELF := __PP381001;
  END;
  EXPORT __ENH_Sele_Vehicle_3 := PROJECT(__EE382126,__ND382021__Project(LEFT));
END;
