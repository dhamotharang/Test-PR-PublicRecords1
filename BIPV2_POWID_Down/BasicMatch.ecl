IMPORT SALT35,ut;
EXPORT BasicMatch(DATASET(layout_POWID_Down) ih) := MODULE// An extremely tight pre-match designed to quickly eliminate high volume duplicates
 
SHARED  h00 := Specificities(ih).input_file;
  SHARED s := Specificities(ih).specificities[1];
  SHARED h00_match := h00((prim_name NOT IN SET(s.nulls_prim_name,prim_name) AND prim_name <> (TYPEOF(prim_name))''),(st NOT IN SET(s.nulls_st,st) AND st <> (TYPEOF(st))''),~(((prim_range  IN SET(s.nulls_prim_range,prim_range) OR prim_range = (TYPEOF(prim_range))'') AND (prim_name  IN SET(s.nulls_prim_name,prim_name) OR prim_name = (TYPEOF(prim_name))'')) AND ((v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR v_city_name = (TYPEOF(v_city_name))'') AND (st  IN SET(s.nulls_st,st) OR st = (TYPEOF(st))'') AND (zip  IN SET(s.nulls_zip,zip) OR zip = (TYPEOF(zip))''))), 
      0 + IF( (orgid  IN SET(s.nulls_orgid,orgid) OR orgid = (TYPEOF(orgid))''), 0, 28 ) + IF( (prim_range  IN SET(s.nulls_prim_range,prim_range) OR prim_range = (TYPEOF(prim_range))''), 0, 13 ) + IF( (prim_name  IN SET(s.nulls_prim_name,prim_name) OR prim_name = (TYPEOF(prim_name))''), 0, 14 ) + IF( (st  IN SET(s.nulls_st,st) OR st = (TYPEOF(st))''), 0, 5 ) + IF( (v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR v_city_name = (TYPEOF(v_city_name))''), 0, 11 ) + IF( (zip  IN SET(s.nulls_zip,zip) OR zip = (TYPEOF(zip))''), 0, 14 ) >= Config.BasicMatchThreshold); // Potentially remove anything that would violate FORCE(+) constraints
  MatchCands := JOIN(h00_match,Specificities(ih).ClusterSizes(InCluster=1),LEFT.POWID=RIGHT.POWID,TRANSFORM(LEFT),LOCAL); // Singletons only may match
  Rec := RECORD
    SALT35.UIDType POWID1;
    SALT35.UIDType POWID2;
  END;
// It is important that this is an EQUIVALENCE relationship - it allows us to form an implicit transitive closure
  h01 := SORT(h00_match,SALT_Partition,orgid,prim_range,prim_name,st,v_city_name,zip,POWID);
  h02 := DEDUP(h01,SALT_Partition,orgid,prim_range,prim_name,st,v_city_name,zip,LOCAL); // ,LOCAL ok - we don't need a perfect dedup - this is an optimization
  Match := JOIN(h02,MatchCands,LEFT.orgid = RIGHT.orgid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st
       AND LEFT.zip = RIGHT.zip AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition ) AND LEFT.POWID < RIGHT.POWID,TRANSFORM(Rec,SELF.POWID2 := LEFT.POWID,SELF.POWID1 := RIGHT.POWID), HASH);
SHARED PickOne := DEDUP( SORT( DISTRIBUTE( Match,HASH(POWID1) ), POWID1, POWID2, LOCAL), POWID1, LOCAL); // Lowest collector ID for each singleton
EXPORT patch_file := PickOne;
  ut.MAC_Patch_Id(h00,POWID,PickOne,POWID1,POWID2,o1); // Patch the input file
EXPORT input_file := o1 : INDEPENDENT;
EXPORT basic_match_count := COUNT(PickOne);
EXPORT id_delta := COUNT(DEDUP(h00,POWID,ALL))-COUNT(DEDUP(input_file,POWID,ALL)); // Should equal basic_match_count
END;
