﻿//HPCC Systems KEL Compiler Version 1.2.2-dev
IMPORT KEL12 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Criminal_Offender,E_Criminal_Offense,E_Criminal_Punishment FROM PublicRecords_KEL;
IMPORT * FROM KEL12.Null;
EXPORT E_Criminal_Details(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Criminal_Offender().Typ) Offender_;
    KEL.typ.ntyp(E_Criminal_Offense().Typ) Offense_;
    KEL.typ.ntyp(E_Criminal_Punishment().Typ) Punishment_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Offender_(DEFAULT:Offender_:0),Offense_(DEFAULT:Offense_:0),Punishment_(DEFAULT:Punishment_:0),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH)';
  SHARED __Mapping0 := 'Offender_(DEFAULT:Offender_:0),Offense_(DEFAULT:Offense_:0),Punishment_(DEFAULT:Punishment_:0),archive_date(DEFAULT:Archive___Date_:EPOCH),event_dt(OVERRIDE:Date_First_Seen_:EPOCH),process_date(OVERRIDE:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping0_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('DC');
    SELF := __r;
  END;
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Punishment,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Punishment),SELF:=RIGHT));
  SHARED __d0_Offender__Layout := RECORD
    RECORDOF(__d0_Norm);
    KEL.typ.uid Offender_;
  END;
  SHARED __d0_Missing_Offender__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Norm,'offender_key','__in');
  SHARED __d0_Offender__Mapped := IF(__d0_Missing_Offender__UIDComponents = 'offender_key',PROJECT(__d0_Norm,TRANSFORM(__d0_Offender__Layout,SELF.Offender_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Norm,__d0_Missing_Offender__UIDComponents),E_Criminal_Offender(__in,__cfg).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d0_Offender__Layout,SELF.Offender_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Offense__Layout := RECORD
    RECORDOF(__d0_Offender__Mapped);
    KEL.typ.uid Offense_;
  END;
  SHARED __d0_Missing_Offense__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Offender__Mapped,'offender_key','__in');
  SHARED __d0_Offense__Mapped := IF(__d0_Missing_Offense__UIDComponents = 'offender_key',PROJECT(__d0_Offender__Mapped,TRANSFORM(__d0_Offense__Layout,SELF.Offense_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Offender__Mapped,__d0_Missing_Offense__UIDComponents),E_Criminal_Offense(__in,__cfg).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d0_Offense__Layout,SELF.Offense_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Punishment__Layout := RECORD
    RECORDOF(__d0_Offense__Mapped);
    KEL.typ.uid Punishment_;
  END;
  SHARED __d0_Missing_Punishment__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_Offense__Mapped,'offender_key','__in');
  SHARED __d0_Punishment__Mapped := IF(__d0_Missing_Punishment__UIDComponents = 'offender_key',PROJECT(__d0_Offense__Mapped,TRANSFORM(__d0_Punishment__Layout,SELF.Punishment_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_Offense__Mapped,__d0_Missing_Punishment__UIDComponents),E_Criminal_Punishment(__in,__cfg).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d0_Punishment__Layout,SELF.Punishment_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_Punishment__Mapped;
  SHARED __d0 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping0_Transform(LEFT)));
  SHARED __Mapping1 := 'Offender_(DEFAULT:Offender_:0),Offense_(DEFAULT:Offense_:0),Punishment_(DEFAULT:Punishment_:0),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('DC');
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenses,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenses),SELF:=RIGHT));
  SHARED __d1_Offender__Layout := RECORD
    RECORDOF(__d1_Norm);
    KEL.typ.uid Offender_;
  END;
  SHARED __d1_Missing_Offender__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_Norm,'offender_key','__in');
  SHARED __d1_Offender__Mapped := IF(__d1_Missing_Offender__UIDComponents = 'offender_key',PROJECT(__d1_Norm,TRANSFORM(__d1_Offender__Layout,SELF.Offender_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_Norm,__d1_Missing_Offender__UIDComponents),E_Criminal_Offender(__in,__cfg).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d1_Offender__Layout,SELF.Offender_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Offense__Layout := RECORD
    RECORDOF(__d1_Offender__Mapped);
    KEL.typ.uid Offense_;
  END;
  SHARED __d1_Missing_Offense__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_Offender__Mapped,'offender_key','__in');
  SHARED __d1_Offense__Mapped := IF(__d1_Missing_Offense__UIDComponents = 'offender_key',PROJECT(__d1_Offender__Mapped,TRANSFORM(__d1_Offense__Layout,SELF.Offense_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_Offender__Mapped,__d1_Missing_Offense__UIDComponents),E_Criminal_Offense(__in,__cfg).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d1_Offense__Layout,SELF.Offense_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Punishment__Layout := RECORD
    RECORDOF(__d1_Offense__Mapped);
    KEL.typ.uid Punishment_;
  END;
  SHARED __d1_Missing_Punishment__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_Offense__Mapped,'offender_key','__in');
  SHARED __d1_Punishment__Mapped := IF(__d1_Missing_Punishment__UIDComponents = 'offender_key',PROJECT(__d1_Offense__Mapped,TRANSFORM(__d1_Punishment__Layout,SELF.Punishment_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_Offense__Mapped,__d1_Missing_Punishment__UIDComponents),E_Criminal_Punishment(__in,__cfg).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d1_Punishment__Layout,SELF.Punishment_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Prefiltered := __d1_Punishment__Mapped;
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'),__Mapping1_Transform(LEFT)));
  SHARED __Mapping2 := 'Offender_(DEFAULT:Offender_:0),Offense_(DEFAULT:Offense_:0),Punishment_(DEFAULT:Punishment_:0),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Court_Offenses,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Court_Offenses),SELF:=RIGHT));
  SHARED __d2_Offender__Layout := RECORD
    RECORDOF(__d2_Norm);
    KEL.typ.uid Offender_;
  END;
  SHARED __d2_Missing_Offender__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d2_Norm,'offender_key','__in');
  SHARED __d2_Offender__Mapped := IF(__d2_Missing_Offender__UIDComponents = 'offender_key',PROJECT(__d2_Norm,TRANSFORM(__d2_Offender__Layout,SELF.Offender_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d2_Norm,__d2_Missing_Offender__UIDComponents),E_Criminal_Offender(__in,__cfg).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d2_Offender__Layout,SELF.Offender_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d2_Offense__Layout := RECORD
    RECORDOF(__d2_Offender__Mapped);
    KEL.typ.uid Offense_;
  END;
  SHARED __d2_Missing_Offense__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d2_Offender__Mapped,'offender_key','__in');
  SHARED __d2_Offense__Mapped := IF(__d2_Missing_Offense__UIDComponents = 'offender_key',PROJECT(__d2_Offender__Mapped,TRANSFORM(__d2_Offense__Layout,SELF.Offense_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d2_Offender__Mapped,__d2_Missing_Offense__UIDComponents),E_Criminal_Offense(__in,__cfg).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d2_Offense__Layout,SELF.Offense_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d2_Punishment__Layout := RECORD
    RECORDOF(__d2_Offense__Mapped);
    KEL.typ.uid Punishment_;
  END;
  SHARED __d2_Missing_Punishment__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d2_Offense__Mapped,'offender_key','__in');
  SHARED __d2_Punishment__Mapped := IF(__d2_Missing_Punishment__UIDComponents = 'offender_key',PROJECT(__d2_Offense__Mapped,TRANSFORM(__d2_Punishment__Layout,SELF.Punishment_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d2_Offense__Mapped,__d2_Missing_Punishment__UIDComponents),E_Criminal_Punishment(__in,__cfg).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d2_Punishment__Layout,SELF.Punishment_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d2_Prefiltered := __d2_Punishment__Mapped;
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  SHARED __Mapping3 := 'Offender_(DEFAULT:Offender_:0),Offense_(DEFAULT:Offense_:0),Punishment_(DEFAULT:Punishment_:0),src(OVERRIDE:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),fcra_date(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),datevendorfirstreported(DEFAULT:Date_Vendor_First_Reported_:EPOCH),datevendorlastreported(DEFAULT:Date_Vendor_Last_Reported_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  SHARED __d3_Offender__Layout := RECORD
    RECORDOF(__d3_Norm);
    KEL.typ.uid Offender_;
  END;
  SHARED __d3_Missing_Offender__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d3_Norm,'offender_key','__in');
  SHARED __d3_Offender__Mapped := IF(__d3_Missing_Offender__UIDComponents = 'offender_key',PROJECT(__d3_Norm,TRANSFORM(__d3_Offender__Layout,SELF.Offender_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d3_Norm,__d3_Missing_Offender__UIDComponents),E_Criminal_Offender(__in,__cfg).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d3_Offender__Layout,SELF.Offender_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d3_Offense__Layout := RECORD
    RECORDOF(__d3_Offender__Mapped);
    KEL.typ.uid Offense_;
  END;
  SHARED __d3_Missing_Offense__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d3_Offender__Mapped,'offender_key','__in');
  SHARED __d3_Offense__Mapped := IF(__d3_Missing_Offense__UIDComponents = 'offender_key',PROJECT(__d3_Offender__Mapped,TRANSFORM(__d3_Offense__Layout,SELF.Offense_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d3_Offender__Mapped,__d3_Missing_Offense__UIDComponents),E_Criminal_Offense(__in,__cfg).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d3_Offense__Layout,SELF.Offense_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d3_Punishment__Layout := RECORD
    RECORDOF(__d3_Offense__Mapped);
    KEL.typ.uid Punishment_;
  END;
  SHARED __d3_Missing_Punishment__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d3_Offense__Mapped,'offender_key','__in');
  SHARED __d3_Punishment__Mapped := IF(__d3_Missing_Punishment__UIDComponents = 'offender_key',PROJECT(__d3_Offense__Mapped,TRANSFORM(__d3_Punishment__Layout,SELF.Punishment_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d3_Offense__Mapped,__d3_Missing_Punishment__UIDComponents),E_Criminal_Punishment(__in,__cfg).Lookup,TRIM((STRING)LEFT.offender_key) = RIGHT.KeyVal,TRANSFORM(__d3_Punishment__Layout,SELF.Punishment_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d3_Prefiltered := __d3_Punishment__Mapped;
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.ECL_Functions.Dataset_FDC'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Criminal_Offender().Typ) Offender_;
    KEL.typ.ntyp(E_Criminal_Offense().Typ) Offense_;
    KEL.typ.ntyp(E_Criminal_Punishment().Typ) Punishment_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Date_Vendor_First_Reported_ := 0;
    KEL.typ.epoch Date_Vendor_Last_Reported_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Offender_,Offense_,Punishment_,ALL));
  Criminal_Details_Group := __PostFilter;
  Layout Criminal_Details__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_First_Reported_,MIN,FALSE),KEL.typ.epoch Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(GROUP,Date_Vendor_Last_Reported_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_First_Reported_,MIN,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRoll(__recs,Date_Vendor_Last_Reported_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Criminal_Details__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Date_Vendor_First_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_First_Reported_,FALSE),SELF.Date_Vendor_Last_Reported_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Vendor_Last_Reported_,FALSE),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Date_Vendor_First_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_First_Reported_,FALSE);
    SELF.Date_Vendor_Last_Reported_ := KEL.era.SimpleRollSingleRow(__r,Date_Vendor_Last_Reported_,FALSE);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Criminal_Details_Group,COUNT(ROWS(LEFT))=1),GROUP,Criminal_Details__Single_Rollup(LEFT)) + ROLLUP(HAVING(Criminal_Details_Group,COUNT(ROWS(LEFT))>1),GROUP,Criminal_Details__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Offender__Orphan := JOIN(InData(__NN(Offender_)),E_Criminal_Offender(__in,__cfg).__Result,__EEQP(LEFT.Offender_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Offense__Orphan := JOIN(InData(__NN(Offense_)),E_Criminal_Offense(__in,__cfg).__Result,__EEQP(LEFT.Offense_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Punishment__Orphan := JOIN(InData(__NN(Punishment_)),E_Criminal_Punishment(__in,__cfg).__Result,__EEQP(LEFT.Punishment_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Offender__Orphan),COUNT(Offense__Orphan),COUNT(Punishment__Orphan)}],{KEL.typ.int Offender__Orphan,KEL.typ.int Offense__Orphan,KEL.typ.int Punishment__Orphan});
  EXPORT NullCounts := DATASET([
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offender',COUNT(__d0(__NL(Offender_))),COUNT(__d0(__NN(Offender_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offense',COUNT(__d0(__NL(Offense_))),COUNT(__d0(__NN(Offense_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Punishment',COUNT(__d0(__NL(Punishment_))),COUNT(__d0(__NN(Punishment_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d0(Date_Vendor_First_Reported_=0)),COUNT(__d0(Date_Vendor_First_Reported_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d0(Date_Vendor_Last_Reported_=0)),COUNT(__d0(Date_Vendor_Last_Reported_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offender',COUNT(__d1(__NL(Offender_))),COUNT(__d1(__NN(Offender_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offense',COUNT(__d1(__NL(Offense_))),COUNT(__d1(__NN(Offense_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Punishment',COUNT(__d1(__NL(Punishment_))),COUNT(__d1(__NN(Punishment_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d1(Date_Vendor_First_Reported_=0)),COUNT(__d1(Date_Vendor_First_Reported_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d1(Date_Vendor_Last_Reported_=0)),COUNT(__d1(Date_Vendor_Last_Reported_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offender',COUNT(__d2(__NL(Offender_))),COUNT(__d2(__NN(Offender_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offense',COUNT(__d2(__NL(Offense_))),COUNT(__d2(__NN(Offense_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Punishment',COUNT(__d2(__NL(Punishment_))),COUNT(__d2(__NN(Punishment_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d2(Date_Vendor_First_Reported_=0)),COUNT(__d2(Date_Vendor_First_Reported_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d2(Date_Vendor_Last_Reported_=0)),COUNT(__d2(Date_Vendor_Last_Reported_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offender',COUNT(__d3(__NL(Offender_))),COUNT(__d3(__NN(Offender_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Offense',COUNT(__d3(__NL(Offense_))),COUNT(__d3(__NN(Offense_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Punishment',COUNT(__d3(__NL(Punishment_))),COUNT(__d3(__NN(Punishment_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorFirstReported',COUNT(__d3(Date_Vendor_First_Reported_=0)),COUNT(__d3(Date_Vendor_First_Reported_!=0))},
    {'CriminalDetails','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateVendorLastReported',COUNT(__d3(Date_Vendor_Last_Reported_=0)),COUNT(__d3(Date_Vendor_Last_Reported_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
