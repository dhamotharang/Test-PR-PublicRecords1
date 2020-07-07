//HPCC Systems KEL Compiler Version 1.3.0beta5
IMPORT KEL13 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT B_Address_2,B_Address_3,B_Address_4,B_Address_5,B_Address_6,B_Aircraft_Owner_1,B_Aircraft_Owner_2,B_Aircraft_Owner_3,B_Bankruptcy_1,B_Bankruptcy_2,B_Bankruptcy_3,B_Bankruptcy_4,B_Bankruptcy_5,B_Bankruptcy_6,B_Bankruptcy_7,B_Bankruptcy_8,B_Criminal_Offense_1,B_Criminal_Offense_2,B_Criminal_Offense_3,B_Criminal_Offense_4,B_Criminal_Offense_5,B_Education_1,B_Education_2,B_Education_3,B_Education_4,B_Education_5,B_Education_6,B_Education_7,B_First_Degree_Relative_5,B_Lien_Judgment_10,B_Lien_Judgment_11,B_Lien_Judgment_12,B_Lien_Judgment_9,B_Person,B_Person_1,B_Person_2,B_Person_3,B_Person_4,B_Person_5,B_Person_6,B_Person_7,B_Person_8,B_Person_Address_2,B_Person_Address_3,B_Person_Lien_Judgment_8,B_Person_Vehicle_1,B_Person_Vehicle_2,B_Person_Vehicle_3,B_Professional_License_1,B_Professional_License_2,B_Professional_License_3,B_Professional_License_4,B_Professional_License_5,B_Sele_Person_3,B_Sele_Person_4,B_Sele_Person_5,B_Sele_Person_6,B_Sele_Person_7,B_Watercraft_Owner_1,B_Watercraft_Owner_2,B_Watercraft_Owner_3,CFG_Compile,E_Address,E_Aircraft,E_Aircraft_Owner,E_Bankruptcy,E_Criminal_Offense,E_Education,E_First_Degree_Associations,E_First_Degree_Relative,E_Geo_Link,E_Lien_Judgment,E_Person,E_Person_Address,E_Person_Bankruptcy,E_Person_Education,E_Person_Lien_Judgment,E_Person_Offenses,E_Person_Vehicle,E_Professional_License,E_Professional_License_Person,E_Sele_Person,E_Vehicle,E_Watercraft,E_Watercraft_Owner,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL13.Null;
EXPORT Q_Non_F_C_R_A_Person_Attributes_V1(KEL.typ.uid __PLexID_in, DATASET(RECORDOF(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII)) __PInputPIIDataset, KEL.typ.kdate __PP_InpClnArchDt, DATA100 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Address_Filtered := MODULE(E_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Aircraft_Owner_Filtered := MODULE(E_Aircraft_Owner(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Bankruptcy_Filtered := MODULE(E_Bankruptcy(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Criminal_Offense_Filtered := MODULE(E_Criminal_Offense(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Education_Filtered := MODULE(E_Education(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_First_Degree_Associations_Filtered := MODULE(E_First_Degree_Associations(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_First_Degree_Relative_Filtered := MODULE(E_First_Degree_Relative(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Lien_Judgment_Filtered := MODULE(E_Lien_Judgment(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Filtered := MODULE(E_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Address_Filtered := MODULE(E_Person_Address(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Bankruptcy_Filtered := MODULE(E_Person_Bankruptcy(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Education_Filtered := MODULE(E_Person_Education(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Lien_Judgment_Filtered := MODULE(E_Person_Lien_Judgment(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Offenses_Filtered := MODULE(E_Person_Offenses(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Person_Vehicle_Filtered := MODULE(E_Person_Vehicle(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Professional_License_Filtered := MODULE(E_Professional_License(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Professional_License_Person_Filtered := MODULE(E_Professional_License_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Sele_Person_Filtered := MODULE(E_Sele_Person(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Watercraft_Owner_Filtered := MODULE(E_Watercraft_Owner(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED E_Zip_Code_Filtered := MODULE(E_Zip_Code(__in,__cfg_Local))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Archive___Date_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds(KEL.Permits.BitAnd(__ds.__Permits,__PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
  END;
  SHARED B_Lien_Judgment_12_Local := MODULE(B_Lien_Judgment_12(__in,__cfg_Local))
    SHARED TYPEOF(E_Lien_Judgment(__in,__cfg_Local).__Result) __E_Lien_Judgment := E_Lien_Judgment_Filtered.__Result;
  END;
  SHARED B_Lien_Judgment_11_Local := MODULE(B_Lien_Judgment_11(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_12(__in,__cfg_Local).__ENH_Lien_Judgment_12) __ENH_Lien_Judgment_12 := B_Lien_Judgment_12_Local.__ENH_Lien_Judgment_12;
  END;
  SHARED B_Lien_Judgment_10_Local := MODULE(B_Lien_Judgment_10(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_11(__in,__cfg_Local).__ENH_Lien_Judgment_11) __ENH_Lien_Judgment_11 := B_Lien_Judgment_11_Local.__ENH_Lien_Judgment_11;
  END;
  SHARED B_Lien_Judgment_9_Local := MODULE(B_Lien_Judgment_9(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_10(__in,__cfg_Local).__ENH_Lien_Judgment_10) __ENH_Lien_Judgment_10 := B_Lien_Judgment_10_Local.__ENH_Lien_Judgment_10;
  END;
  SHARED B_Bankruptcy_8_Local := MODULE(B_Bankruptcy_8(__in,__cfg_Local))
    SHARED TYPEOF(E_Bankruptcy(__in,__cfg_Local).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered.__Result;
  END;
  SHARED B_Person_8_Local := MODULE(B_Person_8(__in,__cfg_Local))
    SHARED TYPEOF(E_Person(__in,__cfg_Local).__Result) __E_Person := E_Person_Filtered.__Result;
    SHARED TYPEOF(E_Person_Address(__in,__cfg_Local).__Result) __E_Person_Address := E_Person_Address_Filtered.__Result;
  END;
  SHARED B_Person_Lien_Judgment_8_Local := MODULE(B_Person_Lien_Judgment_8(__in,__cfg_Local))
    SHARED TYPEOF(B_Lien_Judgment_9(__in,__cfg_Local).__ENH_Lien_Judgment_9) __ENH_Lien_Judgment_9 := B_Lien_Judgment_9_Local.__ENH_Lien_Judgment_9;
    SHARED TYPEOF(E_Person_Lien_Judgment(__in,__cfg_Local).__Result) __E_Person_Lien_Judgment := E_Person_Lien_Judgment_Filtered.__Result;
  END;
  SHARED B_Bankruptcy_7_Local := MODULE(B_Bankruptcy_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_8(__in,__cfg_Local).__ENH_Bankruptcy_8) __ENH_Bankruptcy_8 := B_Bankruptcy_8_Local.__ENH_Bankruptcy_8;
  END;
  SHARED B_Education_7_Local := MODULE(B_Education_7(__in,__cfg_Local))
    SHARED TYPEOF(E_Education(__in,__cfg_Local).__Result) __E_Education := E_Education_Filtered.__Result;
  END;
  SHARED B_Person_7_Local := MODULE(B_Person_7(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_8(__in,__cfg_Local).__ENH_Person_8) __ENH_Person_8 := B_Person_8_Local.__ENH_Person_8;
    SHARED TYPEOF(B_Person_Lien_Judgment_8(__in,__cfg_Local).__ENH_Person_Lien_Judgment_8) __ENH_Person_Lien_Judgment_8 := B_Person_Lien_Judgment_8_Local.__ENH_Person_Lien_Judgment_8;
  END;
  SHARED B_Sele_Person_7_Local := MODULE(B_Sele_Person_7(__in,__cfg_Local))
    SHARED TYPEOF(E_Sele_Person(__in,__cfg_Local).__Result) __E_Sele_Person := E_Sele_Person_Filtered.__Result;
  END;
  SHARED B_Address_6_Local := MODULE(B_Address_6(__in,__cfg_Local))
    SHARED TYPEOF(E_Address(__in,__cfg_Local).__Result) __E_Address := E_Address_Filtered.__Result;
  END;
  SHARED B_Bankruptcy_6_Local := MODULE(B_Bankruptcy_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_7(__in,__cfg_Local).__ENH_Bankruptcy_7) __ENH_Bankruptcy_7 := B_Bankruptcy_7_Local.__ENH_Bankruptcy_7;
  END;
  SHARED B_Education_6_Local := MODULE(B_Education_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_7(__in,__cfg_Local).__ENH_Education_7) __ENH_Education_7 := B_Education_7_Local.__ENH_Education_7;
  END;
  SHARED B_Person_6_Local := MODULE(B_Person_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_7(__in,__cfg_Local).__ENH_Education_7) __ENH_Education_7 := B_Education_7_Local.__ENH_Education_7;
    SHARED TYPEOF(B_Person_7(__in,__cfg_Local).__ENH_Person_7) __ENH_Person_7 := B_Person_7_Local.__ENH_Person_7;
    SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
  END;
  SHARED B_Sele_Person_6_Local := MODULE(B_Sele_Person_6(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_7(__in,__cfg_Local).__ENH_Sele_Person_7) __ENH_Sele_Person_7 := B_Sele_Person_7_Local.__ENH_Sele_Person_7;
  END;
  SHARED B_Address_5_Local := MODULE(B_Address_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_6(__in,__cfg_Local).__ENH_Address_6) __ENH_Address_6 := B_Address_6_Local.__ENH_Address_6;
  END;
  SHARED B_Bankruptcy_5_Local := MODULE(B_Bankruptcy_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_6(__in,__cfg_Local).__ENH_Bankruptcy_6) __ENH_Bankruptcy_6 := B_Bankruptcy_6_Local.__ENH_Bankruptcy_6;
  END;
  SHARED B_Criminal_Offense_5_Local := MODULE(B_Criminal_Offense_5(__in,__cfg_Local))
    SHARED TYPEOF(E_Criminal_Offense(__in,__cfg_Local).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered.__Result;
  END;
  SHARED B_Education_5_Local := MODULE(B_Education_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_6(__in,__cfg_Local).__ENH_Education_6) __ENH_Education_6 := B_Education_6_Local.__ENH_Education_6;
  END;
  SHARED B_First_Degree_Relative_5_Local := MODULE(B_First_Degree_Relative_5(__in,__cfg_Local))
    SHARED TYPEOF(E_First_Degree_Associations(__in,__cfg_Local).__Result) __E_First_Degree_Associations := E_First_Degree_Associations_Filtered.__Result;
  END;
  SHARED B_Person_5_Local := MODULE(B_Person_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_6(__in,__cfg_Local).__ENH_Person_6) __ENH_Person_6 := B_Person_6_Local.__ENH_Person_6;
  END;
  SHARED B_Professional_License_5_Local := MODULE(B_Professional_License_5(__in,__cfg_Local))
    SHARED TYPEOF(E_Professional_License(__in,__cfg_Local).__Result) __E_Professional_License := E_Professional_License_Filtered.__Result;
  END;
  SHARED B_Sele_Person_5_Local := MODULE(B_Sele_Person_5(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_6(__in,__cfg_Local).__ENH_Sele_Person_6) __ENH_Sele_Person_6 := B_Sele_Person_6_Local.__ENH_Sele_Person_6;
  END;
  SHARED B_Address_4_Local := MODULE(B_Address_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_5(__in,__cfg_Local).__ENH_Address_5) __ENH_Address_5 := B_Address_5_Local.__ENH_Address_5;
  END;
  SHARED B_Bankruptcy_4_Local := MODULE(B_Bankruptcy_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_5(__in,__cfg_Local).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local.__ENH_Bankruptcy_5;
  END;
  SHARED B_Criminal_Offense_4_Local := MODULE(B_Criminal_Offense_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_5(__in,__cfg_Local).__ENH_Criminal_Offense_5) __ENH_Criminal_Offense_5 := B_Criminal_Offense_5_Local.__ENH_Criminal_Offense_5;
  END;
  SHARED B_Education_4_Local := MODULE(B_Education_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_5(__in,__cfg_Local).__ENH_Education_5) __ENH_Education_5 := B_Education_5_Local.__ENH_Education_5;
  END;
  SHARED B_Person_4_Local := MODULE(B_Person_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_5(__in,__cfg_Local).__ENH_Person_5) __ENH_Person_5 := B_Person_5_Local.__ENH_Person_5;
  END;
  SHARED B_Professional_License_4_Local := MODULE(B_Professional_License_4(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_5(__in,__cfg_Local).__ENH_Professional_License_5) __ENH_Professional_License_5 := B_Professional_License_5_Local.__ENH_Professional_License_5;
  END;
  SHARED B_Sele_Person_4_Local := MODULE(B_Sele_Person_4(__in,__cfg_Local))
    SHARED TYPEOF(B_First_Degree_Relative_5(__in,__cfg_Local).__ENH_First_Degree_Relative_5) __ENH_First_Degree_Relative_5 := B_First_Degree_Relative_5_Local.__ENH_First_Degree_Relative_5;
    SHARED TYPEOF(B_Sele_Person_5(__in,__cfg_Local).__ENH_Sele_Person_5) __ENH_Sele_Person_5 := B_Sele_Person_5_Local.__ENH_Sele_Person_5;
  END;
  SHARED B_Address_3_Local := MODULE(B_Address_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_4(__in,__cfg_Local).__ENH_Address_4) __ENH_Address_4 := B_Address_4_Local.__ENH_Address_4;
  END;
  SHARED B_Aircraft_Owner_3_Local := MODULE(B_Aircraft_Owner_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Aircraft_Owner(__in,__cfg_Local).__Result) __E_Aircraft_Owner := E_Aircraft_Owner_Filtered.__Result;
  END;
  SHARED B_Bankruptcy_3_Local := MODULE(B_Bankruptcy_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg_Local).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local.__ENH_Bankruptcy_4;
  END;
  SHARED B_Criminal_Offense_3_Local := MODULE(B_Criminal_Offense_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_4(__in,__cfg_Local).__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4_Local.__ENH_Criminal_Offense_4;
  END;
  SHARED B_Education_3_Local := MODULE(B_Education_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_4(__in,__cfg_Local).__ENH_Education_4) __ENH_Education_4 := B_Education_4_Local.__ENH_Education_4;
  END;
  SHARED B_Person_3_Local := MODULE(B_Person_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg_Local).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local.__ENH_Bankruptcy_4;
    SHARED TYPEOF(B_Criminal_Offense_4(__in,__cfg_Local).__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4_Local.__ENH_Criminal_Offense_4;
    SHARED TYPEOF(B_Person_4(__in,__cfg_Local).__ENH_Person_4) __ENH_Person_4 := B_Person_4_Local.__ENH_Person_4;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Professional_License_4(__in,__cfg_Local).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local.__ENH_Professional_License_4;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
  END;
  SHARED B_Person_Address_3_Local := MODULE(B_Person_Address_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_4(__in,__cfg_Local).__ENH_Person_4) __ENH_Person_4 := B_Person_4_Local.__ENH_Person_4;
    SHARED TYPEOF(E_Person_Address(__in,__cfg_Local).__Result) __E_Person_Address := E_Person_Address_Filtered.__Result;
  END;
  SHARED B_Person_Vehicle_3_Local := MODULE(B_Person_Vehicle_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Person_Vehicle(__in,__cfg_Local).__Result) __E_Person_Vehicle := E_Person_Vehicle_Filtered.__Result;
  END;
  SHARED B_Professional_License_3_Local := MODULE(B_Professional_License_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_4(__in,__cfg_Local).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local.__ENH_Professional_License_4;
  END;
  SHARED B_Sele_Person_3_Local := MODULE(B_Sele_Person_3(__in,__cfg_Local))
    SHARED TYPEOF(B_Sele_Person_4(__in,__cfg_Local).__ENH_Sele_Person_4) __ENH_Sele_Person_4 := B_Sele_Person_4_Local.__ENH_Sele_Person_4;
  END;
  SHARED B_Watercraft_Owner_3_Local := MODULE(B_Watercraft_Owner_3(__in,__cfg_Local))
    SHARED TYPEOF(E_Watercraft_Owner(__in,__cfg_Local).__Result) __E_Watercraft_Owner := E_Watercraft_Owner_Filtered.__Result;
  END;
  SHARED B_Address_2_Local := MODULE(B_Address_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_3(__in,__cfg_Local).__ENH_Address_3) __ENH_Address_3 := B_Address_3_Local.__ENH_Address_3;
    SHARED TYPEOF(E_Zip_Code(__in,__cfg_Local).__Result) __E_Zip_Code := E_Zip_Code_Filtered.__Result;
  END;
  SHARED B_Aircraft_Owner_2_Local := MODULE(B_Aircraft_Owner_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_3(__in,__cfg_Local).__ENH_Aircraft_Owner_3) __ENH_Aircraft_Owner_3 := B_Aircraft_Owner_3_Local.__ENH_Aircraft_Owner_3;
  END;
  SHARED B_Bankruptcy_2_Local := MODULE(B_Bankruptcy_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg_Local).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local.__ENH_Bankruptcy_3;
  END;
  SHARED B_Criminal_Offense_2_Local := MODULE(B_Criminal_Offense_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_3(__in,__cfg_Local).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local.__ENH_Criminal_Offense_3;
  END;
  SHARED B_Education_2_Local := MODULE(B_Education_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_3(__in,__cfg_Local).__ENH_Education_3) __ENH_Education_3 := B_Education_3_Local.__ENH_Education_3;
  END;
  SHARED B_Person_2_Local := MODULE(B_Person_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_3(__in,__cfg_Local).__ENH_Aircraft_Owner_3) __ENH_Aircraft_Owner_3 := B_Aircraft_Owner_3_Local.__ENH_Aircraft_Owner_3;
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg_Local).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local.__ENH_Bankruptcy_3;
    SHARED TYPEOF(B_Criminal_Offense_3(__in,__cfg_Local).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local.__ENH_Criminal_Offense_3;
    SHARED TYPEOF(B_Education_3(__in,__cfg_Local).__ENH_Education_3) __ENH_Education_3 := B_Education_3_Local.__ENH_Education_3;
    SHARED TYPEOF(B_Person_3(__in,__cfg_Local).__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local.__ENH_Person_3;
    SHARED TYPEOF(B_Person_Address_3(__in,__cfg_Local).__ENH_Person_Address_3) __ENH_Person_Address_3 := B_Person_Address_3_Local.__ENH_Person_Address_3;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Vehicle_3(__in,__cfg_Local).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3_Local.__ENH_Person_Vehicle_3;
    SHARED TYPEOF(B_Professional_License_3(__in,__cfg_Local).__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3_Local.__ENH_Professional_License_3;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
    SHARED TYPEOF(B_Sele_Person_3(__in,__cfg_Local).__ENH_Sele_Person_3) __ENH_Sele_Person_3 := B_Sele_Person_3_Local.__ENH_Sele_Person_3;
    SHARED TYPEOF(B_Watercraft_Owner_3(__in,__cfg_Local).__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local.__ENH_Watercraft_Owner_3;
  END;
  SHARED B_Person_Address_2_Local := MODULE(B_Person_Address_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Address_3(__in,__cfg_Local).__ENH_Person_Address_3) __ENH_Person_Address_3 := B_Person_Address_3_Local.__ENH_Person_Address_3;
  END;
  SHARED B_Person_Vehicle_2_Local := MODULE(B_Person_Vehicle_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Vehicle_3(__in,__cfg_Local).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3_Local.__ENH_Person_Vehicle_3;
  END;
  SHARED B_Professional_License_2_Local := MODULE(B_Professional_License_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_3(__in,__cfg_Local).__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3_Local.__ENH_Professional_License_3;
  END;
  SHARED B_Watercraft_Owner_2_Local := MODULE(B_Watercraft_Owner_2(__in,__cfg_Local))
    SHARED TYPEOF(B_Watercraft_Owner_3(__in,__cfg_Local).__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local.__ENH_Watercraft_Owner_3;
  END;
  SHARED B_Aircraft_Owner_1_Local := MODULE(B_Aircraft_Owner_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_2(__in,__cfg_Local).__ENH_Aircraft_Owner_2) __ENH_Aircraft_Owner_2 := B_Aircraft_Owner_2_Local.__ENH_Aircraft_Owner_2;
  END;
  SHARED B_Bankruptcy_1_Local := MODULE(B_Bankruptcy_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg_Local).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local.__ENH_Bankruptcy_2;
  END;
  SHARED B_Criminal_Offense_1_Local := MODULE(B_Criminal_Offense_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Criminal_Offense_2(__in,__cfg_Local).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local.__ENH_Criminal_Offense_2;
  END;
  SHARED B_Education_1_Local := MODULE(B_Education_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Education_2(__in,__cfg_Local).__ENH_Education_2) __ENH_Education_2 := B_Education_2_Local.__ENH_Education_2;
  END;
  SHARED B_Person_1_Local := MODULE(B_Person_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Address_2(__in,__cfg_Local).__ENH_Address_2) __ENH_Address_2 := B_Address_2_Local.__ENH_Address_2;
    SHARED TYPEOF(B_Aircraft_Owner_2(__in,__cfg_Local).__ENH_Aircraft_Owner_2) __ENH_Aircraft_Owner_2 := B_Aircraft_Owner_2_Local.__ENH_Aircraft_Owner_2;
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg_Local).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local.__ENH_Bankruptcy_2;
    SHARED TYPEOF(B_Criminal_Offense_2(__in,__cfg_Local).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local.__ENH_Criminal_Offense_2;
    SHARED TYPEOF(B_Education_2(__in,__cfg_Local).__ENH_Education_2) __ENH_Education_2 := B_Education_2_Local.__ENH_Education_2;
    SHARED TYPEOF(B_Person_2(__in,__cfg_Local).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local.__ENH_Person_2;
    SHARED TYPEOF(B_Person_Address_2(__in,__cfg_Local).__ENH_Person_Address_2) __ENH_Person_Address_2 := B_Person_Address_2_Local.__ENH_Person_Address_2;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Vehicle_2(__in,__cfg_Local).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2_Local.__ENH_Person_Vehicle_2;
    SHARED TYPEOF(B_Professional_License_2(__in,__cfg_Local).__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2_Local.__ENH_Professional_License_2;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
    SHARED TYPEOF(B_Watercraft_Owner_2(__in,__cfg_Local).__ENH_Watercraft_Owner_2) __ENH_Watercraft_Owner_2 := B_Watercraft_Owner_2_Local.__ENH_Watercraft_Owner_2;
  END;
  SHARED B_Person_Vehicle_1_Local := MODULE(B_Person_Vehicle_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Person_Vehicle_2(__in,__cfg_Local).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2_Local.__ENH_Person_Vehicle_2;
  END;
  SHARED B_Professional_License_1_Local := MODULE(B_Professional_License_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Professional_License_2(__in,__cfg_Local).__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2_Local.__ENH_Professional_License_2;
  END;
  SHARED B_Watercraft_Owner_1_Local := MODULE(B_Watercraft_Owner_1(__in,__cfg_Local))
    SHARED TYPEOF(B_Watercraft_Owner_2(__in,__cfg_Local).__ENH_Watercraft_Owner_2) __ENH_Watercraft_Owner_2 := B_Watercraft_Owner_2_Local.__ENH_Watercraft_Owner_2;
  END;
  SHARED B_Person_Local := MODULE(B_Person(__in,__cfg_Local))
    SHARED TYPEOF(B_Aircraft_Owner_1(__in,__cfg_Local).__ENH_Aircraft_Owner_1) __ENH_Aircraft_Owner_1 := B_Aircraft_Owner_1_Local.__ENH_Aircraft_Owner_1;
    SHARED TYPEOF(B_Bankruptcy_1(__in,__cfg_Local).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local.__ENH_Bankruptcy_1;
    SHARED TYPEOF(B_Criminal_Offense_1(__in,__cfg_Local).__ENH_Criminal_Offense_1) __ENH_Criminal_Offense_1 := B_Criminal_Offense_1_Local.__ENH_Criminal_Offense_1;
    SHARED TYPEOF(B_Education_1(__in,__cfg_Local).__ENH_Education_1) __ENH_Education_1 := B_Education_1_Local.__ENH_Education_1;
    SHARED TYPEOF(B_Person_1(__in,__cfg_Local).__ENH_Person_1) __ENH_Person_1 := B_Person_1_Local.__ENH_Person_1;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered.__Result;
    SHARED TYPEOF(E_Person_Education(__in,__cfg_Local).__Result) __E_Person_Education := E_Person_Education_Filtered.__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered.__Result;
    SHARED TYPEOF(B_Person_Vehicle_1(__in,__cfg_Local).__ENH_Person_Vehicle_1) __ENH_Person_Vehicle_1 := B_Person_Vehicle_1_Local.__ENH_Person_Vehicle_1;
    SHARED TYPEOF(B_Professional_License_1(__in,__cfg_Local).__ENH_Professional_License_1) __ENH_Professional_License_1 := B_Professional_License_1_Local.__ENH_Professional_License_1;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg_Local).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered.__Result;
    SHARED TYPEOF(B_Watercraft_Owner_1(__in,__cfg_Local).__ENH_Watercraft_Owner_1) __ENH_Watercraft_Owner_1 := B_Watercraft_Owner_1_Local.__ENH_Watercraft_Owner_1;
  END;
  SHARED TYPEOF(B_Person(__in,__cfg_Local).__ENH_Person) __ENH_Person := B_Person_Local.__ENH_Person;
  SHARED __EE6443233 := __ENH_Person;
  SHARED __EE6444152 := __EE6443233(__T(__OP2(__EE6443233.UID,=,__CN(__PLexID_in))));
  SHARED __ST67060_Layout := RECORD
    KEL.typ.nuid Lex_I_D_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.int P_L___Ast_Veh_Auto_Cnt_Ev_ := 0;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST3147742_Layout) P_L___Ast_Veh_Auto_Emrg_Dt_List_Ev_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST3147762_Layout) P_L___Ast_Veh_Auto_Last_Dt_List_Ev_;
    KEL.typ.int P_L___Ast_Veh_Auto_Cnt10_Y_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_Cnt2_Y_ := 0;
    KEL.typ.nstr P_L___Ast_Veh_Auto_Emrg_New_Dt_Ev_;
    KEL.typ.nstr P_L___Ast_Veh_Auto_Emrg_Old_Dt_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_New_Msnc_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_Old_Msnc_Ev_;
    KEL.typ.int P_L___Ast_Veh_Air_Cnt_Ev_ := 0;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST60588_Layout) P_L___Ast_Veh_Air_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_L___Ast_Veh_Air_Emrg_New_Dt_Ev_;
    KEL.typ.nstr P_L___Ast_Veh_Air_Emrg_Old_Dt_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Air_Emrg_New_Msnc_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Air_Emrg_Old_Msnc_Ev_;
    KEL.typ.int P_L___Ast_Veh_Wtr_Cnt_Ev_ := 0;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST60853_Layout) P_L___Ast_Veh_Wtr_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_L___Ast_Veh_Wtr_Emrg_New_Dt_Ev_;
    KEL.typ.nstr P_L___Ast_Veh_Wtr_Emrg_Old_Dt_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Wtr_Emrg_New_Msnc_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Wtr_Emrg_Old_Msnc_Ev_;
    KEL.typ.int P_L___Drg_Crim_Fel_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Crim_Fel_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Crim_Fel_New_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Fel_Old_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Fel_New_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Fel_Old_Dt7_Y_;
    KEL.typ.nint P_L___Drg_Crim_Fel_New_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Crim_Fel_Old_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Crim_Fel_New_Msnc7_Y_;
    KEL.typ.nint P_L___Drg_Crim_Fel_Old_Msnc7_Y_;
    KEL.typ.int P_L___Drg_Crim_Nfel_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Crim_Nfel_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Crim_Nfel_New_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Nfel_Old_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Nfel_New_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Nfel_Old_Dt7_Y_;
    KEL.typ.nint P_L___Drg_Crim_Nfel_New_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Crim_Nfel_Old_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Crim_Nfel_New_Msnc7_Y_;
    KEL.typ.nint P_L___Drg_Crim_Nfel_Old_Msnc7_Y_;
    KEL.typ.int P_L___Drg_Arst_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Arst_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Arst_New_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Arst_Old_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Arst_New_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Arst_Old_Dt7_Y_;
    KEL.typ.nint P_L___Drg_Arst_New_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Arst_Old_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Arst_New_Msnc7_Y_;
    KEL.typ.nint P_L___Drg_Arst_Old_Msnc7_Y_;
    KEL.typ.int P_L___Drg_Crim_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Crim_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Crim_New_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Old_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Crim_New_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Old_Dt7_Y_;
    KEL.typ.nint P_L___Drg_Crim_New_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Crim_Old_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Crim_New_Msnc7_Y_;
    KEL.typ.nint P_L___Drg_Crim_Old_Msnc7_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Severity_Indx7_Y_;
    KEL.typ.nstr P_L___Drg_Crim_Behavior_Indx7_Y_;
    KEL.typ.int P_L___Drg_Bk_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Cnt10_Y_ := 0;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST62508_Layout) P_L___Drg_Bk_Dt_List1_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST62530_Layout) P_L___Drg_Bk_Dt_List7_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST62552_Layout) P_L___Drg_Bk_Dt_List10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Dt10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Old_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Old_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Old_Dt10_Y_;
    KEL.typ.nint P_L___Drg_Bk_New_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Bk_New_Msnc7_Y_;
    KEL.typ.nint P_L___Drg_Bk_New_Msnc10_Y_;
    KEL.typ.nint P_L___Drg_Bk_Old_Msnc1_Y_;
    KEL.typ.nint P_L___Drg_Bk_Old_Msnc7_Y_;
    KEL.typ.nint P_L___Drg_Bk_Old_Msnc10_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST62791_Layout) P_L___Drg_Bk_Ch_List1_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST62821_Layout) P_L___Drg_Bk_Ch_List7_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST62851_Layout) P_L___Drg_Bk_Ch_List10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Ch_Type1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Ch_Type7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Ch_Type10_Y_;
    KEL.typ.int P_L___Drg_Bk_Ch7_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Ch7_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Ch7_Cnt10_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Ch13_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Ch13_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Ch13_Cnt10_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Bk_Updt_New_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Updt_New_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Updt_New_Dt10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Updt_New_Msnc1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Updt_New_Msnc7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Updt_New_Msnc10_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST63650_Layout) P_L___Drg_Bk_Disp_List1_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST63684_Layout) P_L___Drg_Bk_Disp_List7_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST63718_Layout) P_L___Drg_Bk_Disp_List10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Type1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Type7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Type10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Dt1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Dt7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Dt10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Msnc1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Msnc7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_New_Disp_Msnc10_Y_;
    KEL.typ.int P_L___Drg_Bk_Disp_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Disp_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Disp_Cnt10_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Dsms_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Dsms_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Dsms_Cnt10_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Dsch_Cnt1_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Dsch_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Bk_Dsch_Cnt10_Y_ := 0;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST64258_Layout) P_L___Drg_Bk_Type_List1_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST64295_Layout) P_L___Drg_Bk_Type_List7_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST64332_Layout) P_L___Drg_Bk_Type_List10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Bus_Flag1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Bus_Flag7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Bus_Flag10_Y_;
    KEL.typ.str P_L___Drg_Bk_Severity_Indx10_Y_ := '';
    KEL.typ.str P_L___Prof_Lic_Flag_Ev_ := '';
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST64713_Layout) P_L___Prof_Lic_Issue_Dt_List_Ev_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST64721_Layout) P_L___Prof_Lic_Exp_Dt_List_Ev_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST64736_Layout) P_L___Prof_Lic_Indx_By_Lic_List_Ev_;
    KEL.typ.str P_L___Prof_Lic_Actv_Flag_ := '';
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Issue_Dt_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Exp_Dt_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Type_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Title_Type_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Indx_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Src_Type_;
    KEL.typ.nstr P_L___Curr_Addr_Full_;
    KEL.typ.nstr P_L___Curr_Addr_Loc_I_D_;
    KEL.typ.nstr P_L___Prev_Addr_Full_;
    KEL.typ.nstr P_L___Prev_Addr_Loc_I_D_;
    KEL.typ.int P_L___Curr_Addr_Is_Vacant_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_Throwback_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Seasonal_Type_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_D_N_D_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_College_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_C_M_R_A_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_Simp_Addr_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_Drop_Delivery_Flag_ := 0;
    KEL.typ.int P_L___Curr_Addr_Is_Business_Flag_ := 0;
    KEL.typ.int P_L___Drg_Judg_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_L_T_D_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Lien_Cnt7_Y_ := 0;
    KEL.typ.int P_L___Drg_Suit_Cnt7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Suit_Amt_List7_Y_;
    KEL.typ.int P_L___Drg_Suit_Amt_Tot7_Y_ := 0;
    KEL.typ.nstr P_L___Drg_Suit_Dt_List7_Y_;
    KEL.typ.nint P_L___Drg_Suit_New_Msnc7_Y_;
    KEL.typ.nint P_L___Drg_Suit_Old_Msnc7_Y_;
    KEL.typ.str P_L___Edu_Rec_Flag_Ev_ := '';
    KEL.typ.nstr P_L___Edu_Src_List_Ev_;
    KEL.typ.str P_L___Edu_H_S_Rec_Flag_Ev_ := '';
    KEL.typ.str P_L___Edu_Coll_Rec_Flag_Ev_ := '';
    KEL.typ.nstr P_L___Edu_Coll_Src_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_L___Edu_Coll_Src_Last_Dt_List_Ev_;
    KEL.typ.nstr P_L___Edu_Coll_Src_New_Rec_Old_Dt_Ev_;
    KEL.typ.nstr P_L___Edu_Coll_Src_New_Rec_New_Dt_Ev_;
    KEL.typ.nstr P_L___Edu_Coll_Src_New_Rec_Old_Msnc_Ev_;
    KEL.typ.nstr P_L___Edu_Coll_Src_New_Rec_New_Msnc_Ev_;
    KEL.typ.nstr P_L___Edu_Coll_Rec_Span_Ev_;
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
  EXPORT Res0 := __UNWRAP(PROJECT(__EE6444152,TRANSFORM(__ST67060_Layout,SELF.Lex_I_D_ := LEFT.UID,SELF := LEFT)));
END;
