// Begin code to perform the matching itself
 
IMPORT BIPV2_Tools; // Import modules for  attribute definitions
IMPORT SALT32,ut,std;
EXPORT matches(DATASET(layout_EmpID) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
 
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.EmpID1 := le.EmpID;
  SELF.EmpID2 := ri.EmpID;
  SELF.rcid1 := le.rcid;
  SELF.rcid2 := ri.rcid;
  SELF.DateOverlap := SALT32.fn_ComputeDateOverlap(((UNSIGNED)le.dt_first_seen),((UNSIGNED)le.dt_last_seen),((UNSIGNED)ri.dt_first_seen),((UNSIGNED)ri.dt_last_seen));
  INTEGER2 prim_range_score_temp := MAP(
                        le.prim_range = ri.prim_range  => le.prim_range_weight100,
                        SALT32.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch));
  INTEGER2 prim_name_score_temp := MAP(
                        le.prim_name_isnull OR ri.prim_name_isnull OR le.prim_name_weight100 = 0 => 0,
                        le.prim_name = ri.prim_name  => le.prim_name_weight100,
                        SALT32.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch));
  INTEGER2 lname_score_temp := MAP(
                        le.lname_isnull OR ri.lname_isnull OR le.lname_weight100 = 0 => 0,
                        le.lname = ri.lname  => le.lname_weight100,
                        SALT32.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  INTEGER2 contact_phone_score := MAP(
                        le.contact_phone_isnull OR ri.contact_phone_isnull => 0,
                        le.contact_phone = ri.contact_phone  => le.contact_phone_weight100,
                        SALT32.Fn_Fail_Scale(le.contact_phone_weight100,s.contact_phone_switch));
  INTEGER2 contact_did_score_temp := MAP(
                        le.contact_did_isnull OR ri.contact_did_isnull => 0,
                        le.contact_did = ri.contact_did  => le.contact_did_weight100,
                        SALT32.Fn_Fail_Scale(le.contact_did_weight100,s.contact_did_switch));
  INTEGER2 cname_devanitize_score_temp := MAP(
                        le.cname_devanitize_isnull OR ri.cname_devanitize_isnull OR le.cname_devanitize_weight100 = 0 => 0,
                        le.cname_devanitize = ri.cname_devanitize  => le.cname_devanitize_weight100,
                        SALT32.MatchBagOfWords(le.cname_devanitize,ri.cname_devanitize,2128912,1));
  INTEGER2 zip_score := MAP(
                        le.zip_isnull OR ri.zip_isnull => 0,
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT32.Fn_Fail_Scale(le.zip_weight100,s.zip_switch));
  INTEGER2 fname_score_temp := MAP(
                        le.fname_isnull OR ri.fname_isnull OR le.fname_weight100 = 0 => 0,
                        le.fname = ri.fname  => le.fname_weight100,
                        LENGTH(TRIM(le.fname))>0 and le.fname = ri.fname[1..LENGTH(TRIM(le.fname))] => le.fname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.fname))>0 and ri.fname = le.fname[1..LENGTH(TRIM(ri.fname))] => ri.fname_weight100, // An initial match - take initial specificity
                        le.fname_PreferredName = ri.fname_PreferredName => SALT32.fn_fuzzy_specificity(le.fname_weight100,le.fname_cnt, le.fname_PreferredName_cnt,ri.fname_weight100,ri.fname_cnt,ri.fname_PreferredName_cnt),
                        SALT32.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  INTEGER2 contact_ssn_score_temp := MAP(
                        le.contact_ssn_isnull OR ri.contact_ssn_isnull => 0,
                        le.contact_ssn = ri.contact_ssn  => le.contact_ssn_weight100,
                        SALT32.Fn_Fail_Scale(le.contact_ssn_weight100,s.contact_ssn_switch));
  INTEGER2 prim_range_score := IF ( prim_range_score_temp >= Config.prim_range_Force * 100, prim_range_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_name_score := IF ( prim_name_score_temp > Config.prim_name_Force * 100, prim_name_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 lname_score := IF ( lname_score_temp > Config.lname_Force * 100, lname_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 contact_did_score := IF ( contact_did_score_temp >= Config.contact_did_Force * 100, contact_did_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 cname_devanitize_score := IF ( cname_devanitize_score_temp > Config.cname_devanitize_Force * 100, cname_devanitize_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 fname_score := IF ( fname_score_temp > Config.fname_Force * 100, fname_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 contact_ssn_score := IF ( contact_ssn_score_temp >= Config.contact_ssn_Force * 100, contact_ssn_score_temp, SKIP ); // Enforce FORCE parameter
  SELF.Conf_Prop := (0
    +MAX(le.prim_name_prop,ri.prim_name_prop)*prim_name_score // Score if either field propogated
    +MAX(le.cname_devanitize_prop,ri.cname_devanitize_prop)*cname_devanitize_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  iComp := (prim_range_score + prim_name_score + lname_score + contact_phone_score + contact_did_score + cname_devanitize_score + zip_score + fname_score + contact_ssn_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':prim_range:prim_name:lname','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 1 join conditions of which 0 have been optimized into preceding conditions
EXPORT MAC_DoJoins(hfile,trans) := FUNCTIONMACRO
 
//Fixed fields ->:prim_range(13):prim_name(15):lname(15)
 
dn0 := hfile(~prim_name_isnull AND ~lname_isnull);
dn0_deduped := dn0(prim_range_weight100 + prim_name_weight100 + lname_weight100>=500); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.EmpID > RIGHT.EmpID AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.lname = RIGHT.lname AND ( ~left.prim_name_isnull AND ~right.prim_name_isnull ) AND ( ~left.lname_isnull AND ~right.lname_isnull ) AND ( left.contact_did = right.contact_did OR left.contact_did_isnull OR right.contact_did_isnull ) AND ( ~left.cname_devanitize_isnull AND ~right.cname_devanitize_isnull ) AND ( ~left.fname_isnull AND ~right.fname_isnull ) AND ( left.contact_ssn = right.contact_ssn OR left.contact_ssn_isnull OR right.contact_ssn_isnull ),trans(LEFT,RIGHT,0),HINT(unsorted_output),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.prim_name = RIGHT.prim_name AND LEFT.lname = RIGHT.lname,10000),HASH);
last_mjs_t :=mj0;
SALT32.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
mjs0 := o : PERSIST('~temp::EmpID::BIPV2_EmpID::mj::0',EXPIRE(Config.PersistExpire));
 
RETURN  mjs0;
ENDMACRO;
SHARED all_mjs := MAC_DoJoins(h,match_join);
EXPORT All_Matches := all_mjs : PERSIST('~temp::EmpID::BIPV2_EmpID::all_m',EXPIRE(Config.PersistExpire)); // To by used by rcid and EmpID
SALT32.mac_avoid_transitives(All_Matches,EmpID1,EmpID2,Conf,DateOverlap,Rule,o);
EXPORT PossibleMatches := o : PERSIST('~temp::EmpID::BIPV2_EmpID::mt',EXPIRE(Config.PersistExpire));
EXPORT Matches := PossibleMatches(Conf>=MatchThreshold) : PERSIST('~temp::EmpID::BIPV2_EmpID::Matches::Matches',EXPIRE(Config.PersistExpire));
 
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
SHARED ih_thin := TABLE(ih_init,{rcid,EmpID,OrgID,UltID});
  ut.MAC_Patch_Id(ih_thin,EmpID,BasicMatch(ih).patch_file,EmpID1,EmpID2,ihbp); // Perform basic matches
  ut.MAC_Patch_Id(ihbp,EmpID,Matches,EmpID1,EmpID2,o); // Join Clusters
  PatchOrgID := SALT32.MAC_MultiParent_Collapse(o,OrgID,EmpID);  // Collapse any OrgID now joined by EmpID
  PatchUltID := SALT32.MAC_MultiParent_Collapse(PatchOrgID,UltID,OrgID);  // Collapse any UltID now joined by OrgID
SHARED Patched_Infile_thin := PatchUltID : INDEPENDENT;
  pi1 := JOIN(ih, Patched_Infile_thin, LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), HASH/*HACK REMOVE SMART JOINS TO PREVENT MP LINK CLOSED ERROR*/);
 
EXPORT Patched_Infile := pi1;
 
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,EmpID,Matches,EmpID1,EmpID2,o1);
EXPORT Patched_Candidates := o1;
 
// Now compute a file to show which identifiers have changed from input to output
EXPORT id_shift_r := RECORD
    SALT32.UIDType rcid;
    SALT32.UIDType EmpID_before;
    SALT32.UIDType EmpID_after;
    SALT32.UIDType OrgID_before;
    SALT32.UIDType OrgID_after;
    SALT32.UIDType UltID_before;
    SALT32.UIDType UltID_after;
    UNSIGNED4 change_date;
  END;
  id_shift_r note_change(ih_thin le,patched_infile_thin ri) := TRANSFORM
    SELF.rcid := le.rcid;
    SELF.EmpID_before := le.EmpID;
    SELF.EmpID_after := ri.EmpID;
    SELF.OrgID_before := le.OrgID;
    SELF.OrgID_after := ri.OrgID;
    SELF.UltID_before := le.UltID;
    SELF.UltID_after := ri.UltID;
    SELF.change_date := (UNSIGNED4)stringlib.GetDateYYYYMMDD();
  END;
EXPORT IdChanges := JOIN(ih_thin,patched_infile_thin,LEFT.rcid = RIGHT.rcid AND (LEFT.EmpID<>RIGHT.EmpID OR LEFT.OrgID<>RIGHT.OrgID OR LEFT.UltID<>RIGHT.UltID),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := BIPV2_EmpID.Fields.UIDConsistency(ih_thin); // Export whole consistency module
EXPORT PostIDs := BIPV2_EmpID.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[1].EmpID_cnt - PostIDs.IdCounts[1].EmpID_cnt - MatchesPerformed - COUNT(BasicMatch(ih).patch_file) ; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile_thin) - PostIDs.IdCounts[1].rcid_Cnt; // Should be zero
END;
