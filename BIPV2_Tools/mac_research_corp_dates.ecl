/*
  Run on hthor
  looks up the passed in corpkey and any other corpkeys that have the same name and address
  used to help with understanding the bug in the corp as header that rolls up across corpkeys when they have the 
  same name and address
*/
import corp2;

EXPORT mac_research_corp_dates(

   pCorpKey                                 //pass in the corpkey
  ,pDs_corpy      = 'Corp2.Key_Corp_Corpkey' 
  ,pDs_cont       = 'Corp2.Key_Cont_Corpkey' 
  ,pDs_events     = 'Corp2.Key_Event_Corpkey'
  ,pDs_ar         = 'Corp2.Key_AR_Corpkey'   
  ,pDs_corpy_name = 'Corp2.Key_Corp_NameAddr'

) :=
functionmacro

// lcorpkey := '26-654854';
// lcorpkey := '48-0801748034';
// lcorpkey := '01-820046';
// lcorpkey := '49-7253725-0111'; //had no dates on events or filing or status, but had inc date.  use inc date as last resort
// lcorpkey := '11-910524';  //no dates at all.  so we lose dates here
// lcorpkey := ['12-M14000007217','19-486568'];  //only foreign date, so check the foreign filing for more info. also use AR filing date 
// lcorpkey := ['11-843341'];  //cant figure out.  no relevant dates, no events, no ar
// lcorpkey := ['53-602723702'];  //lost date
// lcorpkey := ['31-1633506'];  //lost date
// lcorpkey := ['54-234792'];  //lost date
lcorpkey := pCorpKey;  
 

ds_corpy      := pDs_corpy     ;//corp2.Files().Base_xtnd.corp.qa;
ds_cont       := pDs_cont      ;
ds_events     := pDs_events    ;//corp2.Files().Base_xtnd.Events.qa;
ds_ar         := pDs_ar        ;//corp2.Files().Base_xtnd.ar.qa;
ds_corpy_name := pDs_corpy_name;

// -- get the corp records for that corpkey
ds_get_corpys := ds_corpy (corp_key = lcorpkey);

// -- get the names and addresses for that corpkey
set_cnames := set(table(ds_get_corpys,{corp_legal_name      },corp_legal_name     ,few),corp_legal_name     );
set_zips   := set(table(ds_get_corpys,{corp_addr1_zip5      },corp_addr1_zip5     ,few),corp_addr1_zip5     );
set_pnames := set(table(ds_get_corpys,{corp_addr1_prim_name },corp_addr1_prim_name,few),corp_addr1_prim_name);

ds_other_corpkeys := ds_corpy_name (corp_legal_name in set_cnames ,corp_addr1_zip5 in set_zips  ,corp_addr1_prim_name in set_pnames);

set_all_corpkeys := set(table(ds_other_corpkeys,{corp_key},corp_key,few),corp_key);

ds_corpy_filtered   := ds_corpy (corp_key in set_all_corpkeys);
ds_cont_filtered    := ds_cont  (corp_key in set_all_corpkeys);
ds_events_filtered  := ds_events(corp_key in set_all_corpkeys);
ds_ar_filtered      := ds_ar    (corp_key in set_all_corpkeys);

ds_corpy_slim   := table(ds_corpy_filtered  ,{corp_key ,corp_legal_name,corp_addr1_prim_range,corp_addr1_prim_name,corp_addr1_v_city_name,corp_addr1_zip5,dt_first_seen,dt_last_seen,dt_vendor_first_reported ,dt_vendor_last_reported  ,corp_status_desc,corp_filing_date,corp_status_date,corp_address1_effective_date,corp_address2_effective_date,corp_forgn_date,corp_inc_date});
ds_cont_slim    := table(ds_cont_filtered   ,{corp_key ,dt_first_seen,dt_last_seen,dt_vendor_first_reported ,dt_vendor_last_reported  ,cont_filing_date   ,cont_effective_date  ,cont_address_effective_date});
ds_events_slim  := table(ds_events_filtered ,{corp_key ,dt_first_seen,dt_last_seen,dt_vendor_first_reported ,dt_vendor_last_reported  ,event_date_type_cd ,event_date_type_desc ,event_filing_date          });
ds_ar_slim      := table(ds_ar_filtered     ,{corp_key ,dt_first_seen,dt_last_seen,dt_vendor_first_reported ,dt_vendor_last_reported  ,ar_filed_dt        ,ar_report_dt         ,ar_year                    });

return_result := parallel(
   output(topn(ds_corpy_slim  ,300,corp_key)  ,named('Corp'  ),all)
  ,output(topn(ds_cont_slim   ,300,corp_key)  ,named('Cont'  ),all)
  ,output(topn(ds_events_slim ,300,corp_key)  ,named('Events'),all)
  ,output(topn(ds_ar_slim     ,300,corp_key)  ,named('AR'    ),all)
);

return return_result;

// output(choosen(ds_events((integer)event_filing_date > (integer)stringlib.GetDateYYYYMMDD()),300),named('Future_Event_Examples'),all);
// output(topn(table(ds_events((integer)event_filing_date > (integer)stringlib.GetDateYYYYMMDD()) ,{event_date_type_cd,event_date_type_desc,unsigned cnt := count(group)} ,event_date_type_cd,event_date_type_desc,merge),1000,-cnt,event_date_type_cd,event_date_type_desc) ,named('event_future_dates'),all);

// output(topn(table(ds_events((integer)event_filing_date > (integer)stringlib.GetDateYYYYMMDD()) ,{event_filing_desc,unsigned cnt := count(group)} ,event_filing_desc,merge),1000,-cnt,event_filing_desc) ,named('event_future_dates_filing_desc'),all);

// layouttools := tools.macf_LayoutTools(recordof(ds_corpy)  ,false,'',true);

// ds_norm_corp := normalize(ds_corpy (corp_key in lcorpkey)  ,count(layouttools.setAllFields)  ,transform(
  // {string field_name  ,string field_value}
  // ,self.field_name  := layouttools.fGetFieldName(counter)
  // ,self.field_value := layouttools.fGetFieldValue(counter,left)
// ));

// output(ds_norm_corp(regexfind('(date|dt|status|filing)'  ,field_name + field_value,nocase)) ,named('ds_norm_corp'),all);
// output(ds_norm_corp(regexfind('(comment|cmt)'  ,field_name + field_value,nocase)) ,named('ds_norm_corp_comment'),all);

// layouttools_cont := tools.macf_LayoutTools(recordof(ds_cont)  ,false,'',true);

// ds_norm_cont := normalize(ds_cont (corp_key in lcorpkey)  ,count(layouttools_cont.setAllFields)  ,transform(
  // {string field_name  ,string field_value}
  // ,self.field_name  := layouttools_cont.fGetFieldName(counter)
  // ,self.field_value := layouttools_cont.fGetFieldValue(counter,left)
// ));

// output(ds_norm_cont(regexfind('(date|dt|status|filing)'  ,field_name + field_value,nocase)) ,named('ds_norm_cont'),all);

// ----
// slim_layout := tools.macf_LayoutTools(recordof(ds_corpy)  ,false,'(date|dt|status|filing|forgn|forei)',true);

// output(project(enth(ds_corpy (corp_forgn_date != '' and corp_filing_date = ''),300),slim_layout.layout_record)  ,named('foreign_not_filing'),all);
// output(count(ds_corpy (corp_forgn_date != '' and corp_filing_date = '') ) ,named('count_foreign_not_filing'),all);


// output(project(enth(ds_corpy (corp_forgn_date = '' and corp_filing_date != ''),300),slim_layout.layout_record)  ,named('filing_not_foreign'),all);
// output(count(ds_corpy (corp_forgn_date = '' and corp_filing_date != '') ) ,named('count_filing_not_foreign'),all);


// output(project(enth(ds_corpy (corp_forgn_date != '' and corp_filing_date != ''),300),slim_layout.layout_record)  ,named('both_filing_foreign'),all);
// output(count(ds_corpy (corp_forgn_date != '' and corp_filing_date != '') ) ,named('count_both_filing_foreign'),all);

// IA = 19
//BH SP MANAGER, L.L.C.                                                                                                                                                                                                                                                                                                                                         
//400 LOCUST ST SUITE 790                                               
// output(ds_corpy (corp_key[1..2] = '19',regexfind('BH SP MANAGER',corp_legal_name,nocase)  ,trim(corp_addr1_prim_range) = '400'  ,trim(corp_addr1_prim_name) = 'LOCUST')  ,named('IA_foreign_filing'),all);

endmacro;