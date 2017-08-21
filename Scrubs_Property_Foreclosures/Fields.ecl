IMPORT SALT36;
IMPORT Scrubs_Property_Foreclosures; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT36.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_number','invalid_alpha','invalid_apn','invalid_zip','invalid_year','invalid_date','invalid_phone','invalid_amount','invalid_deed_code','invalid_document_code','invalid_etal_code','invalid_property_code','invalid_land_use_code','invalid_address_indicator','invalid_case','invalid_name');
EXPORT FieldTypeNum(SALT36.StrType fn) := CASE(fn,'invalid_number' => 1,'invalid_alpha' => 2,'invalid_apn' => 3,'invalid_zip' => 4,'invalid_year' => 5,'invalid_date' => 6,'invalid_phone' => 7,'invalid_amount' => 8,'invalid_deed_code' => 9,'invalid_document_code' => 10,'invalid_etal_code' => 11,'invalid_property_code' => 12,'invalid_land_use_code' => 13,'invalid_address_indicator' => 14,'invalid_case' => 15,'invalid_name' => 16,0);
 
EXPORT MakeFT_invalid_number(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_number(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_number(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('0123456789'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./#()'); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' <>{}[]-^=!+&,./#()',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./#()'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' <>{}[]-^=!+&,./#()'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_apn(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -./:'); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' -./:',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_apn(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -./:'))));
EXPORT InValidMessageFT_invalid_apn(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -./:'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('0123456789'),SALT36.HygieneErrors.NotLength('0,5,9'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_year(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_year(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_year(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('0123456789'),SALT36.HygieneErrors.NotLength('0,4'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('0123456789'),SALT36.HygieneErrors.NotLength('0,4,6,8,10'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_phone(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 7 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('0123456789'),SALT36.HygieneErrors.NotLength('0,7,10'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_amount(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_amount(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_amount(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('0123456789'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_deed_code(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_deed_code(SALT36.StrType s) := WHICH(~Scrubs_Property_Foreclosures.fn_valid_codes(s,'deed')>0);
EXPORT InValidMessageFT_invalid_deed_code(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.CustomFail('Scrubs_Property_Foreclosures.fn_valid_codes'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_document_code(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_document_code(SALT36.StrType s) := WHICH(~Scrubs_Property_Foreclosures.fn_valid_codes(s,'document')>0);
EXPORT InValidMessageFT_invalid_document_code(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.CustomFail('Scrubs_Property_Foreclosures.fn_valid_codes'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_etal_code(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_etal_code(SALT36.StrType s) := WHICH(~Scrubs_Property_Foreclosures.fn_valid_codes(s,'etal')>0);
EXPORT InValidMessageFT_invalid_etal_code(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.CustomFail('Scrubs_Property_Foreclosures.fn_valid_codes'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_property_code(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_property_code(SALT36.StrType s) := WHICH(~Scrubs_Property_Foreclosures.fn_valid_codes(s,'property')>0);
EXPORT InValidMessageFT_invalid_property_code(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.CustomFail('Scrubs_Property_Foreclosures.fn_valid_codes'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_land_use_code(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_land_use_code(SALT36.StrType s) := WHICH(~Scrubs_Property_Foreclosures.fn_valid_codes(s,'land_use')>0);
EXPORT InValidMessageFT_invalid_land_use_code(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.CustomFail('Scrubs_Property_Foreclosures.fn_valid_codes'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address_indicator(SALT36.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_address_indicator(SALT36.StrType s) := WHICH(((SALT36.StrType) s) NOT IN ['S','M','U','']);
EXPORT InValidMessageFT_invalid_address_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInEnum('S|M|U|'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_case(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' {}-&,./#():'); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' {}-&,./#():',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_case(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' {}-&,./#():'))));
EXPORT InValidMessageFT_invalid_case(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' {}-&,./#():'),SALT36.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT36.StrType s0) := FUNCTION
  s1 := SALT36.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -,.()'); // Only allow valid symbols
  s2 := SALT36.stringcleanspaces( SALT36.stringsubstituteout(s1,' -,.()',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_name(SALT36.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT36.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -,.()'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 3));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT36.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\' -,.()'),SALT36.HygieneErrors.NotLength('0,3..'),SALT36.HygieneErrors.Good);
 
EXPORT SALT36.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'foreclosure_id','process_date','state','county','batch_date_and_seq_nbr','deed_category','document_type','recording_date','document_year','document_nbr','document_book','document_pages','title_company_code','title_company_name','attorney_name','attorney_phone_nbr','first_defendant_borrower_owner_first_name','first_defendant_borrower_owner_last_name','first_defendant_borrower_company_name','second_defendant_borrower_owner_first_name','second_defendant_borrower_owner_last_name','second_defendant_borrower_company_name','third_defendant_borrower_owner_first_name','third_defendant_borrower_owner_last_name','third_defendant_borrower_company_name','fourth_defendant_borrower_owner_first_name','fourth_defendant_borrower_owner_last_name','fourth_defendant_borrower_company_name','defendant_borrower_owner_et_al_indicator','filler1','date_of_default','amount_of_default','filler2','filing_date','court_case_nbr','lis_pendens_type','plaintiff_1','plaintiff_2','final_judgment_amount','filler_3','auction_date','auction_time','street_address_of_auction_call','city_of_auction_call','state_of_auction_call','opening_bid','tax_year','filler4','sales_price','situs_address_indicator_1','situs_house_number_prefix_1','situs_house_number_1','situs_house_number_suffix_1','situs_street_name_1','situs_mode_1','situs_direction_1','situs_quadrant_1','apartment_unit','property_city_1','property_state_1','property_address_zip_code_1','carrier_code','full_site_address_unparsed_1','lender_beneficiary_first_name','lender_beneficiary_last_name','lender_beneficiary_company_name','lender_beneficiary_mailing_address','lender_beneficiary_city','lender_beneficiary_state','lender_beneficiary_zip','lender_phone','filler_5','trustee_name','trustee_mailing_address','trustee_city','trustee_state','trustee_zip','trustee_phone','trustee_sale_number','filler_6','original_loan_date','original_loan_recording_date','original_loan_amount','original_document_number','original_recording_book','original_recording_page','filler_7','parcel_number_parcel_id','parcel_number_unmatched_id','last_full_sale_transfer_date','transfer_value','situs_address_indicator_2','situs_house_number_prefix_2','situs_house_number_2','situs_house_number_suffix_2','situs_street_name_2','situs_mode_2','situs_direction_2','situs_quadrant_2','apartment_unit_2','property_city_2','property_state_2','property_address_zip_code_2','carrier_code_2','full_site_address_unparsed_2','property_indicator','use_code','number_of_units','living_area_square_feet','number_of_bedrooms','number_of_bathrooms','number_of_garages','zoning_code','lot_size','year_built','current_land_value','current_improvement_value','filler_8','section','township','range','lot','block','tract_subdivision_name','map_book','map_page','unit_nbr','expanded_legal','legal_2','legal_3','legal_4','crlf','deed_desc','document_desc','et_al_desc','property_desc','use_desc');
EXPORT FieldNum(SALT36.StrType fn) := CASE(fn,'foreclosure_id' => 0,'process_date' => 1,'state' => 2,'county' => 3,'batch_date_and_seq_nbr' => 4,'deed_category' => 5,'document_type' => 6,'recording_date' => 7,'document_year' => 8,'document_nbr' => 9,'document_book' => 10,'document_pages' => 11,'title_company_code' => 12,'title_company_name' => 13,'attorney_name' => 14,'attorney_phone_nbr' => 15,'first_defendant_borrower_owner_first_name' => 16,'first_defendant_borrower_owner_last_name' => 17,'first_defendant_borrower_company_name' => 18,'second_defendant_borrower_owner_first_name' => 19,'second_defendant_borrower_owner_last_name' => 20,'second_defendant_borrower_company_name' => 21,'third_defendant_borrower_owner_first_name' => 22,'third_defendant_borrower_owner_last_name' => 23,'third_defendant_borrower_company_name' => 24,'fourth_defendant_borrower_owner_first_name' => 25,'fourth_defendant_borrower_owner_last_name' => 26,'fourth_defendant_borrower_company_name' => 27,'defendant_borrower_owner_et_al_indicator' => 28,'filler1' => 29,'date_of_default' => 30,'amount_of_default' => 31,'filler2' => 32,'filing_date' => 33,'court_case_nbr' => 34,'lis_pendens_type' => 35,'plaintiff_1' => 36,'plaintiff_2' => 37,'final_judgment_amount' => 38,'filler_3' => 39,'auction_date' => 40,'auction_time' => 41,'street_address_of_auction_call' => 42,'city_of_auction_call' => 43,'state_of_auction_call' => 44,'opening_bid' => 45,'tax_year' => 46,'filler4' => 47,'sales_price' => 48,'situs_address_indicator_1' => 49,'situs_house_number_prefix_1' => 50,'situs_house_number_1' => 51,'situs_house_number_suffix_1' => 52,'situs_street_name_1' => 53,'situs_mode_1' => 54,'situs_direction_1' => 55,'situs_quadrant_1' => 56,'apartment_unit' => 57,'property_city_1' => 58,'property_state_1' => 59,'property_address_zip_code_1' => 60,'carrier_code' => 61,'full_site_address_unparsed_1' => 62,'lender_beneficiary_first_name' => 63,'lender_beneficiary_last_name' => 64,'lender_beneficiary_company_name' => 65,'lender_beneficiary_mailing_address' => 66,'lender_beneficiary_city' => 67,'lender_beneficiary_state' => 68,'lender_beneficiary_zip' => 69,'lender_phone' => 70,'filler_5' => 71,'trustee_name' => 72,'trustee_mailing_address' => 73,'trustee_city' => 74,'trustee_state' => 75,'trustee_zip' => 76,'trustee_phone' => 77,'trustee_sale_number' => 78,'filler_6' => 79,'original_loan_date' => 80,'original_loan_recording_date' => 81,'original_loan_amount' => 82,'original_document_number' => 83,'original_recording_book' => 84,'original_recording_page' => 85,'filler_7' => 86,'parcel_number_parcel_id' => 87,'parcel_number_unmatched_id' => 88,'last_full_sale_transfer_date' => 89,'transfer_value' => 90,'situs_address_indicator_2' => 91,'situs_house_number_prefix_2' => 92,'situs_house_number_2' => 93,'situs_house_number_suffix_2' => 94,'situs_street_name_2' => 95,'situs_mode_2' => 96,'situs_direction_2' => 97,'situs_quadrant_2' => 98,'apartment_unit_2' => 99,'property_city_2' => 100,'property_state_2' => 101,'property_address_zip_code_2' => 102,'carrier_code_2' => 103,'full_site_address_unparsed_2' => 104,'property_indicator' => 105,'use_code' => 106,'number_of_units' => 107,'living_area_square_feet' => 108,'number_of_bedrooms' => 109,'number_of_bathrooms' => 110,'number_of_garages' => 111,'zoning_code' => 112,'lot_size' => 113,'year_built' => 114,'current_land_value' => 115,'current_improvement_value' => 116,'filler_8' => 117,'section' => 118,'township' => 119,'range' => 120,'lot' => 121,'block' => 122,'tract_subdivision_name' => 123,'map_book' => 124,'map_page' => 125,'unit_nbr' => 126,'expanded_legal' => 127,'legal_2' => 128,'legal_3' => 129,'legal_4' => 130,'crlf' => 131,'deed_desc' => 132,'document_desc' => 133,'et_al_desc' => 134,'property_desc' => 135,'use_desc' => 136,0);
 
//Individual field level validation
 
EXPORT Make_foreclosure_id(SALT36.StrType s0) := s0;
EXPORT InValid_foreclosure_id(SALT36.StrType s) := 0;
EXPORT InValidMessage_foreclosure_id(UNSIGNED1 wh) := '';
 
EXPORT Make_process_date(SALT36.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_process_date(SALT36.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_state(SALT36.StrType s0) := s0;
EXPORT InValid_state(SALT36.StrType s) := 0;
EXPORT InValidMessage_state(UNSIGNED1 wh) := '';
 
EXPORT Make_county(SALT36.StrType s0) := s0;
EXPORT InValid_county(SALT36.StrType s) := 0;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
 
EXPORT Make_batch_date_and_seq_nbr(SALT36.StrType s0) := s0;
EXPORT InValid_batch_date_and_seq_nbr(SALT36.StrType s) := 0;
EXPORT InValidMessage_batch_date_and_seq_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_deed_category(SALT36.StrType s0) := MakeFT_invalid_deed_code(s0);
EXPORT InValid_deed_category(SALT36.StrType s) := InValidFT_invalid_deed_code(s);
EXPORT InValidMessage_deed_category(UNSIGNED1 wh) := InValidMessageFT_invalid_deed_code(wh);
 
EXPORT Make_document_type(SALT36.StrType s0) := MakeFT_invalid_document_code(s0);
EXPORT InValid_document_type(SALT36.StrType s) := InValidFT_invalid_document_code(s);
EXPORT InValidMessage_document_type(UNSIGNED1 wh) := InValidMessageFT_invalid_document_code(wh);
 
EXPORT Make_recording_date(SALT36.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_recording_date(SALT36.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_recording_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_document_year(SALT36.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_document_year(SALT36.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_document_year(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_document_nbr(SALT36.StrType s0) := MakeFT_invalid_apn(s0);
EXPORT InValid_document_nbr(SALT36.StrType s) := InValidFT_invalid_apn(s);
EXPORT InValidMessage_document_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_apn(wh);
 
EXPORT Make_document_book(SALT36.StrType s0) := s0;
EXPORT InValid_document_book(SALT36.StrType s) := 0;
EXPORT InValidMessage_document_book(UNSIGNED1 wh) := '';
 
EXPORT Make_document_pages(SALT36.StrType s0) := s0;
EXPORT InValid_document_pages(SALT36.StrType s) := 0;
EXPORT InValidMessage_document_pages(UNSIGNED1 wh) := '';
 
EXPORT Make_title_company_code(SALT36.StrType s0) := s0;
EXPORT InValid_title_company_code(SALT36.StrType s) := 0;
EXPORT InValidMessage_title_company_code(UNSIGNED1 wh) := '';
 
EXPORT Make_title_company_name(SALT36.StrType s0) := s0;
EXPORT InValid_title_company_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_title_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_attorney_name(SALT36.StrType s0) := s0;
EXPORT InValid_attorney_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_attorney_name(UNSIGNED1 wh) := '';
 
EXPORT Make_attorney_phone_nbr(SALT36.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_attorney_phone_nbr(SALT36.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_attorney_phone_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_first_defendant_borrower_owner_first_name(SALT36.StrType s0) := s0;
EXPORT InValid_first_defendant_borrower_owner_first_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_first_defendant_borrower_owner_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_first_defendant_borrower_owner_last_name(SALT36.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_first_defendant_borrower_owner_last_name(SALT36.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_first_defendant_borrower_owner_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_first_defendant_borrower_company_name(SALT36.StrType s0) := s0;
EXPORT InValid_first_defendant_borrower_company_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_first_defendant_borrower_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_second_defendant_borrower_owner_first_name(SALT36.StrType s0) := s0;
EXPORT InValid_second_defendant_borrower_owner_first_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_second_defendant_borrower_owner_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_second_defendant_borrower_owner_last_name(SALT36.StrType s0) := s0;
EXPORT InValid_second_defendant_borrower_owner_last_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_second_defendant_borrower_owner_last_name(UNSIGNED1 wh) := '';
 
EXPORT Make_second_defendant_borrower_company_name(SALT36.StrType s0) := s0;
EXPORT InValid_second_defendant_borrower_company_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_second_defendant_borrower_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_third_defendant_borrower_owner_first_name(SALT36.StrType s0) := s0;
EXPORT InValid_third_defendant_borrower_owner_first_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_third_defendant_borrower_owner_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_third_defendant_borrower_owner_last_name(SALT36.StrType s0) := s0;
EXPORT InValid_third_defendant_borrower_owner_last_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_third_defendant_borrower_owner_last_name(UNSIGNED1 wh) := '';
 
EXPORT Make_third_defendant_borrower_company_name(SALT36.StrType s0) := s0;
EXPORT InValid_third_defendant_borrower_company_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_third_defendant_borrower_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_fourth_defendant_borrower_owner_first_name(SALT36.StrType s0) := s0;
EXPORT InValid_fourth_defendant_borrower_owner_first_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_fourth_defendant_borrower_owner_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_fourth_defendant_borrower_owner_last_name(SALT36.StrType s0) := s0;
EXPORT InValid_fourth_defendant_borrower_owner_last_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_fourth_defendant_borrower_owner_last_name(UNSIGNED1 wh) := '';
 
EXPORT Make_fourth_defendant_borrower_company_name(SALT36.StrType s0) := s0;
EXPORT InValid_fourth_defendant_borrower_company_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_fourth_defendant_borrower_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_defendant_borrower_owner_et_al_indicator(SALT36.StrType s0) := MakeFT_invalid_etal_code(s0);
EXPORT InValid_defendant_borrower_owner_et_al_indicator(SALT36.StrType s) := InValidFT_invalid_etal_code(s);
EXPORT InValidMessage_defendant_borrower_owner_et_al_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_etal_code(wh);
 
EXPORT Make_filler1(SALT36.StrType s0) := s0;
EXPORT InValid_filler1(SALT36.StrType s) := 0;
EXPORT InValidMessage_filler1(UNSIGNED1 wh) := '';
 
EXPORT Make_date_of_default(SALT36.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_date_of_default(SALT36.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_date_of_default(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_amount_of_default(SALT36.StrType s0) := MakeFT_invalid_amount(s0);
EXPORT InValid_amount_of_default(SALT36.StrType s) := InValidFT_invalid_amount(s);
EXPORT InValidMessage_amount_of_default(UNSIGNED1 wh) := InValidMessageFT_invalid_amount(wh);
 
EXPORT Make_filler2(SALT36.StrType s0) := s0;
EXPORT InValid_filler2(SALT36.StrType s) := 0;
EXPORT InValidMessage_filler2(UNSIGNED1 wh) := '';
 
EXPORT Make_filing_date(SALT36.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_filing_date(SALT36.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_filing_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_court_case_nbr(SALT36.StrType s0) := MakeFT_invalid_case(s0);
EXPORT InValid_court_case_nbr(SALT36.StrType s) := InValidFT_invalid_case(s);
EXPORT InValidMessage_court_case_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_case(wh);
 
EXPORT Make_lis_pendens_type(SALT36.StrType s0) := s0;
EXPORT InValid_lis_pendens_type(SALT36.StrType s) := 0;
EXPORT InValidMessage_lis_pendens_type(UNSIGNED1 wh) := '';
 
EXPORT Make_plaintiff_1(SALT36.StrType s0) := s0;
EXPORT InValid_plaintiff_1(SALT36.StrType s) := 0;
EXPORT InValidMessage_plaintiff_1(UNSIGNED1 wh) := '';
 
EXPORT Make_plaintiff_2(SALT36.StrType s0) := s0;
EXPORT InValid_plaintiff_2(SALT36.StrType s) := 0;
EXPORT InValidMessage_plaintiff_2(UNSIGNED1 wh) := '';
 
EXPORT Make_final_judgment_amount(SALT36.StrType s0) := MakeFT_invalid_amount(s0);
EXPORT InValid_final_judgment_amount(SALT36.StrType s) := InValidFT_invalid_amount(s);
EXPORT InValidMessage_final_judgment_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_amount(wh);
 
EXPORT Make_filler_3(SALT36.StrType s0) := s0;
EXPORT InValid_filler_3(SALT36.StrType s) := 0;
EXPORT InValidMessage_filler_3(UNSIGNED1 wh) := '';
 
EXPORT Make_auction_date(SALT36.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_auction_date(SALT36.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_auction_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_auction_time(SALT36.StrType s0) := s0;
EXPORT InValid_auction_time(SALT36.StrType s) := 0;
EXPORT InValidMessage_auction_time(UNSIGNED1 wh) := '';
 
EXPORT Make_street_address_of_auction_call(SALT36.StrType s0) := s0;
EXPORT InValid_street_address_of_auction_call(SALT36.StrType s) := 0;
EXPORT InValidMessage_street_address_of_auction_call(UNSIGNED1 wh) := '';
 
EXPORT Make_city_of_auction_call(SALT36.StrType s0) := s0;
EXPORT InValid_city_of_auction_call(SALT36.StrType s) := 0;
EXPORT InValidMessage_city_of_auction_call(UNSIGNED1 wh) := '';
 
EXPORT Make_state_of_auction_call(SALT36.StrType s0) := s0;
EXPORT InValid_state_of_auction_call(SALT36.StrType s) := 0;
EXPORT InValidMessage_state_of_auction_call(UNSIGNED1 wh) := '';
 
EXPORT Make_opening_bid(SALT36.StrType s0) := s0;
EXPORT InValid_opening_bid(SALT36.StrType s) := 0;
EXPORT InValidMessage_opening_bid(UNSIGNED1 wh) := '';
 
EXPORT Make_tax_year(SALT36.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_tax_year(SALT36.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_tax_year(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_filler4(SALT36.StrType s0) := s0;
EXPORT InValid_filler4(SALT36.StrType s) := 0;
EXPORT InValidMessage_filler4(UNSIGNED1 wh) := '';
 
EXPORT Make_sales_price(SALT36.StrType s0) := MakeFT_invalid_amount(s0);
EXPORT InValid_sales_price(SALT36.StrType s) := InValidFT_invalid_amount(s);
EXPORT InValidMessage_sales_price(UNSIGNED1 wh) := InValidMessageFT_invalid_amount(wh);
 
EXPORT Make_situs_address_indicator_1(SALT36.StrType s0) := MakeFT_invalid_address_indicator(s0);
EXPORT InValid_situs_address_indicator_1(SALT36.StrType s) := InValidFT_invalid_address_indicator(s);
EXPORT InValidMessage_situs_address_indicator_1(UNSIGNED1 wh) := InValidMessageFT_invalid_address_indicator(wh);
 
EXPORT Make_situs_house_number_prefix_1(SALT36.StrType s0) := s0;
EXPORT InValid_situs_house_number_prefix_1(SALT36.StrType s) := 0;
EXPORT InValidMessage_situs_house_number_prefix_1(UNSIGNED1 wh) := '';
 
EXPORT Make_situs_house_number_1(SALT36.StrType s0) := s0;
EXPORT InValid_situs_house_number_1(SALT36.StrType s) := 0;
EXPORT InValidMessage_situs_house_number_1(UNSIGNED1 wh) := '';
 
EXPORT Make_situs_house_number_suffix_1(SALT36.StrType s0) := s0;
EXPORT InValid_situs_house_number_suffix_1(SALT36.StrType s) := 0;
EXPORT InValidMessage_situs_house_number_suffix_1(UNSIGNED1 wh) := '';
 
EXPORT Make_situs_street_name_1(SALT36.StrType s0) := s0;
EXPORT InValid_situs_street_name_1(SALT36.StrType s) := 0;
EXPORT InValidMessage_situs_street_name_1(UNSIGNED1 wh) := '';
 
EXPORT Make_situs_mode_1(SALT36.StrType s0) := s0;
EXPORT InValid_situs_mode_1(SALT36.StrType s) := 0;
EXPORT InValidMessage_situs_mode_1(UNSIGNED1 wh) := '';
 
EXPORT Make_situs_direction_1(SALT36.StrType s0) := s0;
EXPORT InValid_situs_direction_1(SALT36.StrType s) := 0;
EXPORT InValidMessage_situs_direction_1(UNSIGNED1 wh) := '';
 
EXPORT Make_situs_quadrant_1(SALT36.StrType s0) := s0;
EXPORT InValid_situs_quadrant_1(SALT36.StrType s) := 0;
EXPORT InValidMessage_situs_quadrant_1(UNSIGNED1 wh) := '';
 
EXPORT Make_apartment_unit(SALT36.StrType s0) := s0;
EXPORT InValid_apartment_unit(SALT36.StrType s) := 0;
EXPORT InValidMessage_apartment_unit(UNSIGNED1 wh) := '';
 
EXPORT Make_property_city_1(SALT36.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_property_city_1(SALT36.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_property_city_1(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_property_state_1(SALT36.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_property_state_1(SALT36.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_property_state_1(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_property_address_zip_code_1(SALT36.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_property_address_zip_code_1(SALT36.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_property_address_zip_code_1(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_carrier_code(SALT36.StrType s0) := s0;
EXPORT InValid_carrier_code(SALT36.StrType s) := 0;
EXPORT InValidMessage_carrier_code(UNSIGNED1 wh) := '';
 
EXPORT Make_full_site_address_unparsed_1(SALT36.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_full_site_address_unparsed_1(SALT36.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_full_site_address_unparsed_1(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_lender_beneficiary_first_name(SALT36.StrType s0) := s0;
EXPORT InValid_lender_beneficiary_first_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_lender_beneficiary_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_lender_beneficiary_last_name(SALT36.StrType s0) := s0;
EXPORT InValid_lender_beneficiary_last_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_lender_beneficiary_last_name(UNSIGNED1 wh) := '';
 
EXPORT Make_lender_beneficiary_company_name(SALT36.StrType s0) := s0;
EXPORT InValid_lender_beneficiary_company_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_lender_beneficiary_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_lender_beneficiary_mailing_address(SALT36.StrType s0) := s0;
EXPORT InValid_lender_beneficiary_mailing_address(SALT36.StrType s) := 0;
EXPORT InValidMessage_lender_beneficiary_mailing_address(UNSIGNED1 wh) := '';
 
EXPORT Make_lender_beneficiary_city(SALT36.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_lender_beneficiary_city(SALT36.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_lender_beneficiary_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_lender_beneficiary_state(SALT36.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_lender_beneficiary_state(SALT36.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_lender_beneficiary_state(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_lender_beneficiary_zip(SALT36.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_lender_beneficiary_zip(SALT36.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_lender_beneficiary_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_lender_phone(SALT36.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_lender_phone(SALT36.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_lender_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_filler_5(SALT36.StrType s0) := s0;
EXPORT InValid_filler_5(SALT36.StrType s) := 0;
EXPORT InValidMessage_filler_5(UNSIGNED1 wh) := '';
 
EXPORT Make_trustee_name(SALT36.StrType s0) := s0;
EXPORT InValid_trustee_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_trustee_name(UNSIGNED1 wh) := '';
 
EXPORT Make_trustee_mailing_address(SALT36.StrType s0) := s0;
EXPORT InValid_trustee_mailing_address(SALT36.StrType s) := 0;
EXPORT InValidMessage_trustee_mailing_address(UNSIGNED1 wh) := '';
 
EXPORT Make_trustee_city(SALT36.StrType s0) := s0;
EXPORT InValid_trustee_city(SALT36.StrType s) := 0;
EXPORT InValidMessage_trustee_city(UNSIGNED1 wh) := '';
 
EXPORT Make_trustee_state(SALT36.StrType s0) := s0;
EXPORT InValid_trustee_state(SALT36.StrType s) := 0;
EXPORT InValidMessage_trustee_state(UNSIGNED1 wh) := '';
 
EXPORT Make_trustee_zip(SALT36.StrType s0) := s0;
EXPORT InValid_trustee_zip(SALT36.StrType s) := 0;
EXPORT InValidMessage_trustee_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_trustee_phone(SALT36.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_trustee_phone(SALT36.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_trustee_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_trustee_sale_number(SALT36.StrType s0) := MakeFT_invalid_apn(s0);
EXPORT InValid_trustee_sale_number(SALT36.StrType s) := InValidFT_invalid_apn(s);
EXPORT InValidMessage_trustee_sale_number(UNSIGNED1 wh) := InValidMessageFT_invalid_apn(wh);
 
EXPORT Make_filler_6(SALT36.StrType s0) := s0;
EXPORT InValid_filler_6(SALT36.StrType s) := 0;
EXPORT InValidMessage_filler_6(UNSIGNED1 wh) := '';
 
EXPORT Make_original_loan_date(SALT36.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_original_loan_date(SALT36.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_original_loan_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_original_loan_recording_date(SALT36.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_original_loan_recording_date(SALT36.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_original_loan_recording_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_original_loan_amount(SALT36.StrType s0) := MakeFT_invalid_amount(s0);
EXPORT InValid_original_loan_amount(SALT36.StrType s) := InValidFT_invalid_amount(s);
EXPORT InValidMessage_original_loan_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_amount(wh);
 
EXPORT Make_original_document_number(SALT36.StrType s0) := MakeFT_invalid_apn(s0);
EXPORT InValid_original_document_number(SALT36.StrType s) := InValidFT_invalid_apn(s);
EXPORT InValidMessage_original_document_number(UNSIGNED1 wh) := InValidMessageFT_invalid_apn(wh);
 
EXPORT Make_original_recording_book(SALT36.StrType s0) := s0;
EXPORT InValid_original_recording_book(SALT36.StrType s) := 0;
EXPORT InValidMessage_original_recording_book(UNSIGNED1 wh) := '';
 
EXPORT Make_original_recording_page(SALT36.StrType s0) := s0;
EXPORT InValid_original_recording_page(SALT36.StrType s) := 0;
EXPORT InValidMessage_original_recording_page(UNSIGNED1 wh) := '';
 
EXPORT Make_filler_7(SALT36.StrType s0) := s0;
EXPORT InValid_filler_7(SALT36.StrType s) := 0;
EXPORT InValidMessage_filler_7(UNSIGNED1 wh) := '';
 
EXPORT Make_parcel_number_parcel_id(SALT36.StrType s0) := MakeFT_invalid_apn(s0);
EXPORT InValid_parcel_number_parcel_id(SALT36.StrType s) := InValidFT_invalid_apn(s);
EXPORT InValidMessage_parcel_number_parcel_id(UNSIGNED1 wh) := InValidMessageFT_invalid_apn(wh);
 
EXPORT Make_parcel_number_unmatched_id(SALT36.StrType s0) := s0;
EXPORT InValid_parcel_number_unmatched_id(SALT36.StrType s) := 0;
EXPORT InValidMessage_parcel_number_unmatched_id(UNSIGNED1 wh) := '';
 
EXPORT Make_last_full_sale_transfer_date(SALT36.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_last_full_sale_transfer_date(SALT36.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_last_full_sale_transfer_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_transfer_value(SALT36.StrType s0) := MakeFT_invalid_amount(s0);
EXPORT InValid_transfer_value(SALT36.StrType s) := InValidFT_invalid_amount(s);
EXPORT InValidMessage_transfer_value(UNSIGNED1 wh) := InValidMessageFT_invalid_amount(wh);
 
EXPORT Make_situs_address_indicator_2(SALT36.StrType s0) := MakeFT_invalid_address_indicator(s0);
EXPORT InValid_situs_address_indicator_2(SALT36.StrType s) := InValidFT_invalid_address_indicator(s);
EXPORT InValidMessage_situs_address_indicator_2(UNSIGNED1 wh) := InValidMessageFT_invalid_address_indicator(wh);
 
EXPORT Make_situs_house_number_prefix_2(SALT36.StrType s0) := s0;
EXPORT InValid_situs_house_number_prefix_2(SALT36.StrType s) := 0;
EXPORT InValidMessage_situs_house_number_prefix_2(UNSIGNED1 wh) := '';
 
EXPORT Make_situs_house_number_2(SALT36.StrType s0) := s0;
EXPORT InValid_situs_house_number_2(SALT36.StrType s) := 0;
EXPORT InValidMessage_situs_house_number_2(UNSIGNED1 wh) := '';
 
EXPORT Make_situs_house_number_suffix_2(SALT36.StrType s0) := s0;
EXPORT InValid_situs_house_number_suffix_2(SALT36.StrType s) := 0;
EXPORT InValidMessage_situs_house_number_suffix_2(UNSIGNED1 wh) := '';
 
EXPORT Make_situs_street_name_2(SALT36.StrType s0) := s0;
EXPORT InValid_situs_street_name_2(SALT36.StrType s) := 0;
EXPORT InValidMessage_situs_street_name_2(UNSIGNED1 wh) := '';
 
EXPORT Make_situs_mode_2(SALT36.StrType s0) := s0;
EXPORT InValid_situs_mode_2(SALT36.StrType s) := 0;
EXPORT InValidMessage_situs_mode_2(UNSIGNED1 wh) := '';
 
EXPORT Make_situs_direction_2(SALT36.StrType s0) := s0;
EXPORT InValid_situs_direction_2(SALT36.StrType s) := 0;
EXPORT InValidMessage_situs_direction_2(UNSIGNED1 wh) := '';
 
EXPORT Make_situs_quadrant_2(SALT36.StrType s0) := s0;
EXPORT InValid_situs_quadrant_2(SALT36.StrType s) := 0;
EXPORT InValidMessage_situs_quadrant_2(UNSIGNED1 wh) := '';
 
EXPORT Make_apartment_unit_2(SALT36.StrType s0) := s0;
EXPORT InValid_apartment_unit_2(SALT36.StrType s) := 0;
EXPORT InValidMessage_apartment_unit_2(UNSIGNED1 wh) := '';
 
EXPORT Make_property_city_2(SALT36.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_property_city_2(SALT36.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_property_city_2(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_property_state_2(SALT36.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_property_state_2(SALT36.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_property_state_2(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_property_address_zip_code_2(SALT36.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_property_address_zip_code_2(SALT36.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_property_address_zip_code_2(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_carrier_code_2(SALT36.StrType s0) := s0;
EXPORT InValid_carrier_code_2(SALT36.StrType s) := 0;
EXPORT InValidMessage_carrier_code_2(UNSIGNED1 wh) := '';
 
EXPORT Make_full_site_address_unparsed_2(SALT36.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_full_site_address_unparsed_2(SALT36.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_full_site_address_unparsed_2(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_property_indicator(SALT36.StrType s0) := MakeFT_invalid_property_code(s0);
EXPORT InValid_property_indicator(SALT36.StrType s) := InValidFT_invalid_property_code(s);
EXPORT InValidMessage_property_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_property_code(wh);
 
EXPORT Make_use_code(SALT36.StrType s0) := MakeFT_invalid_land_use_code(s0);
EXPORT InValid_use_code(SALT36.StrType s) := InValidFT_invalid_land_use_code(s);
EXPORT InValidMessage_use_code(UNSIGNED1 wh) := InValidMessageFT_invalid_land_use_code(wh);
 
EXPORT Make_number_of_units(SALT36.StrType s0) := s0;
EXPORT InValid_number_of_units(SALT36.StrType s) := 0;
EXPORT InValidMessage_number_of_units(UNSIGNED1 wh) := '';
 
EXPORT Make_living_area_square_feet(SALT36.StrType s0) := s0;
EXPORT InValid_living_area_square_feet(SALT36.StrType s) := 0;
EXPORT InValidMessage_living_area_square_feet(UNSIGNED1 wh) := '';
 
EXPORT Make_number_of_bedrooms(SALT36.StrType s0) := s0;
EXPORT InValid_number_of_bedrooms(SALT36.StrType s) := 0;
EXPORT InValidMessage_number_of_bedrooms(UNSIGNED1 wh) := '';
 
EXPORT Make_number_of_bathrooms(SALT36.StrType s0) := s0;
EXPORT InValid_number_of_bathrooms(SALT36.StrType s) := 0;
EXPORT InValidMessage_number_of_bathrooms(UNSIGNED1 wh) := '';
 
EXPORT Make_number_of_garages(SALT36.StrType s0) := s0;
EXPORT InValid_number_of_garages(SALT36.StrType s) := 0;
EXPORT InValidMessage_number_of_garages(UNSIGNED1 wh) := '';
 
EXPORT Make_zoning_code(SALT36.StrType s0) := s0;
EXPORT InValid_zoning_code(SALT36.StrType s) := 0;
EXPORT InValidMessage_zoning_code(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_size(SALT36.StrType s0) := s0;
EXPORT InValid_lot_size(SALT36.StrType s) := 0;
EXPORT InValidMessage_lot_size(UNSIGNED1 wh) := '';
 
EXPORT Make_year_built(SALT36.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_year_built(SALT36.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_year_built(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_current_land_value(SALT36.StrType s0) := MakeFT_invalid_amount(s0);
EXPORT InValid_current_land_value(SALT36.StrType s) := InValidFT_invalid_amount(s);
EXPORT InValidMessage_current_land_value(UNSIGNED1 wh) := InValidMessageFT_invalid_amount(wh);
 
EXPORT Make_current_improvement_value(SALT36.StrType s0) := MakeFT_invalid_amount(s0);
EXPORT InValid_current_improvement_value(SALT36.StrType s) := InValidFT_invalid_amount(s);
EXPORT InValidMessage_current_improvement_value(UNSIGNED1 wh) := InValidMessageFT_invalid_amount(wh);
 
EXPORT Make_filler_8(SALT36.StrType s0) := s0;
EXPORT InValid_filler_8(SALT36.StrType s) := 0;
EXPORT InValidMessage_filler_8(UNSIGNED1 wh) := '';
 
EXPORT Make_section(SALT36.StrType s0) := s0;
EXPORT InValid_section(SALT36.StrType s) := 0;
EXPORT InValidMessage_section(UNSIGNED1 wh) := '';
 
EXPORT Make_township(SALT36.StrType s0) := s0;
EXPORT InValid_township(SALT36.StrType s) := 0;
EXPORT InValidMessage_township(UNSIGNED1 wh) := '';
 
EXPORT Make_range(SALT36.StrType s0) := s0;
EXPORT InValid_range(SALT36.StrType s) := 0;
EXPORT InValidMessage_range(UNSIGNED1 wh) := '';
 
EXPORT Make_lot(SALT36.StrType s0) := s0;
EXPORT InValid_lot(SALT36.StrType s) := 0;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_block(SALT36.StrType s0) := s0;
EXPORT InValid_block(SALT36.StrType s) := 0;
EXPORT InValidMessage_block(UNSIGNED1 wh) := '';
 
EXPORT Make_tract_subdivision_name(SALT36.StrType s0) := s0;
EXPORT InValid_tract_subdivision_name(SALT36.StrType s) := 0;
EXPORT InValidMessage_tract_subdivision_name(UNSIGNED1 wh) := '';
 
EXPORT Make_map_book(SALT36.StrType s0) := s0;
EXPORT InValid_map_book(SALT36.StrType s) := 0;
EXPORT InValidMessage_map_book(UNSIGNED1 wh) := '';
 
EXPORT Make_map_page(SALT36.StrType s0) := s0;
EXPORT InValid_map_page(SALT36.StrType s) := 0;
EXPORT InValidMessage_map_page(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_nbr(SALT36.StrType s0) := s0;
EXPORT InValid_unit_nbr(SALT36.StrType s) := 0;
EXPORT InValidMessage_unit_nbr(UNSIGNED1 wh) := '';
 
EXPORT Make_expanded_legal(SALT36.StrType s0) := s0;
EXPORT InValid_expanded_legal(SALT36.StrType s) := 0;
EXPORT InValidMessage_expanded_legal(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_2(SALT36.StrType s0) := s0;
EXPORT InValid_legal_2(SALT36.StrType s) := 0;
EXPORT InValidMessage_legal_2(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_3(SALT36.StrType s0) := s0;
EXPORT InValid_legal_3(SALT36.StrType s) := 0;
EXPORT InValidMessage_legal_3(UNSIGNED1 wh) := '';
 
EXPORT Make_legal_4(SALT36.StrType s0) := s0;
EXPORT InValid_legal_4(SALT36.StrType s) := 0;
EXPORT InValidMessage_legal_4(UNSIGNED1 wh) := '';
 
EXPORT Make_crlf(SALT36.StrType s0) := s0;
EXPORT InValid_crlf(SALT36.StrType s) := 0;
EXPORT InValidMessage_crlf(UNSIGNED1 wh) := '';
 
EXPORT Make_deed_desc(SALT36.StrType s0) := s0;
EXPORT InValid_deed_desc(SALT36.StrType s) := 0;
EXPORT InValidMessage_deed_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_document_desc(SALT36.StrType s0) := s0;
EXPORT InValid_document_desc(SALT36.StrType s) := 0;
EXPORT InValidMessage_document_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_et_al_desc(SALT36.StrType s0) := s0;
EXPORT InValid_et_al_desc(SALT36.StrType s) := 0;
EXPORT InValidMessage_et_al_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_property_desc(SALT36.StrType s0) := s0;
EXPORT InValid_property_desc(SALT36.StrType s) := 0;
EXPORT InValidMessage_property_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_use_desc(SALT36.StrType s0) := s0;
EXPORT InValid_use_desc(SALT36.StrType s) := 0;
EXPORT InValidMessage_use_desc(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT36,Scrubs_Property_Foreclosures;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_foreclosure_id;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_state;
    BOOLEAN Diff_county;
    BOOLEAN Diff_batch_date_and_seq_nbr;
    BOOLEAN Diff_deed_category;
    BOOLEAN Diff_document_type;
    BOOLEAN Diff_recording_date;
    BOOLEAN Diff_document_year;
    BOOLEAN Diff_document_nbr;
    BOOLEAN Diff_document_book;
    BOOLEAN Diff_document_pages;
    BOOLEAN Diff_title_company_code;
    BOOLEAN Diff_title_company_name;
    BOOLEAN Diff_attorney_name;
    BOOLEAN Diff_attorney_phone_nbr;
    BOOLEAN Diff_first_defendant_borrower_owner_first_name;
    BOOLEAN Diff_first_defendant_borrower_owner_last_name;
    BOOLEAN Diff_first_defendant_borrower_company_name;
    BOOLEAN Diff_second_defendant_borrower_owner_first_name;
    BOOLEAN Diff_second_defendant_borrower_owner_last_name;
    BOOLEAN Diff_second_defendant_borrower_company_name;
    BOOLEAN Diff_third_defendant_borrower_owner_first_name;
    BOOLEAN Diff_third_defendant_borrower_owner_last_name;
    BOOLEAN Diff_third_defendant_borrower_company_name;
    BOOLEAN Diff_fourth_defendant_borrower_owner_first_name;
    BOOLEAN Diff_fourth_defendant_borrower_owner_last_name;
    BOOLEAN Diff_fourth_defendant_borrower_company_name;
    BOOLEAN Diff_defendant_borrower_owner_et_al_indicator;
    BOOLEAN Diff_filler1;
    BOOLEAN Diff_date_of_default;
    BOOLEAN Diff_amount_of_default;
    BOOLEAN Diff_filler2;
    BOOLEAN Diff_filing_date;
    BOOLEAN Diff_court_case_nbr;
    BOOLEAN Diff_lis_pendens_type;
    BOOLEAN Diff_plaintiff_1;
    BOOLEAN Diff_plaintiff_2;
    BOOLEAN Diff_final_judgment_amount;
    BOOLEAN Diff_filler_3;
    BOOLEAN Diff_auction_date;
    BOOLEAN Diff_auction_time;
    BOOLEAN Diff_street_address_of_auction_call;
    BOOLEAN Diff_city_of_auction_call;
    BOOLEAN Diff_state_of_auction_call;
    BOOLEAN Diff_opening_bid;
    BOOLEAN Diff_tax_year;
    BOOLEAN Diff_filler4;
    BOOLEAN Diff_sales_price;
    BOOLEAN Diff_situs_address_indicator_1;
    BOOLEAN Diff_situs_house_number_prefix_1;
    BOOLEAN Diff_situs_house_number_1;
    BOOLEAN Diff_situs_house_number_suffix_1;
    BOOLEAN Diff_situs_street_name_1;
    BOOLEAN Diff_situs_mode_1;
    BOOLEAN Diff_situs_direction_1;
    BOOLEAN Diff_situs_quadrant_1;
    BOOLEAN Diff_apartment_unit;
    BOOLEAN Diff_property_city_1;
    BOOLEAN Diff_property_state_1;
    BOOLEAN Diff_property_address_zip_code_1;
    BOOLEAN Diff_carrier_code;
    BOOLEAN Diff_full_site_address_unparsed_1;
    BOOLEAN Diff_lender_beneficiary_first_name;
    BOOLEAN Diff_lender_beneficiary_last_name;
    BOOLEAN Diff_lender_beneficiary_company_name;
    BOOLEAN Diff_lender_beneficiary_mailing_address;
    BOOLEAN Diff_lender_beneficiary_city;
    BOOLEAN Diff_lender_beneficiary_state;
    BOOLEAN Diff_lender_beneficiary_zip;
    BOOLEAN Diff_lender_phone;
    BOOLEAN Diff_filler_5;
    BOOLEAN Diff_trustee_name;
    BOOLEAN Diff_trustee_mailing_address;
    BOOLEAN Diff_trustee_city;
    BOOLEAN Diff_trustee_state;
    BOOLEAN Diff_trustee_zip;
    BOOLEAN Diff_trustee_phone;
    BOOLEAN Diff_trustee_sale_number;
    BOOLEAN Diff_filler_6;
    BOOLEAN Diff_original_loan_date;
    BOOLEAN Diff_original_loan_recording_date;
    BOOLEAN Diff_original_loan_amount;
    BOOLEAN Diff_original_document_number;
    BOOLEAN Diff_original_recording_book;
    BOOLEAN Diff_original_recording_page;
    BOOLEAN Diff_filler_7;
    BOOLEAN Diff_parcel_number_parcel_id;
    BOOLEAN Diff_parcel_number_unmatched_id;
    BOOLEAN Diff_last_full_sale_transfer_date;
    BOOLEAN Diff_transfer_value;
    BOOLEAN Diff_situs_address_indicator_2;
    BOOLEAN Diff_situs_house_number_prefix_2;
    BOOLEAN Diff_situs_house_number_2;
    BOOLEAN Diff_situs_house_number_suffix_2;
    BOOLEAN Diff_situs_street_name_2;
    BOOLEAN Diff_situs_mode_2;
    BOOLEAN Diff_situs_direction_2;
    BOOLEAN Diff_situs_quadrant_2;
    BOOLEAN Diff_apartment_unit_2;
    BOOLEAN Diff_property_city_2;
    BOOLEAN Diff_property_state_2;
    BOOLEAN Diff_property_address_zip_code_2;
    BOOLEAN Diff_carrier_code_2;
    BOOLEAN Diff_full_site_address_unparsed_2;
    BOOLEAN Diff_property_indicator;
    BOOLEAN Diff_use_code;
    BOOLEAN Diff_number_of_units;
    BOOLEAN Diff_living_area_square_feet;
    BOOLEAN Diff_number_of_bedrooms;
    BOOLEAN Diff_number_of_bathrooms;
    BOOLEAN Diff_number_of_garages;
    BOOLEAN Diff_zoning_code;
    BOOLEAN Diff_lot_size;
    BOOLEAN Diff_year_built;
    BOOLEAN Diff_current_land_value;
    BOOLEAN Diff_current_improvement_value;
    BOOLEAN Diff_filler_8;
    BOOLEAN Diff_section;
    BOOLEAN Diff_township;
    BOOLEAN Diff_range;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_block;
    BOOLEAN Diff_tract_subdivision_name;
    BOOLEAN Diff_map_book;
    BOOLEAN Diff_map_page;
    BOOLEAN Diff_unit_nbr;
    BOOLEAN Diff_expanded_legal;
    BOOLEAN Diff_legal_2;
    BOOLEAN Diff_legal_3;
    BOOLEAN Diff_legal_4;
    BOOLEAN Diff_crlf;
    BOOLEAN Diff_deed_desc;
    BOOLEAN Diff_document_desc;
    BOOLEAN Diff_et_al_desc;
    BOOLEAN Diff_property_desc;
    BOOLEAN Diff_use_desc;
    UNSIGNED Num_Diffs;
    SALT36.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_foreclosure_id := le.foreclosure_id <> ri.foreclosure_id;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_batch_date_and_seq_nbr := le.batch_date_and_seq_nbr <> ri.batch_date_and_seq_nbr;
    SELF.Diff_deed_category := le.deed_category <> ri.deed_category;
    SELF.Diff_document_type := le.document_type <> ri.document_type;
    SELF.Diff_recording_date := le.recording_date <> ri.recording_date;
    SELF.Diff_document_year := le.document_year <> ri.document_year;
    SELF.Diff_document_nbr := le.document_nbr <> ri.document_nbr;
    SELF.Diff_document_book := le.document_book <> ri.document_book;
    SELF.Diff_document_pages := le.document_pages <> ri.document_pages;
    SELF.Diff_title_company_code := le.title_company_code <> ri.title_company_code;
    SELF.Diff_title_company_name := le.title_company_name <> ri.title_company_name;
    SELF.Diff_attorney_name := le.attorney_name <> ri.attorney_name;
    SELF.Diff_attorney_phone_nbr := le.attorney_phone_nbr <> ri.attorney_phone_nbr;
    SELF.Diff_first_defendant_borrower_owner_first_name := le.first_defendant_borrower_owner_first_name <> ri.first_defendant_borrower_owner_first_name;
    SELF.Diff_first_defendant_borrower_owner_last_name := le.first_defendant_borrower_owner_last_name <> ri.first_defendant_borrower_owner_last_name;
    SELF.Diff_first_defendant_borrower_company_name := le.first_defendant_borrower_company_name <> ri.first_defendant_borrower_company_name;
    SELF.Diff_second_defendant_borrower_owner_first_name := le.second_defendant_borrower_owner_first_name <> ri.second_defendant_borrower_owner_first_name;
    SELF.Diff_second_defendant_borrower_owner_last_name := le.second_defendant_borrower_owner_last_name <> ri.second_defendant_borrower_owner_last_name;
    SELF.Diff_second_defendant_borrower_company_name := le.second_defendant_borrower_company_name <> ri.second_defendant_borrower_company_name;
    SELF.Diff_third_defendant_borrower_owner_first_name := le.third_defendant_borrower_owner_first_name <> ri.third_defendant_borrower_owner_first_name;
    SELF.Diff_third_defendant_borrower_owner_last_name := le.third_defendant_borrower_owner_last_name <> ri.third_defendant_borrower_owner_last_name;
    SELF.Diff_third_defendant_borrower_company_name := le.third_defendant_borrower_company_name <> ri.third_defendant_borrower_company_name;
    SELF.Diff_fourth_defendant_borrower_owner_first_name := le.fourth_defendant_borrower_owner_first_name <> ri.fourth_defendant_borrower_owner_first_name;
    SELF.Diff_fourth_defendant_borrower_owner_last_name := le.fourth_defendant_borrower_owner_last_name <> ri.fourth_defendant_borrower_owner_last_name;
    SELF.Diff_fourth_defendant_borrower_company_name := le.fourth_defendant_borrower_company_name <> ri.fourth_defendant_borrower_company_name;
    SELF.Diff_defendant_borrower_owner_et_al_indicator := le.defendant_borrower_owner_et_al_indicator <> ri.defendant_borrower_owner_et_al_indicator;
    SELF.Diff_filler1 := le.filler1 <> ri.filler1;
    SELF.Diff_date_of_default := le.date_of_default <> ri.date_of_default;
    SELF.Diff_amount_of_default := le.amount_of_default <> ri.amount_of_default;
    SELF.Diff_filler2 := le.filler2 <> ri.filler2;
    SELF.Diff_filing_date := le.filing_date <> ri.filing_date;
    SELF.Diff_court_case_nbr := le.court_case_nbr <> ri.court_case_nbr;
    SELF.Diff_lis_pendens_type := le.lis_pendens_type <> ri.lis_pendens_type;
    SELF.Diff_plaintiff_1 := le.plaintiff_1 <> ri.plaintiff_1;
    SELF.Diff_plaintiff_2 := le.plaintiff_2 <> ri.plaintiff_2;
    SELF.Diff_final_judgment_amount := le.final_judgment_amount <> ri.final_judgment_amount;
    SELF.Diff_filler_3 := le.filler_3 <> ri.filler_3;
    SELF.Diff_auction_date := le.auction_date <> ri.auction_date;
    SELF.Diff_auction_time := le.auction_time <> ri.auction_time;
    SELF.Diff_street_address_of_auction_call := le.street_address_of_auction_call <> ri.street_address_of_auction_call;
    SELF.Diff_city_of_auction_call := le.city_of_auction_call <> ri.city_of_auction_call;
    SELF.Diff_state_of_auction_call := le.state_of_auction_call <> ri.state_of_auction_call;
    SELF.Diff_opening_bid := le.opening_bid <> ri.opening_bid;
    SELF.Diff_tax_year := le.tax_year <> ri.tax_year;
    SELF.Diff_filler4 := le.filler4 <> ri.filler4;
    SELF.Diff_sales_price := le.sales_price <> ri.sales_price;
    SELF.Diff_situs_address_indicator_1 := le.situs_address_indicator_1 <> ri.situs_address_indicator_1;
    SELF.Diff_situs_house_number_prefix_1 := le.situs_house_number_prefix_1 <> ri.situs_house_number_prefix_1;
    SELF.Diff_situs_house_number_1 := le.situs_house_number_1 <> ri.situs_house_number_1;
    SELF.Diff_situs_house_number_suffix_1 := le.situs_house_number_suffix_1 <> ri.situs_house_number_suffix_1;
    SELF.Diff_situs_street_name_1 := le.situs_street_name_1 <> ri.situs_street_name_1;
    SELF.Diff_situs_mode_1 := le.situs_mode_1 <> ri.situs_mode_1;
    SELF.Diff_situs_direction_1 := le.situs_direction_1 <> ri.situs_direction_1;
    SELF.Diff_situs_quadrant_1 := le.situs_quadrant_1 <> ri.situs_quadrant_1;
    SELF.Diff_apartment_unit := le.apartment_unit <> ri.apartment_unit;
    SELF.Diff_property_city_1 := le.property_city_1 <> ri.property_city_1;
    SELF.Diff_property_state_1 := le.property_state_1 <> ri.property_state_1;
    SELF.Diff_property_address_zip_code_1 := le.property_address_zip_code_1 <> ri.property_address_zip_code_1;
    SELF.Diff_carrier_code := le.carrier_code <> ri.carrier_code;
    SELF.Diff_full_site_address_unparsed_1 := le.full_site_address_unparsed_1 <> ri.full_site_address_unparsed_1;
    SELF.Diff_lender_beneficiary_first_name := le.lender_beneficiary_first_name <> ri.lender_beneficiary_first_name;
    SELF.Diff_lender_beneficiary_last_name := le.lender_beneficiary_last_name <> ri.lender_beneficiary_last_name;
    SELF.Diff_lender_beneficiary_company_name := le.lender_beneficiary_company_name <> ri.lender_beneficiary_company_name;
    SELF.Diff_lender_beneficiary_mailing_address := le.lender_beneficiary_mailing_address <> ri.lender_beneficiary_mailing_address;
    SELF.Diff_lender_beneficiary_city := le.lender_beneficiary_city <> ri.lender_beneficiary_city;
    SELF.Diff_lender_beneficiary_state := le.lender_beneficiary_state <> ri.lender_beneficiary_state;
    SELF.Diff_lender_beneficiary_zip := le.lender_beneficiary_zip <> ri.lender_beneficiary_zip;
    SELF.Diff_lender_phone := le.lender_phone <> ri.lender_phone;
    SELF.Diff_filler_5 := le.filler_5 <> ri.filler_5;
    SELF.Diff_trustee_name := le.trustee_name <> ri.trustee_name;
    SELF.Diff_trustee_mailing_address := le.trustee_mailing_address <> ri.trustee_mailing_address;
    SELF.Diff_trustee_city := le.trustee_city <> ri.trustee_city;
    SELF.Diff_trustee_state := le.trustee_state <> ri.trustee_state;
    SELF.Diff_trustee_zip := le.trustee_zip <> ri.trustee_zip;
    SELF.Diff_trustee_phone := le.trustee_phone <> ri.trustee_phone;
    SELF.Diff_trustee_sale_number := le.trustee_sale_number <> ri.trustee_sale_number;
    SELF.Diff_filler_6 := le.filler_6 <> ri.filler_6;
    SELF.Diff_original_loan_date := le.original_loan_date <> ri.original_loan_date;
    SELF.Diff_original_loan_recording_date := le.original_loan_recording_date <> ri.original_loan_recording_date;
    SELF.Diff_original_loan_amount := le.original_loan_amount <> ri.original_loan_amount;
    SELF.Diff_original_document_number := le.original_document_number <> ri.original_document_number;
    SELF.Diff_original_recording_book := le.original_recording_book <> ri.original_recording_book;
    SELF.Diff_original_recording_page := le.original_recording_page <> ri.original_recording_page;
    SELF.Diff_filler_7 := le.filler_7 <> ri.filler_7;
    SELF.Diff_parcel_number_parcel_id := le.parcel_number_parcel_id <> ri.parcel_number_parcel_id;
    SELF.Diff_parcel_number_unmatched_id := le.parcel_number_unmatched_id <> ri.parcel_number_unmatched_id;
    SELF.Diff_last_full_sale_transfer_date := le.last_full_sale_transfer_date <> ri.last_full_sale_transfer_date;
    SELF.Diff_transfer_value := le.transfer_value <> ri.transfer_value;
    SELF.Diff_situs_address_indicator_2 := le.situs_address_indicator_2 <> ri.situs_address_indicator_2;
    SELF.Diff_situs_house_number_prefix_2 := le.situs_house_number_prefix_2 <> ri.situs_house_number_prefix_2;
    SELF.Diff_situs_house_number_2 := le.situs_house_number_2 <> ri.situs_house_number_2;
    SELF.Diff_situs_house_number_suffix_2 := le.situs_house_number_suffix_2 <> ri.situs_house_number_suffix_2;
    SELF.Diff_situs_street_name_2 := le.situs_street_name_2 <> ri.situs_street_name_2;
    SELF.Diff_situs_mode_2 := le.situs_mode_2 <> ri.situs_mode_2;
    SELF.Diff_situs_direction_2 := le.situs_direction_2 <> ri.situs_direction_2;
    SELF.Diff_situs_quadrant_2 := le.situs_quadrant_2 <> ri.situs_quadrant_2;
    SELF.Diff_apartment_unit_2 := le.apartment_unit_2 <> ri.apartment_unit_2;
    SELF.Diff_property_city_2 := le.property_city_2 <> ri.property_city_2;
    SELF.Diff_property_state_2 := le.property_state_2 <> ri.property_state_2;
    SELF.Diff_property_address_zip_code_2 := le.property_address_zip_code_2 <> ri.property_address_zip_code_2;
    SELF.Diff_carrier_code_2 := le.carrier_code_2 <> ri.carrier_code_2;
    SELF.Diff_full_site_address_unparsed_2 := le.full_site_address_unparsed_2 <> ri.full_site_address_unparsed_2;
    SELF.Diff_property_indicator := le.property_indicator <> ri.property_indicator;
    SELF.Diff_use_code := le.use_code <> ri.use_code;
    SELF.Diff_number_of_units := le.number_of_units <> ri.number_of_units;
    SELF.Diff_living_area_square_feet := le.living_area_square_feet <> ri.living_area_square_feet;
    SELF.Diff_number_of_bedrooms := le.number_of_bedrooms <> ri.number_of_bedrooms;
    SELF.Diff_number_of_bathrooms := le.number_of_bathrooms <> ri.number_of_bathrooms;
    SELF.Diff_number_of_garages := le.number_of_garages <> ri.number_of_garages;
    SELF.Diff_zoning_code := le.zoning_code <> ri.zoning_code;
    SELF.Diff_lot_size := le.lot_size <> ri.lot_size;
    SELF.Diff_year_built := le.year_built <> ri.year_built;
    SELF.Diff_current_land_value := le.current_land_value <> ri.current_land_value;
    SELF.Diff_current_improvement_value := le.current_improvement_value <> ri.current_improvement_value;
    SELF.Diff_filler_8 := le.filler_8 <> ri.filler_8;
    SELF.Diff_section := le.section <> ri.section;
    SELF.Diff_township := le.township <> ri.township;
    SELF.Diff_range := le.range <> ri.range;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_block := le.block <> ri.block;
    SELF.Diff_tract_subdivision_name := le.tract_subdivision_name <> ri.tract_subdivision_name;
    SELF.Diff_map_book := le.map_book <> ri.map_book;
    SELF.Diff_map_page := le.map_page <> ri.map_page;
    SELF.Diff_unit_nbr := le.unit_nbr <> ri.unit_nbr;
    SELF.Diff_expanded_legal := le.expanded_legal <> ri.expanded_legal;
    SELF.Diff_legal_2 := le.legal_2 <> ri.legal_2;
    SELF.Diff_legal_3 := le.legal_3 <> ri.legal_3;
    SELF.Diff_legal_4 := le.legal_4 <> ri.legal_4;
    SELF.Diff_crlf := le.crlf <> ri.crlf;
    SELF.Diff_deed_desc := le.deed_desc <> ri.deed_desc;
    SELF.Diff_document_desc := le.document_desc <> ri.document_desc;
    SELF.Diff_et_al_desc := le.et_al_desc <> ri.et_al_desc;
    SELF.Diff_property_desc := le.property_desc <> ri.property_desc;
    SELF.Diff_use_desc := le.use_desc <> ri.use_desc;
    SELF.Val := (SALT36.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_foreclosure_id,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_batch_date_and_seq_nbr,1,0)+ IF( SELF.Diff_deed_category,1,0)+ IF( SELF.Diff_document_type,1,0)+ IF( SELF.Diff_recording_date,1,0)+ IF( SELF.Diff_document_year,1,0)+ IF( SELF.Diff_document_nbr,1,0)+ IF( SELF.Diff_document_book,1,0)+ IF( SELF.Diff_document_pages,1,0)+ IF( SELF.Diff_title_company_code,1,0)+ IF( SELF.Diff_title_company_name,1,0)+ IF( SELF.Diff_attorney_name,1,0)+ IF( SELF.Diff_attorney_phone_nbr,1,0)+ IF( SELF.Diff_first_defendant_borrower_owner_first_name,1,0)+ IF( SELF.Diff_first_defendant_borrower_owner_last_name,1,0)+ IF( SELF.Diff_first_defendant_borrower_company_name,1,0)+ IF( SELF.Diff_second_defendant_borrower_owner_first_name,1,0)+ IF( SELF.Diff_second_defendant_borrower_owner_last_name,1,0)+ IF( SELF.Diff_second_defendant_borrower_company_name,1,0)+ IF( SELF.Diff_third_defendant_borrower_owner_first_name,1,0)+ IF( SELF.Diff_third_defendant_borrower_owner_last_name,1,0)+ IF( SELF.Diff_third_defendant_borrower_company_name,1,0)+ IF( SELF.Diff_fourth_defendant_borrower_owner_first_name,1,0)+ IF( SELF.Diff_fourth_defendant_borrower_owner_last_name,1,0)+ IF( SELF.Diff_fourth_defendant_borrower_company_name,1,0)+ IF( SELF.Diff_defendant_borrower_owner_et_al_indicator,1,0)+ IF( SELF.Diff_filler1,1,0)+ IF( SELF.Diff_date_of_default,1,0)+ IF( SELF.Diff_amount_of_default,1,0)+ IF( SELF.Diff_filler2,1,0)+ IF( SELF.Diff_filing_date,1,0)+ IF( SELF.Diff_court_case_nbr,1,0)+ IF( SELF.Diff_lis_pendens_type,1,0)+ IF( SELF.Diff_plaintiff_1,1,0)+ IF( SELF.Diff_plaintiff_2,1,0)+ IF( SELF.Diff_final_judgment_amount,1,0)+ IF( SELF.Diff_filler_3,1,0)+ IF( SELF.Diff_auction_date,1,0)+ IF( SELF.Diff_auction_time,1,0)+ IF( SELF.Diff_street_address_of_auction_call,1,0)+ IF( SELF.Diff_city_of_auction_call,1,0)+ IF( SELF.Diff_state_of_auction_call,1,0)+ IF( SELF.Diff_opening_bid,1,0)+ IF( SELF.Diff_tax_year,1,0)+ IF( SELF.Diff_filler4,1,0)+ IF( SELF.Diff_sales_price,1,0)+ IF( SELF.Diff_situs_address_indicator_1,1,0)+ IF( SELF.Diff_situs_house_number_prefix_1,1,0)+ IF( SELF.Diff_situs_house_number_1,1,0)+ IF( SELF.Diff_situs_house_number_suffix_1,1,0)+ IF( SELF.Diff_situs_street_name_1,1,0)+ IF( SELF.Diff_situs_mode_1,1,0)+ IF( SELF.Diff_situs_direction_1,1,0)+ IF( SELF.Diff_situs_quadrant_1,1,0)+ IF( SELF.Diff_apartment_unit,1,0)+ IF( SELF.Diff_property_city_1,1,0)+ IF( SELF.Diff_property_state_1,1,0)+ IF( SELF.Diff_property_address_zip_code_1,1,0)+ IF( SELF.Diff_carrier_code,1,0)+ IF( SELF.Diff_full_site_address_unparsed_1,1,0)+ IF( SELF.Diff_lender_beneficiary_first_name,1,0)+ IF( SELF.Diff_lender_beneficiary_last_name,1,0)+ IF( SELF.Diff_lender_beneficiary_company_name,1,0)+ IF( SELF.Diff_lender_beneficiary_mailing_address,1,0)+ IF( SELF.Diff_lender_beneficiary_city,1,0)+ IF( SELF.Diff_lender_beneficiary_state,1,0)+ IF( SELF.Diff_lender_beneficiary_zip,1,0)+ IF( SELF.Diff_lender_phone,1,0)+ IF( SELF.Diff_filler_5,1,0)+ IF( SELF.Diff_trustee_name,1,0)+ IF( SELF.Diff_trustee_mailing_address,1,0)+ IF( SELF.Diff_trustee_city,1,0)+ IF( SELF.Diff_trustee_state,1,0)+ IF( SELF.Diff_trustee_zip,1,0)+ IF( SELF.Diff_trustee_phone,1,0)+ IF( SELF.Diff_trustee_sale_number,1,0)+ IF( SELF.Diff_filler_6,1,0)+ IF( SELF.Diff_original_loan_date,1,0)+ IF( SELF.Diff_original_loan_recording_date,1,0)+ IF( SELF.Diff_original_loan_amount,1,0)+ IF( SELF.Diff_original_document_number,1,0)+ IF( SELF.Diff_original_recording_book,1,0)+ IF( SELF.Diff_original_recording_page,1,0)+ IF( SELF.Diff_filler_7,1,0)+ IF( SELF.Diff_parcel_number_parcel_id,1,0)+ IF( SELF.Diff_parcel_number_unmatched_id,1,0)+ IF( SELF.Diff_last_full_sale_transfer_date,1,0)+ IF( SELF.Diff_transfer_value,1,0)+ IF( SELF.Diff_situs_address_indicator_2,1,0)+ IF( SELF.Diff_situs_house_number_prefix_2,1,0)+ IF( SELF.Diff_situs_house_number_2,1,0)+ IF( SELF.Diff_situs_house_number_suffix_2,1,0)+ IF( SELF.Diff_situs_street_name_2,1,0)+ IF( SELF.Diff_situs_mode_2,1,0)+ IF( SELF.Diff_situs_direction_2,1,0)+ IF( SELF.Diff_situs_quadrant_2,1,0)+ IF( SELF.Diff_apartment_unit_2,1,0)+ IF( SELF.Diff_property_city_2,1,0)+ IF( SELF.Diff_property_state_2,1,0)+ IF( SELF.Diff_property_address_zip_code_2,1,0)+ IF( SELF.Diff_carrier_code_2,1,0)+ IF( SELF.Diff_full_site_address_unparsed_2,1,0)+ IF( SELF.Diff_property_indicator,1,0)+ IF( SELF.Diff_use_code,1,0)+ IF( SELF.Diff_number_of_units,1,0)+ IF( SELF.Diff_living_area_square_feet,1,0)+ IF( SELF.Diff_number_of_bedrooms,1,0)+ IF( SELF.Diff_number_of_bathrooms,1,0)+ IF( SELF.Diff_number_of_garages,1,0)+ IF( SELF.Diff_zoning_code,1,0)+ IF( SELF.Diff_lot_size,1,0)+ IF( SELF.Diff_year_built,1,0)+ IF( SELF.Diff_current_land_value,1,0)+ IF( SELF.Diff_current_improvement_value,1,0)+ IF( SELF.Diff_filler_8,1,0)+ IF( SELF.Diff_section,1,0)+ IF( SELF.Diff_township,1,0)+ IF( SELF.Diff_range,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_block,1,0)+ IF( SELF.Diff_tract_subdivision_name,1,0)+ IF( SELF.Diff_map_book,1,0)+ IF( SELF.Diff_map_page,1,0)+ IF( SELF.Diff_unit_nbr,1,0)+ IF( SELF.Diff_expanded_legal,1,0)+ IF( SELF.Diff_legal_2,1,0)+ IF( SELF.Diff_legal_3,1,0)+ IF( SELF.Diff_legal_4,1,0)+ IF( SELF.Diff_crlf,1,0)+ IF( SELF.Diff_deed_desc,1,0)+ IF( SELF.Diff_document_desc,1,0)+ IF( SELF.Diff_et_al_desc,1,0)+ IF( SELF.Diff_property_desc,1,0)+ IF( SELF.Diff_use_desc,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_foreclosure_id := COUNT(GROUP,%Closest%.Diff_foreclosure_id);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_batch_date_and_seq_nbr := COUNT(GROUP,%Closest%.Diff_batch_date_and_seq_nbr);
    Count_Diff_deed_category := COUNT(GROUP,%Closest%.Diff_deed_category);
    Count_Diff_document_type := COUNT(GROUP,%Closest%.Diff_document_type);
    Count_Diff_recording_date := COUNT(GROUP,%Closest%.Diff_recording_date);
    Count_Diff_document_year := COUNT(GROUP,%Closest%.Diff_document_year);
    Count_Diff_document_nbr := COUNT(GROUP,%Closest%.Diff_document_nbr);
    Count_Diff_document_book := COUNT(GROUP,%Closest%.Diff_document_book);
    Count_Diff_document_pages := COUNT(GROUP,%Closest%.Diff_document_pages);
    Count_Diff_title_company_code := COUNT(GROUP,%Closest%.Diff_title_company_code);
    Count_Diff_title_company_name := COUNT(GROUP,%Closest%.Diff_title_company_name);
    Count_Diff_attorney_name := COUNT(GROUP,%Closest%.Diff_attorney_name);
    Count_Diff_attorney_phone_nbr := COUNT(GROUP,%Closest%.Diff_attorney_phone_nbr);
    Count_Diff_first_defendant_borrower_owner_first_name := COUNT(GROUP,%Closest%.Diff_first_defendant_borrower_owner_first_name);
    Count_Diff_first_defendant_borrower_owner_last_name := COUNT(GROUP,%Closest%.Diff_first_defendant_borrower_owner_last_name);
    Count_Diff_first_defendant_borrower_company_name := COUNT(GROUP,%Closest%.Diff_first_defendant_borrower_company_name);
    Count_Diff_second_defendant_borrower_owner_first_name := COUNT(GROUP,%Closest%.Diff_second_defendant_borrower_owner_first_name);
    Count_Diff_second_defendant_borrower_owner_last_name := COUNT(GROUP,%Closest%.Diff_second_defendant_borrower_owner_last_name);
    Count_Diff_second_defendant_borrower_company_name := COUNT(GROUP,%Closest%.Diff_second_defendant_borrower_company_name);
    Count_Diff_third_defendant_borrower_owner_first_name := COUNT(GROUP,%Closest%.Diff_third_defendant_borrower_owner_first_name);
    Count_Diff_third_defendant_borrower_owner_last_name := COUNT(GROUP,%Closest%.Diff_third_defendant_borrower_owner_last_name);
    Count_Diff_third_defendant_borrower_company_name := COUNT(GROUP,%Closest%.Diff_third_defendant_borrower_company_name);
    Count_Diff_fourth_defendant_borrower_owner_first_name := COUNT(GROUP,%Closest%.Diff_fourth_defendant_borrower_owner_first_name);
    Count_Diff_fourth_defendant_borrower_owner_last_name := COUNT(GROUP,%Closest%.Diff_fourth_defendant_borrower_owner_last_name);
    Count_Diff_fourth_defendant_borrower_company_name := COUNT(GROUP,%Closest%.Diff_fourth_defendant_borrower_company_name);
    Count_Diff_defendant_borrower_owner_et_al_indicator := COUNT(GROUP,%Closest%.Diff_defendant_borrower_owner_et_al_indicator);
    Count_Diff_filler1 := COUNT(GROUP,%Closest%.Diff_filler1);
    Count_Diff_date_of_default := COUNT(GROUP,%Closest%.Diff_date_of_default);
    Count_Diff_amount_of_default := COUNT(GROUP,%Closest%.Diff_amount_of_default);
    Count_Diff_filler2 := COUNT(GROUP,%Closest%.Diff_filler2);
    Count_Diff_filing_date := COUNT(GROUP,%Closest%.Diff_filing_date);
    Count_Diff_court_case_nbr := COUNT(GROUP,%Closest%.Diff_court_case_nbr);
    Count_Diff_lis_pendens_type := COUNT(GROUP,%Closest%.Diff_lis_pendens_type);
    Count_Diff_plaintiff_1 := COUNT(GROUP,%Closest%.Diff_plaintiff_1);
    Count_Diff_plaintiff_2 := COUNT(GROUP,%Closest%.Diff_plaintiff_2);
    Count_Diff_final_judgment_amount := COUNT(GROUP,%Closest%.Diff_final_judgment_amount);
    Count_Diff_filler_3 := COUNT(GROUP,%Closest%.Diff_filler_3);
    Count_Diff_auction_date := COUNT(GROUP,%Closest%.Diff_auction_date);
    Count_Diff_auction_time := COUNT(GROUP,%Closest%.Diff_auction_time);
    Count_Diff_street_address_of_auction_call := COUNT(GROUP,%Closest%.Diff_street_address_of_auction_call);
    Count_Diff_city_of_auction_call := COUNT(GROUP,%Closest%.Diff_city_of_auction_call);
    Count_Diff_state_of_auction_call := COUNT(GROUP,%Closest%.Diff_state_of_auction_call);
    Count_Diff_opening_bid := COUNT(GROUP,%Closest%.Diff_opening_bid);
    Count_Diff_tax_year := COUNT(GROUP,%Closest%.Diff_tax_year);
    Count_Diff_filler4 := COUNT(GROUP,%Closest%.Diff_filler4);
    Count_Diff_sales_price := COUNT(GROUP,%Closest%.Diff_sales_price);
    Count_Diff_situs_address_indicator_1 := COUNT(GROUP,%Closest%.Diff_situs_address_indicator_1);
    Count_Diff_situs_house_number_prefix_1 := COUNT(GROUP,%Closest%.Diff_situs_house_number_prefix_1);
    Count_Diff_situs_house_number_1 := COUNT(GROUP,%Closest%.Diff_situs_house_number_1);
    Count_Diff_situs_house_number_suffix_1 := COUNT(GROUP,%Closest%.Diff_situs_house_number_suffix_1);
    Count_Diff_situs_street_name_1 := COUNT(GROUP,%Closest%.Diff_situs_street_name_1);
    Count_Diff_situs_mode_1 := COUNT(GROUP,%Closest%.Diff_situs_mode_1);
    Count_Diff_situs_direction_1 := COUNT(GROUP,%Closest%.Diff_situs_direction_1);
    Count_Diff_situs_quadrant_1 := COUNT(GROUP,%Closest%.Diff_situs_quadrant_1);
    Count_Diff_apartment_unit := COUNT(GROUP,%Closest%.Diff_apartment_unit);
    Count_Diff_property_city_1 := COUNT(GROUP,%Closest%.Diff_property_city_1);
    Count_Diff_property_state_1 := COUNT(GROUP,%Closest%.Diff_property_state_1);
    Count_Diff_property_address_zip_code_1 := COUNT(GROUP,%Closest%.Diff_property_address_zip_code_1);
    Count_Diff_carrier_code := COUNT(GROUP,%Closest%.Diff_carrier_code);
    Count_Diff_full_site_address_unparsed_1 := COUNT(GROUP,%Closest%.Diff_full_site_address_unparsed_1);
    Count_Diff_lender_beneficiary_first_name := COUNT(GROUP,%Closest%.Diff_lender_beneficiary_first_name);
    Count_Diff_lender_beneficiary_last_name := COUNT(GROUP,%Closest%.Diff_lender_beneficiary_last_name);
    Count_Diff_lender_beneficiary_company_name := COUNT(GROUP,%Closest%.Diff_lender_beneficiary_company_name);
    Count_Diff_lender_beneficiary_mailing_address := COUNT(GROUP,%Closest%.Diff_lender_beneficiary_mailing_address);
    Count_Diff_lender_beneficiary_city := COUNT(GROUP,%Closest%.Diff_lender_beneficiary_city);
    Count_Diff_lender_beneficiary_state := COUNT(GROUP,%Closest%.Diff_lender_beneficiary_state);
    Count_Diff_lender_beneficiary_zip := COUNT(GROUP,%Closest%.Diff_lender_beneficiary_zip);
    Count_Diff_lender_phone := COUNT(GROUP,%Closest%.Diff_lender_phone);
    Count_Diff_filler_5 := COUNT(GROUP,%Closest%.Diff_filler_5);
    Count_Diff_trustee_name := COUNT(GROUP,%Closest%.Diff_trustee_name);
    Count_Diff_trustee_mailing_address := COUNT(GROUP,%Closest%.Diff_trustee_mailing_address);
    Count_Diff_trustee_city := COUNT(GROUP,%Closest%.Diff_trustee_city);
    Count_Diff_trustee_state := COUNT(GROUP,%Closest%.Diff_trustee_state);
    Count_Diff_trustee_zip := COUNT(GROUP,%Closest%.Diff_trustee_zip);
    Count_Diff_trustee_phone := COUNT(GROUP,%Closest%.Diff_trustee_phone);
    Count_Diff_trustee_sale_number := COUNT(GROUP,%Closest%.Diff_trustee_sale_number);
    Count_Diff_filler_6 := COUNT(GROUP,%Closest%.Diff_filler_6);
    Count_Diff_original_loan_date := COUNT(GROUP,%Closest%.Diff_original_loan_date);
    Count_Diff_original_loan_recording_date := COUNT(GROUP,%Closest%.Diff_original_loan_recording_date);
    Count_Diff_original_loan_amount := COUNT(GROUP,%Closest%.Diff_original_loan_amount);
    Count_Diff_original_document_number := COUNT(GROUP,%Closest%.Diff_original_document_number);
    Count_Diff_original_recording_book := COUNT(GROUP,%Closest%.Diff_original_recording_book);
    Count_Diff_original_recording_page := COUNT(GROUP,%Closest%.Diff_original_recording_page);
    Count_Diff_filler_7 := COUNT(GROUP,%Closest%.Diff_filler_7);
    Count_Diff_parcel_number_parcel_id := COUNT(GROUP,%Closest%.Diff_parcel_number_parcel_id);
    Count_Diff_parcel_number_unmatched_id := COUNT(GROUP,%Closest%.Diff_parcel_number_unmatched_id);
    Count_Diff_last_full_sale_transfer_date := COUNT(GROUP,%Closest%.Diff_last_full_sale_transfer_date);
    Count_Diff_transfer_value := COUNT(GROUP,%Closest%.Diff_transfer_value);
    Count_Diff_situs_address_indicator_2 := COUNT(GROUP,%Closest%.Diff_situs_address_indicator_2);
    Count_Diff_situs_house_number_prefix_2 := COUNT(GROUP,%Closest%.Diff_situs_house_number_prefix_2);
    Count_Diff_situs_house_number_2 := COUNT(GROUP,%Closest%.Diff_situs_house_number_2);
    Count_Diff_situs_house_number_suffix_2 := COUNT(GROUP,%Closest%.Diff_situs_house_number_suffix_2);
    Count_Diff_situs_street_name_2 := COUNT(GROUP,%Closest%.Diff_situs_street_name_2);
    Count_Diff_situs_mode_2 := COUNT(GROUP,%Closest%.Diff_situs_mode_2);
    Count_Diff_situs_direction_2 := COUNT(GROUP,%Closest%.Diff_situs_direction_2);
    Count_Diff_situs_quadrant_2 := COUNT(GROUP,%Closest%.Diff_situs_quadrant_2);
    Count_Diff_apartment_unit_2 := COUNT(GROUP,%Closest%.Diff_apartment_unit_2);
    Count_Diff_property_city_2 := COUNT(GROUP,%Closest%.Diff_property_city_2);
    Count_Diff_property_state_2 := COUNT(GROUP,%Closest%.Diff_property_state_2);
    Count_Diff_property_address_zip_code_2 := COUNT(GROUP,%Closest%.Diff_property_address_zip_code_2);
    Count_Diff_carrier_code_2 := COUNT(GROUP,%Closest%.Diff_carrier_code_2);
    Count_Diff_full_site_address_unparsed_2 := COUNT(GROUP,%Closest%.Diff_full_site_address_unparsed_2);
    Count_Diff_property_indicator := COUNT(GROUP,%Closest%.Diff_property_indicator);
    Count_Diff_use_code := COUNT(GROUP,%Closest%.Diff_use_code);
    Count_Diff_number_of_units := COUNT(GROUP,%Closest%.Diff_number_of_units);
    Count_Diff_living_area_square_feet := COUNT(GROUP,%Closest%.Diff_living_area_square_feet);
    Count_Diff_number_of_bedrooms := COUNT(GROUP,%Closest%.Diff_number_of_bedrooms);
    Count_Diff_number_of_bathrooms := COUNT(GROUP,%Closest%.Diff_number_of_bathrooms);
    Count_Diff_number_of_garages := COUNT(GROUP,%Closest%.Diff_number_of_garages);
    Count_Diff_zoning_code := COUNT(GROUP,%Closest%.Diff_zoning_code);
    Count_Diff_lot_size := COUNT(GROUP,%Closest%.Diff_lot_size);
    Count_Diff_year_built := COUNT(GROUP,%Closest%.Diff_year_built);
    Count_Diff_current_land_value := COUNT(GROUP,%Closest%.Diff_current_land_value);
    Count_Diff_current_improvement_value := COUNT(GROUP,%Closest%.Diff_current_improvement_value);
    Count_Diff_filler_8 := COUNT(GROUP,%Closest%.Diff_filler_8);
    Count_Diff_section := COUNT(GROUP,%Closest%.Diff_section);
    Count_Diff_township := COUNT(GROUP,%Closest%.Diff_township);
    Count_Diff_range := COUNT(GROUP,%Closest%.Diff_range);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_block := COUNT(GROUP,%Closest%.Diff_block);
    Count_Diff_tract_subdivision_name := COUNT(GROUP,%Closest%.Diff_tract_subdivision_name);
    Count_Diff_map_book := COUNT(GROUP,%Closest%.Diff_map_book);
    Count_Diff_map_page := COUNT(GROUP,%Closest%.Diff_map_page);
    Count_Diff_unit_nbr := COUNT(GROUP,%Closest%.Diff_unit_nbr);
    Count_Diff_expanded_legal := COUNT(GROUP,%Closest%.Diff_expanded_legal);
    Count_Diff_legal_2 := COUNT(GROUP,%Closest%.Diff_legal_2);
    Count_Diff_legal_3 := COUNT(GROUP,%Closest%.Diff_legal_3);
    Count_Diff_legal_4 := COUNT(GROUP,%Closest%.Diff_legal_4);
    Count_Diff_crlf := COUNT(GROUP,%Closest%.Diff_crlf);
    Count_Diff_deed_desc := COUNT(GROUP,%Closest%.Diff_deed_desc);
    Count_Diff_document_desc := COUNT(GROUP,%Closest%.Diff_document_desc);
    Count_Diff_et_al_desc := COUNT(GROUP,%Closest%.Diff_et_al_desc);
    Count_Diff_property_desc := COUNT(GROUP,%Closest%.Diff_property_desc);
    Count_Diff_use_desc := COUNT(GROUP,%Closest%.Diff_use_desc);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
