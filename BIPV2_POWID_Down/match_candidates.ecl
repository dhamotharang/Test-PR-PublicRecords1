// Begin code to produce match candidates
IMPORT SALT35,ut;
EXPORT match_candidates(DATASET(layout_POWID_Down) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := BasicMatch(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00(SALT_Partition<>'*'),{rcid,company_name,orgid,prim_range,prim_name,st,v_city_name,zip,csz,addr1,address,dt_first_seen,dt_last_seen,SALT_Partition,POWID}),HASH(POWID));
 
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 orgid_pop := AVE(GROUP,IF((thin_table.orgid  IN SET(s.nulls_orgid,orgid) OR thin_table.orgid = (TYPEOF(thin_table.orgid))''),0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF((thin_table.prim_range  IN SET(s.nulls_prim_range,prim_range) OR thin_table.prim_range = (TYPEOF(thin_table.prim_range))''),0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF((thin_table.prim_name  IN SET(s.nulls_prim_name,prim_name) OR thin_table.prim_name = (TYPEOF(thin_table.prim_name))''),0,100));
  REAL8 st_pop := AVE(GROUP,IF((thin_table.st  IN SET(s.nulls_st,st) OR thin_table.st = (TYPEOF(thin_table.st))''),0,100));
  REAL8 v_city_name_pop := AVE(GROUP,IF((thin_table.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR thin_table.v_city_name = (TYPEOF(thin_table.v_city_name))''),0,100));
  REAL8 zip_pop := AVE(GROUP,IF((thin_table.zip  IN SET(s.nulls_zip,zip) OR thin_table.zip = (TYPEOF(thin_table.zip))''),0,100));
  REAL8 csz_pop := AVE(GROUP,IF(((thin_table.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR thin_table.v_city_name = (TYPEOF(thin_table.v_city_name))'') AND (thin_table.st  IN SET(s.nulls_st,st) OR thin_table.st = (TYPEOF(thin_table.st))'') AND (thin_table.zip  IN SET(s.nulls_zip,zip) OR thin_table.zip = (TYPEOF(thin_table.zip))'')),0,100));
  REAL8 addr1_pop := AVE(GROUP,IF(((thin_table.prim_range  IN SET(s.nulls_prim_range,prim_range) OR thin_table.prim_range = (TYPEOF(thin_table.prim_range))'') AND (thin_table.prim_name  IN SET(s.nulls_prim_name,prim_name) OR thin_table.prim_name = (TYPEOF(thin_table.prim_name))'')),0,100));
  REAL8 address_pop := AVE(GROUP,IF((((thin_table.prim_range  IN SET(s.nulls_prim_range,prim_range) OR thin_table.prim_range = (TYPEOF(thin_table.prim_range))'') AND (thin_table.prim_name  IN SET(s.nulls_prim_name,prim_name) OR thin_table.prim_name = (TYPEOF(thin_table.prim_name))'')) AND ((thin_table.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR thin_table.v_city_name = (TYPEOF(thin_table.v_city_name))'') AND (thin_table.st  IN SET(s.nulls_st,st) OR thin_table.st = (TYPEOF(thin_table.st))'') AND (thin_table.zip  IN SET(s.nulls_zip,zip) OR thin_table.zip = (TYPEOF(thin_table.zip))''))),0,100));
END;
EXPORT PPS := TABLE(thin_table,PrePropCounts);
EXPORT poprec := RECORD
	STRING label;
		REAL8 pop;
	END;
EXPORT PrePropogationStats := SALT35.MAC_Pivot(PPS, poprec);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 prim_range_prop := 0;
  UNSIGNED1 prim_name_prop := 0;
  UNSIGNED1 st_prop := 0;
  UNSIGNED1 v_city_name_prop := 0;
  UNSIGNED1 zip_prop := 0;
  UNSIGNED1 csz_prop := 0;
  UNSIGNED1 addr1_prop := 0;
  UNSIGNED1 address_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
 
SALT35.mac_prop_field(with_props(prim_name NOT IN SET(s.nulls_prim_name,prim_name)),prim_name,POWID,prim_name_props); // For every DID find the best FULL prim_name
layout_withpropvars take_prim_name(with_props le,prim_name_props ri) := TRANSFORM
  SELF.prim_name := IF ( le.prim_name IN SET(s.nulls_prim_name,prim_name) and ri.POWID<>(TYPEOF(ri.POWID))'', ri.prim_name, le.prim_name );
  SELF.prim_name_prop := le.prim_name_prop + IF ( le.prim_name IN SET(s.nulls_prim_name,prim_name) and ri.prim_name NOT IN SET(s.nulls_prim_name,prim_name) and ri.POWID<>(TYPEOF(ri.POWID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj3 := JOIN(with_props,prim_name_props,left.POWID=right.POWID,take_prim_name(left,right),LEFT OUTER,HASH,HINT(parallel_match));
 
pj3 do_computes(pj3 le) := TRANSFORM
  SELF.csz := IF (Fields.InValid_csz((SALT35.StrType)le.v_city_name,(SALT35.StrType)le.st,(SALT35.StrType)le.zip)>0,0,HASH32((SALT35.StrType)le.v_city_name,(SALT35.StrType)le.st,(SALT35.StrType)le.zip)); // Combine child fields into 1 for specificity counting
  SELF.addr1 := IF (Fields.InValid_addr1((SALT35.StrType)le.prim_range,(SALT35.StrType)le.prim_name)>0,0,HASH32((SALT35.StrType)le.prim_range,(SALT35.StrType)le.prim_name)); // Combine child fields into 1 for specificity counting
  SELF.addr1_prop := IF( le.prim_name_prop > 0, 2, 0 );
  SELF.address := IF (Fields.InValid_address((SALT35.StrType)SELF.addr1,(SALT35.StrType)SELF.csz)>0,0,HASH32((SALT35.StrType)SELF.addr1,(SALT35.StrType)SELF.csz)); // Combine child fields into 1 for specificity counting
  SELF.address_prop := IF( SELF.addr1_prop > 0, 1, 0 );
  SELF := le;
END;
SHARED propogated := PROJECT(pj3,do_computes(left)) : PERSIST('~temp::POWID::BIPV2_POWID_Down::mc_props::POWID_Down',EXPIRE(Config.PersistExpire)); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 orgid_pop := AVE(GROUP,IF((propogated.orgid  IN SET(s.nulls_orgid,orgid) OR propogated.orgid = (TYPEOF(propogated.orgid))''),0,100));
  REAL8 prim_range_pop := AVE(GROUP,IF((propogated.prim_range  IN SET(s.nulls_prim_range,prim_range) OR propogated.prim_range = (TYPEOF(propogated.prim_range))''),0,100));
  REAL8 prim_name_pop := AVE(GROUP,IF((propogated.prim_name  IN SET(s.nulls_prim_name,prim_name) OR propogated.prim_name = (TYPEOF(propogated.prim_name))''),0,100));
  REAL8 st_pop := AVE(GROUP,IF((propogated.st  IN SET(s.nulls_st,st) OR propogated.st = (TYPEOF(propogated.st))''),0,100));
  REAL8 v_city_name_pop := AVE(GROUP,IF((propogated.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR propogated.v_city_name = (TYPEOF(propogated.v_city_name))''),0,100));
  REAL8 zip_pop := AVE(GROUP,IF((propogated.zip  IN SET(s.nulls_zip,zip) OR propogated.zip = (TYPEOF(propogated.zip))''),0,100));
  REAL8 csz_pop := AVE(GROUP,IF(((propogated.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR propogated.v_city_name = (TYPEOF(propogated.v_city_name))'') AND (propogated.st  IN SET(s.nulls_st,st) OR propogated.st = (TYPEOF(propogated.st))'') AND (propogated.zip  IN SET(s.nulls_zip,zip) OR propogated.zip = (TYPEOF(propogated.zip))'')),0,100));
  REAL8 addr1_pop := AVE(GROUP,IF(((propogated.prim_range  IN SET(s.nulls_prim_range,prim_range) OR propogated.prim_range = (TYPEOF(propogated.prim_range))'') AND (propogated.prim_name  IN SET(s.nulls_prim_name,prim_name) OR propogated.prim_name = (TYPEOF(propogated.prim_name))'')),0,100));
  REAL8 address_pop := AVE(GROUP,IF((((propogated.prim_range  IN SET(s.nulls_prim_range,prim_range) OR propogated.prim_range = (TYPEOF(propogated.prim_range))'') AND (propogated.prim_name  IN SET(s.nulls_prim_name,prim_name) OR propogated.prim_name = (TYPEOF(propogated.prim_name))'')) AND ((propogated.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR propogated.v_city_name = (TYPEOF(propogated.v_city_name))'') AND (propogated.st  IN SET(s.nulls_st,st) OR propogated.st = (TYPEOF(propogated.st))'') AND (propogated.zip  IN SET(s.nulls_zip,zip) OR propogated.zip = (TYPEOF(propogated.zip))''))),0,100));
END;
 PoPS := TABLE(propogated,PostPropCounts);
EXPORT PostPropogationStats := SALT35.MAC_Pivot(PoPS, poprec);
  Grpd := GROUP( SORT(
    DISTRIBUTE( TABLE( propogated, { propogated, UNSIGNED2 Buddies := 0 }),HASH(POWID)),
    POWID,orgid,prim_range,prim_name,st,v_city_name,zip,dt_first_seen,dt_last_seen, LOCAL),
    POWID,orgid,prim_range,prim_name,st,v_city_name,zip,dt_first_seen,dt_last_seen, LOCAL);
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
  SALT35.UIDType POWID1;
  SALT35.UIDType POWID2;
  SALT35.UIDType rcid1 := 0;
  SALT35.UIDType rcid2 := 0;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0};
  INTEGER2 orgid_weight100 := 0; // Contains 100x the specificity
  BOOLEAN orgid_isnull := (h0.orgid  IN SET(s.nulls_orgid,orgid) OR h0.orgid = (TYPEOF(h0.orgid))''); // Simplify later processing 
  INTEGER2 prim_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_isnull := (h0.prim_range  IN SET(s.nulls_prim_range,prim_range) OR h0.prim_range = (TYPEOF(h0.prim_range))''); // Simplify later processing 
  INTEGER2 prim_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_isnull := (h0.prim_name  IN SET(s.nulls_prim_name,prim_name) OR h0.prim_name = (TYPEOF(h0.prim_name))''); // Simplify later processing 
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := (h0.st  IN SET(s.nulls_st,st) OR h0.st = (TYPEOF(h0.st))''); // Simplify later processing 
  INTEGER2 v_city_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN v_city_name_isnull := (h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR h0.v_city_name = (TYPEOF(h0.v_city_name))''); // Simplify later processing 
  INTEGER2 zip_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip_isnull := (h0.zip  IN SET(s.nulls_zip,zip) OR h0.zip = (TYPEOF(h0.zip))''); // Simplify later processing 
  INTEGER2 csz_weight100 := 0; // Contains 100x the specificity
  BOOLEAN csz_isnull := ((h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR h0.v_city_name = (TYPEOF(h0.v_city_name))'') AND (h0.st  IN SET(s.nulls_st,st) OR h0.st = (TYPEOF(h0.st))'') AND (h0.zip  IN SET(s.nulls_zip,zip) OR h0.zip = (TYPEOF(h0.zip))'')); // Simplify later processing 
  INTEGER2 addr1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN addr1_isnull := ((h0.prim_range  IN SET(s.nulls_prim_range,prim_range) OR h0.prim_range = (TYPEOF(h0.prim_range))'') AND (h0.prim_name  IN SET(s.nulls_prim_name,prim_name) OR h0.prim_name = (TYPEOF(h0.prim_name))'')); // Simplify later processing 
  INTEGER2 address_weight100 := 0; // Contains 100x the specificity
  BOOLEAN address_isnull := (((h0.prim_range  IN SET(s.nulls_prim_range,prim_range) OR h0.prim_range = (TYPEOF(h0.prim_range))'') AND (h0.prim_name  IN SET(s.nulls_prim_name,prim_name) OR h0.prim_name = (TYPEOF(h0.prim_name))'')) AND ((h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR h0.v_city_name = (TYPEOF(h0.v_city_name))'') AND (h0.st  IN SET(s.nulls_st,st) OR h0.st = (TYPEOF(h0.st))'') AND (h0.zip  IN SET(s.nulls_zip,zip) OR h0.zip = (TYPEOF(h0.zip))''))); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates)(~prim_name_isnull,~st_isnull,~(address_isnull OR (addr1_isnull OR prim_range_isnull AND prim_name_isnull) AND (csz_isnull OR v_city_name_isnull AND st_isnull AND zip_isnull)));
//Now add the weights of each field one by one
 
//Would also create auto-id fields here
 
layout_candidates add_st(layout_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j8 := JOIN(h1,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_st(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_v_city_name(layout_candidates le,Specificities(ih).v_city_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.v_city_name_weight100 := MAP (le.v_city_name_isnull => 0, patch_default and ri.field_specificity=0 => s.v_city_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT35.MAC_Choose_JoinType(j8,s.nulls_v_city_name,Specificities(ih).v_city_name_values_persisted,v_city_name,v_city_name_weight100,add_v_city_name,j7);
layout_candidates add_prim_range(layout_candidates le,Specificities(ih).prim_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_weight100 := MAP (le.prim_range_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT35.MAC_Choose_JoinType(j7,s.nulls_prim_range,Specificities(ih).prim_range_values_persisted,prim_range,prim_range_weight100,add_prim_range,j6);
layout_candidates add_csz(layout_candidates le,Specificities(ih).csz_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.csz_weight100 := MAP (le.csz_isnull => 0, patch_default and ri.field_specificity=0 => s.csz_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT35.MAC_Choose_JoinType(j6,s.nulls_csz,Specificities(ih).csz_values_persisted,csz,csz_weight100,add_csz,j5);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip_weight100 := MAP (le.zip_isnull => 0, patch_default and ri.field_specificity=0 => s.zip_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT35.MAC_Choose_JoinType(j5,s.nulls_zip,Specificities(ih).zip_values_persisted,zip,zip_weight100,add_zip,j4);
layout_candidates add_prim_name(layout_candidates le,Specificities(ih).prim_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_weight100 := MAP (le.prim_name_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT35.MAC_Choose_JoinType(j4,s.nulls_prim_name,Specificities(ih).prim_name_values_persisted,prim_name,prim_name_weight100,add_prim_name,j3);
layout_candidates add_addr1(layout_candidates le,Specificities(ih).addr1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.addr1_weight100 := MAP (le.addr1_isnull => 0, patch_default and ri.field_specificity=0 => s.addr1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT35.MAC_Choose_JoinType(j3,s.nulls_addr1,Specificities(ih).addr1_values_persisted,addr1,addr1_weight100,add_addr1,j2);
layout_candidates add_address(layout_candidates le,Specificities(ih).address_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.address_weight100 := MAP (le.address_isnull => 0, patch_default and ri.field_specificity=0 => s.address_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT35.MAC_Choose_JoinType(j2,s.nulls_address,Specificities(ih).address_values_persisted,address,address_weight100,add_address,j1);
layout_candidates add_orgid(layout_candidates le,Specificities(ih).orgid_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.orgid_weight100 := MAP (le.orgid_isnull => 0, patch_default and ri.field_specificity=0 => s.orgid_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT35.MAC_Choose_JoinType(j1,s.nulls_orgid,Specificities(ih).orgid_values_persisted,orgid,orgid_weight100,add_orgid,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(POWID)) : PERSIST('~temp::POWID::BIPV2_POWID_Down::mc',EXPIRE(Config.PersistExpire)); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.orgid_weight100 + Annotated.address_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
EXPORT BuddyCounts := TABLE(Annotated,{ buddies, Cnt := COUNT(GROUP) }, buddies, FEW);
EXPORT HasBuddies := TABLE(Annotated(buddies>0), { rcid });
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
