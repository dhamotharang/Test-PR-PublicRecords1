IMPORT SALT311;
EXPORT BasicMatch(DATASET(layout_LGID3) ih) := MODULE// An extremely tight pre-match designed to quickly eliminate high volume duplicates
 
SHARED  h00 := BIPV2_LGID3.LinkBlockers(ih).input_file;
  SHARED s := Specificities(ih).specificities[1];
  SHARED h00_match := h00(((company_inc_state NOT IN SET(s.nulls_company_inc_state,company_inc_state) AND company_inc_state <> (TYPEOF(company_inc_state))'') OR (active_duns_number NOT IN SET(s.nulls_active_duns_number,active_duns_number) AND active_duns_number <> (TYPEOF(active_duns_number))'') OR (duns_number NOT IN SET(s.nulls_duns_number,duns_number) AND duns_number <> (TYPEOF(duns_number))'') OR ~((active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR active_duns_number = (TYPEOF(active_duns_number))'') AND (duns_number  IN SET(s.nulls_duns_number,duns_number) OR duns_number = (TYPEOF(duns_number))'')) OR (company_fein NOT IN SET(s.nulls_company_fein,company_fein) AND company_fein <> (TYPEOF(company_fein))'') OR (sbfe_id NOT IN SET(s.nulls_sbfe_id,sbfe_id) AND sbfe_id <> (TYPEOF(sbfe_id))'')), 
      0 + IF( (sbfe_id  IN SET(s.nulls_sbfe_id,sbfe_id) OR sbfe_id = (TYPEOF(sbfe_id))''), 0, 27 ) + IF( (Lgid3IfHrchy  IN SET(s.nulls_Lgid3IfHrchy,Lgid3IfHrchy) OR Lgid3IfHrchy = (TYPEOF(Lgid3IfHrchy))''), 0, 27 ) + IF( (company_name  IN SET(s.nulls_company_name,company_name) OR company_name = (TYPEOF(company_name))''), 0, 26 ) + IF( (cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR cnp_number = (TYPEOF(cnp_number))''), 0, 13 ) + IF( (active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR active_duns_number = (TYPEOF(active_duns_number))''), 0, 27 ) + IF( (duns_number  IN SET(s.nulls_duns_number,duns_number) OR duns_number = (TYPEOF(duns_number))''), 0, 27 ) + IF( (company_fein  IN SET(s.nulls_company_fein,company_fein) OR company_fein = (TYPEOF(company_fein))''), 0, 26 ) + IF( (company_inc_state  IN SET(s.nulls_company_inc_state,company_inc_state) OR company_inc_state = (TYPEOF(company_inc_state))''), 0, 6 ) + IF( (company_charter_number  IN SET(s.nulls_company_charter_number,company_charter_number) OR company_charter_number = (TYPEOF(company_charter_number))''), 0, 26 ) + IF( (cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR cnp_btype = (TYPEOF(cnp_btype))''), 0, 3 ) >= Config.BasicMatchThreshold); // Potentially remove anything that would violate FORCE(+) constraints
  MatchCands := JOIN(h00_match,Specificities(ih).ClusterSizes(InCluster=1),LEFT.LGID3=RIGHT.LGID3,TRANSFORM(LEFT),LOCAL); // Singletons only may match
  Rec := RECORD
    SALT311.UIDType LGID31;
    SALT311.UIDType LGID32;
  END;
/* // It is important that this is an EQUIVALENCE relationship - it allows us to form an implicit transitive closure
  h01 := SORT(h00_match,SALT_Partition,sbfe_id,Lgid3IfHrchy,company_name,cnp_number,active_duns_number,duns_number,company_fein,company_inc_state,company_charter_number,cnp_btype,LGID3);
  h02 := DEDUP(h01,SALT_Partition,sbfe_id,Lgid3IfHrchy,company_name,cnp_number,active_duns_number,duns_number,company_fein,company_inc_state,company_charter_number,cnp_btype,LOCAL); // ,LOCAL ok - we don't need a perfect dedup - this is an optimization
  Match := JOIN(h02,MatchCands,LEFT.sbfe_id = RIGHT.sbfe_id AND LEFT.Lgid3IfHrchy = RIGHT.Lgid3IfHrchy AND LEFT.company_name = RIGHT.company_name AND LEFT.cnp_number = RIGHT.cnp_number AND LEFT.active_duns_number = RIGHT.active_duns_number
       AND LEFT.duns_number = RIGHT.duns_number AND LEFT.duns_number_concept = RIGHT.duns_number_concept AND LEFT.company_fein = RIGHT.company_fein AND LEFT.company_inc_state = RIGHT.company_inc_state AND LEFT.company_charter_number = RIGHT.company_charter_number AND LEFT.company_inc_state = RIGHT.company_inc_state
       AND LEFT.cnp_btype = RIGHT.cnp_btype AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition ) AND LEFT.LGID3 < RIGHT.LGID3,TRANSFORM(Rec,SELF.LGID32 := LEFT.LGID3,SELF.LGID31 := RIGHT.LGID3), HASH);
SHARED PickOne := DEDUP( SORT( DISTRIBUTE( Match,HASH(LGID31) ), LGID31, LGID32, LOCAL), LGID31, LOCAL); // Lowest collector ID for each singleton
EXPORT Block := LinkBlockers(ih).Block;
// Remove all blocked links
SHARED NotBlocked := JOIN(PickOne,Block,LEFT.LGID31=RIGHT.LGID31 AND LEFT.LGID32=RIGHT.LGID32,TRANSFORM(LEFT),LEFT ONLY, LOOKUP) : PERSIST('~temp::LGID3::BIPV2_LGID3::BasicMatch',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
EXPORT patch_file := NotBlocked;
  SALT311.utMAC_Patch_Id(h00,LGID3,NotBlocked,LGID31,LGID32,o1); // Patch the input file
EXPORT input_file := o1 : INDEPENDENT;
EXPORT basic_match_count := COUNT(NotBlocked); */
// HACKBasicMatch - disable BasicMatch altogether
EXPORT patch_file := dataset([],Rec);
EXPORT input_file := h00_match;
EXPORT basic_match_count := 0;

EXPORT id_delta := COUNT(DEDUP(h00,LGID3,ALL))-COUNT(DEDUP(input_file,LGID3,ALL)); // Should equal basic_match_count
END;
