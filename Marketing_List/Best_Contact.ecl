/*
  Get:
    fname
    lname
    title
    lexid
    
*/
import Marketing_List;

EXPORT Best_Contact(

   pcontact_linkids_base        = 'Marketing_List.Source_Files().contacts_key'            
  ,pcontact_title_linkids_base  = 'Marketing_List.Source_Files().contact_Titles_key'      
  ,pMrktg_BitMap                = 'Marketing_List._Config().Marketing_Bitmap'
  ,pMrktg_Approved_Sources      = 'Marketing_List._Config().set_marketing_approved_sources'
  ,pDoSample                    = 'false'
  ,pDebug                       = 'false'
) := 
functionmacro

  ds_contact_linkids_base         := if(pDoSample   = false  ,pcontact_linkids_base      ,choosen(pcontact_linkids_base        ,5000))      ;
  ds_contact_title_linkids_base   := if(pDoSample   = false  ,pcontact_title_linkids_base,choosen(pcontact_title_linkids_base  ,5000))      ;

  mktg_bmap                       := pMrktg_BitMap              ;

  // -- filter for only marketing approved sources, contact title linkids with proxids, and has contacts after filtering for marketing
  ds_contact_linkids_base_filt   := ds_contact_linkids_base               (proxid != 0,source in pMrktg_Approved_Sources);
  ds_contact_title_linkids_filt  := project(ds_contact_title_linkids_base (proxid != 0,exists(contact_title((data_permits & mktg_bmap) != 0)))  ,transform(
    {unsigned6 proxid ,unsigned6 lexid  ,string50 title}
      ,best_contact_title_info := topn(left.contact_title((data_permits & mktg_bmap) != 0)  ,1,contact_title_rank)[1];  //get top person marketing approved
       self.proxid  := left.proxid                                      ;
       self.lexid   := best_contact_title_info.contact_did              ;
       self.title   := best_contact_title_info.contact_job_title_derived;  
  ));
  
  ds_contact_linkids_base_slim := table(ds_contact_linkids_base_filt  ,{proxid  ,unsigned6 lexid := contact_did  ,string20 fname := contact_name.fname  ,string20 lname :=  contact_name.lname  ,string50 title :=  contact_job_title_derived,executive_ind_order}
                                                                      , proxid  ,                   contact_did  ,                  contact_name.fname  ,                   contact_name.lname  ,                   contact_job_title_derived,executive_ind_order  ,merge);


  ds_contact_title_linkids_slim := table(ds_contact_title_linkids_filt  ,{proxid  ,lexid,title  } ,proxid  ,lexid,title ,merge);
 
  // -- for contact title linkids that have two or more contacts per proxid(contact title linkids key is not unique per proxid), we should join to contact linkids and grab the executive_ind_order to make decision on which to keep
  ds_get_best_title       := join(ds_contact_title_linkids_slim ,ds_contact_linkids_base_slim(lexid != 0) ,left.proxid = right.proxid and left.lexid = right.lexid  ,transform({recordof(left),ds_contact_linkids_base_slim.executive_ind_order},self := left,self := right),keep(1),left outer  ,hash);
  ds_get_best_title_table := dedup(sort(distribute(ds_get_best_title  ,hash(proxid))  ,proxid,if(executive_ind_order = 0  ,9999,executive_ind_order)  ,title  ,local) ,proxid,local);
  
  // -- join contact linkids to contact_title on proxid and lexid.  for the ones that match, that is the contact for that proxid.
  // -- for the ones that don't match, and the ones without lexid, 
  ds_contact_linkids_get_best_contact_by_title          := join(ds_contact_linkids_base_slim ,ds_get_best_title_table                                                   ,left.proxid = right.proxid and left.lexid = right.lexid  ,transform(recordof(left),self.title := right.title,self := left),hash);
  ds_contact_linkids_get_best_contact_by_title_nomatch  := join(ds_contact_linkids_base_slim ,table(ds_contact_linkids_get_best_contact_by_title,{proxid},proxid,merge) ,left.proxid = right.proxid                               ,transform(left) ,left only ,hash);

  ds_contact_linkids_get_best_contact_by_title_table         := dedup(sort(distribute(ds_contact_linkids_get_best_contact_by_title          ,hash(proxid))  ,proxid,if(executive_ind_order = 0  ,9999,executive_ind_order)  ,lexid,title  ,local) ,proxid,local);
  ds_contact_linkids_get_best_contact_by_title_nomatch_table := dedup(sort(distribute(ds_contact_linkids_get_best_contact_by_title_nomatch  ,hash(proxid))  ,proxid,if(executive_ind_order = 0  ,9999,executive_ind_order)  ,lexid,title  ,local) ,proxid,local);


  ds_contacts_out := ds_contact_linkids_get_best_contact_by_title_table + ds_contact_linkids_get_best_contact_by_title_nomatch_table  : persist('~persist::Marketing_List::Get_Contacts::ds_contacts_out'      );

  ds_stats := dataset([
    {'ds_contact_linkids_base                                     '  ,count(ds_contact_linkids_base                                     ) ,count(table(ds_contact_linkids_base                                    ,{proxid} ,proxid ,merge)) ,count(ds_contact_linkids_base                                     (proxid = 0)),count(ds_contact_linkids_base                                   ) - count(table(ds_contact_linkids_base                                   ,{proxid} ,proxid ,merge))}
   ,{'ds_contact_title_linkids_base                               '  ,count(ds_contact_title_linkids_base                               ) ,count(table(ds_contact_title_linkids_base                              ,{proxid} ,proxid ,merge)) ,count(ds_contact_title_linkids_base                               (proxid = 0)),count(ds_contact_title_linkids_base                             ) - count(table(ds_contact_title_linkids_base                             ,{proxid} ,proxid ,merge))}
   ,{'ds_contact_linkids_base_filt                                '  ,count(ds_contact_linkids_base_filt                                ) ,count(table(ds_contact_linkids_base_filt                               ,{proxid} ,proxid ,merge)) ,count(ds_contact_linkids_base_filt                                (proxid = 0)),count(ds_contact_linkids_base_filt                              ) - count(table(ds_contact_linkids_base_filt                              ,{proxid} ,proxid ,merge))}
   ,{'ds_contact_title_linkids_filt                               '  ,count(ds_contact_title_linkids_filt                               ) ,count(table(ds_contact_title_linkids_filt                              ,{proxid} ,proxid ,merge)) ,count(ds_contact_title_linkids_filt                               (proxid = 0)),count(ds_contact_title_linkids_filt                             ) - count(table(ds_contact_title_linkids_filt                             ,{proxid} ,proxid ,merge))}
   ,{'ds_contact_linkids_base_slim                                '  ,count(ds_contact_linkids_base_slim                                ) ,count(table(ds_contact_linkids_base_slim                               ,{proxid} ,proxid ,merge)) ,count(ds_contact_linkids_base_slim                                (proxid = 0)),count(ds_contact_linkids_base_slim                              ) - count(table(ds_contact_linkids_base_slim                              ,{proxid} ,proxid ,merge))}
   ,{'ds_contact_title_linkids_slim                               '  ,count(ds_contact_title_linkids_slim                               ) ,count(table(ds_contact_title_linkids_slim                              ,{proxid} ,proxid ,merge)) ,count(ds_contact_title_linkids_slim                               (proxid = 0)),count(ds_contact_title_linkids_slim                             ) - count(table(ds_contact_title_linkids_slim                             ,{proxid} ,proxid ,merge))}
   ,{'ds_get_best_title                                           '  ,count(ds_get_best_title                                           ) ,count(table(ds_get_best_title                                          ,{proxid} ,proxid ,merge)) ,count(ds_get_best_title                                           (proxid = 0)),count(ds_get_best_title                                         ) - count(table(ds_get_best_title                                         ,{proxid} ,proxid ,merge))}
   ,{'ds_get_best_title_table                                     '  ,count(ds_get_best_title_table                                     ) ,count(table(ds_get_best_title_table                                    ,{proxid} ,proxid ,merge)) ,count(ds_get_best_title_table                                     (proxid = 0)),count(ds_get_best_title_table                                   ) - count(table(ds_get_best_title_table                                   ,{proxid} ,proxid ,merge))}
   ,{'ds_contact_linkids_get_best_contact_by_title                '  ,count(ds_contact_linkids_get_best_contact_by_title                ) ,count(table(ds_contact_linkids_get_best_contact_by_title               ,{proxid} ,proxid ,merge)) ,count(ds_contact_linkids_get_best_contact_by_title                (proxid = 0)),count(ds_contact_linkids_get_best_contact_by_title              ) - count(table(ds_contact_linkids_get_best_contact_by_title              ,{proxid} ,proxid ,merge))}
   ,{'ds_contact_linkids_get_best_contact_by_title_nomatch        '  ,count(ds_contact_linkids_get_best_contact_by_title_nomatch        ) ,count(table(ds_contact_linkids_get_best_contact_by_title_nomatch       ,{proxid} ,proxid ,merge)) ,count(ds_contact_linkids_get_best_contact_by_title_nomatch        (proxid = 0)),count(ds_contact_linkids_get_best_contact_by_title_nomatch      ) - count(table(ds_contact_linkids_get_best_contact_by_title_nomatch      ,{proxid} ,proxid ,merge))}
   ,{'ds_contact_linkids_get_best_contact_by_title_table          '  ,count(ds_contact_linkids_get_best_contact_by_title_table          ) ,count(table(ds_contact_linkids_get_best_contact_by_title_table         ,{proxid} ,proxid ,merge)) ,count(ds_contact_linkids_get_best_contact_by_title_table          (proxid = 0)),count(ds_contact_linkids_get_best_contact_by_title_table        ) - count(table(ds_contact_linkids_get_best_contact_by_title_table        ,{proxid} ,proxid ,merge))}
   ,{'ds_contact_linkids_get_best_contact_by_title_nomatch_table  '  ,count(ds_contact_linkids_get_best_contact_by_title_nomatch_table  ) ,count(table(ds_contact_linkids_get_best_contact_by_title_nomatch_table ,{proxid} ,proxid ,merge)) ,count(ds_contact_linkids_get_best_contact_by_title_nomatch_table  (proxid = 0)),count(ds_contact_linkids_get_best_contact_by_title_nomatch_table) - count(table(ds_contact_linkids_get_best_contact_by_title_nomatch_table,{proxid} ,proxid ,merge))}
   ,{'ds_contacts_out                                             '  ,count(ds_contacts_out                                             ) ,count(table(ds_contacts_out                                            ,{proxid} ,proxid ,merge)) ,count(ds_contacts_out                                             (proxid = 0)),count(ds_contacts_out                                           ) - count(table(ds_contacts_out                                           ,{proxid} ,proxid ,merge))}
  ]  ,{string stat  ,unsigned records ,unsigned proxids ,unsigned zero_proxids,integer dups});                                                                                                                                                                                                                  

  outputdebug := parallel(
    output(ds_stats ,named('ds_stats'))
   ,output(topn(ds_contact_linkids_base                                     ,100  ,proxid) ,named('ds_contact_linkids_base'                                   ))
   ,output(topn(ds_contact_title_linkids_base                               ,100  ,proxid) ,named('ds_contact_title_linkids_base'                             ))
   ,output(topn(ds_contact_linkids_base_filt                                ,100  ,proxid) ,named('ds_contact_linkids_base_filt'                              ))
   ,output(topn(ds_contact_title_linkids_filt                               ,100  ,proxid) ,named('ds_contact_title_linkids_filt'                             ))
   ,output(topn(ds_contact_linkids_base_slim                                ,100  ,proxid) ,named('ds_contact_linkids_base_slim'                              ))
   ,output(topn(ds_contact_title_linkids_slim                               ,100  ,proxid) ,named('ds_contact_title_linkids_slim'                             ))
   ,output(topn(ds_get_best_title                                           ,100  ,proxid) ,named('ds_get_best_title'                                         ))
   ,output(topn(ds_get_best_title_table                                     ,100  ,proxid) ,named('ds_get_best_title_table'                                   ))
   ,output(topn(ds_contact_linkids_get_best_contact_by_title                ,100  ,proxid) ,named('ds_contact_linkids_get_best_contact_by_title'              ))
   ,output(topn(ds_contact_linkids_get_best_contact_by_title_nomatch        ,100  ,proxid) ,named('ds_contact_linkids_get_best_contact_by_title_nomatch'      ))
   ,output(topn(ds_contact_linkids_get_best_contact_by_title_table          ,100  ,proxid) ,named('ds_contact_linkids_get_best_contact_by_title_table'        ))
   ,output(topn(ds_contact_linkids_get_best_contact_by_title_nomatch_table  ,100  ,proxid) ,named('ds_contact_linkids_get_best_contact_by_title_nomatch_table'))
   ,output(topn(ds_contacts_out                                             ,100  ,proxid) ,named('ds_contacts_out'                                           ))
  
  );

  #IF(pDebug = true)
    return when(ds_contacts_out ,outputdebug);
  #ELSE
    return ds_contacts_out;
  #END
  

endmacro;