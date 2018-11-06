IMPORT SALT311;
EXPORT BasicMatch(DATASET(layout_Address_Link) ih) := MODULE// An extremely tight pre-match designed to quickly eliminate high volume duplicates
 
SHARED  h00 := InsuranceHeader_Address.Specificities(ih).input_file;
  SHARED s := Specificities(ih).specificities[1];
  SHARED h00_match := h00( 
      0 + IF( (DID  IN SET(s.nulls_DID,DID) OR DID = (TYPEOF(DID))''), 0, 30 ) + IF( (prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR prim_range_alpha = (TYPEOF(prim_range_alpha))''), 0, 10 ) + IF( (prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR prim_range_num = (TYPEOF(prim_range_num))''), 0, 13 ) + IF( (prim_range_fract  IN SET(s.nulls_prim_range_fract,prim_range_fract) OR prim_range_fract = (TYPEOF(prim_range_fract))''), 0, 9 ) + IF( (prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR prim_name_num = (TYPEOF(prim_name_num))''), 0, 13 ) + IF( (prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR prim_name_alpha = (TYPEOF(prim_name_alpha))''), 0, 10 ) + IF( (sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR sec_range_alpha = (TYPEOF(sec_range_alpha))''), 0, 9 ) + IF( (sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR sec_range_num = (TYPEOF(sec_range_num))''), 0, 9 ) + IF( (city  IN SET(s.nulls_city,city) OR city = (TYPEOF(city))''), 0, 8 ) + IF( (st  IN SET(s.nulls_st,st) OR st = (TYPEOF(st))''), 0, 6 ) + IF( (zip  IN SET(s.nulls_zip,zip) OR zip = (TYPEOF(zip))''), 0, 14 ) >= Config.BasicMatchThreshold); // Potentially remove anything that would violate FORCE(+) constraints
  MatchCands := JOIN(h00_match,Specificities(ih).ClusterSizes(InCluster=1),LEFT.ADDRESS_GROUP_ID=RIGHT.ADDRESS_GROUP_ID,TRANSFORM(LEFT),LOCAL); // Singletons only may match
  Rec := RECORD
    SALT311.UIDType ADDRESS_GROUP_ID1;
    SALT311.UIDType ADDRESS_GROUP_ID2;
  END;
// It is important that this is an EQUIVALENCE relationship - it allows us to form an implicit transitive closure
  h01 := SORT(h00_match,DID,prim_range_alpha,prim_range_num,prim_range_fract,prim_name_num,prim_name_alpha,sec_range_alpha,sec_range_num,city,st,zip,ADDRESS_GROUP_ID);
  h02 := DEDUP(h01,DID,prim_range_alpha,prim_range_num,prim_range_fract,prim_name_num,prim_name_alpha,sec_range_alpha,sec_range_num,city,st,zip,LOCAL); // ,LOCAL ok - we don't need a perfect dedup - this is an optimization
  Match := JOIN(h02,MatchCands,LEFT.DID = RIGHT.DID AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha AND LEFT.prim_range_num = RIGHT.prim_range_num AND LEFT.prim_range_fract = RIGHT.prim_range_fract AND LEFT.prim_name_num = RIGHT.prim_name_num
       AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha AND LEFT.sec_range_num = RIGHT.sec_range_num AND LEFT.city = RIGHT.city AND LEFT.st = RIGHT.st
       AND LEFT.zip = RIGHT.zip AND LEFT.addr = RIGHT.addr AND LEFT.locale = RIGHT.locale AND LEFT.ADDRESS_GROUP_ID < RIGHT.ADDRESS_GROUP_ID,TRANSFORM(Rec,SELF.ADDRESS_GROUP_ID2 := LEFT.ADDRESS_GROUP_ID,SELF.ADDRESS_GROUP_ID1 := RIGHT.ADDRESS_GROUP_ID), HASH);
SHARED PickOne := DEDUP( SORT( DISTRIBUTE( Match,HASH(ADDRESS_GROUP_ID1) ), ADDRESS_GROUP_ID1, ADDRESS_GROUP_ID2, LOCAL), ADDRESS_GROUP_ID1, LOCAL); // Lowest collector ID for each singleton
EXPORT patch_file := PickOne;
  SALT311.utMAC_Patch_Id(h00,ADDRESS_GROUP_ID,PickOne,ADDRESS_GROUP_ID1,ADDRESS_GROUP_ID2,o1); // Patch the input file
EXPORT input_file := o1 : INDEPENDENT;
EXPORT basic_match_count := COUNT(PickOne);
EXPORT id_delta := COUNT(DEDUP(h00,ADDRESS_GROUP_ID,ALL))-COUNT(DEDUP(input_file,ADDRESS_GROUP_ID,ALL)); // Should equal basic_match_count
END;
