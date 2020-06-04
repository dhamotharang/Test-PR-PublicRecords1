// Logic to handle the matching around ForeignCorpkey
 
IMPORT SALT32,ut,std;
EXPORT MOD_Attr_ForeignCorpkey(DATASET(layout_DOT) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
// Construct a function to filter matches to those that obey the force criteria on this attribute file.
EXPORT ForceFilter(inhead,infile,id1,id2) := FUNCTIONMACRO
// Every attribute value must match to a value in the other attribute IF they have the same context
  /* HACK - replace Cands0 */
	// Cands0 := BIPV2_DOTID_PLATFORM.match_candidates(inhead).ForeignCorpkey_candidates;
  Cands0 := BIPV2_DOTID_PLATFORM._attr_ck_charters;
// We are going to create a record for each candidate pair; this record will have a child dataset for the attribute values of each side
  /* HACK - add ChildRec1 */
	ChildRec1 := RECORD
    salt32.StrType Basis    := Cands0.company_charter_number;
    salt32.StrType Context  := Cands0.company_inc_state; // Context for the basis ('<')
  END;
  ChildRec := RECORD
    Cands0.DOTid;
    /* HACK - comment-out three lines, add childs line */
    // Cands0.Basis_Weight100;
    // Cands0.Basis;
    // salt32.StrType Context := salt32.GetNthWord(Cands0.Basis,2,'|'); // Context for the basis ('<')
		DATASET(ChildRec1) childs := dataset([{Cands0.company_charter_number,Cands0.company_inc_state}],ChildRec1);
  END;
  Cands := TABLE(Cands0,ChildRec);
	/* HACK - add Cands1/Cands2 */
  Cands1 := rollup(sort(Cands                    ,dotid,local) ,left.dotid = right.dotid,transform(recordof(left),self.childs := left.childs + right.childs,self := left),local);
  Cands2 := rollup(sort(distribute(Cands1,dotid) ,dotid,local) ,left.dotid = right.dotid,transform(recordof(left),self.childs := left.childs + right.childs,self := left),local);
	
  PossRec := RECORD
    infile;
		/* HACK - change to ChildRec1 */
    // DATASET(ChildRec) Kids1 := DATASET([],ChildRec);
    // DATASET(ChildRec) Kids2 := DATASET([],ChildRec);
    DATASET(ChildRec1) Kids1 := DATASET([],ChildRec1);
    DATASET(ChildRec1) Kids2 := DATASET([],ChildRec1);
    unsigned2 countKids1  := 0;
    unsigned2 countKids2  := 0;
    boolean   shouldFilterOut := false;
  END;
  T := TABLE(infile,PossRec); // Allow for addition of children
	/* HACK - replace D1/D2 */
  // D1 := DENORMALIZE(T,Cands,LEFT.id1 = RIGHT.DOTid,GROUP,TRANSFORM(PossRec, SELF.Kids1 := DEDUP(ROWS(RIGHT),Basis,ALL), SELF := LEFT));
  // D2 := DENORMALIZE(D1,Cands,LEFT.id2 = RIGHT.DOTid,GROUP,TRANSFORM(PossRec, SELF.Kids2 := DEDUP(ROWS(RIGHT),Basis,ALL), SELF := LEFT));
  D1 := JOIN(T ,Cands2,LEFT.id1 = RIGHT.DOTid,TRANSFORM(PossRec, SELF.Kids1 := RIGHT.childs,self.countKids1 := count(self.kids1), SELF := LEFT), LEFT OUTER, HASH);
  D2 := JOIN(D1,Cands2,LEFT.id2 = RIGHT.DOTid,TRANSFORM(PossRec, SELF.Kids2 := RIGHT.childs,self.countKids2 := count(RIGHT.childs)
    // ,self.shouldFilterOut := false // default for now
    ,SELF := LEFT), LEFT OUTER, HASH);
  D2_dist := distribute(D2); //to make sure it does the distribute before the project(optimization sometimes puts it afterwards)
  D2_sort := sort(D2_dist,id1,id2,local); //to make sure it does the distribute before the project(optimization sometimes puts it afterwards)
  
  D3 := project(D2_dist,transform(recordof(left)
    ,self.shouldFilterOut := if(left.countKids1 > 0 and left.countKids2 > 0 
      ,count(table(left.kids1 + left.kids2,{context},context))  <  count(table(left.kids1 + left.kids2,{context,basis},context,basis))  
      ,false
    )
   ,self := left
   ));
  D3_tofilterout  := D3(shouldFilterOut = true );
  D3_toKeep       := D3(shouldFilterOut = false);
	/* HACK - change to ChildRec1 */
  // Agree(DATASET(ChildRec) le, DATASET(ChildRec) ri) := FUNCTION
  // Agree(DATASET(ChildRec1) le, DATASET(ChildRec1) ri) := FUNCTION
    // j := JOIN(le,ri,LEFT.Context=RIGHT.Context AND LEFT.Basis<>RIGHT.Basis,TRANSFORM(LEFT));
    // RETURN ~EXISTS(j);
  // END;
  RETURN PROJECT(D3_toKeep,RECORDOF(infile));
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
                        SALT32.Fn_Fail_Scale(le.cnp_number_weight100,s.cnp_number_switch));
  INTEGER2 isContact_score_temp := MAP(
                        le.isContact = ri.isContact  => le.isContact_weight100,
                        SALT32.Fn_Fail_Scale(le.isContact_weight100,s.isContact_switch));
  INTEGER2 company_fein_score_temp := MAP(
                        le.company_fein_isnull OR ri.company_fein_isnull => 0,
                        le.company_fein = ri.company_fein  => le.company_fein_weight100,
                        SALT32.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));
  INTEGER2 active_enterprise_number_score_temp := MAP(
                        le.active_enterprise_number_isnull OR ri.active_enterprise_number_isnull => 0,
                        le.active_enterprise_number = ri.active_enterprise_number  => le.active_enterprise_number_weight100,
                        SALT32.Fn_Fail_Scale(le.active_enterprise_number_weight100,s.active_enterprise_number_switch));
  INTEGER2 active_domestic_corp_key_score_temp := MAP(
                        le.active_domestic_corp_key_isnull OR ri.active_domestic_corp_key_isnull => 0,
                        le.active_domestic_corp_key = ri.active_domestic_corp_key  => le.active_domestic_corp_key_weight100,
                        SALT32.Fn_Fail_Scale(le.active_domestic_corp_key_weight100,s.active_domestic_corp_key_switch));
  INTEGER2 cnp_name_score_temp := MAP(
                        le.cnp_name_isnull OR ri.cnp_name_isnull OR le.cnp_name_weight100 = 0 => 0,
                        le.cnp_name = ri.cnp_name  => le.cnp_name_weight100,
                        SALT32.WithinEditNew(le.cnp_name,le.cnp_name_len,ri.cnp_name,ri.cnp_name_len,1,0) => SALT32.fn_fuzzy_specificity(le.cnp_name_weight100,le.cnp_name_cnt, le.cnp_name_e1_cnt,ri.cnp_name_weight100,ri.cnp_name_cnt,ri.cnp_name_e1_cnt),
                        SALT32.Fn_Fail_Scale(le.cnp_name_weight100,s.cnp_name_switch));
  INTEGER2 corp_legal_name_score_temp := MAP(
                        le.corp_legal_name_isnull OR ri.corp_legal_name_isnull => 0,
                        le.corp_legal_name = ri.corp_legal_name  => le.corp_legal_name_weight100,
                        SALT32.MatchBagOfWords(le.corp_legal_name,ri.corp_legal_name,31762,1));
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
