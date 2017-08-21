IMPORT SALT27,ut;
EXPORT BasicMatch(DATASET(layout_Base) ih) := MODULE// An extremely tight pre-match designed to quickly eliminate high volume duplicates
SHARED  h00 := Specificities(ih).input_file;
  MatchCands := JOIN(h00,Specificities(ih).ClusterSizes(InCluster=1),LEFT.Proxid=RIGHT.Proxid,TRANSFORM(LEFT),LOCAL); // Singletons only may match
  Rec := RECORD
    SALT27.UIDType Proxid1;
    SALT27.UIDType Proxid2;
  END;
// It is important that this is an EQUIVALENCE relationship - it allows us to form an implicit transitive closure
  h01 := SORT(h00,company_name,company_fein,company_phone,company_url,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,fips_state,fips_county,Proxid);
  h02 := DEDUP(h01,company_name,company_fein,company_phone,company_url,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,fips_state,fips_county,LOCAL); // ,LOCAL ok - we don't need a perfect dedup - this is an optimization
  Match := JOIN(h02,MatchCands,LEFT.company_name = RIGHT.company_name AND LEFT.company_fein = RIGHT.company_fein AND LEFT.company_phone = RIGHT.company_phone AND LEFT.company_url = RIGHT.company_url AND LEFT.prim_range = RIGHT.prim_range
       AND LEFT.predir = RIGHT.predir AND LEFT.prim_name = RIGHT.prim_name AND LEFT.addr_suffix = RIGHT.addr_suffix AND LEFT.postdir = RIGHT.postdir AND LEFT.unit_desig = RIGHT.unit_desig
       AND LEFT.sec_range = RIGHT.sec_range AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND LEFT.zip = RIGHT.zip
       AND LEFT.zip4 = RIGHT.zip4 AND LEFT.fips_state = RIGHT.fips_state AND LEFT.fips_county = RIGHT.fips_county AND LEFT.Proxid < RIGHT.Proxid,TRANSFORM(Rec,SELF.Proxid2 := LEFT.Proxid,SELF.Proxid1 := RIGHT.Proxid));
SHARED PickOne := DEDUP( SORT( DISTRIBUTE( Match,HASH(Proxid1) ), Proxid1, Proxid2, LOCAL), Proxid1, LOCAL); // Lowest collector ID for each singleton
EXPORT patch_file := PickOne;
  ut.MAC_Patch_Id(h00,Proxid,PickOne,Proxid1,Proxid2,o1); // Patch the input file
EXPORT input_file := o1;
EXPORT basic_match_count := COUNT(PickOne);
EXPORT id_delta := COUNT(DEDUP(h00,Proxid,ALL))-COUNT(DEDUP(input_file,Proxid,ALL)); // Should equal basic_match_count
END;
