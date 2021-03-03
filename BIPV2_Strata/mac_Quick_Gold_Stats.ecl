import BIPV2;

EXPORT mac_Quick_Gold_Stats(

   pversion   = 'BIPV2.KeySuffix'
  ,pBaseFile  = 'bipv2.CommonBase.DS_BUILT'
  ,pCleanFile = 'bipv2.CommonBase.DS_CLEAN'
  ,pIsTesting = 'false'
) :=
functionmacro

  import BIPV2,Strata,BIPV2_Statuses;
  
  ds_built       := pBaseFile ;  //uses the "built" version of the file just built
  ds_built_clean := BIPV2_Statuses.mac_Calculate_Gold(pCleanFile) : persist('~persist::BIPV2_Strata::mac_Quick_Gold_Stats::ds_built_clean');  //uses the "built" version of the file just built, but cleaned
  
  ds_quick_check_of_golds := dataset([
    {'Total Records'        ,count(      ds_built                                                                  ),count(      ds_built                                                                  )}
   ,{'Total Clean Records'  ,count(      ds_built_clean                                                            ),count(      ds_built_clean                                                            )}
   ,{'Total Seleids'        ,count(table(ds_built_clean                                   ,{seleid} ,seleid ,merge)),count(table(ds_built_clean                                   ,{seleid} ,seleid ,merge))}
   ,{'Total Active Seleids' ,count(table(ds_built_clean(trim(seleid_status_public) = '' ) ,{seleid} ,seleid ,merge)),count(table(ds_built_clean(trim(seleid_status_public) = '' ) ,{seleid} ,seleid ,merge))}
   ,{'Total Gold Seleids'   ,count(table(ds_built_clean(     sele_gold             = 'G') ,{seleid} ,seleid ,merge)),count(table(ds_built_clean(     sele_gold             = 'G') ,{seleid} ,seleid ,merge))}
  
  ],{string statname ,unsigned countgroup,unsigned count});

  quick_check_of_golds	:= Strata.macf_CreateXMLStats (ds_quick_check_of_golds ,'BIPV2','CommonBase'  ,pversion	,BIPV2_Build.mod_email.emailList	,'Gold_Counts' ,'Output'  ,pIsTesting);

// BIPV2_CommonBase_Output_Gold_Counts

  return quick_check_of_golds;
  
endmacro;