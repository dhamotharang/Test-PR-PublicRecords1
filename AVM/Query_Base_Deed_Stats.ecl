import ln_property, ln_mortgage;

export ln_property_valid_state := [
'AK','AL','AR','AS','AZ','CA','CO','CT','DC','DE',
'FL','FM','GA','GU','HI','IA','ID','IL','IN','KS',
'KY','LA','MA','MD','ME','MH','MI','MN','MO','MP',
'MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY',
'OH','OK','ON','OR','PA','PR','PW','RI','SC','SD',
'TN','TX','UM','UT','VA','VI','VT','WA','WI','WV',
'WY'];

in_file := ln_property.File_Deed(state in ln_property_valid_state and vendor_source_flag in ['DAYTN','OKCTY']);

fNonzero(string Input) :=
 if(length(trim(stringlib.stringfilter(Input,'0')))=length(trim(Input)),'',Input);

LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE t1(LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE l) := transform
 self.county_name := stringlib.stringtouppercase(l.county_name);
 self := l;
end;

p1 := project(in_file,t1(left));

deed_sam_dist := p1;
//deed_sam_dist := distribute(p1,hash(fips_code,state,county_name));

deed_sam_counts_rec :=  record
deed_sam_total := count(group);
deed_sam_dist.state;
deed_sam_dist.county_name;
//has_fips_code                        := count(group,trim(deed_sam_dist.fips_code)!='');
//has_state                            := count(group,trim(deed_sam_dist.state)!='');
//has_county_name                      := count(group,trim(deed_sam_dist.county_name)!='');
has_apn                              := count(group,trim(fNonzero(deed_sam_dist.apnt_or_pin_number))!='');
has_buyer1                           := count(group,trim(deed_sam_dist.buyer1)!='');
has_buyer1_id_code                   := count(group,trim(deed_sam_dist.buyer1_id_code)!='');
has_buyer2                           := count(group,trim(deed_sam_dist.buyer2)!='');
has_buyer2_id_code                   := count(group,trim(deed_sam_dist.buyer2_id_code)!='');
has_buyer_vesting_code               := count(group,trim(deed_sam_dist.buyer_vesting_code)!='');
has_buyer_addendum_flag              := count(group,trim(deed_sam_dist.buyer_addendum_flag)!='');
has_phone_number                     := count(group,trim(deed_sam_dist.phone_number)!='');
has_buyer_mailing_careof             := count(group,trim(deed_sam_dist.buyer_mailing_address_care_of_name)!='');
has_buyer_mailing_address            := count(group,trim(deed_sam_dist.buyer_mailing_full_street_address)!='');
has_buyer_mailing_unit_number        := count(group,trim(deed_sam_dist.buyer_mailing_address_unit_number)!='');
has_buyer_citystatezip               := count(group,trim(deed_sam_dist.buyer_mailing_address_citystatezip)!='');
has_borrower1                        := count(group,trim(deed_sam_dist.borrower1)!='');
has_borrower1_id_code                := count(group,trim(deed_sam_dist.borrower1_id_code)!='');
has_borrower2                        := count(group,trim(deed_sam_dist.borrower2)!='');
has_borrower2_id_code                := count(group,trim(deed_sam_dist.borrower2_id_code)!='');
has_borrower_vesting_code            := count(group,trim(deed_sam_dist.borrower_vesting_code)!='');
has_borrower_mailing_address         := count(group,trim(deed_sam_dist.borrower_mailing_full_street_address)!='');
has_borrower_mailing_unit_number     := count(group,trim(deed_sam_dist.borrower_mailing_unit_number)!='');
has_borrower_citystatezip            := count(group,trim(deed_sam_dist.borrower_mailing_citystatezip)!='');
has_seller1                          := count(group,trim(deed_sam_dist.seller1)!='');
has_seller1_id_code                  := count(group,trim(deed_sam_dist.seller1_id_code)!='');
has_seller2                          := count(group,trim(deed_sam_dist.seller2)!='');
has_seller2_id_code                  := count(group,trim(deed_sam_dist.seller2_id_code)!='');
has_seller_addendum_flag             := count(group,trim(deed_sam_dist.seller_addendum_flag)!='');
has_seller_full_street_address       := count(group,trim(deed_sam_dist.seller_mailing_full_street_address)!='');
has_seller_address_unit_number       := count(group,trim(deed_sam_dist.seller_mailing_address_unit_number)!='');
has_seller_address_citystatezip      := count(group,trim(deed_sam_dist.seller_mailing_address_citystatezip)!='');
has_property_full_street_address     := count(group,trim(deed_sam_dist.property_full_street_address)!='');
has_property_address_unit_number     := count(group,trim(deed_sam_dist.property_address_unit_number)!='');
has_property_address_citystatezip    := count(group,trim(deed_sam_dist.property_address_citystatezip)!='');
has_property_address_code            := count(group,trim(deed_sam_dist.property_address_code)!='');
has_legal_lot_number                 := count(group,trim(deed_sam_dist.legal_lot_number)!='');
has_legal_block                      := count(group,trim(deed_sam_dist.legal_block)!='');
has_legal_section                    := count(group,trim(deed_sam_dist.legal_section)!='');
has_legal_district                   := count(group,trim(deed_sam_dist.legal_district)!='');
has_legal_land_lot                   := count(group,trim(deed_sam_dist.legal_land_lot)!='');
has_legal_unit                       := count(group,trim(deed_sam_dist.legal_unit)!='');
has_legal_city_municipality_township := count(group,trim(deed_sam_dist.legal_city_municipality_township)!='');
has_legal_subdivision_name           := count(group,trim(deed_sam_dist.legal_subdivision_name)!='');
has_legal_phase_number               := count(group,trim(deed_sam_dist.legal_phase_number)!='');
has_legal_tract_number               := count(group,trim(deed_sam_dist.legal_tract_number)!='');
has_legal_brief_description          := count(group,trim(deed_sam_dist.legal_brief_description)!='');
has_legal_sec_twn_rng_mer            := count(group,trim(deed_sam_dist.legal_sec_twn_rng_mer)!='');
has_recording_date                   := count(group,trim(fNonzero(deed_sam_dist.recording_date))!='');
has_document_number                  := count(group,trim(fNonzero(deed_sam_dist.document_number))!='');
has_document_type_code               := count(group,trim(fNonzero(deed_sam_dist.document_type_code))!='');
has_recorder_book_number             := count(group,trim(fNonzero(deed_sam_dist.recorder_book_number))!='');
has_recorder_page_number             := count(group,trim(fNonzero(deed_sam_dist.recorder_page_number))!='');
has_sales_price                      := count(group,trim(fNonzero(deed_sam_dist.sales_price))!='');
has_sales_price_code                 := count(group,trim(deed_sam_dist.sales_price_code)!='');
has_city_transfer_tax                := count(group,trim(fNonzero(deed_sam_dist.city_transfer_tax))!='');
has_county_transfer_tax              := count(group,trim(fNonzero(deed_sam_dist.county_transfer_tax))!='');
has_total_transfer_tax               := count(group,trim(fNonzero(deed_sam_dist.total_transfer_tax))!='');
has_first_td_loan_amount             := count(group,trim(fNonzero(deed_sam_dist.first_td_loan_amount))!='');
has_second_td_loan_amount            := count(group,trim(fNonzero(deed_sam_dist.second_td_loan_amount))!='');
has_first_td_lender_type_code        := count(group,trim(deed_sam_dist.first_td_lender_type_code)!='');
has_first_td_loan_type_code          := count(group,trim(deed_sam_dist.first_td_loan_type_code)!=''); 
has_first_td_interest_rate           := count(group,trim(fNonzero(deed_sam_dist.first_td_interest_rate))!='');
has_first_td_due_date                := count(group,trim(fNonzero(deed_sam_dist.first_td_due_date))!='');
has_type_financing                   := count(group,trim(deed_sam_dist.type_financing)!='');
has_title_company_name               := count(group,trim(deed_sam_dist.title_company_name)!='');
has_partial_interest_transferred     := count(group,trim(deed_sam_dist.partial_interest_transferred)!='');
has_loan_term_months                 := count(group,trim(fNonzero(deed_sam_dist.loan_term_months))!='');
has_loan_term_years                  := count(group,trim(fNonzero(deed_sam_dist.loan_term_years))!='');
has_lender_name                      := count(group,trim(deed_sam_dist.lender_name)!='');
has_lender_name_id                   := count(group,trim(deed_sam_dist.lender_name_id)!='');
has_assessment_match_land_use_code   := count(group,trim(deed_sam_dist.assessment_match_land_use_code)!='');
has_condo_code                       := count(group,trim(deed_sam_dist.condo_code)!='');
has_timeshare_flag                   := count(group,trim(deed_sam_dist.timeshare_flag)!='');
has_land_lot_size                    := count(group,trim(deed_sam_dist.land_lot_size)!='');
has_property_use_code                := count(group,trim(deed_sam_dist.property_use_code)!='');
has_rate_change_frequency            := count(group,trim(deed_sam_dist.rate_change_frequency)!='');
has_change_index                     := count(group,trim(deed_sam_dist.change_index)!='');
has_adjustable_rate_index            := count(group,trim(deed_sam_dist.adjustable_rate_index)!='');
has_adjustable_rate_rider            := count(group,trim(deed_sam_dist.adjustable_rate_rider)!='');
has_graduated_payment_rider          := count(group,trim(deed_sam_dist.graduated_payment_rider)!='');
has_balloon_rider                    := count(group,trim(deed_sam_dist.balloon_rider)!='');
has_fixed_step_rate_rider            := count(group,trim(deed_sam_dist.fixed_step_rate_rider)!='');
has_condominium_rider                := count(group,trim(deed_sam_dist.condominium_rider)!='');
has_planned_unit_development_rider   := count(group,trim(deed_sam_dist.planned_unit_development_rider)!='');
has_rate_improvement_rider           := count(group,trim(deed_sam_dist.rate_improvement_rider)!='');
has_assumability_rider               := count(group,trim(deed_sam_dist.assumability_rider)!='');
has_prepayment_rider                 := count(group,trim(deed_sam_dist.prepayment_rider)!='');
has_one_four_family_rider            := count(group,trim(deed_sam_dist.one_four_family_rider)!='');
has_biweekly_payment_rider           := count(group,trim(deed_sam_dist.biweekly_payment_rider)!='');
has_second_home_rider                := count(group,trim(deed_sam_dist.second_home_rider)!='');
has_township                         := count(group,trim(deed_sam_dist.township)!='');
has_land_use_code                    := count(group,trim(deed_sam_dist.land_use_code)!='');

end;

results := sort(table(deed_sam_dist,deed_sam_counts_rec,state,county_name,few),state,county_name);
output(results,all);

//deed_sam_counts := table(deed_sam_dist,deed_sam_counts_rec,few);

//output(deed_sam_counts);

/*
slimrec := record
  deed_sam_file.fips_code;
  deed_sam_file.state;
  deed_sam_file.county_name;
  string8   coverage_dt;
end;

slimrec t1(deed_sam_file l) := transform
 self.coverage_dt := if(trim(l.recording_date)!='',l.recording_date,
					 if(trim(l.contract_date)!='',l.contract_date,
					 ''));
 self := l;
end;

p1 := project(deed_sam_file, t1(left));

slimrec t2(p1 l) := transform
 self.coverage_dt := if(trim(l.coverage_dt)='','NODATE',
                     if(~regexfind('[1-2][0-9][0-9][0-9][0-9][0-9][0-9][0-9]',l.coverage_dt),'NOTVALID',
                     if(l.coverage_dt[1..3]='198' OR l.coverage_dt[1..3]='199',l.coverage_dt[1..4],
					 if(l.coverage_dt[1..3]<'193','BFOR1930',
					 if(l.coverage_dt[1..3]<='197',l.coverage_dt[1..3]+'0\'s',
					 if(l.coverage_dt[1..3]>='200',l.coverage_dt[1..6],
					 ''))))));
 self := l;
end

p2 := project(p1, t2(left)); 

outrec := record
 p2.fips_code;
 p2.state;
 p2.county_name;
 p2.coverage_dt;
 decimal10 count_ := count(group);
end;

table1 := table(p2,outrec,fips_code,state,county_name,coverage_dt);
table1_sort := sort(table1,record);
//table1_first := table1_sort(fips_code[1..2]<'26');
//table1_second := table1_sort(fips_code[1..2]>='26');
output(table1_sort,all);
*/
