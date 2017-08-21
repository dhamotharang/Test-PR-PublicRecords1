#option('skipFileFormatCrcCheck', 1);

fips_rec := record
 string2  st;
 string5  fips;
 string40 county;
 string3  not_relevant;
end;

fips_lookup := dedup(sort(dataset('~thor_data400::in::fips_code_lookup',fips_rec,flat),fips),fips);

ds_deed := distribute(ln_propertyv2.File_Deed      (vendor_source_flag in ['D','O'] and fips_code in ln_property.valid_fips),hash(ln_fares_id));
ds_assr := distribute(ln_propertyv2.File_Assessment(vendor_source_flag in ['D','O'] and fips_code in ln_property.valid_fips),hash(ln_fares_id));
ds_srch := ln_propertyv2.File_Search_DID(vendor_source_flag in ['D','O'] and source_code[2]='P' and ((prim_range<>'' or prim_name<>'') and zip<>''));

r_srch := record
 ds_srch.ln_fares_id;
 ds_srch.prim_range;
 ds_srch.prim_name;
 ds_srch.sec_range;
 ds_srch.zip;
 integer prop_cnt;
end;

r_srch t_srch(ds_srch le) := transform
 self.prop_cnt := 1;
 self          := le;
end;

p3        := project   (ds_srch,t_srch(left));
p3_dist   := distribute(p3,hash(ln_fares_id));
p3_sort   := sort      (p3_dist,ln_fares_id,local);
srch_dupd := dedup     (p3_sort,ln_fares_id,local) : persist('persist::jtrost_risk_prop_srch_dupd');

r1 := record
 string2  st_lookup    :='';
 string40 county_lookup:='';
 string5  fips_lookup  :='';
 string10 prim_range;
 string28 prim_name;
 string8  sec_range;
 string5  zip;
 boolean  is_2009;
 boolean  is_2008;
 boolean  is_2007;
 boolean  is_2006;
 boolean  is_2005;
 boolean  is_2004;
 boolean  pre_2004;
 boolean  no_date;
 boolean  in_fidelity;
 ds_deed;
end;

r1b := record
 string2  st_lookup    :='';
 string40 county_lookup:='';
 string5  fips_lookup  :='';
 string10 prim_range;
 string28 prim_name;
 string8  sec_range;
 string5  zip;
 boolean  is_2009;
 boolean  is_2008;
 boolean  is_2007;
 boolean  is_2006;
 boolean  is_2005;
 boolean  is_2004;
 boolean  pre_2004;
 boolean  no_date;
 boolean  in_fidelity;
 ds_assr;
end;

r1 t1(ds_deed le, srch_dupd ri) := transform
 self.fips_code   := if(le.fips_code='12025','12086',le.fips_code);
 self.county_name := stringlib.stringtouppercase(le.county_name);
 self.is_2009     := le.recording_date[1..4]='2009' or le.contract_date[1..4]='2009';
 self.is_2008     := self.is_2009=false and (le.recording_date[1..4]='2008' or le.contract_date[1..4]='2008');
 self.is_2007     := self.is_2009=false and self.is_2008=false and (le.recording_date[1..4]='2007' or le.contract_date[1..4]='2007');
 self.is_2006     := self.is_2009=false and self.is_2008=false and self.is_2007=false and (le.recording_date[1..4]='2006' or le.contract_date[1..4]='2006');
 self.is_2005     := self.is_2009=false and self.is_2008=false and self.is_2007=false and self.is_2006=false and (le.recording_date[1..4]='2005' or le.contract_date[1..4]='2005');
 self.is_2004     := self.is_2009=false and self.is_2008=false and self.is_2007=false and self.is_2006=false and self.is_2005=false and (le.recording_date[1..4]='2004' or le.contract_date[1..4]='2004');
 self.pre_2004    := self.is_2009=false and self.is_2008=false and self.is_2007=false and self.is_2006=false and self.is_2005=false and self.is_2004=false and (le.recording_date[1..4] between '1900' and '2003' or le.contract_date[1..4] between '1900' and '2003');
 self.no_date     := trim(le.recording_date)='' and trim(le.contract_date)='';
 self.prim_range  := ri.prim_range;
 self.prim_name   := ri.prim_name;
 self.sec_range   := ri.sec_range;
 self.zip         := ri.zip;
 self.in_fidelity := true;
 self             := le;
end;

r1b t1b(ds_assr le, srch_dupd ri) := transform
 self.fips_code   := if(le.fips_code='12025','12086',le.fips_code);
 self.county_name := stringlib.stringtouppercase(le.county_name);
 self.is_2009     := le.assessed_value_year='2009' or le.tax_year='2009';
 self.is_2008     := self.is_2009=false and (le.assessed_value_year='2008' or le.tax_year='2008');
 self.is_2007     := self.is_2009=false and self.is_2008=false and (le.assessed_value_year='2007' or le.tax_year='2007');
 self.is_2006     := self.is_2009=false and self.is_2008=false and self.is_2007=false and (le.assessed_value_year='2006' or le.tax_year='2006');
 self.is_2005     := self.is_2009=false and self.is_2008=false and self.is_2007=false and self.is_2006=false and (le.assessed_value_year='2005' or le.tax_year='2005');
 self.is_2004     := self.is_2009=false and self.is_2008=false and self.is_2007=false and self.is_2006=false and self.is_2005=false and (le.assessed_value_year='2004' or le.tax_year='2004');
 self.pre_2004    := self.is_2009=false and self.is_2008=false and self.is_2007=false and self.is_2006=false and self.is_2005=false and self.is_2004=false and (le.assessed_value_year between '1900' and '2003' or le.tax_year between '1900' and '2003');
 self.no_date     := trim(le.assessed_value_year)='' and trim(le.tax_year)='';
 self.prim_range  := ri.prim_range;
 self.prim_name   := ri.prim_name;
 self.sec_range   := ri.sec_range;
 self.zip         := ri.zip;
 self.in_fidelity := true;
 self             := le;
end;

p1_0 := join(ds_deed,srch_dupd,left.ln_fares_id=right.ln_fares_id,t1 (left,right),left outer,local)(~(is_2009=false and is_2008=false and is_2007=false and is_2006=false and is_2005=false and is_2004=false and pre_2004=false and no_date=false)) : persist('persist::jtrost0a');
p2_0 := join(ds_assr,srch_dupd,left.ln_fares_id=right.ln_fares_id,t1b(left,right),left outer,local)(~(is_2009=false and is_2008=false and is_2007=false and is_2006=false and is_2005=false and is_2004=false and pre_2004=false and no_date=false)) : persist('persist::jtrost0b');

r1 t1_0(p1_0 le, fips_lookup ri) := transform
 //to handle name variations (e.g. SAINT LOUIS COUNTY vs ST LOUIS COUNTY)
 self.county_name := stringlib.stringtouppercase(ri.county);
 self := le;
end;

r1b t1_0b(p2_0 le, fips_lookup ri) := transform
 self.county_name := stringlib.stringtouppercase(ri.county);
 self := le;
end;

p1 := join(p1_0,fips_lookup,left.fips_code=right.fips,t1_0 (left,right),lookup);
p2 := join(p2_0,fips_lookup,left.fips_code=right.fips,t1_0b(left,right),lookup);

p1_bad := join(p1_0,fips_lookup,left.fips_code=right.fips,t1_0 (left,right),left only,lookup);
p2_bad := join(p2_0,fips_lookup,left.fips_code=right.fips,t1_0b(left,right),left only,lookup);

//output(count(p1_bad));
//output(count(p2_bad));
//output(p1_bad);
//output(p2_bad);
//p1 := p1_0;
//p2 := p2_0;

//count(p1);
//count(p2);
//output(p1);
//output(p2);

r2 :=  record
    p1.from_file;
	nbr_of_records := count(group);
	p1.is_2009;
	p1.is_2008;
	p1.is_2007;
	p1.is_2006;
	p1.is_2005;
	p1.is_2004;
	p1.pre_2004;
	p1.no_date;
    //CountGroup                                                                := count(group);
    //Pdeed.vendor_source_flag;
	//ln_fares_id_CountNonBlank                                                 := sum(group,if(p1.ln_fares_id<>'',1,0));
    //process_date_CountNonBlank                                                := sum(group,if(p1.process_date<>'',1,0));
    //vendor_source_flag_CountNonBlank                                          := sum(group,if(p1.vendor_source_flag<>'',1,0));
    current_record_CountNonBlank                                              := sum(group,if(p1.current_record<>'',1,0));
    //from_file_CountNonBlank                                                   := sum(group,if(p1.from_file<>'',1,0));
    fips_code_CountNonBlank                                                   := sum(group,if(p1.fips_code<>'',1,0));
    state_CountNonBlank                                                       := sum(group,if(p1.state<>'',1,0));
    county_name_CountNonBlank                                                 := sum(group,if(p1.county_name<>'',1,0));
    record_type_CountNonBlank                                                 := sum(group,if(p1.record_type<>'',1,0));
    apnt_or_pin_number_CountNonBlank                                          := sum(group,if(p1.apnt_or_pin_number<>'',1,0));
    fares_unformatted_apn_CountNonBlank                                       := sum(group,if(p1.fares_unformatted_apn<>'',1,0));
    multi_apn_flag_CountNonBlank                                              := sum(group,if(p1.multi_apn_flag<>'',1,0));
    tax_id_number_CountNonBlank                                               := sum(group,if(p1.tax_id_number<>'',1,0));
    excise_tax_number_CountNonBlank                                           := sum(group,if(p1.excise_tax_number<>'',1,0));
    buyer_or_borrower_ind_CountNonBlank                                       := sum(group,if(p1.buyer_or_borrower_ind<>'',1,0));
    name1_CountNonBlank                                                       := sum(group,if(p1.name1<>'',1,0));
    name1_id_code_CountNonBlank                                               := sum(group,if(p1.name1_id_code<>'',1,0));
    name2_CountNonBlank                                                       := sum(group,if(p1.name2<>'',1,0));
    name2_id_code_CountNonBlank                                               := sum(group,if(p1.name2_id_code<>'',1,0));
    vesting_code_CountNonBlank                                                := sum(group,if(p1.vesting_code<>'',1,0));
    addendum_flag_CountNonBlank                                               := sum(group,if(p1.addendum_flag<>'',1,0));
    phone_number_CountNonBlank                                                := sum(group,if(p1.phone_number<>'',1,0));
    mailing_care_of_CountNonBlank                                             := sum(group,if(p1.mailing_care_of<>'',1,0));
    mailing_street_CountNonBlank                                              := sum(group,if(p1.mailing_street<>'',1,0));
    mailing_unit_number_CountNonBlank                                         := sum(group,if(p1.mailing_unit_number<>'',1,0));
    mailing_csz_CountNonBlank                                                 := sum(group,if(p1.mailing_csz<>'',1,0));
    mailing_address_cd_CountNonBlank                                          := sum(group,if(p1.mailing_address_cd<>'',1,0));
    seller1_CountNonBlank                                                     := sum(group,if(p1.seller1<>'',1,0));
    seller1_id_code_CountNonBlank                                             := sum(group,if(p1.seller1_id_code<>'',1,0));
    seller2_CountNonBlank                                                     := sum(group,if(p1.seller2<>'',1,0));
    seller2_id_code_CountNonBlank                                             := sum(group,if(p1.seller2_id_code<>'',1,0));
    seller_addendum_flag_CountNonBlank                                        := sum(group,if(p1.seller_addendum_flag<>'',1,0));
    seller_mailing_full_street_address_CountNonBlank                          := sum(group,if(p1.seller_mailing_full_street_address<>'',1,0));
    seller_mailing_address_unit_number_CountNonBlank                          := sum(group,if(p1.seller_mailing_address_unit_number<>'',1,0));
    seller_mailing_address_citystatezip_CountNonBlank                         := sum(group,if(p1.seller_mailing_address_citystatezip<>'',1,0));
    property_full_street_address_CountNonBlank                                := sum(group,if(p1.property_full_street_address<>'',1,0));
    property_address_unit_number_CountNonBlank                                := sum(group,if(p1.property_address_unit_number<>'',1,0));
    property_address_citystatezip_CountNonBlank                               := sum(group,if(p1.property_address_citystatezip<>'',1,0));
    property_address_code_CountNonBlank                                       := sum(group,if(p1.property_address_code<>'',1,0));
    legal_lot_code_CountNonBlank                                              := sum(group,if(p1.legal_lot_code<>'',1,0));
    legal_lot_number_CountNonBlank                                            := sum(group,if(p1.legal_lot_number<>'',1,0));
    legal_block_CountNonBlank                                                 := sum(group,if(p1.legal_block<>'',1,0));
    legal_section_CountNonBlank                                               := sum(group,if(p1.legal_section<>'',1,0));
    legal_district_CountNonBlank                                              := sum(group,if(p1.legal_district<>'',1,0));
    legal_land_lot_CountNonBlank                                              := sum(group,if(p1.legal_land_lot<>'',1,0));
    legal_unit_CountNonBlank                                                  := sum(group,if(p1.legal_unit<>'',1,0));
    legal_city_municipality_township_CountNonBlank                            := sum(group,if(p1.legal_city_municipality_township<>'',1,0));
    legal_subdivision_name_CountNonBlank                                      := sum(group,if(p1.legal_subdivision_name<>'',1,0));
    legal_phase_number_CountNonBlank                                          := sum(group,if(p1.legal_phase_number<>'',1,0));
    legal_tract_number_CountNonBlank                                          := sum(group,if(p1.legal_tract_number<>'',1,0));
    legal_sec_twn_rng_mer_CountNonBlank                                       := sum(group,if(p1.legal_sec_twn_rng_mer<>'',1,0));
    legal_brief_description_CountNonBlank                                     := sum(group,if(p1.legal_brief_description<>'',1,0));
    recorder_map_reference_CountNonBlank                                      := sum(group,if(p1.recorder_map_reference<>'',1,0));
    complete_legal_description_code_CountNonBlank                             := sum(group,if(p1.complete_legal_description_code<>'',1,0));
    contract_date_CountNonBlank                                               := sum(group,if(p1.contract_date<>'',1,0));
    recording_date_CountNonBlank                                              := sum(group,if(p1.recording_date<>'',1,0));
	arm_reset_date_CountNonBlank                                              := sum(group,if(p1.arm_reset_date<>'',1,0));
    document_number_CountNonBlank                                             := sum(group,if(p1.document_number<>'',1,0));
    document_type_code_CountNonBlank                                          := sum(group,if(p1.document_type_code<>'',1,0));
    loan_number_CountNonBlank                                                 := sum(group,if(p1.loan_number<>'',1,0));
    recorder_book_number_CountNonBlank                                        := sum(group,if(p1.recorder_book_number<>'',1,0));
    recorder_page_number_CountNonBlank                                        := sum(group,if(p1.recorder_page_number<>'',1,0));
    concurrent_mortgage_book_page_document_number_CountNonBlank               := sum(group,if(p1.concurrent_mortgage_book_page_document_number<>'',1,0));
    sales_price_CountNonBlank                                                 := sum(group,if(p1.sales_price<>'',1,0));
    sales_price_code_CountNonBlank                                            := sum(group,if(p1.sales_price_code<>'',1,0));
    city_transfer_tax_CountNonBlank                                           := sum(group,if(p1.city_transfer_tax<>'',1,0));
    county_transfer_tax_CountNonBlank                                         := sum(group,if(p1.county_transfer_tax<>'',1,0));
    total_transfer_tax_CountNonBlank                                          := sum(group,if(p1.total_transfer_tax<>'',1,0));
    first_td_loan_amount_CountNonBlank                                        := sum(group,if(p1.first_td_loan_amount<>'',1,0));
    second_td_loan_amount_CountNonBlank                                       := sum(group,if(p1.second_td_loan_amount<>'',1,0));
    first_td_lender_type_code_CountNonBlank                                   := sum(group,if(p1.first_td_lender_type_code<>'',1,0));
    second_td_lender_type_code_CountNonBlank                                  := sum(group,if(p1.second_td_lender_type_code<>'',1,0));
    first_td_loan_type_code_CountNonBlank                                     := sum(group,if(p1.first_td_loan_type_code<>'',1,0));
    type_financing_CountNonBlank                                              := sum(group,if(p1.type_financing<>'',1,0));
    first_td_interest_rate_CountNonBlank                                      := sum(group,if(p1.first_td_interest_rate<>'',1,0));
    first_td_due_date_CountNonBlank                                           := sum(group,if(p1.first_td_due_date<>'',1,0));
    title_company_name_CountNonBlank                                          := sum(group,if(p1.title_company_name<>'',1,0));
    partial_interest_transferred_CountNonBlank                                := sum(group,if(p1.partial_interest_transferred<>'',1,0));
    loan_term_months_CountNonBlank                                            := sum(group,if(p1.loan_term_months<>'',1,0));
    loan_term_years_CountNonBlank                                             := sum(group,if(p1.loan_term_years<>'',1,0));
    lender_name_CountNonBlank                                                 := sum(group,if(p1.lender_name<>'',1,0));
    lender_name_id_CountNonBlank                                              := sum(group,if(p1.lender_name_id<>'',1,0));
    lender_dba_aka_name_CountNonBlank                                         := sum(group,if(p1.lender_dba_aka_name<>'',1,0));
    lender_full_street_address_CountNonBlank                                  := sum(group,if(p1.lender_full_street_address<>'',1,0));
    lender_address_unit_number_CountNonBlank                                  := sum(group,if(p1.lender_address_unit_number<>'',1,0));
    lender_address_citystatezip_CountNonBlank                                 := sum(group,if(p1.lender_address_citystatezip<>'',1,0));
    assessment_match_land_use_code_CountNonBlank                              := sum(group,if(p1.assessment_match_land_use_code<>'',1,0));
    property_use_code_CountNonBlank                                           := sum(group,if(p1.property_use_code<>'',1,0));
    condo_code_CountNonBlank                                                  := sum(group,if(p1.condo_code<>'',1,0));
    timeshare_flag_CountNonBlank                                              := sum(group,if(p1.timeshare_flag<>'',1,0));
    land_lot_size_CountNonBlank                                               := sum(group,if(p1.land_lot_size<>'',1,0));
    hawaii_tct_CountNonBlank                                                  := sum(group,if(p1.hawaii_tct<>'',1,0));
    hawaii_condo_cpr_code_CountNonBlank                                       := sum(group,if(p1.hawaii_condo_cpr_code<>'',1,0));
    hawaii_condo_name_CountNonBlank                                           := sum(group,if(p1.hawaii_condo_name<>'',1,0));
    filler_except_hawaii_CountNonBlank                                        := sum(group,if(p1.filler_except_hawaii<>'',1,0));
    rate_change_frequency_CountNonBlank                                       := sum(group,if(p1.rate_change_frequency<>'',1,0));
    change_index_CountNonBlank                                                := sum(group,if(p1.change_index<>'',1,0));
    adjustable_rate_index_CountNonBlank                                       := sum(group,if(p1.adjustable_rate_index<>'',1,0));
    adjustable_rate_rider_CountNonBlank                                       := sum(group,if(p1.adjustable_rate_rider<>'',1,0));
    graduated_payment_rider_CountNonBlank                                     := sum(group,if(p1.graduated_payment_rider<>'',1,0));
    balloon_rider_CountNonBlank                                               := sum(group,if(p1.balloon_rider<>'',1,0));
    fixed_step_rate_rider_CountNonBlank                                       := sum(group,if(p1.fixed_step_rate_rider<>'',1,0));
    condominium_rider_CountNonBlank                                           := sum(group,if(p1.condominium_rider<>'',1,0));
    planned_unit_development_rider_CountNonBlank                              := sum(group,if(p1.planned_unit_development_rider<>'',1,0));
    rate_improvement_rider_CountNonBlank                                      := sum(group,if(p1.rate_improvement_rider<>'',1,0));
    assumability_rider_CountNonBlank                                          := sum(group,if(p1.assumability_rider<>'',1,0));
    prepayment_rider_CountNonBlank                                            := sum(group,if(p1.prepayment_rider<>'',1,0));
    one_four_family_rider_CountNonBlank                                       := sum(group,if(p1.one_four_family_rider<>'',1,0));
    biweekly_payment_rider_CountNonBlank                                      := sum(group,if(p1.biweekly_payment_rider<>'',1,0));
    second_home_rider_CountNonBlank                                           := sum(group,if(p1.second_home_rider<>'',1,0));
    data_source_code_CountNonBlank                                            := sum(group,if(p1.data_source_code<>'',1,0));
    main_record_id_code_CountNonBlank                                         := sum(group,if(p1.main_record_id_code<>'',1,0));
    addl_name_flag_CountNonBlank                                              := sum(group,if(p1.addl_name_flag<>'',1,0));
    prop_addr_propagated_ind_CountNonBlank                                    := sum(group,if(p1.prop_addr_propagated_ind<>'',1,0));
end;

r2b :=  record
    nbr_of_records := count(group);
	p2.is_2009;
	p2.is_2008;
	p2.is_2007;
	p2.is_2006;
	p2.is_2005;
	p2.is_2004;
	p2.pre_2004;
	p2.no_date;
    //CountGroup                                                    := count(group);
	//pAsses.vendor_source_flag;
    //ln_fares_id_CountNonBlank                                     := sum(group,if(p2.ln_fares_id<>'',1,0));
    //process_date_CountNonBlank                                    := sum(group,if(p2.process_date<>'',1,0));
    //vendor_source_flag_CountNonBlank                              := sum(group,if(p2.vendor_source_flag<>'',1,0));
    current_record_CountNonBlank                                  := sum(group,if(p2.current_record<>'',1,0));
    fips_code_CountNonBlank                                       := sum(group,if(p2.fips_code<>'',1,0));
    state_code_CountNonBlank                                      := sum(group,if(p2.state_code<>'',1,0));
    county_name_CountNonBlank                                     := sum(group,if(p2.county_name<>'',1,0));
    apna_or_pin_number_CountNonBlank                              := sum(group,if(p2.apna_or_pin_number<>'',1,0));
    fares_unformatted_apn_CountNonBlank                           := sum(group,if(p2.fares_unformatted_apn<>'',1,0));
    duplicate_apn_multiple_address_id_CountNonBlank               := sum(group,if(p2.duplicate_apn_multiple_address_id<>'',1,0));
    assessee_name_CountNonBlank                                   := sum(group,if(p2.assessee_name<>'',1,0));
    second_assessee_name_CountNonBlank                            := sum(group,if(p2.second_assessee_name<>'',1,0));
    assessee_ownership_rights_code_CountNonBlank                  := sum(group,if(p2.assessee_ownership_rights_code<>'',1,0));
    assessee_relationship_code_CountNonBlank                      := sum(group,if(p2.assessee_relationship_code<>'',1,0));
    assessee_phone_number_CountNonBlank                           := sum(group,if(p2.assessee_phone_number<>'',1,0));
    tax_account_number_CountNonBlank                              := sum(group,if(p2.tax_account_number<>'',1,0));
    contract_owner_CountNonBlank                                  := sum(group,if(p2.contract_owner<>'',1,0));
    assessee_name_type_code_CountNonBlank                         := sum(group,if(p2.assessee_name_type_code<>'',1,0));
    second_assessee_name_type_code_CountNonBlank                  := sum(group,if(p2.second_assessee_name_type_code<>'',1,0));
    mail_care_of_name_type_code_CountNonBlank                     := sum(group,if(p2.mail_care_of_name_type_code<>'',1,0));
    mailing_care_of_name_CountNonBlank                            := sum(group,if(p2.mailing_care_of_name<>'',1,0));
    mailing_full_street_address_CountNonBlank                     := sum(group,if(p2.mailing_full_street_address<>'',1,0));
    mailing_unit_number_CountNonBlank                             := sum(group,if(p2.mailing_unit_number<>'',1,0));
    mailing_city_state_zip_CountNonBlank                          := sum(group,if(p2.mailing_city_state_zip<>'',1,0));
    property_full_street_address_CountNonBlank                    := sum(group,if(p2.property_full_street_address<>'',1,0));
    property_unit_number_CountNonBlank                            := sum(group,if(p2.property_unit_number<>'',1,0));
    property_city_state_zip_CountNonBlank                         := sum(group,if(p2.property_city_state_zip<>'',1,0));
    property_country_code_CountNonBlank                           := sum(group,if(p2.property_country_code<>'',1,0));
    property_address_code_CountNonBlank                           := sum(group,if(p2.property_address_code<>'',1,0));
    legal_lot_code_CountNonBlank                                  := sum(group,if(p2.legal_lot_code<>'',1,0));
    legal_lot_number_CountNonBlank                                := sum(group,if(p2.legal_lot_number<>'',1,0));
    legal_land_lot_CountNonBlank                                  := sum(group,if(p2.legal_land_lot<>'',1,0));
    legal_block_CountNonBlank                                     := sum(group,if(p2.legal_block<>'',1,0));
    legal_section_CountNonBlank                                   := sum(group,if(p2.legal_section<>'',1,0));
    legal_district_CountNonBlank                                  := sum(group,if(p2.legal_district<>'',1,0));
    legal_unit_CountNonBlank                                      := sum(group,if(p2.legal_unit<>'',1,0));
    legal_city_municipality_township_CountNonBlank                := sum(group,if(p2.legal_city_municipality_township<>'',1,0));
    legal_subdivision_name_CountNonBlank                          := sum(group,if(p2.legal_subdivision_name<>'',1,0));
    legal_phase_number_CountNonBlank                              := sum(group,if(p2.legal_phase_number<>'',1,0));
    legal_tract_number_CountNonBlank                              := sum(group,if(p2.legal_tract_number<>'',1,0));
    legal_sec_twn_rng_mer_CountNonBlank                           := sum(group,if(p2.legal_sec_twn_rng_mer<>'',1,0));
    legal_brief_description_CountNonBlank                         := sum(group,if(p2.legal_brief_description<>'',1,0));
    legal_assessor_map_ref_CountNonBlank                          := sum(group,if(p2.legal_assessor_map_ref<>'',1,0));
    census_tract_CountNonBlank                                    := sum(group,if(p2.census_tract<>'',1,0));
    record_type_code_CountNonBlank                                := sum(group,if(p2.record_type_code<>'',1,0));
    ownership_type_code_CountNonBlank                             := sum(group,if(p2.ownership_type_code<>'',1,0));
    new_record_type_code_CountNonBlank                            := sum(group,if(p2.new_record_type_code<>'',1,0));
    county_land_use_code_CountNonBlank                            := sum(group,if(p2.county_land_use_code<>'',1,0));
    county_land_use_description_CountNonBlank                     := sum(group,if(p2.county_land_use_description<>'',1,0));
    standardized_land_use_code_CountNonBlank                      := sum(group,if(p2.standardized_land_use_code<>'',1,0));
    timeshare_code_CountNonBlank                                  := sum(group,if(p2.timeshare_code<>'',1,0));
    zoning_CountNonBlank                                          := sum(group,if(p2.zoning<>'',1,0));
    owner_occupied_CountNonBlank                                  := sum(group,if(p2.owner_occupied<>'',1,0));
    recorder_document_number_CountNonBlank                        := sum(group,if(p2.recorder_document_number<>'',1,0));
    recorder_book_number_CountNonBlank                            := sum(group,if(p2.recorder_book_number<>'',1,0));
    recorder_page_number_CountNonBlank                            := sum(group,if(p2.recorder_page_number<>'',1,0));
    transfer_date_CountNonBlank                                   := sum(group,if(p2.transfer_date<>'',1,0));
    recording_date_CountNonBlank                                  := sum(group,if(p2.recording_date<>'',1,0));
    sale_date_CountNonBlank                                       := sum(group,if(p2.sale_date<>'',1,0));
    document_type_CountNonBlank                                   := sum(group,if(p2.document_type<>'',1,0));
    sales_price_CountNonBlank                                     := sum(group,if(p2.sales_price<>'',1,0));
    sales_price_code_CountNonBlank                                := sum(group,if(p2.sales_price_code<>'',1,0));
    mortgage_loan_amount_CountNonBlank                            := sum(group,if(p2.mortgage_loan_amount<>'',1,0));
    mortgage_loan_type_code_CountNonBlank                         := sum(group,if(p2.mortgage_loan_type_code<>'',1,0));
    mortgage_lender_name_CountNonBlank                            := sum(group,if(p2.mortgage_lender_name<>'',1,0));
    mortgage_lender_type_code_CountNonBlank                       := sum(group,if(p2.mortgage_lender_type_code<>'',1,0));
    prior_transfer_date_CountNonBlank                             := sum(group,if(p2.prior_transfer_date<>'',1,0));
    prior_recording_date_CountNonBlank                            := sum(group,if(p2.prior_recording_date<>'',1,0));
    prior_sales_price_CountNonBlank                               := sum(group,if(p2.prior_sales_price<>'',1,0));
    prior_sales_price_code_CountNonBlank                          := sum(group,if(p2.prior_sales_price_code<>'',1,0));
    assessed_land_value_CountNonBlank                             := sum(group,if(p2.assessed_land_value<>'',1,0));
    assessed_improvement_value_CountNonBlank                      := sum(group,if(p2.assessed_improvement_value<>'',1,0));
    assessed_total_value_CountNonBlank                            := sum(group,if(p2.assessed_total_value<>'',1,0));
    assessed_value_year_CountNonBlank                             := sum(group,if(p2.assessed_value_year<>'',1,0));
    market_land_value_CountNonBlank                               := sum(group,if(p2.market_land_value<>'',1,0));
    market_improvement_value_CountNonBlank                        := sum(group,if(p2.market_improvement_value<>'',1,0));
    market_total_value_CountNonBlank                              := sum(group,if(p2.market_total_value<>'',1,0));
    market_value_year_CountNonBlank                               := sum(group,if(p2.market_value_year<>'',1,0));
    homestead_homeowner_exemption_CountNonBlank                   := sum(group,if(p2.homestead_homeowner_exemption<>'',1,0));
    tax_exemption1_code_CountNonBlank                             := sum(group,if(p2.tax_exemption1_code<>'',1,0));
    tax_exemption2_code_CountNonBlank                             := sum(group,if(p2.tax_exemption2_code<>'',1,0));
    tax_exemption3_code_CountNonBlank                             := sum(group,if(p2.tax_exemption3_code<>'',1,0));
    tax_exemption4_code_CountNonBlank                             := sum(group,if(p2.tax_exemption4_code<>'',1,0));
    tax_rate_code_area_CountNonBlank                              := sum(group,if(p2.tax_rate_code_area<>'',1,0));
    tax_amount_CountNonBlank                                      := sum(group,if(p2.tax_amount<>'',1,0));
    tax_year_CountNonBlank                                        := sum(group,if(p2.tax_year<>'',1,0));
    tax_delinquent_year_CountNonBlank                             := sum(group,if(p2.tax_delinquent_year<>'',1,0));
    school_tax_district1_CountNonBlank                            := sum(group,if(p2.school_tax_district1<>'',1,0));
    school_tax_district1_indicator_CountNonBlank                  := sum(group,if(p2.school_tax_district1_indicator<>'',1,0));
    school_tax_district2_CountNonBlank                            := sum(group,if(p2.school_tax_district2<>'',1,0));
    school_tax_district2_indicator_CountNonBlank                  := sum(group,if(p2.school_tax_district2_indicator<>'',1,0));
    school_tax_district3_CountNonBlank                            := sum(group,if(p2.school_tax_district3<>'',1,0));
    school_tax_district3_indicator_CountNonBlank                  := sum(group,if(p2.school_tax_district3_indicator<>'',1,0));
		lot_size_CountNonBlank																				:= sum(group,if(p2.lot_size<>'',1,0));
		lot_size_acres_CountNonBlank																	:= sum(group,if(p2.lot_size_acres<>'',1,0));
		lot_size_frontage_feet_CountNonBlank													:= sum(group,if(p2.lot_size_frontage_feet<>'',1,0));
		lot_size_depth_feet_CountNonBlank															:= sum(group,if(p2.lot_size_depth_feet<>'',1,0));
    land_acres_CountNonBlank                                      := sum(group,if(p2.land_acres<>'',1,0));
    land_square_footage_CountNonBlank                             := sum(group,if(p2.land_square_footage<>'',1,0));
    land_dimensions_CountNonBlank                                 := sum(group,if(p2.land_dimensions<>'',1,0));
    building_area_CountNonBlank                                   := sum(group,if(p2.building_area<>'',1,0));
    building_area_indicator_CountNonBlank                         := sum(group,if(p2.building_area_indicator<>'',1,0));
    building_area1_CountNonBlank                                  := sum(group,if(p2.building_area1<>'',1,0));
    building_area1_indicator_CountNonBlank                        := sum(group,if(p2.building_area1_indicator<>'',1,0));
    building_area2_CountNonBlank                                  := sum(group,if(p2.building_area2<>'',1,0));
    building_area2_indicator_CountNonBlank                        := sum(group,if(p2.building_area2_indicator<>'',1,0));
    building_area3_CountNonBlank                                  := sum(group,if(p2.building_area3<>'',1,0));
    building_area3_indicator_CountNonBlank                        := sum(group,if(p2.building_area3_indicator<>'',1,0));
    building_area4_CountNonBlank                                  := sum(group,if(p2.building_area4<>'',1,0));
    building_area4_indicator_CountNonBlank                        := sum(group,if(p2.building_area4_indicator<>'',1,0));
    building_area5_CountNonBlank                                  := sum(group,if(p2.building_area5<>'',1,0));
    building_area5_indicator_CountNonBlank                        := sum(group,if(p2.building_area5_indicator<>'',1,0));
    building_area6_CountNonBlank                                  := sum(group,if(p2.building_area6<>'',1,0));
    building_area6_indicator_CountNonBlank                        := sum(group,if(p2.building_area6_indicator<>'',1,0));
    building_area7_CountNonBlank                                  := sum(group,if(p2.building_area7<>'',1,0));
    building_area7_indicator_CountNonBlank                        := sum(group,if(p2.building_area7_indicator<>'',1,0));
    year_built_CountNonBlank                                      := sum(group,if(p2.year_built<>'',1,0));
    effective_year_built_CountNonBlank                            := sum(group,if(p2.effective_year_built<>'',1,0));
    no_of_buildings_CountNonBlank                                 := sum(group,if(p2.no_of_buildings<>'',1,0));
    no_of_stories_CountNonBlank                                   := sum(group,if(p2.no_of_stories<>'',1,0));
    no_of_units_CountNonBlank                                     := sum(group,if(p2.no_of_units<>'',1,0));
    no_of_rooms_CountNonBlank                                     := sum(group,if(p2.no_of_rooms<>'',1,0));
    no_of_bedrooms_CountNonBlank                                  := sum(group,if(p2.no_of_bedrooms<>'',1,0));
    no_of_baths_CountNonBlank                                     := sum(group,if(p2.no_of_baths<>'',1,0));
    no_of_partial_baths_CountNonBlank                             := sum(group,if(p2.no_of_partial_baths<>'',1,0));
		no_of_plumbing_fixtures_CountNonBlank                         := sum(group,if(p2.no_of_plumbing_fixtures<>'',1,0));
    garage_type_code_CountNonBlank                                := sum(group,if(p2.garage_type_code<>'',1,0));
    parking_no_of_cars_CountNonBlank                              := sum(group,if(p2.parking_no_of_cars<>'',1,0));
    pool_code_CountNonBlank                                       := sum(group,if(p2.pool_code<>'',1,0));
    style_code_CountNonBlank                                      := sum(group,if(p2.style_code<>'',1,0));
    type_construction_code_CountNonBlank                          := sum(group,if(p2.type_construction_code<>'',1,0));
    exterior_walls_code_CountNonBlank                             := sum(group,if(p2.exterior_walls_code<>'',1,0));
    foundation_code_CountNonBlank                                 := sum(group,if(p2.foundation_code<>'',1,0));
		building_quality_code_CountNonBlank                           := sum(group,if(p2.building_quality_code<>'',1,0));
		building_condition_code_CountNonBlank                         := sum(group,if(p2.building_condition_code<>'',1,0));
		interior_walls_code_CountNonBlank                             := sum(group,if(p2.interior_walls_code<>'',1,0));
    roof_cover_code_CountNonBlank                                 := sum(group,if(p2.roof_cover_code<>'',1,0));
    roof_type_code_CountNonBlank                                  := sum(group,if(p2.roof_type_code<>'',1,0));
		floor_cover_code_CountNonBlank                                := sum(group,if(p2.floor_cover_code<>'',1,0));
		water_code_CountNonBlank                                			:= sum(group,if(p2.water_code<>'',1,0));
		sewer_code_CountNonBlank                                			:= sum(group,if(p2.sewer_code<>'',1,0));
    heating_code_CountNonBlank                                    := sum(group,if(p2.heating_code<>'',1,0));
    heating_fuel_type_code_CountNonBlank                          := sum(group,if(p2.heating_fuel_type_code<>'',1,0));
    air_conditioning_code_CountNonBlank                           := sum(group,if(p2.air_conditioning_code<>'',1,0));
    air_conditioning_type_code_CountNonBlank                      := sum(group,if(p2.air_conditioning_type_code<>'',1,0));
    elevator_CountNonBlank                                        := sum(group,if(p2.elevator<>'',1,0));
    fireplace_indicator_CountNonBlank                             := sum(group,if(p2.fireplace_indicator<>'',1,0));
    fireplace_number_CountNonBlank                                := sum(group,if(p2.fireplace_number<>'',1,0));
    basement_code_CountNonBlank                                   := sum(group,if(p2.basement_code<>'',1,0));
    building_class_code_CountNonBlank                             := sum(group,if(p2.building_class_code<>'',1,0));
    site_influence1_code_CountNonBlank                            := sum(group,if(p2.site_influence1_code<>'',1,0));
    site_influence2_code_CountNonBlank                            := sum(group,if(p2.site_influence2_code<>'',1,0));
    site_influence3_code_CountNonBlank                            := sum(group,if(p2.site_influence3_code<>'',1,0));
    site_influence4_code_CountNonBlank                            := sum(group,if(p2.site_influence4_code<>'',1,0));
    site_influence5_code_CountNonBlank                            := sum(group,if(p2.site_influence5_code<>'',1,0));
    amenities1_code_CountNonBlank                                 := sum(group,if(p2.amenities1_code<>'',1,0));
    amenities2_code_CountNonBlank                                 := sum(group,if(p2.amenities2_code<>'',1,0));
    amenities3_code_CountNonBlank                                 := sum(group,if(p2.amenities3_code<>'',1,0));
    amenities4_code_CountNonBlank                                 := sum(group,if(p2.amenities4_code<>'',1,0));
    amenities5_code_CountNonBlank                                 := sum(group,if(p2.amenities5_code<>'',1,0));
		amenities2_code1_CountNonBlank                                := sum(group,if(p2.amenities2_code1<>'',1,0));
    amenities2_code2_CountNonBlank                                := sum(group,if(p2.amenities2_code2<>'',1,0));
    amenities2_code3_CountNonBlank                                := sum(group,if(p2.amenities2_code3<>'',1,0));
    amenities2_code4_CountNonBlank                                := sum(group,if(p2.amenities2_code4<>'',1,0));
    amenities2_code5_CountNonBlank                                := sum(group,if(p2.amenities2_code5<>'',1,0));
		extra_features1_area_CountNonBlank                            := sum(group,if(p2.extra_features1_area<>'',1,0));
		extra_features1_indicator_CountNonBlank                       := sum(group,if(p2.extra_features1_indicator<>'',1,0));
		extra_features2_area_CountNonBlank                            := sum(group,if(p2.extra_features2_area<>'',1,0));
		extra_features2_indicator_CountNonBlank                       := sum(group,if(p2.extra_features2_indicator<>'',1,0));
		extra_features3_area_CountNonBlank                            := sum(group,if(p2.extra_features3_area<>'',1,0));
		extra_features3_indicator_CountNonBlank                       := sum(group,if(p2.extra_features3_indicator<>'',1,0));
		extra_features4_area_CountNonBlank                            := sum(group,if(p2.extra_features4_area<>'',1,0));
		extra_features4_indicator_CountNonBlank                       := sum(group,if(p2.extra_features4_indicator<>'',1,0));
    other_buildings1_code_CountNonBlank                           := sum(group,if(p2.other_buildings1_code<>'',1,0));
    other_buildings2_code_CountNonBlank                           := sum(group,if(p2.other_buildings2_code<>'',1,0));
    other_buildings3_code_CountNonBlank                           := sum(group,if(p2.other_buildings3_code<>'',1,0));
    other_buildings4_code_CountNonBlank                           := sum(group,if(p2.other_buildings4_code<>'',1,0));
    other_buildings5_code_CountNonBlank                           := sum(group,if(p2.other_buildings5_code<>'',1,0));
		other_impr_building1_indicator_CountNonBlank									:= sum(group,if(p2.other_impr_building1_indicator<>'',1,0));
		other_impr_building2_indicator_CountNonBlank									:= sum(group,if(p2.other_impr_building2_indicator<>'',1,0));
		other_impr_building3_indicator_CountNonBlank									:= sum(group,if(p2.other_impr_building3_indicator<>'',1,0));
		other_impr_building4_indicator_CountNonBlank									:= sum(group,if(p2.other_impr_building4_indicator<>'',1,0));
		other_impr_building5_indicator_CountNonBlank									:= sum(group,if(p2.other_impr_building5_indicator<>'',1,0));
		other_impr_building_area1_CountNonBlank												:= sum(group,if(p2.other_impr_building_area1<>'',1,0));
		other_impr_building_area2_CountNonBlank												:= sum(group,if(p2.other_impr_building_area2<>'',1,0));
		other_impr_building_area3_CountNonBlank												:= sum(group,if(p2.other_impr_building_area3<>'',1,0));
		other_impr_building_area4_CountNonBlank												:= sum(group,if(p2.other_impr_building_area4<>'',1,0));
		other_impr_building_area5_CountNonBlank												:= sum(group,if(p2.other_impr_building_area5<>'',1,0));
    topography_code_CountNonBlank                               	:= sum(group,if(p2.topograpy_code<>'',1,0));
		neighborhood_code_CountNonBlank                               := sum(group,if(p2.neighborhood_code<>'',1,0));
    condo_project_or_building_name_CountNonBlank                  := sum(group,if(p2.condo_project_or_building_name<>'',1,0));
    assessee_name_indicator_CountNonBlank                         := sum(group,if(p2.assessee_name_indicator<>'',1,0));
    second_assessee_name_indicator_CountNonBlank                  := sum(group,if(p2.second_assessee_name_indicator<>'',1,0));
    mail_care_of_name_indicator_CountNonBlank                     := sum(group,if(p2.mail_care_of_name_indicator<>'',1,0));
    comments_CountNonBlank                                        := sum(group,if(p2.comments<>'',1,0));
    tape_cut_date_CountNonBlank                                   := sum(group,if(p2.tape_cut_date<>'',1,0));
    certification_date_CountNonBlank                              := sum(group,if(p2.certification_date<>'',1,0));
    edition_number_CountNonBlank                                  := sum(group,if(p2.edition_number<>'',1,0));
    prop_addr_propagated_ind_CountNonBlank                        := sum(group,if(p2.prop_addr_propagated_ind<>'',1,0));
end;

deed_tbl := sort(table(p1(from_file='D'),r2, from_file,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date,few),is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date);
mort_tbl := sort(table(p1(from_file='M'),r2, from_file,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date,few),is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date);
assr_tbl := sort(table(p2,               r2b,          is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date,few),is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date);

output(deed_tbl,all,named('deed_field_populations_by_year'));
output(mort_tbl,all,named('mort_field_populations_by_year'));
output(assr_tbl,all,named('assr_field_populations_by_year'));

f1 := p1(from_file in ['D']);
f2 := p1(from_file in ['M']);

r3 := record
 f1.from_file;
 f1.fips_code;
 f1.state;
 f1.county_name;
 f1.in_fidelity;
 f1.is_2009;
 f1.is_2008;
 f1.is_2007;
 f1.is_2006;
 f1.is_2005;
 f1.is_2004;
 f1.pre_2004;
 f1.no_date;
 count_ := count(group);
end;

r3b := record
 f2.from_file;
 f2.fips_code;
 f2.state;
 f2.county_name;
 f2.in_fidelity;
 f2.is_2009;
 f2.is_2008;
 f2.is_2007;
 f2.is_2006;
 f2.is_2005;
 f2.is_2004;
 f2.pre_2004;
 f2.no_date;
 count_ := count(group);
end;

r3c := record
 p2.fips_code;
 p2.state_code;
 p2.county_name;
 p2.in_fidelity;
 p2.is_2009;
 p2.is_2008;
 p2.is_2007;
 p2.is_2006;
 p2.is_2005;
 p2.is_2004;
 p2.pre_2004;
 p2.no_date;
 count_ := count(group);
end;

deed_tbl2_0 := sort(table(f1,r3, from_file,fips_code,state,     county_name,in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date,few),fips_code,state,     county_name,in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date);
mort_tbl2_0 := sort(table(f2,r3b,from_file,fips_code,state,     county_name,in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date,few),fips_code,state,     county_name,in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date);
assr_tbl2_0 := sort(table(p2,r3c,          fips_code,state_code,county_name,in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date,few),fips_code,state_code,county_name,in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date);

//output(count(dedup(deed_tbl2_0,fips_code,all)),named('fips_in_deeds'));
//output(count(dedup(mort_tbl2_0,fips_code,all)),named('fips_in_morts'));
//output(count(dedup(assr_tbl2_0,fips_code,all)),named('fips_in_assrs'));

//output(count(dedup(deed_tbl2_0,fips_code,state,county_name)),named('fips_st_co_in_deeds'));
//output(count(dedup(mort_tbl2_0,fips_code,state,county_name)),named('fips_st_co_in_morts'));
//output(count(dedup(assr_tbl2_0,fips_code,state_code,county_name)),named('fips_st_co_in_assrs'));

recordof(deed_tbl2_0) t_fill_missing_fips(deed_tbl2_0 le, fips_lookup ri) := transform
 self.from_file   := 'X';
 self.fips_code   := ri.fips;
 self.state       := ri.st;
 self.county_name := ri.county;
 self.in_fidelity := false;
 self.is_2009     := false;
 self.is_2008     := false;
 self.is_2007     := false;
 self.is_2006     := false;
 self.is_2005     := false;
 self.is_2004     := false;
 self.pre_2004    := false;
 self.no_date     := false;
 self.count_      := 0;
end;

recordof(mort_tbl2_0) t_fill_missing_fipsb(mort_tbl2_0 le, fips_lookup ri) := transform
 self.from_file   := 'X';
 self.fips_code   := ri.fips;
 self.state       := ri.st;
 self.county_name := ri.county;
 self.in_fidelity := false;
 self.is_2009     := false;
 self.is_2008     := false;
 self.is_2007     := false;
 self.is_2006     := false;
 self.is_2005     := false;
 self.is_2004     := false;
 self.pre_2004    := false;
 self.no_date     := false;
 self.count_      := 0;
end;

recordof(assr_tbl2_0) t_fill_missing_fipsc(assr_tbl2_0 le, fips_lookup ri) := transform
 self.fips_code   := ri.fips;
 self.state_code  := ri.st;
 self.county_name := ri.county;
 self.in_fidelity := false;
 self.is_2009     := false;
 self.is_2008     := false;
 self.is_2007     := false;
 self.is_2006     := false;
 self.is_2005     := false;
 self.is_2004     := false;
 self.pre_2004    := false;
 self.no_date     := false;
 self.count_      := 0;
end;

j_missing_fips_in_deed := join(deed_tbl2_0,fips_lookup,left.fips_code=right.fips,t_fill_missing_fips (left,right),right only);
j_missing_fips_in_mort := join(mort_tbl2_0,fips_lookup,left.fips_code=right.fips,t_fill_missing_fipsb(left,right),right only);
j_missing_fips_in_assr := join(assr_tbl2_0,fips_lookup,left.fips_code=right.fips,t_fill_missing_fipsc(left,right),right only);

deed_tbl2 := deed_tbl2_0+j_missing_fips_in_deed;
mort_tbl2 := mort_tbl2_0+j_missing_fips_in_mort;
assr_tbl2 := assr_tbl2_0+j_missing_fips_in_assr;

//output(count(dedup(deed_tbl2,fips_code,all)),named('fips_in_deeds2'));
//output(count(dedup(mort_tbl2,fips_code,all)),named('fips_in_morts2'));
//output(count(dedup(assr_tbl2,fips_code,all)),named('fips_in_assrs2'));

//output(count(dedup(deed_tbl2,fips_code,state,county_name)),named('fips_st_co_in_deeds2'));
//output(count(dedup(mort_tbl2,fips_code,state,county_name)),named('fips_st_co_in_morts2'));
//output(count(dedup(assr_tbl2,fips_code,state_code,county_name)),named('fips_st_co_in_assrs2'));

//output(sort(deed_tbl2,state,     county_name),all,named('deed_records_per_year'));
//output(sort(mort_tbl2,state,     county_name),all,named('mort_records_per_year'));
//output(sort(assr_tbl2,state_code,county_name),all,named('assr_records_per_year'));

//recordof(deed_tbl2) t_temp1(deed_tbl2 le, fips_lookup ri) := transform
// self := le;
//end;

//recordof(mort_tbl2) t_temp2(mort_tbl2 le, fips_lookup ri) := transform
// self := le;
//end;

//recordof(assr_tbl2) t_temp3(assr_tbl2 le, fips_lookup ri) := transform
// self := le;
//end;

//j_temp1 := join(deed_tbl2,fips_lookup,left.fips_code=right.fips,t_temp1(left,right),left only,lookup);
//j_temp2 := join(mort_tbl2,fips_lookup,left.fips_code=right.fips,t_temp2(left,right),left only,lookup);
//j_temp3 := join(assr_tbl2,fips_lookup,left.fips_code=right.fips,t_temp3(left,right),left only,lookup);

//output(j_temp1,all);
//output(j_temp2,all);
//output(j_temp3,all);

r4 := record
 string5  fips_code;
 string2  state;
 string40 county_name;
 boolean  in_fidelity;
 string10 c2009_cnt;
 string10 c2008_cnt;
 string10 c2007_cnt;
 string10 c2006_cnt;
 string10 c2005_cnt;
 string10 c2004_cnt;
 string10 pre_2004_cnt;
 string10 no_date_cnt;
end;

r4 t4(r3 le) := transform
 self.c2009_cnt    := if(le.is_2009  and le.count_>0,(string)le.count_,'');
 self.c2008_cnt    := if(le.is_2008  and le.count_>0,(string)le.count_,'');
 self.c2007_cnt    := if(le.is_2007  and le.count_>0,(string)le.count_,'');
 self.c2006_cnt    := if(le.is_2006  and le.count_>0,(string)le.count_,'');
 self.c2005_cnt    := if(le.is_2005  and le.count_>0,(string)le.count_,'');
 self.c2004_cnt    := if(le.is_2004  and le.count_>0,(string)le.count_,'');
 self.pre_2004_cnt := if(le.pre_2004 and le.count_>0,(string)le.count_,'');
 self.no_date_cnt  := if(le.no_date  and le.count_>0,(string)le.count_,'');
 self              := le;
end;

r4 t4b(r3b le) := transform
 self.c2009_cnt    := if(le.is_2009  and le.count_>0,(string)le.count_,'');
 self.c2008_cnt    := if(le.is_2008  and le.count_>0,(string)le.count_,'');
 self.c2007_cnt    := if(le.is_2007  and le.count_>0,(string)le.count_,'');
 self.c2006_cnt    := if(le.is_2006  and le.count_>0,(string)le.count_,'');
 self.c2005_cnt    := if(le.is_2005  and le.count_>0,(string)le.count_,'');
 self.c2004_cnt    := if(le.is_2004  and le.count_>0,(string)le.count_,'');
 self.pre_2004_cnt := if(le.pre_2004 and le.count_>0,(string)le.count_,'');
 self.no_date_cnt  := if(le.no_date  and le.count_>0,(string)le.count_,'');
 self              := le;
end;

r4 t4c(r3c le) := transform
 self.state        := le.state_code;
 self.c2009_cnt    := if(le.is_2009  and le.count_>0,(string)le.count_,'');
 self.c2008_cnt    := if(le.is_2008  and le.count_>0,(string)le.count_,'');
 self.c2007_cnt    := if(le.is_2007  and le.count_>0,(string)le.count_,'');
 self.c2006_cnt    := if(le.is_2006  and le.count_>0,(string)le.count_,'');
 self.c2005_cnt    := if(le.is_2005  and le.count_>0,(string)le.count_,'');
 self.c2004_cnt    := if(le.is_2004  and le.count_>0,(string)le.count_,'');
 self.pre_2004_cnt := if(le.pre_2004 and le.count_>0,(string)le.count_,'');
 self.no_date_cnt  := if(le.no_date  and le.count_>0,(string)le.count_,'');
 self              := le;
end;

deed_tbl3_prep := sort(project(deed_tbl2,t4 (left)),fips_code,in_fidelity);
mort_tbl3_prep := sort(project(mort_tbl2,t4b(left)),fips_code,in_fidelity);
assr_tbl3_prep := sort(project(assr_tbl2,t4c(left)),fips_code,in_fidelity);

r4 t5(r4 le, r4 ri) := transform
 self.c2009_cnt    := if(le.c2009_cnt   <>'',le.c2009_cnt,   ri.c2009_cnt);
 self.c2008_cnt    := if(le.c2008_cnt   <>'',le.c2008_cnt,   ri.c2008_cnt);
 self.c2007_cnt    := if(le.c2007_cnt   <>'',le.c2007_cnt,   ri.c2007_cnt);
 self.c2006_cnt    := if(le.c2006_cnt   <>'',le.c2006_cnt,   ri.c2006_cnt);
 self.c2005_cnt    := if(le.c2005_cnt   <>'',le.c2005_cnt,   ri.c2005_cnt);
 self.c2004_cnt    := if(le.c2004_cnt   <>'',le.c2004_cnt,   ri.c2004_cnt);
 self.pre_2004_cnt := if(le.pre_2004_cnt<>'',le.pre_2004_cnt,ri.pre_2004_cnt);
 self.no_date_cnt  := if(le.no_date_cnt <>'',le.no_date_cnt ,ri.no_date_cnt);
 self              := le;
end;

r4 t5b(r4 le, r4 ri) := transform
 self.c2009_cnt    := if(le.c2009_cnt   <>'',le.c2009_cnt,   ri.c2009_cnt);
 self.c2008_cnt    := if(le.c2008_cnt   <>'',le.c2008_cnt,   ri.c2008_cnt);
 self.c2007_cnt    := if(le.c2007_cnt   <>'',le.c2007_cnt,   ri.c2007_cnt);
 self.c2006_cnt    := if(le.c2006_cnt   <>'',le.c2006_cnt,   ri.c2006_cnt);
 self.c2005_cnt    := if(le.c2005_cnt   <>'',le.c2005_cnt,   ri.c2005_cnt);
 self.c2004_cnt    := if(le.c2004_cnt   <>'',le.c2004_cnt,   ri.c2004_cnt);
 self.pre_2004_cnt := if(le.pre_2004_cnt<>'',le.pre_2004_cnt,ri.pre_2004_cnt);
 self.no_date_cnt  := if(le.no_date_cnt <>'',le.no_date_cnt ,ri.no_date_cnt);
 self              := le;
end;

r4 t5c(r4 le, r4 ri) := transform
 self.c2009_cnt    := if(le.c2009_cnt   <>'',le.c2009_cnt,   ri.c2009_cnt);
 self.c2008_cnt    := if(le.c2008_cnt   <>'',le.c2008_cnt,   ri.c2008_cnt);
 self.c2007_cnt    := if(le.c2007_cnt   <>'',le.c2007_cnt,   ri.c2007_cnt);
 self.c2006_cnt    := if(le.c2006_cnt   <>'',le.c2006_cnt,   ri.c2006_cnt);
 self.c2005_cnt    := if(le.c2005_cnt   <>'',le.c2005_cnt,   ri.c2005_cnt);
 self.c2004_cnt    := if(le.c2004_cnt   <>'',le.c2004_cnt,   ri.c2004_cnt);
 self.pre_2004_cnt := if(le.pre_2004_cnt<>'',le.pre_2004_cnt,ri.pre_2004_cnt);
 self.no_date_cnt  := if(le.no_date_cnt <>'',le.no_date_cnt ,ri.no_date_cnt);
 self              := le;
end;

deed_tbl3 := rollup(deed_tbl3_prep,left.fips_code=right.fips_code and left.in_fidelity=right.in_fidelity,t5 (left,right));
mort_tbl3 := rollup(mort_tbl3_prep,left.fips_code=right.fips_code and left.in_fidelity=right.in_fidelity,t5b(left,right));
assr_tbl3 := rollup(assr_tbl3_prep,left.fips_code=right.fips_code and left.in_fidelity=right.in_fidelity,t5c(left,right));

output(sort(deed_tbl3,state,county_name,in_fidelity),all,named('deed_records_per_year'));
output(sort(mort_tbl3,state,county_name,in_fidelity),all,named('mort_records_per_year'));
output(sort(assr_tbl3,state,county_name,in_fidelity),all,named('assr_records_per_year'));

r5 := record
 f1.fips_code;
 f1.state;
 f1.county_name;
 f1.in_fidelity;
 f1.is_2009;
 f1.is_2008;
 f1.is_2007;
 f1.is_2006;
 f1.is_2005;
 f1.is_2004;
 f1.pre_2004;
 f1.no_date;
 f1.prim_range;
 f1.prim_name;
 f1.sec_range;
 f1.zip;
 integer unique_prop_cnt := 0;
end;

r5b := record
 f2.fips_code;
 f2.state;
 f2.county_name;
 f2.in_fidelity;
 f2.is_2009;
 f2.is_2008;
 f2.is_2007;
 f2.is_2006;
 f2.is_2005;
 f2.is_2004;
 f2.pre_2004;
 f2.no_date;
 f2.prim_range;
 f2.prim_name;
 f2.sec_range;
 f2.zip;
 integer unique_prop_cnt := 0;
end;

r5c := record
 p2.fips_code;
 p2.state_code;
 p2.county_name;
 p2.in_fidelity;
 p2.is_2009;
 p2.is_2008;
 p2.is_2007;
 p2.is_2006;
 p2.is_2005;
 p2.is_2004;
 p2.pre_2004;
 p2.no_date;
 p2.prim_range;
 p2.prim_name;
 p2.sec_range;
 p2.zip;
 integer unique_prop_cnt := 0;
end;

f1_slim := project(f1,r5);
f2_slim := project(f2,r5b);
p2_slim := project(p2,r5c);

f1_slim_dist := distribute(f1_slim,hash(fips_code,/*state,     county_name,*/in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date,prim_range,prim_name,sec_range,zip));
f2_slim_dist := distribute(f2_slim,hash(fips_code,/*state,     county_name,*/in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date,prim_range,prim_name,sec_range,zip));
p2_slim_dist := distribute(p2_slim,hash(fips_code,/*state_code,county_name,*/in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date,prim_range,prim_name,sec_range,zip));

f1_slim_sort := sort(f1_slim_dist,fips_code,/*state,     county_name,*/in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date,prim_range,prim_name,sec_range,zip,local);
f2_slim_sort := sort(f2_slim_dist,fips_code,/*state,     county_name,*/in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date,prim_range,prim_name,sec_range,zip,local);
p2_slim_sort := sort(p2_slim_dist,fips_code,/*state_code,county_name,*/in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date,prim_range,prim_name,sec_range,zip,local);

f1_slim_dupd := dedup(f1_slim_sort,fips_code,/*state,     county_name,*/in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date,prim_range,prim_name,sec_range,zip,local);
f2_slim_dupd := dedup(f2_slim_sort,fips_code,/*state,     county_name,*/in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date,prim_range,prim_name,sec_range,zip,local);
p2_slim_dupd := dedup(p2_slim_sort,fips_code,/*state_code,county_name,*/in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date,prim_range,prim_name,sec_range,zip,local);

f1_redist := distribute(f1_slim_dupd,hash(fips_code,/*state,     county_name,*/in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date));
f2_redist := distribute(f2_slim_dupd,hash(fips_code,/*state,     county_name,*/in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date));
p2_redist := distribute(p2_slim_dupd,hash(fips_code,/*state_code,county_name,*/in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date));

f1_resort := sort(f1_redist,fips_code,/*state,     county_name,*/in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date,local);
f2_resort := sort(f2_redist,fips_code,/*state,     county_name,*/in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date,local);
p2_resort := sort(p2_redist,fips_code,/*state_code,county_name,*/in_fidelity,is_2009,is_2008,is_2007,is_2006,is_2005,is_2004,pre_2004,no_date,local);


r5 t6(r5 le, r5 ri) := transform
 self.unique_prop_cnt := le.unique_prop_cnt+1;
 self                 := le;
end;

r5b t6b(r5b le, r5b ri) := transform
 self.unique_prop_cnt := le.unique_prop_cnt+1;
 self                 := le;
end;

r5c t6c(r5c le, r5c ri) := transform
 self.unique_prop_cnt := le.unique_prop_cnt+1;
 self                 := le;
end;

f1_rold_0 := rollup(f1_resort,
            left.fips_code=right.fips_code and /*left.state=right.state and left.county_name=right.county_name and*/
			left.in_fidelity=right.in_fidelity and left.is_2009=right.is_2009 and left.is_2008=right.is_2008 and left.is_2007=right.is_2007 and
			left.is_2006=right.is_2006 and left.is_2005=right.is_2005 and left.is_2004=right.is_2004 and left.pre_2004=right.pre_2004 and
			left.no_date=right.no_date,
			t6(left,right),local);

f2_rold_0 := rollup(f2_resort,
            left.fips_code=right.fips_code and /*left.state=right.state and left.county_name=right.county_name and*/
			left.in_fidelity=right.in_fidelity and left.is_2009=right.is_2009 and left.is_2008=right.is_2008 and left.is_2007=right.is_2007 and
			left.is_2006=right.is_2006 and left.is_2005=right.is_2005 and left.is_2004=right.is_2004 and left.pre_2004=right.pre_2004 and
			left.no_date=right.no_date,
			t6b(left,right),local);

p2_rold_0 := rollup(p2_resort,
            left.fips_code=right.fips_code and /*left.state_code=right.state_code and left.county_name=right.county_name and*/
			left.in_fidelity=right.in_fidelity and left.is_2009=right.is_2009 and left.is_2008=right.is_2008 and left.is_2007=right.is_2007 and
			left.is_2006=right.is_2006 and left.is_2005=right.is_2005 and left.is_2004=right.is_2004 and left.pre_2004=right.pre_2004 and
			left.no_date=right.no_date,
			t6c(left,right),local);

recordof(f1_rold_0) t_fill_missing_fipsd(f1_rold_0 le, fips_lookup ri) := transform
 //self.from_file   := 'X';
 self.fips_code   := ri.fips;
 self.state       := ri.st;
 self.county_name := ri.county;
 self.in_fidelity := false;
 self.is_2009     := false;
 self.is_2008     := false;
 self.is_2007     := false;
 self.is_2006     := false;
 self.is_2005     := false;
 self.is_2004     := false;
 self.pre_2004    := false;
 self.no_date     := false;
 self.prim_range  := '';
 self.prim_name   := '';
 self.sec_range   := '';
 self.zip         := '';
 self.unique_prop_cnt := 0;
end;

recordof(f2_rold_0) t_fill_missing_fipse(f2_rold_0 le, fips_lookup ri) := transform
 //self.from_file   := 'X';
 self.fips_code   := ri.fips;
 self.state       := ri.st;
 self.county_name := ri.county;
 self.in_fidelity := false;
 self.is_2009     := false;
 self.is_2008     := false;
 self.is_2007     := false;
 self.is_2006     := false;
 self.is_2005     := false;
 self.is_2004     := false;
 self.pre_2004    := false;
 self.no_date     := false;
 self.prim_range  := '';
 self.prim_name   := '';
 self.sec_range   := '';
 self.zip         := '';
 self.unique_prop_cnt := 0;
end;

recordof(p2_rold_0) t_fill_missing_fipsf(p2_rold_0 le, fips_lookup ri) := transform
 self.fips_code   := ri.fips;
 self.state_code  := ri.st;
 self.county_name := ri.county;
 self.in_fidelity := false;
 self.is_2009     := false;
 self.is_2008     := false;
 self.is_2007     := false;
 self.is_2006     := false;
 self.is_2005     := false;
 self.is_2004     := false;
 self.pre_2004    := false;
 self.no_date     := false;
 self.prim_range  := '';
 self.prim_name   := '';
 self.sec_range   := '';
 self.zip         := '';
 self.unique_prop_cnt := 0;
end;

j_missing_fips_in_deedb := join(f1_rold_0,fips_lookup,left.fips_code=right.fips,t_fill_missing_fipsd(left,right),right only);
j_missing_fips_in_mortb := join(f2_rold_0,fips_lookup,left.fips_code=right.fips,t_fill_missing_fipse(left,right),right only);
j_missing_fips_in_assrb := join(p2_rold_0,fips_lookup,left.fips_code=right.fips,t_fill_missing_fipsf(left,right),right only);

f1_rold := f1_rold_0+j_missing_fips_in_deedb;
f2_rold := f2_rold_0+j_missing_fips_in_mortb;
p2_rold := p2_rold_0+j_missing_fips_in_assrb;

//output(sort(f1_rold,state_code,county_name),all,named('deed_unique_properties'));
//output(sort(f2_rold,state_code,county_name),all,named('mort_unique_properties'));
//output(sort(p2_rold,state,     county_name),all,named('assr_unique_properties'));

r6 := record
 string5  fips_code;
 string2  state;
 string40 county_name;
 boolean  in_fidelity;
 string10 c2009_cnt;
 string10 c2008_cnt;
 string10 c2007_cnt;
 string10 c2006_cnt;
 string10 c2005_cnt;
 string10 c2004_cnt;
 string10 pre_2004_cnt;
 string10 no_date_cnt;
end;

r6 t7(f1_rold le) := transform
 self.c2009_cnt    := if(le.is_2009  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.c2008_cnt    := if(le.is_2008  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.c2007_cnt    := if(le.is_2007  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.c2006_cnt    := if(le.is_2006  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.c2005_cnt    := if(le.is_2005  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.c2004_cnt    := if(le.is_2004  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.pre_2004_cnt := if(le.pre_2004 and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.no_date_cnt  := if(le.no_date  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self              := le;
end;


r6 t7b(f2_rold le) := transform
 self.c2009_cnt    := if(le.is_2009  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.c2008_cnt    := if(le.is_2008  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.c2007_cnt    := if(le.is_2007  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.c2006_cnt    := if(le.is_2006  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.c2005_cnt    := if(le.is_2005  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.c2004_cnt    := if(le.is_2004  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.pre_2004_cnt := if(le.pre_2004 and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.no_date_cnt  := if(le.no_date  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self              := le;
end;

r6 t7c(p2_rold le) := transform
 self.state        := le.state_code;
 self.c2009_cnt    := if(le.is_2009  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.c2008_cnt    := if(le.is_2008  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.c2007_cnt    := if(le.is_2007  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.c2006_cnt    := if(le.is_2006  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.c2005_cnt    := if(le.is_2005  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.c2004_cnt    := if(le.is_2004  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.pre_2004_cnt := if(le.pre_2004 and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self.no_date_cnt  := if(le.no_date  and le.unique_prop_cnt>0,(string)le.unique_prop_cnt,'');
 self              := le;
end;

deed_tbl4_prep := sort(project(f1_rold,t7 (left)),fips_code,in_fidelity);
mort_tbl4_prep := sort(project(f2_rold,t7b(left)),fips_code,in_fidelity);
assr_tbl4_prep := sort(project(p2_rold,t7c(left)),fips_code,in_fidelity);

r6 t8(r6 le, r6 ri) := transform
 self.c2009_cnt    := if(le.c2009_cnt   <>'',le.c2009_cnt,   ri.c2009_cnt);
 self.c2008_cnt    := if(le.c2008_cnt   <>'',le.c2008_cnt,   ri.c2008_cnt);
 self.c2007_cnt    := if(le.c2007_cnt   <>'',le.c2007_cnt,   ri.c2007_cnt);
 self.c2006_cnt    := if(le.c2006_cnt   <>'',le.c2006_cnt,   ri.c2006_cnt);
 self.c2005_cnt    := if(le.c2005_cnt   <>'',le.c2005_cnt,   ri.c2005_cnt);
 self.c2004_cnt    := if(le.c2004_cnt   <>'',le.c2004_cnt,   ri.c2004_cnt);
 self.pre_2004_cnt := if(le.pre_2004_cnt<>'',le.pre_2004_cnt,ri.pre_2004_cnt);
 self.no_date_cnt  := if(le.no_date_cnt <>'',le.no_date_cnt ,ri.no_date_cnt);
 self              := le;
end;

r6 t8b(r6 le, r6 ri) := transform
 self.c2009_cnt    := if(le.c2009_cnt   <>'',le.c2009_cnt,   ri.c2009_cnt);
 self.c2008_cnt    := if(le.c2008_cnt   <>'',le.c2008_cnt,   ri.c2008_cnt);
 self.c2007_cnt    := if(le.c2007_cnt   <>'',le.c2007_cnt,   ri.c2007_cnt);
 self.c2006_cnt    := if(le.c2006_cnt   <>'',le.c2006_cnt,   ri.c2006_cnt);
 self.c2005_cnt    := if(le.c2005_cnt   <>'',le.c2005_cnt,   ri.c2005_cnt);
 self.c2004_cnt    := if(le.c2004_cnt   <>'',le.c2004_cnt,   ri.c2004_cnt);
 self.pre_2004_cnt := if(le.pre_2004_cnt<>'',le.pre_2004_cnt,ri.pre_2004_cnt);
 self.no_date_cnt  := if(le.no_date_cnt <>'',le.no_date_cnt ,ri.no_date_cnt);
 self              := le;
end;

r6 t8c(r6 le, r6 ri) := transform
 self.c2009_cnt    := if(le.c2009_cnt   <>'',le.c2009_cnt,   ri.c2009_cnt);
 self.c2008_cnt    := if(le.c2008_cnt   <>'',le.c2008_cnt,   ri.c2008_cnt);
 self.c2007_cnt    := if(le.c2007_cnt   <>'',le.c2007_cnt,   ri.c2007_cnt);
 self.c2006_cnt    := if(le.c2006_cnt   <>'',le.c2006_cnt,   ri.c2006_cnt);
 self.c2005_cnt    := if(le.c2005_cnt   <>'',le.c2005_cnt,   ri.c2005_cnt);
 self.c2004_cnt    := if(le.c2004_cnt   <>'',le.c2004_cnt,   ri.c2004_cnt);
 self.pre_2004_cnt := if(le.pre_2004_cnt<>'',le.pre_2004_cnt,ri.pre_2004_cnt);
 self.no_date_cnt  := if(le.no_date_cnt <>'',le.no_date_cnt ,ri.no_date_cnt);
 self              := le;
end;

deed_tbl4 := rollup(deed_tbl4_prep,left.fips_code=right.fips_code and left.in_fidelity=right.in_fidelity,t8 (left,right));
mort_tbl4 := rollup(mort_tbl4_prep,left.fips_code=right.fips_code and left.in_fidelity=right.in_fidelity,t8b(left,right));
assr_tbl4 := rollup(assr_tbl4_prep,left.fips_code=right.fips_code and left.in_fidelity=right.in_fidelity,t8c(left,right));

output(sort(deed_tbl4,state,county_name,in_fidelity),all,named('deed_unique_properties'));
output(sort(mort_tbl4,state,county_name,in_fidelity),all,named('mort_unique_properties'));
output(sort(assr_tbl4,state,county_name,in_fidelity),all,named('assr_unique_properties'));
//export property_stats_by_year := 'todo';