//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Accident,E_Drivers_License FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Accident_Drivers_License(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Accident().Typ) Acc_;
    KEL.typ.ntyp(E_Drivers_License().Typ) License_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Acc_(Acc_:0),License_(License_:0),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Acc__Layout := RECORD
    RECORDOF(__in);
    KEL.typ.uid Acc_;
  END;
  SHARED __d0_Acc__Mapped := JOIN(__in,E_Accident(__in,__cfg).Lookup,TRIM((STRING)LEFT.AccidentNumber) = RIGHT.KeyVal,TRANSFORM(__d0_Acc__Layout,SELF.Acc_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_License__Layout := RECORD
    RECORDOF(__d0_Acc__Mapped);
    KEL.typ.uid License_;
  END;
  SHARED __d0_License__Mapped := JOIN(__d0_Acc__Mapped,E_Drivers_License(__in,__cfg).Lookup,TRIM((STRING)LEFT.DriversLicenseNumber) + '|' + TRIM((STRING)LEFT.IssuingState) = RIGHT.KeyVal,TRANSFORM(__d0_License__Layout,SELF.License_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
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
    KEL.typ.ntyp(E_Accident().Typ) Acc_;
    KEL.typ.ntyp(E_Drivers_License().Typ) License_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Acc_,License_,ALL));
  Accident_Drivers_License_Group := __PostFilter;
  Layout Accident_Drivers_License__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Accident_Drivers_License__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Accident_Drivers_License_Group,COUNT(ROWS(LEFT))=1),GROUP,Accident_Drivers_License__Single_Rollup(LEFT)) + ROLLUP(HAVING(Accident_Drivers_License_Group,COUNT(ROWS(LEFT))>1),GROUP,Accident_Drivers_License__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Acc__Orphan := JOIN(InData(__NN(Acc_)),E_Accident(__in,__cfg).__Result,__EEQP(LEFT.Acc_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT License__Orphan := JOIN(InData(__NN(License_)),E_Drivers_License(__in,__cfg).__Result,__EEQP(LEFT.License_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Acc__Orphan),COUNT(License__Orphan)}],{KEL.typ.int Acc__Orphan,KEL.typ.int License__Orphan});
  EXPORT NullCounts := DATASET([
    {'AccidentDriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Acc',COUNT(__d0(__NL(Acc_))),COUNT(__d0(__NN(Acc_)))},
    {'AccidentDriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','License',COUNT(__d0(__NL(License_))),COUNT(__d0(__NN(License_)))},
    {'AccidentDriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'AccidentDriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'AccidentDriversLicense','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
