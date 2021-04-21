﻿//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT B_Sele_Vehicle_3,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Sele_Overflow,E_Business_Ult,E_Sele_Vehicle,E_Vehicle,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT B_Sele_Vehicle_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Vehicle_3(__in,__cfg).__ENH_Sele_Vehicle_3) __ENH_Sele_Vehicle_3 := B_Sele_Vehicle_3(__in,__cfg).__ENH_Sele_Vehicle_3;
  SHARED __EE8889011 := __ENH_Sele_Vehicle_3;
  EXPORT __ST239698_Layout := RECORD
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
    KEL.typ.nbool Seen___In___Last___Two___Years_;
    KEL.typ.nstr Vehicle_Min_Date_;
    KEL.typ.nstr Vehicle_Type_Code_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST239698_Layout __ND8888952__Project(B_Sele_Vehicle_3(__in,__cfg).__ST255418_Layout __PP8888617) := TRANSFORM
    __CC13320 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('vehicle_build_version'))),__CN(__cfg.CurrentDate));
    __CC13714 := 730;
    SELF.Seen___In___Last___Two___Years_ := __OP2(__FN2(KEL.Routines.DaysBetween,__PP8888617.Date_Last_Seen_Capped_,__CC13320),<=,__CN(__CC13714));
    __CC13710 := '-99997';
    SELF.Vehicle_Min_Date_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP8888617.Date_First_Seen_Capped_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,__PP8888617.Date_First_Seen_Capped_,__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC13710)));
    __EE8888943 := __PP8888617.Registration_;
    __BS8888930 := __T(__EE8888943);
    __EE8888947 := __BN(TOPN(__BS8888930(__NN(KEL.era.ToDate(__T(__EE8888943).Date_Last_Seen_))),1, -__T(KEL.era.ToDate(__T(__EE8888943).Date_Last_Seen_)),__T(Registration_First_Date_),__T(Registration_Earliest_Effective_Date_),__T(Registration_Latest_Effective_Date_),__T(Registration_Latest_Expiratione_Date_),__T(Registration_Record_Count_),__T(Registration_Decal_Number_),__T(Registratoin_Decal_Year_),__T(Registration_Status_Code_),__T(Registration_Status_Description_),__T(Registration_True_License_Plate_),__T(Registration_License_Plate_),__T(Registration_License_State_),__T(Registration_License_Plate_Type_Code_),__T(Registration_License_Plate_Type_Description_),__T(Registration_Previous_License_State_),__T(Registration_Previous_License_Plate_)),__NL(__EE8888943));
    SELF.Vehicle_Type_Code_ := (__T(__EE8888947))[1].Registration_License_Plate_Type_Code_;
    SELF := __PP8888617;
  END;
  EXPORT __ENH_Sele_Vehicle_2 := PROJECT(__EE8889011,__ND8888952__Project(LEFT));
END;
