/*
  Get:
    number_of_employees
    sales              
    src_sales          

*/
import cortera,mdr;
EXPORT Best_Sales_And_Employees(
   pID                    = 'seleid'
  ,pdca_base              = 'Marketing_List.Source_Files().dca'                  
  ,peq_biz_base           = 'Marketing_List.Source_Files().eq_biz'               
  ,poshair_base           = 'Marketing_List.Source_Files().oshair'               
  ,pcortera_base          = 'Marketing_List.Source_Files().cortera'              
  ,pinfutor_base          = 'Marketing_List.Source_Files().infutor'              
  ,paccutrend_base        = 'Marketing_List.Source_Files().accutrend'            
  ,pEmployees_Ranking     = 'Marketing_List._Config().ds_sources_of_number_of_employees'
  ,pSales_Ranking         = 'Marketing_List._Config().ds_sources_of_sales_revenue'
  ,pDebug                 = 'false'
  ,pSampleSeleids         = '[]'


) :=
functionmacro

import cortera,mdr;

/*
1.	DCA – emp_num field = Number of Employees (61% pop)(rawfields.emp_num)
1.	DCA –    Sales = Sales amount (27% pop)(rawfields.sales_amount)
Sales_desc = Sales description (27% pop).  Sample values:  revenue, sales, interest income, billings, managed assets, premium, puberest income and none

*/
  ds_dca_base       := pdca_base              ;
  ds_eq_biz_base    := peq_biz_base           ;
  ds_oshair_base    := poshair_base           ;
  ds_cortera_base   := pcortera_base          ;
  ds_infutor_base   := pinfutor_base          ;
  ds_accutrend_base := paccutrend_base        ;

  // ds_cortera_base_normexec := Cortera.proc_createExecutives(ds_cortera_base)  : persist('~persist::Marketing_List::Get_Sales_And_Employees::ds_cortera_base_normexec'      );

  ds_dca_base_filt       := ds_dca_base                (pID != 0  ,(integer)trim(rawfields.emp_num           )  > 0 or  (trim(rawfields.Sales ) != '' and regexfind('(revenue|sales)',rawfields.Sales_Desc,nocase)));
  ds_eq_biz_base_filt    := ds_eq_biz_base             (pID != 0  ,(integer)trim(efx_corpempcnt              )  > 0 or  (trim(efx_corpamount  ) != '' and regexfind('(revenue|sales)',efx_corpamounttp     ,nocase)));
  ds_oshair_base_filt    := ds_oshair_base             (pID != 0  ,(integer)Number_In_Establishment             > 0 );
  ds_cortera_base_filt   := ds_cortera_base            (pID != 0  ,(integer)trim(TOTAL_EMPLOYEES             )  > 0 or   trim(TOTAL_SALES     ) != '');
  ds_infutor_base_filt   := ds_infutor_base            (pID != 0  ,         trim(employee_code               ) != '');
  ds_accutrend_base_filt := ds_accutrend_base          (pID != 0  ,(integer)trim(rawfields.EMP_SIZE          )  > 0 );                                                                                                      


  mapinfutoremp(string1 pempcode) := map(
     pempcode = 'A' => 3    // A = 1 to 4     //map to the midpoint of the range
    ,pempcode = 'B' => 7    // B = 5 to 9
    ,pempcode = 'C' => 15   // C = 10 to 19
    ,pempcode = 'D' => 35   // D = 20 to 49
    ,pempcode = 'E' => 75   // E = 50 to 99
    ,pempcode = 'F' => 175  // F = 100 to 249
    ,pempcode = 'G' => 375  // G = 250 to 499
    ,pempcode = 'H' => 750  // H = 500 to 999
    ,pempcode = 'I' => 2000 // I = Over 1000  
    ,                  0
  );

  ds_dca_prep       := table(ds_dca_base_filt     ,{src_rid      ,unsigned6 dt_last_seen := (unsigned6)date_last_seen,string9 enterprise_num :=  rawfields.enterprise_num,pID,string9 emp_num := rawfields.emp_num ,string12 Sales := rawfields.Sales ,string50 Sales_Desc := rawfields.Sales_Desc  ,string12 Earnings := rawfields.Earnings});
  ds_eq_biz_prep    := table(ds_eq_biz_base_filt  ,{rcid         ,unsigned6 dt_last_seen := (unsigned6)dt_last_seen,                             efx_id                  ,pID,string9 emp_num := efx_corpempcnt ,efx_corpamount /*in thousands*/ ,efx_corpamounttp  /*the type of amount  (revenue, sales, assets) in efx_locamount*/}); //
  ds_oshair_prep    := table(ds_oshair_base_filt  ,{source_rec_id,unsigned6 dt_last_seen := (unsigned6)dt_last_seen,                             activity_number         ,pID,Number_In_Establishment }); // not used in sales calculations

  ds_cortera_prep   :=  
                        table(ds_cortera_base_filt  ,{unsigned6 source_rec_id := ((unsigned8)link_id << 32) | HASH32(name                    ,clean_phone  ,EXECUTIVE_NAME,Executive_Title)  ,unsigned6 dt_last_seen := (unsigned6)dt_last_seen,link_id,pID,TOTAL_EMPLOYEES,TOTAL_SALES }) 
                      + table(ds_cortera_base_filt  ,{unsigned6 source_rec_id := ((unsigned8)link_id << 32) | HASH32(name                    ,clean_fax    ,EXECUTIVE_NAME,Executive_Title)  ,unsigned6 dt_last_seen := (unsigned6)dt_last_seen,link_id,pID,TOTAL_EMPLOYEES,TOTAL_SALES })
                      + table(ds_cortera_base_filt  ,{unsigned6 source_rec_id := ((unsigned8)link_id << 32) | HASH32(alternate_business_name ,clean_phone  ,EXECUTIVE_NAME,Executive_Title)  ,unsigned6 dt_last_seen := (unsigned6)dt_last_seen,link_id,pID,TOTAL_EMPLOYEES,TOTAL_SALES })
                      + table(ds_cortera_base_filt  ,{unsigned6 source_rec_id := ((unsigned8)link_id << 32) | HASH32(alternate_business_name ,clean_fax    ,EXECUTIVE_NAME,Executive_Title)  ,unsigned6 dt_last_seen := (unsigned6)dt_last_seen,link_id,pID,TOTAL_EMPLOYEES,TOTAL_SALES })
                      ;

  ds_infutor_prep     := table(ds_infutor_base_filt   ,{rcid         ,unsigned6 dt_last_seen := (unsigned6)dt_last_seen,record_id  ,pID,unsigned number_of_employees := mapinfutoremp(trim(employee_code)) }); // not used in sales calculations
  ds_accutrend_prep   := table(ds_accutrend_base_filt ,{source_rec_id,unsigned6 dt_last_seen := (unsigned6)dt_last_seen,string2 state_code := rawfields.state_code,string4 filing_cod := rawfields.filing_cod,string20 filing_num := rawfields.filing_num  ,pID,string9 emp_size := rawfields.EMP_SIZE }); // not used in sales calculations.
  
  ds_dca_table       := table(ds_dca_prep      ,{pID ,dt_last_seen,integer number_of_employees := max(group,(integer)emp_num                ) ,integer annual_revenue := max(group,(integer)sales                )   ,string2 source := mdr.sourcetools.src_DCA                  } ,pID ,dt_last_seen,merge) : persist('~persist::Marketing_List::Get_Sales_And_Employees::ds_dca_table'      );
  ds_eq_biz_table    := table(ds_eq_biz_prep   ,{pID ,dt_last_seen,integer number_of_employees := max(group,(integer)emp_num                ) ,integer annual_revenue := max(group,(integer)efx_corpamount * 1000)   ,string2 source := mdr.sourcetools.src_Equifax_Business_Data} ,pID ,dt_last_seen,merge) : persist('~persist::Marketing_List::Get_Sales_And_Employees::ds_eq_biz_table'   );
  ds_oshair_table    := table(ds_oshair_prep   ,{pID ,dt_last_seen,integer number_of_employees := max(group,(integer)Number_In_Establishment) ,integer annual_revenue := -1                                          ,string2 source := mdr.sourcetools.src_OSHAIR               } ,pID ,dt_last_seen,merge) : persist('~persist::Marketing_List::Get_Sales_And_Employees::ds_oshair_table'   );
  ds_cortera_table   := table(ds_cortera_prep  ,{pID ,dt_last_seen,integer number_of_employees := max(group,(integer)TOTAL_EMPLOYEES        ) ,integer annual_revenue := max(group,(integer)TOTAL_SALES          )   ,string2 source := mdr.sourcetools.src_Cortera              } ,pID ,dt_last_seen,merge) : persist('~persist::Marketing_List::Get_Sales_And_Employees::ds_cortera_table'  );
  ds_infutor_table   := table(ds_infutor_prep  ,{pID ,dt_last_seen,integer number_of_employees := max(group,(integer)number_of_employees    ) ,integer annual_revenue := -1                                          ,string2 source := mdr.sourcetools.src_Infutor_NARB         } ,pID ,dt_last_seen,merge) : persist('~persist::Marketing_List::Get_Sales_And_Employees::ds_infutor_table'  );
  ds_accutrend_table := table(ds_accutrend_prep,{pID ,dt_last_seen,integer number_of_employees := max(group,(integer)emp_size               ) ,integer annual_revenue := -1                                          ,string2 source := mdr.sourcetools.src_Business_Registration} ,pID ,dt_last_seen,merge) : persist('~persist::Marketing_List::Get_Sales_And_Employees::ds_accutrend_table');


  ds_concat := 
      ds_dca_table        
    + ds_eq_biz_table     
    + ds_oshair_table     
    + ds_cortera_table    
    + ds_infutor_table    
    + ds_accutrend_table  
    ;
  
  ds_add_emp_ranking   := join(ds_concat           ,pEmployees_Ranking ,left.source = right.source,transform({unsigned2 emp_rank_order            ,recordof(left)}  ,self.emp_rank_order            := right.rank_order,self := left) ,left outer,lookup);
  ds_add_sales_ranking := join(ds_add_emp_ranking  ,pSales_Ranking     ,left.source = right.source,transform({unsigned2 annual_revenue_rank_order ,recordof(left)}  ,self.annual_revenue_rank_order := right.rank_order,self := left) ,left outer,lookup);

  best_emp_seleid   := dedup(sort(distribute(ds_add_sales_ranking(number_of_employees > 0,emp_rank_order            > 0)  ,hash(pID))  ,pID,emp_rank_order           ,-dt_last_seen,-number_of_employees ,local) ,pID,local) : persist('~persist::Marketing_List::Get_Sales_And_Employees::best_emp_seleid'        );
  best_sales_seleid := dedup(sort(distribute(ds_add_sales_ranking(annual_revenue      > 0,annual_revenue_rank_order > 0)  ,hash(pID))  ,pID,annual_revenue_rank_order,-dt_last_seen,-annual_revenue      ,local) ,pID,local) : persist('~persist::Marketing_List::Get_Sales_And_Employees::best_sales_seleid'      );

  ds_out := join(best_emp_seleid  ,best_sales_seleid  ,left.pID = right.pID ,transform({recordof(left),string2 src_revenue,string2 src_employees}
    ,self.number_of_employees       := if(left.pID  != 0  ,left.number_of_employees  ,-1)
    ,self.emp_rank_order            := left.emp_rank_order
    ,self.src_employees             := left.source
    ,self.annual_revenue            := if(right.pID != 0  ,right.annual_revenue      ,-1)
    ,self.source                    := right.source
    ,self.src_revenue               := right.source
    ,self.annual_revenue_rank_order := right.annual_revenue_rank_order
    ,self.pID                       := if(left.pID != 0  ,left.pID            ,right.pID          )
    ,self.dt_last_seen              := if(left.pID != 0  ,left.dt_last_seen   ,right.dt_last_seen )
  )  ,hash ,full outer);
  
  ds_stats := dataset([
    {'ds_dca_base      '        ,count(ds_dca_base              )  ,count(table(ds_dca_base               ,{pID} ,pID ,merge))  ,count(ds_dca_base              )  - count(table(ds_dca_base               ,{pID} ,pID ,merge)),count(ds_dca_base              (pID = 0))}
   ,{'ds_eq_biz_base   '        ,count(ds_eq_biz_base           )  ,count(table(ds_eq_biz_base            ,{pID} ,pID ,merge))  ,count(ds_eq_biz_base           )  - count(table(ds_eq_biz_base            ,{pID} ,pID ,merge)),count(ds_eq_biz_base           (pID = 0))}
   ,{'ds_oshair_base   '        ,count(ds_oshair_base           )  ,count(table(ds_oshair_base            ,{pID} ,pID ,merge))  ,count(ds_oshair_base           )  - count(table(ds_oshair_base            ,{pID} ,pID ,merge)),count(ds_oshair_base           (pID = 0))}
   ,{'ds_cortera_base  '        ,count(ds_cortera_base          )  ,count(table(ds_cortera_base           ,{pID} ,pID ,merge))  ,count(ds_cortera_base          )  - count(table(ds_cortera_base           ,{pID} ,pID ,merge)),count(ds_cortera_base          (pID = 0))}
   ,{'ds_infutor_base  '        ,count(ds_infutor_base          )  ,count(table(ds_infutor_base           ,{pID} ,pID ,merge))  ,count(ds_infutor_base          )  - count(table(ds_infutor_base           ,{pID} ,pID ,merge)),count(ds_infutor_base          (pID = 0))}
   ,{'ds_accutrend_base'        ,count(ds_accutrend_base        )  ,count(table(ds_accutrend_base         ,{pID} ,pID ,merge))  ,count(ds_accutrend_base        )  - count(table(ds_accutrend_base         ,{pID} ,pID ,merge)),count(ds_accutrend_base        (pID = 0))}
   // ,{'ds_cortera_base_normexec' ,count(ds_cortera_base_normexec )  ,count(table(ds_cortera_base_normexec  ,{pID} ,pID ,merge))  ,count(ds_cortera_base_normexec )  - count(table(ds_cortera_base_normexec  ,{pID} ,pID ,merge)),count(ds_cortera_base_normexec (pID = 0))}
   ,{'ds_dca_base_filt      '   ,count(ds_dca_base_filt         )  ,count(table(ds_dca_base_filt          ,{pID} ,pID ,merge))  ,count(ds_dca_base_filt         )  - count(table(ds_dca_base_filt          ,{pID} ,pID ,merge)),count(ds_dca_base_filt         (pID = 0))}
   ,{'ds_eq_biz_base_filt   '   ,count(ds_eq_biz_base_filt      )  ,count(table(ds_eq_biz_base_filt       ,{pID} ,pID ,merge))  ,count(ds_eq_biz_base_filt      )  - count(table(ds_eq_biz_base_filt       ,{pID} ,pID ,merge)),count(ds_eq_biz_base_filt      (pID = 0))}
   ,{'ds_oshair_base_filt   '   ,count(ds_oshair_base_filt      )  ,count(table(ds_oshair_base_filt       ,{pID} ,pID ,merge))  ,count(ds_oshair_base_filt      )  - count(table(ds_oshair_base_filt       ,{pID} ,pID ,merge)),count(ds_oshair_base_filt      (pID = 0))}
   ,{'ds_cortera_base_filt  '   ,count(ds_cortera_base_filt     )  ,count(table(ds_cortera_base_filt      ,{pID} ,pID ,merge))  ,count(ds_cortera_base_filt     )  - count(table(ds_cortera_base_filt      ,{pID} ,pID ,merge)),count(ds_cortera_base_filt     (pID = 0))}
   ,{'ds_infutor_base_filt  '   ,count(ds_infutor_base_filt     )  ,count(table(ds_infutor_base_filt      ,{pID} ,pID ,merge))  ,count(ds_infutor_base_filt     )  - count(table(ds_infutor_base_filt      ,{pID} ,pID ,merge)),count(ds_infutor_base_filt     (pID = 0))}
   ,{'ds_accutrend_base_filt'   ,count(ds_accutrend_base_filt   )  ,count(table(ds_accutrend_base_filt    ,{pID} ,pID ,merge))  ,count(ds_accutrend_base_filt   )  - count(table(ds_accutrend_base_filt    ,{pID} ,pID ,merge)),count(ds_accutrend_base_filt   (pID = 0))}
   ,{'ds_dca_prep      '        ,count(ds_dca_prep              )  ,count(table(ds_dca_prep               ,{pID} ,pID ,merge))  ,count(ds_dca_prep              )  - count(table(ds_dca_prep               ,{pID} ,pID ,merge)),count(ds_dca_prep              (pID = 0))}
   ,{'ds_eq_biz_prep   '        ,count(ds_eq_biz_prep           )  ,count(table(ds_eq_biz_prep            ,{pID} ,pID ,merge))  ,count(ds_eq_biz_prep           )  - count(table(ds_eq_biz_prep            ,{pID} ,pID ,merge)),count(ds_eq_biz_prep           (pID = 0))}
   ,{'ds_oshair_prep   '        ,count(ds_oshair_prep           )  ,count(table(ds_oshair_prep            ,{pID} ,pID ,merge))  ,count(ds_oshair_prep           )  - count(table(ds_oshair_prep            ,{pID} ,pID ,merge)),count(ds_oshair_prep           (pID = 0))}
   ,{'ds_cortera_prep  '        ,count(ds_cortera_prep          )  ,count(table(ds_cortera_prep           ,{pID} ,pID ,merge))  ,count(ds_cortera_prep          )  - count(table(ds_cortera_prep           ,{pID} ,pID ,merge)),count(ds_cortera_prep          (pID = 0))}
   ,{'ds_infutor_prep  '        ,count(ds_infutor_prep          )  ,count(table(ds_infutor_prep           ,{pID} ,pID ,merge))  ,count(ds_infutor_prep          )  - count(table(ds_infutor_prep           ,{pID} ,pID ,merge)),count(ds_infutor_prep          (pID = 0))}
   ,{'ds_accutrend_prep'        ,count(ds_accutrend_prep        )  ,count(table(ds_accutrend_prep         ,{pID} ,pID ,merge))  ,count(ds_accutrend_prep        )  - count(table(ds_accutrend_prep         ,{pID} ,pID ,merge)),count(ds_accutrend_prep        (pID = 0))}
   ,{'ds_dca_table      '       ,count(ds_dca_table             )  ,count(table(ds_dca_table              ,{pID} ,pID ,merge))  ,count(ds_dca_table             )  - count(table(ds_dca_table              ,{pID} ,pID ,merge)),count(ds_dca_table             (pID = 0))}
   ,{'ds_eq_biz_table   '       ,count(ds_eq_biz_table          )  ,count(table(ds_eq_biz_table           ,{pID} ,pID ,merge))  ,count(ds_eq_biz_table          )  - count(table(ds_eq_biz_table           ,{pID} ,pID ,merge)),count(ds_eq_biz_table          (pID = 0))}
   ,{'ds_oshair_table   '       ,count(ds_oshair_table          )  ,count(table(ds_oshair_table           ,{pID} ,pID ,merge))  ,count(ds_oshair_table          )  - count(table(ds_oshair_table           ,{pID} ,pID ,merge)),count(ds_oshair_table          (pID = 0))}
   ,{'ds_cortera_table  '       ,count(ds_cortera_table         )  ,count(table(ds_cortera_table          ,{pID} ,pID ,merge))  ,count(ds_cortera_table         )  - count(table(ds_cortera_table          ,{pID} ,pID ,merge)),count(ds_cortera_table         (pID = 0))}
   ,{'ds_infutor_table  '       ,count(ds_infutor_table         )  ,count(table(ds_infutor_table          ,{pID} ,pID ,merge))  ,count(ds_infutor_table         )  - count(table(ds_infutor_table          ,{pID} ,pID ,merge)),count(ds_infutor_table         (pID = 0))}
   ,{'ds_accutrend_table'       ,count(ds_accutrend_table       )  ,count(table(ds_accutrend_table        ,{pID} ,pID ,merge))  ,count(ds_accutrend_table       )  - count(table(ds_accutrend_table        ,{pID} ,pID ,merge)),count(ds_accutrend_table       (pID = 0))}
   ,{'ds_concat'                ,count(ds_concat                )  ,count(table(ds_concat                 ,{pID} ,pID ,merge))  ,count(ds_concat                )  - count(table(ds_concat                 ,{pID} ,pID ,merge)),count(ds_concat                (pID = 0))}
   ,{'ds_add_emp_ranking  '     ,count(ds_add_emp_ranking       )  ,count(table(ds_add_emp_ranking        ,{pID} ,pID ,merge))  ,count(ds_add_emp_ranking       )  - count(table(ds_add_emp_ranking        ,{pID} ,pID ,merge)),count(ds_add_emp_ranking       (pID = 0))}
   ,{'ds_add_sales_ranking'     ,count(ds_add_sales_ranking     )  ,count(table(ds_add_sales_ranking      ,{pID} ,pID ,merge))  ,count(ds_add_sales_ranking     )  - count(table(ds_add_sales_ranking      ,{pID} ,pID ,merge)),count(ds_add_sales_ranking     (pID = 0))}
   ,{'best_emp_seleid  '        ,count(best_emp_seleid          )  ,count(table(best_emp_seleid           ,{pID} ,pID ,merge))  ,count(best_emp_seleid          )  - count(table(best_emp_seleid           ,{pID} ,pID ,merge)),count(best_emp_seleid          (pID = 0))}
   ,{'best_sales_seleid'        ,count(best_sales_seleid        )  ,count(table(best_sales_seleid         ,{pID} ,pID ,merge))  ,count(best_sales_seleid        )  - count(table(best_sales_seleid         ,{pID} ,pID ,merge)),count(best_sales_seleid        (pID = 0))}
   ,{'ds_out'                   ,count(ds_out                   )  ,count(table(ds_out                    ,{pID} ,pID ,merge))  ,count(ds_out                   )  - count(table(ds_out                    ,{pID} ,pID ,merge)),count(ds_out                   (pID = 0))}
   
  ]  ,{string stat  ,unsigned cnt_recs ,unsigned cnt_seleids  ,unsigned cnt_seleid_dups,unsigned cnt_zero_seleids});

  outputdebug := parallel(
    output('---------------------Marketing_List.Best_Sales_And_Employees---------------------'             ,named('Marketing_List_Best_Sales_And_Employees'          ),all)
   ,output(ds_stats                                                                                        ,named('ds_stats'                ))
   ,output('---------------------Marketing_List.Best_Sales_And_Employees Base Files---------------------'  ,named('Marketing_List_Best_Sales_And_Employees_Base'     ),all)
   ,output(topn(ds_dca_base             (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_dca_base'             ))
   ,output(topn(ds_eq_biz_base          (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_eq_biz_base'          ))
   ,output(topn(ds_oshair_base          (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_oshair_base'          ))
   ,output(topn(ds_cortera_base         (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_cortera_base'         ))
   ,output(topn(ds_infutor_base         (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_infutor_base'         ))
   ,output(topn(ds_accutrend_base       (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_accutrend_base'       ))

   ,output('---------------------Marketing_List.Best_Sales_And_Employees Base Filt Files---------------------'  ,named('Marketing_List_Best_Sales_And_Employees_Base_Filt'     ),all)
   ,output(topn(ds_dca_base_filt        (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_dca_base_filt'        ))
   ,output(topn(ds_eq_biz_base_filt     (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_eq_biz_base_filt'     ))
   ,output(topn(ds_oshair_base_filt     (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_oshair_base_filt'     ))
   ,output(topn(ds_cortera_base_filt    (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_cortera_base_filt'    ))
   ,output(topn(ds_infutor_base_filt    (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_infutor_base_filt'    ))
   ,output(topn(ds_accutrend_base_filt  (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_accutrend_base_filt'  ))

   ,output('---------------------Marketing_List.Best_Sales_And_Employees Prep Files---------------------'  ,named('Marketing_List_Best_Sales_And_Employees_Prep'     ),all)
   ,output(topn(ds_dca_prep             (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_dca_prep'             ))
   ,output(topn(ds_eq_biz_prep          (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_eq_biz_prep'          ))
   ,output(topn(ds_oshair_prep          (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_oshair_prep'          ))
   ,output(topn(ds_cortera_prep         (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_cortera_prep'         ))
   ,output(topn(ds_infutor_prep         (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_infutor_prep'         ))
   ,output(topn(ds_accutrend_prep       (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_accutrend_prep'       ))

   ,output('---------------------Marketing_List.Best_Sales_And_Employees Table Files---------------------'  ,named('Marketing_List_Best_Sales_And_Employees_Table'     ),all)
   ,output(topn(ds_dca_table            (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_dca_table'            ))
   ,output(topn(ds_eq_biz_table         (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_eq_biz_table'         ))
   ,output(topn(ds_oshair_table         (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_oshair_table'         ))
   ,output(topn(ds_cortera_table        (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_cortera_table'        ))
   ,output(topn(ds_infutor_table        (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_infutor_table'        ))
   ,output(topn(ds_accutrend_table      (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_accutrend_table'      ))

   ,output('---------------------Marketing_List.Best_Sales_And_Employees Final Files---------------------'  ,named('Marketing_List_Best_Sales_And_Employees_Final'     ),all)
   ,output(topn(ds_concat               (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_concat'               ))
   ,output(topn(ds_add_emp_ranking      (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_add_emp_ranking'      ))
   ,output(topn(ds_add_sales_ranking    (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_add_sales_ranking'    ))
   ,output(topn(best_emp_seleid         (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('best_emp_seleid'         ))
   ,output(topn(best_sales_seleid       (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('best_sales_seleid'       ))
   ,output(topn(ds_out                  (count(pSampleSeleids) = 0 or seleid in pSampleSeleids),100  ,pID) ,named('ds_out'                  ))

  );
  
  #IF(pDebug = true)
    return when(ds_out ,outputdebug);
  #ELSE
    return ds_out;
  #END

endmacro;