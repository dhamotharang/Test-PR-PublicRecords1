EXPORT Create_Business_Information_File(

   pDataset_Best                = 'Marketing_List.Source_Files().bip_best'
  ,pDataset_Base                = 'Marketing_List.Source_Files().bip_base'
  ,pdca_base                    = 'Marketing_List.Source_Files().dca'                  
  ,peq_biz_base                 = 'Marketing_List.Source_Files().eq_biz'               
  ,poshair_base                 = 'Marketing_List.Source_Files().oshair'               
  ,pcortera_base                = 'Marketing_List.Source_Files().cortera'              
  ,pinfutor_base                = 'Marketing_List.Source_Files().infutor'              
  ,paccutrend_base              = 'Marketing_List.Source_Files().accutrend'            
  ,pEmployees_Ranking           = 'Marketing_List._Config().ds_sources_of_number_of_employees'
  ,pSales_Ranking               = 'Marketing_List._Config().ds_sources_of_sales_revenue'
  ,pMrktg_BitMap                = 'Marketing_List._Config().Marketing_Bitmap'
  ,pMrktg_Approved_Sources      = 'Marketing_List._Config().set_marketing_approved_sources'
  ,pDoSample                    = 'false'
  ,pDebug                       = 'false'


) :=
functionmacro

  #UNIQUENAME(ds_best     )
  #UNIQUENAME(ds_base_best)
  
  %ds_best%       := pDataset_Best  ;
  %ds_base_best%  := pDataset_Base  ;
  // ds_base := topn(ds_base_best                ,20000  ,proxid) : persist('~persist::lbentley::BH687::ds_base');

  ds_mrktg_list_best_proxid  := Marketing_List.Best_From_BIP_Best_Proxid  (%ds_best%        ,%ds_base_best%       );
  ds_mrktg_list_best_seleid  := Marketing_List.Best_From_BIP_Best_Seleid  (%ds_best%        ,%ds_base_best%       );
  
  ds_both_best := join(ds_mrktg_list_best_proxid  ,ds_mrktg_list_best_seleid ,left.seleid = right.seleid ,transform(Marketing_List.Layouts.business_information
    ,self.proxid_level.business_name      := left.business_name     ;     
    ,self.proxid_level.business_address   := Address.Addr1FromComponents(left.prim_range ,left.predir  ,left.prim_name ,left.addr_suffix ,left.postdir ,left.unit_desig  ,left.sec_range)  ;      
    ,self.proxid_level.city               := left.v_city_name       ; 
    ,self.proxid_level.state              := left.st                ;
    ,self.proxid_level.zip5               := left.zip               ; 
    ,self.proxid_level.county             := left.fips_state + left.fips_county ;
    // ,self.proxid_level.msa                := left.msa               ; 
    // ,self.proxid_level.err_stat           := left.err_stat          ;
    // ,self.proxid_level.age_of_company     := left.age_of_company    ; 
    // ,self.proxid_level.dt_first_seen      := left.dt_first_seen     ;
    // ,self.proxid_level.dt_last_seen       := left.dt_last_seen      ; 
    ,self.proxid_level.business_phone     := left.business_phone    ;
                                            
    ,self.seleid_level.business_name      := right.business_name     ;     
    ,self.seleid_level.business_address   := Address.Addr1FromComponents(right.prim_range ,right.predir  ,right.prim_name ,right.addr_suffix ,right.postdir ,right.unit_desig  ,right.sec_range)  ;      
    ,self.seleid_level.city               := right.v_city_name       ; 
    ,self.seleid_level.state              := right.st                ;
    ,self.seleid_level.zip5               := right.zip               ; 
    ,self.seleid_level.county             := right.fips_state + right.fips_county ;
    // ,self.seleid_level.msa                := right.msa               ; 
    // ,self.seleid_level.err_stat           := right.err_stat          ;
    // ,self.seleid_level.age_of_company     := right.age_of_company    ; 
    // ,self.seleid_level.dt_first_seen      := right.dt_first_seen     ;
    // ,self.seleid_level.dt_last_seen       := right.dt_last_seen      ; 
    ,self.seleid_level.business_phone     := right.business_phone    ;

    ,self                 := left
    ,self                 := []

  ),hash);

  ds_mrktg_list_base_proxid  := Marketing_List.Best_From_BIP_Base_Proxid  (%ds_base_best%   ,ds_mrktg_list_best_proxid );
  ds_mrktg_list_base_seleid  := Marketing_List.Best_From_BIP_Base_Seleid  (%ds_base_best%   ,ds_mrktg_list_best_seleid );

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

  ds_industry_codes   := Marketing_List.Best_Industry_Codes (%ds_base_best%   ,ds_mrktg_list_best_seleid );

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
                        );

  ds_both_best_both_base_plus_Industry_and_sales := join(ds_both_best_both_base_plus_Industry ,ds_best_emps_sales  ,left.seleid = right.seleid ,transform(recordof(left)
    ,self.seleid_level.number_of_employees  := right.number_of_employees
    ,self.seleid_level.annual_revenue       := right.annual_revenue
    ,self.seleid_level.src_revenue          := right.source
    ,self                                   := left
  ) ,hash ,left outer);
  
/*  
  ds_industry_codes   := Marketing_List.Best_Industry_Codes (ds_base_best   ,ds_mrktg_list_best );
  ds_best_emps_sales  := Marketing_List.Best_Sales_And_Employees(
                           pdca_base        
                          ,peq_biz_base     
                          ,poshair_base     
                          ,pcortera_base    
                          ,pinfutor_base    
                          ,paccutrend_base  
                          ,pEmployees_Ranking
                          ,pSales_Ranking    
                        );
                        
  ds_both := join(ds_mrktg_list_best  ,ds_mrktg_list_base ,left.proxid = right.proxid ,transform(recordof(left)
    ,self.msa             := right.msa
    ,self.err_stat        := right.err_stat
    ,self.age_of_company  := right.age_of_company
    ,self.dt_first_seen   := right.dt_first_seen
    ,self.dt_last_seen    := right.dt_last_seen
    ,self.business_email  := right.business_email
    ,self                 := left

  ),hash);

  ds_both_2 := join(ds_both ,ds_industry_codes  ,left.proxid = right.proxid ,transform(recordof(left)
    ,self.sics    := right.sics
    ,self.naicss  := right.naicss
    ,self         := left
  ) ,hash ,left outer);

  ds_add_emp := join(ds_both_2 ,ds_best_emps_sales  ,left.proxid = right.proxid ,transform(recordof(left)
    ,self.number_of_employees := right.number_of_employees
    ,self.sales               := right.sales
    ,self.src_sales           := right.source
    ,self                     := left
  ) ,hash ,left outer);

  outputdebug := parallel(
     output(choosen(ds_mrktg_list_base  ,300) ,named('ds_mrktg_list_base' ),all)
    ,output(choosen(ds_mrktg_list_best  ,300) ,named('ds_mrktg_list_best' ),all)
    ,output(choosen(ds_both             ,300) ,named('ds_both'            ),all)
    ,output(choosen(ds_both_2           ,300) ,named('ds_both_2'          ),all)
    ,output(choosen(ds_industry_codes   ,300) ,named('ds_industry_codes'  ),all)
    ,output(choosen(ds_add_emp          ,300) ,named('ds_add_emp'         ),all)
  );

  ds_return_result := project(ds_add_emp ,Marketing_List.Layouts.base);

  #IF(pDebug = true)
    return when(ds_return_result  ,outputdebug);
  #ELSE
    return ds_return_result;
  #END

*/
  return ds_both_best_both_base_plus_Industry_and_sales;
  
endmacro;