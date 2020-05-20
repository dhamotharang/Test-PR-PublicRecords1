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
EXPORT Create_Business_Contact_File(

   pDataset_Crosswalk             = 'Marketing_List.Source_Files().crosswalk'
  ,pMrktg_BitMap                  = 'Marketing_List._Config().Marketing_Bitmap'
  ,pDataset_Business_Information  = 'Marketing_List.Files().business_information.built'
  ,pDebug                         = 'false'
  ,pSampleProxids                 = '[]'
  ,pQuickTest                     = 'false'                                                       // set to true to only use the seleids contained in the proxids passed in

// key watchdog marketing v2 key to get addresses for contacts with lexid
// address hiearchy key??  can do marketing permissions??  end of may they will have permissions....
// right now it is giving everything returned.  Cody can give me the interface I should be using


) :=
functionmacro

  import ut;
  
  mktg_bmap     := pMrktg_BitMap              ;
  #IF(pQuickTest = false)
  ds_crosswalk  := pDataset_Crosswalk           (proxid != 0  ,exists(contactNames((contact_name_permits & mktg_bmap) != 0)))   ;  //get proxid level, has to contain contacts
  #ELSE
  ds_crosswalk  := pDataset_Crosswalk           (proxid != 0  ,exists(contactNames((contact_name_permits & mktg_bmap) != 0))  ,proxid in pSampleProxids)   : persist('~persist::Marketing_List::Create_Business_Contact_File::ds_crosswalk') ;  //get proxid level, has to contain contacts
  #END
  ds_biz_info   := pDataset_Business_Information                                                                                ;  //use this to use only proxids that are in this file
  
  // -- only get contacts that are part of active businesses by joining to the business information file
  ds_active_proxids     := table(ds_biz_info  ,{proxid} ,proxid ,merge );
  ds_get_active_proxids := join(ds_crosswalk  ,ds_active_proxids  ,left.proxid = right.proxid ,transform({recordof(left) - contactSSNs - contactDOBs - contactPhones},self := left)  ,hash);
 
  ds_prep := project(ds_get_active_proxids  ,transform({unsigned4 Age ,unsigned executive_ind ,Marketing_List.Layouts.business_contact},
    best_contact_name := topn(left.contactnames((contact_name_permits & mktg_bmap) != 0) ,1                     ,-dt_last_seen_at_business);
    job_titles        := topn(left.jobtitles   ((job_title_permits    & mktg_bmap) != 0) ,5 ,executive_ind_order,-dt_title_last_seen      );

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
    self.fname                := best_contact_name[1].fname             ;
    self.lname                := best_contact_name[1].lname             ;
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
    self.person_hierarchy     := job_titles[1].executive_ind_order      ;
    self.executive_ind        := job_titles[1].executive_ind_order      ;
  
    self.contact_address        := contact_address                      ;
    self.city                   := contact_Addresses.v_city_name        ;
    self.state                  := contact_Addresses.st                 ;
    self.zip5                   := contact_Addresses.zip                ;
    self.county                 := ''                                   ; //no county on crosswalk file.  need to get this from base file
    self.county_name            := ''                                   ; //once get count info from bip base, join to county names file to get the county names
    self.contact_email_address  := contact_emails.contact_email         ;

  ))(trim(fname) != '',trim(lname) != '');
  
  // -- dedup contacts by proxid and fname, lname, tie breaker goes to latest populated title_dt_last_seens, and if that is same, then prefer ones with lexid.
  ds_dist   := distribute (ds_prep  ,hash(seleid,proxid));
  ds_sort   := sort       (ds_dist  ,     seleid,proxid  ,trim(fname) + trim(lname)   ,if(trim(title) != ''  ,1  ,2) ,-title_dt_last_seen   ,-dt_last_seen ,if(person_hierarchy = 0  ,9999 ,person_hierarchy) ,if(lexid != 0  ,1,2) ,lexid  ,local);
  ds_dedup  := dedup      (ds_sort  ,     seleid,proxid  ,trim(fname) + trim(lname)                                                                                                                                                         ,local);

  // -- sort contacts per proxid in person hierarchy order, set person hierarchy
  ds_sort2  := sort       (ds_dedup  ,seleid,proxid,map(age <= 2 and dt_last_seen != 0 => 1,age > 2 and dt_last_seen != 0 => 2  ,3) ,if(person_hierarchy = 0  ,9999 ,person_hierarchy) ,-title_dt_last_seen,-dt_last_seen,if(lexid != 0  ,1,2),lexid,lname,fname,local);
  ds_group  := group      (ds_sort2  ,seleid,proxid,local);
  ds_iterate := iterate(ds_group  ,transform(recordof(left)
    ,self.person_hierarchy := if(left.proxid = 0 ,1  ,left.person_hierarchy + 1)
    ,self                  := right
  
  ));
  
  // for contacts that do not have a title, set the person hierarchy to zero.
  ds_fix_hierarchy := project(ds_iterate  ,transform(Marketing_List.Layouts.business_contact,self.person_hierarchy := if(trim(left.title) != '' ,left.person_hierarchy  ,0) ,self := left ));

  ds_address_info     := table(ds_biz_info  ,{string70 business_address := proxid_level.business_address,string25 city := proxid_level.city ,string2  state := proxid_level.state ,string5  zip5  := proxid_level.zip5  ,string5  county  := proxid_level.county,string31 county_name := proxid_level.county_name}
  ,proxid_level.business_address,proxid_level.city ,proxid_level.state ,proxid_level.zip5  ,proxid_level.county ,proxid_level.county_name
  ,merge);

  ds_fix_hierarchy_with_address     := ds_fix_hierarchy(  trim(contact_address) != '' and trim(city) != '' and trim(state) != '' and trim(zip5) != ''  );
  ds_fix_hierarchy_without_address  := ds_fix_hierarchy(~(trim(contact_address) != '' and trim(city) != '' and trim(state) != '' and trim(zip5) != '' ));

  ds_append_county_info := join(ds_fix_hierarchy ,ds_address_info  ,left.contact_address = right.business_address and left.city = right.city and left.state = right.state and left.zip5 = right.zip5
    ,transform(recordof(left)
      ,self.county      := right.county
      ,self.county_name := right.county_name
      ,self             := left
    ) 
    ,left outer,keep(1),hash);

  ds_return_result := ds_append_county_info + ds_fix_hierarchy_without_address;

  // -- Optional Debug outputs
  output_debug := parallel(
    output('---------------------Marketing_List.Create_Business_Contact_File---------------------'                ,named('Marketing_List_Create_Business_Contact_File'                    ),all)
   ,output(mktg_bmap                                                                                              ,named('Create_Business_Contact_File_mktg_bmap'                         ),all)
   ,output(choosen(ds_crosswalk                     (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_crosswalk'                      ),all)
   ,output(choosen(ds_biz_info                      (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_biz_info'                       ),all)
   ,output(choosen(ds_active_proxids                (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_active_proxids'                 ),all)
   ,output(choosen(ds_get_active_proxids            (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_get_active_proxids'             ),all)
   ,output(choosen(ds_prep                          (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_prep'                           ),all)
   ,output(choosen(ds_dist                          (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_dist'                           ),all)
   ,output(choosen(ds_sort                          (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_sort'                           ),all)
   ,output(choosen(ds_dedup                         (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_dedup'                          ),all)
   ,output(choosen(ds_sort2                         (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_sort2'                          ),all)
   ,output(choosen(ds_group                         (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_group'                          ),all)
   ,output(choosen(ds_iterate                       (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_iterate'                        ),all)
   ,output(choosen(ds_fix_hierarchy                 (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_fix_hierarchy'                  ),all)
   ,output(choosen(ds_address_info                                                                          ,300) ,named('Create_Business_Contact_File_ds_address_info'                   ),all)
   ,output(choosen(ds_fix_hierarchy_with_address    (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_fix_hierarchy_with_address'     ),all)
   ,output(choosen(ds_fix_hierarchy_without_address (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_fix_hierarchy_without_address'  ),all)
   ,output(choosen(ds_append_county_info            (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_append_county_info'             ),all)
   ,output(choosen(ds_return_result                 (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_return_result'                  ),all)
                                                                                                                  
  );

  #IF(pDebug = true)
    return when(ds_return_result  ,output_debug);
  #ELSE
    return ds_return_result;
  #END


endmacro;