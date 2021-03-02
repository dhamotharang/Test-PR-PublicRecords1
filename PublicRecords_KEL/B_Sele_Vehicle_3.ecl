//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Sele_Vehicle,E_Vehicle,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_Vehicle_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Sele_Vehicle(__in,__cfg).__Result) __E_Sele_Vehicle := E_Sele_Vehicle(__in,__cfg).__Result;
  SHARED __EE6904553 := __E_Sele_Vehicle;
  EXPORT __ST245743_Layout := RECORD
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
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.nkdate Date_Last_Seen_Capped_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST245743_Layout __ND6904461__Project(E_Sele_Vehicle(__in,__cfg).Layout __PP1287553) := TRANSFORM
    __EE6904436 := __PP1287553.Counts_Model_;
    __CC13370 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('vehicle_build_version'))),__CN(__cfg.CurrentDate));
    __EE6904456 := __PP1287553.Counts_Model_;
    SELF.Date_First_Seen_Capped_ := IF(__T(__OP2(KEL.Aggregates.MinNN(__EE6904436,KEL.era.ToDate(__T(__EE6904436).Date_First_Seen_)),>,__CC13370)),__ECAST(KEL.typ.nkdate,__CC13370),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MinNN(__EE6904456,KEL.era.ToDate(__T(__EE6904456).Date_First_Seen_))));
    __EE6904473 := __PP1287553.Counts_Model_;
    __EE6904493 := __PP1287553.Counts_Model_;
    SELF.Date_Last_Seen_Capped_ := IF(__T(__OP2(KEL.Aggregates.MaxNN(__EE6904473,KEL.era.ToDate(__T(__EE6904473).Date_Last_Seen_)),>,__CC13370)),__ECAST(KEL.typ.nkdate,__CC13370),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MaxNN(__EE6904493,KEL.era.ToDate(__T(__EE6904493).Date_Last_Seen_))));
    SELF := __PP1287553;
  END;
  EXPORT __ENH_Sele_Vehicle_3 := PROJECT(__EE6904553,__ND6904461__Project(LEFT));
END;
