//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Person FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_First_Degree_Associations(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Person().Typ) First_Degree_Association_;
    KEL.typ.nint Title_;
    KEL.typ.nstr Relationship_Type_;
    KEL.typ.nstr Relationship_Confidence_;
    KEL.typ.nint Relationship_Score_;
    KEL.typ.nstr Generation_;
    KEL.typ.nstr Relationship_Date_First_Seen_;
    KEL.typ.nstr Relationship_Date_Last_Seen_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    DATA57 __Permits;
  END;
  SHARED VIRTUAL __SourceFilter(DATASET(InLayout) __ds) := __ds;
  SHARED __Mapping := 'lexid(DEFAULT:Subject_:0|DEFAULT:First_Degree_Association_:0),title(DEFAULT:Title_:0),relationshiptype(DEFAULT:Relationship_Type_:\'\'),relationshipconfidence(DEFAULT:Relationship_Confidence_:\'\'),relationshipscore(DEFAULT:Relationship_Score_:0),generation(DEFAULT:Generation_:\'\'),relationshipdatefirstseen(DEFAULT:Relationship_Date_First_Seen_:\'\'),relationshipdatelastseen(DEFAULT:Relationship_Date_Last_Seen_:\'\'),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Hybrid_Archive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'did1(OVERRIDE:Subject_:0),did2(OVERRIDE:First_Degree_Association_:0),title(OVERRIDE:Title_:0),type(OVERRIDE:Relationship_Type_:\'\'),confidence(OVERRIDE:Relationship_Confidence_:\'\'),total_score(OVERRIDE:Relationship_Score_:0),generation(OVERRIDE:Generation_:\'\'),rel_dt_first_seen(OVERRIDE:Relationship_Date_First_Seen_:\'\'|OVERRIDE:Date_First_Seen_:EPOCH),rel_dt_last_seen(OVERRIDE:Relationship_Date_Last_Seen_:\'\'|OVERRIDE:Date_Last_Seen_:EPOCH),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d0_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Relationship__Key_Relatives_V3_Vault(Type IN ['PERSONAL', 'SSN ONLY', 'UCC', 'TRANS CLOSURE'] AND 
								Personal = TRUE AND 
								Business = FALSE AND 
								Confidence = 'HIGH' AND 
								((Title >= 1 AND Title < 43) OR (CoSourceCount > 1 AND CoSourceSum > 1 AND Title IN [43, 44])));
  SHARED __d0_Prefiltered := __d0_KELfiltered;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.Relationship__Key_Relatives_V3_Vault'));
  SHARED Hybrid_Archive_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'did1(OVERRIDE:Subject_:0),did2(OVERRIDE:First_Degree_Association_:0),title(OVERRIDE:Title_:0),type(OVERRIDE:Relationship_Type_:\'\'),confidence(OVERRIDE:Relationship_Confidence_:\'\'),total_score(OVERRIDE:Relationship_Score_:0),generation(OVERRIDE:Generation_:\'\'),rel_dt_first_seen(OVERRIDE:Relationship_Date_First_Seen_:\'\'|OVERRIDE:Date_First_Seen_:EPOCH),rel_dt_last_seen(OVERRIDE:Relationship_Date_Last_Seen_:\'\'|OVERRIDE:Date_Last_Seen_:EPOCH),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_1Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d1_KELfiltered := PublicRecords_KEL.Files.NonFCRA.DX_Relatives_v3__Key_Marketing_Header_Relatives_Vault(Type IN ['PERSONAL', 'SSN ONLY', 'UCC', 'TRANS CLOSURE'] AND 
								Personal = TRUE AND 
								Business = FALSE AND 
								Confidence = 'HIGH' AND 
								((Title >= 1 AND Title < 43) OR (CoSourceCount > 1 AND CoSourceSum > 1 AND Title IN [43, 44])));
  SHARED __d1_Prefiltered := __d1_KELfiltered;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.NonFCRA.DX_Relatives_v3__Key_Marketing_Header_Relatives_Vault'));
  EXPORT InData := __d0 + __d1;
  EXPORT Layout := RECORD
    KEL.typ.ntyp(E_Person().Typ) Subject_;
    KEL.typ.ntyp(E_Person().Typ) First_Degree_Association_;
    KEL.typ.nint Title_;
    KEL.typ.nstr Relationship_Type_;
    KEL.typ.nstr Relationship_Confidence_;
    KEL.typ.nint Relationship_Score_;
    KEL.typ.nstr Generation_;
    KEL.typ.nstr Relationship_Date_First_Seen_;
    KEL.typ.nstr Relationship_Date_Last_Seen_;
    KEL.typ.nstr Source_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PreResult := PROJECT(TABLE(InData,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Subject_,First_Degree_Association_,Title_,Relationship_Type_,Relationship_Confidence_,Relationship_Score_,Generation_,Relationship_Date_First_Seen_,Relationship_Date_Last_Seen_,Source_},Subject_,First_Degree_Association_,Title_,Relationship_Type_,Relationship_Confidence_,Relationship_Score_,Generation_,Relationship_Date_First_Seen_,Relationship_Date_Last_Seen_,Source_,MERGE),Layout);
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT Subject__Orphan := JOIN(InData(__NN(Subject_)),E_Person(__cfg).__Result,__EEQP(LEFT.Subject_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT First_Degree_Association__Orphan := JOIN(InData(__NN(First_Degree_Association_)),E_Person(__cfg).__Result,__EEQP(LEFT.First_Degree_Association_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(Subject__Orphan),COUNT(First_Degree_Association__Orphan)}],{KEL.typ.int Subject__Orphan,KEL.typ.int First_Degree_Association__Orphan});
  EXPORT NullCounts := DATASET([
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.Relationship__Key_Relatives_V3_Vault','did1',COUNT(__d0(__NL(Subject_))),COUNT(__d0(__NN(Subject_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.Relationship__Key_Relatives_V3_Vault','did2',COUNT(__d0(__NL(First_Degree_Association_))),COUNT(__d0(__NN(First_Degree_Association_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.Relationship__Key_Relatives_V3_Vault','title',COUNT(__d0(__NL(Title_))),COUNT(__d0(__NN(Title_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.Relationship__Key_Relatives_V3_Vault','type',COUNT(__d0(__NL(Relationship_Type_))),COUNT(__d0(__NN(Relationship_Type_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.Relationship__Key_Relatives_V3_Vault','confidence',COUNT(__d0(__NL(Relationship_Confidence_))),COUNT(__d0(__NN(Relationship_Confidence_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.Relationship__Key_Relatives_V3_Vault','total_score',COUNT(__d0(__NL(Relationship_Score_))),COUNT(__d0(__NN(Relationship_Score_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.Relationship__Key_Relatives_V3_Vault','generation',COUNT(__d0(__NL(Generation_))),COUNT(__d0(__NN(Generation_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.Relationship__Key_Relatives_V3_Vault','rel_dt_first_seen',COUNT(__d0(__NL(Relationship_Date_First_Seen_))),COUNT(__d0(__NN(Relationship_Date_First_Seen_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.Relationship__Key_Relatives_V3_Vault','rel_dt_last_seen',COUNT(__d0(__NL(Relationship_Date_Last_Seen_))),COUNT(__d0(__NN(Relationship_Date_Last_Seen_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.Relationship__Key_Relatives_V3_Vault','Src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.Relationship__Key_Relatives_V3_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.Relationship__Key_Relatives_V3_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.Relationship__Key_Relatives_V3_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.Relationship__Key_Relatives_V3_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.Relationship__Key_Relatives_V3_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.DX_Relatives_v3__Key_Marketing_Header_Relatives_Vault','did1',COUNT(__d1(__NL(Subject_))),COUNT(__d1(__NN(Subject_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.DX_Relatives_v3__Key_Marketing_Header_Relatives_Vault','did2',COUNT(__d1(__NL(First_Degree_Association_))),COUNT(__d1(__NN(First_Degree_Association_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.DX_Relatives_v3__Key_Marketing_Header_Relatives_Vault','title',COUNT(__d1(__NL(Title_))),COUNT(__d1(__NN(Title_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.DX_Relatives_v3__Key_Marketing_Header_Relatives_Vault','type',COUNT(__d1(__NL(Relationship_Type_))),COUNT(__d1(__NN(Relationship_Type_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.DX_Relatives_v3__Key_Marketing_Header_Relatives_Vault','confidence',COUNT(__d1(__NL(Relationship_Confidence_))),COUNT(__d1(__NN(Relationship_Confidence_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.DX_Relatives_v3__Key_Marketing_Header_Relatives_Vault','total_score',COUNT(__d1(__NL(Relationship_Score_))),COUNT(__d1(__NN(Relationship_Score_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.DX_Relatives_v3__Key_Marketing_Header_Relatives_Vault','generation',COUNT(__d1(__NL(Generation_))),COUNT(__d1(__NN(Generation_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.DX_Relatives_v3__Key_Marketing_Header_Relatives_Vault','rel_dt_first_seen',COUNT(__d1(__NL(Relationship_Date_First_Seen_))),COUNT(__d1(__NN(Relationship_Date_First_Seen_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.DX_Relatives_v3__Key_Marketing_Header_Relatives_Vault','rel_dt_last_seen',COUNT(__d1(__NL(Relationship_Date_Last_Seen_))),COUNT(__d1(__NN(Relationship_Date_Last_Seen_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.DX_Relatives_v3__Key_Marketing_Header_Relatives_Vault','Src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.DX_Relatives_v3__Key_Marketing_Header_Relatives_Vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.DX_Relatives_v3__Key_Marketing_Header_Relatives_Vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.DX_Relatives_v3__Key_Marketing_Header_Relatives_Vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.DX_Relatives_v3__Key_Marketing_Header_Relatives_Vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'FirstDegreeAssociations','PublicRecords_KEL.Files.NonFCRA.DX_Relatives_v3__Key_Marketing_Header_Relatives_Vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
