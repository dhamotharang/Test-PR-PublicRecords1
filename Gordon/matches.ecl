// Begin code to perform the matching itself
import ngadl,ut;
export matches(dataset(layout_HEADER) ih,unsigned MatchThreshold = 5) := module
shared h := match_candidates(ih).candidates;
shared LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
shared s := Specificities(ih).Specificities[1];
shared match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,unsigned2 c,unsigned outside=0) := transform
  self.Rule := c;
  self.DID1 := le.DID;
  self.DID2 := ri.DID;
  self.RID1 := le.RID;
  self.RID2 := ri.RID;
  integer2 VENDOR_ID_score := MAP( le.VENDOR_ID  IN SET(s.nulls_VENDOR_ID,VENDOR_ID) or ri.VENDOR_ID  IN SET(s.nulls_VENDOR_ID,VENDOR_ID) => 0,
                        le.SRC <> ri.SRC => 0, // Only valid if the context variable is equal
                        le.VENDOR_ID = ri.VENDOR_ID  => le.VENDOR_ID_weight100,
                        Gordon.fail_scale(le.VENDOR_ID_weight100,s.VENDOR_ID_switch));
  integer2 SSN_score := MAP( le.SSN  IN SET(s.nulls_SSN,SSN) or ri.SSN  IN SET(s.nulls_SSN,SSN) => 0,
                        le.SSN = ri.SSN  => le.SSN_weight100,
                        ut.stringsimilar(le.SSN,ri.SSN) <= 1 => Gordon.fuzzy_specificity(le.SSN_weight100,le.SSN_cnt, le.SSN_e1_cnt,ri.SSN_weight100,ri.SSN_cnt,ri.SSN_e1_cnt),
                        Gordon.fail_scale(le.SSN_weight100,s.SSN_switch));
  integer2 FULLNAME_score_pre := MAP( le.FULLNAME  IN SET(s.nulls_FULLNAME,FULLNAME) or ri.FULLNAME  IN SET(s.nulls_FULLNAME,FULLNAME) => 0,
                        le.FULLNAME = ri.FULLNAME  => le.FULLNAME_weight100,
                        0);
  integer2 PHONE_score := MAP( le.PHONE  IN SET(s.nulls_PHONE,PHONE) or ri.PHONE  IN SET(s.nulls_PHONE,PHONE) => 0,
                        le.PHONE = ri.PHONE  => le.PHONE_weight100,
                        Gordon.fail_scale(le.PHONE_weight100,s.PHONE_switch));
  integer2 DOB_year       := MAP ( le.DOB_year in SET(s.nulls_DOB_year,DOB_year) or ri.DOB_year in SET(s.nulls_DOB_year,DOB_year) => 0,
                                  le.DOB_year = ri.DOB_year => le.DOB_year_weight100,
                                  Gordon.fail_scale(le.DOB_year_weight100,s.DOB_year_switch) );
  integer2 DOB_month       := MAP ( le.DOB_month in SET(s.nulls_DOB_month,DOB_month) or ri.DOB_month in SET(s.nulls_DOB_month,DOB_month) => 0,
                                  le.DOB_month = ri.DOB_month => le.DOB_month_weight100,
                                  Gordon.fail_scale(le.DOB_month_weight100,s.DOB_month_switch) );
  integer2 DOB_day       := MAP ( le.DOB_day in SET(s.nulls_DOB_day,DOB_day) or ri.DOB_day in SET(s.nulls_DOB_day,DOB_day) => 0,
                                  le.DOB_day = ri.DOB_day => le.DOB_day_weight100,
                                  Gordon.fail_scale(le.DOB_day_weight100,s.DOB_day_switch) );
  integer2 DOB_score := MAP( le.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND le.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND le.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) or ri.DOB_year  IN SET(s.nulls_DOB_year,DOB_year) AND ri.DOB_month  IN SET(s.nulls_DOB_month,DOB_month) AND ri.DOB_day  IN SET(s.nulls_DOB_day,DOB_day) => 0,
                        DOB_year+DOB_month+DOB_day < 0 or DOB_year+DOB_month+DOB_day<>0 and DOB_year+DOB_month+DOB_day < 700 => SKIP,
                        DOB_year+DOB_month+DOB_day);
  integer2 ADDR1_score_pre := MAP( le.ADDR1  IN SET(s.nulls_ADDR1,ADDR1) or ri.ADDR1  IN SET(s.nulls_ADDR1,ADDR1) => 0,
                        le.ADDR1 = ri.ADDR1  => le.ADDR1_weight100,
                        0);
  integer2 LNAME_score := MAP( le.LNAME  IN SET(s.nulls_LNAME,LNAME) or ri.LNAME  IN SET(s.nulls_LNAME,LNAME) => 0,
                        FULLNAME_score_pre <> 0 => 0, // Parent has value so child keeps quiet
                        le.LNAME = ri.LNAME  => le.LNAME_weight100,
                        ut.stringsimilar(le.LNAME,ri.LNAME) <= 2 => Gordon.fuzzy_specificity(le.LNAME_weight100,le.LNAME_cnt, le.LNAME_e2_cnt,ri.LNAME_weight100,ri.LNAME_cnt,ri.LNAME_e2_cnt),
                        Gordon.fail_scale(le.LNAME_weight100,s.LNAME_switch));
  integer2 PRIM_NAME_score := MAP( le.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) or ri.PRIM_NAME  IN SET(s.nulls_PRIM_NAME,PRIM_NAME) => 0,
                        ADDR1_score_pre <> 0 => 0, // Parent has value so child keeps quiet
                        le.PRIM_NAME = ri.PRIM_NAME  => le.PRIM_NAME_weight100,
                        Gordon.fail_scale(le.PRIM_NAME_weight100,s.PRIM_NAME_switch));
  integer2 PRIM_RANGE_score := MAP( le.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) or ri.PRIM_RANGE  IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE) => 0,
                        ADDR1_score_pre <> 0 => 0, // Parent has value so child keeps quiet
                        le.PRIM_RANGE = ri.PRIM_RANGE  => le.PRIM_RANGE_weight100,
                        Gordon.fail_scale(le.PRIM_RANGE_weight100,s.PRIM_RANGE_switch));
  integer2 LOCALE_score_pre := MAP( le.LOCALE  IN SET(s.nulls_LOCALE,LOCALE) or ri.LOCALE  IN SET(s.nulls_LOCALE,LOCALE) => 0,
                        le.LOCALE = ri.LOCALE  => le.LOCALE_weight100,
                        0);
  integer2 FNAME_score := MAP( le.FNAME  IN SET(s.nulls_FNAME,FNAME) or ri.FNAME  IN SET(s.nulls_FNAME,FNAME) => 0,
                        FULLNAME_score_pre <> 0 => 0, // Parent has value so child keeps quiet
                        le.FNAME = ri.FNAME  => le.FNAME_weight100,
                        ut.stringsimilar(le.FNAME,ri.FNAME) <= 2 => Gordon.fuzzy_specificity(le.FNAME_weight100,le.FNAME_cnt, le.FNAME_e2_cnt,ri.FNAME_weight100,ri.FNAME_cnt,ri.FNAME_e2_cnt),
                        length(trim(le.FNAME))>0 and le.FNAME = ri.FNAME[length(trim(le.FNAME))] => le.FNAME_weight100, // An initial match - take initial specificity
                        length(trim(ri.FNAME))>0 and ri.FNAME = le.FNAME[length(trim(ri.FNAME))] => ri.FNAME_weight100,// An initial match - take initial specificity
                        Gordon.fail_scale(le.FNAME_weight100,s.FNAME_switch));
  integer2 SEC_RANGE_score := MAP( le.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) or ri.SEC_RANGE  IN SET(s.nulls_SEC_RANGE,SEC_RANGE) => 0,
                        le.SEC_RANGE = ri.SEC_RANGE  => le.SEC_RANGE_weight100,
                        Gordon.fail_scale(le.SEC_RANGE_weight100,s.SEC_RANGE_switch));
  integer2 MNAME_score := MAP( le.MNAME  IN SET(s.nulls_MNAME,MNAME) or ri.MNAME  IN SET(s.nulls_MNAME,MNAME) => 0,
                        FULLNAME_score_pre <> 0 => 0, // Parent has value so child keeps quiet
                        le.MNAME = ri.MNAME  => le.MNAME_weight100,
                        ut.stringsimilar(le.MNAME,ri.MNAME) <= 2 => Gordon.fuzzy_specificity(le.MNAME_weight100,le.MNAME_cnt, le.MNAME_e2_cnt,ri.MNAME_weight100,ri.MNAME_cnt,ri.MNAME_e2_cnt),
                        length(trim(le.MNAME))>0 and le.MNAME = ri.MNAME[length(trim(le.MNAME))] => le.MNAME_weight100, // An initial match - take initial specificity
                        length(trim(ri.MNAME))>0 and ri.MNAME = le.MNAME[length(trim(ri.MNAME))] => ri.MNAME_weight100,// An initial match - take initial specificity
                        Gordon.fail_scale(le.MNAME_weight100,s.MNAME_switch));
  integer2 ST_score := MAP( le.ST  IN SET(s.nulls_ST,ST) or ri.ST  IN SET(s.nulls_ST,ST) => 0,
                        LOCALE_score_pre <> 0 => 0, // Parent has value so child keeps quiet
                        le.ST = ri.ST  => le.ST_weight100,
                        Gordon.fail_scale(le.ST_weight100,s.ST_switch));
  integer2 NAME_SUFFIX_score := MAP( le.NAME_SUFFIX  IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) or ri.NAME_SUFFIX  IN SET(s.nulls_NAME_SUFFIX,NAME_SUFFIX) => 0,
                        FULLNAME_score_pre <> 0 => 0, // Parent has value so child keeps quiet
                        le.NAME_SUFFIX = ri.NAME_SUFFIX  => le.NAME_SUFFIX_weight100,
                        SKIP);
  integer2 GENDER_score := MAP( le.GENDER  IN SET(s.nulls_GENDER,GENDER) or ri.GENDER  IN SET(s.nulls_GENDER,GENDER) => 0,
                        le.GENDER = ri.GENDER  => le.GENDER_weight100,
                        SKIP);
  integer2 FULLNAME_score := FULLNAME_score_pre;
  integer2 ADDR1_score := ADDR1_score_pre;
  integer2 CITY_NAME_score := MAP( le.CITY_NAME  IN SET(s.nulls_CITY_NAME,CITY_NAME) or ri.CITY_NAME  IN SET(s.nulls_CITY_NAME,CITY_NAME) => 0,
                        LOCALE_score_pre <> 0 => 0, // Parent has value so child keeps quiet
                        le.CITY_NAME = ri.CITY_NAME  => le.CITY_NAME_weight100,
                        Gordon.fail_scale(le.CITY_NAME_weight100,s.CITY_NAME_switch));
  integer2 LOCALE_score := LOCALE_score_pre;
  self.Conf_Prop := (if(le.SSN_prop or ri.SSN_prop,SSN_score,0) + if(le.FULLNAME_prop or ri.FULLNAME_prop,FULLNAME_score,0) + if(le.PHONE_prop or ri.PHONE_prop,PHONE_score,0) + if(le.DOB_prop or ri.DOB_prop,DOB_score,0) + if(le.FNAME_prop or ri.FNAME_prop,FNAME_score,0) + if(le.MNAME_prop or ri.MNAME_prop,MNAME_score,0) + if(le.NAME_SUFFIX_prop or ri.NAME_SUFFIX_prop,NAME_SUFFIX_score,0)) / 100; // Score based on propogated fields
  iComp := (VENDOR_ID_score + SSN_score + FULLNAME_score + PHONE_score + DOB_score + ADDR1_score + LNAME_score + PRIM_NAME_score + PRIM_RANGE_score + CITY_NAME_score + LOCALE_score + FNAME_score + SEC_RANGE_score + MNAME_score + ST_score + NAME_SUFFIX_score + GENDER_score) / 100 + outside;
  self.Conf := IF( iComp>=LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
end;
//Now execute each of the 15 join conditions
// Join mj0 which has blocking specificity of 25
dn0 := h(VENDOR_ID NOT IN SET(s.nulls_VENDOR_ID,VENDOR_ID));
Gordon.MAC_Remove_WithDups(dn0,(string)VENDOR_ID + (string)SRC,1000,dn0_deduped)
mj0 := distribute( join( dn0_deduped, dn0_deduped, left.DID > right.DID and left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC,match_join(left,right,0),atmost(left.VENDOR_ID = right.VENDOR_ID and left.SRC = right.SRC,1000),skew(1)),hash(DID1));
// Join mj1 which has blocking specificity of 23
dn1 := h(SSN NOT IN SET(s.nulls_SSN,SSN));
Gordon.MAC_Remove_WithDups(dn1,(string)SSN,1000,dn1_deduped)
mj1 := distribute( join( dn1_deduped, dn1_deduped, left.DID > right.DID and left.SSN = right.SSN,match_join(left,right,1),atmost(left.SSN = right.SSN,1000),skew(1)),hash(DID1));
// Join mj2 which has blocking specificity of 22
dn2 := h(FULLNAME NOT IN SET(s.nulls_FULLNAME,FULLNAME));
Gordon.MAC_Remove_WithDups(dn2,(string)FULLNAME,1000,dn2_deduped)
mj2 := distribute( join( dn2_deduped, dn2_deduped, left.DID > right.DID and left.FULLNAME = right.FULLNAME,match_join(left,right,2),atmost(left.FULLNAME = right.FULLNAME,1000),skew(1)),hash(DID1));
// Join mj3 which has blocking specificity of 19
dn3 := h(PHONE NOT IN SET(s.nulls_PHONE,PHONE));
Gordon.MAC_Remove_WithDups(dn3,(string)PHONE,1000,dn3_deduped)
mj3 := distribute( join( dn3_deduped, dn3_deduped, left.DID > right.DID and left.PHONE = right.PHONE,match_join(left,right,3),atmost(left.PHONE = right.PHONE,1000),skew(1)),hash(DID1));
// Join mj4 which has blocking specificity of 15
dn4 := h((DOB_year NOT IN SET(s.nulls_DOB_year,DOB_year) OR DOB_month NOT IN SET(s.nulls_DOB_month,DOB_month) OR DOB_day NOT IN SET(s.nulls_DOB_day,DOB_day)));
Gordon.MAC_Remove_WithDups(dn4,(string)DOB_year + (string)DOB_month + (string)DOB_day,1000,dn4_deduped)
mj4 := distribute( join( dn4_deduped, dn4_deduped, left.DID > right.DID and left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day,match_join(left,right,4),atmost(left.DOB_year = right.DOB_year and left.DOB_month = right.DOB_month and left.DOB_day = right.DOB_day,1000),skew(1)),hash(DID1));
// Join mj5 which has blocking specificity of 12
dn5 := h(ADDR1 NOT IN SET(s.nulls_ADDR1,ADDR1));
Gordon.MAC_Remove_WithDups(dn5,(string)ADDR1,1000,dn5_deduped)
mj5 := distribute( join( dn5_deduped, dn5_deduped, left.DID > right.DID and left.ADDR1 = right.ADDR1,match_join(left,right,5),atmost(left.ADDR1 = right.ADDR1,1000),skew(1)),hash(DID1));
// Join mj6 which has blocking specificity of 11
dn6 := h(LNAME NOT IN SET(s.nulls_LNAME,LNAME));
Gordon.MAC_Remove_WithDups(dn6,(string)LNAME,1000,dn6_deduped)
mj6 := distribute( join( dn6_deduped, dn6_deduped, left.DID > right.DID and left.LNAME = right.LNAME,match_join(left,right,6),atmost(left.LNAME = right.LNAME,1000),skew(1)),hash(DID1));
// Join mj7 which has blocking specificity of 11
dn7 := h(PRIM_NAME NOT IN SET(s.nulls_PRIM_NAME,PRIM_NAME));
Gordon.MAC_Remove_WithDups(dn7,(string)PRIM_NAME,1000,dn7_deduped)
mj7 := distribute( join( dn7_deduped, dn7_deduped, left.DID > right.DID and left.PRIM_NAME = right.PRIM_NAME,match_join(left,right,7),atmost(left.PRIM_NAME = right.PRIM_NAME,1000),skew(1)),hash(DID1));
// Join mj8 which has blocking specificity of 11
dn8 := h(PRIM_RANGE NOT IN SET(s.nulls_PRIM_RANGE,PRIM_RANGE));
Gordon.MAC_Remove_WithDups(dn8,(string)PRIM_RANGE,1000,dn8_deduped)
mj8 := distribute( join( dn8_deduped, dn8_deduped, left.DID > right.DID and left.PRIM_RANGE = right.PRIM_RANGE,match_join(left,right,8),atmost(left.PRIM_RANGE = right.PRIM_RANGE,1000),skew(1)),hash(DID1));
// Join mj9 which has blocking specificity of 10
dn9 := h(CITY_NAME NOT IN SET(s.nulls_CITY_NAME,CITY_NAME));
Gordon.MAC_Remove_WithDups(dn9,(string)CITY_NAME,1000,dn9_deduped)
mj9 := distribute( join( dn9_deduped, dn9_deduped, left.DID > right.DID and left.CITY_NAME = right.CITY_NAME,match_join(left,right,9),atmost(left.CITY_NAME = right.CITY_NAME,1000),skew(1)),hash(DID1));
// Join mj10 which has blocking specificity of 10
dn10 := h(LOCALE NOT IN SET(s.nulls_LOCALE,LOCALE));
Gordon.MAC_Remove_WithDups(dn10,(string)LOCALE,1000,dn10_deduped)
mj10 := distribute( join( dn10_deduped, dn10_deduped, left.DID > right.DID and left.LOCALE = right.LOCALE,match_join(left,right,10),atmost(left.LOCALE = right.LOCALE,1000),skew(1)),hash(DID1));
// Join mj11 which has blocking specificity of 9
dn11 := h(FNAME NOT IN SET(s.nulls_FNAME,FNAME));
Gordon.MAC_Remove_WithDups(dn11,(string)FNAME,1000,dn11_deduped)
mj11 := distribute( join( dn11_deduped, dn11_deduped, left.DID > right.DID and left.FNAME = right.FNAME,match_join(left,right,11),atmost(left.FNAME = right.FNAME,1000),skew(1)),hash(DID1));
// Join mj12 which has blocking specificity of 7
dn12 := h(SEC_RANGE NOT IN SET(s.nulls_SEC_RANGE,SEC_RANGE));
Gordon.MAC_Remove_WithDups(dn12,(string)SEC_RANGE,1000,dn12_deduped)
mj12 := distribute( join( dn12_deduped, dn12_deduped, left.DID > right.DID and left.SEC_RANGE = right.SEC_RANGE,match_join(left,right,12),atmost(left.SEC_RANGE = right.SEC_RANGE,1000),skew(1)),hash(DID1));
// Join mj13 which has blocking specificity of 6
dn13 := h(MNAME NOT IN SET(s.nulls_MNAME,MNAME));
Gordon.MAC_Remove_WithDups(dn13,(string)MNAME,1000,dn13_deduped)
mj13 := distribute( join( dn13_deduped, dn13_deduped, left.DID > right.DID and left.MNAME = right.MNAME,match_join(left,right,13),atmost(left.MNAME = right.MNAME,1000),skew(1)),hash(DID1));
// Join mj14 which has blocking specificity of 5
dn14 := h(ST NOT IN SET(s.nulls_ST,ST));
Gordon.MAC_Remove_WithDups(dn14,(string)ST,1000,dn14_deduped)
mj14 := distribute( join( dn14_deduped, dn14_deduped, left.DID > right.DID and left.ST = right.ST,match_join(left,right,14),atmost(left.ST = right.ST,1000),skew(1)),hash(DID1));
last_mjs_t := mj0+ mj1+ mj2+ mj3+ mj4+ mj5+ mj6+ mj7+ mj8+ mj9+ mj10+ mj11+ mj12+ mj13+ mj14;
Gordon.mac_select_best_matches(last_mjs_t,DID1,DID2,Conf,Rule,o);
shared all_mjs := o;
export All_Matches := all_mjs;
Gordon.mac_avoid_transitives(All_Matches,DID1,DID2,Conf,DateOverlap,Rule,o);
export PossibleMatches := o;
export Matches := PossibleMatches(Conf>=MatchThreshold);
//Output the attributes to use for match debugging
export MatchSample := enth(Matches,1000);
export BorderlineMatchSample := enth(Matches(Conf=MatchThreshold),1000);
export AlmostMatchSample := enth(PossibleMatches(Conf<MatchThreshold),1000);
r := record
  unsigned2 RuleNumber := Matches.Rule;
  unsigned MatchesFound := count(group);
end;
export RuleEfficacy := table(Matches,r,Rule,few);
r := record
  unsigned2 Conf := Matches.Conf;
  unsigned MatchesFound := count(group);
end;
export ConfidenceBreakdown := table(Matches,r,Conf,few);
Full_Sample_Matches := MatchSample+BorderlineMatchSample+AlmostMatchSample;
export MatchSampleRecords := Debug(ih,s,MatchThreshold).AnnotateMatches(Full_Sample_Matches);
//Now actually produce the new file
ut.MAC_Patch_Id(ih,DID,Matches,DID1,DID2,o);
export Patched_Infile := o;
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,DID,Matches,DID1,DID2,o1);
export Patched_Candidates := o1;
//Now perform the safety checks
export MatchesPerformed := count( Matches );
export MatchesPropAssisted := count( Matches(Conf_Prop>0) );
export MatchesPropRequired := count( Matches(Conf-Conf_Prop<MatchThreshold) );
export PreClusters := hygiene(ih).ClusterCounts;
export PostClusters := hygiene(Patched_Infile).ClusterCounts;
shared PrePatchIdCount := sum( PreClusters, InCluster*NumberOfClusters );
shared PostPatchIdCount := sum( PostClusters, InCluster*NumberOfClusters );
export PatchingError0 := PrePatchIdCount - PostPatchIdCount - MatchesPerformed; // Should be zero
export DuplicateRids0 := count(Patched_Infile) - count(dedup(Patched_Infile,RID,all)); // Should be zero
export DidsNoRid0 := PostPatchIdCount - count(Patched_Infile(DID=RID)); // Should be zero
export DidsAboveRid0 := count(Patched_Infile(DID>RID)); // Should be zero
end;
