import LN_property, LN_mortgage, LN_PropertyV2;

export replace_LN_assessorDeeds := module 
// Bug 153098- Remove records and replaced with most current records found in REPL file
// Bug 165284- Duplicate Property Records

//******************** replace assessor ********************************************************
export replace_assessor(dataset(recordof(LN_PropertyV2.Layout_Property_Common_Model_BASE)) inAssessorRepl,dataset(recordof(LN_PropertyV2.Layout_Property_Common_Model_BASE)) inAssessor) := function

irs_ln_fares_ids := ['OAx098980660',
                     'OAw098980660',
										 'OAv098980660',
										 'OAu098980660'
										];


ds1 := distribute(inAssessor, hash(state_code, county_name, apna_or_pin_number, assessed_value_year, recording_date, edition_number));

ds_repl1 := distribute(inAssessorRepl, hash(state_code, county_name, apna_or_pin_number, assessed_value_year, recording_date, edition_number));
ds_repl2 := dedup(sort(ds_repl1, state_code, county_name, apna_or_pin_number,assessed_value_year, recording_date, edition_number, -process_date, ln_fares_id, local),
												state_code, county_name, apna_or_pin_number,assessed_value_year, recording_date, edition_number,local);



assessor_join :=  JOIN(ds1, ds_repl2,
									  LEFT.fips_code							=	RIGHT.fips_code 						AND 
										LEFT.state_code				  		=	RIGHT.state_code						AND 
										LEFT.county_name						=	RIGHT.county_name						AND 
										LEFT.recording_date					=	RIGHT.recording_date				AND 
										LEFT.assessed_value_year		=	RIGHT.assessed_value_year		AND 
										LEFT.edition_number					=	RIGHT.edition_number				AND 														
										LEFT.apna_or_pin_number			=	RIGHT.apna_or_pin_number		AND
										LEFT.process_date					  < RIGHT.process_date,
										TRANSFORM(LN_PropertyV2.layout_property_common_model_base, SELF := LEFT; SELF := []), left only, local);
										
										
repl_assessor := assessor_join + ds_repl2;

repl_assesor_irs := repl_assessor(ln_fares_id not in irs_ln_fares_ids);	

repl_assessor_good := LN_PropertyV2_Fast.Mac_junk_tax.ln_asses(repl_assesor_irs); 		   

return repl_assessor_good;
end;

//******************** replace deeds ********************************************************

export Replace_Deeds(dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE)) inDeedsRepl ,dataset(recordof(LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE)) inDeeds) := function

										 
ds1 := distribute(inDeeds, hash(fips_code, state, county_name, apnt_or_pin_number, recording_date,recorder_book_number,recorder_page_number, document_number));
ds2 := dedup(sort(ds1,
									fips_code, state, county_name, apnt_or_pin_number,recording_date,recorder_book_number, recorder_page_number,document_number,   
									vendor_source_flag, current_record, from_file, record_type,fares_unformatted_apn, multi_apn_flag, tax_id_number, excise_tax_number,
									name1, name1_id_code, name2, name2_id_code,  vesting_code,  addendum_flag,  phone_number, 
									mailing_care_of, mailing_street, mailing_unit_number, mailing_csz,  mailing_address_cd,
									seller1, seller1_id_code, seller2, seller2_id_code, seller_addendum_flag, seller_mailing_full_street_address,
									seller_mailing_address_unit_number, seller_mailing_address_citystatezip, property_full_street_address,
									property_address_unit_number, property_address_citystatezip, property_address_code, legal_lot_code, legal_lot_number,
									legal_block, legal_section, legal_district, legal_land_lot, legal_unit, legal_city_municipality_township, legal_subdivision_name,
									legal_phase_number, legal_tract_number, legal_sec_twn_rng_mer, legal_brief_description,  recorder_map_reference,
									complete_legal_description_code, contract_date, arm_reset_date,document_type_code,loan_number,concurrent_mortgage_book_page_document_number, 
									sales_price,sales_price_code, city_transfer_tax, county_transfer_tax, total_transfer_tax, first_td_loan_amount, second_td_loan_amount,        
									first_td_lender_type_code,second_td_lender_type_code,first_td_loan_type_code,type_financing,first_td_interest_rate,
									first_td_due_date, title_company_name, partial_interest_transferred,loan_term_months, loan_term_years, lender_name,                  
									lender_name_id, lender_dba_aka_name, lender_full_street_address, lender_address_unit_number, lender_address_citystatezip,
									assessment_match_land_use_code, property_use_code, condo_code, timeshare_flag, land_lot_size, hawaii_tct, hawaii_condo_cpr_code,
									hawaii_condo_name,  filler_except_hawaii, rate_change_frequency, change_index, adjustable_rate_index, adjustable_rate_rider,
									graduated_payment_rider,  balloon_rider, fixed_step_rate_rider, condominium_rider, planned_unit_development_rider, rate_improvement_rider,
									assumability_rider, prepayment_rider, one_four_family_rider, biweekly_payment_rider, second_home_rider, data_source_code,
									main_record_id_code, addl_name_flag,  prop_addr_propagated_ind,  ln_ownership_rights, ln_relationship_type, ln_buyer_mailing_country_code,
									ln_seller_mailing_country_code, process_date, ln_fares_id, LOCAL),
									except process_date, ln_fares_id , local);



ds1_repl := distribute(inDeedsRepl, hash(fips_code, state, county_name, apnt_or_pin_number, recording_date,recorder_book_number,recorder_page_number, document_number));
ds2_repl := dedup(sort(ds1_repl, fips_code, state, county_name, apnt_or_pin_number, recording_date,recorder_book_number,recorder_page_number, document_number, -process_date, ln_fares_id, local),
										fips_code, state, county_name, apnt_or_pin_number, recording_date,recorder_book_number,recorder_page_number, document_number,local);

deed_join :=  JOIN(ds2, ds2_repl,
									  LEFT.fips_code							= 	RIGHT.fips_code 						AND 
										LEFT.state									= 	RIGHT.state									AND 
										LEFT.county_name						= 	RIGHT.county_name						AND 
										LEFT.recording_date					= 	RIGHT.recording_date				AND 
										LEFT.recorder_book_number		= 	RIGHT.recorder_book_number	AND 
										LEFT.recorder_page_number		= 	RIGHT.recorder_page_number	AND 														
										LEFT.document_number				= 	RIGHT.document_number				AND 
										LEFT.apnt_or_pin_number			= 	RIGHT.apnt_or_pin_number		AND
										LEFT.process_date					  <=   RIGHT.process_date,
												TRANSFORM(LN_PropertyV2.layout_deed_mortgage_common_model_base, SELF := LEFT; SELF := []), LEft ONLY);

Repl_Deeds := deed_join + ds2_repl;

Repl_Deeds_good := LN_PropertyV2_Fast.fn_junk_deed.ln_deeds(Repl_Deeds); 

return Repl_Deeds_good;

end;

end;