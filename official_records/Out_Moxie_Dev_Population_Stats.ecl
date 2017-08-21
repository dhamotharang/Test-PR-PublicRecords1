export Out_Moxie_Dev_Population_Stats(pParty    // Party file against which stats are to be run
								     ,pDocument // Document file against which stats are to be run
								     ,pVersion  // The version of the dataset against which the stats are run
								     ,zOut)     // Output of the population stats
 := MACRO

import STRATA;

	#uniquename(rPopulationStats_pParty);
	#uniquename(dPopulationStats_pParty);
	#uniquename(zPartyStats);
	#uniquename(rPopulationStats_pDocument);
	#uniquename(dPopulationStats_pDocument);
	#uniquename(zDocumentStats);

%rPopulationStats_pParty%
 :=
  record
    CountGroup                                                     := count(group);
    process_date_CountNonBlank                                     := sum(group,if(pParty.process_date<>'',1,0));
    pParty.vendor;
    pParty.state_origin;
    county_name_CountNonBlank                                      := sum(group,if(pParty.county_name<>'',1,0));
    official_record_key_CountNonBlank                              := sum(group,if(pParty.official_record_key<>'',1,0));
    doc_instrument_or_clerk_filing_num_CountNonBlank               := sum(group,if(pParty.doc_instrument_or_clerk_filing_num<>'',1,0));
    doc_filed_dt_CountNonBlank                                     := sum(group,if(pParty.doc_filed_dt<>'',1,0));
    doc_type_desc_CountNonBlank                                    := sum(group,if(pParty.doc_type_desc<>'',1,0));
    entity_sequence_CountNonBlank                                  := sum(group,if(pParty.entity_sequence<>'',1,0));
    entity_type_cd_CountNonBlank                                   := sum(group,if(pParty.entity_type_cd<>'',1,0));
    entity_type_desc_CountNonBlank                                 := sum(group,if(pParty.entity_type_desc<>'',1,0));
    entity_nm_CountNonBlank                                        := sum(group,if(pParty.entity_nm<>'',1,0));
    entity_nm_format_CountNonBlank                                 := sum(group,if(pParty.entity_nm_format<>'',1,0));
    entity_dob_CountNonBlank                                       := sum(group,if(pParty.entity_dob<>'',1,0));
    entity_ssn_CountNonBlank                                       := sum(group,if(pParty.entity_ssn<>'',1,0));
    title1_CountNonBlank                                           := sum(group,if(pParty.title1<>'',1,0));
    fname1_CountNonBlank                                           := sum(group,if(pParty.fname1<>'',1,0));
    mname1_CountNonBlank                                           := sum(group,if(pParty.mname1<>'',1,0));
    lname1_CountNonBlank                                           := sum(group,if(pParty.lname1<>'',1,0));
    suffix1_CountNonBlank                                          := sum(group,if(pParty.suffix1<>'',1,0));
    pname1_score_CountNonBlank                                     := sum(group,if(pParty.pname1_score<>'',1,0));
    cname1_CountNonBlank                                           := sum(group,if(pParty.cname1<>'',1,0));
    title2_CountNonBlank                                           := sum(group,if(pParty.title2<>'',1,0));
    fname2_CountNonBlank                                           := sum(group,if(pParty.fname2<>'',1,0));
    mname2_CountNonBlank                                           := sum(group,if(pParty.mname2<>'',1,0));
    lname2_CountNonBlank                                           := sum(group,if(pParty.lname2<>'',1,0));
    suffix2_CountNonBlank                                          := sum(group,if(pParty.suffix2<>'',1,0));
    pname2_score_CountNonBlank                                     := sum(group,if(pParty.pname2_score<>'',1,0));
    cname2_CountNonBlank                                           := sum(group,if(pParty.cname2<>'',1,0));
    title3_CountNonBlank                                           := sum(group,if(pParty.title3<>'',1,0));
    fname3_CountNonBlank                                           := sum(group,if(pParty.fname3<>'',1,0));
    mname3_CountNonBlank                                           := sum(group,if(pParty.mname3<>'',1,0));
    lname3_CountNonBlank                                           := sum(group,if(pParty.lname3<>'',1,0));
    suffix3_CountNonBlank                                          := sum(group,if(pParty.suffix3<>'',1,0));
    pname3_score_CountNonBlank                                     := sum(group,if(pParty.pname3_score<>'',1,0));
    cname3_CountNonBlank                                           := sum(group,if(pParty.cname3<>'',1,0));
    title4_CountNonBlank                                           := sum(group,if(pParty.title4<>'',1,0));
    fname4_CountNonBlank                                           := sum(group,if(pParty.fname4<>'',1,0));
    mname4_CountNonBlank                                           := sum(group,if(pParty.mname4<>'',1,0));
    lname4_CountNonBlank                                           := sum(group,if(pParty.lname4<>'',1,0));
    suffix4_CountNonBlank                                          := sum(group,if(pParty.suffix4<>'',1,0));
    pname4_score_CountNonBlank                                     := sum(group,if(pParty.pname4_score<>'',1,0));
    cname4_CountNonBlank                                           := sum(group,if(pParty.cname4<>'',1,0));
    title5_CountNonBlank                                           := sum(group,if(pParty.title5<>'',1,0));
    fname5_CountNonBlank                                           := sum(group,if(pParty.fname5<>'',1,0));
    mname5_CountNonBlank                                           := sum(group,if(pParty.mname5<>'',1,0));
    lname5_CountNonBlank                                           := sum(group,if(pParty.lname5<>'',1,0));
    suffix5_CountNonBlank                                          := sum(group,if(pParty.suffix5<>'',1,0));
    pname5_score_CountNonBlank                                     := sum(group,if(pParty.pname5_score<>'',1,0));
    cname5_CountNonBlank                                           := sum(group,if(pParty.cname5<>'',1,0));
    master_party_type_cd_CountNonBlank                             := sum(group,if(pParty.master_party_type_cd<>'',1,0));
  end;

%rPopulationStats_pDocument%
 :=
  record
    CountGroup                                                     := count(group);
    process_date_CountNonBlank                                     := sum(group,if(pDocument.process_date<>'',1,0));
    pDocument.vendor;
    pDocument.state_origin;
    county_name_CountNonBlank                                      := sum(group,if(pDocument.county_name<>'',1,0));
    official_record_key_CountNonBlank                              := sum(group,if(pDocument.official_record_key<>'',1,0));
    fips_st_CountNonBlank                                          := sum(group,if(pDocument.fips_st<>'',1,0));
    fips_county_CountNonBlank                                      := sum(group,if(pDocument.fips_county<>'',1,0));
    batch_id_CountNonBlank                                         := sum(group,if(pDocument.batch_id<>'',1,0));
    doc_serial_num_CountNonBlank                                   := sum(group,if(pDocument.doc_serial_num<>'',1,0));
    doc_instrument_or_clerk_filing_num_CountNonBlank               := sum(group,if(pDocument.doc_instrument_or_clerk_filing_num<>'',1,0));
    doc_num_dummy_flag_CountNonBlank                               := sum(group,if(pDocument.doc_num_dummy_flag<>'',1,0));
    doc_filed_dt_CountNonBlank                                     := sum(group,if(pDocument.doc_filed_dt<>'',1,0));
    doc_record_dt_CountNonBlank                                    := sum(group,if(pDocument.doc_record_dt<>'',1,0));
    doc_type_cd_CountNonBlank                                      := sum(group,if(pDocument.doc_type_cd<>'',1,0));
    doc_type_desc_CountNonBlank                                    := sum(group,if(pDocument.doc_type_desc<>'',1,0));
    doc_other_desc_CountNonBlank                                   := sum(group,if(pDocument.doc_other_desc<>'',1,0));
    doc_page_count_CountNonBlank                                   := sum(group,if(pDocument.doc_page_count<>'',1,0));
    doc_names_count_CountNonBlank                                  := sum(group,if(pDocument.doc_names_count<>'',1,0));
    doc_status_cd_CountNonBlank                                    := sum(group,if(pDocument.doc_status_cd<>'',1,0));
    doc_status_desc_CountNonBlank                                  := sum(group,if(pDocument.doc_status_desc<>'',1,0));
    doc_amend_cd_CountNonBlank                                     := sum(group,if(pDocument.doc_amend_cd<>'',1,0));
    doc_amend_desc_CountNonBlank                                   := sum(group,if(pDocument.doc_amend_desc<>'',1,0));
    execution_dt_CountNonBlank                                     := sum(group,if(pDocument.execution_dt<>'',1,0));
    consideration_amt_CountNonBlank                                := sum(group,if(pDocument.consideration_amt<>'',1,0));
    assumption_amt_CountNonBlank                                   := sum(group,if(pDocument.assumption_amt<>'',1,0));
    certified_mail_fee_CountNonBlank                               := sum(group,if(pDocument.certified_mail_fee<>'',1,0));
    service_charge_CountNonBlank                                   := sum(group,if(pDocument.service_charge<>'',1,0));
    trust_amt_CountNonBlank                                        := sum(group,if(pDocument.trust_amt<>'',1,0));
    transfer__CountNonBlank                                        := sum(group,if(pDocument.transfer_<>'',1,0));
    mortgage_CountNonBlank                                         := sum(group,if(pDocument.mortgage<>'',1,0));
    intangible_tax_amt_CountNonBlank                               := sum(group,if(pDocument.intangible_tax_amt<>'',1,0));
    intangible_tax_penalty_CountNonBlank                           := sum(group,if(pDocument.intangible_tax_penalty<>'',1,0));
    excise_tax_amt_CountNonBlank                                   := sum(group,if(pDocument.excise_tax_amt<>'',1,0));
    recording_fee_CountNonBlank                                    := sum(group,if(pDocument.recording_fee<>'',1,0));
    documentary_stamps_fee_CountNonBlank                           := sum(group,if(pDocument.documentary_stamps_fee<>'',1,0));
    doc_stamps_mtg_fee_CountNonBlank                               := sum(group,if(pDocument.doc_stamps_mtg_fee<>'',1,0));
    book_num_CountNonBlank                                         := sum(group,if(pDocument.book_num<>'',1,0));
    page_num_CountNonBlank                                         := sum(group,if(pDocument.page_num<>'',1,0));
    book_type_cd_CountNonBlank                                     := sum(group,if(pDocument.book_type_cd<>'',1,0));
    book_type_desc_CountNonBlank                                   := sum(group,if(pDocument.book_type_desc<>'',1,0));
    parcel_or_case_num_CountNonBlank                               := sum(group,if(pDocument.parcel_or_case_num<>'',1,0));
    formatted_parcel_num_CountNonBlank                             := sum(group,if(pDocument.formatted_parcel_num<>'',1,0));
    legal_desc_1_CountNonBlank                                     := sum(group,if(pDocument.legal_desc_1<>'',1,0));
    legal_desc_2_CountNonBlank                                     := sum(group,if(pDocument.legal_desc_2<>'',1,0));
    legal_desc_3_CountNonBlank                                     := sum(group,if(pDocument.legal_desc_3<>'',1,0));
    legal_desc_4_CountNonBlank                                     := sum(group,if(pDocument.legal_desc_4<>'',1,0));
    legal_desc_5_CountNonBlank                                     := sum(group,if(pDocument.legal_desc_5<>'',1,0));
    verified_flag_CountNonBlank                                    := sum(group,if(pDocument.verified_flag<>'',1,0));
    address_1_CountNonBlank                                        := sum(group,if(pDocument.address_1<>'',1,0));
    address_2_CountNonBlank                                        := sum(group,if(pDocument.address_2<>'',1,0));
    address_3_CountNonBlank                                        := sum(group,if(pDocument.address_3<>'',1,0));
    address_4_CountNonBlank                                        := sum(group,if(pDocument.address_4<>'',1,0));
    prior_doc_file_num_CountNonBlank                               := sum(group,if(pDocument.prior_doc_file_num<>'',1,0));
    prior_doc_type_cd_CountNonBlank                                := sum(group,if(pDocument.prior_doc_type_cd<>'',1,0));
    prior_doc_type_desc_CountNonBlank                              := sum(group,if(pDocument.prior_doc_type_desc<>'',1,0));
    prior_book_num_CountNonBlank                                   := sum(group,if(pDocument.prior_book_num<>'',1,0));
    prior_page_num_CountNonBlank                                   := sum(group,if(pDocument.prior_page_num<>'',1,0));
    prior_book_type_cd_CountNonBlank                               := sum(group,if(pDocument.prior_book_type_cd<>'',1,0));
    prior_book_type_desc_CountNonBlank                             := sum(group,if(pDocument.prior_book_type_desc<>'',1,0));
    prim_range_CountNonBlank                                       := sum(group,if(pDocument.prim_range<>'',1,0));
    predir_CountNonBlank                                           := sum(group,if(pDocument.predir<>'',1,0));
    prim_name_CountNonBlank                                        := sum(group,if(pDocument.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                                      := sum(group,if(pDocument.addr_suffix<>'',1,0));
    postdir_CountNonBlank                                          := sum(group,if(pDocument.postdir<>'',1,0));
    unit_desig_CountNonBlank                                       := sum(group,if(pDocument.unit_desig<>'',1,0));
    sec_range_CountNonBlank                                        := sum(group,if(pDocument.sec_range<>'',1,0));
    p_city_name_CountNonBlank                                      := sum(group,if(pDocument.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                                      := sum(group,if(pDocument.v_city_name<>'',1,0));
    st_CountNonBlank                                               := sum(group,if(pDocument.st<>'',1,0));
    zip_CountNonBlank                                              := sum(group,if(pDocument.zip<>'',1,0));
    zip4_CountNonBlank                                             := sum(group,if(pDocument.zip4<>'',1,0));
    cart_CountNonBlank                                             := sum(group,if(pDocument.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                                       := sum(group,if(pDocument.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                              := sum(group,if(pDocument.lot<>'',1,0));
    lot_order_CountNonBlank                                        := sum(group,if(pDocument.lot_order<>'',1,0));
    dpbc_CountNonBlank                                             := sum(group,if(pDocument.dpbc<>'',1,0));
    chk_digit_CountNonBlank                                        := sum(group,if(pDocument.chk_digit<>'',1,0));
    rec_type_CountNonBlank                                         := sum(group,if(pDocument.rec_type<>'',1,0));
    ace_fips_st_CountNonBlank                                      := sum(group,if(pDocument.ace_fips_st<>'',1,0));
    ace_fips_county_CountNonBlank                                  := sum(group,if(pDocument.ace_fips_county<>'',1,0));
    geo_lat_CountNonBlank                                          := sum(group,if(pDocument.geo_lat<>'',1,0));
    geo_long_CountNonBlank                                         := sum(group,if(pDocument.geo_long<>'',1,0));
    msa_CountNonBlank                                              := sum(group,if(pDocument.msa<>'',1,0));
    geo_blk_CountNonBlank                                          := sum(group,if(pDocument.geo_blk<>'',1,0));
    geo_match_CountNonBlank                                        := sum(group,if(pDocument.geo_match<>'',1,0));
    err_stat_CountNonBlank                                         := sum(group,if(pDocument.err_stat<>'',1,0));
  end
 ;

%dPopulationStats_pParty% := table(pParty
                                  ,%rPopulationStats_pParty%
								  ,vendor,state_origin
								  ,few);
STRATA.createXMLStats(%dPopulationStats_pParty%
                     ,'OfficialRecords'
					 ,'Party'
					 ,pVersion
					 ,''
					 ,%zPartyStats%
					 ,'view'
					 ,'Population');

%dPopulationStats_pDocument% := table(pDocument
                                     ,%rPopulationStats_pDocument%
									 ,vendor,state_origin
									 ,few);
STRATA.createXMLStats(%dPopulationStats_pDocument%
                     ,'OfficialRecords'
					 ,'Document'
					 ,pVersion
					 ,''
					 ,%zDocumentStats%
					 ,'view'
					 ,'Population');

zOut := parallel(%zPartyStats%,%zDocumentStats%);

ENDMACRO;
