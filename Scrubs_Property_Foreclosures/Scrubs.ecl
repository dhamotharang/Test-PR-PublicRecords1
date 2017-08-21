IMPORT SALT36;
IMPORT Scrubs_Property_Foreclosures; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_property_foreclosures)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 deed_category_Invalid;
    UNSIGNED1 document_type_Invalid;
    UNSIGNED1 recording_date_Invalid;
    UNSIGNED1 document_year_Invalid;
    UNSIGNED1 document_nbr_Invalid;
    UNSIGNED1 attorney_phone_nbr_Invalid;
    UNSIGNED1 first_defendant_borrower_owner_last_name_Invalid;
    UNSIGNED1 defendant_borrower_owner_et_al_indicator_Invalid;
    UNSIGNED1 date_of_default_Invalid;
    UNSIGNED1 amount_of_default_Invalid;
    UNSIGNED1 filing_date_Invalid;
    UNSIGNED1 court_case_nbr_Invalid;
    UNSIGNED1 final_judgment_amount_Invalid;
    UNSIGNED1 auction_date_Invalid;
    UNSIGNED1 tax_year_Invalid;
    UNSIGNED1 sales_price_Invalid;
    UNSIGNED1 situs_address_indicator_1_Invalid;
    UNSIGNED1 property_city_1_Invalid;
    UNSIGNED1 property_state_1_Invalid;
    UNSIGNED1 property_address_zip_code_1_Invalid;
    UNSIGNED1 full_site_address_unparsed_1_Invalid;
    UNSIGNED1 lender_beneficiary_city_Invalid;
    UNSIGNED1 lender_beneficiary_state_Invalid;
    UNSIGNED1 lender_beneficiary_zip_Invalid;
    UNSIGNED1 lender_phone_Invalid;
    UNSIGNED1 trustee_phone_Invalid;
    UNSIGNED1 trustee_sale_number_Invalid;
    UNSIGNED1 original_loan_date_Invalid;
    UNSIGNED1 original_loan_recording_date_Invalid;
    UNSIGNED1 original_loan_amount_Invalid;
    UNSIGNED1 original_document_number_Invalid;
    UNSIGNED1 parcel_number_parcel_id_Invalid;
    UNSIGNED1 last_full_sale_transfer_date_Invalid;
    UNSIGNED1 transfer_value_Invalid;
    UNSIGNED1 situs_address_indicator_2_Invalid;
    UNSIGNED1 property_city_2_Invalid;
    UNSIGNED1 property_state_2_Invalid;
    UNSIGNED1 property_address_zip_code_2_Invalid;
    UNSIGNED1 full_site_address_unparsed_2_Invalid;
    UNSIGNED1 property_indicator_Invalid;
    UNSIGNED1 use_code_Invalid;
    UNSIGNED1 year_built_Invalid;
    UNSIGNED1 current_land_value_Invalid;
    UNSIGNED1 current_improvement_value_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_property_foreclosures)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_property_foreclosures) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT36.StrType)le.process_date);
    SELF.deed_category_Invalid := Fields.InValid_deed_category((SALT36.StrType)le.deed_category);
    SELF.document_type_Invalid := Fields.InValid_document_type((SALT36.StrType)le.document_type);
    SELF.recording_date_Invalid := Fields.InValid_recording_date((SALT36.StrType)le.recording_date);
    SELF.document_year_Invalid := Fields.InValid_document_year((SALT36.StrType)le.document_year);
    SELF.document_nbr_Invalid := Fields.InValid_document_nbr((SALT36.StrType)le.document_nbr);
    SELF.attorney_phone_nbr_Invalid := Fields.InValid_attorney_phone_nbr((SALT36.StrType)le.attorney_phone_nbr);
    SELF.first_defendant_borrower_owner_last_name_Invalid := Fields.InValid_first_defendant_borrower_owner_last_name((SALT36.StrType)le.first_defendant_borrower_owner_last_name);
    SELF.defendant_borrower_owner_et_al_indicator_Invalid := Fields.InValid_defendant_borrower_owner_et_al_indicator((SALT36.StrType)le.defendant_borrower_owner_et_al_indicator);
    SELF.date_of_default_Invalid := Fields.InValid_date_of_default((SALT36.StrType)le.date_of_default);
    SELF.amount_of_default_Invalid := Fields.InValid_amount_of_default((SALT36.StrType)le.amount_of_default);
    SELF.filing_date_Invalid := Fields.InValid_filing_date((SALT36.StrType)le.filing_date);
    SELF.court_case_nbr_Invalid := Fields.InValid_court_case_nbr((SALT36.StrType)le.court_case_nbr);
    SELF.final_judgment_amount_Invalid := Fields.InValid_final_judgment_amount((SALT36.StrType)le.final_judgment_amount);
    SELF.auction_date_Invalid := Fields.InValid_auction_date((SALT36.StrType)le.auction_date);
    SELF.tax_year_Invalid := Fields.InValid_tax_year((SALT36.StrType)le.tax_year);
    SELF.sales_price_Invalid := Fields.InValid_sales_price((SALT36.StrType)le.sales_price);
    SELF.situs_address_indicator_1_Invalid := Fields.InValid_situs_address_indicator_1((SALT36.StrType)le.situs_address_indicator_1);
    SELF.property_city_1_Invalid := Fields.InValid_property_city_1((SALT36.StrType)le.property_city_1);
    SELF.property_state_1_Invalid := Fields.InValid_property_state_1((SALT36.StrType)le.property_state_1);
    SELF.property_address_zip_code_1_Invalid := Fields.InValid_property_address_zip_code_1((SALT36.StrType)le.property_address_zip_code_1);
    SELF.full_site_address_unparsed_1_Invalid := Fields.InValid_full_site_address_unparsed_1((SALT36.StrType)le.full_site_address_unparsed_1);
    SELF.lender_beneficiary_city_Invalid := Fields.InValid_lender_beneficiary_city((SALT36.StrType)le.lender_beneficiary_city);
    SELF.lender_beneficiary_state_Invalid := Fields.InValid_lender_beneficiary_state((SALT36.StrType)le.lender_beneficiary_state);
    SELF.lender_beneficiary_zip_Invalid := Fields.InValid_lender_beneficiary_zip((SALT36.StrType)le.lender_beneficiary_zip);
    SELF.lender_phone_Invalid := Fields.InValid_lender_phone((SALT36.StrType)le.lender_phone);
    SELF.trustee_phone_Invalid := Fields.InValid_trustee_phone((SALT36.StrType)le.trustee_phone);
    SELF.trustee_sale_number_Invalid := Fields.InValid_trustee_sale_number((SALT36.StrType)le.trustee_sale_number);
    SELF.original_loan_date_Invalid := Fields.InValid_original_loan_date((SALT36.StrType)le.original_loan_date);
    SELF.original_loan_recording_date_Invalid := Fields.InValid_original_loan_recording_date((SALT36.StrType)le.original_loan_recording_date);
    SELF.original_loan_amount_Invalid := Fields.InValid_original_loan_amount((SALT36.StrType)le.original_loan_amount);
    SELF.original_document_number_Invalid := Fields.InValid_original_document_number((SALT36.StrType)le.original_document_number);
    SELF.parcel_number_parcel_id_Invalid := Fields.InValid_parcel_number_parcel_id((SALT36.StrType)le.parcel_number_parcel_id);
    SELF.last_full_sale_transfer_date_Invalid := Fields.InValid_last_full_sale_transfer_date((SALT36.StrType)le.last_full_sale_transfer_date);
    SELF.transfer_value_Invalid := Fields.InValid_transfer_value((SALT36.StrType)le.transfer_value);
    SELF.situs_address_indicator_2_Invalid := Fields.InValid_situs_address_indicator_2((SALT36.StrType)le.situs_address_indicator_2);
    SELF.property_city_2_Invalid := Fields.InValid_property_city_2((SALT36.StrType)le.property_city_2);
    SELF.property_state_2_Invalid := Fields.InValid_property_state_2((SALT36.StrType)le.property_state_2);
    SELF.property_address_zip_code_2_Invalid := Fields.InValid_property_address_zip_code_2((SALT36.StrType)le.property_address_zip_code_2);
    SELF.full_site_address_unparsed_2_Invalid := Fields.InValid_full_site_address_unparsed_2((SALT36.StrType)le.full_site_address_unparsed_2);
    SELF.property_indicator_Invalid := Fields.InValid_property_indicator((SALT36.StrType)le.property_indicator);
    SELF.use_code_Invalid := Fields.InValid_use_code((SALT36.StrType)le.use_code);
    SELF.year_built_Invalid := Fields.InValid_year_built((SALT36.StrType)le.year_built);
    SELF.current_land_value_Invalid := Fields.InValid_current_land_value((SALT36.StrType)le.current_land_value);
    SELF.current_improvement_value_Invalid := Fields.InValid_current_improvement_value((SALT36.StrType)le.current_improvement_value);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_property_foreclosures);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.deed_category_Invalid << 2 ) + ( le.document_type_Invalid << 3 ) + ( le.recording_date_Invalid << 4 ) + ( le.document_year_Invalid << 6 ) + ( le.document_nbr_Invalid << 8 ) + ( le.attorney_phone_nbr_Invalid << 9 ) + ( le.first_defendant_borrower_owner_last_name_Invalid << 11 ) + ( le.defendant_borrower_owner_et_al_indicator_Invalid << 13 ) + ( le.date_of_default_Invalid << 14 ) + ( le.amount_of_default_Invalid << 16 ) + ( le.filing_date_Invalid << 17 ) + ( le.court_case_nbr_Invalid << 19 ) + ( le.final_judgment_amount_Invalid << 20 ) + ( le.auction_date_Invalid << 21 ) + ( le.tax_year_Invalid << 23 ) + ( le.sales_price_Invalid << 25 ) + ( le.situs_address_indicator_1_Invalid << 26 ) + ( le.property_city_1_Invalid << 27 ) + ( le.property_state_1_Invalid << 28 ) + ( le.property_address_zip_code_1_Invalid << 29 ) + ( le.full_site_address_unparsed_1_Invalid << 31 ) + ( le.lender_beneficiary_city_Invalid << 32 ) + ( le.lender_beneficiary_state_Invalid << 33 ) + ( le.lender_beneficiary_zip_Invalid << 34 ) + ( le.lender_phone_Invalid << 36 ) + ( le.trustee_phone_Invalid << 38 ) + ( le.trustee_sale_number_Invalid << 40 ) + ( le.original_loan_date_Invalid << 41 ) + ( le.original_loan_recording_date_Invalid << 43 ) + ( le.original_loan_amount_Invalid << 45 ) + ( le.original_document_number_Invalid << 46 ) + ( le.parcel_number_parcel_id_Invalid << 47 ) + ( le.last_full_sale_transfer_date_Invalid << 48 ) + ( le.transfer_value_Invalid << 50 ) + ( le.situs_address_indicator_2_Invalid << 51 ) + ( le.property_city_2_Invalid << 52 ) + ( le.property_state_2_Invalid << 53 ) + ( le.property_address_zip_code_2_Invalid << 54 ) + ( le.full_site_address_unparsed_2_Invalid << 56 ) + ( le.property_indicator_Invalid << 57 ) + ( le.use_code_Invalid << 58 ) + ( le.year_built_Invalid << 59 ) + ( le.current_land_value_Invalid << 61 ) + ( le.current_improvement_value_Invalid << 62 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_property_foreclosures);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.deed_category_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.document_type_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.recording_date_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.document_year_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.document_nbr_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.attorney_phone_nbr_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.first_defendant_borrower_owner_last_name_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.defendant_borrower_owner_et_al_indicator_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.date_of_default_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.amount_of_default_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.filing_date_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.court_case_nbr_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.final_judgment_amount_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.auction_date_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.tax_year_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.sales_price_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.situs_address_indicator_1_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.property_city_1_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.property_state_1_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.property_address_zip_code_1_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.full_site_address_unparsed_1_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.lender_beneficiary_city_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.lender_beneficiary_state_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.lender_beneficiary_zip_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.lender_phone_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.trustee_phone_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.trustee_sale_number_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.original_loan_date_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.original_loan_recording_date_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.original_loan_amount_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.original_document_number_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.parcel_number_parcel_id_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.last_full_sale_transfer_date_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.transfer_value_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.situs_address_indicator_2_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.property_city_2_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.property_state_2_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.property_address_zip_code_2_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.full_site_address_unparsed_2_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.property_indicator_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.use_code_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.year_built_Invalid := (le.ScrubsBits1 >> 59) & 3;
    SELF.current_land_value_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.current_improvement_value_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_ALLOW_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_LENGTH_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    deed_category_CUSTOM_ErrorCount := COUNT(GROUP,h.deed_category_Invalid=1);
    document_type_CUSTOM_ErrorCount := COUNT(GROUP,h.document_type_Invalid=1);
    recording_date_ALLOW_ErrorCount := COUNT(GROUP,h.recording_date_Invalid=1);
    recording_date_LENGTH_ErrorCount := COUNT(GROUP,h.recording_date_Invalid=2);
    recording_date_Total_ErrorCount := COUNT(GROUP,h.recording_date_Invalid>0);
    document_year_ALLOW_ErrorCount := COUNT(GROUP,h.document_year_Invalid=1);
    document_year_LENGTH_ErrorCount := COUNT(GROUP,h.document_year_Invalid=2);
    document_year_Total_ErrorCount := COUNT(GROUP,h.document_year_Invalid>0);
    document_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.document_nbr_Invalid=1);
    attorney_phone_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.attorney_phone_nbr_Invalid=1);
    attorney_phone_nbr_LENGTH_ErrorCount := COUNT(GROUP,h.attorney_phone_nbr_Invalid=2);
    attorney_phone_nbr_Total_ErrorCount := COUNT(GROUP,h.attorney_phone_nbr_Invalid>0);
    first_defendant_borrower_owner_last_name_ALLOW_ErrorCount := COUNT(GROUP,h.first_defendant_borrower_owner_last_name_Invalid=1);
    first_defendant_borrower_owner_last_name_LENGTH_ErrorCount := COUNT(GROUP,h.first_defendant_borrower_owner_last_name_Invalid=2);
    first_defendant_borrower_owner_last_name_Total_ErrorCount := COUNT(GROUP,h.first_defendant_borrower_owner_last_name_Invalid>0);
    defendant_borrower_owner_et_al_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.defendant_borrower_owner_et_al_indicator_Invalid=1);
    date_of_default_ALLOW_ErrorCount := COUNT(GROUP,h.date_of_default_Invalid=1);
    date_of_default_LENGTH_ErrorCount := COUNT(GROUP,h.date_of_default_Invalid=2);
    date_of_default_Total_ErrorCount := COUNT(GROUP,h.date_of_default_Invalid>0);
    amount_of_default_ALLOW_ErrorCount := COUNT(GROUP,h.amount_of_default_Invalid=1);
    filing_date_ALLOW_ErrorCount := COUNT(GROUP,h.filing_date_Invalid=1);
    filing_date_LENGTH_ErrorCount := COUNT(GROUP,h.filing_date_Invalid=2);
    filing_date_Total_ErrorCount := COUNT(GROUP,h.filing_date_Invalid>0);
    court_case_nbr_ALLOW_ErrorCount := COUNT(GROUP,h.court_case_nbr_Invalid=1);
    final_judgment_amount_ALLOW_ErrorCount := COUNT(GROUP,h.final_judgment_amount_Invalid=1);
    auction_date_ALLOW_ErrorCount := COUNT(GROUP,h.auction_date_Invalid=1);
    auction_date_LENGTH_ErrorCount := COUNT(GROUP,h.auction_date_Invalid=2);
    auction_date_Total_ErrorCount := COUNT(GROUP,h.auction_date_Invalid>0);
    tax_year_ALLOW_ErrorCount := COUNT(GROUP,h.tax_year_Invalid=1);
    tax_year_LENGTH_ErrorCount := COUNT(GROUP,h.tax_year_Invalid=2);
    tax_year_Total_ErrorCount := COUNT(GROUP,h.tax_year_Invalid>0);
    sales_price_ALLOW_ErrorCount := COUNT(GROUP,h.sales_price_Invalid=1);
    situs_address_indicator_1_ENUM_ErrorCount := COUNT(GROUP,h.situs_address_indicator_1_Invalid=1);
    property_city_1_ALLOW_ErrorCount := COUNT(GROUP,h.property_city_1_Invalid=1);
    property_state_1_ALLOW_ErrorCount := COUNT(GROUP,h.property_state_1_Invalid=1);
    property_address_zip_code_1_ALLOW_ErrorCount := COUNT(GROUP,h.property_address_zip_code_1_Invalid=1);
    property_address_zip_code_1_LENGTH_ErrorCount := COUNT(GROUP,h.property_address_zip_code_1_Invalid=2);
    property_address_zip_code_1_Total_ErrorCount := COUNT(GROUP,h.property_address_zip_code_1_Invalid>0);
    full_site_address_unparsed_1_ALLOW_ErrorCount := COUNT(GROUP,h.full_site_address_unparsed_1_Invalid=1);
    lender_beneficiary_city_ALLOW_ErrorCount := COUNT(GROUP,h.lender_beneficiary_city_Invalid=1);
    lender_beneficiary_state_ALLOW_ErrorCount := COUNT(GROUP,h.lender_beneficiary_state_Invalid=1);
    lender_beneficiary_zip_ALLOW_ErrorCount := COUNT(GROUP,h.lender_beneficiary_zip_Invalid=1);
    lender_beneficiary_zip_LENGTH_ErrorCount := COUNT(GROUP,h.lender_beneficiary_zip_Invalid=2);
    lender_beneficiary_zip_Total_ErrorCount := COUNT(GROUP,h.lender_beneficiary_zip_Invalid>0);
    lender_phone_ALLOW_ErrorCount := COUNT(GROUP,h.lender_phone_Invalid=1);
    lender_phone_LENGTH_ErrorCount := COUNT(GROUP,h.lender_phone_Invalid=2);
    lender_phone_Total_ErrorCount := COUNT(GROUP,h.lender_phone_Invalid>0);
    trustee_phone_ALLOW_ErrorCount := COUNT(GROUP,h.trustee_phone_Invalid=1);
    trustee_phone_LENGTH_ErrorCount := COUNT(GROUP,h.trustee_phone_Invalid=2);
    trustee_phone_Total_ErrorCount := COUNT(GROUP,h.trustee_phone_Invalid>0);
    trustee_sale_number_ALLOW_ErrorCount := COUNT(GROUP,h.trustee_sale_number_Invalid=1);
    original_loan_date_ALLOW_ErrorCount := COUNT(GROUP,h.original_loan_date_Invalid=1);
    original_loan_date_LENGTH_ErrorCount := COUNT(GROUP,h.original_loan_date_Invalid=2);
    original_loan_date_Total_ErrorCount := COUNT(GROUP,h.original_loan_date_Invalid>0);
    original_loan_recording_date_ALLOW_ErrorCount := COUNT(GROUP,h.original_loan_recording_date_Invalid=1);
    original_loan_recording_date_LENGTH_ErrorCount := COUNT(GROUP,h.original_loan_recording_date_Invalid=2);
    original_loan_recording_date_Total_ErrorCount := COUNT(GROUP,h.original_loan_recording_date_Invalid>0);
    original_loan_amount_ALLOW_ErrorCount := COUNT(GROUP,h.original_loan_amount_Invalid=1);
    original_document_number_ALLOW_ErrorCount := COUNT(GROUP,h.original_document_number_Invalid=1);
    parcel_number_parcel_id_ALLOW_ErrorCount := COUNT(GROUP,h.parcel_number_parcel_id_Invalid=1);
    last_full_sale_transfer_date_ALLOW_ErrorCount := COUNT(GROUP,h.last_full_sale_transfer_date_Invalid=1);
    last_full_sale_transfer_date_LENGTH_ErrorCount := COUNT(GROUP,h.last_full_sale_transfer_date_Invalid=2);
    last_full_sale_transfer_date_Total_ErrorCount := COUNT(GROUP,h.last_full_sale_transfer_date_Invalid>0);
    transfer_value_ALLOW_ErrorCount := COUNT(GROUP,h.transfer_value_Invalid=1);
    situs_address_indicator_2_ENUM_ErrorCount := COUNT(GROUP,h.situs_address_indicator_2_Invalid=1);
    property_city_2_ALLOW_ErrorCount := COUNT(GROUP,h.property_city_2_Invalid=1);
    property_state_2_ALLOW_ErrorCount := COUNT(GROUP,h.property_state_2_Invalid=1);
    property_address_zip_code_2_ALLOW_ErrorCount := COUNT(GROUP,h.property_address_zip_code_2_Invalid=1);
    property_address_zip_code_2_LENGTH_ErrorCount := COUNT(GROUP,h.property_address_zip_code_2_Invalid=2);
    property_address_zip_code_2_Total_ErrorCount := COUNT(GROUP,h.property_address_zip_code_2_Invalid>0);
    full_site_address_unparsed_2_ALLOW_ErrorCount := COUNT(GROUP,h.full_site_address_unparsed_2_Invalid=1);
    property_indicator_CUSTOM_ErrorCount := COUNT(GROUP,h.property_indicator_Invalid=1);
    use_code_CUSTOM_ErrorCount := COUNT(GROUP,h.use_code_Invalid=1);
    year_built_ALLOW_ErrorCount := COUNT(GROUP,h.year_built_Invalid=1);
    year_built_LENGTH_ErrorCount := COUNT(GROUP,h.year_built_Invalid=2);
    year_built_Total_ErrorCount := COUNT(GROUP,h.year_built_Invalid>0);
    current_land_value_ALLOW_ErrorCount := COUNT(GROUP,h.current_land_value_Invalid=1);
    current_improvement_value_ALLOW_ErrorCount := COUNT(GROUP,h.current_improvement_value_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT36.StrType ErrorMessage;
    SALT36.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.deed_category_Invalid,le.document_type_Invalid,le.recording_date_Invalid,le.document_year_Invalid,le.document_nbr_Invalid,le.attorney_phone_nbr_Invalid,le.first_defendant_borrower_owner_last_name_Invalid,le.defendant_borrower_owner_et_al_indicator_Invalid,le.date_of_default_Invalid,le.amount_of_default_Invalid,le.filing_date_Invalid,le.court_case_nbr_Invalid,le.final_judgment_amount_Invalid,le.auction_date_Invalid,le.tax_year_Invalid,le.sales_price_Invalid,le.situs_address_indicator_1_Invalid,le.property_city_1_Invalid,le.property_state_1_Invalid,le.property_address_zip_code_1_Invalid,le.full_site_address_unparsed_1_Invalid,le.lender_beneficiary_city_Invalid,le.lender_beneficiary_state_Invalid,le.lender_beneficiary_zip_Invalid,le.lender_phone_Invalid,le.trustee_phone_Invalid,le.trustee_sale_number_Invalid,le.original_loan_date_Invalid,le.original_loan_recording_date_Invalid,le.original_loan_amount_Invalid,le.original_document_number_Invalid,le.parcel_number_parcel_id_Invalid,le.last_full_sale_transfer_date_Invalid,le.transfer_value_Invalid,le.situs_address_indicator_2_Invalid,le.property_city_2_Invalid,le.property_state_2_Invalid,le.property_address_zip_code_2_Invalid,le.full_site_address_unparsed_2_Invalid,le.property_indicator_Invalid,le.use_code_Invalid,le.year_built_Invalid,le.current_land_value_Invalid,le.current_improvement_value_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_deed_category(le.deed_category_Invalid),Fields.InvalidMessage_document_type(le.document_type_Invalid),Fields.InvalidMessage_recording_date(le.recording_date_Invalid),Fields.InvalidMessage_document_year(le.document_year_Invalid),Fields.InvalidMessage_document_nbr(le.document_nbr_Invalid),Fields.InvalidMessage_attorney_phone_nbr(le.attorney_phone_nbr_Invalid),Fields.InvalidMessage_first_defendant_borrower_owner_last_name(le.first_defendant_borrower_owner_last_name_Invalid),Fields.InvalidMessage_defendant_borrower_owner_et_al_indicator(le.defendant_borrower_owner_et_al_indicator_Invalid),Fields.InvalidMessage_date_of_default(le.date_of_default_Invalid),Fields.InvalidMessage_amount_of_default(le.amount_of_default_Invalid),Fields.InvalidMessage_filing_date(le.filing_date_Invalid),Fields.InvalidMessage_court_case_nbr(le.court_case_nbr_Invalid),Fields.InvalidMessage_final_judgment_amount(le.final_judgment_amount_Invalid),Fields.InvalidMessage_auction_date(le.auction_date_Invalid),Fields.InvalidMessage_tax_year(le.tax_year_Invalid),Fields.InvalidMessage_sales_price(le.sales_price_Invalid),Fields.InvalidMessage_situs_address_indicator_1(le.situs_address_indicator_1_Invalid),Fields.InvalidMessage_property_city_1(le.property_city_1_Invalid),Fields.InvalidMessage_property_state_1(le.property_state_1_Invalid),Fields.InvalidMessage_property_address_zip_code_1(le.property_address_zip_code_1_Invalid),Fields.InvalidMessage_full_site_address_unparsed_1(le.full_site_address_unparsed_1_Invalid),Fields.InvalidMessage_lender_beneficiary_city(le.lender_beneficiary_city_Invalid),Fields.InvalidMessage_lender_beneficiary_state(le.lender_beneficiary_state_Invalid),Fields.InvalidMessage_lender_beneficiary_zip(le.lender_beneficiary_zip_Invalid),Fields.InvalidMessage_lender_phone(le.lender_phone_Invalid),Fields.InvalidMessage_trustee_phone(le.trustee_phone_Invalid),Fields.InvalidMessage_trustee_sale_number(le.trustee_sale_number_Invalid),Fields.InvalidMessage_original_loan_date(le.original_loan_date_Invalid),Fields.InvalidMessage_original_loan_recording_date(le.original_loan_recording_date_Invalid),Fields.InvalidMessage_original_loan_amount(le.original_loan_amount_Invalid),Fields.InvalidMessage_original_document_number(le.original_document_number_Invalid),Fields.InvalidMessage_parcel_number_parcel_id(le.parcel_number_parcel_id_Invalid),Fields.InvalidMessage_last_full_sale_transfer_date(le.last_full_sale_transfer_date_Invalid),Fields.InvalidMessage_transfer_value(le.transfer_value_Invalid),Fields.InvalidMessage_situs_address_indicator_2(le.situs_address_indicator_2_Invalid),Fields.InvalidMessage_property_city_2(le.property_city_2_Invalid),Fields.InvalidMessage_property_state_2(le.property_state_2_Invalid),Fields.InvalidMessage_property_address_zip_code_2(le.property_address_zip_code_2_Invalid),Fields.InvalidMessage_full_site_address_unparsed_2(le.full_site_address_unparsed_2_Invalid),Fields.InvalidMessage_property_indicator(le.property_indicator_Invalid),Fields.InvalidMessage_use_code(le.use_code_Invalid),Fields.InvalidMessage_year_built(le.year_built_Invalid),Fields.InvalidMessage_current_land_value(le.current_land_value_Invalid),Fields.InvalidMessage_current_improvement_value(le.current_improvement_value_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.deed_category_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.document_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.recording_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.document_year_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.document_nbr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.attorney_phone_nbr_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.first_defendant_borrower_owner_last_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.defendant_borrower_owner_et_al_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_of_default_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.amount_of_default_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.filing_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.court_case_nbr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.final_judgment_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.auction_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.tax_year_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.sales_price_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.situs_address_indicator_1_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.property_city_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.property_state_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.property_address_zip_code_1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.full_site_address_unparsed_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lender_beneficiary_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lender_beneficiary_state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lender_beneficiary_zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lender_phone_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.trustee_phone_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.trustee_sale_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.original_loan_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.original_loan_recording_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.original_loan_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.original_document_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.parcel_number_parcel_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.last_full_sale_transfer_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.transfer_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.situs_address_indicator_2_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.property_city_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.property_state_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.property_address_zip_code_2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.full_site_address_unparsed_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.property_indicator_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.use_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.year_built_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.current_land_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.current_improvement_value_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','deed_category','document_type','recording_date','document_year','document_nbr','attorney_phone_nbr','first_defendant_borrower_owner_last_name','defendant_borrower_owner_et_al_indicator','date_of_default','amount_of_default','filing_date','court_case_nbr','final_judgment_amount','auction_date','tax_year','sales_price','situs_address_indicator_1','property_city_1','property_state_1','property_address_zip_code_1','full_site_address_unparsed_1','lender_beneficiary_city','lender_beneficiary_state','lender_beneficiary_zip','lender_phone','trustee_phone','trustee_sale_number','original_loan_date','original_loan_recording_date','original_loan_amount','original_document_number','parcel_number_parcel_id','last_full_sale_transfer_date','transfer_value','situs_address_indicator_2','property_city_2','property_state_2','property_address_zip_code_2','full_site_address_unparsed_2','property_indicator','use_code','year_built','current_land_value','current_improvement_value','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_deed_code','invalid_document_code','invalid_date','invalid_year','invalid_apn','invalid_phone','invalid_name','invalid_etal_code','invalid_date','invalid_amount','invalid_date','invalid_case','invalid_amount','invalid_date','invalid_year','invalid_amount','invalid_address_indicator','invalid_alpha','invalid_alpha','invalid_zip','invalid_alpha','invalid_alpha','invalid_alpha','invalid_zip','invalid_phone','invalid_phone','invalid_apn','invalid_date','invalid_date','invalid_amount','invalid_apn','invalid_apn','invalid_date','invalid_amount','invalid_address_indicator','invalid_alpha','invalid_alpha','invalid_zip','invalid_alpha','invalid_property_code','invalid_land_use_code','invalid_year','invalid_amount','invalid_amount','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT36.StrType)le.process_date,(SALT36.StrType)le.deed_category,(SALT36.StrType)le.document_type,(SALT36.StrType)le.recording_date,(SALT36.StrType)le.document_year,(SALT36.StrType)le.document_nbr,(SALT36.StrType)le.attorney_phone_nbr,(SALT36.StrType)le.first_defendant_borrower_owner_last_name,(SALT36.StrType)le.defendant_borrower_owner_et_al_indicator,(SALT36.StrType)le.date_of_default,(SALT36.StrType)le.amount_of_default,(SALT36.StrType)le.filing_date,(SALT36.StrType)le.court_case_nbr,(SALT36.StrType)le.final_judgment_amount,(SALT36.StrType)le.auction_date,(SALT36.StrType)le.tax_year,(SALT36.StrType)le.sales_price,(SALT36.StrType)le.situs_address_indicator_1,(SALT36.StrType)le.property_city_1,(SALT36.StrType)le.property_state_1,(SALT36.StrType)le.property_address_zip_code_1,(SALT36.StrType)le.full_site_address_unparsed_1,(SALT36.StrType)le.lender_beneficiary_city,(SALT36.StrType)le.lender_beneficiary_state,(SALT36.StrType)le.lender_beneficiary_zip,(SALT36.StrType)le.lender_phone,(SALT36.StrType)le.trustee_phone,(SALT36.StrType)le.trustee_sale_number,(SALT36.StrType)le.original_loan_date,(SALT36.StrType)le.original_loan_recording_date,(SALT36.StrType)le.original_loan_amount,(SALT36.StrType)le.original_document_number,(SALT36.StrType)le.parcel_number_parcel_id,(SALT36.StrType)le.last_full_sale_transfer_date,(SALT36.StrType)le.transfer_value,(SALT36.StrType)le.situs_address_indicator_2,(SALT36.StrType)le.property_city_2,(SALT36.StrType)le.property_state_2,(SALT36.StrType)le.property_address_zip_code_2,(SALT36.StrType)le.full_site_address_unparsed_2,(SALT36.StrType)le.property_indicator,(SALT36.StrType)le.use_code,(SALT36.StrType)le.year_built,(SALT36.StrType)le.current_land_value,(SALT36.StrType)le.current_improvement_value,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,45,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT36.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:invalid_date:ALLOW','process_date:invalid_date:LENGTH'
          ,'deed_category:invalid_deed_code:CUSTOM'
          ,'document_type:invalid_document_code:CUSTOM'
          ,'recording_date:invalid_date:ALLOW','recording_date:invalid_date:LENGTH'
          ,'document_year:invalid_year:ALLOW','document_year:invalid_year:LENGTH'
          ,'document_nbr:invalid_apn:ALLOW'
          ,'attorney_phone_nbr:invalid_phone:ALLOW','attorney_phone_nbr:invalid_phone:LENGTH'
          ,'first_defendant_borrower_owner_last_name:invalid_name:ALLOW','first_defendant_borrower_owner_last_name:invalid_name:LENGTH'
          ,'defendant_borrower_owner_et_al_indicator:invalid_etal_code:CUSTOM'
          ,'date_of_default:invalid_date:ALLOW','date_of_default:invalid_date:LENGTH'
          ,'amount_of_default:invalid_amount:ALLOW'
          ,'filing_date:invalid_date:ALLOW','filing_date:invalid_date:LENGTH'
          ,'court_case_nbr:invalid_case:ALLOW'
          ,'final_judgment_amount:invalid_amount:ALLOW'
          ,'auction_date:invalid_date:ALLOW','auction_date:invalid_date:LENGTH'
          ,'tax_year:invalid_year:ALLOW','tax_year:invalid_year:LENGTH'
          ,'sales_price:invalid_amount:ALLOW'
          ,'situs_address_indicator_1:invalid_address_indicator:ENUM'
          ,'property_city_1:invalid_alpha:ALLOW'
          ,'property_state_1:invalid_alpha:ALLOW'
          ,'property_address_zip_code_1:invalid_zip:ALLOW','property_address_zip_code_1:invalid_zip:LENGTH'
          ,'full_site_address_unparsed_1:invalid_alpha:ALLOW'
          ,'lender_beneficiary_city:invalid_alpha:ALLOW'
          ,'lender_beneficiary_state:invalid_alpha:ALLOW'
          ,'lender_beneficiary_zip:invalid_zip:ALLOW','lender_beneficiary_zip:invalid_zip:LENGTH'
          ,'lender_phone:invalid_phone:ALLOW','lender_phone:invalid_phone:LENGTH'
          ,'trustee_phone:invalid_phone:ALLOW','trustee_phone:invalid_phone:LENGTH'
          ,'trustee_sale_number:invalid_apn:ALLOW'
          ,'original_loan_date:invalid_date:ALLOW','original_loan_date:invalid_date:LENGTH'
          ,'original_loan_recording_date:invalid_date:ALLOW','original_loan_recording_date:invalid_date:LENGTH'
          ,'original_loan_amount:invalid_amount:ALLOW'
          ,'original_document_number:invalid_apn:ALLOW'
          ,'parcel_number_parcel_id:invalid_apn:ALLOW'
          ,'last_full_sale_transfer_date:invalid_date:ALLOW','last_full_sale_transfer_date:invalid_date:LENGTH'
          ,'transfer_value:invalid_amount:ALLOW'
          ,'situs_address_indicator_2:invalid_address_indicator:ENUM'
          ,'property_city_2:invalid_alpha:ALLOW'
          ,'property_state_2:invalid_alpha:ALLOW'
          ,'property_address_zip_code_2:invalid_zip:ALLOW','property_address_zip_code_2:invalid_zip:LENGTH'
          ,'full_site_address_unparsed_2:invalid_alpha:ALLOW'
          ,'property_indicator:invalid_property_code:CUSTOM'
          ,'use_code:invalid_land_use_code:CUSTOM'
          ,'year_built:invalid_year:ALLOW','year_built:invalid_year:LENGTH'
          ,'current_land_value:invalid_amount:ALLOW'
          ,'current_improvement_value:invalid_amount:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_process_date(1),Fields.InvalidMessage_process_date(2)
          ,Fields.InvalidMessage_deed_category(1)
          ,Fields.InvalidMessage_document_type(1)
          ,Fields.InvalidMessage_recording_date(1),Fields.InvalidMessage_recording_date(2)
          ,Fields.InvalidMessage_document_year(1),Fields.InvalidMessage_document_year(2)
          ,Fields.InvalidMessage_document_nbr(1)
          ,Fields.InvalidMessage_attorney_phone_nbr(1),Fields.InvalidMessage_attorney_phone_nbr(2)
          ,Fields.InvalidMessage_first_defendant_borrower_owner_last_name(1),Fields.InvalidMessage_first_defendant_borrower_owner_last_name(2)
          ,Fields.InvalidMessage_defendant_borrower_owner_et_al_indicator(1)
          ,Fields.InvalidMessage_date_of_default(1),Fields.InvalidMessage_date_of_default(2)
          ,Fields.InvalidMessage_amount_of_default(1)
          ,Fields.InvalidMessage_filing_date(1),Fields.InvalidMessage_filing_date(2)
          ,Fields.InvalidMessage_court_case_nbr(1)
          ,Fields.InvalidMessage_final_judgment_amount(1)
          ,Fields.InvalidMessage_auction_date(1),Fields.InvalidMessage_auction_date(2)
          ,Fields.InvalidMessage_tax_year(1),Fields.InvalidMessage_tax_year(2)
          ,Fields.InvalidMessage_sales_price(1)
          ,Fields.InvalidMessage_situs_address_indicator_1(1)
          ,Fields.InvalidMessage_property_city_1(1)
          ,Fields.InvalidMessage_property_state_1(1)
          ,Fields.InvalidMessage_property_address_zip_code_1(1),Fields.InvalidMessage_property_address_zip_code_1(2)
          ,Fields.InvalidMessage_full_site_address_unparsed_1(1)
          ,Fields.InvalidMessage_lender_beneficiary_city(1)
          ,Fields.InvalidMessage_lender_beneficiary_state(1)
          ,Fields.InvalidMessage_lender_beneficiary_zip(1),Fields.InvalidMessage_lender_beneficiary_zip(2)
          ,Fields.InvalidMessage_lender_phone(1),Fields.InvalidMessage_lender_phone(2)
          ,Fields.InvalidMessage_trustee_phone(1),Fields.InvalidMessage_trustee_phone(2)
          ,Fields.InvalidMessage_trustee_sale_number(1)
          ,Fields.InvalidMessage_original_loan_date(1),Fields.InvalidMessage_original_loan_date(2)
          ,Fields.InvalidMessage_original_loan_recording_date(1),Fields.InvalidMessage_original_loan_recording_date(2)
          ,Fields.InvalidMessage_original_loan_amount(1)
          ,Fields.InvalidMessage_original_document_number(1)
          ,Fields.InvalidMessage_parcel_number_parcel_id(1)
          ,Fields.InvalidMessage_last_full_sale_transfer_date(1),Fields.InvalidMessage_last_full_sale_transfer_date(2)
          ,Fields.InvalidMessage_transfer_value(1)
          ,Fields.InvalidMessage_situs_address_indicator_2(1)
          ,Fields.InvalidMessage_property_city_2(1)
          ,Fields.InvalidMessage_property_state_2(1)
          ,Fields.InvalidMessage_property_address_zip_code_2(1),Fields.InvalidMessage_property_address_zip_code_2(2)
          ,Fields.InvalidMessage_full_site_address_unparsed_2(1)
          ,Fields.InvalidMessage_property_indicator(1)
          ,Fields.InvalidMessage_use_code(1)
          ,Fields.InvalidMessage_year_built(1),Fields.InvalidMessage_year_built(2)
          ,Fields.InvalidMessage_current_land_value(1)
          ,Fields.InvalidMessage_current_improvement_value(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.deed_category_CUSTOM_ErrorCount
          ,le.document_type_CUSTOM_ErrorCount
          ,le.recording_date_ALLOW_ErrorCount,le.recording_date_LENGTH_ErrorCount
          ,le.document_year_ALLOW_ErrorCount,le.document_year_LENGTH_ErrorCount
          ,le.document_nbr_ALLOW_ErrorCount
          ,le.attorney_phone_nbr_ALLOW_ErrorCount,le.attorney_phone_nbr_LENGTH_ErrorCount
          ,le.first_defendant_borrower_owner_last_name_ALLOW_ErrorCount,le.first_defendant_borrower_owner_last_name_LENGTH_ErrorCount
          ,le.defendant_borrower_owner_et_al_indicator_CUSTOM_ErrorCount
          ,le.date_of_default_ALLOW_ErrorCount,le.date_of_default_LENGTH_ErrorCount
          ,le.amount_of_default_ALLOW_ErrorCount
          ,le.filing_date_ALLOW_ErrorCount,le.filing_date_LENGTH_ErrorCount
          ,le.court_case_nbr_ALLOW_ErrorCount
          ,le.final_judgment_amount_ALLOW_ErrorCount
          ,le.auction_date_ALLOW_ErrorCount,le.auction_date_LENGTH_ErrorCount
          ,le.tax_year_ALLOW_ErrorCount,le.tax_year_LENGTH_ErrorCount
          ,le.sales_price_ALLOW_ErrorCount
          ,le.situs_address_indicator_1_ENUM_ErrorCount
          ,le.property_city_1_ALLOW_ErrorCount
          ,le.property_state_1_ALLOW_ErrorCount
          ,le.property_address_zip_code_1_ALLOW_ErrorCount,le.property_address_zip_code_1_LENGTH_ErrorCount
          ,le.full_site_address_unparsed_1_ALLOW_ErrorCount
          ,le.lender_beneficiary_city_ALLOW_ErrorCount
          ,le.lender_beneficiary_state_ALLOW_ErrorCount
          ,le.lender_beneficiary_zip_ALLOW_ErrorCount,le.lender_beneficiary_zip_LENGTH_ErrorCount
          ,le.lender_phone_ALLOW_ErrorCount,le.lender_phone_LENGTH_ErrorCount
          ,le.trustee_phone_ALLOW_ErrorCount,le.trustee_phone_LENGTH_ErrorCount
          ,le.trustee_sale_number_ALLOW_ErrorCount
          ,le.original_loan_date_ALLOW_ErrorCount,le.original_loan_date_LENGTH_ErrorCount
          ,le.original_loan_recording_date_ALLOW_ErrorCount,le.original_loan_recording_date_LENGTH_ErrorCount
          ,le.original_loan_amount_ALLOW_ErrorCount
          ,le.original_document_number_ALLOW_ErrorCount
          ,le.parcel_number_parcel_id_ALLOW_ErrorCount
          ,le.last_full_sale_transfer_date_ALLOW_ErrorCount,le.last_full_sale_transfer_date_LENGTH_ErrorCount
          ,le.transfer_value_ALLOW_ErrorCount
          ,le.situs_address_indicator_2_ENUM_ErrorCount
          ,le.property_city_2_ALLOW_ErrorCount
          ,le.property_state_2_ALLOW_ErrorCount
          ,le.property_address_zip_code_2_ALLOW_ErrorCount,le.property_address_zip_code_2_LENGTH_ErrorCount
          ,le.full_site_address_unparsed_2_ALLOW_ErrorCount
          ,le.property_indicator_CUSTOM_ErrorCount
          ,le.use_code_CUSTOM_ErrorCount
          ,le.year_built_ALLOW_ErrorCount,le.year_built_LENGTH_ErrorCount
          ,le.current_land_value_ALLOW_ErrorCount
          ,le.current_improvement_value_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.deed_category_CUSTOM_ErrorCount
          ,le.document_type_CUSTOM_ErrorCount
          ,le.recording_date_ALLOW_ErrorCount,le.recording_date_LENGTH_ErrorCount
          ,le.document_year_ALLOW_ErrorCount,le.document_year_LENGTH_ErrorCount
          ,le.document_nbr_ALLOW_ErrorCount
          ,le.attorney_phone_nbr_ALLOW_ErrorCount,le.attorney_phone_nbr_LENGTH_ErrorCount
          ,le.first_defendant_borrower_owner_last_name_ALLOW_ErrorCount,le.first_defendant_borrower_owner_last_name_LENGTH_ErrorCount
          ,le.defendant_borrower_owner_et_al_indicator_CUSTOM_ErrorCount
          ,le.date_of_default_ALLOW_ErrorCount,le.date_of_default_LENGTH_ErrorCount
          ,le.amount_of_default_ALLOW_ErrorCount
          ,le.filing_date_ALLOW_ErrorCount,le.filing_date_LENGTH_ErrorCount
          ,le.court_case_nbr_ALLOW_ErrorCount
          ,le.final_judgment_amount_ALLOW_ErrorCount
          ,le.auction_date_ALLOW_ErrorCount,le.auction_date_LENGTH_ErrorCount
          ,le.tax_year_ALLOW_ErrorCount,le.tax_year_LENGTH_ErrorCount
          ,le.sales_price_ALLOW_ErrorCount
          ,le.situs_address_indicator_1_ENUM_ErrorCount
          ,le.property_city_1_ALLOW_ErrorCount
          ,le.property_state_1_ALLOW_ErrorCount
          ,le.property_address_zip_code_1_ALLOW_ErrorCount,le.property_address_zip_code_1_LENGTH_ErrorCount
          ,le.full_site_address_unparsed_1_ALLOW_ErrorCount
          ,le.lender_beneficiary_city_ALLOW_ErrorCount
          ,le.lender_beneficiary_state_ALLOW_ErrorCount
          ,le.lender_beneficiary_zip_ALLOW_ErrorCount,le.lender_beneficiary_zip_LENGTH_ErrorCount
          ,le.lender_phone_ALLOW_ErrorCount,le.lender_phone_LENGTH_ErrorCount
          ,le.trustee_phone_ALLOW_ErrorCount,le.trustee_phone_LENGTH_ErrorCount
          ,le.trustee_sale_number_ALLOW_ErrorCount
          ,le.original_loan_date_ALLOW_ErrorCount,le.original_loan_date_LENGTH_ErrorCount
          ,le.original_loan_recording_date_ALLOW_ErrorCount,le.original_loan_recording_date_LENGTH_ErrorCount
          ,le.original_loan_amount_ALLOW_ErrorCount
          ,le.original_document_number_ALLOW_ErrorCount
          ,le.parcel_number_parcel_id_ALLOW_ErrorCount
          ,le.last_full_sale_transfer_date_ALLOW_ErrorCount,le.last_full_sale_transfer_date_LENGTH_ErrorCount
          ,le.transfer_value_ALLOW_ErrorCount
          ,le.situs_address_indicator_2_ENUM_ErrorCount
          ,le.property_city_2_ALLOW_ErrorCount
          ,le.property_state_2_ALLOW_ErrorCount
          ,le.property_address_zip_code_2_ALLOW_ErrorCount,le.property_address_zip_code_2_LENGTH_ErrorCount
          ,le.full_site_address_unparsed_2_ALLOW_ErrorCount
          ,le.property_indicator_CUSTOM_ErrorCount
          ,le.use_code_CUSTOM_ErrorCount
          ,le.year_built_ALLOW_ErrorCount,le.year_built_LENGTH_ErrorCount
          ,le.current_land_value_ALLOW_ErrorCount
          ,le.current_improvement_value_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,63,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT36.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT36.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
