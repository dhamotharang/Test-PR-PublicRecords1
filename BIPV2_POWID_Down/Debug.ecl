// Various routines to assist in debugging
 
IMPORT SALT35,ut,std;
EXPORT Debug(DATASET(layout_POWID_Down) ih, Layout_Specificities.R s, MatchThreshold = Config.MatchThreshold) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
 
EXPORT Layout_Sample_Matches := RECORD(match_candidates(ih).Layout_Matches)
  TYPEOF(h.orgid) left_orgid;
  INTEGER1 orgid_match_code;
  INTEGER2 orgid_score;
  BOOLEAN orgid_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.orgid) right_orgid;
  TYPEOF(h.prim_range) left_prim_range;
  INTEGER1 prim_range_match_code;
  INTEGER2 prim_range_score;
  BOOLEAN prim_range_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.prim_range) right_prim_range;
  TYPEOF(h.prim_name) left_prim_name;
  INTEGER1 prim_name_match_code;
  INTEGER2 prim_name_score;
  BOOLEAN prim_name_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.prim_name) right_prim_name;
  TYPEOF(h.st) left_st;
  INTEGER1 st_match_code;
  INTEGER2 st_score;
  BOOLEAN st_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.st) right_st;
  TYPEOF(h.zip) left_zip;
  INTEGER1 zip_match_code;
  INTEGER2 zip_score;
  TYPEOF(h.zip) right_zip;
  TYPEOF(h.csz) left_csz;
  INTEGER1 csz_match_code;
  INTEGER2 csz_score;
  BOOLEAN csz_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.csz) right_csz;
  TYPEOF(h.v_city_name) left_v_city_name;
  INTEGER1 v_city_name_match_code;
  INTEGER2 v_city_name_score;
  TYPEOF(h.v_city_name) right_v_city_name;
  TYPEOF(h.company_name) left_company_name;
  TYPEOF(h.company_name) right_company_name;
  TYPEOF(h.addr1) left_addr1;
  INTEGER1 addr1_match_code;
  INTEGER2 addr1_score;
  TYPEOF(h.addr1) right_addr1;
  TYPEOF(h.address) left_address;
  INTEGER1 address_match_code;
  INTEGER2 address_score;
  BOOLEAN address_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.address) right_address;
  TYPEOF(h.dt_first_seen) left_dt_first_seen;
  TYPEOF(h.dt_first_seen) right_dt_first_seen;
  TYPEOF(h.dt_last_seen) left_dt_last_seen;
  TYPEOF(h.dt_last_seen) right_dt_last_seen;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.POWID1 := le.POWID;
  SELF.POWID2 := ri.POWID;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT35.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  SELF.left_orgid := le.orgid;
  SELF.right_orgid := ri.orgid;
  SELF.orgid_match_code := MAP(
                        le.orgid_isnull OR ri.orgid_isnull => SALT35.MatchCode.OneSideNull,
                        match_methods(ih).match_orgid(le.orgid,ri.orgid));
  INTEGER2 orgid_score_temp := MAP(
                        le.orgid = ri.orgid  => le.orgid_weight100,
                        SALT35.Fn_Fail_Scale(le.orgid_weight100,s.orgid_switch));
  SELF.left_company_name := le.company_name;
  SELF.right_company_name := ri.company_name;
  SELF.address_match_code := MAP(
                        (le.address_isnull OR (le.addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull) AND (le.csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull)) OR (ri.address_isnull OR (ri.addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull) AND (ri.csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull)) OR le.address_weight100 = 0 => SALT35.MatchCode.OneSideNull,
                        match_methods(ih).match_address(le.address,ri.address));
  REAL address_score_scale := ( le.address_weight100 + ri.address_weight100 ) / (le.addr1_weight100 + ri.addr1_weight100 + le.csz_weight100 + ri.csz_weight100); // Scaling factor for this concept
  INTEGER2 address_score_pre := MAP( (le.address_isnull OR (le.addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull) AND (le.csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull)) OR (ri.address_isnull OR (ri.addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull) AND (ri.csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull)) OR le.address_weight100 = 0 => 0,
                        le.address = ri.address  => le.address_weight100,
                        0);
  SELF.left_address := le.address;
  SELF.right_address := ri.address;
  SELF.left_dt_first_seen := le.dt_first_seen;
  SELF.right_dt_first_seen := ri.dt_first_seen;
  SELF.left_dt_last_seen := le.dt_last_seen;
  SELF.right_dt_last_seen := ri.dt_last_seen;
  SELF.orgid_score := IF ( le.orgid = ri.orgid, orgid_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.orgid_skipped := SELF.orgid_score < -5000;// Enforce FORCE parameter
  SELF.csz_match_code := MAP(
                        (le.csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull) OR le.csz_weight100 = 0 => SALT35.MatchCode.OneSideNull,
                        address_score_pre > 0 => SALT35.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_csz(le.csz,ri.csz));
  REAL csz_score_scale := ( le.csz_weight100 + ri.csz_weight100 ) / (le.v_city_name_weight100 + ri.v_city_name_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 csz_score_pre := MAP( (le.csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull) OR le.csz_weight100 = 0 => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.csz = ri.csz  => le.csz_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_csz := le.csz;
  SELF.right_csz := ri.csz;
  SELF.left_v_city_name := le.v_city_name;
  SELF.right_v_city_name := ri.v_city_name;
  SELF.v_city_name_match_code := MAP(
                        le.v_city_name_isnull OR ri.v_city_name_isnull => SALT35.MatchCode.OneSideNull,
                        csz_score_pre > 0 OR address_score_pre > 0 => SALT35.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        le.st_isnull OR ri.st_isnull OR le.st <> ri.st  => SALT35.MatchCode.ContextInvolved, // Only valid if the context variable is equal
                        match_methods(ih).match_v_city_name(le.v_city_name,ri.v_city_name));
  SELF.v_city_name_score := MAP(
                        le.v_city_name_isnull OR ri.v_city_name_isnull => 0,
                        csz_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st_isnull OR ri.st_isnull OR le.st <> ri.st  => 0, // Only valid if the context variable is equal
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT35.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch))*IF(csz_score_scale=0,1,csz_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.addr1_match_code := MAP(
                        (le.addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull) OR (ri.addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull) => SALT35.MatchCode.OneSideNull,
                        address_score_pre > 0 => SALT35.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_addr1(le.addr1,ri.addr1));
  REAL addr1_score_scale := ( le.addr1_weight100 + ri.addr1_weight100 ) / (le.prim_range_weight100 + ri.prim_range_weight100 + le.prim_name_weight100 + ri.prim_name_weight100); // Scaling factor for this concept
  INTEGER2 addr1_score_pre := MAP( (le.addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull) OR (ri.addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull) => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.addr1 = ri.addr1  => le.addr1_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_addr1 := le.addr1;
  SELF.right_addr1 := ri.addr1;
  SELF.left_prim_range := le.prim_range;
  SELF.right_prim_range := ri.prim_range;
  SELF.prim_range_match_code := MAP(
                        le.prim_range_isnull OR ri.prim_range_isnull => SALT35.MatchCode.OneSideNull,
                        addr1_score_pre > 0 OR address_score_pre > 0 => SALT35.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_prim_range(le.prim_range,ri.prim_range));
  INTEGER2 prim_range_score_temp := MAP(
                        addr1_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT35.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch))*IF(addr1_score_scale=0,1,addr1_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_prim_name := le.prim_name;
  SELF.right_prim_name := ri.prim_name;
  SELF.prim_name_match_code := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull => SALT35.MatchCode.OneSideNull,
                        addr1_score_pre > 0 OR address_score_pre > 0 => SALT35.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_prim_name(le.prim_name,ri.prim_name));
  INTEGER2 prim_name_score_temp := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull OR le.prim_name_weight100 = 0 => 0,
                        addr1_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT35.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch))*IF(addr1_score_scale=0,1,addr1_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_st := le.st;
  SELF.right_st := ri.st;
  SELF.st_match_code := MAP(
                        le.st_isnull OR ri.st_isnull => SALT35.MatchCode.OneSideNull,
                        csz_score_pre > 0 OR address_score_pre > 0 => SALT35.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_st(le.st,ri.st));
  INTEGER2 st_score_temp := MAP(
                        le.st_isnull OR ri.st_isnull OR le.st_weight100 = 0 => 0,
                        csz_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT35.Fn_Fail_Scale(le.st_weight100,s.st_switch))*IF(csz_score_scale=0,1,csz_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_zip := le.zip;
  SELF.right_zip := ri.zip;
  SELF.zip_match_code := MAP(
                        le.zip_isnull OR ri.zip_isnull => SALT35.MatchCode.OneSideNull,
                        csz_score_pre > 0 OR address_score_pre > 0 => SALT35.MatchCode.ParentInvolved, // Ancestor has found solution so child keeps quiet
                        match_methods(ih).match_zip(le.zip,ri.zip));
  SELF.zip_score := MAP(
                        le.zip_isnull OR ri.zip_isnull => 0,
                        csz_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT35.Fn_Fail_Scale(le.zip_weight100,s.zip_switch))*IF(csz_score_scale=0,1,csz_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.prim_range_score := IF ( le.prim_range = ri.prim_range OR addr1_score_pre > 0 OR address_score_pre > 0, prim_range_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_range_skipped := SELF.prim_range_score < -5000;// Enforce FORCE parameter
  SELF.prim_name_score := IF ( prim_name_score_temp > Config.prim_name_Force * 100 OR addr1_score_pre > 0 OR address_score_pre > 0, prim_name_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_name_skipped := SELF.prim_name_score < -5000;// Enforce FORCE parameter
  SELF.st_score := IF ( st_score_temp > Config.st_Force * 100 OR csz_score_pre > 0 OR address_score_pre > 0, st_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.st_skipped := SELF.st_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept csz
  INTEGER2 csz_score_ext := SALT35.ClipScore(MAX(csz_score_pre,0) + self.v_city_name_score + self.st_score + self.zip_score + MAX(address_score_pre,0));// Score in surrounding context
  INTEGER2 csz_score_res := MAX(0,csz_score_pre); // At least nothing
  SELF.csz_score := IF ( csz_score_ext > -200,csz_score_res,-9999);
  SELF.csz_skipped := SELF.csz_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept addr1
  INTEGER2 addr1_score_ext := SALT35.ClipScore(MAX(addr1_score_pre,0) + self.prim_range_score + self.prim_name_score + MAX(address_score_pre,0));// Score in surrounding context
  INTEGER2 addr1_score_res := MAX(0,addr1_score_pre); // At least nothing
  SELF.addr1_score := addr1_score_res;
// Compute the score for the concept address
  INTEGER2 address_score_ext := SALT35.ClipScore(MAX(address_score_pre,0)+ SELF.addr1_score + self.prim_range_score + self.prim_name_score+ SELF.csz_score + self.v_city_name_score + self.st_score + self.zip_score);// Score in surrounding context
  INTEGER2 address_score_res := MAX(0,address_score_pre); // At least nothing
  SELF.address_score := IF ( address_score_ext > 0,address_score_res,-9999);
  SELF.address_skipped := SELF.address_score < -5000;// Enforce FORCE parameter
  SELF.Conf_Prop := (0
    +MAX(le.prim_name_prop,ri.prim_name_prop)*SELF.prim_name_score // Score if either field propogated
    +if(le.addr1_prop+ri.addr1_prop>0,self.addr1_score*(0+if(le.prim_name_prop+ri.prim_name_prop>0,s.prim_name_specificity,0))/(+ s.prim_name_specificity),0)
    +if(le.address_prop+ri.address_prop>0,self.address_score*(0+if(le.addr1_prop+ri.addr1_prop>0,s.addr1_specificity,0))/( s.addr1_specificity),0)
  ) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.orgid_score + IF(SELF.address_score>0,MAX(SELF.address_score,IF(SELF.addr1_score>0,MAX(SELF.addr1_score,SELF.prim_range_score + SELF.prim_name_score),SELF.prim_range_score + SELF.prim_name_score) + IF(SELF.csz_score>0,MAX(SELF.csz_score,SELF.v_city_name_score + SELF.st_score + SELF.zip_score),SELF.v_city_name_score + SELF.st_score + SELF.zip_score)),IF(SELF.addr1_score>0,MAX(SELF.addr1_score,SELF.prim_range_score + SELF.prim_name_score),SELF.prim_range_score + SELF.prim_name_score) + IF(SELF.csz_score>0,MAX(SELF.csz_score,SELF.v_city_name_score + SELF.st_score + SELF.zip_score),SELF.v_city_name_score + SELF.st_score + SELF.zip_score))) / 100 + outside;
END;
 
EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION
  j1 := JOIN(in_data,im,LEFT.POWID = RIGHT.POWID1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  r := JOIN(j1,in_data,LEFT.POWID2 = RIGHT.POWID,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
  d := DEDUP( SORT( r, POWID1, POWID2, -Conf, LOCAL ), POWID1, POWID2, LOCAL ); // POWID2 distributed by join
  RETURN d;
END;
 
EXPORT AnnotateMatchesFromRecordData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION//Faster form when rcid known
  j1 := JOIN(in_data,im,LEFT.rcid = RIGHT.rcid1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(j1,in_data,LEFT.rcid2 = RIGHT.rcid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
END;
 
EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT35.UIDType BaseRecord) := FUNCTION//Faster form when rcid known
  j1 := in_data(rcid = BaseRecord);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(in_data(rcid<>BaseRecord),j1,TRUE,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),ALL);
END;
 
EXPORT AnnotateMatches(DATASET(match_candidates(ih).layout_matches) im) := FUNCTION
  am := AnnotateMatchesFromRecordData(h,im);
  am restoreRule(am le,im ri) := TRANSFORM
    SELF.rule := ri.rule;
    SELF := le;
  END;
  annotated_matches := JOIN(am,im,LEFT.rcid1=RIGHT.rcid1 AND LEFT.rcid2=RIGHT.rcid2,restoreRule(LEFT,RIGHT),HASH);
  RETURN annotated_matches;
END;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT35.UIDType POWID;
  DATASET(SALT35.Layout_FieldValueList) orgid_Values := DATASET([],SALT35.Layout_FieldValueList);
  DATASET(SALT35.Layout_FieldValueList) company_name_Values := DATASET([],SALT35.Layout_FieldValueList);
  DATASET(SALT35.Layout_FieldValueList) address_Values := DATASET([],SALT35.Layout_FieldValueList);
  DATASET(SALT35.Layout_FieldValueList) dt_first_seen_Values := DATASET([],SALT35.Layout_FieldValueList);
  DATASET(SALT35.Layout_FieldValueList) dt_last_seen_Values := DATASET([],SALT35.Layout_FieldValueList);
END;
 
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.POWID := le.POWID;
    SELF.orgid_values := SALT35.fn_combine_fieldvaluelist(le.orgid_values,ri.orgid_values);
    SELF.company_name_values := SALT35.fn_combine_fieldvaluelist(le.company_name_values,ri.company_name_values);
    SELF.address_values := SALT35.fn_combine_fieldvaluelist(le.address_values,ri.address_values);
    SELF.dt_first_seen_values := SALT35.fn_combine_fieldvaluelist(le.dt_first_seen_values,ri.dt_first_seen_values);
    SELF.dt_last_seen_values := SALT35.fn_combine_fieldvaluelist(le.dt_last_seen_values,ri.dt_last_seen_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH(POWID) ), POWID, LOCAL ), LEFT.POWID = RIGHT.POWID, RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF.POWID := le.POWID;
    SELF.orgid_values := SORT(le.orgid_values, -cnt, val, LOCAL);
    SELF.company_name_values := SORT(le.company_name_values, -cnt, val, LOCAL);
    SELF.address_values := SORT(le.address_values, -cnt, val, LOCAL);
    SELF.dt_first_seen_values := SORT(le.dt_first_seen_values, -cnt, val, LOCAL);
    SELF.dt_last_seen_values := SORT(le.dt_last_seen_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;
 
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.POWID := le.POWID;
  SELF.orgid_Values := IF ( (le.orgid  IN SET(s.nulls_orgid,orgid) OR le.orgid = (TYPEOF(le.orgid))''),DATASET([],SALT35.Layout_FieldValueList),DATASET([{TRIM((SALT35.StrType)le.orgid)}],SALT35.Layout_FieldValueList));
  SELF.company_name_Values := DATASET([{TRIM((SALT35.StrType)le.company_name)}],SALT35.Layout_FieldValueList);
  SELF.address_Values := IF ( (le.prim_range  IN SET(s.nulls_prim_range,prim_range) OR le.prim_range = (TYPEOF(le.prim_range))'') AND (le.prim_name  IN SET(s.nulls_prim_name,prim_name) OR le.prim_name = (TYPEOF(le.prim_name))'') AND (le.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR le.v_city_name = (TYPEOF(le.v_city_name))'') AND (le.st  IN SET(s.nulls_st,st) OR le.st = (TYPEOF(le.st))'') AND (le.zip  IN SET(s.nulls_zip,zip) OR le.zip = (TYPEOF(le.zip))''),DATASET([],SALT35.Layout_FieldValueList),DATASET([{TRIM((SALT35.StrType)le.prim_range) + ' ' + TRIM((SALT35.StrType)le.prim_name) + ' ' + TRIM((SALT35.StrType)le.v_city_name) + ' ' + TRIM((SALT35.StrType)le.st) + ' ' + TRIM((SALT35.StrType)le.zip)}],SALT35.Layout_FieldValueList));
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT35.StrType)le.dt_first_seen)}],SALT35.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT35.StrType)le.dt_last_seen)}],SALT35.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
 
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.POWID := le.POWID;
  SELF.orgid_Values := IF ( (le.orgid  IN SET(s.nulls_orgid,orgid) OR le.orgid = (TYPEOF(le.orgid))''),DATASET([],SALT35.Layout_FieldValueList),DATASET([{TRIM((SALT35.StrType)le.orgid)}],SALT35.Layout_FieldValueList));
  SELF.company_name_Values := DATASET([{TRIM((SALT35.StrType)le.company_name)}],SALT35.Layout_FieldValueList);
  SELF.address_Values := IF ( (le.prim_range  IN SET(s.nulls_prim_range,prim_range) OR le.prim_range = (TYPEOF(le.prim_range))'') AND (le.prim_name  IN SET(s.nulls_prim_name,prim_name) OR le.prim_name = (TYPEOF(le.prim_name))'') AND (le.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR le.v_city_name = (TYPEOF(le.v_city_name))'') AND (le.st  IN SET(s.nulls_st,st) OR le.st = (TYPEOF(le.st))'') AND (le.zip  IN SET(s.nulls_zip,zip) OR le.zip = (TYPEOF(le.zip))''),DATASET([],SALT35.Layout_FieldValueList),DATASET([{TRIM((SALT35.StrType)le.prim_range) + ' ' + TRIM((SALT35.StrType)le.prim_name) + ' ' + TRIM((SALT35.StrType)le.v_city_name) + ' ' + TRIM((SALT35.StrType)le.st) + ' ' + TRIM((SALT35.StrType)le.zip)}],SALT35.Layout_FieldValueList));
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT35.StrType)le.dt_first_seen)}],SALT35.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT35.StrType)le.dt_last_seen)}],SALT35.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
 
  im rem(im le) := TRANSFORM
    self.prim_name := if ( le.prim_name_prop>0, (TYPEOF(le.prim_name))'', le.prim_name ); // Blank if propogated
    self.prim_name_isnull := le.prim_name_prop>0 OR le.prim_name_isnull;
    self.prim_name_prop := 0; // Avoid reducing score later
    self.addr1 := if ( le.addr1_prop>0, 0, le.addr1 ); // Blank if propogated
    self.addr1_isnull := true; // Flag as null to scoring
    self.addr1_prop := 0; // Avoid reducing score later
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
  UNSIGNED1 orgid_size := 0;
  UNSIGNED1 address_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.orgid_size := SALT35.Fn_SwitchSpec(s.orgid_switch,count(le.orgid_values));
  SELF.address_size := SALT35.Fn_SwitchSpec(s.address_switch,count(le.address_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.orgid_size+t.address_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;
