IMPORT STD,SALT311;
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(Layout_Acquireweb_Business) Delta = DATASET([],Layout_Acquireweb_Business)
, DATASET(Layout_Acquireweb_Business) dsBase = In_Acquireweb_Business // Change IN_Acquireweb_Business to change input to ingest process
, DATASET(RECORDOF(Acquireweb_Plus.prep_business_ingest))  infile = Acquireweb_Plus.prep_business_ingest
) := MODULE
  SHARED NullFile := DATASET([],Layout_Acquireweb_Business); // Use to replace files you wish to remove
 
  SHARED FilesToIngest := infile;
  // Now need to discover which records are old / new / updated
  EXPORT RecordType := ENUM(UNSIGNED1,Unknown,Ancient,Old,Unchanged,Updated,New);
  EXPORT RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Ancient','Old','Unchanged','Updated','New','UNKNOWN');
  SHARED WithRT := RECORD
    Layout_Acquireweb_Business;
    __Tpe := RecordType.Unknown;
  END;
 
  // Base recs start out Old, Ingest recs start out New -- matched records will become Unchanged or Updated below
  SHARED FilesToIngest0 := PROJECT(FilesToIngest,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.New,SELF:=LEFT));
  SHARED Delta0 := PROJECT(Delta,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
  SHARED Base0 := PROJECT(dsBase,TRANSFORM(WithRT,SELF.__Tpe:=RecordType.Old,SELF:=LEFT));
 
  SHARED WithRT MergeData(WithRT le, WithRT ri) := TRANSFORM // Pick the data for the new record
    SELF.title := ri.title; // Derived(NEW)
    SELF.address1 := ri.address1; // Derived(NEW)
    SELF.address2 := ri.address2; // Derived(NEW)
    SELF.emailid := ri.emailid; // Derived(NEW)
    SELF.ipaddress := ri.ipaddress; // Derived(NEW)
    SELF.did := ri.did; // Derived(NEW)
    SELF.did_score := ri.did_score; // Derived(NEW)
    SELF.aid := ri.aid; // Derived(NEW)
    SELF.clean_title := ri.clean_title; // Derived(NEW)
    SELF.clean_fname := ri.clean_fname; // Derived(NEW)
    SELF.clean_mname := ri.clean_mname; // Derived(NEW)
    SELF.clean_lname := ri.clean_lname; // Derived(NEW)
    SELF.clean_name_suffix := ri.clean_name_suffix; // Derived(NEW)
    SELF.clean_cname := ri.clean_cname; // Derived(NEW)
    SELF.clean_prim_range := ri.clean_prim_range; // Derived(NEW)
    SELF.clean_predir := ri.clean_predir; // Derived(NEW)
    SELF.clean_prim_name := ri.clean_prim_name; // Derived(NEW)
    SELF.clean_addr_suffix := ri.clean_addr_suffix; // Derived(NEW)
    SELF.clean_postdir := ri.clean_postdir; // Derived(NEW)
    SELF.clean_unit_desig := ri.clean_unit_desig; // Derived(NEW)
    SELF.clean_sec_range := ri.clean_sec_range; // Derived(NEW)
    SELF.clean_p_city_name := ri.clean_p_city_name; // Derived(NEW)
    SELF.clean_v_city_name := ri.clean_v_city_name; // Derived(NEW)
    SELF.clean_st := ri.clean_st; // Derived(NEW)
    SELF.clean_zip := ri.clean_zip; // Derived(NEW)
    SELF.clean_zip4 := ri.clean_zip4; // Derived(NEW)
    SELF.clean_cart := ri.clean_cart; // Derived(NEW)
    SELF.clean_cr_sort_sz := ri.clean_cr_sort_sz; // Derived(NEW)
    SELF.clean_lot := ri.clean_lot; // Derived(NEW)
    SELF.clean_lot_order := ri.clean_lot_order; // Derived(NEW)
    SELF.clean_dbpc := ri.clean_dbpc; // Derived(NEW)
    SELF.clean_chk_digit := ri.clean_chk_digit; // Derived(NEW)
    SELF.clean_rec_type := ri.clean_rec_type; // Derived(NEW)
    SELF.clean_county := ri.clean_county; // Derived(NEW)
    SELF.clean_geo_lat := ri.clean_geo_lat; // Derived(NEW)
    SELF.clean_geo_long := ri.clean_geo_long; // Derived(NEW)
    SELF.clean_msa := ri.clean_msa; // Derived(NEW)
    SELF.clean_geo_blk := ri.clean_geo_blk; // Derived(NEW)
    SELF.clean_geo_match := ri.clean_geo_match; // Derived(NEW)
    SELF.clean_err_stat := ri.clean_err_stat; // Derived(NEW)
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
    SELF.current_rec := ri.current_rec; // Derived(NEW)
    SELF.source := ri.source; // Derived(NEW)
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
      SELF.date_first_seen <> le.date_first_seen OR SELF.date_last_seen <> le.date_last_seen OR SELF.date_vendor_first_reported <> le.date_vendor_first_reported OR SELF.date_vendor_last_reported <> le.date_vendor_last_reported => RecordType.Updated,
      RecordType.Unchanged);
    SELF.__Tpe := __Tpe0;
    SELF := le; // Take current version - noting update if needed
  END;
 
  // Ingest Files: Rollup to get unique new records
  DistIngest0 := DISTRIBUTE(FilesToIngest0, HASH32(awid,firstname,lastname,companyname,city,state
             ,zip,zip4,email));
  SortIngest0 := SORT(DistIngest0,awid,firstname,lastname,companyname,city,state
             ,zip,zip4,email, __Tpe, RCID, LOCAL);
  GroupIngest0 := GROUP(SortIngest0,awid,firstname,lastname,companyname,city,state
             ,zip,zip4,email, LOCAL, ORDERED, STABLE);
  SHARED AllIngestRecs0 := UNGROUP(ROLLUP(GroupIngest0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Existing Base: combine delta with base file
  DistBase0 := DISTRIBUTE(Base0+Delta0, HASH32(awid,firstname,lastname,companyname,city,state
             ,zip,zip4,email));
  SortBase0 := SORT(DistBase0,awid,firstname,lastname,companyname,city,state
             ,zip,zip4,email, __Tpe, RCID, LOCAL);
  GroupBase0 := GROUP(SortBase0,awid,firstname,lastname,companyname,city,state
             ,zip,zip4,email, LOCAL, ORDERED, STABLE);
  SHARED AllBaseRecs0 := UNGROUP(ROLLUP(GroupBase0,TRUE,MergeData(LEFT,RIGHT)));
 
  // Everything: combine ingest and base recs
  Sort0 := SORT(AllBaseRecs0+AllIngestRecs0,awid,firstname,lastname,companyname,city,state
             ,zip,zip4,email, __Tpe,RCID,LOCAL);
  Group0 := GROUP(Sort0,awid,firstname,lastname,companyname,city,state
             ,zip,zip4,email,LOCAL, ORDERED, STABLE);
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
  SHARED AllRecs := ORe+NR1+NR(RCID<>0) : PERSIST('~temp::Acquireweb_Plus::Ingest_Cache',EXPIRE(Acquireweb_Plus.Config.PersistExpire));
  SHARED UpdateStatsFull := SORT(TABLE(AllRecs, {__Tpe,SALT311.StrType INGESTSTATUS:=RTToText(AllRecs.__Tpe),UNSIGNED Cnt:=COUNT(GROUP)}, __Tpe, FEW),__Tpe, FEW);
  SHARED UpdateStatsInc := SORT(UpdateStatsFull(__Tpe = RecordType.New), __Tpe, INGESTSTATUS, FEW);
  EXPORT UpdateStats := IF(incremental, UpdateStatsInc, UpdateStatsFull);
  SHARED S0 := OUTPUT(UpdateStats, {{UpdateStats} AND NOT __Tpe}, ALL, NAMED('UpdateStats'));
 
  SHARED NoFlagsRec := WithRT;
  SHARED emptyDS := DATASET([], NoFlagsRec);
  EXPORT NewRecords := PROJECT(AllRecs(__Tpe=RecordType.New), NoFlagsRec);
  EXPORT NewRecords_NoTag := PROJECT(NewRecords,Layout_Acquireweb_Business);
  EXPORT OldRecords :=PROJECT( AllRecs(__Tpe=RecordType.Old), NoFlagsRec);
  EXPORT OldRecords_NoTag := PROJECT(OldRecords,Layout_Acquireweb_Business);
  EXPORT UpdatedRecords := PROJECT(AllRecs(__Tpe=RecordType.Updated), NoFlagsRec);
  EXPORT UpdatedRecords_NoTag := PROJECT(UpdatedRecords,Layout_Acquireweb_Business);
  EXPORT AllRecords := IF(incremental, NewRecords, PROJECT(AllRecs, NoFlagsRec));
  EXPORT AllRecords_NoTag := PROJECT(AllRecords,Layout_Acquireweb_Business); // Records in 'pure' format
 
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
