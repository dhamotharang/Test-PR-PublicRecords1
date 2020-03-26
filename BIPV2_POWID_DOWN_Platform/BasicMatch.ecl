IMPORT SALT27,ut;
EXPORT BasicMatch(DATASET(layout_POWID_Down) ih) := MODULE// An extremely tight pre-match designed to quickly eliminate high volume duplicates
 
SHARED  h00 := Specificities(ih).input_file;
  MatchCands := JOIN(h00,Specificities(ih).ClusterSizes(InCluster=1),LEFT.POWID=RIGHT.POWID,TRANSFORM(LEFT),LOCAL); // Singletons only may match
  Rec := RECORD
    SALT27.UIDType POWID1;
    SALT27.UIDType POWID2;
  END;
// It is important that this is an EQUIVALENCE relationship - it allows us to form an implicit transitive closure
  h01 := SORT(h00,SALT_Partition,orgid,prim_range,prim_name,st,v_city_name,zip,POWID);
  h02 := DEDUP(h01,SALT_Partition,orgid,prim_range,prim_name,st,v_city_name,zip,LOCAL); // ,LOCAL ok - we don't need a perfect dedup - this is an optimization
  Match := JOIN(h02,MatchCands,LEFT.orgid = RIGHT.orgid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st
       AND LEFT.zip = RIGHT.zip AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition ) AND LEFT.POWID < RIGHT.POWID,TRANSFORM(Rec,SELF.POWID2 := LEFT.POWID,SELF.POWID1 := RIGHT.POWID));
SHARED PickOne := DEDUP( SORT( DISTRIBUTE( Match,HASH(POWID1) ), POWID1, POWID2, LOCAL), POWID1, LOCAL); // Lowest collector ID for each singleton
EXPORT patch_file := PickOne;
  ut.MAC_Patch_Id(h00,POWID,PickOne,POWID1,POWID2,o1); // Patch the input file
EXPORT input_file := o1;
EXPORT basic_match_count := COUNT(PickOne);
EXPORT id_delta := COUNT(DEDUP(h00,POWID,ALL))-COUNT(DEDUP(input_file,POWID,ALL)); // Should equal basic_match_count
END;
