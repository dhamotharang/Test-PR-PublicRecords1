/* 
  BIPV2_Tools.mac_Set_Statuses()
    -- Set statuses for each BIP ID, allowing for public(no use of DNB) and private(limited use of DNB to corroborate other sources' status)
    -- write out to a file, add to a superfile

*/
EXPORT mac_Set_Statuses_Add_superfile(
   pversion             = 'Bipv2.KeySuffix'
  ,infile               = 'bipv2.CommonBase.ds_clean'                                     //assuming this dataset is ds_clean or cleaned
  ,pBIP_ID              = 'seleid'
  ,pActive_Fieldname    = 'seleid_status_private'
  ,pToday               = 'bipv2.KeySuffix_mod2.MostRecentWithIngestVersionDate'          //in case you want to run as of a date in the past.  default to date of newest data.
  ,pOldWay              = 'false'

  ,pUse_DNB             = 'false'
  ,pBIP_ID_Test_Value   = '0'
  ,pFuture_Dates        = 'true'                                                          // set future dates to 19700101 so they are treated as old.  
  ,pSet_Bad_Sources     = 'MDR.sourceTools.set_Cortera + MDR.sourceTools.set_DataBridge'
  ,pSet_Trusted_Sources = 'bipv2.mod_sources.set_Trusted'                                 // sources required to be in cluster
) :=
FUNCTIONMACRO

  import bipv2,ut,mdr,bipv2,AutoStandardI,BIPV2_PostProcess,BIPV2_Build;

  ds_set_statuses := BIPV2_Tools.mac_Set_Statuses(infile  ,pBIP_ID  ,pActive_Fieldname  ,pUse_DNB ,pBIP_ID_Test_Value ,pFuture_Dates  ,pToday ,true ,pSet_Bad_Sources ,pSet_Trusted_Sources ,pOldWay);

  fnames := BIPV2_Build.filenames(pversion).Active_Status_work(trim(#TEXT(pBIP_ID)));
  
  return sequential(
     output(ds_set_statuses ,,fnames.logical  ,compressed)
    ,BIPV2_Build.Promote(pversion,'Active_Status_work').new2built
  );
  

ENDMACRO;
