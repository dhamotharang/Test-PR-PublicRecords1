//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Criminal_Offense,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Person_Offenses(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Criminal_Offense().Typ) Offense_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'subject(Subject_:0),Offense_(Offense_:0),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'sdid(Subject_:0),Offense_(Offense_:0),src(Source_:\'\'),earliest_offense_date(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_NonFCRA;
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders_Risk,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders_Risk),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)sdid != 0);
  SHARED __d0_Offense__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Offense_;
  END;
  SHARED __d0_Offense__Mapped := JOIN(__d0_KELfiltered,E_Criminal_Offense(__in,__cfg).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d0_Offense__Layout,SELF.Offense_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Offense__Mapped;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0),__Mapping0_Transform(LEFT)));
  SHARED __Mapping1 := 'did(Subject_:0),Offense_(Offense_:0),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_FCRA;
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_BocaShell_Crim_FCRA,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_BocaShell_Crim_FCRA),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)did != 0);
  SHARED __d1_Offense__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Offense_;
  END;
  SHARED __d1_Offense__Mapped := JOIN(__d1_KELfiltered,E_Criminal_Offense(__in,__cfg).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d1_Offense__Layout,SELF.Offense_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Prefiltered := __d1_Offense__Mapped;
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1),__Mapping1_Transform(LEFT)));
  SHARED __Mapping2 := 'did(Subject_:0),Offense_(Offense_:0),src(Source_:\'\'),fcra_date(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_FCRA;
    SELF := __r;
  END;
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  SHARED __d2_Offense__Layout := RECORD
    RECORDOF(__d2_Norm);
    KEL.typ.uid Offense_;
  END;
  SHARED __d2_Offense__Mapped := JOIN(__d2_Norm,E_Criminal_Offense(__in,__cfg).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d2_Offense__Layout,SELF.Offense_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d2_Prefiltered := __d2_Offense__Mapped;
  SHARED __d2 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2),__Mapping2_Transform(LEFT)));
  SHARED __Mapping3 := 'did(Subject_:0),Offense_(Offense_:0),src(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping3_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_NonFCRA;
    SELF := __r;
  END;
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  SHARED __d3_Offense__Layout := RECORD
    RECORDOF(__d3_Norm);
    KEL.typ.uid Offense_;
  END;
  SHARED __d3_Offense__Mapped := JOIN(__d3_Norm,E_Criminal_Offense(__in,__cfg).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d3_Offense__Layout,SELF.Offense_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d3_Prefiltered := __d3_Offense__Mapped;
  SHARED __d3 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3),__Mapping3_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2 + __d3;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Criminal_Offense().Typ) Offense_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Subject_,Offense_,ALL));
  Person_Offenses_Group := __PostFilter;
  Layout Person_Offenses__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Person_Offenses__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_Offenses_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_Offenses__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_Offenses_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_Offenses__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Offense__Orphan := JOIN(InData(__NN(Offense_)),E_Criminal_Offense(__in,__cfg).__Result,__EEQP(LEFT.Offense_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Offense__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Offense__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','sdid',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offense',COUNT(__d0(__NL(Offense_))),COUNT(__d0(__NN(Offense_)))},
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offense',COUNT(__d1(__NL(Offense_))),COUNT(__d1(__NN(Offense_)))},
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d2(__NL(Subject_))),COUNT(__d2(__NN(Subject_)))},
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offense',COUNT(__d2(__NL(Offense_))),COUNT(__d2(__NN(Offense_)))},
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d3(__NL(Subject_))),COUNT(__d3(__NN(Subject_)))},
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offense',COUNT(__d3(__NL(Offense_))),COUNT(__d3(__NN(Offense_)))},
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'PersonOffenses','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
