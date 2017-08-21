// Begin code to perform the matching itself
import SALT20,ut;
export matches(dataset(layout_files().input.used) ih,unsigned MatchThreshold = 0) := module
shared LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
shared h := match_candidates(ih).candidates;
shared s := Specificities(ih).Specificities[1];
shared match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,unsigned2 c,unsigned outside=0) := transform
  self.Rule := c;
  self.1 := le.;
  self.2 := ri.;
  self.1 := le.;
  self.2 := ri.;
  integer2 fname_score := MAP( le.fname_isnull or ri.fname_isnull => 0,
                        le.fname = ri.fname  => le.fname_weight100,
                        SALT20.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  integer2 lname_score := MAP( le.lname_isnull or ri.lname_isnull => 0,
                        le.lname = ri.lname  => le.lname_weight100,
                        SALT20.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  integer2 addr_score := MAP( le.addr_isnull or ri.addr_isnull => 0,
                        le.addr = ri.addr  => le.addr_weight100,
                        SALT20.Fn_Fail_Scale(le.addr_weight100,s.addr_switch));
  integer2 city_score := MAP( le.city_isnull or ri.city_isnull => 0,
                        le.city = ri.city  => le.city_weight100,
                        SALT20.Fn_Fail_Scale(le.city_weight100,s.city_switch));
  integer2 state_score := MAP( le.state_isnull or ri.state_isnull => 0,
                        le.state = ri.state  => le.state_weight100,
                        SALT20.Fn_Fail_Scale(le.state_weight100,s.state_switch));
  integer2 zip_score := MAP( le.zip_isnull or ri.zip_isnull => 0,
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT20.Fn_Fail_Scale(le.zip_weight100,s.zip_switch));
  integer2 zip4_score := MAP( le.zip4_isnull or ri.zip4_isnull => 0,
                        le.zip4 = ri.zip4  => le.zip4_weight100,
                        SALT20.Fn_Fail_Scale(le.zip4_weight100,s.zip4_switch));
  integer2 EMAIL_score := MAP( le.EMAIL_isnull or ri.EMAIL_isnull => 0,
                        le.EMAIL = ri.EMAIL  => le.EMAIL_weight100,
                        SALT20.Fn_Fail_Scale(le.EMAIL_weight100,s.EMAIL_switch));
  integer2 phone_score := MAP( le.phone_isnull or ri.phone_isnull => 0,
                        le.phone = ri.phone  => le.phone_weight100,
                        SALT20.Fn_Fail_Scale(le.phone_weight100,s.phone_switch));
  integer2 LoanType_score := MAP( le.LoanType_isnull or ri.LoanType_isnull => 0,
                        le.LoanType = ri.LoanType  => le.LoanType_weight100,
                        SALT20.Fn_Fail_Scale(le.LoanType_weight100,s.LoanType_switch));
  integer2 BESTTIME_score := MAP( le.BESTTIME_isnull or ri.BESTTIME_isnull => 0,
                        le.BESTTIME = ri.BESTTIME  => le.BESTTIME_weight100,
                        SALT20.Fn_Fail_Scale(le.BESTTIME_weight100,s.BESTTIME_switch));
  integer2 MortRate_score := MAP( le.MortRate_isnull or ri.MortRate_isnull => 0,
                        le.MortRate = ri.MortRate  => le.MortRate_weight100,
                        SALT20.Fn_Fail_Scale(le.MortRate_weight100,s.MortRate_switch));
  integer2 PROPERTYTYPE_score := MAP( le.PROPERTYTYPE_isnull or ri.PROPERTYTYPE_isnull => 0,
                        le.PROPERTYTYPE = ri.PROPERTYTYPE  => le.PROPERTYTYPE_weight100,
                        SALT20.Fn_Fail_Scale(le.PROPERTYTYPE_weight100,s.PROPERTYTYPE_switch));
  integer2 RateType_score := MAP( le.RateType_isnull or ri.RateType_isnull => 0,
                        le.RateType = ri.RateType  => le.RateType_weight100,
                        SALT20.Fn_Fail_Scale(le.RateType_weight100,s.RateType_switch));
  integer2 LTV_score := MAP( le.LTV_isnull or ri.LTV_isnull => 0,
                        le.LTV = ri.LTV  => le.LTV_weight100,
                        SALT20.Fn_Fail_Scale(le.LTV_weight100,s.LTV_switch));
  integer2 YrsThere_score := MAP( le.YrsThere_isnull or ri.YrsThere_isnull => 0,
                        le.YrsThere = ri.YrsThere  => le.YrsThere_weight100,
                        SALT20.Fn_Fail_Scale(le.YrsThere_weight100,s.YrsThere_switch));
  integer2 employer_score := MAP( le.employer_isnull or ri.employer_isnull => 0,
                        le.employer = ri.employer  => le.employer_weight100,
                        SALT20.Fn_Fail_Scale(le.employer_weight100,s.employer_switch));
  integer2 credit_score := MAP( le.credit_isnull or ri.credit_isnull => 0,
                        le.credit = ri.credit  => le.credit_weight100,
                        SALT20.Fn_Fail_Scale(le.credit_weight100,s.credit_switch));
  integer2 Income_score := MAP( le.Income_isnull or ri.Income_isnull => 0,
                        le.Income = ri.Income  => le.Income_weight100,
                        SALT20.Fn_Fail_Scale(le.Income_weight100,s.Income_switch));
  integer2 LoanAmt_score := MAP( le.LoanAmt_isnull or ri.LoanAmt_isnull => 0,
                        le.LoanAmt = ri.LoanAmt  => le.LoanAmt_weight100,
                        SALT20.Fn_Fail_Scale(le.LoanAmt_weight100,s.LoanAmt_switch));
  integer2 dt_score := MAP( le.dt_isnull or ri.dt_isnull => 0,
                        le.dt = ri.dt  => le.dt_weight100,
                        SALT20.Fn_Fail_Scale(le.dt_weight100,s.dt_switch));
  integer2 ip_score := MAP( le.ip_isnull or ri.ip_isnull => 0,
                        le.ip = ri.ip  => le.ip_weight100,
                        SALT20.Fn_Fail_Scale(le.ip_weight100,s.ip_switch));
  self.Conf_Prop := (0
  ) / 100; // Score based on propogated fields
  iComp := (fname_score + lname_score + addr_score + city_score + state_score + zip_score + zip4_score + EMAIL_score + phone_score + LoanType_score + BESTTIME_score + MortRate_score + PROPERTYTYPE_score + RateType_score + LTV_score + YrsThere_score + employer_score + credit_score + Income_score + LoanAmt_score + dt_score + ip_score) / 100 + outside;
  self.Conf := IF( iComp>=LowerMatchThreshold or iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
end;
//Now execute each of the 22 join conditions of which 0 have been optimized into preceding conditions
//Fixed fields ->:fname(0)
dn0 := h(~fname_isnull);
dn0_deduped := dn0(fname_weight100>=0); // Use specificity to flag high-dup counts
mj0 := join( dn0_deduped, dn0_deduped, left. > right. and LEFT.fname = RIGHT.fname,match_join(left,right,0),atmost(LEFT.fname = RIGHT.fname,1000),skew(1));
//Fixed fields ->:lname(0)
dn1 := h(~lname_isnull);
dn1_deduped := dn1(lname_weight100>=0); // Use specificity to flag high-dup counts
mj1 := join( dn1_deduped, dn1_deduped, left. > right. and LEFT.lname = RIGHT.lname,match_join(left,right,1),atmost(LEFT.lname = RIGHT.lname,1000),skew(1));
//Fixed fields ->:addr(0)
dn2 := h(~addr_isnull);
dn2_deduped := dn2(addr_weight100>=0); // Use specificity to flag high-dup counts
mj2 := join( dn2_deduped, dn2_deduped, left. > right. and LEFT.addr = RIGHT.addr,match_join(left,right,2),atmost(LEFT.addr = RIGHT.addr,1000),skew(1));
//Fixed fields ->:city(0)
dn3 := h(~city_isnull);
dn3_deduped := dn3(city_weight100>=0); // Use specificity to flag high-dup counts
mj3 := join( dn3_deduped, dn3_deduped, left. > right. and LEFT.city = RIGHT.city,match_join(left,right,3),atmost(LEFT.city = RIGHT.city,1000),skew(1));
//Fixed fields ->:state(0)
dn4 := h(~state_isnull);
dn4_deduped := dn4(state_weight100>=0); // Use specificity to flag high-dup counts
mj4 := join( dn4_deduped, dn4_deduped, left. > right. and LEFT.state = RIGHT.state,match_join(left,right,4),atmost(LEFT.state = RIGHT.state,1000),skew(1));
mjs0_t := mj0+mj1+mj2+mj3+mj4;
SALT20.mac_select_best_matches(mjs0_t,1,2,o0);
mjs0 := o0 : persist('temp::bell_thrive_LT::::mj0');
//Fixed fields ->:zip(0)
dn5 := h(~zip_isnull);
dn5_deduped := dn5(zip_weight100>=0); // Use specificity to flag high-dup counts
mj5 := join( dn5_deduped, dn5_deduped, left. > right. and LEFT.zip = RIGHT.zip,match_join(left,right,5),atmost(LEFT.zip = RIGHT.zip,1000),skew(1));
//Fixed fields ->:zip4(0)
dn6 := h(~zip4_isnull);
dn6_deduped := dn6(zip4_weight100>=0); // Use specificity to flag high-dup counts
mj6 := join( dn6_deduped, dn6_deduped, left. > right. and LEFT.zip4 = RIGHT.zip4,match_join(left,right,6),atmost(LEFT.zip4 = RIGHT.zip4,1000),skew(1));
//Fixed fields ->:EMAIL(0)
dn7 := h(~EMAIL_isnull);
dn7_deduped := dn7(EMAIL_weight100>=0); // Use specificity to flag high-dup counts
mj7 := join( dn7_deduped, dn7_deduped, left. > right. and LEFT.EMAIL = RIGHT.EMAIL,match_join(left,right,7),atmost(LEFT.EMAIL = RIGHT.EMAIL,1000),skew(1));
//Fixed fields ->:phone(0)
dn8 := h(~phone_isnull);
dn8_deduped := dn8(phone_weight100>=0); // Use specificity to flag high-dup counts
mj8 := join( dn8_deduped, dn8_deduped, left. > right. and LEFT.phone = RIGHT.phone,match_join(left,right,8),atmost(LEFT.phone = RIGHT.phone,1000),skew(1));
//Fixed fields ->:LoanType(0)
dn9 := h(~LoanType_isnull);
dn9_deduped := dn9(LoanType_weight100>=0); // Use specificity to flag high-dup counts
mj9 := join( dn9_deduped, dn9_deduped, left. > right. and LEFT.LoanType = RIGHT.LoanType,match_join(left,right,9),atmost(LEFT.LoanType = RIGHT.LoanType,1000),skew(1));
mjs1_t := mj5+mj6+mj7+mj8+mj9;
SALT20.mac_select_best_matches(mjs1_t,1,2,o1);
mjs1 := o1 : persist('temp::bell_thrive_LT::::mj1');
//Fixed fields ->:BESTTIME(0)
dn10 := h(~BESTTIME_isnull);
dn10_deduped := dn10(BESTTIME_weight100>=0); // Use specificity to flag high-dup counts
mj10 := join( dn10_deduped, dn10_deduped, left. > right. and LEFT.BESTTIME = RIGHT.BESTTIME,match_join(left,right,10),atmost(LEFT.BESTTIME = RIGHT.BESTTIME,1000),skew(1));
//Fixed fields ->:MortRate(0)
dn11 := h(~MortRate_isnull);
dn11_deduped := dn11(MortRate_weight100>=0); // Use specificity to flag high-dup counts
mj11 := join( dn11_deduped, dn11_deduped, left. > right. and LEFT.MortRate = RIGHT.MortRate,match_join(left,right,11),atmost(LEFT.MortRate = RIGHT.MortRate,1000),skew(1));
//Fixed fields ->:PROPERTYTYPE(0)
dn12 := h(~PROPERTYTYPE_isnull);
dn12_deduped := dn12(PROPERTYTYPE_weight100>=0); // Use specificity to flag high-dup counts
mj12 := join( dn12_deduped, dn12_deduped, left. > right. and LEFT.PROPERTYTYPE = RIGHT.PROPERTYTYPE,match_join(left,right,12),atmost(LEFT.PROPERTYTYPE = RIGHT.PROPERTYTYPE,1000),skew(1));
//Fixed fields ->:RateType(0)
dn13 := h(~RateType_isnull);
dn13_deduped := dn13(RateType_weight100>=0); // Use specificity to flag high-dup counts
mj13 := join( dn13_deduped, dn13_deduped, left. > right. and LEFT.RateType = RIGHT.RateType,match_join(left,right,13),atmost(LEFT.RateType = RIGHT.RateType,1000),skew(1));
//Fixed fields ->:LTV(0)
dn14 := h(~LTV_isnull);
dn14_deduped := dn14(LTV_weight100>=0); // Use specificity to flag high-dup counts
mj14 := join( dn14_deduped, dn14_deduped, left. > right. and LEFT.LTV = RIGHT.LTV,match_join(left,right,14),atmost(LEFT.LTV = RIGHT.LTV,1000),skew(1));
mjs2_t := mj10+mj11+mj12+mj13+mj14;
SALT20.mac_select_best_matches(mjs2_t,1,2,o2);
mjs2 := o2 : persist('temp::bell_thrive_LT::::mj2');
//Fixed fields ->:YrsThere(0)
dn15 := h(~YrsThere_isnull);
dn15_deduped := dn15(YrsThere_weight100>=0); // Use specificity to flag high-dup counts
mj15 := join( dn15_deduped, dn15_deduped, left. > right. and LEFT.YrsThere = RIGHT.YrsThere,match_join(left,right,15),atmost(LEFT.YrsThere = RIGHT.YrsThere,1000),skew(1));
//Fixed fields ->:employer(0)
dn16 := h(~employer_isnull);
dn16_deduped := dn16(employer_weight100>=0); // Use specificity to flag high-dup counts
mj16 := join( dn16_deduped, dn16_deduped, left. > right. and LEFT.employer = RIGHT.employer,match_join(left,right,16),atmost(LEFT.employer = RIGHT.employer,1000),skew(1));
//Fixed fields ->:credit(0)
dn17 := h(~credit_isnull);
dn17_deduped := dn17(credit_weight100>=0); // Use specificity to flag high-dup counts
mj17 := join( dn17_deduped, dn17_deduped, left. > right. and LEFT.credit = RIGHT.credit,match_join(left,right,17),atmost(LEFT.credit = RIGHT.credit,1000),skew(1));
//Fixed fields ->:Income(0)
dn18 := h(~Income_isnull);
dn18_deduped := dn18(Income_weight100>=0); // Use specificity to flag high-dup counts
mj18 := join( dn18_deduped, dn18_deduped, left. > right. and LEFT.Income = RIGHT.Income,match_join(left,right,18),atmost(LEFT.Income = RIGHT.Income,1000),skew(1));
//Fixed fields ->:LoanAmt(0)
dn19 := h(~LoanAmt_isnull);
dn19_deduped := dn19(LoanAmt_weight100>=0); // Use specificity to flag high-dup counts
mj19 := join( dn19_deduped, dn19_deduped, left. > right. and LEFT.LoanAmt = RIGHT.LoanAmt,match_join(left,right,19),atmost(LEFT.LoanAmt = RIGHT.LoanAmt,1000),skew(1));
mjs3_t := mj15+mj16+mj17+mj18+mj19;
SALT20.mac_select_best_matches(mjs3_t,1,2,o3);
mjs3 := o3 : persist('temp::bell_thrive_LT::::mj3');
//Fixed fields ->:dt(0)
dn20 := h(~dt_isnull);
dn20_deduped := dn20(dt_weight100>=0); // Use specificity to flag high-dup counts
mj20 := join( dn20_deduped, dn20_deduped, left. > right. and LEFT.dt = RIGHT.dt,match_join(left,right,20),atmost(LEFT.dt = RIGHT.dt,1000),skew(1));
//Fixed fields ->:ip(0)
dn21 := h(~ip_isnull);
dn21_deduped := dn21(ip_weight100>=0); // Use specificity to flag high-dup counts
mj21 := join( dn21_deduped, dn21_deduped, left. > right. and LEFT.ip = RIGHT.ip,match_join(left,right,21),atmost(LEFT.ip = RIGHT.ip,1000),skew(1));
last_mjs_t :=mj20+mj21;
SALT20.mac_select_best_matches(last_mjs_t,1,2,o);
shared all_mjs :=  mjs0+ mjs1+ mjs2+ mjs3 +o;
export All_Matches := all_mjs : persist('temp::bell_thrive_LT__files().input.used_all_m'); // To by used by  and 
SALT20.mac_avoid_transitives(All_Matches,1,2,Conf,DateOverlap,Rule,o);
export PossibleMatches := o : persist('temp::bell_thrive_LT__files().input.used_mt');
SALT20.mac_get_BestPerRecord( All_Matches,1,1,2,2,o );
export BestPerRecord := o : persist('temp::bell_thrive_LT__files().input.used_mr');
//Now lets see if any slice-outs are needed
in_matches := join(h,h,left.=right. and (>string6<)left.<>(>string6<)right.,match_join(left,right,9999),local);
SALT20.mac_cluster_breadth(in_matches,1,2,1,o);
o1 := join(o,Specificities(ih).ClusterSizes,left.1=right.,local);
export ClusterLinkages := o1 : persist('temp::bell_thrive_LT__files().input.used_clu');
export ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT20.UIDType ;  //Outcast
  SALT20.UIDType ;  // Outcase within
  integer2 Closest; // Best present link
  SALT20.UIDType Pref_; // Prefers this record
  SALT20.UIDType Pref_; // Prefers this cluster
  integer2 Conf; // Score of new link
  integer2 Conf_Prop; // Prop of new link
  unsigned2 Pref_Margin; // Extent to which pref is preferred
end;
Pref_Layout note_better(ClusterOutcasts le, BestPerRecord ri) := transform
  self. := le.1;
  self. := le.1;
  self.Closest := le.Closest;
  self.Pref_ := ri.2;
  self.Pref_ := ri.2;
  self.Pref_Margin := ri.Conf-ri.Conf_Prop-le.Closest; // Compute winning margin
  self := ri;
end;
// Find those records happier in another cluster
CurrentJumpers := join(BestPerRecord,ClusterOutcasts,left.1=right.1 and right.closest<left.conf-left.conf_prop,note_better(right,left));
// No need for record to jump ship if clusters are joinable
WillJoin1 := join(CurrentJumpers,All_Matches(Conf>=MatchThreshold),left.=right.1 and left.Pref_=right.2,transform(left),left only,hash);
WillJoin2 := join(WillJoin1,All_Matches(Conf>=MatchThreshold),left.=right.2 and left.Pref_=right.1,transform(left),left only,hash);
export BetterElsewhere := WillJoin2;
export ToSlice := DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>10),HASH()),,-Pref_Margin,LOCAL),,LOCAL); // 1024x better in new place
SALT20.MAC_Avoid_SliceOuts(PossibleMatches,1,2,,Pref_,ToSlice,m); // If  is slice target - don't use in match
export Matches := m(Conf>=MatchThreshold);
//Output the attributes to use for match debugging
export MatchSample := enth(Matches,1000);
export BorderlineMatchSample := enth(Matches(Conf=MatchThreshold),1000);
export AlmostMatchSample := enth(PossibleMatches(Conf<MatchThreshold,Conf>=LowerMatchThreshold),1000);
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
SALT20.MAC_SliceOut_ByRID(ih,,,ToSlice,,sliced); // Execute Sliceouts
ut.MAC_Patch_Id(sliced,,Matches,1,2,o); // Join Clusters
export Patched_Infile := o;
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,,Matches,1,2,o1);
export Patched_Candidates := o1;
//Now perform the safety checks
export MatchesPerformed := count( Matches );
export SlicesPerformed := count( ToSlice );
export MatchesPropAssisted := count( Matches(Conf_Prop>0) );
export MatchesPropRequired := count( Matches(Conf-Conf_Prop<MatchThreshold) );
export PreClusters := hygiene(ih).ClusterCounts;
export PostClusters := hygiene(Patched_Infile).ClusterCounts;
shared PrePatchIdCount := sum( PreClusters, NumberOfClusters );
shared PostPatchIdCount := sum( PostClusters, NumberOfClusters );
export PatchingError0 := PrePatchIdCount - PostPatchIdCount - MatchesPerformed + SlicesPerformed; // Should be zero
end;
