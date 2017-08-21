// Various routines to assist in debugging
IMPORT SALT27,ut;
EXPORT Debug(DATASET(layout_Base) ih, Layout_Specificities.R s, MatchThreshold = 41) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
EXPORT Layout_Sample_Matches := RECORD,MAXLENGTH(32000)
  INTEGER2 Conf;
  INTEGER2 Conf_Prop;
  INTEGER2 DateOverlap := 0;
  SALT27.UIDType Proxid1;
  SALT27.UIDType Proxid2;
  SALT27.UIDType rcid1;
  SALT27.UIDType rcid2;
  typeof(h.company_url) left_company_url;
  INTEGER2 company_url_score;
  typeof(h.company_url) right_company_url;
  typeof(h.company_name) left_company_name;
  INTEGER2 company_name_score;
  typeof(h.company_name) right_company_name;
  typeof(h.company_fein) left_company_fein;
  INTEGER2 company_fein_score;
  typeof(h.company_fein) right_company_fein;
  typeof(h.company_phone) left_company_phone;
  INTEGER2 company_phone_score;
  typeof(h.company_phone) right_company_phone;
  typeof(h.address) left_address;
  INTEGER2 address_score;
  typeof(h.address) right_address;
  typeof(h.prim_name) left_prim_name;
  INTEGER2 prim_name_score;
  typeof(h.prim_name) right_prim_name;
  typeof(h.zip) left_zip;
  INTEGER2 zip_score;
  typeof(h.zip) right_zip;
  typeof(h.prim_range) left_prim_range;
  INTEGER2 prim_range_score;
  typeof(h.prim_range) right_prim_range;
  typeof(h.zip4) left_zip4;
  INTEGER2 zip4_score;
  typeof(h.zip4) right_zip4;
  typeof(h.sec_range) left_sec_range;
  INTEGER2 sec_range_score;
  BOOLEAN sec_range_skipped := FALSE; // True if FORCE blocks match
  typeof(h.sec_range) right_sec_range;
  typeof(h.p_city_name) left_p_city_name;
  INTEGER2 p_city_name_score;
  typeof(h.p_city_name) right_p_city_name;
  typeof(h.v_city_name) left_v_city_name;
  INTEGER2 v_city_name_score;
  typeof(h.v_city_name) right_v_city_name;
  typeof(h.postdir) left_postdir;
  INTEGER2 postdir_score;
  typeof(h.postdir) right_postdir;
  typeof(h.fips_county) left_fips_county;
  INTEGER2 fips_county_score;
  typeof(h.fips_county) right_fips_county;
  typeof(h.predir) left_predir;
  INTEGER2 predir_score;
  typeof(h.predir) right_predir;
  typeof(h.unit_desig) left_unit_desig;
  INTEGER2 unit_desig_score;
  typeof(h.unit_desig) right_unit_desig;
  typeof(h.st) left_st;
  INTEGER2 st_score;
  typeof(h.st) right_st;
  typeof(h.fips_state) left_fips_state;
  INTEGER2 fips_state_score;
  typeof(h.fips_state) right_fips_state;
  typeof(h.addr_suffix) left_addr_suffix;
  INTEGER2 addr_suffix_score;
  typeof(h.addr_suffix) right_addr_suffix;
  typeof(h.dt_first_seen) left_dt_first_seen;
  typeof(h.dt_first_seen) right_dt_first_seen;
  typeof(h.dt_last_seen) left_dt_last_seen;
  typeof(h.dt_last_seen) right_dt_last_seen;
  typeof(h.source_for_votes) left_source_for_votes;
  typeof(h.source_for_votes) right_source_for_votes;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED outside=0) := TRANSFORM
  SELF.Proxid1 := le.Proxid;
  SELF.Proxid2 := ri.Proxid;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT27.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  SELF.left_company_url := le.company_url;
  SELF.right_company_url := ri.company_url;
  SELF.company_url_score := MAP( le.company_url_isnull OR ri.company_url_isnull => 0,
                        le.company_url = ri.company_url  => le.company_url_weight100,
                        SALT27.WithinEditN(le.company_url,ri.company_url,1) => SALT27.fn_fuzzy_specificity(le.company_url_weight100,le.company_url_cnt, le.company_url_e1_cnt,ri.company_url_weight100,ri.company_url_cnt,ri.company_url_e1_cnt),
                        SALT27.Fn_Fail_Scale(le.company_url_weight100,s.company_url_switch));
  SELF.left_company_name := le.company_name;
  SELF.right_company_name := ri.company_name;
  SELF.company_name_score := MAP( le.company_name_isnull OR ri.company_name_isnull => 0,
                        le.company_name = ri.company_name  => le.company_name_weight100,
                        SALT27.WithinEditN(le.company_name,ri.company_name,2) => SALT27.fn_fuzzy_specificity(le.company_name_weight100,le.company_name_cnt, le.company_name_e2_cnt,ri.company_name_weight100,ri.company_name_cnt,ri.company_name_e2_cnt),
                        SALT27.Fn_Fail_Scale(le.company_name_weight100,s.company_name_switch));
  SELF.left_company_fein := le.company_fein;
  SELF.right_company_fein := ri.company_fein;
  SELF.company_fein_score := MAP( le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT27.WithinEditN(le.company_fein,ri.company_fein,1) => SALT27.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_e1_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_e1_cnt),
                        le.company_fein_Right4 = ri.company_fein_Right4 => SALT27.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_Right4_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_Right4_cnt),
                        SALT27.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  SELF.left_company_phone := le.company_phone;
  SELF.right_company_phone := ri.company_phone;
  SELF.company_phone_score := MAP( le.company_phone_isnull OR ri.company_phone_isnull => 0,
                        le.company_phone = ri.company_phone  => le.company_phone_weight100,
                        SALT27.WithinEditN(le.company_phone,ri.company_phone,1) => SALT27.fn_fuzzy_specificity(le.company_phone_weight100,le.company_phone_cnt, le.company_phone_e1_cnt,ri.company_phone_weight100,ri.company_phone_cnt,ri.company_phone_e1_cnt),
                        SALT27.Fn_Fail_Scale(le.company_phone_weight100,s.company_phone_switch));
  REAL address_score_scale := ( le.address_weight100 + ri.address_weight100 ) / (le.prim_range_weight100 + ri.prim_range_weight100 + le.predir_weight100 + ri.predir_weight100 + le.prim_name_weight100 + ri.prim_name_weight100 + le.addr_suffix_weight100 + ri.addr_suffix_weight100 + le.postdir_weight100 + ri.postdir_weight100 + le.unit_desig_weight100 + ri.unit_desig_weight100 + le.sec_range_weight100 + ri.sec_range_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 address_score_pre := MAP( (le.address_isnull OR le.prim_range_isnull AND le.predir_isnull AND le.prim_name_isnull AND le.addr_suffix_isnull AND le.postdir_isnull AND le.unit_desig_isnull AND le.sec_range_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.address_isnull OR ri.prim_range_isnull AND ri.predir_isnull AND ri.prim_name_isnull AND ri.addr_suffix_isnull AND ri.postdir_isnull AND ri.unit_desig_isnull AND ri.sec_range_isnull AND ri.st_isnull AND ri.zip_isnull) => 0,
                        le.address = ri.address  => le.address_weight100,
                        0);
  SELF.left_address := le.address;
  SELF.right_address := ri.address;
  SELF.left_prim_name := le.prim_name;
  SELF.right_prim_name := ri.prim_name;
  SELF.prim_name_score := MAP( le.prim_name_isnull OR ri.prim_name_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT27.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch))* address_score_scale;
  SELF.left_zip := le.zip;
  SELF.right_zip := ri.zip;
  SELF.zip_score := MAP( le.zip_isnull OR ri.zip_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT27.Fn_Fail_Scale(le.zip_weight100,s.zip_switch))* address_score_scale;
  SELF.left_prim_range := le.prim_range;
  SELF.right_prim_range := ri.prim_range;
  SELF.prim_range_score := MAP( le.prim_range_isnull OR ri.prim_range_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT27.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch))* address_score_scale;
  SELF.left_zip4 := le.zip4;
  SELF.right_zip4 := ri.zip4;
  SELF.zip4_score := MAP( le.zip4_isnull OR ri.zip4_isnull => 0,
                        le.zip4 = ri.zip4  => le.zip4_weight100,
                        SALT27.Fn_Fail_Scale(le.zip4_weight100,s.zip4_switch));
  SELF.left_sec_range := le.sec_range;
  SELF.right_sec_range := ri.sec_range;
  INTEGER2 sec_range_score_temp := MAP( le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT27.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch))* address_score_scale;
  SELF.left_p_city_name := le.p_city_name;
  SELF.right_p_city_name := ri.p_city_name;
  SELF.p_city_name_score := MAP( le.p_city_name_isnull OR ri.p_city_name_isnull => 0,
                        le.p_city_name = ri.p_city_name  => le.p_city_name_weight100,
                        SALT27.Fn_Fail_Scale(le.p_city_name_weight100,s.p_city_name_switch));
  SELF.left_v_city_name := le.v_city_name;
  SELF.right_v_city_name := ri.v_city_name;
  SELF.v_city_name_score := MAP( le.v_city_name_isnull OR ri.v_city_name_isnull => 0,
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT27.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch));
  SELF.left_postdir := le.postdir;
  SELF.right_postdir := ri.postdir;
  SELF.postdir_score := MAP( le.postdir_isnull OR ri.postdir_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.postdir = ri.postdir  => le.postdir_weight100,
                        SALT27.Fn_Fail_Scale(le.postdir_weight100,s.postdir_switch))* address_score_scale;
  SELF.left_fips_county := le.fips_county;
  SELF.right_fips_county := ri.fips_county;
  SELF.fips_county_score := MAP( le.fips_county_isnull OR ri.fips_county_isnull => 0,
                        le.fips_county = ri.fips_county  => le.fips_county_weight100,
                        SALT27.Fn_Fail_Scale(le.fips_county_weight100,s.fips_county_switch));
  SELF.left_predir := le.predir;
  SELF.right_predir := ri.predir;
  SELF.predir_score := MAP( le.predir_isnull OR ri.predir_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.predir = ri.predir  => le.predir_weight100,
                        SALT27.Fn_Fail_Scale(le.predir_weight100,s.predir_switch))* address_score_scale;
  SELF.left_unit_desig := le.unit_desig;
  SELF.right_unit_desig := ri.unit_desig;
  SELF.unit_desig_score := MAP( le.unit_desig_isnull OR ri.unit_desig_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.unit_desig = ri.unit_desig  => le.unit_desig_weight100,
                        SALT27.Fn_Fail_Scale(le.unit_desig_weight100,s.unit_desig_switch))* address_score_scale;
  SELF.left_st := le.st;
  SELF.right_st := ri.st;
  SELF.st_score := MAP( le.st_isnull OR ri.st_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT27.Fn_Fail_Scale(le.st_weight100,s.st_switch))* address_score_scale;
  SELF.left_fips_state := le.fips_state;
  SELF.right_fips_state := ri.fips_state;
  SELF.fips_state_score := MAP( le.fips_state_isnull OR ri.fips_state_isnull => 0,
                        le.fips_state = ri.fips_state  => le.fips_state_weight100,
                        SALT27.Fn_Fail_Scale(le.fips_state_weight100,s.fips_state_switch));
  SELF.left_addr_suffix := le.addr_suffix;
  SELF.right_addr_suffix := ri.addr_suffix;
  SELF.addr_suffix_score := MAP( le.addr_suffix_isnull OR ri.addr_suffix_isnull => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.addr_suffix = ri.addr_suffix  => le.addr_suffix_weight100,
                        SALT27.Fn_Fail_Scale(le.addr_suffix_weight100,s.addr_suffix_switch))* address_score_scale;
  SELF.left_dt_first_seen := le.dt_first_seen;
  SELF.right_dt_first_seen := ri.dt_first_seen;
  SELF.left_dt_last_seen := le.dt_last_seen;
  SELF.right_dt_last_seen := ri.dt_last_seen;
  SELF.left_source_for_votes := le.source_for_votes;
  SELF.right_source_for_votes := ri.source_for_votes;
  SELF.sec_range_score := IF ( sec_range_score_temp >= 0, sec_range_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.sec_range_skipped := SELF.sec_range_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept address
  INTEGER2 address_score_ext := MAX(address_score_pre,0) + self.prim_range_score + self.predir_score + self.prim_name_score + self.addr_suffix_score + self.postdir_score + self.unit_desig_score + self.sec_range_score + self.st_score + self.zip_score;// Score in surrounding context
  INTEGER2 address_score_res := MAX(0,address_score_pre); // At least nothing
  SELF.address_score := address_score_res;
  SELF.Conf_Prop := (0
    +MAX(le.company_url_prop,ri.company_url_prop)*SELF.company_url_score // Score if either field propogated
    +MAX(le.company_name_prop,ri.company_name_prop)*SELF.company_name_score // Score if either field propogated
    +MAX(le.company_fein_prop,ri.company_fein_prop)*SELF.company_fein_score // Score if either field propogated
    +MAX(le.company_phone_prop,ri.company_phone_prop)*SELF.company_phone_score // Score if either field propogated
    +if(le.address_prop+ri.address_prop>0,self.address_score*(0)/9,0)
  ) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.company_url_score + SELF.company_name_score + SELF.company_fein_score + SELF.company_phone_score + SELF.address_score + SELF.prim_name_score + SELF.zip_score + SELF.prim_range_score + SELF.zip4_score + SELF.sec_range_score + SELF.p_city_name_score + SELF.v_city_name_score + SELF.postdir_score + SELF.fips_county_score + SELF.predir_score + SELF.unit_desig_score + SELF.st_score + SELF.fips_state_score + SELF.addr_suffix_score) / 100 + outside;
END;
EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION
  j1 := JOIN(in_data,im,LEFT.Proxid = RIGHT.Proxid1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  r := JOIN(j1,in_data,LEFT.Proxid2 = RIGHT.Proxid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
  d := DEDUP( SORT( r, Proxid1, Proxid2, -Conf, LOCAL ), Proxid1, Proxid2, LOCAL ); // Proxid2 distributed by join
  RETURN d;
END;
EXPORT AnnotateMatchesFromRecordData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION//Faster form when rcid known
  j1 := JOIN(in_data,im,LEFT.rcid = RIGHT.rcid1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(j1,in_data,LEFT.rcid2 = RIGHT.rcid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
END;
EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT27.UIDType BaseRecord) := FUNCTION//Faster form when rcid known
  j1 := in_data(rcid = BaseRecord);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(in_data(rcid<>BaseRecord),j1,TRUE,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),ALL);
END;
EXPORT AnnotateMatches(DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION
  RETURN AnnotateMatchesFromRecordData(h,im);
END;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT27.UIDType Proxid;
  DATASET(SALT27.Layout_FieldValueList) company_url_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) company_name_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) company_fein_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) company_phone_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) address_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) zip4_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) p_city_name_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) v_city_name_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) fips_county_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) fips_state_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) dt_first_seen_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) dt_last_seen_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) source_for_votes_Values := DATASET([],SALT27.Layout_FieldValueList);
END;
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.Proxid := le.Proxid;
  SELF.company_url_values := SALT27.fn_combine_fieldvaluelist(le.company_url_values,ri.company_url_values);
  SELF.company_name_values := SALT27.fn_combine_fieldvaluelist(le.company_name_values,ri.company_name_values);
  SELF.company_fein_values := SALT27.fn_combine_fieldvaluelist(le.company_fein_values,ri.company_fein_values);
  SELF.company_phone_values := SALT27.fn_combine_fieldvaluelist(le.company_phone_values,ri.company_phone_values);
  SELF.address_values := SALT27.fn_combine_fieldvaluelist(le.address_values,ri.address_values);
  SELF.zip4_values := SALT27.fn_combine_fieldvaluelist(le.zip4_values,ri.zip4_values);
  SELF.p_city_name_values := SALT27.fn_combine_fieldvaluelist(le.p_city_name_values,ri.p_city_name_values);
  SELF.v_city_name_values := SALT27.fn_combine_fieldvaluelist(le.v_city_name_values,ri.v_city_name_values);
  SELF.fips_county_values := SALT27.fn_combine_fieldvaluelist(le.fips_county_values,ri.fips_county_values);
  SELF.fips_state_values := SALT27.fn_combine_fieldvaluelist(le.fips_state_values,ri.fips_state_values);
  SELF.dt_first_seen_values := SALT27.fn_combine_fieldvaluelist(le.dt_first_seen_values,ri.dt_first_seen_values);
  SELF.dt_last_seen_values := SALT27.fn_combine_fieldvaluelist(le.dt_last_seen_values,ri.dt_last_seen_values);
  SELF.source_for_votes_values := SALT27.fn_combine_fieldvaluelist(le.source_for_votes_values,ri.source_for_votes_values);
END;
  RETURN ROLLUP( SORT( DISTRIBUTE( infile, HASH(Proxid) ), Proxid, LOCAL ), LEFT.Proxid = RIGHT.Proxid, RollValues(LEFT,RIGHT),LOCAL);
END;
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.Proxid := le.Proxid;
  SELF.company_url_Values := IF ( le.company_url  IN SET(s.nulls_company_url,company_url),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.company_url)}],SALT27.Layout_FieldValueList));
  SELF.company_name_Values := IF ( le.company_name  IN SET(s.nulls_company_name,company_name),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.company_name)}],SALT27.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( le.company_fein  IN SET(s.nulls_company_fein,company_fein),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.company_fein)}],SALT27.Layout_FieldValueList));
  SELF.company_phone_Values := IF ( le.company_phone  IN SET(s.nulls_company_phone,company_phone),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.company_phone)}],SALT27.Layout_FieldValueList));
  self.address_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range) AND le.predir  IN SET(s.nulls_predir,predir) AND le.prim_name  IN SET(s.nulls_prim_name,prim_name) AND le.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND le.postdir  IN SET(s.nulls_postdir,postdir) AND le.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND le.sec_range  IN SET(s.nulls_sec_range,sec_range) AND le.st  IN SET(s.nulls_st,st) AND le.zip  IN SET(s.nulls_zip,zip),dataset([],SALT27.Layout_FieldValueList),dataset([{TRIM((SALT27.StrType)le.prim_range) + ' ' + TRIM((SALT27.StrType)le.predir) + ' ' + TRIM((SALT27.StrType)le.prim_name) + ' ' + TRIM((SALT27.StrType)le.addr_suffix) + ' ' + TRIM((SALT27.StrType)le.postdir) + ' ' + TRIM((SALT27.StrType)le.unit_desig) + ' ' + TRIM((SALT27.StrType)le.sec_range) + ' ' + TRIM((SALT27.StrType)le.st) + ' ' + TRIM((SALT27.StrType)le.zip)}],SALT27.Layout_FieldValueList));
  SELF.zip4_Values := IF ( le.zip4  IN SET(s.nulls_zip4,zip4),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.zip4)}],SALT27.Layout_FieldValueList));
  SELF.p_city_name_Values := IF ( le.p_city_name  IN SET(s.nulls_p_city_name,p_city_name),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.p_city_name)}],SALT27.Layout_FieldValueList));
  SELF.v_city_name_Values := IF ( le.v_city_name  IN SET(s.nulls_v_city_name,v_city_name),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.v_city_name)}],SALT27.Layout_FieldValueList));
  SELF.fips_county_Values := IF ( le.fips_county  IN SET(s.nulls_fips_county,fips_county),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.fips_county)}],SALT27.Layout_FieldValueList));
  SELF.fips_state_Values := IF ( le.fips_state  IN SET(s.nulls_fips_state,fips_state),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.fips_state)}],SALT27.Layout_FieldValueList));
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT27.StrType)le.dt_first_seen)}],SALT27.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT27.StrType)le.dt_last_seen)}],SALT27.Layout_FieldValueList);
  SELF.source_for_votes_Values := DATASET([{TRIM((SALT27.StrType)le.source_for_votes)}],SALT27.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.Proxid := le.Proxid;
  SELF.company_url_Values := IF ( le.company_url  IN SET(s.nulls_company_url,company_url),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.company_url)}],SALT27.Layout_FieldValueList));
  SELF.company_name_Values := IF ( le.company_name  IN SET(s.nulls_company_name,company_name),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.company_name)}],SALT27.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( le.company_fein  IN SET(s.nulls_company_fein,company_fein),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.company_fein)}],SALT27.Layout_FieldValueList));
  SELF.company_phone_Values := IF ( le.company_phone  IN SET(s.nulls_company_phone,company_phone),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.company_phone)}],SALT27.Layout_FieldValueList));
  self.address_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range) AND le.predir  IN SET(s.nulls_predir,predir) AND le.prim_name  IN SET(s.nulls_prim_name,prim_name) AND le.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) AND le.postdir  IN SET(s.nulls_postdir,postdir) AND le.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) AND le.sec_range  IN SET(s.nulls_sec_range,sec_range) AND le.st  IN SET(s.nulls_st,st) AND le.zip  IN SET(s.nulls_zip,zip),dataset([],SALT27.Layout_FieldValueList),dataset([{TRIM((SALT27.StrType)le.prim_range) + ' ' + TRIM((SALT27.StrType)le.predir) + ' ' + TRIM((SALT27.StrType)le.prim_name) + ' ' + TRIM((SALT27.StrType)le.addr_suffix) + ' ' + TRIM((SALT27.StrType)le.postdir) + ' ' + TRIM((SALT27.StrType)le.unit_desig) + ' ' + TRIM((SALT27.StrType)le.sec_range) + ' ' + TRIM((SALT27.StrType)le.st) + ' ' + TRIM((SALT27.StrType)le.zip)}],SALT27.Layout_FieldValueList));
  SELF.zip4_Values := IF ( le.zip4  IN SET(s.nulls_zip4,zip4),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.zip4)}],SALT27.Layout_FieldValueList));
  SELF.p_city_name_Values := IF ( le.p_city_name  IN SET(s.nulls_p_city_name,p_city_name),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.p_city_name)}],SALT27.Layout_FieldValueList));
  SELF.v_city_name_Values := IF ( le.v_city_name  IN SET(s.nulls_v_city_name,v_city_name),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.v_city_name)}],SALT27.Layout_FieldValueList));
  SELF.fips_county_Values := IF ( le.fips_county  IN SET(s.nulls_fips_county,fips_county),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.fips_county)}],SALT27.Layout_FieldValueList));
  SELF.fips_state_Values := IF ( le.fips_state  IN SET(s.nulls_fips_state,fips_state),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.fips_state)}],SALT27.Layout_FieldValueList));
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT27.StrType)le.dt_first_seen)}],SALT27.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT27.StrType)le.dt_last_seen)}],SALT27.Layout_FieldValueList);
  SELF.source_for_votes_Values := DATASET([{TRIM((SALT27.StrType)le.source_for_votes)}],SALT27.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
  im rem(im le) := TRANSFORM
    self.company_url := if ( le.company_url_prop>0, (TYPEOF(le.company_url))'', le.company_url ); // Blank if propogated
    self.company_url_isnull := le.company_url_prop>0 OR le.company_url_isnull;
    self.company_url_prop := 0; // Avoid reducing score later
    self.company_name := if ( le.company_name_prop>0, (TYPEOF(le.company_name))'', le.company_name ); // Blank if propogated
    self.company_name_isnull := le.company_name_prop>0 OR le.company_name_isnull;
    self.company_name_prop := 0; // Avoid reducing score later
    self.company_fein := if ( le.company_fein_prop>0, (TYPEOF(le.company_fein))'', le.company_fein ); // Blank if propogated
    self.company_fein_isnull := le.company_fein_prop>0 OR le.company_fein_isnull;
    self.company_fein_prop := 0; // Avoid reducing score later
    self.company_phone := if ( le.company_phone_prop>0, (TYPEOF(le.company_phone))'', le.company_phone ); // Blank if propogated
    self.company_phone_isnull := le.company_phone_prop>0 OR le.company_phone_isnull;
    self.company_phone_prop := 0; // Avoid reducing score later
    self.address := if ( le.address_prop>0, 0, le.address ); // Blank if propogated
    self.address_isnull := true; // Flag as null to scoring
    self.address_prop := 0; // Avoid reducing score later
    SELF := le;
  END;
  RETURN PROJECT(im,rem(LEFT));
END;
// Now to compute the chubbies; those clusters which are really rather larger than one would expect
// this is presently defined in terms of number of field values * the improbability of that occuring by chance
// this could be used as poor mans dodgy-dids; but it does not allow for value planing (co-occurrence)
AllRolled := InFile_Rolled;
Layout_Chubbies0 := RECORD,MAXLENGTH(63000)
  AllRolled;
  UNSIGNED1 company_url_size := 0;
  UNSIGNED1 company_name_size := 0;
  UNSIGNED1 company_fein_size := 0;
  UNSIGNED1 company_phone_size := 0;
  UNSIGNED1 address_size := 0;
  UNSIGNED1 zip4_size := 0;
  UNSIGNED1 p_city_name_size := 0;
  UNSIGNED1 v_city_name_size := 0;
  UNSIGNED1 fips_county_size := 0;
  UNSIGNED1 fips_state_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.company_url_size := SALT27.Fn_SwitchSpec(s.company_url_switch,count(le.company_url_values));
  SELF.company_name_size := SALT27.Fn_SwitchSpec(s.company_name_switch,count(le.company_name_values));
  SELF.company_fein_size := SALT27.Fn_SwitchSpec(s.company_fein_switch,count(le.company_fein_values));
  SELF.company_phone_size := SALT27.Fn_SwitchSpec(s.company_phone_switch,count(le.company_phone_values));
  SELF.address_size := SALT27.Fn_SwitchSpec(s.address_switch,count(le.address_values));
  SELF.zip4_size := SALT27.Fn_SwitchSpec(s.zip4_switch,count(le.zip4_values));
  SELF.p_city_name_size := SALT27.Fn_SwitchSpec(s.p_city_name_switch,count(le.p_city_name_values));
  SELF.v_city_name_size := SALT27.Fn_SwitchSpec(s.v_city_name_switch,count(le.v_city_name_values));
  SELF.fips_county_size := SALT27.Fn_SwitchSpec(s.fips_county_switch,count(le.fips_county_values));
  SELF.fips_state_size := SALT27.Fn_SwitchSpec(s.fips_state_switch,count(le.fips_state_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.company_url_size+t.company_name_size+t.company_fein_size+t.company_phone_size+t.address_size+t.zip4_size+t.p_city_name_size+t.v_city_name_size+t.fips_county_size+t.fips_state_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;
