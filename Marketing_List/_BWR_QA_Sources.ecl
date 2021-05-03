myseleid  := 1629;
pversion  := '20200729_LNK43990_test';

ds_mktng_biz_info     := Marketing_List.Files(pversion).business_information.logical(seleid = myseleid);
ds_mktng_biz_contact  := Marketing_List.Files(pversion).business_contact.logical    (seleid = myseleid);
ds_bip_best           := Marketing_List.Source_Files().bip_best           (seleid = myseleid);
ds_bip_base           := Marketing_List.Source_Files().bip_base           (seleid = myseleid  ,source in Marketing_List._Config().set_marketing_approved_sources);
ds_dca                := Marketing_List.Source_Files().dca                (seleid = myseleid  ,(integer)trim(rawfields.emp_num           )  > 0 or  (trim(rawfields.Sales ) != '' and regexfind('(revenue|sales)',rawfields.Sales_Desc,nocase)));
ds_eq_biz             := Marketing_List.Source_Files().eq_biz             (seleid = myseleid  ,(integer)trim(efx_corpempcnt              )  > 0 or  (trim(efx_corpamount  ) != '' and regexfind('(revenue|sales)',efx_corpamounttp     ,nocase)));
ds_oshair             := Marketing_List.Source_Files().oshair             (seleid = myseleid  ,(integer)Number_In_Establishment             > 0 );
ds_cortera            := Marketing_List.Source_Files().cortera            (seleid = myseleid  ,(integer)trim(TOTAL_EMPLOYEES             )  > 0 or   trim(TOTAL_SALES     ) != '');
ds_infutor            := Marketing_List.Source_Files().infutor            (seleid = myseleid  ,         trim(employee_code               ) != '');
ds_accutrend          := Marketing_List.Source_Files().accutrend          (seleid = myseleid  ,(integer)trim(rawfields.EMP_SIZE          )  > 0 );                                                                                                ;
ds_crosswalk2         := Marketing_List.Source_Files().crosswalk          (seleid = myseleid  );

key_watchdog_best     := Marketing_List.Source_Files().key_watchdog_best  ;  // contains did
key_header_segs       := Marketing_List.Source_Files().key_Header_segs    ;  //contains did

// ds_cortera_base_normexec2 := Cortera.proc_createExecutives(ds_cortera);
// ds_cortera_base_normexec2 := Cortera.Files.Executives(seleid = myseleid  ,(integer)trim(TOTAL_EMPLOYEES             )  > 0 or   trim(TOTAL_SALES     ) != '');

ds_best_slim := project(ds_bip_best  ,{recordof(left) - company_bdid - company_fein - company_url - company_incorporation_date - duns_number - dba_name - global_sid - record_sid});
ds_base_slim := table(ds_bip_base  ,{proxid,seleid,orgid,ultid,unsigned4 dt_first_seen := min(group,if(dt_first_seen = 0,99999999,dt_first_seen)),unsigned4 dt_last_seen := max(group,dt_last_seen),company_name, string address := Address.Addr1FromComponents(prim_range ,predir  ,prim_name ,addr_suffix ,postdir ,unit_desig  ,sec_range),v_city_name,st,zip,msa,err_stat}
,proxid,seleid,orgid,ultid,company_name, prim_range ,predir  ,prim_name ,addr_suffix ,postdir ,unit_desig  ,sec_range,v_city_name,st,zip,msa,err_stat
,merge);
ds_base_slim2 := project(ds_base_slim ,transform(recordof(left),self.dt_first_seen := if(left.dt_first_seen = 99999999  ,0  ,left.dt_first_seen)  ,self := left));


ds_dca_prep2       := table(ds_dca     ,{src_rid      ,unsigned6 dt_last_seen := (unsigned6)date_last_seen,string9 enterprise_num :=  rawfields.enterprise_num,Seleid,string9 emp_num := rawfields.emp_num ,string12 Sales := rawfields.Sales ,string50 Sales_Desc := rawfields.Sales_Desc  ,string12 Earnings := rawfields.Earnings});
ds_eq_biz_prep2    := table(ds_eq_biz  ,{rcid         ,unsigned6 dt_last_seen := (unsigned6)dt_last_seen,                             efx_id                  ,Seleid,string9 emp_num := efx_corpempcnt ,efx_corpamount /*in thousands*/ ,efx_corpamounttp  /*the type of amount  (revenue, sales, assets) in efx_locamount*/}); //
ds_oshair_prep2    := table(ds_oshair  ,{source_rec_id,unsigned6 dt_last_seen := (unsigned6)dt_last_seen,                             activity_number         ,Seleid,Number_In_Establishment }); // not used in sales calculations

ds_cortera_prep2   :=  table(
                      table(ds_cortera  ,{Seleid,link_id,unsigned6 source_rec_id := ((unsigned8)link_id << 32) | HASH32(name                    ,clean_phone  ,EXECUTIVE_NAME,Executive_Title)  ,unsigned6 dt_last_seen := (unsigned6)dt_last_seen,TOTAL_EMPLOYEES,TOTAL_SALES }) 
                    + table(ds_cortera  ,{Seleid,link_id,unsigned6 source_rec_id := ((unsigned8)link_id << 32) | HASH32(name                    ,clean_fax    ,EXECUTIVE_NAME,Executive_Title)  ,unsigned6 dt_last_seen := (unsigned6)dt_last_seen,TOTAL_EMPLOYEES,TOTAL_SALES })
                    + table(ds_cortera  ,{Seleid,link_id,unsigned6 source_rec_id := ((unsigned8)link_id << 32) | HASH32(alternate_business_name ,clean_phone  ,EXECUTIVE_NAME,Executive_Title)  ,unsigned6 dt_last_seen := (unsigned6)dt_last_seen,TOTAL_EMPLOYEES,TOTAL_SALES })
                    + table(ds_cortera  ,{Seleid,link_id,unsigned6 source_rec_id := ((unsigned8)link_id << 32) | HASH32(alternate_business_name ,clean_fax    ,EXECUTIVE_NAME,Executive_Title)  ,unsigned6 dt_last_seen := (unsigned6)dt_last_seen,TOTAL_EMPLOYEES,TOTAL_SALES })
                  ,{seleid,link_id,source_rec_id,dt_last_seen,TOTAL_EMPLOYEES,TOTAL_SALES}
                  ,seleid,link_id,source_rec_id,dt_last_seen,TOTAL_EMPLOYEES,TOTAL_SALES ,merge
                  )
                   ;

ds_infutor_prep2     := table(ds_infutor   ,{Seleid,rcid         ,unsigned6 dt_last_seen := (unsigned6)dt_last_seen,record_id  ,employee_code }); // not used in sales calculations
ds_accutrend_prep2   := table(ds_accutrend ,{Seleid,source_rec_id,unsigned6 dt_last_seen := (unsigned6)dt_last_seen,string2 state_code := rawfields.state_code,string4 filing_cod := rawfields.filing_cod,string20 filing_num := rawfields.filing_num  ,string9 emp_size := rawfields.EMP_SIZE }); // not used in sales calculations.

ds_crosswalk_slim := project(ds_crosswalk2 ,{recordof(left) - contactSSNs - contactDOBs - contactEmails - contactPhones - contactAddresses});

ds_watchdog_contacts_for_seleid := join(table(ds_mktng_biz_contact(lexid != 0),{lexid} ,lexid ,few)  ,key_watchdog_best  ,left.lexid = right.did ,transform(right)  ,keyed);
ds_header_segs_for_seleid       := join(table(ds_mktng_biz_contact(lexid != 0),{lexid} ,lexid ,few)  ,key_header_segs    ,left.lexid = right.did ,transform(right)  ,keyed);


output(myseleid                 ,named('Seleid'                  ));
output(ds_mktng_biz_info        ,named('Business_Information'),all);
// output(sort(ds_mktng_biz_contact  ,proxid,person_hierarchy)   ,named('Business_Contact'    ),all);
output(ds_best_slim             ,named('bip_best'            ),all);
output(ds_base_slim2            ,named('bip_base'            ),all);
output(ds_dca_prep2             ,named('dca'                 ),all);
output(ds_eq_biz_prep2          ,named('eq_biz'              ),all);              
output(ds_oshair_prep2          ,named('oshair'              ),all);             
output(ds_cortera_prep2         ,named('cortera'             ),all);
output(ds_infutor_prep2         ,named('infutor'             ),all);            
output(ds_accutrend_prep2       ,named('accutrend'           ),all);
output(ds_crosswalk_slim        ,named('crosswalk'           ),all);

// output(ds_watchdog_contacts_for_seleid  ,named('ds_watchdog_contacts_for_seleid'           ),all);
// output(ds_header_segs_for_seleid        ,named('ds_header_segs_for_seleid'                 ),all);

// output(Marketing_List.Create_Business_Contact_File    (pversion,ds_crosswalk2,Marketing_List._Config().Marketing_Bitmap,ds_mktng_biz_info,key_watchdog_best,key_header_segs,,,true,[myseleid]) ,named('Marketing_List_Create_Business_Contact_File_'),all);
// output(Marketing_List.Create_Business_Information_File(pversion ,ds_bip_best ,ds_bip_base  ,ds_dca ,ds_eq_biz  ,ds_oshair  ,ds_cortera ,ds_infutor ,ds_accutrend ,true ,[myseleid]) ,named('Marketing_List_Create_Business_Information_File_'),all);
