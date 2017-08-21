import STRATA;

dDocument	:=	official_records.File_Moxie_Document_Dev;

rPopulationStats_dDocument
 :=
  record
    CountGroup                                                     := count(group);
    process_date_CountNonBlank                                     := sum(group,if(dDocument.process_date<>'',1,0));
    dDocument.vendor;
    dDocument.state_origin;
    county_name_CountNonBlank                                      := sum(group,if(dDocument.county_name<>'',1,0));
    official_record_key_CountNonBlank                              := sum(group,if(dDocument.official_record_key<>'',1,0));
    fips_st_CountNonBlank                                          := sum(group,if(dDocument.fips_st<>'',1,0));
    fips_county_CountNonBlank                                      := sum(group,if(dDocument.fips_county<>'',1,0));
    batch_id_CountNonBlank                                         := sum(group,if(dDocument.batch_id<>'',1,0));
    doc_serial_num_CountNonBlank                                   := sum(group,if(dDocument.doc_serial_num<>'',1,0));
    doc_instrument_or_clerk_filing_num_CountNonBlank               := sum(group,if(dDocument.doc_instrument_or_clerk_filing_num<>'',1,0));
    doc_num_dummy_flag_CountNonBlank                               := sum(group,if(dDocument.doc_num_dummy_flag<>'',1,0));
    doc_filed_dt_CountNonBlank                                     := sum(group,if(dDocument.doc_filed_dt<>'',1,0));
    doc_record_dt_CountNonBlank                                    := sum(group,if(dDocument.doc_record_dt<>'',1,0));
    doc_type_cd_CountNonBlank                                      := sum(group,if(dDocument.doc_type_cd<>'',1,0));
    doc_type_desc_CountNonBlank                                    := sum(group,if(dDocument.doc_type_desc<>'',1,0));
    doc_other_desc_CountNonBlank                                   := sum(group,if(dDocument.doc_other_desc<>'',1,0));
    doc_page_count_CountNonBlank                                   := sum(group,if(dDocument.doc_page_count<>'',1,0));
    doc_names_count_CountNonBlank                                  := sum(group,if(dDocument.doc_names_count<>'',1,0));
    doc_status_cd_CountNonBlank                                    := sum(group,if(dDocument.doc_status_cd<>'',1,0));
    doc_status_desc_CountNonBlank                                  := sum(group,if(dDocument.doc_status_desc<>'',1,0));
    doc_amend_cd_CountNonBlank                                     := sum(group,if(dDocument.doc_amend_cd<>'',1,0));
    doc_amend_desc_CountNonBlank                                   := sum(group,if(dDocument.doc_amend_desc<>'',1,0));
    execution_dt_CountNonBlank                                     := sum(group,if(dDocument.execution_dt<>'',1,0));
    consideration_amt_CountNonBlank                                := sum(group,if(dDocument.consideration_amt<>'',1,0));
    assumption_amt_CountNonBlank                                   := sum(group,if(dDocument.assumption_amt<>'',1,0));
    certified_mail_fee_CountNonBlank                               := sum(group,if(dDocument.certified_mail_fee<>'',1,0));
    service_charge_CountNonBlank                                   := sum(group,if(dDocument.service_charge<>'',1,0));
    trust_amt_CountNonBlank                                        := sum(group,if(dDocument.trust_amt<>'',1,0));
    transfer__CountNonBlank                                        := sum(group,if(dDocument.transfer_<>'',1,0));
    mortgage_CountNonBlank                                         := sum(group,if(dDocument.mortgage<>'',1,0));
    intangible_tax_amt_CountNonBlank                               := sum(group,if(dDocument.intangible_tax_amt<>'',1,0));
    intangible_tax_penalty_CountNonBlank                           := sum(group,if(dDocument.intangible_tax_penalty<>'',1,0));
    excise_tax_amt_CountNonBlank                                   := sum(group,if(dDocument.excise_tax_amt<>'',1,0));
    recording_fee_CountNonBlank                                    := sum(group,if(dDocument.recording_fee<>'',1,0));
    documentary_stamps_fee_CountNonBlank                           := sum(group,if(dDocument.documentary_stamps_fee<>'',1,0));
    doc_stamps_mtg_fee_CountNonBlank                               := sum(group,if(dDocument.doc_stamps_mtg_fee<>'',1,0));
    book_num_CountNonBlank                                         := sum(group,if(dDocument.book_num<>'',1,0));
    page_num_CountNonBlank                                         := sum(group,if(dDocument.page_num<>'',1,0));
    book_type_cd_CountNonBlank                                     := sum(group,if(dDocument.book_type_cd<>'',1,0));
    book_type_desc_CountNonBlank                                   := sum(group,if(dDocument.book_type_desc<>'',1,0));
    parcel_or_case_num_CountNonBlank                               := sum(group,if(dDocument.parcel_or_case_num<>'',1,0));
    formatted_parcel_num_CountNonBlank                             := sum(group,if(dDocument.formatted_parcel_num<>'',1,0));
    legal_desc_1_CountNonBlank                                     := sum(group,if(dDocument.legal_desc_1<>'',1,0));
    legal_desc_2_CountNonBlank                                     := sum(group,if(dDocument.legal_desc_2<>'',1,0));
    legal_desc_3_CountNonBlank                                     := sum(group,if(dDocument.legal_desc_3<>'',1,0));
    legal_desc_4_CountNonBlank                                     := sum(group,if(dDocument.legal_desc_4<>'',1,0));
    legal_desc_5_CountNonBlank                                     := sum(group,if(dDocument.legal_desc_5<>'',1,0));
    verified_flag_CountNonBlank                                    := sum(group,if(dDocument.verified_flag<>'',1,0));
    address_1_CountNonBlank                                        := sum(group,if(dDocument.address_1<>'',1,0));
    address_2_CountNonBlank                                        := sum(group,if(dDocument.address_2<>'',1,0));
    address_3_CountNonBlank                                        := sum(group,if(dDocument.address_3<>'',1,0));
    address_4_CountNonBlank                                        := sum(group,if(dDocument.address_4<>'',1,0));
    prior_doc_file_num_CountNonBlank                               := sum(group,if(dDocument.prior_doc_file_num<>'',1,0));
    prior_doc_type_cd_CountNonBlank                                := sum(group,if(dDocument.prior_doc_type_cd<>'',1,0));
    prior_doc_type_desc_CountNonBlank                              := sum(group,if(dDocument.prior_doc_type_desc<>'',1,0));
    prior_book_num_CountNonBlank                                   := sum(group,if(dDocument.prior_book_num<>'',1,0));
    prior_page_num_CountNonBlank                                   := sum(group,if(dDocument.prior_page_num<>'',1,0));
    prior_book_type_cd_CountNonBlank                               := sum(group,if(dDocument.prior_book_type_cd<>'',1,0));
    prior_book_type_desc_CountNonBlank                             := sum(group,if(dDocument.prior_book_type_desc<>'',1,0));
    prim_range_CountNonBlank                                       := sum(group,if(dDocument.prim_range<>'',1,0));
    predir_CountNonBlank                                           := sum(group,if(dDocument.predir<>'',1,0));
    prim_name_CountNonBlank                                        := sum(group,if(dDocument.prim_name<>'',1,0));
    addr_suffix_CountNonBlank                                      := sum(group,if(dDocument.addr_suffix<>'',1,0));
    postdir_CountNonBlank                                          := sum(group,if(dDocument.postdir<>'',1,0));
    unit_desig_CountNonBlank                                       := sum(group,if(dDocument.unit_desig<>'',1,0));
    sec_range_CountNonBlank                                        := sum(group,if(dDocument.sec_range<>'',1,0));
    p_city_name_CountNonBlank                                      := sum(group,if(dDocument.p_city_name<>'',1,0));
    v_city_name_CountNonBlank                                      := sum(group,if(dDocument.v_city_name<>'',1,0));
    st_CountNonBlank                                               := sum(group,if(dDocument.st<>'',1,0));
    zip_CountNonBlank                                              := sum(group,if(dDocument.zip<>'',1,0));
    zip4_CountNonBlank                                             := sum(group,if(dDocument.zip4<>'',1,0));
    cart_CountNonBlank                                             := sum(group,if(dDocument.cart<>'',1,0));
    cr_sort_sz_CountNonBlank                                       := sum(group,if(dDocument.cr_sort_sz<>'',1,0));
    lot_CountNonBlank                                              := sum(group,if(dDocument.lot<>'',1,0));
    lot_order_CountNonBlank                                        := sum(group,if(dDocument.lot_order<>'',1,0));
    dpbc_CountNonBlank                                             := sum(group,if(dDocument.dpbc<>'',1,0));
    chk_digit_CountNonBlank                                        := sum(group,if(dDocument.chk_digit<>'',1,0));
    rec_type_CountNonBlank                                         := sum(group,if(dDocument.rec_type<>'',1,0));
    ace_fips_st_CountNonBlank                                      := sum(group,if(dDocument.ace_fips_st<>'',1,0));
    ace_fips_county_CountNonBlank                                  := sum(group,if(dDocument.ace_fips_county<>'',1,0));
    geo_lat_CountNonBlank                                          := sum(group,if(dDocument.geo_lat<>'',1,0));
    geo_long_CountNonBlank                                         := sum(group,if(dDocument.geo_long<>'',1,0));
    msa_CountNonBlank                                              := sum(group,if(dDocument.msa<>'',1,0));
    geo_blk_CountNonBlank                                          := sum(group,if(dDocument.geo_blk<>'',1,0));
    geo_match_CountNonBlank                                        := sum(group,if(dDocument.geo_match<>'',1,0));
    err_stat_CountNonBlank                                         := sum(group,if(dDocument.err_stat<>'',1,0));
  end
 ;

dPopulationStats_dDocument	:= table(dDocument,
									 rPopulationStats_dDocument,
									 vendor,state_origin,
									 few
									);

STRATA.createXMLStats(dPopulationStats_dDocument,
					  'OfficialRecords',
					  'Document',
					  official_records.Version_Development,
					  '',
					  zRunDocumentStats,
					  'view',
					  'Population'
					 );

export Out_Moxie_Document_Dev_Stats	:=	zRunDocumentStats;