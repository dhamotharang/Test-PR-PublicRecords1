﻿//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_Vehicle,E_Vehicle,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT B_Sele_Vehicle_3(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(E_Sele_Vehicle().__Result) __E_Sele_Vehicle := E_Sele_Vehicle(__in,__cfg).__Result;
  SHARED __EE1117638 := __E_Sele_Vehicle;
  EXPORT __ST147626_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST147626_Layout __ND1117546__Project(E_Sele_Vehicle(__in,__cfg).Layout __PP1116659) := TRANSFORM
    __EE1117521 := __PP1116659.Counts_Model_;
    __CC9584 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('vehicle_build_version'))),__CN(__cfg.CurrentDate));
    __EE1117541 := __PP1116659.Counts_Model_;
    SELF.Date_First_Seen_Capped_ := IF(__T(__OP2(KEL.Aggregates.MinNN(__EE1117521,KEL.era.ToDate(__T(__EE1117521).Date_First_Seen_)),>,__CC9584)),__ECAST(KEL.typ.nkdate,__CC9584),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MinNN(__EE1117541,KEL.era.ToDate(__T(__EE1117541).Date_First_Seen_))));
    __EE1117558 := __PP1116659.Counts_Model_;
    __EE1117578 := __PP1116659.Counts_Model_;
    SELF.Date_Last_Seen_Capped_ := IF(__T(__OP2(KEL.Aggregates.MaxNN(__EE1117558,KEL.era.ToDate(__T(__EE1117558).Date_Last_Seen_)),>,__CC9584)),__ECAST(KEL.typ.nkdate,__CC9584),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MaxNN(__EE1117578,KEL.era.ToDate(__T(__EE1117578).Date_Last_Seen_))));
    SELF := __PP1116659;
  END;
  EXPORT __ENH_Sele_Vehicle_3 := PROJECT(__EE1117638,__ND1117546__Project(LEFT));
END;
