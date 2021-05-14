/*

The Business Contact Information will use the below logic for the person hierarchy and will return all unique contacts where a unique contact is first rolled up by LEXID if one exists and then if no LEXID exists rolled up by First Name, Last Name.

    A consumer has been seen at the business in the past 2 years
        Highest ranked title in current hierarchy of titles (used in the contact key build today)
        If no person on file with a title or a tie pick a consumer with the most recent last seen
    A consumer seen at the business outside of the past 2 years
        Highest ranked title in current hierarchy of titles (used in the contact key build today)
        If no person on file with a title or a tie pick a consumer with the most recent last seen

 

The general rule is to create a file at the PROXID Best level with Marketing Data. The service must search at the PROXID Best level that is restricted for marketing data.

// --------------------------------
LNK-4037 -- CR #5: Marketing List Person_Hierarchy non-zero 

Rules that should be applied for the Person Hierarchy that have 0’s.********

 A. First start with contacts that have a LexID

    If they have an EmpID then we will sort them by highest to lowest and then give them a number
        If there is no EmpID go to 2
    Find contacts that have an address and email, give them a number (just random ordering)
        If there is no email address but there is an address go to 3
    Find contacts that have an address, give them a number (just random ordering)
        If there is no address go to 4
    Find contacts that have an email address, give them a number (just random ordering)
        If there is no email address go to 5.
    Order the rest of the contacts by LexID highest to lowest and then give them a number

 

B. Next move on to contacts that don’t have a LexID

    If they have an EmpID then we will sort them by highest to lowest and then give them a number
        If there is no EmpID go to 2
    Find contacts that have an address and email, give them a number (just random ordering)
        If there is no email address but there is an address go to 3
    Find contacts that have an address, give them a number (just random ordering)
        If there is no address go to 4
    Find contacts that have an email address, give them a number (just random ordering)
        If there is no email address go to 5.
    Give the rest of the contacts a number (just random ordering)
// --------------------------------

*/
EXPORT Set_Hierarchy(

  pContact_File


) :=
functionmacro

  // use lexid, empid, address, email
  // -- sort contacts per proxid in person hierarchy order, set person hierarchy
  ds_set_hrchy_dist := distribute (pContact_File  ,hash(seleid,proxid));

  ds_sort2  := sort(ds_set_hrchy_dist  
    ,seleid  
    ,proxid 
    ,map(age <= 2 and dt_last_seen != 0 => 1  
        ,age >  2 and dt_last_seen != 0 => 2  
        ,                                  3
     ) 
    ,if(person_hierarchy = 0  ,9999 ,person_hierarchy) 
    ,-title_dt_last_seen
    ,-dt_last_seen
    
    // -- CR#5 for the ones without titles that would have gotten person_hierarchy = 0, now will be populated.
    ,if(      lexid                   != 0                                        ,1      ,2)
    ,if(      empid                   != 0                                        ,1      ,2)
    ,if(      empid                   != 0                                        ,-empid ,0)
    ,if(trim( contact_address      )  != '' and trim(contact_email_address) != '' ,1      ,2) //contains both address and email address
    ,if(trim( contact_address      )  != ''                                       ,1      ,2) //contains only address
    ,if(trim( contact_email_address)  != ''                                       ,1      ,2) //contains only email address
    ,if(      lexid                   != 0                                        ,1      ,2)
    ,if(      lexid                   != 0                                        ,-lexid ,0)


    
    // ,if(lexid != 0  ,1,2)
    // ,lexid
    // ,lname
    // ,fname
    ,local
  );
  
  ds_group  := group      (ds_sort2  ,seleid,proxid,local);
  ds_iterate := iterate(ds_group  ,transform(recordof(left)
    ,self.person_hierarchy := if(left.proxid = 0 ,1  ,left.person_hierarchy + 1)
    ,self                  := right
  
  ));

  return_result := ds_iterate;
  // ds_fix_hierarchy := project(ds_iterate  ,transform(Marketing_List.Layouts.business_contact,self.person_hierarchy := if(trim(left.title) != '' ,left.person_hierarchy  ,0) ,self := left ));

  return return_result;

endmacro;