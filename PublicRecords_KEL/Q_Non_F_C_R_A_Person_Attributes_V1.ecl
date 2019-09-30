//HPCC Systems KEL Compiler Version 1.1.0beta2
IMPORT KEL11 AS KEL;
IMPORT B_Aircraft_Owner_1,B_Aircraft_Owner_2,B_Aircraft_Owner_3,B_Aircraft_Owner_4,B_Bankruptcy_1,B_Bankruptcy_2,B_Bankruptcy_3,B_Bankruptcy_4,B_Bankruptcy_5,B_Bankruptcy_6,B_Bankruptcy_7,B_Criminal_Offense_1,B_Criminal_Offense_2,B_Criminal_Offense_3,B_Criminal_Offense_4,B_Person,B_Person_1,B_Person_2,B_Person_3,B_Person_Bankruptcy_1,B_Person_Vehicle_1,B_Person_Vehicle_2,B_Person_Vehicle_3,B_Person_Vehicle_4,B_Professional_License_1,B_Professional_License_2,B_Professional_License_3,B_Professional_License_4,B_Professional_License_5,B_Watercraft_Owner_1,B_Watercraft_Owner_2,B_Watercraft_Owner_3,B_Watercraft_Owner_4,CFG_Compile,E_Aircraft,E_Aircraft_Owner,E_Bankruptcy,E_Criminal_Offense,E_Person,E_Person_Bankruptcy,E_Person_Offenses,E_Person_Vehicle,E_Professional_License,E_Professional_License_Person,E_Vehicle,E_Watercraft,E_Watercraft_Owner FROM PublicRecords_KEL;
IMPORT * FROM KEL11.Null;
EXPORT Q_Non_F_C_R_A_Person_Attributes_V1(KEL.typ.uid __PLexID_in, KEL.typ.kdate __PP_InpClnArchDt, UNSIGNED8 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
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
  SHARED E_Person_Bankruptcy_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __InLayoutExtended := RECORD
      InLayout;
      KEL.typ.bool __Link0 := FALSE;
      KEL.typ.bool __Link1 := FALSE;
    END;
    SHARED __FilterPart0(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Bankruptcy_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Bankrupt_,RIGHT.Bankrupt_),TRANSFORM(__InLayoutExtended,SELF.__Link0:=__NN(RIGHT.Bankrupt_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __FilterPart1(GROUPED DATASET(__InLayoutExtended) __ds) := JOIN(__ds,E_Person_Bankruptcy_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.Subject_) AND __EEQP(LEFT.Bankrupt_,RIGHT.Bankrupt_),TRANSFORM(__InLayoutExtended,SELF.__Link1:=__NN(RIGHT.Subject_),SELF:=LEFT),HASH,GROUPED,KEEP(1),LEFT OUTER);
    SHARED __GroupTest(DATASET(__InLayoutExtended) __g) := EXISTS(__g(__g.__Link0)) OR EXISTS(__g(__g.__Link1));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := PROJECT(HAVING(__FilterPart1(__FilterPart0(__ds)),__GroupTest(ROWS(LEFT))),InLayout);
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
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Professional_License_Person_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Prof_Lic_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Watercraft_Owner_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Watercraft_Owner(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PP_InpClnArchDt))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Owner_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Filtered := E_Person_Filtered_2;
  SHARED E_Person_Offenses_Filtered := E_Person_Offenses_Filtered_1;
  SHARED E_Professional_License_Person_Filtered := E_Professional_License_Person_Filtered_1;
  SHARED B_Bankruptcy_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_7(__in,__cfg))
    SHARED TYPEOF(E_Bankruptcy(__in,__cfg).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Bankruptcy_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_6(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_7(__in,__cfg).__ENH_Bankruptcy_7) __ENH_Bankruptcy_7 := B_Bankruptcy_7_Local(__in,__cfg).__ENH_Bankruptcy_7;
  END;
  SHARED B_Bankruptcy_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_5(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_6(__in,__cfg).__ENH_Bankruptcy_6) __ENH_Bankruptcy_6 := B_Bankruptcy_6_Local(__in,__cfg).__ENH_Bankruptcy_6;
  END;
  SHARED B_Professional_License_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_5(__in,__cfg))
    SHARED TYPEOF(E_Professional_License(__in,__cfg).__Result) __E_Professional_License := E_Professional_License_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Aircraft_Owner_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Aircraft_Owner_4(__in,__cfg))
    SHARED TYPEOF(E_Aircraft_Owner(__in,__cfg).__Result) __E_Aircraft_Owner := E_Aircraft_Owner_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Bankruptcy_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_4(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_5(__in,__cfg).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local(__in,__cfg).__ENH_Bankruptcy_5;
  END;
  SHARED B_Criminal_Offense_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_4(__in,__cfg))
    SHARED TYPEOF(E_Criminal_Offense(__in,__cfg).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Person_Vehicle_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_4(__in,__cfg))
    SHARED TYPEOF(E_Person_Vehicle(__in,__cfg).__Result) __E_Person_Vehicle := E_Person_Vehicle_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Professional_License_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_4(__in,__cfg))
    SHARED TYPEOF(B_Professional_License_5(__in,__cfg).__ENH_Professional_License_5) __ENH_Professional_License_5 := B_Professional_License_5_Local(__in,__cfg).__ENH_Professional_License_5;
  END;
  SHARED B_Watercraft_Owner_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Watercraft_Owner_4(__in,__cfg))
    SHARED TYPEOF(E_Watercraft_Owner(__in,__cfg).__Result) __E_Watercraft_Owner := E_Watercraft_Owner_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Aircraft_Owner_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Aircraft_Owner_3(__in,__cfg))
    SHARED TYPEOF(B_Aircraft_Owner_4(__in,__cfg).__ENH_Aircraft_Owner_4) __ENH_Aircraft_Owner_4 := B_Aircraft_Owner_4_Local(__in,__cfg).__ENH_Aircraft_Owner_4;
  END;
  SHARED B_Bankruptcy_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_3(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local(__in,__cfg).__ENH_Bankruptcy_4;
  END;
  SHARED B_Criminal_Offense_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_3(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_4(__in,__cfg).__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4_Local(__in,__cfg).__ENH_Criminal_Offense_4;
  END;
  SHARED B_Person_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_3(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_4(__in,__cfg).__ENH_Bankruptcy_4) __ENH_Bankruptcy_4 := B_Bankruptcy_4_Local(__in,__cfg).__ENH_Bankruptcy_4;
    SHARED TYPEOF(E_Person(__in,__cfg).__Result) __E_Person := E_Person_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Professional_License_4(__in,__cfg).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local(__in,__cfg).__ENH_Professional_License_4;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Person_Vehicle_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Vehicle_3(__in,__cfg))
    SHARED TYPEOF(B_Person_Vehicle_4(__in,__cfg).__ENH_Person_Vehicle_4) __ENH_Person_Vehicle_4 := B_Person_Vehicle_4_Local(__in,__cfg).__ENH_Person_Vehicle_4;
  END;
  SHARED B_Professional_License_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Professional_License_3(__in,__cfg))
    SHARED TYPEOF(B_Professional_License_4(__in,__cfg).__ENH_Professional_License_4) __ENH_Professional_License_4 := B_Professional_License_4_Local(__in,__cfg).__ENH_Professional_License_4;
  END;
  SHARED B_Watercraft_Owner_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Watercraft_Owner_3(__in,__cfg))
    SHARED TYPEOF(B_Watercraft_Owner_4(__in,__cfg).__ENH_Watercraft_Owner_4) __ENH_Watercraft_Owner_4 := B_Watercraft_Owner_4_Local(__in,__cfg).__ENH_Watercraft_Owner_4;
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
  SHARED B_Person_Bankruptcy_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_Bankruptcy_1(__in,__cfg))
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
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
    SHARED TYPEOF(B_Person_Bankruptcy_1(__in,__cfg).__ENH_Person_Bankruptcy_1) __ENH_Person_Bankruptcy_1 := B_Person_Bankruptcy_1_Local(__in,__cfg).__ENH_Person_Bankruptcy_1;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Person_Vehicle_1(__in,__cfg).__ENH_Person_Vehicle_1) __ENH_Person_Vehicle_1 := B_Person_Vehicle_1_Local(__in,__cfg).__ENH_Person_Vehicle_1;
    SHARED TYPEOF(B_Professional_License_1(__in,__cfg).__ENH_Professional_License_1) __ENH_Professional_License_1 := B_Professional_License_1_Local(__in,__cfg).__ENH_Professional_License_1;
    SHARED TYPEOF(E_Professional_License_Person(__in,__cfg).__Result) __E_Professional_License_Person := E_Professional_License_Person_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(B_Watercraft_Owner_1(__in,__cfg).__ENH_Watercraft_Owner_1) __ENH_Watercraft_Owner_1 := B_Watercraft_Owner_1_Local(__in,__cfg).__ENH_Watercraft_Owner_1;
  END;
  SHARED TYPEOF(B_Person(__in,__cfg_Local).__ENH_Person) __ENH_Person := B_Person_Local(__in,__cfg_Local).__ENH_Person;
  SHARED __EE1429002 := __ENH_Person;
  SHARED __EE1436486 := __EE1429002(__T(__OP2(__EE1429002.UID,=,__CN(__PLexID_in))));
  SHARED __ST35229_Layout := RECORD
    KEL.typ.nuid Lex_I_D_;
    KEL.typ.str P___Lex_I_D_Seen_Flag_ := '';
    KEL.typ.int P_L___Ast_Veh_Auto_Cnt_Ev_ := 0;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST986624_Layout) P_L___Ast_Veh_Auto_Emrg_Dt_List_Ev_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST986644_Layout) P_L___Ast_Veh_Auto_Last_Dt_List_Ev_;
    KEL.typ.int P_L___Ast_Veh_Auto_Cnt10_Y_ := 0;
    KEL.typ.int P_L___Ast_Veh_Auto_Cnt2_Y_ := 0;
    KEL.typ.nstr P_L___Ast_Veh_Auto_Emrg_New_Dt_Ev_;
    KEL.typ.nstr P_L___Ast_Veh_Auto_Emrg_Old_Dt_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_New_Msnc_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Auto_Emrg_Old_Msnc_Ev_;
    KEL.typ.int P_L___Ast_Veh_Air_Cnt_Ev_ := 0;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST30957_Layout) P_L___Ast_Veh_Air_Emrg_Dt_List_Ev_;
    KEL.typ.nstr P_L___Ast_Veh_Air_Emrg_New_Dt_Ev_;
    KEL.typ.nstr P_L___Ast_Veh_Air_Emrg_Old_Dt_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Air_Emrg_New_Msnc_Ev_;
    KEL.typ.nint P_L___Ast_Veh_Air_Emrg_Old_Msnc_Ev_;
    KEL.typ.int P_L___Ast_Veh_Wtr_Cnt_Ev_ := 0;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST31195_Layout) P_L___Ast_Veh_Wtr_Emrg_Dt_List_Ev_;
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
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST32821_Layout) P_L___Drg_Bk_Dt_List1_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST32843_Layout) P_L___Drg_Bk_Dt_List7_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST32865_Layout) P_L___Drg_Bk_Dt_List10_Y_;
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
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST33088_Layout) P_L___Drg_Bk_Ch_List1_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST33118_Layout) P_L___Drg_Bk_Ch_List7_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST33148_Layout) P_L___Drg_Bk_Ch_List10_Y_;
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
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST33936_Layout) P_L___Drg_Bk_Disp_List1_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST33970_Layout) P_L___Drg_Bk_Disp_List7_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST34004_Layout) P_L___Drg_Bk_Disp_List10_Y_;
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
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST34538_Layout) P_L___Drg_Bk_Type_List1_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST34575_Layout) P_L___Drg_Bk_Type_List7_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST34612_Layout) P_L___Drg_Bk_Type_List10_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Bus_Flag1_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Bus_Flag7_Y_;
    KEL.typ.nstr P_L___Drg_Bk_Bus_Flag10_Y_;
    KEL.typ.str P_L___Drg_Bk_Severity_Indx10_Y_ := '';
    KEL.typ.str P_L___Prof_Lic_Flag_Ev_ := '';
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST34958_Layout) P_L___Prof_Lic_Issue_Dt_List_Ev_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST34966_Layout) P_L___Prof_Lic_Exp_Dt_List_Ev_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST34982_Layout) P_L___Prof_Lic_Indx_By_Lic_List_Ev_;
    KEL.typ.str P_L___Prof_Lic_Actv_Flag_ := '';
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Issue_Dt_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Exp_Dt_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Type_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Title_Type_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Indx_;
    KEL.typ.nstr P_L___Prof_Lic_Actv_New_Src_Type_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE1436486,TRANSFORM(__ST35229_Layout,SELF.Lex_I_D_ := LEFT.UID,SELF := LEFT)));
END;
