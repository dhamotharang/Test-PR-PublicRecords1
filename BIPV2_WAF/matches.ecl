// Begin code to perform the matching itself

IMPORT SALT25,ut;
EXPORT matches(DATASET(layout_BizHead) ih,UNSIGNED MatchThreshold = 37) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];

SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED2 c,UNSIGNED outside=0) := TRANSFORM
SELF.Rule := c;
SELF.proxid1 := le.proxid;
SELF.proxid2 := ri.proxid;
SELF.rcid1 := le.rcid;
SELF.rcid2 := ri.rcid;
INTEGER2 orgid_score := MAP( le.orgid_isnull OR ri.orgid_isnull => 0,
le.orgid = ri.orgid  => le.orgid_weight100*1.000000,
SALT25.Fn_Fail_Scale(le.orgid_weight100,s.orgid_switch));

INTEGER2 ultid_score := MAP( le.ultid_isnull OR ri.ultid_isnull => 0,
le.ultid = ri.ultid  => le.ultid_weight100*1.000000,
SALT25.Fn_Fail_Scale(le.ultid_weight100,s.ultid_switch));

INTEGER2 source_record_id_score := MAP( le.source_record_id_isnull OR ri.source_record_id_isnull => 0,
le.source_record_id = ri.source_record_id  => le.source_record_id_weight100*1.000000,
SALT25.Fn_Fail_Scale(le.source_record_id_weight100,s.source_record_id_switch));

INTEGER2 company_phone_score := MAP( le.company_phone_isnull OR ri.company_phone_isnull => 0,
le.company_phone = ri.company_phone  => le.company_phone_weight100*1.000000,
SALT25.Fn_Fail_Scale(le.company_phone_weight100,s.company_phone_switch));

INTEGER2 company_fein_score := MAP( le.company_fein_isnull OR ri.company_fein_isnull => 0,
le.company_fein = ri.company_fein  => le.company_fein_weight100*1.000000,
SALT25.WithinEditN(le.company_fein,ri.company_fein,1) => SALT25.fn_fuzzy_specificity(le.company_fein_weight100,le.company_fein_cnt, le.company_fein_e1_cnt,ri.company_fein_weight100,ri.company_fein_cnt,ri.company_fein_e1_cnt)*1.000000,
SALT25.Fn_Fail_Scale(le.company_fein_weight100,s.company_fein_switch));

INTEGER2 company_url_score := MAP( le.company_url_isnull OR ri.company_url_isnull => 0,
le.company_url = ri.company_url  => le.company_url_weight100*1.000000,
SALT25.MatchBagOfWords(le.company_url,ri.company_url,0,0,0,0)*1.000000);

INTEGER2 company_name_score := MAP( le.company_name_isnull OR ri.company_name_isnull => 0,
le.company_name = ri.company_name  => le.company_name_weight100*1.000000,
SALT25.MatchBagOfWords(le.company_name,ri.company_name,0,0,0,0)*1.000000);

INTEGER2 cnp_name_score := MAP( le.cnp_name_isnull OR ri.cnp_name_isnull => 0,
le.cnp_name = ri.cnp_name  => le.cnp_name_weight100*1.000000,
SALT25.MatchBagOfWords(le.cnp_name,ri.cnp_name,0,0,0,0)*1.000000);

REAL CONTACTNAME_score_scale := ( le.CONTACTNAME_weight100 + ri.CONTACTNAME_weight100 ) / (le.fname_weight100 + ri.fname_weight100 + le.mname_weight100 + ri.mname_weight100 + le.lname_weight100 + ri.lname_weight100); // Scaling factor for this concept
INTEGER2 CONTACTNAME_score_pre := MAP( (le.CONTACTNAME_isnull OR le.fname_isnull AND le.mname_isnull AND le.lname_isnull) OR (ri.CONTACTNAME_isnull OR ri.fname_isnull AND ri.mname_isnull AND ri.lname_isnull) => 0,
le.CONTACTNAME = ri.CONTACTNAME  => le.CONTACTNAME_weight100*1.000000,
0);
REAL STREETADDRESS_score_scale := ( le.STREETADDRESS_weight100 + ri.STREETADDRESS_weight100 ) / (le.prim_range_weight100 + ri.prim_range_weight100 + le.prim_name_weight100 + ri.prim_name_weight100 + le.sec_range_weight100 + ri.sec_range_weight100); // Scaling factor for this concept
INTEGER2 STREETADDRESS_score_pre := MAP( (le.STREETADDRESS_isnull OR le.prim_range_isnull AND le.prim_name_isnull AND le.sec_range_isnull) OR (ri.STREETADDRESS_isnull OR ri.prim_range_isnull AND ri.prim_name_isnull AND ri.sec_range_isnull) => 0,
le.STREETADDRESS = ri.STREETADDRESS  => le.STREETADDRESS_weight100*1.000000,
0);
INTEGER2 prim_name_score := MAP( le.prim_name_isnull OR ri.prim_name_isnull => 0,
STREETADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.prim_name = ri.prim_name  => le.prim_name_weight100*1.000000,
SALT25.WithinEditN(le.prim_name,ri.prim_name,1) => SALT25.fn_fuzzy_specificity(le.prim_name_weight100,le.prim_name_cnt, le.prim_name_e1_cnt,ri.prim_name_weight100,ri.prim_name_cnt,ri.prim_name_e1_cnt)*1.000000,
SALT25.Fn_Fail_Scale(le.prim_name_weight100,s.prim_name_switch))* STREETADDRESS_score_scale;

INTEGER2 zip_score := MAP( le.zip_isnull OR ri.zip_isnull => 0,
le.zip = ri.zip  => le.zip_weight100*1.000000,
SALT25.Fn_Fail_Scale(le.zip_weight100,s.zip_switch));

INTEGER2 prim_range_score := MAP( le.prim_range_isnull OR ri.prim_range_isnull => 0,
STREETADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.prim_range = ri.prim_range  => le.prim_range_weight100*1.000000,
SALT25.WithinEditN(le.prim_range,ri.prim_range,1) => SALT25.fn_fuzzy_specificity(le.prim_range_weight100,le.prim_range_cnt, le.prim_range_e1_cnt,ri.prim_range_weight100,ri.prim_range_cnt,ri.prim_range_e1_cnt)*1.000000,
SALT25.Fn_Fail_Scale(le.prim_range_weight100,s.prim_range_switch))* STREETADDRESS_score_scale;

INTEGER2 sec_range_score := MAP( le.sec_range_isnull OR ri.sec_range_isnull => 0,
STREETADDRESS_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.sec_range = ri.sec_range  => le.sec_range_weight100*1.000000,
SALT25.WithinEditN(le.sec_range,ri.sec_range,1) => SALT25.fn_fuzzy_specificity(le.sec_range_weight100,le.sec_range_cnt, le.sec_range_e1_cnt,ri.sec_range_weight100,ri.sec_range_cnt,ri.sec_range_e1_cnt)*1.000000,
SALT25.Fn_Fail_Scale(le.sec_range_weight100,s.sec_range_switch))* STREETADDRESS_score_scale;

INTEGER2 p_city_name_score := MAP( le.p_city_name_isnull OR ri.p_city_name_isnull => 0,
le.st <> ri.st => 0, // Only valid if the context variable is equal
le.p_city_name = ri.p_city_name  => le.p_city_name_weight100*1.000000,
SALT25.WithinEditN(le.p_city_name,ri.p_city_name,1) => SALT25.fn_fuzzy_specificity(le.p_city_name_weight100,le.p_city_name_cnt, le.p_city_name_e1_cnt,ri.p_city_name_weight100,ri.p_city_name_cnt,ri.p_city_name_e1_cnt)*1.000000,
SALT25.Fn_Fail_Scale(le.p_city_name_weight100,s.p_city_name_switch));

INTEGER2 company_sic_code1_score := MAP( le.company_sic_code1_isnull OR ri.company_sic_code1_isnull => 0,
le.company_sic_code1 = ri.company_sic_code1  => le.company_sic_code1_weight100*1.000000,
SALT25.Fn_Fail_Scale(le.company_sic_code1_weight100,s.company_sic_code1_switch));

INTEGER2 lname_score := MAP( le.lname_isnull OR ri.lname_isnull => 0,
CONTACTNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.lname = ri.lname OR SALT25.fn_hyphen_match(le.lname,ri.lname,1)<=2  => min(le.lname_weight100*1.000000,ri.lname_weight100*1.000000),
SALT25.WithinEditN(le.lname,ri.lname,2) => SALT25.fn_fuzzy_specificity(le.lname_weight100,le.lname_cnt, le.lname_e2_cnt,ri.lname_weight100,ri.lname_cnt,ri.lname_e2_cnt)*1.000000,
length(trim(le.lname))>0 and le.lname = ri.lname[1..length(trim(le.lname))] => le.lname_weight100*1.000000, // An initial match - take initial specificity
length(trim(ri.lname))>0 and ri.lname = le.lname[1..length(trim(ri.lname))] => ri.lname_weight100*1.000000,// An initial match - take initial specificity
SALT25.Fn_Fail_Scale(le.lname_weight100,s.lname_switch))* CONTACTNAME_score_scale;

INTEGER2 mname_score := MAP( le.mname_isnull OR ri.mname_isnull => 0,
CONTACTNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.mname = ri.mname  => le.mname_weight100*1.000000,
SALT25.WithinEditN(le.mname,ri.mname,2) => SALT25.fn_fuzzy_specificity(le.mname_weight100,le.mname_cnt, le.mname_e2_cnt,ri.mname_weight100,ri.mname_cnt,ri.mname_e2_cnt)*1.000000,
length(trim(le.mname))>0 and le.mname = ri.mname[1..length(trim(le.mname))] => le.mname_weight100*1.000000, // An initial match - take initial specificity
length(trim(ri.mname))>0 and ri.mname = le.mname[1..length(trim(ri.mname))] => ri.mname_weight100*1.000000,// An initial match - take initial specificity
SALT25.Fn_Fail_Scale(le.mname_weight100,s.mname_switch))* CONTACTNAME_score_scale;

INTEGER2 fname_score := MAP( le.fname_isnull OR ri.fname_isnull => 0,
CONTACTNAME_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
le.fname = ri.fname  => le.fname_weight100*1.000000,
SALT25.WithinEditN(le.fname,ri.fname,1) => SALT25.fn_fuzzy_specificity(le.fname_weight100,le.fname_cnt, le.fname_e1_cnt,ri.fname_weight100,ri.fname_cnt,ri.fname_e1_cnt)*1.000000,
length(trim(le.fname))>0 and le.fname = ri.fname[1..length(trim(le.fname))] => le.fname_weight100*1.000000, // An initial match - take initial specificity
length(trim(ri.fname))>0 and ri.fname = le.fname[1..length(trim(ri.fname))] => ri.fname_weight100*1.000000,// An initial match - take initial specificity
le.fname_PreferredName = ri.fname_PreferredName => SALT25.fn_fuzzy_specificity(le.fname_weight100,le.fname_cnt, le.fname_PreferredName_cnt,ri.fname_weight100,ri.fname_cnt,ri.fname_PreferredName_cnt),
SALT25.Fn_Fail_Scale(le.fname_weight100,s.fname_switch))* CONTACTNAME_score_scale;

INTEGER2 name_suffix_score := MAP( le.name_suffix_isnull OR ri.name_suffix_isnull => 0,
le.name_suffix = ri.name_suffix  => le.name_suffix_weight100*1.000000,
le.name_suffix_NormSuffix = ri.name_suffix_NormSuffix => SALT25.fn_fuzzy_specificity(le.name_suffix_weight100,le.name_suffix_cnt, le.name_suffix_NormSuffix_cnt,ri.name_suffix_weight100,ri.name_suffix_cnt,ri.name_suffix_NormSuffix_cnt),
SALT25.Fn_Fail_Scale(le.name_suffix_weight100,s.name_suffix_switch));

INTEGER2 st_score := MAP( le.st_isnull OR ri.st_isnull => 0,
le.st = ri.st  => le.st_weight100*1.000000,
SALT25.Fn_Fail_Scale(le.st_weight100,s.st_switch));

INTEGER2 source_score := MAP( le.source_isnull OR ri.source_isnull => 0,
le.source = ri.source  => le.source_weight100*1.000000,
SALT25.Fn_Fail_Scale(le.source_weight100,s.source_switch));

INTEGER2 isContact_score := MAP( le.isContact_isnull OR ri.isContact_isnull => 0,
le.isContact = ri.isContact  => le.isContact_weight100*1.000000,
SALT25.Fn_Fail_Scale(le.isContact_weight100,s.isContact_switch));

INTEGER2 title_score := MAP( le.title_isnull OR ri.title_isnull => 0,
le.title = ri.title  => le.title_weight100*1.000000,
SALT25.Fn_Fail_Scale(le.title_weight100,s.title_switch));

INTEGER2 empid_score := MAP( le.empid_isnull OR ri.empid_isnull => 0,
le.empid = ri.empid  => le.empid_weight100*1.000000,
SALT25.Fn_Fail_Scale(le.empid_weight100,s.empid_switch));

INTEGER2 powid_score := MAP( le.powid_isnull OR ri.powid_isnull => 0,
le.powid = ri.powid  => le.powid_weight100*1.000000,
SALT25.Fn_Fail_Scale(le.powid_weight100,s.powid_switch));

INTEGER2 contact_email_score := MAP( le.contact_email_isnull OR ri.contact_email_isnull => 0,
le.contact_email = ri.contact_email  => le.contact_email_weight100*1.000000,
SALT25.Fn_Fail_Scale(le.contact_email_weight100,s.contact_email_switch));

// Compute the score for the concept CONTACTNAME
INTEGER2 CONTACTNAME_score_ext := MAX(CONTACTNAME_score_pre,0) + fname_score + mname_score + lname_score;// Score in surrounding context
INTEGER2 CONTACTNAME_score_res := MAX(0,CONTACTNAME_score_pre); // At least nothing
INTEGER2 CONTACTNAME_score := CONTACTNAME_score_res;
// Compute the score for the concept STREETADDRESS
INTEGER2 STREETADDRESS_score_ext := MAX(STREETADDRESS_score_pre,0) + prim_range_score + prim_name_score + sec_range_score;// Score in surrounding context
INTEGER2 STREETADDRESS_score_res := MAX(0,STREETADDRESS_score_pre); // At least nothing
INTEGER2 STREETADDRESS_score := STREETADDRESS_score_res;
SELF.Conf_Prop := (0
+MAX(le.company_fein_prop,ri.company_fein_prop)*company_fein_score // Score if either field propogated
) / 100; // Score based on propogated fields
iComp := (orgid_score + ultid_score + source_record_id_score + company_phone_score + company_fein_score + company_url_score + company_name_score + cnp_name_score + CONTACTNAME_score + STREETADDRESS_score + prim_name_score + zip_score + prim_range_score + sec_range_score + p_city_name_score + company_sic_code1_score + lname_score + mname_score + fname_score + name_suffix_score + st_score + source_score + isContact_score + title_score + empid_score + powid_score + contact_email_score) / 100 + outside;
SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
SHARED RuleText(UNSIGNED n) :=  MAP (
n = 0 => ':orgid',
n = 1 => ':ultid',
n = 2 => ':source_record_id',
n = 3 => ':company_phone',
n = 4 => ':company_fein',
n = 5 => ':company_url',
n = 6 => ':company_name:*',
n = 17 => ':cnp_name:*',
n = 27 => ':prim_name:zip',
n = 28 => ':prim_name:prim_range',
n = 29 => ':prim_name:sec_range',
n = 30 => ':prim_name:p_city_name',
n = 31 => ':prim_name:company_sic_code1:*',
n = 35 => ':prim_name:lname:*',
n = 38 => ':prim_name:mname:*',
n = 40 => ':prim_name:fname:name_suffix',
n = 41 => ':zip:prim_range',
n = 42 => ':zip:sec_range',
n = 43 => ':zip:p_city_name',
n = 44 => ':zip:company_sic_code1:*',
n = 48 => ':zip:lname:*',
n = 51 => ':zip:mname:*',
n = 53 => ':zip:fname:name_suffix',
n = 54 => ':prim_range:sec_range:*',
n = 60 => ':prim_range:p_city_name:*',
n = 65 => ':prim_range:company_sic_code1:*',
n = 69 => ':prim_range:lname:*',
n = 72 => ':prim_range:mname:*',
n = 74 => ':prim_range:fname:name_suffix',
n = 75 => ':sec_range:p_city_name:*',
n = 80 => ':sec_range:company_sic_code1:*',
n = 84 => ':sec_range:lname:*',
n = 87 => ':sec_range:mname:*',
n = 89 => ':sec_range:fname:name_suffix',
n = 90 => ':p_city_name:company_sic_code1:*',
n = 94 => ':p_city_name:lname:*',
n = 97 => ':p_city_name:mname:*',
n = 99 => ':p_city_name:fname:name_suffix',
n = 100 => ':company_sic_code1:lname:mname',
n = 101 => ':company_sic_code1:lname:fname',
n = 102 => ':company_sic_code1:lname:name_suffix',
n = 103 => ':company_sic_code1:mname:fname',
n = 104 => ':lname:mname:fname','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 105 join conditions of which 62 have been optimized into preceding conditions

//Fixed fields ->:orgid(27)

dn0 := h(~orgid_isnull);
dn0_deduped := dn0(orgid_weight100>=2600); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.orgid = RIGHT.orgid,match_join(LEFT,RIGHT,0),ATMOST(LEFT.orgid = RIGHT.orgid,1000),SKEW(1));

//Fixed fields ->:ultid(27)

dn1 := h(~ultid_isnull);
dn1_deduped := dn1(ultid_weight100>=2600); // Use specificity to flag high-dup counts
mj1 := JOIN( dn1_deduped, dn1_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.ultid = RIGHT.ultid,match_join(LEFT,RIGHT,1),ATMOST(LEFT.ultid = RIGHT.ultid,1000),SKEW(1));

//Fixed fields ->:source_record_id(26)

dn2 := h(~source_record_id_isnull);
dn2_deduped := dn2(source_record_id_weight100>=2600); // Use specificity to flag high-dup counts
mj2 := JOIN( dn2_deduped, dn2_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.source_record_id = RIGHT.source_record_id,match_join(LEFT,RIGHT,2),ATMOST(LEFT.source_record_id = RIGHT.source_record_id,1000),SKEW(1));

//Fixed fields ->:company_phone(26)

dn3 := h(~company_phone_isnull);
dn3_deduped := dn3(company_phone_weight100>=2600); // Use specificity to flag high-dup counts
mj3 := JOIN( dn3_deduped, dn3_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_phone = RIGHT.company_phone,match_join(LEFT,RIGHT,3),ATMOST(LEFT.company_phone = RIGHT.company_phone,1000),SKEW(1));

//Fixed fields ->:company_fein(26)

dn4 := h(~company_fein_isnull);
dn4_deduped := dn4(company_fein_weight100>=2600); // Use specificity to flag high-dup counts
mj4 := JOIN( dn4_deduped, dn4_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_fein = RIGHT.company_fein,match_join(LEFT,RIGHT,4),ATMOST(LEFT.company_fein = RIGHT.company_fein,1000),SKEW(1));
mjs0_t := mj0+mj1+mj2+mj3+mj4;
SALT25.mac_select_best_matches(mjs0_t,rcid1,rcid2,o0);
mjs0 := o0 : persist('temp::BIPV2_WAF::proxid::mj0');

//Fixed fields ->:company_url(26)

dn5 := h(~company_url_isnull);
dn5_deduped := dn5(company_url_weight100>=2600); // Use specificity to flag high-dup counts
mj5 := JOIN( dn5_deduped, dn5_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_url = RIGHT.company_url,match_join(LEFT,RIGHT,5),ATMOST(LEFT.company_url = RIGHT.company_url,1000),SKEW(1));

//First 1 fields shared with following 10 joins - optimization performed
//Fixed fields ->:company_name(25):cnp_name(24) also :company_name(25):prim_name(15) also :company_name(25):zip(14) also :company_name(25):prim_range(13) also :company_name(25):sec_range(12) also :company_name(25):p_city_name(12) also :company_name(25):company_sic_code1(10) also :company_name(25):lname(10) also :company_name(25):mname(9) also :company_name(25):fname(8) also :company_name(25):name_suffix(8)

dn6 := h(~company_name_isnull);
dn6_deduped := dn6(company_name_weight100>=2200); // Use specificity to flag high-dup counts
mj6 := JOIN( dn6_deduped, dn6_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_name = RIGHT.company_name
AND (
LEFT.cnp_name = RIGHT.cnp_name AND ~LEFT.cnp_name_isnull
OR    LEFT.prim_name = RIGHT.prim_name AND ~LEFT.prim_name_isnull
OR    LEFT.zip = RIGHT.zip AND ~LEFT.zip_isnull
OR    LEFT.prim_range = RIGHT.prim_range AND ~LEFT.prim_range_isnull
OR    LEFT.sec_range = RIGHT.sec_range AND ~LEFT.sec_range_isnull
OR    LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st AND ~LEFT.p_city_name_isnull
OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,6),ATMOST(LEFT.company_name = RIGHT.company_name,1000),SKEW(1));
mjs1_t := mj5+mj6;
SALT25.mac_select_best_matches(mjs1_t,rcid1,rcid2,o1);
mjs1 := o1 : persist('temp::BIPV2_WAF::proxid::mj1');

//First 1 fields shared with following 9 joins - optimization performed
//Fixed fields ->:cnp_name(24):prim_name(15) also :cnp_name(24):zip(14) also :cnp_name(24):prim_range(13) also :cnp_name(24):sec_range(12) also :cnp_name(24):p_city_name(12) also :cnp_name(24):company_sic_code1(10) also :cnp_name(24):lname(10) also :cnp_name(24):mname(9) also :cnp_name(24):fname(8) also :cnp_name(24):name_suffix(8)

dn17 := h(~cnp_name_isnull);
dn17_deduped := dn17(cnp_name_weight100>=2200); // Use specificity to flag high-dup counts
mj17 := JOIN( dn17_deduped, dn17_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.cnp_name = RIGHT.cnp_name
AND (
LEFT.prim_name = RIGHT.prim_name AND ~LEFT.prim_name_isnull
OR    LEFT.zip = RIGHT.zip AND ~LEFT.zip_isnull
OR    LEFT.prim_range = RIGHT.prim_range AND ~LEFT.prim_range_isnull
OR    LEFT.sec_range = RIGHT.sec_range AND ~LEFT.sec_range_isnull
OR    LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st AND ~LEFT.p_city_name_isnull
OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,17),ATMOST(LEFT.cnp_name = RIGHT.cnp_name,1000),SKEW(1));
mjs2_t := mj17;
SALT25.mac_select_best_matches(mjs2_t,rcid1,rcid2,o2);
mjs2 := o2 : persist('temp::BIPV2_WAF::proxid::mj2');

//Fixed fields ->:prim_name(15):zip(14)

dn27 := h(~prim_name_isnull AND ~zip_isnull);
dn27_deduped := dn27(prim_name_weight100 + zip_weight100>=2600); // Use specificity to flag high-dup counts
mj27 := JOIN( dn27_deduped, dn27_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.zip = RIGHT.zip,match_join(LEFT,RIGHT,27),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.zip = RIGHT.zip,1000),SKEW(1));

//Fixed fields ->:prim_name(15):prim_range(13)

dn28 := h(~prim_name_isnull AND ~prim_range_isnull);
dn28_deduped := dn28(prim_name_weight100 + prim_range_weight100>=2600); // Use specificity to flag high-dup counts
mj28 := JOIN( dn28_deduped, dn28_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.prim_range = RIGHT.prim_range,match_join(LEFT,RIGHT,28),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.prim_range = RIGHT.prim_range,1000),SKEW(1));

//Fixed fields ->:prim_name(15):sec_range(12)

dn29 := h(~prim_name_isnull AND ~sec_range_isnull);
dn29_deduped := dn29(prim_name_weight100 + sec_range_weight100>=2600); // Use specificity to flag high-dup counts
mj29 := JOIN( dn29_deduped, dn29_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.sec_range = RIGHT.sec_range,match_join(LEFT,RIGHT,29),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.sec_range = RIGHT.sec_range,1000),SKEW(1));

//Fixed fields ->:prim_name(15):p_city_name(12)

dn30 := h(~prim_name_isnull AND ~p_city_name_isnull);
dn30_deduped := dn30(prim_name_weight100 + p_city_name_weight100>=2600); // Use specificity to flag high-dup counts
mj30 := JOIN( dn30_deduped, dn30_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st,match_join(LEFT,RIGHT,30),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st,1000),SKEW(1));

//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:prim_name(15):company_sic_code1(10):lname(10) also :prim_name(15):company_sic_code1(10):mname(9) also :prim_name(15):company_sic_code1(10):fname(8) also :prim_name(15):company_sic_code1(10):name_suffix(8)

dn31 := h(~prim_name_isnull AND ~company_sic_code1_isnull);
dn31_deduped := dn31(prim_name_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj31 := JOIN( dn31_deduped, dn31_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
AND (
LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,31),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,1000),SKEW(1));
mjs3_t := mj27+mj28+mj29+mj30+mj31;
SALT25.mac_select_best_matches(mjs3_t,rcid1,rcid2,o3);
mjs3 := o3 : persist('temp::BIPV2_WAF::proxid::mj3');

//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:prim_name(15):lname(10):mname(9) also :prim_name(15):lname(10):fname(8) also :prim_name(15):lname(10):name_suffix(8)

dn35 := h(~prim_name_isnull AND ~lname_isnull);
dn35_deduped := dn35(prim_name_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj35 := JOIN( dn35_deduped, dn35_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.lname = RIGHT.lname
AND (
LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,35),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.lname = RIGHT.lname,1000),SKEW(1));

//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:prim_name(15):mname(9):fname(8) also :prim_name(15):mname(9):name_suffix(8)

dn38 := h(~prim_name_isnull AND ~mname_isnull);
dn38_deduped := dn38(prim_name_weight100 + mname_weight100>=2200); // Use specificity to flag high-dup counts
mj38 := JOIN( dn38_deduped, dn38_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.mname = RIGHT.mname
AND (
LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,38),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.mname = RIGHT.mname,1000),SKEW(1));
mjs4_t := mj35+mj38;
SALT25.mac_select_best_matches(mjs4_t,rcid1,rcid2,o4);
mjs4 := o4 : persist('temp::BIPV2_WAF::proxid::mj4');

//Fixed fields ->:prim_name(15):fname(8):name_suffix(8)

dn40 := h(~prim_name_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn40_deduped := dn40(prim_name_weight100 + fname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj40 := JOIN( dn40_deduped, dn40_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_name = RIGHT.prim_name AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix,match_join(LEFT,RIGHT,40),ATMOST(LEFT.prim_name = RIGHT.prim_name AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix,1000),SKEW(1));

//Fixed fields ->:zip(14):prim_range(13)

dn41 := h(~zip_isnull AND ~prim_range_isnull);
dn41_deduped := dn41(zip_weight100 + prim_range_weight100>=2600); // Use specificity to flag high-dup counts
mj41 := JOIN( dn41_deduped, dn41_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.prim_range = RIGHT.prim_range,match_join(LEFT,RIGHT,41),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.prim_range = RIGHT.prim_range,1000),SKEW(1));

//Fixed fields ->:zip(14):sec_range(12)

dn42 := h(~zip_isnull AND ~sec_range_isnull);
dn42_deduped := dn42(zip_weight100 + sec_range_weight100>=2600); // Use specificity to flag high-dup counts
mj42 := JOIN( dn42_deduped, dn42_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.sec_range = RIGHT.sec_range,match_join(LEFT,RIGHT,42),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.sec_range = RIGHT.sec_range,1000),SKEW(1));

//Fixed fields ->:zip(14):p_city_name(12)

dn43 := h(~zip_isnull AND ~p_city_name_isnull);
dn43_deduped := dn43(zip_weight100 + p_city_name_weight100>=2600); // Use specificity to flag high-dup counts
mj43 := JOIN( dn43_deduped, dn43_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st,match_join(LEFT,RIGHT,43),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st,1000),SKEW(1));

//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:zip(14):company_sic_code1(10):lname(10) also :zip(14):company_sic_code1(10):mname(9) also :zip(14):company_sic_code1(10):fname(8) also :zip(14):company_sic_code1(10):name_suffix(8)

dn44 := h(~zip_isnull AND ~company_sic_code1_isnull);
dn44_deduped := dn44(zip_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj44 := JOIN( dn44_deduped, dn44_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
AND (
LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,44),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,1000),SKEW(1));
mjs5_t := mj40+mj41+mj42+mj43+mj44;
SALT25.mac_select_best_matches(mjs5_t,rcid1,rcid2,o5);
mjs5 := o5 : persist('temp::BIPV2_WAF::proxid::mj5');

//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:zip(14):lname(10):mname(9) also :zip(14):lname(10):fname(8) also :zip(14):lname(10):name_suffix(8)

dn48 := h(~zip_isnull AND ~lname_isnull);
dn48_deduped := dn48(zip_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj48 := JOIN( dn48_deduped, dn48_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.lname = RIGHT.lname
AND (
LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,48),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.lname = RIGHT.lname,1000),SKEW(1));

//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:zip(14):mname(9):fname(8) also :zip(14):mname(9):name_suffix(8)

dn51 := h(~zip_isnull AND ~mname_isnull);
dn51_deduped := dn51(zip_weight100 + mname_weight100>=2200); // Use specificity to flag high-dup counts
mj51 := JOIN( dn51_deduped, dn51_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.mname = RIGHT.mname
AND (
LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,51),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.mname = RIGHT.mname,1000),SKEW(1));
mjs6_t := mj48+mj51;
SALT25.mac_select_best_matches(mjs6_t,rcid1,rcid2,o6);
mjs6 := o6 : persist('temp::BIPV2_WAF::proxid::mj6');

//Fixed fields ->:zip(14):fname(8):name_suffix(8)

dn53 := h(~zip_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn53_deduped := dn53(zip_weight100 + fname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj53 := JOIN( dn53_deduped, dn53_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.zip = RIGHT.zip AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix,match_join(LEFT,RIGHT,53),ATMOST(LEFT.zip = RIGHT.zip AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix,1000),SKEW(1));

//First 2 fields shared with following 5 joins - optimization performed
//Fixed fields ->:prim_range(13):sec_range(12):p_city_name(12) also :prim_range(13):sec_range(12):company_sic_code1(10) also :prim_range(13):sec_range(12):lname(10) also :prim_range(13):sec_range(12):mname(9) also :prim_range(13):sec_range(12):fname(8) also :prim_range(13):sec_range(12):name_suffix(8)

dn54 := h(~prim_range_isnull AND ~sec_range_isnull);
dn54_deduped := dn54(prim_range_weight100 + sec_range_weight100>=2200); // Use specificity to flag high-dup counts
mj54 := JOIN( dn54_deduped, dn54_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.sec_range = RIGHT.sec_range
AND (
LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st AND ~LEFT.p_city_name_isnull
OR    LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,54),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.sec_range = RIGHT.sec_range,1000),SKEW(1));
mjs7_t := mj53+mj54;
SALT25.mac_select_best_matches(mjs7_t,rcid1,rcid2,o7);
mjs7 := o7 : persist('temp::BIPV2_WAF::proxid::mj7');

//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:prim_range(13):p_city_name(12):company_sic_code1(10) also :prim_range(13):p_city_name(12):lname(10) also :prim_range(13):p_city_name(12):mname(9) also :prim_range(13):p_city_name(12):fname(8) also :prim_range(13):p_city_name(12):name_suffix(8)

dn60 := h(~prim_range_isnull AND ~p_city_name_isnull);
dn60_deduped := dn60(prim_range_weight100 + p_city_name_weight100>=2200); // Use specificity to flag high-dup counts
mj60 := JOIN( dn60_deduped, dn60_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st
AND (
LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,60),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st,1000),SKEW(1));
mjs8_t := mj60;
SALT25.mac_select_best_matches(mjs8_t,rcid1,rcid2,o8);
mjs8 := o8 : persist('temp::BIPV2_WAF::proxid::mj8');

//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:prim_range(13):company_sic_code1(10):lname(10) also :prim_range(13):company_sic_code1(10):mname(9) also :prim_range(13):company_sic_code1(10):fname(8) also :prim_range(13):company_sic_code1(10):name_suffix(8)

dn65 := h(~prim_range_isnull AND ~company_sic_code1_isnull);
dn65_deduped := dn65(prim_range_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj65 := JOIN( dn65_deduped, dn65_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
AND (
LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,65),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,1000),SKEW(1));

//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:prim_range(13):lname(10):mname(9) also :prim_range(13):lname(10):fname(8) also :prim_range(13):lname(10):name_suffix(8)

dn69 := h(~prim_range_isnull AND ~lname_isnull);
dn69_deduped := dn69(prim_range_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj69 := JOIN( dn69_deduped, dn69_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.lname = RIGHT.lname
AND (
LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,69),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.lname = RIGHT.lname,1000),SKEW(1));
mjs9_t := mj65+mj69;
SALT25.mac_select_best_matches(mjs9_t,rcid1,rcid2,o9);
mjs9 := o9 : persist('temp::BIPV2_WAF::proxid::mj9');

//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:prim_range(13):mname(9):fname(8) also :prim_range(13):mname(9):name_suffix(8)

dn72 := h(~prim_range_isnull AND ~mname_isnull);
dn72_deduped := dn72(prim_range_weight100 + mname_weight100>=2200); // Use specificity to flag high-dup counts
mj72 := JOIN( dn72_deduped, dn72_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.mname = RIGHT.mname
AND (
LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,72),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.mname = RIGHT.mname,1000),SKEW(1));

//Fixed fields ->:prim_range(13):fname(8):name_suffix(8)

dn74 := h(~prim_range_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn74_deduped := dn74(prim_range_weight100 + fname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj74 := JOIN( dn74_deduped, dn74_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.prim_range = RIGHT.prim_range AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix,match_join(LEFT,RIGHT,74),ATMOST(LEFT.prim_range = RIGHT.prim_range AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix,1000),SKEW(1));

//First 2 fields shared with following 4 joins - optimization performed
//Fixed fields ->:sec_range(12):p_city_name(12):company_sic_code1(10) also :sec_range(12):p_city_name(12):lname(10) also :sec_range(12):p_city_name(12):mname(9) also :sec_range(12):p_city_name(12):fname(8) also :sec_range(12):p_city_name(12):name_suffix(8)

dn75 := h(~sec_range_isnull AND ~p_city_name_isnull);
dn75_deduped := dn75(sec_range_weight100 + p_city_name_weight100>=2200); // Use specificity to flag high-dup counts
mj75 := JOIN( dn75_deduped, dn75_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st
AND (
LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND ~LEFT.company_sic_code1_isnull
OR    LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,75),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st,1000),SKEW(1));
mjs10_t := mj72+mj74+mj75;
SALT25.mac_select_best_matches(mjs10_t,rcid1,rcid2,o10);
mjs10 := o10 : persist('temp::BIPV2_WAF::proxid::mj10');

//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:sec_range(12):company_sic_code1(10):lname(10) also :sec_range(12):company_sic_code1(10):mname(9) also :sec_range(12):company_sic_code1(10):fname(8) also :sec_range(12):company_sic_code1(10):name_suffix(8)

dn80 := h(~sec_range_isnull AND ~company_sic_code1_isnull);
dn80_deduped := dn80(sec_range_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj80 := JOIN( dn80_deduped, dn80_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
AND (
LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,80),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,1000),SKEW(1));

//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:sec_range(12):lname(10):mname(9) also :sec_range(12):lname(10):fname(8) also :sec_range(12):lname(10):name_suffix(8)

dn84 := h(~sec_range_isnull AND ~lname_isnull);
dn84_deduped := dn84(sec_range_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj84 := JOIN( dn84_deduped, dn84_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.lname = RIGHT.lname
AND (
LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,84),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.lname = RIGHT.lname,1000),SKEW(1));
mjs11_t := mj80+mj84;
SALT25.mac_select_best_matches(mjs11_t,rcid1,rcid2,o11);
mjs11 := o11 : persist('temp::BIPV2_WAF::proxid::mj11');

//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:sec_range(12):mname(9):fname(8) also :sec_range(12):mname(9):name_suffix(8)

dn87 := h(~sec_range_isnull AND ~mname_isnull);
dn87_deduped := dn87(sec_range_weight100 + mname_weight100>=2200); // Use specificity to flag high-dup counts
mj87 := JOIN( dn87_deduped, dn87_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.mname = RIGHT.mname
AND (
LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,87),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.mname = RIGHT.mname,1000),SKEW(1));

//Fixed fields ->:sec_range(12):fname(8):name_suffix(8)

dn89 := h(~sec_range_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn89_deduped := dn89(sec_range_weight100 + fname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj89 := JOIN( dn89_deduped, dn89_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.sec_range = RIGHT.sec_range AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix,match_join(LEFT,RIGHT,89),ATMOST(LEFT.sec_range = RIGHT.sec_range AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix,1000),SKEW(1));

//First 2 fields shared with following 3 joins - optimization performed
//Fixed fields ->:p_city_name(12):company_sic_code1(10):lname(10) also :p_city_name(12):company_sic_code1(10):mname(9) also :p_city_name(12):company_sic_code1(10):fname(8) also :p_city_name(12):company_sic_code1(10):name_suffix(8)

dn90 := h(~p_city_name_isnull AND ~company_sic_code1_isnull);
dn90_deduped := dn90(p_city_name_weight100 + company_sic_code1_weight100>=2200); // Use specificity to flag high-dup counts
mj90 := JOIN( dn90_deduped, dn90_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st AND LEFT.company_sic_code1 = RIGHT.company_sic_code1
AND (
LEFT.lname = RIGHT.lname AND ~LEFT.lname_isnull
OR    LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,90),ATMOST(LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st AND LEFT.company_sic_code1 = RIGHT.company_sic_code1,1000),SKEW(1));
mjs12_t := mj87+mj89+mj90;
SALT25.mac_select_best_matches(mjs12_t,rcid1,rcid2,o12);
mjs12 := o12 : persist('temp::BIPV2_WAF::proxid::mj12');

//First 2 fields shared with following 2 joins - optimization performed
//Fixed fields ->:p_city_name(12):lname(10):mname(9) also :p_city_name(12):lname(10):fname(8) also :p_city_name(12):lname(10):name_suffix(8)

dn94 := h(~p_city_name_isnull AND ~lname_isnull);
dn94_deduped := dn94(p_city_name_weight100 + lname_weight100>=2200); // Use specificity to flag high-dup counts
mj94 := JOIN( dn94_deduped, dn94_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st AND LEFT.lname = RIGHT.lname
AND (
LEFT.mname = RIGHT.mname AND ~LEFT.mname_isnull
OR    LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,94),ATMOST(LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st AND LEFT.lname = RIGHT.lname,1000),SKEW(1));

//First 2 fields shared with following 1 joins - optimization performed
//Fixed fields ->:p_city_name(12):mname(9):fname(8) also :p_city_name(12):mname(9):name_suffix(8)

dn97 := h(~p_city_name_isnull AND ~mname_isnull);
dn97_deduped := dn97(p_city_name_weight100 + mname_weight100>=2200); // Use specificity to flag high-dup counts
mj97 := JOIN( dn97_deduped, dn97_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st AND LEFT.mname = RIGHT.mname
AND (
LEFT.fname = RIGHT.fname AND ~LEFT.fname_isnull
OR    LEFT.name_suffix = RIGHT.name_suffix AND ~LEFT.name_suffix_isnull
),match_join(LEFT,RIGHT,97),ATMOST(LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st AND LEFT.mname = RIGHT.mname,1000),SKEW(1));
mjs13_t := mj94+mj97;
SALT25.mac_select_best_matches(mjs13_t,rcid1,rcid2,o13);
mjs13 := o13 : persist('temp::BIPV2_WAF::proxid::mj13');

//Fixed fields ->:p_city_name(12):fname(8):name_suffix(8)

dn99 := h(~p_city_name_isnull AND ~fname_isnull AND ~name_suffix_isnull);
dn99_deduped := dn99(p_city_name_weight100 + fname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj99 := JOIN( dn99_deduped, dn99_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix,match_join(LEFT,RIGHT,99),ATMOST(LEFT.p_city_name = RIGHT.p_city_name AND LEFT.st = RIGHT.st AND LEFT.fname = RIGHT.fname AND LEFT.name_suffix = RIGHT.name_suffix,1000),SKEW(1));

//Fixed fields ->:company_sic_code1(10):lname(10):mname(9)

dn100 := h(~company_sic_code1_isnull AND ~lname_isnull AND ~mname_isnull);
dn100_deduped := dn100(company_sic_code1_weight100 + lname_weight100 + mname_weight100>=2600); // Use specificity to flag high-dup counts
mj100 := JOIN( dn100_deduped, dn100_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.mname = RIGHT.mname,match_join(LEFT,RIGHT,100),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.mname = RIGHT.mname,1000),SKEW(1));

//Fixed fields ->:company_sic_code1(10):lname(10):fname(8)

dn101 := h(~company_sic_code1_isnull AND ~lname_isnull AND ~fname_isnull);
dn101_deduped := dn101(company_sic_code1_weight100 + lname_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj101 := JOIN( dn101_deduped, dn101_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.fname = RIGHT.fname,match_join(LEFT,RIGHT,101),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.fname = RIGHT.fname,1000),SKEW(1));

//Fixed fields ->:company_sic_code1(10):lname(10):name_suffix(8)

dn102 := h(~company_sic_code1_isnull AND ~lname_isnull AND ~name_suffix_isnull);
dn102_deduped := dn102(company_sic_code1_weight100 + lname_weight100 + name_suffix_weight100>=2600); // Use specificity to flag high-dup counts
mj102 := JOIN( dn102_deduped, dn102_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.name_suffix = RIGHT.name_suffix,match_join(LEFT,RIGHT,102),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.lname = RIGHT.lname AND LEFT.name_suffix = RIGHT.name_suffix,1000),SKEW(1));

//Fixed fields ->:company_sic_code1(10):mname(9):fname(8)

dn103 := h(~company_sic_code1_isnull AND ~mname_isnull AND ~fname_isnull);
dn103_deduped := dn103(company_sic_code1_weight100 + mname_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj103 := JOIN( dn103_deduped, dn103_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname,match_join(LEFT,RIGHT,103),ATMOST(LEFT.company_sic_code1 = RIGHT.company_sic_code1 AND LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname,1000),SKEW(1));
mjs14_t := mj99+mj100+mj101+mj102+mj103;
SALT25.mac_select_best_matches(mjs14_t,rcid1,rcid2,o14);
mjs14 := o14 : persist('temp::BIPV2_WAF::proxid::mj14');

//Fixed fields ->:lname(10):mname(9):fname(8)

dn104 := h(~lname_isnull AND ~mname_isnull AND ~fname_isnull);
dn104_deduped := dn104(lname_weight100 + mname_weight100 + fname_weight100>=2600); // Use specificity to flag high-dup counts
mj104 := JOIN( dn104_deduped, dn104_deduped, LEFT.proxid > RIGHT.proxid AND LEFT.lname = RIGHT.lname AND LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname,match_join(LEFT,RIGHT,104),ATMOST(LEFT.lname = RIGHT.lname AND LEFT.mname = RIGHT.mname AND LEFT.fname = RIGHT.fname,1000),SKEW(1));
last_mjs_t :=mj104;
SALT25.mac_select_best_matches(last_mjs_t,rcid1,rcid2,o);
SHARED all_mjs :=  mjs0+ mjs1+ mjs2+ mjs3+ mjs4+ mjs5+ mjs6+ mjs7+ mjs8+ mjs9+ mjs10+ mjs11+ mjs12+ mjs13+ mjs14 +o;
export All_Matches := all_mjs : persist('temp::BIPV2_WAF_proxid_BizHead_all_m'); // To by used by rcid and proxid
SALT25.mac_avoid_transitives(All_Matches,proxid1,proxid2,Conf,DateOverlap,Rule,o);
export PossibleMatches := o : persist('temp::BIPV2_WAF_proxid_BizHead_mt');
SALT25.mac_get_BestPerRecord( All_Matches,rcid1,proxid1,rcid2,proxid2,o );
EXPORT BestPerRecord := o : PERSIST('temp::BIPV2_WAF_proxid_BizHead_mr');
//Now lets see if any slice-outs are needed
too_big := Specificities(ih).ClusterSizes(InCluster>1000); // proxid that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.proxid=RIGHT.proxid,TRANSFORM(LEFT),LOOKUP,LEFT ONLY);
in_matches := JOIN(h_ok,h_ok,LEFT.proxid=RIGHT.proxid AND (>STRING6<)LEFT.rcid<>(>STRING6<)RIGHT.rcid,match_join(LEFT,RIGHT,9999),LOCAL);
SALT25.mac_cluster_breadth(in_matches,rcid1,rcid2,proxid1,o);
o1 := JOIN(o,Specificities(ih).ClusterSizes,LEFT.proxid1=RIGHT.proxid,LOCAL);
EXPORT ClusterLinkages := o1 : PERSIST('temp::BIPV2_WAF_proxid_BizHead_clu');
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
SALT25.UIDType rcid;  //Outcast
SALT25.UIDType proxid;  // Outcase within
INTEGER2 Closest; // Best present link
SALT25.UIDType Pref_rcid; // Prefers this record
SALT25.UIDType Pref_proxid; // Prefers this cluster
INTEGER2 Conf; // Score of new link
integer2 Conf_Prop; // Prop of new link
UNSIGNED2 Pref_Margin; // Extent to which pref is preferred
END;
Pref_Layout note_better(ClusterOutcasts le, BestPerRecord ri) := TRANSFORM
self.rcid := le.rcid1;
self.proxid := le.proxid1;
self.Closest := le.Closest;
self.Pref_rcid := ri.rcid2;
self.Pref_proxid := ri.proxid2;
self.Pref_Margin := ri.Conf-ri.Conf_Prop-le.Closest; // Compute winning margin
SELF := ri;
END;
// Find those records happier in another cluster
CurrentJumpers := JOIN(BestPerRecord,ClusterOutcasts,LEFT.rcid1=RIGHT.rcid1 AND RIGHT.closest<LEFT.conf-LEFT.conf_prop,note_better(RIGHT,LEFT),HASH);
// No need for record to jump ship if clusters are joinable
WillJoin1 := JOIN(CurrentJumpers,All_Matches(Conf>=MatchThreshold),LEFT.proxid=RIGHT.proxid1 AND LEFT.Pref_proxid=RIGHT.proxid2,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin2 := JOIN(WillJoin1,All_Matches(Conf>=MatchThreshold),LEFT.proxid=RIGHT.proxid2 AND LEFT.Pref_proxid=RIGHT.proxid1,TRANSFORM(LEFT),LEFT ONLY,HASH);
EXPORT BetterElsewhere := WillJoin2;
EXPORT ToSlice := DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>10),HASH(proxid)),proxid,-Pref_Margin,LOCAL),proxid,LOCAL); // 1024x better in new place
SALT25.MAC_Avoid_SliceOuts(PossibleMatches,proxid1,proxid2,proxid,Pref_proxid,ToSlice,m); // If proxid is slice target - don't use in match
EXPORT Matches := m(Conf>=MatchThreshold);

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
SALT25.MAC_SliceOut_ByRID(ih,rcid,proxid,ToSlice,rcid,sliced); // Execute Sliceouts
ut.MAC_Patch_Id(sliced,proxid,Matches,proxid1,proxid2,o); // Join Clusters
EXPORT Patched_Infile := o;

//Produced a patched version of match_candidates to get External ADL2 for free.
ut.MAC_Patch_Id(h,proxid,Matches,proxid1,proxid2,o1);
export Patched_Candidates := o1;
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT SlicesPerformed := COUNT( ToSlice );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreClusters := hygiene(ih).ClusterCounts;
EXPORT PostClusters := hygiene(Patched_Infile).ClusterCounts;
EXPORT PrePatchIdCount := SUM( PreClusters, NumberOfClusters );
EXPORT PostPatchIdCount := SUM( PostClusters, NumberOfClusters );
EXPORT PatchingError0 := PrePatchIdCount - PostPatchIdCount - MatchesPerformed + SlicesPerformed; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile) - COUNT(DEDUP(Patched_Infile,rcid,ALL)); // Should be zero
EXPORT DidsNoRid0 := PostPatchIdCount - COUNT(Patched_Infile(proxid=rcid)); // Should be zero
EXPORT DidsAboveRid0 := COUNT(Patched_Infile(proxid>rcid)); // Should be zero
END;
