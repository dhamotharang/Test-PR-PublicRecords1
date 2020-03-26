// Begin code to produce match candidates
IMPORT SALT32,ut;
IMPORT BIPV2_Tools; // Import modules for  attribute definitions
EXPORT match_candidates(DATASET(layout_EmpID) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := BasicMatch(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00(SALT_Partition<>'*'),{rcid,isContact,orgid,fname,fname_len,mname,mname_len,lname,lname_len,name_suffix,contact_did,contact_ssn,contact_ssn_len,contact_phone,contact_email,company_name,prim_range,prim_name,sec_range,v_city_name,st,zip,active_duns_number,hist_duns_number,active_domestic_corp_key,hist_domestic_corp_key,foreign_corp_key,unk_corp_key,dt_first_seen,dt_last_seen,SALT_Partition,EmpID}),HASH(EmpID));
 
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 orgid_pop := AVE(GROUP,IF(thin_table.orgid  IN SET(s.nulls_orgid,orgid) OR thin_table.orgid = (TYPEOF(thin_table.orgid))'',0,100));
  REAL8 fname_pop := AVE(GROUP,IF(thin_table.fname  IN SET(s.nulls_fname,fname) OR thin_table.fname = (TYPEOF(thin_table.fname))'',0,100));
  REAL8 mname_pop := AVE(GROUP,IF(thin_table.mname  IN SET(s.nulls_mname,mname) OR thin_table.mname = (TYPEOF(thin_table.mname))'',0,100));
  REAL8 lname_pop := AVE(GROUP,IF(thin_table.lname  IN SET(s.nulls_lname,lname) OR thin_table.lname = (TYPEOF(thin_table.lname))'',0,100));
  REAL8 name_suffix_pop := AVE(GROUP,IF(thin_table.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR thin_table.name_suffix = (TYPEOF(thin_table.name_suffix))'',0,100));
  REAL8 contact_did_pop := AVE(GROUP,IF(thin_table.contact_did  IN SET(s.nulls_contact_did,contact_did) OR thin_table.contact_did = (TYPEOF(thin_table.contact_did))'',0,100));
  REAL8 contact_ssn_pop := AVE(GROUP,IF(thin_table.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn) OR thin_table.contact_ssn = (TYPEOF(thin_table.contact_ssn))'',0,100));
END;
EXPORT PrePropogationStats := TABLE(thin_table,PrePropCounts);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 mname_prop := 0;
  UNSIGNED1 name_suffix_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
 
SALT32.mac_prop_field_init(with_props(mname NOT IN SET(s.nulls_mname,mname)),mname,EmpID,mname_props); // For every DID find the best FULL mname
layout_withpropvars take_mname(with_props le,mname_props ri) := TRANSFORM
  SELF.mname := IF ( le.mname = ri.mname[1..LENGTH(TRIM(le.mname))], ri.mname, le.mname );
  SELF.mname_prop := IF ( LENGTH(TRIM(le.mname)) < LENGTH(TRIM(ri.mname)) and le.mname=ri.mname[1..LENGTH(TRIM(le.mname))],LENGTH(TRIM(ri.mname)) - LENGTH(TRIM(le.mname)) , le.mname_prop ); // Store the amount propogated
  SELF.mname_len := IF ( le.mname = ri.mname[1..LENGTH(TRIM(le.mname))], LENGTH(TRIM(ri.mname)), le.mname_len );
  SELF := le;
  END;
SHARED pj3 := JOIN(with_props,mname_props,left.EmpID=right.EmpID AND (left.mname='' OR left.mname[1]=right.mname[1]),take_mname(left,right),LEFT OUTER,HASH);
 
SALT32.mac_prop_field(with_props(name_suffix NOT IN SET(s.nulls_name_suffix,name_suffix)),name_suffix,EmpID,name_suffix_props); // For every DID find the best FULL name_suffix
layout_withpropvars take_name_suffix(with_props le,name_suffix_props ri) := TRANSFORM
  SELF.name_suffix := IF ( le.name_suffix IN SET(s.nulls_name_suffix,name_suffix) and ri.EmpID<>(TYPEOF(ri.EmpID))'', ri.name_suffix, le.name_suffix );
  SELF.name_suffix_prop := le.name_suffix_prop + IF ( le.name_suffix IN SET(s.nulls_name_suffix,name_suffix) and ri.name_suffix NOT IN SET(s.nulls_name_suffix,name_suffix) and ri.EmpID<>(TYPEOF(ri.EmpID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj5 := JOIN(pj3,name_suffix_props,left.EmpID=right.EmpID,take_name_suffix(left,right),LEFT OUTER,HASH);
 
pj5 do_computes(pj5 le) := TRANSFORM
  SELF := le;
END;
SHARED propogated := PROJECT(pj5,do_computes(left)) : PERSIST('~temp::EmpID::BIPV2_EMPID_DOWN_Platform::mc_props::EmpID',EXPIRE(Config.PersistExpire)); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 orgid_pop := AVE(GROUP,IF(propogated.orgid  IN SET(s.nulls_orgid,orgid) OR propogated.orgid = (TYPEOF(propogated.orgid))'',0,100));
  REAL8 fname_pop := AVE(GROUP,IF(propogated.fname  IN SET(s.nulls_fname,fname) OR propogated.fname = (TYPEOF(propogated.fname))'',0,100));
  REAL8 mname_pop := AVE(GROUP,IF(propogated.mname  IN SET(s.nulls_mname,mname) OR propogated.mname = (TYPEOF(propogated.mname))'',0,100));
  REAL8 lname_pop := AVE(GROUP,IF(propogated.lname  IN SET(s.nulls_lname,lname) OR propogated.lname = (TYPEOF(propogated.lname))'',0,100));
  REAL8 name_suffix_pop := AVE(GROUP,IF(propogated.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR propogated.name_suffix = (TYPEOF(propogated.name_suffix))'',0,100));
  REAL8 contact_did_pop := AVE(GROUP,IF(propogated.contact_did  IN SET(s.nulls_contact_did,contact_did) OR propogated.contact_did = (TYPEOF(propogated.contact_did))'',0,100));
  REAL8 contact_ssn_pop := AVE(GROUP,IF(propogated.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn) OR propogated.contact_ssn = (TYPEOF(propogated.contact_ssn))'',0,100));
END;
EXPORT PostPropogationStats := TABLE(propogated,PostPropCounts);
  Grpd := GROUP( DISTRIBUTE( TABLE( propogated, { propogated, UNSIGNED2 Buddies := 0 }),HASH(EmpID)),orgid,fname,mname,lname,name_suffix,contact_did,contact_ssn,dt_first_seen,dt_last_seen);
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
  SALT32.UIDType EmpID1;
  SALT32.UIDType EmpID2;
  SALT32.UIDType rcid1 := 0;
  SALT32.UIDType rcid2 := 0;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0};
  INTEGER2 orgid_weight100 := 0; // Contains 100x the specificity
  BOOLEAN orgid_isnull := h0.orgid  IN SET(s.nulls_orgid,orgid) OR h0.orgid = (TYPEOF(h0.orgid))''; // Simplify later processing 
  INTEGER2 fname_weight100 := 0; // Contains 100x the specificity
  INTEGER2 fname_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN fname_isnull := h0.fname  IN SET(s.nulls_fname,fname) OR h0.fname = (TYPEOF(h0.fname))''; // Simplify later processing 
  UNSIGNED fname_cnt := 0; // Number of instances with this particular field value
  UNSIGNED fname_e1_cnt := 0; // Number of names instances matching this one by edit distance
  STRING20 fname_PreferredName := (STRING20)'';
  UNSIGNED fname_PreferredName_cnt := 0; // Number of names instances matching this one using PreferredName
  INTEGER2 mname_weight100 := 0; // Contains 100x the specificity
  INTEGER2 mname_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN mname_isnull := h0.mname  IN SET(s.nulls_mname,mname) OR h0.mname = (TYPEOF(h0.mname))''; // Simplify later processing 
  UNSIGNED mname_cnt := 0; // Number of instances with this particular field value
  UNSIGNED mname_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 lname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN lname_isnull := h0.lname  IN SET(s.nulls_lname,lname) OR h0.lname = (TYPEOF(h0.lname))''; // Simplify later processing 
  UNSIGNED lname_cnt := 0; // Number of instances with this particular field value
  UNSIGNED lname_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 name_suffix_weight100 := 0; // Contains 100x the specificity
  BOOLEAN name_suffix_isnull := h0.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR h0.name_suffix = (TYPEOF(h0.name_suffix))''; // Simplify later processing 
  UNSIGNED name_suffix_cnt := 0; // Number of instances with this particular field value
  STRING5 name_suffix_NormSuffix := (STRING5)'';
  UNSIGNED name_suffix_NormSuffix_cnt := 0; // Number of names instances matching this one using NormSuffix
  INTEGER2 contact_did_weight100 := 0; // Contains 100x the specificity
  BOOLEAN contact_did_isnull := h0.contact_did  IN SET(s.nulls_contact_did,contact_did) OR h0.contact_did = (TYPEOF(h0.contact_did))''; // Simplify later processing 
  INTEGER2 contact_ssn_weight100 := 0; // Contains 100x the specificity
  BOOLEAN contact_ssn_isnull := h0.contact_ssn  IN SET(s.nulls_contact_ssn,contact_ssn) OR h0.contact_ssn = (TYPEOF(h0.contact_ssn))''; // Simplify later processing 
  UNSIGNED contact_ssn_cnt := 0; // Number of instances with this particular field value
  UNSIGNED contact_ssn_e1_cnt := 0; // Number of names instances matching this one by edit distance
  STRING4 contact_ssn_Right4 := (STRING4)'';
  UNSIGNED contact_ssn_Right4_cnt := 0; // Number of names instances matching this one using Right4
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
 
//Would also create auto-id fields here
 
layout_candidates add_name_suffix(layout_candidates le,Specificities(ih).name_suffix_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.name_suffix_cnt := ri.cnt;
  SELF.name_suffix_NormSuffix_cnt := ri.NormSuffix_cnt; // Copy in count of matching NormSuffix values for field name_suffix
  SELF.name_suffix_NormSuffix := ri.name_suffix_NormSuffix; // Copy NormSuffix value for field name_suffix
  SELF.name_suffix_weight100 := MAP (le.name_suffix_isnull => 0, patch_default and ri.field_specificity=0 => s.name_suffix_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(h1,s.nulls_name_suffix,Specificities(ih).name_suffix_values_persisted,name_suffix,name_suffix_weight100,add_name_suffix,j6);
layout_candidates add_fname(layout_candidates le,Specificities(ih).fname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.fname_cnt := ri.cnt;
  SELF.fname_e1_cnt := ri.e1_cnt;
  SELF.fname_PreferredName_cnt := ri.PreferredName_cnt; // Copy in count of matching PreferredName values for field fname
  SELF.fname_PreferredName := ri.fname_PreferredName; // Copy PreferredName value for field fname
  SELF.fname_weight100 := MAP (le.fname_isnull => 0, patch_default and ri.field_specificity=0 => s.fname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.fname_initial_char_weight100 := MAP (le.fname_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j6,s.nulls_fname,Specificities(ih).fname_values_persisted,fname,fname_weight100,add_fname,j5);
layout_candidates add_mname(layout_candidates le,Specificities(ih).mname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.mname_cnt := ri.cnt;
  SELF.mname_e1_cnt := ri.e1_cnt;
  SELF.mname_weight100 := MAP (le.mname_isnull => 0, patch_default and ri.field_specificity=0 => s.mname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.mname_initial_char_weight100 := MAP (le.mname_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j5,s.nulls_mname,Specificities(ih).mname_values_persisted,mname,mname_weight100,add_mname,j4);
layout_candidates add_lname(layout_candidates le,Specificities(ih).lname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.lname_cnt := ri.cnt;
  SELF.lname_e1_cnt := ri.e1_cnt;
  SELF.lname_weight100 := MAP (le.lname_isnull => 0, patch_default and ri.field_specificity=0 => s.lname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j4,s.nulls_lname,Specificities(ih).lname_values_persisted,lname,lname_weight100,add_lname,j3);
layout_candidates add_contact_did(layout_candidates le,Specificities(ih).contact_did_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.contact_did_weight100 := MAP (le.contact_did_isnull => 0, patch_default and ri.field_specificity=0 => s.contact_did_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j3,s.nulls_contact_did,Specificities(ih).contact_did_values_persisted,contact_did,contact_did_weight100,add_contact_did,j2);
layout_candidates add_orgid(layout_candidates le,Specificities(ih).orgid_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.orgid_weight100 := MAP (le.orgid_isnull => 0, patch_default and ri.field_specificity=0 => s.orgid_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j2,s.nulls_orgid,Specificities(ih).orgid_values_persisted,orgid,orgid_weight100,add_orgid,j1);
layout_candidates add_contact_ssn(layout_candidates le,Specificities(ih).contact_ssn_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.contact_ssn_cnt := ri.cnt;
  SELF.contact_ssn_e1_cnt := ri.e1_cnt;
  SELF.contact_ssn_Right4_cnt := ri.Right4_cnt; // Copy in count of matching Right4 values for field contact_ssn
  SELF.contact_ssn_Right4 := ri.contact_ssn_Right4; // Copy Right4 value for field contact_ssn
  SELF.contact_ssn_weight100 := MAP (le.contact_ssn_isnull => 0, patch_default and ri.field_specificity=0 => s.contact_ssn_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT32.MAC_Choose_JoinType(j1,s.nulls_contact_ssn,Specificities(ih).contact_ssn_values_persisted,contact_ssn,contact_ssn_weight100,add_contact_ssn,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(EmpID)) : PERSIST('~temp::EmpID::BIPV2_EMPID_DOWN_Platform::mc',EXPIRE(Config.PersistExpire)); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.contact_ssn_weight100 + Annotated.orgid_weight100 + Annotated.contact_did_weight100 + Annotated.lname_weight100 + Annotated.mname_weight100 + Annotated.fname_weight100 + Annotated.name_suffix_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
EXPORT BuddyCounts := TABLE(Annotated,{ buddies, Cnt := COUNT(GROUP) }, buddies, FEW);
EXPORT HasBuddies := TABLE(Annotated(buddies>0), { rcid });
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
