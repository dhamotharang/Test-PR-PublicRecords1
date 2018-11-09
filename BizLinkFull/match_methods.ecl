IMPORT SALT37,std;
EXPORT match_methods(DATASET(layout_BizHead) ih) := MODULE
 
SHARED h := match_candidates(ih).candidates;
EXPORT match_parent_proxid(TYPEOF(h.parent_proxid) L, TYPEOF(h.parent_proxid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_sele_proxid(TYPEOF(h.sele_proxid) L, TYPEOF(h.sele_proxid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_org_proxid(TYPEOF(h.org_proxid) L, TYPEOF(h.org_proxid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_ultimate_proxid(TYPEOF(h.ultimate_proxid) L, TYPEOF(h.ultimate_proxid) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_source(TYPEOF(h.source) L, TYPEOF(h.source) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_source_record_id(TYPEOF(h.source_record_id) L, TYPEOF(h.source_record_id) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_company_name(TYPEOF(h.company_name) L, TYPEOF(h.company_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_company_name_prefix(TYPEOF(h.company_name_prefix) L, TYPEOF(h.company_name_prefix) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_cnp_name(TYPEOF(h.cnp_name) L, TYPEOF(h.cnp_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchBagOfWords(L,R,3177747,1) <> 0 => SALT37.MatchCode.WordBagMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_cnp_number(TYPEOF(h.cnp_number) L, TYPEOF(h.cnp_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_cnp_btype(TYPEOF(h.cnp_btype) L, TYPEOF(h.cnp_btype) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_cnp_lowv(TYPEOF(h.cnp_lowv) L, TYPEOF(h.cnp_lowv) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_company_phone_3(TYPEOF(h.company_phone_3) L, TYPEOF(h.company_phone_3) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_company_phone_3_ex(TYPEOF(h.company_phone_3_ex) L, TYPEOF(h.company_phone_3_ex) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_company_phone_7(TYPEOF(h.company_phone_7) L, TYPEOF(h.company_phone_7) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_company_fein(TYPEOF(h.company_fein) L, TYPEOF(h.company_fein) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	Config_BIP.WithinEditN(L,LL,R,RL,1, 0) => SALT37.MatchCode.EditDistanceMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_company_sic_code1(TYPEOF(h.company_sic_code1) L, TYPEOF(h.company_sic_code1) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_prim_range(TYPEOF(h.prim_range) L, TYPEOF(h.prim_range) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	Config_BIP.WithinEditN(L,LL,R,RL,1, 0) => SALT37.MatchCode.EditDistanceMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_prim_name(TYPEOF(h.prim_name) L, TYPEOF(h.prim_name) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	Config_BIP.WithinEditN(L,LL,R,RL,1, 0) => SALT37.MatchCode.EditDistanceMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_sec_range(TYPEOF(h.sec_range) L, TYPEOF(h.sec_range) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	Config_BIP.WithinEditN(L,LL,R,RL,1, 0) => SALT37.MatchCode.EditDistanceMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_city(TYPEOF(h.city) L, TYPEOF(h.city) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	Config_BIP.WithinEditN(L,LL,R,RL,2, 0) => SALT37.MatchCode.EditDistanceMatch,
	metaphonelib.dmetaphone1(L) = metaphonelib.dmetaphone1(R) => SALT37.MatchCode.PhoneticMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_city_clean(TYPEOF(h.city_clean) L, TYPEOF(h.city_clean) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_st(TYPEOF(h.st) L, TYPEOF(h.st) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_zip_el(TYPEOF(h.zip) L, DATASET(BizLinkFull.process_Biz_layouts.layout_zip_cases) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(EXISTS(R(L=zip)) => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(EXISTS(R(L=zip)) => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_zip(TYPEOF(h.zip) L, TYPEOF(h.zip) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_company_url(TYPEOF(h.company_url) L, TYPEOF(h.company_url) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchBagOfWords(L,R,31744,0) <> 0 => SALT37.MatchCode.WordBagMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_isContact(TYPEOF(h.isContact) L, TYPEOF(h.isContact) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_contact_did(TYPEOF(h.contact_did) L, TYPEOF(h.contact_did) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_title(TYPEOF(h.title) L, TYPEOF(h.title) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_fname(TYPEOF(h.fname) L, TYPEOF(h.fname) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT37.MatchCode.InitialMatch,
	LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT37.MatchCode.InitialMatch,
	Config_BIP.WithinEditN(L,LL,R,RL,1, 0) => SALT37.MatchCode.EditDistanceMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_fname_preferred(TYPEOF(h.fname_preferred) L, TYPEOF(h.fname_preferred) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_mname(TYPEOF(h.mname) L, TYPEOF(h.mname) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
	LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT37.MatchCode.InitialMatch,
	LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT37.MatchCode.InitialMatch,
	Config_BIP.WithinEditN(L,LL,R,RL,2, 0) => SALT37.MatchCode.EditDistanceMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_lname(TYPEOF(h.lname) L, TYPEOF(h.lname) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.HyphenMatch(L,R,1)<=2 => SALT37.MatchCode.HyphenMatch,
	LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT37.MatchCode.InitialMatch,
	LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT37.MatchCode.InitialMatch,
	Config_BIP.WithinEditN(L,LL,R,RL,2, 0) => SALT37.MatchCode.EditDistanceMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_name_suffix(TYPEOF(h.name_suffix) L, TYPEOF(h.name_suffix) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    fn_normSuffix(L) =  fn_normSuffix(R) => SALT37.MatchCode.CustomFuzzyMatch, // Compare fn_normSuffix values
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_contact_ssn(TYPEOF(h.contact_ssn) L, TYPEOF(h.contact_ssn) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_contact_email(TYPEOF(h.contact_email) L, TYPEOF(h.contact_email) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_sele_flag(TYPEOF(h.sele_flag) L, TYPEOF(h.sele_flag) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_org_flag(TYPEOF(h.org_flag) L, TYPEOF(h.org_flag) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_ult_flag(TYPEOF(h.ult_flag) L, TYPEOF(h.ult_flag) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_fallback_value(TYPEOF(h.fallback_value) L, TYPEOF(h.fallback_value) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT37.MatchCode.ExactMatch,
    SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch, SALT37.MatchCode.NoMatch)
);
EXPORT match_CONTACTNAME(TYPEOF(h.CONTACTNAME) L,TYPEOF(h.CONTACTNAME) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT37.MatchCode.ExactMatch,
      SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch,SALT37.MatchCode.NoMatch)
);
EXPORT match_STREETADDRESS(TYPEOF(h.STREETADDRESS) L,TYPEOF(h.STREETADDRESS) R, BOOLEAN RequiredField = FALSE) :=  IF(~RequiredField,
    MAP(L = R => SALT37.MatchCode.ExactMatch,
      SALT37.MatchCode.NoMatch),
        MAP(L = R => SALT37.MatchCode.ExactMatch,SALT37.MatchCode.NoMatch)
);
END;
