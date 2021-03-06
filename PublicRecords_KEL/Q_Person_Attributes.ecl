//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Criminal_Offender_1,B_Criminal_Offender_2,B_Criminal_Offender_3,B_Criminal_Offense_1,B_Criminal_Offense_2,B_Criminal_Offense_3,B_Criminal_Offense_4,B_Person,B_Person_1,B_Person_2,CFG_Compile,E_Criminal_Offender,E_Criminal_Offense,E_Person,E_Person_Offender,E_Person_Offenses FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT Q_Person_Attributes(KEL.typ.uid __PLexID, KEL.typ.kdate __PArchiveDate, UNSIGNED1 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PArchiveDate;
  END;
  SHARED E_Person_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PLexID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Person_Offender_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Offender(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Offenses_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Offenses(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Criminal_Offender_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Offender(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Offender_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Offender_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Criminal_Offense_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Offense(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Offenses_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Offense_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Filtered := E_Person_Filtered_2;
  SHARED E_Person_Offender_Filtered := E_Person_Offender_Filtered_1;
  SHARED E_Person_Offenses_Filtered := E_Person_Offenses_Filtered_1;
  SHARED B_Criminal_Offense_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_4(__in,__cfg))
    SHARED TYPEOF(E_Criminal_Offense(__in,__cfg).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Criminal_Offender_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offender_3(__in,__cfg))
    SHARED TYPEOF(E_Criminal_Offender(__in,__cfg).__Result) __E_Criminal_Offender := E_Criminal_Offender_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Criminal_Offense_3_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_3(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_4(__in,__cfg).__ENH_Criminal_Offense_4) __ENH_Criminal_Offense_4 := B_Criminal_Offense_4_Local(__in,__cfg).__ENH_Criminal_Offense_4;
  END;
  SHARED B_Criminal_Offender_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offender_2(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offender_3(__in,__cfg).__ENH_Criminal_Offender_3) __ENH_Criminal_Offender_3 := B_Criminal_Offender_3_Local(__in,__cfg).__ENH_Criminal_Offender_3;
  END;
  SHARED B_Criminal_Offense_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_2(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_3(__in,__cfg).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local(__in,__cfg).__ENH_Criminal_Offense_3;
  END;
  SHARED B_Person_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_2(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_3(__in,__cfg).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local(__in,__cfg).__ENH_Criminal_Offense_3;
    SHARED TYPEOF(E_Person(__in,__cfg).__Result) __E_Person := E_Person_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Criminal_Offender_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offender_1(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offender_2(__in,__cfg).__ENH_Criminal_Offender_2) __ENH_Criminal_Offender_2 := B_Criminal_Offender_2_Local(__in,__cfg).__ENH_Criminal_Offender_2;
  END;
  SHARED B_Criminal_Offense_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_1(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_2(__in,__cfg).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local(__in,__cfg).__ENH_Criminal_Offense_2;
  END;
  SHARED B_Person_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_1(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offender_2(__in,__cfg).__ENH_Criminal_Offender_2) __ENH_Criminal_Offender_2 := B_Criminal_Offender_2_Local(__in,__cfg).__ENH_Criminal_Offender_2;
    SHARED TYPEOF(B_Criminal_Offense_2(__in,__cfg).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local(__in,__cfg).__ENH_Criminal_Offense_2;
    SHARED TYPEOF(B_Person_2(__in,__cfg).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local(__in,__cfg).__ENH_Person_2;
    SHARED TYPEOF(E_Person_Offender(__in,__cfg).__Result) __E_Person_Offender := E_Person_Offender_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Person_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offender_1(__in,__cfg).__ENH_Criminal_Offender_1) __ENH_Criminal_Offender_1 := B_Criminal_Offender_1_Local(__in,__cfg).__ENH_Criminal_Offender_1;
    SHARED TYPEOF(B_Criminal_Offense_1(__in,__cfg).__ENH_Criminal_Offense_1) __ENH_Criminal_Offense_1 := B_Criminal_Offense_1_Local(__in,__cfg).__ENH_Criminal_Offense_1;
    SHARED TYPEOF(B_Person_1(__in,__cfg).__ENH_Person_1) __ENH_Person_1 := B_Person_1_Local(__in,__cfg).__ENH_Person_1;
    SHARED TYPEOF(E_Person_Offender(__in,__cfg).__Result) __E_Person_Offender := E_Person_Offender_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg).__Result;
  END;
  SHARED TYPEOF(B_Person(__in,__cfg_Local).__ENH_Person) __ENH_Person := B_Person_Local(__in,__cfg_Local).__ENH_Person;
  SHARED __EE106922 := __ENH_Person;
  SHARED __EE107515 := __EE106922(__T(__OP2(__EE106922.UID,=,__CN(__PLexID))));
  SHARED __ST9860_Layout := RECORD
    KEL.typ.nuid Lex_I_D_;
    KEL.typ.int Felony_Cnt1_Y_ := 0;
    KEL.typ.int Felony_Cnt7_Y_ := 0;
    KEL.typ.nkdate Felony_New1_Y_;
    KEL.typ.nkdate Felony_Old1_Y_;
    KEL.typ.nkdate Felony_New7_Y_;
    KEL.typ.nkdate Felony_Old7_Y_;
    KEL.typ.nint Mon_Since_Newest_Felony_Cnt1_Y_;
    KEL.typ.nint Mon_Since_Oldest_Felony_Cnt1_Y_;
    KEL.typ.nint Mon_Since_Newest_Felony_Cnt7_Y_;
    KEL.typ.nint Mon_Since_Oldest_Felony_Cnt7_Y_;
    KEL.typ.int Non_Felony_Cnt1_Y_ := 0;
    KEL.typ.int Nonfelony_Cnt7_Y_ := 0;
    KEL.typ.nkdate Nonfelony_New1_Y_;
    KEL.typ.nkdate Nonfelony_Old1_Y_;
    KEL.typ.nkdate Nonfelony_New7_Y_;
    KEL.typ.nkdate Nonfelony_Old7_Y_;
    KEL.typ.nint Mon_Since_Newest_Nonfelony_Cnt1_Y_;
    KEL.typ.nint Mon_Since_Oldest_Nonfelony_Cnt1_Y_;
    KEL.typ.nint Mon_Since_Newest_Nonfelony_Cnt7_Y_;
    KEL.typ.nint Mon_Since_Oldest_Nonfelony_Cnt7_Y_;
    KEL.typ.int Arrest_Cnt1_Y_ := 0;
    KEL.typ.int Arrest_Cnt7_Y_ := 0;
    KEL.typ.nkdate Arrest_New1_Y_;
    KEL.typ.nkdate Arrest_Old1_Y_;
    KEL.typ.nkdate Arrest_New7_Y_;
    KEL.typ.nkdate Arrest_Old7_Y_;
    KEL.typ.nint Mon_Since_Newest_Arrest_Cnt1_Y_;
    KEL.typ.nint Mon_Since_Oldest_Arrest_Cnt1_Y_;
    KEL.typ.nint Mon_Since_Newest_Arrest_Cnt7_Y_;
    KEL.typ.nint Mon_Since_Oldest_Arrest_Cnt7_Y_;
    KEL.typ.int Crim_Cnt1_Y_ := 0;
    KEL.typ.int Crim_Cnt7_Y_ := 0;
    KEL.typ.nkdate Crim_New1_Y_;
    KEL.typ.nkdate Crim_Old1_Y_;
    KEL.typ.nkdate Crim_New7_Y_;
    KEL.typ.nkdate Crim_Old7_Y_;
    KEL.typ.nint Mon_Since_Newest_Crim_Cnt1_Y_;
    KEL.typ.nint Mon_Since_Oldest_Crim_Cnt1_Y_;
    KEL.typ.nint Mon_Since_Newest_Crim_Cnt7_Y_;
    KEL.typ.nint Mon_Since_Oldest_Crim_Cnt7_Y_;
    KEL.typ.nstr Crim_Severity_Index7_Y_;
    KEL.typ.nstr Crim_Behavior_Index7_Y_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE107515,TRANSFORM(__ST9860_Layout,SELF.Lex_I_D_ := LEFT.UID,SELF := LEFT)));
END;
