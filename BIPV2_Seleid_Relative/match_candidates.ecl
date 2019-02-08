// Begin code to produce match candidates
IMPORT SALT31,ut;
EXPORT match_candidates(DATASET(layout_Base) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := BasicMatch(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00,{rcid,cnp_name,company_inc_state,company_charter_number,company_fein,prim_range,prim_name,postdir,unit_desig,sec_range,v_city_name,st,active_duns_number,active_enterprise_number,source,source_record_id,fname,mname,lname,contact_ssn,contact_phone,company_department,contact_email_username,dt_first_seen,dt_last_seen,dt_first_seen_contact,dt_last_seen_contact,Seleid}),HASH(Seleid));
 
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 cnp_name_pop := AVE(GROUP,IF(thin_table.cnp_name  IN SET(s.nulls_cnp_name,cnp_name),0,100));
  REAL8 company_inc_state_pop := AVE(GROUP,IF(thin_table.company_inc_state  IN SET(s.nulls_company_inc_state,company_inc_state),0,100));
  REAL8 company_charter_number_pop := AVE(GROUP,IF(thin_table.company_charter_number  IN SET(s.nulls_company_charter_number,company_charter_number),0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF(thin_table.company_fein  IN SET(s.nulls_company_fein,company_fein),0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF(thin_table.prim_range  IN SET(s.nulls_prim_range,prim_range),0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF(thin_table.prim_name  IN SET(s.nulls_prim_name,prim_name),0,100));
  REAL8 postdir_pop := AVE(GROUP,IF(thin_table.postdir  IN SET(s.nulls_postdir,postdir),0,100));
  REAL8 sec_range_pop := AVE(GROUP,IF(thin_table.sec_range  IN SET(s.nulls_sec_range,sec_range),0,100));
  REAL8 v_city_name_pop := AVE(GROUP,IF(thin_table.v_city_name  IN SET(s.nulls_v_city_name,v_city_name),0,100));
  REAL8 st_pop := AVE(GROUP,IF(thin_table.st  IN SET(s.nulls_st,st),0,100));
  REAL8 active_duns_number_pop := AVE(GROUP,IF(thin_table.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number),0,100));
  REAL8 active_enterprise_number_pop := AVE(GROUP,IF(thin_table.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number),0,100));
  REAL8 source_pop := AVE(GROUP,IF(thin_table.source  IN SET(s.nulls_source,source),0,100));
  REAL8 source_record_id_pop := AVE(GROUP,IF(thin_table.source_record_id  IN SET(s.nulls_source_record_id,source_record_id),0,100));
  REAL8 fname_pop := AVE(GROUP,IF(thin_table.fname  IN SET(s.nulls_fname,fname),0,100));
  REAL8 mname_pop := AVE(GROUP,IF(thin_table.mname  IN SET(s.nulls_mname,mname),0,100));
  REAL8 lname_pop := AVE(GROUP,IF(thin_table.lname  IN SET(s.nulls_lname,lname),0,100));
  REAL8 contact_ssn_pop := AVE(GROUP,IF(thin_table.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn),0,100));
  REAL8 contact_phone_pop := AVE(GROUP,IF(thin_table.contact_phone  IN SET(s.nulls_contact_phone,contact_phone),0,100));
  REAL8 contact_email_username_pop := AVE(GROUP,IF(thin_table.contact_email_username  IN SET(s.nulls_contact_email_username,contact_email_username),0,100));
END;
EXPORT PrePropogationStats := TABLE(thin_table,PrePropCounts);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 company_inc_state_prop := 0;
  UNSIGNED1 company_charter_number_prop := 0;
  UNSIGNED1 company_fein_prop := 0;
  UNSIGNED1 sec_range_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
 
SALT31.mac_prop_field(with_props(company_inc_state NOT IN SET(s.nulls_company_inc_state,company_inc_state)),company_inc_state,Seleid,company_inc_state_props); // For every DID find the best FULL company_inc_state
layout_withpropvars take_company_inc_state(with_props le,company_inc_state_props ri) := TRANSFORM
  SELF.company_inc_state := IF ( le.company_inc_state IN SET(s.nulls_company_inc_state,company_inc_state) and ri.Seleid<>(TYPEOF(ri.Seleid))'', ri.company_inc_state, le.company_inc_state );
  SELF.company_inc_state_prop := le.company_inc_state_prop + IF ( le.company_inc_state IN SET(s.nulls_company_inc_state,company_inc_state) and ri.company_inc_state NOT IN SET(s.nulls_company_inc_state,company_inc_state) and ri.Seleid<>(TYPEOF(ri.Seleid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj1 := JOIN(with_props,company_inc_state_props,left.Seleid=right.Seleid,take_company_inc_state(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACK*/);
 
SALT31.mac_prop_field(with_props(company_charter_number NOT IN SET(s.nulls_company_charter_number,company_charter_number)),company_charter_number,Seleid,company_charter_number_props); // For every DID find the best FULL company_charter_number
layout_withpropvars take_company_charter_number(with_props le,company_charter_number_props ri) := TRANSFORM
  SELF.company_charter_number := IF ( le.company_charter_number IN SET(s.nulls_company_charter_number,company_charter_number) and ri.Seleid<>(TYPEOF(ri.Seleid))'', ri.company_charter_number, le.company_charter_number );
  SELF.company_charter_number_prop := le.company_charter_number_prop + IF ( le.company_charter_number IN SET(s.nulls_company_charter_number,company_charter_number) and ri.company_charter_number NOT IN SET(s.nulls_company_charter_number,company_charter_number) and ri.Seleid<>(TYPEOF(ri.Seleid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj2 := JOIN(pj1,company_charter_number_props,left.Seleid=right.Seleid,take_company_charter_number(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACK*/);
 
SALT31.mac_prop_field(with_props(company_fein NOT IN SET(s.nulls_company_fein,company_fein)),company_fein,Seleid,company_fein_props); // For every DID find the best FULL company_fein
layout_withpropvars take_company_fein(with_props le,company_fein_props ri) := TRANSFORM
  SELF.company_fein := IF ( le.company_fein IN SET(s.nulls_company_fein,company_fein) and ri.Seleid<>(TYPEOF(ri.Seleid))'', ri.company_fein, le.company_fein );
  SELF.company_fein_prop := le.company_fein_prop + IF ( le.company_fein IN SET(s.nulls_company_fein,company_fein) and ri.company_fein NOT IN SET(s.nulls_company_fein,company_fein) and ri.Seleid<>(TYPEOF(ri.Seleid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj3 := JOIN(pj2,company_fein_props,left.Seleid=right.Seleid,take_company_fein(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACK*/);
 
SALT31.mac_prop_field(with_props(sec_range NOT IN SET(s.nulls_sec_range,sec_range)),sec_range,Seleid,sec_range_props); // For every DID find the best FULL sec_range
layout_withpropvars take_sec_range(with_props le,sec_range_props ri) := TRANSFORM
  SELF.sec_range := IF ( le.sec_range IN SET(s.nulls_sec_range,sec_range) and ri.Seleid<>(TYPEOF(ri.Seleid))'', ri.sec_range, le.sec_range );
  SELF.sec_range_prop := le.sec_range_prop + IF ( le.sec_range IN SET(s.nulls_sec_range,sec_range) and ri.sec_range NOT IN SET(s.nulls_sec_range,sec_range) and ri.Seleid<>(TYPEOF(ri.Seleid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj8 := JOIN(pj3,sec_range_props,left.Seleid=right.Seleid,take_sec_range(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACK*/);
 
pj8 do_computes(pj8 le) := TRANSFORM
  SELF := le;
END;
SHARED propogated := PROJECT(pj8,do_computes(left)) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::mc_props::Base',EXPIRE(Config.PersistExpire)); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 cnp_name_pop := AVE(GROUP,IF(propogated.cnp_name  IN SET(s.nulls_cnp_name,cnp_name),0,100));
  REAL8 company_inc_state_pop := AVE(GROUP,IF(propogated.company_inc_state  IN SET(s.nulls_company_inc_state,company_inc_state),0,100));
  REAL8 company_charter_number_pop := AVE(GROUP,IF(propogated.company_charter_number  IN SET(s.nulls_company_charter_number,company_charter_number),0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF(propogated.company_fein  IN SET(s.nulls_company_fein,company_fein),0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF(propogated.prim_range  IN SET(s.nulls_prim_range,prim_range),0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF(propogated.prim_name  IN SET(s.nulls_prim_name,prim_name),0,100));
  REAL8 postdir_pop := AVE(GROUP,IF(propogated.postdir  IN SET(s.nulls_postdir,postdir),0,100));
  REAL8 sec_range_pop := AVE(GROUP,IF(propogated.sec_range  IN SET(s.nulls_sec_range,sec_range),0,100));
  REAL8 v_city_name_pop := AVE(GROUP,IF(propogated.v_city_name  IN SET(s.nulls_v_city_name,v_city_name),0,100));
  REAL8 st_pop := AVE(GROUP,IF(propogated.st  IN SET(s.nulls_st,st),0,100));
  REAL8 active_duns_number_pop := AVE(GROUP,IF(propogated.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number),0,100));
  REAL8 active_enterprise_number_pop := AVE(GROUP,IF(propogated.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number),0,100));
  REAL8 source_pop := AVE(GROUP,IF(propogated.source  IN SET(s.nulls_source,source),0,100));
  REAL8 source_record_id_pop := AVE(GROUP,IF(propogated.source_record_id  IN SET(s.nulls_source_record_id,source_record_id),0,100));
  REAL8 fname_pop := AVE(GROUP,IF(propogated.fname  IN SET(s.nulls_fname,fname),0,100));
  REAL8 mname_pop := AVE(GROUP,IF(propogated.mname  IN SET(s.nulls_mname,mname),0,100));
  REAL8 lname_pop := AVE(GROUP,IF(propogated.lname  IN SET(s.nulls_lname,lname),0,100));
  REAL8 contact_ssn_pop := AVE(GROUP,IF(propogated.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn),0,100));
  REAL8 contact_phone_pop := AVE(GROUP,IF(propogated.contact_phone  IN SET(s.nulls_contact_phone,contact_phone),0,100));
  REAL8 contact_email_username_pop := AVE(GROUP,IF(propogated.contact_email_username  IN SET(s.nulls_contact_email_username,contact_email_username),0,100));
END;
EXPORT PostPropogationStats := TABLE(propogated,PostPropCounts);
SHARED h0 := DEDUP( SORT ( DISTRIBUTE(propogated,HASH(Seleid)),  EXCEPT rcid, LOCAL ), EXCEPT rcid, LOCAL );// Only one copy of each record
 
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT31.UIDType Seleid1;
  SALT31.UIDType Seleid2;
  SALT31.UIDType rcid1 := 0;
  SALT31.UIDType rcid2 := 0;
END;
EXPORT Layout_Attribute_Matches := RECORD(layout_matches),MAXLENGTH(32000)
  SALT31.StrType source_id;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0};
  INTEGER2 cnp_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_name_isnull := h0.cnp_name  IN SET(s.nulls_cnp_name,cnp_name); // Simplify later processing 
  UNSIGNED cnp_name_cnt := 0; // Number of instances with this particular field value
  UNSIGNED cnp_name_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 company_inc_state_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_inc_state_isnull := h0.company_inc_state  IN SET(s.nulls_company_inc_state,company_inc_state); // Simplify later processing 
  INTEGER2 company_charter_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_charter_number_isnull := h0.company_charter_number  IN SET(s.nulls_company_charter_number,company_charter_number); // Simplify later processing 
  UNSIGNED company_charter_number_cnt := 0; // Number of instances with this particular field value
  UNSIGNED company_charter_number_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 company_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_fein_isnull := h0.company_fein  IN SET(s.nulls_company_fein,company_fein); // Simplify later processing 
  INTEGER2 prim_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_isnull := h0.prim_range  IN SET(s.nulls_prim_range,prim_range); // Simplify later processing 
  INTEGER2 prim_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_isnull := h0.prim_name  IN SET(s.nulls_prim_name,prim_name); // Simplify later processing 
  INTEGER2 postdir_weight100 := 0; // Contains 100x the specificity
  BOOLEAN postdir_isnull := h0.postdir  IN SET(s.nulls_postdir,postdir); // Simplify later processing 
  INTEGER2 sec_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sec_range_isnull := h0.sec_range  IN SET(s.nulls_sec_range,sec_range); // Simplify later processing 
  INTEGER2 v_city_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN v_city_name_isnull := h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name); // Simplify later processing 
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := h0.st  IN SET(s.nulls_st,st); // Simplify later processing 
  INTEGER2 active_duns_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_duns_number_isnull := h0.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number); // Simplify later processing 
  INTEGER2 active_enterprise_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_enterprise_number_isnull := h0.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number); // Simplify later processing 
  INTEGER2 source_weight100 := 0; // Contains 100x the specificity
  BOOLEAN source_isnull := h0.source  IN SET(s.nulls_source,source); // Simplify later processing 
  INTEGER2 source_record_id_weight100 := 0; // Contains 100x the specificity
  BOOLEAN source_record_id_isnull := h0.source_record_id  IN SET(s.nulls_source_record_id,source_record_id); // Simplify later processing 
  INTEGER2 fname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN fname_isnull := h0.fname  IN SET(s.nulls_fname,fname); // Simplify later processing 
  INTEGER2 mname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN mname_isnull := h0.mname  IN SET(s.nulls_mname,mname); // Simplify later processing 
  INTEGER2 lname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN lname_isnull := h0.lname  IN SET(s.nulls_lname,lname); // Simplify later processing 
  INTEGER2 contact_ssn_weight100 := 0; // Contains 100x the specificity
  BOOLEAN contact_ssn_isnull := h0.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn); // Simplify later processing 
  INTEGER2 contact_phone_weight100 := 0; // Contains 100x the specificity
  BOOLEAN contact_phone_isnull := h0.contact_phone  IN SET(s.nulls_contact_phone,contact_phone); // Simplify later processing 
  INTEGER2 contact_email_username_weight100 := 0; // Contains 100x the specificity
  BOOLEAN contact_email_username_isnull := h0.contact_email_username  IN SET(s.nulls_contact_email_username,contact_email_username); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
 
//Would also create auto-id fields here
 
layout_candidates add_source(layout_candidates le,Specificities(ih).source_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.source_weight100 := MAP (le.source_isnull => 0, patch_default and ri.field_specificity=0 => s.source_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j19 := JOIN(h1,PULL(Specificities(ih).source_values_persisted),LEFT.source=RIGHT.source,add_source(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_st(layout_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j18 := JOIN(j19,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_st(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_postdir(layout_candidates le,Specificities(ih).postdir_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.postdir_weight100 := MAP (le.postdir_isnull => 0, patch_default and ri.field_specificity=0 => s.postdir_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j17 := JOIN(j18,PULL(Specificities(ih).postdir_values_persisted),LEFT.postdir=RIGHT.postdir,add_postdir(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_company_inc_state(layout_candidates le,Specificities(ih).company_inc_state_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_inc_state_weight100 := MAP (le.company_inc_state_isnull => 0, patch_default and ri.field_specificity=0 => s.company_inc_state_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j16 := JOIN(j17,PULL(Specificities(ih).company_inc_state_values_persisted),LEFT.company_inc_state=RIGHT.company_inc_state,add_company_inc_state(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_mname(layout_candidates le,Specificities(ih).mname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.mname_weight100 := MAP (le.mname_isnull => 0, patch_default and ri.field_specificity=0 => s.mname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT31.MAC_Choose_JoinType(j16,s.nulls_mname,Specificities(ih).mname_values_persisted,mname,mname_weight100,add_mname,j15);
layout_candidates add_fname(layout_candidates le,Specificities(ih).fname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.fname_weight100 := MAP (le.fname_isnull => 0, patch_default and ri.field_specificity=0 => s.fname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT31.MAC_Choose_JoinType(j15,s.nulls_fname,Specificities(ih).fname_values_persisted,fname,fname_weight100,add_fname,j14);
layout_candidates add_v_city_name(layout_candidates le,Specificities(ih).v_city_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.v_city_name_weight100 := MAP (le.v_city_name_isnull => 0, patch_default and ri.field_specificity=0 => s.v_city_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT31.MAC_Choose_JoinType(j14,s.nulls_v_city_name,Specificities(ih).v_city_name_values_persisted,v_city_name,v_city_name_weight100,add_v_city_name,j13);
layout_candidates add_sec_range(layout_candidates le,Specificities(ih).sec_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sec_range_weight100 := MAP (le.sec_range_isnull => 0, patch_default and ri.field_specificity=0 => s.sec_range_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT31.MAC_Choose_JoinType(j13,s.nulls_sec_range,Specificities(ih).sec_range_values_persisted,sec_range,sec_range_weight100,add_sec_range,j12);
layout_candidates add_prim_range(layout_candidates le,Specificities(ih).prim_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_weight100 := MAP (le.prim_range_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT31.MAC_Choose_JoinType(j12,s.nulls_prim_range,Specificities(ih).prim_range_values_persisted,prim_range,prim_range_weight100,add_prim_range,j11);
layout_candidates add_prim_name(layout_candidates le,Specificities(ih).prim_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_weight100 := MAP (le.prim_name_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT31.MAC_Choose_JoinType(j11,s.nulls_prim_name,Specificities(ih).prim_name_values_persisted,prim_name,prim_name_weight100,add_prim_name,j10);
layout_candidates add_lname(layout_candidates le,Specificities(ih).lname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.lname_weight100 := MAP (le.lname_isnull => 0, patch_default and ri.field_specificity=0 => s.lname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT31.MAC_Choose_JoinType(j10,s.nulls_lname,Specificities(ih).lname_values_persisted,lname,lname_weight100,add_lname,j9);
layout_candidates add_cnp_name(layout_candidates le,Specificities(ih).cnp_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_name_cnt := ri.cnt;
  SELF.cnp_name_e1_cnt := ri.e1_cnt;
  SELF.cnp_name_weight100 := MAP (le.cnp_name_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT31.MAC_Choose_JoinType(j9,s.nulls_cnp_name,Specificities(ih).cnp_name_values_persisted,cnp_name,cnp_name_weight100,add_cnp_name,j8);
layout_candidates add_contact_email_username(layout_candidates le,Specificities(ih).contact_email_username_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.contact_email_username_weight100 := MAP (le.contact_email_username_isnull => 0, patch_default and ri.field_specificity=0 => s.contact_email_username_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT31.MAC_Choose_JoinType(j8,s.nulls_contact_email_username,Specificities(ih).contact_email_username_values_persisted,contact_email_username,contact_email_username_weight100,add_contact_email_username,j7);
layout_candidates add_contact_phone(layout_candidates le,Specificities(ih).contact_phone_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.contact_phone_weight100 := MAP (le.contact_phone_isnull => 0, patch_default and ri.field_specificity=0 => s.contact_phone_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT31.MAC_Choose_JoinType(j7,s.nulls_contact_phone,Specificities(ih).contact_phone_values_persisted,contact_phone,contact_phone_weight100,add_contact_phone,j6);
layout_candidates add_contact_ssn(layout_candidates le,Specificities(ih).contact_ssn_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.contact_ssn_weight100 := MAP (le.contact_ssn_isnull => 0, patch_default and ri.field_specificity=0 => s.contact_ssn_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT31.MAC_Choose_JoinType(j6,s.nulls_contact_ssn,Specificities(ih).contact_ssn_values_persisted,contact_ssn,contact_ssn_weight100,add_contact_ssn,j5);
layout_candidates add_source_record_id(layout_candidates le,Specificities(ih).source_record_id_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.source_record_id_weight100 := MAP (le.source_record_id_isnull => 0, patch_default and ri.field_specificity=0 => s.source_record_id_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT31.MAC_Choose_JoinType(j5,s.nulls_source_record_id,Specificities(ih).source_record_id_values_persisted,source_record_id,source_record_id_weight100,add_source_record_id,j4);
layout_candidates add_company_fein(layout_candidates le,Specificities(ih).company_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_fein_weight100 := MAP (le.company_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.company_fein_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT31.MAC_Choose_JoinType(j4,s.nulls_company_fein,Specificities(ih).company_fein_values_persisted,company_fein,company_fein_weight100,add_company_fein,j3);
layout_candidates add_company_charter_number(layout_candidates le,Specificities(ih).company_charter_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_charter_number_cnt := ri.cnt;
  SELF.company_charter_number_e1_cnt := ri.e1_cnt;
  SELF.company_charter_number_weight100 := MAP (le.company_charter_number_isnull => 0, patch_default and ri.field_specificity=0 => s.company_charter_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT31.MAC_Choose_JoinType(j3,s.nulls_company_charter_number,Specificities(ih).company_charter_number_values_persisted,company_charter_number,company_charter_number_weight100,add_company_charter_number,j2);
layout_candidates add_active_enterprise_number(layout_candidates le,Specificities(ih).active_enterprise_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_enterprise_number_weight100 := MAP (le.active_enterprise_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_enterprise_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT31.MAC_Choose_JoinType(j2,s.nulls_active_enterprise_number,Specificities(ih).active_enterprise_number_values_persisted,active_enterprise_number,active_enterprise_number_weight100,add_active_enterprise_number,j1);
layout_candidates add_active_duns_number(layout_candidates le,Specificities(ih).active_duns_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_duns_number_weight100 := MAP (le.active_duns_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_duns_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT31.MAC_Choose_JoinType(j1,s.nulls_active_duns_number,Specificities(ih).active_duns_number_values_persisted,active_duns_number,active_duns_number_weight100,add_active_duns_number,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(Seleid)) : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::mc',EXPIRE(Config.PersistExpire)); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.active_duns_number_weight100 + Annotated.active_enterprise_number_weight100 + Annotated.company_charter_number_weight100 + Annotated.company_fein_weight100 + Annotated.source_record_id_weight100 + Annotated.contact_ssn_weight100 + Annotated.contact_phone_weight100 + Annotated.contact_email_username_weight100 + Annotated.cnp_name_weight100 + Annotated.lname_weight100 + Annotated.prim_name_weight100 + Annotated.prim_range_weight100 + Annotated.sec_range_weight100 + Annotated.v_city_name_weight100 + Annotated.fname_weight100 + Annotated.mname_weight100 + Annotated.company_inc_state_weight100 + Annotated.postdir_weight100 + Annotated.st_weight100 + Annotated.source_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
