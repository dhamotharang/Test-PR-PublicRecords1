IMPORT STD,SALT311;
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(Layout_Tradeline_Base) Delta = DATASET([],Layout_Tradeline_Base)
, DATASET(Layout_Tradeline_Base) dsBase = In_Tradeline_Base // Change IN_Tradeline_Base to change input to ingest process
, DATASET(RECORDOF(Cortera_Tradeline.Prep_Ingest))  infile = Cortera_Tradeline.Prep_Ingest
) := MODULE
  SHARED NullFile := DATASET([],Layout_Tradeline_Base); // Use to replace files you wish to remove

  SHARED FilesToIngest := infile;
  // Now need to discover which records are old / new / updated
  EXPORT RecordType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');
  SHARED WithRT := RECORD
    Layout_Tradeline_Base;
    __Tpe := RecordType.Unknown;
  END;

  // Base recs start out Old, Ingest recs start out New -- matched records will become Unchanged or Updated below
  SHARED FilesToIngest0 := PROJECT(FilesToIngest,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.New,SELF:=LEFT));
  SHARED Delta0 := PROJECT(Delta,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
  SHARED Base0 := PROJECT(dsBase,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));

  SHARED WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
    SELF.dt_vendor_first_reported := MAP ( le.__Tpe = 0 OR (UNSIGNED)le.dt_vendor_first_reported = 0 => ri.dt_vendor_first_reported,
                     ri.__Tpe = 0 OR (UNSIGNED)ri.dt_vendor_first_reported = 0 => le.dt_vendor_first_reported,
                     (UNSIGNED)le.dt_vendor_first_reported < (UNSIGNED)ri.dt_vendor_first_reported => le.dt_vendor_first_reported, // Want the lowest non-zero value
                     ri.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := MAP ( le.__Tpe = 0 => ri.dt_vendor_last_reported,
                     ri.__Tpe = 0 => le.dt_vendor_last_reported,
                     (UNSIGNED)le.dt_vendor_last_reported < (UNSIGNED)ri.dt_vendor_last_reported => ri.dt_vendor_last_reported, // Want the highest value
                     le.dt_vendor_last_reported);
    __Tpe0 := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      SELF.dt_vendor_first_reported <> le.dt_vendor_first_reported OR SELF.dt_vendor_last_reported <> le.dt_vendor_last_reported => RecordType.Updated,
      RecordType.Unchanged);
    SELF.__Tpe := __Tpe0;
    SELF := le; // Take current version - noting update if needed
  END;

  // Ingest Files: Rollup to get unique new records
  DistIngest0 := DISTRIBUTE(FilesToIngest0, HASH32(link_id,account_key,ar_date,total_ar,status));
  SortIngest0 := SORT(DistIngest0,link_id,account_key,ar_date,total_ar,status, __Tpe, record_sid, LOCAL);
  GroupIngest0 := GROUP(SortIngest0,link_id,account_key,ar_date,total_ar,status, LOCAL, ORDERED, STABLE);
  SHARED AllIngestRecs0 := UNGROUP(ROLLUP(GroupIngest0,TRUE,MergeData(LEFT,RIGHT)));

  // Existing Base: combine delta with base file
  DistBase0 := DISTRIBUTE(Base0+Delta0, HASH32(link_id,account_key,ar_date,total_ar,status));
  SortBase0 := SORT(DistBase0,link_id,account_key,ar_date,total_ar,status, __Tpe, record_sid, LOCAL);
  GroupBase0 := GROUP(SortBase0,link_id,account_key,ar_date,total_ar,status, LOCAL, ORDERED, STABLE);
  SHARED AllBaseRecs0 := UNGROUP(ROLLUP(GroupBase0,TRUE,MergeData(LEFT,RIGHT)));

  // Everything: combine ingest and base recs
  Sort0 := SORT(AllBaseRecs0+AllIngestRecs0,link_id,account_key,ar_date,total_ar,status, __Tpe,record_sid,LOCAL);
  Group0 := GROUP(Sort0,link_id,account_key,ar_date,total_ar,status,LOCAL, ORDERED, STABLE);
  SHARED AllRecs0 := UNGROUP(ROLLUP(Group0,TRUE,MergeData(LEFT,RIGHT)));

  //Now need to update 'rid' numbers on new records
  //Base upon SALT311.utMac_Sequence_Records
  // Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);
  PrevBase := MAX(ORe,record_sid);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.record_sid := IF ( le.record_sid=0, PrevBase+1+thorlib.node(), le.record_sid+thorlib.nodes() );
    SELF := ri;
  END;
  NR1 := ITERATE(NR(record_sid=0),AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1+NR(record_sid<>0) : PERSIST('~temp::Cortera_Tradeline::Ingest_Cache',EXPIRE(Cortera_Tradeline.Config.PersistExpire));
  SHARED UpdateStatsFull := SORT(TABLE(AllRecs, {__Tpe,SALT311.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED UpdateStatsInc := SORT(UpdateStatsFull(__Tpe = RecordType.New), __Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStats := IF(incremental, UpdateStatsInc, UpdateStatsFull);
  SHARED S0 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));

  SHARED NoFlagsRec := WithRT;
  SHARED emptyDS := DATASET([], NoFlagsRec);
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New), NoFlagsRec);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,Layout_Tradeline_Base);
  EXPORT OldRecords :=PROJECT( AllRecs(__Tpe=RecordType.Old), NoFlagsRec);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,Layout_Tradeline_Base);
  EXPORT UpdatedRecords := PROJECT(AllRecs(__Tpe=RecordType.Updated), NoFlagsRec);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,Layout_Tradeline_Base);
  EXPORT AllRecords := IF(incremental, NewRecords, PROJECT(AllRecs, NoFlagsRec));
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,Layout_Tradeline_Base); // Records in 'pure' format

f := TABLE(dsBase,{record_sid}) : GLOBAL;
rcid_clusters := SALT311.MOD_ClusterStats.Counts(f,record_sid);
DuplicateRids0 := COUNT(dsBase) - SUM(rcid_clusters,NumberOfClusters); // Should be zero
d := DATASET([{DuplicateRids0}],{UNSIGNED2 DuplicateRids0});
EXPORT ValidityStats := OUTPUT(d,NAMED('ValidityStatistics'));
  EXPORT DoStats := S0;

  EXPORT StandardStats(BOOLEAN doInfileOverallCnt = TRUE, BOOLEAN doStatusOverallCnt = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    infileCntOverall := IF(doInfileOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileOverallCount(COUNT(FilesToIngest), 'Infile', myTimeStamp));
    basefileCntOverall := IF(doInfileOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileOverallCount(COUNT(dsBase), 'Basefile', myTimeStamp));
    deltaCntOverall := IF(doInfileOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestInfileOverallCount(COUNT(Delta), 'Deltafile', myTimeStamp));
    ingestStatusOverall := IF(doStatusOverallCnt, SALT311.mod_StandardStatsTransforms.MAC_ingestStatus(UpdateStats,, myTimeStamp));
    standardStats := infileCntOverall & basefileCntOverall & ingestStatusOverall;
    RETURN standardStats;
  END;
END;
