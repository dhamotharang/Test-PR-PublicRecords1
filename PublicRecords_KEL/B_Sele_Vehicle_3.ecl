//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT B_Sele_Vehicle_4,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_Vehicle,E_Vehicle FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Sele_Vehicle_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Vehicle_4(__in,__cfg).__ENH_Sele_Vehicle_4) __ENH_Sele_Vehicle_4 := B_Sele_Vehicle_4(__in,__cfg).__ENH_Sele_Vehicle_4;
  SHARED __EE457641 := __ENH_Sele_Vehicle_4;
  EXPORT __ST101360_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST101360_Layout __ND457546__Project(B_Sele_Vehicle_4(__in,__cfg).__ST106171_Layout __PP456636) := TRANSFORM
    __EE457519 := __PP456636.Counts_Model_;
    __EE457541 := __PP456636.Counts_Model_;
    SELF.Date_First_Seen_Capped_ := IF(__T(__OP2(KEL.Aggregates.MinNN(__EE457519,KEL.era.ToDate(__T(__EE457519).Date_First_Seen_)),>,__PP456636.Current_Date_)),__ECAST(KEL.typ.nkdate,__PP456636.Current_Date_),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MinNN(__EE457541,KEL.era.ToDate(__T(__EE457541).Date_First_Seen_))));
    __EE457558 := __PP456636.Counts_Model_;
    __EE457580 := __PP456636.Counts_Model_;
    SELF.Date_Last_Seen_Capped_ := IF(__T(__OP2(KEL.Aggregates.MaxNN(__EE457558,KEL.era.ToDate(__T(__EE457558).Date_Last_Seen_)),>,__PP456636.Current_Date_)),__ECAST(KEL.typ.nkdate,__PP456636.Current_Date_),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MaxNN(__EE457580,KEL.era.ToDate(__T(__EE457580).Date_Last_Seen_))));
    SELF := __PP456636;
  END;
  EXPORT __ENH_Sele_Vehicle_3 := PROJECT(__EE457641,__ND457546__Project(LEFT));
END;
