//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Address,E_Drivers_License,E_Zip_Code FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Address_Drivers_License(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.ntyp(E_Drivers_License().Typ) License_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Location_(Location_:0),License_(License_:0),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Location__Layout := RECORD
    RECORDOF(__in);
    KEL.typ.uid Location_;
  END;
  SHARED __d0_Location__Mapped := JOIN(__in,E_Address(__in,__cfg).Lookup,TRIM((STRING)LEFT.PrimaryRange) + '|' + TRIM((STRING)LEFT.Predirectional) + '|' + TRIM((STRING)LEFT.PrimaryName) + '|' + TRIM((STRING)LEFT.Suffix) + '|' + TRIM((STRING)LEFT.Postdirectional) + '|' + TRIM((STRING)LEFT.ZIP5) + '|' + TRIM((STRING)LEFT.SecondaryRange) = RIGHT.KeyVal,TRANSFORM(__d0_Location__Layout,SELF.Location_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_License__Layout := RECORD
    RECORDOF(__d0_Location__Mapped);
    KEL.typ.uid License_;
  END;
  SHARED __d0_License__Mapped := JOIN(__d0_Location__Mapped,E_Drivers_License(__in,__cfg).Lookup,TRIM((STRING)LEFT.DriversLicenseNumber) + '|' + TRIM((STRING)LEFT.IssuingState) = RIGHT.KeyVal,TRANSFORM(__d0_License__Layout,SELF.License_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_License__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Address().Typ) Location_;
    KEL.typ.ntyp(E_Drivers_License().Typ) License_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Location_,License_,ALL));
  Address_Drivers_License_Group := __PostFilter;
  Layout Address_Drivers_License__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Address_Drivers_License__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Address_Drivers_License_Group,COUNT(ROWS(LEFT))=1),GROUP,Address_Drivers_License__Single_Rollup(LEFT)) + ROLLUP(HAVING(Address_Drivers_License_Group,COUNT(ROWS(LEFT))>1),GROUP,Address_Drivers_License__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::PublicRecords_KEL::Address_Drivers_License::Result' + IF(__cfg.PersistId <> '','::' + __cfg.PersistId,''),EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Location__Orphan := JOIN(InData(__NN(Location_)),E_Address(__in,__cfg).__Result,__EEQP(LEFT.Location_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT License__Orphan := JOIN(InData(__NN(License_)),E_Drivers_License(__in,__cfg).__Result,__EEQP(LEFT.License_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Location__Orphan),COUNT(License__Orphan)}],{KEL.typ.int Location__Orphan,KEL.typ.int License__Orphan});
  EXPORT NullCounts := DATASET([
    {'AddressDriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Location',COUNT(__d0(__NL(Location_))),COUNT(__d0(__NN(Location_)))},
    {'AddressDriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','License',COUNT(__d0(__NL(License_))),COUNT(__d0(__NN(License_)))},
    {'AddressDriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'AddressDriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'AddressDriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
