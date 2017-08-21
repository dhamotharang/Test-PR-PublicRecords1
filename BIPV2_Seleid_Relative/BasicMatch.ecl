IMPORT SALT31,ut;
EXPORT BasicMatch(DATASET(layout_Base) ih) := MODULE// An extremely tight pre-match designed to quickly eliminate high volume duplicates
SHARED  h00 := Specificities(ih).input_file;
  SHARED s := Specificities(ih).specificities[1];
  SHARED h00_match := h00( 
      0 + IF( cnp_name  IN SET(s.nulls_cnp_name,cnp_name), 0, 25 ) + IF( company_inc_state  IN SET(s.nulls_company_inc_state,company_inc_state), 0, 7 ) + IF( company_charter_number  IN SET(s.nulls_company_charter_number,company_charter_number), 0, 27 ) + IF( company_fein  IN SET(s.nulls_company_fein,company_fein), 0, 27 ) + IF( prim_range  IN SET(s.nulls_prim_range,prim_range), 0, 13 ) + IF( prim_name  IN SET(s.nulls_prim_name,prim_name), 0, 15 ) + IF( postdir  IN SET(s.nulls_postdir,postdir), 0, 7 ) + IF( sec_range  IN SET(s.nulls_sec_range,sec_range), 0, 12 ) + IF( v_city_name  IN SET(s.nulls_v_city_name,v_city_name), 0, 11 ) + IF( st  IN SET(s.nulls_st,st), 0, 5 ) + IF( active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number), 0, 28 ) + IF( active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number), 0, 28 ) + IF( source  IN SET(s.nulls_source,source), 0, 4 ) + IF( source_record_id  IN SET(s.nulls_source_record_id,source_record_id), 0, 27 ) + IF( fname  IN SET(s.nulls_fname,fname), 0, 11 ) + IF( mname  IN SET(s.nulls_mname,mname), 0, 8 ) + IF( lname  IN SET(s.nulls_lname,lname), 0, 16 ) + IF( contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn), 0, 27 ) + IF( contact_phone  IN SET(s.nulls_contact_phone,contact_phone), 0, 27 ) + IF( contact_email_username  IN SET(s.nulls_contact_email_username,contact_email_username), 0, 27 ) >= Config.BasicMatchThreshold); // Potentially remove anything that would violate FORCE(+) constraints
  MatchCands := JOIN(h00_match,Specificities(ih).ClusterSizes(InCluster=1),LEFT.Seleid=RIGHT.Seleid,TRANSFORM(LEFT),LOCAL); // Singletons only may match
  Rec := RECORD
    SALT31.UIDType Seleid1;
    SALT31.UIDType Seleid2;
  END;
// It is important that this is an EQUIVALENCE relationship - it allows us to form an implicit transitive closure
  h01 := SORT(h00_match,cnp_name,company_inc_state,company_charter_number,company_fein,prim_range,prim_name,postdir,sec_range,v_city_name,st,active_duns_number,active_enterprise_number,source,source_record_id,fname,mname,lname,contact_ssn,contact_phone,contact_email_username,Seleid);
  h02 := DEDUP(h01,cnp_name,company_inc_state,company_charter_number,company_fein,prim_range,prim_name,postdir,sec_range,v_city_name,st,active_duns_number,active_enterprise_number,source,source_record_id,fname,mname,lname,contact_ssn,contact_phone,contact_email_username,LOCAL); // ,LOCAL ok - we don't need a perfect dedup - this is an optimization
  Match := JOIN(h02,MatchCands,LEFT.cnp_name = RIGHT.cnp_name AND LEFT.company_inc_state = RIGHT.company_inc_state AND LEFT.company_charter_number = RIGHT.company_charter_number AND LEFT.company_inc_state = RIGHT.company_inc_state AND LEFT.company_fein = RIGHT.company_fein AND LEFT.prim_range = RIGHT.prim_range
       AND LEFT.prim_name = RIGHT.prim_name AND LEFT.postdir = RIGHT.postdir AND LEFT.prim_name = RIGHT.prim_name AND LEFT.sec_range = RIGHT.sec_range AND LEFT.v_city_name = RIGHT.v_city_name AND LEFT.st = RIGHT.st AND LEFT.st = RIGHT.st
       AND LEFT.active_duns_number = RIGHT.active_duns_number AND LEFT.active_enterprise_number = RIGHT.active_enterprise_number AND LEFT.source = RIGHT.source AND LEFT.source_record_id = RIGHT.source_record_id AND LEFT.fname = RIGHT.fname
       AND LEFT.mname = RIGHT.mname AND LEFT.lname = RIGHT.lname AND LEFT.contact_ssn = RIGHT.contact_ssn AND LEFT.contact_phone = RIGHT.contact_phone AND LEFT.contact_email_username = RIGHT.contact_email_username AND LEFT.Seleid < RIGHT.Seleid,TRANSFORM(Rec,SELF.Seleid2 := LEFT.Seleid,SELF.Seleid1 := RIGHT.Seleid), HASH);
SHARED PickOne := DEDUP( SORT( DISTRIBUTE( Match,HASH(Seleid1) ), Seleid1, Seleid2, LOCAL), Seleid1, LOCAL); // Lowest collector ID for each singleton
EXPORT patch_file := PickOne;
  ut.MAC_Patch_Id(h00,Seleid,PickOne,Seleid1,Seleid2,o1); // Patch the input file
EXPORT input_file := o1 : INDEPENDENT;
EXPORT basic_match_count := COUNT(PickOne);
EXPORT id_delta := COUNT(DEDUP(h00,Seleid,ALL))-COUNT(DEDUP(input_file,Seleid,ALL)); // Should equal basic_match_count
END;
