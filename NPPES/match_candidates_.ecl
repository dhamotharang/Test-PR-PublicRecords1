// Begin code to produce match candidates
import SALT19,ut;
export match_candidates(dataset(layout_FileIN) ih) := module
shared s := Specificities(ih).Specificities[1];
h00 := Specificities(ih).input_file;
shared thin_table := table(h00,{did,src,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,vendor_id,phone,title,fname,mname,lname,name_suffix,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,county,msa,geo_blk,RawAID,});// Already distributed by specificities module
shared h0 := dedup( sort ( thin_table, whole record, local ), whole record, local );// Only one copy of each record
export Layout_Matches := record//in this module for because of ,foward bug
  unsigned2 Rule;
  integer2 Conf;
  integer2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  integer2 Conf_Prop; // Confidense provided by propogated fields
  SALT19.UIDType 1;
  SALT19.UIDType 2;
end;
export Layout_Candidates := record // A record to hold weights of each field value
  {h0};
  unsigned2 did_weight100 := 0; // Contains 100x the specificity
  boolean did_isnull := h0.did  IN SET(s.nulls_did,did); // Simplify later processing 
  unsigned2 src_weight100 := 0; // Contains 100x the specificity
  boolean src_isnull := h0.src  IN SET(s.nulls_src,src); // Simplify later processing 
  unsigned2 dt_first_seen_weight100 := 0; // Contains 100x the specificity
  boolean dt_first_seen_isnull := h0.dt_first_seen  IN SET(s.nulls_dt_first_seen,dt_first_seen); // Simplify later processing 
  unsigned2 dt_last_seen_weight100 := 0; // Contains 100x the specificity
  boolean dt_last_seen_isnull := h0.dt_last_seen  IN SET(s.nulls_dt_last_seen,dt_last_seen); // Simplify later processing 
  unsigned2 dt_vendor_first_reported_weight100 := 0; // Contains 100x the specificity
  boolean dt_vendor_first_reported_isnull := h0.dt_vendor_first_reported  IN SET(s.nulls_dt_vendor_first_reported,dt_vendor_first_reported); // Simplify later processing 
  unsigned2 dt_vendor_last_reported_weight100 := 0; // Contains 100x the specificity
  boolean dt_vendor_last_reported_isnull := h0.dt_vendor_last_reported  IN SET(s.nulls_dt_vendor_last_reported,dt_vendor_last_reported); // Simplify later processing 
  unsigned2 vendor_id_weight100 := 0; // Contains 100x the specificity
  boolean vendor_id_isnull := h0.vendor_id  IN SET(s.nulls_vendor_id,vendor_id); // Simplify later processing 
  unsigned2 phone_weight100 := 0; // Contains 100x the specificity
  boolean phone_isnull := h0.phone  IN SET(s.nulls_phone,phone); // Simplify later processing 
  unsigned2 title_weight100 := 0; // Contains 100x the specificity
  boolean title_isnull := h0.title  IN SET(s.nulls_title,title); // Simplify later processing 
  unsigned2 fname_weight100 := 0; // Contains 100x the specificity
  boolean fname_isnull := h0.fname  IN SET(s.nulls_fname,fname); // Simplify later processing 
  unsigned2 mname_weight100 := 0; // Contains 100x the specificity
  boolean mname_isnull := h0.mname  IN SET(s.nulls_mname,mname); // Simplify later processing 
  unsigned2 lname_weight100 := 0; // Contains 100x the specificity
  boolean lname_isnull := h0.lname  IN SET(s.nulls_lname,lname); // Simplify later processing 
  unsigned2 name_suffix_weight100 := 0; // Contains 100x the specificity
  boolean name_suffix_isnull := h0.name_suffix  IN SET(s.nulls_name_suffix,name_suffix); // Simplify later processing 
  unsigned2 prim_range_weight100 := 0; // Contains 100x the specificity
  boolean prim_range_isnull := h0.prim_range  IN SET(s.nulls_prim_range,prim_range); // Simplify later processing 
  unsigned2 predir_weight100 := 0; // Contains 100x the specificity
  boolean predir_isnull := h0.predir  IN SET(s.nulls_predir,predir); // Simplify later processing 
  unsigned2 prim_name_weight100 := 0; // Contains 100x the specificity
  boolean prim_name_isnull := h0.prim_name  IN SET(s.nulls_prim_name,prim_name); // Simplify later processing 
  unsigned2 suffix_weight100 := 0; // Contains 100x the specificity
  boolean suffix_isnull := h0.suffix  IN SET(s.nulls_suffix,suffix); // Simplify later processing 
  unsigned2 postdir_weight100 := 0; // Contains 100x the specificity
  boolean postdir_isnull := h0.postdir  IN SET(s.nulls_postdir,postdir); // Simplify later processing 
  unsigned2 unit_desig_weight100 := 0; // Contains 100x the specificity
  boolean unit_desig_isnull := h0.unit_desig  IN SET(s.nulls_unit_desig,unit_desig); // Simplify later processing 
  unsigned2 sec_range_weight100 := 0; // Contains 100x the specificity
  boolean sec_range_isnull := h0.sec_range  IN SET(s.nulls_sec_range,sec_range); // Simplify later processing 
  unsigned2 city_name_weight100 := 0; // Contains 100x the specificity
  boolean city_name_isnull := h0.city_name  IN SET(s.nulls_city_name,city_name); // Simplify later processing 
  unsigned2 st_weight100 := 0; // Contains 100x the specificity
  boolean st_isnull := h0.st  IN SET(s.nulls_st,st); // Simplify later processing 
  unsigned2 zip_weight100 := 0; // Contains 100x the specificity
  boolean zip_isnull := h0.zip  IN SET(s.nulls_zip,zip); // Simplify later processing 
  unsigned2 zip4_weight100 := 0; // Contains 100x the specificity
  boolean zip4_isnull := h0.zip4  IN SET(s.nulls_zip4,zip4); // Simplify later processing 
  unsigned2 county_weight100 := 0; // Contains 100x the specificity
  boolean county_isnull := h0.county  IN SET(s.nulls_county,county); // Simplify later processing 
  unsigned2 msa_weight100 := 0; // Contains 100x the specificity
  boolean msa_isnull := h0.msa  IN SET(s.nulls_msa,msa); // Simplify later processing 
  unsigned2 geo_blk_weight100 := 0; // Contains 100x the specificity
  boolean geo_blk_isnull := h0.geo_blk  IN SET(s.nulls_geo_blk,geo_blk); // Simplify later processing 
  unsigned2 RawAID_weight100 := 0; // Contains 100x the specificity
  boolean RawAID_isnull := h0.RawAID  IN SET(s.nulls_RawAID,RawAID); // Simplify later processing 
end;
h1 := table(h0,layout_candidates);
//Now add the weights of each field one by one
//Would also create auto-id fields here
layout_candidates add_RawAID(layout_candidates le,Specificities(ih).RawAID_values_persisted ri,boolean patch_default) := transform
  self.RawAID_weight100 := IF(patch_default and ~le.RawAID_isnull and ri.field_specificity=0,s.RawAID_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j27 := join(h1,PULL(Specificities(ih).RawAID_values_persisted),left.RawAID=right.RawAID,add_RawAID(left,right,true),lookup,left outer);
layout_candidates add_geo_blk(layout_candidates le,Specificities(ih).geo_blk_values_persisted ri,boolean patch_default) := transform
  self.geo_blk_weight100 := IF(patch_default and ~le.geo_blk_isnull and ri.field_specificity=0,s.geo_blk_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j26 := join(j27,PULL(Specificities(ih).geo_blk_values_persisted),left.geo_blk=right.geo_blk,add_geo_blk(left,right,true),lookup,left outer);
layout_candidates add_msa(layout_candidates le,Specificities(ih).msa_values_persisted ri,boolean patch_default) := transform
  self.msa_weight100 := IF(patch_default and ~le.msa_isnull and ri.field_specificity=0,s.msa_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j25 := join(j26,PULL(Specificities(ih).msa_values_persisted),left.msa=right.msa,add_msa(left,right,true),lookup,left outer);
layout_candidates add_county(layout_candidates le,Specificities(ih).county_values_persisted ri,boolean patch_default) := transform
  self.county_weight100 := IF(patch_default and ~le.county_isnull and ri.field_specificity=0,s.county_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j24 := join(j25,PULL(Specificities(ih).county_values_persisted),left.county=right.county,add_county(left,right,true),lookup,left outer);
layout_candidates add_zip4(layout_candidates le,Specificities(ih).zip4_values_persisted ri,boolean patch_default) := transform
  self.zip4_weight100 := IF(patch_default and ~le.zip4_isnull and ri.field_specificity=0,s.zip4_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j23 := join(j24,PULL(Specificities(ih).zip4_values_persisted),left.zip4=right.zip4,add_zip4(left,right,true),lookup,left outer);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri,boolean patch_default) := transform
  self.zip_weight100 := IF(patch_default and ~le.zip_isnull and ri.field_specificity=0,s.zip_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j22 := join(j23,PULL(Specificities(ih).zip_values_persisted),left.zip=right.zip,add_zip(left,right,true),lookup,left outer);
layout_candidates add_st(layout_candidates le,Specificities(ih).st_values_persisted ri,boolean patch_default) := transform
  self.st_weight100 := IF(patch_default and ~le.st_isnull and ri.field_specificity=0,s.st_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j21 := join(j22,PULL(Specificities(ih).st_values_persisted),left.st=right.st,add_st(left,right,true),lookup,left outer);
layout_candidates add_city_name(layout_candidates le,Specificities(ih).city_name_values_persisted ri,boolean patch_default) := transform
  self.city_name_weight100 := IF(patch_default and ~le.city_name_isnull and ri.field_specificity=0,s.city_name_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j20 := join(j21,PULL(Specificities(ih).city_name_values_persisted),left.city_name=right.city_name,add_city_name(left,right,true),lookup,left outer);
layout_candidates add_sec_range(layout_candidates le,Specificities(ih).sec_range_values_persisted ri,boolean patch_default) := transform
  self.sec_range_weight100 := IF(patch_default and ~le.sec_range_isnull and ri.field_specificity=0,s.sec_range_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j19 := join(j20,PULL(Specificities(ih).sec_range_values_persisted),left.sec_range=right.sec_range,add_sec_range(left,right,true),lookup,left outer);
layout_candidates add_unit_desig(layout_candidates le,Specificities(ih).unit_desig_values_persisted ri,boolean patch_default) := transform
  self.unit_desig_weight100 := IF(patch_default and ~le.unit_desig_isnull and ri.field_specificity=0,s.unit_desig_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j18 := join(j19,PULL(Specificities(ih).unit_desig_values_persisted),left.unit_desig=right.unit_desig,add_unit_desig(left,right,true),lookup,left outer);
layout_candidates add_postdir(layout_candidates le,Specificities(ih).postdir_values_persisted ri,boolean patch_default) := transform
  self.postdir_weight100 := IF(patch_default and ~le.postdir_isnull and ri.field_specificity=0,s.postdir_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j17 := join(j18,PULL(Specificities(ih).postdir_values_persisted),left.postdir=right.postdir,add_postdir(left,right,true),lookup,left outer);
layout_candidates add_suffix(layout_candidates le,Specificities(ih).suffix_values_persisted ri,boolean patch_default) := transform
  self.suffix_weight100 := IF(patch_default and ~le.suffix_isnull and ri.field_specificity=0,s.suffix_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j16 := join(j17,PULL(Specificities(ih).suffix_values_persisted),left.suffix=right.suffix,add_suffix(left,right,true),lookup,left outer);
layout_candidates add_prim_name(layout_candidates le,Specificities(ih).prim_name_values_persisted ri,boolean patch_default) := transform
  self.prim_name_weight100 := IF(patch_default and ~le.prim_name_isnull and ri.field_specificity=0,s.prim_name_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j15 := join(j16,PULL(Specificities(ih).prim_name_values_persisted),left.prim_name=right.prim_name,add_prim_name(left,right,true),lookup,left outer);
layout_candidates add_predir(layout_candidates le,Specificities(ih).predir_values_persisted ri,boolean patch_default) := transform
  self.predir_weight100 := IF(patch_default and ~le.predir_isnull and ri.field_specificity=0,s.predir_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j14 := join(j15,PULL(Specificities(ih).predir_values_persisted),left.predir=right.predir,add_predir(left,right,true),lookup,left outer);
layout_candidates add_prim_range(layout_candidates le,Specificities(ih).prim_range_values_persisted ri,boolean patch_default) := transform
  self.prim_range_weight100 := IF(patch_default and ~le.prim_range_isnull and ri.field_specificity=0,s.prim_range_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j13 := join(j14,PULL(Specificities(ih).prim_range_values_persisted),left.prim_range=right.prim_range,add_prim_range(left,right,true),lookup,left outer);
layout_candidates add_name_suffix(layout_candidates le,Specificities(ih).name_suffix_values_persisted ri,boolean patch_default) := transform
  self.name_suffix_weight100 := IF(patch_default and ~le.name_suffix_isnull and ri.field_specificity=0,s.name_suffix_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j12 := join(j13,PULL(Specificities(ih).name_suffix_values_persisted),left.name_suffix=right.name_suffix,add_name_suffix(left,right,true),lookup,left outer);
layout_candidates add_lname(layout_candidates le,Specificities(ih).lname_values_persisted ri,boolean patch_default) := transform
  self.lname_weight100 := IF(patch_default and ~le.lname_isnull and ri.field_specificity=0,s.lname_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j11 := join(j12,PULL(Specificities(ih).lname_values_persisted),left.lname=right.lname,add_lname(left,right,true),lookup,left outer);
layout_candidates add_mname(layout_candidates le,Specificities(ih).mname_values_persisted ri,boolean patch_default) := transform
  self.mname_weight100 := IF(patch_default and ~le.mname_isnull and ri.field_specificity=0,s.mname_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j10 := join(j11,PULL(Specificities(ih).mname_values_persisted),left.mname=right.mname,add_mname(left,right,true),lookup,left outer);
layout_candidates add_fname(layout_candidates le,Specificities(ih).fname_values_persisted ri,boolean patch_default) := transform
  self.fname_weight100 := IF(patch_default and ~le.fname_isnull and ri.field_specificity=0,s.fname_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j9 := join(j10,PULL(Specificities(ih).fname_values_persisted),left.fname=right.fname,add_fname(left,right,true),lookup,left outer);
layout_candidates add_title(layout_candidates le,Specificities(ih).title_values_persisted ri,boolean patch_default) := transform
  self.title_weight100 := IF(patch_default and ~le.title_isnull and ri.field_specificity=0,s.title_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j8 := join(j9,PULL(Specificities(ih).title_values_persisted),left.title=right.title,add_title(left,right,true),lookup,left outer);
layout_candidates add_phone(layout_candidates le,Specificities(ih).phone_values_persisted ri,boolean patch_default) := transform
  self.phone_weight100 := IF(patch_default and ~le.phone_isnull and ri.field_specificity=0,s.phone_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j7 := join(j8,PULL(Specificities(ih).phone_values_persisted),left.phone=right.phone,add_phone(left,right,true),lookup,left outer);
layout_candidates add_vendor_id(layout_candidates le,Specificities(ih).vendor_id_values_persisted ri,boolean patch_default) := transform
  self.vendor_id_weight100 := IF(patch_default and ~le.vendor_id_isnull and ri.field_specificity=0,s.vendor_id_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j6 := join(j7,PULL(Specificities(ih).vendor_id_values_persisted),left.vendor_id=right.vendor_id,add_vendor_id(left,right,true),lookup,left outer);
layout_candidates add_dt_vendor_last_reported(layout_candidates le,Specificities(ih).dt_vendor_last_reported_values_persisted ri,boolean patch_default) := transform
  self.dt_vendor_last_reported_weight100 := IF(patch_default and ~le.dt_vendor_last_reported_isnull and ri.field_specificity=0,s.dt_vendor_last_reported_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j5 := join(j6,PULL(Specificities(ih).dt_vendor_last_reported_values_persisted),left.dt_vendor_last_reported=right.dt_vendor_last_reported,add_dt_vendor_last_reported(left,right,true),lookup,left outer);
layout_candidates add_dt_vendor_first_reported(layout_candidates le,Specificities(ih).dt_vendor_first_reported_values_persisted ri,boolean patch_default) := transform
  self.dt_vendor_first_reported_weight100 := IF(patch_default and ~le.dt_vendor_first_reported_isnull and ri.field_specificity=0,s.dt_vendor_first_reported_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j4 := join(j5,PULL(Specificities(ih).dt_vendor_first_reported_values_persisted),left.dt_vendor_first_reported=right.dt_vendor_first_reported,add_dt_vendor_first_reported(left,right,true),lookup,left outer);
layout_candidates add_dt_last_seen(layout_candidates le,Specificities(ih).dt_last_seen_values_persisted ri,boolean patch_default) := transform
  self.dt_last_seen_weight100 := IF(patch_default and ~le.dt_last_seen_isnull and ri.field_specificity=0,s.dt_last_seen_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j3 := join(j4,PULL(Specificities(ih).dt_last_seen_values_persisted),left.dt_last_seen=right.dt_last_seen,add_dt_last_seen(left,right,true),lookup,left outer);
layout_candidates add_dt_first_seen(layout_candidates le,Specificities(ih).dt_first_seen_values_persisted ri,boolean patch_default) := transform
  self.dt_first_seen_weight100 := IF(patch_default and ~le.dt_first_seen_isnull and ri.field_specificity=0,s.dt_first_seen_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j2 := join(j3,PULL(Specificities(ih).dt_first_seen_values_persisted),left.dt_first_seen=right.dt_first_seen,add_dt_first_seen(left,right,true),lookup,left outer);
layout_candidates add_src(layout_candidates le,Specificities(ih).src_values_persisted ri,boolean patch_default) := transform
  self.src_weight100 := IF(patch_default and ~le.src_isnull and ri.field_specificity=0,s.src_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j1 := join(j2,PULL(Specificities(ih).src_values_persisted),left.src=right.src,add_src(left,right,true),lookup,left outer);
layout_candidates add_did(layout_candidates le,Specificities(ih).did_values_persisted ri,boolean patch_default) := transform
  self.did_weight100 := IF(patch_default and ~le.did_isnull and ri.field_specificity=0,s.did_max,ri.field_specificity) * 100; // If never seen before - must be rare
  self := le;
end;
j0 := join(j1,PULL(Specificities(ih).did_values_persisted),left.did=right.did,add_did(left,right,true),lookup,left outer);
//Using HASH(did) to get smoother distribution
shared Annotated := distribute(j0,hash()) : persist('temp::NPPES_FileIN_mc'); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.did_weight100 + Annotated.src_weight100 + Annotated.dt_first_seen_weight100 + Annotated.dt_last_seen_weight100 + Annotated.dt_vendor_first_reported_weight100 + Annotated.dt_vendor_last_reported_weight100 + Annotated.vendor_id_weight100 + Annotated.phone_weight100 + Annotated.title_weight100 + Annotated.fname_weight100 + Annotated.mname_weight100 + Annotated.lname_weight100 + Annotated.name_suffix_weight100 + Annotated.prim_range_weight100 + Annotated.predir_weight100 + Annotated.prim_name_weight100 + Annotated.suffix_weight100 + Annotated.postdir_weight100 + Annotated.unit_desig_weight100 + Annotated.sec_range_weight100 + Annotated.city_name_weight100 + Annotated.st_weight100 + Annotated.zip_weight100 + Annotated.zip4_weight100 + Annotated.county_weight100 + Annotated.msa_weight100 + Annotated.geo_blk_weight100 + Annotated.RawAID_weight100;
shared Linkable := TotalWeight >= 0;
export Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
export Candidates := Annotated(Linkable); //No point in trying to link records with too little data
end;
+++Line:38:RIDField is now compulsory for full adl matching!!!
