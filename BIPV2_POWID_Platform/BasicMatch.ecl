IMPORT SALT32,ut;
EXPORT BasicMatch(DATASET(layout_POWID) ih) := MODULE// An extremely tight pre-match designed to quickly eliminate high volume duplicates
 
SHARED  h00 := Specificities(ih).input_file;
  SHARED s := Specificities(ih).specificities[1];
  SHARED h00_match := h00(cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name) AND cnp_name <> (TYPEOF(cnp_name))'', 
      0 + IF( RID_If_Big_Biz  IN SET(s.nulls_RID_If_Big_Biz,RID_If_Big_Biz) OR RID_If_Big_Biz = (TYPEOF(RID_If_Big_Biz))'', 0, 26 ) + IF( company_name  IN SET(s.nulls_company_name,company_name) OR company_name = (TYPEOF(company_name))'', 0, 25 ) + IF( cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR cnp_name = (TYPEOF(cnp_name))'', 0, 26 ) + IF( cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR cnp_number = (TYPEOF(cnp_number))'', 0, 14 ) + IF( prim_range  IN SET(s.nulls_prim_range,prim_range) OR prim_range = (TYPEOF(prim_range))'', 0, 13 ) + IF( prim_name  IN SET(s.nulls_prim_name,prim_name) OR prim_name = (TYPEOF(prim_name))'', 0, 15 ) + IF( zip  IN SET(s.nulls_zip,zip) OR zip = (TYPEOF(zip))'', 0, 14 ) >= Config.BasicMatchThreshold); // Potentially remove anything that would violate FORCE(+) constraints
  MatchCands := JOIN(h00_match,Specificities(ih).ClusterSizes(InCluster=1),LEFT.POWID=RIGHT.POWID,TRANSFORM(LEFT),LOCAL); // Singletons only may match
  Rec := RECORD
    SALT32.UIDType POWID1;
    SALT32.UIDType POWID2;
  END;
// It is important that this is an EQUIVALENCE relationship - it allows us to form an implicit transitive closure
  h01 := SORT(h00_match,SALT_Partition,RID_If_Big_Biz,company_name,cnp_name,cnp_number,prim_range,prim_name,zip,POWID);
  h02 := DEDUP(h01,SALT_Partition,RID_If_Big_Biz,company_name,cnp_name,cnp_number,prim_range,prim_name,zip,LOCAL); // ,LOCAL ok - we don't need a perfect dedup - this is an optimization
  Match := JOIN(h02,MatchCands,LEFT.RID_If_Big_Biz = RIGHT.RID_If_Big_Biz AND LEFT.company_name = RIGHT.company_name AND LEFT.cnp_name = RIGHT.cnp_name AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range = RIGHT.prim_range
       AND LEFT.prim_name = RIGHT.prim_name AND LEFT.zip = RIGHT.zip AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition ) AND LEFT.POWID < RIGHT.POWID,TRANSFORM(Rec,SELF.POWID2 := LEFT.POWID,SELF.POWID1 := RIGHT.POWID), HASH);
SHARED PickOne := DEDUP( SORT( DISTRIBUTE( Match,HASH(POWID1) ), POWID1, POWID2, LOCAL), POWID1, LOCAL); // Lowest collector ID for each singleton
EXPORT patch_file := PickOne;
  ut.MAC_Patch_Id(h00,POWID,PickOne,POWID1,POWID2,o1); // Patch the input file
EXPORT input_file := o1 : INDEPENDENT;
EXPORT basic_match_count := COUNT(PickOne);
EXPORT id_delta := COUNT(DEDUP(h00,POWID,ALL))-COUNT(DEDUP(input_file,POWID,ALL)); // Should equal basic_match_count
END;
