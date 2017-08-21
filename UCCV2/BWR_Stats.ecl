main:=UCCV2.File_UCC_Main_Base;
party:=UCCv2.File_UCC_Party_Base;

rPopulationStats_main
 :=
  record
    CountGroup                                           := count(group);    
    tmsid_CountNonBlank                                  := sum(group,if(main.tmsid<>'',1,0));
    rmsid_CountNonBlank                                  := sum(group,if(main.rmsid<>'',1,0));
    process_date_CountNonBlank                           := sum(group,if(main.process_date<>'',1,0));
    static_value_CountNonBlank                           := sum(group,if(main.static_value<>'',1,0));
    date_vendor_removed_CountNonBlank                    := sum(group,if(main.date_vendor_removed<>'',1,0));
    date_vendor_changed_CountNonBlank                    := sum(group,if(main.date_vendor_changed<>'',1,0));
    orig_filing_number_CountNonBlank                     := sum(group,if(main.orig_filing_number<>'',1,0));
    orig_filing_type_CountNonBlank                       := sum(group,if(main.orig_filing_type<>'',1,0));
    orig_filing_date_CountNonBlank                       := sum(group,if(main.orig_filing_date<>'',1,0));
    orig_filing_time_CountNonBlank                       := sum(group,if(main.orig_filing_time<>'',1,0));
    filing_number_CountNonBlank                          := sum(group,if(main.filing_number<>'',1,0));
    filing_number_indc_CountNonBlank                     := sum(group,if(main.filing_number_indc<>'',1,0));
    filing_type_CountNonBlank                            := sum(group,if(main.filing_type<>'',1,0));
    filing_date_CountNonBlank                            := sum(group,if(main.filing_date<>'',1,0));
    filing_time_CountNonBlank                            := sum(group,if(main.filing_time<>'',1,0));
    filing_status_CountNonBlank                          := sum(group,if(main.filing_status<>'',1,0));
    page_CountNonBlank                                   := sum(group,if(main.page<>'',1,0));
    expiration_date_CountNonBlank                        := sum(group,if(main.expiration_date<>'',1,0));
    contract_type_CountNonBlank                          := sum(group,if(main.contract_type<>'',1,0));
    vendor_entry_date_CountNonBlank                      := sum(group,if(main.vendor_entry_date<>'',1,0));
    vendor_upd_date_CountNonBlank                        := sum(group,if(main.vendor_upd_date<>'',1,0));
    statements_filed_CountNonBlank                       := sum(group,if(main.statements_filed<>'',1,0));
    continuious_expiration_CountNonBlank                 := sum(group,if(main.continuious_expiration<>'',1,0));
    microfilm_number_CountNonBlank                       := sum(group,if(main.microfilm_number<>'',1,0));
    amount_CountNonBlank                                 := sum(group,if(main.amount<>'',1,0));
    irs_serial_number_CountNonBlank                      := sum(group,if(main.irs_serial_number<>'',1,0));
    effective_date_CountNonBlank                         := sum(group,if(main.effective_date<>'',1,0));
    Signer_Name_CountNonBlank                            := sum(group,if(main.Signer_Name<>'',1,0));
    title_CountNonBlank                                  := sum(group,if(main.title<>'',1,0));
    filing_agency_CountNonBlank                          := sum(group,if(main.filing_agency<>'',1,0));
    address_CountNonBlank                                := sum(group,if(main.address<>'',1,0));
    city_CountNonBlank                                   := sum(group,if(main.city<>'',1,0));
    state_CountNonBlank                                  := sum(group,if(main.state<>'',1,0));
    county_CountNonBlank                                 := sum(group,if(main.county<>'',1,0));
    zip_CountNonBlank                                    := sum(group,if(main.zip<>'',1,0));
    duns_number_CountNonBlank                            := sum(group,if(main.duns_number<>'',1,0));
    cmnt_effective_date_CountNonBlank                    := sum(group,if(main.cmnt_effective_date<>'',1,0));
    collateral_desc_CountNonBlank                        := sum(group,if(main.collateral_desc<>'',1,0));
    prim_machine_CountNonBlank                           := sum(group,if(main.prim_machine<>'',1,0));
    sec_machine_CountNonBlank                            := sum(group,if(main.sec_machine<>'',1,0));
    model_CountNonBlank                                  := sum(group,if(main.model<>'',1,0));
    model_year_CountNonBlank                             := sum(group,if(main.model_year<>'',1,0));
    collateral_count_CountNonBlank                       := sum(group,if(main.collateral_count<>'',1,0));
    manufactured_year_CountNonBlank                      := sum(group,if(main.manufactured_year<>'',1,0));
    new_used_CountNonBlank                               := sum(group,if(main.new_used<>'',1,0));
    serial_number_CountNonBlank                          := sum(group,if(main.serial_number<>'',1,0));
    Property_desc_CountNonBlank                          := sum(group,if(main.Property_desc<>'',1,0));
    borough_CountNonBlank                                := sum(group,if(main.borough<>'',1,0));
    block_CountNonBlank                                  := sum(group,if(main.block<>'',1,0));
    lot_CountNonBlank                                    := sum(group,if(main.lot<>'',1,0));
    collateral_address_CountNonBlank                     := sum(group,if(main.collateral_address<>'',1,0));
    air_rights_indc_CountNonBlank                        := sum(group,if(main.air_rights_indc<>'',1,0));
    subterranean_rights_indc_CountNonBlank               := sum(group,if(main.subterranean_rights_indc<>'',1,0));
    easment_indc_CountNonBlank                           := sum(group,if(main.easment_indc<>'',1,0));
    
  end;

 
rPopulationStats_party
 :=
  record
    CountGroup                                           := count(group);
    
    tmsid_CountNonBlank                                 := sum(group,if(party.tmsid<>'',1,0));
    rmsid_CountNonBlank                                 := sum(group,if(party.rmsid<>'',1,0));
    Orig_name_CountNonBlank                             := sum(group,if(party.Orig_name<>'',1,0));
	Orig_lname_CountNonBlank                            := sum(group,if(party.Orig_lname<>'',1,0));
	Orig_fname_CountNonBlank                            := sum(group,if(party.Orig_fname<>'',1,0));
	Orig_mname_CountNonBlank                            := sum(group,if(party.Orig_mname<>'',1,0));
    duns_number_CountNonBlank                           := sum(group,if(party.duns_number<>'',1,0));
    hq_duns_number_CountNonBlank                        := sum(group,if(party.hq_duns_number<>'',1,0));
    ssn_CountNonBlank                                   := sum(group,if(party.ssn<>'',1,0));
    fein_CountNonBlank                                  := sum(group,if(party.fein<>'',1,0));
    Incorp_state_CountNonBlank                          := sum(group,if(party.Incorp_state<>'',1,0));
    corp_number_CountNonBlank                           := sum(group,if(party.corp_number<>'',1,0));
    corp_type_CountNonBlank                             := sum(group,if(party.corp_type<>'',1,0));
    Orig_address1_CountNonBlank                         := sum(group,if(party.Orig_address1<>'',1,0));
    Orig_address2_CountNonBlank                         := sum(group,if(party.Orig_address2<>'',1,0));
    Orig_city_CountNonBlank                             := sum(group,if(party.Orig_city<>'',1,0));
    Orig_state_CountNonBlank                            := sum(group,if(party.Orig_state<>'',1,0));
    Orig_zip5_CountNonBlank                             := sum(group,if(party.Orig_zip5<>'',1,0));
    Orig_zip4_CountNonBlank                             := sum(group,if(party.Orig_zip4<>'',1,0));
    Orig_province_CountNonBlank                         := sum(group,if(party.Orig_province<>'',1,0));
    Orig_postal_code_CountNonBlank                      := sum(group,if(party.Orig_postal_code<>'',1,0));
    foreign_indc_CountNonBlank                          := sum(group,if(party.foreign_indc<>'',1,0));
    Party_type_CountNonBlank                            := sum(group,if(party.Party_type<>'',1,0));
    dt_first_seen_CountNonZero                          := sum(group,if(party.dt_first_seen<>0,1,0));
    dt_vendor_last_reported_CountNonZero                := sum(group,if(party.dt_vendor_last_reported<>0,1,0));
    process_date_CountNonBlank                          := sum(group,if(party.process_date<>'',1,0));
	cname_NonBlank                                      := sum(group,if(party.company_name<>'',1,0));
    pname_NonBlank                                      := sum(group,if(party.company_name='',1,0));
    did_CountNonZero                                    := sum(group,if(party.did<>0,1,0));
    bdid_CountNonZero                                   := sum(group,if(party.bdid<>0,1,0));
    
    
  end;
  
  
 output(table(main,rPopulationStats_main));
 output(table(party,rPopulationStats_party));
    
    
