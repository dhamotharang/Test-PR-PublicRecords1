/* ----------------- Quick Simple Sanity Check of BIP IDs only(using Strata) ------------------- */
// ['rcid:Dotid','Dotid:proxid:empid','proxid:powid:seleid','lgid3:seleid','empid:orgid','powid:orgid','seleid:orgid','orgid:ultid','ultid']
import strata,bipv2_build,BIPV2_Files,bipv2,tools;
export mac_BIP_ID_Check(
   pDataset                                                 // Dataset to do strata in
  ,pBuild_Step                                              // Proxid, Empid, etc
  ,pBuild_SubStep                                           // Preprocess
  ,pversion         = 'bipv2.KeySuffix'                     // build date
  ,pIsTesting       = 'false'                               // true = do not send to strata, false = send to strata
  ,pEmail_List      = 'BIPV2_Build.mod_email.emailList'     // email list 
  ,pBuild           = '\'BIPV2\''                           // This will be the same for all calls in the BIP build
  ,pStatType        = '\'ID_Integrity_Check\''              // This will also be the same for all calls in the BIP build
  ,pOverwrite       = 'false'                               // no effect yet
) :=
functionmacro
  // -- Figure out what BIP ID fields exist, and then unique on those.
  LOADXML('<xml/>');
  #EXPORTXML(pLayout_MetaInfo ,recordof(pDataset))
	#uniquename(SET_IDS_DO_NOT_EXIST)
  import tools,bipv2_build;
  tools.mac_DoFieldsExist(pLayout_MetaInfo	,['rcid','dotid','empid','powid','proxid','lgid3','seleid','orgid','ultid','ultimate_proxid'],SET_IDS_DO_NOT_EXIST,true);
  
  #uniquename(tableslimmer)
  #SET(tableslimmer ,'')
  import std,BIPV2_strata;
  
  #IF('rcid'   not in %SET_IDS_DO_NOT_EXIST% )  #APPEND(tableslimmer ,',rcid'   ) #ELSE STD.System.Log.addWorkunitWarning ('BIPV2_strata.mac_BIP_ID_Check: rcid field does not exist'  ); #END
  #IF('dotid'  not in %SET_IDS_DO_NOT_EXIST% )  #APPEND(tableslimmer ,',dotid'  ) #ELSE STD.System.Log.addWorkunitWarning ('BIPV2_strata.mac_BIP_ID_Check: dotid field does not exist' ); #END
  #IF('empid'  not in %SET_IDS_DO_NOT_EXIST% )  #APPEND(tableslimmer ,',empid'  ) #ELSE STD.System.Log.addWorkunitWarning ('BIPV2_strata.mac_BIP_ID_Check: empid field does not exist' ); #END
  #IF('powid'  not in %SET_IDS_DO_NOT_EXIST% )  #APPEND(tableslimmer ,',powid'  ) #ELSE STD.System.Log.addWorkunitWarning ('BIPV2_strata.mac_BIP_ID_Check: powid field does not exist' ); #END
  #IF('proxid' not in %SET_IDS_DO_NOT_EXIST% )  #APPEND(tableslimmer ,',proxid' ) #ELSE STD.System.Log.addWorkunitWarning ('BIPV2_strata.mac_BIP_ID_Check: proxid field does not exist'); #END
	#IF('lgid3'  not in %SET_IDS_DO_NOT_EXIST% )  #APPEND(tableslimmer ,',lgid3'  ) #ELSE STD.System.Log.addWorkunitWarning ('BIPV2_strata.mac_BIP_ID_Check: lgid3 field does not exist' ); #END
	#IF('seleid' not in %SET_IDS_DO_NOT_EXIST% )  #APPEND(tableslimmer ,',seleid' ) #ELSE STD.System.Log.addWorkunitWarning ('BIPV2_strata.mac_BIP_ID_Check: seleid field does not exist'); #END
  #IF('orgid'  not in %SET_IDS_DO_NOT_EXIST% )  #APPEND(tableslimmer ,',orgid'  ) #ELSE STD.System.Log.addWorkunitWarning ('BIPV2_strata.mac_BIP_ID_Check: orgid field does not exist' ); #END
  #IF('ultid'  not in %SET_IDS_DO_NOT_EXIST% )  #APPEND(tableslimmer ,',ultid'  ) #ELSE STD.System.Log.addWorkunitWarning ('BIPV2_strata.mac_BIP_ID_Check: ultid field does not exist' ); #END
  #IF('ultimate_proxid'  not in %SET_IDS_DO_NOT_EXIST% )  #APPEND(tableslimmer ,',ultimate_proxid'  ) #ELSE STD.System.Log.addWorkunitWarning ('BIPV2_strata.mac_BIP_ID_Check: ultimate_proxid field does not exist' ); #END
  #SET(tableslimmer ,%'tableslimmer'%[2..])
  ds_slim := distribute(table(pDataset, {%tableslimmer%})) : independent;
// ['rcid:Dotid','Dotid:proxid:empid','proxid:powid:seleid','lgid3:seleid','empid:orgid','powid:orgid','seleid:orgid','orgid:ultid','ultid']
  return_dataset := 
						// BIPV2_strata.mac_ID_Integrity_check(bipv2.CommonBase.ds_base,rcid,rcid  ,true ,dotid  )
    #IF('dotid'  not in %SET_IDS_DO_NOT_EXIST% and 'proxid' not in %SET_IDS_DO_NOT_EXIST%)   BIPV2_strata.mac_ID_Integrity_check_V2(ds_slim,rcid,dotid ,true ,proxid,pBuild_Step,pBuild_SubStep) #ELSE   dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    //#IF('dotid'  not in %SET_IDS_DO_NOT_EXIST% and 'empid'  not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check_V2(ds_slim,rcid,dotid ,true ,empid,pBuild_Step,pBuild_SubStep) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    //#IF('proxid' not in %SET_IDS_DO_NOT_EXIST% and 'powid'  not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check_V2(ds_slim,rcid,proxid,true ,powid,pBuild_Step,pBuild_SubStep) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    //add the following : (proxid, lgid3)  BH-75
		#IF('proxid'  not in %SET_IDS_DO_NOT_EXIST% and 'lgid3'  not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check_V2(ds_slim,rcid,proxid,true ,lgid3,pBuild_Step,pBuild_SubStep) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    
		#IF('proxid' not in %SET_IDS_DO_NOT_EXIST% and 'seleid' not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check_V2(ds_slim,rcid,proxid,true ,seleid,pBuild_Step,pBuild_SubStep) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    #IF('lgid3'  not in %SET_IDS_DO_NOT_EXIST% and 'seleid' not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check_V2(ds_slim,rcid,lgid3 ,true ,seleid,pBuild_Step,pBuild_SubStep) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    #IF('empid'  not in %SET_IDS_DO_NOT_EXIST% and 'orgid'  not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check_V2(ds_slim,rcid,empid ,true ,orgid,pBuild_Step,pBuild_SubStep) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    #IF('powid'  not in %SET_IDS_DO_NOT_EXIST% and 'orgid'  not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check_V2(ds_slim,rcid,powid ,true ,orgid,pBuild_Step,pBuild_SubStep) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    #IF('seleid' not in %SET_IDS_DO_NOT_EXIST% and 'orgid'  not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check_V2(ds_slim,rcid,seleid,true ,orgid,pBuild_Step,pBuild_SubStep) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    #IF('orgid'  not in %SET_IDS_DO_NOT_EXIST% and 'ultid'  not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check_V2(ds_slim,rcid,orgid ,true ,ultid,pBuild_Step,pBuild_SubStep) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    #IF('ultid'  not in %SET_IDS_DO_NOT_EXIST% and 'ultimate_proxid'  not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check_V2(ds_slim,rcid,ultid ,false ,ultimate_proxid,pBuild_Step,pBuild_SubStep) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    #IF('ultimate_proxid'  not in %SET_IDS_DO_NOT_EXIST% and 'ultid'  not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check_V2(ds_slim,rcid,ultimate_proxid ,false ,ultid,pBuild_Step,pBuild_SubStep) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    
		//#IF('dotid'  not in %SET_IDS_DO_NOT_EXIST% and 'proxid' not in %SET_IDS_DO_NOT_EXIST%)   BIPV2_strata.mac_ID_Integrity_check(ds_slim,rcid,dotid ,true ,proxid ) #ELSE   dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    //#IF('dotid'  not in %SET_IDS_DO_NOT_EXIST% and 'empid'  not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check(ds_slim,rcid,dotid ,true ,empid  ) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    //#IF('proxid' not in %SET_IDS_DO_NOT_EXIST% and 'powid'  not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check(ds_slim,rcid,proxid,true ,powid  ) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    //#IF('proxid' not in %SET_IDS_DO_NOT_EXIST% and 'seleid' not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check(ds_slim,rcid,proxid,true ,seleid ) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    //#IF('lgid3'  not in %SET_IDS_DO_NOT_EXIST% and 'seleid' not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check(ds_slim,rcid,lgid3 ,true ,seleid ) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    //#IF('empid'  not in %SET_IDS_DO_NOT_EXIST% and 'orgid'  not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check(ds_slim,rcid,empid ,true ,orgid  ) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    //#IF('powid'  not in %SET_IDS_DO_NOT_EXIST% and 'orgid'  not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check(ds_slim,rcid,powid ,true ,orgid  ) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    //#IF('seleid' not in %SET_IDS_DO_NOT_EXIST% and 'orgid'  not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check(ds_slim,rcid,seleid,true ,orgid  ) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    //#IF('orgid'  not in %SET_IDS_DO_NOT_EXIST% and 'ultid'  not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check(ds_slim,rcid,orgid ,true ,ultid  ) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    //#IF('ultid'  not in %SET_IDS_DO_NOT_EXIST% and 'ultimate_proxid'  not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check(ds_slim,rcid,ultid ,false ,ultimate_proxid       ) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    //#IF('ultimate_proxid'  not in %SET_IDS_DO_NOT_EXIST% and 'ultid'  not in %SET_IDS_DO_NOT_EXIST%) + BIPV2_strata.mac_ID_Integrity_check(ds_slim,rcid,ultimate_proxid ,false ,ultid       ) #ELSE + dataset([],BIPV2_strata.layouts.Id_Integrity) #END
    
    : independent;  // add independent to prevent this from being evaluated twice in Strata.macf_CreateXMLStats
  // ds_Uniques      := Strata.macf_Uniques        (ds_slim );
  ID_Check_Strata	:= Strata.macf_CreateXMLStats (return_dataset ,pBuild,pBuild_Step  ,pversion	,pEmail_List	,pStatType ,pBuild_SubStep	,pIsTesting,pOverwrite);
  return ID_Check_Strata;
  // return %'tableslimmer'%;
  // return parallel(output(%'tableslimmer'%),output(%'SET_IDS_DO_NOT_EXIST'%));
  
endmacro;
