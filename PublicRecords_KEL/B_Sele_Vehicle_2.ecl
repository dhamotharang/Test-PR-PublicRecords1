//HPCC Systems KEL Compiler Version 1.3.0
IMPORT KEL13 AS KEL;
IMPORT B_Sele_Vehicle_3,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_Vehicle,E_Vehicle,FN_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT B_Sele_Vehicle_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Vehicle_3(__in,__cfg).__ENH_Sele_Vehicle_3) __ENH_Sele_Vehicle_3 := B_Sele_Vehicle_3(__in,__cfg).__ENH_Sele_Vehicle_3;
  SHARED __EE4654439 := __ENH_Sele_Vehicle_3;
  EXPORT __ST173279_Layout := RECORD
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
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_First_Seen_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST173279_Layout __ND4654380__Project(B_Sele_Vehicle_3(__in,__cfg).__ST185342_Layout __PP4654122) := TRANSFORM
    __CC10427 := KEL.Routines.MinN(FN_Compile(__cfg).FN_G_E_T_B_U_I_L_D_D_A_T_E(__ECAST(KEL.typ.nstr,__CN('vehicle_build_version'))),__CN(__cfg.CurrentDate));
    __CC10734 := 730;
    SELF.Seen___In___Last___Two___Years_ := __OP2(__FN2(KEL.Routines.DaysBetween,__PP4654122.Date_Last_Seen_Capped_,__CC10427),<=,__CN(__CC10734));
    __CC10730 := '-99997';
    SELF.Vehicle_Min_Date_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP4654122.Date_First_Seen_Capped_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,__PP4654122.Date_First_Seen_Capped_,__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC10730)));
    __EE4654371 := __PP4654122.Registration_;
    __BS4654358 := __T(__EE4654371);
    __EE4654375 := __BN(TOPN(__BS4654358(__NN(KEL.era.ToDate(__T(__EE4654371).Date_Last_Seen_))),1, -__T(KEL.era.ToDate(__T(__EE4654371).Date_Last_Seen_)),__T(Registration_First_Date_),__T(Registration_Earliest_Effective_Date_),__T(Registration_Latest_Effective_Date_),__T(Registration_Latest_Expiratione_Date_),__T(Registration_Record_Count_),__T(Registration_Decal_Number_),__T(Registratoin_Decal_Year_),__T(Registration_Status_Code_),__T(Registration_Status_Description_),__T(Registration_True_License_Plate_),__T(Registration_License_Plate_),__T(Registration_License_State_),__T(Registration_License_Plate_Type_Code_),__T(Registration_License_Plate_Type_Description_),__T(Registration_Previous_License_State_),__T(Registration_Previous_License_Plate_)),__NL(__EE4654371));
    SELF.Vehicle_Type_Code_ := (__T(__EE4654375))[1].Registration_License_Plate_Type_Code_;
    SELF := __PP4654122;
  END;
  EXPORT __ENH_Sele_Vehicle_2 := PROJECT(__EE4654439,__ND4654380__Project(LEFT));
END;
