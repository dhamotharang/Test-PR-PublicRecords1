// Begin code to produce match candidates
import SALT20,ut;
export match_candidates(dataset(layout_as_bh) ih) := module
shared s := Specificities(ih).Specificities[1];
h00 := Specificities(ih).input_file;
shared thin_table := table(h00,{rcid,bdid,source,source_group,pflag,group1_id,vendor_id,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,company_name,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,city,state,zip,zip4,county,msa,geo_lat,geo_long,phone,phone_score,fein,current,dppa,vl_id,RawAID,});// Already distributed by specificities module
SHARED h0 := DEDUP( SORT ( DISTRIBUTE(thin_table,HASH()), WHOLE RECORD, LOCAL ), WHOLE RECORD, LOCAL );// Only one copy of each record
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  unsigned2 Rule;
  integer2 Conf;
  integer2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  integer2 Conf_Prop; // Confidense provided by propogated fields
  SALT20.UIDType 1;
  SALT20.UIDType 2;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0};
  unsigned2 rcid_weight100 := 0; // Contains 100x the specificity
  boolean rcid_isnull := h0.rcid  IN SET(s.nulls_rcid,rcid); // Simplify later processing 
  unsigned2 bdid_weight100 := 0; // Contains 100x the specificity
  boolean bdid_isnull := h0.bdid  IN SET(s.nulls_bdid,bdid); // Simplify later processing 
  unsigned2 source_weight100 := 0; // Contains 100x the specificity
  boolean source_isnull := h0.source  IN SET(s.nulls_source,source); // Simplify later processing 
  unsigned2 source_group_weight100 := 0; // Contains 100x the specificity
  boolean source_group_isnull := h0.source_group  IN SET(s.nulls_source_group,source_group); // Simplify later processing 
  unsigned2 pflag_weight100 := 0; // Contains 100x the specificity
  boolean pflag_isnull := h0.pflag  IN SET(s.nulls_pflag,pflag); // Simplify later processing 
  unsigned2 group1_id_weight100 := 0; // Contains 100x the specificity
  boolean group1_id_isnull := h0.group1_id  IN SET(s.nulls_group1_id,group1_id); // Simplify later processing 
  unsigned2 vendor_id_weight100 := 0; // Contains 100x the specificity
  boolean vendor_id_isnull := h0.vendor_id  IN SET(s.nulls_vendor_id,vendor_id); // Simplify later processing 
  unsigned2 dt_first_seen_weight100 := 0; // Contains 100x the specificity
  boolean dt_first_seen_isnull := h0.dt_first_seen  IN SET(s.nulls_dt_first_seen,dt_first_seen); // Simplify later processing 
  unsigned2 dt_last_seen_weight100 := 0; // Contains 100x the specificity
  boolean dt_last_seen_isnull := h0.dt_last_seen  IN SET(s.nulls_dt_last_seen,dt_last_seen); // Simplify later processing 
  unsigned2 dt_vendor_first_reported_weight100 := 0; // Contains 100x the specificity
  boolean dt_vendor_first_reported_isnull := h0.dt_vendor_first_reported  IN SET(s.nulls_dt_vendor_first_reported,dt_vendor_first_reported); // Simplify later processing 
  unsigned2 dt_vendor_last_reported_weight100 := 0; // Contains 100x the specificity
  boolean dt_vendor_last_reported_isnull := h0.dt_vendor_last_reported  IN SET(s.nulls_dt_vendor_last_reported,dt_vendor_last_reported); // Simplify later processing 
  unsigned2 company_name_weight100 := 0; // Contains 100x the specificity
  boolean company_name_isnull := h0.company_name  IN SET(s.nulls_company_name,company_name); // Simplify later processing 
  unsigned2 prim_range_weight100 := 0; // Contains 100x the specificity
  boolean prim_range_isnull := h0.prim_range  IN SET(s.nulls_prim_range,prim_range); // Simplify later processing 
  unsigned2 predir_weight100 := 0; // Contains 100x the specificity
  boolean predir_isnull := h0.predir  IN SET(s.nulls_predir,predir); // Simplify later processing 
  unsigned2 prim_name_weight100 := 0; // Contains 100x the specificity
  boolean prim_name_isnull := h0.prim_name  IN SET(s.nulls_prim_name,prim_name); // Simplify later processing 
  unsigned2 addr_suffix_weight100 := 0; // Contains 100x the specificity
  boolean addr_suffix_isnull := h0.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix); // Simplify later processing 
  unsigned2 postdir_weight100 := 0; // Contains 100x the specificity
  boolean postdir_isnull := h0.postdir  IN SET(s.nulls_postdir,postdir); // Simplify later processing 
  unsigned2 unit_desig_weight100 := 0; // Contains 100x the specificity
  boolean unit_desig_isnull := h0.unit_desig  IN SET(s.nulls_unit_desig,unit_desig); // Simplify later processing 
  unsigned2 sec_range_weight100 := 0; // Contains 100x the specificity
  boolean sec_range_isnull := h0.sec_range  IN SET(s.nulls_sec_range,sec_range); // Simplify later processing 
  unsigned2 city_weight100 := 0; // Contains 100x the specificity
  boolean city_isnull := h0.city  IN SET(s.nulls_city,city); // Simplify later processing 
  unsigned2 state_weight100 := 0; // Contains 100x the specificity
  boolean state_isnull := h0.state  IN SET(s.nulls_state,state); // Simplify later processing 
  unsigned2 zip_weight100 := 0; // Contains 100x the specificity
  boolean zip_isnull := h0.zip  IN SET(s.nulls_zip,zip); // Simplify later processing 
  unsigned2 zip4_weight100 := 0; // Contains 100x the specificity
  boolean zip4_isnull := h0.zip4  IN SET(s.nulls_zip4,zip4); // Simplify later processing 
  unsigned2 county_weight100 := 0; // Contains 100x the specificity
  boolean county_isnull := h0.county  IN SET(s.nulls_county,county); // Simplify later processing 
  unsigned2 msa_weight100 := 0; // Contains 100x the specificity
  boolean msa_isnull := h0.msa  IN SET(s.nulls_msa,msa); // Simplify later processing 
  unsigned2 geo_lat_weight100 := 0; // Contains 100x the specificity
  boolean geo_lat_isnull := h0.geo_lat  IN SET(s.nulls_geo_lat,geo_lat); // Simplify later processing 
  unsigned2 geo_long_weight100 := 0; // Contains 100x the specificity
  boolean geo_long_isnull := h0.geo_long  IN SET(s.nulls_geo_long,geo_long); // Simplify later processing 
  unsigned2 phone_weight100 := 0; // Contains 100x the specificity
  boolean phone_isnull := h0.phone  IN SET(s.nulls_phone,phone); // Simplify later processing 
  unsigned2 phone_score_weight100 := 0; // Contains 100x the specificity
  boolean phone_score_isnull := h0.phone_score  IN SET(s.nulls_phone_score,phone_score); // Simplify later processing 
  unsigned2 fein_weight100 := 0; // Contains 100x the specificity
  boolean fein_isnull := h0.fein  IN SET(s.nulls_fein,fein); // Simplify later processing 
  unsigned2 current_weight100 := 0; // Contains 100x the specificity
  boolean current_isnull := h0.current  IN SET(s.nulls_current,current); // Simplify later processing 
  unsigned2 dppa_weight100 := 0; // Contains 100x the specificity
  boolean dppa_isnull := h0.dppa  IN SET(s.nulls_dppa,dppa); // Simplify later processing 
  unsigned2 vl_id_weight100 := 0; // Contains 100x the specificity
  boolean vl_id_isnull := h0.vl_id  IN SET(s.nulls_vl_id,vl_id); // Simplify later processing 
  unsigned2 RawAID_weight100 := 0; // Contains 100x the specificity
  boolean RawAID_isnull := h0.RawAID  IN SET(s.nulls_RawAID,RawAID); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates);
//Now add the weights of each field one by one
//Would also create auto-id fields here
layout_candidates add_RawAID(layout_candidates le,Specificities(ih).RawAID_values_persisted ri,boolean patch_default) := transform
  self.RawAID_weight100 := MAP (le.RawAID_isnull => 0, patch_default and ri.field_specificity=0 => s.RawAID_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j33 := join(h1,PULL(Specificities(ih).RawAID_values_persisted),left.RawAID=right.RawAID,add_RawAID(left,right,true),lookup,left outer);
layout_candidates add_vl_id(layout_candidates le,Specificities(ih).vl_id_values_persisted ri,boolean patch_default) := transform
  self.vl_id_weight100 := MAP (le.vl_id_isnull => 0, patch_default and ri.field_specificity=0 => s.vl_id_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j32 := join(j33,PULL(Specificities(ih).vl_id_values_persisted),left.vl_id=right.vl_id,add_vl_id(left,right,true),lookup,left outer);
layout_candidates add_dppa(layout_candidates le,Specificities(ih).dppa_values_persisted ri,boolean patch_default) := transform
  self.dppa_weight100 := MAP (le.dppa_isnull => 0, patch_default and ri.field_specificity=0 => s.dppa_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j31 := join(j32,PULL(Specificities(ih).dppa_values_persisted),left.dppa=right.dppa,add_dppa(left,right,true),lookup,left outer);
layout_candidates add_current(layout_candidates le,Specificities(ih).current_values_persisted ri,boolean patch_default) := transform
  self.current_weight100 := MAP (le.current_isnull => 0, patch_default and ri.field_specificity=0 => s.current_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j30 := join(j31,PULL(Specificities(ih).current_values_persisted),left.current=right.current,add_current(left,right,true),lookup,left outer);
layout_candidates add_fein(layout_candidates le,Specificities(ih).fein_values_persisted ri,boolean patch_default) := transform
  self.fein_weight100 := MAP (le.fein_isnull => 0, patch_default and ri.field_specificity=0 => s.fein_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j29 := join(j30,PULL(Specificities(ih).fein_values_persisted),left.fein=right.fein,add_fein(left,right,true),lookup,left outer);
layout_candidates add_phone_score(layout_candidates le,Specificities(ih).phone_score_values_persisted ri,boolean patch_default) := transform
  self.phone_score_weight100 := MAP (le.phone_score_isnull => 0, patch_default and ri.field_specificity=0 => s.phone_score_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j28 := join(j29,PULL(Specificities(ih).phone_score_values_persisted),left.phone_score=right.phone_score,add_phone_score(left,right,true),lookup,left outer);
layout_candidates add_phone(layout_candidates le,Specificities(ih).phone_values_persisted ri,boolean patch_default) := transform
  self.phone_weight100 := MAP (le.phone_isnull => 0, patch_default and ri.field_specificity=0 => s.phone_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j27 := join(j28,PULL(Specificities(ih).phone_values_persisted),left.phone=right.phone,add_phone(left,right,true),lookup,left outer);
layout_candidates add_geo_long(layout_candidates le,Specificities(ih).geo_long_values_persisted ri,boolean patch_default) := transform
  self.geo_long_weight100 := MAP (le.geo_long_isnull => 0, patch_default and ri.field_specificity=0 => s.geo_long_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j26 := join(j27,PULL(Specificities(ih).geo_long_values_persisted),left.geo_long=right.geo_long,add_geo_long(left,right,true),lookup,left outer);
layout_candidates add_geo_lat(layout_candidates le,Specificities(ih).geo_lat_values_persisted ri,boolean patch_default) := transform
  self.geo_lat_weight100 := MAP (le.geo_lat_isnull => 0, patch_default and ri.field_specificity=0 => s.geo_lat_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j25 := join(j26,PULL(Specificities(ih).geo_lat_values_persisted),left.geo_lat=right.geo_lat,add_geo_lat(left,right,true),lookup,left outer);
layout_candidates add_msa(layout_candidates le,Specificities(ih).msa_values_persisted ri,boolean patch_default) := transform
  self.msa_weight100 := MAP (le.msa_isnull => 0, patch_default and ri.field_specificity=0 => s.msa_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j24 := join(j25,PULL(Specificities(ih).msa_values_persisted),left.msa=right.msa,add_msa(left,right,true),lookup,left outer);
layout_candidates add_county(layout_candidates le,Specificities(ih).county_values_persisted ri,boolean patch_default) := transform
  self.county_weight100 := MAP (le.county_isnull => 0, patch_default and ri.field_specificity=0 => s.county_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j23 := join(j24,PULL(Specificities(ih).county_values_persisted),left.county=right.county,add_county(left,right,true),lookup,left outer);
layout_candidates add_zip4(layout_candidates le,Specificities(ih).zip4_values_persisted ri,boolean patch_default) := transform
  self.zip4_weight100 := MAP (le.zip4_isnull => 0, patch_default and ri.field_specificity=0 => s.zip4_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j22 := join(j23,PULL(Specificities(ih).zip4_values_persisted),left.zip4=right.zip4,add_zip4(left,right,true),lookup,left outer);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri,boolean patch_default) := transform
  self.zip_weight100 := MAP (le.zip_isnull => 0, patch_default and ri.field_specificity=0 => s.zip_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j21 := join(j22,PULL(Specificities(ih).zip_values_persisted),left.zip=right.zip,add_zip(left,right,true),lookup,left outer);
layout_candidates add_state(layout_candidates le,Specificities(ih).state_values_persisted ri,boolean patch_default) := transform
  self.state_weight100 := MAP (le.state_isnull => 0, patch_default and ri.field_specificity=0 => s.state_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j20 := join(j21,PULL(Specificities(ih).state_values_persisted),left.state=right.state,add_state(left,right,true),lookup,left outer);
layout_candidates add_city(layout_candidates le,Specificities(ih).city_values_persisted ri,boolean patch_default) := transform
  self.city_weight100 := MAP (le.city_isnull => 0, patch_default and ri.field_specificity=0 => s.city_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j19 := join(j20,PULL(Specificities(ih).city_values_persisted),left.city=right.city,add_city(left,right,true),lookup,left outer);
layout_candidates add_sec_range(layout_candidates le,Specificities(ih).sec_range_values_persisted ri,boolean patch_default) := transform
  self.sec_range_weight100 := MAP (le.sec_range_isnull => 0, patch_default and ri.field_specificity=0 => s.sec_range_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j18 := join(j19,PULL(Specificities(ih).sec_range_values_persisted),left.sec_range=right.sec_range,add_sec_range(left,right,true),lookup,left outer);
layout_candidates add_unit_desig(layout_candidates le,Specificities(ih).unit_desig_values_persisted ri,boolean patch_default) := transform
  self.unit_desig_weight100 := MAP (le.unit_desig_isnull => 0, patch_default and ri.field_specificity=0 => s.unit_desig_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j17 := join(j18,PULL(Specificities(ih).unit_desig_values_persisted),left.unit_desig=right.unit_desig,add_unit_desig(left,right,true),lookup,left outer);
layout_candidates add_postdir(layout_candidates le,Specificities(ih).postdir_values_persisted ri,boolean patch_default) := transform
  self.postdir_weight100 := MAP (le.postdir_isnull => 0, patch_default and ri.field_specificity=0 => s.postdir_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j16 := join(j17,PULL(Specificities(ih).postdir_values_persisted),left.postdir=right.postdir,add_postdir(left,right,true),lookup,left outer);
layout_candidates add_addr_suffix(layout_candidates le,Specificities(ih).addr_suffix_values_persisted ri,boolean patch_default) := transform
  self.addr_suffix_weight100 := MAP (le.addr_suffix_isnull => 0, patch_default and ri.field_specificity=0 => s.addr_suffix_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j15 := join(j16,PULL(Specificities(ih).addr_suffix_values_persisted),left.addr_suffix=right.addr_suffix,add_addr_suffix(left,right,true),lookup,left outer);
layout_candidates add_prim_name(layout_candidates le,Specificities(ih).prim_name_values_persisted ri,boolean patch_default) := transform
  self.prim_name_weight100 := MAP (le.prim_name_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j14 := join(j15,PULL(Specificities(ih).prim_name_values_persisted),left.prim_name=right.prim_name,add_prim_name(left,right,true),lookup,left outer);
layout_candidates add_predir(layout_candidates le,Specificities(ih).predir_values_persisted ri,boolean patch_default) := transform
  self.predir_weight100 := MAP (le.predir_isnull => 0, patch_default and ri.field_specificity=0 => s.predir_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j13 := join(j14,PULL(Specificities(ih).predir_values_persisted),left.predir=right.predir,add_predir(left,right,true),lookup,left outer);
layout_candidates add_prim_range(layout_candidates le,Specificities(ih).prim_range_values_persisted ri,boolean patch_default) := transform
  self.prim_range_weight100 := MAP (le.prim_range_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j12 := join(j13,PULL(Specificities(ih).prim_range_values_persisted),left.prim_range=right.prim_range,add_prim_range(left,right,true),lookup,left outer);
layout_candidates add_company_name(layout_candidates le,Specificities(ih).company_name_values_persisted ri,boolean patch_default) := transform
  self.company_name_weight100 := MAP (le.company_name_isnull => 0, patch_default and ri.field_specificity=0 => s.company_name_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j11 := join(j12,PULL(Specificities(ih).company_name_values_persisted),left.company_name=right.company_name,add_company_name(left,right,true),lookup,left outer);
layout_candidates add_dt_vendor_last_reported(layout_candidates le,Specificities(ih).dt_vendor_last_reported_values_persisted ri,boolean patch_default) := transform
  self.dt_vendor_last_reported_weight100 := MAP (le.dt_vendor_last_reported_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_vendor_last_reported_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j10 := join(j11,PULL(Specificities(ih).dt_vendor_last_reported_values_persisted),left.dt_vendor_last_reported=right.dt_vendor_last_reported,add_dt_vendor_last_reported(left,right,true),lookup,left outer);
layout_candidates add_dt_vendor_first_reported(layout_candidates le,Specificities(ih).dt_vendor_first_reported_values_persisted ri,boolean patch_default) := transform
  self.dt_vendor_first_reported_weight100 := MAP (le.dt_vendor_first_reported_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_vendor_first_reported_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j9 := join(j10,PULL(Specificities(ih).dt_vendor_first_reported_values_persisted),left.dt_vendor_first_reported=right.dt_vendor_first_reported,add_dt_vendor_first_reported(left,right,true),lookup,left outer);
layout_candidates add_dt_last_seen(layout_candidates le,Specificities(ih).dt_last_seen_values_persisted ri,boolean patch_default) := transform
  self.dt_last_seen_weight100 := MAP (le.dt_last_seen_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_last_seen_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j8 := join(j9,PULL(Specificities(ih).dt_last_seen_values_persisted),left.dt_last_seen=right.dt_last_seen,add_dt_last_seen(left,right,true),lookup,left outer);
layout_candidates add_dt_first_seen(layout_candidates le,Specificities(ih).dt_first_seen_values_persisted ri,boolean patch_default) := transform
  self.dt_first_seen_weight100 := MAP (le.dt_first_seen_isnull => 0, patch_default and ri.field_specificity=0 => s.dt_first_seen_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j7 := join(j8,PULL(Specificities(ih).dt_first_seen_values_persisted),left.dt_first_seen=right.dt_first_seen,add_dt_first_seen(left,right,true),lookup,left outer);
layout_candidates add_vendor_id(layout_candidates le,Specificities(ih).vendor_id_values_persisted ri,boolean patch_default) := transform
  self.vendor_id_weight100 := MAP (le.vendor_id_isnull => 0, patch_default and ri.field_specificity=0 => s.vendor_id_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j6 := join(j7,PULL(Specificities(ih).vendor_id_values_persisted),left.vendor_id=right.vendor_id,add_vendor_id(left,right,true),lookup,left outer);
layout_candidates add_group1_id(layout_candidates le,Specificities(ih).group1_id_values_persisted ri,boolean patch_default) := transform
  self.group1_id_weight100 := MAP (le.group1_id_isnull => 0, patch_default and ri.field_specificity=0 => s.group1_id_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j5 := join(j6,PULL(Specificities(ih).group1_id_values_persisted),left.group1_id=right.group1_id,add_group1_id(left,right,true),lookup,left outer);
layout_candidates add_pflag(layout_candidates le,Specificities(ih).pflag_values_persisted ri,boolean patch_default) := transform
  self.pflag_weight100 := MAP (le.pflag_isnull => 0, patch_default and ri.field_specificity=0 => s.pflag_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j4 := join(j5,PULL(Specificities(ih).pflag_values_persisted),left.pflag=right.pflag,add_pflag(left,right,true),lookup,left outer);
layout_candidates add_source_group(layout_candidates le,Specificities(ih).source_group_values_persisted ri,boolean patch_default) := transform
  self.source_group_weight100 := MAP (le.source_group_isnull => 0, patch_default and ri.field_specificity=0 => s.source_group_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j3 := join(j4,PULL(Specificities(ih).source_group_values_persisted),left.source_group=right.source_group,add_source_group(left,right,true),lookup,left outer);
layout_candidates add_source(layout_candidates le,Specificities(ih).source_values_persisted ri,boolean patch_default) := transform
  self.source_weight100 := MAP (le.source_isnull => 0, patch_default and ri.field_specificity=0 => s.source_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j2 := join(j3,PULL(Specificities(ih).source_values_persisted),left.source=right.source,add_source(left,right,true),lookup,left outer);
layout_candidates add_bdid(layout_candidates le,Specificities(ih).bdid_values_persisted ri,boolean patch_default) := transform
  self.bdid_weight100 := MAP (le.bdid_isnull => 0, patch_default and ri.field_specificity=0 => s.bdid_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j1 := join(j2,PULL(Specificities(ih).bdid_values_persisted),left.bdid=right.bdid,add_bdid(left,right,true),lookup,left outer);
layout_candidates add_rcid(layout_candidates le,Specificities(ih).rcid_values_persisted ri,boolean patch_default) := transform
  self.rcid_weight100 := MAP (le.rcid_isnull => 0, patch_default and ri.field_specificity=0 => s.rcid_max, ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j0 := join(j1,PULL(Specificities(ih).rcid_values_persisted),left.rcid=right.rcid,add_rcid(left,right,true),lookup,left outer);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash()) : PERSIST('temp::Business_Research_pDataset_mc'); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.rcid_weight100 + Annotated.bdid_weight100 + Annotated.source_weight100 + Annotated.source_group_weight100 + Annotated.pflag_weight100 + Annotated.group1_id_weight100 + Annotated.vendor_id_weight100 + Annotated.dt_first_seen_weight100 + Annotated.dt_last_seen_weight100 + Annotated.dt_vendor_first_reported_weight100 + Annotated.dt_vendor_last_reported_weight100 + Annotated.company_name_weight100 + Annotated.prim_range_weight100 + Annotated.predir_weight100 + Annotated.prim_name_weight100 + Annotated.addr_suffix_weight100 + Annotated.postdir_weight100 + Annotated.unit_desig_weight100 + Annotated.sec_range_weight100 + Annotated.city_weight100 + Annotated.state_weight100 + Annotated.zip_weight100 + Annotated.zip4_weight100 + Annotated.county_weight100 + Annotated.msa_weight100 + Annotated.geo_lat_weight100 + Annotated.geo_long_weight100 + Annotated.phone_weight100 + Annotated.phone_score_weight100 + Annotated.fein_weight100 + Annotated.current_weight100 + Annotated.dppa_weight100 + Annotated.vl_id_weight100 + Annotated.RawAID_weight100;
SHARED Linkable := TotalWeight >= 0;
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
+++Line:44:RIDField is now compulsory for full adl matching!!!
