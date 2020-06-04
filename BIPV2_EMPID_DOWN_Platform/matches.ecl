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
  INTEGER2 orgid_score_temp := MAP(
                        le.orgid = ri.orgid  => le.orgid_weight100,
                        SALT32.Fn_Fail_Scale(le.orgid_weight100,s.orgid_switch));
  INTEGER2 contact_ssn_score := MAP(
                        le.contact_ssn_isnull OR ri.contact_ssn_isnull => 0,
                        le.contact_ssn = ri.contact_ssn  => le.contact_ssn_weight100,
                        SALT32.WithinEditNew(le.contact_ssn,le.contact_ssn_len,ri.contact_ssn,ri.contact_ssn_len,1,0) => SALT32.fn_fuzzy_specificity(le.contact_ssn_weight100,le.contact_ssn_cnt, le.contact_ssn_e1_cnt,ri.contact_ssn_weight100,ri.contact_ssn_cnt,ri.contact_ssn_e1_cnt),
                        le.contact_ssn_Right4 = ri.contact_ssn_Right4 => SALT32.fn_fuzzy_specificity(le.contact_ssn_weight100,le.contact_ssn_cnt, le.contact_ssn_Right4_cnt,ri.contact_ssn_weight100,ri.contact_ssn_cnt,ri.contact_ssn_Right4_cnt),
                        SALT32.Fn_Fail_Scale(le.contact_ssn_weight100,s.contact_ssn_switch));
  INTEGER2 contact_did_score := MAP(
                        le.contact_did_isnull OR ri.contact_did_isnull => 0,
                        le.contact_did = ri.contact_did  => le.contact_did_weight100,
                        SALT32.Fn_Fail_Scale(le.contact_did_weight100,s.contact_did_switch));
  INTEGER2 lname_score_temp := MAP(
                        le.lname_isnull OR ri.lname_isnull OR le.lname_weight100 = 0 => 0,
                        le.lname = ri.lname OR SALT32.HyphenMatch(le.lname,ri.lname,3)<=2  => MIN(le.lname_weight100,ri.lname_weight100),
                        SALT32.WithinEditNew(le.lname,le.lname_len,ri.lname,ri.lname_len,1,0) => SALT32.fn_fuzzy_specificity(le.lname_weight100,le.lname_cnt, le.lname_e1_cnt,ri.lname_weight100,ri.lname_cnt,ri.lname_e1_cnt),
                        SALT32.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  INTEGER2 mname_score_temp := MAP(
                        le.mname_isnull OR ri.mname_isnull => 0,
                        le.mname = ri.mname  => le.mname_weight100,
                        SALT32.WithinEditNew(le.mname,le.mname_len,ri.mname,ri.mname_len,1,0) => SALT32.fn_fuzzy_specificity(le.mname_weight100,le.mname_cnt, le.mname_e1_cnt,ri.mname_weight100,ri.mname_cnt,ri.mname_e1_cnt),
                        LENGTH(TRIM(le.mname))>0 and le.mname = ri.mname[1..LENGTH(TRIM(le.mname))] => le.mname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.mname))>0 and ri.mname = le.mname[1..LENGTH(TRIM(ri.mname))] => ri.mname_weight100, // An initial match - take initial specificity
                        SALT32.Fn_Fail_Scale(le.mname_weight100,s.mname_switch));
  INTEGER2 fname_score_temp := MAP(
                        le.fname_isnull OR ri.fname_isnull OR le.fname_weight100 = 0 => 0,
                        le.fname = ri.fname  => le.fname_weight100,
                        SALT32.WithinEditNew(le.fname,le.fname_len,ri.fname,ri.fname_len,1,0) => SALT32.fn_fuzzy_specificity(le.fname_weight100,le.fname_cnt, le.fname_e1_cnt,ri.fname_weight100,ri.fname_cnt,ri.fname_e1_cnt),
                        LENGTH(TRIM(le.fname))>0 and le.fname = ri.fname[1..LENGTH(TRIM(le.fname))] => le.fname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.fname))>0 and ri.fname = le.fname[1..LENGTH(TRIM(ri.fname))] => ri.fname_weight100, // An initial match - take initial specificity
                        le.fname_PreferredName = ri.fname_PreferredName => SALT32.fn_fuzzy_specificity(le.fname_weight100,le.fname_cnt, le.fname_PreferredName_cnt,ri.fname_weight100,ri.fname_cnt,ri.fname_PreferredName_cnt),
                        SALT32.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  INTEGER2 name_suffix_score_temp := MAP(
                        le.name_suffix_isnull OR ri.name_suffix_isnull => 0,
                        le.name_suffix = ri.name_suffix  => le.name_suffix_weight100,
                        le.name_suffix_NormSuffix = ri.name_suffix_NormSuffix => SALT32.fn_fuzzy_specificity(le.name_suffix_weight100,le.name_suffix_cnt, le.name_suffix_NormSuffix_cnt,ri.name_suffix_weight100,ri.name_suffix_cnt,ri.name_suffix_NormSuffix_cnt),
                        SALT32.Fn_Fail_Scale(le.name_suffix_weight100,s.name_suffix_switch));
  INTEGER2 orgid_score := IF ( orgid_score_temp >= Config.orgid_Force * 100, orgid_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 lname_score := IF (le.lname = ri.lname or/*HACK*/  lname_score_temp > Config.lname_Force * 100, lname_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 mname_score := IF ( mname_score_temp >= Config.mname_Force * 100, mname_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 fname_score := IF (le.fname = ri.fname or/*HACK*/  fname_score_temp > Config.fname_Force * 100, fname_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 name_suffix_score := IF ( name_suffix_score_temp >= Config.name_suffix_Force * 100, name_suffix_score_temp, SKIP ); // Enforce FORCE parameter
  SELF.Conf_Prop := (0
    +(MAX(le.mname_prop,ri.mname_prop)/MAX(LENGTH(TRIM(le.mname)),LENGTH(TRIM(ri.mname))))*mname_score // Proportion of longest string propogated
    +MAX(le.name_suffix_prop,ri.name_suffix_prop)*name_suffix_score // Score if either field propogated
  ) / 100; // Score based on propogated fields
  iComp := (orgid_score + contact_ssn_score + contact_did_score + lname_score + mname_score + fname_score + name_suffix_score) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':orgid','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 1 join conditions of which 0 have been optimized into preceding conditions
EXPORT MAC_DoJoins(hfile,trans) := FUNCTIONMACRO
 
//Fixed fields ->:orgid(26)
 
dn0 := hfile();
dn0_deduped := dn0(orgid_weight100>=500); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.EmpID > RIGHT.EmpID AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.orgid = RIGHT.orgid /* AND ( ~left.lname_isnull AND ~right.lname_isnull ) *//*HACK*/ /* AND ( ~left.fname_isnull AND ~right.fname_isnull ) *//*HACK*/ AND ( left.name_suffix = right.name_suffix OR left.name_suffix_isnull OR right.name_suffix_isnull ),trans(LEFT,RIGHT,0),HINT(unsorted_output),ATMOST(LEFT.orgid = RIGHT.orgid,10000),HASH);
last_mjs_t :=mj0;
SALT32.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
mjs0 := o : PERSIST('~temp::EmpID::BIPV2_EMPID_DOWN_Platform::mj::0',EXPIRE(Config.PersistExpire));
 
RETURN  mjs0;
ENDMACRO;
SHARED all_mjs := MAC_DoJoins(h,match_join);
EXPORT All_Matches := all_mjs : PERSIST('~temp::EmpID::BIPV2_EMPID_DOWN_Platform::all_m',EXPIRE(Config.PersistExpire)); // To by used by rcid and EmpID
SALT32.mac_avoid_transitives(All_Matches,EmpID1,EmpID2,Conf,DateOverlap,Rule,o);
EXPORT PossibleMatches := o : PERSIST('~temp::EmpID::BIPV2_EMPID_DOWN_Platform::mt',EXPIRE(Config.PersistExpire));
EXPORT Matches := PossibleMatches(Conf>=MatchThreshold) : PERSIST('~temp::EmpID::BIPV2_EMPID_DOWN_Platform::Matches::Matches',EXPIRE(Config.PersistExpire));
 
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
SHARED ih_thin := TABLE(ih_init,{rcid,EmpID});
  ut.MAC_Patch_Id(ih_thin,EmpID,BasicMatch(ih).patch_file,EmpID1,EmpID2,ihbp); // Perform basic matches
  ut.MAC_Patch_Id(ihbp,EmpID,Matches,EmpID1,EmpID2,o); // Join Clusters
SHARED Patched_Infile_thin := o : INDEPENDENT;
  pi1 := JOIN(ih, Patched_Infile_thin, LEFT.rcid=RIGHT.rcid, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), HASH/*HACK*/);
 
EXPORT Patched_Infile := pi1;
 
//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,EmpID,Matches,EmpID1,EmpID2,o1);
EXPORT Patched_Candidates := o1;
 
// Now compute a file to show which identifiers have changed from input to output
EXPORT id_shift_r := RECORD
    SALT32.UIDType rcid;
    SALT32.UIDType EmpID_before;
    SALT32.UIDType EmpID_after;
    UNSIGNED4 change_date;
  END;
  id_shift_r note_change(ih_thin le,patched_infile_thin ri) := TRANSFORM
    SELF.rcid := le.rcid;
    SELF.EmpID_before := le.EmpID;
    SELF.EmpID_after := ri.EmpID;
    SELF.change_date := (UNSIGNED4)stringlib.GetDateYYYYMMDD();
  END;
EXPORT IdChanges := JOIN(ih_thin,patched_infile_thin,LEFT.rcid = RIGHT.rcid AND (LEFT.EmpID<>RIGHT.EmpID),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := BIPV2_EMPID_DOWN_Platform.Fields.UIDConsistency(ih_thin); // Export whole consistency module
EXPORT PostIDs := BIPV2_EMPID_DOWN_Platform.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[1].EmpID_cnt - PostIDs.IdCounts[1].EmpID_cnt - MatchesPerformed - COUNT(BasicMatch(ih).patch_file) ; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile_thin) - PostIDs.IdCounts[1].rcid_Cnt; // Should be zero
END;
