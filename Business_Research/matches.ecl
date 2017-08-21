// Begin code to perform the matching itself
import SALT20,ut;
export matches(dataset(layout_as_bh) ih,unsigned MatchThreshold = 0) := module
shared LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
shared h := match_candidates(ih).candidates;
shared s := Specificities(ih).Specificities[1];
shared match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,unsigned2 c,unsigned outside=0) := transform
  self.Rule := c;
  self.1 := le.;
  self.2 := ri.;
  self.1 := le.;
  self.2 := ri.;
  integer2 rcid_score := MAP( le.rcid_isnull or ri.rcid_isnull => 0,
                        le.rcid = ri.rcid  => le.rcid_weight100,
                        SALT20.Fn_Fail_Scale(le.rcid_weight100,s.rcid_switch));
  integer2 bdid_score := MAP( le.bdid_isnull or ri.bdid_isnull => 0,
                        le.bdid = ri.bdid  => le.bdid_weight100,
                        SALT20.Fn_Fail_Scale(le.bdid_weight100,s.bdid_switch));
  integer2 source_score := MAP( le.source_isnull or ri.source_isnull => 0,
                        le.source = ri.source  => le.source_weight100,
                        SALT20.Fn_Fail_Scale(le.source_weight100,s.source_switch));
  integer2 source_group_score := MAP( le.source_group_isnull or ri.source_group_isnull => 0,
                        le.source_group = ri.source_group  => le.source_group_weight100,
                        SALT20.Fn_Fail_Scale(le.source_group_weight100,s.source_group_switch));
  integer2 pflag_score := MAP( le.pflag_isnull or ri.pflag_isnull => 0,
                        le.pflag = ri.pflag  => le.pflag_weight100,
                        SALT20.Fn_Fail_Scale(le.pflag_weight100,s.pflag_switch));
  integer2 group1_id_score := MAP( le.group1_id_isnull or ri.group1_id_isnull => 0,
                        le.group1_id = ri.group1_id  => le.group1_id_weight100,
                        SALT20.Fn_Fail_Scale(le.group1_id_weight100,s.group1_id_switch));
  integer2 vendor_id_score := MAP( le.vendor_id_isnull or ri.vendor_id_isnull => 0,
                        le.vendor_id = ri.vendor_id  => le.vendor_id_weight100,
                        SALT20.Fn_Fail_Scale(le.vendor_id_weight100,s.vendor_id_switch));
  integer2 dt_first_seen_score := MAP( le.dt_first_seen_isnull or ri.dt_first_seen_isnull => 0,
                        le.dt_first_seen = ri.dt_first_seen  => le.dt_first_seen_weight100,
                        SALT20.Fn_Fail_Scale(le.dt_first_seen_weight100,s.dt_first_seen_switch));
  integer2 dt_last_seen_score := MAP( le.dt_last_seen_isnull or ri.dt_last_seen_isnull => 0,
                        le.dt_last_seen = ri.dt_last_seen  => le.dt_last_seen_weight100,
                        SALT20.Fn_Fail_Scale(le.dt_last_seen_weight100,s.dt_last_seen_switch));
  integer2 dt_vendor_first_reported_score := MAP( le.dt_vendor_first_reported_isnull or ri.dt_vendor_first_reported_isnull => 0,
                        le.dt_vendor_first_reported = ri.dt_vendor_first_reported  => le.dt_vendor_first_reported_weight100,
                        SALT20.Fn_Fail_Scale(le.dt_vendor_first_reported_weight100,s.dt_vendor_first_reported_switch));
  integer2 dt_vendor_last_reported_score := MAP( le.dt_vendor_last_reported_isnull or ri.dt_vendor_last_reported_isnull => 0,
                        le.dt_vendor_last_reported = ri.dt_vendor_last_reported  => le.dt_vendor_last_reported_weight100,
                        SALT20.Fn_Fail_Scale(le.dt_vendor_last_reported_weight100,s.dt_vendor_last_reported_switch));
  integer2 company_name_score := MAP( le.company_name_isnull or ri.company_name_isnull => 0,
                        le.company_name = ri.company_name  => le.company_name_weight100,
                        SALT20.Fn_Fail_Scale(le.company_name_weight100,s.company_name_switch));
  integer2 prim_range_score := MAP( le.prim_range_isnull or ri.prim_range_isnull => 0,
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT20.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch));
  integer2 predir_score := MAP( le.predir_isnull or ri.predir_isnull => 0,
                        le.predir = ri.predir  => le.predir_weight100,
                        SALT20.Fn_Fail_Scale(le.predir_weight100,s.predir_switch));
  integer2 prim_name_score := MAP( le.prim_name_isnull or ri.prim_name_isnull => 0,
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT20.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch));
  integer2 addr_suffix_score := MAP( le.addr_suffix_isnull or ri.addr_suffix_isnull => 0,
                        le.addr_suffix = ri.addr_suffix  => le.addr_suffix_weight100,
                        SALT20.Fn_Fail_Scale(le.addr_suffix_weight100,s.addr_suffix_switch));
  integer2 postdir_score := MAP( le.postdir_isnull or ri.postdir_isnull => 0,
                        le.postdir = ri.postdir  => le.postdir_weight100,
                        SALT20.Fn_Fail_Scale(le.postdir_weight100,s.postdir_switch));
  integer2 unit_desig_score := MAP( le.unit_desig_isnull or ri.unit_desig_isnull => 0,
                        le.unit_desig = ri.unit_desig  => le.unit_desig_weight100,
                        SALT20.Fn_Fail_Scale(le.unit_desig_weight100,s.unit_desig_switch));
  integer2 sec_range_score := MAP( le.sec_range_isnull or ri.sec_range_isnull => 0,
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT20.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch));
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
  integer2 county_score := MAP( le.county_isnull or ri.county_isnull => 0,
                        le.county = ri.county  => le.county_weight100,
                        SALT20.Fn_Fail_Scale(le.county_weight100,s.county_switch));
  integer2 msa_score := MAP( le.msa_isnull or ri.msa_isnull => 0,
                        le.msa = ri.msa  => le.msa_weight100,
                        SALT20.Fn_Fail_Scale(le.msa_weight100,s.msa_switch));
  integer2 geo_lat_score := MAP( le.geo_lat_isnull or ri.geo_lat_isnull => 0,
                        le.geo_lat = ri.geo_lat  => le.geo_lat_weight100,
                        SALT20.Fn_Fail_Scale(le.geo_lat_weight100,s.geo_lat_switch));
  integer2 geo_long_score := MAP( le.geo_long_isnull or ri.geo_long_isnull => 0,
                        le.geo_long = ri.geo_long  => le.geo_long_weight100,
                        SALT20.Fn_Fail_Scale(le.geo_long_weight100,s.geo_long_switch));
  integer2 phone_score := MAP( le.phone_isnull or ri.phone_isnull => 0,
                        le.phone = ri.phone  => le.phone_weight100,
                        SALT20.Fn_Fail_Scale(le.phone_weight100,s.phone_switch));
  integer2 phone_score_score := MAP( le.phone_score_isnull or ri.phone_score_isnull => 0,
                        le.phone_score = ri.phone_score  => le.phone_score_weight100,
                        SALT20.Fn_Fail_Scale(le.phone_score_weight100,s.phone_score_switch));
  integer2 fein_score := MAP( le.fein_isnull or ri.fein_isnull => 0,
                        le.fein = ri.fein  => le.fein_weight100,
                        SALT20.Fn_Fail_Scale(le.fein_weight100,s.fein_switch));
  integer2 current_score := MAP( le.current_isnull or ri.current_isnull => 0,
                        le.current = ri.current  => le.current_weight100,
                        SALT20.Fn_Fail_Scale(le.current_weight100,s.current_switch));
  integer2 dppa_score := MAP( le.dppa_isnull or ri.dppa_isnull => 0,
                        le.dppa = ri.dppa  => le.dppa_weight100,
                        SALT20.Fn_Fail_Scale(le.dppa_weight100,s.dppa_switch));
  integer2 vl_id_score := MAP( le.vl_id_isnull or ri.vl_id_isnull => 0,
                        le.vl_id = ri.vl_id  => le.vl_id_weight100,
                        SALT20.Fn_Fail_Scale(le.vl_id_weight100,s.vl_id_switch));
  integer2 RawAID_score := MAP( le.RawAID_isnull or ri.RawAID_isnull => 0,
                        le.RawAID = ri.RawAID  => le.RawAID_weight100,
                        SALT20.Fn_Fail_Scale(le.RawAID_weight100,s.RawAID_switch));
  self.Conf_Prop := (0
  ) / 100; // Score based on propogated fields
  iComp := (rcid_score + bdid_score + source_score + source_group_score + pflag_score + group1_id_score + vendor_id_score + dt_first_seen_score + dt_last_seen_score + dt_vendor_first_reported_score + dt_vendor_last_reported_score + company_name_score + prim_range_score + predir_score + prim_name_score + addr_suffix_score + postdir_score + unit_desig_score + sec_range_score + city_score + state_score + zip_score + zip4_score + county_score + msa_score + geo_lat_score + geo_long_score + phone_score + phone_score_score + fein_score + current_score + dppa_score + vl_id_score + RawAID_score) / 100 + outside;
  self.Conf := IF( iComp>=LowerMatchThreshold or iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
end;
//Now execute each of the 34 join conditions of which 0 have been optimized into preceding conditions
//Fixed fields ->:rcid(0)
dn0 := h(~rcid_isnull);
dn0_deduped := dn0(rcid_weight100>=0); // Use specificity to flag high-dup counts
mj0 := join( dn0_deduped, dn0_deduped, left. > right. and LEFT.rcid = RIGHT.rcid,match_join(left,right,0),atmost(LEFT.rcid = RIGHT.rcid,1000),skew(1));
//Fixed fields ->:bdid(0)
dn1 := h(~bdid_isnull);
dn1_deduped := dn1(bdid_weight100>=0); // Use specificity to flag high-dup counts
mj1 := join( dn1_deduped, dn1_deduped, left. > right. and LEFT.bdid = RIGHT.bdid,match_join(left,right,1),atmost(LEFT.bdid = RIGHT.bdid,1000),skew(1));
//Fixed fields ->:source(0)
dn2 := h(~source_isnull);
dn2_deduped := dn2(source_weight100>=0); // Use specificity to flag high-dup counts
mj2 := join( dn2_deduped, dn2_deduped, left. > right. and LEFT.source = RIGHT.source,match_join(left,right,2),atmost(LEFT.source = RIGHT.source,1000),skew(1));
//Fixed fields ->:source_group(0)
dn3 := h(~source_group_isnull);
dn3_deduped := dn3(source_group_weight100>=0); // Use specificity to flag high-dup counts
mj3 := join( dn3_deduped, dn3_deduped, left. > right. and LEFT.source_group = RIGHT.source_group,match_join(left,right,3),atmost(LEFT.source_group = RIGHT.source_group,1000),skew(1));
//Fixed fields ->:pflag(0)
dn4 := h(~pflag_isnull);
dn4_deduped := dn4(pflag_weight100>=0); // Use specificity to flag high-dup counts
mj4 := join( dn4_deduped, dn4_deduped, left. > right. and LEFT.pflag = RIGHT.pflag,match_join(left,right,4),atmost(LEFT.pflag = RIGHT.pflag,1000),skew(1));
mjs0_t := mj0+mj1+mj2+mj3+mj4;
SALT20.mac_select_best_matches(mjs0_t,1,2,o0);
mjs0 := o0 : persist('temp::Business_Research::::mj0');
//Fixed fields ->:group1_id(0)
dn5 := h(~group1_id_isnull);
dn5_deduped := dn5(group1_id_weight100>=0); // Use specificity to flag high-dup counts
mj5 := join( dn5_deduped, dn5_deduped, left. > right. and LEFT.group1_id = RIGHT.group1_id,match_join(left,right,5),atmost(LEFT.group1_id = RIGHT.group1_id,1000),skew(1));
//Fixed fields ->:vendor_id(0)
dn6 := h(~vendor_id_isnull);
dn6_deduped := dn6(vendor_id_weight100>=0); // Use specificity to flag high-dup counts
mj6 := join( dn6_deduped, dn6_deduped, left. > right. and LEFT.vendor_id = RIGHT.vendor_id,match_join(left,right,6),atmost(LEFT.vendor_id = RIGHT.vendor_id,1000),skew(1));
//Fixed fields ->:dt_first_seen(0)
dn7 := h(~dt_first_seen_isnull);
dn7_deduped := dn7(dt_first_seen_weight100>=0); // Use specificity to flag high-dup counts
mj7 := join( dn7_deduped, dn7_deduped, left. > right. and LEFT.dt_first_seen = RIGHT.dt_first_seen,match_join(left,right,7),atmost(LEFT.dt_first_seen = RIGHT.dt_first_seen,1000),skew(1));
//Fixed fields ->:dt_last_seen(0)
dn8 := h(~dt_last_seen_isnull);
dn8_deduped := dn8(dt_last_seen_weight100>=0); // Use specificity to flag high-dup counts
mj8 := join( dn8_deduped, dn8_deduped, left. > right. and LEFT.dt_last_seen = RIGHT.dt_last_seen,match_join(left,right,8),atmost(LEFT.dt_last_seen = RIGHT.dt_last_seen,1000),skew(1));
//Fixed fields ->:dt_vendor_first_reported(0)
dn9 := h(~dt_vendor_first_reported_isnull);
dn9_deduped := dn9(dt_vendor_first_reported_weight100>=0); // Use specificity to flag high-dup counts
mj9 := join( dn9_deduped, dn9_deduped, left. > right. and LEFT.dt_vendor_first_reported = RIGHT.dt_vendor_first_reported,match_join(left,right,9),atmost(LEFT.dt_vendor_first_reported = RIGHT.dt_vendor_first_reported,1000),skew(1));
mjs1_t := mj5+mj6+mj7+mj8+mj9;
SALT20.mac_select_best_matches(mjs1_t,1,2,o1);
mjs1 := o1 : persist('temp::Business_Research::::mj1');
//Fixed fields ->:dt_vendor_last_reported(0)
dn10 := h(~dt_vendor_last_reported_isnull);
dn10_deduped := dn10(dt_vendor_last_reported_weight100>=0); // Use specificity to flag high-dup counts
mj10 := join( dn10_deduped, dn10_deduped, left. > right. and LEFT.dt_vendor_last_reported = RIGHT.dt_vendor_last_reported,match_join(left,right,10),atmost(LEFT.dt_vendor_last_reported = RIGHT.dt_vendor_last_reported,1000),skew(1));
//Fixed fields ->:company_name(0)
dn11 := h(~company_name_isnull);
dn11_deduped := dn11(company_name_weight100>=0); // Use specificity to flag high-dup counts
mj11 := join( dn11_deduped, dn11_deduped, left. > right. and LEFT.company_name = RIGHT.company_name,match_join(left,right,11),atmost(LEFT.company_name = RIGHT.company_name,1000),skew(1));
//Fixed fields ->:prim_range(0)
dn12 := h(~prim_range_isnull);
dn12_deduped := dn12(prim_range_weight100>=0); // Use specificity to flag high-dup counts
mj12 := join( dn12_deduped, dn12_deduped, left. > right. and LEFT.prim_range = RIGHT.prim_range,match_join(left,right,12),atmost(LEFT.prim_range = RIGHT.prim_range,1000),skew(1));
//Fixed fields ->:predir(0)
dn13 := h(~predir_isnull);
dn13_deduped := dn13(predir_weight100>=0); // Use specificity to flag high-dup counts
mj13 := join( dn13_deduped, dn13_deduped, left. > right. and LEFT.predir = RIGHT.predir,match_join(left,right,13),atmost(LEFT.predir = RIGHT.predir,1000),skew(1));
//Fixed fields ->:prim_name(0)
dn14 := h(~prim_name_isnull);
dn14_deduped := dn14(prim_name_weight100>=0); // Use specificity to flag high-dup counts
mj14 := join( dn14_deduped, dn14_deduped, left. > right. and LEFT.prim_name = RIGHT.prim_name,match_join(left,right,14),atmost(LEFT.prim_name = RIGHT.prim_name,1000),skew(1));
mjs2_t := mj10+mj11+mj12+mj13+mj14;
SALT20.mac_select_best_matches(mjs2_t,1,2,o2);
mjs2 := o2 : persist('temp::Business_Research::::mj2');
//Fixed fields ->:addr_suffix(0)
dn15 := h(~addr_suffix_isnull);
dn15_deduped := dn15(addr_suffix_weight100>=0); // Use specificity to flag high-dup counts
mj15 := join( dn15_deduped, dn15_deduped, left. > right. and LEFT.addr_suffix = RIGHT.addr_suffix,match_join(left,right,15),atmost(LEFT.addr_suffix = RIGHT.addr_suffix,1000),skew(1));
//Fixed fields ->:postdir(0)
dn16 := h(~postdir_isnull);
dn16_deduped := dn16(postdir_weight100>=0); // Use specificity to flag high-dup counts
mj16 := join( dn16_deduped, dn16_deduped, left. > right. and LEFT.postdir = RIGHT.postdir,match_join(left,right,16),atmost(LEFT.postdir = RIGHT.postdir,1000),skew(1));
//Fixed fields ->:unit_desig(0)
dn17 := h(~unit_desig_isnull);
dn17_deduped := dn17(unit_desig_weight100>=0); // Use specificity to flag high-dup counts
mj17 := join( dn17_deduped, dn17_deduped, left. > right. and LEFT.unit_desig = RIGHT.unit_desig,match_join(left,right,17),atmost(LEFT.unit_desig = RIGHT.unit_desig,1000),skew(1));
//Fixed fields ->:sec_range(0)
dn18 := h(~sec_range_isnull);
dn18_deduped := dn18(sec_range_weight100>=0); // Use specificity to flag high-dup counts
mj18 := join( dn18_deduped, dn18_deduped, left. > right. and LEFT.sec_range = RIGHT.sec_range,match_join(left,right,18),atmost(LEFT.sec_range = RIGHT.sec_range,1000),skew(1));
//Fixed fields ->:city(0)
dn19 := h(~city_isnull);
dn19_deduped := dn19(city_weight100>=0); // Use specificity to flag high-dup counts
mj19 := join( dn19_deduped, dn19_deduped, left. > right. and LEFT.city = RIGHT.city,match_join(left,right,19),atmost(LEFT.city = RIGHT.city,1000),skew(1));
mjs3_t := mj15+mj16+mj17+mj18+mj19;
SALT20.mac_select_best_matches(mjs3_t,1,2,o3);
mjs3 := o3 : persist('temp::Business_Research::::mj3');
//Fixed fields ->:state(0)
dn20 := h(~state_isnull);
dn20_deduped := dn20(state_weight100>=0); // Use specificity to flag high-dup counts
mj20 := join( dn20_deduped, dn20_deduped, left. > right. and LEFT.state = RIGHT.state,match_join(left,right,20),atmost(LEFT.state = RIGHT.state,1000),skew(1));
//Fixed fields ->:zip(0)
dn21 := h(~zip_isnull);
dn21_deduped := dn21(zip_weight100>=0); // Use specificity to flag high-dup counts
mj21 := join( dn21_deduped, dn21_deduped, left. > right. and LEFT.zip = RIGHT.zip,match_join(left,right,21),atmost(LEFT.zip = RIGHT.zip,1000),skew(1));
//Fixed fields ->:zip4(0)
dn22 := h(~zip4_isnull);
dn22_deduped := dn22(zip4_weight100>=0); // Use specificity to flag high-dup counts
mj22 := join( dn22_deduped, dn22_deduped, left. > right. and LEFT.zip4 = RIGHT.zip4,match_join(left,right,22),atmost(LEFT.zip4 = RIGHT.zip4,1000),skew(1));
//Fixed fields ->:county(0)
dn23 := h(~county_isnull);
dn23_deduped := dn23(county_weight100>=0); // Use specificity to flag high-dup counts
mj23 := join( dn23_deduped, dn23_deduped, left. > right. and LEFT.county = RIGHT.county,match_join(left,right,23),atmost(LEFT.county = RIGHT.county,1000),skew(1));
//Fixed fields ->:msa(0)
dn24 := h(~msa_isnull);
dn24_deduped := dn24(msa_weight100>=0); // Use specificity to flag high-dup counts
mj24 := join( dn24_deduped, dn24_deduped, left. > right. and LEFT.msa = RIGHT.msa,match_join(left,right,24),atmost(LEFT.msa = RIGHT.msa,1000),skew(1));
mjs4_t := mj20+mj21+mj22+mj23+mj24;
SALT20.mac_select_best_matches(mjs4_t,1,2,o4);
mjs4 := o4 : persist('temp::Business_Research::::mj4');
//Fixed fields ->:geo_lat(0)
dn25 := h(~geo_lat_isnull);
dn25_deduped := dn25(geo_lat_weight100>=0); // Use specificity to flag high-dup counts
mj25 := join( dn25_deduped, dn25_deduped, left. > right. and LEFT.geo_lat = RIGHT.geo_lat,match_join(left,right,25),atmost(LEFT.geo_lat = RIGHT.geo_lat,1000),skew(1));
//Fixed fields ->:geo_long(0)
dn26 := h(~geo_long_isnull);
dn26_deduped := dn26(geo_long_weight100>=0); // Use specificity to flag high-dup counts
mj26 := join( dn26_deduped, dn26_deduped, left. > right. and LEFT.geo_long = RIGHT.geo_long,match_join(left,right,26),atmost(LEFT.geo_long = RIGHT.geo_long,1000),skew(1));
//Fixed fields ->:phone(0)
dn27 := h(~phone_isnull);
dn27_deduped := dn27(phone_weight100>=0); // Use specificity to flag high-dup counts
mj27 := join( dn27_deduped, dn27_deduped, left. > right. and LEFT.phone = RIGHT.phone,match_join(left,right,27),atmost(LEFT.phone = RIGHT.phone,1000),skew(1));
//Fixed fields ->:phone_score(0)
dn28 := h(~phone_score_isnull);
dn28_deduped := dn28(phone_score_weight100>=0); // Use specificity to flag high-dup counts
mj28 := join( dn28_deduped, dn28_deduped, left. > right. and LEFT.phone_score = RIGHT.phone_score,match_join(left,right,28),atmost(LEFT.phone_score = RIGHT.phone_score,1000),skew(1));
//Fixed fields ->:fein(0)
dn29 := h(~fein_isnull);
dn29_deduped := dn29(fein_weight100>=0); // Use specificity to flag high-dup counts
mj29 := join( dn29_deduped, dn29_deduped, left. > right. and LEFT.fein = RIGHT.fein,match_join(left,right,29),atmost(LEFT.fein = RIGHT.fein,1000),skew(1));
mjs5_t := mj25+mj26+mj27+mj28+mj29;
SALT20.mac_select_best_matches(mjs5_t,1,2,o5);
mjs5 := o5 : persist('temp::Business_Research::::mj5');
//Fixed fields ->:current(0)
dn30 := h(~current_isnull);
dn30_deduped := dn30(current_weight100>=0); // Use specificity to flag high-dup counts
mj30 := join( dn30_deduped, dn30_deduped, left. > right. and LEFT.current = RIGHT.current,match_join(left,right,30),atmost(LEFT.current = RIGHT.current,1000),skew(1));
//Fixed fields ->:dppa(0)
dn31 := h(~dppa_isnull);
dn31_deduped := dn31(dppa_weight100>=0); // Use specificity to flag high-dup counts
mj31 := join( dn31_deduped, dn31_deduped, left. > right. and LEFT.dppa = RIGHT.dppa,match_join(left,right,31),atmost(LEFT.dppa = RIGHT.dppa,1000),skew(1));
//Fixed fields ->:vl_id(0)
dn32 := h(~vl_id_isnull);
dn32_deduped := dn32(vl_id_weight100>=0); // Use specificity to flag high-dup counts
mj32 := join( dn32_deduped, dn32_deduped, left. > right. and LEFT.vl_id = RIGHT.vl_id,match_join(left,right,32),atmost(LEFT.vl_id = RIGHT.vl_id,1000),skew(1));
//Fixed fields ->:RawAID(0)
dn33 := h(~RawAID_isnull);
dn33_deduped := dn33(RawAID_weight100>=0); // Use specificity to flag high-dup counts
mj33 := join( dn33_deduped, dn33_deduped, left. > right. and LEFT.RawAID = RIGHT.RawAID,match_join(left,right,33),atmost(LEFT.RawAID = RIGHT.RawAID,1000),skew(1));
last_mjs_t :=mj30+mj31+mj32+mj33;
SALT20.mac_select_best_matches(last_mjs_t,1,2,o);
shared all_mjs :=  mjs0+ mjs1+ mjs2+ mjs3+ mjs4+ mjs5 +o;
export All_Matches := all_mjs : persist('temp::Business_Research__pDataset_all_m'); // To by used by  and 
SALT20.mac_avoid_transitives(All_Matches,1,2,Conf,DateOverlap,Rule,o);
export PossibleMatches := o : persist('temp::Business_Research__pDataset_mt');
SALT20.mac_get_BestPerRecord( All_Matches,1,1,2,2,o );
export BestPerRecord := o : persist('temp::Business_Research__pDataset_mr');
//Now lets see if any slice-outs are needed
in_matches := join(h,h,left.=right. and (>string6<)left.<>(>string6<)right.,match_join(left,right,9999),local);
SALT20.mac_cluster_breadth(in_matches,1,2,1,o);
o1 := join(o,Specificities(ih).ClusterSizes,left.1=right.,local);
export ClusterLinkages := o1 : persist('temp::Business_Research__pDataset_clu');
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
