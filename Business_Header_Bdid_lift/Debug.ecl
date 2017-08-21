// Various routines to assist in debugging
import ut, salt24;
export Debug(dataset(layout_file_business_header) ih, Layout_Specificities.R s, MatchThreshold = 50) := module
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
shared h := match_candidates(ih).candidates;
shared LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
export Layout_Sample_Matches := record,maxlength(32000)
  integer2 Conf;
  integer2 Conf_Prop;
  integer2 DateOverlap := 0;
  unsigned6 BDID1;
  unsigned6 BDID2;
  unsigned6 RCID1;
  unsigned6 RCID2;
  typeof(h.zip) left_zip;
  integer2 zip_score;
  typeof(h.zip) right_zip;
  typeof(h.prim_name) left_prim_name;
  integer2 prim_name_score;
  typeof(h.prim_name) right_prim_name;
  typeof(h.state) left_state;
  integer2 state_score;
  typeof(h.state) right_state;
  typeof(h.fein) left_fein;
  integer2 fein_score;
  typeof(h.fein) right_fein;
  typeof(h.vendor_id) left_vendor_id;
  integer2 vendor_id_score;
  typeof(h.vendor_id) right_vendor_id;
  typeof(h.phone) left_phone;
  integer2 phone_score;
  typeof(h.phone) right_phone;
  typeof(h.company_name) left_company_name;
  integer2 company_name_score;
  typeof(h.company_name) right_company_name;
  typeof(h.zip4) left_zip4;
  integer2 zip4_score;
  typeof(h.zip4) right_zip4;
  typeof(h.prim_range) left_prim_range;
  integer2 prim_range_score;
  typeof(h.prim_range) right_prim_range;
  typeof(h.CITY) left_CITY;
  integer2 CITY_score;
  typeof(h.CITY) right_CITY;
  typeof(h.sec_range) left_sec_range;
  integer2 sec_range_score;
  typeof(h.sec_range) right_sec_range;
  typeof(h.msa) left_msa;
  integer2 msa_score;
  typeof(h.msa) right_msa;
  typeof(h.county) left_county;
  integer2 county_score;
  typeof(h.county) right_county;
  typeof(h.SOURCE) left_SOURCE;
  integer2 SOURCE_score;
  typeof(h.SOURCE) right_SOURCE;
  typeof(h.unit_desig) left_unit_desig;
  integer2 unit_desig_score;
  typeof(h.unit_desig) right_unit_desig;
  typeof(h.addr_suffix) left_addr_suffix;
  integer2 addr_suffix_score;
  typeof(h.addr_suffix) right_addr_suffix;
  typeof(h.locale) left_locale;
  integer2 locale_score;
  typeof(h.locale) right_locale;
  typeof(h.address) left_address;
  integer2 address_score;
  typeof(h.address) right_address;
end;
export layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,unsigned outside=0) := transform
  self.BDID1 := le.BDID;
  self.BDID2 := ri.BDID;
  self.RCID1 := le.RCID;
  self.RCID2 := ri.RCID;
  self.fein_score := MAP( le.fein  IN SET(s.nulls_fein,fein) or ri.fein  IN SET(s.nulls_fein,fein) => 0,
                        le.fein = ri.fein  => le.fein_weight100,
                        Fn_Fail_Scale(le.fein_weight100,s.fein_switch));
  self.left_fein := le.fein;
  self.right_fein := ri.fein;
  self.vendor_id_score := MAP( le.vendor_id  IN SET(s.nulls_vendor_id,vendor_id) or ri.vendor_id  IN SET(s.nulls_vendor_id,vendor_id) => 0,
                        le.SOURCE <> ri.SOURCE => 0, // Only valid if the context variable is equal
                        le.vendor_id = ri.vendor_id  => le.vendor_id_weight100,
                        Fn_Fail_Scale(le.vendor_id_weight100,s.vendor_id_switch));
  self.left_vendor_id := le.vendor_id;
  self.right_vendor_id := ri.vendor_id;
  self.phone_score := MAP( le.phone  IN SET(s.nulls_phone,phone) or ri.phone  IN SET(s.nulls_phone,phone) => 0,
                        le.phone = ri.phone  => le.phone_weight100,
                        Fn_Fail_Scale(le.phone_weight100,s.phone_switch));
  self.left_phone := le.phone;
  self.right_phone := ri.phone;
  integer2 company_name_score_temp := MAP( le.company_name  IN SET(s.nulls_company_name,company_name) or ri.company_name  IN SET(s.nulls_company_name,company_name) or le.company_name_weight100 = 0 => SKIP,
                        le.company_name = ri.company_name  => le.company_name_weight100,
                        salt24.fn_match_bagofwords(le.company_name,ri.company_name,2,0));
  self.company_name_score := IF ( company_name_score_temp >= 2000, company_name_score_temp, SKIP ); // Enforce FORCE parameter
  self.left_company_name := le.company_name;
  self.right_company_name := ri.company_name;
  self.county_score := MAP( le.county  IN SET(s.nulls_county,county) or ri.county  IN SET(s.nulls_county,county) => 0,
                        le.county = ri.county  => le.county_weight100,
                        Fn_Fail_Scale(le.county_weight100,s.county_switch));
  self.left_county := le.county;
  self.right_county := ri.county;
  self.SOURCE_score := MAP( le.SOURCE  IN SET(s.nulls_SOURCE,SOURCE) or ri.SOURCE  IN SET(s.nulls_SOURCE,SOURCE) => 0,
                        le.SOURCE = ri.SOURCE  => le.SOURCE_weight100,
                        Fn_Fail_Scale(le.SOURCE_weight100,s.SOURCE_switch));
  self.left_SOURCE := le.SOURCE;
  self.right_SOURCE := ri.SOURCE;
  integer2 locale_score_pre := MAP( le.locale  IN SET(s.nulls_locale,locale) or ri.locale  IN SET(s.nulls_locale,locale) => 0,
                        le.zip  IN SET(s.nulls_zip,zip) OR le.state  IN SET(s.nulls_state,state) OR le.CITY  IN SET(s.nulls_CITY,CITY) OR le.msa  IN SET(s.nulls_msa,msa) => 0, // No combined score if these fields are null
                        le.locale = ri.locale  => le.locale_weight100,
                        0);
  self.left_locale := le.locale;
  self.right_locale := ri.locale;
  integer2 address_score_pre := MAP( le.address  IN SET(s.nulls_address,address) or ri.address  IN SET(s.nulls_address,address) => 0,
                        le.prim_range  IN SET(s.nulls_prim_range,prim_range) OR le.prim_name  IN SET(s.nulls_prim_name,prim_name) => 0, // No combined score if these fields are null
                        le.address = ri.address  => le.address_weight100,
                        0);
  self.left_address := le.address;
  self.right_address := ri.address;
  self.zip_score := MAP( le.zip  IN SET(s.nulls_zip,zip) or ri.zip  IN SET(s.nulls_zip,zip) => SKIP,
                        locale_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SKIP);
  self.left_zip := le.zip;
  self.right_zip := ri.zip;
  self.prim_name_score := MAP( le.prim_name  IN SET(s.nulls_prim_name,prim_name) or ri.prim_name  IN SET(s.nulls_prim_name,prim_name) or le.prim_name_weight100 = 0 => SKIP,
                        address_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SKIP);
  self.left_prim_name := le.prim_name;
  self.right_prim_name := ri.prim_name;
  self.state_score := MAP( le.state  IN SET(s.nulls_state,state) or ri.state  IN SET(s.nulls_state,state) => SKIP,
                        locale_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.state = ri.state  => le.state_weight100,
                        SKIP);
  self.left_state := le.state;
  self.right_state := ri.state;
  self.zip4_score := MAP( le.zip4  IN SET(s.nulls_zip4,zip4) or ri.zip4  IN SET(s.nulls_zip4,zip4) => 0,
                        address_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.zip4 = ri.zip4  => le.zip4_weight100,
                        Fn_Fail_Scale(le.zip4_weight100,s.zip4_switch));
  self.left_zip4 := le.zip4;
  self.right_zip4 := ri.zip4;
  self.prim_range_score := MAP( le.prim_range  IN SET(s.nulls_prim_range,prim_range) or ri.prim_range  IN SET(s.nulls_prim_range,prim_range) or le.prim_range_weight100 = 0 => SKIP,
                        address_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        ut.stringsimilar(le.prim_range,ri.prim_range) <= 1 => fn_fuzzy_specificity(le.prim_range_weight100,le.prim_range_cnt, le.prim_range_e1_cnt,ri.prim_range_weight100,ri.prim_range_cnt,ri.prim_range_e1_cnt),
                        SKIP);
  self.left_prim_range := le.prim_range;
  self.right_prim_range := ri.prim_range;
  self.CITY_score := MAP( le.CITY  IN SET(s.nulls_CITY,CITY) or ri.CITY  IN SET(s.nulls_CITY,CITY) => 0,
                        locale_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.CITY = ri.CITY  => le.CITY_weight100,
                        Fn_Fail_Scale(le.CITY_weight100,s.CITY_switch));
  self.left_CITY := le.CITY;
  self.right_CITY := ri.CITY;
  self.sec_range_score := MAP( le.sec_range  IN SET(s.nulls_sec_range,sec_range) or ri.sec_range  IN SET(s.nulls_sec_range,sec_range) => 0,
                        address_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch));
  self.left_sec_range := le.sec_range;
  self.right_sec_range := ri.sec_range;
  self.msa_score := MAP( le.msa  IN SET(s.nulls_msa,msa) or ri.msa  IN SET(s.nulls_msa,msa) => 0,
                        locale_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.msa = ri.msa  => le.msa_weight100,
                        Fn_Fail_Scale(le.msa_weight100,s.msa_switch));
  self.left_msa := le.msa;
  self.right_msa := ri.msa;
  self.unit_desig_score := MAP( le.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) or ri.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) => 0,
                        address_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.unit_desig = ri.unit_desig  => le.unit_desig_weight100,
                        Fn_Fail_Scale(le.unit_desig_weight100,s.unit_desig_switch));
  self.left_unit_desig := le.unit_desig;
  self.right_unit_desig := ri.unit_desig;
  self.addr_suffix_score := MAP( le.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) or ri.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) => 0,
                        address_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.prim_name <> ri.prim_name => 0, // Only valid if the context variable is equal
                        le.addr_suffix = ri.addr_suffix  => le.addr_suffix_weight100,
                        Fn_Fail_Scale(le.addr_suffix_weight100,s.addr_suffix_switch));
  self.left_addr_suffix := le.addr_suffix;
  self.right_addr_suffix := ri.addr_suffix;
  self.locale_score := locale_score_pre;
  self.address_score := address_score_pre;
  self.Conf_Prop := (if(le.fein_prop or ri.fein_prop,self.fein_score,0) + if(le.phone_prop or ri.phone_prop,self.phone_score,0)) / 100; // Score based on propogated fields
  self.Conf := (self.zip_score + self.prim_name_score + self.state_score + self.fein_score + self.vendor_id_score + self.phone_score + self.company_name_score + self.zip4_score + self.prim_range_score + self.CITY_score + self.sec_range_score + self.msa_score + self.county_score + self.SOURCE_score + self.unit_desig_score + self.addr_suffix_score + self.locale_score + self.address_score) / 100 + outside;
end;
export AnnotateMatchesFromData(dataset(match_candidates(ih).layout_candidates) in_data,dataset(match_candidates(ih).layout_matches)  im) := function
  j1 := join(in_data,im,left.BDID = right.BDID1,hash);
  match_candidates(ih).layout_candidates strim(j1 le) := transform
    self := le;
  end;
  r := join(j1,in_data,left.BDID2 = right.BDID,sample_match_join( project(left,strim(left)),right),hash);
  d := dedup( sort( r, BDID1, BDID2, -Conf, local ), BDID1, BDID2, local ); // BDID2 distributed by join
  return d;
end;
export AnnotateMatchesFromRecordData(dataset(match_candidates(ih).layout_candidates) in_data,dataset(match_candidates(ih).layout_matches)  im) := function//Faster form when RCID known
  j1 := join(in_data,im,left.RCID = right.RCID1,hash);
  match_candidates(ih).layout_candidates strim(j1 le) := transform
    self := le;
  end;
  return join(j1,in_data,left.RCID2 = right.RCID,sample_match_join( project(left,strim(left)),right),hash);
end;
export AnnotateMatches(dataset(match_candidates(ih).layout_matches)  im) := function
  return AnnotateMatchesFromRecordData(h,im);
end;
shared Layout_FieldValueList := record,maxlength(2096)
  STRING Val;
end;
export Layout_RolledEntity := record,maxlength(63000)
  unsigned6 BDID;
  dataset(Layout_FieldValueList) fein_Values;
  dataset(Layout_FieldValueList) vendor_id_Values;
  dataset(Layout_FieldValueList) phone_Values;
  dataset(Layout_FieldValueList) company_name_Values;
  dataset(Layout_FieldValueList) county_Values;
  dataset(Layout_FieldValueList) SOURCE_Values;
  dataset(Layout_FieldValueList) locale_Values;
  dataset(Layout_FieldValueList) address_Values;
end;
export RolledEntities(dataset(match_candidates(ih).layout_candidates) in_data) := function
Layout_RolledEntity into(in_data le) := transform
  self.BDID := le.BDID;
  self.fein_Values := IF ( le.fein IN SET(s.nulls_fein,fein),dataset([],Layout_FieldValueList),dataset([{trim((string)le.fein)}],Layout_FieldValueList));
  self.vendor_id_Values := IF ( le.vendor_id IN SET(s.nulls_vendor_id,vendor_id),dataset([],Layout_FieldValueList),dataset([{trim((string)le.vendor_id)}],Layout_FieldValueList));
  self.phone_Values := IF ( le.phone IN SET(s.nulls_phone,phone),dataset([],Layout_FieldValueList),dataset([{trim((string)le.phone)}],Layout_FieldValueList));
  self.company_name_Values := IF ( le.company_name IN SET(s.nulls_company_name,company_name),dataset([],Layout_FieldValueList),dataset([{trim((string)le.company_name)}],Layout_FieldValueList));
  self.county_Values := IF ( le.county IN SET(s.nulls_county,county),dataset([],Layout_FieldValueList),dataset([{trim((string)le.county)}],Layout_FieldValueList));
  self.SOURCE_Values := IF ( le.SOURCE IN SET(s.nulls_SOURCE,SOURCE),dataset([],Layout_FieldValueList),dataset([{trim((string)le.SOURCE)}],Layout_FieldValueList));
  self.locale_Values := IF ( le.zip IN SET(s.nulls_zip,zip) AND le.state IN SET(s.nulls_state,state) AND le.CITY IN SET(s.nulls_CITY,CITY) AND le.msa IN SET(s.nulls_msa,msa),dataset([],Layout_FieldValueList),dataset([{trim((string)le.zip) + ' ' + trim((string)le.state) + ' ' + trim((string)le.CITY) + ' ' + trim((string)le.msa)}],Layout_FieldValueList));
  self.address_Values := IF ( le.prim_range IN SET(s.nulls_prim_range,prim_range) AND le.sec_range IN SET(s.nulls_sec_range,sec_range) AND le.prim_name IN SET(s.nulls_prim_name,prim_name) AND le.zip4 IN SET(s.nulls_zip4,zip4) AND le.unit_desig IN SET(s.nulls_unit_desig,unit_desig) AND le.addr_suffix IN SET(s.nulls_addr_suffix,addr_suffix),dataset([],Layout_FieldValueList),dataset([{trim((string)le.prim_range) + ' ' + trim((string)le.sec_range) + ' ' + trim((string)le.prim_name) + ' ' + trim((string)le.zip4) + ' ' + trim((string)le.unit_desig) + ' ' + trim((string)le.addr_suffix)}],Layout_FieldValueList));
end;
AsFieldValues := project(in_data,into(left));
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := transform
  self.BDID := le.BDID;
  self.fein_values := if ( count(le.fein_values)>=100 or exists(le.fein_values(Val=ri.fein_values[1].Val)), le.fein_values, le.fein_values+ri.fein_values);
  self.vendor_id_values := if ( count(le.vendor_id_values)>=100 or exists(le.vendor_id_values(Val=ri.vendor_id_values[1].Val)), le.vendor_id_values, le.vendor_id_values+ri.vendor_id_values);
  self.phone_values := if ( count(le.phone_values)>=100 or exists(le.phone_values(Val=ri.phone_values[1].Val)), le.phone_values, le.phone_values+ri.phone_values);
  self.company_name_values := if ( count(le.company_name_values)>=100 or exists(le.company_name_values(Val=ri.company_name_values[1].Val)), le.company_name_values, le.company_name_values+ri.company_name_values);
  self.county_values := if ( count(le.county_values)>=100 or exists(le.county_values(Val=ri.county_values[1].Val)), le.county_values, le.county_values+ri.county_values);
  self.SOURCE_values := if ( count(le.SOURCE_values)>=100 or exists(le.SOURCE_values(Val=ri.SOURCE_values[1].Val)), le.SOURCE_values, le.SOURCE_values+ri.SOURCE_values);
  self.locale_values := if ( count(le.locale_values)>=100 or exists(le.locale_values(Val=ri.locale_values[1].Val)), le.locale_values, le.locale_values+ri.locale_values);
  self.address_values := if ( count(le.address_values)>=100 or exists(le.address_values(Val=ri.address_values[1].Val)), le.address_values, le.address_values+ri.address_values);
end;
  return rollup( sort( distribute( AsFieldValues, BDID ), BDID, local ), left.BDID = right.BDID, RollValues(left,right),local);
end;
end;
