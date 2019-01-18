//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT CFG_Compile,E_Criminal_Offender,E_Person,E_Person_Offender FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT Q_Criminal_Offender_Search(KEL.typ.uid __PLexID, UNSIGNED1 __PDPM, CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  SHARED E_Person_Filtered_2(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE(E_Person(__in))
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __GroupTest(DATASET(InLayout) __g) := EXISTS(__g(__T(__OP2(__g.UID,=,__CN(__PLexID)))));
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__ds);
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := HAVING(__ds,__GroupTest(ROWS(LEFT)));
  END;
  SHARED E_Person_Offender_Filtered_1(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE(E_Person_Offender(__in))
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__ds);
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Filtered_2(__in).__PostFilter,__EEQP(LEFT.Subject_,RIGHT.UID),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Criminal_Offender_Filtered(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE(E_Criminal_Offender(__in))
    SHARED __UsingFitler(DATASET(InLayout) __ds) := __ds((__ds.__Permits & __PDPM) = __ds.__Permits);
    SHARED __SourceFilter(DATASET(InLayout) __ds) := __UsingFitler(__ds);
    SHARED __GroupedFilter(GROUPED DATASET(InLayout) __ds) := JOIN(__ds,E_Person_Offender_Filtered_1(__in).__PostFilter,__EEQP(LEFT.UID,RIGHT.Offender_),TRANSFORM(InLayout,SELF:=LEFT),HASH,GROUPED,KEEP(1));
  END;
  SHARED E_Person_Filtered := E_Person_Filtered_2;
  SHARED E_Person_Offender_Filtered := E_Person_Offender_Filtered_1;
  SHARED TYPEOF(E_Criminal_Offender(__in).__Result) __E_Criminal_Offender := E_Criminal_Offender_Filtered(__in).__Result;
  SHARED TYPEOF(E_Person(__in).__Result) __E_Person := E_Person_Filtered(__in).__Result;
  SHARED TYPEOF(E_Person_Offender(__in).__Result) __E_Person_Offender := E_Person_Offender_Filtered(__in).__Result;
  SHARED __EE6306 := __E_Person;
  SHARED __EE7707 := __EE6306(__T(__OP2(__EE6306.UID,=,__CN(__PLexID))));
  SHARED __EE6308 := __E_Criminal_Offender;
  SHARED __EE6307 := __E_Person_Offender;
  SHARED __EE7126 := __EE6307(__NN(__EE6307.Subject_) AND __NN(__EE6307.Offender_));
  __JC7716(E_Person_Offender(__in).Layout __EE7126, E_Person(__in).Layout __EE7707) := __EEQP(__EE7707.UID,__EE7126.Subject_);
  SHARED __EE7717 := JOIN(__EE7126,__EE7707,__JC7716(LEFT,RIGHT),TRANSFORM(E_Person_Offender(__in).Layout,SELF:=LEFT),MANY LOOKUP,KEEP(1));
  SHARED __ST5842_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Offender_Key_;
    KEL.typ.ndataset(E_Criminal_Offender(__in).Sources_Layout) Sources_;
    KEL.typ.nstr Citizenship_;
    KEL.typ.nstr Hair_Color_;
    KEL.typ.nstr Eye_Color_;
    KEL.typ.nstr Skin_Color_;
    KEL.typ.nint Height_;
    KEL.typ.nint Weight_;
    KEL.typ.ndataset(E_Criminal_Offender(__in).Current_Status_Layout) Current_Status_;
    KEL.typ.ndataset(E_Criminal_Offender(__in).Number_Of_Offense_Counts_Layout) Number_Of_Offense_Counts_;
    KEL.typ.ndataset(E_Criminal_Offender(__in).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Criminal_Offender().Typ) Offender_;
    KEL.typ.ndataset(E_Person_Offender(__in).Data_Sources_Layout) Data_Sources__1_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC7726(E_Criminal_Offender(__in).Layout __EE6308, E_Person_Offender(__in).Layout __EE7717) := __EEQP(__EE7717.Offender_,__EE6308.UID);
  __ST5842_Layout __JT7726(E_Criminal_Offender(__in).Layout __l, E_Person_Offender(__in).Layout __r) := TRANSFORM
    SELF.Data_Sources__1_ := __r.Data_Sources_;
    SELF := __l;
    SELF := __r;
  END;
  SHARED __EE7727 := JOIN(__EE6308,__EE7717,__JC7726(LEFT,RIGHT),__JT7726(LEFT,RIGHT),INNER,MANY LOOKUP);
  SHARED __ST6182_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Gender_;
    KEL.typ.nstr Lex_I_D_Segment_;
    KEL.typ.ndataset(E_Person(__in).Full_Name_Layout) Full_Name_;
    KEL.typ.ndataset(E_Person(__in).Reported_Dates_Of_Birth_Layout) Reported_Dates_Of_Birth_;
    KEL.typ.ndataset(E_Person(__in).Reported_Dates_Of_Death_Layout) Reported_Dates_Of_Death_;
    KEL.typ.nstr Race_;
    KEL.typ.nstr Race_Description_;
    KEL.typ.ndataset(E_Person(__in).Data_Sources_Layout) Data_Sources_;
    KEL.typ.ndataset(__ST5842_Layout) Offender_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  __JC7736(E_Person(__in).Layout __EE7707, __ST5842_Layout __EE7727) := __EEQP(__EE7707.UID,__EE7727.Subject_);
  __ST6182_Layout __Join__ST6182_Layout(E_Person(__in).Layout __r, DATASET(__ST5842_Layout) __recs) := TRANSFORM
    SELF := __r;
    SELF.Offender_ := __CN(__recs);
  END;
  SHARED __EE7737 := DENORMALIZE(DISTRIBUTE(__EE7707,HASH(UID)),DISTRIBUTE(__EE7727,HASH(Subject_)),__JC7736(LEFT,RIGHT),GROUP,__Join__ST6182_Layout(LEFT,ROWS(RIGHT)),LOCAL,MANY LOOKUP);
  SHARED __ST2725_Layout := RECORD
    KEL.typ.nstr Source_File_;
    KEL.typ.nint Data_Type_;
    KEL.typ.nstr Data_Source_;
    KEL.typ.nstr Source_State_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST2733_Layout := RECORD
    KEL.typ.nstr Status_;
    KEL.typ.nstr Current_Incarcerated_Flag_;
    KEL.typ.nstr Current_Parole_Flag_;
    KEL.typ.nstr Current_Probation_Flag_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST2741_Layout := RECORD
    KEL.typ.nint Number_Of_Offense_Counts_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST2746_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST2749_Layout := RECORD
    KEL.typ.nstr Offender_Key_;
    KEL.typ.ndataset(__ST2725_Layout) Sources_;
    KEL.typ.nstr Citizenship_;
    KEL.typ.nstr Hair_Color_;
    KEL.typ.nstr Eye_Color_;
    KEL.typ.nstr Skin_Color_;
    KEL.typ.nint Height_;
    KEL.typ.nint Weight_;
    KEL.typ.ndataset(__ST2733_Layout) Current_Status_;
    KEL.typ.ndataset(__ST2741_Layout) Number_Of_Offense_Counts_;
    KEL.typ.ndataset(__ST2746_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST2762_Layout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.ndataset(__ST2749_Layout) Offender_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  SHARED __ST2762_Layout __ND7564__Project(__ST6182_Layout __PP7560) := TRANSFORM
    __EE7740 := __PP7560.Offender_;
    __ST2749_Layout __ND7590__Project(__ST5842_Layout __PP7586) := TRANSFORM
      __EE7743 := __PP7586.Sources_;
      SELF.Sources_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE7743),__ST2725_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_File_,Data_Type_,Data_Source_,Source_State_},Source_File_,Data_Type_,Data_Source_,Source_State_,MERGE),__ST2725_Layout),__NL(__EE7743));
      __EE7746 := __PP7586.Current_Status_;
      SELF.Current_Status_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE7746),__ST2733_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Status_,Current_Incarcerated_Flag_,Current_Parole_Flag_,Current_Probation_Flag_},Status_,Current_Incarcerated_Flag_,Current_Parole_Flag_,Current_Probation_Flag_,MERGE),__ST2733_Layout),__NL(__EE7746));
      __EE7752 := __PP7586.Number_Of_Offense_Counts_;
      SELF.Number_Of_Offense_Counts_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE7752),__ST2741_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Number_Of_Offense_Counts_},Number_Of_Offense_Counts_,MERGE),__ST2741_Layout),__NL(__EE7752));
      __EE7749 := __PP7586.Data_Sources_;
      SELF.Data_Sources_ := __BN(PROJECT(TABLE(PROJECT(__T(__EE7749),__ST2746_Layout),{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_,MERGE),__ST2746_Layout),__NL(__EE7749));
      SELF := __PP7586;
    END;
    __ST2749_Layout __ND7590__Rollup(__ST2749_Layout __r, DATASET(__ST2749_Layout) __recs) := TRANSFORM
      __recs_Sources_ := NORMALIZE(__recs,__T(LEFT.Sources_),TRANSFORM(__ST2725_Layout,SELF:=RIGHT));
      __recs_Sources__allnull := NOT EXISTS(__recs(__NN(Sources_)));
      SELF.Sources_ := __BN(PROJECT(TABLE(__recs_Sources_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_File_,Data_Type_,Data_Source_,Source_State_},Source_File_,Data_Type_,Data_Source_,Source_State_),__ST2725_Layout),__recs_Sources__allnull);
      __recs_Current_Status_ := NORMALIZE(__recs,__T(LEFT.Current_Status_),TRANSFORM(__ST2733_Layout,SELF:=RIGHT));
      __recs_Current_Status__allnull := NOT EXISTS(__recs(__NN(Current_Status_)));
      SELF.Current_Status_ := __BN(PROJECT(TABLE(__recs_Current_Status_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Status_,Current_Incarcerated_Flag_,Current_Parole_Flag_,Current_Probation_Flag_},Status_,Current_Incarcerated_Flag_,Current_Parole_Flag_,Current_Probation_Flag_),__ST2733_Layout),__recs_Current_Status__allnull);
      __recs_Number_Of_Offense_Counts_ := NORMALIZE(__recs,__T(LEFT.Number_Of_Offense_Counts_),TRANSFORM(__ST2741_Layout,SELF:=RIGHT));
      __recs_Number_Of_Offense_Counts__allnull := NOT EXISTS(__recs(__NN(Number_Of_Offense_Counts_)));
      SELF.Number_Of_Offense_Counts_ := __BN(PROJECT(TABLE(__recs_Number_Of_Offense_Counts_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Number_Of_Offense_Counts_},Number_Of_Offense_Counts_),__ST2741_Layout),__recs_Number_Of_Offense_Counts__allnull);
      __recs_Data_Sources_ := NORMALIZE(__recs,__T(LEFT.Data_Sources_),TRANSFORM(__ST2746_Layout,SELF:=RIGHT));
      __recs_Data_Sources__allnull := NOT EXISTS(__recs(__NN(Data_Sources_)));
      SELF.Data_Sources_ := __BN(PROJECT(TABLE(__recs_Data_Sources_,{KEL.typ.int __RecordCount := SUM(GROUP,__RecordCount),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),__ST2746_Layout),__recs_Data_Sources__allnull);
      SELF.__RecordCount := SUM(__recs,__RecordCount);
      SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
      SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
      SELF := __r;
    END;
    SELF.Offender_ := __BN(ROLLUP(GROUP(KEL.Routines.SortAndAppendFilteredChildren(PROJECT(__T(__EE7740),__ND7590__Project(LEFT))(__NN(Offender_Key_) OR __NN(Sources_) OR __NN(Citizenship_) OR __NN(Hair_Color_) OR __NN(Eye_Color_) OR __NN(Skin_Color_) OR __NN(Height_) OR __NN(Weight_) OR __NN(Current_Status_) OR __NN(Number_Of_Offense_Counts_) OR __NN(Data_Sources_)),'Sources_,Current_Status_,Number_Of_Offense_Counts_,Data_Sources_','sources_,current_status_,number_of_offense_counts_,data_sources_','clean','__recordcount,date_first_seen_,date_last_seen_'),Offender_Key_,Sources_Clean,Citizenship_,Hair_Color_,Eye_Color_,Skin_Color_,Height_,Weight_,Current_Status_Clean,Number_Of_Offense_Counts_Clean,Data_Sources_Clean,ALL),GROUP,__ND7590__Rollup(ROW(LEFT,__ST2749_Layout), PROJECT(ROWS(LEFT),__ST2749_Layout))),__NL(__EE7740));
    SELF := __PP7560;
  END;
  EXPORT Res0 := __UNWRAP(PROJECT(PROJECT(__EE7737,__ND7564__Project(LEFT)),__ST2762_Layout));
END;
