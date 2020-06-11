//HPCC Systems KEL Compiler Version 1.2.1-dev
IMPORT KEL12 AS KEL;
IMPORT B_Aircraft_Owner_1,B_Aircraft_Owner_2,B_Aircraft_Owner_3,B_Bankruptcy_1,B_Bankruptcy_2,B_Bankruptcy_3,B_Bankruptcy_4,B_Bankruptcy_5,B_Bankruptcy_6,B_Bankruptcy_7,B_Bankruptcy_8,B_Criminal_Offense_1,B_Criminal_Offense_2,B_Criminal_Offense_3,B_Criminal_Offense_4,B_Person,B_Person_1,B_Person_2,B_Person_3,B_Person_4,B_Person_5,B_Person_6,B_Person_7,B_Person_Vehicle_1,B_Person_Vehicle_2,B_Person_Vehicle_3,B_Professional_License_1,B_Professional_License_2,B_Professional_License_3,B_Professional_License_4,B_Professional_License_5,B_Watercraft_Owner_1,B_Watercraft_Owner_2,B_Watercraft_Owner_3,CFG_Compile,E_Address,E_Aircraft,E_Aircraft_Owner,E_Bankruptcy,E_Criminal_Offense,E_Geo_Link,E_Person,E_Person_Address,E_Person_Bankruptcy,E_Person_Offenses,E_Person_Vehicle,E_Professional_License,E_Professional_License_Person,E_Vehicle,E_Watercraft,E_Watercraft_Owner,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT Q_F_C_R_A_Mini_Attributes_V1(KEL.typ.uid __PLexID_in, KEL.typ.kdate __PP_InpClnArchDt, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PP_InpClnArchDt;
  END;
  SHARED E_Person_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PLexID_in)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Person_Bankruptcy_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Offenses_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Offenses(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Professional_License_Person_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Professional_License_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Aircraft_Owner_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Aircraft_Owner(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Bankruptcy_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Bankruptcy_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Bankrupt_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Criminal_Offense_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Offense(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Offenses_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Offense_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Vehicle_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Vehicle(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Professional_License_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Professional_License(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.License_Number_,<>,__CN('')))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(HAVING(__ds,__GroupTest(ROWS(LEFT))),E_Professional_License_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Prof_Lic_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Watercraft_Owner_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Watercraft_Owner(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Filtered := E_Person_Filtered_2;
  SHARED E_Person_Bankruptcy_Filtered := E_Person_Bankruptcy_Filtered_1;
  SHARED E_Person_Offenses_Filtered := E_Person_Offenses_Filtered_1;
  SHARED E_Professional_License_Person_Filtered := E_Professional_License_Person_Filtered_1;
  SHARED B_Bankruptcy_8_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_8(__in,__cfg))
    SHARED TYPEOF(E_Bankruptcy(__in,__cfg).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Bankruptcy_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_7(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_8(__in,__cfg).__ENH_Bankruptcy_8) __ENH_Bankruptcy_8 := B_Bankruptcy_8_Local(__in,__cfg).__ENH_Bankruptcy_8;
  END;
  SHARED B_Person_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_7(__in,__cfg))
    SHARED TYPEOF(E_Person(__in,__cfg).__Result) __E_Person := E_Person_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Address(__in,__cfg).__Result) __E_Person_Address := E_Person_Address_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Bankruptcy_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_6(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_7(__in,__cfg).__ENH_Bankruptcy_7) __ENH_Bankruptcy_7 := B_Bankruptcy_7_Local(__in,__cfg).__ENH_Bankruptcy_7;
  END;
  SHARED B_Person_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_6(__in,__cfg))
    SHARED TYPEOF(B_Person_7(__in,__cfg).__ENH_Person_7) __ENH_Person_7 := B_Person_7_Local(__in,__cfg).__ENH_Person_7;
  END;
  SHARED B_Bankruptcy_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_5(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_6(__in,__cfg).__ENH_Bankruptcy_6) __ENH_Bankruptcy_6 := B_Bankruptcy_6_Local(__in,__cfg).__ENH_Bankruptcy_6;
  END;
  SHARED B_Person_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_5(__in,__cfg))
    SHARED TYPEOF(B_Person_6(__in,__cfg).__ENH_Person_6) __ENH_Person_6 := B_Person_6_Local(__in,__cfg).__ENH_Person_6;
  END;
  SHARED B_Professional_License_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_5(__in,__cfg))
    SHARED TYPEOF(E_Professional_License(__in,__cfg).__Result) __E_Professional_License := E_Professional_License_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Bankruptcy_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_4(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_5(__in,__cfg).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local(__in,__cfg).__ENH_Bankruptcy_5;
  END;
  SHARED B_Criminal_Offense_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_4(__in,__cfg))
    SHARED TYPEOF(E_Criminal_Offense(__in,__cfg).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Person_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_4(__in,__cfg))
    SHARED TYPEOF(B_Person_5(__in,__cfg).__ENH_Person_5) __ENH_Person_5 := B_Person_5_Local(__in,__cfg).__ENH_Person_5;
  END;
  SHARED B_Professional_License_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_4(__in,__cfg))
    SHARED TYPEOF(B_Professional_License_5(__in,__cfg).__ENH_Professional_License_5) __ENH_Professional_License_5 := B_Professional_License_5_Local(__in,__cfg).__ENH_Professional_License_5;
  END;
  SHARED B_Aircraft_Owner_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Aircraft_Owner_3(__in,__cfg))
    SHARED TYPEOF(E_Aircraft_Owner(__in,__cfg).__Result) __E_Aircraft_Owner := E_Aircraft_Owner_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Bankruptcy_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_3(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local(__in,__cfg).__ENH_Bankruptcy_4;
  END;
  SHARED B_Criminal_Offense_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_3(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_4(__in,__cfg).__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4_Local(__in,__cfg).__ENH_Criminal_Offense_4;
  END;
  SHARED B_Person_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_3(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local(__in,__cfg).__ENH_Bankruptcy_4;
    SHARED TYPEOF(B_Person_4(__in,__cfg).__ENH_Person_4) __ENH_Person_4 := B_Person_4_Local(__in,__cfg).__ENH_Person_4;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Professional_License_4(__in,__cfg).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local(__in,__cfg).__ENH_Professional_License_4;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Person_Vehicle_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_3(__in,__cfg))
    SHARED TYPEOF(E_Person_Vehicle(__in,__cfg).__Result) __E_Person_Vehicle := E_Person_Vehicle_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Professional_License_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_3(__in,__cfg))
    SHARED TYPEOF(B_Professional_License_4(__in,__cfg).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local(__in,__cfg).__ENH_Professional_License_4;
  END;
  SHARED B_Watercraft_Owner_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Watercraft_Owner_3(__in,__cfg))
    SHARED TYPEOF(E_Watercraft_Owner(__in,__cfg).__Result) __E_Watercraft_Owner := E_Watercraft_Owner_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Aircraft_Owner_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Aircraft_Owner_2(__in,__cfg))
    SHARED TYPEOF(B_Aircraft_Owner_3(__in,__cfg).__ENH_Aircraft_Owner_3) __ENH_Aircraft_Owner_3 := B_Aircraft_Owner_3_Local(__in,__cfg).__ENH_Aircraft_Owner_3;
  END;
  SHARED B_Bankruptcy_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_2(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local(__in,__cfg).__ENH_Bankruptcy_3;
  END;
  SHARED B_Criminal_Offense_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_2(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_3(__in,__cfg).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local(__in,__cfg).__ENH_Criminal_Offense_3;
  END;
  SHARED B_Person_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_2(__in,__cfg))
    SHARED TYPEOF(B_Aircraft_Owner_3(__in,__cfg).__ENH_Aircraft_Owner_3) __ENH_Aircraft_Owner_3 := B_Aircraft_Owner_3_Local(__in,__cfg).__ENH_Aircraft_Owner_3;
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local(__in,__cfg).__ENH_Bankruptcy_3;
    SHARED TYPEOF(B_Criminal_Offense_3(__in,__cfg).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local(__in,__cfg).__ENH_Criminal_Offense_3;
    SHARED TYPEOF(B_Person_3(__in,__cfg).__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local(__in,__cfg).__ENH_Person_3;
    SHARED TYPEOF(E_Person_Address(__in,__cfg).__Result) __E_Person_Address := E_Person_Address_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Person_Vehicle_3(__in,__cfg).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3_Local(__in,__cfg).__ENH_Person_Vehicle_3;
    SHARED TYPEOF(B_Professional_License_3(__in,__cfg).__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3_Local(__in,__cfg).__ENH_Professional_License_3;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Watercraft_Owner_3(__in,__cfg).__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local(__in,__cfg).__ENH_Watercraft_Owner_3;
  END;
  SHARED B_Person_Vehicle_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_2(__in,__cfg))
    SHARED TYPEOF(B_Person_Vehicle_3(__in,__cfg).__ENH_Person_Vehicle_3) __ENH_Person_Vehicle_3 := B_Person_Vehicle_3_Local(__in,__cfg).__ENH_Person_Vehicle_3;
  END;
  SHARED B_Professional_License_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_2(__in,__cfg))
    SHARED TYPEOF(B_Professional_License_3(__in,__cfg).__ENH_Professional_License_3) __ENH_Professional_License_3 := B_Professional_License_3_Local(__in,__cfg).__ENH_Professional_License_3;
  END;
  SHARED B_Watercraft_Owner_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Watercraft_Owner_2(__in,__cfg))
    SHARED TYPEOF(B_Watercraft_Owner_3(__in,__cfg).__ENH_Watercraft_Owner_3) __ENH_Watercraft_Owner_3 := B_Watercraft_Owner_3_Local(__in,__cfg).__ENH_Watercraft_Owner_3;
  END;
  SHARED B_Aircraft_Owner_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Aircraft_Owner_1(__in,__cfg))
    SHARED TYPEOF(B_Aircraft_Owner_2(__in,__cfg).__ENH_Aircraft_Owner_2) __ENH_Aircraft_Owner_2 := B_Aircraft_Owner_2_Local(__in,__cfg).__ENH_Aircraft_Owner_2;
  END;
  SHARED B_Bankruptcy_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_1(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local(__in,__cfg).__ENH_Bankruptcy_2;
  END;
  SHARED B_Criminal_Offense_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_1(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_2(__in,__cfg).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local(__in,__cfg).__ENH_Criminal_Offense_2;
  END;
  SHARED B_Person_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_1(__in,__cfg))
    SHARED TYPEOF(B_Aircraft_Owner_2(__in,__cfg).__ENH_Aircraft_Owner_2) __ENH_Aircraft_Owner_2 := B_Aircraft_Owner_2_Local(__in,__cfg).__ENH_Aircraft_Owner_2;
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local(__in,__cfg).__ENH_Bankruptcy_2;
    SHARED TYPEOF(B_Criminal_Offense_2(__in,__cfg).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local(__in,__cfg).__ENH_Criminal_Offense_2;
    SHARED TYPEOF(B_Person_2(__in,__cfg).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local(__in,__cfg).__ENH_Person_2;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Person_Vehicle_2(__in,__cfg).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2_Local(__in,__cfg).__ENH_Person_Vehicle_2;
    SHARED TYPEOF(B_Professional_License_2(__in,__cfg).__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2_Local(__in,__cfg).__ENH_Professional_License_2;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Watercraft_Owner_2(__in,__cfg).__ENH_Watercraft_Owner_2) __ENH_Watercraft_Owner_2 := B_Watercraft_Owner_2_Local(__in,__cfg).__ENH_Watercraft_Owner_2;
  END;
  SHARED B_Person_Vehicle_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_1(__in,__cfg))
    SHARED TYPEOF(B_Person_Vehicle_2(__in,__cfg).__ENH_Person_Vehicle_2) __ENH_Person_Vehicle_2 := B_Person_Vehicle_2_Local(__in,__cfg).__ENH_Person_Vehicle_2;
  END;
  SHARED B_Professional_License_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_1(__in,__cfg))
    SHARED TYPEOF(B_Professional_License_2(__in,__cfg).__ENH_Professional_License_2) __ENH_Professional_License_2 := B_Professional_License_2_Local(__in,__cfg).__ENH_Professional_License_2;
  END;
  SHARED B_Watercraft_Owner_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Watercraft_Owner_1(__in,__cfg))
    SHARED TYPEOF(B_Watercraft_Owner_2(__in,__cfg).__ENH_Watercraft_Owner_2) __ENH_Watercraft_Owner_2 := B_Watercraft_Owner_2_Local(__in,__cfg).__ENH_Watercraft_Owner_2;
  END;
  SHARED B_Person_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person(__in,__cfg))
    SHARED TYPEOF(B_Aircraft_Owner_1(__in,__cfg).__ENH_Aircraft_Owner_1) __ENH_Aircraft_Owner_1 := B_Aircraft_Owner_1_Local(__in,__cfg).__ENH_Aircraft_Owner_1;
    SHARED TYPEOF(B_Bankruptcy_1(__in,__cfg).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local(__in,__cfg).__ENH_Bankruptcy_1;
    SHARED TYPEOF(B_Criminal_Offense_1(__in,__cfg).__ENH_Criminal_Offense_1) __ENH_Criminal_Offense_1 := B_Criminal_Offense_1_Local(__in,__cfg).__ENH_Criminal_Offense_1;
    SHARED TYPEOF(B_Person_1(__in,__cfg).__ENH_Person_1) __ENH_Person_1 := B_Person_1_Local(__in,__cfg).__ENH_Person_1;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Person_Vehicle_1(__in,__cfg).__ENH_Person_Vehicle_1) __ENH_Person_Vehicle_1 := B_Person_Vehicle_1_Local(__in,__cfg).__ENH_Person_Vehicle_1;
    SHARED TYPEOF(B_Professional_License_1(__in,__cfg).__ENH_Professional_License_1) __ENH_Professional_License_1 := B_Professional_License_1_Local(__in,__cfg).__ENH_Professional_License_1;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Watercraft_Owner_1(__in,__cfg).__ENH_Watercraft_Owner_1) __ENH_Watercraft_Owner_1 := B_Watercraft_Owner_1_Local(__in,__cfg).__ENH_Watercraft_Owner_1;
  END;
  SHARED TYPEOF(B_Person(__in,__cfg_Local).__ENH_Person) __ENH_Person := B_Person_Local(__in,__cfg_Local).__ENH_Person;
  SHARED __EE2749465 := __ENH_Person;
  SHARED __EE2749954 := __EE2749465(__T(__OP2(__EE2749465.UID,=,__CN(__PLexID_in))));
  SHARED __ST71222_Layout := RECORD
    KEL.typ.nuid Lex_I_D_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.nstr Current_Addr_Prim_Rng_;
    KEL.typ.nstr Current_Addr_Pre_Dir_;
    KEL.typ.nstr Current_Addr_Prim_Name_;
    KEL.typ.nstr Current_Postdirectional_;
    KEL.typ.nstr Current_Addr_Sffx_;
    KEL.typ.nstr Current_Addr_Sec_Rng_;
    KEL.typ.nstr Current_Addr_State_;
    KEL.typ.nstr Current_Addr_Zip5_;
    KEL.typ.nstr Current_Addr_State_Code_;
    KEL.typ.nstr Current_Addr_Cnty_;
    KEL.typ.nstr Current_Addr_Geo_;
    KEL.typ.nstr Previous_Addr_Prim_Rng_;
    KEL.typ.nstr Previous_Addr_Pre_Dir_;
    KEL.typ.nstr Previous_Addr_Prim_Name_;
    KEL.typ.nstr Previous_Postdirectional_;
    KEL.typ.nstr Previous_Addr_Sffx_;
    KEL.typ.nstr Previous_Addr_Sec_Rng_;
    KEL.typ.nstr Previous_Addr_State_;
    KEL.typ.nstr Previous_Addr_Zip5_;
    KEL.typ.nstr Previous_Addr_State_Code_;
    KEL.typ.nstr Previous_Addr_Cnty_;
    KEL.typ.nstr Previous_Addr_Geo_;
    KEL.typ.nstr Emerging_Addr_Prim_Rng_;
    KEL.typ.nstr Emerging_Addr_Pre_Dir_;
    KEL.typ.nstr Emerging_Addr_Prim_Name_;
    KEL.typ.nstr Emerging_Postdirectional_;
    KEL.typ.nstr Emerging_Addr_Sffx_;
    KEL.typ.nstr Emerging_Addr_Sec_Rng_;
    KEL.typ.nstr Emerging_Addr_State_;
    KEL.typ.ntyp(E_Zip_Code().Typ) Emerging_Addr_Zip5_;
    KEL.typ.nstr Emerging_Addr_State_Code_;
    KEL.typ.nstr Emerging_Addr_Cnty_;
    KEL.typ.nstr Emerging_Addr_Geo_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE2749954,TRANSFORM(__ST71222_Layout,SELF.Lex_I_D_ := LEFT.UID,SELF := LEFT)));
END;
