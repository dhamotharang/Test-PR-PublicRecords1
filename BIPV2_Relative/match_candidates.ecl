// Begin code to produce match candidates
IMPORT SALT25,ut;
EXPORT match_candidates(DATASET(layout_DOT_Base) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := Specificities(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00,{rcid,company_name,cnp_name,corp_legal_name,cnp_hasnumber,cnp_number,cnp_btype,cnp_lowv,cnp_translated,cnp_classid,company_fein,company_inc_state,company_charter_number,company_bdid,company_phone,iscorp,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,Company_RAWAID,company_csz,company_addr1,company_address,active_duns_number,active_enterprise_number,active_domestic_corp_key,source,source_record_id,isContact,title,fname,mname,lname,name_suffix,contact_ssn,contact_phone,contact_email,contact_job_title_raw,company_department,contact_email_username,dt_first_seen,dt_last_seen,Proxid}),HASH(Proxid));
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 cnp_name_pop := AVE(GROUP,IF(thin_table.cnp_name IN SET(s.nulls_cnp_name,cnp_name),0,100));
  REAL8 corp_legal_name_pop := AVE(GROUP,IF(thin_table.corp_legal_name IN SET(s.nulls_corp_legal_name,corp_legal_name),0,100));
  REAL8 cnp_hasnumber_pop := AVE(GROUP,IF(thin_table.cnp_hasnumber IN SET(s.nulls_cnp_hasnumber,cnp_hasnumber),0,100));
  REAL8 cnp_number_pop := AVE(GROUP,IF(thin_table.cnp_number IN SET(s.nulls_cnp_number,cnp_number),0,100));
  REAL8 cnp_btype_pop := AVE(GROUP,IF(thin_table.cnp_btype IN SET(s.nulls_cnp_btype,cnp_btype),0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF(thin_table.company_fein IN SET(s.nulls_company_fein,company_fein),0,100));
  REAL8 company_inc_state_pop := AVE(GROUP,IF(thin_table.company_inc_state IN SET(s.nulls_company_inc_state,company_inc_state),0,100));
  REAL8 company_charter_number_pop := AVE(GROUP,IF(thin_table.company_charter_number IN SET(s.nulls_company_charter_number,company_charter_number),0,100));
  REAL8 iscorp_pop := AVE(GROUP,IF(thin_table.iscorp IN SET(s.nulls_iscorp,iscorp),0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF(thin_table.prim_range IN SET(s.nulls_prim_range,prim_range),0,100));
  REAL8 predir_pop := AVE(GROUP,IF(thin_table.predir IN SET(s.nulls_predir,predir),0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF(thin_table.prim_name IN SET(s.nulls_prim_name,prim_name),0,100));
  REAL8 addr_suffix_pop := AVE(GROUP,IF(thin_table.addr_suffix IN SET(s.nulls_addr_suffix,addr_suffix),0,100));
  REAL8 postdir_pop := AVE(GROUP,IF(thin_table.postdir IN SET(s.nulls_postdir,postdir),0,100));
  REAL8 sec_range_pop := AVE(GROUP,IF(thin_table.sec_range IN SET(s.nulls_sec_range,sec_range),0,100));
  REAL8 p_city_name_pop := AVE(GROUP,IF(thin_table.p_city_name IN SET(s.nulls_p_city_name,p_city_name),0,100));
  REAL8 v_city_name_pop := AVE(GROUP,IF(thin_table.v_city_name IN SET(s.nulls_v_city_name,v_city_name),0,100));
  REAL8 st_pop := AVE(GROUP,IF(thin_table.st IN SET(s.nulls_st,st),0,100));
  REAL8 zip_pop := AVE(GROUP,IF(thin_table.zip IN SET(s.nulls_zip,zip),0,100));
  REAL8 zip4_pop := AVE(GROUP,IF(thin_table.zip4 IN SET(s.nulls_zip4,zip4),0,100));
  REAL8 company_csz_pop := AVE(GROUP,IF(thin_table.company_csz IN SET(s.nulls_company_csz,company_csz),0,100));
  REAL8 company_addr1_pop := AVE(GROUP,IF(thin_table.company_addr1 IN SET(s.nulls_company_addr1,company_addr1),0,100));
  REAL8 company_address_pop := AVE(GROUP,IF(thin_table.company_address IN SET(s.nulls_company_address,company_address),0,100));
  REAL8 active_duns_number_pop := AVE(GROUP,IF(thin_table.active_duns_number IN SET(s.nulls_active_duns_number,active_duns_number),0,100));
  REAL8 active_enterprise_number_pop := AVE(GROUP,IF(thin_table.active_enterprise_number IN SET(s.nulls_active_enterprise_number,active_enterprise_number),0,100));
  REAL8 active_domestic_corp_key_pop := AVE(GROUP,IF(thin_table.active_domestic_corp_key IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key),0,100));
  REAL8 source_pop := AVE(GROUP,IF(thin_table.source IN SET(s.nulls_source,source),0,100));
  REAL8 source_record_id_pop := AVE(GROUP,IF(thin_table.source_record_id IN SET(s.nulls_source_record_id,source_record_id),0,100));
  REAL8 fname_pop := AVE(GROUP,IF(thin_table.fname IN SET(s.nulls_fname,fname),0,100));
  REAL8 mname_pop := AVE(GROUP,IF(thin_table.mname IN SET(s.nulls_mname,mname),0,100));
  REAL8 lname_pop := AVE(GROUP,IF(thin_table.lname IN SET(s.nulls_lname,lname),0,100));
  REAL8 contact_ssn_pop := AVE(GROUP,IF(thin_table.contact_ssn IN SET(s.nulls_contact_ssn,contact_ssn),0,100));
  REAL8 contact_phone_pop := AVE(GROUP,IF(thin_table.contact_phone IN SET(s.nulls_contact_phone,contact_phone),0,100));
  REAL8 contact_email_username_pop := AVE(GROUP,IF(thin_table.contact_email_username IN SET(s.nulls_contact_email_username,contact_email_username),0,100));
END;
EXPORT PrePropogationStats := TABLE(thin_table,PrePropCounts);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 corp_legal_name_prop := 0;
  UNSIGNED1 company_fein_prop := 0;
  UNSIGNED1 company_inc_state_prop := 0;
  UNSIGNED1 company_charter_number_prop := 0;
  UNSIGNED1 iscorp_prop := 0;
  UNSIGNED1 prim_range_prop := 0;
  UNSIGNED1 prim_name_prop := 0;
  UNSIGNED1 sec_range_prop := 0;
  UNSIGNED1 v_city_name_prop := 0;
  UNSIGNED1 st_prop := 0;
  UNSIGNED1 zip_prop := 0;
  UNSIGNED1 company_csz_prop := 0;
  UNSIGNED1 company_addr1_prop := 0;
  UNSIGNED1 company_address_prop := 0;
  UNSIGNED1 active_duns_number_prop := 0;
  UNSIGNED1 active_enterprise_number_prop := 0;
  UNSIGNED1 active_domestic_corp_key_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
// Now generate code for basis :Proxid
// There are 3 best types that we can propogate from this basis which means we will not need to use this basis again
  Layout_WithPropVars T_UniqueSingleValue_3_0(Layout_WithPropVars le,Best(ih).BestBy_Proxid_best ri) := TRANSFORM
    SELF.active_duns_number := MAP ( le.active_duns_number_prop > 0 OR le.active_duns_number = ri.active_duns_number OR ri.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) => le.active_duns_number, // No propogation
      le.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) => ri.active_duns_number, // If the field is presently null then any prop-method is good enough
      le.active_duns_number);
    SELF.active_duns_number_prop := IF ( le.active_duns_number = SELF.active_duns_number, le.active_duns_number_prop,1); // Flag the propagation for sliceouts
    SELF.active_enterprise_number := MAP ( le.active_enterprise_number_prop > 0 OR le.active_enterprise_number = ri.active_enterprise_number OR ri.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number) => le.active_enterprise_number, // No propogation
      le.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number) => ri.active_enterprise_number, // If the field is presently null then any prop-method is good enough
      le.active_enterprise_number);
    SELF.active_enterprise_number_prop := IF ( le.active_enterprise_number = SELF.active_enterprise_number, le.active_enterprise_number_prop,1); // Flag the propagation for sliceouts
    SELF.active_domestic_corp_key := MAP ( le.active_domestic_corp_key_prop > 0 OR le.active_domestic_corp_key = ri.active_domestic_corp_key OR ri.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) => le.active_domestic_corp_key, // No propogation
      le.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key) => ri.active_domestic_corp_key, // If the field is presently null then any prop-method is good enough
      le.active_domestic_corp_key);
    SELF.active_domestic_corp_key_prop := IF ( le.active_domestic_corp_key = SELF.active_domestic_corp_key, le.active_domestic_corp_key_prop,1); // Flag the propagation for sliceouts
    SELF := le;
  END;
SHARED P_UniqueSingleValue_3_0 := JOIN(with_props(Proxid <> 0),Best(ih).BestBy_Proxid_best, LEFT.Proxid = RIGHT.Proxid ,T_UniqueSingleValue_3_0(LEFT,RIGHT),LEFT OUTER,HASH)
                 + with_props(Proxid = 0);
SALT25.mac_prop_field(with_props(corp_legal_name NOT IN SET(s.nulls_corp_legal_name,corp_legal_name)),corp_legal_name,Proxid,corp_legal_name_props); // For every DID find the best FULL corp_legal_name
layout_withpropvars take_corp_legal_name(with_props le,corp_legal_name_props ri) := TRANSFORM
  SELF.corp_legal_name := IF ( le.corp_legal_name IN SET(s.nulls_corp_legal_name,corp_legal_name) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.corp_legal_name, le.corp_legal_name );
  SELF.corp_legal_name_prop := le.corp_legal_name_prop + IF ( le.corp_legal_name IN SET(s.nulls_corp_legal_name,corp_legal_name) and ri.corp_legal_name NOT IN SET(s.nulls_corp_legal_name,corp_legal_name) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj2 := JOIN(P_UniqueSingleValue_3_0,corp_legal_name_props,left.Proxid=right.Proxid,take_corp_legal_name(left,right),LEFT OUTER,HASH);
SALT25.mac_prop_field(with_props(company_fein NOT IN SET(s.nulls_company_fein,company_fein)),company_fein,Proxid,company_fein_props); // For every DID find the best FULL company_fein
layout_withpropvars take_company_fein(with_props le,company_fein_props ri) := TRANSFORM
  SELF.company_fein := IF ( le.company_fein IN SET(s.nulls_company_fein,company_fein) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.company_fein, le.company_fein );
  SELF.company_fein_prop := le.company_fein_prop + IF ( le.company_fein IN SET(s.nulls_company_fein,company_fein) and ri.company_fein NOT IN SET(s.nulls_company_fein,company_fein) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj9 := JOIN(pj2,company_fein_props,left.Proxid=right.Proxid,take_company_fein(left,right),LEFT OUTER,HASH);
SALT25.mac_prop_field(with_props(company_inc_state NOT IN SET(s.nulls_company_inc_state,company_inc_state)),company_inc_state,Proxid,company_inc_state_props); // For every DID find the best FULL company_inc_state
layout_withpropvars take_company_inc_state(with_props le,company_inc_state_props ri) := TRANSFORM
  SELF.company_inc_state := IF ( le.company_inc_state IN SET(s.nulls_company_inc_state,company_inc_state) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.company_inc_state, le.company_inc_state );
  SELF.company_inc_state_prop := le.company_inc_state_prop + IF ( le.company_inc_state IN SET(s.nulls_company_inc_state,company_inc_state) and ri.company_inc_state NOT IN SET(s.nulls_company_inc_state,company_inc_state) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj10 := JOIN(pj9,company_inc_state_props,left.Proxid=right.Proxid,take_company_inc_state(left,right),LEFT OUTER,HASH);
SALT25.mac_prop_field(with_props(company_charter_number NOT IN SET(s.nulls_company_charter_number,company_charter_number)),company_charter_number,Proxid,company_charter_number_props); // For every DID find the best FULL company_charter_number
layout_withpropvars take_company_charter_number(with_props le,company_charter_number_props ri) := TRANSFORM
  SELF.company_charter_number := IF ( le.company_charter_number IN SET(s.nulls_company_charter_number,company_charter_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.company_charter_number, le.company_charter_number );
  SELF.company_charter_number_prop := le.company_charter_number_prop + IF ( le.company_charter_number IN SET(s.nulls_company_charter_number,company_charter_number) and ri.company_charter_number NOT IN SET(s.nulls_company_charter_number,company_charter_number) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj11 := JOIN(pj10,company_charter_number_props,left.Proxid=right.Proxid,take_company_charter_number(left,right),LEFT OUTER,HASH);
SALT25.mac_prop_field(with_props(iscorp NOT IN SET(s.nulls_iscorp,iscorp)),iscorp,Proxid,iscorp_props); // For every DID find the best FULL iscorp
layout_withpropvars take_iscorp(with_props le,iscorp_props ri) := TRANSFORM
  SELF.iscorp := IF ( le.iscorp IN SET(s.nulls_iscorp,iscorp) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.iscorp, le.iscorp );
  SELF.iscorp_prop := le.iscorp_prop + IF ( le.iscorp IN SET(s.nulls_iscorp,iscorp) and ri.iscorp NOT IN SET(s.nulls_iscorp,iscorp) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj14 := JOIN(pj11,iscorp_props,left.Proxid=right.Proxid,take_iscorp(left,right),LEFT OUTER,HASH);
SALT25.mac_prop_field(with_props(sec_range NOT IN SET(s.nulls_sec_range,sec_range)),sec_range,Proxid,sec_range_props); // For every DID find the best FULL sec_range
layout_withpropvars take_sec_range(with_props le,sec_range_props ri) := TRANSFORM
  SELF.sec_range := IF ( le.sec_range IN SET(s.nulls_sec_range,sec_range) and ri.Proxid<>(TYPEOF(ri.Proxid))'', ri.sec_range, le.sec_range );
  SELF.sec_range_prop := le.sec_range_prop + IF ( le.sec_range IN SET(s.nulls_sec_range,sec_range) and ri.sec_range NOT IN SET(s.nulls_sec_range,sec_range) and ri.Proxid<>(TYPEOF(ri.Proxid))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj21 := JOIN(pj14,sec_range_props,left.Proxid=right.Proxid,take_sec_range(left,right),LEFT OUTER,HASH);
pj21 do_computes(pj21 le) := TRANSFORM
  SELF.company_csz := HASH32((SALT25.StrType)le.v_city_name,(SALT25.StrType)le.st,(SALT25.StrType)le.zip); // Combine child fields into 1 for specificity counting
  SELF.company_addr1 := HASH32((SALT25.StrType)le.prim_range,(SALT25.StrType)le.prim_name,(SALT25.StrType)le.sec_range); // Combine child fields into 1 for specificity counting
  self.company_addr1_prop := IF( le.sec_range_prop > 0, 4, 0 );
  SELF.company_address := HASH32((SALT25.StrType)SELF.company_addr1,(SALT25.StrType)SELF.company_csz); // Combine child fields into 1 for specificity counting
  self.company_address_prop := IF( self.company_addr1_prop > 0, 1, 0 );
  SELF := le;
END;
SHARED propogated := PROJECT(pj21,do_computes(left)) : PERSIST('temp::BIPV2_Relative_Proxid_DOT_Base_mc_props'); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 cnp_name_pop := AVE(GROUP,IF(propogated.cnp_name IN SET(s.nulls_cnp_name,cnp_name),0,100));
  REAL8 corp_legal_name_pop := AVE(GROUP,IF(propogated.corp_legal_name IN SET(s.nulls_corp_legal_name,corp_legal_name),0,100));
  REAL8 cnp_hasnumber_pop := AVE(GROUP,IF(propogated.cnp_hasnumber IN SET(s.nulls_cnp_hasnumber,cnp_hasnumber),0,100));
  REAL8 cnp_number_pop := AVE(GROUP,IF(propogated.cnp_number IN SET(s.nulls_cnp_number,cnp_number),0,100));
  REAL8 cnp_btype_pop := AVE(GROUP,IF(propogated.cnp_btype IN SET(s.nulls_cnp_btype,cnp_btype),0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF(propogated.company_fein IN SET(s.nulls_company_fein,company_fein),0,100));
  REAL8 company_inc_state_pop := AVE(GROUP,IF(propogated.company_inc_state IN SET(s.nulls_company_inc_state,company_inc_state),0,100));
  REAL8 company_charter_number_pop := AVE(GROUP,IF(propogated.company_charter_number IN SET(s.nulls_company_charter_number,company_charter_number),0,100));
  REAL8 iscorp_pop := AVE(GROUP,IF(propogated.iscorp IN SET(s.nulls_iscorp,iscorp),0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF(propogated.prim_range IN SET(s.nulls_prim_range,prim_range),0,100));
  REAL8 predir_pop := AVE(GROUP,IF(propogated.predir IN SET(s.nulls_predir,predir),0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF(propogated.prim_name IN SET(s.nulls_prim_name,prim_name),0,100));
  REAL8 addr_suffix_pop := AVE(GROUP,IF(propogated.addr_suffix IN SET(s.nulls_addr_suffix,addr_suffix),0,100));
  REAL8 postdir_pop := AVE(GROUP,IF(propogated.postdir IN SET(s.nulls_postdir,postdir),0,100));
  REAL8 sec_range_pop := AVE(GROUP,IF(propogated.sec_range IN SET(s.nulls_sec_range,sec_range),0,100));
  REAL8 p_city_name_pop := AVE(GROUP,IF(propogated.p_city_name IN SET(s.nulls_p_city_name,p_city_name),0,100));
  REAL8 v_city_name_pop := AVE(GROUP,IF(propogated.v_city_name IN SET(s.nulls_v_city_name,v_city_name),0,100));
  REAL8 st_pop := AVE(GROUP,IF(propogated.st IN SET(s.nulls_st,st),0,100));
  REAL8 zip_pop := AVE(GROUP,IF(propogated.zip IN SET(s.nulls_zip,zip),0,100));
  REAL8 zip4_pop := AVE(GROUP,IF(propogated.zip4 IN SET(s.nulls_zip4,zip4),0,100));
  REAL8 company_csz_pop := AVE(GROUP,IF(propogated.company_csz IN SET(s.nulls_company_csz,company_csz),0,100));
  REAL8 company_addr1_pop := AVE(GROUP,IF(propogated.company_addr1 IN SET(s.nulls_company_addr1,company_addr1),0,100));
  REAL8 company_address_pop := AVE(GROUP,IF(propogated.company_address IN SET(s.nulls_company_address,company_address),0,100));
  REAL8 active_duns_number_pop := AVE(GROUP,IF(propogated.active_duns_number IN SET(s.nulls_active_duns_number,active_duns_number),0,100));
  REAL8 active_enterprise_number_pop := AVE(GROUP,IF(propogated.active_enterprise_number IN SET(s.nulls_active_enterprise_number,active_enterprise_number),0,100));
  REAL8 active_domestic_corp_key_pop := AVE(GROUP,IF(propogated.active_domestic_corp_key IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key),0,100));
  REAL8 source_pop := AVE(GROUP,IF(propogated.source IN SET(s.nulls_source,source),0,100));
  REAL8 source_record_id_pop := AVE(GROUP,IF(propogated.source_record_id IN SET(s.nulls_source_record_id,source_record_id),0,100));
  REAL8 fname_pop := AVE(GROUP,IF(propogated.fname IN SET(s.nulls_fname,fname),0,100));
  REAL8 mname_pop := AVE(GROUP,IF(propogated.mname IN SET(s.nulls_mname,mname),0,100));
  REAL8 lname_pop := AVE(GROUP,IF(propogated.lname IN SET(s.nulls_lname,lname),0,100));
  REAL8 contact_ssn_pop := AVE(GROUP,IF(propogated.contact_ssn IN SET(s.nulls_contact_ssn,contact_ssn),0,100));
  REAL8 contact_phone_pop := AVE(GROUP,IF(propogated.contact_phone IN SET(s.nulls_contact_phone,contact_phone),0,100));
  REAL8 contact_email_username_pop := AVE(GROUP,IF(propogated.contact_email_username IN SET(s.nulls_contact_email_username,contact_email_username),0,100));
END;
EXPORT PostPropogationStats := TABLE(propogated,PostPropCounts);
SHARED h0 := DEDUP( SORT ( DISTRIBUTE(propogated,HASH(Proxid)), WHOLE RECORD, LOCAL ), WHOLE RECORD, LOCAL );// Only one copy of each record
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT25.UIDType Proxid1;
  SALT25.UIDType Proxid2;
  SALT25.UIDType rcid1 := 0;
  SALT25.UIDType rcid2 := 0;
END;
EXPORT Layout_Attribute_Matches := RECORD(layout_matches),MAXLENGTH(32000)
  SALT25.StrType source_id;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0};
  INTEGER2 cnp_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_name_isnull := h0.cnp_name  IN SET(s.nulls_cnp_name,cnp_name); // Simplify later processing 
  UNSIGNED cnp_name_cnt := 0; // Number of instances with this particular field value
  UNSIGNED cnp_name_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 corp_legal_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN corp_legal_name_isnull := h0.corp_legal_name  IN SET(s.nulls_corp_legal_name,corp_legal_name); // Simplify later processing 
  UNSIGNED corp_legal_name_cnt := 0; // Number of instances with this particular field value
  UNSIGNED corp_legal_name_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 cnp_hasnumber_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_hasnumber_isnull := h0.cnp_hasnumber  IN SET(s.nulls_cnp_hasnumber,cnp_hasnumber); // Simplify later processing 
  INTEGER2 cnp_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_number_isnull := h0.cnp_number  IN SET(s.nulls_cnp_number,cnp_number); // Simplify later processing 
  INTEGER2 cnp_btype_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_btype_isnull := h0.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype); // Simplify later processing 
  INTEGER2 company_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_fein_isnull := h0.company_fein  IN SET(s.nulls_company_fein,company_fein); // Simplify later processing 
  INTEGER2 company_inc_state_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_inc_state_isnull := h0.company_inc_state  IN SET(s.nulls_company_inc_state,company_inc_state); // Simplify later processing 
  INTEGER2 company_charter_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_charter_number_isnull := h0.company_charter_number  IN SET(s.nulls_company_charter_number,company_charter_number); // Simplify later processing 
  UNSIGNED company_charter_number_cnt := 0; // Number of instances with this particular field value
  UNSIGNED company_charter_number_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 iscorp_weight100 := 0; // Contains 100x the specificity
  BOOLEAN iscorp_isnull := h0.iscorp  IN SET(s.nulls_iscorp,iscorp); // Simplify later processing 
  INTEGER2 prim_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_isnull := h0.prim_range  IN SET(s.nulls_prim_range,prim_range); // Simplify later processing 
  INTEGER2 predir_weight100 := 0; // Contains 100x the specificity
  BOOLEAN predir_isnull := h0.predir  IN SET(s.nulls_predir,predir); // Simplify later processing 
  INTEGER2 prim_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_isnull := h0.prim_name  IN SET(s.nulls_prim_name,prim_name); // Simplify later processing 
  INTEGER2 addr_suffix_weight100 := 0; // Contains 100x the specificity
  BOOLEAN addr_suffix_isnull := h0.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix); // Simplify later processing 
  INTEGER2 postdir_weight100 := 0; // Contains 100x the specificity
  BOOLEAN postdir_isnull := h0.postdir  IN SET(s.nulls_postdir,postdir); // Simplify later processing 
  INTEGER2 sec_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sec_range_isnull := h0.sec_range  IN SET(s.nulls_sec_range,sec_range); // Simplify later processing 
  INTEGER2 p_city_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN p_city_name_isnull := h0.p_city_name  IN SET(s.nulls_p_city_name,p_city_name); // Simplify later processing 
  INTEGER2 v_city_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN v_city_name_isnull := h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name); // Simplify later processing 
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := h0.st  IN SET(s.nulls_st,st); // Simplify later processing 
  INTEGER2 zip_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip_isnull := h0.zip  IN SET(s.nulls_zip,zip); // Simplify later processing 
  INTEGER2 zip4_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip4_isnull := h0.zip4  IN SET(s.nulls_zip4,zip4); // Simplify later processing 
  INTEGER2 company_csz_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_csz_isnull := (h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) AND h0.st  IN SET(s.nulls_st,st) AND h0.zip  IN SET(s.nulls_zip,zip)); // Simplify later processing 
  INTEGER2 company_addr1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_addr1_isnull := (h0.prim_range  IN SET(s.nulls_prim_range,prim_range) AND h0.prim_name  IN SET(s.nulls_prim_name,prim_name) AND h0.sec_range  IN SET(s.nulls_sec_range,sec_range)); // Simplify later processing 
  INTEGER2 company_address_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_address_isnull := ((h0.prim_range  IN SET(s.nulls_prim_range,prim_range) AND h0.prim_name  IN SET(s.nulls_prim_name,prim_name) AND h0.sec_range  IN SET(s.nulls_sec_range,sec_range)) AND (h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) AND h0.st  IN SET(s.nulls_st,st) AND h0.zip  IN SET(s.nulls_zip,zip))); // Simplify later processing 
  INTEGER2 active_duns_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_duns_number_isnull := h0.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number); // Simplify later processing 
  INTEGER2 active_enterprise_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_enterprise_number_isnull := h0.active_enterprise_number  IN SET(s.nulls_active_enterprise_number,active_enterprise_number); // Simplify later processing 
  INTEGER2 active_domestic_corp_key_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_domestic_corp_key_isnull := h0.active_domestic_corp_key  IN SET(s.nulls_active_domestic_corp_key,active_domestic_corp_key); // Simplify later processing 
  UNSIGNED active_domestic_corp_key_cnt := 0; // Number of instances with this particular field value
  UNSIGNED active_domestic_corp_key_e1_cnt := 0; // Number of names instances matching this one by edit distance
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
layout_candidates add_contact_email_username(layout_candidates le,Specificities(ih).contact_email_username_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.contact_email_username_weight100 := MAP (le.contact_email_username_isnull => 0, patch_default and ri.field_specificity=0 => s.contact_email_username_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j47 := JOIN(h1,PULL(Specificities(ih).contact_email_username_values_persisted),LEFT.contact_email_username=RIGHT.contact_email_username,add_contact_email_username(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_cnp_hasnumber(layout_candidates le,Specificities(ih).cnp_hasnumber_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_hasnumber_weight100 := MAP (le.cnp_hasnumber_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_hasnumber_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j33 := JOIN(j47,PULL(Specificities(ih).cnp_hasnumber_values_persisted),LEFT.cnp_hasnumber=RIGHT.cnp_hasnumber,add_cnp_hasnumber(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_iscorp(layout_candidates le,Specificities(ih).iscorp_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.iscorp_weight100 := MAP (le.iscorp_isnull => 0, patch_default and ri.field_specificity=0 => s.iscorp_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j31 := JOIN(j33,PULL(Specificities(ih).iscorp_values_persisted),LEFT.iscorp=RIGHT.iscorp,add_iscorp(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_source(layout_candidates le,Specificities(ih).source_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.source_weight100 := MAP (le.source_isnull => 0, patch_default and ri.field_specificity=0 => s.source_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j30 := JOIN(j31,PULL(Specificities(ih).source_values_persisted),LEFT.source=RIGHT.source,add_source(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_cnp_btype(layout_candidates le,Specificities(ih).cnp_btype_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_btype_weight100 := MAP (le.cnp_btype_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_btype_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j29 := JOIN(j30,PULL(Specificities(ih).cnp_btype_values_persisted),LEFT.cnp_btype=RIGHT.cnp_btype,add_cnp_btype(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_addr_suffix(layout_candidates le,Specificities(ih).addr_suffix_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.addr_suffix_weight100 := MAP (le.addr_suffix_isnull => 0, patch_default and ri.field_specificity=0 => s.addr_suffix_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j28 := JOIN(j29,PULL(Specificities(ih).addr_suffix_values_persisted),LEFT.addr_suffix=RIGHT.addr_suffix,add_addr_suffix(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_predir(layout_candidates le,Specificities(ih).predir_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.predir_weight100 := MAP (le.predir_isnull => 0, patch_default and ri.field_specificity=0 => s.predir_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j27 := JOIN(j28,PULL(Specificities(ih).predir_values_persisted),LEFT.predir=RIGHT.predir,add_predir(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_st(layout_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j26 := JOIN(j27,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_st(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_postdir(layout_candidates le,Specificities(ih).postdir_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.postdir_weight100 := MAP (le.postdir_isnull => 0, patch_default and ri.field_specificity=0 => s.postdir_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j25 := JOIN(j26,PULL(Specificities(ih).postdir_values_persisted),LEFT.postdir=RIGHT.postdir,add_postdir(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_mname(layout_candidates le,Specificities(ih).mname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.mname_weight100 := MAP (le.mname_isnull => 0, patch_default and ri.field_specificity=0 => s.mname_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j25,s.nulls_mname,Specificities(ih).mname_values_persisted,mname,mname_weight100,add_mname,j24);
layout_candidates add_company_inc_state(layout_candidates le,Specificities(ih).company_inc_state_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_inc_state_weight100 := MAP (le.company_inc_state_isnull => 0, patch_default and ri.field_specificity=0 => s.company_inc_state_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j24,s.nulls_company_inc_state,Specificities(ih).company_inc_state_values_persisted,company_inc_state,company_inc_state_weight100,add_company_inc_state,j23);
layout_candidates add_fname(layout_candidates le,Specificities(ih).fname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.fname_weight100 := MAP (le.fname_isnull => 0, patch_default and ri.field_specificity=0 => s.fname_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j23,s.nulls_fname,Specificities(ih).fname_values_persisted,fname,fname_weight100,add_fname,j22);
layout_candidates add_v_city_name(layout_candidates le,Specificities(ih).v_city_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.v_city_name_weight100 := MAP (le.v_city_name_isnull => 0, patch_default and ri.field_specificity=0 => s.v_city_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j22,s.nulls_v_city_name,Specificities(ih).v_city_name_values_persisted,v_city_name,v_city_name_weight100,add_v_city_name,j21);
layout_candidates add_p_city_name(layout_candidates le,Specificities(ih).p_city_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.p_city_name_weight100 := MAP (le.p_city_name_isnull => 0, patch_default and ri.field_specificity=0 => s.p_city_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j21,s.nulls_p_city_name,Specificities(ih).p_city_name_values_persisted,p_city_name,p_city_name_weight100,add_p_city_name,j20);
layout_candidates add_cnp_number(layout_candidates le,Specificities(ih).cnp_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_number_weight100 := MAP (le.cnp_number_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j20,s.nulls_cnp_number,Specificities(ih).cnp_number_values_persisted,cnp_number,cnp_number_weight100,add_cnp_number,j19);
layout_candidates add_sec_range(layout_candidates le,Specificities(ih).sec_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sec_range_weight100 := MAP (le.sec_range_isnull => 0, patch_default and ri.field_specificity=0 => s.sec_range_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j19,s.nulls_sec_range,Specificities(ih).sec_range_values_persisted,sec_range,sec_range_weight100,add_sec_range,j18);
layout_candidates add_zip4(layout_candidates le,Specificities(ih).zip4_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip4_weight100 := MAP (le.zip4_isnull => 0, patch_default and ri.field_specificity=0 => s.zip4_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j18,s.nulls_zip4,Specificities(ih).zip4_values_persisted,zip4,zip4_weight100,add_zip4,j17);
layout_candidates add_prim_range(layout_candidates le,Specificities(ih).prim_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_weight100 := MAP (le.prim_range_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j17,s.nulls_prim_range,Specificities(ih).prim_range_values_persisted,prim_range,prim_range_weight100,add_prim_range,j16);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip_weight100 := MAP (le.zip_isnull => 0, patch_default and ri.field_specificity=0 => s.zip_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j16,s.nulls_zip,Specificities(ih).zip_values_persisted,zip,zip_weight100,add_zip,j15);
layout_candidates add_lname(layout_candidates le,Specificities(ih).lname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.lname_weight100 := MAP (le.lname_isnull => 0, patch_default and ri.field_specificity=0 => s.lname_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j15,s.nulls_lname,Specificities(ih).lname_values_persisted,lname,lname_weight100,add_lname,j14);
layout_candidates add_prim_name(layout_candidates le,Specificities(ih).prim_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_weight100 := MAP (le.prim_name_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j14,s.nulls_prim_name,Specificities(ih).prim_name_values_persisted,prim_name,prim_name_weight100,add_prim_name,j13);
layout_candidates add_company_csz(layout_candidates le,Specificities(ih).company_csz_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_csz_weight100 := MAP (le.company_csz_isnull => 0, patch_default and ri.field_specificity=0 => s.company_csz_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j13,s.nulls_company_csz,Specificities(ih).company_csz_values_persisted,company_csz,company_csz_weight100,add_company_csz,j12);
layout_candidates add_company_addr1(layout_candidates le,Specificities(ih).company_addr1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_addr1_weight100 := MAP (le.company_addr1_isnull => 0, patch_default and ri.field_specificity=0 => s.company_addr1_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j12,s.nulls_company_addr1,Specificities(ih).company_addr1_values_persisted,company_addr1,company_addr1_weight100,add_company_addr1,j11);
layout_candidates add_company_address(layout_candidates le,Specificities(ih).company_address_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_address_weight100 := MAP (le.company_address_isnull => 0, patch_default and ri.field_specificity=0 => s.company_address_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j11,s.nulls_company_address,Specificities(ih).company_address_values_persisted,company_address,company_address_weight100,add_company_address,j10);
layout_candidates add_corp_legal_name(layout_candidates le,Specificities(ih).corp_legal_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.corp_legal_name_cnt := ri.cnt;
  SELF.corp_legal_name_e1_cnt := ri.e1_cnt;
  SELF.corp_legal_name_weight100 := MAP (le.corp_legal_name_isnull => 0, patch_default and ri.field_specificity=0 => s.corp_legal_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j10,s.nulls_corp_legal_name,Specificities(ih).corp_legal_name_values_persisted,corp_legal_name,corp_legal_name_weight100,add_corp_legal_name,j9);
layout_candidates add_cnp_name(layout_candidates le,Specificities(ih).cnp_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_name_cnt := ri.cnt;
  SELF.cnp_name_e1_cnt := ri.e1_cnt;
  SELF.cnp_name_weight100 := MAP (le.cnp_name_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j9,s.nulls_cnp_name,Specificities(ih).cnp_name_values_persisted,cnp_name,cnp_name_weight100,add_cnp_name,j8);
layout_candidates add_contact_phone(layout_candidates le,Specificities(ih).contact_phone_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.contact_phone_weight100 := MAP (le.contact_phone_isnull => 0, patch_default and ri.field_specificity=0 => s.contact_phone_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j8,s.nulls_contact_phone,Specificities(ih).contact_phone_values_persisted,contact_phone,contact_phone_weight100,add_contact_phone,j7);
layout_candidates add_active_domestic_corp_key(layout_candidates le,Specificities(ih).active_domestic_corp_key_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_domestic_corp_key_cnt := ri.cnt;
  SELF.active_domestic_corp_key_e1_cnt := ri.e1_cnt;
  SELF.active_domestic_corp_key_weight100 := MAP (le.active_domestic_corp_key_isnull => 0, patch_default and ri.field_specificity=0 => s.active_domestic_corp_key_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j7,s.nulls_active_domestic_corp_key,Specificities(ih).active_domestic_corp_key_values_persisted,active_domestic_corp_key,active_domestic_corp_key_weight100,add_active_domestic_corp_key,j6);
layout_candidates add_active_duns_number(layout_candidates le,Specificities(ih).active_duns_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_duns_number_weight100 := MAP (le.active_duns_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_duns_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j6,s.nulls_active_duns_number,Specificities(ih).active_duns_number_values_persisted,active_duns_number,active_duns_number_weight100,add_active_duns_number,j5);
layout_candidates add_company_charter_number(layout_candidates le,Specificities(ih).company_charter_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_charter_number_cnt := ri.cnt;
  SELF.company_charter_number_e1_cnt := ri.e1_cnt;
  SELF.company_charter_number_weight100 := MAP (le.company_charter_number_isnull => 0, patch_default and ri.field_specificity=0 => s.company_charter_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j5,s.nulls_company_charter_number,Specificities(ih).company_charter_number_values_persisted,company_charter_number,company_charter_number_weight100,add_company_charter_number,j4);
layout_candidates add_company_fein(layout_candidates le,Specificities(ih).company_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_fein_weight100 := MAP (le.company_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.company_fein_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j4,s.nulls_company_fein,Specificities(ih).company_fein_values_persisted,company_fein,company_fein_weight100,add_company_fein,j3);
layout_candidates add_contact_ssn(layout_candidates le,Specificities(ih).contact_ssn_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.contact_ssn_weight100 := MAP (le.contact_ssn_isnull => 0, patch_default and ri.field_specificity=0 => s.contact_ssn_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j3,s.nulls_contact_ssn,Specificities(ih).contact_ssn_values_persisted,contact_ssn,contact_ssn_weight100,add_contact_ssn,j2);
layout_candidates add_source_record_id(layout_candidates le,Specificities(ih).source_record_id_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.source_record_id_weight100 := MAP (le.source_record_id_isnull => 0, patch_default and ri.field_specificity=0 => s.source_record_id_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j2,s.nulls_source_record_id,Specificities(ih).source_record_id_values_persisted,source_record_id,source_record_id_weight100,add_source_record_id,j1);
layout_candidates add_active_enterprise_number(layout_candidates le,Specificities(ih).active_enterprise_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_enterprise_number_weight100 := MAP (le.active_enterprise_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_enterprise_number_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT25.MAC_Choose_JoinType(j1,s.nulls_active_enterprise_number,Specificities(ih).active_enterprise_number_values_persisted,active_enterprise_number,active_enterprise_number_weight100,add_active_enterprise_number,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(Proxid)) : PERSIST('temp::BIPV2_Relative_DOT_Base_mc'); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.active_enterprise_number_weight100 + Annotated.source_record_id_weight100 + Annotated.contact_ssn_weight100 + Annotated.company_fein_weight100 + Annotated.company_charter_number_weight100 + Annotated.active_duns_number_weight100 + Annotated.active_domestic_corp_key_weight100 + Annotated.contact_phone_weight100 + Annotated.cnp_name_weight100 + Annotated.corp_legal_name_weight100 + Annotated.company_address_weight100 + Annotated.lname_weight100 + Annotated.zip4_weight100 + Annotated.cnp_number_weight100 + Annotated.p_city_name_weight100 + Annotated.fname_weight100 + Annotated.company_inc_state_weight100 + Annotated.mname_weight100 + Annotated.postdir_weight100 + Annotated.predir_weight100 + Annotated.addr_suffix_weight100 + Annotated.cnp_btype_weight100 + Annotated.source_weight100 + Annotated.iscorp_weight100 + Annotated.cnp_hasnumber_weight100 + Annotated.contact_email_username_weight100;
SHARED Linkable := TotalWeight >= 32;
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
