// Begin code to produce match candidates
IMPORT SALT34,ut;
IMPORT InsuranceHeader_Property_Transactions_DeedsMortgages; // Import modules for  attribute definitions
EXPORT match_candidates(DATASET(layout_PROPERTY_TRANSACTION) ih) := MODULE
SHARED s := Specificities(ih).Specificities[1];
  h00 := BasicMatch(ih).input_file;
SHARED thin_table := DISTRIBUTE(TABLE(h00,{rid,fips_code,apnt_or_pin_number,apnt_or_pin_number_len,ln_fares_id,did,name,prim_range,prim_range_alpha,prim_range_num,prim_name,prim_name_num,prim_name_alpha,sec_range,sec_range_alpha,sec_range_num,city,st,zip,zip_len,recording_date,SourceType,contract_date,document_number,document_type_code,recorder_book_number,recorder_page_number,sales_price,first_td_loan_amount,lender_name,county_name,primrange,primname,secrange,locale,address,DPROPTXID}),HASH(DPROPTXID));
//Prepare for field propagations ...
PrePropCounts := RECORD
  REAL8 fips_code_pop := AVE(GROUP,IF((thin_table.fips_code  IN SET(s.nulls_fips_code,fips_code) OR thin_table.fips_code = (TYPEOF(thin_table.fips_code))''),0,100));
  REAL8 apnt_or_pin_number_pop := AVE(GROUP,IF((thin_table.apnt_or_pin_number  IN SET(s.nulls_apnt_or_pin_number,apnt_or_pin_number) OR thin_table.apnt_or_pin_number = (TYPEOF(thin_table.apnt_or_pin_number))''),0,100));
  REAL8 did_pop := AVE(GROUP,IF((thin_table.did  IN SET(s.nulls_did,did) OR thin_table.did = (TYPEOF(thin_table.did))''),0,100));
  REAL8 name_pop := AVE(GROUP,IF((thin_table.name  IN SET(s.nulls_name,name) OR thin_table.name = (TYPEOF(thin_table.name))''),0,100));
  REAL8 prim_range_alpha_pop := AVE(GROUP,IF((thin_table.prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR thin_table.prim_range_alpha = (TYPEOF(thin_table.prim_range_alpha))''),0,100));
  REAL8 prim_range_num_pop := AVE(GROUP,IF((thin_table.prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR thin_table.prim_range_num = (TYPEOF(thin_table.prim_range_num))''),0,100));
  REAL8 prim_name_num_pop := AVE(GROUP,IF((thin_table.prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR thin_table.prim_name_num = (TYPEOF(thin_table.prim_name_num))''),0,100));
  REAL8 prim_name_alpha_pop := AVE(GROUP,IF((thin_table.prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR thin_table.prim_name_alpha = (TYPEOF(thin_table.prim_name_alpha))''),0,100));
  REAL8 sec_range_alpha_pop := AVE(GROUP,IF((thin_table.sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR thin_table.sec_range_alpha = (TYPEOF(thin_table.sec_range_alpha))''),0,100));
  REAL8 sec_range_num_pop := AVE(GROUP,IF((thin_table.sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR thin_table.sec_range_num = (TYPEOF(thin_table.sec_range_num))''),0,100));
  REAL8 city_pop := AVE(GROUP,IF((thin_table.city  IN SET(s.nulls_city,city) OR thin_table.city = (TYPEOF(thin_table.city))''),0,100));
  REAL8 st_pop := AVE(GROUP,IF((thin_table.st  IN SET(s.nulls_st,st) OR thin_table.st = (TYPEOF(thin_table.st))''),0,100));
  REAL8 zip_pop := AVE(GROUP,IF((thin_table.zip  IN SET(s.nulls_zip,zip) OR thin_table.zip = (TYPEOF(thin_table.zip))''),0,100));
  REAL8 recording_date_pop := AVE(GROUP,IF((thin_table.recording_date  IN SET(s.nulls_recording_date,recording_date) OR thin_table.recording_date = (TYPEOF(thin_table.recording_date))''),0,100));
  REAL8 SourceType_pop := AVE(GROUP,IF((thin_table.SourceType  IN SET(s.nulls_SourceType,SourceType) OR thin_table.SourceType = (TYPEOF(thin_table.SourceType))''),0,100));
  REAL8 contract_date_pop := AVE(GROUP,IF((thin_table.contract_date  IN SET(s.nulls_contract_date,contract_date) OR thin_table.contract_date = (TYPEOF(thin_table.contract_date))''),0,100));
  REAL8 document_number_pop := AVE(GROUP,IF((thin_table.document_number  IN SET(s.nulls_document_number,document_number) OR thin_table.document_number = (TYPEOF(thin_table.document_number))''),0,100));
  REAL8 recorder_book_number_pop := AVE(GROUP,IF((thin_table.recorder_book_number  IN SET(s.nulls_recorder_book_number,recorder_book_number) OR thin_table.recorder_book_number = (TYPEOF(thin_table.recorder_book_number))''),0,100));
  REAL8 recorder_page_number_pop := AVE(GROUP,IF((thin_table.recorder_page_number  IN SET(s.nulls_recorder_page_number,recorder_page_number) OR thin_table.recorder_page_number = (TYPEOF(thin_table.recorder_page_number))''),0,100));
  REAL8 sales_price_pop := AVE(GROUP,IF((thin_table.sales_price  IN SET(s.nulls_sales_price,sales_price) OR thin_table.sales_price = (TYPEOF(thin_table.sales_price))''),0,100));
  REAL8 first_td_loan_amount_pop := AVE(GROUP,IF((thin_table.first_td_loan_amount  IN SET(s.nulls_first_td_loan_amount,first_td_loan_amount) OR thin_table.first_td_loan_amount = (TYPEOF(thin_table.first_td_loan_amount))''),0,100));
  REAL8 lender_name_pop := AVE(GROUP,IF((thin_table.lender_name  IN SET(s.nulls_lender_name,lender_name) OR thin_table.lender_name = (TYPEOF(thin_table.lender_name))''),0,100));
  REAL8 county_name_pop := AVE(GROUP,IF((thin_table.county_name  IN SET(s.nulls_county_name,county_name) OR thin_table.county_name = (TYPEOF(thin_table.county_name))''),0,100));
  REAL8 primrange_pop := AVE(GROUP,IF(((thin_table.prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR thin_table.prim_range_alpha = (TYPEOF(thin_table.prim_range_alpha))'') AND (thin_table.prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR thin_table.prim_range_num = (TYPEOF(thin_table.prim_range_num))'')),0,100));
  REAL8 primname_pop := AVE(GROUP,IF(((thin_table.prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR thin_table.prim_name_alpha = (TYPEOF(thin_table.prim_name_alpha))'') AND (thin_table.prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR thin_table.prim_name_num = (TYPEOF(thin_table.prim_name_num))'')),0,100));
  REAL8 secrange_pop := AVE(GROUP,IF(((thin_table.sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR thin_table.sec_range_alpha = (TYPEOF(thin_table.sec_range_alpha))'') AND (thin_table.sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR thin_table.sec_range_num = (TYPEOF(thin_table.sec_range_num))'')),0,100));
  REAL8 locale_pop := AVE(GROUP,IF(((thin_table.city  IN SET(s.nulls_city,city) OR thin_table.city = (TYPEOF(thin_table.city))'') AND (thin_table.st  IN SET(s.nulls_st,st) OR thin_table.st = (TYPEOF(thin_table.st))'') AND (thin_table.zip  IN SET(s.nulls_zip,zip) OR thin_table.zip = (TYPEOF(thin_table.zip))'')),0,100));
  REAL8 address_pop := AVE(GROUP,IF((((thin_table.prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR thin_table.prim_range_alpha = (TYPEOF(thin_table.prim_range_alpha))'') AND (thin_table.prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR thin_table.prim_range_num = (TYPEOF(thin_table.prim_range_num))'')) AND ((thin_table.prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR thin_table.prim_name_alpha = (TYPEOF(thin_table.prim_name_alpha))'') AND (thin_table.prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR thin_table.prim_name_num = (TYPEOF(thin_table.prim_name_num))'')) AND ((thin_table.sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR thin_table.sec_range_alpha = (TYPEOF(thin_table.sec_range_alpha))'') AND (thin_table.sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR thin_table.sec_range_num = (TYPEOF(thin_table.sec_range_num))'')) AND ((thin_table.city  IN SET(s.nulls_city,city) OR thin_table.city = (TYPEOF(thin_table.city))'') AND (thin_table.st  IN SET(s.nulls_st,st) OR thin_table.st = (TYPEOF(thin_table.st))'') AND (thin_table.zip  IN SET(s.nulls_zip,zip) OR thin_table.zip = (TYPEOF(thin_table.zip))''))),0,100));
END;
EXPORT PPS := TABLE(thin_table,PrePropCounts);
EXPORT poprec := RECORD
	STRING label;
		REAL8 pop;
	END;
EXPORT PrePropogationStats := SALT34.MAC_Pivot(PPS, poprec);
SHARED layout_withpropvars := RECORD
  thin_table;
  UNSIGNED1 prim_range_alpha_prop := 0;
  UNSIGNED1 prim_range_num_prop := 0;
  UNSIGNED1 prim_name_num_prop := 0;
  UNSIGNED1 prim_name_alpha_prop := 0;
  UNSIGNED1 sec_range_alpha_prop := 0;
  UNSIGNED1 sec_range_num_prop := 0;
  UNSIGNED1 city_prop := 0;
  UNSIGNED1 st_prop := 0;
  UNSIGNED1 zip_prop := 0;
  UNSIGNED1 contract_date_prop := 0;
  UNSIGNED1 sales_price_prop := 0;
  UNSIGNED1 first_td_loan_amount_prop := 0;
  UNSIGNED1 primrange_prop := 0;
  UNSIGNED1 primname_prop := 0;
  UNSIGNED1 secrange_prop := 0;
  UNSIGNED1 locale_prop := 0;
  UNSIGNED1 address_prop := 0;
END;
SHARED with_props := TABLE(thin_table,layout_withpropvars);
SALT34.mac_prop_field(with_props(sec_range_alpha NOT IN SET(s.nulls_sec_range_alpha,sec_range_alpha)),sec_range_alpha,DPROPTXID,sec_range_alpha_props); // For every DID find the best FULL sec_range_alpha
layout_withpropvars take_sec_range_alpha(with_props le,sec_range_alpha_props ri) := TRANSFORM
  SELF.sec_range_alpha := IF ( le.sec_range_alpha IN SET(s.nulls_sec_range_alpha,sec_range_alpha) and ri.DPROPTXID<>(TYPEOF(ri.DPROPTXID))'', ri.sec_range_alpha, le.sec_range_alpha );
  SELF.sec_range_alpha_prop := le.sec_range_alpha_prop + IF ( le.sec_range_alpha IN SET(s.nulls_sec_range_alpha,sec_range_alpha) and ri.sec_range_alpha NOT IN SET(s.nulls_sec_range_alpha,sec_range_alpha) and ri.DPROPTXID<>(TYPEOF(ri.DPROPTXID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj12 := JOIN(with_props,sec_range_alpha_props,left.DPROPTXID=right.DPROPTXID,take_sec_range_alpha(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SALT34.mac_prop_field_init(with_props(sec_range_num NOT IN SET(s.nulls_sec_range_num,sec_range_num)),sec_range_num,DPROPTXID,sec_range_num_props); // For every DID find the best FULL sec_range_num
layout_withpropvars take_sec_range_num(with_props le,sec_range_num_props ri) := TRANSFORM
  SELF.sec_range_num := IF ( le.sec_range_num = ri.sec_range_num[1..LENGTH(TRIM(le.sec_range_num))], ri.sec_range_num, le.sec_range_num );
  SELF.sec_range_num_prop := IF ( LENGTH(TRIM(le.sec_range_num)) < LENGTH(TRIM(ri.sec_range_num)) and le.sec_range_num=ri.sec_range_num[1..LENGTH(TRIM(le.sec_range_num))],LENGTH(TRIM(ri.sec_range_num)) - LENGTH(TRIM(le.sec_range_num)) , le.sec_range_num_prop ); // Store the amount propogated
  SELF := le;
  END;
SHARED pj13 := JOIN(pj12,sec_range_num_props,left.DPROPTXID=right.DPROPTXID AND (left.sec_range_num='' OR left.sec_range_num[1]=right.sec_range_num[1]),take_sec_range_num(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SALT34.mac_prop_field(with_props(contract_date NOT IN SET(s.nulls_contract_date,contract_date)),contract_date,DPROPTXID,contract_date_props); // For every DID find the best FULL contract_date
layout_withpropvars take_contract_date(with_props le,contract_date_props ri) := TRANSFORM
  SELF.contract_date := IF ( le.contract_date IN SET(s.nulls_contract_date,contract_date) and ri.DPROPTXID<>(TYPEOF(ri.DPROPTXID))'', ri.contract_date, le.contract_date );
  SELF.contract_date_prop := le.contract_date_prop + IF ( le.contract_date IN SET(s.nulls_contract_date,contract_date) and ri.contract_date NOT IN SET(s.nulls_contract_date,contract_date) and ri.DPROPTXID<>(TYPEOF(ri.DPROPTXID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj19 := JOIN(pj13,contract_date_props,left.DPROPTXID=right.DPROPTXID,take_contract_date(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SALT34.mac_prop_field(with_props(sales_price NOT IN SET(s.nulls_sales_price,sales_price)),sales_price,DPROPTXID,sales_price_props); // For every DID find the best FULL sales_price
layout_withpropvars take_sales_price(with_props le,sales_price_props ri) := TRANSFORM
  SELF.sales_price := IF ( le.sales_price IN SET(s.nulls_sales_price,sales_price) and ri.DPROPTXID<>(TYPEOF(ri.DPROPTXID))'', ri.sales_price, le.sales_price );
  SELF.sales_price_prop := le.sales_price_prop + IF ( le.sales_price IN SET(s.nulls_sales_price,sales_price) and ri.sales_price NOT IN SET(s.nulls_sales_price,sales_price) and ri.DPROPTXID<>(TYPEOF(ri.DPROPTXID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj24 := JOIN(pj19,sales_price_props,left.DPROPTXID=right.DPROPTXID,take_sales_price(left,right),LEFT OUTER,HASH,HINT(parallel_match));
SALT34.mac_prop_field(with_props(first_td_loan_amount NOT IN SET(s.nulls_first_td_loan_amount,first_td_loan_amount)),first_td_loan_amount,DPROPTXID,first_td_loan_amount_props); // For every DID find the best FULL first_td_loan_amount
layout_withpropvars take_first_td_loan_amount(with_props le,first_td_loan_amount_props ri) := TRANSFORM
  SELF.first_td_loan_amount := IF ( le.first_td_loan_amount IN SET(s.nulls_first_td_loan_amount,first_td_loan_amount) and ri.DPROPTXID<>(TYPEOF(ri.DPROPTXID))'', ri.first_td_loan_amount, le.first_td_loan_amount );
  SELF.first_td_loan_amount_prop := le.first_td_loan_amount_prop + IF ( le.first_td_loan_amount IN SET(s.nulls_first_td_loan_amount,first_td_loan_amount) and ri.first_td_loan_amount NOT IN SET(s.nulls_first_td_loan_amount,first_td_loan_amount) and ri.DPROPTXID<>(TYPEOF(ri.DPROPTXID))'', 1, 0 ); // <>0 => propogation
  SELF := le;
  END;
SHARED pj25 := JOIN(pj24,first_td_loan_amount_props,left.DPROPTXID=right.DPROPTXID,take_first_td_loan_amount(left,right),LEFT OUTER,HASH,HINT(parallel_match));
pj25 do_computes(pj25 le) := TRANSFORM
  SELF.primrange := IF (Fields.InValid_primrange((SALT34.StrType)le.prim_range_alpha,(SALT34.StrType)le.prim_range_num),0,HASH32((SALT34.StrType)le.prim_range_alpha,(SALT34.StrType)le.prim_range_num)); // Combine child fields into 1 for specificity counting
  SELF.primname := IF (Fields.InValid_primname((SALT34.StrType)le.prim_name_alpha,(SALT34.StrType)le.prim_name_num),0,HASH32((SALT34.StrType)le.prim_name_alpha,(SALT34.StrType)le.prim_name_num)); // Combine child fields into 1 for specificity counting
  SELF.secrange := IF (Fields.InValid_secrange((SALT34.StrType)le.sec_range_alpha,(SALT34.StrType)le.sec_range_num),0,HASH32((SALT34.StrType)le.sec_range_alpha,(SALT34.StrType)le.sec_range_num)); // Combine child fields into 1 for specificity counting
  SELF.secrange_prop := IF( le.sec_range_alpha_prop > 0, 1, 0 ) + IF( le.sec_range_num_prop > 0, 2, 0 );
  SELF.locale := IF (Fields.InValid_locale((SALT34.StrType)le.city,(SALT34.StrType)le.st,(SALT34.StrType)le.zip),0,HASH32((SALT34.StrType)le.city,(SALT34.StrType)le.st,(SALT34.StrType)le.zip)); // Combine child fields into 1 for specificity counting
  SELF.address := IF (Fields.InValid_address((SALT34.StrType)SELF.primrange,(SALT34.StrType)SELF.primname,(SALT34.StrType)SELF.secrange,(SALT34.StrType)SELF.locale),0,HASH32((SALT34.StrType)SELF.primrange,(SALT34.StrType)SELF.primname,(SALT34.StrType)SELF.secrange,(SALT34.StrType)SELF.locale)); // Combine child fields into 1 for specificity counting
  SELF.address_prop := IF( SELF.secrange_prop > 0, 4, 0 );
  SELF := le;
END;
SHARED propogated := PROJECT(pj25,do_computes(left)) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::mc_props::PROPERTY_TRANSACTION',EXPIRE(Config.PersistExpire)); // to allow to 'jump' over an exported value
PostPropCounts := RECORD
  REAL8 fips_code_pop := AVE(GROUP,IF((propogated.fips_code  IN SET(s.nulls_fips_code,fips_code) OR propogated.fips_code = (TYPEOF(propogated.fips_code))''),0,100));
  REAL8 apnt_or_pin_number_pop := AVE(GROUP,IF((propogated.apnt_or_pin_number  IN SET(s.nulls_apnt_or_pin_number,apnt_or_pin_number) OR propogated.apnt_or_pin_number = (TYPEOF(propogated.apnt_or_pin_number))''),0,100));
  REAL8 did_pop := AVE(GROUP,IF((propogated.did  IN SET(s.nulls_did,did) OR propogated.did = (TYPEOF(propogated.did))''),0,100));
  REAL8 name_pop := AVE(GROUP,IF((propogated.name  IN SET(s.nulls_name,name) OR propogated.name = (TYPEOF(propogated.name))''),0,100));
  REAL8 prim_range_alpha_pop := AVE(GROUP,IF((propogated.prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR propogated.prim_range_alpha = (TYPEOF(propogated.prim_range_alpha))''),0,100));
  REAL8 prim_range_num_pop := AVE(GROUP,IF((propogated.prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR propogated.prim_range_num = (TYPEOF(propogated.prim_range_num))''),0,100));
  REAL8 prim_name_num_pop := AVE(GROUP,IF((propogated.prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR propogated.prim_name_num = (TYPEOF(propogated.prim_name_num))''),0,100));
  REAL8 prim_name_alpha_pop := AVE(GROUP,IF((propogated.prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR propogated.prim_name_alpha = (TYPEOF(propogated.prim_name_alpha))''),0,100));
  REAL8 sec_range_alpha_pop := AVE(GROUP,IF((propogated.sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR propogated.sec_range_alpha = (TYPEOF(propogated.sec_range_alpha))''),0,100));
  REAL8 sec_range_num_pop := AVE(GROUP,IF((propogated.sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR propogated.sec_range_num = (TYPEOF(propogated.sec_range_num))''),0,100));
  REAL8 city_pop := AVE(GROUP,IF((propogated.city  IN SET(s.nulls_city,city) OR propogated.city = (TYPEOF(propogated.city))''),0,100));
  REAL8 st_pop := AVE(GROUP,IF((propogated.st  IN SET(s.nulls_st,st) OR propogated.st = (TYPEOF(propogated.st))''),0,100));
  REAL8 zip_pop := AVE(GROUP,IF((propogated.zip  IN SET(s.nulls_zip,zip) OR propogated.zip = (TYPEOF(propogated.zip))''),0,100));
  REAL8 recording_date_pop := AVE(GROUP,IF((propogated.recording_date  IN SET(s.nulls_recording_date,recording_date) OR propogated.recording_date = (TYPEOF(propogated.recording_date))''),0,100));
  REAL8 SourceType_pop := AVE(GROUP,IF((propogated.SourceType  IN SET(s.nulls_SourceType,SourceType) OR propogated.SourceType = (TYPEOF(propogated.SourceType))''),0,100));
  REAL8 contract_date_pop := AVE(GROUP,IF((propogated.contract_date  IN SET(s.nulls_contract_date,contract_date) OR propogated.contract_date = (TYPEOF(propogated.contract_date))''),0,100));
  REAL8 document_number_pop := AVE(GROUP,IF((propogated.document_number  IN SET(s.nulls_document_number,document_number) OR propogated.document_number = (TYPEOF(propogated.document_number))''),0,100));
  REAL8 recorder_book_number_pop := AVE(GROUP,IF((propogated.recorder_book_number  IN SET(s.nulls_recorder_book_number,recorder_book_number) OR propogated.recorder_book_number = (TYPEOF(propogated.recorder_book_number))''),0,100));
  REAL8 recorder_page_number_pop := AVE(GROUP,IF((propogated.recorder_page_number  IN SET(s.nulls_recorder_page_number,recorder_page_number) OR propogated.recorder_page_number = (TYPEOF(propogated.recorder_page_number))''),0,100));
  REAL8 sales_price_pop := AVE(GROUP,IF((propogated.sales_price  IN SET(s.nulls_sales_price,sales_price) OR propogated.sales_price = (TYPEOF(propogated.sales_price))''),0,100));
  REAL8 first_td_loan_amount_pop := AVE(GROUP,IF((propogated.first_td_loan_amount  IN SET(s.nulls_first_td_loan_amount,first_td_loan_amount) OR propogated.first_td_loan_amount = (TYPEOF(propogated.first_td_loan_amount))''),0,100));
  REAL8 lender_name_pop := AVE(GROUP,IF((propogated.lender_name  IN SET(s.nulls_lender_name,lender_name) OR propogated.lender_name = (TYPEOF(propogated.lender_name))''),0,100));
  REAL8 county_name_pop := AVE(GROUP,IF((propogated.county_name  IN SET(s.nulls_county_name,county_name) OR propogated.county_name = (TYPEOF(propogated.county_name))''),0,100));
  REAL8 primrange_pop := AVE(GROUP,IF(((propogated.prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR propogated.prim_range_alpha = (TYPEOF(propogated.prim_range_alpha))'') AND (propogated.prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR propogated.prim_range_num = (TYPEOF(propogated.prim_range_num))'')),0,100));
  REAL8 primname_pop := AVE(GROUP,IF(((propogated.prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR propogated.prim_name_alpha = (TYPEOF(propogated.prim_name_alpha))'') AND (propogated.prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR propogated.prim_name_num = (TYPEOF(propogated.prim_name_num))'')),0,100));
  REAL8 secrange_pop := AVE(GROUP,IF(((propogated.sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR propogated.sec_range_alpha = (TYPEOF(propogated.sec_range_alpha))'') AND (propogated.sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR propogated.sec_range_num = (TYPEOF(propogated.sec_range_num))'')),0,100));
  REAL8 locale_pop := AVE(GROUP,IF(((propogated.city  IN SET(s.nulls_city,city) OR propogated.city = (TYPEOF(propogated.city))'') AND (propogated.st  IN SET(s.nulls_st,st) OR propogated.st = (TYPEOF(propogated.st))'') AND (propogated.zip  IN SET(s.nulls_zip,zip) OR propogated.zip = (TYPEOF(propogated.zip))'')),0,100));
  REAL8 address_pop := AVE(GROUP,IF((((propogated.prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR propogated.prim_range_alpha = (TYPEOF(propogated.prim_range_alpha))'') AND (propogated.prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR propogated.prim_range_num = (TYPEOF(propogated.prim_range_num))'')) AND ((propogated.prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR propogated.prim_name_alpha = (TYPEOF(propogated.prim_name_alpha))'') AND (propogated.prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR propogated.prim_name_num = (TYPEOF(propogated.prim_name_num))'')) AND ((propogated.sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR propogated.sec_range_alpha = (TYPEOF(propogated.sec_range_alpha))'') AND (propogated.sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR propogated.sec_range_num = (TYPEOF(propogated.sec_range_num))'')) AND ((propogated.city  IN SET(s.nulls_city,city) OR propogated.city = (TYPEOF(propogated.city))'') AND (propogated.st  IN SET(s.nulls_st,st) OR propogated.st = (TYPEOF(propogated.st))'') AND (propogated.zip  IN SET(s.nulls_zip,zip) OR propogated.zip = (TYPEOF(propogated.zip))''))),0,100));
END;
 PoPS := TABLE(propogated,PostPropCounts);
EXPORT PostPropogationStats := SALT34.MAC_Pivot(PoPS, poprec);
  Grpd := GROUP( SORT(
    DISTRIBUTE( TABLE( propogated, { propogated, UNSIGNED2 Buddies := 0 }),HASH(DPROPTXID)),
    DPROPTXID,fips_code,apnt_or_pin_number,did,name,prim_range_alpha,prim_range_num,prim_name_num,prim_name_alpha,sec_range_alpha,sec_range_num,city,st,zip,recording_date,SourceType,contract_date,document_number,recorder_book_number,recorder_page_number,sales_price,first_td_loan_amount,lender_name,county_name, LOCAL),
    DPROPTXID,fips_code,apnt_or_pin_number,did,name,prim_range_alpha,prim_range_num,prim_name_num,prim_name_alpha,sec_range_alpha,sec_range_num,city,st,zip,recording_date,SourceType,contract_date,document_number,recorder_book_number,recorder_page_number,sales_price,first_td_loan_amount,lender_name,county_name, LOCAL);
  Grpd Tr(Grpd le, Grpd ri) := TRANSFORM
    SELF.Buddies := le.Buddies+1;
    SELF := le;
  END;
SHARED h0 := UNGROUP(ROLLUP(Grpd,TRUE,Tr(LEFT,RIGHT)));// Only one copy of each record
EXPORT Layout_Matches := RECORD//in this module for because of ,foward bug
  UNSIGNED2 Rule;
  INTEGER2 Conf := 0;
  INTEGER2 DateOverlap := 0; // Number of months of overlap, -ve to show distance of non-overlap
  INTEGER2 Conf_Prop := 0; // Confidence provided by propogated fields
  SALT34.UIDType DPROPTXID1;
  SALT34.UIDType DPROPTXID2;
  SALT34.UIDType rid1 := 0;
  SALT34.UIDType rid2 := 0;
END;
EXPORT Layout_Candidates := RECORD // A record to hold weights of each field value
  {h0} AND NOT [name,prim_name_alpha,city,lender_name]; // remove wordbag fields which need to be expanded
  INTEGER2 fips_code_weight100 := 0; // Contains 100x the specificity
  BOOLEAN fips_code_isnull := (h0.fips_code  IN SET(s.nulls_fips_code,fips_code) OR h0.fips_code = (TYPEOF(h0.fips_code))''); // Simplify later processing 
  INTEGER2 apnt_or_pin_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN apnt_or_pin_number_isnull := (h0.apnt_or_pin_number  IN SET(s.nulls_apnt_or_pin_number,apnt_or_pin_number) OR h0.apnt_or_pin_number = (TYPEOF(h0.apnt_or_pin_number))''); // Simplify later processing 
  UNSIGNED apnt_or_pin_number_cnt := 0; // Number of instances with this particular field value
  UNSIGNED apnt_or_pin_number_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 did_weight100 := 0; // Contains 100x the specificity
  BOOLEAN did_isnull := (h0.did  IN SET(s.nulls_did,did) OR h0.did = (TYPEOF(h0.did))''); // Simplify later processing 
  STRING160 name := h0.name; // Expanded wordbag field
  INTEGER2 name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN name_isnull := (h0.name  IN SET(s.nulls_name,name) OR h0.name = (TYPEOF(h0.name))''); // Simplify later processing 
  INTEGER2 prim_range_alpha_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_alpha_isnull := (h0.prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR h0.prim_range_alpha = (TYPEOF(h0.prim_range_alpha))''); // Simplify later processing 
  INTEGER2 prim_range_num_weight100 := 0; // Contains 100x the specificity
  INTEGER2 prim_range_num_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_num_isnull := (h0.prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR h0.prim_range_num = (TYPEOF(h0.prim_range_num))''); // Simplify later processing 
  INTEGER2 prim_name_num_weight100 := 0; // Contains 100x the specificity
  INTEGER2 prim_name_num_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_num_isnull := (h0.prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR h0.prim_name_num = (TYPEOF(h0.prim_name_num))''); // Simplify later processing 
  STRING56 prim_name_alpha := h0.prim_name_alpha; // Expanded wordbag field
  INTEGER2 prim_name_alpha_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_alpha_isnull := (h0.prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR h0.prim_name_alpha = (TYPEOF(h0.prim_name_alpha))''); // Simplify later processing 
  INTEGER2 sec_range_alpha_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sec_range_alpha_isnull := (h0.sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR h0.sec_range_alpha = (TYPEOF(h0.sec_range_alpha))''); // Simplify later processing 
  INTEGER2 sec_range_num_weight100 := 0; // Contains 100x the specificity
  INTEGER2 sec_range_num_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sec_range_num_isnull := (h0.sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR h0.sec_range_num = (TYPEOF(h0.sec_range_num))''); // Simplify later processing 
  STRING50 city := h0.city; // Expanded wordbag field
  INTEGER2 city_weight100 := 0; // Contains 100x the specificity
  BOOLEAN city_isnull := (h0.city  IN SET(s.nulls_city,city) OR h0.city = (TYPEOF(h0.city))''); // Simplify later processing 
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := (h0.st  IN SET(s.nulls_st,st) OR h0.st = (TYPEOF(h0.st))''); // Simplify later processing 
  INTEGER2 zip_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip_isnull := (h0.zip  IN SET(s.nulls_zip,zip) OR h0.zip = (TYPEOF(h0.zip))''); // Simplify later processing 
  UNSIGNED zip_cnt := 0; // Number of instances with this particular field value
  UNSIGNED zip_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 recording_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN recording_date_isnull := (h0.recording_date  IN SET(s.nulls_recording_date,recording_date) OR h0.recording_date = (TYPEOF(h0.recording_date))''); // Simplify later processing 
  INTEGER2 SourceType_weight100 := 0; // Contains 100x the specificity
  BOOLEAN SourceType_isnull := (h0.SourceType  IN SET(s.nulls_SourceType,SourceType) OR h0.SourceType = (TYPEOF(h0.SourceType))''); // Simplify later processing 
  INTEGER2 contract_date_weight100 := 0; // Contains 100x the specificity
  BOOLEAN contract_date_isnull := (h0.contract_date  IN SET(s.nulls_contract_date,contract_date) OR h0.contract_date = (TYPEOF(h0.contract_date))''); // Simplify later processing 
  INTEGER2 document_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN document_number_isnull := (h0.document_number  IN SET(s.nulls_document_number,document_number) OR h0.document_number = (TYPEOF(h0.document_number))''); // Simplify later processing 
  UNSIGNED document_number_cnt := 0; // Number of instances with this particular field value
  INTEGER2 recorder_book_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN recorder_book_number_isnull := (h0.recorder_book_number  IN SET(s.nulls_recorder_book_number,recorder_book_number) OR h0.recorder_book_number = (TYPEOF(h0.recorder_book_number))''); // Simplify later processing 
  INTEGER2 recorder_page_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN recorder_page_number_isnull := (h0.recorder_page_number  IN SET(s.nulls_recorder_page_number,recorder_page_number) OR h0.recorder_page_number = (TYPEOF(h0.recorder_page_number))''); // Simplify later processing 
  INTEGER2 sales_price_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sales_price_isnull := (h0.sales_price  IN SET(s.nulls_sales_price,sales_price) OR h0.sales_price = (TYPEOF(h0.sales_price))''); // Simplify later processing 
  INTEGER2 first_td_loan_amount_weight100 := 0; // Contains 100x the specificity
  BOOLEAN first_td_loan_amount_isnull := (h0.first_td_loan_amount  IN SET(s.nulls_first_td_loan_amount,first_td_loan_amount) OR h0.first_td_loan_amount = (TYPEOF(h0.first_td_loan_amount))''); // Simplify later processing 
  STRING80 lender_name := h0.lender_name; // Expanded wordbag field
  INTEGER2 lender_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN lender_name_isnull := (h0.lender_name  IN SET(s.nulls_lender_name,lender_name) OR h0.lender_name = (TYPEOF(h0.lender_name))''); // Simplify later processing 
  INTEGER2 county_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN county_name_isnull := (h0.county_name  IN SET(s.nulls_county_name,county_name) OR h0.county_name = (TYPEOF(h0.county_name))''); // Simplify later processing 
  INTEGER2 primrange_weight100 := 0; // Contains 100x the specificity
  BOOLEAN primrange_isnull := ((h0.prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR h0.prim_range_alpha = (TYPEOF(h0.prim_range_alpha))'') AND (h0.prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR h0.prim_range_num = (TYPEOF(h0.prim_range_num))'')); // Simplify later processing 
  INTEGER2 primname_weight100 := 0; // Contains 100x the specificity
  BOOLEAN primname_isnull := ((h0.prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR h0.prim_name_alpha = (TYPEOF(h0.prim_name_alpha))'') AND (h0.prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR h0.prim_name_num = (TYPEOF(h0.prim_name_num))'')); // Simplify later processing 
  INTEGER2 secrange_weight100 := 0; // Contains 100x the specificity
  BOOLEAN secrange_isnull := ((h0.sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR h0.sec_range_alpha = (TYPEOF(h0.sec_range_alpha))'') AND (h0.sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR h0.sec_range_num = (TYPEOF(h0.sec_range_num))'')); // Simplify later processing 
  INTEGER2 locale_weight100 := 0; // Contains 100x the specificity
  BOOLEAN locale_isnull := ((h0.city  IN SET(s.nulls_city,city) OR h0.city = (TYPEOF(h0.city))'') AND (h0.st  IN SET(s.nulls_st,st) OR h0.st = (TYPEOF(h0.st))'') AND (h0.zip  IN SET(s.nulls_zip,zip) OR h0.zip = (TYPEOF(h0.zip))'')); // Simplify later processing 
  INTEGER2 address_weight100 := 0; // Contains 100x the specificity
  BOOLEAN address_isnull := (((h0.prim_range_alpha  IN SET(s.nulls_prim_range_alpha,prim_range_alpha) OR h0.prim_range_alpha = (TYPEOF(h0.prim_range_alpha))'') AND (h0.prim_range_num  IN SET(s.nulls_prim_range_num,prim_range_num) OR h0.prim_range_num = (TYPEOF(h0.prim_range_num))'')) AND ((h0.prim_name_alpha  IN SET(s.nulls_prim_name_alpha,prim_name_alpha) OR h0.prim_name_alpha = (TYPEOF(h0.prim_name_alpha))'') AND (h0.prim_name_num  IN SET(s.nulls_prim_name_num,prim_name_num) OR h0.prim_name_num = (TYPEOF(h0.prim_name_num))'')) AND ((h0.sec_range_alpha  IN SET(s.nulls_sec_range_alpha,sec_range_alpha) OR h0.sec_range_alpha = (TYPEOF(h0.sec_range_alpha))'') AND (h0.sec_range_num  IN SET(s.nulls_sec_range_num,sec_range_num) OR h0.sec_range_num = (TYPEOF(h0.sec_range_num))'')) AND ((h0.city  IN SET(s.nulls_city,city) OR h0.city = (TYPEOF(h0.city))'') AND (h0.st  IN SET(s.nulls_st,st) OR h0.st = (TYPEOF(h0.st))'') AND (h0.zip  IN SET(s.nulls_zip,zip) OR h0.zip = (TYPEOF(h0.zip))''))); // Simplify later processing 
END;
h1 := TABLE(h0,layout_candidates)((~recorder_page_number_isnull OR ~document_number_isnull));
//Now add the weights of each field one by one
//Would also create auto-id fields here
layout_candidates add_SourceType(layout_candidates le,Specificities(ih).SourceType_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.SourceType_weight100 := MAP (le.SourceType_isnull => 0, patch_default and ri.field_specificity=0 => s.SourceType_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j27 := JOIN(h1,PULL(Specificities(ih).SourceType_values_persisted),LEFT.SourceType=RIGHT.SourceType,add_SourceType(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_st(layout_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j26 := JOIN(j27,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_st(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_city(layout_candidates le,Specificities(ih).city_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.city_weight100 := MAP (le.city_isnull => 0, patch_default and ri.field_specificity=0 => s.city_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.city := IF( ri.field_specificity<>0 or ri.word<>'',SELF.city_weight100+' '+ri.word,SALT34.Fn_WordBag_AppendSpecs_Fake(le.city, s.city_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
j25 := JOIN(j26,PULL(Specificities(ih).city_values_persisted),LEFT.city=RIGHT.city,add_city(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_prim_range_num(layout_candidates le,Specificities(ih).prim_range_num_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_num_weight100 := MAP (le.prim_range_num_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_num_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.prim_range_num_initial_char_weight100 := MAP (le.prim_range_num_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
j24 := JOIN(j25,PULL(Specificities(ih).prim_range_num_values_persisted),LEFT.prim_range_num=RIGHT.prim_range_num,add_prim_range_num(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_lender_name(layout_candidates le,Specificities(ih).lender_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.lender_name_weight100 := MAP (le.lender_name_isnull => 0, patch_default and ri.field_specificity=0 => s.lender_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.lender_name := IF( ri.field_specificity<>0 or ri.word<>'',SELF.lender_name_weight100+' '+ri.word,SALT34.Fn_WordBag_AppendSpecs_Fake(le.lender_name, s.lender_name_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
j23 := JOIN(j24,PULL(Specificities(ih).lender_name_values_persisted),LEFT.lender_name=RIGHT.lender_name,add_lender_name(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
layout_candidates add_county_name(layout_candidates le,Specificities(ih).county_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.county_name_weight100 := MAP (le.county_name_isnull => 0, patch_default and ri.field_specificity=0 => s.county_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j23,s.nulls_county_name,Specificities(ih).county_name_values_persisted,county_name,county_name_weight100,add_county_name,j22);
layout_candidates add_sec_range_num(layout_candidates le,Specificities(ih).sec_range_num_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sec_range_num_weight100 := MAP (le.sec_range_num_isnull => 0, patch_default and ri.field_specificity=0 => s.sec_range_num_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.sec_range_num_initial_char_weight100 := MAP (le.sec_range_num_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j22,s.nulls_sec_range_num,Specificities(ih).sec_range_num_values_persisted,sec_range_num,sec_range_num_weight100,add_sec_range_num,j21);
layout_candidates add_prim_name_alpha(layout_candidates le,Specificities(ih).prim_name_alpha_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_alpha_weight100 := MAP (le.prim_name_alpha_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_alpha_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.prim_name_alpha := IF( ri.field_specificity<>0 or ri.word<>'',SELF.prim_name_alpha_weight100+' '+ri.word,SALT34.Fn_WordBag_AppendSpecs_Fake(le.prim_name_alpha, s.prim_name_alpha_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j21,s.nulls_prim_name_alpha,Specificities(ih).prim_name_alpha_values_persisted,prim_name_alpha,prim_name_alpha_weight100,add_prim_name_alpha,j20);
layout_candidates add_prim_name_num(layout_candidates le,Specificities(ih).prim_name_num_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_num_weight100 := MAP (le.prim_name_num_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_num_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.prim_name_num_initial_char_weight100 := MAP (le.prim_name_num_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j20,s.nulls_prim_name_num,Specificities(ih).prim_name_num_values_persisted,prim_name_num,prim_name_num_weight100,add_prim_name_num,j19);
layout_candidates add_fips_code(layout_candidates le,Specificities(ih).fips_code_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.fips_code_weight100 := MAP (le.fips_code_isnull => 0, patch_default and ri.field_specificity=0 => s.fips_code_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j19,s.nulls_fips_code,Specificities(ih).fips_code_values_persisted,fips_code,fips_code_weight100,add_fips_code,j18);
layout_candidates add_name(layout_candidates le,Specificities(ih).name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.name_weight100 := MAP (le.name_isnull => 0, patch_default and ri.field_specificity=0 => s.name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.name := IF( ri.field_specificity<>0 or ri.word<>'',SELF.name_weight100+' '+ri.word,SALT34.Fn_WordBag_AppendSpecs_Fake(le.name, s.name_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j18,s.nulls_name,Specificities(ih).name_values_persisted,name,name_weight100,add_name,j17);
layout_candidates add_sec_range_alpha(layout_candidates le,Specificities(ih).sec_range_alpha_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sec_range_alpha_weight100 := MAP (le.sec_range_alpha_isnull => 0, patch_default and ri.field_specificity=0 => s.sec_range_alpha_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j17,s.nulls_sec_range_alpha,Specificities(ih).sec_range_alpha_values_persisted,sec_range_alpha,sec_range_alpha_weight100,add_sec_range_alpha,j16);
layout_candidates add_prim_range_alpha(layout_candidates le,Specificities(ih).prim_range_alpha_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_alpha_weight100 := MAP (le.prim_range_alpha_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_alpha_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j16,s.nulls_prim_range_alpha,Specificities(ih).prim_range_alpha_values_persisted,prim_range_alpha,prim_range_alpha_weight100,add_prim_range_alpha,j15);
layout_candidates add_recorder_page_number(layout_candidates le,Specificities(ih).recorder_page_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.recorder_page_number_weight100 := MAP (le.recorder_page_number_isnull => 0, patch_default and ri.field_specificity=0 => s.recorder_page_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j15,s.nulls_recorder_page_number,Specificities(ih).recorder_page_number_values_persisted,recorder_page_number,recorder_page_number_weight100,add_recorder_page_number,j14);
layout_candidates add_document_number(layout_candidates le,Specificities(ih).document_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.document_number_cnt := ri.cnt;
  SELF.document_number_weight100 := MAP (le.document_number_isnull => 0, patch_default and ri.field_specificity=0 => s.document_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j14,s.nulls_document_number,Specificities(ih).document_number_values_persisted,document_number,document_number_weight100,add_document_number,j13);
layout_candidates add_contract_date(layout_candidates le,Specificities(ih).contract_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.contract_date_weight100 := MAP (le.contract_date_isnull => 0, patch_default and ri.field_specificity=0 => s.contract_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j13,s.nulls_contract_date,Specificities(ih).contract_date_values_persisted,contract_date,contract_date_weight100,add_contract_date,j12);
layout_candidates add_recording_date(layout_candidates le,Specificities(ih).recording_date_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.recording_date_weight100 := MAP (le.recording_date_isnull => 0, patch_default and ri.field_specificity=0 => s.recording_date_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j12,s.nulls_recording_date,Specificities(ih).recording_date_values_persisted,recording_date,recording_date_weight100,add_recording_date,j11);
layout_candidates add_locale(layout_candidates le,Specificities(ih).locale_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.locale_weight100 := MAP (le.locale_isnull => 0, patch_default and ri.field_specificity=0 => s.locale_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j11,s.nulls_locale,Specificities(ih).locale_values_persisted,locale,locale_weight100,add_locale,j10);
layout_candidates add_secrange(layout_candidates le,Specificities(ih).secrange_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.secrange_weight100 := MAP (le.secrange_isnull => 0, patch_default and ri.field_specificity=0 => s.secrange_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j10,s.nulls_secrange,Specificities(ih).secrange_values_persisted,secrange,secrange_weight100,add_secrange,j9);
layout_candidates add_primrange(layout_candidates le,Specificities(ih).primrange_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.primrange_weight100 := MAP (le.primrange_isnull => 0, patch_default and ri.field_specificity=0 => s.primrange_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j9,s.nulls_primrange,Specificities(ih).primrange_values_persisted,primrange,primrange_weight100,add_primrange,j8);
layout_candidates add_first_td_loan_amount(layout_candidates le,Specificities(ih).first_td_loan_amount_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.first_td_loan_amount_weight100 := MAP (le.first_td_loan_amount_isnull => 0, patch_default and ri.field_specificity=0 => s.first_td_loan_amount_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j8,s.nulls_first_td_loan_amount,Specificities(ih).first_td_loan_amount_values_persisted,first_td_loan_amount,first_td_loan_amount_weight100,add_first_td_loan_amount,j7);
layout_candidates add_sales_price(layout_candidates le,Specificities(ih).sales_price_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sales_price_weight100 := MAP (le.sales_price_isnull => 0, patch_default and ri.field_specificity=0 => s.sales_price_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j7,s.nulls_sales_price,Specificities(ih).sales_price_values_persisted,sales_price,sales_price_weight100,add_sales_price,j6);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip_cnt := ri.cnt;
  SELF.zip_e1_cnt := ri.e1_cnt;
  SELF.zip_weight100 := MAP (le.zip_isnull => 0, patch_default and ri.field_specificity=0 => s.zip_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j6,s.nulls_zip,Specificities(ih).zip_values_persisted,zip,zip_weight100,add_zip,j5);
layout_candidates add_primname(layout_candidates le,Specificities(ih).primname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.primname_weight100 := MAP (le.primname_isnull => 0, patch_default and ri.field_specificity=0 => s.primname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j5,s.nulls_primname,Specificities(ih).primname_values_persisted,primname,primname_weight100,add_primname,j4);
layout_candidates add_recorder_book_number(layout_candidates le,Specificities(ih).recorder_book_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.recorder_book_number_weight100 := MAP (le.recorder_book_number_isnull => 0, patch_default and ri.field_specificity=0 => s.recorder_book_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j4,s.nulls_recorder_book_number,Specificities(ih).recorder_book_number_values_persisted,recorder_book_number,recorder_book_number_weight100,add_recorder_book_number,j3);
layout_candidates add_address(layout_candidates le,Specificities(ih).address_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.address_weight100 := MAP (le.address_isnull => 0, patch_default and ri.field_specificity=0 => s.address_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j3,s.nulls_address,Specificities(ih).address_values_persisted,address,address_weight100,add_address,j2);
layout_candidates add_apnt_or_pin_number(layout_candidates le,Specificities(ih).apnt_or_pin_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.apnt_or_pin_number_cnt := ri.cnt;
  SELF.apnt_or_pin_number_e1_cnt := ri.e1_cnt;
  SELF.apnt_or_pin_number_weight100 := MAP (le.apnt_or_pin_number_isnull => 0, patch_default and ri.field_specificity=0 => s.apnt_or_pin_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j2,s.nulls_apnt_or_pin_number,Specificities(ih).apnt_or_pin_number_values_persisted,apnt_or_pin_number,apnt_or_pin_number_weight100,add_apnt_or_pin_number,j1);
layout_candidates add_did(layout_candidates le,Specificities(ih).did_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.did_weight100 := MAP (le.did_isnull => 0, patch_default and ri.field_specificity=0 => s.did_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT34.MAC_Choose_JoinType(j1,s.nulls_did,Specificities(ih).did_values_persisted,did,did_weight100,add_did,j0);
//Using HASH(did) to get smoother distribution
SHARED Annotated := DISTRIBUTE(j0,hash(DPROPTXID)) : PERSIST('~temp::DPROPTXID::InsuranceHeader_Property_Transactions_DeedsMortgages::mc',EXPIRE(Config.PersistExpire)); // Distributed for keybuild case
//Now see if these records are actually linkable
TotalWeight := Annotated.did_weight100 + Annotated.apnt_or_pin_number_weight100 + Annotated.address_weight100 + Annotated.recorder_book_number_weight100 + Annotated.sales_price_weight100 + Annotated.first_td_loan_amount_weight100 + Annotated.recording_date_weight100 + Annotated.contract_date_weight100 + Annotated.document_number_weight100 + Annotated.recorder_page_number_weight100 + Annotated.name_weight100 + Annotated.fips_code_weight100 + Annotated.county_name_weight100 + Annotated.lender_name_weight100 + Annotated.SourceType_weight100;
SHARED Linkable := TotalWeight >= Config.MatchThreshold;
EXPORT BuddyCounts := TABLE(Annotated,{ buddies, Cnt := COUNT(GROUP) }, buddies, FEW);
EXPORT HasBuddies := TABLE(Annotated(buddies>0), { rid });
EXPORT Unlinkables := Annotated(~Linkable); // Insufficient data to ever get a match
EXPORT Candidates := Annotated(Linkable); //No point in trying to link records with too little data
END;
