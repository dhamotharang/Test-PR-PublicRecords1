IMPORT SALT30,ut;
EXPORT BasicMatch(DATASET(layout_Base) ih) := MODULE// An extremely tight pre-match designed to quickly eliminate high volume duplicates
 
SHARED  h00 := Specificities(ih).input_file;
  SHARED s := Specificities(ih).specificities[1];
  SHARED h00_match := h00( 
      0 + IF( company_name  IN SET(s.nulls_company_name,company_name), 0, 26 ) + IF( company_fein  IN SET(s.nulls_company_fein,company_fein), 0, 26 ) + IF( company_phone  IN SET(s.nulls_company_phone,company_phone), 0, 26 ) + IF( company_url  IN SET(s.nulls_company_url,company_url), 0, 27 ) + IF( duns_number  IN SET(s.nulls_duns_number,duns_number), 0, 27 ) + IF( company_sic_code1  IN SET(s.nulls_company_sic_code1,company_sic_code1), 0, 11 ) + IF( company_naics_code1  IN SET(s.nulls_company_naics_code1,company_naics_code1), 0, 11 ) + IF( dba_name  IN SET(s.nulls_dba_name,dba_name), 0, 26 ) + IF( prim_range  IN SET(s.nulls_prim_range,prim_range), 0, 13 ) + IF( predir  IN SET(s.nulls_predir,predir), 0, 5 ) + IF( prim_name  IN SET(s.nulls_prim_name,prim_name), 0, 15 ) + IF( addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix), 0, 4 ) + IF( postdir  IN SET(s.nulls_postdir,postdir), 0, 7 ) + IF( unit_desig  IN SET(s.nulls_unit_desig,unit_desig), 0, 5 ) + IF( sec_range  IN SET(s.nulls_sec_range,sec_range), 0, 12 ) + IF( p_city_name  IN SET(s.nulls_p_city_name,p_city_name), 0, 12 ) + IF( v_city_name  IN SET(s.nulls_v_city_name,v_city_name), 0, 11 ) + IF( st  IN SET(s.nulls_st,st), 0, 5 ) + IF( zip  IN SET(s.nulls_zip,zip), 0, 14 ) + IF( zip4  IN SET(s.nulls_zip4,zip4), 0, 13 ) + IF( fips_state  IN SET(s.nulls_fips_state,fips_state), 0, 5 ) + IF( fips_county  IN SET(s.nulls_fips_county,fips_county), 0, 7 ) >= Config.BasicMatchThreshold); // Potentially remove anything that would violate FORCE(+) constraints
  MatchCands := JOIN(h00_match,Specificities(ih).ClusterSizes(InCluster=1),LEFT.Proxid=RIGHT.Proxid,TRANSFORM(LEFT),LOCAL); // Singletons only may match
  Rec := RECORD
    SALT30.UIDType Proxid1;
    SALT30.UIDType Proxid2;
  END;
// It is important that this is an EQUIVALENCE relationship - it allows us to form an implicit transitive closure
  h01 := SORT(h00_match,company_name,company_fein,company_phone,company_url,duns_number,company_sic_code1,company_naics_code1,dba_name,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,fips_state,fips_county,Proxid);
  h02 := DEDUP(h01,company_name,company_fein,company_phone,company_url,duns_number,company_sic_code1,company_naics_code1,dba_name,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,fips_state,fips_county,LOCAL); // ,LOCAL ok - we don't need a perfect dedup - this is an optimization
  Match := JOIN(h02,MatchCands,LEFT.company_name = RIGHT.company_name AND LEFT.company_fein = RIGHT.company_fein AND LEFT.company_phone = RIGHT.company_phone AND LEFT.company_url = RIGHT.company_url AND LEFT.duns_number = RIGHT.duns_number
       AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.company_naics_code1 = RIGHT.company_naics_code1 AND LEFT.dba_name = RIGHT.dba_name AND LEFT.prim_range = RIGHT.prim_range AND LEFT.predir = RIGHT.predir
       AND LEFT.prim_name = RIGHT.prim_name AND LEFT.addr_suffix = RIGHT.addr_suffix AND LEFT.postdir = RIGHT.postdir AND LEFT.unit_desig = RIGHT.unit_desig AND LEFT.sec_range = RIGHT.sec_range
       AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND LEFT.zip = RIGHT.zip AND LEFT.zip4 = RIGHT.zip4
       AND LEFT.fips_state = RIGHT.fips_state AND LEFT.fips_county = RIGHT.fips_county AND LEFT.Proxid < RIGHT.Proxid,TRANSFORM(Rec,SELF.Proxid2 := LEFT.Proxid,SELF.Proxid1 := RIGHT.Proxid), HASH);
SHARED PickOne := DEDUP( SORT( DISTRIBUTE( Match,HASH(Proxid1) ), Proxid1, Proxid2, LOCAL), Proxid1, LOCAL); // Lowest collector ID for each singleton
EXPORT patch_file := PickOne;
  ut.MAC_Patch_Id(h00,Proxid,PickOne,Proxid1,Proxid2,o1); // Patch the input file
EXPORT input_file := o1 : INDEPENDENT;
EXPORT basic_match_count := COUNT(PickOne);
EXPORT id_delta := COUNT(DEDUP(h00,Proxid,ALL))-COUNT(DEDUP(input_file,Proxid,ALL)); // Should equal basic_match_count
END;
