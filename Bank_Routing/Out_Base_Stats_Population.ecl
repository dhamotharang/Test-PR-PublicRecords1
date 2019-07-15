IMPORT strata; 

EXPORT Out_Base_Stats_Population(STRING filedate):= FUNCTION

 rPopulationStats_bank_routing__Bank_Routing_Files_base := RECORD
  CountGroup                                  := count(group);
  rcid_CountNonBlank                          := sum(group,if(Bank_Routing.Files.base.rcid<>0,1,0));
  process_date_countnonblank                  := sum(group,if(Bank_Routing.files.base.process_date<>'',1,0));
  dt_first_seen_countnonblank                 := sum(group,if(Bank_Routing.files.base.dt_first_seen<>0,1,0));
  dt_last_seen_countnonblank                  := sum(group,if(Bank_Routing.files.base.dt_last_seen<>0,1,0));
  dt_vendor_first_reported_countnonblank      := sum(group,if(Bank_Routing.files.base.dt_vendor_first_reported<>0,1,0));
  dt_vendor_last_reported_countnonblank       := sum(group,if(Bank_Routing.files.base.dt_vendor_last_reported<>0,1,0));
  file_key_CountNonBlank                      := sum(group,if(Bank_Routing.Files.base.file_key<>'',1,0));
  date_updated_CountNonBlank                  := sum(group,if(Bank_Routing.Files.base.date_updated<>'',1,0));
  type_instituon_code_CountNonBlank           := sum(group,if(Bank_Routing.Files.base.type_instituon_code<>'',1,0));
  head_office_branch_codes_CountNonBlank      := sum(group,if(Bank_Routing.Files.base.head_office_branch_codes<>'',1,0));
  Bank_Routing.Files.base.routing_number_MICR;
  routing_number_fractional_CountNonBlank     := sum(group,if(Bank_Routing.Files.base.routing_number_fractional<>'',1,0));
  institution_name_full_CountNonBlank         := sum(group,if(Bank_Routing.Files.base.institution_name_full<>'',1,0));
  institution_name_abbreviated_CountNonBlank  := sum(group,if(Bank_Routing.Files.base.institution_name_abbreviated<>'',1,0));
  street_address_CountNonBlank                := sum(group,if(Bank_Routing.Files.base.street_address<>'',1,0));
  city_town_CountNonBlank                     := sum(group,if(Bank_Routing.Files.base.city_town<>'',1,0));
  state_CountNonBlank                         := sum(group,if(Bank_Routing.Files.base.state<>'',1,0));
  zip_code_CountNonBlank                      := sum(group,if(Bank_Routing.Files.base.zip_code<>'',1,0));
  zip_4_CountNonBlank                         := sum(group,if(Bank_Routing.Files.base.zip_4<>'',1,0));
  mail_address_CountNonBlank                  := sum(group,if(Bank_Routing.Files.base.mail_address<>'',1,0));
  mail_city_town_CountNonBlank                := sum(group,if(Bank_Routing.Files.base.mail_city_town<>'',1,0));
  mail_state_CountNonBlank                    := sum(group,if(Bank_Routing.Files.base.mail_state<>'',1,0));
  mail_zip_code_CountNonBlank                 := sum(group,if(Bank_Routing.Files.base.mail_zip_code<>'',1,0));
  mail_zip_4_CountNonBlank                    := sum(group,if(Bank_Routing.Files.base.mail_zip_4<>'',1,0));
  branch_office_name_CountNonBlank            := sum(group,if(Bank_Routing.Files.base.branch_office_name<>'',1,0));
  head_office_routing_number_CountNonBlank    := sum(group,if(Bank_Routing.Files.base.head_office_routing_number<>'',1,0));
  phone_number_area_code_CountNonBlank        := sum(group,if(Bank_Routing.Files.base.phone_number_area_code<>'',1,0));
  phone_number_CountNonBlank                  := sum(group,if(Bank_Routing.Files.base.phone_number<>'',1,0));
  phone_number_extension_CountNonBlank        := sum(group,if(Bank_Routing.Files.base.phone_number_extension<>'',1,0));
  fax_area_code_CountNonBlank                 := sum(group,if(Bank_Routing.Files.base.fax_area_code<>'',1,0));
  fax_number_CountNonBlank                    := sum(group,if(Bank_Routing.Files.base.fax_number<>'',1,0));
  fax_extension_CountNonBlank                 := sum(group,if(Bank_Routing.Files.base.fax_extension<>'',1,0));
  head_office_asset_size_CountNonBlank        := sum(group,if(Bank_Routing.Files.base.head_office_asset_size<>'',1,0));
  federal_reserve_district_code_CountNonBlank := sum(group,if(Bank_Routing.Files.base.federal_reserve_district_code<>'',1,0));
  year_2000_date_last_updated_CountNonBlank   := sum(group,if(Bank_Routing.Files.base.year_2000_date_last_updated<>'',1,0));
  head_office_file_key_CountNonBlank          := sum(group,if(Bank_Routing.Files.base.head_office_file_key<>'',1,0));
  routing_number_type_CountNonBlank           := sum(group,if(Bank_Routing.Files.base.routing_number_type<>'',1,0));
  routing_number_status_CountNonBlank         := sum(group,if(Bank_Routing.Files.base.routing_number_status<>'',1,0));
  employer_tax_id_CountNonBlank               := sum(group,if(Bank_Routing.Files.base.employer_tax_id<>'',1,0));
  institution_identifier_CountNonBlank        := sum(group,if(Bank_Routing.Files.base.institution_identifier<>'',1,0));
  rawaid_CountNonBlank                        := sum(group,if(Bank_Routing.Files.base.rawaid<>0,1,0));
  prim_range_CountNonBlank                    := sum(group,if(Bank_Routing.Files.base.prim_range<>'',1,0));
  predir_CountNonBlank                        := sum(group,if(Bank_Routing.Files.base.predir<>'',1,0));
  prim_name_CountNonBlank                     := sum(group,if(Bank_Routing.Files.base.prim_name<>'',1,0));
  addr_suffix_CountNonBlank                   := sum(group,if(Bank_Routing.Files.base.addr_suffix<>'',1,0));
  postdir_CountNonBlank                       := sum(group,if(Bank_Routing.Files.base.postdir<>'',1,0));
  unit_desig_CountNonBlank                    := sum(group,if(Bank_Routing.Files.base.unit_desig<>'',1,0));
  sec_range_CountNonBlank                     := sum(group,if(Bank_Routing.Files.base.sec_range<>'',1,0));
  p_city_name_CountNonBlank                   := sum(group,if(Bank_Routing.Files.base.p_city_name<>'',1,0));
  v_city_name_CountNonBlank                   := sum(group,if(Bank_Routing.Files.base.v_city_name<>'',1,0));
  st_CountNonBlank                            := sum(group,if(Bank_Routing.Files.base.st<>'',1,0));
  zip_CountNonBlank                           := sum(group,if(Bank_Routing.Files.base.zip<>'',1,0));
  zip4_CountNonBlank                          := sum(group,if(Bank_Routing.Files.base.zip4<>'',1,0));
  cart_CountNonBlank                          := sum(group,if(Bank_Routing.Files.base.cart<>'',1,0));
  cr_sort_sz_CountNonBlank                    := sum(group,if(Bank_Routing.Files.base.cr_sort_sz<>'',1,0));
  lot_CountNonBlank                           := sum(group,if(Bank_Routing.Files.base.lot<>'',1,0));
  lot_order_CountNonBlank                     := sum(group,if(Bank_Routing.Files.base.lot_order<>'',1,0));
  dpbc_CountNonBlank                          := sum(group,if(Bank_Routing.Files.base.dpbc<>'',1,0));
  chk_digit_CountNonBlank                     := sum(group,if(Bank_Routing.Files.base.chk_digit<>'',1,0));
  rec_type_CountNonBlank                      := sum(group,if(Bank_Routing.Files.base.rec_type<>'',1,0));
  county_CountNonBlank                        := sum(group,if(Bank_Routing.Files.base.county<>'',1,0));
  ace_fips_st_CountNonBlank                   := sum(group,if(Bank_Routing.Files.base.ace_fips_st<>'',1,0));
  fips_county_CountNonBlank                   := sum(group,if(Bank_Routing.Files.base.fips_county<>'',1,0));
  geo_lat_CountNonBlank                       := sum(group,if(Bank_Routing.Files.base.geo_lat<>'',1,0));
  geo_long_CountNonBlank                      := sum(group,if(Bank_Routing.Files.base.geo_long<>'',1,0));
  msa_CountNonBlank                           := sum(group,if(Bank_Routing.Files.base.msa<>'',1,0));
  geo_blk_CountNonBlank                       := sum(group,if(Bank_Routing.Files.base.geo_blk<>'',1,0));
  geo_match_CountNonBlank                     := sum(group,if(Bank_Routing.Files.base.geo_match<>'',1,0));
  err_stat_CountNonBlank                      := sum(group,if(Bank_Routing.Files.base.err_stat<>'',1,0));
  dotid_CountNonBlank                         := sum(group,if(Bank_Routing.Files.base.dotid<>0,1,0));
  dotscore_CountNonBlank                      := sum(group,if(Bank_Routing.Files.base.dotscore<>0,1,0));
  dotweight_CountNonBlank                     := sum(group,if(Bank_Routing.Files.base.dotweight<>0,1,0));
  empid_CountNonBlank                         := sum(group,if(Bank_Routing.Files.base.empid<>0,1,0));
  empscore_CountNonBlank                      := sum(group,if(Bank_Routing.Files.base.empscore<>0,1,0));
  empweight_CountNonBlank                     := sum(group,if(Bank_Routing.Files.base.empweight<>0,1,0));
  powid_CountNonBlank                         := sum(group,if(Bank_Routing.Files.base.powid<>0,1,0));
  powscore_CountNonBlank                      := sum(group,if(Bank_Routing.Files.base.powscore<>0,1,0));
  powweight_CountNonBlank                     := sum(group,if(Bank_Routing.Files.base.powweight<>0,1,0));
  proxid_CountNonBlank                        := sum(group,if(Bank_Routing.Files.base.proxid<>0,1,0));
  proxscore_CountNonBlank                     := sum(group,if(Bank_Routing.Files.base.proxscore<>0,1,0));
  proxweight_CountNonBlank                    := sum(group,if(Bank_Routing.Files.base.proxweight<>0,1,0));
  seleid_CountNonBlank                        := sum(group,if(Bank_Routing.Files.base.seleid<>0,1,0));
  selescore_CountNonBlank                     := sum(group,if(Bank_Routing.Files.base.selescore<>0,1,0));
  seleweight_CountNonBlank                    := sum(group,if(Bank_Routing.Files.base.seleweight<>0,1,0));
  orgid_CountNonBlank                         := sum(group,if(Bank_Routing.Files.base.orgid<>0,1,0));
  orgscore_CountNonBlank                      := sum(group,if(Bank_Routing.Files.base.orgscore<>0,1,0));
  orgweight_CountNonBlank                     := sum(group,if(Bank_Routing.Files.base.orgweight<>0,1,0));
  ultid_CountNonBlank                         := sum(group,if(Bank_Routing.Files.base.ultid<>0,1,0));
  ultscore_CountNonBlank                      := sum(group,if(Bank_Routing.Files.base.ultscore<>0,1,0));
  ultweight_CountNonBlank                     := sum(group,if(Bank_Routing.Files.base.ultweight<>0,1,0));
  source_rec_id_CountNonBlank                 := sum(group,if(Bank_Routing.Files.base.source_rec_id<>0,1,0));              
 END;

dPopulationStats_bank_routing__Bank_Routing_Files_base := TABLE(Bank_Routing.Files.base,
 rPopulationStats_bank_routing__Bank_Routing_Files_base,
 routing_number_MICR,
 few
									               );
// export createXMLStats(pStats, pBuildName, pBuildSubSet, pVersionName, pEmailNotifyList, rOut, pBuildView = '\'\'', pBuildType = '\'\'', pShouldExport = 'false',pShouldSendToStrata = 'true', omit_output_to_screen = 'true') := macro
STRATA.createXMLStats(dPopulationStats_bank_routing__Bank_Routing_Files_base,
 'Bank Routing',
 'data',
 filedate,
 '',
 resultsOut,
 'view',
 'population',,,true);
					 
RETURN resultsOut;

END;