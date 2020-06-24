//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Person_Vehicle_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Person_Vehicle().__Result) __E_Person_Vehicle := E_Person_Vehicle(__in,__cfg).__Result;
  SHARED __EE1154354 := __E_Person_Vehicle;
  EXPORT __ST146340_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Registration_Layout) Registration_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Title_Layout) Title_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Counts_Model_Layout) Counts_Model_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST146340_Layout __ND1154306__Project(E_Person_Vehicle(__in,__cfg).Layout __PP1153675) := TRANSFORM
    __EE1154281 := __PP1153675.Counts_Model_;
    __CC9239 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('vehicle_build_version'))),__CN(__cfg.CurrentDate));
    __EE1154301 := __PP1153675.Counts_Model_;
    SELF.Date_First_Seen_Capped_ := IF(__T(__OP2(KEL.Aggregates.MinNN(__EE1154281,KEL.era.ToDate(__T(__EE1154281).Date_First_Seen_)),>,__CC9239)),__ECAST(KEL.typ.nkdate,__CC9239),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MinNN(__EE1154301,KEL.era.ToDate(__T(__EE1154301).Date_First_Seen_))));
    SELF := __PP1153675;
  END;
  EXPORT __ENH_Person_Vehicle_3 := PROJECT(__EE1154354,__ND1154306__Project(LEFT));
END;
