//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile,E_Person,E_Watercraft FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Watercraft_Owner(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.ntyp(E_Watercraft().Typ) W_Craft_;
    KEL.typ.ntyp(E_Person().Typ) Owner_;
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
  SHARED __Mapping := 'W_Craft_(DEFAULT:W_Craft_:0),owner(DEFAULT:Owner_:0),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED Hybrid_Archive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'W_Craft_(DEFAULT:W_Craft_:0),l_did(OVERRIDE:Owner_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d0_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault((UNSIGNED)l_did > 0);
  SHARED __d0_W_Craft__Layout := RECORD
    RECORDOF(__d0_KELfiltered);
    KEL.typ.uid W_Craft_;
  END;
  SHARED __d0_Missing_W_Craft__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d0_KELfiltered,'watercraft_key','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault');
  SHARED __d0_W_Craft__Mapped := IF(__d0_Missing_W_Craft__UIDComponents = 'watercraft_key',PROJECT(__d0_KELfiltered,TRANSFORM(__d0_W_Craft__Layout,SELF.W_Craft_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d0_KELfiltered,__d0_Missing_W_Craft__UIDComponents),E_Watercraft(__cfg).Lookup,TRIM((STRING)LEFT.watercraft_key) = RIGHT.KeyVal,TRANSFORM(__d0_W_Craft__Layout,SELF.W_Craft_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d0_Prefiltered := __d0_W_Craft__Mapped;
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault'));
  SHARED Hybrid_Archive_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'W_Craft_(DEFAULT:W_Craft_:0),did(OVERRIDE:Owner_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_1Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d1_KELfiltered := PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault((UNSIGNED)did > 0);
  SHARED __d1_W_Craft__Layout := RECORD
    RECORDOF(__d1_KELfiltered);
    KEL.typ.uid W_Craft_;
  END;
  SHARED __d1_Missing_W_Craft__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d1_KELfiltered,'watercraft_key','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault');
  SHARED __d1_W_Craft__Mapped := IF(__d1_Missing_W_Craft__UIDComponents = 'watercraft_key',PROJECT(__d1_KELfiltered,TRANSFORM(__d1_W_Craft__Layout,SELF.W_Craft_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d1_KELfiltered,__d1_Missing_W_Craft__UIDComponents),E_Watercraft(__cfg).Lookup,TRIM((STRING)LEFT.watercraft_key) = RIGHT.KeyVal,TRANSFORM(__d1_W_Craft__Layout,SELF.W_Craft_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d1_Prefiltered := __d1_W_Craft__Mapped;
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault'));
  SHARED Hybrid_Archive_Date_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping2 := 'W_Craft_(DEFAULT:W_Craft_:0),l_did(OVERRIDE:Owner_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_2Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d2_KELfiltered := PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault((UNSIGNED)l_did > 0);
  SHARED __d2_W_Craft__Layout := RECORD
    RECORDOF(__d2_KELfiltered);
    KEL.typ.uid W_Craft_;
  END;
  SHARED __d2_Missing_W_Craft__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d2_KELfiltered,'watercraft_key','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault');
  SHARED __d2_W_Craft__Mapped := IF(__d2_Missing_W_Craft__UIDComponents = 'watercraft_key',PROJECT(__d2_KELfiltered,TRANSFORM(__d2_W_Craft__Layout,SELF.W_Craft_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d2_KELfiltered,__d2_Missing_W_Craft__UIDComponents),E_Watercraft(__cfg).Lookup,TRIM((STRING)LEFT.watercraft_key) = RIGHT.KeyVal,TRANSFORM(__d2_W_Craft__Layout,SELF.W_Craft_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d2_Prefiltered := __d2_W_Craft__Mapped;
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault'));
  SHARED Hybrid_Archive_Date_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping3 := 'W_Craft_(DEFAULT:W_Craft_:0),did(OVERRIDE:Owner_:0),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_3Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  EXPORT __d3_KELfiltered := PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault((UNSIGNED)did > 0);
  SHARED __d3_W_Craft__Layout := RECORD
    RECORDOF(__d3_KELfiltered);
    KEL.typ.uid W_Craft_;
  END;
  SHARED __d3_Missing_W_Craft__UIDComponents := KEL.Intake.ConstructMissingFieldList(__d3_KELfiltered,'watercraft_key','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault');
  SHARED __d3_W_Craft__Mapped := IF(__d3_Missing_W_Craft__UIDComponents = 'watercraft_key',PROJECT(__d3_KELfiltered,TRANSFORM(__d3_W_Craft__Layout,SELF.W_Craft_:=0,SELF:=LEFT)),JOIN(KEL.Intake.AppendFields(__d3_KELfiltered,__d3_Missing_W_Craft__UIDComponents),E_Watercraft(__cfg).Lookup,TRIM((STRING)LEFT.watercraft_key) = RIGHT.KeyVal,TRANSFORM(__d3_W_Craft__Layout,SELF.W_Craft_:=RIGHT.UID,SELF:=LEFT),LEFT OUTER,SMART));
  SHARED __d3_Prefiltered := __d3_W_Craft__Mapped;
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3;
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
    KEL.typ.ntyp(E_Watercraft().Typ) W_Craft_;
    KEL.typ.ntyp(E_Person().Typ) Owner_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(InData,W_Craft_,Owner_,ALL));
  Watercraft_Owner_Group := __PostFilter;
  Layout Watercraft_Owner__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Watercraft_Owner__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Watercraft_Owner_Group,COUNT(ROWS(LEFT))=1),GROUP,Watercraft_Owner__Single_Rollup(LEFT)) + ROLLUP(HAVING(Watercraft_Owner_Group,COUNT(ROWS(LEFT))>1),GROUP,Watercraft_Owner__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT W_Craft__Orphan := JOIN(InData(__NN(W_Craft_)),E_Watercraft(__cfg).__Result,__EEQP(LEFT.W_Craft_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT Owner__Orphan := JOIN(InData(__NN(Owner_)),E_Person(__cfg).__Result,__EEQP(LEFT.Owner_, RIGHT.UID),TRANSFORM(InLayout,SELF := LEFT,SELF:=[]),LEFT ONLY, HASH);
  EXPORT SanityCheck := DATASET([{COUNT(W_Craft__Orphan),COUNT(Owner__Orphan)}],{KEL.typ.int W_Craft__Orphan,KEL.typ.int Owner__Orphan});
  EXPORT NullCounts := DATASET([
    {'WatercraftOwner','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault','WCraft',COUNT(__d0(__NL(W_Craft_))),COUNT(__d0(__NN(W_Craft_)))},
    {'WatercraftOwner','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault','l_did',COUNT(__d0(__NL(Owner_))),COUNT(__d0(__NN(Owner_)))},
    {'WatercraftOwner','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'WatercraftOwner','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'WatercraftOwner','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'WatercraftOwner','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'WatercraftOwner','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'WatercraftOwner','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'WatercraftOwner','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault','WCraft',COUNT(__d1(__NL(W_Craft_))),COUNT(__d1(__NN(W_Craft_)))},
    {'WatercraftOwner','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault','did',COUNT(__d1(__NL(Owner_))),COUNT(__d1(__NN(Owner_)))},
    {'WatercraftOwner','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'WatercraftOwner','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'WatercraftOwner','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'WatercraftOwner','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'WatercraftOwner','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'WatercraftOwner','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'WatercraftOwner','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault','WCraft',COUNT(__d2(__NL(W_Craft_))),COUNT(__d2(__NN(W_Craft_)))},
    {'WatercraftOwner','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault','l_did',COUNT(__d2(__NL(Owner_))),COUNT(__d2(__NN(Owner_)))},
    {'WatercraftOwner','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'WatercraftOwner','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'WatercraftOwner','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'WatercraftOwner','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'WatercraftOwner','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'WatercraftOwner','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'WatercraftOwner','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault','WCraft',COUNT(__d3(__NL(W_Craft_))),COUNT(__d3(__NN(W_Craft_)))},
    {'WatercraftOwner','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault','did',COUNT(__d3(__NL(Owner_))),COUNT(__d3(__NN(Owner_)))},
    {'WatercraftOwner','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'WatercraftOwner','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'WatercraftOwner','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'WatercraftOwner','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'WatercraftOwner','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'WatercraftOwner','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
