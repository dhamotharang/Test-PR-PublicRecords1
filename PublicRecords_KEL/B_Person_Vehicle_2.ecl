//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_Vehicle_3,CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Vehicle_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Vehicle_3(__in,__cfg).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3(__in,__cfg).__ENH_Person_Vehicle_3;
  SHARED __EE8062066 := __ENH_Person_Vehicle_3;
  EXPORT __ST227649_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Registration_Layout) Registration_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Title_Layout) Title_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Counts_Model_Layout) Counts_Model_;
    KEL.typ.ndataset(E_Person_Vehicle(__in,__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nkdate Date_First_Seen_Capped_;
    KEL.typ.nkdate Date_Last_Seen_Capped_;
    KEL.typ.nstr Vehicle_Min_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST227649_Layout __ND8062005__Project(B_Person_Vehicle_3(__in,__cfg).__ST242782_Layout __PP8061736) := TRANSFORM
    __EE8061980 := __PP8061736.Counts_Model_;
    __CC13351 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('vehicle_build_version'))),__CN(__cfg.CurrentDate));
    __EE8062000 := __PP8061736.Counts_Model_;
    SELF.Date_Last_Seen_Capped_ := IF(__T(__OP2(KEL.Aggregates.MaxNN(__EE8061980,KEL.era.ToDate(__T(__EE8061980).Date_Last_Seen_)),>,__CC13351)),__ECAST(KEL.typ.nkdate,__CC13351),__ECAST(KEL.typ.nkdate,KEL.Aggregates.MaxNN(__EE8062000,KEL.era.ToDate(__T(__EE8062000).Date_Last_Seen_))));
    __CC13681 := '-99997';
    SELF.Vehicle_Min_Date_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP8061736.Date_First_Seen_Capped_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,__PP8061736.Date_First_Seen_Capped_,__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13681)));
    SELF := __PP8061736;
  END;
  EXPORT __ENH_Person_Vehicle_2 := PROJECT(__EE8062066,__ND8062005__Project(LEFT));
END;
