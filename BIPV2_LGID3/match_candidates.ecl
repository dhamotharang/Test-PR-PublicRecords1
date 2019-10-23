// Begin code to produce match candidates
IMPORT SALT311,STD;
EXPORT match_candidates(DATASET(layout_LGID3) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := BIPV2_LGID3.BasicMatch(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00(SALT_Partition<>'*'),{rcid,sbfe_id,nodes_below_st,Lgid3IfHrchy,OriginalSeleId,OriginalOrgId,company_name,cnp_number,active_duns_number,duns_number,duns_number_concept,company_fein,company_inc_state,company_charter_number,cnp_btype,company_name_type_derived,hist_duns_number,active_domestic_corp_key,hist_domestic_corp_key,foreign_corp_key,unk_corp_key,cnp_name,cnp_hasNumber,cnp_lowv,cnp_translated,cnp_classid,prim_range,prim_name,sec_range,v_city_name,st,zip,has_lgid,is_sele_level,is_org_level,is_ult_level,parent_proxid,sele_proxid,org_proxid,ultimate_proxid,levels_from_top,nodes_total,dt_first_seen,dt_last_seen,SALT_Partition,ultid,orgid,seleid,LGID3}),HASH(LGID3));
 
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 sbfe_id_pop := AVE(GROUP,IF((thin_table.sbfe_id  IN SET(s.nulls_sbfe_id,sbfe_id) OR thin_table.sbfe_id = (TYPEOF(thin_table.sbfe_id))''),0,100));
  REAL8 Lgid3IfHrchy_pop := AVE(GROUP,IF((thin_table.Lgid3IfHrchy  IN SET(s.nulls_Lgid3IfHrchy,Lgid3IfHrchy) OR thin_table.Lgid3IfHrchy = (TYPEOF(thin_table.Lgid3IfHrchy))''),0,100));
  REAL8 company_name_pop := AVE(GROUP,IF((thin_table.company_name  IN SET(s.nulls_company_name,company_name) OR thin_table.company_name = (TYPEOF(thin_table.company_name))''),0,100));
  REAL8 cnp_number_pop := AVE(GROUP,IF((thin_table.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR thin_table.cnp_number = (TYPEOF(thin_table.cnp_number))''),0,100));
  REAL8 active_duns_number_pop := AVE(GROUP,IF((thin_table.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR thin_table.active_duns_number = (TYPEOF(thin_table.active_duns_number))''),0,100));
  REAL8 duns_number_pop := AVE(GROUP,IF((thin_table.duns_number  IN SET(s.nulls_duns_number,duns_number) OR thin_table.duns_number = (TYPEOF(thin_table.duns_number))''),0,100));
  REAL8 duns_number_concept_pop := AVE(GROUP,IF(((thin_table.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR thin_table.active_duns_number = (TYPEOF(thin_table.active_duns_number))'') AND (thin_table.duns_number  IN SET(s.nulls_duns_number,duns_number) OR thin_table.duns_number = (TYPEOF(thin_table.duns_number))'')),0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF((thin_table.company_fein  IN SET(s.nulls_company_fein,company_fein) OR thin_table.company_fein = (TYPEOF(thin_table.company_fein))''),0,100));
  REAL8 company_inc_state_pop := AVE(GROUP,IF((thin_table.company_inc_state  IN SET(s.nulls_company_inc_state,company_inc_state) OR thin_table.company_inc_state = (TYPEOF(thin_table.company_inc_state))''),0,100));
  REAL8 company_charter_number_pop := AVE(GROUP,IF((thin_table.company_charter_number  IN SET(s.nulls_company_charter_number,company_charter_number) OR thin_table.company_charter_number = (TYPEOF(thin_table.company_charter_number))''),0,100));
  REAL8 cnp_btype_pop := AVE(GROUP,IF((thin_table.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR thin_table.cnp_btype = (TYPEOF(thin_table.cnp_btype))''),0,100));
END;
EXPORT PPS := TABLE(thin_table,PrePropCounts);
EXPORT poprec := RECORD
	STRING label;
		REAL8 pop;
	END;
EXPORT PrePropogationStats := SALT311.MAC_Pivot(PPS, poprec);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 Lgid3IfHrchy_prop := 0;
  UNSIGNED1 company_name_prop := 0;
  UNSIGNED1 cnp_number_prop := 0;
  UNSIGNED1 active_duns_number_prop := 0;
  UNSIGNED1 duns_number_prop := 0;
  UNSIGNED1 duns_number_concept_prop := 0;
  UNSIGNED1 company_inc_state_prop := 0;
  UNSIGNED1 company_charter_number_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
SHARED UnderLinks_prop0 := DISTRIBUTE( Specificities(ih).UnderLinks_values_persisted(Basis_cnt<10000), HASH(LGID3)); // Not guaranteed distributed by LGID3 :(
 
SALT311.mac_prop_field(thin_table(sbfe_id NOT IN SET(s.nulls_sbfe_id,sbfe_id)),sbfe_id,LGID3,sbfe_id_props); // For every DID find the best FULL sbfe_id
SHARED UnderLinks_prop1 := JOIN(UnderLinks_prop0,sbfe_id_props,left.LGID3=right.LGID3,LEFT OUTER,LOCAL);
 
SALT311.mac_prop_field(thin_table(Lgid3IfHrchy NOT IN SET(s.nulls_Lgid3IfHrchy,Lgid3IfHrchy)),Lgid3IfHrchy,LGID3,Lgid3IfHrchy_props); // For every DID find the best FULL Lgid3IfHrchy
layout_withpropvars take_Lgid3IfHrchy(with_props le,Lgid3IfHrchy_props ri) := TRANSFORM
  SELF.Lgid3IfHrchy := IF ( le.Lgid3IfHrchy IN SET(s.nulls_Lgid3IfHrchy,Lgid3IfHrchy) and ri.LGID3<>(TYPEOF(ri.LGID3))'', ri.Lgid3IfHrchy, le.Lgid3IfHrchy );
  SELF.Lgid3IfHrchy_prop := le.Lgid3IfHrchy_prop + IF ( le.Lgid3IfHrchy IN SET(s.nulls_Lgid3IfHrchy,Lgid3IfHrchy) and ri.Lgid3IfHrchy NOT IN SET(s.nulls_Lgid3IfHrchy,Lgid3IfHrchy) and ri.LGID3<>(TYPEOF(ri.LGID3))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj2 := JOIN(with_props,Lgid3IfHrchy_props,left.LGID3=right.LGID3,take_Lgid3IfHrchy(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKmatch_candidates00 to prevent memory limit exceeded error*/);
SHARED UnderLinks_prop2 := JOIN(UnderLinks_prop1,Lgid3IfHrchy_props,left.LGID3=right.LGID3,LEFT OUTER,LOCAL);
 
SALT311.mac_prop_field(thin_table(company_name NOT IN SET(s.nulls_company_name,company_name)),company_name,LGID3,company_name_props); // For every DID find the best FULL company_name
layout_withpropvars take_company_name(with_props le,company_name_props ri) := TRANSFORM
  SELF.company_name := IF ( le.company_name IN SET(s.nulls_company_name,company_name) and ri.LGID3<>(TYPEOF(ri.LGID3))'', ri.company_name, le.company_name );
  SELF.company_name_prop := le.company_name_prop + IF ( le.company_name IN SET(s.nulls_company_name,company_name) and ri.company_name NOT IN SET(s.nulls_company_name,company_name) and ri.LGID3<>(TYPEOF(ri.LGID3))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj5 := JOIN(pj2,company_name_props,left.LGID3=right.LGID3,take_company_name(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKmatch_candidates00 to prevent memory limit exceeded error*/);
 
SALT311.mac_prop_field(thin_table(cnp_number NOT IN SET(s.nulls_cnp_number,cnp_number)),cnp_number,LGID3,cnp_number_props); // For every DID find the best FULL cnp_number
layout_withpropvars take_cnp_number(with_props le,cnp_number_props ri) := TRANSFORM
  SELF.cnp_number := IF ( le.cnp_number IN SET(s.nulls_cnp_number,cnp_number) and ri.LGID3<>(TYPEOF(ri.LGID3))'', ri.cnp_number, le.cnp_number );
  SELF.cnp_number_prop := le.cnp_number_prop + IF ( le.cnp_number IN SET(s.nulls_cnp_number,cnp_number) and ri.cnp_number NOT IN SET(s.nulls_cnp_number,cnp_number) and ri.LGID3<>(TYPEOF(ri.LGID3))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj6 := JOIN(pj5,cnp_number_props,left.LGID3=right.LGID3,take_cnp_number(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKmatch_candidates00 to prevent memory limit exceeded error*/);
SHARED UnderLinks_prop3 := JOIN(UnderLinks_prop2,cnp_number_props,left.LGID3=right.LGID3,LEFT OUTER,LOCAL);
 
SALT311.mac_prop_field(thin_table(active_duns_number NOT IN SET(s.nulls_active_duns_number,active_duns_number)),active_duns_number,LGID3,active_duns_number_props); // For every DID find the best FULL active_duns_number
layout_withpropvars take_active_duns_number(with_props le,active_duns_number_props ri) := TRANSFORM
  SELF.active_duns_number := IF ( le.active_duns_number IN SET(s.nulls_active_duns_number,active_duns_number) and ri.LGID3<>(TYPEOF(ri.LGID3))'', ri.active_duns_number, le.active_duns_number );
  SELF.active_duns_number_prop := le.active_duns_number_prop + IF ( le.active_duns_number IN SET(s.nulls_active_duns_number,active_duns_number) and ri.active_duns_number NOT IN SET(s.nulls_active_duns_number,active_duns_number) and ri.LGID3<>(TYPEOF(ri.LGID3))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj7 := JOIN(pj6,active_duns_number_props,left.LGID3=right.LGID3,take_active_duns_number(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKmatch_candidates00 to prevent memory limit exceeded error*/);
SHARED UnderLinks_prop4 := JOIN(UnderLinks_prop3,active_duns_number_props,left.LGID3=right.LGID3,LEFT OUTER,LOCAL);
 
SALT311.mac_prop_field(thin_table(duns_number NOT IN SET(s.nulls_duns_number,duns_number)),duns_number,LGID3,duns_number_props); // For every DID find the best FULL duns_number
layout_withpropvars take_duns_number(with_props le,duns_number_props ri) := TRANSFORM
  SELF.duns_number := IF ( le.duns_number IN SET(s.nulls_duns_number,duns_number) and ri.LGID3<>(TYPEOF(ri.LGID3))'', ri.duns_number, le.duns_number );
  SELF.duns_number_prop := le.duns_number_prop + IF ( le.duns_number IN SET(s.nulls_duns_number,duns_number) and ri.duns_number NOT IN SET(s.nulls_duns_number,duns_number) and ri.LGID3<>(TYPEOF(ri.LGID3))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj8 := JOIN(pj7,duns_number_props,left.LGID3=right.LGID3,take_duns_number(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKmatch_candidates00 to prevent memory limit exceeded error*/);
SHARED UnderLinks_prop5 := JOIN(UnderLinks_prop4,duns_number_props,left.LGID3=right.LGID3,LEFT OUTER,LOCAL);
 
SALT311.mac_prop_field(thin_table(company_fein NOT IN SET(s.nulls_company_fein,company_fein)),company_fein,LGID3,company_fein_props); // For every DID find the best FULL company_fein
SHARED UnderLinks_prop6 := JOIN(UnderLinks_prop5,company_fein_props,left.LGID3=right.LGID3,LEFT OUTER,LOCAL);
 
SALT311.mac_prop_field(thin_table(company_inc_state NOT IN SET(s.nulls_company_inc_state,company_inc_state)),company_inc_state,LGID3,company_inc_state_props); // For every DID find the best FULL company_inc_state
layout_withpropvars take_company_inc_state(with_props le,company_inc_state_props ri) := TRANSFORM
  SELF.company_inc_state := IF ( le.company_inc_state IN SET(s.nulls_company_inc_state,company_inc_state) and ri.LGID3<>(TYPEOF(ri.LGID3))'', ri.company_inc_state, le.company_inc_state );
  SELF.company_inc_state_prop := le.company_inc_state_prop + IF ( le.company_inc_state IN SET(s.nulls_company_inc_state,company_inc_state) and ri.company_inc_state NOT IN SET(s.nulls_company_inc_state,company_inc_state) and ri.LGID3<>(TYPEOF(ri.LGID3))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj11 := JOIN(pj8,company_inc_state_props,left.LGID3=right.LGID3,take_company_inc_state(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKmatch_candidates00 to prevent memory limit exceeded error*/);
/*HACKmatch_candidates01*/ SHARED UnderLinks_prop7 := JOIN(UnderLinks_prop6,company_inc_state_props,left.LGID3=right.LGID3,LEFT OUTER, LOCAL);
 
SALT311.mac_prop_field(thin_table(company_charter_number NOT IN SET(s.nulls_company_charter_number,company_charter_number)),company_charter_number,LGID3,company_charter_number_props); // For every DID find the best FULL company_charter_number
layout_withpropvars take_company_charter_number(with_props le,company_charter_number_props ri) := TRANSFORM
  SELF.company_charter_number := IF ( le.company_charter_number IN SET(s.nulls_company_charter_number,company_charter_number) and ri.LGID3<>(TYPEOF(ri.LGID3))'', ri.company_charter_number, le.company_charter_number );
  SELF.company_charter_number_prop := le.company_charter_number_prop + IF ( le.company_charter_number IN SET(s.nulls_company_charter_number,company_charter_number) and ri.company_charter_number NOT IN SET(s.nulls_company_charter_number,company_charter_number) and ri.LGID3<>(TYPEOF(ri.LGID3))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj12 := JOIN(pj11,company_charter_number_props,left.LGID3=right.LGID3,take_company_charter_number(left,right),LEFT OUTER,HASH/*,HINT(parallel_match)*//*HACKmatch_candidates00 to prevent memory limit exceeded error*/);
SHARED UnderLinks_prp := UnderLinks_prop7;
 
pj12 do_computes(pj12 le) := TRANSFORM
  SELF.duns_number_concept := IF (Fields.InValid_duns_number_concept((SALT311.StrType)le.active_duns_number,(SALT311.StrType)le.duns_number)>0,0,HASH32((SALT311.StrType)le.active_duns_number,(SALT311.StrType)le.duns_number)); // Combine child fields into 1 for specificity counting
  SELF.duns_number_concept_prop := IF( le.active_duns_number_prop > 0, 1, 0 ) + IF( le.duns_number_prop > 0, 2, 0 );
  SELF := le;
END;
SHARED propogated := PROJECT(pj12,do_computes(left)) : PERSIST('~temp::LGID3::BIPV2_LGID3::mc_props::LGID3',EXPIRE(BIPV2_LGID3.Config.PersistExpire)); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 sbfe_id_pop := AVE(GROUP,IF((propogated.sbfe_id  IN SET(s.nulls_sbfe_id,sbfe_id) OR propogated.sbfe_id = (TYPEOF(propogated.sbfe_id))''),0,100));
  REAL8 Lgid3IfHrchy_pop := AVE(GROUP,IF((propogated.Lgid3IfHrchy  IN SET(s.nulls_Lgid3IfHrchy,Lgid3IfHrchy) OR propogated.Lgid3IfHrchy = (TYPEOF(propogated.Lgid3IfHrchy))''),0,100));
  REAL8 company_name_pop := AVE(GROUP,IF((propogated.company_name  IN SET(s.nulls_company_name,company_name) OR propogated.company_name = (TYPEOF(propogated.company_name))''),0,100));
  REAL8 cnp_number_pop := AVE(GROUP,IF((propogated.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR propogated.cnp_number = (TYPEOF(propogated.cnp_number))''),0,100));
  REAL8 active_duns_number_pop := AVE(GROUP,IF((propogated.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR propogated.active_duns_number = (TYPEOF(propogated.active_duns_number))''),0,100));
  REAL8 duns_number_pop := AVE(GROUP,IF((propogated.duns_number  IN SET(s.nulls_duns_number,duns_number) OR propogated.duns_number = (TYPEOF(propogated.duns_number))''),0,100));
  REAL8 duns_number_concept_pop := AVE(GROUP,IF(((propogated.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR propogated.active_duns_number = (TYPEOF(propogated.active_duns_number))'') AND (propogated.duns_number  IN SET(s.nulls_duns_number,duns_number) OR propogated.duns_number = (TYPEOF(propogated.duns_number))'')),0,100));
  REAL8 company_fein_pop := AVE(GROUP,IF((propogated.company_fein  IN SET(s.nulls_company_fein,company_fein) OR propogated.company_fein = (TYPEOF(propogated.company_fein))''),0,100));
  REAL8 company_inc_state_pop := AVE(GROUP,IF((propogated.company_inc_state  IN SET(s.nulls_company_inc_state,company_inc_state) OR propogated.company_inc_state = (TYPEOF(propogated.company_inc_state))''),0,100));
  REAL8 company_charter_number_pop := AVE(GROUP,IF((propogated.company_charter_number  IN SET(s.nulls_company_charter_number,company_charter_number) OR propogated.company_charter_number = (TYPEOF(propogated.company_charter_number))''),0,100));
  REAL8 cnp_btype_pop := AVE(GROUP,IF((propogated.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR propogated.cnp_btype = (TYPEOF(propogated.cnp_btype))''),0,100));
END;
 PoPS := TABLE(propogated,PostPropCounts);
EXPORT PostPropogationStats := SALT311.MAC_Pivot(PoPS, poprec);
  SHARED MAC_RollupCandidates(inCandidates, sortFields, groupFields, addBuddies) := FUNCTIONMACRO
    Grpd0 := GROUP(SORT(
      DISTRIBUTE(TABLE(inCandidates, {inCandidates #IF(addBuddies) , UNSIGNED2 Buddies := 0 #END}), HASH(LGID3)),
      LGID3, SALT_Partition, #EXPAND(sortFields), LOCAL),
      LGID3, SALT_Partition, #EXPAND(groupFields), LOCAL);
    Grpd0 Tr0(Grpd0 le, Grpd0 ri) := TRANSFORM
      SELF.Buddies := le.Buddies + ri.Buddies + 1;
      SELF := le;
    END;
    RETURN UNGROUP(ROLLUP(Grpd0,TRUE,Tr0(LEFT,RIGHT)));// Only one copy of each record
  ENDMACRO;
  SHARED fieldList := 'sbfe_id,Lgid3IfHrchy,company_name,cnp_number,active_duns_number,duns_number,company_fein,company_inc_state,company_charter_number,cnp_btype,dt_first_seen,dt_last_seen';
  SHARED fieldListWithPropFlags := fieldList + ',Lgid3IfHrchy_prop,company_name_prop,cnp_number_prop,active_duns_number_prop,duns_number_prop,duns_number_concept_prop,company_inc_state_prop,company_charter_number_prop';
  GrpdRoll_withpropfields := MAC_RollupCandidates(propogated, fieldListWithPropFlags, fieldListWithPropFlags, TRUE);
  GrpdRoll_nopropfields := MAC_RollupCandidates(propogated, fieldListWithPropFlags, fieldList, TRUE);
SHARED h0 := IF(Config.FastSlice, GrpdRoll_nopropFields, GrpdRoll_withpropfields);
 
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT311.UIDType LGID31;
  SALT311.UIDType LGID32;
  SALT311.UIDType rcid1 := 0;
  SALT311.UIDType rcid2 := 0;
END;
EXPORT Layout_Attribute_Matches := RECORD(layout_matches),MAXLENGTH(32000)
  SALT311.StrType source_id;
END;
EXPORT Layout_UnderLinks_Candidates := RECORD
  {UnderLinks_prp};
  INTEGER2 sbfe_id_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sbfe_id_isnull := (UnderLinks_prp.sbfe_id  IN SET(s.nulls_sbfe_id,sbfe_id) OR UnderLinks_prp.sbfe_id = (TYPEOF(UnderLinks_prp.sbfe_id))''); // Simplify later processing 
  INTEGER2 Lgid3IfHrchy_weight100 := 0; // Contains 100x the specificity
  BOOLEAN Lgid3IfHrchy_isnull := (UnderLinks_prp.Lgid3IfHrchy  IN SET(s.nulls_Lgid3IfHrchy,Lgid3IfHrchy) OR UnderLinks_prp.Lgid3IfHrchy = (TYPEOF(UnderLinks_prp.Lgid3IfHrchy))''); // Simplify later processing 
  INTEGER2 cnp_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_number_isnull := (UnderLinks_prp.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR UnderLinks_prp.cnp_number = (TYPEOF(UnderLinks_prp.cnp_number))''); // Simplify later processing 
  INTEGER2 active_duns_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_duns_number_isnull := (UnderLinks_prp.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR UnderLinks_prp.active_duns_number = (TYPEOF(UnderLinks_prp.active_duns_number))''); // Simplify later processing 
  INTEGER2 duns_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN duns_number_isnull := (UnderLinks_prp.duns_number  IN SET(s.nulls_duns_number,duns_number) OR UnderLinks_prp.duns_number = (TYPEOF(UnderLinks_prp.duns_number))''); // Simplify later processing 
  INTEGER2 company_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_fein_isnull := (UnderLinks_prp.company_fein  IN SET(s.nulls_company_fein,company_fein) OR UnderLinks_prp.company_fein = (TYPEOF(UnderLinks_prp.company_fein))''); // Simplify later processing 
  INTEGER2 company_inc_state_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_inc_state_isnull := (UnderLinks_prp.company_inc_state  IN SET(s.nulls_company_inc_state,company_inc_state) OR UnderLinks_prp.company_inc_state = (TYPEOF(UnderLinks_prp.company_inc_state))''); // Simplify later processing 
END;
/*HACKmatch_candidates02*/ SHARED UnderLinks_pp := TABLE(UnderLinks_prp,Layout_UnderLinks_Candidates)((~company_inc_state_isnull OR ~active_duns_number_isnull OR ~duns_number_isnull OR ~(active_duns_number_isnull AND duns_number_isnull) OR ~company_fein_isnull OR ~sbfe_id_isnull));
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0} AND NOT [company_name]; // remove wordbag fields which need to be expanded
  INTEGER2 sbfe_id_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sbfe_id_isnull := (h0.sbfe_id  IN SET(s.nulls_sbfe_id,sbfe_id) OR h0.sbfe_id = (TYPEOF(h0.sbfe_id))''); // Simplify later processing 
  INTEGER2 Lgid3IfHrchy_weight100 := 0; // Contains 100x the specificity
  BOOLEAN Lgid3IfHrchy_isnull := (h0.Lgid3IfHrchy  IN SET(s.nulls_Lgid3IfHrchy,Lgid3IfHrchy) OR h0.Lgid3IfHrchy = (TYPEOF(h0.Lgid3IfHrchy))''); // Simplify later processing 
  STRING500 company_name := h0.company_name; // Expanded wordbag field
  INTEGER2 company_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_name_isnull := (h0.company_name  IN SET(s.nulls_company_name,company_name) OR h0.company_name = (TYPEOF(h0.company_name))''); // Simplify later processing 
  INTEGER2 cnp_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_number_isnull := (h0.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR h0.cnp_number = (TYPEOF(h0.cnp_number))''); // Simplify later processing 
  INTEGER2 active_duns_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN active_duns_number_isnull := (h0.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR h0.active_duns_number = (TYPEOF(h0.active_duns_number))''); // Simplify later processing 
  INTEGER2 duns_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN duns_number_isnull := (h0.duns_number  IN SET(s.nulls_duns_number,duns_number) OR h0.duns_number = (TYPEOF(h0.duns_number))''); // Simplify later processing 
  INTEGER2 duns_number_concept_weight100 := 0; // Contains 100x the specificity
  BOOLEAN duns_number_concept_isnull := ((h0.active_duns_number  IN SET(s.nulls_active_duns_number,active_duns_number) OR h0.active_duns_number = (TYPEOF(h0.active_duns_number))'') AND (h0.duns_number  IN SET(s.nulls_duns_number,duns_number) OR h0.duns_number = (TYPEOF(h0.duns_number))'')); // Simplify later processing 
  INTEGER2 company_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_fein_isnull := (h0.company_fein  IN SET(s.nulls_company_fein,company_fein) OR h0.company_fein = (TYPEOF(h0.company_fein))''); // Simplify later processing 
  INTEGER2 company_inc_state_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_inc_state_isnull := (h0.company_inc_state  IN SET(s.nulls_company_inc_state,company_inc_state) OR h0.company_inc_state = (TYPEOF(h0.company_inc_state))''); // Simplify later processing 
  INTEGER2 company_charter_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_charter_number_isnull := (h0.company_charter_number  IN SET(s.nulls_company_charter_number,company_charter_number) OR h0.company_charter_number = (TYPEOF(h0.company_charter_number))''); // Simplify later processing 
  INTEGER2 cnp_btype_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_btype_isnull := (h0.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR h0.cnp_btype = (TYPEOF(h0.cnp_btype))''); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates)((~company_inc_state_isnull OR ~active_duns_number_isnull OR ~duns_number_isnull OR ~(duns_number_concept_isnull OR active_duns_number_isnull AND duns_number_isnull) OR ~company_fein_isnull OR ~sbfe_id_isnull));
//Now add the weights of each field one by one
 
//Would also create auto-id fields here
 
layout_candidates add_cnp_btype(layout_candidates le,Specificities(ih).cnp_btype_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_btype_weight100 := MAP (le.cnp_btype_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_btype_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j10 := JOIN(h1,PULL(Specificities(ih).cnp_btype_values_persisted),LEFT.cnp_btype=RIGHT.cnp_btype,add_cnp_btype(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_company_inc_state(layout_candidates le,Specificities(ih).company_inc_state_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_inc_state_weight100 := MAP (le.company_inc_state_isnull => 0, patch_default and ri.field_specificity=0 => s.company_inc_state_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j9 := JOIN(j10,PULL(Specificities(ih).company_inc_state_values_persisted),LEFT.company_inc_state=RIGHT.company_inc_state,add_company_inc_state(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_cnp_number(layout_candidates le,Specificities(ih).cnp_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_number_weight100 := MAP (le.cnp_number_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j9,s.nulls_cnp_number,Specificities(ih).cnp_number_values_persisted,cnp_number,cnp_number_weight100,add_cnp_number,j8);
layout_candidates add_company_charter_number(layout_candidates le,Specificities(ih).company_charter_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_charter_number_weight100 := MAP (le.company_charter_number_isnull => 0, patch_default and ri.field_specificity=0 => s.company_charter_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j8,s.nulls_company_charter_number,Specificities(ih).company_charter_number_values_persisted,company_charter_number,company_charter_number_weight100,add_company_charter_number,j7);
layout_candidates add_company_fein(layout_candidates le,Specificities(ih).company_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_fein_weight100 := MAP (le.company_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.company_fein_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j7,s.nulls_company_fein,Specificities(ih).company_fein_values_persisted,company_fein,company_fein_weight100,add_company_fein,j6);
layout_candidates add_company_name(layout_candidates le,Specificities(ih).company_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_name_weight100 := MAP (le.company_name_isnull => 0, patch_default and ri.field_specificity=0 => s.company_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.company_name := IF( ri.field_specificity<>0 or ri.word<>'',SELF.company_name_weight100+' '+ri.word,SALT311.Fn_WordBag_AppendSpecs_Fake(le.company_name, s.company_name_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j6,s.nulls_company_name,Specificities(ih).company_name_values_persisted,company_name,company_name_weight100,add_company_name,j5);
layout_candidates add_duns_number_concept(layout_candidates le,Specificities(ih).duns_number_concept_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.duns_number_concept_weight100 := MAP (le.duns_number_concept_isnull => 0, patch_default and ri.field_specificity=0 => s.duns_number_concept_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j5,s.nulls_duns_number_concept,Specificities(ih).duns_number_concept_values_persisted,duns_number_concept,duns_number_concept_weight100,add_duns_number_concept,j4);
layout_candidates add_duns_number(layout_candidates le,Specificities(ih).duns_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.duns_number_weight100 := MAP (le.duns_number_isnull => 0, patch_default and ri.field_specificity=0 => s.duns_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j4,s.nulls_duns_number,Specificities(ih).duns_number_values_persisted,duns_number,duns_number_weight100,add_duns_number,j3);
layout_candidates add_active_duns_number(layout_candidates le,Specificities(ih).active_duns_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_duns_number_weight100 := MAP (le.active_duns_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_duns_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j3,s.nulls_active_duns_number,Specificities(ih).active_duns_number_values_persisted,active_duns_number,active_duns_number_weight100,add_active_duns_number,j2);
layout_candidates add_Lgid3IfHrchy(layout_candidates le,Specificities(ih).Lgid3IfHrchy_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.Lgid3IfHrchy_weight100 := MAP (le.Lgid3IfHrchy_isnull => 0, patch_default and ri.field_specificity=0 => s.Lgid3IfHrchy_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j2,s.nulls_Lgid3IfHrchy,Specificities(ih).Lgid3IfHrchy_values_persisted,Lgid3IfHrchy,Lgid3IfHrchy_weight100,add_Lgid3IfHrchy,j1);
layout_candidates add_sbfe_id(layout_candidates le,Specificities(ih).sbfe_id_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sbfe_id_weight100 := MAP (le.sbfe_id_isnull => 0, patch_default and ri.field_specificity=0 => s.sbfe_id_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(j1,s.nulls_sbfe_id,Specificities(ih).sbfe_id_values_persisted,sbfe_id,sbfe_id_weight100,add_sbfe_id,j0);
//Using HASH(did) to get smoother distribution
SHARED j0_dist := DISTRIBUTE(j0, HASH(LGID3));
SHARED Annotated_NoDedup := j0_dist : PERSIST('~temp::LGID3::BIPV2_LGID3::mc_nodedup',EXPIRE(BIPV2_LGID3.Config.PersistExpire)); // No dedup- for aggressive slicing
SHARED Annotated_Dedup := IF(Config.FastSlice, j0_dist, MAC_RollupCandidates(Annotated_NoDedup, fieldListWithPropFlags, fieldList, FALSE));
SHARED Annotated := Annotated_Dedup : PERSIST('~temp::LGID3::BIPV2_LGID3::mc',EXPIRE(BIPV2_LGID3.Config.PersistExpire)); // Distributed for keybuild case
 
//Now prepare candidate file for UnderLinks attribute file
layout_UnderLinks_candidates add_UnderLinks_sbfe_id(layout_UnderLinks_candidates le,Specificities(ih).sbfe_id_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sbfe_id_weight100 := MAP (le.sbfe_id_isnull => 0, patch_default and ri.field_specificity=0 => s.sbfe_id_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(UnderLinks_pp,s.nulls_sbfe_id,Specificities(ih).sbfe_id_values_persisted,sbfe_id,sbfe_id_weight100,add_UnderLinks_sbfe_id,jUnderLinks_0);
layout_UnderLinks_candidates add_UnderLinks_Lgid3IfHrchy(layout_UnderLinks_candidates le,Specificities(ih).Lgid3IfHrchy_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.Lgid3IfHrchy_weight100 := MAP (le.Lgid3IfHrchy_isnull => 0, patch_default and ri.field_specificity=0 => s.Lgid3IfHrchy_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jUnderLinks_0,s.nulls_Lgid3IfHrchy,Specificities(ih).Lgid3IfHrchy_values_persisted,Lgid3IfHrchy,Lgid3IfHrchy_weight100,add_UnderLinks_Lgid3IfHrchy,jUnderLinks_1);
layout_UnderLinks_candidates add_UnderLinks_active_duns_number(layout_UnderLinks_candidates le,Specificities(ih).active_duns_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.active_duns_number_weight100 := MAP (le.active_duns_number_isnull => 0, patch_default and ri.field_specificity=0 => s.active_duns_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jUnderLinks_1,s.nulls_active_duns_number,Specificities(ih).active_duns_number_values_persisted,active_duns_number,active_duns_number_weight100,add_UnderLinks_active_duns_number,jUnderLinks_2);
layout_UnderLinks_candidates add_UnderLinks_duns_number(layout_UnderLinks_candidates le,Specificities(ih).duns_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.duns_number_weight100 := MAP (le.duns_number_isnull => 0, patch_default and ri.field_specificity=0 => s.duns_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jUnderLinks_2,s.nulls_duns_number,Specificities(ih).duns_number_values_persisted,duns_number,duns_number_weight100,add_UnderLinks_duns_number,jUnderLinks_3);
layout_UnderLinks_candidates add_UnderLinks_company_fein(layout_UnderLinks_candidates le,Specificities(ih).company_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_fein_weight100 := MAP (le.company_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.company_fein_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jUnderLinks_3,s.nulls_company_fein,Specificities(ih).company_fein_values_persisted,company_fein,company_fein_weight100,add_UnderLinks_company_fein,jUnderLinks_6);
layout_UnderLinks_candidates add_UnderLinks_cnp_number(layout_UnderLinks_candidates le,Specificities(ih).cnp_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_number_weight100 := MAP (le.cnp_number_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT311.MAC_Choose_JoinType(jUnderLinks_6,s.nulls_cnp_number,Specificities(ih).cnp_number_values_persisted,cnp_number,cnp_number_weight100,add_UnderLinks_cnp_number,jUnderLinks_8);
layout_UnderLinks_candidates add_UnderLinks_company_inc_state(layout_UnderLinks_candidates le,Specificities(ih).company_inc_state_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_inc_state_weight100 := MAP (le.company_inc_state_isnull => 0, patch_default and ri.field_specificity=0 => s.company_inc_state_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
jUnderLinks_9 := JOIN(jUnderLinks_8,PULL(Specificities(ih).company_inc_state_values_persisted),LEFT.company_inc_state=RIGHT.company_inc_state,add_UnderLinks_company_inc_state(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
EXPORT UnderLinks_candidates := jUnderLinks_9 : PERSIST('~temp::LGID3::BIPV2_LGID3::mc::UnderLinks',EXPIRE(BIPV2_LGID3.Config.PersistExpire));
//Now see if these records are actually linkable
TotalWeight := Annotated.sbfe_id_weight100 + Annotated.Lgid3IfHrchy_weight100 + Annotated.duns_number_concept_weight100 + Annotated.company_name_weight100 + Annotated.company_fein_weight100 + Annotated.company_charter_number_weight100 + Annotated.cnp_number_weight100 + Annotated.company_inc_state_weight100 + Annotated.cnp_btype_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
TotalWeight_NoDedup := Annotated_NoDedup.sbfe_id_weight100 + Annotated_NoDedup.Lgid3IfHrchy_weight100 + Annotated_NoDedup.duns_number_concept_weight100 + Annotated_NoDedup.company_name_weight100 + Annotated_NoDedup.company_fein_weight100 + Annotated_NoDedup.company_charter_number_weight100 + Annotated_NoDedup.cnp_number_weight100 + Annotated_NoDedup.company_inc_state_weight100 + Annotated_NoDedup.cnp_btype_weight100;
SHARED Linkable_NoDedup := TotalWeight_NoDedup >= Config.MatchThreshold;
EXPORT BuddyCounts := TABLE(IF(Config.FastSlice, Annotated, Annotated_NoDedup),{ buddies, Cnt := COUNT(GROUP) }, buddies, FEW);
EXPORT HasBuddies := TABLE(IF(Config.FastSlice, Annotated, Annotated_NoDedup)(buddies>0), { rcid });
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(); //Attribute Files might bring total score up to threshold
EXPORT Candidates_ForSlice := IF(Config.FastSlice, Candidates, Annotated_NoDedup());
END;
