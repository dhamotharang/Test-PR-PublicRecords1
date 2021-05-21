/*
File 2 - Business Contact Information (LEXID not required) 

All business contact data is to be at the PROXID level

    SELEID – connect the person to the business
    PROXID
    LEXID
    EMPID
    First name
    Last name
    Title 
        Date First Seen
        Date Last Seen
    Title2
        Title2 Date First Seen
        Title2 Date Last Seen
    Title3
        Title3 Date First Seen
        Title3 Date Last Seen
    Title4
        Title4 Date First Seen
        Title4 Date Last Seen
    Title5
        Title5 Date First Seen
        Title5 Date Last Seen
    Person Hierarchy - allow the flexibility to return a single contact

The Business Contact Information will use the below logic for the person hierarchy and will return all unique contacts where a unique contact is first rolled up by LEXID if one exists and then if no LEXID exists rolled up by First Name, Last Name.

    A consumer has been seen at the business in the past 2 years
        Highest ranked title in current hierarchy of titles (used in the contact key build today)
        If no person on file with a title or a tie pick a consumer with the most recent last seen
    A consumer seen at the business outside of the past 2 years
        Highest ranked title in current hierarchy of titles (used in the contact key build today)
        If no person on file with a title or a tie pick a consumer with the most recent last seen

 

The general rule is to create a file at the PROXID Best level with Marketing Data. The service must search at the PROXID Best level that is restricted for marketing data.

*/
import dx_BestRecords,address;

EXPORT Create_Business_Contact_File(

   pversion                       = 'BIPV2.KeySuffix'
  ,pDataset_Crosswalk             = 'Marketing_List.Source_Files().crosswalk'
  ,pMrktg_BitMap                  = 'Marketing_List._Config().Marketing_Bitmap'
  ,pDataset_Business_Information  = 'Marketing_List.Files().business_information.built'
  ,pWatchdog_Best_Key             = 'Marketing_List.Source_Files().key_watchdog_best'
  ,pHeader_Segs_Key               = 'Marketing_List.Source_Files().key_Header_segs'
  ,pCounty_Names                  = 'Marketing_List.Source_Files().County_Names'
  ,pCity_Names                    = 'Marketing_List.Source_Files().City_names'
  ,pDebug                         = 'false'
  ,pSampleProxids                 = '[]'
  ,pQuickTest                     = 'false'                                                       // set to true to only use the seleids contained in the proxids passed in

// key watchdog marketing v2 key to get addresses for contacts with lexid
// address hiearchy key??  can do marketing permissions??  end of may they will have permissions....
// right now it is giving everything returned.  Cody can give me the interface I should be using


) :=
functionmacro

  import ut,header;
  
  mktg_bmap     := pMrktg_BitMap              ;
  #IF(pQuickTest = false)
  ds_crosswalk  := pDataset_Crosswalk           (proxid != 0  ,exists(contactNames((contact_name_permits & mktg_bmap) != 0)))   ;  //get proxid level, has to contain contacts
  #ELSE
  ds_crosswalk  := pDataset_Crosswalk           (proxid != 0  ,exists(contactNames((contact_name_permits & mktg_bmap) != 0))  ,proxid in pSampleProxids)   : persist('~persist::Marketing_List::Create_Business_Contact_File::ds_crosswalk') ;  //get proxid level, has to contain contacts
  #END
  ds_biz_info   := pDataset_Business_Information                                                                                ;  //use this to use only proxids that are in this file
  
  // -- only get contacts that are part of active businesses by joining to the business information file
  ds_active_proxids     := table(ds_biz_info  ,{proxid} ,proxid ,merge );
  ds_get_active_proxids := join(ds_crosswalk  ,ds_active_proxids  ,left.proxid = right.proxid ,transform({recordof(left) - contactSSNs - contactDOBs - contactPhones},self.jobtitles := project(left.jobtitles,transform(recordof(left),self.executive_ind_order := bipv2.bl_tables.Rank_ExecutiveTitles(left.job_title),self := left)),self := left)  ,hash);
 
  ds_prep := project(ds_get_active_proxids  ,transform(Marketing_List.Layouts.business_contact,
    eligible_contact_names          := left.contactnames((contact_name_permits & mktg_bmap) != 0);
    eligible_contact_names_sources  := table(eligible_contact_names  ,{source} ,source ,few);

    best_contact_name := topn(eligible_contact_names ,1                                                                                                     ,-dt_last_seen_at_business);
    job_titles        := topn(left.jobtitles   ((job_title_permits    & mktg_bmap) != 0) ,5 ,map(executive_ind_order = 0 and trim(job_title) = '' => 9999 ,executive_ind_order = 0 => 99  ,executive_ind_order + 1) ,-dt_title_last_seen      );

    // bipv2.bl_tables.executivetitles -- where the executive_ind_order comes from.  the contact key where the crosswalk gets this executive ind from does not look right.  some presidents and ceos are 99.  doens't make sense.
//	], {string position_title, integer order});

    contact_Addresses := choosen(left.contactAddresses   ((contact_address_permits    & mktg_bmap) != 0) ,1)[1]; //no date to use to get the latest
    contact_emails    := choosen(left.contactEmails      ((contact_email_permits      & mktg_bmap) != 0) ,1)[1]; //no date to use to get the latest

    contact_address := Address.Addr1FromComponents(contact_Addresses.prim_range ,contact_Addresses.predir ,contact_Addresses.prim_name  ,contact_Addresses.addr_suffix  ,contact_Addresses.postdir  ,contact_Addresses.unit_desig ,contact_Addresses.sec_range)  ;

    self.dt_first_seen        := left.dt_first_seen                     ;
    self.dt_last_seen         := left.dt_last_seen                      ;
    self.age                  := ut.age(left.dt_last_seen)              ;
    self.seleid               := left.seleid                            ;
    self.proxid               := left.proxid                            ;
    self.lexid                := left.contact_did                       ;
    self.empid                := left.empid                             ;
    self.fname                := regexreplace('[^[:print:]]' ,best_contact_name[1].fname ,'' ,nocase)   ;
    self.lname                := regexreplace('[^[:print:]]' ,best_contact_name[1].lname ,'' ,nocase)   ;
    self.src_name             := best_contact_name[1].source            ;
    self.name_sources         := count(eligible_contact_names_sources)  ;
    self.title                := job_titles[1].job_title                ;
    self.title_dt_first_seen  := job_titles[1].dt_title_first_seen      ;
    self.title_dt_last_seen   := job_titles[1].dt_title_first_seen      ;
    self.title2               := job_titles[2].job_title                ;
    self.title2_dt_first_seen := job_titles[2].dt_title_first_seen      ;
    self.title2_dt_last_seen  := job_titles[2].dt_title_first_seen      ;
    self.title3               := job_titles[3].job_title                ;
    self.title3_dt_first_seen := job_titles[3].dt_title_first_seen      ;
    self.title3_dt_last_seen  := job_titles[3].dt_title_first_seen      ;
    self.title4               := job_titles[4].job_title                ;
    self.title4_dt_first_seen := job_titles[4].dt_title_first_seen      ;
    self.title4_dt_last_seen  := job_titles[4].dt_title_first_seen      ;
    self.title5               := job_titles[5].job_title                ;
    self.title5_dt_first_seen := job_titles[5].dt_title_first_seen      ;
    self.title5_dt_last_seen  := job_titles[5].dt_title_first_seen      ;
    self.person_hierarchy     := if(job_titles[1].executive_ind_order = 0 and trim(self.title) = '' ,0  ,job_titles[1].executive_ind_order + 1)     ;
    self.executive_ind        := job_titles[1].executive_ind_order      ;
  
    self.contact_address        := contact_address                      ;
    self.city                   := contact_Addresses.v_city_name        ;
    self.state                  := contact_Addresses.st                 ;
    self.zip5                   := contact_Addresses.zip                ;
    self.county                 := ''                                   ; //no county on crosswalk file.  need to get this from base file
    self.county_name            := ''                                   ; //once get count info from bip base, join to county names file to get the county names
    self.contact_email_address  := Marketing_List.Validate_Email(contact_emails.contact_email)         ;

  ))(trim(fname) != '',trim(lname) != '');
  
  // -- remove contacts without seg categories and remove minors
  ds_prep_with_lexid     := ds_prep(lexid != 0);
  ds_prep_without_lexid  := ds_prep(lexid  = 0);

  ds_lexid_valid_segs_no_minors := join(ds_prep_with_lexid ,pHeader_Segs_Key ,left.lexid = right.did and trim(right.ind) in Marketing_List._Config().set_valid_lexid_segs and (ut.Age(right.dob) >= 18 and right.dob != 0) ,transform(left)  ,keyed);

  ds_concat_lexid_segs := ds_lexid_valid_segs_no_minors + ds_prep_without_lexid;

  // -- validate contact name conforms to rules
  ds_validate_contact_name := join(ds_concat_lexid_segs ,ds_biz_info ,left.proxid = right.proxid and Marketing_List.Validate_Contact_Name(left.fname,left.lname,right.proxid_level.business_name),transform(left)  ,hash);

  // -- dedup contacts by proxid and fname, lname, tie breaker goes to latest populated title_dt_last_seens, and if that is same, then prefer ones with lexid.
  ds_dist   := distribute (ds_validate_contact_name  ,hash(seleid,proxid));
  ds_sort   := sort       (ds_dist               ,     seleid,proxid  ,trim(fname) + trim(lname)   ,if(trim(title) != ''  ,1  ,2) ,-title_dt_last_seen   ,-dt_last_seen ,if(person_hierarchy = 0  ,9999 ,person_hierarchy) ,if(lexid != 0  ,1,2) ,lexid  ,local);
  ds_dedup  := dedup      (ds_sort               ,     seleid,proxid  ,trim(fname) + trim(lname)                                                                                                                                                         ,local);

/*  // -- sort contacts per proxid in person hierarchy order, set person hierarchy
  ds_sort2  := sort       (ds_dedup  ,seleid,proxid,map(age <= 2 and dt_last_seen != 0 => 1,age > 2 and dt_last_seen != 0 => 2  ,3) ,if(person_hierarchy = 0  ,9999 ,person_hierarchy) ,-title_dt_last_seen,-dt_last_seen,if(lexid != 0  ,1,2),lexid,lname,fname,local);
  ds_group  := group      (ds_sort2  ,seleid,proxid,local);
  ds_iterate := iterate(ds_group  ,transform(recordof(left)
    ,self.person_hierarchy := if(left.proxid = 0 ,1  ,left.person_hierarchy + 1)
    ,self                  := right
  
  ));
  
  // for contacts that do not have a title, set the person hierarchy to zero.
  ds_fix_hierarchy := project(ds_iterate  ,transform(Marketing_List.Layouts.business_contact,self.person_hierarchy := if(trim(left.title) != '' ,left.person_hierarchy  ,0) ,self := left ));
*/
  ds_fix_hierarchy_with_lexid     := ds_dedup(lexid != 0);
  ds_fix_hierarchy_without_lexid  := ds_dedup(lexid  = 0);

  // -----------------------------------------------------------------------------------
  // -- append address for lexid records
  ds_lexids_prep        := project(table(ds_fix_hierarchy_with_lexid ,{lexid} ,lexid ,merge) ,transform(doxie.layout_references  ,self.did := left.lexid));
  ds_lexids_append_addr := Marketing_List.Best_Contact_Address_By_Lexid(ds_lexids_prep,pWatchdog_Best_Key,pDebug);
  
  ds_get_lexid_addresses := join(ds_fix_hierarchy_with_lexid ,ds_lexids_append_addr  ,left.lexid = right.lexid ,transform(recordof(left),self := right,self := left ) ,left outer ,keep(1),hash);
  // -----------------------------------------------------------------------------------

  // -- concat records with lexid and records without lexid
  ds_concat_lexids := ds_get_lexid_addresses + ds_fix_hierarchy_without_lexid;

  ds_fix_hierarchy_with_address     := ds_concat_lexids(  trim(contact_address) != '' and trim(city) != '' and trim(state) != '' and trim(zip5) != ''  );
  ds_fix_hierarchy_without_address  := ds_concat_lexids(~(trim(contact_address) != '' and trim(city) != '' and trim(state) != '' and trim(zip5) != '' ));

  ds_append_county_info1 := join(ds_fix_hierarchy_with_address ,pCity_Names  ,left.city = right.city_name and left.state = right.state_alpha
    ,transform({string2 state_code,string3 county_code,recordof(left)}
      ,self.state_code  := right.state_code
      ,self.county_code := right.county_code
      ,self             := left
    ) 
    ,left outer,keep(1),hash);

  ds_append_county_info2 := join(ds_append_county_info1 ,pCounty_Names  ,left.state_code = right.state_code and left.county_code = right.county_code
    ,transform({recordof(left)}
      ,self.county      := right.state_code + right.county_code
      ,self.county_name := right.county_name
      ,self             := left
    ) 
    ,left outer,keep(1),hash);

  // blank out address fields if needed

  ds_concat_address := project(ds_append_county_info2  ,Marketing_List.Layouts.business_contact) + project(ds_fix_hierarchy_without_address ,Marketing_List.Layouts.business_contact);

  ds_blank_address_fields := project(ds_concat_address  ,transform(Marketing_List.Layouts.business_contact,
    is_any_address_field_blank_or_not_valid := 
      if(   trim(left.contact_address) = '' or trim(left.city) = '' or trim(left.state) = '' or trim(left.zip5) = '' 
        or ~Marketing_List.Validate_Address(left.contact_address ,left.city  ,left.state ,left.zip5)
          ,true 
          ,false
      );

    self.contact_address := if(~is_any_address_field_blank_or_not_valid ,left.contact_address  ,'');
    self.city            := if(~is_any_address_field_blank_or_not_valid ,left.city             ,'');
    self.state           := if(~is_any_address_field_blank_or_not_valid ,left.state            ,'');
    self.zip5            := if(~is_any_address_field_blank_or_not_valid ,left.zip5             ,'');
    self.county          := if(~is_any_address_field_blank_or_not_valid ,left.county           ,'');
    self.county_name     := if(~is_any_address_field_blank_or_not_valid ,left.county_name      ,'');
    self                 := left
  ));

  // -- set hiearchy at end after all fields have been set properly because set hiearchy uses the address fields
  ds_set_hierarchy := Marketing_List.Set_Hierarchy(ds_blank_address_fields);
  
  ds_result := project(ds_set_hierarchy ,Marketing_List.Layouts.business_contact );
  
  ds_stats := dataset([
    {'ds_crosswalk                    ' ,ut.fIntWithCommas(count(ds_crosswalk                     ))}
   ,{'ds_biz_info                     ' ,ut.fIntWithCommas(count(ds_biz_info                      ))}
   ,{'ds_active_proxids               ' ,ut.fIntWithCommas(count(ds_active_proxids                ))}
   ,{'ds_get_active_proxids           ' ,ut.fIntWithCommas(count(ds_get_active_proxids            ))}
   ,{'ds_prep                         ' ,ut.fIntWithCommas(count(ds_prep                          ))}
   ,{'ds_prep_with_lexid              ' ,ut.fIntWithCommas(count(ds_prep_with_lexid               ))}
   ,{'ds_prep_without_lexid           ' ,ut.fIntWithCommas(count(ds_prep_without_lexid            ))}
   ,{'ds_lexid_valid_segs_no_minors   ' ,ut.fIntWithCommas(count(ds_lexid_valid_segs_no_minors    ))}
   ,{'ds_concat_lexid_segs            ' ,ut.fIntWithCommas(count(ds_concat_lexid_segs             ))}
   ,{'ds_validate_contact_name        ' ,ut.fIntWithCommas(count(ds_validate_contact_name         ))}
   ,{'ds_dist                         ' ,ut.fIntWithCommas(count(ds_dist                          ))}
   ,{'ds_sort                         ' ,ut.fIntWithCommas(count(ds_sort                          ))}
   ,{'ds_dedup                        ' ,ut.fIntWithCommas(count(ds_dedup                         ))}
   // ,{'ds_sort2                        ' ,ut.fIntWithCommas(count(ds_sort2                         ))}
   // ,{'ds_group                        ' ,ut.fIntWithCommas(count(ds_group                         ))}
   // ,{'ds_iterate                      ' ,ut.fIntWithCommas(count(ds_iterate                       ))}
   // ,{'ds_fix_hierarchy                ' ,ut.fIntWithCommas(count(ds_fix_hierarchy                 ))}
   ,{'ds_fix_hierarchy_with_lexid     ' ,ut.fIntWithCommas(count(ds_fix_hierarchy_with_lexid      ))}
   ,{'ds_fix_hierarchy_without_lexid  ' ,ut.fIntWithCommas(count(ds_fix_hierarchy_without_lexid   ))}
   ,{'ds_lexids_prep                  ' ,ut.fIntWithCommas(count(ds_lexids_prep                   ))}
   ,{'ds_lexids_append_addr           ' ,ut.fIntWithCommas(count(ds_lexids_append_addr            ))}
   ,{'ds_get_lexid_addresses          ' ,ut.fIntWithCommas(count(ds_get_lexid_addresses           ))}
   ,{'ds_concat_lexids                ' ,ut.fIntWithCommas(count(ds_concat_lexids                 ))}
   ,{'ds_fix_hierarchy_with_address   ' ,ut.fIntWithCommas(count(ds_fix_hierarchy_with_address    ))}
   ,{'ds_fix_hierarchy_without_address' ,ut.fIntWithCommas(count(ds_fix_hierarchy_without_address ))}
   ,{'ds_append_county_info1          ' ,ut.fIntWithCommas(count(ds_append_county_info1           ))}
   ,{'ds_append_county_info2          ' ,ut.fIntWithCommas(count(ds_append_county_info2           ))}
   ,{'ds_concat_address               ' ,ut.fIntWithCommas(count(ds_concat_address                ))}
   ,{'ds_blank_address_fields         ' ,ut.fIntWithCommas(count(ds_blank_address_fields          ))}
   ,{'ds_set_hierarchy                ' ,ut.fIntWithCommas(count(ds_set_hierarchy                 ))}
   ,{'ds_result                       ' ,ut.fIntWithCommas(count(ds_result                        ))}
  
  ]  ,{string statname  ,string statvalue});


  // -- Optional Debug outputs
  output_debug := parallel(
    output('---------------------Marketing_List.Create_Business_Contact_File---------------------'                ,named('Marketing_List_Create_Business_Contact_File'                    ),all)
   ,output(ds_stats                                                                                               ,named('Create_Business_Contact_File_ds_stats'                          ),all)
   ,output(mktg_bmap                                                                                              ,named('Create_Business_Contact_File_mktg_bmap'                         ),all)
   ,output(choosen(ds_crosswalk                     (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_crosswalk'                      ),all)
   ,output(choosen(ds_biz_info                      (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_biz_info'                       ),all)
   ,output(choosen(ds_active_proxids                (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_active_proxids'                 ),all)
   ,output(choosen(ds_get_active_proxids            (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_get_active_proxids'             ),all)
   ,output(topn(ds_prep                          (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_prep'                           ),all)
   
   ,output(topn(ds_prep_with_lexid               (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_prep_with_lexid'                ),all)
   ,output(topn(ds_prep_without_lexid            (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_prep_without_lexid'             ),all)
   ,output(topn(ds_lexid_valid_segs_no_minors    (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_lexid_valid_segs_no_minors'     ),all)
   ,output(topn(ds_concat_lexid_segs             (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_concat_lexid_segs'              ),all)
   ,output(topn(ds_validate_contact_name         (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_validate_contact_name'          ),all)

   ,output(topn(ds_dist                          (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_dist'                           ),all)
   ,output(topn(ds_sort                          (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_sort'                           ),all)
   ,output(topn(ds_dedup                         (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_dedup'                          ),all)
   // ,output(choosen(ds_sort2                         (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_sort2'                          ),all)
   // ,output(choosen(ds_group                         (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_group'                          ),all)
   // ,output(choosen(ds_iterate                       (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_iterate'                        ),all)
   // ,output(choosen(ds_fix_hierarchy                 (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_fix_hierarchy'                  ),all)

   ,output(topn(ds_fix_hierarchy_with_lexid      (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_fix_hierarchy_with_lexid'       ),all)
   ,output(topn(ds_fix_hierarchy_without_lexid   (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_fix_hierarchy_without_lexid'    ),all)
   ,output(choosen(ds_lexids_prep                   /*(count(pSampleProxids) = 0 or proxid in pSampleProxids )*/,300) ,named('Create_Business_Contact_File_ds_lexids_prep'                ),all)
   ,output(choosen(ds_lexids_append_addr            /*(count(pSampleProxids) = 0 or proxid in pSampleProxids )*/,300) ,named('Create_Business_Contact_File_ds_lexids_append_addr'         ),all)
   ,output(topn(ds_get_lexid_addresses           (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_get_lexid_addresses'            ),all)
   ,output(topn(ds_concat_lexids                 (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_concat_lexids'                  ),all)
   ,output(topn(ds_fix_hierarchy_with_address    (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_fix_hierarchy_with_address'     ),all)
   ,output(topn(ds_fix_hierarchy_without_address (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_fix_hierarchy_without_address'  ),all)
   ,output(topn(ds_append_county_info1           (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_append_county_info1'            ),all)
   ,output(topn(ds_append_county_info2           (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_append_county_info2'            ),all)

   ,output(topn(ds_concat_address                (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_concat_address'                 ),all)
   ,output(topn(ds_blank_address_fields          (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_blank_address_fields'           ),all)
   ,output(topn(ds_set_hierarchy                 (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_set_hierarchy'                  ),all)

   ,output(topn(ds_result                        (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300,person_hierarchy) ,named('Create_Business_Contact_File_ds_return_result'                  ),all)
                                                                                                                  
  );

  #IF(pDebug = true)
    return when(ds_result  ,output_debug);
  #ELSE
    return ds_result;
  #END


endmacro;