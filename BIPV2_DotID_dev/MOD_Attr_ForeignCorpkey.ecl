// Logic to handle the matching around ForeignCorpkey
 
IMPORT SALT30,ut,std;
EXPORT MOD_Attr_ForeignCorpkey(DATASET(layout_DOT) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
// Construct a function to filter matches to those that obey the force criteria on this attribute file.
EXPORT ForceFilter(inhead,infile,id1,id2) := FUNCTIONMACRO
// Every attribute value must match to a value in the other attribute IF they have the same context
  Cands0 := BIPV2_DOTID_dev.match_candidates(inhead).ForeignCorpkey_candidates;
// We are going to create a record for each candidate pair; this record will have a child dataset for the attribute values of each side
  ChildRec := RECORD
    Cands0.DOTid;
    Cands0.Basis_Weight100;
    Cands0.Basis;
    SALT30.StrType Context := SALT30.GetNthWord(Cands0.Basis,2,'|'); // Context for the basis ('<')
  END;
  Cands1 := TABLE(Cands0,ChildRec);
  Cands := DEDUP( SORT( DISTRIBUTE(Cands1,HASH(DOTid)), WHOLE RECORD, LOCAL), WHOLE RECORD, LOCAL);
  // This is an optimized version of the code that takes particular advantage of the FORCE you are using
  Mtch0 := DISTRIBUTE(TABLE(infile,{id1,id2}),HASH(id1));
  Mtch := DEDUP( SORT( Mtch0, id1, id2, LOCAL ), id1, id2, LOCAL );
  Jnd := JOIN(Mtch,Cands,LEFT.id1=RIGHT.DOTid,LOCAL);
  Bads := JOIN(DISTRIBUTE(Jnd,HASH(id2)),Cands,LEFT.id2=RIGHT.DOTid AND LEFT.Context=RIGHT.Context AND LEFT.Basis<>RIGHT.Basis,TRANSFORM(LEFT),LOCAL);
  RETURN JOIN(infile,Bads,LEFT.id1=RIGHT.id1 AND LEFT.id2=RIGHT.id2,TRANSFORM(LEFT),LEFT ONLY, SMART);
ENDMACRO;
SHARED Cands := match_candidates(ih).ForeignCorpkey_candidates;
SHARED s := Specificities(ih).Specificities[1];
 
// Generate match candidates based upon this attribute file
 
match_candidates(ih).Layout_Attribute_Matches Score(Cands le,Cands ri) := TRANSFORM
  SELF.rule := 10000; // Signify Attribute File #0
  SELF.DOTid1 := le.DOTid;
  SELF.DOTid2 := ri.DOTid;
  SELF.source_id := le.Basis;
  INTEGER2 cnp_number_score_temp := MAP(
                        le.cnp_number = ri.cnp_number  => le.cnp_number_weight100,
                        SALT30.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  INTEGER2 isContact_score_temp := MAP(
                        le.isContact = ri.isContact  => le.isContact_weight100,
                        SALT30.Fn_Fail_Scale(le.isContact_weight100,s.isContact_switch));
  INTEGER2 company_fein_score_temp := MAP(
                        le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT30.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  INTEGER2 active_enterprise_number_score_temp := MAP(
                        le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,
                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,
                        SALT30.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));
  INTEGER2 active_domestic_corp_key_score_temp := MAP(
                        le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,
                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,
                        SALT30.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));
  INTEGER2 cnp_name_score_temp := MAP(
                        le.cnp_name_isnull OR ri.cnp_name_isnull OR le.cnp_name_weight100 = 0 => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT30.WithinEditN(le.cnp_name,ri.cnp_name,1,0) => SALT30.fn_fuzzy_specificity(le.cnp_name_weight100,le.cnp_name_cnt, le.cnp_name_e1_cnt,ri.cnp_name_weight100,ri.cnp_name_cnt,ri.cnp_name_e1_cnt),
                        SALT30.Fn_Fail_Scale(le.cnp_name_weight100,s.cnp_name_switch));
  INTEGER2 corp_legal_name_score_temp := MAP(
                        le.corp_legal_name_isnull OR ri.corp_legal_name_isnull => 0,
                        le.corp_legal_name = ri.corp_legal_name  => le.corp_legal_name_weight100,
                        SALT30.MatchBagOfWords(le.corp_legal_name,ri.corp_legal_name,31762,1));
  INTEGER2 lname_score_temp := MAP(
                        le.lname_isnull OR ri.lname_isnull OR le.lname_weight100 = 0 => 0,
                        le.lname = ri.lname OR SALT30.HyphenMatch(le.lname,ri.lname,3)<=2  => MIN(le.lname_weight100,ri.lname_weight100),
                        SALT30.WithinEditN(le.lname,ri.lname,1,0) => SALT30.fn_fuzzy_specificity(le.lname_weight100,le.lname_cnt, le.lname_e1_cnt,ri.lname_weight100,ri.lname_cnt,ri.lname_e1_cnt),
                        SALT30.Fn_Fail_Scale(le.lname_weight100,s.lname_switch));
  INTEGER2 mname_score_temp := MAP(
                        le.mname_isnull OR ri.mname_isnull => 0,
                        le.mname = ri.mname  => le.mname_weight100,
                        SALT30.WithinEditN(le.mname,ri.mname,1,0) => SALT30.fn_fuzzy_specificity(le.mname_weight100,le.mname_cnt, le.mname_e1_cnt,ri.mname_weight100,ri.mname_cnt,ri.mname_e1_cnt),
                        LENGTH(TRIM(le.mname))>0 and le.mname = ri.mname[1..LENGTH(TRIM(le.mname))] => le.mname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.mname))>0 and ri.mname = le.mname[1..LENGTH(TRIM(ri.mname))] => ri.mname_weight100, // An initial match - take initial specificity
                        SALT30.Fn_Fail_Scale(le.mname_weight100,s.mname_switch));
  INTEGER2 fname_score_temp := MAP(
                        le.fname_isnull OR ri.fname_isnull OR le.fname_weight100 = 0 => 0,
                        le.fname = ri.fname  => le.fname_weight100,
                        SALT30.WithinEditN(le.fname,ri.fname,1,0) => SALT30.fn_fuzzy_specificity(le.fname_weight100,le.fname_cnt, le.fname_e1_cnt,ri.fname_weight100,ri.fname_cnt,ri.fname_e1_cnt),
                        LENGTH(TRIM(le.fname))>0 and le.fname = ri.fname[1..LENGTH(TRIM(le.fname))] => le.fname_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.fname))>0 and ri.fname = le.fname[1..LENGTH(TRIM(ri.fname))] => ri.fname_weight100, // An initial match - take initial specificity
                        le.fname_PreferredName = ri.fname_PreferredName => SALT30.fn_fuzzy_specificity(le.fname_weight100,le.fname_cnt, le.fname_PreferredName_cnt,ri.fname_weight100,ri.fname_cnt,ri.fname_PreferredName_cnt),
                        SALT30.Fn_Fail_Scale(le.fname_weight100,s.fname_switch));
  INTEGER2 name_suffix_score_temp := MAP(
                        le.name_suffix_isnull OR ri.name_suffix_isnull => 0,
                        le.name_suffix = ri.name_suffix  => le.name_suffix_weight100,
                        le.name_suffix_NormSuffix = ri.name_suffix_NormSuffix => SALT30.fn_fuzzy_specificity(le.name_suffix_weight100,le.name_suffix_cnt, le.name_suffix_NormSuffix_cnt,ri.name_suffix_weight100,ri.name_suffix_cnt,ri.name_suffix_NormSuffix_cnt),
                        SALT30.Fn_Fail_Scale(le.name_suffix_weight100,s.name_suffix_switch));
  INTEGER2 cnp_number_score := IF ( cnp_number_score_temp >= Config.cnp_number_Force * 100, cnp_number_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 isContact_score := IF ( isContact_score_temp >= Config.isContact_Force * 100, isContact_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 company_fein_score := IF ( company_fein_score_temp >= Config.company_fein_Force * 100, company_fein_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 active_enterprise_number_score := IF ( active_enterprise_number_score_temp >= Config.active_enterprise_number_Force * 100, active_enterprise_number_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 active_domestic_corp_key_score := IF ( active_domestic_corp_key_score_temp >= Config.active_domestic_corp_key_Force * 100, active_domestic_corp_key_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 cnp_name_score := IF ( cnp_name_score_temp > Config.cnp_name_Force * 100, cnp_name_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 corp_legal_name_score := IF ( corp_legal_name_score_temp >= Config.corp_legal_name_Force * 100, corp_legal_name_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 lname_score := IF ( lname_score_temp > Config.lname_Force * 100, lname_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 mname_score := IF ( mname_score_temp >= Config.mname_Force * 100, mname_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 fname_score := IF ( fname_score_temp > Config.fname_Force * 100, fname_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 name_suffix_score := IF ( name_suffix_score_temp >= Config.name_suffix_Force * 100, name_suffix_score_temp, SKIP ); // Enforce FORCE parameter
  SELF.Conf_Prop := (cnp_number_score + isContact_score + company_fein_score + active_enterprise_number_score + active_domestic_corp_key_score + cnp_name_score + corp_legal_name_score + lname_score + mname_score + fname_score + name_suffix_score) / 100; // Score based on forced fields
  SELF.Conf := ri.Basis_weight100/100;
END;
Matches0 := DISTRIBUTE(JOIN(Cands,Cands,LEFT.Basis = RIGHT.Basis AND LEFT.DOTid > RIGHT.DOTid,Score(LEFT,RIGHT)),DOTid1+DOTid2);
 
EXPORT Match := DEDUP( SORT(Matches0,DOTid1,DOTid2,-(Conf+Conf_Prop),Source_Id,LOCAL),DOTid1,DOTid2,KEEP(1),LOCAL ); // Keep 1 source_ids per match
END;
