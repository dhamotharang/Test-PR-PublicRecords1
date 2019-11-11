//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Sele_Vehicle_3,CFG_Compile,E_Business_Org,E_Business_Sele,E_Business_Ult,E_Sele_Vehicle,E_Vehicle FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT B_Sele_Vehicle_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  SHARED VIRTUAL TYPEOF(B_Sele_Vehicle_3(__in,__cfg).__ENH_Sele_Vehicle_3) __ENH_Sele_Vehicle_3 := B_Sele_Vehicle_3(__in,__cfg).__ENH_Sele_Vehicle_3;
  SHARED __EE673884 := __ENH_Sele_Vehicle_3;
  EXPORT __ST83412_Layout := RECORD
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
    KEL.typ.nbool Seen___In___Last___Two___Years_;
    KEL.typ.nstr Vehicle_Min_Date_;
    KEL.typ.nstr Vehicle_Type_Code_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST83412_Layout __ND673814__Project(B_Sele_Vehicle_3(__in,__cfg).__ST88837_Layout __PP672753) := TRANSFORM
    __CC8015 := 730;
    SELF.Seen___In___Last___Two___Years_ := __OP2(__FN2(KEL.Routines.DaysBetween,__PP672753.Date_Last_Seen_Capped_,__PP672753.Current_Date_),<=,__CN(__CC8015));
    __CC8011 := '-99997';
    SELF.Vehicle_Min_Date_ := IF(__T(__FN1(KEL.Routines.IsValidDate,__PP672753.Date_First_Seen_Capped_)),__ECAST(KEL.typ.nstr,__FN2(KEL.Routines.DateToString,__PP672753.Date_First_Seen_Capped_,__CN('%Y%m%d'))),__ECAST(KEL.typ.nstr,__CN(__CC8011)));
    __EE673805 := __PP672753.Registration_;
    __BS673792 := __T(__EE673805);
    __EE673809 := __BN(TOPN(__BS673792(__NN(KEL.era.ToDate(__T(__EE673805).Date_Last_Seen_))),1, -__T(KEL.era.ToDate(__T(__EE673805).Date_Last_Seen_)),__T(Registration_First_Date_),__T(Registration_Earliest_Effective_Date_),__T(Registration_Latest_Effective_Date_),__T(Registration_Latest_Expiratione_Date_),__T(Registration_Record_Count_),__T(Registration_Decal_Number_),__T(Registratoin_Decal_Year_),__T(Registration_Status_Code_),__T(Registration_Status_Description_),__T(Registration_True_License_Plate_),__T(Registration_License_Plate_),__T(Registration_License_State_),__T(Registration_License_Plate_Type_Code_),__T(Registration_License_Plate_Type_Description_),__T(Registration_Previous_License_State_),__T(Registration_Previous_License_Plate_),__T(Date_Vendor_First_Reported_),__T(Date_Vendor_Last_Reported_)),__NL(__EE673805));
    SELF.Vehicle_Type_Code_ := (__T(__EE673809))[1].Registration_License_Plate_Type_Code_;
    SELF := __PP672753;
  END;
  EXPORT __ENH_Sele_Vehicle_2 := PROJECT(__EE673884,__ND673814__Project(LEFT));
END;
