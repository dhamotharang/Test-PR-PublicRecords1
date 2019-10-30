// -- copied from Create_Business_Information_File so far.
/*
1.	A consumer has been seen at the business in the past 2 years 
    a.	Highest ranked title in current hierarchy of titles (used in the contact key build today) 
    b.	If no person on file with a title or a tie pick a consumer with the most recent last seen 
2.	A consumer seen at the business outside of the past 2 years 
    a.	Highest ranked title in current hierarchy of titles (used in the contact key build today) 
    b.	If no person on file with a title or a tie pick a consumer with the most recent last seen

*/
EXPORT Create_Business_Contact_File(

   pDataset_Best                = 'Marketing_List.Source_Files().bip_best'
  ,pDataset_Base                = 'Marketing_List.Source_Files().bip_base'
  ,pdca_base                    = 'Marketing_List.Source_Files().dca'                  
  ,peq_biz_base                 = 'Marketing_List.Source_Files().eq_biz'               
  ,poshair_base                 = 'Marketing_List.Source_Files().oshair'               
  ,pcortera_base                = 'Marketing_List.Source_Files().cortera'              
  ,pinfutor_base                = 'Marketing_List.Source_Files().infutor'              
  ,paccutrend_base              = 'Marketing_List.Source_Files().accutrend'            
  ,pcontact_linkids_base        = 'Marketing_List.Source_Files().contacts_key'            
  ,pcontact_title_linkids_base  = 'Marketing_List.Source_Files().contact_Titles_key'      
  ,pEmployees_Ranking           = 'Marketing_List._Config().ds_sources_of_number_of_employees'
  ,pSales_Ranking               = 'Marketing_List._Config().ds_sources_of_sales_revenue'
  ,pMrktg_BitMap                = 'Marketing_List._Config().Marketing_Bitmap'
  ,pMrktg_Approved_Sources      = 'Marketing_List._Config().set_marketing_approved_sources'
  ,pDoSample                    = 'false'
  ,pDebug                       = 'false'


) :=
functionmacro

  ds_best       := pDataset_Best(proxid != 0) ;
  ds_base_best  := pDataset_Base              ;
  // ds_base := topn(ds_base_best                ,20000  ,proxid) : persist('~persist::lbentley::BH687::ds_base');

  ds_mrktg_list_best  := Marketing_List.Best_From_BIP_Best  (ds_best        ,ds_base_best       );
  ds_mrktg_list_base  := Marketing_List.Best_From_BIP_Base  (ds_base_best   ,ds_mrktg_list_best );
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
  // ds_best_contacts    := Marketing_List.Best_Contact(
                           // pcontact_linkids_base      
                          // ,pcontact_title_linkids_base
                          // ,pMrktg_BitMap              
                          // ,pMrktg_Approved_Sources      
  // );

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

  // ds_add_contacts := join(ds_add_emp ,ds_best_contacts  ,left.proxid = right.proxid ,transform(recordof(left)
    // ,self.fname := right.fname
    // ,self.lname := right.lname
    // ,self.title := right.title
    // ,self.lexid := right.lexid
    // ,self       := left
  // ) ,hash ,left outer);

  output(choosen(ds_mrktg_list_base ,300),named('ds_mrktg_list_base'),all);
  output(choosen(ds_mrktg_list_best ,300),named('ds_mrktg_list_best'),all);
  output(choosen(ds_both  ,300)  ,named('ds_both'),all);
  output(choosen(ds_both_2  ,300)  ,named('ds_both_2'),all);
  output(choosen(ds_industry_codes ,300),named('ds_industry_codes'),all);
  output(choosen(ds_add_emp  ,300)  ,named('ds_add_emp'),all);
  // output(choosen(ds_add_contacts  ,300)  ,named('ds_add_contacts'),all);

  ds_return_result := project(ds_add_emp ,Marketing_List.Layouts.base);

  return ds_return_result;


endmacro;