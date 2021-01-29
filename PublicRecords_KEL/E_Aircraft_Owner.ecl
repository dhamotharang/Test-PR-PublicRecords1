//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Aircraft,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Aircraft_Owner(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Aircraft().Typ) Plane_;
    KEL.typ.ntyp(E_Person().Typ) Owner_;
    KEL.typ.nint Registrant_Type_;
    KEL.typ.nkdate Certificate_Issue_Date_;
    KEL.typ.nstr Certification_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    DATA57 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED VIRTUAL __GroupedFilter(GROUPED DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'Plane_(DEFAULT:Plane_:0),owner(DEFAULT:Owner_:0),registranttype(DEFAULT:Registrant_Type_:0),certificateissuedate(DEFAULT:Certificate_Issue_Date_:DATE),certification(DEFAULT:Certification_:\'\'),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Hybrid_Archive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'Plane_(DEFAULT:Plane_:0),did_out(OVERRIDE:Owner_:0),type_registrant(OVERRIDE:Registrant_Type_:0),cert_issue_date(OVERRIDE:Certificate_Issue_Date_:DATE),certification(OVERRIDE:Certification_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d0_KELfiltered := PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault((UNSIGNED)did_out != 0);
  SHARED __d0_Plane__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid Plane_;
  END;
  SHARED __d0_Missing_Plane__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_KELfiltered,'n_number','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault');
  SHARED __d0_Plane__Mapped := IF(__d0_Missing_Plane__UIDComponents = 'n_number',PROJECT(__d0_KELfiltered,TRANSFORM(__d0_Plane__Layout,SELF.Plane_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_KELfiltered,__d0_Missing_Plane__UIDComponents),E_Aircraft(__cfg).Lookup,TRIM((STRING)LEFT.n_number) = RIGHT.KeyVal,TRANSFORM(__d0_Plane__Layout,SELF.Plane_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_Plane__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault'));
  SHARED Hybrid_Archive_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'Plane_(DEFAULT:Plane_:0),did_out(OVERRIDE:Owner_:0),type_registrant(OVERRIDE:Registrant_Type_:0),cert_issue_date(OVERRIDE:Certificate_Issue_Date_:DATE),certification(OVERRIDE:Certification_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_1Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d1_KELfiltered := PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault((UNSIGNED)did_out != 0);
  SHARED __d1_Plane__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid Plane_;
  END;
  SHARED __d1_Missing_Plane__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_KELfiltered,'n_number','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault');
  SHARED __d1_Plane__Mapped := IF(__d1_Missing_Plane__UIDComponents = 'n_number',PROJECT(__d1_KELfiltered,TRANSFORM(__d1_Plane__Layout,SELF.Plane_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_KELfiltered,__d1_Missing_Plane__UIDComponents),E_Aircraft(__cfg).Lookup,TRIM((STRING)LEFT.n_number) = RIGHT.KeyVal,TRANSFORM(__d1_Plane__Layout,SELF.Plane_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Prefiltered := __d1_Plane__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault'));
  EXPORT InData := __d0 + __d1;
  EXPORT Data_Sources_Layout := RECORD
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Aircraft().Typ) Plane_;
    KEL.typ.ntyp(E_Person().Typ) Owner_;
    KEL.typ.nint Registrant_Type_;
    KEL.typ.nkdate Certificate_Issue_Date_;
    KEL.typ.nstr Certification_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,Plane_,Owner_,Registrant_Type_,Certificate_Issue_Date_,Certification_,ALL));
  Aircraft_Owner_Group := __PostFilter;
  Layout Aircraft_Owner__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Aircraft_Owner__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Aircraft_Owner_Group,COUNT(ROWS(LEFT))=1),GROUP,Aircraft_Owner__Single_Rollup(LEFT)) + ROLLUP(HAVING(Aircraft_Owner_Group,COUNT(ROWS(LEFT))>1),GROUP,Aircraft_Owner__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Plane__Orphan := JOIN(InData(__NN(Plane_)),E_Aircraft(__cfg).__Result,__EEQP(LEFT.Plane_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Owner__Orphan := JOIN(InData(__NN(Owner_)),E_Person(__cfg).__Result,__EEQP(LEFT.Owner_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Plane__Orphan),COUNT(Owner__Orphan)}],{KEL.typ.int Plane__Orphan,KEL.typ.int Owner__Orphan});
  EXPORT NullCounts := DATASET([
    {'AircraftOwner','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','Plane',COUNT(__d0(__NL(Plane_))),COUNT(__d0(__NN(Plane_)))},
    {'AircraftOwner','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','did_out',COUNT(__d0(__NL(Owner_))),COUNT(__d0(__NN(Owner_)))},
    {'AircraftOwner','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','type_registrant',COUNT(__d0(__NL(Registrant_Type_))),COUNT(__d0(__NN(Registrant_Type_)))},
    {'AircraftOwner','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','cert_issue_date',COUNT(__d0(__NL(Certificate_Issue_Date_))),COUNT(__d0(__NN(Certificate_Issue_Date_)))},
    {'AircraftOwner','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','certification',COUNT(__d0(__NL(Certification_))),COUNT(__d0(__NN(Certification_)))},
    {'AircraftOwner','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'AircraftOwner','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'AircraftOwner','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'AircraftOwner','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'AircraftOwner','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'AircraftOwner','PublicRecords_KEL.Files.NonFCRA.FAA__Key_Aircraft_Id_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'AircraftOwner','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','Plane',COUNT(__d1(__NL(Plane_))),COUNT(__d1(__NN(Plane_)))},
    {'AircraftOwner','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','did_out',COUNT(__d1(__NL(Owner_))),COUNT(__d1(__NN(Owner_)))},
    {'AircraftOwner','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','type_registrant',COUNT(__d1(__NL(Registrant_Type_))),COUNT(__d1(__NN(Registrant_Type_)))},
    {'AircraftOwner','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','cert_issue_date',COUNT(__d1(__NL(Certificate_Issue_Date_))),COUNT(__d1(__NN(Certificate_Issue_Date_)))},
    {'AircraftOwner','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','certification',COUNT(__d1(__NL(Certification_))),COUNT(__d1(__NN(Certification_)))},
    {'AircraftOwner','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'AircraftOwner','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'AircraftOwner','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'AircraftOwner','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'AircraftOwner','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'AircraftOwner','PublicRecords_KEL.Files.FCRA.FAA__Key_Aircraft_Id_vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
