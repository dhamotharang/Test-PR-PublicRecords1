import liensV2;

file_in := LiensV2.file_liens_main;


rPopulationStats_file_in
 :=
  record
    tmsid_CountNonBlank                             := ave(group,if(file_in.tmsid<>'',100,0));
    rmsid_CountNonBlank                             := ave(group,if(file_in.rmsid<>'',100,0));
    process_date_CountNonBlank                      := ave(group,if(file_in.process_date<>'',100,0));
    record_code_CountNonBlank                       := ave(group,if(file_in.record_code<>'',100,0));
    date_vendor_removed_CountNonBlank               := ave(group,if(file_in.date_vendor_removed<>'',100,0));
    filing_jurisdiction_CountNonBlank               := ave(group,if(file_in.filing_jurisdiction<>'',100,0));
    filing_state_CountNonBlank                      := ave(group,if(file_in.filing_state<>'',100,0));
    orig_filing_number_CountNonBlank                := ave(group,if(file_in.orig_filing_number<>'',100,0));
    orig_filing_type_CountNonBlank                  := ave(group,if(file_in.orig_filing_type<>'',100,0));
    orig_filing_date_CountNonBlank                  := ave(group,if(file_in.orig_filing_date<>'',100,0));
    orig_filing_time_CountNonBlank                  := ave(group,if(file_in.orig_filing_time<>'',100,0));
    case_number_CountNonBlank                       := ave(group,if(file_in.case_number<>'',100,0));
    filing_number_CountNonBlank                     := ave(group,if(file_in.filing_number<>'',100,0));
    filing_type_desc_CountNonBlank                  := ave(group,if(file_in.filing_type_desc<>'',100,0));
    filing_date_CountNonBlank                       := ave(group,if(file_in.filing_date<>'',100,0));
    filing_time_CountNonBlank                       := ave(group,if(file_in.filing_time<>'',100,0));
    vendor_entry_date_CountNonBlank                 := ave(group,if(file_in.vendor_entry_date<>'',100,0));
    judge_CountNonBlank                             := ave(group,if(file_in.judge<>'',100,0));
    case_title_CountNonBlank                        := ave(group,if(file_in.case_title<>'',100,0));
    filing_book_CountNonBlank                       := ave(group,if(file_in.filing_book<>'',100,0));
    filing_page_CountNonBlank                       := ave(group,if(file_in.filing_page<>'',100,0));
    release_date_CountNonBlank                      := ave(group,if(file_in.release_date<>'',100,0));
    amount_CountNonBlank                            := ave(group,if(file_in.amount<>'',100,0));
    eviction_CountNonBlank                          := ave(group,if(file_in.eviction<>'',100,0));
    satisifaction_type_CountNonBlank                := ave(group,if(file_in.satisifaction_type<>'',100,0));
    judg_satisfied_date_CountNonBlank               := ave(group,if(file_in.judg_satisfied_date<>'',100,0));
    judg_vacated_date_CountNonBlank                 := ave(group,if(file_in.judg_vacated_date<>'',100,0));
    tax_code_CountNonBlank                          := ave(group,if(file_in.tax_code<>'',100,0));
    irs_serial_number_CountNonBlank                 := ave(group,if(file_in.irs_serial_number<>'',100,0));
    effective_date_CountNonBlank                    := ave(group,if(file_in.effective_date<>'',100,0));
    lapse_date_CountNonBlank                        := ave(group,if(file_in.lapse_date<>'',100,0));
    accident_date_CountNonBlank                     := ave(group,if(file_in.accident_date<>'',100,0));
    sherrif_indc_CountNonBlank                      := ave(group,if(file_in.sherrif_indc<>'',100,0));
    expiration_date_CountNonBlank                   := ave(group,if(file_in.expiration_date<>'',100,0));
    agency_CountNonBlank                            := ave(group,if(file_in.agency<>'',100,0));
    agency_city_CountNonBlank                       := ave(group,if(file_in.agency_city<>'',100,0));
    agency_state_CountNonBlank                      := ave(group,if(file_in.agency_state<>'',100,0));
    agency_county_CountNonBlank                     := ave(group,if(file_in.agency_county<>'',100,0));
    legal_lot_CountNonBlank                         := ave(group,if(file_in.legal_lot<>'',100,0));
    legal_block_CountNonBlank                       := ave(group,if(file_in.legal_block<>'',100,0));
    legal_borough_CountNonBlank                     := ave(group,if(file_in.legal_borough<>'',100,0));


end;

stats_out := table(file_in, rPopulationStats_file_in, few);


export stats_main := output(stats_out);