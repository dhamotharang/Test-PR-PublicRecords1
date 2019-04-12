//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT CFG_Compile,E_Address,E_Bankruptcy,E_Criminal_Offender,E_Criminal_Offense,E_Person,E_Person_Address,E_Person_Bankruptcy,E_Person_Offender,E_Person_Offenses,E_Person_Phone,E_Person_S_S_N,E_Phone,E_Social_Security_Number,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT Q_Data_Permissions(SET OF KEL.typ.uid __PLexIDs, UNSIGNED8 __PDPM, KEL.typ.kdate __PInputArchiveDateClean, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED __cfg_Local := MODULE(CFG_Compile)
    EXPORT KEL.typ.kdate CurrentDate := __PInputArchiveDateClean;
  END;
  SHARED E_Person_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,IN,__CN(__PLexIDs)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Person_Address_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Bankruptcy_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Offender_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Offender(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Offenses_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Offenses(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Phone_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_Phone(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_S_S_N_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Person_S_S_N(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_2(__in,__cfg).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Address_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Address(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Address_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Location_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Bankruptcy_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Bankruptcy(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Bankruptcy_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Bankrupt_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Criminal_Offender_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Offender(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Offender_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Offender_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Criminal_Offense_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Criminal_Offense(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Offenses_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Offense_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Phone_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Phone(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Phone_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Phone_Number_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Social_Security_Number_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE(E_Social_Security_Number(__in,__cfg))
    SHARED __AsofFitler(DATASET(InLayout) __ds) := __ds(__T(__OP2(KEL.era.ToDateMinNull(__ds.Date_First_Seen_),<=,__CN(__PInputArchiveDateClean))));
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__AsofFitler(__ds));
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_S_S_N_Filtered_1(__in,__cfg).__PostFilter,__EEQP(LEFT.UID,RIGHT.Social_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Filtered := E_Person_Filtered_2;
  SHARED E_Person_Address_Filtered := E_Person_Address_Filtered_1;
  SHARED E_Person_Bankruptcy_Filtered := E_Person_Bankruptcy_Filtered_1;
  SHARED E_Person_Offender_Filtered := E_Person_Offender_Filtered_1;
  SHARED E_Person_Offenses_Filtered := E_Person_Offenses_Filtered_1;
  SHARED E_Person_Phone_Filtered := E_Person_Phone_Filtered_1;
  SHARED E_Person_S_S_N_Filtered := E_Person_S_S_N_Filtered_1;
  SHARED TYPEOF(E_Address(__in,__cfg_Local).__Result) __E_Address := E_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Bankruptcy(__in,__cfg_Local).__Result) __E_Bankruptcy := E_Bankruptcy_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Criminal_Offender(__in,__cfg_Local).__Result) __E_Criminal_Offender := E_Criminal_Offender_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Criminal_Offense(__in,__cfg_Local).__Result) __E_Criminal_Offense := E_Criminal_Offense_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person(__in,__cfg_Local).__Result) __E_Person := E_Person_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Address(__in,__cfg_Local).__Result) __E_Person_Address := E_Person_Address_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Bankruptcy(__in,__cfg_Local).__Result) __E_Person_Bankruptcy := E_Person_Bankruptcy_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Offender(__in,__cfg_Local).__Result) __E_Person_Offender := E_Person_Offender_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Offenses(__in,__cfg_Local).__Result) __E_Person_Offenses := E_Person_Offenses_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_Phone(__in,__cfg_Local).__Result) __E_Person_Phone := E_Person_Phone_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Person_S_S_N(__in,__cfg_Local).__Result) __E_Person_S_S_N := E_Person_S_S_N_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Phone(__in,__cfg_Local).__Result) __E_Phone := E_Phone_Filtered(__in,__cfg_Local).__Result;
  SHARED TYPEOF(E_Social_Security_Number(__in,__cfg_Local).__Result) __E_Social_Security_Number := E_Social_Security_Number_Filtered(__in,__cfg_Local).__Result;
  SHARED __EE485287 := __E_Person;
  SHARED __EE485365 := __EE485287(__T(__OP2(__EE485287.UID,IN,__CN(__PLexIDs))));
  SHARED __ST21818_Layout := RECORD
    KEL.typ.ndataset(E_Person(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST21818_Layout __ND485370__Rollup(__ST21818_Layout __r, DATASET(__ST21818_Layout) __recs) := TRANSFORM
    __recs_Data_Sources_ := NORMALIZE(__recs,__T(LEFT.Data_Sources_),TRANSFORM(E_Person(__in,__cfg_Local).Data_Sources_Layout,SELF:=RIGHT));
    __recs_Data_Sources__allnull := NOT EXISTS(__recs(__NN(Data_Sources_)));
    SELF.Data_Sources_ := __BN(PROJECT(TABLE(__recs_Data_Sources_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),E_Person(__in,__cfg_Local).Data_Sources_Layout),__recs_Data_Sources__allnull);
    SELF.__RecordCount := SUM(__recs,__RecordCount);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  SHARED __EE485379 := ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__EE485365,__ST21818_Layout),'Data_Sources_','data_sources_','clean','__recordcount,date_first_seen_,date_last_seen_'),Data_Sources_Clean,ALL),GROUP,__ND485370__Rollup(ROW(LEFT,__ST21818_Layout), PROJECT(ROWS(LEFT),__ST21818_Layout)));
  EXPORT Res0 := __UNWRAP(__EE485379);
  SHARED __EE485406 := __E_Person_Address;
  SHARED __EE485552 := __EE485406(__NN(__EE485406.Subject_));
  SHARED __EE485400 := __E_Person;
  SHARED __EE485574 := __EE485400(__T(__OP2(__EE485400.UID,IN,__CN(__PLexIDs))));
  __JC485580(E_Person_Address(__in,__cfg_Local).Layout __EE485552, E_Person(__in,__cfg_Local).Layout __EE485574) := __EEQP(__EE485574.UID,__EE485552.Subject_);
  SHARED __EE485588 := JOIN(__EE485552,__EE485574,__JC485580(LEFT,RIGHT),TRANSFORM(E_Person_Address(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST21831_Layout := RECORD
    KEL.typ.ndataset(E_Person_Address(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST21831_Layout __ND485593__Rollup(__ST21831_Layout __r, DATASET(__ST21831_Layout) __recs) := TRANSFORM
    __recs_Data_Sources_ := NORMALIZE(__recs,__T(LEFT.Data_Sources_),TRANSFORM(E_Person_Address(__in,__cfg_Local).Data_Sources_Layout,SELF:=RIGHT));
    __recs_Data_Sources__allnull := NOT EXISTS(__recs(__NN(Data_Sources_)));
    SELF.Data_Sources_ := __BN(PROJECT(TABLE(__recs_Data_Sources_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),E_Person_Address(__in,__cfg_Local).Data_Sources_Layout),__recs_Data_Sources__allnull);
    SELF.__RecordCount := SUM(__recs,__RecordCount);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  SHARED __EE485602 := ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__EE485588,__ST21831_Layout),'Data_Sources_','data_sources_','clean','__recordcount,date_first_seen_,date_last_seen_'),Data_Sources_Clean,ALL),GROUP,__ND485593__Rollup(ROW(LEFT,__ST21831_Layout), PROJECT(ROWS(LEFT),__ST21831_Layout)));
  EXPORT Res1 := __UNWRAP(__EE485602);
  SHARED __EE485658 := __E_Address;
  SHARED __EE485648 := __E_Person_Address;
  SHARED __EE486090 := __EE485648(__NN(__EE485648.Subject_) AND __NN(__EE485648.Location_));
  SHARED __EE485642 := __E_Person;
  SHARED __EE486233 := __EE485642(__T(__OP2(__EE485642.UID,IN,__CN(__PLexIDs))));
  __JC486239(E_Person_Address(__in,__cfg_Local).Layout __EE486090, E_Person(__in,__cfg_Local).Layout __EE486233) := __EEQP(__EE486233.UID,__EE486090.Subject_);
  SHARED __EE486247 := JOIN(__EE486090,__EE486233,__JC486239(LEFT,RIGHT),TRANSFORM(E_Person_Address(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC486253(E_Address(__in,__cfg_Local).Layout __EE485658, E_Person_Address(__in,__cfg_Local).Layout __EE486247) := __EEQP(__EE486247.Location_,__EE485658.UID);
  SHARED __EE486346 := JOIN(__EE485658,__EE486247,__JC486253(LEFT,RIGHT),TRANSFORM(E_Address(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST21846_Layout := RECORD
    KEL.typ.ndataset(E_Address(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST21846_Layout __ND486351__Rollup(__ST21846_Layout __r, DATASET(__ST21846_Layout) __recs) := TRANSFORM
    __recs_Data_Sources_ := NORMALIZE(__recs,__T(LEFT.Data_Sources_),TRANSFORM(E_Address(__in,__cfg_Local).Data_Sources_Layout,SELF:=RIGHT));
    __recs_Data_Sources__allnull := NOT EXISTS(__recs(__NN(Data_Sources_)));
    SELF.Data_Sources_ := __BN(PROJECT(TABLE(__recs_Data_Sources_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),E_Address(__in,__cfg_Local).Data_Sources_Layout),__recs_Data_Sources__allnull);
    SELF.__RecordCount := SUM(__recs,__RecordCount);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  SHARED __EE486360 := ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__EE486346,__ST21846_Layout),'Data_Sources_','data_sources_','clean','__recordcount,date_first_seen_,date_last_seen_'),Data_Sources_Clean,ALL),GROUP,__ND486351__Rollup(ROW(LEFT,__ST21846_Layout), PROJECT(ROWS(LEFT),__ST21846_Layout)));
  EXPORT Res2 := __UNWRAP(__EE486360);
  SHARED __EE486520 := __E_Person_Bankruptcy;
  SHARED __EE486664 := __EE486520(__NN(__EE486520.Subject_));
  SHARED __EE486514 := __E_Person;
  SHARED __EE486685 := __EE486514(__T(__OP2(__EE486514.UID,IN,__CN(__PLexIDs))));
  __JC486691(E_Person_Bankruptcy(__in,__cfg_Local).Layout __EE486664, E_Person(__in,__cfg_Local).Layout __EE486685) := __EEQP(__EE486685.UID,__EE486664.Subject_);
  SHARED __EE486698 := JOIN(__EE486664,__EE486685,__JC486691(LEFT,RIGHT),TRANSFORM(E_Person_Bankruptcy(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST21859_Layout := RECORD
    KEL.typ.ndataset(E_Person_Bankruptcy(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST21859_Layout __ND486703__Rollup(__ST21859_Layout __r, DATASET(__ST21859_Layout) __recs) := TRANSFORM
    __recs_Data_Sources_ := NORMALIZE(__recs,__T(LEFT.Data_Sources_),TRANSFORM(E_Person_Bankruptcy(__in,__cfg_Local).Data_Sources_Layout,SELF:=RIGHT));
    __recs_Data_Sources__allnull := NOT EXISTS(__recs(__NN(Data_Sources_)));
    SELF.Data_Sources_ := __BN(PROJECT(TABLE(__recs_Data_Sources_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),E_Person_Bankruptcy(__in,__cfg_Local).Data_Sources_Layout),__recs_Data_Sources__allnull);
    SELF.__RecordCount := SUM(__recs,__RecordCount);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  SHARED __EE486712 := ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__EE486698,__ST21859_Layout),'Data_Sources_','data_sources_','clean','__recordcount,date_first_seen_,date_last_seen_'),Data_Sources_Clean,ALL),GROUP,__ND486703__Rollup(ROW(LEFT,__ST21859_Layout), PROJECT(ROWS(LEFT),__ST21859_Layout)));
  EXPORT Res3 := __UNWRAP(__EE486712);
  SHARED __EE486768 := __E_Bankruptcy;
  SHARED __EE486757 := __E_Person_Bankruptcy;
  SHARED __EE487082 := __EE486757(__NN(__EE486757.Subject_) AND __NN(__EE486757.Bankrupt_));
  SHARED __EE486751 := __E_Person;
  SHARED __EE487173 := __EE486751(__T(__OP2(__EE486751.UID,IN,__CN(__PLexIDs))));
  __JC487179(E_Person_Bankruptcy(__in,__cfg_Local).Layout __EE487082, E_Person(__in,__cfg_Local).Layout __EE487173) := __EEQP(__EE487173.UID,__EE487082.Subject_);
  SHARED __EE487186 := JOIN(__EE487082,__EE487173,__JC487179(LEFT,RIGHT),TRANSFORM(E_Person_Bankruptcy(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC487192(E_Bankruptcy(__in,__cfg_Local).Layout __EE486768, E_Person_Bankruptcy(__in,__cfg_Local).Layout __EE487186) := __EEQP(__EE487186.Bankrupt_,__EE486768.UID);
  SHARED __EE487234 := JOIN(__EE486768,__EE487186,__JC487192(LEFT,RIGHT),TRANSFORM(E_Bankruptcy(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST21874_Layout := RECORD
    KEL.typ.ndataset(E_Bankruptcy(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST21874_Layout __ND487239__Rollup(__ST21874_Layout __r, DATASET(__ST21874_Layout) __recs) := TRANSFORM
    __recs_Data_Sources_ := NORMALIZE(__recs,__T(LEFT.Data_Sources_),TRANSFORM(E_Bankruptcy(__in,__cfg_Local).Data_Sources_Layout,SELF:=RIGHT));
    __recs_Data_Sources__allnull := NOT EXISTS(__recs(__NN(Data_Sources_)));
    SELF.Data_Sources_ := __BN(PROJECT(TABLE(__recs_Data_Sources_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),E_Bankruptcy(__in,__cfg_Local).Data_Sources_Layout),__recs_Data_Sources__allnull);
    SELF.__RecordCount := SUM(__recs,__RecordCount);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  SHARED __EE487248 := ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__EE487234,__ST21874_Layout),'Data_Sources_','data_sources_','clean','__recordcount,date_first_seen_,date_last_seen_'),Data_Sources_Clean,ALL),GROUP,__ND487239__Rollup(ROW(LEFT,__ST21874_Layout), PROJECT(ROWS(LEFT),__ST21874_Layout)));
  EXPORT Res4 := __UNWRAP(__EE487248);
  SHARED __EE487356 := __E_Person_Phone;
  SHARED __EE487512 := __EE487356(__NN(__EE487356.Subject_));
  SHARED __EE487350 := __E_Person;
  SHARED __EE487539 := __EE487350(__T(__OP2(__EE487350.UID,IN,__CN(__PLexIDs))));
  __JC487545(E_Person_Phone(__in,__cfg_Local).Layout __EE487512, E_Person(__in,__cfg_Local).Layout __EE487539) := __EEQP(__EE487539.UID,__EE487512.Subject_);
  SHARED __EE487558 := JOIN(__EE487512,__EE487539,__JC487545(LEFT,RIGHT),TRANSFORM(E_Person_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST21887_Layout := RECORD
    KEL.typ.ndataset(E_Person_Phone(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST21887_Layout __ND487563__Rollup(__ST21887_Layout __r, DATASET(__ST21887_Layout) __recs) := TRANSFORM
    __recs_Data_Sources_ := NORMALIZE(__recs,__T(LEFT.Data_Sources_),TRANSFORM(E_Person_Phone(__in,__cfg_Local).Data_Sources_Layout,SELF:=RIGHT));
    __recs_Data_Sources__allnull := NOT EXISTS(__recs(__NN(Data_Sources_)));
    SELF.Data_Sources_ := __BN(PROJECT(TABLE(__recs_Data_Sources_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),E_Person_Phone(__in,__cfg_Local).Data_Sources_Layout),__recs_Data_Sources__allnull);
    SELF.__RecordCount := SUM(__recs,__RecordCount);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  SHARED __EE487572 := ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__EE487558,__ST21887_Layout),'Data_Sources_','data_sources_','clean','__recordcount,date_first_seen_,date_last_seen_'),Data_Sources_Clean,ALL),GROUP,__ND487563__Rollup(ROW(LEFT,__ST21887_Layout), PROJECT(ROWS(LEFT),__ST21887_Layout)));
  EXPORT Res5 := __UNWRAP(__EE487572);
  SHARED __EE487634 := __E_Phone;
  SHARED __EE487623 := __E_Person_Phone;
  SHARED __EE487973 := __EE487623(__NN(__EE487623.Subject_) AND __NN(__EE487623.Phone_Number_));
  SHARED __EE487617 := __E_Person;
  SHARED __EE488073 := __EE487617(__T(__OP2(__EE487617.UID,IN,__CN(__PLexIDs))));
  __JC488079(E_Person_Phone(__in,__cfg_Local).Layout __EE487973, E_Person(__in,__cfg_Local).Layout __EE488073) := __EEQP(__EE488073.UID,__EE487973.Subject_);
  SHARED __EE488092 := JOIN(__EE487973,__EE488073,__JC488079(LEFT,RIGHT),TRANSFORM(E_Person_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC488098(E_Phone(__in,__cfg_Local).Layout __EE487634, E_Person_Phone(__in,__cfg_Local).Layout __EE488092) := __EEQP(__EE488092.Phone_Number_,__EE487634.UID);
  SHARED __EE488143 := JOIN(__EE487634,__EE488092,__JC488098(LEFT,RIGHT),TRANSFORM(E_Phone(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST21902_Layout := RECORD
    KEL.typ.ndataset(E_Phone(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST21902_Layout __ND488148__Rollup(__ST21902_Layout __r, DATASET(__ST21902_Layout) __recs) := TRANSFORM
    __recs_Data_Sources_ := NORMALIZE(__recs,__T(LEFT.Data_Sources_),TRANSFORM(E_Phone(__in,__cfg_Local).Data_Sources_Layout,SELF:=RIGHT));
    __recs_Data_Sources__allnull := NOT EXISTS(__recs(__NN(Data_Sources_)));
    SELF.Data_Sources_ := __BN(PROJECT(TABLE(__recs_Data_Sources_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),E_Phone(__in,__cfg_Local).Data_Sources_Layout),__recs_Data_Sources__allnull);
    SELF.__RecordCount := SUM(__recs,__RecordCount);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  SHARED __EE488157 := ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__EE488143,__ST21902_Layout),'Data_Sources_','data_sources_','clean','__recordcount,date_first_seen_,date_last_seen_'),Data_Sources_Clean,ALL),GROUP,__ND488148__Rollup(ROW(LEFT,__ST21902_Layout), PROJECT(ROWS(LEFT),__ST21902_Layout)));
  EXPORT Res6 := __UNWRAP(__EE488157);
  SHARED __EE488274 := __E_Person_Offenses;
  SHARED __EE488418 := __EE488274(__NN(__EE488274.Subject_));
  SHARED __EE488268 := __E_Person;
  SHARED __EE488439 := __EE488268(__T(__OP2(__EE488268.UID,IN,__CN(__PLexIDs))));
  __JC488445(E_Person_Offenses(__in,__cfg_Local).Layout __EE488418, E_Person(__in,__cfg_Local).Layout __EE488439) := __EEQP(__EE488439.UID,__EE488418.Subject_);
  SHARED __EE488452 := JOIN(__EE488418,__EE488439,__JC488445(LEFT,RIGHT),TRANSFORM(E_Person_Offenses(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST21915_Layout := RECORD
    KEL.typ.ndataset(E_Person_Offenses(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST21915_Layout __ND488457__Rollup(__ST21915_Layout __r, DATASET(__ST21915_Layout) __recs) := TRANSFORM
    __recs_Data_Sources_ := NORMALIZE(__recs,__T(LEFT.Data_Sources_),TRANSFORM(E_Person_Offenses(__in,__cfg_Local).Data_Sources_Layout,SELF:=RIGHT));
    __recs_Data_Sources__allnull := NOT EXISTS(__recs(__NN(Data_Sources_)));
    SELF.Data_Sources_ := __BN(PROJECT(TABLE(__recs_Data_Sources_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),E_Person_Offenses(__in,__cfg_Local).Data_Sources_Layout),__recs_Data_Sources__allnull);
    SELF.__RecordCount := SUM(__recs,__RecordCount);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  SHARED __EE488466 := ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__EE488452,__ST21915_Layout),'Data_Sources_','data_sources_','clean','__recordcount,date_first_seen_,date_last_seen_'),Data_Sources_Clean,ALL),GROUP,__ND488457__Rollup(ROW(LEFT,__ST21915_Layout), PROJECT(ROWS(LEFT),__ST21915_Layout)));
  EXPORT Res7 := __UNWRAP(__EE488466);
  SHARED __EE488522 := __E_Criminal_Offense;
  SHARED __EE488511 := __E_Person_Offenses;
  SHARED __EE488911 := __EE488511(__NN(__EE488511.Subject_) AND __NN(__EE488511.Offense_));
  SHARED __EE488505 := __E_Person;
  SHARED __EE489038 := __EE488505(__T(__OP2(__EE488505.UID,IN,__CN(__PLexIDs))));
  __JC489044(E_Person_Offenses(__in,__cfg_Local).Layout __EE488911, E_Person(__in,__cfg_Local).Layout __EE489038) := __EEQP(__EE489038.UID,__EE488911.Subject_);
  SHARED __EE489051 := JOIN(__EE488911,__EE489038,__JC489044(LEFT,RIGHT),TRANSFORM(E_Person_Offenses(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC489057(E_Criminal_Offense(__in,__cfg_Local).Layout __EE488522, E_Person_Offenses(__in,__cfg_Local).Layout __EE489051) := __EEQP(__EE489051.Offense_,__EE488522.UID);
  SHARED __EE489135 := JOIN(__EE488522,__EE489051,__JC489057(LEFT,RIGHT),TRANSFORM(E_Criminal_Offense(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST21930_Layout := RECORD
    KEL.typ.ndataset(E_Criminal_Offense(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST21930_Layout __ND489140__Rollup(__ST21930_Layout __r, DATASET(__ST21930_Layout) __recs) := TRANSFORM
    __recs_Data_Sources_ := NORMALIZE(__recs,__T(LEFT.Data_Sources_),TRANSFORM(E_Criminal_Offense(__in,__cfg_Local).Data_Sources_Layout,SELF:=RIGHT));
    __recs_Data_Sources__allnull := NOT EXISTS(__recs(__NN(Data_Sources_)));
    SELF.Data_Sources_ := __BN(PROJECT(TABLE(__recs_Data_Sources_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),E_Criminal_Offense(__in,__cfg_Local).Data_Sources_Layout),__recs_Data_Sources__allnull);
    SELF.__RecordCount := SUM(__recs,__RecordCount);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  SHARED __EE489149 := ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__EE489135,__ST21930_Layout),'Data_Sources_','data_sources_','clean','__recordcount,date_first_seen_,date_last_seen_'),Data_Sources_Clean,ALL),GROUP,__ND489140__Rollup(ROW(LEFT,__ST21930_Layout), PROJECT(ROWS(LEFT),__ST21930_Layout)));
  EXPORT Res8 := __UNWRAP(__EE489149);
  SHARED __EE489293 := __E_Person_Offender;
  SHARED __EE489437 := __EE489293(__NN(__EE489293.Subject_));
  SHARED __EE489287 := __E_Person;
  SHARED __EE489458 := __EE489287(__T(__OP2(__EE489287.UID,IN,__CN(__PLexIDs))));
  __JC489464(E_Person_Offender(__in,__cfg_Local).Layout __EE489437, E_Person(__in,__cfg_Local).Layout __EE489458) := __EEQP(__EE489458.UID,__EE489437.Subject_);
  SHARED __EE489471 := JOIN(__EE489437,__EE489458,__JC489464(LEFT,RIGHT),TRANSFORM(E_Person_Offender(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST21943_Layout := RECORD
    KEL.typ.ndataset(E_Person_Offender(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST21943_Layout __ND489476__Rollup(__ST21943_Layout __r, DATASET(__ST21943_Layout) __recs) := TRANSFORM
    __recs_Data_Sources_ := NORMALIZE(__recs,__T(LEFT.Data_Sources_),TRANSFORM(E_Person_Offender(__in,__cfg_Local).Data_Sources_Layout,SELF:=RIGHT));
    __recs_Data_Sources__allnull := NOT EXISTS(__recs(__NN(Data_Sources_)));
    SELF.Data_Sources_ := __BN(PROJECT(TABLE(__recs_Data_Sources_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),E_Person_Offender(__in,__cfg_Local).Data_Sources_Layout),__recs_Data_Sources__allnull);
    SELF.__RecordCount := SUM(__recs,__RecordCount);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  SHARED __EE489485 := ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__EE489471,__ST21943_Layout),'Data_Sources_','data_sources_','clean','__recordcount,date_first_seen_,date_last_seen_'),Data_Sources_Clean,ALL),GROUP,__ND489476__Rollup(ROW(LEFT,__ST21943_Layout), PROJECT(ROWS(LEFT),__ST21943_Layout)));
  EXPORT Res9 := __UNWRAP(__EE489485);
  SHARED __EE489541 := __E_Criminal_Offender;
  SHARED __EE489530 := __E_Person_Offender;
  SHARED __EE489827 := __EE489530(__NN(__EE489530.Subject_) AND __NN(__EE489530.Offender_));
  SHARED __EE489524 := __E_Person;
  SHARED __EE489904 := __EE489524(__T(__OP2(__EE489524.UID,IN,__CN(__PLexIDs))));
  __JC489910(E_Person_Offender(__in,__cfg_Local).Layout __EE489827, E_Person(__in,__cfg_Local).Layout __EE489904) := __EEQP(__EE489904.UID,__EE489827.Subject_);
  SHARED __EE489917 := JOIN(__EE489827,__EE489904,__JC489910(LEFT,RIGHT),TRANSFORM(E_Person_Offender(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC489923(E_Criminal_Offender(__in,__cfg_Local).Layout __EE489541, E_Person_Offender(__in,__cfg_Local).Layout __EE489917) := __EEQP(__EE489917.Offender_,__EE489541.UID);
  SHARED __EE489951 := JOIN(__EE489541,__EE489917,__JC489923(LEFT,RIGHT),TRANSFORM(E_Criminal_Offender(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST21958_Layout := RECORD
    KEL.typ.ndataset(E_Criminal_Offender(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST21958_Layout __ND489956__Rollup(__ST21958_Layout __r, DATASET(__ST21958_Layout) __recs) := TRANSFORM
    __recs_Data_Sources_ := NORMALIZE(__recs,__T(LEFT.Data_Sources_),TRANSFORM(E_Criminal_Offender(__in,__cfg_Local).Data_Sources_Layout,SELF:=RIGHT));
    __recs_Data_Sources__allnull := NOT EXISTS(__recs(__NN(Data_Sources_)));
    SELF.Data_Sources_ := __BN(PROJECT(TABLE(__recs_Data_Sources_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),E_Criminal_Offender(__in,__cfg_Local).Data_Sources_Layout),__recs_Data_Sources__allnull);
    SELF.__RecordCount := SUM(__recs,__RecordCount);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  SHARED __EE489965 := ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__EE489951,__ST21958_Layout),'Data_Sources_','data_sources_','clean','__recordcount,date_first_seen_,date_last_seen_'),Data_Sources_Clean,ALL),GROUP,__ND489956__Rollup(ROW(LEFT,__ST21958_Layout), PROJECT(ROWS(LEFT),__ST21958_Layout)));
  EXPORT Res10 := __UNWRAP(__EE489965);
  SHARED __EE490060 := __E_Person_S_S_N;
  SHARED __EE490211 := __EE490060(__NN(__EE490060.Subject_));
  SHARED __EE490053 := __E_Person;
  SHARED __EE490235 := __EE490053(__T(__OP2(__EE490053.UID,IN,__CN(__PLexIDs))));
  __JC490241(E_Person_S_S_N(__in,__cfg_Local).Layout __EE490211, E_Person(__in,__cfg_Local).Layout __EE490235) := __EEQP(__EE490235.UID,__EE490211.Subject_);
  SHARED __EE490251 := JOIN(__EE490211,__EE490235,__JC490241(LEFT,RIGHT),TRANSFORM(E_Person_S_S_N(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST21971_Layout := RECORD
    KEL.typ.ndataset(E_Person_S_S_N(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST21971_Layout __ND490256__Rollup(__ST21971_Layout __r, DATASET(__ST21971_Layout) __recs) := TRANSFORM
    __recs_Data_Sources_ := NORMALIZE(__recs,__T(LEFT.Data_Sources_),TRANSFORM(E_Person_S_S_N(__in,__cfg_Local).Data_Sources_Layout,SELF:=RIGHT));
    __recs_Data_Sources__allnull := NOT EXISTS(__recs(__NN(Data_Sources_)));
    SELF.Data_Sources_ := __BN(PROJECT(TABLE(__recs_Data_Sources_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),E_Person_S_S_N(__in,__cfg_Local).Data_Sources_Layout),__recs_Data_Sources__allnull);
    SELF.__RecordCount := SUM(__recs,__RecordCount);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  SHARED __EE490265 := ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__EE490251,__ST21971_Layout),'Data_Sources_','data_sources_','clean','__recordcount,date_first_seen_,date_last_seen_'),Data_Sources_Clean,ALL),GROUP,__ND490256__Rollup(ROW(LEFT,__ST21971_Layout), PROJECT(ROWS(LEFT),__ST21971_Layout)));
  EXPORT Res11 := __UNWRAP(__EE490265);
  SHARED __EE490324 := __E_Social_Security_Number;
  SHARED __EE490314 := __E_Person_S_S_N;
  SHARED __EE490590 := __EE490314(__NN(__EE490314.Subject_) AND __NN(__EE490314.Social_));
  SHARED __EE490307 := __E_Person;
  SHARED __EE490656 := __EE490307(__T(__OP2(__EE490307.UID,IN,__CN(__PLexIDs))));
  __JC490662(E_Person_S_S_N(__in,__cfg_Local).Layout __EE490590, E_Person(__in,__cfg_Local).Layout __EE490656) := __EEQP(__EE490656.UID,__EE490590.Subject_);
  SHARED __EE490672 := JOIN(__EE490590,__EE490656,__JC490662(LEFT,RIGHT),TRANSFORM(E_Person_S_S_N(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  __JC490678(E_Social_Security_Number(__in,__cfg_Local).Layout __EE490324, E_Person_S_S_N(__in,__cfg_Local).Layout __EE490672) := __EEQP(__EE490672.Social_,__EE490324.UID);
  SHARED __EE490692 := JOIN(__EE490324,__EE490672,__JC490678(LEFT,RIGHT),TRANSFORM(E_Social_Security_Number(__in,__cfg_Local).Layout,SELF:=LEFT),HASH,KEEP(1));
  SHARED __ST21986_Layout := RECORD
    KEL.typ.ndataset(E_Social_Security_Number(__in,__cfg_Local).Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST21986_Layout __ND490697__Rollup(__ST21986_Layout __r, DATASET(__ST21986_Layout) __recs) := TRANSFORM
    __recs_Data_Sources_ := NORMALIZE(__recs,__T(LEFT.Data_Sources_),TRANSFORM(E_Social_Security_Number(__in,__cfg_Local).Data_Sources_Layout,SELF:=RIGHT));
    __recs_Data_Sources__allnull := NOT EXISTS(__recs(__NN(Data_Sources_)));
    SELF.Data_Sources_ := __BN(PROJECT(TABLE(__recs_Data_Sources_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),E_Social_Security_Number(__in,__cfg_Local).Data_Sources_Layout),__recs_Data_Sources__allnull);
    SELF.__RecordCount := SUM(__recs,__RecordCount);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  EXPORT Res12 := __UNWRAP(ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__EE490692,__ST21986_Layout),'Data_Sources_','data_sources_','clean','__recordcount,date_first_seen_,date_last_seen_'),Data_Sources_Clean,ALL),GROUP,__ND490697__Rollup(ROW(LEFT,__ST21986_Layout), PROJECT(ROWS(LEFT),__ST21986_Layout))));
END;
