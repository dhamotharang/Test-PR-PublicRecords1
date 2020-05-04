﻿EXPORT Create_Business_Information_File(

   pDataset_Best                = 'Marketing_List.Source_Files().bip_best'
  ,pDataset_Base                = 'Marketing_List.Source_Files().bip_base'
  ,pdca_base                    = 'Marketing_List.Source_Files().dca'                  
  ,peq_biz_base                 = 'Marketing_List.Source_Files().eq_biz'               
  ,poshair_base                 = 'Marketing_List.Source_Files().oshair'               
  ,pcortera_base                = 'Marketing_List.Source_Files().cortera'              
  ,pinfutor_base                = 'Marketing_List.Source_Files().infutor'              
  ,paccutrend_base              = 'Marketing_List.Source_Files().accutrend'            
  ,pDebug                       = 'false'
  ,pSampleProxids               = '[]'
  ,pEmployees_Ranking           = 'Marketing_List._Config().ds_sources_of_number_of_employees'
  ,pSales_Ranking               = 'Marketing_List._Config().ds_sources_of_sales_revenue'
  ,pMrktg_BitMap                = 'Marketing_List._Config().Marketing_Bitmap'
  ,pMrktg_Approved_Sources      = 'Marketing_List._Config().set_marketing_approved_sources'
  ,pCounty_Names                = 'Address.County_Names'
  ,pQuickTest                   = 'false'                                                       // set to true to only use the seleids contained in the proxids passed in

) :=
functionmacro

  import Address;
  
  #UNIQUENAME(ds_best     )
  #UNIQUENAME(ds_base_best)
  
  // -- get debug seleids from proxids
  ds_debug_seleids  := table(pDataset_Best(proxid in pSampleProxids )  ,{seleid},seleid,few);
  set_debug_seleids := set(ds_debug_seleids ,seleid);
  
  #IF(pQuickTest = false)
    %ds_best%       := pDataset_Best  ;
    %ds_base_best%  := pDataset_Base  ;
    // ds_base := topn(ds_base_best                ,20000  ,proxid) : persist('~persist::lbentley::BH687::ds_base');
  #ELSE
    %ds_best%       := pDataset_Best  (seleid in set_debug_seleids) : persist('~persist::Marketing_List::Create_Business_Information_File::ds_best');
    %ds_base_best%  := pDataset_Base  (seleid in set_debug_seleids) : persist('~persist::Marketing_List::Create_Business_Information_File::ds_base_best');
  #END

  ds_mrktg_list_best_proxid  := Marketing_List.Best_From_BIP_Best_Proxid  (%ds_best%        ,%ds_base_best% ,pDebug ,pSampleProxids ,pCounty_Names  );
  ds_mrktg_list_best_seleid  := Marketing_List.Best_From_BIP_Best_Seleid  (%ds_best%        ,%ds_base_best% ,pDebug ,pSampleProxids ,pCounty_Names  );
  
  ds_both_best := join(ds_mrktg_list_best_proxid  ,ds_mrktg_list_best_seleid ,left.seleid = right.seleid ,transform(Marketing_List.Layouts.business_information

    ,proxid_level_address := Address.Addr1FromComponents(left.prim_range  ,left.predir  ,left.prim_name   ,left.addr_suffix   ,left.postdir   ,left.unit_desig  ,left.sec_range )  ;
     seleid_level_address := Address.Addr1FromComponents(right.prim_range ,right.predir ,right.prim_name  ,right.addr_suffix  ,right.postdir  ,right.unit_desig ,right.sec_range)  ;
    
    self.proxid_level.business_name      := left.business_name                   ;     
    self.proxid_level.business_address   := proxid_level_address                 ;      
    self.proxid_level.city               := left.v_city_name                     ; 
    self.proxid_level.state              := left.st                              ;
    self.proxid_level.zip5               := left.zip                             ; 
    self.proxid_level.county             := left.fips_state + left.fips_county   ;
    self.proxid_level.county_name        := left.county_name                     ;
    self.proxid_level.business_phone     := left.business_phone                  ;
                                           
    self.seleid_level.business_name      := right.business_name                  ;     
    self.seleid_level.business_address   := seleid_level_address                 ;      
    self.seleid_level.city               := right.v_city_name                    ; 
    self.seleid_level.state              := right.st                             ;
    self.seleid_level.zip5               := right.zip                            ; 
    self.seleid_level.county             := right.fips_state + right.fips_county ;
    self.seleid_level.county_name        := right.county_name                    ;
    self.seleid_level.business_phone     := right.business_phone                 ;

    self                                 := left                                 ;
    self                                 := []                                   ;

  ),hash);

  ds_mrktg_list_base_proxid  := Marketing_List.Best_From_BIP_Base_Proxid  (%ds_base_best%   ,ds_mrktg_list_best_proxid  ,pDebug ,pSampleProxids);
  ds_mrktg_list_base_seleid  := Marketing_List.Best_From_BIP_Base_Seleid  (%ds_base_best%   ,ds_mrktg_list_best_seleid  ,pDebug ,pSampleProxids);

  ds_both_best_plus_proxid_base := join(ds_both_best  ,ds_mrktg_list_base_proxid ,left.proxid = right.proxid ,transform(recordof(left)
    ,self.proxid_level.msa             := right.msa
    ,self.proxid_level.err_stat        := right.err_stat
    ,self.proxid_level.age_of_company  := right.age_of_company
    ,self.proxid_level.dt_first_seen   := right.dt_first_seen
    ,self.proxid_level.dt_last_seen    := right.dt_last_seen
    // ,self.proxid_level.business_email  := right.business_email //no email for proxid level.
    ,self                              := left

  ),hash);

  ds_both_best_both_base := join(ds_both_best_plus_proxid_base  ,ds_mrktg_list_base_seleid ,left.seleid = right.seleid ,transform(recordof(left)
    ,self.seleid_level.msa             := right.msa
    ,self.seleid_level.err_stat        := right.err_stat
    ,self.seleid_level.age_of_company  := right.age_of_company
    ,self.seleid_level.dt_first_seen   := right.dt_first_seen
    ,self.seleid_level.dt_last_seen    := right.dt_last_seen
    ,self.seleid_level.business_email  := right.business_email
    ,self                              := left

  ),hash);

  ds_industry_codes   := Marketing_List.Best_Industry_Codes (%ds_base_best%   ,ds_mrktg_list_best_seleid  ,pDebug ,pSampleProxids);

  ds_both_best_both_base_plus_Industry := join(ds_both_best_both_base ,ds_industry_codes  ,left.seleid = right.seleid ,transform(recordof(left)
    ,self.seleid_level.SIC_Primary        := right.SIC_Primary       
    ,self.seleid_level.SIC2               := right.SIC2              
    ,self.seleid_level.SIC3               := right.SIC3              
    ,self.seleid_level.SIC4               := right.SIC4              
    ,self.seleid_level.SIC5               := right.SIC5              
    ,self.seleid_level.NAICS_Primary      := right.NAICS_Primary     
    ,self.seleid_level.NAICS2             := right.NAICS2            
    ,self.seleid_level.NAICS3             := right.NAICS3            
    ,self.seleid_level.NAICS4             := right.NAICS4            
    ,self.seleid_level.NAICS5             := right.NAICS5            
    ,self                                 := left
  ) ,hash ,left outer);

  ds_best_emps_sales  := Marketing_List.Best_Sales_And_Employees(
                           seleid
                          ,pdca_base        
                          ,peq_biz_base     
                          ,poshair_base     
                          ,pcortera_base    
                          ,pinfutor_base    
                          ,paccutrend_base  
                          ,pEmployees_Ranking
                          ,pSales_Ranking 
                          ,pDebug 
                          ,pSampleProxids
                        );

  // -- if no data for emp num or revenue, set to -1.
  ds_return_result_biz := join(ds_both_best_both_base_plus_Industry ,ds_best_emps_sales  ,left.seleid = right.seleid ,transform(recordof(left)
    ,self.seleid_level.number_of_employees  := if(right.seleid != 0                               ,right.number_of_employees  ,-1)
    ,self.seleid_level.annual_revenue       := if(right.seleid != 0                               ,right.annual_revenue       ,-1)
    ,self.seleid_level.src_revenue          := if(right.seleid != 0 and right.annual_revenue >= 0 ,right.source               ,'')
    ,self                                   := left
  ) ,hash ,left outer);
  
  
  output_debug := parallel(
   
    output('---------------------Marketing_List.Create_Business_Information_File---------------------'                    ,named('Marketing_List_Create_Business_Information_File'                       ),all)
   ,output(pMrktg_BitMap                                                                                                  ,named('Create_Business_Information_File_pMrktg_BitMap'                        ),all)
   ,output(pMrktg_Approved_Sources                                                                                        ,named('Create_Business_Information_File_pMrktg_Approved_Sources'              ),all)
   ,output(pEmployees_Ranking                                                                                             ,named('Create_Business_Information_File_pEmployees_Ranking'                   ),all)
   ,output(pSales_Ranking                                                                                                 ,named('Create_Business_Information_File_pSales_Ranking'                       ),all)
   ,output(choosen(pDataset_Best                        (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Create_Business_Information_File_pDataset_Best'                        ),all)
   ,output(choosen(pDataset_Base                        (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Create_Business_Information_File_pDataset_Base'                        ),all)
   ,output(choosen(pdca_base                            (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Create_Business_Information_File_pdca_base'                            ),all)
   ,output(choosen(peq_biz_base                         (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Create_Business_Information_File_peq_biz_base'                         ),all)
   ,output(choosen(poshair_base                         (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Create_Business_Information_File_poshair_base'                         ),all)
   ,output(choosen(pcortera_base                        (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Create_Business_Information_File_pcortera_base'                        ),all)
   ,output(choosen(pinfutor_base                        (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Create_Business_Information_File_pinfutor_base'                        ),all)
   ,output(choosen(paccutrend_base                      (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Create_Business_Information_File_paccutrend_base'                      ),all)
   ,output(choosen(ds_mrktg_list_best_proxid            (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Create_Business_Information_File_ds_mrktg_list_best_proxid'            ),all)
   ,output(choosen(ds_mrktg_list_best_seleid            (count(pSampleProxids) = 0 or seleid in set_debug_seleids ),300)  ,named('Create_Business_Information_File_ds_mrktg_list_best_seleid'            ),all)
   ,output(choosen(ds_both_best                         (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Create_Business_Information_File_ds_both_best'                         ),all)
   ,output(choosen(ds_mrktg_list_base_proxid            (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Create_Business_Information_File_ds_mrktg_list_base_proxid'            ),all)
   ,output(choosen(ds_mrktg_list_base_seleid            (count(pSampleProxids) = 0 or seleid in set_debug_seleids ),300)  ,named('Create_Business_Information_File_ds_mrktg_list_base_seleid'            ),all)
   ,output(choosen(ds_both_best_plus_proxid_base        (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Create_Business_Information_File_ds_both_best_plus_proxid_base'        ),all)
   ,output(choosen(ds_both_best_both_base               (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Create_Business_Information_File_ds_both_best_both_base'               ),all)
   ,output(choosen(ds_industry_codes                    (count(pSampleProxids) = 0 or seleid in set_debug_seleids ),300)  ,named('Create_Business_Information_File_ds_industry_codes'                    ),all)
   ,output(choosen(ds_both_best_both_base_plus_Industry (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Create_Business_Information_File_ds_both_best_both_base_plus_Industry' ),all)
   ,output(choosen(ds_best_emps_sales                   (count(pSampleProxids) = 0 or seleid in set_debug_seleids ),300)  ,named('Create_Business_Information_File_ds_best_emps_sales'                   ),all)
   ,output(choosen(ds_return_result_biz                 (count(pSampleProxids) = 0 or proxid in pSampleProxids    ),300)  ,named('Create_Business_Information_File_ds_return_result_biz'                 ),all)
                                                                                                                                  
  );

  #IF(pDebug = true)
    return when(ds_return_result_biz  ,output_debug);
  #ELSE
    return ds_return_result_biz;
  #END
  
endmacro;