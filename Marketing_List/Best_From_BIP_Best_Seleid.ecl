/*
  Get From Best:
    business_name
    address
    fips_state   
    fips_county  
    county_name
    business_phone
    seleid_status

number_of_employees
annual_revenue     
src_revenue        
src_employees      

*/
import ut,BIPV2,Address;
EXPORT Best_From_BIP_Best_Seleid(

  dataset(recordof(Marketing_List.Source_Files().bip_best)) pDataset_Best   = Marketing_List.Source_Files().bip_best
 ,dataset(recordof(Marketing_List.Source_Files().bip_base)) pDataset_Base   = Marketing_List.Source_Files().bip_base
 ,boolean                                                   pDebug          = false
 ,set of unsigned6                                          pSampleProxids  = []
 ,dataset(recordof(Address.County_Names                  )) pCounty_Names   = Address.County_Names
 ,boolean                                                   pPullFromBest   = _Config().Pull_From_Best_File
) :=
function

  ds_base := pDataset_Base;
  ds_best := pDataset_Best;

  // -- get debug seleids from proxids
  ds_debug_seleids  := table(pDataset_Best(proxid in pSampleProxids )  ,{seleid},seleid,few);
  set_debug_seleids := set(ds_debug_seleids ,seleid);
  
  // -- define set of marketing approved sources and the marketing sources bitmap
  mktg_sources            := Marketing_List._Config().set_marketing_approved_sources;
  mktg_bmap               := Marketing_List._Config().Marketing_Bitmap              ;
  Best_Has_Source_Fields  := Marketing_List._Config().Best_Has_Source_Fields        ;
  
  // -- take bip commonbase, filter for populated name, address, only marketing sources, and seleid_status_public = ''
  ds_base_clean                   := ds_base;
  ds_base_filt                    := ds_base_clean(source in mktg_sources ,trim(seleid_status_public) = ''  ,trim(company_name) != ''  ,trim(prim_name) != ''  ,trim(v_city_name) != '' ,trim(st) != '',trim(zip) != '');

  // -- Only want Seleid level records from BIP Best
  ds_best_filter_out_seleid_level := ds_best(proxid = 0); 
  
  // -- Join to base to get only Active Best Seleids
  ds_best_get_active_seleids := join(ds_best_filter_out_seleid_level  ,table(ds_base_filt,{seleid},seleid,merge)  ,left.seleid = right.seleid ,transform(left)  ,hash);

  // -- reformat for output populating available fields including best company name and address that are marketing approved
  ds_best_prep := project(ds_best_get_active_seleids  ,transform(Marketing_List.Layouts.business_information_prep,

    // -- get best address and company name that are marketing approved.
    emp_cnt_cd := left.employee_count ((employee_count_data_permits  & mktg_bmap) != 0);
    sales_cd   := left.sales          ((sales_data_permits           & mktg_bmap) != 0);
    
    best_company_name := topn(left.company_name   ((company_name_data_permits         & mktg_bmap) != 0)                                                     ,1,-dt_last_seen               )[1];
    best_address      := topn(left.company_address((company_address_data_permits      & mktg_bmap) != 0)                                                     ,1, company_address_method     )[1];
    best_phone        := topn(left.company_phone  ((company_phone_data_permits        & mktg_bmap) != 0,Marketing_List.Validate_phone(company_phone) != '')  ,1, company_phone_method       )[1];

    best_emp_cnt      := topn(left.employee_count ((employee_count_data_permits       & mktg_bmap) != 0)                                                     ,1, employee_count_method      )[1];
    best_sales_cnt    := topn(left.sales          ((sales_data_permits                & mktg_bmap) != 0)                                                     ,1, sales_method               )[1];  
    best_sic_codes    := topn(left.sic_code       ((company_sic_code1_data_permits    & mktg_bmap) != 0)                                                     ,5, company_sic_code1_method   );
    best_naics_codes  := topn(left.naics_code     ((company_naics_code1_data_permits  & mktg_bmap) != 0)                                                     ,5, company_naics_code1_method );
  
    self.seleid              := left.seleid                             ;
    self.proxid              := 0                                       ;
    self.ultid               := left.ultid                              ;
    self.orgid               := left.orgid                              ;
    self.business_name       := best_company_name.company_name          ;
    self.prim_range          := best_address.company_prim_range         ;
    self.predir              := best_address.company_predir             ;
    self.prim_name           := best_address.company_prim_name          ;
    self.addr_suffix         := best_address.company_addr_suffix        ;
    self.postdir             := best_address.company_postdir            ;
    self.unit_desig          := best_address.company_unit_desig         ;
    self.sec_range           := best_address.company_sec_range          ;
    self.p_city_name         := best_address.company_p_city_name        ;
    self.v_city_name         := best_address.address_v_city_name        ;
    self.st                  := best_address.company_st                 ;
    self.zip                 := best_address.company_zip5               ;
    self.msa                 := ''                                      ;//need to get this from the base file
    self.err_stat            := ''                                      ;//need to get this from the base file
    self.fips_state          := best_address.state_fips                 ;
    self.fips_county         := best_address.county_fips                ;
    self.county_name         := ''                                      ;//get this below
    self.age_of_company      := ''                                      ;
    self.business_phone      := Marketing_List.Validate_phone(best_phone.company_phone)                ;
    self.business_email      := ''                                      ;//need to get this from the base file

    self.annual_revenue      := if(pPullFromBest = true ,if(exists(sales_cd  ) ,best_sales_cnt.sales         ,-1) ,0 )                                      ;
    #IF(Best_Has_Source_Fields = true)
    self.src_revenue         := if(pPullFromBest = true ,if(exists(sales_cd  ) ,best_sales_cnt.source        ,'') ,'')                                                                           ;
    #ELSE
    self.src_revenue         := ''                                                                            ;
    #END
    
    self.number_of_employees := if(pPullFromBest = true ,if(exists(emp_cnt_cd) ,best_emp_cnt.employee_count  ,-1) ,0 )                                     ;
    #IF(Best_Has_Source_Fields = true)
    self.src_employees       := if(pPullFromBest = true ,if(exists(emp_cnt_cd) ,best_emp_cnt.source          ,'') ,'')                                       ;  //remove until best has this!!!!!!
    #ELSE
    self.src_employees       := ''                                                                            ;
    #END

    self.SIC_Primary         := best_sic_codes[1].company_sic_code1     ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.SIC2                := best_sic_codes[2].company_sic_code1     ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.SIC3                := best_sic_codes[3].company_sic_code1     ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.SIC4                := best_sic_codes[4].company_sic_code1     ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.SIC5                := best_sic_codes[5].company_sic_code1     ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.src_sics            := ''                                      ;
    self.NAICS_Primary       := best_naics_codes[1].company_naics_code1 ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.NAICS2              := best_naics_codes[2].company_naics_code1 ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.NAICS3              := best_naics_codes[3].company_naics_code1 ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.NAICS4              := best_naics_codes[4].company_naics_code1 ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.NAICS5              := best_naics_codes[5].company_naics_code1 ; //need to get these from the base file so we can rank them and use dt_last_seen
    self.src_naics           := ''                                      ;
    self.dt_first_seen       := 0                                       ; //need to get from the base file
    self.dt_last_seen        := 0                                       ; //need to get from the base file
  ));
    
  // -- filter final dataset to make sure we didn't lose any records because of the marketing filter on company_name and address
  ds_best_seleid := ds_best_prep(trim(business_name) != '',trim(prim_name) != '',trim(v_city_name) != '',trim(st) != '',trim(zip) != '');
  
  ds_result := join(ds_best_seleid  ,pCounty_Names  ,left.fips_state = right.state_code and left.fips_county = right.county_code ,transform(
    recordof(left)
    ,self.county_name := right.county_name  ;
    ,self             := left               ;
  ) ,left outer  ,hash  ,keep(1));

  output_debug := parallel(
   
    output('---------------------Marketing_List.Best_From_BIP_Best_Seleid---------------------'                      ,named('Marketing_List_Best_From_BIP_Best_Seleid' ),all)
   ,output(choosen(pDataset_Best                    (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Best_Seleid_pDataset_Best'                            ),all)
   ,output(choosen(pDataset_Base                    (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Best_Seleid_pDataset_Base'                            ),all)
   ,output(choosen(ds_base_filt                     (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Best_Seleid_ds_base_filt'                             ),all)
   ,output(choosen(ds_best_filter_out_seleid_level  (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Best_Seleid_ds_best_filter_out_seleid_level'          ),all)
   ,output(choosen(ds_best_get_active_seleids       (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Best_Seleid_ds_best_get_active_seleids'               ),all)
   ,output(choosen(ds_best_prep                     (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Best_Seleid_ds_best_prep'                             ),all)
   ,output(choosen(ds_best_seleid                   (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Best_Seleid_ds_best_seleid'                           ),all)
   ,output(choosen(ds_result                        (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Best_Seleid_ds_result'                                ),all)
  
  );

  return when(ds_result  ,if(pDebug = true ,output_debug));
  
end;