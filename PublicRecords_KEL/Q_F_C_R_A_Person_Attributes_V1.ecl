﻿//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT B_Bankruptcy_1,B_Bankruptcy_2,B_Bankruptcy_3,B_Bankruptcy_4,B_Bankruptcy_5,B_Bankruptcy_6,B_Bankruptcy_7,B_Criminal_Offense_1,B_Criminal_Offense_2,B_Criminal_Offense_3,B_Criminal_Offense_4,B_Person,B_Person_1,B_Person_2,B_Person_3,CFG_Compile,E_Bankruptcy,E_Criminal_Offense,E_Person,E_Person_Bankruptcy,E_Person_Offenses FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT Q_F_C_R_A_Person_Attributes_V1(SET OF KEL.typ.uid __PLexIDs, KEL.typ.kdate __PArchiveDate, UNSIGNED1 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PArchiveDate;
  END;
  SHARED E_Person_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,IN,__CN(__PLexIDs)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Person_Bankruptcy_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Bankruptcy(__in,__cfg))
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
  SHARED E_Bankruptcy_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__FN1(KEL.Routines.TrimAll,__g.Case_Number_),<>,__CN(''))))) AND EXISTS(__g(__T(__NOT(__NT(__g.Case_Number_)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(HAVING(__ds,__GroupTest(ROWS(LEFT))),E_Person_Bankruptcy_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Bankrupt_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Criminal_Offense_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Offense(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PArchiveDate))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Offenses_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Offense_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Filtered := E_Person_Filtered_2;
  SHARED E_Person_Bankruptcy_Filtered := E_Person_Bankruptcy_Filtered_1;
  SHARED E_Person_Offenses_Filtered := E_Person_Offenses_Filtered_1;
  SHARED B_Bankruptcy_7_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_7(__in,__cfg))
    SHARED TYPEOF(E_Bankruptcy(__in,__cfg).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Bankruptcy_6_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_6(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_7(__in,__cfg).__ENH_Bankruptcy_7) __ENH_Bankruptcy_7 := B_Bankruptcy_7_Local(__in,__cfg).__ENH_Bankruptcy_7;
  END;
  SHARED B_Bankruptcy_5_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_5(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_6(__in,__cfg).__ENH_Bankruptcy_6) __ENH_Bankruptcy_6 := B_Bankruptcy_6_Local(__in,__cfg).__ENH_Bankruptcy_6;
  END;
  SHARED B_Bankruptcy_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_4(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_5(__in,__cfg).__ENH_Bankruptcy_5) __ENH_Bankruptcy_5 := B_Bankruptcy_5_Local(__in,__cfg).__ENH_Bankruptcy_5;
  END;
  SHARED B_Criminal_Offense_4_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_4(__in,__cfg))
    SHARED TYPEOF(E_Criminal_Offense(__in,__cfg).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered(__in,__cfg).__Result;
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
  END;
  SHARED B_Bankruptcy_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_2(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local(__in,__cfg).__ENH_Bankruptcy_3;
  END;
  SHARED B_Criminal_Offense_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_2(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_3(__in,__cfg).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local(__in,__cfg).__ENH_Criminal_Offense_3;
  END;
  SHARED B_Person_2_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_2(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_3(__in,__cfg).__ENH_Bankruptcy_3) __ENH_Bankruptcy_3 := B_Bankruptcy_3_Local(__in,__cfg).__ENH_Bankruptcy_3;
    SHARED TYPEOF(B_Criminal_Offense_3(__in,__cfg).__ENH_Criminal_Offense_3) __ENH_Criminal_Offense_3 := B_Criminal_Offense_3_Local(__in,__cfg).__ENH_Criminal_Offense_3;
    SHARED TYPEOF(B_Person_3(__in,__cfg).__ENH_Person_3) __ENH_Person_3 := B_Person_3_Local(__in,__cfg).__ENH_Person_3;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Bankruptcy_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Bankruptcy_1(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local(__in,__cfg).__ENH_Bankruptcy_2;
  END;
  SHARED B_Criminal_Offense_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Criminal_Offense_1(__in,__cfg))
    SHARED TYPEOF(B_Criminal_Offense_2(__in,__cfg).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local(__in,__cfg).__ENH_Criminal_Offense_2;
  END;
  SHARED B_Person_1_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person_1(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_2(__in,__cfg).__ENH_Bankruptcy_2) __ENH_Bankruptcy_2 := B_Bankruptcy_2_Local(__in,__cfg).__ENH_Bankruptcy_2;
    SHARED TYPEOF(B_Criminal_Offense_2(__in,__cfg).__ENH_Criminal_Offense_2) __ENH_Criminal_Offense_2 := B_Criminal_Offense_2_Local(__in,__cfg).__ENH_Criminal_Offense_2;
    SHARED TYPEOF(B_Person_2(__in,__cfg).__ENH_Person_2) __ENH_Person_2 := B_Person_2_Local(__in,__cfg).__ENH_Person_2;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg).__Result;
  END;
  SHARED B_Person_Local(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(B_Person(__in,__cfg))
    SHARED TYPEOF(B_Bankruptcy_1(__in,__cfg).__ENH_Bankruptcy_1) __ENH_Bankruptcy_1 := B_Bankruptcy_1_Local(__in,__cfg).__ENH_Bankruptcy_1;
    SHARED TYPEOF(B_Criminal_Offense_1(__in,__cfg).__ENH_Criminal_Offense_1) __ENH_Criminal_Offense_1 := B_Criminal_Offense_1_Local(__in,__cfg).__ENH_Criminal_Offense_1;
    SHARED TYPEOF(B_Person_1(__in,__cfg).__ENH_Person_1) __ENH_Person_1 := B_Person_1_Local(__in,__cfg).__ENH_Person_1;
    SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg).__Result;
    SHARED TYPEOF(E_Person_Offenses(__in,__cfg).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg).__Result;
  END;
  SHARED TYPEOF(B_Person(__in,__cfg_Local).__ENH_Person) __ENH_Person := B_Person_Local(__in,__cfg_Local).__ENH_Person;
  SHARED __EE410330 := __ENH_Person;
  SHARED __EE413755 := __EE410330(__T(__OP2(__EE410330.UID,IN,__CN(__PLexIDs))));
  SHARED __ST17545_Layout := RECORD
    KEL.typ.nuid Lex_I_D_;
    KEL.typ.int Felony_Cnt1_Y_ := 0;
    KEL.typ.int Felony_Cnt7_Y_ := 0;
    KEL.typ.nstr Felony_New1_Y_;
    KEL.typ.nstr Felony_Old1_Y_;
    KEL.typ.nstr Felony_New7_Y_;
    KEL.typ.nstr Felony_Old7_Y_;
    KEL.typ.nint Mon_Since_Newest_Felony_Cnt1_Y_;
    KEL.typ.nint Mon_Since_Oldest_Felony_Cnt1_Y_;
    KEL.typ.nint Mon_Since_Newest_Felony_Cnt7_Y_;
    KEL.typ.nint Mon_Since_Oldest_Felony_Cnt7_Y_;
    KEL.typ.int Non_Felony_Cnt1_Y_ := 0;
    KEL.typ.int Nonfelony_Cnt7_Y_ := 0;
    KEL.typ.nstr Nonfelony_New1_Y_;
    KEL.typ.nstr Nonfelony_Old1_Y_;
    KEL.typ.nstr Nonfelony_New7_Y_;
    KEL.typ.nstr Nonfelony_Old7_Y_;
    KEL.typ.nint Mon_Since_Newest_Nonfelony_Cnt1_Y_;
    KEL.typ.nint Mon_Since_Oldest_Nonfelony_Cnt1_Y_;
    KEL.typ.nint Mon_Since_Newest_Nonfelony_Cnt7_Y_;
    KEL.typ.nint Mon_Since_Oldest_Nonfelony_Cnt7_Y_;
    KEL.typ.int Crim_Cnt1_Y_ := 0;
    KEL.typ.int Crim_Cnt7_Y_ := 0;
    KEL.typ.nstr Crim_New1_Y_;
    KEL.typ.nstr Crim_Old1_Y_;
    KEL.typ.nstr Crim_New7_Y_;
    KEL.typ.nstr Crim_Old7_Y_;
    KEL.typ.nint Mon_Since_Newest_Crim_Cnt1_Y_;
    KEL.typ.nint Mon_Since_Oldest_Crim_Cnt1_Y_;
    KEL.typ.nint Mon_Since_Newest_Crim_Cnt7_Y_;
    KEL.typ.nint Mon_Since_Oldest_Crim_Cnt7_Y_;
    KEL.typ.nstr Crim_Severity_Index7_Y_;
    KEL.typ.nstr Crim_Behavior_Index7_Y_;
    KEL.typ.int Bk_Cnt1_Y_ := 0;
    KEL.typ.int Bk_Cnt7_Y_ := 0;
    KEL.typ.int Bk_Cnt10_Y_ := 0;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST15665_Layout) Dt_Of_Bks_List1_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST15683_Layout) Dt_Of_Bks_List7_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST15701_Layout) Dt_Of_Bks_List10_Y_;
    KEL.typ.nstr Bk_New1_Y_;
    KEL.typ.nstr Bk_New7_Y_;
    KEL.typ.nstr Bk_New10_Y_;
    KEL.typ.nstr Bk_Old1_Y_;
    KEL.typ.nstr Bk_Old7_Y_;
    KEL.typ.nstr Bk_Old10_Y_;
    KEL.typ.nint Mon_Since_Newest_Bk_Cnt1_Y_;
    KEL.typ.nint Mon_Since_Newest_Bk_Cnt7_Y_;
    KEL.typ.nint Mon_Since_Newest_Bk_Cnt10_Y_;
    KEL.typ.nint Mon_Since_Oldest_Bk_Cnt1_Y_;
    KEL.typ.nint Mon_Since_Oldest_Bk_Cnt7_Y_;
    KEL.typ.nint Mon_Since_Oldest_Bk_Cnt10_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST15882_Layout) Ch_For_Bks_List1_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST15903_Layout) Ch_For_Bks_List7_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST15924_Layout) Ch_For_Bks_List10_Y_;
    KEL.typ.nstr Bk_With_Newest_Date_Ch1_Y_;
    KEL.typ.nstr Bk_With_Newest_Date_Ch7_Y_;
    KEL.typ.nstr Bk_With_Newest_Date_Ch10_Y_;
    KEL.typ.int Bk_Under_Ch7_Cnt1_Y_ := 0;
    KEL.typ.int Bk_Under_Ch7_Cnt7_Y_ := 0;
    KEL.typ.int Bk_Under_Ch7_Cnt10_Y_ := 0;
    KEL.typ.int Bk_Under_Ch13_Cnt1_Y_ := 0;
    KEL.typ.int Bk_Under_Ch13_Cnt7_Y_ := 0;
    KEL.typ.int Bk_Under_Ch13_Cnt10_Y_ := 0;
    KEL.typ.nstr Newest_Bk_Update_Dt1_Y_;
    KEL.typ.nstr Newest_Bk_Update_Dt7_Y_;
    KEL.typ.nstr Newest_Bk_Update_Dt10_Y_;
    KEL.typ.nstr Mon_Since_Newest_Bk_Update_Cnt1_Y_;
    KEL.typ.nstr Mon_Since_Newest_Bk_Update_Cnt7_Y_;
    KEL.typ.nstr Mon_Since_Newest_Bk_Update_Cnt10_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST16556_Layout) Disp_Of_Bks_List1_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST16580_Layout) Disp_Of_Bks_List7_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST16604_Layout) Disp_Of_Bks_List10_Y_;
    KEL.typ.nstr Bk_With_Newest_Date_Disp1_Y_;
    KEL.typ.nstr Bk_With_Newest_Date_Disp7_Y_;
    KEL.typ.nstr Bk_With_Newest_Date_Disp10_Y_;
    KEL.typ.nstr Disp_Of_Newest_Bk_Dt1_Y_;
    KEL.typ.nstr Disp_Of_Newest_Bk_Dt7_Y_;
    KEL.typ.nstr Disp_Of_Newest_Bk_Dt10_Y_;
    KEL.typ.nstr Mon_Since_Disp_Of_Newest_Bk_Cnt1_Y_;
    KEL.typ.nstr Mon_Since_Disp_Of_Newest_Bk_Cnt7_Y_;
    KEL.typ.nstr Mon_Since_Disp_Of_Newest_Bk_Cnt10_Y_;
    KEL.typ.int Bk_Disposed_Cnt1_Y_ := 0;
    KEL.typ.int Bk_Disposed_Cnt7_Y_ := 0;
    KEL.typ.int Bk_Disposed_Cnt10_Y_ := 0;
    KEL.typ.int Bk_Dismissed_Cnt1_Y_ := 0;
    KEL.typ.int Bk_Dismissed_Cnt7_Y_ := 0;
    KEL.typ.int Bk_Dismissed_Cnt10_Y_ := 0;
    KEL.typ.int Bk_Discharged_Cnt1_Y_ := 0;
    KEL.typ.int Bk_Discharged_Cnt7_Y_ := 0;
    KEL.typ.int Bk_Discharged_Cnt10_Y_ := 0;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST17063_Layout) Type_Of_Bks_List1_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST17097_Layout) Type_Of_Bks_List7_Y_;
    KEL.typ.ndataset(B_Person(__in,__cfg_Local).__ST17131_Layout) Type_Of_Bks_List10_Y_;
    KEL.typ.nstr Bk_Having_Bus_Type_Flag1_Y_;
    KEL.typ.nstr Bk_Having_Bus_Type_Flag7_Y_;
    KEL.typ.nstr Bk_Having_Bus_Type_Flag10_Y_;
    KEL.typ.str Bk_Severity_Index10_Y_ := '';
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(__EE413755,TRANSFORM(__ST17545_Layout,SELF.Lex_I_D_ := LEFT.UID,SELF := LEFT)));
END;
