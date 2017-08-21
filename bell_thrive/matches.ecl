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
  integer2 id_score := MAP( le.id_isnull or ri.id_isnull => 0,
                        le.id = ri.id  => le.id_weight100,
                        SALT20.Fn_Fail_Scale(le.id_weight100,s.id_switch));
  integer2 fname_score := MAP( le.fname_isnull or ri.fname_isnull => 0,
                        le.fname = ri.fname  => le.fname_weight100,
                        SALT20.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  integer2 lname_score := MAP( le.lname_isnull or ri.lname_isnull => 0,
                        le.lname = ri.lname  => le.lname_weight100,
                        SALT20.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  integer2 dob_score := MAP( le.dob_isnull or ri.dob_isnull => 0,
                        le.dob = ri.dob  => le.dob_weight100,
                        SALT20.Fn_Fail_Scale(le.dob_weight100,s.dob_switch));
  integer2 Own_Home_score := MAP( le.Own_Home_isnull or ri.Own_Home_isnull => 0,
                        le.Own_Home = ri.Own_Home  => le.Own_Home_weight100,
                        SALT20.Fn_Fail_Scale(le.Own_Home_weight100,s.Own_Home_switch));
  integer2 dlnum_score := MAP( le.dlnum_isnull or ri.dlnum_isnull => 0,
                        le.dlnum = ri.dlnum  => le.dlnum_weight100,
                        SALT20.Fn_Fail_Scale(le.dlnum_weight100,s.dlnum_switch));
  integer2 State_Of_License_score := MAP( le.State_Of_License_isnull or ri.State_Of_License_isnull => 0,
                        le.State_Of_License = ri.State_Of_License  => le.State_Of_License_weight100,
                        SALT20.Fn_Fail_Scale(le.State_Of_License_weight100,s.State_Of_License_switch));
  integer2 addr_score := MAP( le.addr_isnull or ri.addr_isnull => 0,
                        le.addr = ri.addr  => le.addr_weight100,
                        SALT20.Fn_Fail_Scale(le.addr_weight100,s.addr_switch));
  integer2 city_score := MAP( le.city_isnull or ri.city_isnull => 0,
                        le.city = ri.city  => le.city_weight100,
                        SALT20.Fn_Fail_Scale(le.city_weight100,s.city_switch));
  integer2 st_score := MAP( le.st_isnull or ri.st_isnull => 0,
                        le.st = ri.st  => le.st_weight100,
                        SALT20.Fn_Fail_Scale(le.st_weight100,s.st_switch));
  integer2 zip_score := MAP( le.zip_isnull or ri.zip_isnull => 0,
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT20.Fn_Fail_Scale(le.zip_weight100,s.zip_switch));
  integer2 Phone_Home_score := MAP( le.Phone_Home_isnull or ri.Phone_Home_isnull => 0,
                        le.Phone_Home = ri.Phone_Home  => le.Phone_Home_weight100,
                        SALT20.Fn_Fail_Scale(le.Phone_Home_weight100,s.Phone_Home_switch));
  integer2 Phone_Cell_score := MAP( le.Phone_Cell_isnull or ri.Phone_Cell_isnull => 0,
                        le.Phone_Cell = ri.Phone_Cell  => le.Phone_Cell_weight100,
                        SALT20.Fn_Fail_Scale(le.Phone_Cell_weight100,s.Phone_Cell_switch));
  integer2 Phone_Work_score := MAP( le.Phone_Work_isnull or ri.Phone_Work_isnull => 0,
                        le.Phone_Work = ri.Phone_Work  => le.Phone_Work_weight100,
                        SALT20.Fn_Fail_Scale(le.Phone_Work_weight100,s.Phone_Work_switch));
  integer2 EMAIL_score := MAP( le.EMAIL_isnull or ri.EMAIL_isnull => 0,
                        le.EMAIL = ri.EMAIL  => le.EMAIL_weight100,
                        SALT20.Fn_Fail_Scale(le.EMAIL_weight100,s.EMAIL_switch));
  integer2 ip_score := MAP( le.ip_isnull or ri.ip_isnull => 0,
                        le.ip = ri.ip  => le.ip_weight100,
                        SALT20.Fn_Fail_Scale(le.ip_weight100,s.ip_switch));
  integer2 dt_score := MAP( le.dt_isnull or ri.dt_isnull => 0,
                        le.dt = ri.dt  => le.dt_weight100,
                        SALT20.Fn_Fail_Scale(le.dt_weight100,s.dt_switch));
  integer2 INCOME_MONTHLY_score := MAP( le.INCOME_MONTHLY_isnull or ri.INCOME_MONTHLY_isnull => 0,
                        le.INCOME_MONTHLY = ri.INCOME_MONTHLY  => le.INCOME_MONTHLY_weight100,
                        SALT20.Fn_Fail_Scale(le.INCOME_MONTHLY_weight100,s.INCOME_MONTHLY_switch));
  integer2 Weekly_BiWeekly_score := MAP( le.Weekly_BiWeekly_isnull or ri.Weekly_BiWeekly_isnull => 0,
                        le.Weekly_BiWeekly = ri.Weekly_BiWeekly  => le.Weekly_BiWeekly_weight100,
                        SALT20.Fn_Fail_Scale(le.Weekly_BiWeekly_weight100,s.Weekly_BiWeekly_switch));
  integer2 MONTHSEMPLOYED_score := MAP( le.MONTHSEMPLOYED_isnull or ri.MONTHSEMPLOYED_isnull => 0,
                        le.MONTHSEMPLOYED = ri.MONTHSEMPLOYED  => le.MONTHSEMPLOYED_weight100,
                        SALT20.Fn_Fail_Scale(le.MONTHSEMPLOYED_weight100,s.MONTHSEMPLOYED_switch));
  integer2 MonthsAtBank_score := MAP( le.MonthsAtBank_isnull or ri.MonthsAtBank_isnull => 0,
                        le.MonthsAtBank = ri.MonthsAtBank  => le.MonthsAtBank_weight100,
                        SALT20.Fn_Fail_Scale(le.MonthsAtBank_weight100,s.MonthsAtBank_switch));
  integer2 employer_score := MAP( le.employer_isnull or ri.employer_isnull => 0,
                        le.employer = ri.employer  => le.employer_weight100,
                        SALT20.Fn_Fail_Scale(le.employer_weight100,s.employer_switch));
  integer2 Bank_score := MAP( le.Bank_isnull or ri.Bank_isnull => 0,
                        le.Bank = ri.Bank  => le.Bank_weight100,
                        SALT20.Fn_Fail_Scale(le.Bank_weight100,s.Bank_switch));
  self.Conf_Prop := (0
  ) / 100; // Score based on propogated fields
  iComp := (id_score + fname_score + lname_score + dob_score + Own_Home_score + dlnum_score + State_Of_License_score + addr_score + city_score + st_score + zip_score + Phone_Home_score + Phone_Cell_score + Phone_Work_score + EMAIL_score + ip_score + dt_score + INCOME_MONTHLY_score + Weekly_BiWeekly_score + MONTHSEMPLOYED_score + MonthsAtBank_score + employer_score + Bank_score) / 100 + outside;
  self.Conf := IF( iComp>=LowerMatchThreshold or iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
end;
//Now execute each of the 23 join conditions of which 0 have been optimized into preceding conditions
//Fixed fields ->:id(0)
dn0 := h(~id_isnull);
dn0_deduped := dn0(id_weight100>=0); // Use specificity to flag high-dup counts
mj0 := join( dn0_deduped, dn0_deduped, left. > right. and LEFT.id = RIGHT.id,match_join(left,right,0),atmost(LEFT.id = RIGHT.id,1000),skew(1));
//Fixed fields ->:fname(0)
dn1 := h(~fname_isnull);
dn1_deduped := dn1(fname_weight100>=0); // Use specificity to flag high-dup counts
mj1 := join( dn1_deduped, dn1_deduped, left. > right. and LEFT.fname = RIGHT.fname,match_join(left,right,1),atmost(LEFT.fname = RIGHT.fname,1000),skew(1));
//Fixed fields ->:lname(0)
dn2 := h(~lname_isnull);
dn2_deduped := dn2(lname_weight100>=0); // Use specificity to flag high-dup counts
mj2 := join( dn2_deduped, dn2_deduped, left. > right. and LEFT.lname = RIGHT.lname,match_join(left,right,2),atmost(LEFT.lname = RIGHT.lname,1000),skew(1));
//Fixed fields ->:dob(0)
dn3 := h(~dob_isnull);
dn3_deduped := dn3(dob_weight100>=0); // Use specificity to flag high-dup counts
mj3 := join( dn3_deduped, dn3_deduped, left. > right. and LEFT.dob = RIGHT.dob,match_join(left,right,3),atmost(LEFT.dob = RIGHT.dob,1000),skew(1));
//Fixed fields ->:Own_Home(0)
dn4 := h(~Own_Home_isnull);
dn4_deduped := dn4(Own_Home_weight100>=0); // Use specificity to flag high-dup counts
mj4 := join( dn4_deduped, dn4_deduped, left. > right. and LEFT.Own_Home = RIGHT.Own_Home,match_join(left,right,4),atmost(LEFT.Own_Home = RIGHT.Own_Home,1000),skew(1));
mjs0_t := mj0+mj1+mj2+mj3+mj4;
SALT20.mac_select_best_matches(mjs0_t,1,2,o0);
mjs0 := o0 : persist('temp::bell_thrive::::mj0');
//Fixed fields ->:dlnum(0)
dn5 := h(~dlnum_isnull);
dn5_deduped := dn5(dlnum_weight100>=0); // Use specificity to flag high-dup counts
mj5 := join( dn5_deduped, dn5_deduped, left. > right. and LEFT.dlnum = RIGHT.dlnum,match_join(left,right,5),atmost(LEFT.dlnum = RIGHT.dlnum,1000),skew(1));
//Fixed fields ->:State_Of_License(0)
dn6 := h(~State_Of_License_isnull);
dn6_deduped := dn6(State_Of_License_weight100>=0); // Use specificity to flag high-dup counts
mj6 := join( dn6_deduped, dn6_deduped, left. > right. and LEFT.State_Of_License = RIGHT.State_Of_License,match_join(left,right,6),atmost(LEFT.State_Of_License = RIGHT.State_Of_License,1000),skew(1));
//Fixed fields ->:addr(0)
dn7 := h(~addr_isnull);
dn7_deduped := dn7(addr_weight100>=0); // Use specificity to flag high-dup counts
mj7 := join( dn7_deduped, dn7_deduped, left. > right. and LEFT.addr = RIGHT.addr,match_join(left,right,7),atmost(LEFT.addr = RIGHT.addr,1000),skew(1));
//Fixed fields ->:city(0)
dn8 := h(~city_isnull);
dn8_deduped := dn8(city_weight100>=0); // Use specificity to flag high-dup counts
mj8 := join( dn8_deduped, dn8_deduped, left. > right. and LEFT.city = RIGHT.city,match_join(left,right,8),atmost(LEFT.city = RIGHT.city,1000),skew(1));
//Fixed fields ->:st(0)
dn9 := h(~st_isnull);
dn9_deduped := dn9(st_weight100>=0); // Use specificity to flag high-dup counts
mj9 := join( dn9_deduped, dn9_deduped, left. > right. and LEFT.st = RIGHT.st,match_join(left,right,9),atmost(LEFT.st = RIGHT.st,1000),skew(1));
mjs1_t := mj5+mj6+mj7+mj8+mj9;
SALT20.mac_select_best_matches(mjs1_t,1,2,o1);
mjs1 := o1 : persist('temp::bell_thrive::::mj1');
//Fixed fields ->:zip(0)
dn10 := h(~zip_isnull);
dn10_deduped := dn10(zip_weight100>=0); // Use specificity to flag high-dup counts
mj10 := join( dn10_deduped, dn10_deduped, left. > right. and LEFT.zip = RIGHT.zip,match_join(left,right,10),atmost(LEFT.zip = RIGHT.zip,1000),skew(1));
//Fixed fields ->:Phone_Home(0)
dn11 := h(~Phone_Home_isnull);
dn11_deduped := dn11(Phone_Home_weight100>=0); // Use specificity to flag high-dup counts
mj11 := join( dn11_deduped, dn11_deduped, left. > right. and LEFT.Phone_Home = RIGHT.Phone_Home,match_join(left,right,11),atmost(LEFT.Phone_Home = RIGHT.Phone_Home,1000),skew(1));
//Fixed fields ->:Phone_Cell(0)
dn12 := h(~Phone_Cell_isnull);
dn12_deduped := dn12(Phone_Cell_weight100>=0); // Use specificity to flag high-dup counts
mj12 := join( dn12_deduped, dn12_deduped, left. > right. and LEFT.Phone_Cell = RIGHT.Phone_Cell,match_join(left,right,12),atmost(LEFT.Phone_Cell = RIGHT.Phone_Cell,1000),skew(1));
//Fixed fields ->:Phone_Work(0)
dn13 := h(~Phone_Work_isnull);
dn13_deduped := dn13(Phone_Work_weight100>=0); // Use specificity to flag high-dup counts
mj13 := join( dn13_deduped, dn13_deduped, left. > right. and LEFT.Phone_Work = RIGHT.Phone_Work,match_join(left,right,13),atmost(LEFT.Phone_Work = RIGHT.Phone_Work,1000),skew(1));
//Fixed fields ->:EMAIL(0)
dn14 := h(~EMAIL_isnull);
dn14_deduped := dn14(EMAIL_weight100>=0); // Use specificity to flag high-dup counts
mj14 := join( dn14_deduped, dn14_deduped, left. > right. and LEFT.EMAIL = RIGHT.EMAIL,match_join(left,right,14),atmost(LEFT.EMAIL = RIGHT.EMAIL,1000),skew(1));
mjs2_t := mj10+mj11+mj12+mj13+mj14;
SALT20.mac_select_best_matches(mjs2_t,1,2,o2);
mjs2 := o2 : persist('temp::bell_thrive::::mj2');
//Fixed fields ->:ip(0)
dn15 := h(~ip_isnull);
dn15_deduped := dn15(ip_weight100>=0); // Use specificity to flag high-dup counts
mj15 := join( dn15_deduped, dn15_deduped, left. > right. and LEFT.ip = RIGHT.ip,match_join(left,right,15),atmost(LEFT.ip = RIGHT.ip,1000),skew(1));
//Fixed fields ->:dt(0)
dn16 := h(~dt_isnull);
dn16_deduped := dn16(dt_weight100>=0); // Use specificity to flag high-dup counts
mj16 := join( dn16_deduped, dn16_deduped, left. > right. and LEFT.dt = RIGHT.dt,match_join(left,right,16),atmost(LEFT.dt = RIGHT.dt,1000),skew(1));
//Fixed fields ->:INCOME_MONTHLY(0)
dn17 := h(~INCOME_MONTHLY_isnull);
dn17_deduped := dn17(INCOME_MONTHLY_weight100>=0); // Use specificity to flag high-dup counts
mj17 := join( dn17_deduped, dn17_deduped, left. > right. and LEFT.INCOME_MONTHLY = RIGHT.INCOME_MONTHLY,match_join(left,right,17),atmost(LEFT.INCOME_MONTHLY = RIGHT.INCOME_MONTHLY,1000),skew(1));
//Fixed fields ->:Weekly_BiWeekly(0)
dn18 := h(~Weekly_BiWeekly_isnull);
dn18_deduped := dn18(Weekly_BiWeekly_weight100>=0); // Use specificity to flag high-dup counts
mj18 := join( dn18_deduped, dn18_deduped, left. > right. and LEFT.Weekly_BiWeekly = RIGHT.Weekly_BiWeekly,match_join(left,right,18),atmost(LEFT.Weekly_BiWeekly = RIGHT.Weekly_BiWeekly,1000),skew(1));
//Fixed fields ->:MONTHSEMPLOYED(0)
dn19 := h(~MONTHSEMPLOYED_isnull);
dn19_deduped := dn19(MONTHSEMPLOYED_weight100>=0); // Use specificity to flag high-dup counts
mj19 := join( dn19_deduped, dn19_deduped, left. > right. and LEFT.MONTHSEMPLOYED = RIGHT.MONTHSEMPLOYED,match_join(left,right,19),atmost(LEFT.MONTHSEMPLOYED = RIGHT.MONTHSEMPLOYED,1000),skew(1));
mjs3_t := mj15+mj16+mj17+mj18+mj19;
SALT20.mac_select_best_matches(mjs3_t,1,2,o3);
mjs3 := o3 : persist('temp::bell_thrive::::mj3');
//Fixed fields ->:MonthsAtBank(0)
dn20 := h(~MonthsAtBank_isnull);
dn20_deduped := dn20(MonthsAtBank_weight100>=0); // Use specificity to flag high-dup counts
mj20 := join( dn20_deduped, dn20_deduped, left. > right. and LEFT.MonthsAtBank = RIGHT.MonthsAtBank,match_join(left,right,20),atmost(LEFT.MonthsAtBank = RIGHT.MonthsAtBank,1000),skew(1));
//Fixed fields ->:employer(0)
dn21 := h(~employer_isnull);
dn21_deduped := dn21(employer_weight100>=0); // Use specificity to flag high-dup counts
mj21 := join( dn21_deduped, dn21_deduped, left. > right. and LEFT.employer = RIGHT.employer,match_join(left,right,21),atmost(LEFT.employer = RIGHT.employer,1000),skew(1));
//Fixed fields ->:Bank(0)
dn22 := h(~Bank_isnull);
dn22_deduped := dn22(Bank_weight100>=0); // Use specificity to flag high-dup counts
mj22 := join( dn22_deduped, dn22_deduped, left. > right. and LEFT.Bank = RIGHT.Bank,match_join(left,right,22),atmost(LEFT.Bank = RIGHT.Bank,1000),skew(1));
last_mjs_t :=mj20+mj21+mj22;
SALT20.mac_select_best_matches(last_mjs_t,1,2,o);
shared all_mjs :=  mjs0+ mjs1+ mjs2+ mjs3 +o;
export All_Matches := all_mjs : persist('temp::bell_thrive__files().input.used_all_m'); // To by used by  and 
SALT20.mac_avoid_transitives(All_Matches,1,2,Conf,DateOverlap,Rule,o);
export PossibleMatches := o : persist('temp::bell_thrive__files().input.used_mt');
SALT20.mac_get_BestPerRecord( All_Matches,1,1,2,2,o );
export BestPerRecord := o : persist('temp::bell_thrive__files().input.used_mr');
//Now lets see if any slice-outs are needed
in_matches := join(h,h,left.=right. and (>string6<)left.<>(>string6<)right.,match_join(left,right,9999),local);
SALT20.mac_cluster_breadth(in_matches,1,2,1,o);
o1 := join(o,Specificities(ih).ClusterSizes,left.1=right.,local);
export ClusterLinkages := o1 : persist('temp::bell_thrive__files().input.used_clu');
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
