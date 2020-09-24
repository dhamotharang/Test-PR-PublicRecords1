EXPORT mac_compare_statuses_and_gold(

   pversion             = 'Bipv2.KeySuffix'
  ,pBase_File           = 'bipv2.CommonBase.ds_clean'                   //assuming this dataset is ds_clean or cleaned
  ,pBIP_ID              = 'seleid'
  ,pGold_Fieldname      = 'sele_gold'
  ,pActive_Fieldname    = 'seleid_status_private'
  ,pSet_Trusted_Sources = 'bipv2.mod_sources.set_Trusted'   // sources required to be in cluster
  ,pToday               = 'bipv2.KeySuffix_mod2.MostRecentWithIngestVersionDate'          //in case you want to run as of a date in the past.  default to date of newest data.

  ,pBIP_ID_Test_Value   = '0'
  ,pOutputNameModifier  = '' 
  ,pShow_Work           = 'false'
) :=
FUNCTIONMACRO

  set_current_seleid_statuses := BIPV2_Tools.mac_Set_Statuses_Add_superfile(pversion  ,pBase_File ,pBIP_ID  ,pActive_Fieldname  ,pToday);
  set_current_gold_statuses   := BIPV2_PostProcess.mac_Calculate_Gold



endmacro;