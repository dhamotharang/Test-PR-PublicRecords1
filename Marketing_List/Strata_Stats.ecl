import BIPV2;

EXPORT Strata_Stats(

   pversion           = 'BIPV2.KeySuffix'
  ,pBusiness_Info     = 'Marketing_List.Files().business_information.built'
  ,pBusiness_Contact  = 'Marketing_List.Files().business_contact.built'
	,pIsTesting         = 'tools._Constants.IsDataland'

) :=
functionmacro

  import strata,BIPV2;

  email_list    := Marketing_List.Email_Notification_Lists(pIsTesting).BuildSuccess;
  
  ds_base_slim  := project(pBusiness_Info ,recordof(left));
  
  // -- Do population and unique values stats for business information file and business contact file
  ds_population_stats         := strata.macf_Pops   (ds_base_slim     );
  ds_unique_stats             := strata.macf_Uniques(ds_base_slim     );
  ds_population_stats_contact := strata.macf_Pops   (pBusiness_Contact);
  ds_unique_stats_contact     := strata.macf_Uniques(pBusiness_Contact);

  // -- send those stats to strata
  do_pops             := Strata.macf_CreateXMLStats(ds_population_stats         ,'Marketing_List' ,'business_information' ,pversion ,email_list  ,'Population' ,'Stats' ,pIsTesting);
  do_uniques          := Strata.macf_CreateXMLStats(ds_unique_stats             ,'Marketing_List' ,'business_information' ,pversion ,email_list  ,'Uniques'    ,'Stats' ,pIsTesting);
  do_pops_contact     := Strata.macf_CreateXMLStats(ds_population_stats_contact ,'Marketing_List' ,'business_contact'     ,pversion ,email_list  ,'Population' ,'Stats' ,pIsTesting);
  do_uniques_contact  := Strata.macf_CreateXMLStats(ds_unique_stats_contact     ,'Marketing_List' ,'business_contact'     ,pversion ,email_list  ,'Uniques'    ,'Stats' ,pIsTesting);

  return parallel(
     do_pops
    ,do_uniques
    ,do_pops_contact   
    ,do_uniques_contact
  );

endmacro;