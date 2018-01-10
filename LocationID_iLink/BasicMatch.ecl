IMPORT SALT37;
EXPORT BasicMatch(DATASET(layout_LocationId) ih) := MODULE// An extremely tight pre-match designed to quickly eliminate high volume duplicates
 
SHARED  h00 := LocationId_iLink.Specificities(ih).input_file;
  SHARED s := Specificities(ih).specificities[1];
  SHARED h00_match := h00((prim_range NOT IN SET(s.nulls_prim_range,prim_range) AND prim_range <> (TYPEOF(prim_range))''),(v_city_name NOT IN SET(s.nulls_v_city_name,v_city_name) AND v_city_name <> (TYPEOF(v_city_name))''),(st NOT IN SET(s.nulls_st,st) AND st <> (TYPEOF(st))''),(zip5 NOT IN SET(s.nulls_zip5,zip5) AND zip5 <> (TYPEOF(zip5))''),((cntprimname NOT IN SET(s.nulls_cntprimname,cntprimname) AND cntprimname <> (TYPEOF(cntprimname))'') OR (prim_name NOT IN SET(s.nulls_prim_name,prim_name) AND prim_name <> (TYPEOF(prim_name))'')), 
      0 + IF( (prim_range  IN SET(s.nulls_prim_range,prim_range) OR prim_range = (TYPEOF(prim_range))''), 0, 13 ) + IF( (predir  IN SET(s.nulls_predir,predir) OR predir = (TYPEOF(predir))''), 0, 7 ) + IF( (prim_name  IN SET(s.nulls_prim_name,prim_name) OR prim_name = (TYPEOF(prim_name))''), 0, 14 ) + IF( (addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) OR addr_suffix = (TYPEOF(addr_suffix))''), 0, 4 ) + IF( (postdir  IN SET(s.nulls_postdir,postdir) OR postdir = (TYPEOF(postdir))''), 0, 6 ) + IF( (sec_range  IN SET(s.nulls_sec_range,sec_range) OR sec_range = (TYPEOF(sec_range))''), 0, 14 ) + IF( (v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR v_city_name = (TYPEOF(v_city_name))''), 0, 7 ) + IF( (st  IN SET(s.nulls_st,st) OR st = (TYPEOF(st))''), 0, 1 ) + IF( (zip5  IN SET(s.nulls_zip5,zip5) OR zip5 = (TYPEOF(zip5))''), 0, 9 ) + IF( (err_stat  IN SET(s.nulls_err_stat,err_stat) OR err_stat = (TYPEOF(err_stat))''), 0, 3 ) + IF( (cntprimname  IN SET(s.nulls_cntprimname,cntprimname) OR cntprimname = (TYPEOF(cntprimname))''), 0, 10 ) >= Config.BasicMatchThreshold); // Potentially remove anything that would violate FORCE(+) constraints
  MatchCands := JOIN(h00_match,Specificities(ih).ClusterSizes(InCluster=1),LEFT.LocId=RIGHT.LocId,TRANSFORM(LEFT),LOCAL); // Singletons only may match
  Rec := RECORD
    SALT37.UIDType LocId1;
    SALT37.UIDType LocId2;
  END;
// It is important that this is an EQUIVALENCE relationship - it allows us to form an implicit transitive closure
  h01 := SORT(h00_match,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,v_city_name,st,zip5,err_stat,cntprimname,LocId);
  h02 := DEDUP(h01,prim_range,predir,prim_name,addr_suffix,postdir,sec_range,v_city_name,st,zip5,err_stat,cntprimname,LOCAL); // ,LOCAL ok - we don't need a perfect dedup - this is an optimization
  Match := JOIN(h02,MatchCands,LEFT.prim_range = RIGHT.prim_range AND LEFT.predir = RIGHT.predir AND LEFT.prim_name = RIGHT.prim_name AND LEFT.addr_suffix = RIGHT.addr_suffix AND LEFT.postdir = RIGHT.postdir
       AND LEFT.sec_range = RIGHT.sec_range AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND LEFT.st = RIGHT.st AND LEFT.zip5 = RIGHT.zip5 AND LEFT.err_stat = RIGHT.err_stat
       AND LEFT.cntprimname = RIGHT.cntprimname AND LEFT.LocId < RIGHT.LocId,TRANSFORM(Rec,SELF.LocId2 := LEFT.LocId,SELF.LocId1 := RIGHT.LocId), HASH);
SHARED PickOne := DEDUP( SORT( DISTRIBUTE( Match,HASH(LocId1) ), LocId1, LocId2, LOCAL), LocId1, LOCAL); // Lowest collector ID for each singleton
EXPORT patch_file := PickOne;
  SALT37.utMAC_Patch_Id(h00,LocId,PickOne,LocId1,LocId2,o1); // Patch the input file
EXPORT input_file := o1;
EXPORT basic_match_count := COUNT(PickOne);
EXPORT id_delta := COUNT(DEDUP(h00,LocId,ALL))-COUNT(DEDUP(input_file,LocId,ALL)); // Should equal basic_match_count
END;
