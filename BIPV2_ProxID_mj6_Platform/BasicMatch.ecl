IMPORT SALT30,ut;
EXPORT BasicMatch(DATASET(layout_DOT_Base) ih) := MODULE// An extremely tight pre-match designed to quickly eliminate high volume duplicates
 
SHARED  h00 := Specificities(ih).input_file;
  SHARED s := Specificities(ih).specificities[1];
  SHARED h00_match := h00( 
      0 + IF( cnp_name  IN SET(s.nulls_cnp_name,cnp_name), 0, 25 ) + IF( cnp_number  IN SET(s.nulls_cnp_number,cnp_number), 0, 14 ) + IF( active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number), 0, 27 ) + IF( active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number), 0, 26 ) + IF( active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key), 0, 27 ) + IF( hist_enterprise_number  IN SET(s.nulls_hist_enterprise_number,hist_enterprise_number), 0, 28 ) + IF( hist_duns_number  IN SET(s.nulls_hist_duns_number,hist_duns_number), 0, 27 ) + IF( hist_domestic_corp_key  IN SET(s.nulls_hist_domestic_corp_key,hist_domestic_corp_key), 0, 27 ) + IF( foreign_corp_key  IN SET(s.nulls_foreign_corp_key,foreign_corp_key), 0, 27 ) + IF( unk_corp_key  IN SET(s.nulls_unk_corp_key,unk_corp_key), 0, 27 ) + IF( ebr_file_number  IN SET(s.nulls_ebr_file_number,ebr_file_number), 0, 28 ) + IF( company_fein  IN SET(s.nulls_company_fein,company_fein), 0, 26 ) + IF( company_phone  IN SET(s.nulls_company_phone,company_phone), 0, 27 ) + IF( prim_range  IN SET(s.nulls_prim_range,prim_range), 0, 13 ) + IF( prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived), 0, 15 ) + IF( sec_range  IN SET(s.nulls_sec_range,sec_range), 0, 12 ) + IF( v_city_name  IN SET(s.nulls_v_city_name,v_city_name), 0, 11 ) + IF( st  IN SET(s.nulls_st,st), 0, 5 ) + IF( zip  IN SET(s.nulls_zip,zip), 0, 14 ) >= Config.BasicMatchThreshold); // Potentially remove anything that would violate FORCE(+) constraints
  MatchCands := JOIN(h00_match,Specificities(ih).ClusterSizes(InCluster=1),LEFT.Proxid=RIGHT.Proxid,TRANSFORM(LEFT),LOCAL); // Singletons only may match
  Rec := RECORD
    SALT30.UIDType Proxid1;
    SALT30.UIDType Proxid2;
  END;
// It is important that this is an EQUIVALENCE relationship - it allows us to form an implicit transitive closure
  h01 := SORT      (h00_match ,SALT_Partition,cnp_name,cnp_number,active_duns_number,active_enterprise_number,active_domestic_corp_key,hist_enterprise_number,hist_duns_number,hist_domestic_corp_key,foreign_corp_key,unk_corp_key,ebr_file_number,company_fein,company_phone,prim_range,prim_name_derived,sec_range,v_city_name,st,zip,Proxid,local);
h02 := DEDUP     (h01       ,SALT_Partition,cnp_name,cnp_number,active_duns_number,active_enterprise_number,active_domestic_corp_key,hist_enterprise_number,hist_duns_number,hist_domestic_corp_key,foreign_corp_key,unk_corp_key,ebr_file_number,company_fein,company_phone,prim_range,prim_name_derived,sec_range,v_city_name,st,zip,local);
h03 := DISTRIBUTE(h02,hash64(SALT_Partition,cnp_name,cnp_number,active_duns_number,active_enterprise_number,active_domestic_corp_key,hist_enterprise_number,hist_duns_number,hist_domestic_corp_key,foreign_corp_key,unk_corp_key,ebr_file_number,company_fein,company_phone,prim_range,prim_name_derived,sec_range,v_city_name,st,zip));
h04 := SORT      (h03       ,SALT_Partition,cnp_name,cnp_number,active_duns_number,active_enterprise_number,active_domestic_corp_key,hist_enterprise_number,hist_duns_number,hist_domestic_corp_key,foreign_corp_key,unk_corp_key,ebr_file_number,company_fein,company_phone,prim_range,prim_name_derived,sec_range,v_city_name,st,zip,Proxid,local);
h05 := DEDUP     (h04       ,SALT_Partition,cnp_name,cnp_number,active_duns_number,active_enterprise_number,active_domestic_corp_key,hist_enterprise_number,hist_duns_number,hist_domestic_corp_key,foreign_corp_key,unk_corp_key,ebr_file_number,company_fein,company_phone,prim_range,prim_name_derived,sec_range,v_city_name,st,zip,local);
Match := JOIN(h05,MatchCands,LEFT.cnp_name = RIGHT.cnp_name AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.active_duns_number = RIGHT.active_duns_number AND LEFT.active_enterprise_number = RIGHT.active_enterprise_number AND LEFT.active_domestic_corp_key = RIGHT.active_domestic_corp_key
       AND LEFT.hist_enterprise_number = RIGHT.hist_enterprise_number AND LEFT.hist_duns_number = RIGHT.hist_duns_number AND LEFT.hist_domestic_corp_key = RIGHT.hist_domestic_corp_key AND LEFT.foreign_corp_key = RIGHT.foreign_corp_key AND LEFT.unk_corp_key = RIGHT.unk_corp_key
       AND LEFT.ebr_file_number = RIGHT.ebr_file_number AND LEFT.company_fein = RIGHT.company_fein AND LEFT.company_phone = RIGHT.company_phone AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name_derived = RIGHT.prim_name_derived
       AND LEFT.sec_range = RIGHT.sec_range AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND LEFT.st = RIGHT.st AND LEFT.zip = RIGHT.zip AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition ) AND LEFT.Proxid < RIGHT.Proxid,TRANSFORM(Rec,SELF.Proxid2 := LEFT.Proxid,SELF.Proxid1 := RIGHT.Proxid), HASH);
SHARED PickOne := DEDUP( SORT( DISTRIBUTE( Match,HASH(Proxid1) ), Proxid1, Proxid2, LOCAL), Proxid1, LOCAL); // Lowest collector ID for each singleton
EXPORT patch_file := PickOne;
  ut.MAC_Patch_Id(h00,Proxid,PickOne,Proxid1,Proxid2,o1); // Patch the input file
EXPORT input_file := o1 : INDEPENDENT;
EXPORT basic_match_count := COUNT(PickOne);
EXPORT id_delta := COUNT(DEDUP(h00,Proxid,ALL))-COUNT(DEDUP(input_file,Proxid,ALL)); // Should equal basic_match_count
END;
