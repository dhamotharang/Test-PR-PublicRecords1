// Begin code to perform the matching itself
import ut,salt,salt24;
export matches(dataset(layout_file_business_header) ih,unsigned MatchThreshold = 50) := module
shared h := match_candidates(ih).candidates;
shared LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
shared s := Specificities(ih).Specificities[1];
shared match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,unsigned2 c,unsigned outside=0) := transform
  self.Rule := c;
  self.BDID1 := le.BDID;
  self.BDID2 := ri.BDID;
  self.RCID1 := le.RCID;
  self.RCID2 := ri.RCID;
  integer2 fein_score := MAP( le.fein  IN SET(s.nulls_fein,fein) or ri.fein  IN SET(s.nulls_fein,fein) => 0,
                        le.fein = ri.fein  => le.fein_weight100,
                        Fn_Fail_Scale(le.fein_weight100,s.fein_switch));
  integer2 vendor_id_score := MAP( le.vendor_id  IN SET(s.nulls_vendor_id,vendor_id) or ri.vendor_id  IN SET(s.nulls_vendor_id,vendor_id) => 0,
                        le.SOURCE <> ri.SOURCE => 0, // Only valid if the context variable is equal
                        le.vendor_id = ri.vendor_id  => le.vendor_id_weight100,
                        Fn_Fail_Scale(le.vendor_id_weight100,s.vendor_id_switch));
  integer2 phone_score := MAP( le.phone  IN SET(s.nulls_phone,phone) or ri.phone  IN SET(s.nulls_phone,phone) => 0,
                        le.phone = ri.phone  => le.phone_weight100,
                        Fn_Fail_Scale(le.phone_weight100,s.phone_switch));
  integer2 company_name_score_temp := MAP( le.company_name  IN SET(s.nulls_company_name,company_name) or ri.company_name  IN SET(s.nulls_company_name,company_name) or le.company_name_weight100 = 0 => SKIP,
                        le.company_name = ri.company_name  => le.company_name_weight100,
                        salt24.fn_match_bagofwords(le.company_name,ri.company_name,2,0));
  integer2 company_name_score := IF ( company_name_score_temp >= 2000, company_name_score_temp, SKIP ); // Enforce FORCE parameter
  integer2 county_score := MAP( le.county  IN SET(s.nulls_county,county) or ri.county  IN SET(s.nulls_county,county) => 0,
                        le.county = ri.county  => le.county_weight100,
                        Fn_Fail_Scale(le.county_weight100,s.county_switch));
  integer2 SOURCE_score := MAP( le.SOURCE  IN SET(s.nulls_SOURCE,SOURCE) or ri.SOURCE  IN SET(s.nulls_SOURCE,SOURCE) => 0,
                        le.SOURCE = ri.SOURCE  => le.SOURCE_weight100,
                        Fn_Fail_Scale(le.SOURCE_weight100,s.SOURCE_switch));
  integer2 locale_score_pre := MAP( le.locale  IN SET(s.nulls_locale,locale) or ri.locale  IN SET(s.nulls_locale,locale) => 0,
                        le.zip  IN SET(s.nulls_zip,zip) OR le.state  IN SET(s.nulls_state,state) OR le.CITY  IN SET(s.nulls_CITY,CITY) OR le.msa  IN SET(s.nulls_msa,msa) => 0, // No combined score if these fields are null
                        le.locale = ri.locale  => le.locale_weight100,
                        0);
  integer2 address_score_pre := MAP( le.address  IN SET(s.nulls_address,address) or ri.address  IN SET(s.nulls_address,address) => 0,
                        le.prim_range  IN SET(s.nulls_prim_range,prim_range) OR le.prim_name  IN SET(s.nulls_prim_name,prim_name) => 0, // No combined score if these fields are null
                        le.address = ri.address  => le.address_weight100,
                        0);
  integer2 zip_score := MAP( le.zip  IN SET(s.nulls_zip,zip) or ri.zip  IN SET(s.nulls_zip,zip) => SKIP,
                        locale_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SKIP);
  integer2 prim_name_score := MAP( le.prim_name  IN SET(s.nulls_prim_name,prim_name) or ri.prim_name  IN SET(s.nulls_prim_name,prim_name) or le.prim_name_weight100 = 0 => SKIP,
                        address_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SKIP);
  integer2 state_score := MAP( le.state  IN SET(s.nulls_state,state) or ri.state  IN SET(s.nulls_state,state) => SKIP,
                        locale_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.state = ri.state  => le.state_weight100,
                        SKIP);
  integer2 zip4_score := MAP( le.zip4  IN SET(s.nulls_zip4,zip4) or ri.zip4  IN SET(s.nulls_zip4,zip4) => 0,
                        address_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.zip4 = ri.zip4  => le.zip4_weight100,
                        Fn_Fail_Scale(le.zip4_weight100,s.zip4_switch));
  integer2 prim_range_score := MAP( le.prim_range  IN SET(s.nulls_prim_range,prim_range) or ri.prim_range  IN SET(s.nulls_prim_range,prim_range) or le.prim_range_weight100 = 0 => SKIP,
                        address_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        ut.stringsimilar(le.prim_range,ri.prim_range) <= 1 => fn_fuzzy_specificity(le.prim_range_weight100,le.prim_range_cnt, le.prim_range_e1_cnt,ri.prim_range_weight100,ri.prim_range_cnt,ri.prim_range_e1_cnt),
                        SKIP);
  integer2 CITY_score := MAP( le.CITY  IN SET(s.nulls_CITY,CITY) or ri.CITY  IN SET(s.nulls_CITY,CITY) => 0,
                        locale_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.CITY = ri.CITY  => le.CITY_weight100,
                        Fn_Fail_Scale(le.CITY_weight100,s.CITY_switch));
  integer2 sec_range_score := MAP( le.sec_range  IN SET(s.nulls_sec_range,sec_range) or ri.sec_range  IN SET(s.nulls_sec_range,sec_range) => 0,
                        address_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch));
  integer2 msa_score := MAP( le.msa  IN SET(s.nulls_msa,msa) or ri.msa  IN SET(s.nulls_msa,msa) => 0,
                        locale_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.msa = ri.msa  => le.msa_weight100,
                        Fn_Fail_Scale(le.msa_weight100,s.msa_switch));
  integer2 unit_desig_score := MAP( le.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) or ri.unit_desig  IN SET(s.nulls_unit_desig,unit_desig) => 0,
                        address_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.unit_desig = ri.unit_desig  => le.unit_desig_weight100,
                        Fn_Fail_Scale(le.unit_desig_weight100,s.unit_desig_switch));
  integer2 addr_suffix_score := MAP( le.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) or ri.addr_suffix  IN SET(s.nulls_addr_suffix,addr_suffix) => 0,
                        address_score_pre <> 0 => 0, // Ancestor has value so child keeps quiet
                        le.prim_name <> ri.prim_name => 0, // Only valid if the context variable is equal
                        le.addr_suffix = ri.addr_suffix  => le.addr_suffix_weight100,
                        Fn_Fail_Scale(le.addr_suffix_weight100,s.addr_suffix_switch));
  integer2 locale_score := locale_score_pre;
  integer2 address_score := address_score_pre;
  self.Conf_Prop := (if(le.fein_prop or ri.fein_prop,fein_score,0) + if(le.phone_prop or ri.phone_prop,phone_score,0)) / 100; // Score based on propogated fields
  iComp := (zip_score + prim_name_score + state_score + fein_score + vendor_id_score + phone_score + company_name_score + zip4_score + prim_range_score + CITY_score + sec_range_score + msa_score + county_score + SOURCE_score + unit_desig_score + addr_suffix_score + locale_score + address_score) / 100 + outside;
  self.Conf := IF( iComp>=LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
end;
//Now execute each of the 1 join conditions
// Join mj0 which has blocking specificity of 27
dn0 := h(zip NOT IN SET(s.nulls_zip,zip) and prim_name NOT IN SET(s.nulls_prim_name,prim_name) and state NOT IN SET(s.nulls_state,state));
MAC_Remove_WithDups(dn0,(string)zip + (string)prim_name + (string)state,1000,dn0_deduped)
mj0 := distribute( join( dn0_deduped, dn0_deduped, left.BDID > right.BDID and left.zip = right.zip and left.prim_name = right.prim_name and left.state = right.state,match_join(left,right,0),atmost(left.zip = right.zip and left.prim_name = right.prim_name and left.state = right.state,1000),skew(1)),hash(BDID1));
last_mjs_t := mj0;
mac_select_best_matches(last_mjs_t,BDID1,BDID2,Conf,Rule,o);
shared all_mjs := o;
export All_Matches := all_mjs;
mac_avoid_transitives(All_Matches,BDID1,BDID2,Conf,DateOverlap,Rule,o);
export PossibleMatches := o : persist('temp::Business_Header_Bdid_lift_BDID_file_business_header_mt');
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
ut.MAC_Patch_Id(ih,BDID,Matches,BDID1,BDID2,o);
export Patched_Infile := o;
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,BDID,Matches,BDID1,BDID2,o1);
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
export DidsNoRid0 := PostPatchIdCount - count(Patched_Infile(BDID=RCID)); // Should be zero
export DidsAboveRid0 := count(Patched_Infile(BDID>RCID)); // Should be zero
end;
