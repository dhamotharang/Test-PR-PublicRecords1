//HPCC Systems KEL Compiler Version 1.6.0
IMPORT KEL16 AS KEL;
IMPORT CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle,FN_Compile FROM PublicRecords_KEL.KEL_Queries_MAS_NonFCRA;
IMPORT * FROM KEL16.Null;
EXPORT B_Person_Vehicle_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Person_Vehicle(__in,__cfg).__Result) __E_Person_Vehicle := E_Person_Vehicle(__in,__cfg).__Result;
  SHARED __EE1919163 := __E_Person_Vehicle;
  EXPORT __ST177258_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Registration_Layout) Registration_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Title_Layout) Title_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Counts_Model_Layout) Counts_Model_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.nkdate Date_Last_Seen_Capped_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST177258_Layout __ND1919078__Project(E_Person_Vehicle(__in,__cfg).Layout __PP469598) := TRANSFORM
    __EE1919053 := __PP469598.Counts_Model_;
    __CC13459 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('vehicle_build_version'))),__CN(__cfg.CurrentDate));
    __EE1919073 := __PP469598.Counts_Model_;
    SELF.Date_First_Seen_Capped_ := IF(__T(__OP2(KEL.Aggregates.MinNN(__EE1919053,KEL.era.ToDate(__T(__EE1919053).Date_First_Seen_)),>,__CC13459)),__ECAST(KEL.typ.nkdate,__CC13459),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MinNN(__EE1919073,KEL.era.ToDate(__T(__EE1919073).Date_First_Seen_))));
    __EE1919090 := __PP469598.Counts_Model_;
    __EE1919110 := __PP469598.Counts_Model_;
    SELF.Date_Last_Seen_Capped_ := IF(__T(__OP2(KEL.Aggregates.MaxNN(__EE1919090,KEL.era.ToDate(__T(__EE1919090).Date_Last_Seen_)),>,__CC13459)),__ECAST(KEL.typ.nkdate,__CC13459),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MaxNN(__EE1919110,KEL.era.ToDate(__T(__EE1919110).Date_Last_Seen_))));
    SELF := __PP469598;
  END;
  EXPORT __ENH_Person_Vehicle_3 := PROJECT(__EE1919163,__ND1919078__Project(LEFT));
END;
