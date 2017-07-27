//export BWR_FARES_1080_Mapping := 'todo';

import LN_Mortgage, LN_Functions, Property, lib_AddrClean, lib_StringLib;

source_file := Property.File_Fares_Deeds;
/*
source_file_filtered := Property.File_Fares_Deeds(fips[1..2] in ['06','08','15','17','25',
                                                                 '26','28','29','35','44']);
*/
//06 - CA
//08 - CO
//15 - HI
//17 - IL
//25 - MA
//26 - MI
//28 - MS
//29 - MO
//35 - NM
//44 - RI

LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE MapToCommonModel(source_file L) := TRANSFORM

  self.ln_fares_id        := L.fares_id;
  self.process_date       := L.process_date;
  self.vendor_source_flag := L.vendor;
  self.from_file          := 'F';
  self.fips_code          := L.fips;
  self.state              := if(L.prop_state!='',L.prop_state,L.prop_ace_state);
  self.county_name        := '';
  
  self.apnt_or_pin_number := L.apn_parcel_number_formatted;
  self.tax_id_number      := L.account_number;
  self.multi_apn_flag     := L.multi_apn_count;
  
  self.buyer1                   := LN_Functions.Function_CombineFirstLastCorpNames(L.owner_buyer_last_name, L.owner_buyer_first_name);
  //self.buyer1_last_or_corp_name := L.owner_buyer_last_name;
  //self.buyer1_first_middle_name := L.owner_buyer_first_name;
  
  self.buyer_mailing_address_care_of_name := L.c_o_name;
  
  string v_buyer_mailing_full_street_address := trim(L.owner_house_number_prefix,left,right) + if(trim(L.owner_house_number,left,right)!='',' ','') +
                                             (integer) L.owner_house_number                  + if(trim(L.owner_house_number_suffix,left,right)!='',' ','') +
										     trim(L.owner_house_number_suffix,left,right)    + if(trim(L.owner_street_direction,left,right)!='',' ','') +
										     trim(L.owner_street_direction,left,right)       + if(trim(L.owner_street_name,left,right)!='',' ','') +
										     trim(L.owner_street_name,left,right)            + if(trim(L.owner_mode,left,right)!='',' ','') +
										     trim(L.owner_mode,left,right)                   + if(trim(L.owner_quadrant,left,right)!='',' ','') +
										     trim(L.owner_quadrant,left,right);
  
  
  self.buyer_mailing_full_street_address  := if(trim(v_buyer_mailing_full_street_address,left,right)='0','',v_buyer_mailing_full_street_address);
  self.buyer_mailing_address_unit_number  := L.owner_apartment_unit;
  self.buyer_mailing_address_citystatezip := LN_Functions.Function_CombineCityStateZip(L.owner_city, L.owner_state, L.owner_zip_code, '');
  
  self.seller1 := L.seller_name;
  
  string v_property_full_street_address := trim(L.prop_house_number_prefix,left,right) + if(trim(L.prop_house_number,left,right)!='',' ','') +
                                       (integer) L.prop_house_number               + if(trim(L.prop_house_number_suffix,left,right)!='',' ','') +
									   trim(L.prop_house_number_suffix,left,right) + if(trim(L.prop_street_name,left,right)!='',' ','') +
									   trim(L.prop_street_name,left,right)         + if(trim(L.prop_mode,left,right)!='',' ','') +
									   trim(L.prop_mode,left,right)                + if(trim(L.prop_direction,left,right)!='',' ','') +
									   trim(L.prop_direction,left,right)           + if(trim(L.prop_quadrant,left,right)!='',' ','') +
									   trim(L.prop_quadrant,left,right);
    
  self.property_full_street_address := if(trim(v_property_full_street_address,left,right)='0','',v_property_full_street_address);
  self.property_address_unit_number := L.prop_apartment_unit;
  self.property_address_citystatezip := LN_Functions.Function_CombineCityStateZip(L.prop_city, L.prop_state, L.prop_property_address_zip_code_, '');
  self.property_address_code        := L.address_indicator;
  
  self.contract_date                := L.sale_date_yyyymmdd;
  self.recording_date               := L.recording_date_yyyymmdd;
  self.document_number              := L.document_number;
  self.document_type_code           := L.document_type;
  self.recorder_book_number         := L.book_page_6x6[1..6];
  self.recorder_page_number         := L.book_page_6x6[7..12];
  self.sales_price                  := L.sale_amount;
  self.sales_price_code             := L.sale_code;
  self.first_td_loan_amount         := L.mortgage_amount;
  self.first_td_loan_type_code      := L.mortgage_loan_type_code;
  self.first_td_due_date            := L.mortgage_due_date;
  self.type_financing               := L.mortgage_interest_rate_type;
  self.title_company_name           := L.title_company_name;
  self.second_td_loan_amount        := L.second_mortgage_amount;
  self.partial_interest_transferred := L.ownership_transfer_percentage;
  self.lender_name := trim(trim(if(trim(L.lender_last_name,left,right)='PRIVATE INDIVIDUAL','',trim(L.lender_last_name,left,right)) +
                      ' ' +
					  trim(L.lender_first_name,left,right),left,right),left,right);  
  
  self.assessment_match_land_use_code := L.universal_luse_code;
  self.property_use_code              := L.property_indicator_code;
  
  //self.fares_id                                 := L.fares_id;
  //self.fares_fips_sub_code                      := L.fips_sub_code;
  //self.fares_municipality_code                  := L.municipality_code;
  //self.fares_original_apn                       := L.original_apn;
  self.fares_unformatted_apn                    := L.apn_parcel_number_unformatted;
  //self.fares_apn_sequence_number                := L.apn_sequence_number;
  self.fares_corporate_indicator                := L.corporate_indicator;
  //self.fares_etal_indicator                     := L.owner_etal_ind;
  //self.fares_owner_relationship_rights_code     := L.owner_relationship_rights_code;
  //self.fares_owner_relationship_type            := L.owner_relationship_type;
  //self.fares_owner_mailing_address_carrier_code := L.owner_carrier_code;
  //self.fares_owner_mailing_address_match_code   := L.match_code;
  //self.fares_property_address_carrier_code      := L.prop_carrier_code;
  //self.fares_transaction_batch_id               := L.batch_id;
  //self.fares_transaction_batch_sequence         := L.batch_seq;
  //self.fares_document_year                      := L.document_year;
  self.fares_transaction_type                   := L.transaction_type;
  self.fares_lender_address                     := L.lender_address;
  //self.fares_mortgage_company_code              := L.mortgage_company_code;
  //self.fares_sales_transaction_code             := L.sales_transaction_code;
  //self.fares_multi_apn                          := L.multi_apn;
  //self.fares_title_company_code                 := L.title_company_code;
  //self.fares_residential_model_indicator        := L.residential_model_indicator;
  //self.fares_mortgage_date                      := L.mortgage_date;
  self.fares_mortgage_deed_type                 := L.mortgage_deed_type;
  self.fares_mortgage_term_code                 := L.mortgage_term_code;
  self.fares_mortgage_term                      := L.mortgage_term;
  //self.fares_mortgage_assumption_amount         := L.mortgage_assumption_amount;
  //self.fares_second_mortgage_loan_type_code     := L.second_mortgage_loan_type_code;
  //self.fares_2nd_deed_type                      := L.second_deed_type;
  //self.fares_prior_doc_year                     := L.prior_doc_year;
  //self.fares_prior_doc_number                   := L.prior_doc_number;
  //self.fares_prior_book_page                    := L.prior_book_and_page;
  //self.fares_prior_sales_deed_category_code     := L.prior_sales_deed_category_code;
  //self.fares_prior_recording_date               := L.prior_recording_date;
  //self.fares_prior_sales_date                   := L.prior_sales_date;
  //self.fares_prior_sales_price                  := L.prior_sales_price;
  //self.fares_prior_sales_code                   := L.prior_sales_code;
  //self.fares_prior_sales_transaction_code       := L.prior_sales_transaction_code;
  //self.fares_prior_multi_apn_flag               := L.prior_multi_apn_flag;
  //self.fares_prior_multi_apn_count              := L.prior_multi_apn_count;
  //self.fares_prior_mortgage_amount              := L.prior_mortgage_amount;
  //self.fares_prior_deed_type                    := L.prior_deed_type;
  //self.fares_absentee_indicator                 := L.absentee_indicator;
  self.fares_building_square_feet               := L.building_square_feet;
  //self.fares_partial_interest_indicator         := L.partial_interest_indicator;
  //self.fares_pri_cat_code                       := L.pri_cat_code;
  //self.fares_seller_carry_back                  := L.seller_carry_back;
  //self.fares_private_party_lender               := L.private_party_lender;
  //self.fares_construction_loan                  := L.construction_loan;
  //self.fares_resale_new_construction            := L.resale_new_construction_m_resale_n_;
  //self.fares_inter_family                       := L.inter_family;
  //self.fares_cash_mortgage_purchase             := L.cash_mortgage_purchase_q_cash_r_mor;
  self.fares_foreclosure                        := L.foreclosure;
  self.fares_refi_flag                          := L.refi_flag;
  self.fares_equity_flag                        := L.equity_flag;
  //self.fares_census_tract                       := L.tract;
  //self.fares_census_block_group                 := L.block_group;
  //self.fares_census_block                       := L.block;
  //self.fares_census_block_suffix                := L.block_suffix;
  //self.fares_latitude                           := L.latitude_6_2;
  //self.fares_longitude                          := L.longitude_3_6;
  self.fares_iris_apn                           := L.Iris_apn;

  /*
  self.clean_buyer_address := L.own_prim_range +
                            L.own_predir +
							L.own_prim_name +
							L.own_suffix +
							L.own_postdir +
							L.own_unit_desig +
							L.own_sec_range +
							L.own_p_city_name +
							L.own_v_city_name +
							L.own_ace_state +
							L.own_ace_zip +
							L.own_ace_zip4 +
							L.own_cart +
							L.own_cr_sort_sz +
							L.own_lot +
							L.own_lot_order +
							L.own_dbpc +
							L.own_chk_digit +
							L.own_ace_rec_type +
							L.own_ace_county +
							L.own_geo_lat +
							L.own_geo_long +
							L.own_ace_msa +
							L.own_geo_blk +
							L.own_geo_match +
							L.own_err_stat;

  self.clean_property_address := L.prop_prim_range +
                               L.prop_predir +
							   L.prop_prim_name +
							   L.prop_suffix +
							   L.prop_postdir +
							   L.prop_unit_desig +
							   L.prop_sec_range +
							   L.prop_p_city_name +
							   L.prop_v_city_name +
							   L.prop_ace_state +
							   L.prop_ace_zip +
							   L.prop_ace_zip4 +
							   L.prop_cart +
							   L.prop_cr_sort_sz +
							   L.prop_lot +
							   L.prop_lot_order +
							   L.prop_dbpc +
							   L.prop_chk_digit +
							   L.prop_ace_rec_type +
							   L.prop_ace_county +
							   L.prop_geo_lat +
							   L.prop_geo_long +
							   L.prop_ace_msa +
							   L.prop_geo_blk +
							   L.prop_geo_match +
							   L.prop_err_stat;
  */							   

  self := [];
  
END;

Result := PROJECT(source_file,MapToCommonModel(LEFT));

output(Result,,LN_Mortgage.Filename_FARES_1080,overwrite);
//output(Result);