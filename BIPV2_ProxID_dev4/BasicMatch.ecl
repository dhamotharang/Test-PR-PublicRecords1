IMPORT SALT27,ut;
EXPORT BasicMatch(DATASET(layout_DOT_Base) ih) := MODULE// An extremely tight pre-match designed to quickly eliminate high volume duplicates
 
SHARED  h00 := Specificities(ih).input_file;
  MatchCands := JOIN(h00,Specificities(ih).ClusterSizes(InCluster=1),LEFT.Proxid=RIGHT.Proxid,TRANSFORM(LEFT),LOCAL); // Singletons only may match
  Rec := RECORD
    SALT27.UIDType Proxid1;
    SALT27.UIDType Proxid2;
  END;
// It is important that this is an EQUIVALENCE relationship - it allows us to form an implicit transitive closure
  h01 := SORT(h00,SALT_Partition,active_duns_number,active_enterprise_number,active_domestic_corp_key,hist_enterprise_number,hist_duns_number,hist_domestic_corp_key,foreign_corp_key,unk_corp_key,ebr_file_number,company_name,cnp_number,cnp_btype,company_fein,company_phone,iscorp,prim_range,prim_name,sec_range,v_city_name,st,zip,Proxid);
  h02 := DEDUP(h01,SALT_Partition,active_duns_number,active_enterprise_number,active_domestic_corp_key,hist_enterprise_number,hist_duns_number,hist_domestic_corp_key,foreign_corp_key,unk_corp_key,ebr_file_number,company_name,cnp_number,cnp_btype,company_fein,company_phone,iscorp,prim_range,prim_name,sec_range,v_city_name,st,zip,LOCAL); // ,LOCAL ok - we don't need a perfect dedup - this is an optimization
  Match := JOIN(h02,MatchCands,LEFT.active_duns_number = RIGHT.active_duns_number AND LEFT.active_enterprise_number = RIGHT.active_enterprise_number AND LEFT.active_domestic_corp_key = RIGHT.active_domestic_corp_key AND LEFT.hist_enterprise_number = RIGHT.hist_enterprise_number AND LEFT.hist_duns_number = RIGHT.hist_duns_number
       AND LEFT.hist_domestic_corp_key = RIGHT.hist_domestic_corp_key AND LEFT.foreign_corp_key = RIGHT.foreign_corp_key AND LEFT.unk_corp_key = RIGHT.unk_corp_key AND LEFT.ebr_file_number = RIGHT.ebr_file_number AND LEFT.company_name = RIGHT.company_name
       AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.cnp_btype = RIGHT.cnp_btype AND LEFT.company_fein = RIGHT.company_fein AND LEFT.company_phone = RIGHT.company_phone AND LEFT.iscorp = RIGHT.iscorp
       AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.sec_range = RIGHT.sec_range AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND LEFT.st = RIGHT.st
       AND LEFT.zip = RIGHT.zip AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition ) AND LEFT.Proxid < RIGHT.Proxid,TRANSFORM(Rec,SELF.Proxid2 := LEFT.Proxid,SELF.Proxid1 := RIGHT.Proxid));
SHARED PickOne := DEDUP( SORT( DISTRIBUTE( Match,HASH(Proxid1) ), Proxid1, Proxid2, LOCAL), Proxid1, LOCAL); // Lowest collector ID for each singleton
EXPORT patch_file := PickOne;
  ut.MAC_Patch_Id(h00,Proxid,PickOne,Proxid1,Proxid2,o1); // Patch the input file
EXPORT input_file := o1;
EXPORT basic_match_count := COUNT(PickOne);
EXPORT id_delta := COUNT(DEDUP(h00,Proxid,ALL))-COUNT(DEDUP(input_file,Proxid,ALL)); // Should equal basic_match_count
END;
