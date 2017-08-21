IMPORT SALT34,std;
IMPORT InsuranceHeader_Property_Transactions_DeedsMortgages; // Import modules for  attribute definitions
EXPORT match_methods(DATASET(layout_PROPERTY_TRANSACTION) ih) := MODULE
SHARED h := match_candidates(ih).candidates;
EXPORT match_recording_date(TYPEOF(h.recording_date) L, TYPEOF(h.recording_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_SourceType(TYPEOF(h.SourceType) L, TYPEOF(h.SourceType) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_did(TYPEOF(h.did) L, TYPEOF(h.did) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_apnt_or_pin_number(TYPEOF(h.apnt_or_pin_number) L, TYPEOF(h.apnt_or_pin_number) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.WithinEditNew(L,LL,R,RL,1, 0) => SALT34.MatchCode.EditDistanceMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_recorder_book_number(TYPEOF(h.recorder_book_number) L, TYPEOF(h.recorder_book_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_primname(TYPEOF(h.primname) L,TYPEOF(h.primname) R) := 
   MAP(L = R => SALT34.MatchCode.ExactMatch,
	SALT34.MatchCode.NoMatch);
EXPORT match_zip(TYPEOF(h.zip) L, TYPEOF(h.zip) R, UNSIGNED1 LL = 0, UNSIGNED1 RL = 0, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.WithinEditNew(L,LL,R,RL,1, 0) => SALT34.MatchCode.EditDistanceMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_sales_price(TYPEOF(h.sales_price) L, TYPEOF(h.sales_price) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_first_td_loan_amount(TYPEOF(h.first_td_loan_amount) L, TYPEOF(h.first_td_loan_amount) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_primrange(TYPEOF(h.primrange) L,TYPEOF(h.primrange) R) := 
   MAP(L = R => SALT34.MatchCode.ExactMatch,
	SALT34.MatchCode.NoMatch);
EXPORT match_secrange(TYPEOF(h.secrange) L,TYPEOF(h.secrange) R) := 
   MAP(L = R => SALT34.MatchCode.ExactMatch,
	SALT34.MatchCode.NoMatch);
EXPORT match_contract_date(TYPEOF(h.contract_date) L, TYPEOF(h.contract_date) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_document_number(TYPEOF(h.document_number) L, TYPEOF(h.document_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    InsuranceHeader_Property_Transactions_DeedsMortgages.fn_document_number((STRING20)L,(STRING20)R) => SALT34.MatchCode.CustomFuzzyMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_recorder_page_number(TYPEOF(h.recorder_page_number) L, TYPEOF(h.recorder_page_number) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_prim_range_alpha(TYPEOF(h.prim_range_alpha) L, TYPEOF(h.prim_range_alpha) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_sec_range_alpha(TYPEOF(h.sec_range_alpha) L, TYPEOF(h.sec_range_alpha) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_name(TYPEOF(h.name) L, TYPEOF(h.name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.HyphenMatch(L,R,1)<=2 => SALT34.MatchCode.HyphenMatch,
    SALT34.MatchBagOfWords(L,R,31770,2) <> 0  => SALT34.MatchCode.WordBagMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_prim_name_num(TYPEOF(h.prim_name_num) L, TYPEOF(h.prim_name_num) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT34.MatchCode.InitialMatch,
    LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT34.MatchCode.InitialMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_prim_name_alpha(TYPEOF(h.prim_name_alpha) L, TYPEOF(h.prim_name_alpha) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.HyphenMatch(L,R,1)<=2 => SALT34.MatchCode.HyphenMatch,
    SALT34.MatchBagOfWords(L,R,31768,2) <> 0  => SALT34.MatchCode.WordBagMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_sec_range_num(TYPEOF(h.sec_range_num) L, TYPEOF(h.sec_range_num) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.HyphenMatch(L,R,1)<=2 => SALT34.MatchCode.HyphenMatch,
    LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT34.MatchCode.InitialMatch,
    LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT34.MatchCode.InitialMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_fips_code(TYPEOF(h.fips_code) L, TYPEOF(h.fips_code) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_county_name(TYPEOF(h.county_name) L, TYPEOF(h.county_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_lender_name(TYPEOF(h.lender_name) L, TYPEOF(h.lender_name) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.HyphenMatch(L,R,1)<=2 => SALT34.MatchCode.HyphenMatch,
    SALT34.MatchBagOfWords(L,R,31770,2) <> 0  => SALT34.MatchCode.WordBagMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_prim_range_num(TYPEOF(h.prim_range_num) L, TYPEOF(h.prim_range_num) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.HyphenMatch(L,R,1)<=2 => SALT34.MatchCode.HyphenMatch,
    LENGTH(TRIM(L))>0 and L = R[1..LENGTH(TRIM(L))] => SALT34.MatchCode.InitialMatch,
    LENGTH(TRIM(R))>0 and R = L[1..LENGTH(TRIM(R))] => SALT34.MatchCode.InitialMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_city(TYPEOF(h.city) L, TYPEOF(h.city) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.HyphenMatch(L,R,1)<=2 => SALT34.MatchCode.HyphenMatch,
    SALT34.MatchBagOfWords(L,R,31784,1) <> 0 => SALT34.MatchCode.WordBagMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_st(TYPEOF(h.st) L, TYPEOF(h.st) R, BOOLEAN RequiredField = FALSE) := IF(~RequiredField,
   MAP(L = R => SALT34.MatchCode.ExactMatch,
    SALT34.MatchCode.NoMatch),
        MAP(L = R => SALT34.MatchCode.ExactMatch, SALT34.MatchCode.NoMatch)
);
EXPORT match_locale(TYPEOF(h.locale) L,TYPEOF(h.locale) R) := 
   MAP(L = R => SALT34.MatchCode.ExactMatch,
	SALT34.MatchCode.NoMatch);
EXPORT match_address(TYPEOF(h.address) L,TYPEOF(h.address) R) := 
   MAP(L = R => SALT34.MatchCode.ExactMatch,
	SALT34.MatchCode.NoMatch);
END;
