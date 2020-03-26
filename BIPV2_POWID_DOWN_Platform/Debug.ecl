// Various routines to assist in debugging
 
IMPORT SALT27,ut,std;
EXPORT Debug(DATASET(layout_POWID_Down) ih, Layout_Specificities.R s, MatchThreshold = 38) := MODULE
// These shareds are the same as in matches. I cannot directly reference because co-calling modules is treacherous
SHARED h := match_candidates(ih).candidates;
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
 
EXPORT Layout_Sample_Matches := RECORD,MAXLENGTH(32000)
  INTEGER2 Conf;
  INTEGER2 Conf_Prop;
  INTEGER2 DateOverlap := 0;
  SALT27.UIDType POWID1;
  SALT27.UIDType POWID2;
  SALT27.UIDType rcid1;
  SALT27.UIDType rcid2;
  typeof(h.orgid) left_orgid;
  INTEGER2 orgid_score;
  BOOLEAN orgid_skipped := FALSE; // True if FORCE blocks match
  typeof(h.orgid) right_orgid;
  typeof(h.prim_range) left_prim_range;
  INTEGER2 prim_range_score;
  BOOLEAN prim_range_skipped := FALSE; // True if FORCE blocks match
  typeof(h.prim_range) right_prim_range;
  typeof(h.prim_name) left_prim_name;
  INTEGER2 prim_name_score;
  BOOLEAN prim_name_skipped := FALSE; // True if FORCE blocks match
  typeof(h.prim_name) right_prim_name;
  typeof(h.st) left_st;
  INTEGER2 st_score;
  BOOLEAN st_skipped := FALSE; // True if FORCE blocks match
  typeof(h.st) right_st;
  typeof(h.zip) left_zip;
  INTEGER2 zip_score;
  typeof(h.zip) right_zip;
  typeof(h.csz) left_csz;
  INTEGER2 csz_score;
  BOOLEAN csz_skipped := FALSE; // True if FORCE blocks match
  typeof(h.csz) right_csz;
  typeof(h.v_city_name) left_v_city_name;
  INTEGER2 v_city_name_score;
  typeof(h.v_city_name) right_v_city_name;
  typeof(h.company_name) left_company_name;
  typeof(h.company_name) right_company_name;
  typeof(h.addr1) left_addr1;
  INTEGER2 addr1_score;
  typeof(h.addr1) right_addr1;
  typeof(h.address) left_address;
  INTEGER2 address_score;
  BOOLEAN address_skipped := FALSE; // True if FORCE blocks match
  typeof(h.address) right_address;
  typeof(h.dt_first_seen) left_dt_first_seen;
  typeof(h.dt_first_seen) right_dt_first_seen;
  typeof(h.dt_last_seen) left_dt_last_seen;
  typeof(h.dt_last_seen) right_dt_last_seen;
END;
EXPORT layout_sample_matches sample_match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED outside=0) := TRANSFORM
  SELF.POWID1 := le.POWID;
  SELF.POWID2 := ri.POWID;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT27.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  SELF.left_orgid := le.orgid;
  SELF.right_orgid := ri.orgid;
  INTEGER2 orgid_score_temp := MAP(                         le.orgid = ri.orgid  => le.orgid_weight100,
                        SALT27.Fn_Fail_Scale(le.orgid_weight100,s.orgid_switch));
  SELF.left_company_name := le.company_name;
  SELF.right_company_name := ri.company_name;
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
  SELF.orgid_score := IF ( orgid_score_temp >= 0, orgid_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.orgid_skipped := SELF.orgid_score < -5000;// Enforce FORCE parameter
  REAL csz_score_scale := ( le.csz_weight100 + ri.csz_weight100 ) / (le.v_city_name_weight100 + ri.v_city_name_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 csz_score_pre := MAP( (le.csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull) OR le.csz_weight100 = 0 => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.csz = ri.csz  => le.csz_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_csz := le.csz;
  SELF.right_csz := ri.csz;
  SELF.left_v_city_name := le.v_city_name;
  SELF.right_v_city_name := ri.v_city_name;
  SELF.v_city_name_score := MAP( le.v_city_name_isnull OR ri.v_city_name_isnull => 0,
                        csz_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st <> ri.st => 0, // Only valid if the context variable is equal
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT27.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch))*IF(csz_score_scale=0,1,csz_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  REAL addr1_score_scale := ( le.addr1_weight100 + ri.addr1_weight100 ) / (le.prim_range_weight100 + ri.prim_range_weight100 + le.prim_name_weight100 + ri.prim_name_weight100); // Scaling factor for this concept
  INTEGER2 addr1_score_pre := MAP( (le.addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull) OR (ri.addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull) => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.addr1 = ri.addr1  => le.addr1_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_addr1 := le.addr1;
  SELF.right_addr1 := ri.addr1;
  SELF.left_prim_range := le.prim_range;
  SELF.right_prim_range := ri.prim_range;
  INTEGER2 prim_range_score_temp := MAP(                         addr1_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT27.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch))*IF(addr1_score_scale=0,1,addr1_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_prim_name := le.prim_name;
  SELF.right_prim_name := ri.prim_name;
  INTEGER2 prim_name_score_temp := MAP( le.prim_name_isnull OR ri.prim_name_isnull OR le.prim_name_weight100 = 0 => 0,
                        addr1_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT27.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch))*IF(addr1_score_scale=0,1,addr1_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_st := le.st;
  SELF.right_st := ri.st;
  INTEGER2 st_score_temp := MAP( le.st_isnull OR ri.st_isnull OR le.st_weight100 = 0 => 0,
                        csz_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT27.Fn_Fail_Scale(le.st_weight100,s.st_switch))*IF(csz_score_scale=0,1,csz_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.left_zip := le.zip;
  SELF.right_zip := ri.zip;
  SELF.zip_score := MAP( le.zip_isnull OR ri.zip_isnull => 0,
                        csz_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT27.Fn_Fail_Scale(le.zip_weight100,s.zip_switch))*IF(csz_score_scale=0,1,csz_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  SELF.prim_range_score := IF ( prim_range_score_temp >= 0 OR addr1_score_pre > 0 OR address_score_pre > 0, prim_range_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_range_skipped := SELF.prim_range_score < -5000;// Enforce FORCE parameter
  SELF.prim_name_score := IF ( prim_name_score_temp > 0 OR addr1_score_pre > 0 OR address_score_pre > 0, prim_name_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.prim_name_skipped := SELF.prim_name_score < -5000;// Enforce FORCE parameter
  SELF.st_score := IF ( st_score_temp > 0 OR csz_score_pre > 0 OR address_score_pre > 0, st_score_temp, -9999 ); // Enforce FORCE parameter
  SELF.st_skipped := SELF.st_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept csz
  INTEGER2 csz_score_ext := MAX(csz_score_pre,0) + self.v_city_name_score + self.st_score + self.zip_score + MAX(address_score_pre,0);// Score in surrounding context
  INTEGER2 csz_score_res := MAX(0,csz_score_pre); // At least nothing
  SELF.csz_score := IF ( csz_score_ext > -200,csz_score_res,-9999);
  SELF.csz_skipped := SELF.csz_score < -5000;// Enforce FORCE parameter
// Compute the score for the concept addr1
  INTEGER2 addr1_score_ext := MAX(addr1_score_pre,0) + self.prim_range_score + self.prim_name_score + MAX(address_score_pre,0);// Score in surrounding context
  INTEGER2 addr1_score_res := MAX(0,addr1_score_pre); // At least nothing
  SELF.addr1_score := addr1_score_res;
// Compute the score for the concept address
  INTEGER2 address_score_ext := MAX(address_score_pre,0)+ SELF.addr1_score + self.prim_range_score + self.prim_name_score+ SELF.csz_score + self.v_city_name_score + self.st_score + self.zip_score;// Score in surrounding context
  INTEGER2 address_score_res := MAX(0,address_score_pre); // At least nothing
  SELF.address_score := IF ( address_score_ext > 0,address_score_res,-9999);
  SELF.address_skipped := SELF.address_score < -5000;// Enforce FORCE parameter
  SELF.Conf_Prop := (0
    +MAX(le.prim_name_prop,ri.prim_name_prop)*SELF.prim_name_score // Score if either field propogated
    +if(le.addr1_prop+ri.addr1_prop>0,self.addr1_score*(0+if(le.prim_name_prop+ri.prim_name_prop>0,1,0))/2,0)
    +if(le.address_prop+ri.address_prop>0,self.address_score*(0+if(le.addr1_prop+ri.addr1_prop>0,1,0))/2,0)
  ) / 100; // Score based on propogated fields
  SELF.Conf := (SELF.orgid_score + MAX(SELF.address_score,MAX(SELF.addr1_score,SELF.prim_range_score + SELF.prim_name_score) + MAX(SELF.csz_score,SELF.v_city_name_score + SELF.st_score + SELF.zip_score))) / 100 + outside;
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
  SALT27.UIDType POWID;
  DATASET(SALT27.Layout_FieldValueList) orgid_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) company_name_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) address_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) dt_first_seen_Values := DATASET([],SALT27.Layout_FieldValueList);
  DATASET(SALT27.Layout_FieldValueList) dt_last_seen_Values := DATASET([],SALT27.Layout_FieldValueList);
END;
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
 
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.POWID := le.POWID;
  SELF.orgid_values := SALT27.fn_combine_fieldvaluelist(le.orgid_values,ri.orgid_values);
  SELF.company_name_values := SALT27.fn_combine_fieldvaluelist(le.company_name_values,ri.company_name_values);
  SELF.address_values := SALT27.fn_combine_fieldvaluelist(le.address_values,ri.address_values);
  SELF.dt_first_seen_values := SALT27.fn_combine_fieldvaluelist(le.dt_first_seen_values,ri.dt_first_seen_values);
  SELF.dt_last_seen_values := SALT27.fn_combine_fieldvaluelist(le.dt_last_seen_values,ri.dt_last_seen_values);
END;
  RETURN ROLLUP( SORT( DISTRIBUTE( infile, HASH(POWID) ), POWID, LOCAL ), LEFT.POWID = RIGHT.POWID, RollValues(LEFT,RIGHT),LOCAL);
END;
 
EXPORT RolledEntities(DATASET(match_candidates(ih).layout_candidates) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.POWID := le.POWID;
  SELF.orgid_Values := IF ( le.orgid  IN SET(s.nulls_orgid,orgid),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.orgid)}],SALT27.Layout_FieldValueList));
  SELF.company_name_Values := DATASET([{TRIM((SALT27.StrType)le.company_name)}],SALT27.Layout_FieldValueList);
  self.address_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range) AND le.prim_name  IN SET(s.nulls_prim_name,prim_name) AND le.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) AND le.st  IN SET(s.nulls_st,st) AND le.zip  IN SET(s.nulls_zip,zip),dataset([],SALT27.Layout_FieldValueList),dataset([{TRIM((SALT27.StrType)le.prim_range) + ' ' + TRIM((SALT27.StrType)le.prim_name) + ' ' + TRIM((SALT27.StrType)le.v_city_name) + ' ' + TRIM((SALT27.StrType)le.st) + ' ' + TRIM((SALT27.StrType)le.zip)}],SALT27.Layout_FieldValueList));
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT27.StrType)le.dt_first_seen)}],SALT27.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT27.StrType)le.dt_last_seen)}],SALT27.Layout_FieldValueList);
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
 
Layout_RolledEntity into(ih le) := TRANSFORM
  SELF.POWID := le.POWID;
  SELF.orgid_Values := IF ( le.orgid  IN SET(s.nulls_orgid,orgid),DATASET([],SALT27.Layout_FieldValueList),DATASET([{TRIM((SALT27.StrType)le.orgid)}],SALT27.Layout_FieldValueList));
  SELF.company_name_Values := DATASET([{TRIM((SALT27.StrType)le.company_name)}],SALT27.Layout_FieldValueList);
  self.address_Values := IF ( le.prim_range  IN SET(s.nulls_prim_range,prim_range) AND le.prim_name  IN SET(s.nulls_prim_name,prim_name) AND le.v_city_name  IN SET(s.nulls_v_city_name,v_city_name) AND le.st  IN SET(s.nulls_st,st) AND le.zip  IN SET(s.nulls_zip,zip),dataset([],SALT27.Layout_FieldValueList),dataset([{TRIM((SALT27.StrType)le.prim_range) + ' ' + TRIM((SALT27.StrType)le.prim_name) + ' ' + TRIM((SALT27.StrType)le.v_city_name) + ' ' + TRIM((SALT27.StrType)le.st) + ' ' + TRIM((SALT27.StrType)le.zip)}],SALT27.Layout_FieldValueList));
  SELF.dt_first_seen_Values := DATASET([{TRIM((SALT27.StrType)le.dt_first_seen)}],SALT27.Layout_FieldValueList);
  SELF.dt_last_seen_Values := DATASET([{TRIM((SALT27.StrType)le.dt_last_seen)}],SALT27.Layout_FieldValueList);
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
  SELF.orgid_size := SALT27.Fn_SwitchSpec(s.orgid_switch,count(le.orgid_values));
  SELF.address_size := SALT27.Fn_SwitchSpec(s.address_switch,count(le.address_values));
  SELF := le;
END;  t := PROJECT(t0,NoteSize(LEFT));
Layout_Chubbies := RECORD,MAXLENGTH(63000)
  t;
  UNSIGNED2 Size := t.orgid_size+t.address_size;
END;
EXPORT Chubbies := TABLE(t,Layout_Chubbies);
END;
