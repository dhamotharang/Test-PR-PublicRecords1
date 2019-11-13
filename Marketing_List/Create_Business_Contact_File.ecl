// -- copied from Create_Business_Information_File so far.
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


) :=
functionmacro

  import ut;
  
  mktg_bmap     := pMrktg_BitMap              ;
  ds_crosswalk  := pDataset_Crosswalk           (proxid != 0  ,exists(contactNames((contact_name_permits & mktg_bmap) != 0)))   ;  //get proxid level, has to contain contacts
  ds_biz_info   := pDataset_Business_Information                                                                                ;  //use this to use only proxids that are in this file
  
  ds_active_proxids := table(ds_biz_info  ,{proxid} ,proxid ,merge);
  
  ds_get_active_proxids := join(ds_crosswalk  ,ds_active_proxids  ,left.proxid = right.proxid ,transform({recordof(left) - contactSSNs - contactDOBs - contactEmails - contactPhones - contactAddresses},self := left)  ,hash);

  ds_prep := project(ds_get_active_proxids  ,transform({unsigned4 dt_last_seen  ,unsigned4 Age ,unsigned executive_ind ,Marketing_List.Layouts.business_contact},
    best_contact_name := topn(left.contactnames((contact_name_permits & mktg_bmap) != 0) ,1                     ,-dt_last_seen_at_business);
    job_titles        := topn(left.jobtitles   ((job_title_permits    & mktg_bmap) != 0) ,5 ,executive_ind_order,-dt_title_last_seen      );

    self.dt_last_seen         := left.dt_last_seen                      ;
    self.age                  := ut.age(left.dt_last_seen)              ;
    self.seleid               := left.seleid                            ;
    self.proxid               := left.proxid                            ;
    self.lexid                := left.contact_did                       ;
    self.empid                := left.empid                             ;
    self.fname                := best_contact_name[1].fname             ;
    self.lname                := best_contact_name[1].lname             ;
    self.title                := job_titles[1].job_title            ;
    self.title_dt_first_seen  := job_titles[1].dt_title_first_seen  ;
    self.title_dt_last_seen   := job_titles[1].dt_title_first_seen  ;
    self.title2               := job_titles[2].job_title            ;
    self.title2_dt_first_seen := job_titles[2].dt_title_first_seen  ;
    self.title2_dt_last_seen  := job_titles[2].dt_title_first_seen  ;
    self.title3               := job_titles[3].job_title            ;
    self.title3_dt_first_seen := job_titles[3].dt_title_first_seen  ;
    self.title3_dt_last_seen  := job_titles[3].dt_title_first_seen  ;
    self.title4               := job_titles[4].job_title            ;
    self.title4_dt_first_seen := job_titles[4].dt_title_first_seen  ;
    self.title4_dt_last_seen  := job_titles[4].dt_title_first_seen  ;
    self.title5               := job_titles[5].job_title            ;
    self.title5_dt_first_seen := job_titles[5].dt_title_first_seen  ;
    self.title5_dt_last_seen  := job_titles[5].dt_title_first_seen  ;
    self.person_hierarchy     := job_titles[1].executive_ind_order  ;
    self.executive_ind        := job_titles[1].executive_ind_order  ;
  
  ))(trim(fname) != '',trim(lname) != '');
  
  ds_dist   := distribute (ds_prep  ,hash(seleid,proxid));
  ds_sort   := sort       (ds_dist  ,seleid,proxid,if(lexid != 0  ,'LEXID' + '-' + (string)lexid  ,trim(fname) + trim(lname)) ,-dt_last_seen ,local);
  ds_dedup  := dedup      (ds_sort  ,seleid,proxid,if(lexid != 0  ,'LEXID' + '-' + (string)lexid  ,trim(fname) + trim(lname)) ,local);
  
  ds_sort2  := sort       (ds_dedup  ,seleid,proxid,map(age <= 2 and dt_last_seen != 0 => 1,age > 2 and dt_last_seen != 0 => 2  ,3) ,if(person_hierarchy = 0  ,9999 ,person_hierarchy) ,-dt_last_seen,if(lexid != 0  ,1,2),lexid,lname,fname,local);
  ds_group  := group      (ds_sort2  ,seleid,proxid,local);
  ds_iterate := iterate(ds_group  ,transform(recordof(left)
    ,self.person_hierarchy := if(left.proxid = 0 ,1  ,left.person_hierarchy + 1)
    ,self                  := right
  
  ));
  
  ds_return_result_contact := project(ds_iterate  ,Marketing_List.Layouts.business_contact);

  output_debug := parallel(
    output('---------------------Marketing_List.Create_Business_Contact_File---------------------'        ,named('Marketing_List_Create_Business_Contact_File'        ),all)
   ,output(mktg_bmap                                                                                      ,named('Create_Business_Contact_File_mktg_bmap'             ),all)
   ,output(choosen(ds_crosswalk             (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_crosswalk'          ),all)
   ,output(choosen(ds_biz_info              (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_biz_info'           ),all)
   ,output(choosen(ds_active_proxids        (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_active_proxids'     ),all)
   ,output(choosen(ds_get_active_proxids    (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_get_active_proxids' ),all)
   ,output(choosen(ds_prep                  (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_prep'               ),all)
   ,output(choosen(ds_dist                  (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_dist'               ),all)
   ,output(choosen(ds_sort                  (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_sort'               ),all)
   ,output(choosen(ds_dedup                 (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_dedup'              ),all)
   ,output(choosen(ds_sort2                 (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_sort2'              ),all)
   ,output(choosen(ds_group                 (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_group'              ),all)
   ,output(choosen(ds_iterate               (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_iterate'            ),all)
   ,output(choosen(ds_return_result_contact (count(pSampleProxids) = 0 or proxid in pSampleProxids ),300) ,named('Create_Business_Contact_File_ds_return_result'      ),all)
                                                                                                                  
  );

  #IF(pDebug = true)
    return when(ds_return_result_contact  ,output_debug);
  #ELSE
    return ds_return_result_contact;
  #END


endmacro;