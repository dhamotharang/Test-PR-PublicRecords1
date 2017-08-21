//Import:BDL2_Test.matches
// Begin code to perform the matching itself

import SALT,ut,salt24;

//*** Modified the salt generated default MatchThreshold from 36 to 25.
export matches(dataset(Layout_BH_BDL) ih,unsigned MatchThreshold = 25) := module
shared h := match_candidates(ih).candidates;
shared LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
shared s := Specificities(ih).Specificities[1];

shared match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,unsigned2 c,unsigned outside=0) := transform
  self.Rule := c;
  self.BDL1 := le.BDL;
  self.BDL2 := ri.BDL;
  self.RCID1 := le.RCID;
  self.RCID2 := ri.RCID;
  integer2 GROUP_ID_score := MAP( le.GROUP_ID  IN SET(s.nulls_GROUP_ID,GROUP_ID) or ri.GROUP_ID  IN SET(s.nulls_GROUP_ID,GROUP_ID) => SKIP,
                        le.GROUP_ID = ri.GROUP_ID  => le.GROUP_ID_weight100,
                        SKIP);

  integer2 COMPANY_NAME_score := MAP( le.COMPANY_NAME  IN SET(s.nulls_COMPANY_NAME,COMPANY_NAME) or ri.COMPANY_NAME  IN SET(s.nulls_COMPANY_NAME,COMPANY_NAME) => 0,
                        le.COMPANY_NAME = ri.COMPANY_NAME  => le.COMPANY_NAME_weight100,
                        SALT24.fn_match_bagofwords(le.COMPANY_NAME,ri.COMPANY_NAME,2,1));

  self.Conf_Prop := (0) / 100; // Score based on propogated fields
  iComp := (GROUP_ID_score + COMPANY_NAME_score) / 100 + outside;
  self.Conf := IF( iComp>=LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
end;
//Now execute each of the 1 join conditions

// Join mj0 which has blocking specificity of 40
dn0 := dedup(sort(h(GROUP_ID NOT IN SET(s.nulls_GROUP_ID,GROUP_ID) and COMPANY_NAME NOT IN SET(s.nulls_COMPANY_NAME,COMPANY_NAME)),bdl,group_id,company_name),bdl,group_id,company_name);
SALT.MAC_Remove_WithDups(dn0,(string)GROUP_ID + (string)COMPANY_NAME,2000,dn0_deduped)
mj0 := distribute( join( dn0_deduped, dn0_deduped, left.BDL > right.BDL and left.GROUP_ID = right.GROUP_ID and left.COMPANY_NAME = right.COMPANY_NAME,match_join(left,right,0),atmost(left.GROUP_ID = right.GROUP_ID and left.COMPANY_NAME = right.COMPANY_NAME,2000),skew(1)),hash(BDL1));
dn1 := dedup(sort(h(GROUP_ID NOT IN SET(s.nulls_GROUP_ID,GROUP_ID)),bdl,group_id,company_name),bdl,group_id,company_name);
SALT.MAC_Remove_WithDups(dn1,(string)GROUP_ID,2000,dn1_deduped)
mj1 := distribute( join( dn1_deduped, dn1_deduped, left.BDL > right.BDL and left.GROUP_ID = right.GROUP_ID,match_join(left,right,1),atmost(left.GROUP_ID = right.GROUP_ID,2000),skew(1)),hash(BDL1));
last_mjs_t := mj0+mj1;
SALT.mac_select_best_matches(last_mjs_t,BDL1,BDL2,Conf,Rule,o);
shared all_mjs := o;
export All_Matches := all_mjs;

SALT.mac_avoid_transitives(All_Matches,BDL1,BDL2,Conf,DateOverlap,Rule,o);
export PossibleMatches := o : persist('temp::Business_header_BDL2::BDL_BUSINESS_HEADER_mt');
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
ut.MAC_Patch_Id(ih,BDL,Matches,BDL1,BDL2,o);
export Patched_Infile := o;

//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,BDL,Matches,BDL1,BDL2,o1);
export Patched_Candidates := o1;
//Now perform the safety checks
export MatchesPerformed := count( Matches );
export MatchesPropAssisted := count( Matches(Conf_Prop>0) );
export MatchesPropRequired := count( Matches(Conf-Conf_Prop<MatchThreshold) );
export PreClusters := hygiene(ih).ClusterCounts;
export PostClusters := hygiene(Patched_Infile).ClusterCounts;
shared PrePatchIdCount := sum( PreClusters, NumberOfClusters );
shared PostPatchIdCount := sum( PostClusters, NumberOfClusters );
export PatchingError0 := PrePatchIdCount - PostPatchIdCount - MatchesPerformed; // Should be zero
export DuplicateRids0 := count(Patched_Infile) - count(dedup(Patched_Infile,RCID,all)); // Should be zero
export DidsNoRid0 := PostPatchIdCount - count(Patched_Infile(BDL=RCID)); // Should be zero
export DidsAboveRid0 := count(Patched_Infile(BDL>RCID)); // Should be zero
end;