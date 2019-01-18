//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Criminal_Offender,E_Criminal_Offense,E_Criminal_Punishment FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Criminal_Details(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Criminal_Offender().Typ) Offender_;
    KEL.typ.ntyp(E_Criminal_Offense().Typ) Offense_;
    KEL.typ.ntyp(E_Criminal_Punishment().Typ) Punishment_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED1 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Offender_(Offender_:0),Offense_(Offense_:0),Punishment_(Punishment_:0),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'Offender_(Offender_:0),Offense_(Offense_:0),Punishment_(Punishment_:0),event_dt(Date_First_Seen_:EPOCH),process_date(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('DC');
    SELF.__Permits := CFG_Compile.Permit_nonFCRA;
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Punishment,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Punishment),SELF:=RIGHT));
  SHARED __d0_Offender__Layout := RECORD
    RECORDOF(__d0_Norm);
    KEL.typ.uid Offender_;
  END;
  SHARED __d0_Offender__Mapped := JOIN(__d0_Norm,E_Criminal_Offender(__in).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d0_Offender__Layout,SELF.Offender_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Offense__Layout := RECORD
    RECORDOF(__d0_Offender__Mapped);
    KEL.typ.uid Offense_;
  END;
  SHARED __d0_Offense__Mapped := JOIN(__d0_Offender__Mapped,E_Criminal_Offense(__in).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d0_Offense__Layout,SELF.Offense_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Punishment__Layout := RECORD
    RECORDOF(__d0_Offense__Mapped);
    KEL.typ.uid Punishment_;
  END;
  SHARED __d0_Punishment__Mapped := JOIN(__d0_Offense__Mapped,E_Criminal_Punishment(__in).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d0_Punishment__Layout,SELF.Punishment_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Punishment__Mapped;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0),__Mapping0_Transform(LEFT)));
  SHARED __Mapping1 := 'Offender_(Offender_:0),Offense_(Offense_:0),Punishment_(Punishment_:0),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('DC');
    SELF.__Permits := CFG_Compile.Permit_FCRA;
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenses,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenses),SELF:=RIGHT));
  SHARED __d1_Offender__Layout := RECORD
    RECORDOF(__d1_Norm);
    KEL.typ.uid Offender_;
  END;
  SHARED __d1_Offender__Mapped := JOIN(__d1_Norm,E_Criminal_Offender(__in).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d1_Offender__Layout,SELF.Offender_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Offense__Layout := RECORD
    RECORDOF(__d1_Offender__Mapped);
    KEL.typ.uid Offense_;
  END;
  SHARED __d1_Offense__Mapped := JOIN(__d1_Offender__Mapped,E_Criminal_Offense(__in).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d1_Offense__Layout,SELF.Offense_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Punishment__Layout := RECORD
    RECORDOF(__d1_Offense__Mapped);
    KEL.typ.uid Punishment_;
  END;
  SHARED __d1_Punishment__Mapped := JOIN(__d1_Offense__Mapped,E_Criminal_Punishment(__in).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d1_Punishment__Layout,SELF.Punishment_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Prefiltered := __d1_Punishment__Mapped;
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1),__Mapping1_Transform(LEFT)));
  SHARED __Mapping2 := 'Offender_(Offender_:0),Offense_(Offense_:0),Punishment_(Punishment_:0),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_FCRA;
    SELF := __r;
  END;
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Court_Offenses,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Court_Offenses),SELF:=RIGHT));
  SHARED __d2_Offender__Layout := RECORD
    RECORDOF(__d2_Norm);
    KEL.typ.uid Offender_;
  END;
  SHARED __d2_Offender__Mapped := JOIN(__d2_Norm,E_Criminal_Offender(__in).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d2_Offender__Layout,SELF.Offender_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d2_Offense__Layout := RECORD
    RECORDOF(__d2_Offender__Mapped);
    KEL.typ.uid Offense_;
  END;
  SHARED __d2_Offense__Mapped := JOIN(__d2_Offender__Mapped,E_Criminal_Offense(__in).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d2_Offense__Layout,SELF.Offense_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d2_Punishment__Layout := RECORD
    RECORDOF(__d2_Offense__Mapped);
    KEL.typ.uid Punishment_;
  END;
  SHARED __d2_Punishment__Mapped := JOIN(__d2_Offense__Mapped,E_Criminal_Punishment(__in).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d2_Punishment__Layout,SELF.Punishment_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d2_Prefiltered := __d2_Punishment__Mapped;
  SHARED __d2 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2),__Mapping2_Transform(LEFT)));
  SHARED __Mapping3 := 'Offender_(Offender_:0),Offense_(Offense_:0),Punishment_(Punishment_:0),src(Source_:\'\'),fcra_date(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping3_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_FCRA;
    SELF := __r;
  END;
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  SHARED __d3_Offender__Layout := RECORD
    RECORDOF(__d3_Norm);
    KEL.typ.uid Offender_;
  END;
  SHARED __d3_Offender__Mapped := JOIN(__d3_Norm,E_Criminal_Offender(__in).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d3_Offender__Layout,SELF.Offender_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d3_Offense__Layout := RECORD
    RECORDOF(__d3_Offender__Mapped);
    KEL.typ.uid Offense_;
  END;
  SHARED __d3_Offense__Mapped := JOIN(__d3_Offender__Mapped,E_Criminal_Offense(__in).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d3_Offense__Layout,SELF.Offense_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d3_Punishment__Layout := RECORD
    RECORDOF(__d3_Offense__Mapped);
    KEL.typ.uid Punishment_;
  END;
  SHARED __d3_Punishment__Mapped := JOIN(__d3_Offense__Mapped,E_Criminal_Punishment(__in).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d3_Punishment__Layout,SELF.Punishment_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d3_Prefiltered := __d3_Punishment__Mapped;
  SHARED __d3 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3),__Mapping3_Transform(LEFT)));
  SHARED __Mapping4 := 'Offender_(Offender_:0),Offense_(Offense_:0),Punishment_(Punishment_:0),src(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping4_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_nonFCRA;
    SELF := __r;
  END;
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  SHARED __d4_Offender__Layout := RECORD
    RECORDOF(__d4_Norm);
    KEL.typ.uid Offender_;
  END;
  SHARED __d4_Offender__Mapped := JOIN(__d4_Norm,E_Criminal_Offender(__in).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d4_Offender__Layout,SELF.Offender_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d4_Offense__Layout := RECORD
    RECORDOF(__d4_Offender__Mapped);
    KEL.typ.uid Offense_;
  END;
  SHARED __d4_Offense__Mapped := JOIN(__d4_Offender__Mapped,E_Criminal_Offense(__in).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d4_Offense__Layout,SELF.Offense_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d4_Punishment__Layout := RECORD
    RECORDOF(__d4_Offense__Mapped);
    KEL.typ.uid Punishment_;
  END;
  SHARED __d4_Punishment__Mapped := JOIN(__d4_Offense__Mapped,E_Criminal_Punishment(__in).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d4_Punishment__Layout,SELF.Punishment_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d4_Prefiltered := __d4_Punishment__Mapped;
  SHARED __d4 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4),__Mapping4_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Criminal_Offender().Typ) Offender_;
    KEL.typ.ntyp(E_Criminal_Offense().Typ) Offense_;
    KEL.typ.ntyp(E_Criminal_Punishment().Typ) Punishment_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Offender_,Offense_,Punishment_,ALL));
  Criminal_Details_Group := __PostFilter;
  Layout Criminal_Details__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Criminal_Details__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Criminal_Details_Group,COUNT(ROWS(LEFT))=1),GROUP,Criminal_Details__Single_Rollup(LEFT)) + ROLLUP(HAVING(Criminal_Details_Group,COUNT(ROWS(LEFT))>1),GROUP,Criminal_Details__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Offender__Orphan := JOIN(InData(__NN(Offender_)),E_Criminal_Offender(__in).__Result,__EEQP(LEFT.Offender_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Offense__Orphan := JOIN(InData(__NN(Offense_)),E_Criminal_Offense(__in).__Result,__EEQP(LEFT.Offense_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Punishment__Orphan := JOIN(InData(__NN(Punishment_)),E_Criminal_Punishment(__in).__Result,__EEQP(LEFT.Punishment_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Offender__Orphan),COUNT(Offense__Orphan),COUNT(Punishment__Orphan)}],{KEL.typ.int Offender__Orphan,KEL.typ.int Offense__Orphan,KEL.typ.int Punishment__Orphan});
  EXPORT NullCounts := DATASET([
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offender',COUNT(__d0(__NL(Offender_))),COUNT(__d0(__NN(Offender_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offense',COUNT(__d0(__NL(Offense_))),COUNT(__d0(__NN(Offense_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Punishment',COUNT(__d0(__NL(Punishment_))),COUNT(__d0(__NN(Punishment_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offender',COUNT(__d1(__NL(Offender_))),COUNT(__d1(__NN(Offender_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offense',COUNT(__d1(__NL(Offense_))),COUNT(__d1(__NN(Offense_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Punishment',COUNT(__d1(__NL(Punishment_))),COUNT(__d1(__NN(Punishment_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offender',COUNT(__d2(__NL(Offender_))),COUNT(__d2(__NN(Offender_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offense',COUNT(__d2(__NL(Offense_))),COUNT(__d2(__NN(Offense_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Punishment',COUNT(__d2(__NL(Punishment_))),COUNT(__d2(__NN(Punishment_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offender',COUNT(__d3(__NL(Offender_))),COUNT(__d3(__NN(Offender_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offense',COUNT(__d3(__NL(Offense_))),COUNT(__d3(__NN(Offense_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Punishment',COUNT(__d3(__NL(Punishment_))),COUNT(__d3(__NN(Punishment_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offender',COUNT(__d4(__NL(Offender_))),COUNT(__d4(__NN(Offender_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offense',COUNT(__d4(__NL(Offense_))),COUNT(__d4(__NN(Offense_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Punishment',COUNT(__d4(__NL(Punishment_))),COUNT(__d4(__NN(Punishment_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
