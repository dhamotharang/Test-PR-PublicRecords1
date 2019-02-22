//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Person,E_Social_Security_Number FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Person_S_S_N(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.nbool Temp_Legacy_S_S_N_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'subject(Subject_:0),social(Social_:0),templegacyssn(Temp_Legacy_S_S_N_),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED Date_First_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'did(Subject_:0),ssn(Social_:0),templegacyssn(Temp_Legacy_S_S_N_),src(Source_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH:Date_First_Seen_0Rule),dt_last_seen(Date_Last_Seen_:EPOCH:Date_Last_Seen_0Rule)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  EXPORT __d0_KELfiltered := __d0_Norm((UNSIGNED)did != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d0_Prefiltered := __d0_KELfiltered;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED Date_First_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED Date_Last_Seen_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'did(Subject_:0),ssn(Social_:0),templegacyssn(Temp_Legacy_S_S_N_),src(Source_:\'\'),dt_first_seen(Date_First_Seen_:EPOCH:Date_First_Seen_1Rule),dt_last_seen(Date_Last_Seen_:EPOCH:Date_Last_Seen_1Rule)';
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Header_Quick__Key_Did,TRANSFORM(RECORDOF(__in.Dataset_Header_Quick__Key_Did),SELF:=RIGHT));
  EXPORT __d1_KELfiltered := __d1_Norm((UNSIGNED)ssn != 0 AND (UNSIGNED)did != 0);
  SHARED __d1_Prefiltered := __d1_KELfiltered;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1));
  SHARED __Mapping2 := 'did(Subject_:0),ssn(Social_:0),templegacyssn(Temp_Legacy_S_S_N_),src(Source_:\'\'),earliest_offense_date(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_NonFCRA;
    SELF := __r;
  END;
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders_Risk,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders_Risk),SELF:=RIGHT));
  EXPORT __d2_KELfiltered := __d2_Norm((UNSIGNED)did != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d2_Prefiltered := __d2_KELfiltered;
  SHARED __d2 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2),__Mapping2_Transform(LEFT)));
  SHARED __Mapping3 := 'did(Subject_:0),ssn(Social_:0),templegacyssn(Temp_Legacy_S_S_N_),src(Source_:\'\'),fcra_date(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping3_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_FCRA;
    SELF := __r;
  END;
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  EXPORT __d3_KELfiltered := __d3_Norm((UNSIGNED)did != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d3_Prefiltered := __d3_KELfiltered;
  SHARED __d3 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3),__Mapping3_Transform(LEFT)));
  SHARED __Mapping4 := 'did(Subject_:0),ssn(Social_:0),templegacyssn(Temp_Legacy_S_S_N_),src(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping4_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_NonFCRA;
    SELF := __r;
  END;
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  EXPORT __d4_KELfiltered := __d4_Norm((UNSIGNED)did != 0 AND (UNSIGNED)ssn != 0);
  SHARED __d4_Prefiltered := __d4_KELfiltered;
  SHARED __d4 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4),__Mapping4_Transform(LEFT)));
  SHARED __Mapping5 := 'did(Subject_:0),ssn(Social_:0),templegacyssn(Temp_Legacy_S_S_N_),date_first_seen(Date_First_Seen_:EPOCH),date_last_seen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping5_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('BA');
    SELF.__Permits := CFG_Compile.Permit_FCRA;
    SELF := __r;
  END;
  SHARED __d5_Norm := NORMALIZE(__in,LEFT.Dataset_Bankruptcy_Files__Key_Search,TRANSFORM(RECORDOF(__in.Dataset_Bankruptcy_Files__Key_Search),SELF:=RIGHT));
  EXPORT __d5_KELfiltered := __d5_Norm((UNSIGNED)ssn != 0 AND (UNSIGNED)did != 0);
  SHARED __d5_Prefiltered := __d5_KELfiltered;
  SHARED __d5 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d5_Prefiltered,InLayout,__Mapping5),__Mapping5_Transform(LEFT)));
  SHARED __Mapping6 := 'did(Subject_:0),ssn(Social_:0),templegacyssn(Temp_Legacy_S_S_N_),date_first_seen(Date_First_Seen_:EPOCH),date_last_seen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping6_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('BA');
    SELF.__Permits := CFG_Compile.Permit_NonFCRA;
    SELF := __r;
  END;
  SHARED __d6_Norm := NORMALIZE(__in,LEFT.Dataset_Bankruptcy_Files__Key_Search,TRANSFORM(RECORDOF(__in.Dataset_Bankruptcy_Files__Key_Search),SELF:=RIGHT));
  EXPORT __d6_KELfiltered := __d6_Norm((UNSIGNED)ssn != 0 AND (UNSIGNED)did != 0);
  SHARED __d6_Prefiltered := __d6_KELfiltered;
  SHARED __d6 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d6_Prefiltered,InLayout,__Mapping6),__Mapping6_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4 + __d5 + __d6;
  EXPORT Temp_Legacy_S_S_N_Layout := RECORD
    KEL.typ.nbool Temp_Legacy_S_S_N_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Social_Security_Number().Typ) Social_;
    KEL.typ.ndataset(Temp_Legacy_S_S_N_Layout) Temp_Legacy_S_S_N_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Subject_,Social_,ALL));
  Person_S_S_N_Group := __PostFilter;
  Layout Person_S_S_N__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Temp_Legacy_S_S_N_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Temp_Legacy_S_S_N_},Temp_Legacy_S_S_N_),Temp_Legacy_S_S_N_Layout)(__NN(Temp_Legacy_S_S_N_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Person_S_S_N__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Temp_Legacy_S_S_N_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Temp_Legacy_S_S_N_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Temp_Legacy_S_S_N_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Person_S_S_N_Group,COUNT(ROWS(LEFT))=1),GROUP,Person_S_S_N__Single_Rollup(LEFT)) + ROLLUP(HAVING(Person_S_S_N_Group,COUNT(ROWS(LEFT))>1),GROUP,Person_S_S_N__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::PublicRecords_KEL::Person_S_S_N::Result' + IF(__cfg.PersistId <> '','::' + __cfg.PersistId,''),EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Social__Orphan := JOIN(InData(__NN(Social_)),E_Social_Security_Number(__in,__cfg).__Result,__EEQP(LEFT.Social_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(Social__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int Social__Orphan});
  EXPORT NullCounts := DATASET([
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d0(__NL(Social_))),COUNT(__d0(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TempLegacySSN',COUNT(__d0(__NL(Temp_Legacy_S_S_N_))),COUNT(__d0(__NN(Temp_Legacy_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d1(__NL(Social_))),COUNT(__d1(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TempLegacySSN',COUNT(__d1(__NL(Temp_Legacy_S_S_N_))),COUNT(__d1(__NN(Temp_Legacy_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d2(__NL(Subject_))),COUNT(__d2(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d2(__NL(Social_))),COUNT(__d2(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TempLegacySSN',COUNT(__d2(__NL(Temp_Legacy_S_S_N_))),COUNT(__d2(__NN(Temp_Legacy_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d3(__NL(Subject_))),COUNT(__d3(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d3(__NL(Social_))),COUNT(__d3(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TempLegacySSN',COUNT(__d3(__NL(Temp_Legacy_S_S_N_))),COUNT(__d3(__NN(Temp_Legacy_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d4(__NL(Subject_))),COUNT(__d4(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d4(__NL(Social_))),COUNT(__d4(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TempLegacySSN',COUNT(__d4(__NL(Temp_Legacy_S_S_N_))),COUNT(__d4(__NN(Temp_Legacy_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d5(__NL(Subject_))),COUNT(__d5(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d5(__NL(Social_))),COUNT(__d5(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TempLegacySSN',COUNT(__d5(__NL(Temp_Legacy_S_S_N_))),COUNT(__d5(__NN(Temp_Legacy_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d5(Date_First_Seen_=0)),COUNT(__d5(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d5(Date_Last_Seen_=0)),COUNT(__d5(Date_Last_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d6(__NL(Subject_))),COUNT(__d6(__NN(Subject_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','ssn',COUNT(__d6(__NL(Social_))),COUNT(__d6(__NN(Social_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','TempLegacySSN',COUNT(__d6(__NL(Temp_Legacy_S_S_N_))),COUNT(__d6(__NN(Temp_Legacy_S_S_N_)))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d6(Date_First_Seen_=0)),COUNT(__d6(Date_First_Seen_!=0))},
    {'PersonSSN','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d6(Date_Last_Seen_=0)),COUNT(__d6(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
