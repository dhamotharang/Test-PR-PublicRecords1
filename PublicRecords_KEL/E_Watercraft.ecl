//HPCC Systems KEL Compiler Version 1.5.0rc1
IMPORT KEL15 AS KEL;
IMPORT PublicRecords_KEL;
IMPORT CFG_Compile FROM PublicRecords_KEL;
IMPORT * FROM KEL15.Null;
EXPORT E_Watercraft(CFG_Compile __cfg = CFG_Compile) := MODULE
  EXPORT Typ := KEL.typ.uid;
  EXPORT InLayout := RECORD
    KEL.typ.nuid UID;
    KEL.typ.nstr Watercraft_Key_;
    KEL.typ.nstr Sequence_Key_;
    KEL.typ.nstr Origin_State_;
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
  SHARED __Mapping := 'UID(DEFAULT:UID),watercraftkey(DEFAULT:Watercraft_Key_:\'\'),sequencekey(DEFAULT:Sequence_Key_:\'\'),originstate(DEFAULT:Origin_State_:\'\'),source(DEFAULT:Source_:\'\'),archive_date(DEFAULT:Archive___Date_:EPOCH),datefirstseen(DEFAULT:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybridarchivedate(DEFAULT:Hybrid_Archive_Date_:EPOCH),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH)';
  SHARED __Trimmed := RECORD, MAXLENGTH(5000)
    STRING KeyVal;
  END;
  SHARED __d0_Trim := PROJECT(PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.watercraft_key)));
  SHARED __d1_Trim := PROJECT(PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.watercraft_key)));
  SHARED __d2_Trim := PROJECT(PublicRecords_KEL.Files.NonFCRA.Watercraft__Key_LinkIds_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.watercraft_key)));
  SHARED __d3_Trim := PROJECT(PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.watercraft_key)));
  SHARED __d4_Trim := PROJECT(PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault,TRANSFORM(__Trimmed,SELF.KeyVal:=TRIM((STRING)LEFT.watercraft_key)));
  EXPORT __All_Trim := __d0_Trim + __d1_Trim + __d2_Trim + __d3_Trim + __d4_Trim;
  SHARED __TabRec := RECORD, MAXLENGTH(5000)
    __All_Trim.KeyVal;
    UNSIGNED4 Cnt := COUNT(GROUP);
    KEL.typ.uid UID := 0;
  END;
  EXPORT NullKeyVal := TRIM((STRING)'');
  SHARED __Table := TABLE(__All_Trim(KeyVal <> NullKeyVal),__TabRec,KeyVal,MERGE);
  SHARED NullLookupRec := DATASET([{NullKeyVal,1,0}],__TabRec);
  EXPORT Lookup := NullLookupRec + PROJECT(__Table,TRANSFORM(__TabRec,SELF.UID:=COUNTER,SELF:=LEFT)) : PERSIST('~temp::KEL::PublicRecords_KEL::Watercraft::UidLookup',EXPIRE(7));
  EXPORT UID_IdToText := INDEX(Lookup,{UID},{Lookup},'~temp::KEL::IDtoT::PublicRecords_KEL::Watercraft');
  EXPORT UID_TextToId := INDEX(Lookup,{ht:=HASH32(KeyVal)},{Lookup},'~temp::KEL::TtoID::PublicRecords_KEL::Watercraft');
  EXPORT BuildAll := PARALLEL(BUILDINDEX(UID_IdToText,OVERWRITE),BUILDINDEX(UID_TextToId,OVERWRITE));
  EXPORT GetText(KEL.typ.uid i) := UID_IdToText(UID=i)[1];
  EXPORT GetId(STRING s) := UID_TextToId(ht=HASH32(s),KeyVal=s)[1];
  SHARED Hybrid_Archive_Date_0Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping0 := 'UID(DEFAULT:UID),watercraft_key(OVERRIDE:Watercraft_Key_:\'\'),sequence_key(OVERRIDE:Sequence_Key_:\'\'),state_origin(OVERRIDE:Origin_State_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_0Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d0_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d0_UID_Mapped := JOIN(PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault,Lookup,TRIM((STRING)LEFT.watercraft_key) = RIGHT.KeyVal,TRANSFORM(__d0_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_Watercraft__key_watercraft_did_Vault_Invalid := __d0_UID_Mapped(UID = 0);
  SHARED __d0_Prefiltered := __d0_UID_Mapped(UID <> 0);
  SHARED __d0 := __SourceFilter(KEL.FromFlat.Convert(__d0_Prefiltered,InLayout,__Mapping0,'PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault'));
  SHARED Hybrid_Archive_Date_1Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping1 := 'UID(DEFAULT:UID),watercraft_key(OVERRIDE:Watercraft_Key_:\'\'),sequence_key(OVERRIDE:Sequence_Key_:\'\'),state_origin(OVERRIDE:Origin_State_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_1Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d1_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d1_UID_Mapped := JOIN(PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault,Lookup,TRIM((STRING)LEFT.watercraft_key) = RIGHT.KeyVal,TRANSFORM(__d1_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_Watercraft__key_watercraft_sid_Vault_Invalid := __d1_UID_Mapped(UID = 0);
  SHARED __d1_Prefiltered := __d1_UID_Mapped(UID <> 0);
  SHARED __d1 := __SourceFilter(KEL.FromFlat.Convert(__d1_Prefiltered,InLayout,__Mapping1,'PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault'));
  SHARED Date_Last_Seen_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..8]))=>a[1..8],KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01',KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..4]+'0101'))=>a[1..4]+'0101','0');
  SHARED Hybrid_Archive_Date_2Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping2 := 'UID(DEFAULT:UID),watercraft_key(OVERRIDE:Watercraft_Key_:\'\'),sequence_key(OVERRIDE:Sequence_Key_:\'\'),state_origin(OVERRIDE:Origin_State_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH:Date_Last_Seen_2Rule),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_2Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d2_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.NonFCRA.Watercraft__Key_LinkIds_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d2_UID_Mapped := JOIN(PublicRecords_KEL.Files.NonFCRA.Watercraft__Key_LinkIds_Vault,Lookup,TRIM((STRING)LEFT.watercraft_key) = RIGHT.KeyVal,TRANSFORM(__d2_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_NonFCRA_Watercraft__Key_LinkIds_Vault_Invalid := __d2_UID_Mapped(UID = 0);
  SHARED __d2_Prefiltered := __d2_UID_Mapped(UID <> 0);
  SHARED __d2 := __SourceFilter(KEL.FromFlat.Convert(__d2_Prefiltered,InLayout,__Mapping2,'PublicRecords_KEL.Files.NonFCRA.Watercraft__Key_LinkIds_Vault'));
  SHARED Hybrid_Archive_Date_3Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping3 := 'UID(DEFAULT:UID),watercraft_key(OVERRIDE:Watercraft_Key_:\'\'),sequence_key(OVERRIDE:Sequence_Key_:\'\'),state_origin(OVERRIDE:Origin_State_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),datelastseen(DEFAULT:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_3Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d3_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d3_UID_Mapped := JOIN(PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault,Lookup,TRIM((STRING)LEFT.watercraft_key) = RIGHT.KeyVal,TRANSFORM(__d3_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_FCRA_Watercraft__key_watercraft_did_Vault_Invalid := __d3_UID_Mapped(UID = 0);
  SHARED __d3_Prefiltered := __d3_UID_Mapped(UID <> 0);
  SHARED __d3 := __SourceFilter(KEL.FromFlat.Convert(__d3_Prefiltered,InLayout,__Mapping3,'PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault'));
  SHARED Hybrid_Archive_Date_4Rule(STRING a) := MAP(KEL.Routines.IsValidDate((KEL.typ.kdate)(a[1..6]+'01'))=>a[1..6]+'01','0');
  SHARED __Mapping4 := 'UID(DEFAULT:UID),watercraft_key(OVERRIDE:Watercraft_Key_:\'\'),sequence_key(OVERRIDE:Sequence_Key_:\'\'),state_origin(OVERRIDE:Origin_State_:\'\'),src(OVERRIDE:Source_:\'\'),archive_date(OVERRIDE:Archive___Date_:EPOCH),date_first_seen(OVERRIDE:Date_First_Seen_:EPOCH),date_last_seen(OVERRIDE:Date_Last_Seen_:EPOCH),hybrid_archive_date(OVERRIDE:Hybrid_Archive_Date_:EPOCH:Hybrid_Archive_Date_4Rule),vaultdatelastseen(DEFAULT:Vault_Date_Last_Seen_:EPOCH),DPMBitmap(OVERRIDE:__Permits:PERMITS)';
  SHARED __d4_Out := RECORD
    RECORDOF(PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault);
    KEL.typ.uid UID := 0;
  END;
  SHARED __d4_UID_Mapped := JOIN(PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault,Lookup,TRIM((STRING)LEFT.watercraft_key) = RIGHT.KeyVal,TRANSFORM(__d4_Out,SELF.UID:=RIGHT.UID,SELF:=LEFT),SMART);
  EXPORT PublicRecords_KEL_Files_FCRA_Watercraft__key_watercraft_sid_Vault_Invalid := __d4_UID_Mapped(UID = 0);
  SHARED __d4_Prefiltered := __d4_UID_Mapped(UID <> 0);
  SHARED __d4 := __SourceFilter(KEL.FromFlat.Convert(__d4_Prefiltered,InLayout,__Mapping4,'PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault'));
  EXPORT InData := __d0 + __d1 + __d2 + __d3 + __d4;
  EXPORT Origin_States_Layout := RECORD
    KEL.typ.nstr Origin_State_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
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
    KEL.typ.nuid UID;
    KEL.typ.nstr Watercraft_Key_;
    KEL.typ.nstr Sequence_Key_;
    KEL.typ.ndataset(Origin_States_Layout) Origin_States_;
    KEL.typ.ndataset(Data_Sources_Layout) Data_Sources_;
    KEL.typ.epoch Archive___Date_ := 0;
    KEL.typ.epoch Date_First_Seen_ := 0;
    KEL.typ.epoch Date_Last_Seen_ := 0;
    KEL.typ.epoch Hybrid_Archive_Date_ := 0;
    KEL.typ.epoch Vault_Date_Last_Seen_ := 0;
    KEL.typ.int __RecordCount := 0;
  END;
  EXPORT __PostFilter := __GroupedFilter(GROUP(DISTRIBUTE(InData,HASH(UID)),UID,LOCAL,ALL));
  Watercraft_Group := __PostFilter;
  Layout Watercraft__Rollup(InLayout __r, DATASET(InLayout) __recs) := TRANSFORM
    SELF.Watercraft_Key_ := KEL.Intake.SingleValue(__recs,Watercraft_Key_);
    SELF.Sequence_Key_ := KEL.Intake.SingleValue(__recs,Sequence_Key_);
    SELF.Origin_States_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Origin_State_},Origin_State_),Origin_States_Layout)(__NN(Origin_State_)));
    SELF.Data_Sources_ := __CN(PROJECT(TABLE(__recs,{KEL.typ.int __RecordCount := COUNT(GROUP),KEL.typ.epoch Archive___Date_ := KEL.era.SimpleRoll(GROUP,Archive___Date_,MIN,FALSE),KEL.typ.epoch Date_First_Seen_ := KEL.era.SimpleRoll(GROUP,Date_First_Seen_,MIN,FALSE),KEL.typ.epoch Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Date_Last_Seen_,MAX,FALSE),KEL.typ.epoch Hybrid_Archive_Date_ := KEL.era.SimpleRoll(GROUP,Hybrid_Archive_Date_,MIN,FALSE),KEL.typ.epoch Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(GROUP,Vault_Date_Last_Seen_,MAX,NMAX),Source_},Source_),Data_Sources_Layout)(__NN(Source_)));
    SELF.__RecordCount := COUNT(__recs);
    SELF.Archive___Date_ := KEL.era.SimpleRoll(__recs,Archive___Date_,MIN,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRoll(__recs,Date_First_Seen_,MIN,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Date_Last_Seen_,MAX,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRoll(__recs,Hybrid_Archive_Date_,MIN,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRoll(__recs,Vault_Date_Last_Seen_,MAX,NMAX);
    SELF := __r;
  END;
  Layout Watercraft__Single_Rollup(InLayout __r) := TRANSFORM
    SELF.Origin_States_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Origin_States_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Origin_State_)));
    SELF.Data_Sources_ := __CN(PROJECT(DATASET(__r),TRANSFORM(Data_Sources_Layout,SELF.__RecordCount:=1;,SELF.Archive___Date_:=KEL.era.SimpleRollSingleRow(LEFT,Archive___Date_,FALSE),SELF.Date_First_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_First_Seen_,FALSE),SELF.Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Date_Last_Seen_,FALSE),SELF.Hybrid_Archive_Date_:=KEL.era.SimpleRollSingleRow(LEFT,Hybrid_Archive_Date_,FALSE),SELF.Vault_Date_Last_Seen_:=KEL.era.SimpleRollSingleRow(LEFT,Vault_Date_Last_Seen_,NMAX),SELF:=LEFT))(__NN(Source_)));
    SELF.__RecordCount := 1;
    SELF.Archive___Date_ := KEL.era.SimpleRollSingleRow(__r,Archive___Date_,FALSE);
    SELF.Date_First_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_First_Seen_,FALSE);
    SELF.Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Date_Last_Seen_,FALSE);
    SELF.Hybrid_Archive_Date_ := KEL.era.SimpleRollSingleRow(__r,Hybrid_Archive_Date_,FALSE);
    SELF.Vault_Date_Last_Seen_ := KEL.era.SimpleRollSingleRow(__r,Vault_Date_Last_Seen_,NMAX);
    SELF := __r;
  END;
  EXPORT __PreResult := ROLLUP(HAVING(Watercraft_Group,COUNT(ROWS(LEFT))=1),GROUP,Watercraft__Single_Rollup(LEFT)) + ROLLUP(HAVING(Watercraft_Group,COUNT(ROWS(LEFT))>1),GROUP,Watercraft__Rollup(LEFT, ROWS(LEFT)));
  EXPORT __Result := __CLEARFLAGS(__PreResult);
  EXPORT Result := __UNWRAP(__Result);
  EXPORT UIDSourceCounts := Lookup;
  EXPORT TopSourcedUIDs(KEL.typ.int n = 10) := TOPN(UIDSourceCounts,n,-Cnt);
  EXPORT UIDSourceDistribution := SORT(TABLE(UIDSourceCounts,{Cnt,KEL.typ.int uidCount := COUNT(GROUP),KEL.typ.uid rep := MIN(GROUP,UID)},Cnt),-Cnt);
  EXPORT Watercraft_Key__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Watercraft_Key_);
  EXPORT Sequence_Key__SingleValue_Invalid := KEL.Intake.DetectMultipleValuesOnResult(Result,Sequence_Key_);
  EXPORT SanityCheck := DATASET([{COUNT(PublicRecords_KEL_Files_NonFCRA_Watercraft__key_watercraft_did_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_Watercraft__key_watercraft_sid_Vault_Invalid),COUNT(PublicRecords_KEL_Files_NonFCRA_Watercraft__Key_LinkIds_Vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_Watercraft__key_watercraft_did_Vault_Invalid),COUNT(PublicRecords_KEL_Files_FCRA_Watercraft__key_watercraft_sid_Vault_Invalid),COUNT(Watercraft_Key__SingleValue_Invalid),COUNT(Sequence_Key__SingleValue_Invalid),TopSourcedUIDs(1)}],{KEL.typ.int PublicRecords_KEL_Files_NonFCRA_Watercraft__key_watercraft_did_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_Watercraft__key_watercraft_sid_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_NonFCRA_Watercraft__Key_LinkIds_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_Watercraft__key_watercraft_did_Vault_Invalid,KEL.typ.int PublicRecords_KEL_Files_FCRA_Watercraft__key_watercraft_sid_Vault_Invalid,KEL.typ.int Watercraft_Key__SingleValue_Invalid,KEL.typ.int Sequence_Key__SingleValue_Invalid,DATASET(RECORDOF(UIDSourceCounts)) topSourcedUID});
  EXPORT NullCounts := DATASET([
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_Watercraft__key_watercraft_did_Vault_Invalid),COUNT(__d0)},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault','watercraft_key',COUNT(__d0(__NL(Watercraft_Key_))),COUNT(__d0(__NN(Watercraft_Key_)))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault','sequence_key',COUNT(__d0(__NL(Sequence_Key_))),COUNT(__d0(__NN(Sequence_Key_)))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault','state_origin',COUNT(__d0(__NL(Origin_State_))),COUNT(__d0(__NN(Origin_State_)))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault','src',COUNT(__d0(__NL(Source_))),COUNT(__d0(__NN(Source_)))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault','Archive_Date',COUNT(__d0(Archive___Date_=0)),COUNT(__d0(Archive___Date_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault','DateFirstSeen',COUNT(__d0(Date_First_Seen_=0)),COUNT(__d0(Date_First_Seen_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault','DateLastSeen',COUNT(__d0(Date_Last_Seen_=0)),COUNT(__d0(Date_Last_Seen_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault','HybridArchiveDate',COUNT(__d0(Hybrid_Archive_Date_=0)),COUNT(__d0(Hybrid_Archive_Date_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_did_Vault','VaultDateLastSeen',COUNT(__d0(Vault_Date_Last_Seen_=0)),COUNT(__d0(Vault_Date_Last_Seen_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_Watercraft__key_watercraft_sid_Vault_Invalid),COUNT(__d1)},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault','watercraft_key',COUNT(__d1(__NL(Watercraft_Key_))),COUNT(__d1(__NN(Watercraft_Key_)))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault','sequence_key',COUNT(__d1(__NL(Sequence_Key_))),COUNT(__d1(__NN(Sequence_Key_)))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault','state_origin',COUNT(__d1(__NL(Origin_State_))),COUNT(__d1(__NN(Origin_State_)))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault','src',COUNT(__d1(__NL(Source_))),COUNT(__d1(__NN(Source_)))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault','Archive_Date',COUNT(__d1(Archive___Date_=0)),COUNT(__d1(Archive___Date_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault','DateFirstSeen',COUNT(__d1(Date_First_Seen_=0)),COUNT(__d1(Date_First_Seen_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault','DateLastSeen',COUNT(__d1(Date_Last_Seen_=0)),COUNT(__d1(Date_Last_Seen_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault','HybridArchiveDate',COUNT(__d1(Hybrid_Archive_Date_=0)),COUNT(__d1(Hybrid_Archive_Date_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__key_watercraft_sid_Vault','VaultDateLastSeen',COUNT(__d1(Vault_Date_Last_Seen_=0)),COUNT(__d1(Vault_Date_Last_Seen_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__Key_LinkIds_Vault','UID',COUNT(PublicRecords_KEL_Files_NonFCRA_Watercraft__Key_LinkIds_Vault_Invalid),COUNT(__d2)},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__Key_LinkIds_Vault','watercraft_key',COUNT(__d2(__NL(Watercraft_Key_))),COUNT(__d2(__NN(Watercraft_Key_)))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__Key_LinkIds_Vault','sequence_key',COUNT(__d2(__NL(Sequence_Key_))),COUNT(__d2(__NN(Sequence_Key_)))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__Key_LinkIds_Vault','state_origin',COUNT(__d2(__NL(Origin_State_))),COUNT(__d2(__NN(Origin_State_)))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__Key_LinkIds_Vault','src',COUNT(__d2(__NL(Source_))),COUNT(__d2(__NN(Source_)))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__Key_LinkIds_Vault','Archive_Date',COUNT(__d2(Archive___Date_=0)),COUNT(__d2(Archive___Date_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__Key_LinkIds_Vault','DateFirstSeen',COUNT(__d2(Date_First_Seen_=0)),COUNT(__d2(Date_First_Seen_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__Key_LinkIds_Vault','DateLastSeen',COUNT(__d2(Date_Last_Seen_=0)),COUNT(__d2(Date_Last_Seen_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__Key_LinkIds_Vault','HybridArchiveDate',COUNT(__d2(Hybrid_Archive_Date_=0)),COUNT(__d2(Hybrid_Archive_Date_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.NonFCRA.Watercraft__Key_LinkIds_Vault','VaultDateLastSeen',COUNT(__d2(Vault_Date_Last_Seen_=0)),COUNT(__d2(Vault_Date_Last_Seen_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_Watercraft__key_watercraft_did_Vault_Invalid),COUNT(__d3)},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault','watercraft_key',COUNT(__d3(__NL(Watercraft_Key_))),COUNT(__d3(__NN(Watercraft_Key_)))},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault','sequence_key',COUNT(__d3(__NL(Sequence_Key_))),COUNT(__d3(__NN(Sequence_Key_)))},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault','state_origin',COUNT(__d3(__NL(Origin_State_))),COUNT(__d3(__NN(Origin_State_)))},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault','src',COUNT(__d3(__NL(Source_))),COUNT(__d3(__NN(Source_)))},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault','Archive_Date',COUNT(__d3(Archive___Date_=0)),COUNT(__d3(Archive___Date_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault','DateFirstSeen',COUNT(__d3(Date_First_Seen_=0)),COUNT(__d3(Date_First_Seen_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault','DateLastSeen',COUNT(__d3(Date_Last_Seen_=0)),COUNT(__d3(Date_Last_Seen_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault','HybridArchiveDate',COUNT(__d3(Hybrid_Archive_Date_=0)),COUNT(__d3(Hybrid_Archive_Date_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_did_Vault','VaultDateLastSeen',COUNT(__d3(Vault_Date_Last_Seen_=0)),COUNT(__d3(Vault_Date_Last_Seen_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault','UID',COUNT(PublicRecords_KEL_Files_FCRA_Watercraft__key_watercraft_sid_Vault_Invalid),COUNT(__d4)},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault','watercraft_key',COUNT(__d4(__NL(Watercraft_Key_))),COUNT(__d4(__NN(Watercraft_Key_)))},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault','sequence_key',COUNT(__d4(__NL(Sequence_Key_))),COUNT(__d4(__NN(Sequence_Key_)))},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault','state_origin',COUNT(__d4(__NL(Origin_State_))),COUNT(__d4(__NN(Origin_State_)))},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault','src',COUNT(__d4(__NL(Source_))),COUNT(__d4(__NN(Source_)))},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault','Archive_Date',COUNT(__d4(Archive___Date_=0)),COUNT(__d4(Archive___Date_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault','DateFirstSeen',COUNT(__d4(Date_First_Seen_=0)),COUNT(__d4(Date_First_Seen_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault','DateLastSeen',COUNT(__d4(Date_Last_Seen_=0)),COUNT(__d4(Date_Last_Seen_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault','HybridArchiveDate',COUNT(__d4(Hybrid_Archive_Date_=0)),COUNT(__d4(Hybrid_Archive_Date_!=0))},
    {'Watercraft','PublicRecords_KEL.Files.FCRA.Watercraft__key_watercraft_sid_Vault','VaultDateLastSeen',COUNT(__d4(Vault_Date_Last_Seen_=0)),COUNT(__d4(Vault_Date_Last_Seen_!=0))}]
  ,{KEL.typ.str entity,KEL.typ.str fileName,KEL.typ.str fieldName,KEL.typ.int nullCount,KEL.typ.int notNullCount});
END;
