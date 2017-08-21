IMPORT SALT36;
EXPORT hygiene(dataset(layout_property_foreclosures) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT36.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_foreclosure_id_pcnt := AVE(GROUP,IF(h.foreclosure_id = (TYPEOF(h.foreclosure_id))'',0,100));
    maxlength_foreclosure_id := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.foreclosure_id)));
    avelength_foreclosure_id := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.foreclosure_id)),h.foreclosure_id<>(typeof(h.foreclosure_id))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_batch_date_and_seq_nbr_pcnt := AVE(GROUP,IF(h.batch_date_and_seq_nbr = (TYPEOF(h.batch_date_and_seq_nbr))'',0,100));
    maxlength_batch_date_and_seq_nbr := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.batch_date_and_seq_nbr)));
    avelength_batch_date_and_seq_nbr := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.batch_date_and_seq_nbr)),h.batch_date_and_seq_nbr<>(typeof(h.batch_date_and_seq_nbr))'');
    populated_deed_category_pcnt := AVE(GROUP,IF(h.deed_category = (TYPEOF(h.deed_category))'',0,100));
    maxlength_deed_category := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.deed_category)));
    avelength_deed_category := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.deed_category)),h.deed_category<>(typeof(h.deed_category))'');
    populated_document_type_pcnt := AVE(GROUP,IF(h.document_type = (TYPEOF(h.document_type))'',0,100));
    maxlength_document_type := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.document_type)));
    avelength_document_type := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.document_type)),h.document_type<>(typeof(h.document_type))'');
    populated_recording_date_pcnt := AVE(GROUP,IF(h.recording_date = (TYPEOF(h.recording_date))'',0,100));
    maxlength_recording_date := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.recording_date)));
    avelength_recording_date := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.recording_date)),h.recording_date<>(typeof(h.recording_date))'');
    populated_document_year_pcnt := AVE(GROUP,IF(h.document_year = (TYPEOF(h.document_year))'',0,100));
    maxlength_document_year := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.document_year)));
    avelength_document_year := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.document_year)),h.document_year<>(typeof(h.document_year))'');
    populated_document_nbr_pcnt := AVE(GROUP,IF(h.document_nbr = (TYPEOF(h.document_nbr))'',0,100));
    maxlength_document_nbr := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.document_nbr)));
    avelength_document_nbr := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.document_nbr)),h.document_nbr<>(typeof(h.document_nbr))'');
    populated_document_book_pcnt := AVE(GROUP,IF(h.document_book = (TYPEOF(h.document_book))'',0,100));
    maxlength_document_book := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.document_book)));
    avelength_document_book := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.document_book)),h.document_book<>(typeof(h.document_book))'');
    populated_document_pages_pcnt := AVE(GROUP,IF(h.document_pages = (TYPEOF(h.document_pages))'',0,100));
    maxlength_document_pages := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.document_pages)));
    avelength_document_pages := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.document_pages)),h.document_pages<>(typeof(h.document_pages))'');
    populated_title_company_code_pcnt := AVE(GROUP,IF(h.title_company_code = (TYPEOF(h.title_company_code))'',0,100));
    maxlength_title_company_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.title_company_code)));
    avelength_title_company_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.title_company_code)),h.title_company_code<>(typeof(h.title_company_code))'');
    populated_title_company_name_pcnt := AVE(GROUP,IF(h.title_company_name = (TYPEOF(h.title_company_name))'',0,100));
    maxlength_title_company_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.title_company_name)));
    avelength_title_company_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.title_company_name)),h.title_company_name<>(typeof(h.title_company_name))'');
    populated_attorney_name_pcnt := AVE(GROUP,IF(h.attorney_name = (TYPEOF(h.attorney_name))'',0,100));
    maxlength_attorney_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.attorney_name)));
    avelength_attorney_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.attorney_name)),h.attorney_name<>(typeof(h.attorney_name))'');
    populated_attorney_phone_nbr_pcnt := AVE(GROUP,IF(h.attorney_phone_nbr = (TYPEOF(h.attorney_phone_nbr))'',0,100));
    maxlength_attorney_phone_nbr := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.attorney_phone_nbr)));
    avelength_attorney_phone_nbr := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.attorney_phone_nbr)),h.attorney_phone_nbr<>(typeof(h.attorney_phone_nbr))'');
    populated_first_defendant_borrower_owner_first_name_pcnt := AVE(GROUP,IF(h.first_defendant_borrower_owner_first_name = (TYPEOF(h.first_defendant_borrower_owner_first_name))'',0,100));
    maxlength_first_defendant_borrower_owner_first_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.first_defendant_borrower_owner_first_name)));
    avelength_first_defendant_borrower_owner_first_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.first_defendant_borrower_owner_first_name)),h.first_defendant_borrower_owner_first_name<>(typeof(h.first_defendant_borrower_owner_first_name))'');
    populated_first_defendant_borrower_owner_last_name_pcnt := AVE(GROUP,IF(h.first_defendant_borrower_owner_last_name = (TYPEOF(h.first_defendant_borrower_owner_last_name))'',0,100));
    maxlength_first_defendant_borrower_owner_last_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.first_defendant_borrower_owner_last_name)));
    avelength_first_defendant_borrower_owner_last_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.first_defendant_borrower_owner_last_name)),h.first_defendant_borrower_owner_last_name<>(typeof(h.first_defendant_borrower_owner_last_name))'');
    populated_first_defendant_borrower_company_name_pcnt := AVE(GROUP,IF(h.first_defendant_borrower_company_name = (TYPEOF(h.first_defendant_borrower_company_name))'',0,100));
    maxlength_first_defendant_borrower_company_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.first_defendant_borrower_company_name)));
    avelength_first_defendant_borrower_company_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.first_defendant_borrower_company_name)),h.first_defendant_borrower_company_name<>(typeof(h.first_defendant_borrower_company_name))'');
    populated_second_defendant_borrower_owner_first_name_pcnt := AVE(GROUP,IF(h.second_defendant_borrower_owner_first_name = (TYPEOF(h.second_defendant_borrower_owner_first_name))'',0,100));
    maxlength_second_defendant_borrower_owner_first_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.second_defendant_borrower_owner_first_name)));
    avelength_second_defendant_borrower_owner_first_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.second_defendant_borrower_owner_first_name)),h.second_defendant_borrower_owner_first_name<>(typeof(h.second_defendant_borrower_owner_first_name))'');
    populated_second_defendant_borrower_owner_last_name_pcnt := AVE(GROUP,IF(h.second_defendant_borrower_owner_last_name = (TYPEOF(h.second_defendant_borrower_owner_last_name))'',0,100));
    maxlength_second_defendant_borrower_owner_last_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.second_defendant_borrower_owner_last_name)));
    avelength_second_defendant_borrower_owner_last_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.second_defendant_borrower_owner_last_name)),h.second_defendant_borrower_owner_last_name<>(typeof(h.second_defendant_borrower_owner_last_name))'');
    populated_second_defendant_borrower_company_name_pcnt := AVE(GROUP,IF(h.second_defendant_borrower_company_name = (TYPEOF(h.second_defendant_borrower_company_name))'',0,100));
    maxlength_second_defendant_borrower_company_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.second_defendant_borrower_company_name)));
    avelength_second_defendant_borrower_company_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.second_defendant_borrower_company_name)),h.second_defendant_borrower_company_name<>(typeof(h.second_defendant_borrower_company_name))'');
    populated_third_defendant_borrower_owner_first_name_pcnt := AVE(GROUP,IF(h.third_defendant_borrower_owner_first_name = (TYPEOF(h.third_defendant_borrower_owner_first_name))'',0,100));
    maxlength_third_defendant_borrower_owner_first_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.third_defendant_borrower_owner_first_name)));
    avelength_third_defendant_borrower_owner_first_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.third_defendant_borrower_owner_first_name)),h.third_defendant_borrower_owner_first_name<>(typeof(h.third_defendant_borrower_owner_first_name))'');
    populated_third_defendant_borrower_owner_last_name_pcnt := AVE(GROUP,IF(h.third_defendant_borrower_owner_last_name = (TYPEOF(h.third_defendant_borrower_owner_last_name))'',0,100));
    maxlength_third_defendant_borrower_owner_last_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.third_defendant_borrower_owner_last_name)));
    avelength_third_defendant_borrower_owner_last_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.third_defendant_borrower_owner_last_name)),h.third_defendant_borrower_owner_last_name<>(typeof(h.third_defendant_borrower_owner_last_name))'');
    populated_third_defendant_borrower_company_name_pcnt := AVE(GROUP,IF(h.third_defendant_borrower_company_name = (TYPEOF(h.third_defendant_borrower_company_name))'',0,100));
    maxlength_third_defendant_borrower_company_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.third_defendant_borrower_company_name)));
    avelength_third_defendant_borrower_company_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.third_defendant_borrower_company_name)),h.third_defendant_borrower_company_name<>(typeof(h.third_defendant_borrower_company_name))'');
    populated_fourth_defendant_borrower_owner_first_name_pcnt := AVE(GROUP,IF(h.fourth_defendant_borrower_owner_first_name = (TYPEOF(h.fourth_defendant_borrower_owner_first_name))'',0,100));
    maxlength_fourth_defendant_borrower_owner_first_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.fourth_defendant_borrower_owner_first_name)));
    avelength_fourth_defendant_borrower_owner_first_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.fourth_defendant_borrower_owner_first_name)),h.fourth_defendant_borrower_owner_first_name<>(typeof(h.fourth_defendant_borrower_owner_first_name))'');
    populated_fourth_defendant_borrower_owner_last_name_pcnt := AVE(GROUP,IF(h.fourth_defendant_borrower_owner_last_name = (TYPEOF(h.fourth_defendant_borrower_owner_last_name))'',0,100));
    maxlength_fourth_defendant_borrower_owner_last_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.fourth_defendant_borrower_owner_last_name)));
    avelength_fourth_defendant_borrower_owner_last_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.fourth_defendant_borrower_owner_last_name)),h.fourth_defendant_borrower_owner_last_name<>(typeof(h.fourth_defendant_borrower_owner_last_name))'');
    populated_fourth_defendant_borrower_company_name_pcnt := AVE(GROUP,IF(h.fourth_defendant_borrower_company_name = (TYPEOF(h.fourth_defendant_borrower_company_name))'',0,100));
    maxlength_fourth_defendant_borrower_company_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.fourth_defendant_borrower_company_name)));
    avelength_fourth_defendant_borrower_company_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.fourth_defendant_borrower_company_name)),h.fourth_defendant_borrower_company_name<>(typeof(h.fourth_defendant_borrower_company_name))'');
    populated_defendant_borrower_owner_et_al_indicator_pcnt := AVE(GROUP,IF(h.defendant_borrower_owner_et_al_indicator = (TYPEOF(h.defendant_borrower_owner_et_al_indicator))'',0,100));
    maxlength_defendant_borrower_owner_et_al_indicator := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.defendant_borrower_owner_et_al_indicator)));
    avelength_defendant_borrower_owner_et_al_indicator := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.defendant_borrower_owner_et_al_indicator)),h.defendant_borrower_owner_et_al_indicator<>(typeof(h.defendant_borrower_owner_et_al_indicator))'');
    populated_filler1_pcnt := AVE(GROUP,IF(h.filler1 = (TYPEOF(h.filler1))'',0,100));
    maxlength_filler1 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.filler1)));
    avelength_filler1 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.filler1)),h.filler1<>(typeof(h.filler1))'');
    populated_date_of_default_pcnt := AVE(GROUP,IF(h.date_of_default = (TYPEOF(h.date_of_default))'',0,100));
    maxlength_date_of_default := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.date_of_default)));
    avelength_date_of_default := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.date_of_default)),h.date_of_default<>(typeof(h.date_of_default))'');
    populated_amount_of_default_pcnt := AVE(GROUP,IF(h.amount_of_default = (TYPEOF(h.amount_of_default))'',0,100));
    maxlength_amount_of_default := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.amount_of_default)));
    avelength_amount_of_default := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.amount_of_default)),h.amount_of_default<>(typeof(h.amount_of_default))'');
    populated_filler2_pcnt := AVE(GROUP,IF(h.filler2 = (TYPEOF(h.filler2))'',0,100));
    maxlength_filler2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.filler2)));
    avelength_filler2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.filler2)),h.filler2<>(typeof(h.filler2))'');
    populated_filing_date_pcnt := AVE(GROUP,IF(h.filing_date = (TYPEOF(h.filing_date))'',0,100));
    maxlength_filing_date := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.filing_date)));
    avelength_filing_date := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.filing_date)),h.filing_date<>(typeof(h.filing_date))'');
    populated_court_case_nbr_pcnt := AVE(GROUP,IF(h.court_case_nbr = (TYPEOF(h.court_case_nbr))'',0,100));
    maxlength_court_case_nbr := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.court_case_nbr)));
    avelength_court_case_nbr := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.court_case_nbr)),h.court_case_nbr<>(typeof(h.court_case_nbr))'');
    populated_lis_pendens_type_pcnt := AVE(GROUP,IF(h.lis_pendens_type = (TYPEOF(h.lis_pendens_type))'',0,100));
    maxlength_lis_pendens_type := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.lis_pendens_type)));
    avelength_lis_pendens_type := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.lis_pendens_type)),h.lis_pendens_type<>(typeof(h.lis_pendens_type))'');
    populated_plaintiff_1_pcnt := AVE(GROUP,IF(h.plaintiff_1 = (TYPEOF(h.plaintiff_1))'',0,100));
    maxlength_plaintiff_1 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.plaintiff_1)));
    avelength_plaintiff_1 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.plaintiff_1)),h.plaintiff_1<>(typeof(h.plaintiff_1))'');
    populated_plaintiff_2_pcnt := AVE(GROUP,IF(h.plaintiff_2 = (TYPEOF(h.plaintiff_2))'',0,100));
    maxlength_plaintiff_2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.plaintiff_2)));
    avelength_plaintiff_2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.plaintiff_2)),h.plaintiff_2<>(typeof(h.plaintiff_2))'');
    populated_final_judgment_amount_pcnt := AVE(GROUP,IF(h.final_judgment_amount = (TYPEOF(h.final_judgment_amount))'',0,100));
    maxlength_final_judgment_amount := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.final_judgment_amount)));
    avelength_final_judgment_amount := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.final_judgment_amount)),h.final_judgment_amount<>(typeof(h.final_judgment_amount))'');
    populated_filler_3_pcnt := AVE(GROUP,IF(h.filler_3 = (TYPEOF(h.filler_3))'',0,100));
    maxlength_filler_3 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.filler_3)));
    avelength_filler_3 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.filler_3)),h.filler_3<>(typeof(h.filler_3))'');
    populated_auction_date_pcnt := AVE(GROUP,IF(h.auction_date = (TYPEOF(h.auction_date))'',0,100));
    maxlength_auction_date := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.auction_date)));
    avelength_auction_date := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.auction_date)),h.auction_date<>(typeof(h.auction_date))'');
    populated_auction_time_pcnt := AVE(GROUP,IF(h.auction_time = (TYPEOF(h.auction_time))'',0,100));
    maxlength_auction_time := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.auction_time)));
    avelength_auction_time := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.auction_time)),h.auction_time<>(typeof(h.auction_time))'');
    populated_street_address_of_auction_call_pcnt := AVE(GROUP,IF(h.street_address_of_auction_call = (TYPEOF(h.street_address_of_auction_call))'',0,100));
    maxlength_street_address_of_auction_call := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.street_address_of_auction_call)));
    avelength_street_address_of_auction_call := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.street_address_of_auction_call)),h.street_address_of_auction_call<>(typeof(h.street_address_of_auction_call))'');
    populated_city_of_auction_call_pcnt := AVE(GROUP,IF(h.city_of_auction_call = (TYPEOF(h.city_of_auction_call))'',0,100));
    maxlength_city_of_auction_call := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.city_of_auction_call)));
    avelength_city_of_auction_call := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.city_of_auction_call)),h.city_of_auction_call<>(typeof(h.city_of_auction_call))'');
    populated_state_of_auction_call_pcnt := AVE(GROUP,IF(h.state_of_auction_call = (TYPEOF(h.state_of_auction_call))'',0,100));
    maxlength_state_of_auction_call := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.state_of_auction_call)));
    avelength_state_of_auction_call := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.state_of_auction_call)),h.state_of_auction_call<>(typeof(h.state_of_auction_call))'');
    populated_opening_bid_pcnt := AVE(GROUP,IF(h.opening_bid = (TYPEOF(h.opening_bid))'',0,100));
    maxlength_opening_bid := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.opening_bid)));
    avelength_opening_bid := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.opening_bid)),h.opening_bid<>(typeof(h.opening_bid))'');
    populated_tax_year_pcnt := AVE(GROUP,IF(h.tax_year = (TYPEOF(h.tax_year))'',0,100));
    maxlength_tax_year := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.tax_year)));
    avelength_tax_year := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.tax_year)),h.tax_year<>(typeof(h.tax_year))'');
    populated_filler4_pcnt := AVE(GROUP,IF(h.filler4 = (TYPEOF(h.filler4))'',0,100));
    maxlength_filler4 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.filler4)));
    avelength_filler4 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.filler4)),h.filler4<>(typeof(h.filler4))'');
    populated_sales_price_pcnt := AVE(GROUP,IF(h.sales_price = (TYPEOF(h.sales_price))'',0,100));
    maxlength_sales_price := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.sales_price)));
    avelength_sales_price := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.sales_price)),h.sales_price<>(typeof(h.sales_price))'');
    populated_situs_address_indicator_1_pcnt := AVE(GROUP,IF(h.situs_address_indicator_1 = (TYPEOF(h.situs_address_indicator_1))'',0,100));
    maxlength_situs_address_indicator_1 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_address_indicator_1)));
    avelength_situs_address_indicator_1 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_address_indicator_1)),h.situs_address_indicator_1<>(typeof(h.situs_address_indicator_1))'');
    populated_situs_house_number_prefix_1_pcnt := AVE(GROUP,IF(h.situs_house_number_prefix_1 = (TYPEOF(h.situs_house_number_prefix_1))'',0,100));
    maxlength_situs_house_number_prefix_1 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_house_number_prefix_1)));
    avelength_situs_house_number_prefix_1 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_house_number_prefix_1)),h.situs_house_number_prefix_1<>(typeof(h.situs_house_number_prefix_1))'');
    populated_situs_house_number_1_pcnt := AVE(GROUP,IF(h.situs_house_number_1 = (TYPEOF(h.situs_house_number_1))'',0,100));
    maxlength_situs_house_number_1 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_house_number_1)));
    avelength_situs_house_number_1 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_house_number_1)),h.situs_house_number_1<>(typeof(h.situs_house_number_1))'');
    populated_situs_house_number_suffix_1_pcnt := AVE(GROUP,IF(h.situs_house_number_suffix_1 = (TYPEOF(h.situs_house_number_suffix_1))'',0,100));
    maxlength_situs_house_number_suffix_1 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_house_number_suffix_1)));
    avelength_situs_house_number_suffix_1 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_house_number_suffix_1)),h.situs_house_number_suffix_1<>(typeof(h.situs_house_number_suffix_1))'');
    populated_situs_street_name_1_pcnt := AVE(GROUP,IF(h.situs_street_name_1 = (TYPEOF(h.situs_street_name_1))'',0,100));
    maxlength_situs_street_name_1 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_street_name_1)));
    avelength_situs_street_name_1 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_street_name_1)),h.situs_street_name_1<>(typeof(h.situs_street_name_1))'');
    populated_situs_mode_1_pcnt := AVE(GROUP,IF(h.situs_mode_1 = (TYPEOF(h.situs_mode_1))'',0,100));
    maxlength_situs_mode_1 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_mode_1)));
    avelength_situs_mode_1 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_mode_1)),h.situs_mode_1<>(typeof(h.situs_mode_1))'');
    populated_situs_direction_1_pcnt := AVE(GROUP,IF(h.situs_direction_1 = (TYPEOF(h.situs_direction_1))'',0,100));
    maxlength_situs_direction_1 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_direction_1)));
    avelength_situs_direction_1 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_direction_1)),h.situs_direction_1<>(typeof(h.situs_direction_1))'');
    populated_situs_quadrant_1_pcnt := AVE(GROUP,IF(h.situs_quadrant_1 = (TYPEOF(h.situs_quadrant_1))'',0,100));
    maxlength_situs_quadrant_1 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_quadrant_1)));
    avelength_situs_quadrant_1 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_quadrant_1)),h.situs_quadrant_1<>(typeof(h.situs_quadrant_1))'');
    populated_apartment_unit_pcnt := AVE(GROUP,IF(h.apartment_unit = (TYPEOF(h.apartment_unit))'',0,100));
    maxlength_apartment_unit := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.apartment_unit)));
    avelength_apartment_unit := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.apartment_unit)),h.apartment_unit<>(typeof(h.apartment_unit))'');
    populated_property_city_1_pcnt := AVE(GROUP,IF(h.property_city_1 = (TYPEOF(h.property_city_1))'',0,100));
    maxlength_property_city_1 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.property_city_1)));
    avelength_property_city_1 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.property_city_1)),h.property_city_1<>(typeof(h.property_city_1))'');
    populated_property_state_1_pcnt := AVE(GROUP,IF(h.property_state_1 = (TYPEOF(h.property_state_1))'',0,100));
    maxlength_property_state_1 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.property_state_1)));
    avelength_property_state_1 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.property_state_1)),h.property_state_1<>(typeof(h.property_state_1))'');
    populated_property_address_zip_code_1_pcnt := AVE(GROUP,IF(h.property_address_zip_code_1 = (TYPEOF(h.property_address_zip_code_1))'',0,100));
    maxlength_property_address_zip_code_1 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.property_address_zip_code_1)));
    avelength_property_address_zip_code_1 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.property_address_zip_code_1)),h.property_address_zip_code_1<>(typeof(h.property_address_zip_code_1))'');
    populated_carrier_code_pcnt := AVE(GROUP,IF(h.carrier_code = (TYPEOF(h.carrier_code))'',0,100));
    maxlength_carrier_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.carrier_code)));
    avelength_carrier_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.carrier_code)),h.carrier_code<>(typeof(h.carrier_code))'');
    populated_full_site_address_unparsed_1_pcnt := AVE(GROUP,IF(h.full_site_address_unparsed_1 = (TYPEOF(h.full_site_address_unparsed_1))'',0,100));
    maxlength_full_site_address_unparsed_1 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.full_site_address_unparsed_1)));
    avelength_full_site_address_unparsed_1 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.full_site_address_unparsed_1)),h.full_site_address_unparsed_1<>(typeof(h.full_site_address_unparsed_1))'');
    populated_lender_beneficiary_first_name_pcnt := AVE(GROUP,IF(h.lender_beneficiary_first_name = (TYPEOF(h.lender_beneficiary_first_name))'',0,100));
    maxlength_lender_beneficiary_first_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.lender_beneficiary_first_name)));
    avelength_lender_beneficiary_first_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.lender_beneficiary_first_name)),h.lender_beneficiary_first_name<>(typeof(h.lender_beneficiary_first_name))'');
    populated_lender_beneficiary_last_name_pcnt := AVE(GROUP,IF(h.lender_beneficiary_last_name = (TYPEOF(h.lender_beneficiary_last_name))'',0,100));
    maxlength_lender_beneficiary_last_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.lender_beneficiary_last_name)));
    avelength_lender_beneficiary_last_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.lender_beneficiary_last_name)),h.lender_beneficiary_last_name<>(typeof(h.lender_beneficiary_last_name))'');
    populated_lender_beneficiary_company_name_pcnt := AVE(GROUP,IF(h.lender_beneficiary_company_name = (TYPEOF(h.lender_beneficiary_company_name))'',0,100));
    maxlength_lender_beneficiary_company_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.lender_beneficiary_company_name)));
    avelength_lender_beneficiary_company_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.lender_beneficiary_company_name)),h.lender_beneficiary_company_name<>(typeof(h.lender_beneficiary_company_name))'');
    populated_lender_beneficiary_mailing_address_pcnt := AVE(GROUP,IF(h.lender_beneficiary_mailing_address = (TYPEOF(h.lender_beneficiary_mailing_address))'',0,100));
    maxlength_lender_beneficiary_mailing_address := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.lender_beneficiary_mailing_address)));
    avelength_lender_beneficiary_mailing_address := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.lender_beneficiary_mailing_address)),h.lender_beneficiary_mailing_address<>(typeof(h.lender_beneficiary_mailing_address))'');
    populated_lender_beneficiary_city_pcnt := AVE(GROUP,IF(h.lender_beneficiary_city = (TYPEOF(h.lender_beneficiary_city))'',0,100));
    maxlength_lender_beneficiary_city := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.lender_beneficiary_city)));
    avelength_lender_beneficiary_city := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.lender_beneficiary_city)),h.lender_beneficiary_city<>(typeof(h.lender_beneficiary_city))'');
    populated_lender_beneficiary_state_pcnt := AVE(GROUP,IF(h.lender_beneficiary_state = (TYPEOF(h.lender_beneficiary_state))'',0,100));
    maxlength_lender_beneficiary_state := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.lender_beneficiary_state)));
    avelength_lender_beneficiary_state := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.lender_beneficiary_state)),h.lender_beneficiary_state<>(typeof(h.lender_beneficiary_state))'');
    populated_lender_beneficiary_zip_pcnt := AVE(GROUP,IF(h.lender_beneficiary_zip = (TYPEOF(h.lender_beneficiary_zip))'',0,100));
    maxlength_lender_beneficiary_zip := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.lender_beneficiary_zip)));
    avelength_lender_beneficiary_zip := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.lender_beneficiary_zip)),h.lender_beneficiary_zip<>(typeof(h.lender_beneficiary_zip))'');
    populated_lender_phone_pcnt := AVE(GROUP,IF(h.lender_phone = (TYPEOF(h.lender_phone))'',0,100));
    maxlength_lender_phone := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.lender_phone)));
    avelength_lender_phone := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.lender_phone)),h.lender_phone<>(typeof(h.lender_phone))'');
    populated_filler_5_pcnt := AVE(GROUP,IF(h.filler_5 = (TYPEOF(h.filler_5))'',0,100));
    maxlength_filler_5 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.filler_5)));
    avelength_filler_5 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.filler_5)),h.filler_5<>(typeof(h.filler_5))'');
    populated_trustee_name_pcnt := AVE(GROUP,IF(h.trustee_name = (TYPEOF(h.trustee_name))'',0,100));
    maxlength_trustee_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.trustee_name)));
    avelength_trustee_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.trustee_name)),h.trustee_name<>(typeof(h.trustee_name))'');
    populated_trustee_mailing_address_pcnt := AVE(GROUP,IF(h.trustee_mailing_address = (TYPEOF(h.trustee_mailing_address))'',0,100));
    maxlength_trustee_mailing_address := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.trustee_mailing_address)));
    avelength_trustee_mailing_address := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.trustee_mailing_address)),h.trustee_mailing_address<>(typeof(h.trustee_mailing_address))'');
    populated_trustee_city_pcnt := AVE(GROUP,IF(h.trustee_city = (TYPEOF(h.trustee_city))'',0,100));
    maxlength_trustee_city := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.trustee_city)));
    avelength_trustee_city := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.trustee_city)),h.trustee_city<>(typeof(h.trustee_city))'');
    populated_trustee_state_pcnt := AVE(GROUP,IF(h.trustee_state = (TYPEOF(h.trustee_state))'',0,100));
    maxlength_trustee_state := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.trustee_state)));
    avelength_trustee_state := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.trustee_state)),h.trustee_state<>(typeof(h.trustee_state))'');
    populated_trustee_zip_pcnt := AVE(GROUP,IF(h.trustee_zip = (TYPEOF(h.trustee_zip))'',0,100));
    maxlength_trustee_zip := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.trustee_zip)));
    avelength_trustee_zip := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.trustee_zip)),h.trustee_zip<>(typeof(h.trustee_zip))'');
    populated_trustee_phone_pcnt := AVE(GROUP,IF(h.trustee_phone = (TYPEOF(h.trustee_phone))'',0,100));
    maxlength_trustee_phone := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.trustee_phone)));
    avelength_trustee_phone := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.trustee_phone)),h.trustee_phone<>(typeof(h.trustee_phone))'');
    populated_trustee_sale_number_pcnt := AVE(GROUP,IF(h.trustee_sale_number = (TYPEOF(h.trustee_sale_number))'',0,100));
    maxlength_trustee_sale_number := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.trustee_sale_number)));
    avelength_trustee_sale_number := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.trustee_sale_number)),h.trustee_sale_number<>(typeof(h.trustee_sale_number))'');
    populated_filler_6_pcnt := AVE(GROUP,IF(h.filler_6 = (TYPEOF(h.filler_6))'',0,100));
    maxlength_filler_6 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.filler_6)));
    avelength_filler_6 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.filler_6)),h.filler_6<>(typeof(h.filler_6))'');
    populated_original_loan_date_pcnt := AVE(GROUP,IF(h.original_loan_date = (TYPEOF(h.original_loan_date))'',0,100));
    maxlength_original_loan_date := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.original_loan_date)));
    avelength_original_loan_date := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.original_loan_date)),h.original_loan_date<>(typeof(h.original_loan_date))'');
    populated_original_loan_recording_date_pcnt := AVE(GROUP,IF(h.original_loan_recording_date = (TYPEOF(h.original_loan_recording_date))'',0,100));
    maxlength_original_loan_recording_date := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.original_loan_recording_date)));
    avelength_original_loan_recording_date := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.original_loan_recording_date)),h.original_loan_recording_date<>(typeof(h.original_loan_recording_date))'');
    populated_original_loan_amount_pcnt := AVE(GROUP,IF(h.original_loan_amount = (TYPEOF(h.original_loan_amount))'',0,100));
    maxlength_original_loan_amount := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.original_loan_amount)));
    avelength_original_loan_amount := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.original_loan_amount)),h.original_loan_amount<>(typeof(h.original_loan_amount))'');
    populated_original_document_number_pcnt := AVE(GROUP,IF(h.original_document_number = (TYPEOF(h.original_document_number))'',0,100));
    maxlength_original_document_number := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.original_document_number)));
    avelength_original_document_number := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.original_document_number)),h.original_document_number<>(typeof(h.original_document_number))'');
    populated_original_recording_book_pcnt := AVE(GROUP,IF(h.original_recording_book = (TYPEOF(h.original_recording_book))'',0,100));
    maxlength_original_recording_book := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.original_recording_book)));
    avelength_original_recording_book := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.original_recording_book)),h.original_recording_book<>(typeof(h.original_recording_book))'');
    populated_original_recording_page_pcnt := AVE(GROUP,IF(h.original_recording_page = (TYPEOF(h.original_recording_page))'',0,100));
    maxlength_original_recording_page := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.original_recording_page)));
    avelength_original_recording_page := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.original_recording_page)),h.original_recording_page<>(typeof(h.original_recording_page))'');
    populated_filler_7_pcnt := AVE(GROUP,IF(h.filler_7 = (TYPEOF(h.filler_7))'',0,100));
    maxlength_filler_7 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.filler_7)));
    avelength_filler_7 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.filler_7)),h.filler_7<>(typeof(h.filler_7))'');
    populated_parcel_number_parcel_id_pcnt := AVE(GROUP,IF(h.parcel_number_parcel_id = (TYPEOF(h.parcel_number_parcel_id))'',0,100));
    maxlength_parcel_number_parcel_id := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.parcel_number_parcel_id)));
    avelength_parcel_number_parcel_id := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.parcel_number_parcel_id)),h.parcel_number_parcel_id<>(typeof(h.parcel_number_parcel_id))'');
    populated_parcel_number_unmatched_id_pcnt := AVE(GROUP,IF(h.parcel_number_unmatched_id = (TYPEOF(h.parcel_number_unmatched_id))'',0,100));
    maxlength_parcel_number_unmatched_id := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.parcel_number_unmatched_id)));
    avelength_parcel_number_unmatched_id := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.parcel_number_unmatched_id)),h.parcel_number_unmatched_id<>(typeof(h.parcel_number_unmatched_id))'');
    populated_last_full_sale_transfer_date_pcnt := AVE(GROUP,IF(h.last_full_sale_transfer_date = (TYPEOF(h.last_full_sale_transfer_date))'',0,100));
    maxlength_last_full_sale_transfer_date := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.last_full_sale_transfer_date)));
    avelength_last_full_sale_transfer_date := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.last_full_sale_transfer_date)),h.last_full_sale_transfer_date<>(typeof(h.last_full_sale_transfer_date))'');
    populated_transfer_value_pcnt := AVE(GROUP,IF(h.transfer_value = (TYPEOF(h.transfer_value))'',0,100));
    maxlength_transfer_value := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.transfer_value)));
    avelength_transfer_value := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.transfer_value)),h.transfer_value<>(typeof(h.transfer_value))'');
    populated_situs_address_indicator_2_pcnt := AVE(GROUP,IF(h.situs_address_indicator_2 = (TYPEOF(h.situs_address_indicator_2))'',0,100));
    maxlength_situs_address_indicator_2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_address_indicator_2)));
    avelength_situs_address_indicator_2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_address_indicator_2)),h.situs_address_indicator_2<>(typeof(h.situs_address_indicator_2))'');
    populated_situs_house_number_prefix_2_pcnt := AVE(GROUP,IF(h.situs_house_number_prefix_2 = (TYPEOF(h.situs_house_number_prefix_2))'',0,100));
    maxlength_situs_house_number_prefix_2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_house_number_prefix_2)));
    avelength_situs_house_number_prefix_2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_house_number_prefix_2)),h.situs_house_number_prefix_2<>(typeof(h.situs_house_number_prefix_2))'');
    populated_situs_house_number_2_pcnt := AVE(GROUP,IF(h.situs_house_number_2 = (TYPEOF(h.situs_house_number_2))'',0,100));
    maxlength_situs_house_number_2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_house_number_2)));
    avelength_situs_house_number_2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_house_number_2)),h.situs_house_number_2<>(typeof(h.situs_house_number_2))'');
    populated_situs_house_number_suffix_2_pcnt := AVE(GROUP,IF(h.situs_house_number_suffix_2 = (TYPEOF(h.situs_house_number_suffix_2))'',0,100));
    maxlength_situs_house_number_suffix_2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_house_number_suffix_2)));
    avelength_situs_house_number_suffix_2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_house_number_suffix_2)),h.situs_house_number_suffix_2<>(typeof(h.situs_house_number_suffix_2))'');
    populated_situs_street_name_2_pcnt := AVE(GROUP,IF(h.situs_street_name_2 = (TYPEOF(h.situs_street_name_2))'',0,100));
    maxlength_situs_street_name_2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_street_name_2)));
    avelength_situs_street_name_2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_street_name_2)),h.situs_street_name_2<>(typeof(h.situs_street_name_2))'');
    populated_situs_mode_2_pcnt := AVE(GROUP,IF(h.situs_mode_2 = (TYPEOF(h.situs_mode_2))'',0,100));
    maxlength_situs_mode_2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_mode_2)));
    avelength_situs_mode_2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_mode_2)),h.situs_mode_2<>(typeof(h.situs_mode_2))'');
    populated_situs_direction_2_pcnt := AVE(GROUP,IF(h.situs_direction_2 = (TYPEOF(h.situs_direction_2))'',0,100));
    maxlength_situs_direction_2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_direction_2)));
    avelength_situs_direction_2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_direction_2)),h.situs_direction_2<>(typeof(h.situs_direction_2))'');
    populated_situs_quadrant_2_pcnt := AVE(GROUP,IF(h.situs_quadrant_2 = (TYPEOF(h.situs_quadrant_2))'',0,100));
    maxlength_situs_quadrant_2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_quadrant_2)));
    avelength_situs_quadrant_2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.situs_quadrant_2)),h.situs_quadrant_2<>(typeof(h.situs_quadrant_2))'');
    populated_apartment_unit_2_pcnt := AVE(GROUP,IF(h.apartment_unit_2 = (TYPEOF(h.apartment_unit_2))'',0,100));
    maxlength_apartment_unit_2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.apartment_unit_2)));
    avelength_apartment_unit_2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.apartment_unit_2)),h.apartment_unit_2<>(typeof(h.apartment_unit_2))'');
    populated_property_city_2_pcnt := AVE(GROUP,IF(h.property_city_2 = (TYPEOF(h.property_city_2))'',0,100));
    maxlength_property_city_2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.property_city_2)));
    avelength_property_city_2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.property_city_2)),h.property_city_2<>(typeof(h.property_city_2))'');
    populated_property_state_2_pcnt := AVE(GROUP,IF(h.property_state_2 = (TYPEOF(h.property_state_2))'',0,100));
    maxlength_property_state_2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.property_state_2)));
    avelength_property_state_2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.property_state_2)),h.property_state_2<>(typeof(h.property_state_2))'');
    populated_property_address_zip_code_2_pcnt := AVE(GROUP,IF(h.property_address_zip_code_2 = (TYPEOF(h.property_address_zip_code_2))'',0,100));
    maxlength_property_address_zip_code_2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.property_address_zip_code_2)));
    avelength_property_address_zip_code_2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.property_address_zip_code_2)),h.property_address_zip_code_2<>(typeof(h.property_address_zip_code_2))'');
    populated_carrier_code_2_pcnt := AVE(GROUP,IF(h.carrier_code_2 = (TYPEOF(h.carrier_code_2))'',0,100));
    maxlength_carrier_code_2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.carrier_code_2)));
    avelength_carrier_code_2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.carrier_code_2)),h.carrier_code_2<>(typeof(h.carrier_code_2))'');
    populated_full_site_address_unparsed_2_pcnt := AVE(GROUP,IF(h.full_site_address_unparsed_2 = (TYPEOF(h.full_site_address_unparsed_2))'',0,100));
    maxlength_full_site_address_unparsed_2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.full_site_address_unparsed_2)));
    avelength_full_site_address_unparsed_2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.full_site_address_unparsed_2)),h.full_site_address_unparsed_2<>(typeof(h.full_site_address_unparsed_2))'');
    populated_property_indicator_pcnt := AVE(GROUP,IF(h.property_indicator = (TYPEOF(h.property_indicator))'',0,100));
    maxlength_property_indicator := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.property_indicator)));
    avelength_property_indicator := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.property_indicator)),h.property_indicator<>(typeof(h.property_indicator))'');
    populated_use_code_pcnt := AVE(GROUP,IF(h.use_code = (TYPEOF(h.use_code))'',0,100));
    maxlength_use_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.use_code)));
    avelength_use_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.use_code)),h.use_code<>(typeof(h.use_code))'');
    populated_number_of_units_pcnt := AVE(GROUP,IF(h.number_of_units = (TYPEOF(h.number_of_units))'',0,100));
    maxlength_number_of_units := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.number_of_units)));
    avelength_number_of_units := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.number_of_units)),h.number_of_units<>(typeof(h.number_of_units))'');
    populated_living_area_square_feet_pcnt := AVE(GROUP,IF(h.living_area_square_feet = (TYPEOF(h.living_area_square_feet))'',0,100));
    maxlength_living_area_square_feet := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.living_area_square_feet)));
    avelength_living_area_square_feet := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.living_area_square_feet)),h.living_area_square_feet<>(typeof(h.living_area_square_feet))'');
    populated_number_of_bedrooms_pcnt := AVE(GROUP,IF(h.number_of_bedrooms = (TYPEOF(h.number_of_bedrooms))'',0,100));
    maxlength_number_of_bedrooms := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.number_of_bedrooms)));
    avelength_number_of_bedrooms := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.number_of_bedrooms)),h.number_of_bedrooms<>(typeof(h.number_of_bedrooms))'');
    populated_number_of_bathrooms_pcnt := AVE(GROUP,IF(h.number_of_bathrooms = (TYPEOF(h.number_of_bathrooms))'',0,100));
    maxlength_number_of_bathrooms := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.number_of_bathrooms)));
    avelength_number_of_bathrooms := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.number_of_bathrooms)),h.number_of_bathrooms<>(typeof(h.number_of_bathrooms))'');
    populated_number_of_garages_pcnt := AVE(GROUP,IF(h.number_of_garages = (TYPEOF(h.number_of_garages))'',0,100));
    maxlength_number_of_garages := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.number_of_garages)));
    avelength_number_of_garages := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.number_of_garages)),h.number_of_garages<>(typeof(h.number_of_garages))'');
    populated_zoning_code_pcnt := AVE(GROUP,IF(h.zoning_code = (TYPEOF(h.zoning_code))'',0,100));
    maxlength_zoning_code := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.zoning_code)));
    avelength_zoning_code := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.zoning_code)),h.zoning_code<>(typeof(h.zoning_code))'');
    populated_lot_size_pcnt := AVE(GROUP,IF(h.lot_size = (TYPEOF(h.lot_size))'',0,100));
    maxlength_lot_size := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.lot_size)));
    avelength_lot_size := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.lot_size)),h.lot_size<>(typeof(h.lot_size))'');
    populated_year_built_pcnt := AVE(GROUP,IF(h.year_built = (TYPEOF(h.year_built))'',0,100));
    maxlength_year_built := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.year_built)));
    avelength_year_built := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.year_built)),h.year_built<>(typeof(h.year_built))'');
    populated_current_land_value_pcnt := AVE(GROUP,IF(h.current_land_value = (TYPEOF(h.current_land_value))'',0,100));
    maxlength_current_land_value := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.current_land_value)));
    avelength_current_land_value := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.current_land_value)),h.current_land_value<>(typeof(h.current_land_value))'');
    populated_current_improvement_value_pcnt := AVE(GROUP,IF(h.current_improvement_value = (TYPEOF(h.current_improvement_value))'',0,100));
    maxlength_current_improvement_value := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.current_improvement_value)));
    avelength_current_improvement_value := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.current_improvement_value)),h.current_improvement_value<>(typeof(h.current_improvement_value))'');
    populated_filler_8_pcnt := AVE(GROUP,IF(h.filler_8 = (TYPEOF(h.filler_8))'',0,100));
    maxlength_filler_8 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.filler_8)));
    avelength_filler_8 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.filler_8)),h.filler_8<>(typeof(h.filler_8))'');
    populated_section_pcnt := AVE(GROUP,IF(h.section = (TYPEOF(h.section))'',0,100));
    maxlength_section := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.section)));
    avelength_section := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.section)),h.section<>(typeof(h.section))'');
    populated_township_pcnt := AVE(GROUP,IF(h.township = (TYPEOF(h.township))'',0,100));
    maxlength_township := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.township)));
    avelength_township := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.township)),h.township<>(typeof(h.township))'');
    populated_range_pcnt := AVE(GROUP,IF(h.range = (TYPEOF(h.range))'',0,100));
    maxlength_range := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.range)));
    avelength_range := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.range)),h.range<>(typeof(h.range))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_block_pcnt := AVE(GROUP,IF(h.block = (TYPEOF(h.block))'',0,100));
    maxlength_block := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.block)));
    avelength_block := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.block)),h.block<>(typeof(h.block))'');
    populated_tract_subdivision_name_pcnt := AVE(GROUP,IF(h.tract_subdivision_name = (TYPEOF(h.tract_subdivision_name))'',0,100));
    maxlength_tract_subdivision_name := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.tract_subdivision_name)));
    avelength_tract_subdivision_name := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.tract_subdivision_name)),h.tract_subdivision_name<>(typeof(h.tract_subdivision_name))'');
    populated_map_book_pcnt := AVE(GROUP,IF(h.map_book = (TYPEOF(h.map_book))'',0,100));
    maxlength_map_book := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.map_book)));
    avelength_map_book := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.map_book)),h.map_book<>(typeof(h.map_book))'');
    populated_map_page_pcnt := AVE(GROUP,IF(h.map_page = (TYPEOF(h.map_page))'',0,100));
    maxlength_map_page := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.map_page)));
    avelength_map_page := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.map_page)),h.map_page<>(typeof(h.map_page))'');
    populated_unit_nbr_pcnt := AVE(GROUP,IF(h.unit_nbr = (TYPEOF(h.unit_nbr))'',0,100));
    maxlength_unit_nbr := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.unit_nbr)));
    avelength_unit_nbr := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.unit_nbr)),h.unit_nbr<>(typeof(h.unit_nbr))'');
    populated_expanded_legal_pcnt := AVE(GROUP,IF(h.expanded_legal = (TYPEOF(h.expanded_legal))'',0,100));
    maxlength_expanded_legal := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.expanded_legal)));
    avelength_expanded_legal := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.expanded_legal)),h.expanded_legal<>(typeof(h.expanded_legal))'');
    populated_legal_2_pcnt := AVE(GROUP,IF(h.legal_2 = (TYPEOF(h.legal_2))'',0,100));
    maxlength_legal_2 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.legal_2)));
    avelength_legal_2 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.legal_2)),h.legal_2<>(typeof(h.legal_2))'');
    populated_legal_3_pcnt := AVE(GROUP,IF(h.legal_3 = (TYPEOF(h.legal_3))'',0,100));
    maxlength_legal_3 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.legal_3)));
    avelength_legal_3 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.legal_3)),h.legal_3<>(typeof(h.legal_3))'');
    populated_legal_4_pcnt := AVE(GROUP,IF(h.legal_4 = (TYPEOF(h.legal_4))'',0,100));
    maxlength_legal_4 := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.legal_4)));
    avelength_legal_4 := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.legal_4)),h.legal_4<>(typeof(h.legal_4))'');
    populated_crlf_pcnt := AVE(GROUP,IF(h.crlf = (TYPEOF(h.crlf))'',0,100));
    maxlength_crlf := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.crlf)));
    avelength_crlf := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.crlf)),h.crlf<>(typeof(h.crlf))'');
    populated_deed_desc_pcnt := AVE(GROUP,IF(h.deed_desc = (TYPEOF(h.deed_desc))'',0,100));
    maxlength_deed_desc := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.deed_desc)));
    avelength_deed_desc := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.deed_desc)),h.deed_desc<>(typeof(h.deed_desc))'');
    populated_document_desc_pcnt := AVE(GROUP,IF(h.document_desc = (TYPEOF(h.document_desc))'',0,100));
    maxlength_document_desc := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.document_desc)));
    avelength_document_desc := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.document_desc)),h.document_desc<>(typeof(h.document_desc))'');
    populated_et_al_desc_pcnt := AVE(GROUP,IF(h.et_al_desc = (TYPEOF(h.et_al_desc))'',0,100));
    maxlength_et_al_desc := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.et_al_desc)));
    avelength_et_al_desc := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.et_al_desc)),h.et_al_desc<>(typeof(h.et_al_desc))'');
    populated_property_desc_pcnt := AVE(GROUP,IF(h.property_desc = (TYPEOF(h.property_desc))'',0,100));
    maxlength_property_desc := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.property_desc)));
    avelength_property_desc := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.property_desc)),h.property_desc<>(typeof(h.property_desc))'');
    populated_use_desc_pcnt := AVE(GROUP,IF(h.use_desc = (TYPEOF(h.use_desc))'',0,100));
    maxlength_use_desc := MAX(GROUP,LENGTH(TRIM((SALT36.StrType)h.use_desc)));
    avelength_use_desc := AVE(GROUP,LENGTH(TRIM((SALT36.StrType)h.use_desc)),h.use_desc<>(typeof(h.use_desc))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_foreclosure_id_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_batch_date_and_seq_nbr_pcnt *   0.00 / 100 + T.Populated_deed_category_pcnt *   0.00 / 100 + T.Populated_document_type_pcnt *   0.00 / 100 + T.Populated_recording_date_pcnt *   0.00 / 100 + T.Populated_document_year_pcnt *   0.00 / 100 + T.Populated_document_nbr_pcnt *   0.00 / 100 + T.Populated_document_book_pcnt *   0.00 / 100 + T.Populated_document_pages_pcnt *   0.00 / 100 + T.Populated_title_company_code_pcnt *   0.00 / 100 + T.Populated_title_company_name_pcnt *   0.00 / 100 + T.Populated_attorney_name_pcnt *   0.00 / 100 + T.Populated_attorney_phone_nbr_pcnt *   0.00 / 100 + T.Populated_first_defendant_borrower_owner_first_name_pcnt *   0.00 / 100 + T.Populated_first_defendant_borrower_owner_last_name_pcnt *   0.00 / 100 + T.Populated_first_defendant_borrower_company_name_pcnt *   0.00 / 100 + T.Populated_second_defendant_borrower_owner_first_name_pcnt *   0.00 / 100 + T.Populated_second_defendant_borrower_owner_last_name_pcnt *   0.00 / 100 + T.Populated_second_defendant_borrower_company_name_pcnt *   0.00 / 100 + T.Populated_third_defendant_borrower_owner_first_name_pcnt *   0.00 / 100 + T.Populated_third_defendant_borrower_owner_last_name_pcnt *   0.00 / 100 + T.Populated_third_defendant_borrower_company_name_pcnt *   0.00 / 100 + T.Populated_fourth_defendant_borrower_owner_first_name_pcnt *   0.00 / 100 + T.Populated_fourth_defendant_borrower_owner_last_name_pcnt *   0.00 / 100 + T.Populated_fourth_defendant_borrower_company_name_pcnt *   0.00 / 100 + T.Populated_defendant_borrower_owner_et_al_indicator_pcnt *   0.00 / 100 + T.Populated_filler1_pcnt *   0.00 / 100 + T.Populated_date_of_default_pcnt *   0.00 / 100 + T.Populated_amount_of_default_pcnt *   0.00 / 100 + T.Populated_filler2_pcnt *   0.00 / 100 + T.Populated_filing_date_pcnt *   0.00 / 100 + T.Populated_court_case_nbr_pcnt *   0.00 / 100 + T.Populated_lis_pendens_type_pcnt *   0.00 / 100 + T.Populated_plaintiff_1_pcnt *   0.00 / 100 + T.Populated_plaintiff_2_pcnt *   0.00 / 100 + T.Populated_final_judgment_amount_pcnt *   0.00 / 100 + T.Populated_filler_3_pcnt *   0.00 / 100 + T.Populated_auction_date_pcnt *   0.00 / 100 + T.Populated_auction_time_pcnt *   0.00 / 100 + T.Populated_street_address_of_auction_call_pcnt *   0.00 / 100 + T.Populated_city_of_auction_call_pcnt *   0.00 / 100 + T.Populated_state_of_auction_call_pcnt *   0.00 / 100 + T.Populated_opening_bid_pcnt *   0.00 / 100 + T.Populated_tax_year_pcnt *   0.00 / 100 + T.Populated_filler4_pcnt *   0.00 / 100 + T.Populated_sales_price_pcnt *   0.00 / 100 + T.Populated_situs_address_indicator_1_pcnt *   0.00 / 100 + T.Populated_situs_house_number_prefix_1_pcnt *   0.00 / 100 + T.Populated_situs_house_number_1_pcnt *   0.00 / 100 + T.Populated_situs_house_number_suffix_1_pcnt *   0.00 / 100 + T.Populated_situs_street_name_1_pcnt *   0.00 / 100 + T.Populated_situs_mode_1_pcnt *   0.00 / 100 + T.Populated_situs_direction_1_pcnt *   0.00 / 100 + T.Populated_situs_quadrant_1_pcnt *   0.00 / 100 + T.Populated_apartment_unit_pcnt *   0.00 / 100 + T.Populated_property_city_1_pcnt *   0.00 / 100 + T.Populated_property_state_1_pcnt *   0.00 / 100 + T.Populated_property_address_zip_code_1_pcnt *   0.00 / 100 + T.Populated_carrier_code_pcnt *   0.00 / 100 + T.Populated_full_site_address_unparsed_1_pcnt *   0.00 / 100 + T.Populated_lender_beneficiary_first_name_pcnt *   0.00 / 100 + T.Populated_lender_beneficiary_last_name_pcnt *   0.00 / 100 + T.Populated_lender_beneficiary_company_name_pcnt *   0.00 / 100 + T.Populated_lender_beneficiary_mailing_address_pcnt *   0.00 / 100 + T.Populated_lender_beneficiary_city_pcnt *   0.00 / 100 + T.Populated_lender_beneficiary_state_pcnt *   0.00 / 100 + T.Populated_lender_beneficiary_zip_pcnt *   0.00 / 100 + T.Populated_lender_phone_pcnt *   0.00 / 100 + T.Populated_filler_5_pcnt *   0.00 / 100 + T.Populated_trustee_name_pcnt *   0.00 / 100 + T.Populated_trustee_mailing_address_pcnt *   0.00 / 100 + T.Populated_trustee_city_pcnt *   0.00 / 100 + T.Populated_trustee_state_pcnt *   0.00 / 100 + T.Populated_trustee_zip_pcnt *   0.00 / 100 + T.Populated_trustee_phone_pcnt *   0.00 / 100 + T.Populated_trustee_sale_number_pcnt *   0.00 / 100 + T.Populated_filler_6_pcnt *   0.00 / 100 + T.Populated_original_loan_date_pcnt *   0.00 / 100 + T.Populated_original_loan_recording_date_pcnt *   0.00 / 100 + T.Populated_original_loan_amount_pcnt *   0.00 / 100 + T.Populated_original_document_number_pcnt *   0.00 / 100 + T.Populated_original_recording_book_pcnt *   0.00 / 100 + T.Populated_original_recording_page_pcnt *   0.00 / 100 + T.Populated_filler_7_pcnt *   0.00 / 100 + T.Populated_parcel_number_parcel_id_pcnt *   0.00 / 100 + T.Populated_parcel_number_unmatched_id_pcnt *   0.00 / 100 + T.Populated_last_full_sale_transfer_date_pcnt *   0.00 / 100 + T.Populated_transfer_value_pcnt *   0.00 / 100 + T.Populated_situs_address_indicator_2_pcnt *   0.00 / 100 + T.Populated_situs_house_number_prefix_2_pcnt *   0.00 / 100 + T.Populated_situs_house_number_2_pcnt *   0.00 / 100 + T.Populated_situs_house_number_suffix_2_pcnt *   0.00 / 100 + T.Populated_situs_street_name_2_pcnt *   0.00 / 100 + T.Populated_situs_mode_2_pcnt *   0.00 / 100 + T.Populated_situs_direction_2_pcnt *   0.00 / 100 + T.Populated_situs_quadrant_2_pcnt *   0.00 / 100 + T.Populated_apartment_unit_2_pcnt *   0.00 / 100 + T.Populated_property_city_2_pcnt *   0.00 / 100 + T.Populated_property_state_2_pcnt *   0.00 / 100 + T.Populated_property_address_zip_code_2_pcnt *   0.00 / 100 + T.Populated_carrier_code_2_pcnt *   0.00 / 100 + T.Populated_full_site_address_unparsed_2_pcnt *   0.00 / 100 + T.Populated_property_indicator_pcnt *   0.00 / 100 + T.Populated_use_code_pcnt *   0.00 / 100 + T.Populated_number_of_units_pcnt *   0.00 / 100 + T.Populated_living_area_square_feet_pcnt *   0.00 / 100 + T.Populated_number_of_bedrooms_pcnt *   0.00 / 100 + T.Populated_number_of_bathrooms_pcnt *   0.00 / 100 + T.Populated_number_of_garages_pcnt *   0.00 / 100 + T.Populated_zoning_code_pcnt *   0.00 / 100 + T.Populated_lot_size_pcnt *   0.00 / 100 + T.Populated_year_built_pcnt *   0.00 / 100 + T.Populated_current_land_value_pcnt *   0.00 / 100 + T.Populated_current_improvement_value_pcnt *   0.00 / 100 + T.Populated_filler_8_pcnt *   0.00 / 100 + T.Populated_section_pcnt *   0.00 / 100 + T.Populated_township_pcnt *   0.00 / 100 + T.Populated_range_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_block_pcnt *   0.00 / 100 + T.Populated_tract_subdivision_name_pcnt *   0.00 / 100 + T.Populated_map_book_pcnt *   0.00 / 100 + T.Populated_map_page_pcnt *   0.00 / 100 + T.Populated_unit_nbr_pcnt *   0.00 / 100 + T.Populated_expanded_legal_pcnt *   0.00 / 100 + T.Populated_legal_2_pcnt *   0.00 / 100 + T.Populated_legal_3_pcnt *   0.00 / 100 + T.Populated_legal_4_pcnt *   0.00 / 100 + T.Populated_crlf_pcnt *   0.00 / 100 + T.Populated_deed_desc_pcnt *   0.00 / 100 + T.Populated_document_desc_pcnt *   0.00 / 100 + T.Populated_et_al_desc_pcnt *   0.00 / 100 + T.Populated_property_desc_pcnt *   0.00 / 100 + T.Populated_use_desc_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT36.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'foreclosure_id','process_date','state','county','batch_date_and_seq_nbr','deed_category','document_type','recording_date','document_year','document_nbr','document_book','document_pages','title_company_code','title_company_name','attorney_name','attorney_phone_nbr','first_defendant_borrower_owner_first_name','first_defendant_borrower_owner_last_name','first_defendant_borrower_company_name','second_defendant_borrower_owner_first_name','second_defendant_borrower_owner_last_name','second_defendant_borrower_company_name','third_defendant_borrower_owner_first_name','third_defendant_borrower_owner_last_name','third_defendant_borrower_company_name','fourth_defendant_borrower_owner_first_name','fourth_defendant_borrower_owner_last_name','fourth_defendant_borrower_company_name','defendant_borrower_owner_et_al_indicator','filler1','date_of_default','amount_of_default','filler2','filing_date','court_case_nbr','lis_pendens_type','plaintiff_1','plaintiff_2','final_judgment_amount','filler_3','auction_date','auction_time','street_address_of_auction_call','city_of_auction_call','state_of_auction_call','opening_bid','tax_year','filler4','sales_price','situs_address_indicator_1','situs_house_number_prefix_1','situs_house_number_1','situs_house_number_suffix_1','situs_street_name_1','situs_mode_1','situs_direction_1','situs_quadrant_1','apartment_unit','property_city_1','property_state_1','property_address_zip_code_1','carrier_code','full_site_address_unparsed_1','lender_beneficiary_first_name','lender_beneficiary_last_name','lender_beneficiary_company_name','lender_beneficiary_mailing_address','lender_beneficiary_city','lender_beneficiary_state','lender_beneficiary_zip','lender_phone','filler_5','trustee_name','trustee_mailing_address','trustee_city','trustee_state','trustee_zip','trustee_phone','trustee_sale_number','filler_6','original_loan_date','original_loan_recording_date','original_loan_amount','original_document_number','original_recording_book','original_recording_page','filler_7','parcel_number_parcel_id','parcel_number_unmatched_id','last_full_sale_transfer_date','transfer_value','situs_address_indicator_2','situs_house_number_prefix_2','situs_house_number_2','situs_house_number_suffix_2','situs_street_name_2','situs_mode_2','situs_direction_2','situs_quadrant_2','apartment_unit_2','property_city_2','property_state_2','property_address_zip_code_2','carrier_code_2','full_site_address_unparsed_2','property_indicator','use_code','number_of_units','living_area_square_feet','number_of_bedrooms','number_of_bathrooms','number_of_garages','zoning_code','lot_size','year_built','current_land_value','current_improvement_value','filler_8','section','township','range','lot','block','tract_subdivision_name','map_book','map_page','unit_nbr','expanded_legal','legal_2','legal_3','legal_4','crlf','deed_desc','document_desc','et_al_desc','property_desc','use_desc');
  SELF.populated_pcnt := CHOOSE(C,le.populated_foreclosure_id_pcnt,le.populated_process_date_pcnt,le.populated_state_pcnt,le.populated_county_pcnt,le.populated_batch_date_and_seq_nbr_pcnt,le.populated_deed_category_pcnt,le.populated_document_type_pcnt,le.populated_recording_date_pcnt,le.populated_document_year_pcnt,le.populated_document_nbr_pcnt,le.populated_document_book_pcnt,le.populated_document_pages_pcnt,le.populated_title_company_code_pcnt,le.populated_title_company_name_pcnt,le.populated_attorney_name_pcnt,le.populated_attorney_phone_nbr_pcnt,le.populated_first_defendant_borrower_owner_first_name_pcnt,le.populated_first_defendant_borrower_owner_last_name_pcnt,le.populated_first_defendant_borrower_company_name_pcnt,le.populated_second_defendant_borrower_owner_first_name_pcnt,le.populated_second_defendant_borrower_owner_last_name_pcnt,le.populated_second_defendant_borrower_company_name_pcnt,le.populated_third_defendant_borrower_owner_first_name_pcnt,le.populated_third_defendant_borrower_owner_last_name_pcnt,le.populated_third_defendant_borrower_company_name_pcnt,le.populated_fourth_defendant_borrower_owner_first_name_pcnt,le.populated_fourth_defendant_borrower_owner_last_name_pcnt,le.populated_fourth_defendant_borrower_company_name_pcnt,le.populated_defendant_borrower_owner_et_al_indicator_pcnt,le.populated_filler1_pcnt,le.populated_date_of_default_pcnt,le.populated_amount_of_default_pcnt,le.populated_filler2_pcnt,le.populated_filing_date_pcnt,le.populated_court_case_nbr_pcnt,le.populated_lis_pendens_type_pcnt,le.populated_plaintiff_1_pcnt,le.populated_plaintiff_2_pcnt,le.populated_final_judgment_amount_pcnt,le.populated_filler_3_pcnt,le.populated_auction_date_pcnt,le.populated_auction_time_pcnt,le.populated_street_address_of_auction_call_pcnt,le.populated_city_of_auction_call_pcnt,le.populated_state_of_auction_call_pcnt,le.populated_opening_bid_pcnt,le.populated_tax_year_pcnt,le.populated_filler4_pcnt,le.populated_sales_price_pcnt,le.populated_situs_address_indicator_1_pcnt,le.populated_situs_house_number_prefix_1_pcnt,le.populated_situs_house_number_1_pcnt,le.populated_situs_house_number_suffix_1_pcnt,le.populated_situs_street_name_1_pcnt,le.populated_situs_mode_1_pcnt,le.populated_situs_direction_1_pcnt,le.populated_situs_quadrant_1_pcnt,le.populated_apartment_unit_pcnt,le.populated_property_city_1_pcnt,le.populated_property_state_1_pcnt,le.populated_property_address_zip_code_1_pcnt,le.populated_carrier_code_pcnt,le.populated_full_site_address_unparsed_1_pcnt,le.populated_lender_beneficiary_first_name_pcnt,le.populated_lender_beneficiary_last_name_pcnt,le.populated_lender_beneficiary_company_name_pcnt,le.populated_lender_beneficiary_mailing_address_pcnt,le.populated_lender_beneficiary_city_pcnt,le.populated_lender_beneficiary_state_pcnt,le.populated_lender_beneficiary_zip_pcnt,le.populated_lender_phone_pcnt,le.populated_filler_5_pcnt,le.populated_trustee_name_pcnt,le.populated_trustee_mailing_address_pcnt,le.populated_trustee_city_pcnt,le.populated_trustee_state_pcnt,le.populated_trustee_zip_pcnt,le.populated_trustee_phone_pcnt,le.populated_trustee_sale_number_pcnt,le.populated_filler_6_pcnt,le.populated_original_loan_date_pcnt,le.populated_original_loan_recording_date_pcnt,le.populated_original_loan_amount_pcnt,le.populated_original_document_number_pcnt,le.populated_original_recording_book_pcnt,le.populated_original_recording_page_pcnt,le.populated_filler_7_pcnt,le.populated_parcel_number_parcel_id_pcnt,le.populated_parcel_number_unmatched_id_pcnt,le.populated_last_full_sale_transfer_date_pcnt,le.populated_transfer_value_pcnt,le.populated_situs_address_indicator_2_pcnt,le.populated_situs_house_number_prefix_2_pcnt,le.populated_situs_house_number_2_pcnt,le.populated_situs_house_number_suffix_2_pcnt,le.populated_situs_street_name_2_pcnt,le.populated_situs_mode_2_pcnt,le.populated_situs_direction_2_pcnt,le.populated_situs_quadrant_2_pcnt,le.populated_apartment_unit_2_pcnt,le.populated_property_city_2_pcnt,le.populated_property_state_2_pcnt,le.populated_property_address_zip_code_2_pcnt,le.populated_carrier_code_2_pcnt,le.populated_full_site_address_unparsed_2_pcnt,le.populated_property_indicator_pcnt,le.populated_use_code_pcnt,le.populated_number_of_units_pcnt,le.populated_living_area_square_feet_pcnt,le.populated_number_of_bedrooms_pcnt,le.populated_number_of_bathrooms_pcnt,le.populated_number_of_garages_pcnt,le.populated_zoning_code_pcnt,le.populated_lot_size_pcnt,le.populated_year_built_pcnt,le.populated_current_land_value_pcnt,le.populated_current_improvement_value_pcnt,le.populated_filler_8_pcnt,le.populated_section_pcnt,le.populated_township_pcnt,le.populated_range_pcnt,le.populated_lot_pcnt,le.populated_block_pcnt,le.populated_tract_subdivision_name_pcnt,le.populated_map_book_pcnt,le.populated_map_page_pcnt,le.populated_unit_nbr_pcnt,le.populated_expanded_legal_pcnt,le.populated_legal_2_pcnt,le.populated_legal_3_pcnt,le.populated_legal_4_pcnt,le.populated_crlf_pcnt,le.populated_deed_desc_pcnt,le.populated_document_desc_pcnt,le.populated_et_al_desc_pcnt,le.populated_property_desc_pcnt,le.populated_use_desc_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_foreclosure_id,le.maxlength_process_date,le.maxlength_state,le.maxlength_county,le.maxlength_batch_date_and_seq_nbr,le.maxlength_deed_category,le.maxlength_document_type,le.maxlength_recording_date,le.maxlength_document_year,le.maxlength_document_nbr,le.maxlength_document_book,le.maxlength_document_pages,le.maxlength_title_company_code,le.maxlength_title_company_name,le.maxlength_attorney_name,le.maxlength_attorney_phone_nbr,le.maxlength_first_defendant_borrower_owner_first_name,le.maxlength_first_defendant_borrower_owner_last_name,le.maxlength_first_defendant_borrower_company_name,le.maxlength_second_defendant_borrower_owner_first_name,le.maxlength_second_defendant_borrower_owner_last_name,le.maxlength_second_defendant_borrower_company_name,le.maxlength_third_defendant_borrower_owner_first_name,le.maxlength_third_defendant_borrower_owner_last_name,le.maxlength_third_defendant_borrower_company_name,le.maxlength_fourth_defendant_borrower_owner_first_name,le.maxlength_fourth_defendant_borrower_owner_last_name,le.maxlength_fourth_defendant_borrower_company_name,le.maxlength_defendant_borrower_owner_et_al_indicator,le.maxlength_filler1,le.maxlength_date_of_default,le.maxlength_amount_of_default,le.maxlength_filler2,le.maxlength_filing_date,le.maxlength_court_case_nbr,le.maxlength_lis_pendens_type,le.maxlength_plaintiff_1,le.maxlength_plaintiff_2,le.maxlength_final_judgment_amount,le.maxlength_filler_3,le.maxlength_auction_date,le.maxlength_auction_time,le.maxlength_street_address_of_auction_call,le.maxlength_city_of_auction_call,le.maxlength_state_of_auction_call,le.maxlength_opening_bid,le.maxlength_tax_year,le.maxlength_filler4,le.maxlength_sales_price,le.maxlength_situs_address_indicator_1,le.maxlength_situs_house_number_prefix_1,le.maxlength_situs_house_number_1,le.maxlength_situs_house_number_suffix_1,le.maxlength_situs_street_name_1,le.maxlength_situs_mode_1,le.maxlength_situs_direction_1,le.maxlength_situs_quadrant_1,le.maxlength_apartment_unit,le.maxlength_property_city_1,le.maxlength_property_state_1,le.maxlength_property_address_zip_code_1,le.maxlength_carrier_code,le.maxlength_full_site_address_unparsed_1,le.maxlength_lender_beneficiary_first_name,le.maxlength_lender_beneficiary_last_name,le.maxlength_lender_beneficiary_company_name,le.maxlength_lender_beneficiary_mailing_address,le.maxlength_lender_beneficiary_city,le.maxlength_lender_beneficiary_state,le.maxlength_lender_beneficiary_zip,le.maxlength_lender_phone,le.maxlength_filler_5,le.maxlength_trustee_name,le.maxlength_trustee_mailing_address,le.maxlength_trustee_city,le.maxlength_trustee_state,le.maxlength_trustee_zip,le.maxlength_trustee_phone,le.maxlength_trustee_sale_number,le.maxlength_filler_6,le.maxlength_original_loan_date,le.maxlength_original_loan_recording_date,le.maxlength_original_loan_amount,le.maxlength_original_document_number,le.maxlength_original_recording_book,le.maxlength_original_recording_page,le.maxlength_filler_7,le.maxlength_parcel_number_parcel_id,le.maxlength_parcel_number_unmatched_id,le.maxlength_last_full_sale_transfer_date,le.maxlength_transfer_value,le.maxlength_situs_address_indicator_2,le.maxlength_situs_house_number_prefix_2,le.maxlength_situs_house_number_2,le.maxlength_situs_house_number_suffix_2,le.maxlength_situs_street_name_2,le.maxlength_situs_mode_2,le.maxlength_situs_direction_2,le.maxlength_situs_quadrant_2,le.maxlength_apartment_unit_2,le.maxlength_property_city_2,le.maxlength_property_state_2,le.maxlength_property_address_zip_code_2,le.maxlength_carrier_code_2,le.maxlength_full_site_address_unparsed_2,le.maxlength_property_indicator,le.maxlength_use_code,le.maxlength_number_of_units,le.maxlength_living_area_square_feet,le.maxlength_number_of_bedrooms,le.maxlength_number_of_bathrooms,le.maxlength_number_of_garages,le.maxlength_zoning_code,le.maxlength_lot_size,le.maxlength_year_built,le.maxlength_current_land_value,le.maxlength_current_improvement_value,le.maxlength_filler_8,le.maxlength_section,le.maxlength_township,le.maxlength_range,le.maxlength_lot,le.maxlength_block,le.maxlength_tract_subdivision_name,le.maxlength_map_book,le.maxlength_map_page,le.maxlength_unit_nbr,le.maxlength_expanded_legal,le.maxlength_legal_2,le.maxlength_legal_3,le.maxlength_legal_4,le.maxlength_crlf,le.maxlength_deed_desc,le.maxlength_document_desc,le.maxlength_et_al_desc,le.maxlength_property_desc,le.maxlength_use_desc);
  SELF.avelength := CHOOSE(C,le.avelength_foreclosure_id,le.avelength_process_date,le.avelength_state,le.avelength_county,le.avelength_batch_date_and_seq_nbr,le.avelength_deed_category,le.avelength_document_type,le.avelength_recording_date,le.avelength_document_year,le.avelength_document_nbr,le.avelength_document_book,le.avelength_document_pages,le.avelength_title_company_code,le.avelength_title_company_name,le.avelength_attorney_name,le.avelength_attorney_phone_nbr,le.avelength_first_defendant_borrower_owner_first_name,le.avelength_first_defendant_borrower_owner_last_name,le.avelength_first_defendant_borrower_company_name,le.avelength_second_defendant_borrower_owner_first_name,le.avelength_second_defendant_borrower_owner_last_name,le.avelength_second_defendant_borrower_company_name,le.avelength_third_defendant_borrower_owner_first_name,le.avelength_third_defendant_borrower_owner_last_name,le.avelength_third_defendant_borrower_company_name,le.avelength_fourth_defendant_borrower_owner_first_name,le.avelength_fourth_defendant_borrower_owner_last_name,le.avelength_fourth_defendant_borrower_company_name,le.avelength_defendant_borrower_owner_et_al_indicator,le.avelength_filler1,le.avelength_date_of_default,le.avelength_amount_of_default,le.avelength_filler2,le.avelength_filing_date,le.avelength_court_case_nbr,le.avelength_lis_pendens_type,le.avelength_plaintiff_1,le.avelength_plaintiff_2,le.avelength_final_judgment_amount,le.avelength_filler_3,le.avelength_auction_date,le.avelength_auction_time,le.avelength_street_address_of_auction_call,le.avelength_city_of_auction_call,le.avelength_state_of_auction_call,le.avelength_opening_bid,le.avelength_tax_year,le.avelength_filler4,le.avelength_sales_price,le.avelength_situs_address_indicator_1,le.avelength_situs_house_number_prefix_1,le.avelength_situs_house_number_1,le.avelength_situs_house_number_suffix_1,le.avelength_situs_street_name_1,le.avelength_situs_mode_1,le.avelength_situs_direction_1,le.avelength_situs_quadrant_1,le.avelength_apartment_unit,le.avelength_property_city_1,le.avelength_property_state_1,le.avelength_property_address_zip_code_1,le.avelength_carrier_code,le.avelength_full_site_address_unparsed_1,le.avelength_lender_beneficiary_first_name,le.avelength_lender_beneficiary_last_name,le.avelength_lender_beneficiary_company_name,le.avelength_lender_beneficiary_mailing_address,le.avelength_lender_beneficiary_city,le.avelength_lender_beneficiary_state,le.avelength_lender_beneficiary_zip,le.avelength_lender_phone,le.avelength_filler_5,le.avelength_trustee_name,le.avelength_trustee_mailing_address,le.avelength_trustee_city,le.avelength_trustee_state,le.avelength_trustee_zip,le.avelength_trustee_phone,le.avelength_trustee_sale_number,le.avelength_filler_6,le.avelength_original_loan_date,le.avelength_original_loan_recording_date,le.avelength_original_loan_amount,le.avelength_original_document_number,le.avelength_original_recording_book,le.avelength_original_recording_page,le.avelength_filler_7,le.avelength_parcel_number_parcel_id,le.avelength_parcel_number_unmatched_id,le.avelength_last_full_sale_transfer_date,le.avelength_transfer_value,le.avelength_situs_address_indicator_2,le.avelength_situs_house_number_prefix_2,le.avelength_situs_house_number_2,le.avelength_situs_house_number_suffix_2,le.avelength_situs_street_name_2,le.avelength_situs_mode_2,le.avelength_situs_direction_2,le.avelength_situs_quadrant_2,le.avelength_apartment_unit_2,le.avelength_property_city_2,le.avelength_property_state_2,le.avelength_property_address_zip_code_2,le.avelength_carrier_code_2,le.avelength_full_site_address_unparsed_2,le.avelength_property_indicator,le.avelength_use_code,le.avelength_number_of_units,le.avelength_living_area_square_feet,le.avelength_number_of_bedrooms,le.avelength_number_of_bathrooms,le.avelength_number_of_garages,le.avelength_zoning_code,le.avelength_lot_size,le.avelength_year_built,le.avelength_current_land_value,le.avelength_current_improvement_value,le.avelength_filler_8,le.avelength_section,le.avelength_township,le.avelength_range,le.avelength_lot,le.avelength_block,le.avelength_tract_subdivision_name,le.avelength_map_book,le.avelength_map_page,le.avelength_unit_nbr,le.avelength_expanded_legal,le.avelength_legal_2,le.avelength_legal_3,le.avelength_legal_4,le.avelength_crlf,le.avelength_deed_desc,le.avelength_document_desc,le.avelength_et_al_desc,le.avelength_property_desc,le.avelength_use_desc);
END;
EXPORT invSummary := NORMALIZE(summary0, 137, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT36.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT36.StrType)le.foreclosure_id),TRIM((SALT36.StrType)le.process_date),TRIM((SALT36.StrType)le.state),TRIM((SALT36.StrType)le.county),TRIM((SALT36.StrType)le.batch_date_and_seq_nbr),TRIM((SALT36.StrType)le.deed_category),TRIM((SALT36.StrType)le.document_type),TRIM((SALT36.StrType)le.recording_date),TRIM((SALT36.StrType)le.document_year),TRIM((SALT36.StrType)le.document_nbr),TRIM((SALT36.StrType)le.document_book),TRIM((SALT36.StrType)le.document_pages),TRIM((SALT36.StrType)le.title_company_code),TRIM((SALT36.StrType)le.title_company_name),TRIM((SALT36.StrType)le.attorney_name),TRIM((SALT36.StrType)le.attorney_phone_nbr),TRIM((SALT36.StrType)le.first_defendant_borrower_owner_first_name),TRIM((SALT36.StrType)le.first_defendant_borrower_owner_last_name),TRIM((SALT36.StrType)le.first_defendant_borrower_company_name),TRIM((SALT36.StrType)le.second_defendant_borrower_owner_first_name),TRIM((SALT36.StrType)le.second_defendant_borrower_owner_last_name),TRIM((SALT36.StrType)le.second_defendant_borrower_company_name),TRIM((SALT36.StrType)le.third_defendant_borrower_owner_first_name),TRIM((SALT36.StrType)le.third_defendant_borrower_owner_last_name),TRIM((SALT36.StrType)le.third_defendant_borrower_company_name),TRIM((SALT36.StrType)le.fourth_defendant_borrower_owner_first_name),TRIM((SALT36.StrType)le.fourth_defendant_borrower_owner_last_name),TRIM((SALT36.StrType)le.fourth_defendant_borrower_company_name),TRIM((SALT36.StrType)le.defendant_borrower_owner_et_al_indicator),TRIM((SALT36.StrType)le.filler1),TRIM((SALT36.StrType)le.date_of_default),TRIM((SALT36.StrType)le.amount_of_default),TRIM((SALT36.StrType)le.filler2),TRIM((SALT36.StrType)le.filing_date),TRIM((SALT36.StrType)le.court_case_nbr),TRIM((SALT36.StrType)le.lis_pendens_type),TRIM((SALT36.StrType)le.plaintiff_1),TRIM((SALT36.StrType)le.plaintiff_2),TRIM((SALT36.StrType)le.final_judgment_amount),TRIM((SALT36.StrType)le.filler_3),TRIM((SALT36.StrType)le.auction_date),TRIM((SALT36.StrType)le.auction_time),TRIM((SALT36.StrType)le.street_address_of_auction_call),TRIM((SALT36.StrType)le.city_of_auction_call),TRIM((SALT36.StrType)le.state_of_auction_call),TRIM((SALT36.StrType)le.opening_bid),TRIM((SALT36.StrType)le.tax_year),TRIM((SALT36.StrType)le.filler4),TRIM((SALT36.StrType)le.sales_price),TRIM((SALT36.StrType)le.situs_address_indicator_1),TRIM((SALT36.StrType)le.situs_house_number_prefix_1),TRIM((SALT36.StrType)le.situs_house_number_1),TRIM((SALT36.StrType)le.situs_house_number_suffix_1),TRIM((SALT36.StrType)le.situs_street_name_1),TRIM((SALT36.StrType)le.situs_mode_1),TRIM((SALT36.StrType)le.situs_direction_1),TRIM((SALT36.StrType)le.situs_quadrant_1),TRIM((SALT36.StrType)le.apartment_unit),TRIM((SALT36.StrType)le.property_city_1),TRIM((SALT36.StrType)le.property_state_1),TRIM((SALT36.StrType)le.property_address_zip_code_1),TRIM((SALT36.StrType)le.carrier_code),TRIM((SALT36.StrType)le.full_site_address_unparsed_1),TRIM((SALT36.StrType)le.lender_beneficiary_first_name),TRIM((SALT36.StrType)le.lender_beneficiary_last_name),TRIM((SALT36.StrType)le.lender_beneficiary_company_name),TRIM((SALT36.StrType)le.lender_beneficiary_mailing_address),TRIM((SALT36.StrType)le.lender_beneficiary_city),TRIM((SALT36.StrType)le.lender_beneficiary_state),TRIM((SALT36.StrType)le.lender_beneficiary_zip),TRIM((SALT36.StrType)le.lender_phone),TRIM((SALT36.StrType)le.filler_5),TRIM((SALT36.StrType)le.trustee_name),TRIM((SALT36.StrType)le.trustee_mailing_address),TRIM((SALT36.StrType)le.trustee_city),TRIM((SALT36.StrType)le.trustee_state),TRIM((SALT36.StrType)le.trustee_zip),TRIM((SALT36.StrType)le.trustee_phone),TRIM((SALT36.StrType)le.trustee_sale_number),TRIM((SALT36.StrType)le.filler_6),TRIM((SALT36.StrType)le.original_loan_date),TRIM((SALT36.StrType)le.original_loan_recording_date),TRIM((SALT36.StrType)le.original_loan_amount),TRIM((SALT36.StrType)le.original_document_number),TRIM((SALT36.StrType)le.original_recording_book),TRIM((SALT36.StrType)le.original_recording_page),TRIM((SALT36.StrType)le.filler_7),TRIM((SALT36.StrType)le.parcel_number_parcel_id),TRIM((SALT36.StrType)le.parcel_number_unmatched_id),TRIM((SALT36.StrType)le.last_full_sale_transfer_date),TRIM((SALT36.StrType)le.transfer_value),TRIM((SALT36.StrType)le.situs_address_indicator_2),TRIM((SALT36.StrType)le.situs_house_number_prefix_2),TRIM((SALT36.StrType)le.situs_house_number_2),TRIM((SALT36.StrType)le.situs_house_number_suffix_2),TRIM((SALT36.StrType)le.situs_street_name_2),TRIM((SALT36.StrType)le.situs_mode_2),TRIM((SALT36.StrType)le.situs_direction_2),TRIM((SALT36.StrType)le.situs_quadrant_2),TRIM((SALT36.StrType)le.apartment_unit_2),TRIM((SALT36.StrType)le.property_city_2),TRIM((SALT36.StrType)le.property_state_2),TRIM((SALT36.StrType)le.property_address_zip_code_2),TRIM((SALT36.StrType)le.carrier_code_2),TRIM((SALT36.StrType)le.full_site_address_unparsed_2),TRIM((SALT36.StrType)le.property_indicator),TRIM((SALT36.StrType)le.use_code),TRIM((SALT36.StrType)le.number_of_units),TRIM((SALT36.StrType)le.living_area_square_feet),TRIM((SALT36.StrType)le.number_of_bedrooms),TRIM((SALT36.StrType)le.number_of_bathrooms),TRIM((SALT36.StrType)le.number_of_garages),TRIM((SALT36.StrType)le.zoning_code),TRIM((SALT36.StrType)le.lot_size),TRIM((SALT36.StrType)le.year_built),TRIM((SALT36.StrType)le.current_land_value),TRIM((SALT36.StrType)le.current_improvement_value),TRIM((SALT36.StrType)le.filler_8),TRIM((SALT36.StrType)le.section),TRIM((SALT36.StrType)le.township),TRIM((SALT36.StrType)le.range),TRIM((SALT36.StrType)le.lot),TRIM((SALT36.StrType)le.block),TRIM((SALT36.StrType)le.tract_subdivision_name),TRIM((SALT36.StrType)le.map_book),TRIM((SALT36.StrType)le.map_page),TRIM((SALT36.StrType)le.unit_nbr),TRIM((SALT36.StrType)le.expanded_legal),TRIM((SALT36.StrType)le.legal_2),TRIM((SALT36.StrType)le.legal_3),TRIM((SALT36.StrType)le.legal_4),TRIM((SALT36.StrType)le.crlf),TRIM((SALT36.StrType)le.deed_desc),TRIM((SALT36.StrType)le.document_desc),TRIM((SALT36.StrType)le.et_al_desc),TRIM((SALT36.StrType)le.property_desc),TRIM((SALT36.StrType)le.use_desc)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,137,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT36.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 137);
  SELF.FldNo2 := 1 + (C % 137);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT36.StrType)le.foreclosure_id),TRIM((SALT36.StrType)le.process_date),TRIM((SALT36.StrType)le.state),TRIM((SALT36.StrType)le.county),TRIM((SALT36.StrType)le.batch_date_and_seq_nbr),TRIM((SALT36.StrType)le.deed_category),TRIM((SALT36.StrType)le.document_type),TRIM((SALT36.StrType)le.recording_date),TRIM((SALT36.StrType)le.document_year),TRIM((SALT36.StrType)le.document_nbr),TRIM((SALT36.StrType)le.document_book),TRIM((SALT36.StrType)le.document_pages),TRIM((SALT36.StrType)le.title_company_code),TRIM((SALT36.StrType)le.title_company_name),TRIM((SALT36.StrType)le.attorney_name),TRIM((SALT36.StrType)le.attorney_phone_nbr),TRIM((SALT36.StrType)le.first_defendant_borrower_owner_first_name),TRIM((SALT36.StrType)le.first_defendant_borrower_owner_last_name),TRIM((SALT36.StrType)le.first_defendant_borrower_company_name),TRIM((SALT36.StrType)le.second_defendant_borrower_owner_first_name),TRIM((SALT36.StrType)le.second_defendant_borrower_owner_last_name),TRIM((SALT36.StrType)le.second_defendant_borrower_company_name),TRIM((SALT36.StrType)le.third_defendant_borrower_owner_first_name),TRIM((SALT36.StrType)le.third_defendant_borrower_owner_last_name),TRIM((SALT36.StrType)le.third_defendant_borrower_company_name),TRIM((SALT36.StrType)le.fourth_defendant_borrower_owner_first_name),TRIM((SALT36.StrType)le.fourth_defendant_borrower_owner_last_name),TRIM((SALT36.StrType)le.fourth_defendant_borrower_company_name),TRIM((SALT36.StrType)le.defendant_borrower_owner_et_al_indicator),TRIM((SALT36.StrType)le.filler1),TRIM((SALT36.StrType)le.date_of_default),TRIM((SALT36.StrType)le.amount_of_default),TRIM((SALT36.StrType)le.filler2),TRIM((SALT36.StrType)le.filing_date),TRIM((SALT36.StrType)le.court_case_nbr),TRIM((SALT36.StrType)le.lis_pendens_type),TRIM((SALT36.StrType)le.plaintiff_1),TRIM((SALT36.StrType)le.plaintiff_2),TRIM((SALT36.StrType)le.final_judgment_amount),TRIM((SALT36.StrType)le.filler_3),TRIM((SALT36.StrType)le.auction_date),TRIM((SALT36.StrType)le.auction_time),TRIM((SALT36.StrType)le.street_address_of_auction_call),TRIM((SALT36.StrType)le.city_of_auction_call),TRIM((SALT36.StrType)le.state_of_auction_call),TRIM((SALT36.StrType)le.opening_bid),TRIM((SALT36.StrType)le.tax_year),TRIM((SALT36.StrType)le.filler4),TRIM((SALT36.StrType)le.sales_price),TRIM((SALT36.StrType)le.situs_address_indicator_1),TRIM((SALT36.StrType)le.situs_house_number_prefix_1),TRIM((SALT36.StrType)le.situs_house_number_1),TRIM((SALT36.StrType)le.situs_house_number_suffix_1),TRIM((SALT36.StrType)le.situs_street_name_1),TRIM((SALT36.StrType)le.situs_mode_1),TRIM((SALT36.StrType)le.situs_direction_1),TRIM((SALT36.StrType)le.situs_quadrant_1),TRIM((SALT36.StrType)le.apartment_unit),TRIM((SALT36.StrType)le.property_city_1),TRIM((SALT36.StrType)le.property_state_1),TRIM((SALT36.StrType)le.property_address_zip_code_1),TRIM((SALT36.StrType)le.carrier_code),TRIM((SALT36.StrType)le.full_site_address_unparsed_1),TRIM((SALT36.StrType)le.lender_beneficiary_first_name),TRIM((SALT36.StrType)le.lender_beneficiary_last_name),TRIM((SALT36.StrType)le.lender_beneficiary_company_name),TRIM((SALT36.StrType)le.lender_beneficiary_mailing_address),TRIM((SALT36.StrType)le.lender_beneficiary_city),TRIM((SALT36.StrType)le.lender_beneficiary_state),TRIM((SALT36.StrType)le.lender_beneficiary_zip),TRIM((SALT36.StrType)le.lender_phone),TRIM((SALT36.StrType)le.filler_5),TRIM((SALT36.StrType)le.trustee_name),TRIM((SALT36.StrType)le.trustee_mailing_address),TRIM((SALT36.StrType)le.trustee_city),TRIM((SALT36.StrType)le.trustee_state),TRIM((SALT36.StrType)le.trustee_zip),TRIM((SALT36.StrType)le.trustee_phone),TRIM((SALT36.StrType)le.trustee_sale_number),TRIM((SALT36.StrType)le.filler_6),TRIM((SALT36.StrType)le.original_loan_date),TRIM((SALT36.StrType)le.original_loan_recording_date),TRIM((SALT36.StrType)le.original_loan_amount),TRIM((SALT36.StrType)le.original_document_number),TRIM((SALT36.StrType)le.original_recording_book),TRIM((SALT36.StrType)le.original_recording_page),TRIM((SALT36.StrType)le.filler_7),TRIM((SALT36.StrType)le.parcel_number_parcel_id),TRIM((SALT36.StrType)le.parcel_number_unmatched_id),TRIM((SALT36.StrType)le.last_full_sale_transfer_date),TRIM((SALT36.StrType)le.transfer_value),TRIM((SALT36.StrType)le.situs_address_indicator_2),TRIM((SALT36.StrType)le.situs_house_number_prefix_2),TRIM((SALT36.StrType)le.situs_house_number_2),TRIM((SALT36.StrType)le.situs_house_number_suffix_2),TRIM((SALT36.StrType)le.situs_street_name_2),TRIM((SALT36.StrType)le.situs_mode_2),TRIM((SALT36.StrType)le.situs_direction_2),TRIM((SALT36.StrType)le.situs_quadrant_2),TRIM((SALT36.StrType)le.apartment_unit_2),TRIM((SALT36.StrType)le.property_city_2),TRIM((SALT36.StrType)le.property_state_2),TRIM((SALT36.StrType)le.property_address_zip_code_2),TRIM((SALT36.StrType)le.carrier_code_2),TRIM((SALT36.StrType)le.full_site_address_unparsed_2),TRIM((SALT36.StrType)le.property_indicator),TRIM((SALT36.StrType)le.use_code),TRIM((SALT36.StrType)le.number_of_units),TRIM((SALT36.StrType)le.living_area_square_feet),TRIM((SALT36.StrType)le.number_of_bedrooms),TRIM((SALT36.StrType)le.number_of_bathrooms),TRIM((SALT36.StrType)le.number_of_garages),TRIM((SALT36.StrType)le.zoning_code),TRIM((SALT36.StrType)le.lot_size),TRIM((SALT36.StrType)le.year_built),TRIM((SALT36.StrType)le.current_land_value),TRIM((SALT36.StrType)le.current_improvement_value),TRIM((SALT36.StrType)le.filler_8),TRIM((SALT36.StrType)le.section),TRIM((SALT36.StrType)le.township),TRIM((SALT36.StrType)le.range),TRIM((SALT36.StrType)le.lot),TRIM((SALT36.StrType)le.block),TRIM((SALT36.StrType)le.tract_subdivision_name),TRIM((SALT36.StrType)le.map_book),TRIM((SALT36.StrType)le.map_page),TRIM((SALT36.StrType)le.unit_nbr),TRIM((SALT36.StrType)le.expanded_legal),TRIM((SALT36.StrType)le.legal_2),TRIM((SALT36.StrType)le.legal_3),TRIM((SALT36.StrType)le.legal_4),TRIM((SALT36.StrType)le.crlf),TRIM((SALT36.StrType)le.deed_desc),TRIM((SALT36.StrType)le.document_desc),TRIM((SALT36.StrType)le.et_al_desc),TRIM((SALT36.StrType)le.property_desc),TRIM((SALT36.StrType)le.use_desc)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT36.StrType)le.foreclosure_id),TRIM((SALT36.StrType)le.process_date),TRIM((SALT36.StrType)le.state),TRIM((SALT36.StrType)le.county),TRIM((SALT36.StrType)le.batch_date_and_seq_nbr),TRIM((SALT36.StrType)le.deed_category),TRIM((SALT36.StrType)le.document_type),TRIM((SALT36.StrType)le.recording_date),TRIM((SALT36.StrType)le.document_year),TRIM((SALT36.StrType)le.document_nbr),TRIM((SALT36.StrType)le.document_book),TRIM((SALT36.StrType)le.document_pages),TRIM((SALT36.StrType)le.title_company_code),TRIM((SALT36.StrType)le.title_company_name),TRIM((SALT36.StrType)le.attorney_name),TRIM((SALT36.StrType)le.attorney_phone_nbr),TRIM((SALT36.StrType)le.first_defendant_borrower_owner_first_name),TRIM((SALT36.StrType)le.first_defendant_borrower_owner_last_name),TRIM((SALT36.StrType)le.first_defendant_borrower_company_name),TRIM((SALT36.StrType)le.second_defendant_borrower_owner_first_name),TRIM((SALT36.StrType)le.second_defendant_borrower_owner_last_name),TRIM((SALT36.StrType)le.second_defendant_borrower_company_name),TRIM((SALT36.StrType)le.third_defendant_borrower_owner_first_name),TRIM((SALT36.StrType)le.third_defendant_borrower_owner_last_name),TRIM((SALT36.StrType)le.third_defendant_borrower_company_name),TRIM((SALT36.StrType)le.fourth_defendant_borrower_owner_first_name),TRIM((SALT36.StrType)le.fourth_defendant_borrower_owner_last_name),TRIM((SALT36.StrType)le.fourth_defendant_borrower_company_name),TRIM((SALT36.StrType)le.defendant_borrower_owner_et_al_indicator),TRIM((SALT36.StrType)le.filler1),TRIM((SALT36.StrType)le.date_of_default),TRIM((SALT36.StrType)le.amount_of_default),TRIM((SALT36.StrType)le.filler2),TRIM((SALT36.StrType)le.filing_date),TRIM((SALT36.StrType)le.court_case_nbr),TRIM((SALT36.StrType)le.lis_pendens_type),TRIM((SALT36.StrType)le.plaintiff_1),TRIM((SALT36.StrType)le.plaintiff_2),TRIM((SALT36.StrType)le.final_judgment_amount),TRIM((SALT36.StrType)le.filler_3),TRIM((SALT36.StrType)le.auction_date),TRIM((SALT36.StrType)le.auction_time),TRIM((SALT36.StrType)le.street_address_of_auction_call),TRIM((SALT36.StrType)le.city_of_auction_call),TRIM((SALT36.StrType)le.state_of_auction_call),TRIM((SALT36.StrType)le.opening_bid),TRIM((SALT36.StrType)le.tax_year),TRIM((SALT36.StrType)le.filler4),TRIM((SALT36.StrType)le.sales_price),TRIM((SALT36.StrType)le.situs_address_indicator_1),TRIM((SALT36.StrType)le.situs_house_number_prefix_1),TRIM((SALT36.StrType)le.situs_house_number_1),TRIM((SALT36.StrType)le.situs_house_number_suffix_1),TRIM((SALT36.StrType)le.situs_street_name_1),TRIM((SALT36.StrType)le.situs_mode_1),TRIM((SALT36.StrType)le.situs_direction_1),TRIM((SALT36.StrType)le.situs_quadrant_1),TRIM((SALT36.StrType)le.apartment_unit),TRIM((SALT36.StrType)le.property_city_1),TRIM((SALT36.StrType)le.property_state_1),TRIM((SALT36.StrType)le.property_address_zip_code_1),TRIM((SALT36.StrType)le.carrier_code),TRIM((SALT36.StrType)le.full_site_address_unparsed_1),TRIM((SALT36.StrType)le.lender_beneficiary_first_name),TRIM((SALT36.StrType)le.lender_beneficiary_last_name),TRIM((SALT36.StrType)le.lender_beneficiary_company_name),TRIM((SALT36.StrType)le.lender_beneficiary_mailing_address),TRIM((SALT36.StrType)le.lender_beneficiary_city),TRIM((SALT36.StrType)le.lender_beneficiary_state),TRIM((SALT36.StrType)le.lender_beneficiary_zip),TRIM((SALT36.StrType)le.lender_phone),TRIM((SALT36.StrType)le.filler_5),TRIM((SALT36.StrType)le.trustee_name),TRIM((SALT36.StrType)le.trustee_mailing_address),TRIM((SALT36.StrType)le.trustee_city),TRIM((SALT36.StrType)le.trustee_state),TRIM((SALT36.StrType)le.trustee_zip),TRIM((SALT36.StrType)le.trustee_phone),TRIM((SALT36.StrType)le.trustee_sale_number),TRIM((SALT36.StrType)le.filler_6),TRIM((SALT36.StrType)le.original_loan_date),TRIM((SALT36.StrType)le.original_loan_recording_date),TRIM((SALT36.StrType)le.original_loan_amount),TRIM((SALT36.StrType)le.original_document_number),TRIM((SALT36.StrType)le.original_recording_book),TRIM((SALT36.StrType)le.original_recording_page),TRIM((SALT36.StrType)le.filler_7),TRIM((SALT36.StrType)le.parcel_number_parcel_id),TRIM((SALT36.StrType)le.parcel_number_unmatched_id),TRIM((SALT36.StrType)le.last_full_sale_transfer_date),TRIM((SALT36.StrType)le.transfer_value),TRIM((SALT36.StrType)le.situs_address_indicator_2),TRIM((SALT36.StrType)le.situs_house_number_prefix_2),TRIM((SALT36.StrType)le.situs_house_number_2),TRIM((SALT36.StrType)le.situs_house_number_suffix_2),TRIM((SALT36.StrType)le.situs_street_name_2),TRIM((SALT36.StrType)le.situs_mode_2),TRIM((SALT36.StrType)le.situs_direction_2),TRIM((SALT36.StrType)le.situs_quadrant_2),TRIM((SALT36.StrType)le.apartment_unit_2),TRIM((SALT36.StrType)le.property_city_2),TRIM((SALT36.StrType)le.property_state_2),TRIM((SALT36.StrType)le.property_address_zip_code_2),TRIM((SALT36.StrType)le.carrier_code_2),TRIM((SALT36.StrType)le.full_site_address_unparsed_2),TRIM((SALT36.StrType)le.property_indicator),TRIM((SALT36.StrType)le.use_code),TRIM((SALT36.StrType)le.number_of_units),TRIM((SALT36.StrType)le.living_area_square_feet),TRIM((SALT36.StrType)le.number_of_bedrooms),TRIM((SALT36.StrType)le.number_of_bathrooms),TRIM((SALT36.StrType)le.number_of_garages),TRIM((SALT36.StrType)le.zoning_code),TRIM((SALT36.StrType)le.lot_size),TRIM((SALT36.StrType)le.year_built),TRIM((SALT36.StrType)le.current_land_value),TRIM((SALT36.StrType)le.current_improvement_value),TRIM((SALT36.StrType)le.filler_8),TRIM((SALT36.StrType)le.section),TRIM((SALT36.StrType)le.township),TRIM((SALT36.StrType)le.range),TRIM((SALT36.StrType)le.lot),TRIM((SALT36.StrType)le.block),TRIM((SALT36.StrType)le.tract_subdivision_name),TRIM((SALT36.StrType)le.map_book),TRIM((SALT36.StrType)le.map_page),TRIM((SALT36.StrType)le.unit_nbr),TRIM((SALT36.StrType)le.expanded_legal),TRIM((SALT36.StrType)le.legal_2),TRIM((SALT36.StrType)le.legal_3),TRIM((SALT36.StrType)le.legal_4),TRIM((SALT36.StrType)le.crlf),TRIM((SALT36.StrType)le.deed_desc),TRIM((SALT36.StrType)le.document_desc),TRIM((SALT36.StrType)le.et_al_desc),TRIM((SALT36.StrType)le.property_desc),TRIM((SALT36.StrType)le.use_desc)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),137*137,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'foreclosure_id'}
      ,{2,'process_date'}
      ,{3,'state'}
      ,{4,'county'}
      ,{5,'batch_date_and_seq_nbr'}
      ,{6,'deed_category'}
      ,{7,'document_type'}
      ,{8,'recording_date'}
      ,{9,'document_year'}
      ,{10,'document_nbr'}
      ,{11,'document_book'}
      ,{12,'document_pages'}
      ,{13,'title_company_code'}
      ,{14,'title_company_name'}
      ,{15,'attorney_name'}
      ,{16,'attorney_phone_nbr'}
      ,{17,'first_defendant_borrower_owner_first_name'}
      ,{18,'first_defendant_borrower_owner_last_name'}
      ,{19,'first_defendant_borrower_company_name'}
      ,{20,'second_defendant_borrower_owner_first_name'}
      ,{21,'second_defendant_borrower_owner_last_name'}
      ,{22,'second_defendant_borrower_company_name'}
      ,{23,'third_defendant_borrower_owner_first_name'}
      ,{24,'third_defendant_borrower_owner_last_name'}
      ,{25,'third_defendant_borrower_company_name'}
      ,{26,'fourth_defendant_borrower_owner_first_name'}
      ,{27,'fourth_defendant_borrower_owner_last_name'}
      ,{28,'fourth_defendant_borrower_company_name'}
      ,{29,'defendant_borrower_owner_et_al_indicator'}
      ,{30,'filler1'}
      ,{31,'date_of_default'}
      ,{32,'amount_of_default'}
      ,{33,'filler2'}
      ,{34,'filing_date'}
      ,{35,'court_case_nbr'}
      ,{36,'lis_pendens_type'}
      ,{37,'plaintiff_1'}
      ,{38,'plaintiff_2'}
      ,{39,'final_judgment_amount'}
      ,{40,'filler_3'}
      ,{41,'auction_date'}
      ,{42,'auction_time'}
      ,{43,'street_address_of_auction_call'}
      ,{44,'city_of_auction_call'}
      ,{45,'state_of_auction_call'}
      ,{46,'opening_bid'}
      ,{47,'tax_year'}
      ,{48,'filler4'}
      ,{49,'sales_price'}
      ,{50,'situs_address_indicator_1'}
      ,{51,'situs_house_number_prefix_1'}
      ,{52,'situs_house_number_1'}
      ,{53,'situs_house_number_suffix_1'}
      ,{54,'situs_street_name_1'}
      ,{55,'situs_mode_1'}
      ,{56,'situs_direction_1'}
      ,{57,'situs_quadrant_1'}
      ,{58,'apartment_unit'}
      ,{59,'property_city_1'}
      ,{60,'property_state_1'}
      ,{61,'property_address_zip_code_1'}
      ,{62,'carrier_code'}
      ,{63,'full_site_address_unparsed_1'}
      ,{64,'lender_beneficiary_first_name'}
      ,{65,'lender_beneficiary_last_name'}
      ,{66,'lender_beneficiary_company_name'}
      ,{67,'lender_beneficiary_mailing_address'}
      ,{68,'lender_beneficiary_city'}
      ,{69,'lender_beneficiary_state'}
      ,{70,'lender_beneficiary_zip'}
      ,{71,'lender_phone'}
      ,{72,'filler_5'}
      ,{73,'trustee_name'}
      ,{74,'trustee_mailing_address'}
      ,{75,'trustee_city'}
      ,{76,'trustee_state'}
      ,{77,'trustee_zip'}
      ,{78,'trustee_phone'}
      ,{79,'trustee_sale_number'}
      ,{80,'filler_6'}
      ,{81,'original_loan_date'}
      ,{82,'original_loan_recording_date'}
      ,{83,'original_loan_amount'}
      ,{84,'original_document_number'}
      ,{85,'original_recording_book'}
      ,{86,'original_recording_page'}
      ,{87,'filler_7'}
      ,{88,'parcel_number_parcel_id'}
      ,{89,'parcel_number_unmatched_id'}
      ,{90,'last_full_sale_transfer_date'}
      ,{91,'transfer_value'}
      ,{92,'situs_address_indicator_2'}
      ,{93,'situs_house_number_prefix_2'}
      ,{94,'situs_house_number_2'}
      ,{95,'situs_house_number_suffix_2'}
      ,{96,'situs_street_name_2'}
      ,{97,'situs_mode_2'}
      ,{98,'situs_direction_2'}
      ,{99,'situs_quadrant_2'}
      ,{100,'apartment_unit_2'}
      ,{101,'property_city_2'}
      ,{102,'property_state_2'}
      ,{103,'property_address_zip_code_2'}
      ,{104,'carrier_code_2'}
      ,{105,'full_site_address_unparsed_2'}
      ,{106,'property_indicator'}
      ,{107,'use_code'}
      ,{108,'number_of_units'}
      ,{109,'living_area_square_feet'}
      ,{110,'number_of_bedrooms'}
      ,{111,'number_of_bathrooms'}
      ,{112,'number_of_garages'}
      ,{113,'zoning_code'}
      ,{114,'lot_size'}
      ,{115,'year_built'}
      ,{116,'current_land_value'}
      ,{117,'current_improvement_value'}
      ,{118,'filler_8'}
      ,{119,'section'}
      ,{120,'township'}
      ,{121,'range'}
      ,{122,'lot'}
      ,{123,'block'}
      ,{124,'tract_subdivision_name'}
      ,{125,'map_book'}
      ,{126,'map_page'}
      ,{127,'unit_nbr'}
      ,{128,'expanded_legal'}
      ,{129,'legal_2'}
      ,{130,'legal_3'}
      ,{131,'legal_4'}
      ,{132,'crlf'}
      ,{133,'deed_desc'}
      ,{134,'document_desc'}
      ,{135,'et_al_desc'}
      ,{136,'property_desc'}
      ,{137,'use_desc'}],SALT36.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT36.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT36.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT36.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_foreclosure_id((SALT36.StrType)le.foreclosure_id),
    Fields.InValid_process_date((SALT36.StrType)le.process_date),
    Fields.InValid_state((SALT36.StrType)le.state),
    Fields.InValid_county((SALT36.StrType)le.county),
    Fields.InValid_batch_date_and_seq_nbr((SALT36.StrType)le.batch_date_and_seq_nbr),
    Fields.InValid_deed_category((SALT36.StrType)le.deed_category),
    Fields.InValid_document_type((SALT36.StrType)le.document_type),
    Fields.InValid_recording_date((SALT36.StrType)le.recording_date),
    Fields.InValid_document_year((SALT36.StrType)le.document_year),
    Fields.InValid_document_nbr((SALT36.StrType)le.document_nbr),
    Fields.InValid_document_book((SALT36.StrType)le.document_book),
    Fields.InValid_document_pages((SALT36.StrType)le.document_pages),
    Fields.InValid_title_company_code((SALT36.StrType)le.title_company_code),
    Fields.InValid_title_company_name((SALT36.StrType)le.title_company_name),
    Fields.InValid_attorney_name((SALT36.StrType)le.attorney_name),
    Fields.InValid_attorney_phone_nbr((SALT36.StrType)le.attorney_phone_nbr),
    Fields.InValid_first_defendant_borrower_owner_first_name((SALT36.StrType)le.first_defendant_borrower_owner_first_name),
    Fields.InValid_first_defendant_borrower_owner_last_name((SALT36.StrType)le.first_defendant_borrower_owner_last_name),
    Fields.InValid_first_defendant_borrower_company_name((SALT36.StrType)le.first_defendant_borrower_company_name),
    Fields.InValid_second_defendant_borrower_owner_first_name((SALT36.StrType)le.second_defendant_borrower_owner_first_name),
    Fields.InValid_second_defendant_borrower_owner_last_name((SALT36.StrType)le.second_defendant_borrower_owner_last_name),
    Fields.InValid_second_defendant_borrower_company_name((SALT36.StrType)le.second_defendant_borrower_company_name),
    Fields.InValid_third_defendant_borrower_owner_first_name((SALT36.StrType)le.third_defendant_borrower_owner_first_name),
    Fields.InValid_third_defendant_borrower_owner_last_name((SALT36.StrType)le.third_defendant_borrower_owner_last_name),
    Fields.InValid_third_defendant_borrower_company_name((SALT36.StrType)le.third_defendant_borrower_company_name),
    Fields.InValid_fourth_defendant_borrower_owner_first_name((SALT36.StrType)le.fourth_defendant_borrower_owner_first_name),
    Fields.InValid_fourth_defendant_borrower_owner_last_name((SALT36.StrType)le.fourth_defendant_borrower_owner_last_name),
    Fields.InValid_fourth_defendant_borrower_company_name((SALT36.StrType)le.fourth_defendant_borrower_company_name),
    Fields.InValid_defendant_borrower_owner_et_al_indicator((SALT36.StrType)le.defendant_borrower_owner_et_al_indicator),
    Fields.InValid_filler1((SALT36.StrType)le.filler1),
    Fields.InValid_date_of_default((SALT36.StrType)le.date_of_default),
    Fields.InValid_amount_of_default((SALT36.StrType)le.amount_of_default),
    Fields.InValid_filler2((SALT36.StrType)le.filler2),
    Fields.InValid_filing_date((SALT36.StrType)le.filing_date),
    Fields.InValid_court_case_nbr((SALT36.StrType)le.court_case_nbr),
    Fields.InValid_lis_pendens_type((SALT36.StrType)le.lis_pendens_type),
    Fields.InValid_plaintiff_1((SALT36.StrType)le.plaintiff_1),
    Fields.InValid_plaintiff_2((SALT36.StrType)le.plaintiff_2),
    Fields.InValid_final_judgment_amount((SALT36.StrType)le.final_judgment_amount),
    Fields.InValid_filler_3((SALT36.StrType)le.filler_3),
    Fields.InValid_auction_date((SALT36.StrType)le.auction_date),
    Fields.InValid_auction_time((SALT36.StrType)le.auction_time),
    Fields.InValid_street_address_of_auction_call((SALT36.StrType)le.street_address_of_auction_call),
    Fields.InValid_city_of_auction_call((SALT36.StrType)le.city_of_auction_call),
    Fields.InValid_state_of_auction_call((SALT36.StrType)le.state_of_auction_call),
    Fields.InValid_opening_bid((SALT36.StrType)le.opening_bid),
    Fields.InValid_tax_year((SALT36.StrType)le.tax_year),
    Fields.InValid_filler4((SALT36.StrType)le.filler4),
    Fields.InValid_sales_price((SALT36.StrType)le.sales_price),
    Fields.InValid_situs_address_indicator_1((SALT36.StrType)le.situs_address_indicator_1),
    Fields.InValid_situs_house_number_prefix_1((SALT36.StrType)le.situs_house_number_prefix_1),
    Fields.InValid_situs_house_number_1((SALT36.StrType)le.situs_house_number_1),
    Fields.InValid_situs_house_number_suffix_1((SALT36.StrType)le.situs_house_number_suffix_1),
    Fields.InValid_situs_street_name_1((SALT36.StrType)le.situs_street_name_1),
    Fields.InValid_situs_mode_1((SALT36.StrType)le.situs_mode_1),
    Fields.InValid_situs_direction_1((SALT36.StrType)le.situs_direction_1),
    Fields.InValid_situs_quadrant_1((SALT36.StrType)le.situs_quadrant_1),
    Fields.InValid_apartment_unit((SALT36.StrType)le.apartment_unit),
    Fields.InValid_property_city_1((SALT36.StrType)le.property_city_1),
    Fields.InValid_property_state_1((SALT36.StrType)le.property_state_1),
    Fields.InValid_property_address_zip_code_1((SALT36.StrType)le.property_address_zip_code_1),
    Fields.InValid_carrier_code((SALT36.StrType)le.carrier_code),
    Fields.InValid_full_site_address_unparsed_1((SALT36.StrType)le.full_site_address_unparsed_1),
    Fields.InValid_lender_beneficiary_first_name((SALT36.StrType)le.lender_beneficiary_first_name),
    Fields.InValid_lender_beneficiary_last_name((SALT36.StrType)le.lender_beneficiary_last_name),
    Fields.InValid_lender_beneficiary_company_name((SALT36.StrType)le.lender_beneficiary_company_name),
    Fields.InValid_lender_beneficiary_mailing_address((SALT36.StrType)le.lender_beneficiary_mailing_address),
    Fields.InValid_lender_beneficiary_city((SALT36.StrType)le.lender_beneficiary_city),
    Fields.InValid_lender_beneficiary_state((SALT36.StrType)le.lender_beneficiary_state),
    Fields.InValid_lender_beneficiary_zip((SALT36.StrType)le.lender_beneficiary_zip),
    Fields.InValid_lender_phone((SALT36.StrType)le.lender_phone),
    Fields.InValid_filler_5((SALT36.StrType)le.filler_5),
    Fields.InValid_trustee_name((SALT36.StrType)le.trustee_name),
    Fields.InValid_trustee_mailing_address((SALT36.StrType)le.trustee_mailing_address),
    Fields.InValid_trustee_city((SALT36.StrType)le.trustee_city),
    Fields.InValid_trustee_state((SALT36.StrType)le.trustee_state),
    Fields.InValid_trustee_zip((SALT36.StrType)le.trustee_zip),
    Fields.InValid_trustee_phone((SALT36.StrType)le.trustee_phone),
    Fields.InValid_trustee_sale_number((SALT36.StrType)le.trustee_sale_number),
    Fields.InValid_filler_6((SALT36.StrType)le.filler_6),
    Fields.InValid_original_loan_date((SALT36.StrType)le.original_loan_date),
    Fields.InValid_original_loan_recording_date((SALT36.StrType)le.original_loan_recording_date),
    Fields.InValid_original_loan_amount((SALT36.StrType)le.original_loan_amount),
    Fields.InValid_original_document_number((SALT36.StrType)le.original_document_number),
    Fields.InValid_original_recording_book((SALT36.StrType)le.original_recording_book),
    Fields.InValid_original_recording_page((SALT36.StrType)le.original_recording_page),
    Fields.InValid_filler_7((SALT36.StrType)le.filler_7),
    Fields.InValid_parcel_number_parcel_id((SALT36.StrType)le.parcel_number_parcel_id),
    Fields.InValid_parcel_number_unmatched_id((SALT36.StrType)le.parcel_number_unmatched_id),
    Fields.InValid_last_full_sale_transfer_date((SALT36.StrType)le.last_full_sale_transfer_date),
    Fields.InValid_transfer_value((SALT36.StrType)le.transfer_value),
    Fields.InValid_situs_address_indicator_2((SALT36.StrType)le.situs_address_indicator_2),
    Fields.InValid_situs_house_number_prefix_2((SALT36.StrType)le.situs_house_number_prefix_2),
    Fields.InValid_situs_house_number_2((SALT36.StrType)le.situs_house_number_2),
    Fields.InValid_situs_house_number_suffix_2((SALT36.StrType)le.situs_house_number_suffix_2),
    Fields.InValid_situs_street_name_2((SALT36.StrType)le.situs_street_name_2),
    Fields.InValid_situs_mode_2((SALT36.StrType)le.situs_mode_2),
    Fields.InValid_situs_direction_2((SALT36.StrType)le.situs_direction_2),
    Fields.InValid_situs_quadrant_2((SALT36.StrType)le.situs_quadrant_2),
    Fields.InValid_apartment_unit_2((SALT36.StrType)le.apartment_unit_2),
    Fields.InValid_property_city_2((SALT36.StrType)le.property_city_2),
    Fields.InValid_property_state_2((SALT36.StrType)le.property_state_2),
    Fields.InValid_property_address_zip_code_2((SALT36.StrType)le.property_address_zip_code_2),
    Fields.InValid_carrier_code_2((SALT36.StrType)le.carrier_code_2),
    Fields.InValid_full_site_address_unparsed_2((SALT36.StrType)le.full_site_address_unparsed_2),
    Fields.InValid_property_indicator((SALT36.StrType)le.property_indicator),
    Fields.InValid_use_code((SALT36.StrType)le.use_code),
    Fields.InValid_number_of_units((SALT36.StrType)le.number_of_units),
    Fields.InValid_living_area_square_feet((SALT36.StrType)le.living_area_square_feet),
    Fields.InValid_number_of_bedrooms((SALT36.StrType)le.number_of_bedrooms),
    Fields.InValid_number_of_bathrooms((SALT36.StrType)le.number_of_bathrooms),
    Fields.InValid_number_of_garages((SALT36.StrType)le.number_of_garages),
    Fields.InValid_zoning_code((SALT36.StrType)le.zoning_code),
    Fields.InValid_lot_size((SALT36.StrType)le.lot_size),
    Fields.InValid_year_built((SALT36.StrType)le.year_built),
    Fields.InValid_current_land_value((SALT36.StrType)le.current_land_value),
    Fields.InValid_current_improvement_value((SALT36.StrType)le.current_improvement_value),
    Fields.InValid_filler_8((SALT36.StrType)le.filler_8),
    Fields.InValid_section((SALT36.StrType)le.section),
    Fields.InValid_township((SALT36.StrType)le.township),
    Fields.InValid_range((SALT36.StrType)le.range),
    Fields.InValid_lot((SALT36.StrType)le.lot),
    Fields.InValid_block((SALT36.StrType)le.block),
    Fields.InValid_tract_subdivision_name((SALT36.StrType)le.tract_subdivision_name),
    Fields.InValid_map_book((SALT36.StrType)le.map_book),
    Fields.InValid_map_page((SALT36.StrType)le.map_page),
    Fields.InValid_unit_nbr((SALT36.StrType)le.unit_nbr),
    Fields.InValid_expanded_legal((SALT36.StrType)le.expanded_legal),
    Fields.InValid_legal_2((SALT36.StrType)le.legal_2),
    Fields.InValid_legal_3((SALT36.StrType)le.legal_3),
    Fields.InValid_legal_4((SALT36.StrType)le.legal_4),
    Fields.InValid_crlf((SALT36.StrType)le.crlf),
    Fields.InValid_deed_desc((SALT36.StrType)le.deed_desc),
    Fields.InValid_document_desc((SALT36.StrType)le.document_desc),
    Fields.InValid_et_al_desc((SALT36.StrType)le.et_al_desc),
    Fields.InValid_property_desc((SALT36.StrType)le.property_desc),
    Fields.InValid_use_desc((SALT36.StrType)le.use_desc),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,137,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','invalid_date','Unknown','Unknown','Unknown','invalid_deed_code','invalid_document_code','invalid_date','invalid_year','invalid_apn','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_phone','Unknown','invalid_name','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_etal_code','Unknown','invalid_date','invalid_amount','Unknown','invalid_date','invalid_case','Unknown','Unknown','Unknown','invalid_amount','Unknown','invalid_date','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_year','Unknown','invalid_amount','invalid_address_indicator','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_alpha','invalid_alpha','invalid_zip','Unknown','invalid_alpha','Unknown','Unknown','Unknown','Unknown','invalid_alpha','invalid_alpha','invalid_zip','invalid_phone','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_phone','invalid_apn','Unknown','invalid_date','invalid_date','invalid_amount','invalid_apn','Unknown','Unknown','Unknown','invalid_apn','Unknown','invalid_date','invalid_amount','invalid_address_indicator','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_alpha','invalid_alpha','invalid_zip','Unknown','invalid_alpha','invalid_property_code','invalid_land_use_code','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_year','invalid_amount','invalid_amount','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_foreclosure_id(TotalErrors.ErrorNum),Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_batch_date_and_seq_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_deed_category(TotalErrors.ErrorNum),Fields.InValidMessage_document_type(TotalErrors.ErrorNum),Fields.InValidMessage_recording_date(TotalErrors.ErrorNum),Fields.InValidMessage_document_year(TotalErrors.ErrorNum),Fields.InValidMessage_document_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_document_book(TotalErrors.ErrorNum),Fields.InValidMessage_document_pages(TotalErrors.ErrorNum),Fields.InValidMessage_title_company_code(TotalErrors.ErrorNum),Fields.InValidMessage_title_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_attorney_name(TotalErrors.ErrorNum),Fields.InValidMessage_attorney_phone_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_first_defendant_borrower_owner_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_first_defendant_borrower_owner_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_first_defendant_borrower_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_second_defendant_borrower_owner_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_second_defendant_borrower_owner_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_second_defendant_borrower_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_third_defendant_borrower_owner_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_third_defendant_borrower_owner_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_third_defendant_borrower_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_fourth_defendant_borrower_owner_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_fourth_defendant_borrower_owner_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_fourth_defendant_borrower_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_defendant_borrower_owner_et_al_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_filler1(TotalErrors.ErrorNum),Fields.InValidMessage_date_of_default(TotalErrors.ErrorNum),Fields.InValidMessage_amount_of_default(TotalErrors.ErrorNum),Fields.InValidMessage_filler2(TotalErrors.ErrorNum),Fields.InValidMessage_filing_date(TotalErrors.ErrorNum),Fields.InValidMessage_court_case_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_lis_pendens_type(TotalErrors.ErrorNum),Fields.InValidMessage_plaintiff_1(TotalErrors.ErrorNum),Fields.InValidMessage_plaintiff_2(TotalErrors.ErrorNum),Fields.InValidMessage_final_judgment_amount(TotalErrors.ErrorNum),Fields.InValidMessage_filler_3(TotalErrors.ErrorNum),Fields.InValidMessage_auction_date(TotalErrors.ErrorNum),Fields.InValidMessage_auction_time(TotalErrors.ErrorNum),Fields.InValidMessage_street_address_of_auction_call(TotalErrors.ErrorNum),Fields.InValidMessage_city_of_auction_call(TotalErrors.ErrorNum),Fields.InValidMessage_state_of_auction_call(TotalErrors.ErrorNum),Fields.InValidMessage_opening_bid(TotalErrors.ErrorNum),Fields.InValidMessage_tax_year(TotalErrors.ErrorNum),Fields.InValidMessage_filler4(TotalErrors.ErrorNum),Fields.InValidMessage_sales_price(TotalErrors.ErrorNum),Fields.InValidMessage_situs_address_indicator_1(TotalErrors.ErrorNum),Fields.InValidMessage_situs_house_number_prefix_1(TotalErrors.ErrorNum),Fields.InValidMessage_situs_house_number_1(TotalErrors.ErrorNum),Fields.InValidMessage_situs_house_number_suffix_1(TotalErrors.ErrorNum),Fields.InValidMessage_situs_street_name_1(TotalErrors.ErrorNum),Fields.InValidMessage_situs_mode_1(TotalErrors.ErrorNum),Fields.InValidMessage_situs_direction_1(TotalErrors.ErrorNum),Fields.InValidMessage_situs_quadrant_1(TotalErrors.ErrorNum),Fields.InValidMessage_apartment_unit(TotalErrors.ErrorNum),Fields.InValidMessage_property_city_1(TotalErrors.ErrorNum),Fields.InValidMessage_property_state_1(TotalErrors.ErrorNum),Fields.InValidMessage_property_address_zip_code_1(TotalErrors.ErrorNum),Fields.InValidMessage_carrier_code(TotalErrors.ErrorNum),Fields.InValidMessage_full_site_address_unparsed_1(TotalErrors.ErrorNum),Fields.InValidMessage_lender_beneficiary_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_lender_beneficiary_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_lender_beneficiary_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_lender_beneficiary_mailing_address(TotalErrors.ErrorNum),Fields.InValidMessage_lender_beneficiary_city(TotalErrors.ErrorNum),Fields.InValidMessage_lender_beneficiary_state(TotalErrors.ErrorNum),Fields.InValidMessage_lender_beneficiary_zip(TotalErrors.ErrorNum),Fields.InValidMessage_lender_phone(TotalErrors.ErrorNum),Fields.InValidMessage_filler_5(TotalErrors.ErrorNum),Fields.InValidMessage_trustee_name(TotalErrors.ErrorNum),Fields.InValidMessage_trustee_mailing_address(TotalErrors.ErrorNum),Fields.InValidMessage_trustee_city(TotalErrors.ErrorNum),Fields.InValidMessage_trustee_state(TotalErrors.ErrorNum),Fields.InValidMessage_trustee_zip(TotalErrors.ErrorNum),Fields.InValidMessage_trustee_phone(TotalErrors.ErrorNum),Fields.InValidMessage_trustee_sale_number(TotalErrors.ErrorNum),Fields.InValidMessage_filler_6(TotalErrors.ErrorNum),Fields.InValidMessage_original_loan_date(TotalErrors.ErrorNum),Fields.InValidMessage_original_loan_recording_date(TotalErrors.ErrorNum),Fields.InValidMessage_original_loan_amount(TotalErrors.ErrorNum),Fields.InValidMessage_original_document_number(TotalErrors.ErrorNum),Fields.InValidMessage_original_recording_book(TotalErrors.ErrorNum),Fields.InValidMessage_original_recording_page(TotalErrors.ErrorNum),Fields.InValidMessage_filler_7(TotalErrors.ErrorNum),Fields.InValidMessage_parcel_number_parcel_id(TotalErrors.ErrorNum),Fields.InValidMessage_parcel_number_unmatched_id(TotalErrors.ErrorNum),Fields.InValidMessage_last_full_sale_transfer_date(TotalErrors.ErrorNum),Fields.InValidMessage_transfer_value(TotalErrors.ErrorNum),Fields.InValidMessage_situs_address_indicator_2(TotalErrors.ErrorNum),Fields.InValidMessage_situs_house_number_prefix_2(TotalErrors.ErrorNum),Fields.InValidMessage_situs_house_number_2(TotalErrors.ErrorNum),Fields.InValidMessage_situs_house_number_suffix_2(TotalErrors.ErrorNum),Fields.InValidMessage_situs_street_name_2(TotalErrors.ErrorNum),Fields.InValidMessage_situs_mode_2(TotalErrors.ErrorNum),Fields.InValidMessage_situs_direction_2(TotalErrors.ErrorNum),Fields.InValidMessage_situs_quadrant_2(TotalErrors.ErrorNum),Fields.InValidMessage_apartment_unit_2(TotalErrors.ErrorNum),Fields.InValidMessage_property_city_2(TotalErrors.ErrorNum),Fields.InValidMessage_property_state_2(TotalErrors.ErrorNum),Fields.InValidMessage_property_address_zip_code_2(TotalErrors.ErrorNum),Fields.InValidMessage_carrier_code_2(TotalErrors.ErrorNum),Fields.InValidMessage_full_site_address_unparsed_2(TotalErrors.ErrorNum),Fields.InValidMessage_property_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_use_code(TotalErrors.ErrorNum),Fields.InValidMessage_number_of_units(TotalErrors.ErrorNum),Fields.InValidMessage_living_area_square_feet(TotalErrors.ErrorNum),Fields.InValidMessage_number_of_bedrooms(TotalErrors.ErrorNum),Fields.InValidMessage_number_of_bathrooms(TotalErrors.ErrorNum),Fields.InValidMessage_number_of_garages(TotalErrors.ErrorNum),Fields.InValidMessage_zoning_code(TotalErrors.ErrorNum),Fields.InValidMessage_lot_size(TotalErrors.ErrorNum),Fields.InValidMessage_year_built(TotalErrors.ErrorNum),Fields.InValidMessage_current_land_value(TotalErrors.ErrorNum),Fields.InValidMessage_current_improvement_value(TotalErrors.ErrorNum),Fields.InValidMessage_filler_8(TotalErrors.ErrorNum),Fields.InValidMessage_section(TotalErrors.ErrorNum),Fields.InValidMessage_township(TotalErrors.ErrorNum),Fields.InValidMessage_range(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_block(TotalErrors.ErrorNum),Fields.InValidMessage_tract_subdivision_name(TotalErrors.ErrorNum),Fields.InValidMessage_map_book(TotalErrors.ErrorNum),Fields.InValidMessage_map_page(TotalErrors.ErrorNum),Fields.InValidMessage_unit_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_expanded_legal(TotalErrors.ErrorNum),Fields.InValidMessage_legal_2(TotalErrors.ErrorNum),Fields.InValidMessage_legal_3(TotalErrors.ErrorNum),Fields.InValidMessage_legal_4(TotalErrors.ErrorNum),Fields.InValidMessage_crlf(TotalErrors.ErrorNum),Fields.InValidMessage_deed_desc(TotalErrors.ErrorNum),Fields.InValidMessage_document_desc(TotalErrors.ErrorNum),Fields.InValidMessage_et_al_desc(TotalErrors.ErrorNum),Fields.InValidMessage_property_desc(TotalErrors.ErrorNum),Fields.InValidMessage_use_desc(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
