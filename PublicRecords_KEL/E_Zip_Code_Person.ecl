//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Address,E_Person,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Zip_Code_Person(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Zip_Code().Typ) Zip_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'zip(Zip_:0),subject(Subject_:0),Location_(Location_:0),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __Mapping0 := 'zip(Zip_:0),did(Subject_:0),Location_(Location_:0),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie__Key_Header,TRANSFORM(RECORDOF(__in.Dataset_Doxie__Key_Header),SELF:=RIGHT));
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__d0_Norm);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Location__Mapped := JOIN(__d0_Norm,E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.PrimaryRange) + '|' + TRIM((STRING)LEFT.Predirectional) + '|' + TRIM((STRING)LEFT.PrimaryName) + '|' + TRIM((STRING)LEFT.Postdirectional) + '|' + TRIM((STRING)LEFT.Suffix) + '|' + TRIM((STRING)LEFT.ZIP5) + '|' + TRIM((STRING)LEFT.SecondaryRange) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Location__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0));
  SHARED __Mapping1 := 'zip5(Zip_:0),did(Subject_:0),Location_(Location_:0),src(Source_:\'\'),earliest_offense_date(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping1_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_NonFCRA;
    SELF := __r;
  END;
  SHARED __d1_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders_Risk,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders_Risk),SELF:=RIGHT));
  SHARED __d1_Location__Layout := RECORD
    RECORDOF(__d1_Norm);
    KEL.typ.uid Location_;
  END;
  SHARED __d1_Location__Mapped := JOIN(__d1_Norm,E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.zip5) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d1_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d1_Prefiltered := __d1_Location__Mapped;
  SHARED __d1 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1),__Mapping1_Transform(LEFT)));
  SHARED __Mapping2 := 'zip5(Zip_:0),did(Subject_:0),Location_(Location_:0),src(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping2_Transform(InLayout __r) := TRANSFORM
    SELF.__Permits := CFG_Compile.Permit_NonFCRA;
    SELF := __r;
  END;
  SHARED __d2_Norm := NORMALIZE(__in,LEFT.Dataset_Doxie_Files__Key_Offenders,TRANSFORM(RECORDOF(__in.Dataset_Doxie_Files__Key_Offenders),SELF:=RIGHT));
  SHARED __d2_Location__Layout := RECORD
    RECORDOF(__d2_Norm);
    KEL.typ.uid Location_;
  END;
  SHARED __d2_Location__Mapped := JOIN(__d2_Norm,E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.zip5) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d2_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d2_Prefiltered := __d2_Location__Mapped;
  SHARED __d2 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2),__Mapping2_Transform(LEFT)));
  SHARED __Mapping3 := 'zip(Zip_:0),did(Subject_:0),Location_(Location_:0),date_first_seen(Date_First_Seen_:EPOCH),date_last_seen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping3_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('BA');
    SELF.__Permits := CFG_Compile.Permit_FCRA;
    SELF := __r;
  END;
  SHARED __d3_Norm := NORMALIZE(__in,LEFT.Dataset_Bankruptcy_Files__Key_Search,TRANSFORM(RECORDOF(__in.Dataset_Bankruptcy_Files__Key_Search),SELF:=RIGHT));
  SHARED __d3_Location__Layout := RECORD
    RECORDOF(__d3_Norm);
    KEL.typ.uid Location_;
  END;
  SHARED __d3_Location__Mapped := JOIN(__d3_Norm,E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d3_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d3_Prefiltered := __d3_Location__Mapped;
  SHARED __d3 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3),__Mapping3_Transform(LEFT)));
  SHARED __Mapping4 := 'zip(Zip_:0),did(Subject_:0),Location_(Location_:0),date_first_seen(Date_First_Seen_:EPOCH),date_last_seen(Date_Last_Seen_:EPOCH)';
  SHARED InLayout __Mapping4_Transform(InLayout __r) := TRANSFORM
    SELF.Source_ := __CN('BA');
    SELF.__Permits := CFG_Compile.Permit_NonFCRA;
    SELF := __r;
  END;
  SHARED __d4_Norm := NORMALIZE(__in,LEFT.Dataset_Bankruptcy_Files__Key_Search,TRANSFORM(RECORDOF(__in.Dataset_Bankruptcy_Files__Key_Search),SELF:=RIGHT));
  SHARED __d4_Location__Layout := RECORD
    RECORDOF(__d4_Norm);
    KEL.typ.uid Location_;
  END;
  SHARED __d4_Location__Mapped := JOIN(__d4_Norm,E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.prim_range) + '|' + TRIM((STRING)LEFT.predir) + '|' + TRIM((STRING)LEFT.prim_name) + '|' + TRIM((STRING)LEFT.postdir) + '|' + TRIM((STRING)LEFT.addr_suffix) + '|' + TRIM((STRING)LEFT.zip) + '|' + TRIM((STRING)LEFT.sec_range) = RIGHT.KeyVal,TRANSFORM(__d4_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d4_Prefiltered := __d4_Location__Mapped;
  SHARED __d4 := __SourceFilter(PROJECT(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4),__Mapping4_Transform(LEFT)));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Zip_Code().Typ) Zip_;
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Zip_,Subject_,Location_,ALL));
  Zip_Code_Person_Group := __PostFilter;
  Layout Zip_Code_Person__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Zip_Code_Person__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Zip_Code_Person_Group,COUNT(ROWS(LEFT))=1),GROUP,Zip_Code_Person__Single_Rollup(LEFT)) + ROLLUP(HAVING(Zip_Code_Person_Group,COUNT(ROWS(LEFT))>1),GROUP,Zip_Code_Person__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::PublicRecords_KEL::Zip_Code_Person::Result' + IF(__cfg.PersistId <> '','::' + __cfg.PersistId,''),EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Zip__Orphan := JOIN(InData(__NN(Zip_)),E_Zip_Code(__in,__cfg).__Result,__EEQP(LEFT.Zip_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address(__in,__cfg).__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Zip__Orphan),COUNT(Subject__Orphan),COUNT(Location__Orphan)}],{KEL.typ.int Zip__Orphan,KEL.typ.int Subject__Orphan,KEL.typ.int Location__Orphan});
  EXPORT NullCounts := DATASET([
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d0(__NL(Zip_))),COUNT(__d0(__NN(Zip_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip5',COUNT(__d1(__NL(Zip_))),COUNT(__d1(__NN(Zip_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d1(__NL(Location_))),COUNT(__d1(__NN(Location_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip5',COUNT(__d2(__NL(Zip_))),COUNT(__d2(__NN(Zip_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d2(__NL(Subject_))),COUNT(__d2(__NN(Subject_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d2(__NL(Location_))),COUNT(__d2(__NN(Location_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d3(__NL(Zip_))),COUNT(__d3(__NN(Zip_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d3(__NL(Subject_))),COUNT(__d3(__NN(Subject_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d3(__NL(Location_))),COUNT(__d3(__NN(Location_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','zip',COUNT(__d4(__NL(Zip_))),COUNT(__d4(__NN(Zip_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','did',COUNT(__d4(__NL(Subject_))),COUNT(__d4(__NN(Subject_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d4(__NL(Location_))),COUNT(__d4(__NN(Location_)))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'ZipCodePerson','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
