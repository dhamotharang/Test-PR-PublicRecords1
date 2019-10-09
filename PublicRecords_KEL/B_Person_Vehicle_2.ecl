//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Person_Vehicle_3,CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Person_Vehicle_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Vehicle_3(__in,__cfg).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3(__in,__cfg).__ENH_Person_Vehicle_3;
  SHARED __EE579773 := __ENH_Person_Vehicle_3;
  EXPORT __ST75996_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Registration_Layout) Registration_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Title_Layout) Title_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Counts_Model_Layout) Counts_Model_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Current_Date_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.nkdate Date_Last_Seen_Capped_;
    KEL.typ.nstr Vehicle_Min_Date_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST75996_Layout __ND579711__Project(B_Person_Vehicle_3(__in,__cfg).__ST81167_Layout __PP579029) := TRANSFORM
    __EE579684 := __PP579029.Counts_Model_;
    __EE579706 := __PP579029.Counts_Model_;
    SELF.Date_Last_Seen_Capped_ := IF(__T(__OP2(KEL.Aggregates.MaxNN(__EE579684,KEL.era.ToDate(__T(__EE579684).Date_Last_Seen_)),>,__PP579029.Current_Date_)),__ECAST(KEL.typ.nkdate,__PP579029.Current_Date_),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MaxNN(__EE579706,KEL.era.ToDate(__T(__EE579706).Date_Last_Seen_))));
    __CC8099 := '-99997';
    SELF.Vehicle_Min_Date_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP579029.Date_First_Seen_Capped_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,__PP579029.Date_First_Seen_Capped_,__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC8099)));
    SELF := __PP579029;
  END;
  EXPORT __ENH_Person_Vehicle_2 := PROJECT(__EE579773,__ND579711__Project(LEFT));
END;
