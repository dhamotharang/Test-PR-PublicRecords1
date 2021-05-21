/*
  Get From Best:
    business_name
    address
    fips_state   
    fips_county  
    county_name
    business_phone
    proxid_status


*/
import ut,BIPV2,Address;
EXPORT Best_From_BIP_Best_Proxid(

  dataset(recordof(Marketing_List.Source_Files().bip_best)) pDataset_Best   = Marketing_List.Source_Files().bip_best
 ,dataset(recordof(Marketing_List.Source_Files().bip_base)) pDataset_Base   = Marketing_List.Source_Files().bip_base
 ,boolean                                                   pDebug          = false
 ,set of unsigned6                                          pSampleProxids  = []
 ,dataset(recordof(Address.County_Names                  )) pCounty_Names   = Address.County_Names
 
) :=
function

  ds_base := pDataset_Base;
  ds_best := pDataset_Best;
  
  // -- define set of marketing approved sources and the marketing sources bitmap
  mktg_sources  := Marketing_List._Config().set_marketing_approved_sources;
  mktg_bmap     := Marketing_List._Config().Marketing_Bitmap              ;
  
  // -- take bip commonbase, filter for populated name, address, only marketing sources, and proxid_status_public = ''
  ds_base_clean                   := ds_base;
  ds_base_filt                    := ds_base_clean(source in mktg_sources ,trim(proxid_status_public) = ''  ,trim(company_name) != ''  ,trim(prim_name) != ''  ,trim(v_city_name) != '' ,trim(st) != '',trim(zip) != '');
  
  // -- Only want Proxid level records from BIP Best
  ds_best_filter_out_seleid_level := ds_best(proxid != 0); 
  
  // -- Join to base to get only Active Best Proxids
  ds_best_get_active_proxids := join(ds_best_filter_out_seleid_level  ,table(ds_base_filt,{proxid},proxid,merge)  ,left.proxid = right.proxid ,transform(left)  ,hash);

  // -- reformat for output populating available fields including best company name and address that are marketing approved
  ds_best_prep := project(ds_best_get_active_proxids  ,transform(Marketing_List.Layouts.business_information_prep,
    
    // -- get best address and company name that are marketing approved.  
    best_company_name := topn(left.company_name   ((company_name_data_permits    & mktg_bmap) != 0) ,1,-dt_last_seen          )[1];
    best_address      := topn(left.company_address((company_address_data_permits & mktg_bmap) != 0) ,1, company_address_method)[1];
    best_phone        := topn(left.company_phone  ((company_phone_data_permits   & mktg_bmap) != 0,Marketing_List.Validate_phone(company_phone) != '') ,1, company_phone_method  )[1];
    
    has_full_fips := if(length(trim(best_address.state_fips) + trim(best_address.county_fips)) = 5  ,true ,false);
    
    self.seleid              := left.seleid                         ;
    self.proxid              := left.proxid                         ;
    self.ultid               := left.ultid                          ;
    self.orgid               := left.orgid                          ;
    self.business_name       := best_company_name.company_name      ;
    self.prim_range          := best_address.company_prim_range     ;
    self.predir              := best_address.company_predir         ;
    self.prim_name           := best_address.company_prim_name      ;
    self.addr_suffix         := best_address.company_addr_suffix    ;
    self.postdir             := best_address.company_postdir        ;
    self.unit_desig          := best_address.company_unit_desig     ;
    self.sec_range           := best_address.company_sec_range      ;
    self.p_city_name         := best_address.company_p_city_name    ;
    self.v_city_name         := best_address.address_v_city_name    ;
    self.st                  := best_address.company_st             ;
    self.zip                 := map(length(trim(best_address.company_zip5)) = 5  =>       best_address.company_zip5 
                                   ,length(trim(best_address.company_zip5)) = 4  => '0' + trim(best_address.company_zip5) 
                                   ,                                                ''
    );
    self.msa                 := ''                                  ;//need to get this from the base file
    self.err_stat            := ''                                  ;//need to get this from the base file
    self.fips_state          := if(has_full_fips = true ,best_address.state_fips  ,'')  ;
    self.fips_county         := if(has_full_fips = true ,best_address.county_fips ,'')  ;
    self.county_name         := ''                                  ;//get this below
    self.age_of_company      := ''                                  ;
    self.business_phone      := Marketing_List.Validate_phone(best_phone.company_phone)            ;
    self.business_email      := ''                                  ;//need to get this from the base file
    self.annual_revenue      := 0                                   ;
    self.src_revenue         := ''                                  ;
    self.revenue_sources     := 0                                   ;
    self.number_of_employees := 0                                   ;
    self.src_employees       := ''                                  ;
    self.employees_sources   := 0                                   ;
    self.SIC_Primary         := ''                                  ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.SIC2                := ''                                  ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.SIC3                := ''                                  ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.SIC4                := ''                                  ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.SIC5                := ''                                  ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.src_sics            := ''                                  ;
    self.sic_sources         := 0                                   ;
    self.NAICS_Primary       := ''                                  ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.NAICS2              := ''                                  ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.NAICS3              := ''                                  ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.NAICS4              := ''                                  ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.NAICS5              := ''                                  ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.src_naics           := ''                                  ;
    self.naics_sources       := 0                                   ;
    self.dt_first_seen       := 0                                   ;  //need to get from the base file
    self.dt_last_seen        := 0                                   ;  //need to get from the base file
  ));
  
  // -- filter final dataset to make sure we didn't lose any records because of the marketing filter on company_name and address
  ds_best_proxid := ds_best_prep(trim(business_name) != '',trim(prim_name) != '',trim(v_city_name) != '',trim(st) != '',trim(zip) != '');

  ds_best_proxid_with_fips    := ds_best_proxid(  trim(fips_state) != '' and trim(fips_county) != '' );
  ds_best_proxid_without_fips := ds_best_proxid(~(trim(fips_state) != '' and trim(fips_county) != ''));
  
  ds_get_county_name := join(ds_best_proxid_with_fips  ,pCounty_Names  ,left.fips_state = right.state_code and left.fips_county = right.county_code ,transform(
    recordof(left)
    ,self.county_name := right.county_name  ;
    ,self             := left               ;
  ) ,left outer  ,hash  ,keep(1));
  
  ds_result := ds_get_county_name + ds_best_proxid_without_fips;
  
  output_debug := parallel(
   
    output('---------------------Marketing_List.Best_From_BIP_Best_Proxid---------------------'                       ,named('Marketing_List_Best_From_BIP_Best_Proxid' ),all)
   ,output(choosen(pDataset_Best                    (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Best_From_BIP_Best_Proxid_pDataset_Best'                            ),all)
   ,output(choosen(pDataset_Base                    (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Best_From_BIP_Best_Proxid_pDataset_Base'                            ),all)
   ,output(choosen(ds_base_filt                     (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Best_From_BIP_Best_Proxid_ds_base_filt'                             ),all)
   ,output(choosen(ds_best_filter_out_seleid_level  (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Best_From_BIP_Best_Proxid_ds_best_filter_out_seleid_level'          ),all)
   ,output(choosen(ds_best_get_active_proxids       (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Best_From_BIP_Best_Proxid_ds_best_get_active_proxids'               ),all)
   ,output(choosen(ds_best_prep                     (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Best_From_BIP_Best_Proxid_ds_best_prep'                             ),all)
   ,output(choosen(ds_best_proxid                   (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Best_From_BIP_Best_Proxid_ds_best_proxid'                           ),all)
   ,output(choosen(ds_best_proxid_with_fips         (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Best_From_BIP_Best_Proxid_ds_best_proxid_with_fips'                 ),all)
   ,output(choosen(ds_best_proxid_without_fips      (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Best_From_BIP_Best_Proxid_ds_best_proxid_without_fips'              ),all)
   ,output(choosen(ds_get_county_name               (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Best_From_BIP_Best_Proxid_ds_get_county_name'                       ),all)
   ,output(choosen(ds_result                        (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Best_From_BIP_Best_Proxid_ds_result'                                ),all)
  
  );

  return when(ds_result  ,if(pDebug = true ,output_debug));

end;