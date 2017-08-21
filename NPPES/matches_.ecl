// Begin code to perform the matching itself
import SALT19,ut;
export matches(dataset(layout_FileIN) ih,unsigned MatchThreshold = 0) := module
shared LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
shared h := match_candidates(ih).candidates;
shared s := Specificities(ih).Specificities[1];
shared match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,unsigned2 c,unsigned outside=0) := transform
  self.Rule := c;
  self.1 := le.;
  self.2 := ri.;
  self.1 := le.;
  self.2 := ri.;
  integer2 did_score := MAP( le.did_isnull or ri.did_isnull => 0,
                        le.did = ri.did  => le.did_weight100,
                        SALT19.Fn_Fail_Scale(le.did_weight100,s.did_switch));
  integer2 src_score := MAP( le.src_isnull or ri.src_isnull => 0,
                        le.src = ri.src  => le.src_weight100,
                        SALT19.Fn_Fail_Scale(le.src_weight100,s.src_switch));
  integer2 dt_first_seen_score := MAP( le.dt_first_seen_isnull or ri.dt_first_seen_isnull => 0,
                        le.dt_first_seen = ri.dt_first_seen  => le.dt_first_seen_weight100,
                        SALT19.Fn_Fail_Scale(le.dt_first_seen_weight100,s.dt_first_seen_switch));
  integer2 dt_last_seen_score := MAP( le.dt_last_seen_isnull or ri.dt_last_seen_isnull => 0,
                        le.dt_last_seen = ri.dt_last_seen  => le.dt_last_seen_weight100,
                        SALT19.Fn_Fail_Scale(le.dt_last_seen_weight100,s.dt_last_seen_switch));
  integer2 dt_vendor_first_reported_score := MAP( le.dt_vendor_first_reported_isnull or ri.dt_vendor_first_reported_isnull => 0,
                        le.dt_vendor_first_reported = ri.dt_vendor_first_reported  => le.dt_vendor_first_reported_weight100,
                        SALT19.Fn_Fail_Scale(le.dt_vendor_first_reported_weight100,s.dt_vendor_first_reported_switch));
  integer2 dt_vendor_last_reported_score := MAP( le.dt_vendor_last_reported_isnull or ri.dt_vendor_last_reported_isnull => 0,
                        le.dt_vendor_last_reported = ri.dt_vendor_last_reported  => le.dt_vendor_last_reported_weight100,
                        SALT19.Fn_Fail_Scale(le.dt_vendor_last_reported_weight100,s.dt_vendor_last_reported_switch));
  integer2 vendor_id_score := MAP( le.vendor_id_isnull or ri.vendor_id_isnull => 0,
                        le.vendor_id = ri.vendor_id  => le.vendor_id_weight100,
                        SALT19.Fn_Fail_Scale(le.vendor_id_weight100,s.vendor_id_switch));
  integer2 phone_score := MAP( le.phone_isnull or ri.phone_isnull => 0,
                        le.phone = ri.phone  => le.phone_weight100,
                        SALT19.Fn_Fail_Scale(le.phone_weight100,s.phone_switch));
  integer2 title_score := MAP( le.title_isnull or ri.title_isnull => 0,
                        le.title = ri.title  => le.title_weight100,
                        SALT19.Fn_Fail_Scale(le.title_weight100,s.title_switch));
  integer2 fname_score := MAP( le.fname_isnull or ri.fname_isnull => 0,
                        le.fname = ri.fname  => le.fname_weight100,
                        SALT19.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  integer2 mname_score := MAP( le.mname_isnull or ri.mname_isnull => 0,
                        le.mname = ri.mname  => le.mname_weight100,
                        SALT19.Fn_Fail_Scale(le.mname_weight100,s.mname_switch));
  integer2 lname_score := MAP( le.lname_isnull or ri.lname_isnull => 0,
                        le.lname = ri.lname  => le.lname_weight100,
                        SALT19.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  integer2 name_suffix_score := MAP( le.name_suffix_isnull or ri.name_suffix_isnull => 0,
                        le.name_suffix = ri.name_suffix  => le.name_suffix_weight100,
                        SALT19.Fn_Fail_Scale(le.name_suffix_weight100,s.name_suffix_switch));
  integer2 prim_range_score := MAP( le.prim_range_isnull or ri.prim_range_isnull => 0,
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT19.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch));
  integer2 predir_score := MAP( le.predir_isnull or ri.predir_isnull => 0,
                        le.predir = ri.predir  => le.predir_weight100,
                        SALT19.Fn_Fail_Scale(le.predir_weight100,s.predir_switch));
  integer2 prim_name_score := MAP( le.prim_name_isnull or ri.prim_name_isnull => 0,
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT19.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch));
  integer2 suffix_score := MAP( le.suffix_isnull or ri.suffix_isnull => 0,
                        le.suffix = ri.suffix  => le.suffix_weight100,
                        SALT19.Fn_Fail_Scale(le.suffix_weight100,s.suffix_switch));
  integer2 postdir_score := MAP( le.postdir_isnull or ri.postdir_isnull => 0,
                        le.postdir = ri.postdir  => le.postdir_weight100,
                        SALT19.Fn_Fail_Scale(le.postdir_weight100,s.postdir_switch));
  integer2 unit_desig_score := MAP( le.unit_desig_isnull or ri.unit_desig_isnull => 0,
                        le.unit_desig = ri.unit_desig  => le.unit_desig_weight100,
                        SALT19.Fn_Fail_Scale(le.unit_desig_weight100,s.unit_desig_switch));
  integer2 sec_range_score := MAP( le.sec_range_isnull or ri.sec_range_isnull => 0,
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT19.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch));
  integer2 city_name_score := MAP( le.city_name_isnull or ri.city_name_isnull => 0,
                        le.city_name = ri.city_name  => le.city_name_weight100,
                        SALT19.Fn_Fail_Scale(le.city_name_weight100,s.city_name_switch));
  integer2 st_score := MAP( le.st_isnull or ri.st_isnull => 0,
                        le.st = ri.st  => le.st_weight100,
                        SALT19.Fn_Fail_Scale(le.st_weight100,s.st_switch));
  integer2 zip_score := MAP( le.zip_isnull or ri.zip_isnull => 0,
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT19.Fn_Fail_Scale(le.zip_weight100,s.zip_switch));
  integer2 zip4_score := MAP( le.zip4_isnull or ri.zip4_isnull => 0,
                        le.zip4 = ri.zip4  => le.zip4_weight100,
                        SALT19.Fn_Fail_Scale(le.zip4_weight100,s.zip4_switch));
  integer2 county_score := MAP( le.county_isnull or ri.county_isnull => 0,
                        le.county = ri.county  => le.county_weight100,
                        SALT19.Fn_Fail_Scale(le.county_weight100,s.county_switch));
  integer2 msa_score := MAP( le.msa_isnull or ri.msa_isnull => 0,
                        le.msa = ri.msa  => le.msa_weight100,
                        SALT19.Fn_Fail_Scale(le.msa_weight100,s.msa_switch));
  integer2 geo_blk_score := MAP( le.geo_blk_isnull or ri.geo_blk_isnull => 0,
                        le.geo_blk = ri.geo_blk  => le.geo_blk_weight100,
                        SALT19.Fn_Fail_Scale(le.geo_blk_weight100,s.geo_blk_switch));
  integer2 RawAID_score := MAP( le.RawAID_isnull or ri.RawAID_isnull => 0,
                        le.RawAID = ri.RawAID  => le.RawAID_weight100,
                        SALT19.Fn_Fail_Scale(le.RawAID_weight100,s.RawAID_switch));
  self.Conf_Prop := (0
  ) / 100; // Score based on propogated fields
  iComp := (did_score + src_score + dt_first_seen_score + dt_last_seen_score + dt_vendor_first_reported_score + dt_vendor_last_reported_score + vendor_id_score + phone_score + title_score + fname_score + mname_score + lname_score + name_suffix_score + prim_range_score + predir_score + prim_name_score + suffix_score + postdir_score + unit_desig_score + sec_range_score + city_name_score + st_score + zip_score + zip4_score + county_score + msa_score + geo_blk_score + RawAID_score) / 100 + outside;
  self.Conf := IF( iComp>=LowerMatchThreshold or iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
end;
//Now execute each of the 28 join conditions of which 0 have been optimized into preceding conditions
//Fixed fields ->:did(0)
dn0 := h(~did_isnull);
dn0_deduped := dn0(did_weight100>=0); // Use specificity to flag high-dup counts
mj0 := join( dn0_deduped, dn0_deduped, left. > right. and left.did = right.did,match_join(left,right,0),atmost(left.did = right.did,1000),skew(1));
//Fixed fields ->:src(0)
dn1 := h(~src_isnull);
dn1_deduped := dn1(src_weight100>=0); // Use specificity to flag high-dup counts
mj1 := join( dn1_deduped, dn1_deduped, left. > right. and left.src = right.src,match_join(left,right,1),atmost(left.src = right.src,1000),skew(1));
//Fixed fields ->:dt_first_seen(0)
dn2 := h(~dt_first_seen_isnull);
dn2_deduped := dn2(dt_first_seen_weight100>=0); // Use specificity to flag high-dup counts
mj2 := join( dn2_deduped, dn2_deduped, left. > right. and left.dt_first_seen = right.dt_first_seen,match_join(left,right,2),atmost(left.dt_first_seen = right.dt_first_seen,1000),skew(1));
//Fixed fields ->:dt_last_seen(0)
dn3 := h(~dt_last_seen_isnull);
dn3_deduped := dn3(dt_last_seen_weight100>=0); // Use specificity to flag high-dup counts
mj3 := join( dn3_deduped, dn3_deduped, left. > right. and left.dt_last_seen = right.dt_last_seen,match_join(left,right,3),atmost(left.dt_last_seen = right.dt_last_seen,1000),skew(1));
//Fixed fields ->:dt_vendor_first_reported(0)
dn4 := h(~dt_vendor_first_reported_isnull);
dn4_deduped := dn4(dt_vendor_first_reported_weight100>=0); // Use specificity to flag high-dup counts
mj4 := join( dn4_deduped, dn4_deduped, left. > right. and left.dt_vendor_first_reported = right.dt_vendor_first_reported,match_join(left,right,4),atmost(left.dt_vendor_first_reported = right.dt_vendor_first_reported,1000),skew(1));
mjs0_t := mj0+mj1+mj2+mj3+mj4;
SALT19.mac_select_best_matches(mjs0_t,1,2,o0);
mjs0 := o0 : persist('temp::::mj0');
//Fixed fields ->:dt_vendor_last_reported(0)
dn5 := h(~dt_vendor_last_reported_isnull);
dn5_deduped := dn5(dt_vendor_last_reported_weight100>=0); // Use specificity to flag high-dup counts
mj5 := join( dn5_deduped, dn5_deduped, left. > right. and left.dt_vendor_last_reported = right.dt_vendor_last_reported,match_join(left,right,5),atmost(left.dt_vendor_last_reported = right.dt_vendor_last_reported,1000),skew(1));
//Fixed fields ->:vendor_id(0)
dn6 := h(~vendor_id_isnull);
dn6_deduped := dn6(vendor_id_weight100>=0); // Use specificity to flag high-dup counts
mj6 := join( dn6_deduped, dn6_deduped, left. > right. and left.vendor_id = right.vendor_id,match_join(left,right,6),atmost(left.vendor_id = right.vendor_id,1000),skew(1));
//Fixed fields ->:phone(0)
dn7 := h(~phone_isnull);
dn7_deduped := dn7(phone_weight100>=0); // Use specificity to flag high-dup counts
mj7 := join( dn7_deduped, dn7_deduped, left. > right. and left.phone = right.phone,match_join(left,right,7),atmost(left.phone = right.phone,1000),skew(1));
//Fixed fields ->:title(0)
dn8 := h(~title_isnull);
dn8_deduped := dn8(title_weight100>=0); // Use specificity to flag high-dup counts
mj8 := join( dn8_deduped, dn8_deduped, left. > right. and left.title = right.title,match_join(left,right,8),atmost(left.title = right.title,1000),skew(1));
//Fixed fields ->:fname(0)
dn9 := h(~fname_isnull);
dn9_deduped := dn9(fname_weight100>=0); // Use specificity to flag high-dup counts
mj9 := join( dn9_deduped, dn9_deduped, left. > right. and left.fname = right.fname,match_join(left,right,9),atmost(left.fname = right.fname,1000),skew(1));
mjs1_t := mj5+mj6+mj7+mj8+mj9;
SALT19.mac_select_best_matches(mjs1_t,1,2,o1);
mjs1 := o1 : persist('temp::::mj1');
//Fixed fields ->:mname(0)
dn10 := h(~mname_isnull);
dn10_deduped := dn10(mname_weight100>=0); // Use specificity to flag high-dup counts
mj10 := join( dn10_deduped, dn10_deduped, left. > right. and left.mname = right.mname,match_join(left,right,10),atmost(left.mname = right.mname,1000),skew(1));
//Fixed fields ->:lname(0)
dn11 := h(~lname_isnull);
dn11_deduped := dn11(lname_weight100>=0); // Use specificity to flag high-dup counts
mj11 := join( dn11_deduped, dn11_deduped, left. > right. and left.lname = right.lname,match_join(left,right,11),atmost(left.lname = right.lname,1000),skew(1));
//Fixed fields ->:name_suffix(0)
dn12 := h(~name_suffix_isnull);
dn12_deduped := dn12(name_suffix_weight100>=0); // Use specificity to flag high-dup counts
mj12 := join( dn12_deduped, dn12_deduped, left. > right. and left.name_suffix = right.name_suffix,match_join(left,right,12),atmost(left.name_suffix = right.name_suffix,1000),skew(1));
//Fixed fields ->:prim_range(0)
dn13 := h(~prim_range_isnull);
dn13_deduped := dn13(prim_range_weight100>=0); // Use specificity to flag high-dup counts
mj13 := join( dn13_deduped, dn13_deduped, left. > right. and left.prim_range = right.prim_range,match_join(left,right,13),atmost(left.prim_range = right.prim_range,1000),skew(1));
//Fixed fields ->:predir(0)
dn14 := h(~predir_isnull);
dn14_deduped := dn14(predir_weight100>=0); // Use specificity to flag high-dup counts
mj14 := join( dn14_deduped, dn14_deduped, left. > right. and left.predir = right.predir,match_join(left,right,14),atmost(left.predir = right.predir,1000),skew(1));
mjs2_t := mj10+mj11+mj12+mj13+mj14;
SALT19.mac_select_best_matches(mjs2_t,1,2,o2);
mjs2 := o2 : persist('temp::::mj2');
//Fixed fields ->:prim_name(0)
dn15 := h(~prim_name_isnull);
dn15_deduped := dn15(prim_name_weight100>=0); // Use specificity to flag high-dup counts
mj15 := join( dn15_deduped, dn15_deduped, left. > right. and left.prim_name = right.prim_name,match_join(left,right,15),atmost(left.prim_name = right.prim_name,1000),skew(1));
//Fixed fields ->:suffix(0)
dn16 := h(~suffix_isnull);
dn16_deduped := dn16(suffix_weight100>=0); // Use specificity to flag high-dup counts
mj16 := join( dn16_deduped, dn16_deduped, left. > right. and left.suffix = right.suffix,match_join(left,right,16),atmost(left.suffix = right.suffix,1000),skew(1));
//Fixed fields ->:postdir(0)
dn17 := h(~postdir_isnull);
dn17_deduped := dn17(postdir_weight100>=0); // Use specificity to flag high-dup counts
mj17 := join( dn17_deduped, dn17_deduped, left. > right. and left.postdir = right.postdir,match_join(left,right,17),atmost(left.postdir = right.postdir,1000),skew(1));
//Fixed fields ->:unit_desig(0)
dn18 := h(~unit_desig_isnull);
dn18_deduped := dn18(unit_desig_weight100>=0); // Use specificity to flag high-dup counts
mj18 := join( dn18_deduped, dn18_deduped, left. > right. and left.unit_desig = right.unit_desig,match_join(left,right,18),atmost(left.unit_desig = right.unit_desig,1000),skew(1));
//Fixed fields ->:sec_range(0)
dn19 := h(~sec_range_isnull);
dn19_deduped := dn19(sec_range_weight100>=0); // Use specificity to flag high-dup counts
mj19 := join( dn19_deduped, dn19_deduped, left. > right. and left.sec_range = right.sec_range,match_join(left,right,19),atmost(left.sec_range = right.sec_range,1000),skew(1));
mjs3_t := mj15+mj16+mj17+mj18+mj19;
SALT19.mac_select_best_matches(mjs3_t,1,2,o3);
mjs3 := o3 : persist('temp::::mj3');
//Fixed fields ->:city_name(0)
dn20 := h(~city_name_isnull);
dn20_deduped := dn20(city_name_weight100>=0); // Use specificity to flag high-dup counts
mj20 := join( dn20_deduped, dn20_deduped, left. > right. and left.city_name = right.city_name,match_join(left,right,20),atmost(left.city_name = right.city_name,1000),skew(1));
//Fixed fields ->:st(0)
dn21 := h(~st_isnull);
dn21_deduped := dn21(st_weight100>=0); // Use specificity to flag high-dup counts
mj21 := join( dn21_deduped, dn21_deduped, left. > right. and left.st = right.st,match_join(left,right,21),atmost(left.st = right.st,1000),skew(1));
//Fixed fields ->:zip(0)
dn22 := h(~zip_isnull);
dn22_deduped := dn22(zip_weight100>=0); // Use specificity to flag high-dup counts
mj22 := join( dn22_deduped, dn22_deduped, left. > right. and left.zip = right.zip,match_join(left,right,22),atmost(left.zip = right.zip,1000),skew(1));
//Fixed fields ->:zip4(0)
dn23 := h(~zip4_isnull);
dn23_deduped := dn23(zip4_weight100>=0); // Use specificity to flag high-dup counts
mj23 := join( dn23_deduped, dn23_deduped, left. > right. and left.zip4 = right.zip4,match_join(left,right,23),atmost(left.zip4 = right.zip4,1000),skew(1));
//Fixed fields ->:county(0)
dn24 := h(~county_isnull);
dn24_deduped := dn24(county_weight100>=0); // Use specificity to flag high-dup counts
mj24 := join( dn24_deduped, dn24_deduped, left. > right. and left.county = right.county,match_join(left,right,24),atmost(left.county = right.county,1000),skew(1));
mjs4_t := mj20+mj21+mj22+mj23+mj24;
SALT19.mac_select_best_matches(mjs4_t,1,2,o4);
mjs4 := o4 : persist('temp::::mj4');
//Fixed fields ->:msa(0)
dn25 := h(~msa_isnull);
dn25_deduped := dn25(msa_weight100>=0); // Use specificity to flag high-dup counts
mj25 := join( dn25_deduped, dn25_deduped, left. > right. and left.msa = right.msa,match_join(left,right,25),atmost(left.msa = right.msa,1000),skew(1));
//Fixed fields ->:geo_blk(0)
dn26 := h(~geo_blk_isnull);
dn26_deduped := dn26(geo_blk_weight100>=0); // Use specificity to flag high-dup counts
mj26 := join( dn26_deduped, dn26_deduped, left. > right. and left.geo_blk = right.geo_blk,match_join(left,right,26),atmost(left.geo_blk = right.geo_blk,1000),skew(1));
//Fixed fields ->:RawAID(0)
dn27 := h(~RawAID_isnull);
dn27_deduped := dn27(RawAID_weight100>=0); // Use specificity to flag high-dup counts
mj27 := join( dn27_deduped, dn27_deduped, left. > right. and left.RawAID = right.RawAID,match_join(left,right,27),atmost(left.RawAID = right.RawAID,1000),skew(1));
last_mjs_t :=mj25+mj26+mj27;
SALT19.mac_select_best_matches(last_mjs_t,1,2,o);
shared all_mjs :=  mjs0+ mjs1+ mjs2+ mjs3+ mjs4 +o;
export All_Matches := all_mjs : persist('temp::NPPES__FileIN_all_m'); // To by used by  and 
SALT19.mac_avoid_transitives(All_Matches,1,2,Conf,DateOverlap,Rule,o);
export PossibleMatches := o : persist('temp::NPPES__FileIN_mt');
SALT19.mac_get_BestPerRecord( All_Matches,1,1,2,2,o );
export BestPerRecord := o : persist('temp::NPPES__FileIN_mr');
//Now lets see if any slice-outs are needed
in_matches := join(h,h,left.=right. and (>string6<)left.<>(>string6<)right.,match_join(left,right,9999),local);
SALT19.mac_cluster_breadth(in_matches,1,2,1,o);
o1 := join(o,Specificities(ih).ClusterSizes,left.1=right.,local);
export ClusterLinkages := o1 : persist('temp::NPPES__FileIN_clu');
export ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT19.UIDType ;  //Outcast
  SALT19.UIDType ;  // Outcase within
  integer2 Closest; // Best present link
  SALT19.UIDType Pref_; // Prefers this record
  SALT19.UIDType Pref_; // Prefers this cluster
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
SALT19.MAC_Avoid_SliceOuts(PossibleMatches,1,2,,Pref_,ToSlice,m); // If  is slice target - don't use in match
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
SALT19.MAC_SliceOut_ByRID(ih,,,ToSlice,,sliced); // Execute Sliceouts
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
