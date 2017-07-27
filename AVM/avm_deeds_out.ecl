import ln_property, ln_mortgage;

// Assessor year select
assessor_year_list := ['2000','2001','2002','2003','2004','2005','2006'];

ln_property_valid_state := [
'AK','AL','AR','AS','AZ','CA','CO','CT','DC','DE',
'FL','FM','GA','GU','HI','IA','ID','IL','IN','KS',
'KY','LA','MA','MD','ME','MH','MI','MN','MO','MP',
'MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY',
'OH','OK','ON','OR','PA','PR','PW','RI','SC','SD',
'TN','TX','UM','UT','VA','VI','VT','WA','WI','WV',
'WY'];

deed_base := ln_property.File_Deed;
//deed_base := dataset('~thor_data400::base::ln_property::20060804::deed', LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE, flat);
deed_file := deed_base(state in ln_property_valid_state and vendor_source_flag in ['DAYTN','OKCTY']);

// avm search file
sfa := avm_search(ln_fares_id[1] in ['D','O'], ln_fares_id[2] = 'A');
sfd := avm_search(ln_fares_id[1] in ['D','O'], ln_fares_id[2] in ['D','M']);

// Limit deeds to only those matching an assessor record
layout_avm_property_id := record
sfa.avm_property_id;
end;

sfa_pid_list := table(sfa, layout_avm_property_id);
sfa_pid_list_dedup := dedup(sfa_pid_list, all);

sfda := join(sfd,
             sfa_pid_list_dedup,
		   left.avm_property_id = right.avm_property_id,
		   transform(Layout_AVM_Search, self := left),
		   hash);

// Filter out bad characters from fields
valid_chars := ' !"#$%&`()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_\'abcdefghijklmnopqrstuvwxyz{|}~';

// Format output deed records
Layout_AVM_Deed FormatDeedsOut(deed_file l, sfda r) := transform
self.avm_property_id := intformat(r.avm_property_id, 12, 1);
self.fips_county_name := Stringlib.StringFilter(r.county_name, valid_chars);
self.county_name := Stringlib.StringFilter(l.county_name, valid_chars);
self.apnt_or_pin_number := Stringlib.StringFilter(l.apnt_or_pin_number, valid_chars);
self.property_full_street_address := Stringlib.StringFilter(l.property_full_street_address, valid_chars);
self.property_address_unit_number := Stringlib.StringFilter(l.property_address_unit_number, valid_chars);
self.property_address_citystatezip := Stringlib.StringFilter(l.property_address_citystatezip, valid_chars);
self.property_address_code := Stringlib.StringFilter(l.property_address_code, valid_chars);
self.legal_lot_code := Stringlib.StringFilter(l.legal_lot_code, valid_chars);
self.legal_lot_number := Stringlib.StringFilter(l.legal_lot_number, valid_chars);
self.legal_block := Stringlib.StringFilter(l.legal_block, valid_chars);
self.legal_section := Stringlib.StringFilter(l.legal_section, valid_chars);
self.legal_district := Stringlib.StringFilter(l.legal_district, valid_chars);
self.legal_land_lot := Stringlib.StringFilter(l.legal_land_lot, valid_chars);
self.legal_unit := Stringlib.StringFilter(l.legal_unit, valid_chars);
self.legal_city_municipality_township := Stringlib.StringFilter(l.legal_city_municipality_township, valid_chars);
self.legal_subdivision_name := Stringlib.StringFilter(l.legal_subdivision_name, valid_chars);
self.legal_phase_number := Stringlib.StringFilter(l.legal_phase_number, valid_chars);
self.legal_tract_number := Stringlib.StringFilter(l.legal_tract_number, valid_chars);
self.legal_sec_twn_rng_mer := Stringlib.StringFilter(l.legal_sec_twn_rng_mer, valid_chars);
self.legal_brief_description := Stringlib.StringFilter(l.legal_brief_description, valid_chars); 
self.recording_date := Stringlib.StringFilter(l.recording_date, valid_chars);
self.document_number := Stringlib.StringFilter(l.document_number, valid_chars);
self.document_type_code := Stringlib.StringFilter(l.document_type_code, valid_chars);
self.recorder_book_number := Stringlib.StringFilter(l.recorder_book_number, valid_chars);
self.recorder_page_number := Stringlib.StringFilter(l.recorder_page_number, valid_chars);
self.sales_price := Stringlib.StringFilter(l.sales_price, valid_chars);
self.sales_price_code := Stringlib.StringFilter(l.sales_price_code, valid_chars);
self.city_transfer_tax := Stringlib.StringFilter(l.city_transfer_tax, valid_chars);
self.county_transfer_tax := Stringlib.StringFilter(l.county_transfer_tax, valid_chars);
self.total_transfer_tax := Stringlib.StringFilter(l.total_transfer_tax, valid_chars);
self.first_td_loan_amount := Stringlib.StringFilter(l.first_td_loan_amount, valid_chars);
self.second_td_loan_amount := Stringlib.StringFilter(l.second_td_loan_amount, valid_chars);
self.first_td_lender_type_code := Stringlib.StringFilter(l.first_td_lender_type_code, valid_chars);
self.second_td_lender_type_code := Stringlib.StringFilter(l.second_td_lender_type_code, valid_chars); 
self.first_td_loan_type_code := Stringlib.StringFilter(l.first_td_loan_type_code, valid_chars);
self.type_financing := Stringlib.StringFilter(l.type_financing, valid_chars);
self.first_td_interest_rate := Stringlib.StringFilter(l.first_td_interest_rate, valid_chars);
self.first_td_due_date := Stringlib.StringFilter(l.first_td_due_date, valid_chars);
self.title_company_name := Stringlib.StringFilter(l.title_company_name, valid_chars);
self.partial_interest_transferred := Stringlib.StringFilter(l.partial_interest_transferred, valid_chars);
self.loan_term_months := Stringlib.StringFilter(l.loan_term_months, valid_chars);
self.loan_term_years := Stringlib.StringFilter(l.loan_term_years, valid_chars);
self.lender_name := Stringlib.StringFilter(l.lender_name, valid_chars);
self.lender_name_id := Stringlib.StringFilter(l.lender_name_id, valid_chars);
self.assessment_match_land_use_code := Stringlib.StringFilter(l.assessment_match_land_use_code, valid_chars);
self.property_use_code := Stringlib.StringFilter(l.property_use_code, valid_chars);
self.condo_code := Stringlib.StringFilter(l.condo_code, valid_chars);
self.timeshare_flag := Stringlib.StringFilter(l.timeshare_flag, valid_chars);
self.land_lot_size := Stringlib.StringFilter(l.land_lot_size, valid_chars);
self.rate_change_frequency := Stringlib.StringFilter(l.rate_change_frequency, valid_chars);
self.change_index := Stringlib.StringFilter(l.change_index, valid_chars);
self.adjustable_rate_index := Stringlib.StringFilter(l.adjustable_rate_index, valid_chars);
self.adjustable_rate_rider := Stringlib.StringFilter(l.adjustable_rate_rider, valid_chars);
self.graduated_payment_rider := Stringlib.StringFilter(l.graduated_payment_rider, valid_chars);
self.balloon_rider := Stringlib.StringFilter(l.balloon_rider, valid_chars);
self.fixed_step_rate_rider := Stringlib.StringFilter(l.fixed_step_rate_rider, valid_chars);
self.condominium_rider := Stringlib.StringFilter(l.condominium_rider, valid_chars);
self.planned_unit_development_rider := Stringlib.StringFilter(l.planned_unit_development_rider, valid_chars);
self.rate_improvement_rider := Stringlib.StringFilter(l.rate_improvement_rider, valid_chars);
self.assumability_rider := Stringlib.StringFilter(l.assumability_rider, valid_chars);
self.prepayment_rider := Stringlib.StringFilter(l.prepayment_rider, valid_chars);
self.one_four_family_rider := Stringlib.StringFilter(l.one_four_family_rider, valid_chars);
self.biweekly_payment_rider := Stringlib.StringFilter(l.biweekly_payment_rider, valid_chars);
self.second_home_rider := Stringlib.StringFilter(l.second_home_rider, valid_chars);
self.township := Stringlib.StringFilter(l.township, valid_chars);
self.land_use_code := Stringlib.StringFilter(l.land_use_code, valid_chars);
self.prim_name := Stringlib.StringFilter(r.prim_name, valid_chars);
self.prim_range := Stringlib.StringFilter(r.prim_range, valid_chars);
self.sec_range := Stringlib.StringFilter(r.sec_range, valid_chars);
self := l;
self := r;
end;

avm_deeds_init := join(deed_file,
                       sfda,
				   left.ln_fares_id = right.ln_fares_id,
				   FormatDeedsOut(left, right),
				   hash);
					 
avm_deeds_sort := sort(avm_deeds_init, avm_property_id);



export avm_deeds_out := avm_deeds_sort : persist('TEMP::avm_deeds_out');