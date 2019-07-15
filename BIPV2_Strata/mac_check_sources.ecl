// add new strata stat on source and file for source ingest, ingest, base, clean, xlink, contacts key

import bipv2_build,bipv2,strata,BIPV2_Files,bizlinkfull;

EXPORT mac_check_sources(
   pversion       = 'bipv2.KeySuffix'                           // build date
  ,pSource_Ingest = 'BIPV2.File_Business_Sources'
  ,pIngest_Base   = 'BIPV2_Files.files_ingest.DS_BASE'
  ,pDS_Base       = 'Bipv2.CommonBase.ds_built'
  ,pDS_Clean      = 'Bipv2.CommonBase.ds_clean'
  ,pDS_Xlink      = 'Bipv2.CommonBase.ds_xlink'
  ,pBIP_Key       = 'BIPV2_Build.key_contact_linkids.keybuilt'
  ,pXlinkPayload  = 'BizLinkFull._Keys().Xlinkmeow.built'
  ,pEmail_List    = 'BIPV2_Build.mod_email.emailList'           // email list 
  ,pIsTesting     = 'false'
  ,pOverwrite     = 'false'
) :=
functionmacro

  import bipv2_build,bipv2,strata,bipv2_files,bizlinkfull;
  
  Source_Ingest     := table(pSource_Ingest     ,{string source := BIPV2.mod_sources.TranslateSource_aggregate(source),string file := 'Source Ingest'     });
  Ingest_Base       := table(pIngest_Base       ,{string source := BIPV2.mod_sources.TranslateSource_aggregate(source),string file := 'Ingest Base'       });
  DS_Base           := table(pDS_Base           ,{string source := BIPV2.mod_sources.TranslateSource_aggregate(source),string file := 'DS_Base'           });
  DS_Clean          := table(pDS_Clean          ,{string source := BIPV2.mod_sources.TranslateSource_aggregate(source),string file := 'DS_Clean'          });
  DS_Xlink          := table(pDS_Xlink          ,{string source := BIPV2.mod_sources.TranslateSource_aggregate(source),string file := 'DS_Xlink'          });
  BIP_Key           := table(pBIP_Key           ,{string source := BIPV2.mod_sources.TranslateSource_aggregate(source),string file := 'Contacts_Key'      });
  Xlink_Payload_Key := table(pXlinkPayload      ,{string source := BIPV2.mod_sources.TranslateSource_aggregate(source),string file := 'Xlink Payload Key' });
  
  ds_concat := 
    Source_Ingest  
  + Ingest_Base    
  + DS_Base        
  + DS_Clean       
  + DS_Xlink       
  + BIP_Key        
  + Xlink_Payload_Key        
  ;
                                                                                                                              
  ds_count := sort(table(ds_concat ,{source,file, unsigned countgroup := count(group), unsigned cnt := count(group)},source,file,merge),source,file)
  : independent;

  return Strata.macf_CreateXMLStats (ds_count ,'BIPV2','2.2'  ,pversion	,pEmail_List	,'CHECK' ,'SOURCE'	,pIsTesting,pOverwrite);

endmacro;
