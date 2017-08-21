+++Line:44:RIDField is now compulsory for full adl matching!!!
// Various routines to assist in debugging
import SALT20,ut;
export Debug(dataset(layout_as_bh) ih, Layout_Specificities.R s, MatchThreshold = 0) := module
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
shared h := match_candidates(ih).candidates;
shared LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
export Layout_Sample_Matches := record,maxlength(32000)
  integer2 Conf;
  integer2 Conf_Prop;
  integer2 DateOverlap := 0;
  SALT20.UIDType 1;
  SALT20.UIDType 2;
  SALT20.UIDType 1;
  SALT20.UIDType 2;
  typeof(h.rcid) left_rcid;
  integer2 rcid_score;
  typeof(h.rcid) right_rcid;
  typeof(h.bdid) left_bdid;
  integer2 bdid_score;
  typeof(h.bdid) right_bdid;
  typeof(h.source) left_source;
  integer2 source_score;
  typeof(h.source) right_source;
  typeof(h.source_group) left_source_group;
  integer2 source_group_score;
  typeof(h.source_group) right_source_group;
  typeof(h.pflag) left_pflag;
  integer2 pflag_score;
  typeof(h.pflag) right_pflag;
  typeof(h.group1_id) left_group1_id;
  integer2 group1_id_score;
  typeof(h.group1_id) right_group1_id;
  typeof(h.vendor_id) left_vendor_id;
  integer2 vendor_id_score;
  typeof(h.vendor_id) right_vendor_id;
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
  typeof(h.company_name) left_company_name;
  integer2 company_name_score;
  typeof(h.company_name) right_company_name;
  typeof(h.prim_range) left_prim_range;
  integer2 prim_range_score;
  typeof(h.prim_range) right_prim_range;
  typeof(h.predir) left_predir;
  integer2 predir_score;
  typeof(h.predir) right_predir;
  typeof(h.prim_name) left_prim_name;
  integer2 prim_name_score;
  typeof(h.prim_name) right_prim_name;
  typeof(h.addr_suffix) left_addr_suffix;
  integer2 addr_suffix_score;
  typeof(h.addr_suffix) right_addr_suffix;
  typeof(h.postdir) left_postdir;
  integer2 postdir_score;
  typeof(h.postdir) right_postdir;
  typeof(h.unit_desig) left_unit_desig;
  integer2 unit_desig_score;
  typeof(h.unit_desig) right_unit_desig;
  typeof(h.sec_range) left_sec_range;
  integer2 sec_range_score;
  typeof(h.sec_range) right_sec_range;
  typeof(h.city) left_city;
  integer2 city_score;
  typeof(h.city) right_city;
  typeof(h.state) left_state;
  integer2 state_score;
  typeof(h.state) right_state;
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
  typeof(h.geo_lat) left_geo_lat;
  integer2 geo_lat_score;
  typeof(h.geo_lat) right_geo_lat;
  typeof(h.geo_long) left_geo_long;
  integer2 geo_long_score;
  typeof(h.geo_long) right_geo_long;
  typeof(h.phone) left_phone;
  integer2 phone_score;
  typeof(h.phone) right_phone;
  typeof(h.phone_score) left_phone_score;
  integer2 phone_score_score;
  typeof(h.phone_score) right_phone_score;
  typeof(h.fein) left_fein;
  integer2 fein_score;
  typeof(h.fein) right_fein;
  typeof(h.current) left_current;
  integer2 current_score;
  typeof(h.current) right_current;
  typeof(h.dppa) left_dppa;
  integer2 dppa_score;
  typeof(h.dppa) right_dppa;
  typeof(h.vl_id) left_vl_id;
  integer2 vl_id_score;
  typeof(h.vl_id) right_vl_id;
  typeof(h.RawAID) left_RawAID;
  integer2 RawAID_score;
  typeof(h.RawAID) right_RawAID;
end;
export layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,unsigned outside=0) := transform
  self.1 := le.;
  self.2 := ri.;
  self.1 := le.;
  self.2 := ri.;
  self.rcid_score := MAP( le.rcid_isnull or ri.rcid_isnull => 0,
                        le.rcid = ri.rcid  => le.rcid_weight100,
                        SALT20.Fn_Fail_Scale(le.rcid_weight100,s.rcid_switch));
  self.left_rcid := le.rcid;
  self.right_rcid := ri.rcid;
  self.bdid_score := MAP( le.bdid_isnull or ri.bdid_isnull => 0,
                        le.bdid = ri.bdid  => le.bdid_weight100,
                        SALT20.Fn_Fail_Scale(le.bdid_weight100,s.bdid_switch));
  self.left_bdid := le.bdid;
  self.right_bdid := ri.bdid;
  self.source_score := MAP( le.source_isnull or ri.source_isnull => 0,
                        le.source = ri.source  => le.source_weight100,
                        SALT20.Fn_Fail_Scale(le.source_weight100,s.source_switch));
  self.left_source := le.source;
  self.right_source := ri.source;
  self.source_group_score := MAP( le.source_group_isnull or ri.source_group_isnull => 0,
                        le.source_group = ri.source_group  => le.source_group_weight100,
                        SALT20.Fn_Fail_Scale(le.source_group_weight100,s.source_group_switch));
  self.left_source_group := le.source_group;
  self.right_source_group := ri.source_group;
  self.pflag_score := MAP( le.pflag_isnull or ri.pflag_isnull => 0,
                        le.pflag = ri.pflag  => le.pflag_weight100,
                        SALT20.Fn_Fail_Scale(le.pflag_weight100,s.pflag_switch));
  self.left_pflag := le.pflag;
  self.right_pflag := ri.pflag;
  self.group1_id_score := MAP( le.group1_id_isnull or ri.group1_id_isnull => 0,
                        le.group1_id = ri.group1_id  => le.group1_id_weight100,
                        SALT20.Fn_Fail_Scale(le.group1_id_weight100,s.group1_id_switch));
  self.left_group1_id := le.group1_id;
  self.right_group1_id := ri.group1_id;
  self.vendor_id_score := MAP( le.vendor_id_isnull or ri.vendor_id_isnull => 0,
                        le.vendor_id = ri.vendor_id  => le.vendor_id_weight100,
                        SALT20.Fn_Fail_Scale(le.vendor_id_weight100,s.vendor_id_switch));
  self.left_vendor_id := le.vendor_id;
  self.right_vendor_id := ri.vendor_id;
  self.dt_first_seen_score := MAP( le.dt_first_seen_isnull or ri.dt_first_seen_isnull => 0,
                        le.dt_first_seen = ri.dt_first_seen  => le.dt_first_seen_weight100,
                        SALT20.Fn_Fail_Scale(le.dt_first_seen_weight100,s.dt_first_seen_switch));
  self.left_dt_first_seen := le.dt_first_seen;
  self.right_dt_first_seen := ri.dt_first_seen;
  self.dt_last_seen_score := MAP( le.dt_last_seen_isnull or ri.dt_last_seen_isnull => 0,
                        le.dt_last_seen = ri.dt_last_seen  => le.dt_last_seen_weight100,
                        SALT20.Fn_Fail_Scale(le.dt_last_seen_weight100,s.dt_last_seen_switch));
  self.left_dt_last_seen := le.dt_last_seen;
  self.right_dt_last_seen := ri.dt_last_seen;
  self.dt_vendor_first_reported_score := MAP( le.dt_vendor_first_reported_isnull or ri.dt_vendor_first_reported_isnull => 0,
                        le.dt_vendor_first_reported = ri.dt_vendor_first_reported  => le.dt_vendor_first_reported_weight100,
                        SALT20.Fn_Fail_Scale(le.dt_vendor_first_reported_weight100,s.dt_vendor_first_reported_switch));
  self.left_dt_vendor_first_reported := le.dt_vendor_first_reported;
  self.right_dt_vendor_first_reported := ri.dt_vendor_first_reported;
  self.dt_vendor_last_reported_score := MAP( le.dt_vendor_last_reported_isnull or ri.dt_vendor_last_reported_isnull => 0,
                        le.dt_vendor_last_reported = ri.dt_vendor_last_reported  => le.dt_vendor_last_reported_weight100,
                        SALT20.Fn_Fail_Scale(le.dt_vendor_last_reported_weight100,s.dt_vendor_last_reported_switch));
  self.left_dt_vendor_last_reported := le.dt_vendor_last_reported;
  self.right_dt_vendor_last_reported := ri.dt_vendor_last_reported;
  self.company_name_score := MAP( le.company_name_isnull or ri.company_name_isnull => 0,
                        le.company_name = ri.company_name  => le.company_name_weight100,
                        SALT20.Fn_Fail_Scale(le.company_name_weight100,s.company_name_switch));
  self.left_company_name := le.company_name;
  self.right_company_name := ri.company_name;
  self.prim_range_score := MAP( le.prim_range_isnull or ri.prim_range_isnull => 0,
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT20.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch));
  self.left_prim_range := le.prim_range;
  self.right_prim_range := ri.prim_range;
  self.predir_score := MAP( le.predir_isnull or ri.predir_isnull => 0,
                        le.predir = ri.predir  => le.predir_weight100,
                        SALT20.Fn_Fail_Scale(le.predir_weight100,s.predir_switch));
  self.left_predir := le.predir;
  self.right_predir := ri.predir;
  self.prim_name_score := MAP( le.prim_name_isnull or ri.prim_name_isnull => 0,
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT20.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch));
  self.left_prim_name := le.prim_name;
  self.right_prim_name := ri.prim_name;
  self.addr_suffix_score := MAP( le.addr_suffix_isnull or ri.addr_suffix_isnull => 0,
                        le.addr_suffix = ri.addr_suffix  => le.addr_suffix_weight100,
                        SALT20.Fn_Fail_Scale(le.addr_suffix_weight100,s.addr_suffix_switch));
  self.left_addr_suffix := le.addr_suffix;
  self.right_addr_suffix := ri.addr_suffix;
  self.postdir_score := MAP( le.postdir_isnull or ri.postdir_isnull => 0,
                        le.postdir = ri.postdir  => le.postdir_weight100,
                        SALT20.Fn_Fail_Scale(le.postdir_weight100,s.postdir_switch));
  self.left_postdir := le.postdir;
  self.right_postdir := ri.postdir;
  self.unit_desig_score := MAP( le.unit_desig_isnull or ri.unit_desig_isnull => 0,
                        le.unit_desig = ri.unit_desig  => le.unit_desig_weight100,
                        SALT20.Fn_Fail_Scale(le.unit_desig_weight100,s.unit_desig_switch));
  self.left_unit_desig := le.unit_desig;
  self.right_unit_desig := ri.unit_desig;
  self.sec_range_score := MAP( le.sec_range_isnull or ri.sec_range_isnull => 0,
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT20.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch));
  self.left_sec_range := le.sec_range;
  self.right_sec_range := ri.sec_range;
  self.city_score := MAP( le.city_isnull or ri.city_isnull => 0,
                        le.city = ri.city  => le.city_weight100,
                        SALT20.Fn_Fail_Scale(le.city_weight100,s.city_switch));
  self.left_city := le.city;
  self.right_city := ri.city;
  self.state_score := MAP( le.state_isnull or ri.state_isnull => 0,
                        le.state = ri.state  => le.state_weight100,
                        SALT20.Fn_Fail_Scale(le.state_weight100,s.state_switch));
  self.left_state := le.state;
  self.right_state := ri.state;
  self.zip_score := MAP( le.zip_isnull or ri.zip_isnull => 0,
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT20.Fn_Fail_Scale(le.zip_weight100,s.zip_switch));
  self.left_zip := le.zip;
  self.right_zip := ri.zip;
  self.zip4_score := MAP( le.zip4_isnull or ri.zip4_isnull => 0,
                        le.zip4 = ri.zip4  => le.zip4_weight100,
                        SALT20.Fn_Fail_Scale(le.zip4_weight100,s.zip4_switch));
  self.left_zip4 := le.zip4;
  self.right_zip4 := ri.zip4;
  self.county_score := MAP( le.county_isnull or ri.county_isnull => 0,
                        le.county = ri.county  => le.county_weight100,
                        SALT20.Fn_Fail_Scale(le.county_weight100,s.county_switch));
  self.left_county := le.county;
  self.right_county := ri.county;
  self.msa_score := MAP( le.msa_isnull or ri.msa_isnull => 0,
                        le.msa = ri.msa  => le.msa_weight100,
                        SALT20.Fn_Fail_Scale(le.msa_weight100,s.msa_switch));
  self.left_msa := le.msa;
  self.right_msa := ri.msa;
  self.geo_lat_score := MAP( le.geo_lat_isnull or ri.geo_lat_isnull => 0,
                        le.geo_lat = ri.geo_lat  => le.geo_lat_weight100,
                        SALT20.Fn_Fail_Scale(le.geo_lat_weight100,s.geo_lat_switch));
  self.left_geo_lat := le.geo_lat;
  self.right_geo_lat := ri.geo_lat;
  self.geo_long_score := MAP( le.geo_long_isnull or ri.geo_long_isnull => 0,
                        le.geo_long = ri.geo_long  => le.geo_long_weight100,
                        SALT20.Fn_Fail_Scale(le.geo_long_weight100,s.geo_long_switch));
  self.left_geo_long := le.geo_long;
  self.right_geo_long := ri.geo_long;
  self.phone_score := MAP( le.phone_isnull or ri.phone_isnull => 0,
                        le.phone = ri.phone  => le.phone_weight100,
                        SALT20.Fn_Fail_Scale(le.phone_weight100,s.phone_switch));
  self.left_phone := le.phone;
  self.right_phone := ri.phone;
  self.phone_score_score := MAP( le.phone_score_isnull or ri.phone_score_isnull => 0,
                        le.phone_score = ri.phone_score  => le.phone_score_weight100,
                        SALT20.Fn_Fail_Scale(le.phone_score_weight100,s.phone_score_switch));
  self.left_phone_score := le.phone_score;
  self.right_phone_score := ri.phone_score;
  self.fein_score := MAP( le.fein_isnull or ri.fein_isnull => 0,
                        le.fein = ri.fein  => le.fein_weight100,
                        SALT20.Fn_Fail_Scale(le.fein_weight100,s.fein_switch));
  self.left_fein := le.fein;
  self.right_fein := ri.fein;
  self.current_score := MAP( le.current_isnull or ri.current_isnull => 0,
                        le.current = ri.current  => le.current_weight100,
                        SALT20.Fn_Fail_Scale(le.current_weight100,s.current_switch));
  self.left_current := le.current;
  self.right_current := ri.current;
  self.dppa_score := MAP( le.dppa_isnull or ri.dppa_isnull => 0,
                        le.dppa = ri.dppa  => le.dppa_weight100,
                        SALT20.Fn_Fail_Scale(le.dppa_weight100,s.dppa_switch));
  self.left_dppa := le.dppa;
  self.right_dppa := ri.dppa;
  self.vl_id_score := MAP( le.vl_id_isnull or ri.vl_id_isnull => 0,
                        le.vl_id = ri.vl_id  => le.vl_id_weight100,
                        SALT20.Fn_Fail_Scale(le.vl_id_weight100,s.vl_id_switch));
  self.left_vl_id := le.vl_id;
  self.right_vl_id := ri.vl_id;
  self.RawAID_score := MAP( le.RawAID_isnull or ri.RawAID_isnull => 0,
                        le.RawAID = ri.RawAID  => le.RawAID_weight100,
                        SALT20.Fn_Fail_Scale(le.RawAID_weight100,s.RawAID_switch));
  self.left_RawAID := le.RawAID;
  self.right_RawAID := ri.RawAID;
  self.Conf_Prop := (0
  ) / 100; // Score based on propogated fields
  self.Conf := (self.rcid_score + self.bdid_score + self.source_score + self.source_group_score + self.pflag_score + self.group1_id_score + self.vendor_id_score + self.dt_first_seen_score + self.dt_last_seen_score + self.dt_vendor_first_reported_score + self.dt_vendor_last_reported_score + self.company_name_score + self.prim_range_score + self.predir_score + self.prim_name_score + self.addr_suffix_score + self.postdir_score + self.unit_desig_score + self.sec_range_score + self.city_score + self.state_score + self.zip_score + self.zip4_score + self.county_score + self.msa_score + self.geo_lat_score + self.geo_long_score + self.phone_score + self.phone_score_score + self.fein_score + self.current_score + self.dppa_score + self.vl_id_score + self.RawAID_score) / 100 + outside;
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
export AnnotateClusterMatches(dataset(match_candidates(ih).layout_candidates) in_data,SALT20.UIDType BaseRecord) := function//Faster form when  known
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
  SALT20.UIDType ;
  dataset(SALT20.Layout_FieldValueList) rcid_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) bdid_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) source_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) source_group_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) pflag_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) group1_id_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) vendor_id_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) dt_first_seen_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) dt_last_seen_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) dt_vendor_first_reported_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) dt_vendor_last_reported_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) company_name_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) prim_range_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) predir_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) prim_name_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) addr_suffix_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) postdir_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) unit_desig_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) sec_range_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) city_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) state_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) zip_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) zip4_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) county_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) msa_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) geo_lat_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) geo_long_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) phone_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) phone_score_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) fein_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) current_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) dppa_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) vl_id_Values := dataset([],SALT20.Layout_FieldValueList);
  dataset(SALT20.Layout_FieldValueList) RawAID_Values := dataset([],SALT20.Layout_FieldValueList);
end;
shared RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := transform
  self. := le.;
  self.rcid_values := SALT20.fn_combine_fieldvaluelist(le.rcid_values,ri.rcid_values);
  self.bdid_values := SALT20.fn_combine_fieldvaluelist(le.bdid_values,ri.bdid_values);
  self.source_values := SALT20.fn_combine_fieldvaluelist(le.source_values,ri.source_values);
  self.source_group_values := SALT20.fn_combine_fieldvaluelist(le.source_group_values,ri.source_group_values);
  self.pflag_values := SALT20.fn_combine_fieldvaluelist(le.pflag_values,ri.pflag_values);
  self.group1_id_values := SALT20.fn_combine_fieldvaluelist(le.group1_id_values,ri.group1_id_values);
  self.vendor_id_values := SALT20.fn_combine_fieldvaluelist(le.vendor_id_values,ri.vendor_id_values);
  self.dt_first_seen_values := SALT20.fn_combine_fieldvaluelist(le.dt_first_seen_values,ri.dt_first_seen_values);
  self.dt_last_seen_values := SALT20.fn_combine_fieldvaluelist(le.dt_last_seen_values,ri.dt_last_seen_values);
  self.dt_vendor_first_reported_values := SALT20.fn_combine_fieldvaluelist(le.dt_vendor_first_reported_values,ri.dt_vendor_first_reported_values);
  self.dt_vendor_last_reported_values := SALT20.fn_combine_fieldvaluelist(le.dt_vendor_last_reported_values,ri.dt_vendor_last_reported_values);
  self.company_name_values := SALT20.fn_combine_fieldvaluelist(le.company_name_values,ri.company_name_values);
  self.prim_range_values := SALT20.fn_combine_fieldvaluelist(le.prim_range_values,ri.prim_range_values);
  self.predir_values := SALT20.fn_combine_fieldvaluelist(le.predir_values,ri.predir_values);
  self.prim_name_values := SALT20.fn_combine_fieldvaluelist(le.prim_name_values,ri.prim_name_values);
  self.addr_suffix_values := SALT20.fn_combine_fieldvaluelist(le.addr_suffix_values,ri.addr_suffix_values);
  self.postdir_values := SALT20.fn_combine_fieldvaluelist(le.postdir_values,ri.postdir_values);
  self.unit_desig_values := SALT20.fn_combine_fieldvaluelist(le.unit_desig_values,ri.unit_desig_values);
  self.sec_range_values := SALT20.fn_combine_fieldvaluelist(le.sec_range_values,ri.sec_range_values);
  self.city_values := SALT20.fn_combine_fieldvaluelist(le.city_values,ri.city_values);
  self.state_values := SALT20.fn_combine_fieldvaluelist(le.state_values,ri.state_values);
  self.zip_values := SALT20.fn_combine_fieldvaluelist(le.zip_values,ri.zip_values);
  self.zip4_values := SALT20.fn_combine_fieldvaluelist(le.zip4_values,ri.zip4_values);
  self.county_values := SALT20.fn_combine_fieldvaluelist(le.county_values,ri.county_values);
  self.msa_values := SALT20.fn_combine_fieldvaluelist(le.msa_values,ri.msa_values);
  self.geo_lat_values := SALT20.fn_combine_fieldvaluelist(le.geo_lat_values,ri.geo_lat_values);
  self.geo_long_values := SALT20.fn_combine_fieldvaluelist(le.geo_long_values,ri.geo_long_values);
  self.phone_values := SALT20.fn_combine_fieldvaluelist(le.phone_values,ri.phone_values);
  self.phone_score_values := SALT20.fn_combine_fieldvaluelist(le.phone_score_values,ri.phone_score_values);
  self.fein_values := SALT20.fn_combine_fieldvaluelist(le.fein_values,ri.fein_values);
  self.current_values := SALT20.fn_combine_fieldvaluelist(le.current_values,ri.current_values);
  self.dppa_values := SALT20.fn_combine_fieldvaluelist(le.dppa_values,ri.dppa_values);
  self.vl_id_values := SALT20.fn_combine_fieldvaluelist(le.vl_id_values,ri.vl_id_values);
  self.RawAID_values := SALT20.fn_combine_fieldvaluelist(le.RawAID_values,ri.RawAID_values);
end;
  return rollup( sort( distribute( infile, hash() ), , local ), left. = right., RollValues(left,right),local);
end;
export RolledEntities(dataset(match_candidates(ih).layout_candidates) in_data) := function
Layout_RolledEntity into(in_data le) := transform
  self. := le.;
  self.rcid_Values := IF ( le.rcid  IN SET(s.nulls_rcid,rcid),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.rcid)}],SALT20.Layout_FieldValueList));
  self.bdid_Values := IF ( le.bdid  IN SET(s.nulls_bdid,bdid),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.bdid)}],SALT20.Layout_FieldValueList));
  self.source_Values := IF ( le.source  IN SET(s.nulls_source,source),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.source)}],SALT20.Layout_FieldValueList));
  self.source_group_Values := IF ( le.source_group  IN SET(s.nulls_source_group,source_group),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.source_group)}],SALT20.Layout_FieldValueList));
  self.pflag_Values := IF ( le.pflag  IN SET(s.nulls_pflag,pflag),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.pflag)}],SALT20.Layout_FieldValueList));
  self.group1_id_Values := IF ( le.group1_id  IN SET(s.nulls_group1_id,group1_id),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.group1_id)}],SALT20.Layout_FieldValueList));
  self.vendor_id_Values := IF ( le.vendor_id  IN SET(s.nulls_vendor_id,vendor_id),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.vendor_id)}],SALT20.Layout_FieldValueList));
  self.dt_first_seen_Values := IF ( le.dt_first_seen  IN SET(s.nulls_dt_first_seen,dt_first_seen),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.dt_first_seen)}],SALT20.Layout_FieldValueList));
  self.dt_last_seen_Values := IF ( le.dt_last_seen  IN SET(s.nulls_dt_last_seen,dt_last_seen),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.dt_last_seen)}],SALT20.Layout_FieldValueList));
  self.dt_vendor_first_reported_Values := IF ( le.dt_vendor_first_reported  IN SET(s.nulls_dt_vendor_first_reported,dt_vendor_first_reported),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.dt_vendor_first_reported)}],SALT20.Layout_FieldValueList));
  self.dt_vendor_last_reported_Values := IF ( le.dt_vendor_last_reported  IN SET(s.nulls_dt_vendor_last_reported,dt_vendor_last_reported),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.dt_vendor_last_reported)}],SALT20.Layout_FieldValueList));
  self.company_name_Values := IF ( le.company_name  IN SET(s.nulls_company_name,company_name),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.company_name)}],SALT20.Layout_FieldValueList));
  self.prim_range_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.prim_range)}],SALT20.Layout_FieldValueList));
  self.predir_Values := IF ( le.predir  IN SET(s.nulls_predir,predir),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.predir)}],SALT20.Layout_FieldValueList));
  self.prim_name_Values := IF ( le.prim_name  IN SET(s.nulls_prim_name,prim_name),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.prim_name)}],SALT20.Layout_FieldValueList));
  self.addr_suffix_Values := IF ( le.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.addr_suffix)}],SALT20.Layout_FieldValueList));
  self.postdir_Values := IF ( le.postdir  IN SET(s.nulls_postdir,postdir),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.postdir)}],SALT20.Layout_FieldValueList));
  self.unit_desig_Values := IF ( le.unit_desig  IN SET(s.nulls_unit_desig,unit_desig),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.unit_desig)}],SALT20.Layout_FieldValueList));
  self.sec_range_Values := IF ( le.sec_range  IN SET(s.nulls_sec_range,sec_range),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.sec_range)}],SALT20.Layout_FieldValueList));
  self.city_Values := IF ( le.city  IN SET(s.nulls_city,city),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.city)}],SALT20.Layout_FieldValueList));
  self.state_Values := IF ( le.state  IN SET(s.nulls_state,state),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.state)}],SALT20.Layout_FieldValueList));
  self.zip_Values := IF ( le.zip  IN SET(s.nulls_zip,zip),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.zip)}],SALT20.Layout_FieldValueList));
  self.zip4_Values := IF ( le.zip4  IN SET(s.nulls_zip4,zip4),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.zip4)}],SALT20.Layout_FieldValueList));
  self.county_Values := IF ( le.county  IN SET(s.nulls_county,county),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.county)}],SALT20.Layout_FieldValueList));
  self.msa_Values := IF ( le.msa  IN SET(s.nulls_msa,msa),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.msa)}],SALT20.Layout_FieldValueList));
  self.geo_lat_Values := IF ( le.geo_lat  IN SET(s.nulls_geo_lat,geo_lat),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.geo_lat)}],SALT20.Layout_FieldValueList));
  self.geo_long_Values := IF ( le.geo_long  IN SET(s.nulls_geo_long,geo_long),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.geo_long)}],SALT20.Layout_FieldValueList));
  self.phone_Values := IF ( le.phone  IN SET(s.nulls_phone,phone),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.phone)}],SALT20.Layout_FieldValueList));
  self.phone_score_Values := IF ( le.phone_score  IN SET(s.nulls_phone_score,phone_score),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.phone_score)}],SALT20.Layout_FieldValueList));
  self.fein_Values := IF ( le.fein  IN SET(s.nulls_fein,fein),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.fein)}],SALT20.Layout_FieldValueList));
  self.current_Values := IF ( le.current  IN SET(s.nulls_current,current),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.current)}],SALT20.Layout_FieldValueList));
  self.dppa_Values := IF ( le.dppa  IN SET(s.nulls_dppa,dppa),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.dppa)}],SALT20.Layout_FieldValueList));
  self.vl_id_Values := IF ( le.vl_id  IN SET(s.nulls_vl_id,vl_id),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.vl_id)}],SALT20.Layout_FieldValueList));
  self.RawAID_Values := IF ( le.RawAID  IN SET(s.nulls_RawAID,RawAID),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.RawAID)}],SALT20.Layout_FieldValueList));
end;
AsFieldValues := project(in_data,into(left));
  return RollEntities(AsFieldValues);
end;
Layout_RolledEntity into(ih le) := transform
  self. := le.;
  self.rcid_Values := IF ( le.rcid  IN SET(s.nulls_rcid,rcid),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.rcid)}],SALT20.Layout_FieldValueList));
  self.bdid_Values := IF ( le.bdid  IN SET(s.nulls_bdid,bdid),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.bdid)}],SALT20.Layout_FieldValueList));
  self.source_Values := IF ( le.source  IN SET(s.nulls_source,source),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.source)}],SALT20.Layout_FieldValueList));
  self.source_group_Values := IF ( le.source_group  IN SET(s.nulls_source_group,source_group),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.source_group)}],SALT20.Layout_FieldValueList));
  self.pflag_Values := IF ( le.pflag  IN SET(s.nulls_pflag,pflag),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.pflag)}],SALT20.Layout_FieldValueList));
  self.group1_id_Values := IF ( le.group1_id  IN SET(s.nulls_group1_id,group1_id),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.group1_id)}],SALT20.Layout_FieldValueList));
  self.vendor_id_Values := IF ( le.vendor_id  IN SET(s.nulls_vendor_id,vendor_id),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.vendor_id)}],SALT20.Layout_FieldValueList));
  self.dt_first_seen_Values := IF ( le.dt_first_seen  IN SET(s.nulls_dt_first_seen,dt_first_seen),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.dt_first_seen)}],SALT20.Layout_FieldValueList));
  self.dt_last_seen_Values := IF ( le.dt_last_seen  IN SET(s.nulls_dt_last_seen,dt_last_seen),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.dt_last_seen)}],SALT20.Layout_FieldValueList));
  self.dt_vendor_first_reported_Values := IF ( le.dt_vendor_first_reported  IN SET(s.nulls_dt_vendor_first_reported,dt_vendor_first_reported),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.dt_vendor_first_reported)}],SALT20.Layout_FieldValueList));
  self.dt_vendor_last_reported_Values := IF ( le.dt_vendor_last_reported  IN SET(s.nulls_dt_vendor_last_reported,dt_vendor_last_reported),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.dt_vendor_last_reported)}],SALT20.Layout_FieldValueList));
  self.company_name_Values := IF ( le.company_name  IN SET(s.nulls_company_name,company_name),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.company_name)}],SALT20.Layout_FieldValueList));
  self.prim_range_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.prim_range)}],SALT20.Layout_FieldValueList));
  self.predir_Values := IF ( le.predir  IN SET(s.nulls_predir,predir),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.predir)}],SALT20.Layout_FieldValueList));
  self.prim_name_Values := IF ( le.prim_name  IN SET(s.nulls_prim_name,prim_name),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.prim_name)}],SALT20.Layout_FieldValueList));
  self.addr_suffix_Values := IF ( le.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.addr_suffix)}],SALT20.Layout_FieldValueList));
  self.postdir_Values := IF ( le.postdir  IN SET(s.nulls_postdir,postdir),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.postdir)}],SALT20.Layout_FieldValueList));
  self.unit_desig_Values := IF ( le.unit_desig  IN SET(s.nulls_unit_desig,unit_desig),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.unit_desig)}],SALT20.Layout_FieldValueList));
  self.sec_range_Values := IF ( le.sec_range  IN SET(s.nulls_sec_range,sec_range),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.sec_range)}],SALT20.Layout_FieldValueList));
  self.city_Values := IF ( le.city  IN SET(s.nulls_city,city),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.city)}],SALT20.Layout_FieldValueList));
  self.state_Values := IF ( le.state  IN SET(s.nulls_state,state),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.state)}],SALT20.Layout_FieldValueList));
  self.zip_Values := IF ( le.zip  IN SET(s.nulls_zip,zip),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.zip)}],SALT20.Layout_FieldValueList));
  self.zip4_Values := IF ( le.zip4  IN SET(s.nulls_zip4,zip4),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.zip4)}],SALT20.Layout_FieldValueList));
  self.county_Values := IF ( le.county  IN SET(s.nulls_county,county),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.county)}],SALT20.Layout_FieldValueList));
  self.msa_Values := IF ( le.msa  IN SET(s.nulls_msa,msa),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.msa)}],SALT20.Layout_FieldValueList));
  self.geo_lat_Values := IF ( le.geo_lat  IN SET(s.nulls_geo_lat,geo_lat),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.geo_lat)}],SALT20.Layout_FieldValueList));
  self.geo_long_Values := IF ( le.geo_long  IN SET(s.nulls_geo_long,geo_long),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.geo_long)}],SALT20.Layout_FieldValueList));
  self.phone_Values := IF ( le.phone  IN SET(s.nulls_phone,phone),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.phone)}],SALT20.Layout_FieldValueList));
  self.phone_score_Values := IF ( le.phone_score  IN SET(s.nulls_phone_score,phone_score),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.phone_score)}],SALT20.Layout_FieldValueList));
  self.fein_Values := IF ( le.fein  IN SET(s.nulls_fein,fein),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.fein)}],SALT20.Layout_FieldValueList));
  self.current_Values := IF ( le.current  IN SET(s.nulls_current,current),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.current)}],SALT20.Layout_FieldValueList));
  self.dppa_Values := IF ( le.dppa  IN SET(s.nulls_dppa,dppa),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.dppa)}],SALT20.Layout_FieldValueList));
  self.vl_id_Values := IF ( le.vl_id  IN SET(s.nulls_vl_id,vl_id),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.vl_id)}],SALT20.Layout_FieldValueList));
  self.RawAID_Values := IF ( le.RawAID  IN SET(s.nulls_RawAID,RawAID),dataset([],SALT20.Layout_FieldValueList),dataset([{trim((string)le.RawAID)}],SALT20.Layout_FieldValueList));
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
  unsigned1 rcid_size := 0;
  unsigned1 bdid_size := 0;
  unsigned1 source_size := 0;
  unsigned1 source_group_size := 0;
  unsigned1 pflag_size := 0;
  unsigned1 group1_id_size := 0;
  unsigned1 vendor_id_size := 0;
  unsigned1 dt_first_seen_size := 0;
  unsigned1 dt_last_seen_size := 0;
  unsigned1 dt_vendor_first_reported_size := 0;
  unsigned1 dt_vendor_last_reported_size := 0;
  unsigned1 company_name_size := 0;
  unsigned1 prim_range_size := 0;
  unsigned1 predir_size := 0;
  unsigned1 prim_name_size := 0;
  unsigned1 addr_suffix_size := 0;
  unsigned1 postdir_size := 0;
  unsigned1 unit_desig_size := 0;
  unsigned1 sec_range_size := 0;
  unsigned1 city_size := 0;
  unsigned1 state_size := 0;
  unsigned1 zip_size := 0;
  unsigned1 zip4_size := 0;
  unsigned1 county_size := 0;
  unsigned1 msa_size := 0;
  unsigned1 geo_lat_size := 0;
  unsigned1 geo_long_size := 0;
  unsigned1 phone_size := 0;
  unsigned1 phone_score_size := 0;
  unsigned1 fein_size := 0;
  unsigned1 current_size := 0;
  unsigned1 dppa_size := 0;
  unsigned1 vl_id_size := 0;
  unsigned1 RawAID_size := 0;
end;
t0 := table(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := transform
  SELF.rcid_size := SALT20.Fn_SwitchSpec(s.rcid_switch,count(le.rcid_values));
  SELF.bdid_size := SALT20.Fn_SwitchSpec(s.bdid_switch,count(le.bdid_values));
  SELF.source_size := SALT20.Fn_SwitchSpec(s.source_switch,count(le.source_values));
  SELF.source_group_size := SALT20.Fn_SwitchSpec(s.source_group_switch,count(le.source_group_values));
  SELF.pflag_size := SALT20.Fn_SwitchSpec(s.pflag_switch,count(le.pflag_values));
  SELF.group1_id_size := SALT20.Fn_SwitchSpec(s.group1_id_switch,count(le.group1_id_values));
  SELF.vendor_id_size := SALT20.Fn_SwitchSpec(s.vendor_id_switch,count(le.vendor_id_values));
  SELF.dt_first_seen_size := SALT20.Fn_SwitchSpec(s.dt_first_seen_switch,count(le.dt_first_seen_values));
  SELF.dt_last_seen_size := SALT20.Fn_SwitchSpec(s.dt_last_seen_switch,count(le.dt_last_seen_values));
  SELF.dt_vendor_first_reported_size := SALT20.Fn_SwitchSpec(s.dt_vendor_first_reported_switch,count(le.dt_vendor_first_reported_values));
  SELF.dt_vendor_last_reported_size := SALT20.Fn_SwitchSpec(s.dt_vendor_last_reported_switch,count(le.dt_vendor_last_reported_values));
  SELF.company_name_size := SALT20.Fn_SwitchSpec(s.company_name_switch,count(le.company_name_values));
  SELF.prim_range_size := SALT20.Fn_SwitchSpec(s.prim_range_switch,count(le.prim_range_values));
  SELF.predir_size := SALT20.Fn_SwitchSpec(s.predir_switch,count(le.predir_values));
  SELF.prim_name_size := SALT20.Fn_SwitchSpec(s.prim_name_switch,count(le.prim_name_values));
  SELF.addr_suffix_size := SALT20.Fn_SwitchSpec(s.addr_suffix_switch,count(le.addr_suffix_values));
  SELF.postdir_size := SALT20.Fn_SwitchSpec(s.postdir_switch,count(le.postdir_values));
  SELF.unit_desig_size := SALT20.Fn_SwitchSpec(s.unit_desig_switch,count(le.unit_desig_values));
  SELF.sec_range_size := SALT20.Fn_SwitchSpec(s.sec_range_switch,count(le.sec_range_values));
  SELF.city_size := SALT20.Fn_SwitchSpec(s.city_switch,count(le.city_values));
  SELF.state_size := SALT20.Fn_SwitchSpec(s.state_switch,count(le.state_values));
  SELF.zip_size := SALT20.Fn_SwitchSpec(s.zip_switch,count(le.zip_values));
  SELF.zip4_size := SALT20.Fn_SwitchSpec(s.zip4_switch,count(le.zip4_values));
  SELF.county_size := SALT20.Fn_SwitchSpec(s.county_switch,count(le.county_values));
  SELF.msa_size := SALT20.Fn_SwitchSpec(s.msa_switch,count(le.msa_values));
  SELF.geo_lat_size := SALT20.Fn_SwitchSpec(s.geo_lat_switch,count(le.geo_lat_values));
  SELF.geo_long_size := SALT20.Fn_SwitchSpec(s.geo_long_switch,count(le.geo_long_values));
  SELF.phone_size := SALT20.Fn_SwitchSpec(s.phone_switch,count(le.phone_values));
  SELF.phone_score_size := SALT20.Fn_SwitchSpec(s.phone_score_switch,count(le.phone_score_values));
  SELF.fein_size := SALT20.Fn_SwitchSpec(s.fein_switch,count(le.fein_values));
  SELF.current_size := SALT20.Fn_SwitchSpec(s.current_switch,count(le.current_values));
  SELF.dppa_size := SALT20.Fn_SwitchSpec(s.dppa_switch,count(le.dppa_values));
  SELF.vl_id_size := SALT20.Fn_SwitchSpec(s.vl_id_switch,count(le.vl_id_values));
  SELF.RawAID_size := SALT20.Fn_SwitchSpec(s.RawAID_switch,count(le.RawAID_values));
  SELF := le;
end;  t := project(t0,NoteSize(left));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  unsigned2 Size := t.rcid_size+t.bdid_size+t.source_size+t.source_group_size+t.pflag_size+t.group1_id_size+t.vendor_id_size+t.dt_first_seen_size+t.dt_last_seen_size+t.dt_vendor_first_reported_size+t.dt_vendor_last_reported_size+t.company_name_size+t.prim_range_size+t.predir_size+t.prim_name_size+t.addr_suffix_size+t.postdir_size+t.unit_desig_size+t.sec_range_size+t.city_size+t.state_size+t.zip_size+t.zip4_size+t.county_size+t.msa_size+t.geo_lat_size+t.geo_long_size+t.phone_size+t.phone_score_size+t.fein_size+t.current_size+t.dppa_size+t.vl_id_size+t.RawAID_size;
end;
export Chubbies := table(t,Layout_Chubbies);
end;
