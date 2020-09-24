IMPORT STD,SALT311;
EXPORT IngestContacts(BOOLEAN incremental=FALSE
, DATASET(Layouts.Base_Contacts) Delta = DATASET([],Layouts.Base_Contacts)
, DATASET(Layouts.Base_Contacts) dsBase 
, DATASET(RECORDOF(equifax_business_data.Layouts.Base_Contacts))  infile 
) := MODULE
  SHARED NullFile := DATASET([],Layouts.Base_Contacts); // Use to replace files you wish to remove
 
  SHARED FilesToIngest := infile;
  // Now need to discover which records are old / new / updated
  EXPORT RecordType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');
  SHARED WithRT := RECORD
    Layouts.Base_Contacts;
    __Tpe := RecordType.Unknown;
  END;
 
  // Base recs start out Old, Ingest recs start out New -- matched records will become Unchanged or Updated below
  SHARED FilesToIngest0 := PROJECT(FilesToIngest,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.New,SELF:=LEFT));
  SHARED Delta0 := PROJECT(Delta,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
  SHARED Base0 := PROJECT(dsBase,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
 
  SHARED WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
    SELF.dt_first_seen := MAP ( le.__Tpe = 0 OR (UNSIGNED)le.dt_first_seen = 0 => ri.dt_first_seen,
                     ri.__Tpe = 0 OR (UNSIGNED)ri.dt_first_seen = 0 => le.dt_first_seen,
                     (UNSIGNED)le.dt_first_seen < (UNSIGNED)ri.dt_first_seen => le.dt_first_seen, // Want the lowest non-zero value
                     ri.dt_first_seen);
    SELF.dt_last_seen := MAP ( le.__Tpe = 0 => ri.dt_last_seen,
                     ri.__Tpe = 0 => le.dt_last_seen,
                     (UNSIGNED)le.dt_last_seen < (UNSIGNED)ri.dt_last_seen => ri.dt_last_seen, // Want the highest value
                     le.dt_last_seen);
    SELF.dt_vendor_first_reported := MAP ( le.__Tpe = 0 OR (UNSIGNED)le.dt_vendor_first_reported = 0 => ri.dt_vendor_first_reported,
                     ri.__Tpe = 0 OR (UNSIGNED)ri.dt_vendor_first_reported = 0 => le.dt_vendor_first_reported,
                     (UNSIGNED)le.dt_vendor_first_reported < (UNSIGNED)ri.dt_vendor_first_reported => le.dt_vendor_first_reported, // Want the lowest non-zero value
                     ri.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := MAP ( le.__Tpe = 0 => ri.dt_vendor_last_reported,
                     ri.__Tpe = 0 => le.dt_vendor_last_reported,
                     (UNSIGNED)le.dt_vendor_last_reported < (UNSIGNED)ri.dt_vendor_last_reported => ri.dt_vendor_last_reported, // Want the highest value
                     le.dt_vendor_last_reported);
    SELF.process_date := ri.process_date; // Derived(NEW)
    SELF.record_type := ri.record_type; // Derived(NEW)
    __Tpe0 := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      SELF.dt_first_seen <> le.dt_first_seen OR SELF.dt_last_seen <> le.dt_last_seen OR SELF.dt_vendor_first_reported <> le.dt_vendor_first_reported OR SELF.dt_vendor_last_reported <> le.dt_vendor_last_reported => RecordType.Updated,
      RecordType.Unchanged);
    SELF.__Tpe := __Tpe0;
    SELF := le; // Take current version - noting update if needed
  END;
 
  // Ingest Files: Rollup to get unique new records
  DistIngest0 := DISTRIBUTE(FilesToIngest0, HASH32(EFX_ID,EFX_CONTCT,EFX_TITLECD
             ,EFX_TITLEDESC,EFX_LASTNAM,EFX_FSTNAM,EFX_EMAIL,EFX_DATE));
  SortIngest0 := SORT(DistIngest0,EFX_ID,EFX_CONTCT,EFX_TITLECD
             ,EFX_TITLEDESC,EFX_LASTNAM,EFX_FSTNAM,EFX_EMAIL,EFX_DATE, __Tpe, rcid, LOCAL);
  GroupIngest0 := GROUP(SortIngest0,EFX_ID,EFX_CONTCT,EFX_TITLECD
             ,EFX_TITLEDESC,EFX_LASTNAM,EFX_FSTNAM,EFX_EMAIL,EFX_DATE, LOCAL, ORDERED, STABLE);
  SHARED AllIngestRecs0 := UNGROUP(ROLLUP(GroupIngest0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Existing Base: combine delta with base file
  DistBase0 := DISTRIBUTE(Base0+Delta0, HASH32(EFX_ID,EFX_CONTCT,EFX_TITLECD
             ,EFX_TITLEDESC,EFX_LASTNAM,EFX_FSTNAM,EFX_EMAIL,EFX_DATE));
  SortBase0 := SORT(DistBase0,EFX_ID,EFX_CONTCT,EFX_TITLECD
             ,EFX_TITLEDESC,EFX_LASTNAM,EFX_FSTNAM,EFX_EMAIL,EFX_DATE, __Tpe, rcid, LOCAL);
  GroupBase0 := GROUP(SortBase0,EFX_ID,EFX_CONTCT,EFX_TITLECD
             ,EFX_TITLEDESC,EFX_LASTNAM,EFX_FSTNAM,EFX_EMAIL,EFX_DATE, LOCAL, ORDERED, STABLE);
  SHARED AllBaseRecs0 := UNGROUP(ROLLUP(GroupBase0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Everything: combine ingest and base recs
  Sort0 := SORT(AllBaseRecs0+AllIngestRecs0,EFX_ID,EFX_CONTCT,EFX_TITLECD
             ,EFX_TITLEDESC,EFX_LASTNAM,EFX_FSTNAM,EFX_EMAIL,EFX_DATE, __Tpe,rcid,LOCAL);
  Group0 := GROUP(Sort0,EFX_ID,EFX_CONTCT,EFX_TITLECD
             ,EFX_TITLEDESC,EFX_LASTNAM,EFX_FSTNAM,EFX_EMAIL,EFX_DATE,LOCAL, ORDERED, STABLE);
  SHARED AllRecs0 := UNGROUP(ROLLUP(Group0,TRUE,MergeData(LEFT,RIGHT)));
 
  //Now need to update 'rid' numbers on new records
  //Base upon SALT311.utMac_Sequence_Records
  // Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);
  PrevBase := MAX(ORe,rcid);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.rcid := IF ( le.rcid=0, PrevBase+1+thorlib.node(), le.rcid+thorlib.nodes() );
    SELF.seleid := SELF.rcid; // Default for an 'ADL' value is the 'RID' value
    SELF := ri;
  END;
  NR1 := ITERATE(NR(rcid=0),AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1+NR(rcid<>0) : PERSIST('~temp::seleid::Equifax_Business_Data::Ingest_Cache_Contacts',EXPIRE(Equifax_Business_Data.Config.PersistExpire));
  SHARED UpdateStatsFull := SORT(TABLE(AllRecs, {__Tpe,SALT311.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED UpdateStatsInc := SORT(UpdateStatsFull(__Tpe = RecordType.New), __Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStats := IF(incremental, UpdateStatsInc, UpdateStatsFull);
  SHARED S0 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));
 
  SHARED NoFlagsRec := WithRT;
  SHARED emptyDS := DATASET([], NoFlagsRec);
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New), NoFlagsRec);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,Layouts.Base_Contacts);
  EXPORT OldRecords :=PROJECT( AllRecs(__Tpe=RecordType.Old), NoFlagsRec);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,Layouts.Base_Contacts);
  EXPORT UpdatedRecords := PROJECT(AllRecs(__Tpe=RecordType.Updated), NoFlagsRec);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,Layouts.Base_Contacts);
  EXPORT AllRecords := IF(incremental, NewRecords, PROJECT(AllRecs, NoFlagsRec));
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,Layouts.Base_Contacts); // Records in 'pure' format
 
f := TABLE(dsBase,{rcid}) : GLOBAL;
rcid_clusters := SALT311.MOD_ClusterStats.Counts(f,rcid);
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
