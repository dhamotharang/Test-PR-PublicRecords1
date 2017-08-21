// Begin code to perform the matching itself
 
IMPORT SALT35,ut,std;
EXPORT matches(DATASET(layout_POWID_Down) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.POWID1 := le.POWID;
  SELF.POWID2 := ri.POWID;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT35.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  INTEGER2 orgid_score_temp := MAP(
                        le.orgid = ri.orgid  => le.orgid_weight100,
                        SALT35.Fn_Fail_Scale(le.orgid_weight100,s.orgid_switch));
  REAL address_score_scale := ( le.address_weight100 + ri.address_weight100 ) / (le.addr1_weight100 + ri.addr1_weight100 + le.csz_weight100 + ri.csz_weight100); // Scaling factor for this concept
  INTEGER2 address_score_pre := MAP( (le.address_isnull OR (le.addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull) AND (le.csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull)) OR (ri.address_isnull OR (ri.addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull) AND (ri.csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull)) OR le.address_weight100 = 0 => 0,
                        le.address = ri.address  => le.address_weight100,
                        0);
  INTEGER2 orgid_score := IF ( orgid_score_temp >= Config.orgid_Force * 100, orgid_score_temp, SKIP ); // Enforce FORCE parameter
  REAL csz_score_scale := ( le.csz_weight100 + ri.csz_weight100 ) / (le.v_city_name_weight100 + ri.v_city_name_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 csz_score_pre := MAP( (le.csz_isnull OR le.v_city_name_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.csz_isnull OR ri.v_city_name_isnull AND ri.st_isnull AND ri.zip_isnull) OR le.csz_weight100 = 0 => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.csz = ri.csz  => le.csz_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 v_city_name_score := MAP(
                        le.v_city_name_isnull OR ri.v_city_name_isnull => 0,
                        csz_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st_isnull OR ri.st_isnull OR le.st <> ri.st  => 0, // Only valid if the context variable is equal
                        le.v_city_name = ri.v_city_name  => le.v_city_name_weight100,
                        SALT35.Fn_Fail_Scale(le.v_city_name_weight100,s.v_city_name_switch))*IF(csz_score_scale=0,1,csz_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  REAL addr1_score_scale := ( le.addr1_weight100 + ri.addr1_weight100 ) / (le.prim_range_weight100 + ri.prim_range_weight100 + le.prim_name_weight100 + ri.prim_name_weight100); // Scaling factor for this concept
  INTEGER2 addr1_score_pre := MAP( (le.addr1_isnull OR le.prim_range_isnull AND le.prim_name_isnull) OR (ri.addr1_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull) => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.addr1 = ri.addr1  => le.addr1_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 prim_range_score_temp := MAP(
                        addr1_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT35.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch))*IF(addr1_score_scale=0,1,addr1_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 prim_name_score_temp := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull OR le.prim_name_weight100 = 0 => 0,
                        addr1_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT35.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch))*IF(addr1_score_scale=0,1,addr1_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 st_score_temp := MAP(
                        le.st_isnull OR ri.st_isnull OR le.st_weight100 = 0 => 0,
                        csz_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT35.Fn_Fail_Scale(le.st_weight100,s.st_switch))*IF(csz_score_scale=0,1,csz_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 zip_score := MAP(
                        le.zip_isnull OR ri.zip_isnull => 0,
                        csz_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT35.Fn_Fail_Scale(le.zip_weight100,s.zip_switch))*IF(csz_score_scale=0,1,csz_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 prim_range_score := IF ( prim_range_score_temp >= Config.prim_range_Force * 100 OR addr1_score_pre > 0 OR address_score_pre > 0, prim_range_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_name_score := IF ( prim_name_score_temp > Config.prim_name_Force * 100 OR addr1_score_pre > 0 OR address_score_pre > 0, prim_name_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 st_score := IF ( st_score_temp > Config.st_Force * 100 OR csz_score_pre > 0 OR address_score_pre > 0, st_score_temp, SKIP ); // Enforce FORCE parameter
// Compute the score for the concept csz
  INTEGER2 csz_score_ext := SALT35.ClipScore(MAX(csz_score_pre,0) + v_city_name_score + st_score + zip_score + MAX(address_score_pre,0));// Score in surrounding context
  INTEGER2 csz_score_res := MAX(0,csz_score_pre); // At least nothing
  INTEGER2 csz_score := IF ( csz_score_ext > -200,csz_score_res,SKIP);
// Compute the score for the concept addr1
  INTEGER2 addr1_score_ext := SALT35.ClipScore(MAX(addr1_score_pre,0) + prim_range_score + prim_name_score + MAX(address_score_pre,0));// Score in surrounding context
  INTEGER2 addr1_score_res := MAX(0,addr1_score_pre); // At least nothing
  INTEGER2 addr1_score := addr1_score_res;
// Compute the score for the concept address
  INTEGER2 address_score_ext := SALT35.ClipScore(MAX(address_score_pre,0)+ addr1_score + prim_range_score + prim_name_score+ csz_score + v_city_name_score + st_score + zip_score);// Score in surrounding context
  INTEGER2 address_score_res := MAX(0,address_score_pre); // At least nothing
  INTEGER2 address_score := IF ( address_score_ext > 0,address_score_res,SKIP);
  SELF.Conf_Prop := (0
    +MAX(le.prim_name_prop,ri.prim_name_prop)*prim_name_score // Score if either field propogated
    +if(le.addr1_prop+ri.addr1_prop>0,addr1_score*(0+if(le.prim_name_prop+ri.prim_name_prop>0,s.prim_name_specificity,0))/(+ s.prim_name_specificity),0)
    +if(le.address_prop+ri.address_prop>0,address_score*(0+if(le.addr1_prop+ri.addr1_prop>0,s.addr1_specificity,0))/( s.addr1_specificity),0)
  ) / 100; // Score based on propogated fields
  iComp := (orgid_score + IF(address_score>0,MAX(address_score,IF(addr1_score>0,MAX(addr1_score,prim_range_score + prim_name_score),prim_range_score + prim_name_score) + IF(csz_score>0,MAX(csz_score,v_city_name_score + st_score + zip_score),v_city_name_score + st_score + zip_score)),IF(addr1_score>0,MAX(addr1_score,prim_range_score + prim_name_score),prim_range_score + prim_name_score) + IF(csz_score>0,MAX(csz_score,v_city_name_score + st_score + zip_score),v_city_name_score + st_score + zip_score))) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':orgid:prim_range:prim_name:st','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 1 join conditions of which 0 have been optimized into preceding conditions
EXPORT MAC_DoJoins(hfile,trans) := FUNCTIONMACRO
 
//Fixed fields ->:orgid(28):prim_range(13):prim_name(14):st(5)
 
dn0 := hfile(~prim_name_isnull AND ~st_isnull);
dn0_deduped := dn0(orgid_weight100 + prim_range_weight100 + prim_name_weight100 + st_weight100>=500); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.POWID > RIGHT.POWID AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' )
    AND LEFT.orgid = RIGHT.orgid
    AND LEFT.prim_range = RIGHT.prim_range
    AND LEFT.prim_name = RIGHT.prim_name
    AND LEFT.st = RIGHT.st
    AND ( ~left.prim_name_isnull AND ~right.prim_name_isnull )
    AND ( ~left.st_isnull AND ~right.st_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    ,trans(LEFT,RIGHT,0),UNORDERED,
    ATMOST(LEFT.orgid = RIGHT.orgid
      AND LEFT.prim_range = RIGHT.prim_range
      AND LEFT.prim_name = RIGHT.prim_name
      AND LEFT.st = RIGHT.st,10000),HASH);
last_mjs_t :=mj0;
SALT35.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
mjs0 := o : PERSIST('~temp::POWID::BIPV2_POWID_Down::mj::0',EXPIRE(Config.PersistExpire));
 
RETURN  mjs0;
ENDMACRO;
SHARED all_mjs := MAC_DoJoins(h,match_join);
EXPORT All_Matches := all_mjs : PERSIST('~temp::POWID::BIPV2_POWID_Down::all_m',EXPIRE(Config.PersistExpire)); // To by used by rcid and POWID
SALT35.mac_avoid_transitives(All_Matches,POWID1,POWID2,Conf,DateOverlap,Rule,o);
EXPORT PossibleMatches := o : PERSIST('~temp::POWID::BIPV2_POWID_Down::mt',EXPIRE(Config.PersistExpire));
EXPORT Matches := PossibleMatches(Conf>=MatchThreshold) : PERSIST('~temp::POWID::BIPV2_POWID_Down::Matches::Matches',EXPIRE(Config.PersistExpire));
 
//Output the attributes to use for match debugging
EXPORT MatchSample := ENTH(Matches,1000);
EXPORT BorderlineMatchSample := ENTH(Matches(Conf=MatchThreshold),1000);
EXPORT AlmostMatchSample := ENTH(PossibleMatches(Conf<MatchThreshold,Conf>=LowerMatchThreshold),1000);
r := RECORD
  UNSIGNED2 RuleNumber := Matches.Rule;
  STRING Rule := RuleText(Matches.Rule);
  UNSIGNED MatchesFound := COUNT(GROUP);
END;
EXPORT RuleEfficacy := TABLE(Matches,r,Rule,FEW);
r := RECORD
  UNSIGNED2 Conf := Matches.Conf;
  UNSIGNED MatchesFound := COUNT(GROUp);
END;
export ConfidenceBreakdown := table(Matches,r,Conf,few);
Full_Sample_Matches := MatchSample+BorderlineMatchSample+AlmostMatchSample;
export MatchSampleRecords := Debug(ih,s,MatchThreshold).AnnotateMatches(Full_Sample_Matches);
 
//Now actually produce the new file
SHARED ih_init := Specificities(ih).ih_init;
SHARED ih_thin := TABLE(ih_init,{rcid,POWID});
  ut.MAC_Patch_Id(ih_thin,POWID,BasicMatch(ih).patch_file,POWID1,POWID2,ihbp); // Perform basic matches
  ut.MAC_Patch_Id(ihbp,POWID,Matches,POWID1,POWID2,o); // Join Clusters
SHARED Patched_Infile_thin := o : INDEPENDENT;
  pi1 := JOIN(ih, Patched_Infile_thin, LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
 
EXPORT Patched_Infile := pi1;
 
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,POWID,Matches,POWID1,POWID2,o1);
EXPORT Patched_Candidates := o1;
 
// Now compute a file to show which identifiers have changed from input to output
  MatchHistory.id_shift_r note_change(ih_thin le,patched_infile_thin ri) := TRANSFORM
    SELF.rcid := le.rcid;
    SELF.POWID_before := le.POWID;
    SELF.POWID_after := ri.POWID;
    SELF.change_date := (UNSIGNED4)stringlib.GetDateYYYYMMDD();
  END;
EXPORT IdChanges := JOIN(ih_thin,patched_infile_thin,LEFT.rcid = RIGHT.rcid AND (LEFT.POWID<>RIGHT.POWID),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := BIPV2_POWID_Down.Fields.UIDConsistency(ih_thin); // Export whole consistency module
EXPORT PostIDs := BIPV2_POWID_Down.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[2].cnt - PostIDs.IdCounts[2].cnt - MatchesPerformed - COUNT(BasicMatch(ih).patch_file) ; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile_thin) - PostIDs.IdCounts[1].Cnt; // Should be zero
END;
