import BIPV2;

EXPORT Strata_Stats(

   pversion   = 'BIPV2.KeySuffix'
  ,pBase      = 'Marketing_List.Files().business_information.built'
	,pIsTesting = 'tools._Constants.IsDataland'

) :=
functionmacro

  import strata,BIPV2;

  email_list := Marketing_List.Email_Notification_Lists(pIsTesting).BuildSuccess;
  
  ds_base_slim := project(pBase ,recordof(left));
  
  ds_population_stats := strata.macf_Pops   (ds_base_slim);
  ds_unique_stats     := strata.macf_Uniques(ds_base_slim);
  
  do_pops     := Strata.macf_CreateXMLStats(ds_population_stats ,'Marketing_List' ,'Base' ,pversion ,email_list  ,'Population' ,'Stats' ,pIsTesting);
  do_uniques  := Strata.macf_CreateXMLStats(ds_unique_stats     ,'Marketing_List' ,'Base' ,pversion ,email_list  ,'Uniques'    ,'Stats' ,pIsTesting);
  
  return parallel(
     do_pops
    ,do_uniques
  );

endmacro;