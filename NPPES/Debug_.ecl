+++Line:38:RIDField is now compulsory for full adl matching!!!
// Various routines to assist in debugging
import SALT19,ut;
export Debug(dataset(layout_FileIN) ih, Layout_Specificities.R s, MatchThreshold = 0) := module
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
shared h := match_candidates(ih).candidates;
shared LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
export Layout_Sample_Matches := record,maxlength(32000)
  integer2 Conf;
  integer2 Conf_Prop;
  integer2 DateOverlap := 0;
  SALT19.UIDType 1;
  SALT19.UIDType 2;
  SALT19.UIDType 1;
  SALT19.UIDType 2;
  typeof(h.did) left_did;
  integer2 did_score;
  typeof(h.did) right_did;
  typeof(h.src) left_src;
  integer2 src_score;
  typeof(h.src) right_src;
  typeof(h.dt_first_seen) left_dt_first_seen;
  integer2 dt_first_seen_score;
  typeof(h.dt_first_seen) right_dt_first_seen;
  typeof(h.dt_last_seen) left_dt_last_seen;
  integer2 dt_last_seen_score;
  typeof(h.dt_last_seen) right_dt_last_seen;
  typeof(h.dt_vendor_first_reported) left_dt_vendor_first_reported;
  integer2 dt_vendor_first_reported_score;
  typeof(h.dt_vendor_first_reported) right_dt_vendor_first_reported;
  typeof(h.dt_vendor_last_reported) left_dt_vendor_last_reported;
  integer2 dt_vendor_last_reported_score;
  typeof(h.dt_vendor_last_reported) right_dt_vendor_last_reported;
  typeof(h.vendor_id) left_vendor_id;
  integer2 vendor_id_score;
  typeof(h.vendor_id) right_vendor_id;
  typeof(h.phone) left_phone;
  integer2 phone_score;
  typeof(h.phone) right_phone;
  typeof(h.title) left_title;
  integer2 title_score;
  typeof(h.title) right_title;
  typeof(h.fname) left_fname;
  integer2 fname_score;
  typeof(h.fname) right_fname;
  typeof(h.mname) left_mname;
  integer2 mname_score;
  typeof(h.mname) right_mname;
  typeof(h.lname) left_lname;
  integer2 lname_score;
  typeof(h.lname) right_lname;
  typeof(h.name_suffix) left_name_suffix;
  integer2 name_suffix_score;
  typeof(h.name_suffix) right_name_suffix;
  typeof(h.prim_range) left_prim_range;
  integer2 prim_range_score;
  typeof(h.prim_range) right_prim_range;
  typeof(h.predir) left_predir;
  integer2 predir_score;
  typeof(h.predir) right_predir;
  typeof(h.prim_name) left_prim_name;
  integer2 prim_name_score;
  typeof(h.prim_name) right_prim_name;
  typeof(h.suffix) left_suffix;
  integer2 suffix_score;
  typeof(h.suffix) right_suffix;
  typeof(h.postdir) left_postdir;
  integer2 postdir_score;
  typeof(h.postdir) right_postdir;
  typeof(h.unit_desig) left_unit_desig;
  integer2 unit_desig_score;
  typeof(h.unit_desig) right_unit_desig;
  typeof(h.sec_range) left_sec_range;
  integer2 sec_range_score;
  typeof(h.sec_range) right_sec_range;
  typeof(h.city_name) left_city_name;
  integer2 city_name_score;
  typeof(h.city_name) right_city_name;
  typeof(h.st) left_st;
  integer2 st_score;
  typeof(h.st) right_st;
  typeof(h.zip) left_zip;
  integer2 zip_score;
  typeof(h.zip) right_zip;
  typeof(h.zip4) left_zip4;
  integer2 zip4_score;
  typeof(h.zip4) right_zip4;
  typeof(h.county) left_county;
  integer2 county_score;
  typeof(h.county) right_county;
  typeof(h.msa) left_msa;
  integer2 msa_score;
  typeof(h.msa) right_msa;
  typeof(h.geo_blk) left_geo_blk;
  integer2 geo_blk_score;
  typeof(h.geo_blk) right_geo_blk;
  typeof(h.RawAID) left_RawAID;
  integer2 RawAID_score;
  typeof(h.RawAID) right_RawAID;
end;
export layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,unsigned outside=0) := transform
  self.1 := le.;
  self.2 := ri.;
  self.1 := le.;
  self.2 := ri.;
  self.did_score := MAP( le.did_isnull or ri.did_isnull => 0,
                        le.did = ri.did  => le.did_weight100,
                        SALT19.Fn_Fail_Scale(le.did_weight100,s.did_switch));
  self.left_did := le.did;
  self.right_did := ri.did;
  self.src_score := MAP( le.src_isnull or ri.src_isnull => 0,
                        le.src = ri.src  => le.src_weight100,
                        SALT19.Fn_Fail_Scale(le.src_weight100,s.src_switch));
  self.left_src := le.src;
  self.right_src := ri.src;
  self.dt_first_seen_score := MAP( le.dt_first_seen_isnull or ri.dt_first_seen_isnull => 0,
                        le.dt_first_seen = ri.dt_first_seen  => le.dt_first_seen_weight100,
                        SALT19.Fn_Fail_Scale(le.dt_first_seen_weight100,s.dt_first_seen_switch));
  self.left_dt_first_seen := le.dt_first_seen;
  self.right_dt_first_seen := ri.dt_first_seen;
  self.dt_last_seen_score := MAP( le.dt_last_seen_isnull or ri.dt_last_seen_isnull => 0,
                        le.dt_last_seen = ri.dt_last_seen  => le.dt_last_seen_weight100,
                        SALT19.Fn_Fail_Scale(le.dt_last_seen_weight100,s.dt_last_seen_switch));
  self.left_dt_last_seen := le.dt_last_seen;
  self.right_dt_last_seen := ri.dt_last_seen;
  self.dt_vendor_first_reported_score := MAP( le.dt_vendor_first_reported_isnull or ri.dt_vendor_first_reported_isnull => 0,
                        le.dt_vendor_first_reported = ri.dt_vendor_first_reported  => le.dt_vendor_first_reported_weight100,
                        SALT19.Fn_Fail_Scale(le.dt_vendor_first_reported_weight100,s.dt_vendor_first_reported_switch));
  self.left_dt_vendor_first_reported := le.dt_vendor_first_reported;
  self.right_dt_vendor_first_reported := ri.dt_vendor_first_reported;
  self.dt_vendor_last_reported_score := MAP( le.dt_vendor_last_reported_isnull or ri.dt_vendor_last_reported_isnull => 0,
                        le.dt_vendor_last_reported = ri.dt_vendor_last_reported  => le.dt_vendor_last_reported_weight100,
                        SALT19.Fn_Fail_Scale(le.dt_vendor_last_reported_weight100,s.dt_vendor_last_reported_switch));
  self.left_dt_vendor_last_reported := le.dt_vendor_last_reported;
  self.right_dt_vendor_last_reported := ri.dt_vendor_last_reported;
  self.vendor_id_score := MAP( le.vendor_id_isnull or ri.vendor_id_isnull => 0,
                        le.vendor_id = ri.vendor_id  => le.vendor_id_weight100,
                        SALT19.Fn_Fail_Scale(le.vendor_id_weight100,s.vendor_id_switch));
  self.left_vendor_id := le.vendor_id;
  self.right_vendor_id := ri.vendor_id;
  self.phone_score := MAP( le.phone_isnull or ri.phone_isnull => 0,
                        le.phone = ri.phone  => le.phone_weight100,
                        SALT19.Fn_Fail_Scale(le.phone_weight100,s.phone_switch));
  self.left_phone := le.phone;
  self.right_phone := ri.phone;
  self.title_score := MAP( le.title_isnull or ri.title_isnull => 0,
                        le.title = ri.title  => le.title_weight100,
                        SALT19.Fn_Fail_Scale(le.title_weight100,s.title_switch));
  self.left_title := le.title;
  self.right_title := ri.title;
  self.fname_score := MAP( le.fname_isnull or ri.fname_isnull => 0,
                        le.fname = ri.fname  => le.fname_weight100,
                        SALT19.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  self.left_fname := le.fname;
  self.right_fname := ri.fname;
  self.mname_score := MAP( le.mname_isnull or ri.mname_isnull => 0,
                        le.mname = ri.mname  => le.mname_weight100,
                        SALT19.Fn_Fail_Scale(le.mname_weight100,s.mname_switch));
  self.left_mname := le.mname;
  self.right_mname := ri.mname;
  self.lname_score := MAP( le.lname_isnull or ri.lname_isnull => 0,
                        le.lname = ri.lname  => le.lname_weight100,
                        SALT19.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  self.left_lname := le.lname;
  self.right_lname := ri.lname;
  self.name_suffix_score := MAP( le.name_suffix_isnull or ri.name_suffix_isnull => 0,
                        le.name_suffix = ri.name_suffix  => le.name_suffix_weight100,
                        SALT19.Fn_Fail_Scale(le.name_suffix_weight100,s.name_suffix_switch));
  self.left_name_suffix := le.name_suffix;
  self.right_name_suffix := ri.name_suffix;
  self.prim_range_score := MAP( le.prim_range_isnull or ri.prim_range_isnull => 0,
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT19.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch));
  self.left_prim_range := le.prim_range;
  self.right_prim_range := ri.prim_range;
  self.predir_score := MAP( le.predir_isnull or ri.predir_isnull => 0,
                        le.predir = ri.predir  => le.predir_weight100,
                        SALT19.Fn_Fail_Scale(le.predir_weight100,s.predir_switch));
  self.left_predir := le.predir;
  self.right_predir := ri.predir;
  self.prim_name_score := MAP( le.prim_name_isnull or ri.prim_name_isnull => 0,
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT19.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch));
  self.left_prim_name := le.prim_name;
  self.right_prim_name := ri.prim_name;
  self.suffix_score := MAP( le.suffix_isnull or ri.suffix_isnull => 0,
                        le.suffix = ri.suffix  => le.suffix_weight100,
                        SALT19.Fn_Fail_Scale(le.suffix_weight100,s.suffix_switch));
  self.left_suffix := le.suffix;
  self.right_suffix := ri.suffix;
  self.postdir_score := MAP( le.postdir_isnull or ri.postdir_isnull => 0,
                        le.postdir = ri.postdir  => le.postdir_weight100,
                        SALT19.Fn_Fail_Scale(le.postdir_weight100,s.postdir_switch));
  self.left_postdir := le.postdir;
  self.right_postdir := ri.postdir;
  self.unit_desig_score := MAP( le.unit_desig_isnull or ri.unit_desig_isnull => 0,
                        le.unit_desig = ri.unit_desig  => le.unit_desig_weight100,
                        SALT19.Fn_Fail_Scale(le.unit_desig_weight100,s.unit_desig_switch));
  self.left_unit_desig := le.unit_desig;
  self.right_unit_desig := ri.unit_desig;
  self.sec_range_score := MAP( le.sec_range_isnull or ri.sec_range_isnull => 0,
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT19.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch));
  self.left_sec_range := le.sec_range;
  self.right_sec_range := ri.sec_range;
  self.city_name_score := MAP( le.city_name_isnull or ri.city_name_isnull => 0,
                        le.city_name = ri.city_name  => le.city_name_weight100,
                        SALT19.Fn_Fail_Scale(le.city_name_weight100,s.city_name_switch));
  self.left_city_name := le.city_name;
  self.right_city_name := ri.city_name;
  self.st_score := MAP( le.st_isnull or ri.st_isnull => 0,
                        le.st = ri.st  => le.st_weight100,
                        SALT19.Fn_Fail_Scale(le.st_weight100,s.st_switch));
  self.left_st := le.st;
  self.right_st := ri.st;
  self.zip_score := MAP( le.zip_isnull or ri.zip_isnull => 0,
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT19.Fn_Fail_Scale(le.zip_weight100,s.zip_switch));
  self.left_zip := le.zip;
  self.right_zip := ri.zip;
  self.zip4_score := MAP( le.zip4_isnull or ri.zip4_isnull => 0,
                        le.zip4 = ri.zip4  => le.zip4_weight100,
                        SALT19.Fn_Fail_Scale(le.zip4_weight100,s.zip4_switch));
  self.left_zip4 := le.zip4;
  self.right_zip4 := ri.zip4;
  self.county_score := MAP( le.county_isnull or ri.county_isnull => 0,
                        le.county = ri.county  => le.county_weight100,
                        SALT19.Fn_Fail_Scale(le.county_weight100,s.county_switch));
  self.left_county := le.county;
  self.right_county := ri.county;
  self.msa_score := MAP( le.msa_isnull or ri.msa_isnull => 0,
                        le.msa = ri.msa  => le.msa_weight100,
                        SALT19.Fn_Fail_Scale(le.msa_weight100,s.msa_switch));
  self.left_msa := le.msa;
  self.right_msa := ri.msa;
  self.geo_blk_score := MAP( le.geo_blk_isnull or ri.geo_blk_isnull => 0,
                        le.geo_blk = ri.geo_blk  => le.geo_blk_weight100,
                        SALT19.Fn_Fail_Scale(le.geo_blk_weight100,s.geo_blk_switch));
  self.left_geo_blk := le.geo_blk;
  self.right_geo_blk := ri.geo_blk;
  self.RawAID_score := MAP( le.RawAID_isnull or ri.RawAID_isnull => 0,
                        le.RawAID = ri.RawAID  => le.RawAID_weight100,
                        SALT19.Fn_Fail_Scale(le.RawAID_weight100,s.RawAID_switch));
  self.left_RawAID := le.RawAID;
  self.right_RawAID := ri.RawAID;
  self.Conf_Prop := (0
  ) / 100; // Score based on propogated fields
  self.Conf := (self.did_score + self.src_score + self.dt_first_seen_score + self.dt_last_seen_score + self.dt_vendor_first_reported_score + self.dt_vendor_last_reported_score + self.vendor_id_score + self.phone_score + self.title_score + self.fname_score + self.mname_score + self.lname_score + self.name_suffix_score + self.prim_range_score + self.predir_score + self.prim_name_score + self.suffix_score + self.postdir_score + self.unit_desig_score + self.sec_range_score + self.city_name_score + self.st_score + self.zip_score + self.zip4_score + self.county_score + self.msa_score + self.geo_blk_score + self.RawAID_score) / 100 + outside;
end;
export AnnotateMatchesFromData(dataset(match_candidates(ih).layout_candidates) in_data,dataset(match_candidates(ih).layout_matches)  im) := function
  j1 := join(in_data,im,left. = right.1,hash);
  match_candidates(ih).layout_candidates strim(j1 le) := transform
    self := le;
  end;
  r := join(j1,in_data,left.2 = right.,sample_match_join( project(left,strim(left)),right),hash);
  d := dedup( sort( r, 1, 2, -Conf, local ), 1, 2, local ); // 2 distributed by join
  return d;
end;
export AnnotateMatchesFromRecordData(dataset(match_candidates(ih).layout_candidates) in_data,dataset(match_candidates(ih).layout_matches)  im) := function//Faster form when  known
  j1 := join(in_data,im,left. = right.1,hash);
  match_candidates(ih).layout_candidates strim(j1 le) := transform
    self := le;
  end;
  return join(j1,in_data,left.2 = right.,sample_match_join( project(left,strim(left)),right),hash);
end;
export AnnotateClusterMatches(dataset(match_candidates(ih).layout_candidates) in_data,SALT19.UIDType BaseRecord) := function//Faster form when  known
  j1 := in_data( = BaseRecord);
  match_candidates(ih).layout_candidates strim(j1 le) := transform
    self := le;
  end;
  return join(in_data(<>BaseRecord),j1,true,sample_match_join( project(left,strim(left)),right),all);
end;
export AnnotateMatches(dataset(match_candidates(ih).layout_matches)  im) := function
  return AnnotateMatchesFromRecordData(h,im);
end;
export Layout_RolledEntity := record,maxlength(63000)
  SALT19.UIDType ;
  dataset(SALT19.Layout_FieldValueList) did_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) src_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) dt_first_seen_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) dt_last_seen_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) dt_vendor_first_reported_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) dt_vendor_last_reported_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) vendor_id_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) phone_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) title_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) fname_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) mname_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) lname_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) name_suffix_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) prim_range_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) predir_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) prim_name_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) suffix_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) postdir_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) unit_desig_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) sec_range_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) city_name_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) st_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) zip_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) zip4_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) county_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) msa_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) geo_blk_Values := dataset([],SALT19.Layout_FieldValueList);
  dataset(SALT19.Layout_FieldValueList) RawAID_Values := dataset([],SALT19.Layout_FieldValueList);
end;
shared RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := transform
  self. := le.;
  self.did_values := SALT19.fn_combine_fieldvaluelist(le.did_values,ri.did_values);
  self.src_values := SALT19.fn_combine_fieldvaluelist(le.src_values,ri.src_values);
  self.dt_first_seen_values := SALT19.fn_combine_fieldvaluelist(le.dt_first_seen_values,ri.dt_first_seen_values);
  self.dt_last_seen_values := SALT19.fn_combine_fieldvaluelist(le.dt_last_seen_values,ri.dt_last_seen_values);
  self.dt_vendor_first_reported_values := SALT19.fn_combine_fieldvaluelist(le.dt_vendor_first_reported_values,ri.dt_vendor_first_reported_values);
  self.dt_vendor_last_reported_values := SALT19.fn_combine_fieldvaluelist(le.dt_vendor_last_reported_values,ri.dt_vendor_last_reported_values);
  self.vendor_id_values := SALT19.fn_combine_fieldvaluelist(le.vendor_id_values,ri.vendor_id_values);
  self.phone_values := SALT19.fn_combine_fieldvaluelist(le.phone_values,ri.phone_values);
  self.title_values := SALT19.fn_combine_fieldvaluelist(le.title_values,ri.title_values);
  self.fname_values := SALT19.fn_combine_fieldvaluelist(le.fname_values,ri.fname_values);
  self.mname_values := SALT19.fn_combine_fieldvaluelist(le.mname_values,ri.mname_values);
  self.lname_values := SALT19.fn_combine_fieldvaluelist(le.lname_values,ri.lname_values);
  self.name_suffix_values := SALT19.fn_combine_fieldvaluelist(le.name_suffix_values,ri.name_suffix_values);
  self.prim_range_values := SALT19.fn_combine_fieldvaluelist(le.prim_range_values,ri.prim_range_values);
  self.predir_values := SALT19.fn_combine_fieldvaluelist(le.predir_values,ri.predir_values);
  self.prim_name_values := SALT19.fn_combine_fieldvaluelist(le.prim_name_values,ri.prim_name_values);
  self.suffix_values := SALT19.fn_combine_fieldvaluelist(le.suffix_values,ri.suffix_values);
  self.postdir_values := SALT19.fn_combine_fieldvaluelist(le.postdir_values,ri.postdir_values);
  self.unit_desig_values := SALT19.fn_combine_fieldvaluelist(le.unit_desig_values,ri.unit_desig_values);
  self.sec_range_values := SALT19.fn_combine_fieldvaluelist(le.sec_range_values,ri.sec_range_values);
  self.city_name_values := SALT19.fn_combine_fieldvaluelist(le.city_name_values,ri.city_name_values);
  self.st_values := SALT19.fn_combine_fieldvaluelist(le.st_values,ri.st_values);
  self.zip_values := SALT19.fn_combine_fieldvaluelist(le.zip_values,ri.zip_values);
  self.zip4_values := SALT19.fn_combine_fieldvaluelist(le.zip4_values,ri.zip4_values);
  self.county_values := SALT19.fn_combine_fieldvaluelist(le.county_values,ri.county_values);
  self.msa_values := SALT19.fn_combine_fieldvaluelist(le.msa_values,ri.msa_values);
  self.geo_blk_values := SALT19.fn_combine_fieldvaluelist(le.geo_blk_values,ri.geo_blk_values);
  self.RawAID_values := SALT19.fn_combine_fieldvaluelist(le.RawAID_values,ri.RawAID_values);
end;
  return rollup( sort( distribute( infile, hash() ), , local ), left. = right., RollValues(left,right),local);
end;
export RolledEntities(dataset(match_candidates(ih).layout_candidates) in_data) := function
Layout_RolledEntity into(in_data le) := transform
  self. := le.;
  self.did_Values := IF ( le.did  IN SET(s.nulls_did,did),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.did)}],SALT19.Layout_FieldValueList));
  self.src_Values := IF ( le.src  IN SET(s.nulls_src,src),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.src)}],SALT19.Layout_FieldValueList));
  self.dt_first_seen_Values := IF ( le.dt_first_seen  IN SET(s.nulls_dt_first_seen,dt_first_seen),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.dt_first_seen)}],SALT19.Layout_FieldValueList));
  self.dt_last_seen_Values := IF ( le.dt_last_seen  IN SET(s.nulls_dt_last_seen,dt_last_seen),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.dt_last_seen)}],SALT19.Layout_FieldValueList));
  self.dt_vendor_first_reported_Values := IF ( le.dt_vendor_first_reported  IN SET(s.nulls_dt_vendor_first_reported,dt_vendor_first_reported),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.dt_vendor_first_reported)}],SALT19.Layout_FieldValueList));
  self.dt_vendor_last_reported_Values := IF ( le.dt_vendor_last_reported  IN SET(s.nulls_dt_vendor_last_reported,dt_vendor_last_reported),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.dt_vendor_last_reported)}],SALT19.Layout_FieldValueList));
  self.vendor_id_Values := IF ( le.vendor_id  IN SET(s.nulls_vendor_id,vendor_id),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.vendor_id)}],SALT19.Layout_FieldValueList));
  self.phone_Values := IF ( le.phone  IN SET(s.nulls_phone,phone),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.phone)}],SALT19.Layout_FieldValueList));
  self.title_Values := IF ( le.title  IN SET(s.nulls_title,title),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.title)}],SALT19.Layout_FieldValueList));
  self.fname_Values := IF ( le.fname  IN SET(s.nulls_fname,fname),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.fname)}],SALT19.Layout_FieldValueList));
  self.mname_Values := IF ( le.mname  IN SET(s.nulls_mname,mname),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.mname)}],SALT19.Layout_FieldValueList));
  self.lname_Values := IF ( le.lname  IN SET(s.nulls_lname,lname),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.lname)}],SALT19.Layout_FieldValueList));
  self.name_suffix_Values := IF ( le.name_suffix  IN SET(s.nulls_name_suffix,name_suffix),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.name_suffix)}],SALT19.Layout_FieldValueList));
  self.prim_range_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.prim_range)}],SALT19.Layout_FieldValueList));
  self.predir_Values := IF ( le.predir  IN SET(s.nulls_predir,predir),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.predir)}],SALT19.Layout_FieldValueList));
  self.prim_name_Values := IF ( le.prim_name  IN SET(s.nulls_prim_name,prim_name),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.prim_name)}],SALT19.Layout_FieldValueList));
  self.suffix_Values := IF ( le.suffix  IN SET(s.nulls_suffix,suffix),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.suffix)}],SALT19.Layout_FieldValueList));
  self.postdir_Values := IF ( le.postdir  IN SET(s.nulls_postdir,postdir),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.postdir)}],SALT19.Layout_FieldValueList));
  self.unit_desig_Values := IF ( le.unit_desig  IN SET(s.nulls_unit_desig,unit_desig),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.unit_desig)}],SALT19.Layout_FieldValueList));
  self.sec_range_Values := IF ( le.sec_range  IN SET(s.nulls_sec_range,sec_range),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.sec_range)}],SALT19.Layout_FieldValueList));
  self.city_name_Values := IF ( le.city_name  IN SET(s.nulls_city_name,city_name),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.city_name)}],SALT19.Layout_FieldValueList));
  self.st_Values := IF ( le.st  IN SET(s.nulls_st,st),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.st)}],SALT19.Layout_FieldValueList));
  self.zip_Values := IF ( le.zip  IN SET(s.nulls_zip,zip),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.zip)}],SALT19.Layout_FieldValueList));
  self.zip4_Values := IF ( le.zip4  IN SET(s.nulls_zip4,zip4),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.zip4)}],SALT19.Layout_FieldValueList));
  self.county_Values := IF ( le.county  IN SET(s.nulls_county,county),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.county)}],SALT19.Layout_FieldValueList));
  self.msa_Values := IF ( le.msa  IN SET(s.nulls_msa,msa),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.msa)}],SALT19.Layout_FieldValueList));
  self.geo_blk_Values := IF ( le.geo_blk  IN SET(s.nulls_geo_blk,geo_blk),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.geo_blk)}],SALT19.Layout_FieldValueList));
  self.RawAID_Values := IF ( le.RawAID  IN SET(s.nulls_RawAID,RawAID),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.RawAID)}],SALT19.Layout_FieldValueList));
end;
AsFieldValues := project(in_data,into(left));
  return RollEntities(AsFieldValues);
end;
Layout_RolledEntity into(ih le) := transform
  self. := le.;
  self.did_Values := IF ( le.did  IN SET(s.nulls_did,did),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.did)}],SALT19.Layout_FieldValueList));
  self.src_Values := IF ( le.src  IN SET(s.nulls_src,src),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.src)}],SALT19.Layout_FieldValueList));
  self.dt_first_seen_Values := IF ( le.dt_first_seen  IN SET(s.nulls_dt_first_seen,dt_first_seen),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.dt_first_seen)}],SALT19.Layout_FieldValueList));
  self.dt_last_seen_Values := IF ( le.dt_last_seen  IN SET(s.nulls_dt_last_seen,dt_last_seen),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.dt_last_seen)}],SALT19.Layout_FieldValueList));
  self.dt_vendor_first_reported_Values := IF ( le.dt_vendor_first_reported  IN SET(s.nulls_dt_vendor_first_reported,dt_vendor_first_reported),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.dt_vendor_first_reported)}],SALT19.Layout_FieldValueList));
  self.dt_vendor_last_reported_Values := IF ( le.dt_vendor_last_reported  IN SET(s.nulls_dt_vendor_last_reported,dt_vendor_last_reported),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.dt_vendor_last_reported)}],SALT19.Layout_FieldValueList));
  self.vendor_id_Values := IF ( le.vendor_id  IN SET(s.nulls_vendor_id,vendor_id),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.vendor_id)}],SALT19.Layout_FieldValueList));
  self.phone_Values := IF ( le.phone  IN SET(s.nulls_phone,phone),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.phone)}],SALT19.Layout_FieldValueList));
  self.title_Values := IF ( le.title  IN SET(s.nulls_title,title),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.title)}],SALT19.Layout_FieldValueList));
  self.fname_Values := IF ( le.fname  IN SET(s.nulls_fname,fname),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.fname)}],SALT19.Layout_FieldValueList));
  self.mname_Values := IF ( le.mname  IN SET(s.nulls_mname,mname),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.mname)}],SALT19.Layout_FieldValueList));
  self.lname_Values := IF ( le.lname  IN SET(s.nulls_lname,lname),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.lname)}],SALT19.Layout_FieldValueList));
  self.name_suffix_Values := IF ( le.name_suffix  IN SET(s.nulls_name_suffix,name_suffix),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.name_suffix)}],SALT19.Layout_FieldValueList));
  self.prim_range_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.prim_range)}],SALT19.Layout_FieldValueList));
  self.predir_Values := IF ( le.predir  IN SET(s.nulls_predir,predir),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.predir)}],SALT19.Layout_FieldValueList));
  self.prim_name_Values := IF ( le.prim_name  IN SET(s.nulls_prim_name,prim_name),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.prim_name)}],SALT19.Layout_FieldValueList));
  self.suffix_Values := IF ( le.suffix  IN SET(s.nulls_suffix,suffix),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.suffix)}],SALT19.Layout_FieldValueList));
  self.postdir_Values := IF ( le.postdir  IN SET(s.nulls_postdir,postdir),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.postdir)}],SALT19.Layout_FieldValueList));
  self.unit_desig_Values := IF ( le.unit_desig  IN SET(s.nulls_unit_desig,unit_desig),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.unit_desig)}],SALT19.Layout_FieldValueList));
  self.sec_range_Values := IF ( le.sec_range  IN SET(s.nulls_sec_range,sec_range),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.sec_range)}],SALT19.Layout_FieldValueList));
  self.city_name_Values := IF ( le.city_name  IN SET(s.nulls_city_name,city_name),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.city_name)}],SALT19.Layout_FieldValueList));
  self.st_Values := IF ( le.st  IN SET(s.nulls_st,st),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.st)}],SALT19.Layout_FieldValueList));
  self.zip_Values := IF ( le.zip  IN SET(s.nulls_zip,zip),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.zip)}],SALT19.Layout_FieldValueList));
  self.zip4_Values := IF ( le.zip4  IN SET(s.nulls_zip4,zip4),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.zip4)}],SALT19.Layout_FieldValueList));
  self.county_Values := IF ( le.county  IN SET(s.nulls_county,county),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.county)}],SALT19.Layout_FieldValueList));
  self.msa_Values := IF ( le.msa  IN SET(s.nulls_msa,msa),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.msa)}],SALT19.Layout_FieldValueList));
  self.geo_blk_Values := IF ( le.geo_blk  IN SET(s.nulls_geo_blk,geo_blk),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.geo_blk)}],SALT19.Layout_FieldValueList));
  self.RawAID_Values := IF ( le.RawAID  IN SET(s.nulls_RawAID,RawAID),dataset([],SALT19.Layout_FieldValueList),dataset([{trim((string)le.RawAID)}],SALT19.Layout_FieldValueList));
end;
AsFieldValues := project(ih,into(left));
export InFile_Rolled := RollEntities(AsFieldValues);
export RemoveProps(dataset(match_candidates(ih).layout_candidates) im) := function
  im rem(im le) := transform
    self := le;
  end;
  return project(im,rem(left));
end;
// Now to compute the chubbies; those clusters which are really rather larger than one would expect
// this is presently defined in terms of number of field values * the improbability of that occuring by chance
// this could be used as poor mans dodgy-dids; but it does not allow for value planing (co-occurrence)
AllRolled := InFile_Rolled;
Layout_Chubbies0 := RECORD,MAXLENGTH(63000)
  AllRolled;
  unsigned1 did_size := 0;
  unsigned1 src_size := 0;
  unsigned1 dt_first_seen_size := 0;
  unsigned1 dt_last_seen_size := 0;
  unsigned1 dt_vendor_first_reported_size := 0;
  unsigned1 dt_vendor_last_reported_size := 0;
  unsigned1 vendor_id_size := 0;
  unsigned1 phone_size := 0;
  unsigned1 title_size := 0;
  unsigned1 fname_size := 0;
  unsigned1 mname_size := 0;
  unsigned1 lname_size := 0;
  unsigned1 name_suffix_size := 0;
  unsigned1 prim_range_size := 0;
  unsigned1 predir_size := 0;
  unsigned1 prim_name_size := 0;
  unsigned1 suffix_size := 0;
  unsigned1 postdir_size := 0;
  unsigned1 unit_desig_size := 0;
  unsigned1 sec_range_size := 0;
  unsigned1 city_name_size := 0;
  unsigned1 st_size := 0;
  unsigned1 zip_size := 0;
  unsigned1 zip4_size := 0;
  unsigned1 county_size := 0;
  unsigned1 msa_size := 0;
  unsigned1 geo_blk_size := 0;
  unsigned1 RawAID_size := 0;
end;
t0 := table(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := transform
  SELF.did_size := SALT19.Fn_SwitchSpec(s.did_switch,count(le.did_values));
  SELF.src_size := SALT19.Fn_SwitchSpec(s.src_switch,count(le.src_values));
  SELF.dt_first_seen_size := SALT19.Fn_SwitchSpec(s.dt_first_seen_switch,count(le.dt_first_seen_values));
  SELF.dt_last_seen_size := SALT19.Fn_SwitchSpec(s.dt_last_seen_switch,count(le.dt_last_seen_values));
  SELF.dt_vendor_first_reported_size := SALT19.Fn_SwitchSpec(s.dt_vendor_first_reported_switch,count(le.dt_vendor_first_reported_values));
  SELF.dt_vendor_last_reported_size := SALT19.Fn_SwitchSpec(s.dt_vendor_last_reported_switch,count(le.dt_vendor_last_reported_values));
  SELF.vendor_id_size := SALT19.Fn_SwitchSpec(s.vendor_id_switch,count(le.vendor_id_values));
  SELF.phone_size := SALT19.Fn_SwitchSpec(s.phone_switch,count(le.phone_values));
  SELF.title_size := SALT19.Fn_SwitchSpec(s.title_switch,count(le.title_values));
  SELF.fname_size := SALT19.Fn_SwitchSpec(s.fname_switch,count(le.fname_values));
  SELF.mname_size := SALT19.Fn_SwitchSpec(s.mname_switch,count(le.mname_values));
  SELF.lname_size := SALT19.Fn_SwitchSpec(s.lname_switch,count(le.lname_values));
  SELF.name_suffix_size := SALT19.Fn_SwitchSpec(s.name_suffix_switch,count(le.name_suffix_values));
  SELF.prim_range_size := SALT19.Fn_SwitchSpec(s.prim_range_switch,count(le.prim_range_values));
  SELF.predir_size := SALT19.Fn_SwitchSpec(s.predir_switch,count(le.predir_values));
  SELF.prim_name_size := SALT19.Fn_SwitchSpec(s.prim_name_switch,count(le.prim_name_values));
  SELF.suffix_size := SALT19.Fn_SwitchSpec(s.suffix_switch,count(le.suffix_values));
  SELF.postdir_size := SALT19.Fn_SwitchSpec(s.postdir_switch,count(le.postdir_values));
  SELF.unit_desig_size := SALT19.Fn_SwitchSpec(s.unit_desig_switch,count(le.unit_desig_values));
  SELF.sec_range_size := SALT19.Fn_SwitchSpec(s.sec_range_switch,count(le.sec_range_values));
  SELF.city_name_size := SALT19.Fn_SwitchSpec(s.city_name_switch,count(le.city_name_values));
  SELF.st_size := SALT19.Fn_SwitchSpec(s.st_switch,count(le.st_values));
  SELF.zip_size := SALT19.Fn_SwitchSpec(s.zip_switch,count(le.zip_values));
  SELF.zip4_size := SALT19.Fn_SwitchSpec(s.zip4_switch,count(le.zip4_values));
  SELF.county_size := SALT19.Fn_SwitchSpec(s.county_switch,count(le.county_values));
  SELF.msa_size := SALT19.Fn_SwitchSpec(s.msa_switch,count(le.msa_values));
  SELF.geo_blk_size := SALT19.Fn_SwitchSpec(s.geo_blk_switch,count(le.geo_blk_values));
  SELF.RawAID_size := SALT19.Fn_SwitchSpec(s.RawAID_switch,count(le.RawAID_values));
  SELF := le;
end;  t := project(t0,NoteSize(left));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  unsigned2 Size := t.did_size+t.src_size+t.dt_first_seen_size+t.dt_last_seen_size+t.dt_vendor_first_reported_size+t.dt_vendor_last_reported_size+t.vendor_id_size+t.phone_size+t.title_size+t.fname_size+t.mname_size+t.lname_size+t.name_suffix_size+t.prim_range_size+t.predir_size+t.prim_name_size+t.suffix_size+t.postdir_size+t.unit_desig_size+t.sec_range_size+t.city_name_size+t.st_size+t.zip_size+t.zip4_size+t.county_size+t.msa_size+t.geo_blk_size+t.RawAID_size;
end;
export Chubbies := table(t,Layout_Chubbies);
end;
