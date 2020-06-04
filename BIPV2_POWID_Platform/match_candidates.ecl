// Begin code to produce match candidates
IMPORT SALT32,ut;
EXPORT match_candidates(DATASET(layout_POWID) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := BasicMatch(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00(SALT_Partition<>'*'),{rcid,num_incs,nodes_total,RID_If_Big_Biz,num_legal_names,company_name,company_name_len,cnp_name,cnp_number,prim_range,prim_name,zip,zip4,sec_range,v_city_name,st,company_inc_state,company_charter_number,active_duns_number,hist_duns_number,active_domestic_corp_key,hist_domestic_corp_key,foreign_corp_key,unk_corp_key,company_fein,cnp_btype,company_name_type_derived,company_bdid,dt_first_seen,dt_last_seen,SALT_Partition,UltID,OrgID,POWID}),HASH(POWID));
 
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 RID_If_Big_Biz_pop := AVE(GROUP,IF(thin_table.RID_If_Big_Biz  IN SET(s.nulls_RID_If_Big_Biz,RID_If_Big_Biz) OR thin_table.RID_If_Big_Biz = (TYPEOF(thin_table.RID_If_Big_Biz))'',0,100));
  REAL8 company_name_pop := AVE(GROUP,IF(thin_table.company_name  IN SET(s.nulls_company_name,company_name) OR thin_table.company_name = (TYPEOF(thin_table.company_name))'',0,100));
  REAL8 cnp_name_pop := AVE(GROUP,IF(thin_table.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR thin_table.cnp_name = (TYPEOF(thin_table.cnp_name))'',0,100));
  REAL8 cnp_number_pop := AVE(GROUP,IF(thin_table.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR thin_table.cnp_number = (TYPEOF(thin_table.cnp_number))'',0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF(thin_table.prim_range  IN SET(s.nulls_prim_range,prim_range) OR thin_table.prim_range = (TYPEOF(thin_table.prim_range))'',0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF(thin_table.prim_name  IN SET(s.nulls_prim_name,prim_name) OR thin_table.prim_name = (TYPEOF(thin_table.prim_name))'',0,100));
  REAL8 zip_pop := AVE(GROUP,IF(thin_table.zip  IN SET(s.nulls_zip,zip) OR thin_table.zip = (TYPEOF(thin_table.zip))'',0,100));
END;
EXPORT PrePropogationStats := TABLE(thin_table,PrePropCounts);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 RID_If_Big_Biz_prop := 0;
  UNSIGNED1 company_name_prop := 0;
  UNSIGNED1 cnp_number_prop := 0;
  UNSIGNED1 prim_name_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
SHARED charter_prop0 := DISTRIBUTE( Specificities(ih).charter_values_persisted(Basis_cnt<10000), HASH(POWID)); // Not guaranteed distributed by POWID :(
 
SALT32.mac_prop_field(with_props(RID_If_Big_Biz NOT IN SET(s.nulls_RID_If_Big_Biz,RID_If_Big_Biz)),RID_If_Big_Biz,POWID,RID_If_Big_Biz_props); // For every DID find the best FULL RID_If_Big_Biz
layout_withpropvars take_RID_If_Big_Biz(with_props le,RID_If_Big_Biz_props ri) := TRANSFORM
  SELF.RID_If_Big_Biz := IF ( le.RID_If_Big_Biz IN SET(s.nulls_RID_If_Big_Biz,RID_If_Big_Biz) and ri.POWID<>(TYPEOF(ri.POWID))'', ri.RID_If_Big_Biz, le.RID_If_Big_Biz );
  SELF.RID_If_Big_Biz_prop := le.RID_If_Big_Biz_prop + IF ( le.RID_If_Big_Biz IN SET(s.nulls_RID_If_Big_Biz,RID_If_Big_Biz) and ri.RID_If_Big_Biz NOT IN SET(s.nulls_RID_If_Big_Biz,RID_If_Big_Biz) and ri.POWID<>(TYPEOF(ri.POWID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj2 := JOIN(with_props,RID_If_Big_Biz_props,left.POWID=right.POWID,take_RID_If_Big_Biz(left,right),LEFT OUTER,HASH);
SHARED charter_prop1 := JOIN(charter_prop0,RID_If_Big_Biz_props,left.POWID=right.POWID,LEFT OUTER,LOCAL);
 
SALT32.mac_prop_field(with_props(company_name NOT IN SET(s.nulls_company_name,company_name)),company_name,POWID,company_name_props); // For every DID find the best FULL company_name
layout_withpropvars take_company_name(with_props le,company_name_props ri) := TRANSFORM
  SELF.company_name := IF ( le.company_name IN SET(s.nulls_company_name,company_name) and ri.POWID<>(TYPEOF(ri.POWID))'', ri.company_name, le.company_name );
  SELF.company_name_prop := le.company_name_prop + IF ( le.company_name IN SET(s.nulls_company_name,company_name) and ri.company_name NOT IN SET(s.nulls_company_name,company_name) and ri.POWID<>(TYPEOF(ri.POWID))'', 1, 0 ); // <>0 => propogation
  SELF.company_name_len := IF ( le.company_name IN SET(s.nulls_company_name,company_name) and ri.POWID<>(TYPEOF(ri.POWID))'', LENGTH(TRIM(ri.company_name)), le.company_name_len );
  SELF := le;
  END;
SHARED pj4 := JOIN(pj2,company_name_props,left.POWID=right.POWID,take_company_name(left,right),LEFT OUTER,HASH);
SHARED charter_prop2 := JOIN(charter_prop1,company_name_props,left.POWID=right.POWID,LOCAL);
 
SALT32.mac_prop_field(with_props(cnp_name NOT IN SET(s.nulls_cnp_name,cnp_name)),cnp_name,POWID,cnp_name_props); // For every DID find the best FULL cnp_name
SHARED charter_prop3 := JOIN(charter_prop2,cnp_name_props,left.POWID=right.POWID,LOCAL);
 
SALT32.mac_prop_field(with_props(cnp_number NOT IN SET(s.nulls_cnp_number,cnp_number)),cnp_number,POWID,cnp_number_props); // For every DID find the best FULL cnp_number
layout_withpropvars take_cnp_number(with_props le,cnp_number_props ri) := TRANSFORM
  SELF.cnp_number := IF ( le.cnp_number IN SET(s.nulls_cnp_number,cnp_number) and ri.POWID<>(TYPEOF(ri.POWID))'', ri.cnp_number, le.cnp_number );
  SELF.cnp_number_prop := le.cnp_number_prop + IF ( le.cnp_number IN SET(s.nulls_cnp_number,cnp_number) and ri.cnp_number NOT IN SET(s.nulls_cnp_number,cnp_number) and ri.POWID<>(TYPEOF(ri.POWID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj6 := JOIN(pj4,cnp_number_props,left.POWID=right.POWID,take_cnp_number(left,right),LEFT OUTER,HASH);
SHARED charter_prop4 := JOIN(charter_prop3,cnp_number_props,left.POWID=right.POWID,LEFT OUTER,LOCAL);
 
SALT32.mac_prop_field(with_props(prim_range NOT IN SET(s.nulls_prim_range,prim_range)),prim_range,POWID,prim_range_props); // For every DID find the best FULL prim_range
SHARED charter_prop5 := JOIN(charter_prop4,prim_range_props,left.POWID=right.POWID,LEFT OUTER,LOCAL);
 
SALT32.mac_prop_field(with_props(prim_name NOT IN SET(s.nulls_prim_name,prim_name)),prim_name,POWID,prim_name_props); // For every DID find the best FULL prim_name
layout_withpropvars take_prim_name(with_props le,prim_name_props ri) := TRANSFORM
  SELF.prim_name := IF ( le.prim_name IN SET(s.nulls_prim_name,prim_name) and ri.POWID<>(TYPEOF(ri.POWID))'', ri.prim_name, le.prim_name );
  SELF.prim_name_prop := le.prim_name_prop + IF ( le.prim_name IN SET(s.nulls_prim_name,prim_name) and ri.prim_name NOT IN SET(s.nulls_prim_name,prim_name) and ri.POWID<>(TYPEOF(ri.POWID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj8 := JOIN(pj6,prim_name_props,left.POWID=right.POWID,take_prim_name(left,right),LEFT OUTER,HASH);
SHARED charter_prop6 := JOIN(charter_prop5,prim_name_props,left.POWID=right.POWID,LOCAL);
SHARED charter_prp := charter_prop6;
 
pj8 do_computes(pj8 le) := TRANSFORM
  SELF := le;
END;
SHARED propogated := PROJECT(pj8,do_computes(left)) : PERSIST('~temp::POWID::BIPV2_POWID_Platform::mc_props::POWID',EXPIRE(Config.PersistExpire)); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 RID_If_Big_Biz_pop := AVE(GROUP,IF(propogated.RID_If_Big_Biz  IN SET(s.nulls_RID_If_Big_Biz,RID_If_Big_Biz) OR propogated.RID_If_Big_Biz = (TYPEOF(propogated.RID_If_Big_Biz))'',0,100));
  REAL8 company_name_pop := AVE(GROUP,IF(propogated.company_name  IN SET(s.nulls_company_name,company_name) OR propogated.company_name = (TYPEOF(propogated.company_name))'',0,100));
  REAL8 cnp_name_pop := AVE(GROUP,IF(propogated.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR propogated.cnp_name = (TYPEOF(propogated.cnp_name))'',0,100));
  REAL8 cnp_number_pop := AVE(GROUP,IF(propogated.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR propogated.cnp_number = (TYPEOF(propogated.cnp_number))'',0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF(propogated.prim_range  IN SET(s.nulls_prim_range,prim_range) OR propogated.prim_range = (TYPEOF(propogated.prim_range))'',0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF(propogated.prim_name  IN SET(s.nulls_prim_name,prim_name) OR propogated.prim_name = (TYPEOF(propogated.prim_name))'',0,100));
  REAL8 zip_pop := AVE(GROUP,IF(propogated.zip  IN SET(s.nulls_zip,zip) OR propogated.zip = (TYPEOF(propogated.zip))'',0,100));
END;
EXPORT PostPropogationStats := TABLE(propogated,PostPropCounts);
  Grpd := GROUP( DISTRIBUTE( TABLE( propogated, { propogated, UNSIGNED2 Buddies := 0 }),HASH(POWID)),RID_If_Big_Biz,company_name,cnp_name,cnp_number,prim_range,prim_name,zip,dt_first_seen,dt_last_seen);
  Grpd Tr(Grpd le, Grpd ri) := TRANSFORM
    SELF.Buddies := le.Buddies+1;
    SELF := le;
  END;
SHARED h0 := UNGROUP(ROLLUP(Grpd,TRUE,Tr(LEFT,RIGHT)));// Only one copy of each record
 
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT32.UIDType POWID1;
  SALT32.UIDType POWID2;
  SALT32.UIDType rcid1 := 0;
  SALT32.UIDType rcid2 := 0;
END;
EXPORT Layout_Attribute_Matches := RECORD(layout_matches),MAXLENGTH(32000)
  SALT32.StrType source_id;
END;
EXPORT Layout_charter_Candidates := RECORD
  {charter_prp} AND NOT [company_name,cnp_name];
  INTEGER2 RID_If_Big_Biz_weight100 := 0; // Contains 100x the specificity
  BOOLEAN RID_If_Big_Biz_isnull := charter_prp.RID_If_Big_Biz  IN SET(s.nulls_RID_If_Big_Biz,RID_If_Big_Biz) OR charter_prp.RID_If_Big_Biz = (TYPEOF(charter_prp.RID_If_Big_Biz))''; // Simplify later processing 
  STRING500 company_name := charter_prp.company_name; // Expanded wordbag field
  INTEGER2 company_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_name_isnull := charter_prp.company_name  IN SET(s.nulls_company_name,company_name) OR charter_prp.company_name = (TYPEOF(charter_prp.company_name))''; // Simplify later processing 
  UNSIGNED1 company_name_len := LENGTH(TRIM(charter_prp.company_name));
  STRING500 cnp_name := charter_prp.cnp_name; // Expanded wordbag field
  INTEGER2 cnp_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_name_isnull := charter_prp.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR charter_prp.cnp_name = (TYPEOF(charter_prp.cnp_name))''; // Simplify later processing 
  INTEGER2 cnp_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_number_isnull := charter_prp.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR charter_prp.cnp_number = (TYPEOF(charter_prp.cnp_number))''; // Simplify later processing 
  INTEGER2 prim_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_isnull := charter_prp.prim_range  IN SET(s.nulls_prim_range,prim_range) OR charter_prp.prim_range = (TYPEOF(charter_prp.prim_range))''; // Simplify later processing 
  INTEGER2 prim_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_isnull := charter_prp.prim_name  IN SET(s.nulls_prim_name,prim_name) OR charter_prp.prim_name = (TYPEOF(charter_prp.prim_name))''; // Simplify later processing 
END;
SHARED charter_pp := TABLE(charter_prp,Layout_charter_Candidates)(~cnp_name_isnull);
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0} AND NOT [company_name,cnp_name]; // remove wordbag fields which need to be expanded
  INTEGER2 RID_If_Big_Biz_weight100 := 0; // Contains 100x the specificity
  BOOLEAN RID_If_Big_Biz_isnull := h0.RID_If_Big_Biz  IN SET(s.nulls_RID_If_Big_Biz,RID_If_Big_Biz) OR h0.RID_If_Big_Biz = (TYPEOF(h0.RID_If_Big_Biz))''; // Simplify later processing 
  STRING500 company_name := h0.company_name; // Expanded wordbag field
  INTEGER2 company_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_name_isnull := h0.company_name  IN SET(s.nulls_company_name,company_name) OR h0.company_name = (TYPEOF(h0.company_name))''; // Simplify later processing 
  STRING500 cnp_name := h0.cnp_name; // Expanded wordbag field
  INTEGER2 cnp_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_name_isnull := h0.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR h0.cnp_name = (TYPEOF(h0.cnp_name))''; // Simplify later processing 
  INTEGER2 cnp_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_number_isnull := h0.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR h0.cnp_number = (TYPEOF(h0.cnp_number))''; // Simplify later processing 
  INTEGER2 prim_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_isnull := h0.prim_range  IN SET(s.nulls_prim_range,prim_range) OR h0.prim_range = (TYPEOF(h0.prim_range))''; // Simplify later processing 
  INTEGER2 prim_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_isnull := h0.prim_name  IN SET(s.nulls_prim_name,prim_name) OR h0.prim_name = (TYPEOF(h0.prim_name))''; // Simplify later processing 
  INTEGER2 zip_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip_isnull := h0.zip  IN SET(s.nulls_zip,zip) OR h0.zip = (TYPEOF(h0.zip))''; // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates)(~cnp_name_isnull);
//Now add the weights of each field one by one
 
//Would also create auto-id fields here
 
layout_candidates add_prim_range(layout_candidates le,Specificities(ih).prim_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_weight100 := MAP (le.prim_range_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(h1,s.nulls_prim_range,Specificities(ih).prim_range_values_persisted,prim_range,prim_range_weight100,add_prim_range,j6);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip_weight100 := MAP (le.zip_isnull => 0, patch_default and ri.field_specificity=0 => s.zip_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j6,s.nulls_zip,Specificities(ih).zip_values_persisted,zip,zip_weight100,add_zip,j5);
layout_candidates add_cnp_number(layout_candidates le,Specificities(ih).cnp_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_number_weight100 := MAP (le.cnp_number_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j5,s.nulls_cnp_number,Specificities(ih).cnp_number_values_persisted,cnp_number,cnp_number_weight100,add_cnp_number,j4);
layout_candidates add_prim_name(layout_candidates le,Specificities(ih).prim_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_weight100 := MAP (le.prim_name_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j4,s.nulls_prim_name,Specificities(ih).prim_name_values_persisted,prim_name,prim_name_weight100,add_prim_name,j3);
layout_candidates add_company_name(layout_candidates le,Specificities(ih).company_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_name_weight100 := MAP (le.company_name_isnull => 0, patch_default and ri.field_specificity=0 => s.company_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.company_name := IF( ri.field_specificity<>0 or ri.word<>'',SELF.company_name_weight100+' '+ri.word,SALT32.Fn_WordBag_AppendSpecs_Fake(le.company_name, s.company_name_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j3,s.nulls_company_name,Specificities(ih).company_name_values_persisted,company_name,company_name_weight100,add_company_name,j2);
layout_candidates add_cnp_name(layout_candidates le,Specificities(ih).cnp_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_name_weight100 := MAP (le.cnp_name_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.cnp_name := IF( ri.field_specificity<>0 or ri.word<>'',SELF.cnp_name_weight100+' '+ri.word,SALT32.Fn_WordBag_AppendSpecs_Fake(le.cnp_name, s.cnp_name_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j2,s.nulls_cnp_name,Specificities(ih).cnp_name_values_persisted,cnp_name,cnp_name_weight100,add_cnp_name,j1);
layout_candidates add_RID_If_Big_Biz(layout_candidates le,Specificities(ih).RID_If_Big_Biz_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.RID_If_Big_Biz_weight100 := MAP (le.RID_If_Big_Biz_isnull => 0, patch_default and ri.field_specificity=0 => s.RID_If_Big_Biz_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j1,s.nulls_RID_If_Big_Biz,Specificities(ih).RID_If_Big_Biz_values_persisted,RID_If_Big_Biz,RID_If_Big_Biz_weight100,add_RID_If_Big_Biz,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(POWID)) : PERSIST('~temp::POWID::BIPV2_POWID_Platform::mc',EXPIRE(Config.PersistExpire)); // Distributed for keybuild case
 
//Now prepare candidate file for charter attribute file
layout_charter_candidates add_charter_RID_If_Big_Biz(layout_charter_candidates le,Specificities(ih).RID_If_Big_Biz_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.RID_If_Big_Biz_weight100 := MAP (le.RID_If_Big_Biz_isnull => 0, patch_default and ri.field_specificity=0 => s.RID_If_Big_Biz_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(charter_pp,s.nulls_RID_If_Big_Biz,Specificities(ih).RID_If_Big_Biz_values_persisted,RID_If_Big_Biz,RID_If_Big_Biz_weight100,add_charter_RID_If_Big_Biz,jcharter_0);
layout_charter_candidates add_charter_cnp_name(layout_charter_candidates le,Specificities(ih).cnp_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_name_weight100 := MAP (le.cnp_name_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.cnp_name := IF( ri.field_specificity<>0 or ri.word<>'',SELF.cnp_name_weight100+' '+ri.word,SALT32.Fn_WordBag_AppendSpecs_Fake(le.cnp_name, s.cnp_name_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(jcharter_0,s.nulls_cnp_name,Specificities(ih).cnp_name_values_persisted,cnp_name,cnp_name_weight100,add_charter_cnp_name,jcharter_1);
layout_charter_candidates add_charter_company_name(layout_charter_candidates le,Specificities(ih).company_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_name_weight100 := MAP (le.company_name_isnull => 0, patch_default and ri.field_specificity=0 => s.company_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.company_name := IF( ri.field_specificity<>0 or ri.word<>'',SELF.company_name_weight100+' '+ri.word,SALT32.Fn_WordBag_AppendSpecs_Fake(le.company_name, s.company_name_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(jcharter_1,s.nulls_company_name,Specificities(ih).company_name_values_persisted,company_name,company_name_weight100,add_charter_company_name,jcharter_2);
layout_charter_candidates add_charter_prim_name(layout_charter_candidates le,Specificities(ih).prim_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_weight100 := MAP (le.prim_name_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(jcharter_2,s.nulls_prim_name,Specificities(ih).prim_name_values_persisted,prim_name,prim_name_weight100,add_charter_prim_name,jcharter_3);
layout_charter_candidates add_charter_cnp_number(layout_charter_candidates le,Specificities(ih).cnp_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_number_weight100 := MAP (le.cnp_number_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(jcharter_3,s.nulls_cnp_number,Specificities(ih).cnp_number_values_persisted,cnp_number,cnp_number_weight100,add_charter_cnp_number,jcharter_4);
layout_charter_candidates add_charter_prim_range(layout_charter_candidates le,Specificities(ih).prim_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_weight100 := MAP (le.prim_range_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(jcharter_4,s.nulls_prim_range,Specificities(ih).prim_range_values_persisted,prim_range,prim_range_weight100,add_charter_prim_range,jcharter_6);
EXPORT charter_candidates := jcharter_6 : PERSIST('~temp::POWID::BIPV2_POWID_Platform::mc::charter',EXPIRE(Config.PersistExpire));
//Now see if these records are actually linkable
TotalWeight := Annotated.RID_If_Big_Biz_weight100 + Annotated.cnp_name_weight100 + Annotated.company_name_weight100 + Annotated.prim_name_weight100 + Annotated.cnp_number_weight100 + Annotated.zip_weight100 + Annotated.prim_range_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
EXPORT BuddyCounts := TABLE(Annotated,{ buddies, Cnt := COUNT(GROUP) }, buddies, FEW);
EXPORT HasBuddies := TABLE(Annotated(buddies>0), { rcid });
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(); //Attribute Files might bring total score up to threshold
END;
