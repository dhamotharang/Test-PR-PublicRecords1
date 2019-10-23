IMPORT SALT31,ut;
import mdr;//HACK
EXPORT Relationships(DATASET(layout_Base) ih,DATASET(match_candidates(ih).layout_candidates) mc = Match_Candidates(ih).candidates, layout_specificities.R s = Specificities(ih).specificities[1]) := INLINE MODULE/*HACK INLINE FOR ROXIE*/
SHARED h := Scaled_Candidates(ih,mc);
// Create code to find relationships between clusters based upon multiple records
 
// Code for NAMEST relationship 
  BaseFile := h;
  SlimRec := RECORD
    BaseFile.Seleid;
    BaseFile.cnp_name;
    BaseFile.cnp_name_weight100;
    BaseFile.st;
    BaseFile.st_weight100;
    BaseFile.dt_first_seen;
    BaseFile.dt_last_seen;
  END;
/*HACK FOLLOWS*/
/******* To filter any franchise from name st relationship *****/
CandidatesNAMEST1 := BaseFile (cnp_name_weight100 + st_weight100>=2000);

// select the franchise seleids in the basefile.
frandxSeleId := DEDUP(TABLE(basefile(MDR.sourceTools.SourceIsFrandx(source)), 
									{basefile.seleId}), ALL);

// left only here to eliminate all the franchise seleids from name relationship.
noFrandxCandidates := JOIN(DISTRIBUTE(CandidatesNAMEST1, HASH(seleid)), 
														DISTRIBUTE(frandxSeleId, HASH(seleid)),
														left.seleid = right.seleid, left only, local);
SlimRec1 := RECORD
  noFrandxCandidates.Seleid;
  noFrandxCandidates.cnp_name;
 noFrandxCandidates.cnp_name_weight100;
  noFrandxCandidates.st;
 noFrandxCandidates.st_weight100;
 noFrandxCandidates.dt_first_seen;
 noFrandxCandidates.dt_last_seen;
END;
SHARED CandidatesNAMEST := TABLE(noFrandxCandidates,SlimRec1);
 /*HACKS END*/ // Select records with enough specificity in basis and then slim
  CombinationRecord := RECORD
    SALT31.UIDType Seleid1;
    SALT31.UIDType Seleid2;
    INTEGER2 Basis_score; // Score allocated to the basis relationship
    UNSIGNED2 Dedup_Val; // Hash will be stored in here to dedup
    UNSIGNED2 Cnt; // Number of different matching basis
    UNSIGNED4 dt_first_seen_track; // Computed date for this particular field
    UNSIGNED4 dt_last_seen_track; // Computed date for this particular field
  END;
  CombinationRecord NoteLink(CandidatesNAMEST le,CandidatesNAMEST ri) := TRANSFORM
    SELF.Seleid1 := le.Seleid;
    SELF.Seleid2 := ri.Seleid;
    SELF.Cnt := 1;
    SELF.dt_first_seen_Track := MAP(le.dt_first_seen = 0 OR ri.dt_first_seen = 0 => 0, MAX(le.dt_first_seen,ri.dt_first_seen));
    SELF.dt_last_seen_Track := MAP(le.dt_last_seen = 0 OR ri.dt_last_seen = 0 => 0, MIN(le.dt_last_seen,ri.dt_last_seen));
    SELF.Basis_Score := (le.cnp_name_weight100 + le.st_weight100) / 100;
    SELF.Dedup_Val := HASH32(le.cnp_name,le.st); // Will be slimmed to 16 bit for efficiency
  END;
  CombinationRecord Combine(CombinationRecord le,CombinationRecord ri) := TRANSFORM
    SELF.Basis_Score := IF ( le.Dedup_Val = ri.Dedup_Val, MAX(le.Basis_Score,ri.Basis_Score),le.Basis_Score+ri.Basis_Score );
    SELF.Cnt := IF ( le.Dedup_Val = ri.Dedup_Val,MAX(le.Cnt,ri.Cnt),le.Cnt+ri.Cnt );
    SELF.Dedup_Val := ri.Dedup_Val; // Keep right most to compare to next in line (incoming data sorted by dedup_val)
    SELF.dt_first_seen_Track := MAP(le.dt_first_seen_Track = 0 => ri.dt_first_seen_Track, ri.dt_first_seen_Track = 0 => le.dt_first_seen_Track, MIN(le.dt_first_seen_Track,ri.dt_first_seen_Track));
    SELF.dt_last_seen_Track := MAP(le.dt_last_seen_Track = 0 => ri.dt_last_seen_Track, ri.dt_last_seen_Track = 0 => le.dt_last_seen_Track, MAX(le.dt_last_seen_Track,ri.dt_last_seen_Track));
    SELF := le;
  END;
SHARED CombinationRecord ProduceLinksNAMEST(DATASET(RECORDOF(CandidatesNAMEST)) le,DATASET(RECORDOF(CandidatesNAMEST)) ri) := FUNCTION
    J1 := JOIN(le,ri,LEFT.Seleid>RIGHT.Seleid AND LEFT.cnp_name=RIGHT.cnp_name AND LEFT.st=RIGHT.st,NoteLink(LEFT,RIGHT),ATMOST(LEFT.cnp_name=RIGHT.cnp_name AND LEFT.st=RIGHT.st,10000)/*,GROUP(LEFT.Seleid)*//*HACK*/,local); // Slice new in-memory relationship
    /*HACKS FOLLOW*/DJ := DISTRIBUTE(J1, HASH(Seleid1), MERGE(Seleid1));
R  := GROUP(DJ, Seleid1, LOCAL);
J2 := SORT(R,Seleid2,dedup_val);
/*HACKS END*/
    RETURN GROUP(ROLLUP( J2, LEFT.Seleid2=RIGHT.Seleid2, Combine(LEFT,RIGHT)))((Basis_Score) >= 10,Cnt >= 1);
  END;
SHARED SortedCandNAMEST := SORT(DISTRIBUTE(CandidatesNAMEST,HASH(cnp_name,st)),cnp_name,st,LOCAL); // Prepare so the light joins can be used
  SHARED RelJoinNAMEST0_np := ProduceLinksNAMEST(SortedCandNAMEST,SortedCandNAMEST);
  SHARED RelJoinNAMEST0 := RelJoinNAMEST0_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::NAMEST0',EXPIRE(Config.PersistExpire));
EXPORT NAMEST_Links_np := RelJoinNAMEST0_np;
EXPORT NAMEST_Links := RelJoinNAMEST0;
// Code for CHARTER relationship 
  BaseFile := h;
  SlimRec := RECORD
    BaseFile.Seleid;
    BaseFile.company_charter_number;
    BaseFile.company_inc_state;  // Context field needed too
    BaseFile.company_charter_number_weight100;
    BaseFile.company_inc_state_weight100;
    BaseFile.dt_first_seen;
    BaseFile.dt_last_seen;
  END;
SHARED CandidatesCHARTER := TABLE(BaseFile(company_charter_number_weight100 + company_inc_state_weight100>=2000),SlimRec); // Select records with enough specificity in basis and then slim
  CombinationRecord := RECORD
    SALT31.UIDType Seleid1;
    SALT31.UIDType Seleid2;
    INTEGER2 Basis_score; // Score allocated to the basis relationship
    UNSIGNED2 Dedup_Val; // Hash will be stored in here to dedup
    UNSIGNED2 Cnt; // Number of different matching basis
    UNSIGNED4 dt_first_seen_track; // Computed date for this particular field
    UNSIGNED4 dt_last_seen_track; // Computed date for this particular field
  END;
  CombinationRecord NoteLink(CandidatesCHARTER le,CandidatesCHARTER ri) := TRANSFORM
    SELF.Seleid1 := le.Seleid;
    SELF.Seleid2 := ri.Seleid;
    SELF.Cnt := 1;
    SELF.dt_first_seen_Track := MAP(le.dt_first_seen = 0 OR ri.dt_first_seen = 0 => 0, MAX(le.dt_first_seen,ri.dt_first_seen));
    SELF.dt_last_seen_Track := MAP(le.dt_last_seen = 0 OR ri.dt_last_seen = 0 => 0, MIN(le.dt_last_seen,ri.dt_last_seen));
    SELF.Basis_Score := (le.company_charter_number_weight100 + le.company_inc_state_weight100) / 100;
    SELF.Dedup_Val := HASH32(le.company_charter_number,le.company_inc_state); // Will be slimmed to 16 bit for efficiency
  END;
  CombinationRecord Combine(CombinationRecord le,CombinationRecord ri) := TRANSFORM
    SELF.Basis_Score := IF ( le.Dedup_Val = ri.Dedup_Val, MAX(le.Basis_Score,ri.Basis_Score),le.Basis_Score+ri.Basis_Score );
    SELF.Cnt := IF ( le.Dedup_Val = ri.Dedup_Val,MAX(le.Cnt,ri.Cnt),le.Cnt+ri.Cnt );
    SELF.Dedup_Val := ri.Dedup_Val; // Keep right most to compare to next in line (incoming data sorted by dedup_val)
    SELF.dt_first_seen_Track := MAP(le.dt_first_seen_Track = 0 => ri.dt_first_seen_Track, ri.dt_first_seen_Track = 0 => le.dt_first_seen_Track, MIN(le.dt_first_seen_Track,ri.dt_first_seen_Track));
    SELF.dt_last_seen_Track := MAP(le.dt_last_seen_Track = 0 => ri.dt_last_seen_Track, ri.dt_last_seen_Track = 0 => le.dt_last_seen_Track, MAX(le.dt_last_seen_Track,ri.dt_last_seen_Track));
    SELF := le;
  END;
SHARED CombinationRecord ProduceLinksCHARTER(DATASET(RECORDOF(CandidatesCHARTER)) le,DATASET(RECORDOF(CandidatesCHARTER)) ri) := FUNCTION
    J1 := JOIN(le,ri,LEFT.Seleid>RIGHT.Seleid AND LEFT.company_charter_number=RIGHT.company_charter_number AND LEFT.company_inc_state=RIGHT.company_inc_state AND LEFT.company_inc_state=RIGHT.company_inc_state,NoteLink(LEFT,RIGHT),ATMOST(LEFT.company_charter_number=RIGHT.company_charter_number AND LEFT.company_inc_state=RIGHT.company_inc_state AND LEFT.company_inc_state=RIGHT.company_inc_state,10000),GROUP(LEFT.Seleid)); // Slice new in-memory relationship
    /*HACKS FOLLOW*/DJ := DISTRIBUTE(J1, HASH(Seleid1), MERGE(Seleid1));
R  := GROUP(DJ, Seleid1, LOCAL);
J2 := SORT(R,Seleid2,dedup_val);
/*HACKS END*/
    RETURN GROUP(ROLLUP( J2, LEFT.Seleid2=RIGHT.Seleid2, Combine(LEFT,RIGHT)))((Basis_Score) >= 20,Cnt >= 1);
  END;
SHARED SortedCandCHARTER := SORT(DISTRIBUTE(CandidatesCHARTER,HASH(company_charter_number,company_inc_state)),company_charter_number,company_inc_state,LOCAL); // Prepare so the light joins can be used
  SHARED RelJoinCHARTER0_np := ProduceLinksCHARTER(SortedCandCHARTER,SortedCandCHARTER);
  SHARED RelJoinCHARTER0 := RelJoinCHARTER0_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::CHARTER0',EXPIRE(Config.PersistExpire));
EXPORT CHARTER_Links_np := RelJoinCHARTER0_np;
EXPORT CHARTER_Links := RelJoinCHARTER0;
// Code for FEIN relationship 
  BaseFile := h;
  SlimRec := RECORD
    BaseFile.Seleid;
    BaseFile.company_fein;
    BaseFile.company_fein_weight100;
    BaseFile.dt_first_seen;
    BaseFile.dt_last_seen;
  END;
SHARED CandidatesFEIN := TABLE(BaseFile(company_fein_weight100>=2000),SlimRec); // Select records with enough specificity in basis and then slim
  CombinationRecord := RECORD
    SALT31.UIDType Seleid1;
    SALT31.UIDType Seleid2;
    INTEGER2 Basis_score; // Score allocated to the basis relationship
    UNSIGNED2 Dedup_Val; // Hash will be stored in here to dedup
    UNSIGNED2 Cnt; // Number of different matching basis
    UNSIGNED4 dt_first_seen_track; // Computed date for this particular field
    UNSIGNED4 dt_last_seen_track; // Computed date for this particular field
  END;
  CombinationRecord NoteLink(CandidatesFEIN le,CandidatesFEIN ri) := TRANSFORM
    SELF.Seleid1 := le.Seleid;
    SELF.Seleid2 := ri.Seleid;
    SELF.Cnt := 1;
    SELF.dt_first_seen_Track := MAP(le.dt_first_seen = 0 OR ri.dt_first_seen = 0 => 0, MAX(le.dt_first_seen,ri.dt_first_seen));
    SELF.dt_last_seen_Track := MAP(le.dt_last_seen = 0 OR ri.dt_last_seen = 0 => 0, MIN(le.dt_last_seen,ri.dt_last_seen));
    SELF.Basis_Score := (le.company_fein_weight100) / 100;
    SELF.Dedup_Val := HASH32(le.company_fein); // Will be slimmed to 16 bit for efficiency
  END;
  CombinationRecord Combine(CombinationRecord le,CombinationRecord ri) := TRANSFORM
    SELF.Basis_Score := IF ( le.Dedup_Val = ri.Dedup_Val, MAX(le.Basis_Score,ri.Basis_Score),le.Basis_Score+ri.Basis_Score );
    SELF.Cnt := IF ( le.Dedup_Val = ri.Dedup_Val,MAX(le.Cnt,ri.Cnt),le.Cnt+ri.Cnt );
    SELF.Dedup_Val := ri.Dedup_Val; // Keep right most to compare to next in line (incoming data sorted by dedup_val)
    SELF.dt_first_seen_Track := MAP(le.dt_first_seen_Track = 0 => ri.dt_first_seen_Track, ri.dt_first_seen_Track = 0 => le.dt_first_seen_Track, MIN(le.dt_first_seen_Track,ri.dt_first_seen_Track));
    SELF.dt_last_seen_Track := MAP(le.dt_last_seen_Track = 0 => ri.dt_last_seen_Track, ri.dt_last_seen_Track = 0 => le.dt_last_seen_Track, MAX(le.dt_last_seen_Track,ri.dt_last_seen_Track));
    SELF := le;
  END;
SHARED CombinationRecord ProduceLinksFEIN(DATASET(RECORDOF(CandidatesFEIN)) le,DATASET(RECORDOF(CandidatesFEIN)) ri) := FUNCTION
    J1 := JOIN(le,ri,LEFT.Seleid>RIGHT.Seleid AND LEFT.company_fein=RIGHT.company_fein,NoteLink(LEFT,RIGHT),ATMOST(LEFT.company_fein=RIGHT.company_fein,10000),GROUP(LEFT.Seleid)); // Slice new in-memory relationship
    /*HACKS FOLLOW*/DJ := DISTRIBUTE(J1, HASH(Seleid1), MERGE(Seleid1));
R  := GROUP(DJ, Seleid1, LOCAL);
J2 := SORT(R,Seleid2,dedup_val);
/*HACKS END*/
    RETURN GROUP(ROLLUP( J2, LEFT.Seleid2=RIGHT.Seleid2, Combine(LEFT,RIGHT)))((Basis_Score) >= 10,Cnt >= 1);
  END;
SHARED SortedCandFEIN := SORT(DISTRIBUTE(CandidatesFEIN,HASH(company_fein)),company_fein,LOCAL); // Prepare so the light joins can be used
  SHARED RelJoinFEIN0_np := ProduceLinksFEIN(SortedCandFEIN,SortedCandFEIN);
  SHARED RelJoinFEIN0 := RelJoinFEIN0_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::FEIN0',EXPIRE(Config.PersistExpire));
EXPORT FEIN_Links_np := RelJoinFEIN0_np;
EXPORT FEIN_Links := RelJoinFEIN0;
// Code for CONTACT relationship 
  BaseFile := h;
  SlimRec := RECORD
    BaseFile.Seleid;
    BaseFile.fname;
    BaseFile.fname_weight100;
    BaseFile.lname;
    BaseFile.lname_weight100;
    BaseFile.mname;
    BaseFile.mname_isnull;
  BaseFile.mname_weight100 ; // Contains 100x the specificity
    BaseFile.contact_ssn;
    BaseFile.contact_ssn_isnull;
  BaseFile.contact_ssn_weight100 ; // Contains 100x the specificity
    BaseFile.contact_phone;
    BaseFile.contact_phone_isnull;
  BaseFile.contact_phone_weight100 ; // Contains 100x the specificity
    BaseFile.contact_email_username;
    BaseFile.contact_email_username_isnull;
  BaseFile.contact_email_username_weight100 ; // Contains 100x the specificity
    BaseFile.dt_first_seen_contact;
    BaseFile.dt_last_seen_contact;
  END;
SHARED CandidatesCONTACT := TABLE(BaseFile(fname_weight100 + lname_weight100>=2000),SlimRec); // Select records with enough specificity in basis and then slim
  CombinationRecord := RECORD
    SALT31.UIDType Seleid1;
    SALT31.UIDType Seleid2;
    INTEGER2 Basis_score; // Score allocated to the basis relationship
    UNSIGNED2 Dedup_Val; // Hash will be stored in here to dedup
    UNSIGNED2 Cnt; // Number of different matching basis
  INTEGER1 mname_match_code;
    INTEGER2 mname_score; // Independent score for this particular field
  INTEGER1 contact_ssn_match_code;
    INTEGER2 contact_ssn_score; // Independent score for this particular field
  INTEGER1 contact_phone_match_code;
    INTEGER2 contact_phone_score; // Independent score for this particular field
  INTEGER1 contact_email_username_match_code;
    INTEGER2 contact_email_username_score; // Independent score for this particular field
    UNSIGNED4 dt_first_seen_contact_track; // Computed date for this particular field
    UNSIGNED4 dt_last_seen_contact_track; // Computed date for this particular field
  END;
  CombinationRecord NoteLink(CandidatesCONTACT le,CandidatesCONTACT ri) := TRANSFORM
    SELF.Seleid1 := le.Seleid;
    SELF.Seleid2 := ri.Seleid;
    SELF.Cnt := 1;
    SELF.dt_first_seen_contact_Track := MAP(le.dt_first_seen_contact = 0 OR ri.dt_first_seen_contact = 0 => 0, MAX(le.dt_first_seen_contact,ri.dt_first_seen_contact));
    SELF.dt_last_seen_contact_Track := MAP(le.dt_last_seen_contact = 0 OR ri.dt_last_seen_contact = 0 => 0, MIN(le.dt_last_seen_contact,ri.dt_last_seen_contact));
    SELF.Basis_Score := (le.fname_weight100 + le.lname_weight100) / 100;
    SELF.Dedup_Val := HASH32(le.fname,le.lname); // Will be slimmed to 16 bit for efficiency
  SELF.mname_match_code := MAP(
		le.mname_isnull OR ri.mname_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_mname(le.mname,ri.mname));
  SELF.mname_score := MAP(
                        le.mname_isnull OR ri.mname_isnull => 0,
                        le.mname = ri.mname  => le.mname_weight100,
                        SALT31.Fn_Fail_Scale(le.mname_weight100,s.mname_switch))/100;
  SELF.contact_ssn_match_code := MAP(
		le.contact_ssn_isnull OR ri.contact_ssn_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_contact_ssn(le.contact_ssn,ri.contact_ssn));
  SELF.contact_ssn_score := MAP(
                        le.contact_ssn_isnull OR ri.contact_ssn_isnull => 0,
                        le.contact_ssn = ri.contact_ssn  => le.contact_ssn_weight100,
                        SALT31.Fn_Fail_Scale(le.contact_ssn_weight100,s.contact_ssn_switch))/100;
  SELF.contact_phone_match_code := MAP(
		le.contact_phone_isnull OR ri.contact_phone_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_contact_phone(le.contact_phone,ri.contact_phone));
  SELF.contact_phone_score := MAP(
                        le.contact_phone_isnull OR ri.contact_phone_isnull => 0,
                        le.contact_phone = ri.contact_phone  => le.contact_phone_weight100,
                        SALT31.Fn_Fail_Scale(le.contact_phone_weight100,s.contact_phone_switch))/100;
  SELF.contact_email_username_match_code := MAP(
		le.contact_email_username_isnull OR ri.contact_email_username_isnull => SALT31.MatchCode.OneSideNull,
		match_methods(ih).match_contact_email_username(le.contact_email_username,ri.contact_email_username));
  SELF.contact_email_username_score := MAP(
                        le.contact_email_username_isnull OR ri.contact_email_username_isnull => 0,
                        le.contact_email_username = ri.contact_email_username  => le.contact_email_username_weight100,
                        SALT31.Fn_Fail_Scale(le.contact_email_username_weight100,s.contact_email_username_switch))/100;
  END;
  CombinationRecord Combine(CombinationRecord le,CombinationRecord ri) := TRANSFORM
    SELF.Basis_Score := IF ( le.Dedup_Val = ri.Dedup_Val, MAX(le.Basis_Score,ri.Basis_Score),le.Basis_Score+ri.Basis_Score );
    SELF.Cnt := IF ( le.Dedup_Val = ri.Dedup_Val,MAX(le.Cnt,ri.Cnt),le.Cnt+ri.Cnt );
    SELF.mname_score := MAX( le.mname_score, ri.mname_score ); // Score fields may only score once
    SELF.contact_ssn_score := MAX( le.contact_ssn_score, ri.contact_ssn_score ); // Score fields may only score once
    SELF.contact_phone_score := MAX( le.contact_phone_score, ri.contact_phone_score ); // Score fields may only score once
    SELF.contact_email_username_score := MAX( le.contact_email_username_score, ri.contact_email_username_score ); // Score fields may only score once
    SELF.Dedup_Val := ri.Dedup_Val; // Keep right most to compare to next in line (incoming data sorted by dedup_val)
    SELF.dt_first_seen_contact_Track := MAP(le.dt_first_seen_contact_Track = 0 => ri.dt_first_seen_contact_Track, ri.dt_first_seen_contact_Track = 0 => le.dt_first_seen_contact_Track, MIN(le.dt_first_seen_contact_Track,ri.dt_first_seen_contact_Track));
    SELF.dt_last_seen_contact_Track := MAP(le.dt_last_seen_contact_Track = 0 => ri.dt_last_seen_contact_Track, ri.dt_last_seen_contact_Track = 0 => le.dt_last_seen_contact_Track, MAX(le.dt_last_seen_contact_Track,ri.dt_last_seen_contact_Track));
    SELF := le;
  END;
SHARED CombinationRecord ProduceLinksCONTACT(DATASET(RECORDOF(CandidatesCONTACT)) le,DATASET(RECORDOF(CandidatesCONTACT)) ri) := FUNCTION
    J1 := JOIN(le,ri,LEFT.Seleid>RIGHT.Seleid AND LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname,NoteLink(LEFT,RIGHT),ATMOST(LEFT.fname=RIGHT.fname AND LEFT.lname=RIGHT.lname,10000),GROUP(LEFT.Seleid)); // Slice new in-memory relationship
    /*HACKS FOLLOW*/DJ := DISTRIBUTE(J1, HASH(Seleid1), MERGE(Seleid1));
R  := GROUP(DJ, Seleid1, LOCAL);
J2 := SORT(R,Seleid2,dedup_val);
/*HACKS END*/
    RETURN GROUP(ROLLUP( J2, LEFT.Seleid2=RIGHT.Seleid2, Combine(LEFT,RIGHT)))((Basis_Score + mname_Score + contact_ssn_Score + contact_phone_Score + contact_email_username_Score) >= 18,Cnt >= 2);
  END;
SHARED SortedCandCONTACT := SORT(DISTRIBUTE(CandidatesCONTACT,HASH(fname,lname)),fname,lname,LOCAL); // Prepare so the light joins can be used
  SHARED RelJoinCONTACT0_np := ProduceLinksCONTACT(SortedCandCONTACT,SortedCandCONTACT);
  SHARED RelJoinCONTACT0 := RelJoinCONTACT0_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::CONTACT0',EXPIRE(Config.PersistExpire));
EXPORT CONTACT_Links_np := RelJoinCONTACT0_np;
EXPORT CONTACT_Links := RelJoinCONTACT0;
// Code for ADDRESS relationship 
  BaseFile := h;
  SlimRec := RECORD
    BaseFile.Seleid;
    BaseFile.prim_name;
    BaseFile.prim_name_weight100;
    BaseFile.prim_range;
    BaseFile.prim_range_weight100;
    BaseFile.v_city_name;
    BaseFile.st;  // Context field needed too
    BaseFile.v_city_name_weight100;
    BaseFile.st_weight100;
    BaseFile.sec_range;
    BaseFile.sec_range_isnull;
  BaseFile.sec_range_weight100 ; // Contains 100x the specificity
    BaseFile.dt_first_seen;
    BaseFile.dt_last_seen;
  END;
SHARED CandidatesADDRESS := TABLE(BaseFile(prim_name_weight100 + prim_range_weight100 + v_city_name_weight100 + st_weight100>=2000),SlimRec); // Select records with enough specificity in basis and then slim
  CombinationRecord := RECORD
    SALT31.UIDType Seleid1;
    SALT31.UIDType Seleid2;
    INTEGER2 Basis_score; // Score allocated to the basis relationship
    UNSIGNED2 Dedup_Val; // Hash will be stored in here to dedup
    UNSIGNED2 Cnt; // Number of different matching basis
    UNSIGNED4 dt_first_seen_track; // Computed date for this particular field
    UNSIGNED4 dt_last_seen_track; // Computed date for this particular field
  END;
  CombinationRecord NoteLink(CandidatesADDRESS le,CandidatesADDRESS ri) := TRANSFORM
    SELF.Seleid1 := le.Seleid;
    SELF.Seleid2 := ri.Seleid;
    SELF.Cnt := 1;
    SELF.dt_first_seen_Track := MAP(le.dt_first_seen = 0 OR ri.dt_first_seen = 0 => 0, MAX(le.dt_first_seen,ri.dt_first_seen));
    SELF.dt_last_seen_Track := MAP(le.dt_last_seen = 0 OR ri.dt_last_seen = 0 => 0, MIN(le.dt_last_seen,ri.dt_last_seen));
  INTEGER2 sec_range_score := MAP(
                        le.sec_range_isnull OR ri.sec_range_isnull => 0,
                        le.sec_range = ri.sec_range  => le.sec_range_weight100,
                        SALT31.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch));
    SELF.Basis_Score := (le.prim_name_weight100 + le.prim_range_weight100 + le.v_city_name_weight100 + le.st_weight100 + sec_range_score) / 100;
    SELF.Dedup_Val := HASH32(le.prim_name); // Will be slimmed to 16 bit for efficiency
  END;
  CombinationRecord Combine(CombinationRecord le,CombinationRecord ri) := TRANSFORM
    SELF.Basis_Score := IF ( le.Dedup_Val = ri.Dedup_Val, MAX(le.Basis_Score,ri.Basis_Score),le.Basis_Score+ri.Basis_Score );
    SELF.Cnt := IF ( le.Dedup_Val = ri.Dedup_Val,MAX(le.Cnt,ri.Cnt),le.Cnt+ri.Cnt );
    SELF.Dedup_Val := ri.Dedup_Val; // Keep right most to compare to next in line (incoming data sorted by dedup_val)
    SELF.dt_first_seen_Track := MAP(le.dt_first_seen_Track = 0 => ri.dt_first_seen_Track, ri.dt_first_seen_Track = 0 => le.dt_first_seen_Track, MIN(le.dt_first_seen_Track,ri.dt_first_seen_Track));
    SELF.dt_last_seen_Track := MAP(le.dt_last_seen_Track = 0 => ri.dt_last_seen_Track, ri.dt_last_seen_Track = 0 => le.dt_last_seen_Track, MAX(le.dt_last_seen_Track,ri.dt_last_seen_Track));
    SELF := le;
  END;
SHARED CombinationRecord ProduceLinksADDRESS(DATASET(RECORDOF(CandidatesADDRESS)) le,DATASET(RECORDOF(CandidatesADDRESS)) ri) := FUNCTION
    J1 := JOIN(le,ri,LEFT.Seleid>RIGHT.Seleid AND LEFT.prim_name=RIGHT.prim_name AND LEFT.prim_range=RIGHT.prim_range AND LEFT.v_city_name=RIGHT.v_city_name AND LEFT.st=RIGHT.st AND LEFT.st=RIGHT.st AND (LEFT.sec_range=RIGHT.sec_range OR LEFT.sec_range_isnull OR RIGHT.sec_range_isnull),NoteLink(LEFT,RIGHT),ATMOST(LEFT.prim_name=RIGHT.prim_name AND LEFT.prim_range=RIGHT.prim_range AND LEFT.v_city_name=RIGHT.v_city_name AND LEFT.st=RIGHT.st AND LEFT.st=RIGHT.st,10000),GROUP(LEFT.Seleid)); // Slice new in-memory relationship
    /*HACKS FOLLOW*/DJ := DISTRIBUTE(J1, HASH(Seleid1), MERGE(Seleid1));
R  := GROUP(DJ, Seleid1, LOCAL);
J2 := SORT(R,Seleid2,dedup_val);
/*HACKS END*/
    RETURN GROUP(ROLLUP( J2, LEFT.Seleid2=RIGHT.Seleid2, Combine(LEFT,RIGHT)))((Basis_Score) >= 10,Cnt >= 2);
  END;
SHARED SortedCandADDRESS := SORT(DISTRIBUTE(CandidatesADDRESS,HASH(prim_name,prim_range,v_city_name,st)),prim_name,prim_range,v_city_name,st,LOCAL); // Prepare so the light joins can be used
  SHARED RelJoinADDRESS0_np := ProduceLinksADDRESS(SortedCandADDRESS(Seleid % 8 = 0),SortedCandADDRESS(Seleid % 2 = 0));
  SHARED RelJoinADDRESS0 := RelJoinADDRESS0_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::ADDRESS0',EXPIRE(Config.PersistExpire));
  SHARED RelJoinADDRESS1_np := ProduceLinksADDRESS(SortedCandADDRESS(Seleid % 8 = 0),SortedCandADDRESS(Seleid % 2 = 1));
  SHARED RelJoinADDRESS1 := RelJoinADDRESS1_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::ADDRESS1',EXPIRE(Config.PersistExpire));
  SHARED RelJoinADDRESS2_np := ProduceLinksADDRESS(SortedCandADDRESS(Seleid % 8 = 1),SortedCandADDRESS(Seleid % 2 = 0));
  SHARED RelJoinADDRESS2 := RelJoinADDRESS2_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::ADDRESS2',EXPIRE(Config.PersistExpire));
  SHARED RelJoinADDRESS3_np := ProduceLinksADDRESS(SortedCandADDRESS(Seleid % 8 = 1),SortedCandADDRESS(Seleid % 2 = 1));
  SHARED RelJoinADDRESS3 := RelJoinADDRESS3_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::ADDRESS3',EXPIRE(Config.PersistExpire));
  SHARED RelJoinADDRESS4_np := ProduceLinksADDRESS(SortedCandADDRESS(Seleid % 8 = 2),SortedCandADDRESS(Seleid % 2 = 0));
  SHARED RelJoinADDRESS4 := RelJoinADDRESS4_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::ADDRESS4',EXPIRE(Config.PersistExpire));
  SHARED RelJoinADDRESS5_np := ProduceLinksADDRESS(SortedCandADDRESS(Seleid % 8 = 2),SortedCandADDRESS(Seleid % 2 = 1));
  SHARED RelJoinADDRESS5 := RelJoinADDRESS5_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::ADDRESS5',EXPIRE(Config.PersistExpire));
  SHARED RelJoinADDRESS6_np := ProduceLinksADDRESS(SortedCandADDRESS(Seleid % 8 = 3),SortedCandADDRESS(Seleid % 2 = 0));
  SHARED RelJoinADDRESS6 := RelJoinADDRESS6_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::ADDRESS6',EXPIRE(Config.PersistExpire));
  SHARED RelJoinADDRESS7_np := ProduceLinksADDRESS(SortedCandADDRESS(Seleid % 8 = 3),SortedCandADDRESS(Seleid % 2 = 1));
  SHARED RelJoinADDRESS7 := RelJoinADDRESS7_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::ADDRESS7',EXPIRE(Config.PersistExpire));
  SHARED RelJoinADDRESS8_np := ProduceLinksADDRESS(SortedCandADDRESS(Seleid % 8 = 4),SortedCandADDRESS(Seleid % 2 = 0));
  SHARED RelJoinADDRESS8 := RelJoinADDRESS8_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::ADDRESS8',EXPIRE(Config.PersistExpire));
  SHARED RelJoinADDRESS9_np := ProduceLinksADDRESS(SortedCandADDRESS(Seleid % 8 = 4),SortedCandADDRESS(Seleid % 2 = 1));
  SHARED RelJoinADDRESS9 := RelJoinADDRESS9_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::ADDRESS9',EXPIRE(Config.PersistExpire));
  SHARED RelJoinADDRESS10_np := ProduceLinksADDRESS(SortedCandADDRESS(Seleid % 8 = 5),SortedCandADDRESS(Seleid % 2 = 0));
  SHARED RelJoinADDRESS10 := RelJoinADDRESS10_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::ADDRESS10',EXPIRE(Config.PersistExpire));
  SHARED RelJoinADDRESS11_np := ProduceLinksADDRESS(SortedCandADDRESS(Seleid % 8 = 5),SortedCandADDRESS(Seleid % 2 = 1));
  SHARED RelJoinADDRESS11 := RelJoinADDRESS11_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::ADDRESS11',EXPIRE(Config.PersistExpire));
  SHARED RelJoinADDRESS12_np := ProduceLinksADDRESS(SortedCandADDRESS(Seleid % 8 = 6),SortedCandADDRESS(Seleid % 2 = 0));
  SHARED RelJoinADDRESS12 := RelJoinADDRESS12_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::ADDRESS12',EXPIRE(Config.PersistExpire));
  SHARED RelJoinADDRESS13_np := ProduceLinksADDRESS(SortedCandADDRESS(Seleid % 8 = 6),SortedCandADDRESS(Seleid % 2 = 1));
  SHARED RelJoinADDRESS13 := RelJoinADDRESS13_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::ADDRESS13',EXPIRE(Config.PersistExpire));
  SHARED RelJoinADDRESS14_np := ProduceLinksADDRESS(SortedCandADDRESS(Seleid % 8 = 7),SortedCandADDRESS(Seleid % 2 = 0));
  SHARED RelJoinADDRESS14 := RelJoinADDRESS14_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::ADDRESS14',EXPIRE(Config.PersistExpire));
  SHARED RelJoinADDRESS15_np := ProduceLinksADDRESS(SortedCandADDRESS(Seleid % 8 = 7),SortedCandADDRESS(Seleid % 2 = 1));
  SHARED RelJoinADDRESS15 := RelJoinADDRESS15_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::ADDRESS15',EXPIRE(Config.PersistExpire));
EXPORT ADDRESS_Links_np := RelJoinADDRESS0_np + RelJoinADDRESS1_np + RelJoinADDRESS2_np + RelJoinADDRESS3_np + RelJoinADDRESS4_np + RelJoinADDRESS5_np + RelJoinADDRESS6_np + RelJoinADDRESS7_np + RelJoinADDRESS8_np + RelJoinADDRESS9_np + RelJoinADDRESS10_np + RelJoinADDRESS11_np + RelJoinADDRESS12_np + RelJoinADDRESS13_np + RelJoinADDRESS14_np + RelJoinADDRESS15_np;
EXPORT ADDRESS_Links := RelJoinADDRESS0 + RelJoinADDRESS1 + RelJoinADDRESS2 + RelJoinADDRESS3 + RelJoinADDRESS4 + RelJoinADDRESS5 + RelJoinADDRESS6 + RelJoinADDRESS7 + RelJoinADDRESS8 + RelJoinADDRESS9 + RelJoinADDRESS10 + RelJoinADDRESS11 + RelJoinADDRESS12 + RelJoinADDRESS13 + RelJoinADDRESS14 + RelJoinADDRESS15;
// Code for DUNS_NUMBER relationship 
  BaseFile := h;
  SlimRec := RECORD
    BaseFile.Seleid;
    BaseFile.active_duns_number;
    BaseFile.active_duns_number_weight100;
    BaseFile.dt_first_seen;
    BaseFile.dt_last_seen;
  END;
SHARED CandidatesDUNS_NUMBER := TABLE(BaseFile(active_duns_number_weight100>=2000),SlimRec); // Select records with enough specificity in basis and then slim
  CombinationRecord := RECORD
    SALT31.UIDType Seleid1;
    SALT31.UIDType Seleid2;
    INTEGER2 Basis_score; // Score allocated to the basis relationship
    UNSIGNED2 Dedup_Val; // Hash will be stored in here to dedup
    UNSIGNED2 Cnt; // Number of different matching basis
    UNSIGNED4 dt_first_seen_track; // Computed date for this particular field
    UNSIGNED4 dt_last_seen_track; // Computed date for this particular field
  END;
  CombinationRecord NoteLink(CandidatesDUNS_NUMBER le,CandidatesDUNS_NUMBER ri) := TRANSFORM
    SELF.Seleid1 := le.Seleid;
    SELF.Seleid2 := ri.Seleid;
    SELF.Cnt := 1;
    SELF.dt_first_seen_Track := MAP(le.dt_first_seen = 0 OR ri.dt_first_seen = 0 => 0, MAX(le.dt_first_seen,ri.dt_first_seen));
    SELF.dt_last_seen_Track := MAP(le.dt_last_seen = 0 OR ri.dt_last_seen = 0 => 0, MIN(le.dt_last_seen,ri.dt_last_seen));
    SELF.Basis_Score := (le.active_duns_number_weight100) / 100;
    SELF.Dedup_Val := HASH32(le.active_duns_number); // Will be slimmed to 16 bit for efficiency
  END;
  CombinationRecord Combine(CombinationRecord le,CombinationRecord ri) := TRANSFORM
    SELF.Basis_Score := IF ( le.Dedup_Val = ri.Dedup_Val, MAX(le.Basis_Score,ri.Basis_Score),le.Basis_Score+ri.Basis_Score );
    SELF.Cnt := IF ( le.Dedup_Val = ri.Dedup_Val,MAX(le.Cnt,ri.Cnt),le.Cnt+ri.Cnt );
    SELF.Dedup_Val := ri.Dedup_Val; // Keep right most to compare to next in line (incoming data sorted by dedup_val)
    SELF.dt_first_seen_Track := MAP(le.dt_first_seen_Track = 0 => ri.dt_first_seen_Track, ri.dt_first_seen_Track = 0 => le.dt_first_seen_Track, MIN(le.dt_first_seen_Track,ri.dt_first_seen_Track));
    SELF.dt_last_seen_Track := MAP(le.dt_last_seen_Track = 0 => ri.dt_last_seen_Track, ri.dt_last_seen_Track = 0 => le.dt_last_seen_Track, MAX(le.dt_last_seen_Track,ri.dt_last_seen_Track));
    SELF := le;
  END;
SHARED CombinationRecord ProduceLinksDUNS_NUMBER(DATASET(RECORDOF(CandidatesDUNS_NUMBER)) le,DATASET(RECORDOF(CandidatesDUNS_NUMBER)) ri) := FUNCTION
    J1 := JOIN(le,ri,LEFT.Seleid>RIGHT.Seleid AND LEFT.active_duns_number=RIGHT.active_duns_number,NoteLink(LEFT,RIGHT),ATMOST(LEFT.active_duns_number=RIGHT.active_duns_number,10000),GROUP(LEFT.Seleid)); // Slice new in-memory relationship
    /*HACKS FOLLOW*/DJ := DISTRIBUTE(J1, HASH(Seleid1), MERGE(Seleid1));
R  := GROUP(DJ, Seleid1, LOCAL);
J2 := SORT(R,Seleid2,dedup_val);
/*HACKS END*/
    RETURN GROUP(ROLLUP( J2, LEFT.Seleid2=RIGHT.Seleid2, Combine(LEFT,RIGHT)))((Basis_Score) >= 10,Cnt >= 1);
  END;
SHARED SortedCandDUNS_NUMBER := SORT(DISTRIBUTE(CandidatesDUNS_NUMBER,HASH(active_duns_number)),active_duns_number,LOCAL); // Prepare so the light joins can be used
  SHARED RelJoinDUNS_NUMBER0_np := ProduceLinksDUNS_NUMBER(SortedCandDUNS_NUMBER,SortedCandDUNS_NUMBER);
  SHARED RelJoinDUNS_NUMBER0 := RelJoinDUNS_NUMBER0_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::DUNS_NUMBER0',EXPIRE(Config.PersistExpire));
EXPORT DUNS_NUMBER_Links_np := RelJoinDUNS_NUMBER0_np;
EXPORT DUNS_NUMBER_Links := RelJoinDUNS_NUMBER0;
// Code for ENTERPRISE_NUMBER relationship 
  BaseFile := h;
  SlimRec := RECORD
    BaseFile.Seleid;
    BaseFile.active_enterprise_number;
    BaseFile.active_enterprise_number_weight100;
    BaseFile.dt_first_seen;
    BaseFile.dt_last_seen;
  END;
SHARED CandidatesENTERPRISE_NUMBER := TABLE(BaseFile(active_enterprise_number_weight100>=2000),SlimRec); // Select records with enough specificity in basis and then slim
  CombinationRecord := RECORD
    SALT31.UIDType Seleid1;
    SALT31.UIDType Seleid2;
    INTEGER2 Basis_score; // Score allocated to the basis relationship
    UNSIGNED2 Dedup_Val; // Hash will be stored in here to dedup
    UNSIGNED2 Cnt; // Number of different matching basis
    UNSIGNED4 dt_first_seen_track; // Computed date for this particular field
    UNSIGNED4 dt_last_seen_track; // Computed date for this particular field
  END;
  CombinationRecord NoteLink(CandidatesENTERPRISE_NUMBER le,CandidatesENTERPRISE_NUMBER ri) := TRANSFORM
    SELF.Seleid1 := le.Seleid;
    SELF.Seleid2 := ri.Seleid;
    SELF.Cnt := 1;
    SELF.dt_first_seen_Track := MAP(le.dt_first_seen = 0 OR ri.dt_first_seen = 0 => 0, MAX(le.dt_first_seen,ri.dt_first_seen));
    SELF.dt_last_seen_Track := MAP(le.dt_last_seen = 0 OR ri.dt_last_seen = 0 => 0, MIN(le.dt_last_seen,ri.dt_last_seen));
    SELF.Basis_Score := (le.active_enterprise_number_weight100) / 100;
    SELF.Dedup_Val := HASH32(le.active_enterprise_number); // Will be slimmed to 16 bit for efficiency
  END;
  CombinationRecord Combine(CombinationRecord le,CombinationRecord ri) := TRANSFORM
    SELF.Basis_Score := IF ( le.Dedup_Val = ri.Dedup_Val, MAX(le.Basis_Score,ri.Basis_Score),le.Basis_Score+ri.Basis_Score );
    SELF.Cnt := IF ( le.Dedup_Val = ri.Dedup_Val,MAX(le.Cnt,ri.Cnt),le.Cnt+ri.Cnt );
    SELF.Dedup_Val := ri.Dedup_Val; // Keep right most to compare to next in line (incoming data sorted by dedup_val)
    SELF.dt_first_seen_Track := MAP(le.dt_first_seen_Track = 0 => ri.dt_first_seen_Track, ri.dt_first_seen_Track = 0 => le.dt_first_seen_Track, MIN(le.dt_first_seen_Track,ri.dt_first_seen_Track));
    SELF.dt_last_seen_Track := MAP(le.dt_last_seen_Track = 0 => ri.dt_last_seen_Track, ri.dt_last_seen_Track = 0 => le.dt_last_seen_Track, MAX(le.dt_last_seen_Track,ri.dt_last_seen_Track));
    SELF := le;
  END;
SHARED CombinationRecord ProduceLinksENTERPRISE_NUMBER(DATASET(RECORDOF(CandidatesENTERPRISE_NUMBER)) le,DATASET(RECORDOF(CandidatesENTERPRISE_NUMBER)) ri) := FUNCTION
    J1 := JOIN(le,ri,LEFT.Seleid>RIGHT.Seleid AND LEFT.active_enterprise_number=RIGHT.active_enterprise_number,NoteLink(LEFT,RIGHT),ATMOST(LEFT.active_enterprise_number=RIGHT.active_enterprise_number,10000),GROUP(LEFT.Seleid)); // Slice new in-memory relationship
    /*HACKS FOLLOW*/DJ := DISTRIBUTE(J1, HASH(Seleid1), MERGE(Seleid1));
R  := GROUP(DJ, Seleid1, LOCAL);
J2 := SORT(R,Seleid2,dedup_val);
/*HACKS END*/
    RETURN GROUP(ROLLUP( J2, LEFT.Seleid2=RIGHT.Seleid2, Combine(LEFT,RIGHT)))((Basis_Score) >= 10,Cnt >= 1);
  END;
SHARED SortedCandENTERPRISE_NUMBER := SORT(DISTRIBUTE(CandidatesENTERPRISE_NUMBER,HASH(active_enterprise_number)),active_enterprise_number,LOCAL); // Prepare so the light joins can be used
  SHARED RelJoinENTERPRISE_NUMBER0_np := ProduceLinksENTERPRISE_NUMBER(SortedCandENTERPRISE_NUMBER,SortedCandENTERPRISE_NUMBER);
  SHARED RelJoinENTERPRISE_NUMBER0 := RelJoinENTERPRISE_NUMBER0_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::ENTERPRISE_NUMBER0',EXPIRE(Config.PersistExpire));
EXPORT ENTERPRISE_NUMBER_Links_np := RelJoinENTERPRISE_NUMBER0_np;
EXPORT ENTERPRISE_NUMBER_Links := RelJoinENTERPRISE_NUMBER0;
// Code for SOURCE relationship 
  BaseFile := h;
  SlimRec := RECORD
    BaseFile.Seleid;
    BaseFile.source;
    BaseFile.source_weight100;
    BaseFile.source_record_id;
    BaseFile.source_record_id_weight100;
    BaseFile.dt_first_seen;
    BaseFile.dt_last_seen;
  END;
SHARED CandidatesSOURCE := TABLE(BaseFile(source_weight100 + source_record_id_weight100>=2000),SlimRec); // Select records with enough specificity in basis and then slim
  CombinationRecord := RECORD
    SALT31.UIDType Seleid1;
    SALT31.UIDType Seleid2;
    INTEGER2 Basis_score; // Score allocated to the basis relationship
    UNSIGNED2 Dedup_Val; // Hash will be stored in here to dedup
    UNSIGNED2 Cnt; // Number of different matching basis
    UNSIGNED4 dt_first_seen_track; // Computed date for this particular field
    UNSIGNED4 dt_last_seen_track; // Computed date for this particular field
  END;
  CombinationRecord NoteLink(CandidatesSOURCE le,CandidatesSOURCE ri) := TRANSFORM
    SELF.Seleid1 := le.Seleid;
    SELF.Seleid2 := ri.Seleid;
    SELF.Cnt := 1;
    SELF.dt_first_seen_Track := MAP(le.dt_first_seen = 0 OR ri.dt_first_seen = 0 => 0, MAX(le.dt_first_seen,ri.dt_first_seen));
    SELF.dt_last_seen_Track := MAP(le.dt_last_seen = 0 OR ri.dt_last_seen = 0 => 0, MIN(le.dt_last_seen,ri.dt_last_seen));
    SELF.Basis_Score := (le.source_weight100 + le.source_record_id_weight100) / 100;
    SELF.Dedup_Val := HASH32(le.source,le.source_record_id); // Will be slimmed to 16 bit for efficiency
  END;
  CombinationRecord Combine(CombinationRecord le,CombinationRecord ri) := TRANSFORM
    SELF.Basis_Score := IF ( le.Dedup_Val = ri.Dedup_Val, MAX(le.Basis_Score,ri.Basis_Score),le.Basis_Score+ri.Basis_Score );
    SELF.Cnt := IF ( le.Dedup_Val = ri.Dedup_Val,MAX(le.Cnt,ri.Cnt),le.Cnt+ri.Cnt );
    SELF.Dedup_Val := ri.Dedup_Val; // Keep right most to compare to next in line (incoming data sorted by dedup_val)
    SELF.dt_first_seen_Track := MAP(le.dt_first_seen_Track = 0 => ri.dt_first_seen_Track, ri.dt_first_seen_Track = 0 => le.dt_first_seen_Track, MIN(le.dt_first_seen_Track,ri.dt_first_seen_Track));
    SELF.dt_last_seen_Track := MAP(le.dt_last_seen_Track = 0 => ri.dt_last_seen_Track, ri.dt_last_seen_Track = 0 => le.dt_last_seen_Track, MAX(le.dt_last_seen_Track,ri.dt_last_seen_Track));
    SELF := le;
  END;
SHARED CombinationRecord ProduceLinksSOURCE(DATASET(RECORDOF(CandidatesSOURCE)) le,DATASET(RECORDOF(CandidatesSOURCE)) ri) := FUNCTION
    J1 := JOIN(le,ri,LEFT.Seleid>RIGHT.Seleid AND LEFT.source=RIGHT.source AND LEFT.source_record_id=RIGHT.source_record_id,NoteLink(LEFT,RIGHT),ATMOST(LEFT.source=RIGHT.source AND LEFT.source_record_id=RIGHT.source_record_id,10000),GROUP(LEFT.Seleid)); // Slice new in-memory relationship
    /*HACKS FOLLOW*/DJ := DISTRIBUTE(J1, HASH(Seleid1), MERGE(Seleid1));
R  := GROUP(DJ, Seleid1, LOCAL);
J2 := SORT(R,Seleid2,dedup_val);
/*HACKS END*/
    RETURN GROUP(ROLLUP( J2, LEFT.Seleid2=RIGHT.Seleid2, Combine(LEFT,RIGHT)))((Basis_Score) >= 20,Cnt >= 1);
  END;
SHARED SortedCandSOURCE := SORT(DISTRIBUTE(CandidatesSOURCE,HASH(source,source_record_id)),source,source_record_id,LOCAL); // Prepare so the light joins can be used
  SHARED RelJoinSOURCE0_np := ProduceLinksSOURCE(SortedCandSOURCE,SortedCandSOURCE);
  SHARED RelJoinSOURCE0 := RelJoinSOURCE0_np : PERSIST('~temp::Seleid::BIPV2_Seleid_Relative::RLink::SOURCE0',EXPIRE(Config.PersistExpire));
EXPORT SOURCE_Links_np := RelJoinSOURCE0_np;
EXPORT SOURCE_Links := RelJoinSOURCE0;
// Code for ASSOC relationship 
SHARED ASSOCCRec := RECORD
    SALT31.UIDType Seleid1;
    SALT31.UIDType Seleid2;
    INTEGER2 DUNS_NUMBER_score := 0;
    INTEGER2 DUNS_NUMBER_cnt := 0;
    INTEGER2 ENTERPRISE_NUMBER_score := 0;
    INTEGER2 ENTERPRISE_NUMBER_cnt := 0;
    INTEGER2 SOURCE_score := 0;
    INTEGER2 SOURCE_cnt := 0;
    INTEGER2 CONTACT_score := 0;
    INTEGER2 CONTACT_cnt := 0;
    INTEGER2 ADDRESS_score := 0;
    INTEGER2 ADDRESS_cnt := 0;
    INTEGER2 NAMEST_score := 0;
    INTEGER2 NAMEST_cnt := 0;
    INTEGER2 CHARTER_score := 0;
    INTEGER2 CHARTER_cnt := 0;
    INTEGER2 FEIN_score := 0;
    INTEGER2 FEIN_cnt := 0;
    INTEGER2 mname_score := 0;
    INTEGER2 contact_ssn_score := 0;
    INTEGER2 contact_phone_score := 0;
    INTEGER2 contact_email_username_score := 0;
    UNSIGNED4 dt_first_seen_Track := 0;
    UNSIGNED4 dt_last_seen_Track := 0;
    UNSIGNED4 dt_first_seen_contact_Track := 0;
    UNSIGNED4 dt_last_seen_contact_Track := 0;
  END;
  ASSOCCRec Into(DUNS_NUMBER_Links le) := TRANSFORM
    SELF.DUNS_NUMBER_score := le.Basis_score;
    SELF.DUNS_NUMBER_cnt := le.Cnt;
    SELF := le;
  END;
SHARED DUNS_NUMBER_combined_links := PROJECT(DUNS_NUMBER_links,Into(LEFT));
  ASSOCCRec Into(ENTERPRISE_NUMBER_Links le) := TRANSFORM
    SELF.ENTERPRISE_NUMBER_score := le.Basis_score;
    SELF.ENTERPRISE_NUMBER_cnt := le.Cnt;
    SELF := le;
  END;
SHARED ENTERPRISE_NUMBER_combined_links := PROJECT(ENTERPRISE_NUMBER_links,Into(LEFT));
  ASSOCCRec Into(SOURCE_Links le) := TRANSFORM
    SELF.SOURCE_score := le.Basis_score;
    SELF.SOURCE_cnt := le.Cnt;
    SELF := le;
  END;
SHARED SOURCE_combined_links := PROJECT(SOURCE_links,Into(LEFT));
  ASSOCCRec Into(CONTACT_Links le) := TRANSFORM
    SELF.CONTACT_score := le.Basis_score;
    SELF.CONTACT_cnt := le.Cnt;
    SELF := le;
  END;
SHARED CONTACT_combined_links := PROJECT(CONTACT_links,Into(LEFT));
  ASSOCCRec Into(ADDRESS_Links le) := TRANSFORM
    SELF.ADDRESS_score := le.Basis_score;
    SELF.ADDRESS_cnt := le.Cnt;
    SELF := le;
  END;
SHARED ADDRESS_combined_links := PROJECT(ADDRESS_links,Into(LEFT));
  ASSOCCRec Into(NAMEST_Links le) := TRANSFORM
    SELF.NAMEST_score := le.Basis_score;
    SELF.NAMEST_cnt := le.Cnt;
    SELF := le;
  END;
SHARED NAMEST_combined_links := PROJECT(NAMEST_links,Into(LEFT));
  ASSOCCRec Into(CHARTER_Links le) := TRANSFORM
    SELF.CHARTER_score := le.Basis_score;
    SELF.CHARTER_cnt := le.Cnt;
    SELF := le;
  END;
SHARED CHARTER_combined_links := PROJECT(CHARTER_links,Into(LEFT));
  ASSOCCRec Into(FEIN_Links le) := TRANSFORM
    SELF.FEIN_score := le.Basis_score;
    SELF.FEIN_cnt := le.Cnt;
    SELF := le;
  END;
SHARED FEIN_combined_links := PROJECT(FEIN_links,Into(LEFT));
  All_Combined := SORT(DUNS_NUMBER_combined_links + ENTERPRISE_NUMBER_combined_links + SOURCE_combined_links + CONTACT_combined_links + ADDRESS_combined_links + NAMEST_combined_links + CHARTER_combined_links + FEIN_combined_links,Seleid1,Seleid2,LOCAL);
  ASSOCCRec Roll(All_Combined le,All_Combined ri) := transform
    SELF.DUNS_NUMBER_score := MAX(le.DUNS_NUMBER_score,ri.DUNS_NUMBER_score);
    SELF.DUNS_NUMBER_cnt := MAX(le.DUNS_NUMBER_cnt,ri.DUNS_NUMBER_cnt);
    SELF.ENTERPRISE_NUMBER_score := MAX(le.ENTERPRISE_NUMBER_score,ri.ENTERPRISE_NUMBER_score);
    SELF.ENTERPRISE_NUMBER_cnt := MAX(le.ENTERPRISE_NUMBER_cnt,ri.ENTERPRISE_NUMBER_cnt);
    SELF.SOURCE_score := MAX(le.SOURCE_score,ri.SOURCE_score);
    SELF.SOURCE_cnt := MAX(le.SOURCE_cnt,ri.SOURCE_cnt);
    SELF.CONTACT_score := MAX(le.CONTACT_score,ri.CONTACT_score);
    SELF.CONTACT_cnt := MAX(le.CONTACT_cnt,ri.CONTACT_cnt);
    SELF.ADDRESS_score := MAX(le.ADDRESS_score,ri.ADDRESS_score);
    SELF.ADDRESS_cnt := MAX(le.ADDRESS_cnt,ri.ADDRESS_cnt);
    SELF.NAMEST_score := MAX(le.NAMEST_score,ri.NAMEST_score);
    SELF.NAMEST_cnt := MAX(le.NAMEST_cnt,ri.NAMEST_cnt);
    SELF.CHARTER_score := MAX(le.CHARTER_score,ri.CHARTER_score);
    SELF.CHARTER_cnt := MAX(le.CHARTER_cnt,ri.CHARTER_cnt);
    SELF.FEIN_score := MAX(le.FEIN_score,ri.FEIN_score);
    SELF.FEIN_cnt := MAX(le.FEIN_cnt,ri.FEIN_cnt);
    SELF.dt_first_seen_Track := MAP(le.dt_first_seen_Track = 0 => ri.dt_first_seen_Track, ri.dt_first_seen_Track = 0 => le.dt_first_seen_Track, MIN(le.dt_first_seen_Track,ri.dt_first_seen_Track));
    SELF.dt_last_seen_Track := MAP(le.dt_last_seen_Track = 0 => ri.dt_last_seen_Track, ri.dt_last_seen_Track = 0 => le.dt_last_seen_Track, MAX(le.dt_last_seen_Track,ri.dt_last_seen_Track));
    SELF.dt_first_seen_contact_Track := MAP(le.dt_first_seen_contact_Track = 0 => ri.dt_first_seen_contact_Track, ri.dt_first_seen_contact_Track = 0 => le.dt_first_seen_contact_Track, MIN(le.dt_first_seen_contact_Track,ri.dt_first_seen_contact_Track));
    SELF.dt_last_seen_contact_Track := MAP(le.dt_last_seen_contact_Track = 0 => ri.dt_last_seen_contact_Track, ri.dt_last_seen_contact_Track = 0 => le.dt_last_seen_contact_Track, MAX(le.dt_last_seen_contact_Track,ri.dt_last_seen_contact_Track));
    SELF.mname_score := MAX(le.mname_score,ri.mname_score);
    SELF.contact_ssn_score := MAX(le.contact_ssn_score,ri.contact_ssn_score);
    SELF.contact_phone_score := MAX(le.contact_phone_score,ri.contact_phone_score);
    SELF.contact_email_username_score := MAX(le.contact_email_username_score,ri.contact_email_username_score);
    SELF := le;
  END;
  Rolled := ROLLUP( All_Combined, left.Seleid1=right.Seleid1 AND left.Seleid2=right.Seleid2, Roll(left,right), local );
  WithTots := RECORD
    Rolled;
    UNSIGNED2 Total_Cnt :=Rolled.DUNS_NUMBER_cnt + Rolled.ENTERPRISE_NUMBER_cnt + Rolled.SOURCE_cnt + Rolled.CONTACT_cnt + Rolled.ADDRESS_cnt + Rolled.NAMEST_cnt + Rolled.CHARTER_cnt + Rolled.FEIN_cnt;
    INTEGER2 Total_Score := Rolled.DUNS_NUMBER_score + Rolled.ENTERPRISE_NUMBER_score + Rolled.SOURCE_score + Rolled.CONTACT_score + Rolled.ADDRESS_score + Rolled.NAMEST_score + Rolled.CHARTER_score + Rolled.FEIN_score + Rolled.mname_score + Rolled.contact_ssn_score + Rolled.contact_phone_score + Rolled.contact_email_username_score;
  END;
EXPORT ASSOC_links := table(Rolled,WithTots)(Total_Score >= 18);
  All_Combined := SORT(TABLE(ASSOC_links,{Seleid1,Seleid2,Total_cnt,Total_Score}),Seleid1,Seleid2,LOCAL);
  All_Combined Roll(All_Combined le,All_Combined ri) := TRANSFORM
    SELF.Total_score := MAX(le.Total_score,ri.Total_score);
    SELF.Total_cnt := MAX(le.Total_cnt,ri.Total_cnt);
    SELF := le;
  END;
  All_Combined MakeSymmetric(All_Combined le,INTEGER C) := TRANSFORM
    SELF.Seleid1 := IF(C=0,le.Seleid1,le.Seleid2);
    SELF.Seleid2 := IF(C=0,le.Seleid2,le.Seleid1);
    SELF := le;
  END;
EXPORT All_Relationship_Links := NORMALIZE(ROLLUP( All_Combined, LEFT.Seleid1=RIGHT.Seleid1 AND LEFT.Seleid2=RIGHT.Seleid2, Roll(LEFT,RIGHT), LOCAL ),2,MakeSymmetric(LEFT,COUNTER));
END;
