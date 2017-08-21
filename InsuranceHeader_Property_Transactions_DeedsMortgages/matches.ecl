// Begin code to perform the matching itself
IMPORT InsuranceHeader_Property_Transactions_DeedsMortgages; // Import modules for  attribute definitions
IMPORT SALT34,ut,std;
EXPORT matches(DATASET(layout_PROPERTY_TRANSACTION) ih,UNSIGNED MatchThreshold = Config.MatchThreshold) := MODULE
SHARED LowerMatchThreshold := MatchThreshold-3; // Keep extra 'borderlines' for debug purposes
SHARED h := match_candidates(ih).candidates;
SHARED s := Specificities(ih).Specificities[1];
SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED c=0,UNSIGNED outside=0) := TRANSFORM
  SELF.Rule := c;
  SELF.DPROPTXID1 := le.DPROPTXID;
  SELF.DPROPTXID2 := ri.DPROPTXID;
  SELF.rid1 := le.rid;
  SELF.rid2 := ri.rid;
  INTEGER2 recording_date_score_temp := MAP(
                        le.recording_date = ri.recording_date  => le.recording_date_weight100,
                        SALT34.Fn_Fail_Scale(le.recording_date_weight100,s.recording_date_switch));
  INTEGER2 SourceType_score_temp := MAP(
                        le.SourceType = ri.SourceType  => le.SourceType_weight100,
                        SALT34.Fn_Fail_Scale(le.SourceType_weight100,s.SourceType_switch));
  INTEGER2 did_score_temp := MAP(
                        le.did_isnull OR ri.did_isnull => 0,
                        le.did = ri.did  => le.did_weight100,
                        SALT34.Fn_Fail_Scale(le.did_weight100,s.did_switch));
  INTEGER2 apnt_or_pin_number_score_temp := MAP(
                        le.apnt_or_pin_number_isnull OR ri.apnt_or_pin_number_isnull => 0,
                        le.apnt_or_pin_number = ri.apnt_or_pin_number  => le.apnt_or_pin_number_weight100,
                        SALT34.WithinEditNew(le.apnt_or_pin_number,le.apnt_or_pin_number_len,ri.apnt_or_pin_number,ri.apnt_or_pin_number_len,1,0) =>  SALT34.fn_fuzzy_specificity(le.apnt_or_pin_number_weight100,le.apnt_or_pin_number_cnt, le.apnt_or_pin_number_e1_cnt,ri.apnt_or_pin_number_weight100,ri.apnt_or_pin_number_cnt,ri.apnt_or_pin_number_e1_cnt),
                        SALT34.Fn_Fail_Scale(le.apnt_or_pin_number_weight100,s.apnt_or_pin_number_switch));
  INTEGER2 recorder_book_number_score := MAP(
                        le.recorder_book_number_isnull OR ri.recorder_book_number_isnull => 0,
                        le.recorder_book_number = ri.recorder_book_number  => le.recorder_book_number_weight100,
                        SALT34.Fn_Fail_Scale(le.recorder_book_number_weight100,s.recorder_book_number_switch));
  INTEGER2 sales_price_score_temp := MAP(
                        le.sales_price_isnull OR ri.sales_price_isnull => 0,
                        le.sales_price = ri.sales_price  => le.sales_price_weight100,
                        SALT34.Fn_Fail_Scale(le.sales_price_weight100,s.sales_price_switch));
  INTEGER2 first_td_loan_amount_score_temp := MAP(
                        le.first_td_loan_amount_isnull OR ri.first_td_loan_amount_isnull => 0,
                        le.first_td_loan_amount = ri.first_td_loan_amount  => le.first_td_loan_amount_weight100,
                        SALT34.Fn_Fail_Scale(le.first_td_loan_amount_weight100,s.first_td_loan_amount_switch));
  INTEGER2 contract_date_score_temp := MAP(
                        le.contract_date_isnull OR ri.contract_date_isnull => 0,
                        le.contract_date = ri.contract_date  => le.contract_date_weight100,
                        SALT34.Fn_Fail_Scale(le.contract_date_weight100,s.contract_date_switch));
  INTEGER2 document_number_score := MAP(
                        le.document_number_isnull OR ri.document_number_isnull => 0,
                        le.document_number = ri.document_number  => le.document_number_weight100,
                        InsuranceHeader_Property_Transactions_DeedsMortgages.fn_document_number((STRING20)le.document_number,ri.document_number) => SALT34.MOD_NonZero.AVENZ(le.document_number_weight100,ri.document_number_weight100),
                        0 /* switchN/0 */);
  INTEGER2 recorder_page_number_score_temp := MAP(
                        le.recorder_page_number_isnull OR ri.recorder_page_number_isnull OR le.recorder_page_number_weight100 = 0 => 0,
                        le.recorder_book_number <> ri.recorder_book_number => 0, // Only valid if the context variable is equal
                        le.recorder_page_number = ri.recorder_page_number  => le.recorder_page_number_weight100,
                        SALT34.Fn_Fail_Scale(le.recorder_page_number_weight100,s.recorder_page_number_switch));
  INTEGER2 name_score := MAP(
                        le.name_isnull OR ri.name_isnull => 0,
                        le.name = ri.name OR SALT34.HyphenMatch(le.name,ri.name,1)<=2  => MIN(le.name_weight100,ri.name_weight100),
                        SALT34.MatchBagOfWords(le.name,ri.name,31770,2));
  INTEGER2 fips_code_score := MAP(
                        le.fips_code_isnull OR ri.fips_code_isnull => 0,
                        le.fips_code = ri.fips_code  => le.fips_code_weight100,
                        SALT34.Fn_Fail_Scale(le.fips_code_weight100,s.fips_code_switch));
  INTEGER2 county_name_score := MAP(
                        le.county_name_isnull OR ri.county_name_isnull => 0,
                        le.county_name = ri.county_name  => le.county_name_weight100,
                        SALT34.Fn_Fail_Scale(le.county_name_weight100,s.county_name_switch));
  INTEGER2 lender_name_score := MAP(
                        le.lender_name_isnull OR ri.lender_name_isnull => 0,
                        le.lender_name = ri.lender_name OR SALT34.HyphenMatch(le.lender_name,ri.lender_name,1)<=2  => MIN(le.lender_name_weight100,ri.lender_name_weight100),
                        SALT34.MatchBagOfWords(le.lender_name,ri.lender_name,31770,2));
  REAL address_score_scale := ( le.address_weight100 + ri.address_weight100 ) / (le.primrange_weight100 + ri.primrange_weight100 + le.primname_weight100 + ri.primname_weight100 + le.secrange_weight100 + ri.secrange_weight100 + le.locale_weight100 + ri.locale_weight100); // Scaling factor for this concept
  INTEGER2 address_score_pre := MAP( (le.address_isnull OR (le.primrange_isnull OR le.prim_range_alpha_isnull AND le.prim_range_num_isnull) AND (le.primname_isnull OR le.prim_name_alpha_isnull AND le.prim_name_num_isnull) AND (le.secrange_isnull OR le.sec_range_alpha_isnull AND le.sec_range_num_isnull) AND (le.locale_isnull OR le.city_isnull AND le.st_isnull AND le.zip_isnull)) OR (ri.address_isnull OR (ri.primrange_isnull OR ri.prim_range_alpha_isnull AND ri.prim_range_num_isnull) AND (ri.primname_isnull OR ri.prim_name_alpha_isnull AND ri.prim_name_num_isnull) AND (ri.secrange_isnull OR ri.sec_range_alpha_isnull AND ri.sec_range_num_isnull) AND (ri.locale_isnull OR ri.city_isnull AND ri.st_isnull AND ri.zip_isnull)) OR le.address_weight100 = 0 => 0,
                        le.address = ri.address  => le.address_weight100,
                        0);
  INTEGER2 recording_date_score := IF ( recording_date_score_temp >= Config.recording_date_Force * 100, recording_date_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 SourceType_score := IF ( SourceType_score_temp >= Config.SourceType_Force * 100, SourceType_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 did_score := did_score_temp*0.50; 
  INTEGER2 apnt_or_pin_number_score := apnt_or_pin_number_score_temp*0.50; 
  REAL primname_score_scale := ( le.primname_weight100 + ri.primname_weight100 ) / (le.prim_name_alpha_weight100 + ri.prim_name_alpha_weight100 + le.prim_name_num_weight100 + ri.prim_name_num_weight100); // Scaling factor for this concept
  INTEGER2 primname_score_pre := MAP( (le.primname_isnull OR le.prim_name_alpha_isnull AND le.prim_name_num_isnull) OR (ri.primname_isnull OR ri.prim_name_alpha_isnull AND ri.prim_name_num_isnull) => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.primname = ri.primname  => le.primname_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 sales_price_score := IF ( sales_price_score_temp >= Config.sales_price_Force * 100, sales_price_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 first_td_loan_amount_score := IF ( first_td_loan_amount_score_temp >= Config.first_td_loan_amount_Force * 100, first_td_loan_amount_score_temp, SKIP ); // Enforce FORCE parameter
  REAL primrange_score_scale := ( le.primrange_weight100 + ri.primrange_weight100 ) / (le.prim_range_alpha_weight100 + ri.prim_range_alpha_weight100 + le.prim_range_num_weight100 + ri.prim_range_num_weight100); // Scaling factor for this concept
  INTEGER2 primrange_score_pre := MAP( (le.primrange_isnull OR le.prim_range_alpha_isnull AND le.prim_range_num_isnull) OR (ri.primrange_isnull OR ri.prim_range_alpha_isnull AND ri.prim_range_num_isnull) => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.primrange = ri.primrange  => le.primrange_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  REAL secrange_score_scale := ( le.secrange_weight100 + ri.secrange_weight100 ) / (le.sec_range_alpha_weight100 + ri.sec_range_alpha_weight100 + le.sec_range_num_weight100 + ri.sec_range_num_weight100); // Scaling factor for this concept
  INTEGER2 secrange_score_pre := MAP( (le.secrange_isnull OR le.sec_range_alpha_isnull AND le.sec_range_num_isnull) OR (ri.secrange_isnull OR ri.sec_range_alpha_isnull AND ri.sec_range_num_isnull) => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.secrange = ri.secrange  => le.secrange_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 contract_date_score := IF ( contract_date_score_temp >= Config.contract_date_Force * 100, contract_date_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 recorder_page_number_score := IF ( recorder_page_number_score_temp >= Config.recorder_page_number_Force * 100 OR document_number_score > Config.recorder_page_number_OR1_document_number_Force*100, recorder_page_number_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_range_alpha_score := MAP(
                        le.prim_range_alpha_isnull OR ri.prim_range_alpha_isnull => 0,
                        primrange_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range_alpha = ri.prim_range_alpha  => le.prim_range_alpha_weight100,
                        SALT34.Fn_Fail_Scale(le.prim_range_alpha_weight100,s.prim_range_alpha_switch))*IF(primrange_score_scale=0,1,primrange_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 sec_range_alpha_score_temp := MAP(
                        le.sec_range_alpha_isnull OR ri.sec_range_alpha_isnull => 0,
                        secrange_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range_alpha = ri.sec_range_alpha  => le.sec_range_alpha_weight100,
                        SALT34.Fn_Fail_Scale(le.sec_range_alpha_weight100,s.sec_range_alpha_switch))*IF(secrange_score_scale=0,1,secrange_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 prim_name_num_score_temp := MAP(
                        le.prim_name_num_isnull OR ri.prim_name_num_isnull => 0,
                        primname_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name_num = ri.prim_name_num  => le.prim_name_num_weight100,
                        LENGTH(TRIM(le.prim_name_num))>0 and le.prim_name_num = ri.prim_name_num[1..LENGTH(TRIM(le.prim_name_num))] => le.prim_name_num_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.prim_name_num))>0 and ri.prim_name_num = le.prim_name_num[1..LENGTH(TRIM(ri.prim_name_num))] => ri.prim_name_num_weight100, // An initial match - take initial specificity
                        SALT34.Fn_Fail_Scale(le.prim_name_num_weight100,s.prim_name_num_switch))*IF(primname_score_scale=0,1,primname_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 prim_name_alpha_score_temp := MAP(
                        le.prim_name_alpha_isnull OR ri.prim_name_alpha_isnull OR le.prim_name_alpha_weight100 = 0 => 0,
                        primname_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_name_alpha = ri.prim_name_alpha OR SALT34.HyphenMatch(le.prim_name_alpha,ri.prim_name_alpha,1)<=2  => MIN(le.prim_name_alpha_weight100,ri.prim_name_alpha_weight100),
                        SALT34.MatchBagOfWords(le.prim_name_alpha,ri.prim_name_alpha,31768,2))*IF(primname_score_scale=0,1,primname_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 sec_range_num_score_temp := MAP(
                        le.sec_range_num_isnull OR ri.sec_range_num_isnull => 0,
                        secrange_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.sec_range_num = ri.sec_range_num OR SALT34.HyphenMatch(le.sec_range_num,ri.sec_range_num,1)<=2  => MIN(le.sec_range_num_weight100,ri.sec_range_num_weight100),
                        LENGTH(TRIM(le.sec_range_num))>0 and le.sec_range_num = ri.sec_range_num[1..LENGTH(TRIM(le.sec_range_num))] => le.sec_range_num_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.sec_range_num))>0 and ri.sec_range_num = le.sec_range_num[1..LENGTH(TRIM(ri.sec_range_num))] => ri.sec_range_num_weight100, // An initial match - take initial specificity
                        SALT34.Fn_Fail_Scale(le.sec_range_num_weight100,s.sec_range_num_switch))*IF(secrange_score_scale=0,1,secrange_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 prim_range_num_score_temp := MAP(
                        le.prim_range_num_isnull OR ri.prim_range_num_isnull OR le.prim_range_num_weight100 = 0 => 0,
                        primrange_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.prim_range_num = ri.prim_range_num OR SALT34.HyphenMatch(le.prim_range_num,ri.prim_range_num,1)<=2  => MIN(le.prim_range_num_weight100,ri.prim_range_num_weight100),
                        LENGTH(TRIM(le.prim_range_num))>0 and le.prim_range_num = ri.prim_range_num[1..LENGTH(TRIM(le.prim_range_num))] => le.prim_range_num_weight100, // An initial match - take initial specificity
                        LENGTH(TRIM(ri.prim_range_num))>0 and ri.prim_range_num = le.prim_range_num[1..LENGTH(TRIM(ri.prim_range_num))] => ri.prim_range_num_weight100, // An initial match - take initial specificity
                        SALT34.Fn_Fail_Scale(le.prim_range_num_weight100,s.prim_range_num_switch))*IF(primrange_score_scale=0,1,primrange_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  REAL locale_score_scale := ( le.locale_weight100 + ri.locale_weight100 ) / (le.city_weight100 + ri.city_weight100 + le.st_weight100 + ri.st_weight100 + le.zip_weight100 + ri.zip_weight100); // Scaling factor for this concept
  INTEGER2 locale_score_pre := MAP( (le.locale_isnull OR le.city_isnull AND le.st_isnull AND le.zip_isnull) OR (ri.locale_isnull OR ri.city_isnull AND ri.st_isnull AND ri.zip_isnull) => 0,
                        address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.locale = ri.locale  => le.locale_weight100,
                        0)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 zip_score_temp := MAP(
                        le.zip_isnull OR ri.zip_isnull OR le.zip_weight100 = 0 => 0,
                        locale_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.zip = ri.zip  => le.zip_weight100,
                        SALT34.WithinEditNew(le.zip,le.zip_len,ri.zip,ri.zip_len,1,0) =>  SALT34.fn_fuzzy_specificity(le.zip_weight100,le.zip_cnt, le.zip_e1_cnt,ri.zip_weight100,ri.zip_cnt,ri.zip_e1_cnt),
                        SALT34.Fn_Fail_Scale(le.zip_weight100,s.zip_switch))*IF(locale_score_scale=0,1,locale_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 sec_range_alpha_score := IF ( sec_range_alpha_score_temp >= Config.sec_range_alpha_Force * 100, sec_range_alpha_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_name_num_score := IF ( prim_name_num_score_temp >= Config.prim_name_num_Force * 100, prim_name_num_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_name_alpha_score := IF ( prim_name_alpha_score_temp > Config.prim_name_alpha_Force * 100 OR primname_score_pre > 0 OR address_score_pre > 0, prim_name_alpha_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 sec_range_num_score := IF ( sec_range_num_score_temp >= Config.sec_range_num_Force * 100, sec_range_num_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 prim_range_num_score := IF ( prim_range_num_score_temp > Config.prim_range_num_Force * 100 OR primrange_score_pre > 0 OR address_score_pre > 0, prim_range_num_score_temp, SKIP ); // Enforce FORCE parameter
  INTEGER2 city_score := MAP(
                        le.city_isnull OR ri.city_isnull => 0,
                        locale_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.city = ri.city OR SALT34.HyphenMatch(le.city,ri.city,1)<=2  => MIN(le.city_weight100,ri.city_weight100),
                        SALT34.MatchBagOfWords(le.city,ri.city,31784,1))*IF(locale_score_scale=0,1,locale_score_scale)*IF(address_score_scale=0,1,address_score_scale);
  INTEGER2 st_score := MAP(
                        le.st_isnull OR ri.st_isnull => 0,
                        locale_score_pre > 0 OR address_score_pre > 0 => 0, // Ancestor has found solution so child keeps quiet
                        le.st = ri.st  => le.st_weight100,
                        SALT34.Fn_Fail_Scale(le.st_weight100,s.st_switch))*IF(locale_score_scale=0,1,locale_score_scale)*IF(address_score_scale=0,1,address_score_scale);
// Compute the score for the concept primname
  INTEGER2 primname_score_ext := SALT34.ClipScore(MAX(primname_score_pre,0) + prim_name_alpha_score + prim_name_num_score + MAX(address_score_pre,0));// Score in surrounding context
  INTEGER2 primname_score_res := MAX(0,primname_score_pre); // At least nothing
  INTEGER2 primname_score := primname_score_res;
  INTEGER2 zip_score := IF ( zip_score_temp > Config.zip_Force * 100 OR locale_score_pre > 0 OR address_score_pre > 0, zip_score_temp, SKIP ); // Enforce FORCE parameter
// Compute the score for the concept primrange
  INTEGER2 primrange_score_ext := SALT34.ClipScore(MAX(primrange_score_pre,0) + prim_range_alpha_score + prim_range_num_score + MAX(address_score_pre,0));// Score in surrounding context
  INTEGER2 primrange_score_res := MAX(0,primrange_score_pre); // At least nothing
  INTEGER2 primrange_score := primrange_score_res;
// Compute the score for the concept secrange
  INTEGER2 secrange_score_ext := SALT34.ClipScore(MAX(secrange_score_pre,0) + sec_range_alpha_score + sec_range_num_score + MAX(address_score_pre,0));// Score in surrounding context
  INTEGER2 secrange_score_res := MAX(0,secrange_score_pre); // At least nothing
  INTEGER2 secrange_score := secrange_score_res;
// Compute the score for the concept locale
  INTEGER2 locale_score_ext := SALT34.ClipScore(MAX(locale_score_pre,0) + city_score + st_score + zip_score + MAX(address_score_pre,0));// Score in surrounding context
  INTEGER2 locale_score_res := MAX(0,locale_score_pre); // At least nothing
  INTEGER2 locale_score := locale_score_res;
// Compute the score for the concept address
  INTEGER2 address_score_ext := SALT34.ClipScore(MAX(address_score_pre,0)+ primrange_score + prim_range_alpha_score + prim_range_num_score+ primname_score + prim_name_alpha_score + prim_name_num_score+ secrange_score + sec_range_alpha_score + sec_range_num_score+ locale_score + city_score + st_score + zip_score);// Score in surrounding context
  INTEGER2 address_score_res := MAX(0,address_score_pre); // At least nothing
  INTEGER2 address_score := IF ( address_score_ext > 0,address_score_res,SKIP);
  SELF.Conf_Prop := (0
    +MAX(le.sales_price_prop,ri.sales_price_prop)*sales_price_score // Score if either field propogated
    +MAX(le.first_td_loan_amount_prop,ri.first_td_loan_amount_prop)*first_td_loan_amount_score // Score if either field propogated
    +if(le.secrange_prop+ri.secrange_prop>0,secrange_score*(0+if(le.sec_range_alpha_prop+ri.sec_range_alpha_prop>0,s.sec_range_alpha_specificity,0)+if(le.sec_range_num_prop+ri.sec_range_num_prop>0,s.sec_range_num_specificity,0))/( s.sec_range_alpha_specificity+ s.sec_range_num_specificity),0)
    +MAX(le.contract_date_prop,ri.contract_date_prop)*contract_date_score // Score if either field propogated
    +MAX(le.sec_range_alpha_prop,ri.sec_range_alpha_prop)*sec_range_alpha_score // Score if either field propogated
    +(MAX(le.sec_range_num_prop,ri.sec_range_num_prop)/MAX(LENGTH(TRIM(le.sec_range_num)),LENGTH(TRIM(ri.sec_range_num))))*sec_range_num_score // Proportion of longest string propogated
    +if(le.address_prop+ri.address_prop>0,address_score*(0+if(le.secrange_prop+ri.secrange_prop>0,s.secrange_specificity,0))/(+ s.secrange_specificity),0)
  ) / 100; // Score based on propogated fields
  iComp := (recording_date_score + SourceType_score + did_score + apnt_or_pin_number_score + recorder_book_number_score + sales_price_score + first_td_loan_amount_score + contract_date_score + document_number_score + recorder_page_number_score + name_score + fips_code_score + county_name_score + lender_name_score + IF(address_score>0,MAX(address_score,IF(primrange_score>0,MAX(primrange_score,prim_range_alpha_score + prim_range_num_score),prim_range_alpha_score + prim_range_num_score) + IF(primname_score>0,MAX(primname_score,prim_name_alpha_score + prim_name_num_score),prim_name_alpha_score + prim_name_num_score) + IF(secrange_score>0,MAX(secrange_score,sec_range_alpha_score + sec_range_num_score),sec_range_alpha_score + sec_range_num_score) + IF(locale_score>0,MAX(locale_score,city_score + st_score + zip_score),city_score + st_score + zip_score)),IF(primrange_score>0,MAX(primrange_score,prim_range_alpha_score + prim_range_num_score),prim_range_alpha_score + prim_range_num_score) + IF(primname_score>0,MAX(primname_score,prim_name_alpha_score + prim_name_num_score),prim_name_alpha_score + prim_name_num_score) + IF(secrange_score>0,MAX(secrange_score,sec_range_alpha_score + sec_range_num_score),sec_range_alpha_score + sec_range_num_score) + IF(locale_score>0,MAX(locale_score,city_score + st_score + zip_score),city_score + st_score + zip_score))) / 100 + outside;
  SELF.Conf := IF( iComp>=LowerMatchThreshold OR iComp-self.Conf_Prop >= LowerMatchThreshold,iComp,SKIP ); // Remove failing records asap
END;
//Allow rule numbers to be converted to readable text.
EXPORT RuleText(UNSIGNED n) :=  MAP (
  n = 0 => ':recording_date:SourceType:did',
  n = 1 => ':recording_date:SourceType:apnt_or_pin_number',
  n = 2 => ':recording_date:SourceType:recorder_book_number',
  n = 3 => ':recording_date:SourceType:zip',
  n = 4 => ':recording_date:SourceType:sales_price',
  n = 5 => ':recording_date:SourceType:first_td_loan_amount',
  n = 6 => ':recording_date:SourceType:contract_date',
  n = 7 => ':recording_date:SourceType:document_number',
  n = 8 => ':recording_date:SourceType:recorder_page_number',
  n = 9 => ':recording_date:SourceType:prim_range_alpha',
  n = 10 => ':recording_date:SourceType:sec_range_alpha',
  n = 11 => ':recording_date:SourceType:name:*',
  n = 20 => ':recording_date:SourceType:prim_name_num:*',
  n = 28 => ':recording_date:SourceType:prim_name_alpha:*',
  n = 35 => ':recording_date:SourceType:sec_range_num:*',
  n = 41 => ':recording_date:SourceType:fips_code:*',
  n = 46 => ':recording_date:SourceType:county_name:*',
  n = 50 => ':recording_date:SourceType:lender_name:*',
  n = 53 => ':recording_date:SourceType:prim_range_num:*',
  n = 55 => ':recording_date:SourceType:city:st','AttributeFile:'+(STRING)(n-10000));
//Now execute each of the 56 join conditions of which 36 have been optimized into preceding conditions
EXPORT MAC_DoJoins(hfile,trans) := FUNCTIONMACRO
//Fixed fields ->:recording_date(12):SourceType(1):did(26)
dn0 := hfile(~did_isnull);
dn0_deduped := dn0(recording_date_weight100 + SourceType_weight100 + did_weight100>=1500); // Use specificity to flag high-dup counts
mj0 := JOIN( dn0_deduped, dn0_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.did = RIGHT.did
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    ,trans(LEFT,RIGHT,0),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.did = RIGHT.did,10000),HASH);
//Fixed fields ->:recording_date(12):SourceType(1):apnt_or_pin_number(25)
dn1 := hfile(~apnt_or_pin_number_isnull);
dn1_deduped := dn1(recording_date_weight100 + SourceType_weight100 + apnt_or_pin_number_weight100>=2300); // Use specificity to flag high-dup counts
mj1 := JOIN( dn1_deduped, dn1_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.apnt_or_pin_number = RIGHT.apnt_or_pin_number
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    ,trans(LEFT,RIGHT,1),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.apnt_or_pin_number = RIGHT.apnt_or_pin_number,10000),HASH);
//Fixed fields ->:recording_date(12):SourceType(1):recorder_book_number(16)
dn2 := hfile(~recorder_book_number_isnull);
dn2_deduped := dn2(recording_date_weight100 + SourceType_weight100 + recorder_book_number_weight100>=2300); // Use specificity to flag high-dup counts
mj2 := JOIN( dn2_deduped, dn2_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.recorder_book_number = RIGHT.recorder_book_number
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    ,trans(LEFT,RIGHT,2),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.recorder_book_number = RIGHT.recorder_book_number,10000),HASH);
//Fixed fields ->:recording_date(12):SourceType(1):zip(13)
dn3 := hfile(~zip_isnull);
dn3_deduped := dn3(recording_date_weight100 + SourceType_weight100 + zip_weight100>=2300); // Use specificity to flag high-dup counts
mj3 := JOIN( dn3_deduped, dn3_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.zip = RIGHT.zip
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    ,trans(LEFT,RIGHT,3),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.zip = RIGHT.zip,10000),HASH);
//Fixed fields ->:recording_date(12):SourceType(1):sales_price(13)
dn4 := hfile(~sales_price_isnull);
dn4_deduped := dn4(recording_date_weight100 + SourceType_weight100 + sales_price_weight100>=2300); // Use specificity to flag high-dup counts
mj4 := JOIN( dn4_deduped, dn4_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.sales_price = RIGHT.sales_price
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    ,trans(LEFT,RIGHT,4),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.sales_price = RIGHT.sales_price,10000),HASH);
mjs0_t := mj0+mj1+mj2+mj3+mj4;
SALT34.mac_select_best_matches(mjs0_t,rid1,rid2,o0);
mjs0 := o0 : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::mj::0',EXPIRE(Config.PersistExpire));
//Fixed fields ->:recording_date(12):SourceType(1):first_td_loan_amount(13)
dn5 := hfile(~first_td_loan_amount_isnull);
dn5_deduped := dn5(recording_date_weight100 + SourceType_weight100 + first_td_loan_amount_weight100>=2300); // Use specificity to flag high-dup counts
mj5 := JOIN( dn5_deduped, dn5_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.first_td_loan_amount = RIGHT.first_td_loan_amount
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    ,trans(LEFT,RIGHT,5),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.first_td_loan_amount = RIGHT.first_td_loan_amount,10000),HASH);
//Fixed fields ->:recording_date(12):SourceType(1):contract_date(12)
dn6 := hfile(~contract_date_isnull);
dn6_deduped := dn6(recording_date_weight100 + SourceType_weight100 + contract_date_weight100>=2300); // Use specificity to flag high-dup counts
mj6 := JOIN( dn6_deduped, dn6_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.contract_date = RIGHT.contract_date
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    ,trans(LEFT,RIGHT,6),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.contract_date = RIGHT.contract_date,10000),HASH);
//Fixed fields ->:recording_date(12):SourceType(1):document_number(12)
dn7 := hfile(~document_number_isnull);
dn7_deduped := dn7(recording_date_weight100 + SourceType_weight100 + document_number_weight100>=2300); // Use specificity to flag high-dup counts
mj7 := JOIN( dn7_deduped, dn7_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.document_number = RIGHT.document_number
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    ,trans(LEFT,RIGHT,7),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.document_number = RIGHT.document_number,10000),HASH);
//Fixed fields ->:recording_date(12):SourceType(1):recorder_page_number(12)
dn8 := hfile((~recorder_page_number_isnull OR ~document_number_isnull));
dn8_deduped := dn8(recording_date_weight100 + SourceType_weight100 + recorder_page_number_weight100>=2300); // Use specificity to flag high-dup counts
mj8 := JOIN( dn8_deduped, dn8_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.recorder_page_number = RIGHT.recorder_page_number AND LEFT.recorder_book_number = RIGHT.recorder_book_number
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    ,trans(LEFT,RIGHT,8),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.recorder_page_number = RIGHT.recorder_page_number AND LEFT.recorder_book_number = RIGHT.recorder_book_number,10000),HASH);
//Fixed fields ->:recording_date(12):SourceType(1):prim_range_alpha(10)
dn9 := hfile(~prim_range_alpha_isnull);
dn9_deduped := dn9(recording_date_weight100 + SourceType_weight100 + prim_range_alpha_weight100>=2300); // Use specificity to flag high-dup counts
mj9 := JOIN( dn9_deduped, dn9_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    ,trans(LEFT,RIGHT,9),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.prim_range_alpha = RIGHT.prim_range_alpha,10000),HASH);
mjs1_t := mj5+mj6+mj7+mj8+mj9;
SALT34.mac_select_best_matches(mjs1_t,rid1,rid2,o1);
mjs1 := o1 : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::mj::1',EXPIRE(Config.PersistExpire));
//Fixed fields ->:recording_date(12):SourceType(1):sec_range_alpha(10)
dn10 := hfile(~sec_range_alpha_isnull);
dn10_deduped := dn10(recording_date_weight100 + SourceType_weight100 + sec_range_alpha_weight100>=2300); // Use specificity to flag high-dup counts
mj10 := JOIN( dn10_deduped, dn10_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    ,trans(LEFT,RIGHT,10),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.sec_range_alpha = RIGHT.sec_range_alpha,10000),HASH);
//First 3 fields shared with following 8 joins - optimization performed
//Fixed fields ->:recording_date(12):SourceType(1):name(9):prim_name_num(8) also :recording_date(12):SourceType(1):name(9):prim_name_alpha(8) also :recording_date(12):SourceType(1):name(9):sec_range_num(8) also :recording_date(12):SourceType(1):name(9):fips_code(8) also :recording_date(12):SourceType(1):name(9):county_name(8) also :recording_date(12):SourceType(1):name(9):lender_name(7) also :recording_date(12):SourceType(1):name(9):prim_range_num(6) also :recording_date(12):SourceType(1):name(9):city(6) also :recording_date(12):SourceType(1):name(9):st(6)
dn11 := hfile(~name_isnull);
dn11_deduped := dn11(recording_date_weight100 + SourceType_weight100 + name_weight100>=1900); // Use specificity to flag high-dup counts
mj11 := JOIN( dn11_deduped, dn11_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.name = RIGHT.name
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    AND (
          LEFT.prim_name_num = RIGHT.prim_name_num AND ~LEFT.prim_name_num_isnull
    OR    LEFT.prim_name_alpha = RIGHT.prim_name_alpha AND ~LEFT.prim_name_alpha_isnull
    OR    LEFT.sec_range_num = RIGHT.sec_range_num AND ~LEFT.sec_range_num_isnull
    OR    LEFT.fips_code = RIGHT.fips_code AND ~LEFT.fips_code_isnull
    OR    LEFT.county_name = RIGHT.county_name AND ~LEFT.county_name_isnull
    OR    LEFT.lender_name = RIGHT.lender_name AND ~LEFT.lender_name_isnull
    OR    LEFT.prim_range_num = RIGHT.prim_range_num AND ~LEFT.prim_range_num_isnull
    OR    LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,11),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.name = RIGHT.name,10000),HASH);
mjs2_t := mj10+mj11;
SALT34.mac_select_best_matches(mjs2_t,rid1,rid2,o2);
mjs2 := o2 : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::mj::2',EXPIRE(Config.PersistExpire));
//First 3 fields shared with following 7 joins - optimization performed
//Fixed fields ->:recording_date(12):SourceType(1):prim_name_num(8):prim_name_alpha(8) also :recording_date(12):SourceType(1):prim_name_num(8):sec_range_num(8) also :recording_date(12):SourceType(1):prim_name_num(8):fips_code(8) also :recording_date(12):SourceType(1):prim_name_num(8):county_name(8) also :recording_date(12):SourceType(1):prim_name_num(8):lender_name(7) also :recording_date(12):SourceType(1):prim_name_num(8):prim_range_num(6) also :recording_date(12):SourceType(1):prim_name_num(8):city(6) also :recording_date(12):SourceType(1):prim_name_num(8):st(6)
dn20 := hfile(~prim_name_num_isnull);
dn20_deduped := dn20(recording_date_weight100 + SourceType_weight100 + prim_name_num_weight100>=1900); // Use specificity to flag high-dup counts
mj20 := JOIN( dn20_deduped, dn20_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.prim_name_num = RIGHT.prim_name_num
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    AND (
          LEFT.prim_name_alpha = RIGHT.prim_name_alpha AND ~LEFT.prim_name_alpha_isnull
    OR    LEFT.sec_range_num = RIGHT.sec_range_num AND ~LEFT.sec_range_num_isnull
    OR    LEFT.fips_code = RIGHT.fips_code AND ~LEFT.fips_code_isnull
    OR    LEFT.county_name = RIGHT.county_name AND ~LEFT.county_name_isnull
    OR    LEFT.lender_name = RIGHT.lender_name AND ~LEFT.lender_name_isnull
    OR    LEFT.prim_range_num = RIGHT.prim_range_num AND ~LEFT.prim_range_num_isnull
    OR    LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,20),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.prim_name_num = RIGHT.prim_name_num,10000),HASH);
mjs3_t := mj20;
SALT34.mac_select_best_matches(mjs3_t,rid1,rid2,o3);
mjs3 := o3 : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::mj::3',EXPIRE(Config.PersistExpire));
//First 3 fields shared with following 6 joins - optimization performed
//Fixed fields ->:recording_date(12):SourceType(1):prim_name_alpha(8):sec_range_num(8) also :recording_date(12):SourceType(1):prim_name_alpha(8):fips_code(8) also :recording_date(12):SourceType(1):prim_name_alpha(8):county_name(8) also :recording_date(12):SourceType(1):prim_name_alpha(8):lender_name(7) also :recording_date(12):SourceType(1):prim_name_alpha(8):prim_range_num(6) also :recording_date(12):SourceType(1):prim_name_alpha(8):city(6) also :recording_date(12):SourceType(1):prim_name_alpha(8):st(6)
dn28 := hfile(~prim_name_alpha_isnull);
dn28_deduped := dn28(recording_date_weight100 + SourceType_weight100 + prim_name_alpha_weight100>=1900); // Use specificity to flag high-dup counts
mj28 := JOIN( dn28_deduped, dn28_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    AND (
          LEFT.sec_range_num = RIGHT.sec_range_num AND ~LEFT.sec_range_num_isnull
    OR    LEFT.fips_code = RIGHT.fips_code AND ~LEFT.fips_code_isnull
    OR    LEFT.county_name = RIGHT.county_name AND ~LEFT.county_name_isnull
    OR    LEFT.lender_name = RIGHT.lender_name AND ~LEFT.lender_name_isnull
    OR    LEFT.prim_range_num = RIGHT.prim_range_num AND ~LEFT.prim_range_num_isnull
    OR    LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,28),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.prim_name_alpha = RIGHT.prim_name_alpha,10000),HASH);
mjs4_t := mj28;
SALT34.mac_select_best_matches(mjs4_t,rid1,rid2,o4);
mjs4 := o4 : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::mj::4',EXPIRE(Config.PersistExpire));
//First 3 fields shared with following 5 joins - optimization performed
//Fixed fields ->:recording_date(12):SourceType(1):sec_range_num(8):fips_code(8) also :recording_date(12):SourceType(1):sec_range_num(8):county_name(8) also :recording_date(12):SourceType(1):sec_range_num(8):lender_name(7) also :recording_date(12):SourceType(1):sec_range_num(8):prim_range_num(6) also :recording_date(12):SourceType(1):sec_range_num(8):city(6) also :recording_date(12):SourceType(1):sec_range_num(8):st(6)
dn35 := hfile(~sec_range_num_isnull);
dn35_deduped := dn35(recording_date_weight100 + SourceType_weight100 + sec_range_num_weight100>=1900); // Use specificity to flag high-dup counts
mj35 := JOIN( dn35_deduped, dn35_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.sec_range_num = RIGHT.sec_range_num
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    AND (
          LEFT.fips_code = RIGHT.fips_code AND ~LEFT.fips_code_isnull
    OR    LEFT.county_name = RIGHT.county_name AND ~LEFT.county_name_isnull
    OR    LEFT.lender_name = RIGHT.lender_name AND ~LEFT.lender_name_isnull
    OR    LEFT.prim_range_num = RIGHT.prim_range_num AND ~LEFT.prim_range_num_isnull
    OR    LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,35),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.sec_range_num = RIGHT.sec_range_num,10000),HASH);
mjs5_t := mj35;
SALT34.mac_select_best_matches(mjs5_t,rid1,rid2,o5);
mjs5 := o5 : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::mj::5',EXPIRE(Config.PersistExpire));
//First 3 fields shared with following 4 joins - optimization performed
//Fixed fields ->:recording_date(12):SourceType(1):fips_code(8):county_name(8) also :recording_date(12):SourceType(1):fips_code(8):lender_name(7) also :recording_date(12):SourceType(1):fips_code(8):prim_range_num(6) also :recording_date(12):SourceType(1):fips_code(8):city(6) also :recording_date(12):SourceType(1):fips_code(8):st(6)
dn41 := hfile(~fips_code_isnull);
dn41_deduped := dn41(recording_date_weight100 + SourceType_weight100 + fips_code_weight100>=1900); // Use specificity to flag high-dup counts
mj41 := JOIN( dn41_deduped, dn41_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.fips_code = RIGHT.fips_code
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    AND (
          LEFT.county_name = RIGHT.county_name AND ~LEFT.county_name_isnull
    OR    LEFT.lender_name = RIGHT.lender_name AND ~LEFT.lender_name_isnull
    OR    LEFT.prim_range_num = RIGHT.prim_range_num AND ~LEFT.prim_range_num_isnull
    OR    LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,41),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.fips_code = RIGHT.fips_code,10000),HASH);
mjs6_t := mj41;
SALT34.mac_select_best_matches(mjs6_t,rid1,rid2,o6);
mjs6 := o6 : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::mj::6',EXPIRE(Config.PersistExpire));
//First 3 fields shared with following 3 joins - optimization performed
//Fixed fields ->:recording_date(12):SourceType(1):county_name(8):lender_name(7) also :recording_date(12):SourceType(1):county_name(8):prim_range_num(6) also :recording_date(12):SourceType(1):county_name(8):city(6) also :recording_date(12):SourceType(1):county_name(8):st(6)
dn46 := hfile(~county_name_isnull);
dn46_deduped := dn46(recording_date_weight100 + SourceType_weight100 + county_name_weight100>=1900); // Use specificity to flag high-dup counts
mj46 := JOIN( dn46_deduped, dn46_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.county_name = RIGHT.county_name
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    AND (
          LEFT.lender_name = RIGHT.lender_name AND ~LEFT.lender_name_isnull
    OR    LEFT.prim_range_num = RIGHT.prim_range_num AND ~LEFT.prim_range_num_isnull
    OR    LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,46),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.county_name = RIGHT.county_name,10000),HASH);
//First 3 fields shared with following 2 joins - optimization performed
//Fixed fields ->:recording_date(12):SourceType(1):lender_name(7):prim_range_num(6) also :recording_date(12):SourceType(1):lender_name(7):city(6) also :recording_date(12):SourceType(1):lender_name(7):st(6)
dn50 := hfile(~lender_name_isnull);
dn50_deduped := dn50(recording_date_weight100 + SourceType_weight100 + lender_name_weight100>=1900); // Use specificity to flag high-dup counts
mj50 := JOIN( dn50_deduped, dn50_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.lender_name = RIGHT.lender_name
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    AND (
          LEFT.prim_range_num = RIGHT.prim_range_num AND ~LEFT.prim_range_num_isnull
    OR    LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,50),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.lender_name = RIGHT.lender_name,10000),HASH);
mjs7_t := mj46+mj50;
SALT34.mac_select_best_matches(mjs7_t,rid1,rid2,o7);
mjs7 := o7 : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::mj::7',EXPIRE(Config.PersistExpire));
//First 3 fields shared with following 1 joins - optimization performed
//Fixed fields ->:recording_date(12):SourceType(1):prim_range_num(6):city(6) also :recording_date(12):SourceType(1):prim_range_num(6):st(6)
dn53 := hfile(~prim_range_num_isnull);
dn53_deduped := dn53(recording_date_weight100 + SourceType_weight100 + prim_range_num_weight100>=1900); // Use specificity to flag high-dup counts
mj53 := JOIN( dn53_deduped, dn53_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.prim_range_num = RIGHT.prim_range_num
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    AND (
          LEFT.city = RIGHT.city AND ~LEFT.city_isnull
    OR    LEFT.st = RIGHT.st AND ~LEFT.st_isnull
        )
    ,trans(LEFT,RIGHT,53),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.prim_range_num = RIGHT.prim_range_num,10000),HASH);
//Fixed fields ->:recording_date(12):SourceType(1):city(6):st(6)
dn55 := hfile(~city_isnull AND ~st_isnull);
dn55_deduped := dn55(recording_date_weight100 + SourceType_weight100 + city_weight100 + st_weight100>=2300); // Use specificity to flag high-dup counts
mj55 := JOIN( dn55_deduped, dn55_deduped, LEFT.DPROPTXID > RIGHT.DPROPTXID
    AND LEFT.recording_date = RIGHT.recording_date
    AND LEFT.SourceType = RIGHT.SourceType
    AND LEFT.city = RIGHT.city
    AND LEFT.st = RIGHT.st
    AND ( ~left.zip_isnull AND ~right.zip_isnull )
    AND ( left.sales_price = right.sales_price OR left.sales_price_isnull OR right.sales_price_isnull )
    AND ( left.first_td_loan_amount = right.first_td_loan_amount OR left.first_td_loan_amount_isnull OR right.first_td_loan_amount_isnull )
    AND ( left.contract_date = right.contract_date OR left.contract_date_isnull OR right.contract_date_isnull )
    AND (( ~left.recorder_page_number_isnull AND ~right.recorder_page_number_isnull ) OR ( ~left.document_number_isnull AND ~right.document_number_isnull ))
    AND ( left.sec_range_alpha = right.sec_range_alpha OR left.sec_range_alpha_isnull OR right.sec_range_alpha_isnull )
    AND ( ~left.prim_name_alpha_isnull AND ~right.prim_name_alpha_isnull )
    AND ( ~left.prim_range_num_isnull AND ~right.prim_range_num_isnull ) AND ( ~left.address_isnull AND ~right.address_isnull )
    ,trans(LEFT,RIGHT,55),HINT(unsorted_output),
    ATMOST(LEFT.recording_date = RIGHT.recording_date
      AND LEFT.SourceType = RIGHT.SourceType
      AND LEFT.city = RIGHT.city
      AND LEFT.st = RIGHT.st,10000),HASH);
last_mjs_t :=mj53+mj55;
SALT34.mac_select_best_matches(last_mjs_t,rid1,rid2,o);
mjs8 := o : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::mj::8',EXPIRE(Config.PersistExpire));
RETURN  mjs0+ mjs1+ mjs2+ mjs3+ mjs4+ mjs5+ mjs6+ mjs7+ mjs8;
ENDMACRO;
SHARED all_mjs := MAC_DoJoins(h,match_join);
EXPORT All_Matches := all_mjs : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::all_m',EXPIRE(Config.PersistExpire)); // To by used by rid and DPROPTXID
SALT34.mac_avoid_transitives(All_Matches,DPROPTXID1,DPROPTXID2,Conf,DateOverlap,Rule,o);
EXPORT PossibleMatches := o : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::mt',EXPIRE(Config.PersistExpire));
SALT34.mac_get_BestPerRecord( All_Matches,rid1,DPROPTXID1,rid2,DPROPTXID2,o );
EXPORT BestPerRecord := o : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::mr',EXPIRE(Config.PersistExpire));
//Now lets see if any slice-outs are needed
too_big := TABLE(h,{DPROPTXID, InCluster := COUNT(GROUP)},DPROPTXID,LOCAL)(InCluster>1000); // DPROPTXID that are too big for sliceout
h_ok := JOIN(h,too_big,LEFT.DPROPTXID=RIGHT.DPROPTXID,TRANSFORM(LEFT),LOCAL,LEFT ONLY);
SHARED in_matches := JOIN(h_ok,h_ok,LEFT.DPROPTXID=RIGHT.DPROPTXID AND (>STRING6<)LEFT.rid<>(>STRING6<)RIGHT.rid,match_join(LEFT,RIGHT,9999),LOCAL,UNORDERED);
SALT34.mac_cluster_breadth(in_matches,rid1,rid2,DPROPTXID1,o);
SHARED in_matches1 := o;
missed_linkages := JOIN(in_matches1,Specificities(ih).ClusterSizes(InCluster>1),LEFT.DPROPTXID1=RIGHT.DPROPTXID,RIGHT ONLY,LOCAL);
missed_linkages1 := JOIN(h,missed_linkages,LEFT.DPROPTXID=RIGHT.DPROPTXID,TRANSFORM(RECORDOF(missed_linkages),SELF.DPROPTXID1:=RIGHT.DPROPTXID,SELF.rid1:=LEFT.rid,SELF:=RIGHT),LOCAL);
o1 := JOIN(in_matches1,Specificities(ih).ClusterSizes,LEFT.DPROPTXID1=RIGHT.DPROPTXID,LOCAL);
EXPORT ClusterLinkages := o1 + missed_linkages1 : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::clu',EXPIRE(Config.PersistExpire));
EXPORT ClusterOutcasts := ClusterLinkages(InCluster>1,Closest<MatchThreshold);
//Now find those outcasts that are liked elsewhere ...
Pref_Layout := RECORD
  SALT34.UIDType rid;  //Outcast
  SALT34.UIDType DPROPTXID;  // Outcase within
  INTEGER2 Closest; // Best present link
  SALT34.UIDType Pref_rid; // Prefers this record
  SALT34.UIDType Pref_DPROPTXID; // Prefers this cluster
  INTEGER2 Conf; // Score of new link
  integer2 Conf_Prop; // Prop of new link
  UNSIGNED2 Pref_Margin; // Extent to which pref is preferred
END;
Pref_Layout note_better(ClusterOutcasts le, BestPerRecord ri) := TRANSFORM
  self.rid := le.rid1;
  self.DPROPTXID := le.DPROPTXID1;
  self.Closest := le.Closest;
  self.Pref_rid := ri.rid2;
  self.Pref_DPROPTXID := ri.DPROPTXID2;
  self.Pref_Margin := ri.Conf-ri.Conf_Prop-le.Closest; // Compute winning margin
  SELF := ri;
END;
// Find those records happier in another cluster
CurrentJumpers := JOIN(BestPerRecord,ClusterOutcasts,LEFT.rid1=RIGHT.rid1 AND RIGHT.closest<LEFT.conf-LEFT.conf_prop,note_better(RIGHT,LEFT),HASH);
// No need for record to jump ship if clusters are joinable
WillJoin1 := JOIN(CurrentJumpers,All_Matches(Conf>=MatchThreshold),LEFT.DPROPTXID=RIGHT.DPROPTXID1 AND LEFT.Pref_DPROPTXID=RIGHT.DPROPTXID2,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin2 := JOIN(WillJoin1,All_Matches(Conf>=MatchThreshold),LEFT.DPROPTXID=RIGHT.DPROPTXID2 AND LEFT.Pref_DPROPTXID=RIGHT.DPROPTXID1,TRANSFORM(LEFT),LEFT ONLY,HASH);
WillJoin3 := JOIN(WillJoin2,match_candidates(ih).hasbuddies,LEFT.rid=RIGHT.rid,TRANSFORM(LEFT),LEFT ONLY,HASH); // Duplicated records cannot be sliced
EXPORT BetterElsewhere := WillJoin3;
EXPORT ToSlice := IF ( Config.DoSliceouts, DEDUP(SORT(DISTRIBUTE(BetterElsewhere(Pref_Margin>10),HASH(DPROPTXID)),DPROPTXID,-Pref_Margin,LOCAL),DPROPTXID,LOCAL)) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::Matches::ToSlice',EXPIRE(Config.PersistExpire));
// 1024x better in new place
  SALT34.MAC_Avoid_SliceOuts(PossibleMatches,DPROPTXID1,DPROPTXID2,DPROPTXID,Pref_DPROPTXID,ToSlice,m); // If DPROPTXID is slice target - don't use in match
  m1 := IF( Config.DoSliceouts,m,PossibleMatches );
EXPORT Matches := m1(Conf>=MatchThreshold) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::Matches::Matches',EXPIRE(Config.PersistExpire));
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
SHARED ih_thin := TABLE(ih_init,{rid,DPROPTXID});
//akayttala - changed to use local instead of ut.MAC_Patch_Id
  ut.MAC_Patch_Id_local(ih_thin,DPROPTXID,BasicMatch(ih).patch_file,DPROPTXID1,DPROPTXID2,ihbp); // Perform basic matches
  SALT34.MAC_SliceOut_ByRID(ihbp,rid,DPROPTXID,ToSlice,rid,sliced0); // Execute Sliceouts
  sliced := IF( Config.DoSliceouts, sliced0, ihbp); // Config-based ability to remove sliceout
//akayttala - changed to use local instead of ut.MAC_Patch_Id 
 ut.MAC_Patch_Id_local(sliced,DPROPTXID,Matches,DPROPTXID1,DPROPTXID2,o); // Join Clusters
SHARED Patched_Infile_thin := o : INDEPENDENT;
  pi1 := JOIN(ih, Patched_Infile_thin, LEFT.rid=RIGHT.rid, TRANSFORM(RECORDOF(ih),SELF:=RIGHT,SELF:=LEFT), KEEP(1), SMART);
EXPORT Patched_Infile := pi1;
//Produced a patched version of match_candidates to get External ADL2 for free.
//akayttala - changed to use local instead of ut.MAC_Patch_Id
ut.MAC_Patch_Id_local(h,DPROPTXID,Matches,DPROPTXID1,DPROPTXID2,o1);
EXPORT Patched_Candidates := o1;
// Now compute a file to show which identifiers have changed from input to output
  MatchHistory.id_shift_r note_change(ih_thin le,patched_infile_thin ri) := TRANSFORM
    SELF.rid := le.rid;
    SELF.DPROPTXID_before := le.DPROPTXID;
    SELF.DPROPTXID_after := ri.DPROPTXID;
    SELF.change_date := (UNSIGNED4)stringlib.GetDateYYYYMMDD();
  END;
EXPORT IdChanges := JOIN(ih_thin,patched_infile_thin,LEFT.rid = RIGHT.rid AND (LEFT.DPROPTXID<>RIGHT.DPROPTXID),note_change(LEFT,RIGHT));
//Now perform the safety checks
EXPORT MatchesPerformed := COUNT( Matches );
EXPORT SlicesPerformed := COUNT( ToSlice );
EXPORT MatchesPropAssisted := COUNT( Matches(Conf_Prop>0) );
EXPORT MatchesPropRequired := COUNT( Matches(Conf-Conf_Prop<MatchThreshold) );
EXPORT PreIDs := InsuranceHeader_Property_Transactions_DeedsMortgages.Fields.UIDConsistency(ih_thin); // Export whole consistency module
EXPORT PostIDs := InsuranceHeader_Property_Transactions_DeedsMortgages.Fields.UIDConsistency(Patched_Infile_thin); // Export whole consistency module
EXPORT PatchingError0 := PreIDs.IdCounts[2].cnt - PostIDs.IdCounts[2].cnt - MatchesPerformed - COUNT(BasicMatch(ih).patch_file)  + SlicesPerformed; // Should be zero
EXPORT DuplicateRids0 := COUNT(Patched_Infile_thin) - PostIDs.IdCounts[1].Cnt; // Should be zero
END;
