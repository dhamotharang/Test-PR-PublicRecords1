//HPCC Systems KEL Compiler Version 0.11.6
IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Aircraft,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL011.Null;
EXPORT E_Aircraft_Owner(CFG_Compile.FDCDataset __in = CFG_Compile.FDCDefault, CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Aircraft().Typ) Plane_;
    KEL.typ.ntyp(E_Person().Typ) Owner_;
    KEL.typ.nint Registrant_Type_;
    KEL.typ.nkdate Certificate_Issue_Date_;
    KEL.typ.nstr Certification_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    UNSIGNED8 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Plane_(Plane_:0),owner(Owner_:0),registranttype(Registrant_Type_:0),certificateissuedate(Certificate_Issue_Date_:DATE),certification(Certification_:\'\'),source(Source_:\'\'),datefirstseen(Date_First_Seen_:EPOCH),datelastseen(Date_Last_Seen_:EPOCH)';
  SHARED __d0_Plane__Layout := RECORD
    RECORDOF(__in);
    KEL.typ.uid Plane_;
  END;
  SHARED __d0_Plane__Mapped := JOIN(__in,E_Aircraft(__in,__cfg).Lookup,TRIM((STRING)LEFT.NNumber) = RIGHT.KeyVal,TRANSFORM(__d0_Plane__Layout,SELF.Plane_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,HASH);
  SHARED __d0_Prefiltered := __d0_Plane__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping));
  EXPORT InData := __d0;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Aircraft().Typ) Plane_;
    KEL.typ.ntyp(E_Person().Typ) Owner_;
    KEL.typ.nint Registrant_Type_;
    KEL.typ.nkdate Certificate_Issue_Date_;
    KEL.typ.nstr Certification_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Plane_,Owner_,Registrant_Type_,Certificate_Issue_Date_,Certification_,ALL));
  Aircraft_Owner_Group := __PostFilter;
  Layout Aircraft_Owner__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,TRUE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,TRUE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF := __r;
  END;
  Layout Aircraft_Owner__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Aircraft_Owner_Group,COUNT(ROWS(LEFT))=1),GROUP,Aircraft_Owner__Single_Rollup(LEFT)) + ROLLUP(HAVING(Aircraft_Owner_Group,COUNT(ROWS(LEFT))>1),GROUP,Aircraft_Owner__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult) : PERSIST('~temp::KEL::PublicRecords_KEL::Aircraft_Owner::Result' + IF(__cfg.PersistId <> '','::' + __cfg.PersistId,''),EXPIRE(7));
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Plane__Orphan := JOIN(InData(__NN(Plane_)),E_Aircraft(__in,__cfg).__Result,__EEQP(LEFT.Plane_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Owner__Orphan := JOIN(InData(__NN(Owner_)),E_Person(__in,__cfg).__Result,__EEQP(LEFT.Owner_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Plane__Orphan),COUNT(Owner__Orphan)}],{KEL.typ.int Plane__Orphan,KEL.typ.int Owner__Orphan});
  EXPORT NullCounts := DATASET([
    {'AircraftOwner','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Plane',COUNT(__d0(__NL(Plane_))),COUNT(__d0(__NN(Plane_)))},
    {'AircraftOwner','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Owner',COUNT(__d0(__NL(Owner_))),COUNT(__d0(__NN(Owner_)))},
    {'AircraftOwner','PublicRecords_KEL.ECL_Functions.Dataset_FDC','RegistrantType',COUNT(__d0(__NL(Registrant_Type_))),COUNT(__d0(__NN(Registrant_Type_)))},
    {'AircraftOwner','PublicRecords_KEL.ECL_Functions.Dataset_FDC','CertificateIssueDate',COUNT(__d0(__NL(Certificate_Issue_Date_))),COUNT(__d0(__NN(Certificate_Issue_Date_)))},
    {'AircraftOwner','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Certification',COUNT(__d0(__NL(Certification_))),COUNT(__d0(__NN(Certification_)))},
    {'AircraftOwner','PublicRecords_KEL.ECL_Functions.Dataset_FDC','Source',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'AircraftOwner','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'AircraftOwner','PublicRecords_KEL.ECL_Functions.Dataset_FDC','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
