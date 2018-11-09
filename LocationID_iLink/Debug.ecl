// Various routines to assist in debugging
 
IMPORT SALT37,std;
EXPORT Debug(DATASET(layout_LocationId) ih, Layout_Specificities.R s, MatchThreshold = Config.MatchThreshold) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
 
EXPORT Layout_Sample_Matches := RECORD(match_candidates(ih).Layout_Matches)
  TYPEOF(h.prim_range) left_prim_range;
  INTEGER1 prim_range_match_code;
  INTEGER2 prim_range_score;
  BOOLEAN prim_range_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.prim_range) right_prim_range;
  TYPEOF(h.v_city_name) left_v_city_name;
  INTEGER1 v_city_name_match_code;
  INTEGER2 v_city_name_score;
  BOOLEAN v_city_name_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.v_city_name) right_v_city_name;
  TYPEOF(h.st) left_st;
  INTEGER1 st_match_code;
  INTEGER2 st_score;
  BOOLEAN st_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.st) right_st;
  TYPEOF(h.zip5) left_zip5;
  INTEGER1 zip5_match_code;
  INTEGER2 zip5_score;
  BOOLEAN zip5_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.zip5) right_zip5;
  TYPEOF(h.cntprimname) left_cntprimname;
  INTEGER1 cntprimname_match_code;
  INTEGER2 cntprimname_score;
  BOOLEAN cntprimname_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.cntprimname) right_cntprimname;
  TYPEOF(h.sec_range) left_sec_range;
  INTEGER1 sec_range_match_code;
  INTEGER2 sec_range_score;
  BOOLEAN sec_range_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.sec_range) right_sec_range;
  TYPEOF(h.postdir) left_postdir;
  INTEGER1 postdir_match_code;
  INTEGER2 postdir_score;
  BOOLEAN postdir_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.postdir) right_postdir;
  TYPEOF(h.unit_desig) left_unit_desig;
  TYPEOF(h.unit_desig) right_unit_desig;
  TYPEOF(h.aid) left_aid;
  TYPEOF(h.aid) right_aid;
  TYPEOF(h.predir) left_predir;
  INTEGER1 predir_match_code;
  INTEGER2 predir_score;
  BOOLEAN predir_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.predir) right_predir;
  TYPEOF(h.prim_name) left_prim_name;
  INTEGER1 prim_name_match_code;
  INTEGER2 prim_name_score;
  TYPEOF(h.prim_name) right_prim_name;
  TYPEOF(h.rec_type) left_rec_type;
  TYPEOF(h.rec_type) right_rec_type;
  TYPEOF(h.err_stat) left_err_stat;
  INTEGER1 err_stat_match_code;
  INTEGER2 err_stat_score;
  BOOLEAN err_stat_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.err_stat) right_err_stat;
  TYPEOF(h.addr_suffix) left_addr_suffix;
  INTEGER1 addr_suffix_match_code;
  INTEGER2 addr_suffix_score;
  BOOLEAN addr_suffix_skipped := FALSE; // True if FORCE blocks match
  TYPEOF(h.addr_suffix) right_addr_suffix;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.LocId1 := le.LocId;
  SELF.LocId2 := ri.LocId;
  SELF.rid1 := le.rid;
  SELF.rid2 := ri.rid;
  SELF.left_prim_range := le.prim_range;
  SELF.right_prim_range := ri.prim_range;
  SELF.prim_range_match_code := MAP(
                        le.prim_range_isnull OR ri.prim_range_isnull => SALT37.MatchCode.OneSideNull,
                        match_methods(ih).match_prim_range(le.prim_range,ri.prim_range));
  INTEGER2 prim_range_score_temp := MAP(
                        le.prim_range_isnull OR ri.prim_range_isnull OR le.prim_range_weight100 = 0 => 0,
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT37.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch));
  SELF.left_v_city_name := le.v_city_name;
  SELF.right_v_city_name := ri.v_city_name;
  SELF.v_city_name_match_code := MAP(
                        le.v_city_name_isnull OR ri.v_city_name_isnull => SALT37.MatchCode.OneSideNull,
                        le.st_isnull OR ri.st_isnull OR le.st <> ri.st  => SALT37.MatchCode.ContextInvolved, // Only valid if the context variable is equal
                        match_methods(ih).match_v_city_name(le.v_city_name,ri.v_city_name));
  INTEGER2 v_city_name_score_temp := MAP(
                        le.v_city_name_isnull OR ri.v_city_name_isnull OR le.v_city_name_weight100 = 0 => 0,
                        le.st_isnull OR ri.st_isnull OR le.st <> ri.st  => 0, // Only valid if the context variable is equal
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT37.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch));
  SELF.left_st := le.st;
  SELF.right_st := ri.st;
  SELF.st_match_code := MAP(
                        le.st_isnull OR ri.st_isnull => SALT37.MatchCode.OneSideNull,
                        match_methods(ih).match_st(le.st,ri.st));
  INTEGER2 st_score_temp := MAP(
                        le.st_isnull OR ri.st_isnull OR le.st_weight100 = 0 => 0,
                        le.st = ri.st  => le.st_weight100,
                        SALT37.Fn_Fail_Scale(le.st_weight100,s.st_switch));
  SELF.left_zip5 := le.zip5;
  SELF.right_zip5 := ri.zip5;
  SELF.zip5_match_code := MAP(
                        le.zip5_isnull OR ri.zip5_isnull => SALT37.MatchCode.OneSideNull,
                        match_methods(ih).match_zip5(le.zip5,ri.zip5));
  INTEGER2 zip5_score_temp := MAP(
                        le.zip5_isnull OR ri.zip5_isnull OR le.zip5_weight100 = 0 => 0,
                        le.zip5 = ri.zip5  => le.zip5_weight100,
                        SALT37.Fn_Fail_Scale(le.zip5_weight100,s.zip5_switch));
  SELF.left_cntprimname := le.cntprimname;
  SELF.right_cntprimname := ri.cntprimname;
  SELF.cntprimname_match_code := MAP(
                        le.cntprimname_isnull OR ri.cntprimname_isnull => SALT37.MatchCode.OneSideNull,
                        match_methods(ih).match_cntprimname(le.cntprimname,ri.cntprimname));
  INTEGER2 cntprimname_score_temp := MAP(
                        le.cntprimname_isnull OR ri.cntprimname_isnull OR le.cntprimname_weight100 = 0 => 0,
                        le.cntprimname = ri.cntprimname  => le.cntprimname_weight100,
                        PrimNameCount((UNSIGNED8)le.cntprimname,ri.cntprimname) => SALT37.MOD_NonZero.AVENZ(le.cntprimname_weight100,ri.cntprimname_weight100),
                        SALT37.Fn_Fail_Scale(le.cntprimname_weight100,s.cntprimname_switch));
  SELF.left_sec_range := le.sec_range;
  SELF.right_sec_range := ri.sec_range;
  SELF.sec_range_match_code := MAP(
                        le.sec_range_isnull OR ri.sec_range_isnull => SALT37.MatchCode.OneSideNull,
                        match_methods(ih).match_sec_range(le.sec_range,ri.sec_range));
  INTEGER2 sec_range_score_temp := MAP(
                        le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        le.sec_range = ri.sec_range OR SALT37.HyphenMatch(le.sec_range,ri.sec_range,1)<=1  => MIN(le.sec_range_weight100,ri.sec_range_weight100),
                        SALT37.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch));
  SELF.left_postdir := le.postdir;
  SELF.right_postdir := ri.postdir;
  SELF.postdir_match_code := MAP(
                        le.postdir_isnull OR ri.postdir_isnull => SALT37.MatchCode.OneSideNull,
                        match_methods(ih).match_postdir(le.postdir,ri.postdir));
  INTEGER2 postdir_score_temp := MAP(
                        le.postdir_isnull OR ri.postdir_isnull => 0,
                        le.postdir = ri.postdir  => le.postdir_weight100,
                        SALT37.Fn_Fail_Scale(le.postdir_weight100,s.postdir_switch));
  SELF.left_unit_desig := le.unit_desig;
  SELF.right_unit_desig := ri.unit_desig;
  SELF.left_aid := le.aid;
  SELF.right_aid := ri.aid;
  SELF.left_predir := le.predir;
  SELF.right_predir := ri.predir;
  SELF.predir_match_code := MAP(
                        le.predir_isnull OR ri.predir_isnull => SALT37.MatchCode.OneSideNull,
                        match_methods(ih).match_predir(le.predir,ri.predir));
  INTEGER2 predir_score_temp := MAP(
                        le.predir_isnull OR ri.predir_isnull => 0,
                        le.predir = ri.predir  => le.predir_weight100,
                        SALT37.Fn_Fail_Scale(le.predir_weight100,s.predir_switch));
  SELF.left_prim_name := le.prim_name;
  SELF.right_prim_name := ri.prim_name;
  SELF.prim_name_match_code := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull => SALT37.MatchCode.OneSideNull,
                        match_methods(ih).match_prim_name(le.prim_name,ri.prim_name, le.prim_name_len, ri.prim_name_len));
  SELF.prim_name_score := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull => 0,
                        le.prim_name = ri.prim_name OR SALT37.HyphenMatch(le.prim_name,ri.prim_name,1)<=1  => MIN(le.prim_name_weight100,ri.prim_name_weight100),
                        Config.WithinEditN(le.prim_name,le.prim_name_len,ri.prim_name,ri.prim_name_len,1,0) =>  SALT37.fn_fuzzy_specificity(le.prim_name_weight100,le.prim_name_cnt, le.prim_name_e1_cnt,ri.prim_name_weight100,ri.prim_name_cnt,ri.prim_name_e1_cnt),
                        PrimNameMatch((STRING28)le.prim_name,ri.prim_name) => SALT37.MOD_NonZero.AVENZ(le.prim_name_weight100,ri.prim_name_weight100),
                        SALT37.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch));
  SELF.left_rec_type := le.rec_type;
  SELF.right_rec_type := ri.rec_type;
  SELF.left_err_stat := le.err_stat;
  SELF.right_err_stat := ri.err_stat;
  SELF.err_stat_match_code := MAP(
                        le.err_stat_isnull OR ri.err_stat_isnull => SALT37.MatchCode.OneSideNull,
                        match_methods(ih).match_err_stat(le.err_stat,ri.err_stat));
  INTEGER2 err_stat_score_temp := MAP(
                        le.err_stat_isnull OR ri.err_stat_isnull => 0,
                        le.err_stat = ri.err_stat  => le.err_stat_weight100,
                        CustomErrStat((STRING4)le.err_stat,ri.err_stat) => SALT37.MOD_NonZero.AVENZ(le.err_stat_weight100,ri.err_stat_weight100),
                        SALT37.Fn_Fail_Scale(le.err_stat_weight100,s.err_stat_switch));
  SELF.left_addr_suffix := le.addr_suffix;
  SELF.right_addr_suffix := ri.addr_suffix;
  SELF.addr_suffix_match_code := MAP(
                        le.addr_suffix_isnull OR ri.addr_suffix_isnull => SALT37.MatchCode.OneSideNull,
                        match_methods(ih).match_addr_suffix(le.addr_suffix,ri.addr_suffix));
  INTEGER2 addr_suffix_score_temp := MAP(
                        le.addr_suffix_isnull OR ri.addr_suffix_isnull => 0,
                        le.addr_suffix = ri.addr_suffix  => le.addr_suffix_weight100,
                        SALT37.Fn_Fail_Scale(le.addr_suffix_weight100,s.addr_suffix_switch));
  SELF.prim_range_score := IF ( prim_range_score_temp > Config.prim_range_Force * 100, prim_range_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_range_skipped := SELF.prim_range_score < -5000;// Enforce FORCE parameter
  SELF.v_city_name_score := IF ( v_city_name_score_temp > Config.v_city_name_Force * 100, v_city_name_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.v_city_name_skipped := SELF.v_city_name_score < -5000;// Enforce FORCE parameter
  SELF.st_score := IF ( st_score_temp > Config.st_Force * 100, st_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.st_skipped := SELF.st_score < -5000;// Enforce FORCE parameter
  SELF.zip5_score := IF ( zip5_score_temp > Config.zip5_Force * 100, zip5_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.zip5_skipped := SELF.zip5_score < -5000;// Enforce FORCE parameter
  SELF.sec_range_score := IF ( sec_range_score_temp >= Config.sec_range_Force * 100, sec_range_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.sec_range_skipped := SELF.sec_range_score < -5000;// Enforce FORCE parameter
  SELF.postdir_score := IF ( postdir_score_temp >= Config.postdir_Force * 100, postdir_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.postdir_skipped := SELF.postdir_score < -5000;// Enforce FORCE parameter
  SELF.predir_score := IF ( predir_score_temp >= Config.predir_Force * 100, predir_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.predir_skipped := SELF.predir_score < -5000;// Enforce FORCE parameter
  SELF.err_stat_score := IF ( err_stat_score_temp >= Config.err_stat_Force * 100, err_stat_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.err_stat_skipped := SELF.err_stat_score < -5000;// Enforce FORCE parameter
  SELF.addr_suffix_score := IF ( addr_suffix_score_temp >= Config.addr_suffix_Force * 100, addr_suffix_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.addr_suffix_skipped := SELF.addr_suffix_score < -5000;// Enforce FORCE parameter
  SELF.cntprimname_score := IF ( cntprimname_score_temp > Config.cntprimname_Force * 100 OR SELF.prim_name_score > Config.cntprimname_OR1_prim_name_Force*100, cntprimname_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.cntprimname_skipped := SELF.cntprimname_score < -5000;// Enforce FORCE parameter
  // Get propagation scores for individual propagated fields
  SELF.Conf_Prop := (0) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.prim_range_score + SELF.v_city_name_score + SELF.st_score + SELF.zip5_score + SELF.cntprimname_score + SELF.sec_range_score + SELF.postdir_score + SELF.predir_score + SELF.prim_name_score + SELF.err_stat_score + SELF.addr_suffix_score) / 100 + outside;
END;
 
EXPORT AnnotateMatchesFromData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION
  j1 := JOIN(in_data,im,LEFT.LocId = RIGHT.LocId1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  r := JOIN(j1,in_data,LEFT.LocId2 = RIGHT.LocId,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
  d := DEDUP( r(rid1 <> rid2), ALL, WHOLE RECORD ); // keep all matches and allow downstream processes to filter
  RETURN d;
END;
 
EXPORT AnnotateMatchesFromRecordData(DATASET(match_candidates(ih).layout_candidates) in_data,DATASET(match_candidates(ih).layout_matches)  im) := FUNCTION//Faster form when rid known
  j1 := JOIN(in_data,im,LEFT.rid = RIGHT.rid1,HASH);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(j1,in_data,LEFT.rid2 = RIGHT.rid,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),HASH);
END;
 
EXPORT AnnotateClusterMatches(DATASET(match_candidates(ih).layout_candidates) in_data,SALT37.UIDType BaseRecord) := FUNCTION//Faster form when rid known
  j1 := in_data(rid = BaseRecord);
  match_candidates(ih).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
  RETURN JOIN(in_data(rid<>BaseRecord),j1,TRUE,sample_match_join( PROJECT(LEFT,strim(LEFT)),RIGHT),ALL);
END;
 
EXPORT AnnotateMatches(DATASET(match_candidates(ih).layout_matches) im) := FUNCTION
  am := AnnotateMatchesFromRecordData(h,im);
  am restoreRule(am le,im ri) := TRANSFORM
    SELF.rule := ri.rule;
    SELF := le;
  END;
  annotated_matches := JOIN(am,im,LEFT.rid1=RIGHT.rid1 AND LEFT.rid2=RIGHT.rid2,restoreRule(LEFT,RIGHT),HASH);
  RETURN annotated_matches;
END;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT37.UIDType LocId;
  DATASET(SALT37.Layout_FieldValueList) prim_range_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) v_city_name_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) st_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) zip5_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) cntprimname_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) sec_range_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) postdir_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) unit_desig_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) aid_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) predir_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) prim_name_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) rec_type_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) err_stat_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) addr_suffix_Values := DATASET([],SALT37.Layout_FieldValueList);
END;
 
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.LocId := le.LocId;
    SELF.prim_range_values := SALT37.fn_combine_fieldvaluelist(le.prim_range_values,ri.prim_range_values);
    SELF.v_city_name_values := SALT37.fn_combine_fieldvaluelist(le.v_city_name_values,ri.v_city_name_values);
    SELF.st_values := SALT37.fn_combine_fieldvaluelist(le.st_values,ri.st_values);
    SELF.zip5_values := SALT37.fn_combine_fieldvaluelist(le.zip5_values,ri.zip5_values);
    SELF.cntprimname_values := SALT37.fn_combine_fieldvaluelist(le.cntprimname_values,ri.cntprimname_values);
    SELF.sec_range_values := SALT37.fn_combine_fieldvaluelist(le.sec_range_values,ri.sec_range_values);
    SELF.postdir_values := SALT37.fn_combine_fieldvaluelist(le.postdir_values,ri.postdir_values);
    SELF.unit_desig_values := SALT37.fn_combine_fieldvaluelist(le.unit_desig_values,ri.unit_desig_values);
    SELF.aid_values := SALT37.fn_combine_fieldvaluelist(le.aid_values,ri.aid_values);
    SELF.predir_values := SALT37.fn_combine_fieldvaluelist(le.predir_values,ri.predir_values);
    SELF.prim_name_values := SALT37.fn_combine_fieldvaluelist(le.prim_name_values,ri.prim_name_values);
    SELF.rec_type_values := SALT37.fn_combine_fieldvaluelist(le.rec_type_values,ri.rec_type_values);
    SELF.err_stat_values := SALT37.fn_combine_fieldvaluelist(le.err_stat_values,ri.err_stat_values);
    SELF.addr_suffix_values := SALT37.fn_combine_fieldvaluelist(le.addr_suffix_values,ri.addr_suffix_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH(LocId) ), LocId, LOCAL ), LEFT.LocId = RIGHT.LocId, RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF.LocId := le.LocId;
    SELF.prim_range_values := SORT(le.prim_range_values, -cnt, val, LOCAL);
    SELF.v_city_name_values := SORT(le.v_city_name_values, -cnt, val, LOCAL);
    SELF.st_values := SORT(le.st_values, -cnt, val, LOCAL);
    SELF.zip5_values := SORT(le.zip5_values, -cnt, val, LOCAL);
    SELF.cntprimname_values := SORT(le.cntprimname_values, -cnt, val, LOCAL);
    SELF.sec_range_values := SORT(le.sec_range_values, -cnt, val, LOCAL);
    SELF.postdir_values := SORT(le.postdir_values, -cnt, val, LOCAL);
    SELF.unit_desig_values := SORT(le.unit_desig_values, -cnt, val, LOCAL);
    SELF.aid_values := SORT(le.aid_values, -cnt, val, LOCAL);
    SELF.predir_values := SORT(le.predir_values, -cnt, val, LOCAL);
    SELF.prim_name_values := SORT(le.prim_name_values, -cnt, val, LOCAL);
    SELF.rec_type_values := SORT(le.rec_type_values, -cnt, val, LOCAL);
    SELF.err_stat_values := SORT(le.err_stat_values, -cnt, val, LOCAL);
    SELF.addr_suffix_values := SORT(le.addr_suffix_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;
 
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.LocId := le.LocId;
  SELF.prim_range_Values := IF ( (le.prim_range  IN SET(s.nulls_prim_range,prim_range) OR le.prim_range = (TYPEOF(le.prim_range))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.prim_range)}],SALT37.Layout_FieldValueList));
  SELF.v_city_name_Values := IF ( (le.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR le.v_city_name = (TYPEOF(le.v_city_name))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.v_city_name)}],SALT37.Layout_FieldValueList));
  SELF.st_Values := IF ( (le.st  IN SET(s.nulls_st,st) OR le.st = (TYPEOF(le.st))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.st)}],SALT37.Layout_FieldValueList));
  SELF.zip5_Values := IF ( (le.zip5  IN SET(s.nulls_zip5,zip5) OR le.zip5 = (TYPEOF(le.zip5))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.zip5)}],SALT37.Layout_FieldValueList));
  SELF.cntprimname_Values := IF ( (le.cntprimname  IN SET(s.nulls_cntprimname,cntprimname) OR le.cntprimname = (TYPEOF(le.cntprimname))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.cntprimname)}],SALT37.Layout_FieldValueList));
  SELF.sec_range_Values := IF ( (le.sec_range  IN SET(s.nulls_sec_range,sec_range) OR le.sec_range = (TYPEOF(le.sec_range))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.sec_range)}],SALT37.Layout_FieldValueList));
  SELF.postdir_Values := IF ( (le.postdir  IN SET(s.nulls_postdir,postdir) OR le.postdir = (TYPEOF(le.postdir))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.postdir)}],SALT37.Layout_FieldValueList));
  SELF.unit_desig_Values := DATASET([{TRIM((SALT37.StrType)le.unit_desig)}],SALT37.Layout_FieldValueList);
  SELF.aid_Values := DATASET([{TRIM((SALT37.StrType)le.aid)}],SALT37.Layout_FieldValueList);
  SELF.predir_Values := IF ( (le.predir  IN SET(s.nulls_predir,predir) OR le.predir = (TYPEOF(le.predir))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.predir)}],SALT37.Layout_FieldValueList));
  SELF.prim_name_Values := IF ( (le.prim_name  IN SET(s.nulls_prim_name,prim_name) OR le.prim_name = (TYPEOF(le.prim_name))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.prim_name)}],SALT37.Layout_FieldValueList));
  SELF.rec_type_Values := DATASET([{TRIM((SALT37.StrType)le.rec_type)}],SALT37.Layout_FieldValueList);
  SELF.err_stat_Values := IF ( (le.err_stat  IN SET(s.nulls_err_stat,err_stat) OR le.err_stat = (TYPEOF(le.err_stat))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.err_stat)}],SALT37.Layout_FieldValueList));
  SELF.addr_suffix_Values := IF ( (le.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) OR le.addr_suffix = (TYPEOF(le.addr_suffix))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.addr_suffix)}],SALT37.Layout_FieldValueList));
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
 
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.LocId := le.LocId;
  SELF.prim_range_Values := IF ( (le.prim_range  IN SET(s.nulls_prim_range,prim_range) OR le.prim_range = (TYPEOF(le.prim_range))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.prim_range)}],SALT37.Layout_FieldValueList));
  SELF.v_city_name_Values := IF ( (le.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) OR le.v_city_name = (TYPEOF(le.v_city_name))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.v_city_name)}],SALT37.Layout_FieldValueList));
  SELF.st_Values := IF ( (le.st  IN SET(s.nulls_st,st) OR le.st = (TYPEOF(le.st))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.st)}],SALT37.Layout_FieldValueList));
  SELF.zip5_Values := IF ( (le.zip5  IN SET(s.nulls_zip5,zip5) OR le.zip5 = (TYPEOF(le.zip5))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.zip5)}],SALT37.Layout_FieldValueList));
  SELF.cntprimname_Values := IF ( (le.cntprimname  IN SET(s.nulls_cntprimname,cntprimname) OR le.cntprimname = (TYPEOF(le.cntprimname))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.cntprimname)}],SALT37.Layout_FieldValueList));
  SELF.sec_range_Values := IF ( (le.sec_range  IN SET(s.nulls_sec_range,sec_range) OR le.sec_range = (TYPEOF(le.sec_range))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.sec_range)}],SALT37.Layout_FieldValueList));
  SELF.postdir_Values := IF ( (le.postdir  IN SET(s.nulls_postdir,postdir) OR le.postdir = (TYPEOF(le.postdir))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.postdir)}],SALT37.Layout_FieldValueList));
  SELF.unit_desig_Values := DATASET([{TRIM((SALT37.StrType)le.unit_desig)}],SALT37.Layout_FieldValueList);
  SELF.aid_Values := DATASET([{TRIM((SALT37.StrType)le.aid)}],SALT37.Layout_FieldValueList);
  SELF.predir_Values := IF ( (le.predir  IN SET(s.nulls_predir,predir) OR le.predir = (TYPEOF(le.predir))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.predir)}],SALT37.Layout_FieldValueList));
  SELF.prim_name_Values := IF ( (le.prim_name  IN SET(s.nulls_prim_name,prim_name) OR le.prim_name = (TYPEOF(le.prim_name))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.prim_name)}],SALT37.Layout_FieldValueList));
  SELF.rec_type_Values := DATASET([{TRIM((SALT37.StrType)le.rec_type)}],SALT37.Layout_FieldValueList);
  SELF.err_stat_Values := IF ( (le.err_stat  IN SET(s.nulls_err_stat,err_stat) OR le.err_stat = (TYPEOF(le.err_stat))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.err_stat)}],SALT37.Layout_FieldValueList));
  SELF.addr_suffix_Values := IF ( (le.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) OR le.addr_suffix = (TYPEOF(le.addr_suffix))''),DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.addr_suffix)}],SALT37.Layout_FieldValueList));
END;
AsFieldValues := PROJECT(ih,into(left));
EXPORT InFile_Rolled := RollEntities(AsFieldValues);
EXPORT RemoveProps(DATASET(match_candidates(ih).layout_candidates) im) := FUNCTION
 
  im rem(im le) := TRANSFORM
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
  UNSIGNED1 prim_range_size := 0;
  UNSIGNED1 v_city_name_size := 0;
  UNSIGNED1 st_size := 0;
  UNSIGNED1 zip5_size := 0;
  UNSIGNED1 cntprimname_size := 0;
  UNSIGNED1 sec_range_size := 0;
  UNSIGNED1 postdir_size := 0;
  UNSIGNED1 predir_size := 0;
  UNSIGNED1 prim_name_size := 0;
  UNSIGNED1 err_stat_size := 0;
  UNSIGNED1 addr_suffix_size := 0;
END;
t0 := TABLE(AllRolled,Layout_Chubbies0);
Layout_Chubbies0 NoteSize(Layout_Chubbies0 le) := TRANSFORM
  SELF.prim_range_size := SALT37.Fn_SwitchSpec(s.prim_range_switch,count(le.prim_range_values));
  SELF.v_city_name_size := SALT37.Fn_SwitchSpec(s.v_city_name_switch,count(le.v_city_name_values));
  SELF.st_size := SALT37.Fn_SwitchSpec(s.st_switch,count(le.st_values));
  SELF.zip5_size := SALT37.Fn_SwitchSpec(s.zip5_switch,count(le.zip5_values));
  SELF.cntprimname_size := SALT37.Fn_SwitchSpec(s.cntprimname_switch,count(le.cntprimname_values));
  SELF.sec_range_size := SALT37.Fn_SwitchSpec(s.sec_range_switch,count(le.sec_range_values));
  SELF.postdir_size := SALT37.Fn_SwitchSpec(s.postdir_switch,count(le.postdir_values));
  SELF.predir_size := SALT37.Fn_SwitchSpec(s.predir_switch,count(le.predir_values));
  SELF.prim_name_size := SALT37.Fn_SwitchSpec(s.prim_name_switch,count(le.prim_name_values));
  SELF.err_stat_size := SALT37.Fn_SwitchSpec(s.err_stat_switch,count(le.err_stat_values));
  SELF.addr_suffix_size := SALT37.Fn_SwitchSpec(s.addr_suffix_switch,count(le.addr_suffix_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.prim_range_size+t.v_city_name_size+t.st_size+t.zip5_size+t.cntprimname_size+t.sec_range_size+t.postdir_size+t.predir_size+t.prim_name_size+t.err_stat_size+t.addr_suffix_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;
