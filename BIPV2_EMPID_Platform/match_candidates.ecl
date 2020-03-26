// Begin code to produce match candidates
IMPORT SALT30,ut;
IMPORT BIPV2_Tools; // Import modules for  attribute definitions
EXPORT match_candidates(DATASET(layout_EmpID) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := BasicMatch(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00(SALT_Partition<>'*'),{rcid,isCorpEnhanced,contact_job_title_derived,cname_devanitize,prim_range,prim_name,zip,zip4,fname,lname,contact_phone,contact_did,contact_ssn,company_name,sec_range,v_city_name,st,company_inc_state,company_charter_number,active_duns_number,hist_duns_number,active_domestic_corp_key,hist_domestic_corp_key,foreign_corp_key,unk_corp_key,company_fein,cnp_btype,cnp_name,company_name_type_derived,company_bdid,nodes_total,dt_first_seen,dt_last_seen,SALT_Partition,UltID,OrgID,SeleID,EmpID}),HASH(EmpID));
 
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 cname_devanitize_pop := AVE(GROUP,IF(thin_table.cname_devanitize IN SET(s.nulls_cname_devanitize,cname_devanitize),0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF(thin_table.prim_range IN SET(s.nulls_prim_range,prim_range),0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF(thin_table.prim_name IN SET(s.nulls_prim_name,prim_name),0,100));
  REAL8 zip_pop := AVE(GROUP,IF(thin_table.zip IN SET(s.nulls_zip,zip),0,100));
  REAL8 fname_pop := AVE(GROUP,IF(thin_table.fname IN SET(s.nulls_fname,fname),0,100));
  REAL8 lname_pop := AVE(GROUP,IF(thin_table.lname IN SET(s.nulls_lname,lname),0,100));
  REAL8 contact_phone_pop := AVE(GROUP,IF(thin_table.contact_phone IN SET(s.nulls_contact_phone,contact_phone),0,100));
  REAL8 contact_did_pop := AVE(GROUP,IF(thin_table.contact_did IN SET(s.nulls_contact_did,contact_did),0,100));
  REAL8 contact_ssn_pop := AVE(GROUP,IF(thin_table.contact_ssn IN SET(s.nulls_contact_ssn,contact_ssn),0,100));
END;
EXPORT PrePropogationStats := TABLE(thin_table,PrePropCounts);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 cname_devanitize_prop := 0;
  UNSIGNED1 prim_name_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
 
SALT30.mac_prop_field(with_props(cname_devanitize NOT IN SET(s.nulls_cname_devanitize,cname_devanitize)),cname_devanitize,EmpID,cname_devanitize_props); // For every DID find the best FULL cname_devanitize
layout_withpropvars take_cname_devanitize(with_props le,cname_devanitize_props ri) := TRANSFORM
  SELF.cname_devanitize := IF ( le.cname_devanitize IN SET(s.nulls_cname_devanitize,cname_devanitize) and ri.EmpID<>(TYPEOF(ri.EmpID))'', ri.cname_devanitize, le.cname_devanitize );
  SELF.cname_devanitize_prop := le.cname_devanitize_prop + IF ( le.cname_devanitize IN SET(s.nulls_cname_devanitize,cname_devanitize) and ri.cname_devanitize NOT IN SET(s.nulls_cname_devanitize,cname_devanitize) and ri.EmpID<>(TYPEOF(ri.EmpID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj2 := JOIN(with_props,cname_devanitize_props,left.EmpID=right.EmpID,take_cname_devanitize(left,right),LEFT OUTER,HASH);
 
SALT30.mac_prop_field(with_props(prim_name NOT IN SET(s.nulls_prim_name,prim_name)),prim_name,EmpID,prim_name_props); // For every DID find the best FULL prim_name
layout_withpropvars take_prim_name(with_props le,prim_name_props ri) := TRANSFORM
  SELF.prim_name := IF ( le.prim_name IN SET(s.nulls_prim_name,prim_name) and ri.EmpID<>(TYPEOF(ri.EmpID))'', ri.prim_name, le.prim_name );
  SELF.prim_name_prop := le.prim_name_prop + IF ( le.prim_name IN SET(s.nulls_prim_name,prim_name) and ri.prim_name NOT IN SET(s.nulls_prim_name,prim_name) and ri.EmpID<>(TYPEOF(ri.EmpID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj4 := JOIN(pj2,prim_name_props,left.EmpID=right.EmpID,take_prim_name(left,right),LEFT OUTER,HASH);
 
pj4 do_computes(pj4 le) := TRANSFORM
  SELF := le;
END;
SHARED propogated := PROJECT(pj4,do_computes(left)) : PERSIST('~temp::EmpID::BIPV2_EMPID_Platform::mc_props::EmpID',EXPIRE(Config.PersistExpire)); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 cname_devanitize_pop := AVE(GROUP,IF(propogated.cname_devanitize IN SET(s.nulls_cname_devanitize,cname_devanitize),0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF(propogated.prim_range IN SET(s.nulls_prim_range,prim_range),0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF(propogated.prim_name IN SET(s.nulls_prim_name,prim_name),0,100));
  REAL8 zip_pop := AVE(GROUP,IF(propogated.zip IN SET(s.nulls_zip,zip),0,100));
  REAL8 fname_pop := AVE(GROUP,IF(propogated.fname IN SET(s.nulls_fname,fname),0,100));
  REAL8 lname_pop := AVE(GROUP,IF(propogated.lname IN SET(s.nulls_lname,lname),0,100));
  REAL8 contact_phone_pop := AVE(GROUP,IF(propogated.contact_phone IN SET(s.nulls_contact_phone,contact_phone),0,100));
  REAL8 contact_did_pop := AVE(GROUP,IF(propogated.contact_did IN SET(s.nulls_contact_did,contact_did),0,100));
  REAL8 contact_ssn_pop := AVE(GROUP,IF(propogated.contact_ssn IN SET(s.nulls_contact_ssn,contact_ssn),0,100));
END;
EXPORT PostPropogationStats := TABLE(propogated,PostPropCounts);
SHARED h0 := DEDUP( SORT ( DISTRIBUTE(propogated,HASH(EmpID)),  EXCEPT rcid, LOCAL ), EXCEPT rcid, LOCAL );// Only one copy of each record
 
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT30.UIDType EmpID1;
  SALT30.UIDType EmpID2;
  SALT30.UIDType rcid1 := 0;
  SALT30.UIDType rcid2 := 0;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0} AND NOT [cname_devanitize]; // remove wordbag fields which need to be expanded
  STRING500 cname_devanitize := h0.cname_devanitize; // Expanded wordbag field
  INTEGER2 cname_devanitize_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cname_devanitize_isnull := h0.cname_devanitize  IN SET(s.nulls_cname_devanitize,cname_devanitize); // Simplify later processing 
  INTEGER2 prim_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_isnull := h0.prim_range  IN SET(s.nulls_prim_range,prim_range); // Simplify later processing 
  INTEGER2 prim_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_isnull := h0.prim_name  IN SET(s.nulls_prim_name,prim_name); // Simplify later processing 
  INTEGER2 zip_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip_isnull := h0.zip  IN SET(s.nulls_zip,zip); // Simplify later processing 
  INTEGER2 fname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN fname_isnull := h0.fname  IN SET(s.nulls_fname,fname); // Simplify later processing 
  UNSIGNED fname_cnt := 0; // Number of instances with this particular field value
  STRING20 fname_PreferredName := (STRING20)'';
  UNSIGNED fname_PreferredName_cnt := 0; // Number of names instances matching this one using PreferredName
  INTEGER2 lname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN lname_isnull := h0.lname  IN SET(s.nulls_lname,lname); // Simplify later processing 
  INTEGER2 contact_phone_weight100 := 0; // Contains 100x the specificity
  BOOLEAN contact_phone_isnull := h0.contact_phone  IN SET(s.nulls_contact_phone,contact_phone); // Simplify later processing 
  INTEGER2 contact_did_weight100 := 0; // Contains 100x the specificity
  BOOLEAN contact_did_isnull := h0.contact_did  IN SET(s.nulls_contact_did,contact_did); // Simplify later processing 
  INTEGER2 contact_ssn_weight100 := 0; // Contains 100x the specificity
  BOOLEAN contact_ssn_isnull := h0.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
 
//Would also create auto-id fields here
 
layout_candidates add_contact_ssn(layout_candidates le,Specificities(ih).contact_ssn_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.contact_ssn_weight100 := MAP (le.contact_ssn_isnull => 0, patch_default and ri.field_specificity=0 => s.contact_ssn_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j8 := JOIN(h1,PULL(Specificities(ih).contact_ssn_values_persisted),LEFT.contact_ssn=RIGHT.contact_ssn,add_contact_ssn(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_fname(layout_candidates le,Specificities(ih).fname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.fname_cnt := ri.cnt;
  SELF.fname_PreferredName_cnt := ri.PreferredName_cnt; // Copy in count of matching PreferredName values for field fname
  SELF.fname_PreferredName := ri.fname_PreferredName; // Copy PreferredName value for field fname
  SELF.fname_weight100 := MAP (le.fname_isnull => 0, patch_default and ri.field_specificity=0 => s.fname_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j8,s.nulls_fname,Specificities(ih).fname_values_persisted,fname,fname_weight100,add_fname,j7);
layout_candidates add_prim_range(layout_candidates le,Specificities(ih).prim_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_weight100 := MAP (le.prim_range_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j7,s.nulls_prim_range,Specificities(ih).prim_range_values_persisted,prim_range,prim_range_weight100,add_prim_range,j6);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip_weight100 := MAP (le.zip_isnull => 0, patch_default and ri.field_specificity=0 => s.zip_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j6,s.nulls_zip,Specificities(ih).zip_values_persisted,zip,zip_weight100,add_zip,j5);
layout_candidates add_lname(layout_candidates le,Specificities(ih).lname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.lname_weight100 := MAP (le.lname_isnull => 0, patch_default and ri.field_specificity=0 => s.lname_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j5,s.nulls_lname,Specificities(ih).lname_values_persisted,lname,lname_weight100,add_lname,j4);
layout_candidates add_prim_name(layout_candidates le,Specificities(ih).prim_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_weight100 := MAP (le.prim_name_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j4,s.nulls_prim_name,Specificities(ih).prim_name_values_persisted,prim_name,prim_name_weight100,add_prim_name,j3);
layout_candidates add_cname_devanitize(layout_candidates le,Specificities(ih).cname_devanitize_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cname_devanitize_weight100 := MAP (le.cname_devanitize_isnull => 0, patch_default and ri.field_specificity=0 => s.cname_devanitize_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.cname_devanitize := IF( ri.field_specificity<>0 or ri.word<>'',SELF.cname_devanitize_weight100+' '+ri.word,SALT30.Fn_WordBag_AppendSpecs_Fake(le.cname_devanitize, s.cname_devanitize_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j3,s.nulls_cname_devanitize,Specificities(ih).cname_devanitize_values_persisted,cname_devanitize,cname_devanitize_weight100,add_cname_devanitize,j2);
layout_candidates add_contact_did(layout_candidates le,Specificities(ih).contact_did_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.contact_did_weight100 := MAP (le.contact_did_isnull => 0, patch_default and ri.field_specificity=0 => s.contact_did_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j2,s.nulls_contact_did,Specificities(ih).contact_did_values_persisted,contact_did,contact_did_weight100,add_contact_did,j1);
layout_candidates add_contact_phone(layout_candidates le,Specificities(ih).contact_phone_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.contact_phone_weight100 := MAP (le.contact_phone_isnull => 0, patch_default and ri.field_specificity=0 => s.contact_phone_max, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT30.MAC_Choose_JoinType(j1,s.nulls_contact_phone,Specificities(ih).contact_phone_values_persisted,contact_phone,contact_phone_weight100,add_contact_phone,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(EmpID)) : PERSIST('~temp::EmpID::BIPV2_EMPID_Platform::mc',EXPIRE(Config.PersistExpire)); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.contact_phone_weight100 + Annotated.contact_did_weight100 + Annotated.cname_devanitize_weight100 + Annotated.prim_name_weight100 + Annotated.lname_weight100 + Annotated.zip_weight100 + Annotated.prim_range_weight100 + Annotated.fname_weight100 + Annotated.contact_ssn_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
