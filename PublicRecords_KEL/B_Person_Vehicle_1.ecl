﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Person_Vehicle_2,CFG_Compile,E_Person,E_Person_Vehicle,E_Vehicle,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Person_Vehicle_1(CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Person_Vehicle_2(__cfg).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2(__cfg).__ENH_Person_Vehicle_2;
  SHARED __EE8515970 := __ENH_Person_Vehicle_2;
  EXPORT __ST197878_Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Vehicle().Typ) Automobile_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Registration_Layout) Registration_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Title_Layout) Title_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Counts_Model_Layout) Counts_Model_;
    KEL.typ.ndataset(E_Person_Vehicle(__cfg).Data_Sources_Layout) Data_Sources_;
    KEL.typ.nbool Seen___In___Last___Ten___Years_;
    KEL.typ.nbool Seen___In___Last___Two___Years_;
    KEL.typ.nstr Vehicle_Max_Date_;
    KEL.typ.nstr Vehicle_Min_Date_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST197878_Layout __ND8516138__Project(B_Person_Vehicle_2(__cfg).__ST216661_Layout __PP8515971) := TRANSFORM
    __CC14514 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('vehicle_build_version'))),__CN(__cfg.CurrentDate));
    __CC14830 := 3652;
    SELF.Seen___In___Last___Ten___Years_ := __OP2(__FN2(KEL.Routines.DaysBetween,__PP8515971.Date_Last_Seen_Capped_,__CC14514),<=,__CN(__CC14830));
    __CC14832 := 730;
    SELF.Seen___In___Last___Two___Years_ := __OP2(__FN2(KEL.Routines.DaysBetween,__PP8515971.Date_Last_Seen_Capped_,__CC14514),<=,__CN(__CC14832));
    __CC14828 := '-99997';
    SELF.Vehicle_Max_Date_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP8515971.Date_Last_Seen_Capped_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,__PP8515971.Date_Last_Seen_Capped_,__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC14828)));
    SELF := __PP8515971;
  END;
  EXPORT __ENH_Person_Vehicle_1 := PROJECT(__EE8515970,__ND8516138__Project(LEFT));
END;
