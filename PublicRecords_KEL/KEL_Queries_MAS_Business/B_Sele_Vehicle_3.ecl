//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Sele_Vehicle,E_Vehicle,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_Business;
IMPORT * FROM KEL16.Null;
EXPORT B_Sele_Vehicle_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Sele_Vehicle(__in,__cfg).__Result) __E_Sele_Vehicle := E_Sele_Vehicle(__in,__cfg).__Result;
  SHARED __EE2509365 := __E_Sele_Vehicle;
  EXPORT __ST202066_Layout := RECORD
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
  SHARED __ST202066_Layout __ND2509273__Project(E_Sele_Vehicle(__in,__cfg).Layout __PP801641) := TRANSFORM
    __EE2509248 := __PP801641.Counts_Model_;
    __CC13466 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('vehicle_build_version'))),__CN(__cfg.CurrentDate));
    __EE2509268 := __PP801641.Counts_Model_;
    SELF.Date_First_Seen_Capped_ := IF(__T(__OP2(KEL.Aggregates.MinNN(__EE2509248,KEL.era.ToDate(__T(__EE2509248).Date_First_Seen_)),>,__CC13466)),__ECAST(KEL.typ.nkdate,__CC13466),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MinNN(__EE2509268,KEL.era.ToDate(__T(__EE2509268).Date_First_Seen_))));
    __EE2509285 := __PP801641.Counts_Model_;
    __EE2509305 := __PP801641.Counts_Model_;
    SELF.Date_Last_Seen_Capped_ := IF(__T(__OP2(KEL.Aggregates.MaxNN(__EE2509285,KEL.era.ToDate(__T(__EE2509285).Date_Last_Seen_)),>,__CC13466)),__ECAST(KEL.typ.nkdate,__CC13466),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MaxNN(__EE2509305,KEL.era.ToDate(__T(__EE2509305).Date_Last_Seen_))));
    SELF := __PP801641;
  END;
  EXPORT __ENH_Sele_Vehicle_3 := PROJECT(__EE2509365,__ND2509273__Project(LEFT));
END;
