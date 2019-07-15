IMPORT STD,SALT311;
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(Layout_RealSource) Delta = DATASET([],Layout_RealSource)
, DATASET(Layout_RealSource) dsBase = In_RealSource // Change IN_RealSource to change input to ingest process
, DATASET(RECORDOF(RealSource.prep_ingest_file))  infile = RealSource.prep_ingest_file
) := MODULE
  SHARED NullFile := DATASET([],Layout_RealSource); // Use to replace files you wish to remove
 
  SHARED FilesToIngest := infile;
  // Now need to discover which records are old / new / updated
  EXPORT RecordType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');
  SHARED WithRT := RECORD
    Layout_RealSource;
    __Tpe := RecordType.Unknown;
  END;
 
  // Base recs start out Old, Ingest recs start out New -- matched records will become Unchanged or Updated below
  SHARED FilesToIngest0 := PROJECT(FilesToIngest,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.New,SELF:=LEFT));
  SHARED Delta0 := PROJECT(Delta,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
  SHARED Base0 := PROJECT(dsBase,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
 
  SHARED WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
    SELF.suffix := ri.suffix; // Derived(NEW)
    SELF.address := ri.address; // Derived(NEW)
    SELF.phone := ri.phone; // Derived(NEW)
    SELF.ipaddr := ri.ipaddr; // Derived(NEW)
    SELF.datestamp := ri.datestamp; // Derived(NEW)
    SELF.persistent_record_id := ri.persistent_record_id; // Derived(NEW)
    SELF.did := ri.did; // Derived(NEW)
    SELF.did_score := ri.did_score; // Derived(NEW)
    SELF.clean_title := ri.clean_title; // Derived(NEW)
    SELF.clean_fname := ri.clean_fname; // Derived(NEW)
    SELF.clean_mname := ri.clean_mname; // Derived(NEW)
    SELF.clean_lname := ri.clean_lname; // Derived(NEW)
    SELF.clean_name_suffix := ri.clean_name_suffix; // Derived(NEW)
    SELF.clean_name_score := ri.clean_name_score; // Derived(NEW)
    SELF.rawaid := ri.rawaid; // Derived(NEW)
    SELF.append_prep_address_situs := ri.append_prep_address_situs; // Derived(NEW)
    SELF.append_prep_address_last_situs := ri.append_prep_address_last_situs; // Derived(NEW)
    SELF.prim_range := ri.prim_range; // Derived(NEW)
    SELF.predir := ri.predir; // Derived(NEW)
    SELF.prim_name := ri.prim_name; // Derived(NEW)
    SELF.addr_suffix := ri.addr_suffix; // Derived(NEW)
    SELF.postdir := ri.postdir; // Derived(NEW)
    SELF.unit_desig := ri.unit_desig; // Derived(NEW)
    SELF.sec_range := ri.sec_range; // Derived(NEW)
    SELF.p_city_name := ri.p_city_name; // Derived(NEW)
    SELF.v_city_name := ri.v_city_name; // Derived(NEW)
    SELF.st := ri.st; // Derived(NEW)
    SELF.zip := ri.zip; // Derived(NEW)
    SELF.zip4 := ri.zip4; // Derived(NEW)
    SELF.cart := ri.cart; // Derived(NEW)
    SELF.cr_sort_sz := ri.cr_sort_sz; // Derived(NEW)
    SELF.lot := ri.lot; // Derived(NEW)
    SELF.lot_order := ri.lot_order; // Derived(NEW)
    SELF.dbpc := ri.dbpc; // Derived(NEW)
    SELF.chk_digit := ri.chk_digit; // Derived(NEW)
    SELF.rec_type := ri.rec_type; // Derived(NEW)
    SELF.county := ri.county; // Derived(NEW)
    SELF.geo_lat := ri.geo_lat; // Derived(NEW)
    SELF.geo_long := ri.geo_long; // Derived(NEW)
    SELF.msa := ri.msa; // Derived(NEW)
    SELF.geo_blk := ri.geo_blk; // Derived(NEW)
    SELF.geo_match := ri.geo_match; // Derived(NEW)
    SELF.err_stat := ri.err_stat; // Derived(NEW)
    SELF.process_date := MAP ( le.__Tpe = 0 => ri.process_date,
                     ri.__Tpe = 0 => le.process_date,
                     (UNSIGNED)le.process_date < (UNSIGNED)ri.process_date => ri.process_date, // Want the highest value
                     le.process_date);
    SELF.date_first_seen := MAP ( le.__Tpe = 0 OR (UNSIGNED)le.date_first_seen = 0 => ri.date_first_seen,
                     ri.__Tpe = 0 OR (UNSIGNED)ri.date_first_seen = 0 => le.date_first_seen,
                     (UNSIGNED)le.date_first_seen < (UNSIGNED)ri.date_first_seen => le.date_first_seen, // Want the lowest non-zero value
                     ri.date_first_seen);
    SELF.date_last_seen := MAP ( le.__Tpe = 0 => ri.date_last_seen,
                     ri.__Tpe = 0 => le.date_last_seen,
                     (UNSIGNED)le.date_last_seen < (UNSIGNED)ri.date_last_seen => ri.date_last_seen, // Want the highest value
                     le.date_last_seen);
    SELF.date_vendor_first_reported := MAP ( le.__Tpe = 0 OR (UNSIGNED)le.date_vendor_first_reported = 0 => ri.date_vendor_first_reported,
                     ri.__Tpe = 0 OR (UNSIGNED)ri.date_vendor_first_reported = 0 => le.date_vendor_first_reported,
                     (UNSIGNED)le.date_vendor_first_reported < (UNSIGNED)ri.date_vendor_first_reported => le.date_vendor_first_reported, // Want the lowest non-zero value
                     ri.date_vendor_first_reported);
    SELF.date_vendor_last_reported := MAP ( le.__Tpe = 0 => ri.date_vendor_last_reported,
                     ri.__Tpe = 0 => le.date_vendor_last_reported,
                     (UNSIGNED)le.date_vendor_last_reported < (UNSIGNED)ri.date_vendor_last_reported => ri.date_vendor_last_reported, // Want the highest value
                     le.date_vendor_last_reported);
    SELF.clean_cname := ri.clean_cname; // Derived(NEW)
    SELF.current_rec := ri.current_rec; // Derived(NEW)
    SELF.dotid := ri.dotid; // Derived(NEW)
    SELF.dotscore := ri.dotscore; // Derived(NEW)
    SELF.dotweight := ri.dotweight; // Derived(NEW)
    SELF.empid := ri.empid; // Derived(NEW)
    SELF.empscore := ri.empscore; // Derived(NEW)
    SELF.empweight := ri.empweight; // Derived(NEW)
    SELF.powid := ri.powid; // Derived(NEW)
    SELF.powscore := ri.powscore; // Derived(NEW)
    SELF.powweight := ri.powweight; // Derived(NEW)
    SELF.proxid := ri.proxid; // Derived(NEW)
    SELF.proxscore := ri.proxscore; // Derived(NEW)
    SELF.proxweight := ri.proxweight; // Derived(NEW)
    SELF.seleid := ri.seleid; // Derived(NEW)
    SELF.selescore := ri.selescore; // Derived(NEW)
    SELF.seleweight := ri.seleweight; // Derived(NEW)
    SELF.orgid := ri.orgid; // Derived(NEW)
    SELF.orgscore := ri.orgscore; // Derived(NEW)
    SELF.orgweight := ri.orgweight; // Derived(NEW)
    SELF.ultid := ri.ultid; // Derived(NEW)
    SELF.ultscore := ri.ultscore; // Derived(NEW)
    SELF.ultweight := ri.ultweight; // Derived(NEW)
    __Tpe0 := MAP (
      le.__Tpe = 0 => ri.__Tpe,
      le.__Tpe = RecordType.Updated OR ri.__Tpe = 0 OR ri.__Tpe = le.__Tpe => le.__Tpe,
      SELF.process_date <> le.process_date OR SELF.date_first_seen <> le.date_first_seen OR SELF.date_last_seen <> le.date_last_seen OR SELF.date_vendor_first_reported <> le.date_vendor_first_reported OR SELF.date_vendor_last_reported <> le.date_vendor_last_reported => RecordType.Updated,
      RecordType.Unchanged);
    SELF.__Tpe := __Tpe0;
    SELF := le; // Take current version - noting update if needed
  END;
 
  // Ingest Files: Rollup to get unique new records
  DistIngest0 := DISTRIBUTE(FilesToIngest0, HASH32(firstname,middleinit,lastname,city,state,ZipCode,ZipPlus4,dob,email,url));
  SortIngest0 := SORT(DistIngest0,firstname,middleinit,lastname,city,state,ZipCode,ZipPlus4,dob,email,url, __Tpe, RCID, LOCAL);
  GroupIngest0 := GROUP(SortIngest0,firstname,middleinit,lastname,city,state,ZipCode,ZipPlus4,dob,email,url, LOCAL, ORDERED, STABLE);
  SHARED AllIngestRecs0 := UNGROUP(ROLLUP(GroupIngest0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Existing Base: combine delta with base file
  DistBase0 := DISTRIBUTE(Base0+Delta0, HASH32(firstname,middleinit,lastname,city,state,ZipCode,ZipPlus4,dob,email,url));
  SortBase0 := SORT(DistBase0,firstname,middleinit,lastname,city,state,ZipCode,ZipPlus4,dob,email,url, __Tpe, RCID, LOCAL);
  GroupBase0 := GROUP(SortBase0,firstname,middleinit,lastname,city,state,ZipCode,ZipPlus4,dob,email,url, LOCAL, ORDERED, STABLE);
  SHARED AllBaseRecs0 := UNGROUP(ROLLUP(GroupBase0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Everything: combine ingest and base recs
  Sort0 := SORT(AllBaseRecs0+AllIngestRecs0,firstname,middleinit,lastname,city,state,ZipCode,ZipPlus4,dob,email,url, __Tpe,RCID,LOCAL);
  Group0 := GROUP(Sort0,firstname,middleinit,lastname,city,state,ZipCode,ZipPlus4,dob,email,url,LOCAL, ORDERED, STABLE);
  SHARED AllRecs0 := UNGROUP(ROLLUP(Group0,TRUE,MergeData(LEFT,RIGHT)));
 
  //Now need to update 'rid' numbers on new records
  //Base upon SALT311.utMac_Sequence_Records
  // Do not use PROJECT,COUNTER because it is very slow if any of the fields are not fixed length
  NR := AllRecs0(__Tpe=RecordType.New);
  ORe := AllRecs0(__Tpe<>RecordType.New);
  PrevBase := MAX(ORe,RCID);
  WithRT AddNewRid(WithRT le, WithRT ri) := TRANSFORM
    SELF.RCID := IF ( le.RCID=0, PrevBase+1+thorlib.node(), le.RCID+thorlib.nodes() );
    SELF := ri;
  END;
  NR1 := ITERATE(NR(RCID=0),AddNewRid(LEFT,RIGHT),LOCAL);
  SHARED AllRecs := ORe+NR1+NR(RCID<>0) : PERSIST('~temp::RealSource::Ingest_Cache',EXPIRE(RealSource.Config.PersistExpire));
  SHARED UpdateStatsFull := SORT(TABLE(AllRecs, {__Tpe,SALT311.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED UpdateStatsInc := SORT(UpdateStatsFull(__Tpe = RecordType.New), __Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStats := IF(incremental, UpdateStatsInc, UpdateStatsFull);
  SHARED S0 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));
 
  SHARED NoFlagsRec := WithRT;
  SHARED emptyDS := DATASET([], NoFlagsRec);
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New), NoFlagsRec);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,Layout_RealSource);
  EXPORT OldRecords :=PROJECT( AllRecs(__Tpe=RecordType.Old), NoFlagsRec);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,Layout_RealSource);
  EXPORT UpdatedRecords := PROJECT(AllRecs(__Tpe=RecordType.Updated), NoFlagsRec);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,Layout_RealSource);
  EXPORT AllRecords := IF(incremental, NewRecords, PROJECT(AllRecs, NoFlagsRec));
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,Layout_RealSource); // Records in 'pure' format
 
f := TABLE(dsBase,{RCID}) : GLOBAL;
rcid_clusters := SALT311.MOD_ClusterStats.Counts(f,RCID);
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
