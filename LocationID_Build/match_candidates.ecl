﻿// Begin code to produce match candidates
IMPORT SALT37;
EXPORT match_candidates(DATASET(layout_LocationId) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := LocationId_xLink.Specificities(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00,{rid,prim_range,predir,prim_name_derived,addr_suffix_derived,postdir,err_stat,unit_desig,sec_range,v_city_name,st,zip5,LocId}),HASH(LocId));
 
  Grpd := GROUP( SORT(
    DISTRIBUTE( TABLE( thin_table, { thin_table, UNSIGNED2 Buddies := 0 }),HASH(LocId)),
    LocId,prim_range,predir,prim_name_derived,addr_suffix_derived,postdir,err_stat,unit_desig,sec_range,v_city_name,st,zip5, LOCAL),
    LocId,prim_range,predir,prim_name_derived,addr_suffix_derived,postdir,err_stat,unit_desig,sec_range,v_city_name,st,zip5, LOCAL);
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
  SALT37.UIDType LocId1;
  SALT37.UIDType LocId2;
  SALT37.UIDType rid1 := 0;
  SALT37.UIDType rid2 := 0;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0};
  INTEGER2 prim_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_isnull := (h0.prim_range  IN SET(s.nulls_prim_range,prim_range) OR h0.prim_range = (TYPEOF(h0.prim_range))''); // Simplify later processing 
  INTEGER2 predir_weight100 := 0; // Contains 100x the specificity
  BOOLEAN predir_isnull := (h0.predir  IN SET(s.nulls_predir,predir) OR h0.predir = (TYPEOF(h0.predir))''); // Simplify later processing 
  INTEGER2 prim_name_derived_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_derived_isnull := (h0.prim_name_derived  IN SET(s.nulls_prim_name_derived,prim_name_derived) OR h0.prim_name_derived = (TYPEOF(h0.prim_name_derived))''); // Simplify later processing 
  INTEGER2 addr_suffix_derived_weight100 := 0; // Contains 100x the specificity
  BOOLEAN addr_suffix_derived_isnull := (h0.addr_suffix_derived  IN SET(s.nulls_addr_suffix_derived,addr_suffix_derived) OR h0.addr_suffix_derived = (TYPEOF(h0.addr_suffix_derived))''); // Simplify later processing 
  INTEGER2 postdir_weight100 := 0; // Contains 100x the specificity
  BOOLEAN postdir_isnull := (h0.postdir  IN SET(s.nulls_postdir,postdir) OR h0.postdir = (TYPEOF(h0.postdir))''); // Simplify later processing 
  INTEGER2 err_stat_weight100 := 0; // Contains 100x the specificity
  BOOLEAN err_stat_isnull := (h0.err_stat  IN SET(s.nulls_err_stat,err_stat) OR h0.err_stat = (TYPEOF(h0.err_stat))''); // Simplify later processing 
  INTEGER2 unit_desig_weight100 := 0; // Contains 100x the specificity
  BOOLEAN unit_desig_isnull := (h0.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) OR h0.unit_desig = (TYPEOF(h0.unit_desig))''); // Simplify later processing 
  INTEGER2 sec_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sec_range_isnull := (h0.sec_range  IN SET(s.nulls_sec_range,sec_range) OR h0.sec_range = (TYPEOF(h0.sec_range))''); // Simplify later processing 
  INTEGER2 v_city_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN v_city_name_isnull := (h0.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR h0.v_city_name = (TYPEOF(h0.v_city_name))''); // Simplify later processing 
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := (h0.st  IN SET(s.nulls_st,st) OR h0.st = (TYPEOF(h0.st))''); // Simplify later processing 
  INTEGER2 zip5_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip5_isnull := (h0.zip5  IN SET(s.nulls_zip5,zip5) OR h0.zip5 = (TYPEOF(h0.zip5))''); // Simplify later processing 
  UNSIGNED zip5_cnt := 0; // Number of instances with this particular field value
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
 
//Would also create auto-id fields here
 
layout_candidates add_err_stat(layout_candidates le,Specificities(ih).err_stat_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.err_stat_weight100 := MAP (le.err_stat_isnull => 0, patch_default and ri.field_specificity=0 => s.err_stat_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j10 := JOIN(h1,PULL(Specificities(ih).err_stat_values_persisted),LEFT.err_stat=RIGHT.err_stat,add_err_stat(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_addr_suffix_derived(layout_candidates le,Specificities(ih).addr_suffix_derived_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.addr_suffix_derived_weight100 := MAP (le.addr_suffix_derived_isnull => 0, patch_default and ri.field_specificity=0 => s.addr_suffix_derived_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j9 := JOIN(j10,PULL(Specificities(ih).addr_suffix_derived_values_persisted),LEFT.addr_suffix_derived=RIGHT.addr_suffix_derived,add_addr_suffix_derived(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_st(layout_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j8 := JOIN(j9,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_st(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_predir(layout_candidates le,Specificities(ih).predir_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.predir_weight100 := MAP (le.predir_isnull => 0, patch_default and ri.field_specificity=0 => s.predir_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j7 := JOIN(j8,PULL(Specificities(ih).predir_values_persisted),LEFT.predir=RIGHT.predir,add_predir(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_unit_desig(layout_candidates le,Specificities(ih).unit_desig_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.unit_desig_weight100 := MAP (le.unit_desig_isnull => 0, patch_default and ri.field_specificity=0 => s.unit_desig_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j6 := JOIN(j7,PULL(Specificities(ih).unit_desig_values_persisted),LEFT.unit_desig=RIGHT.unit_desig,add_unit_desig(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_postdir(layout_candidates le,Specificities(ih).postdir_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.postdir_weight100 := MAP (le.postdir_isnull => 0, patch_default and ri.field_specificity=0 => s.postdir_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j5 := JOIN(j6,PULL(Specificities(ih).postdir_values_persisted),LEFT.postdir=RIGHT.postdir,add_postdir(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_v_city_name(layout_candidates le,Specificities(ih).v_city_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.v_city_name_weight100 := MAP (le.v_city_name_isnull => 0, patch_default and ri.field_specificity=0 => s.v_city_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j5,s.nulls_v_city_name,Specificities(ih).v_city_name_values_persisted,v_city_name,v_city_name_weight100,add_v_city_name,j4);
layout_candidates add_prim_range(layout_candidates le,Specificities(ih).prim_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_weight100 := MAP (le.prim_range_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j4,s.nulls_prim_range,Specificities(ih).prim_range_values_persisted,prim_range,prim_range_weight100,add_prim_range,j3);
layout_candidates add_zip5(layout_candidates le,Specificities(ih).zip5_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip5_cnt := ri.cnt;
  SELF.zip5_weight100 := MAP (le.zip5_isnull => 0, patch_default and ri.field_specificity=0 => s.zip5_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j3,s.nulls_zip5,Specificities(ih).zip5_values_persisted,zip5,zip5_weight100,add_zip5,j2);
layout_candidates add_sec_range(layout_candidates le,Specificities(ih).sec_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sec_range_weight100 := MAP (le.sec_range_isnull => 0, patch_default and ri.field_specificity=0 => s.sec_range_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j2,s.nulls_sec_range,Specificities(ih).sec_range_values_persisted,sec_range,sec_range_weight100,add_sec_range,j1);
layout_candidates add_prim_name_derived(layout_candidates le,Specificities(ih).prim_name_derived_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_derived_weight100 := MAP (le.prim_name_derived_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_derived_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT37.MAC_Choose_JoinType(j1,s.nulls_prim_name_derived,Specificities(ih).prim_name_derived_values_persisted,prim_name_derived,prim_name_derived_weight100,add_prim_name_derived,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(LocId)) : PERSIST('~temp::LocId::LocationId_xLink::mc',EXPIRE(LocationId_xLink._CFG.PersistExpire)); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.prim_name_derived_weight100 + Annotated.sec_range_weight100 + Annotated.zip5_weight100 + Annotated.prim_range_weight100 + Annotated.v_city_name_weight100 + Annotated.postdir_weight100 + Annotated.unit_desig_weight100 + Annotated.predir_weight100 + Annotated.st_weight100 + Annotated.addr_suffix_derived_weight100 + Annotated.err_stat_weight100;
SHARED Linkable := TotalWeight >= _CFG.MatchThreshold;
EXPORT BuddyCounts := TABLE(Annotated,{ buddies, Cnt := COUNT(GROUP) }, buddies, FEW);
EXPORT HasBuddies := TABLE(Annotated(buddies>0), { rid });
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
