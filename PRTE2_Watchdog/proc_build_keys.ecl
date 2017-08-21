IMPORT Roxiekeybuild,Watchdog,Suppress,header,std,PRTE2_Header,_Control;

EXPORT proc_build_keys(string filedate) := MODULE

    SHARED pwn := '~prte::key::watchdog::';
		SHARED pfn := '~prte::key::watchdog_best::fcra::';
    SHARED phn := '~prte::key::header::';
    SHARED key_copy    := watchdog.Key_Prep_Watchdog_GLB() :independent;

    SHARED copy(string fromkeyname, string tokeyname):= nothor(global(if(fileservices.FileExists(tokeyname),
                                                                output(tokeyname+' |'+'FILE ALREADY EXISTS'),
                                                                    fileservices.copy(fromkeyname,STD.System.Thorlib.Group(),tokeyname,,,,,true,true) )));

    Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(watchdog.Key_Prep_Watchdog_GLB()            ,pwn+'best.did'         ,pwn+filedate+'::best.did'         ,k01);
    Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(watchdog.Key_Prep_Watchdog_GLB(true)        ,pwn+'best_nonutil.did' ,pwn+filedate+'::best_nonutil.did' ,k02);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(watchdog.Key_Prep_Watchdog_nonglb(false)    ,pwn+'nonglb.did'       ,pwn+filedate+'::nonglb.did'       ,k03);
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(watchdog.Key_Prep_Watchdog_nonglb(true)     ,pwn+'nonglb_noneq.did' ,pwn+filedate+'::nonglb_noneq.did' ,k04);
    Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(watchdog.Key_Prep_Best_SSN                  ,pwn+'best.ssn'         ,pwn+filedate+'::best.ssn'         ,k05);
    Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(Suppress.Key_SSN_Bad                        ,pwn+'ssn_bads'         ,pwn+filedate+'::ssn_bads'         ,k06);
    
    Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(Watchdog.key_Prep_Watchdog_glb_nonutil_nonblank(true),pwn+'best_nonutil.did_nonblank',pwn+filedate+'::best_nonutil.did_nonblank' ,k07);
    k08 :=                                copy(pwn+filedate+'::best.did'                            ,pwn+filedate+'::best.did_nonblank'    );
    
    Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(Watchdog.key_Prep_Watchdog_nonglb_nonblank(false)    ,pwn+'nonglb.did_nonblank'      ,pwn+filedate+'::nonglb.did_nonblank'       ,k09);
    Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(Watchdog.key_Prep_Watchdog_nonglb_nonblank(true)     ,pwn+'nonglb_noneq.did_nonblank',pwn+filedate+'::nonglb_noneq.did_nonblank' ,k10);
    Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(Watchdog.Key_Prep_Watchdog_teaser(false)             ,pwn+'nonglb.teaser'            ,pwn+filedate+'::nonglb.teaser'             ,k11);
    Roxiekeybuild.Mac_SK_BuildProcess_v2_Local(Watchdog.Key_Prep_Watchdog_teaser(true)              ,pwn+'nonglb_noneq.teaser'      ,pwn+filedate+'::nonglb_noneq.teaser'       ,k12);

    k13 :=                                 copy(pwn+filedate+'::best.did'                           ,pwn+filedate+'::best_nonen.did'                );
		k14 :=                                 copy(pwn+filedate+'::best.did'                           ,pwn+filedate+'::best_nonen.did_nonblank'       );
    k15 :=                                 copy(pwn+filedate+'::best.did'                           ,pwn+filedate+'::best_nonen_noneq.did'          );
    k16 :=                                 copy(pwn+filedate+'::best.did'                           ,pwn+filedate+'::best_nonen_noneq.did_nonblank' );
    k17 :=                                 copy(pwn+filedate+'::best.did'                           ,pwn+filedate+'::best_noneq.did'                );
    k18 :=                                 copy(pwn+filedate+'::best.did'                           ,pwn+filedate+'::best_noneq.did_nonblank'       );

    //Roxiekeybuild.MAC_SK_BuildProcess_v2_Local(header.key_ADL_segmentation                          ,phn+'::adl_segmentation'      ,phn+filedate+'::adl_segmentation'           ,k19);
    Roxiekeybuild.MAC_SK_BuildProcess_v2_Local(Watchdog.Key_Best_Name_City_State                    ,pwn+'::best.name_city_st'     ,pwn+filedate+'::best.name_city_st'          ,k20);
    // Watchdog.Key_Supplemental // THIS KEY IS BUILT BY PRTE2_Header.proc_build_keys
    Roxiekeybuild.MAC_SK_BuildProcess_Local(watchdog.Key_Prep_Watchdog_marketing(false)             ,pwn+filedate+'::marketing.did'         ,pwn+'::marketing.did'              ,k21,2);
    Roxiekeybuild.MAC_SK_BuildProcess_Local(watchdog.Key_Prep_Watchdog_marketing(true)              ,pwn+filedate+'::marketing_noneq.did'   ,pwn+'::marketing_noneq.did'        ,k22,2);


    SHARED build_them := 
    sequential    ( k01,k02,k03,k04,k05,k06,k07,k08,k09,k10,k11,k12,k13,k14,k15,k16,k17,k18/*,k19*/,k20,k21,k22 );


    ecl1 := '#workunit(\'name\',\'PRTE2_Watchdog.proc_build_keys STEP2\');\n'
    
    + PRTE2_Header.fn_bld_blank_index('','Watchdog.Key_Supplemental          ','thor_data400::key::watchdog_best_supplemental::did','::best_supplemental::did',pwn,filedate,'23')
    + PRTE2_Header.fn_bld_blank_index('','Watchdog.Key_Watchdog_FCRA_nonEN   ','thor_data400::key::watchdog_best::FCRA::nonEN_did' ,'::nonen_did'             ,pfn,filedate,'13f')
    + PRTE2_Header.fn_bld_blank_index('','Watchdog.Key_Watchdog_FCRA_nonEQ   ','thor_data400::key::watchdog_best::FCRA::nonEQ_did' ,'::noneq_did'             ,pfn,filedate,'17f')
  
    +'sequential(parallel(bld23,bld13f,bld17f                                )\n'
    +'          ,PRTE2_Watchdog.proc_build_keys(\''+filedate+'\').step2);';

    SHARED build_empty_keys := //output(ecl1); 
                    _Control.fSubmitNewWorkunit(ecl1,std.system.job.target());

    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::best.did'                     ,pwn+filedate+'::best.did'                     ,MB01);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::best_nonutil.did'             ,pwn+filedate+'::best_nonutil.did'             ,MB02);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::nonglb.did'                   ,pwn+filedate+'::nonglb.did'                   ,MB03);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::nonglb_noneq.did'             ,pwn+filedate+'::nonglb_noneq.did'             ,MB04);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::best.ssn'                     ,pwn+filedate+'::best.ssn'                     ,MB05);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::ssn_bads'                     ,pwn+filedate+'::ssn_bads'                     ,MB06);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::best_nonutil.did_nonblank'    ,pwn+filedate+'::best_nonutil.did_nonblank'    ,MB07);    
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::best.did_nonblank'            ,pwn+filedate+'::best.did_nonblank'            ,MB08);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::nonglb.did_nonblank'          ,pwn+filedate+'::nonglb.did_nonblank'          ,MB09);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::nonglb_noneq.did_nonblank'    ,pwn+filedate+'::nonglb_noneq.did_nonblank'    ,MB10);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::nonglb.teaser'                ,pwn+filedate+'::nonglb.teaser'                ,MB11);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::nonglb_noneq.teaser'          ,pwn+filedate+'::nonglb_noneq.teaser'          ,MB12);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::best_nonen.did'               ,pwn+filedate+'::best_nonen.did'               ,MB13);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pfn+'@version@'+'::nonen.did'                    ,pfn+filedate+'::nonen_did'                    ,MB13f);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::best_nonen.did_nonblank'      ,pwn+filedate+'::best_nonen.did_nonblank'      ,MB14);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::best_nonen_noneq.did'         ,pwn+filedate+'::best_nonen_noneq.did'         ,MB15);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::best_nonen_noneq.did_nonblank',pwn+filedate+'::best_nonen_noneq.did_nonblank',MB16);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::best_noneq.did'               ,pwn+filedate+'::best_noneq.did'               ,MB17);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pfn+'@version@'+'::noneq.did'                    ,pfn+filedate+'::noneq_did'                    ,MB17f);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::best_noneq.did_nonblank'      ,pwn+filedate+'::best_noneq.did_nonblank'      ,MB18);
    // RoxieKeyBuild.Mac_SK_Move_to_Built_v2(phn+'@version@'+'::adl_segmentation'             ,phn+filedate+'::adl_segmentation'             ,MB19);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::best.name_city_st'            ,pwn+filedate+'::best.name_city_st'            ,MB20);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::marketing.did'                ,pwn+filedate+'::marketing.did'                ,MB21);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::marketing_noneq.did'          ,pwn+filedate+'::marketing_noneq.did'          ,MB22);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2(pwn+'@version@'+'::best_supplemental::did'       ,pwn+filedate+'::best_supplemental::did'       ,MB23);
    
		SHARED move_to_built := 
    parallel      ( MB01,MB02,MB03,MB04,MB05,MB06,MB07,MB08,MB09,MB10,MB11,MB12,MB13,MB14,MB15,MB16,MB17,MB18/*,MB19*/,MB20,MB21,MB22,MB23,MB13f,MB17f);

    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::best.did'                      ,'Q',MQ01,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::best_nonutil.did'              ,'Q',MQ02,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::nonglb.did'                    ,'Q',MQ03,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::nonglb_noneq.did'              ,'Q',MQ04,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::best.ssn'                      ,'Q',MQ05,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::ssn_bads'                      ,'Q',MQ06,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::best.did_nonblank'             ,'Q',MQ07,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::best_nonutil.did_nonblank'     ,'Q',MQ08,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::nonglb.did_nonblank'           ,'Q',MQ09,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::nonglb_noneq.did_nonblank'     ,'Q',MQ10,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::nonglb.teaser'                 ,'Q',MQ11,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::nonglb_noneq.teaser'           ,'Q',MQ12,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pfn+'@version@'+'::nonen.did'                     ,'Q',MQ13f,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::best_nonen.did'                ,'Q',MQ13,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::best_nonen.did_nonblank'       ,'Q',MQ14,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::best_nonen_noneq.did'          ,'Q',MQ15,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::best_nonen_noneq.did_nonblank' ,'Q',MQ16,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::best_noneq.did'                ,'Q',MQ17,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pfn+'@version@'+'::noneq.did'                     ,'Q',MQ17f,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::best_noneq.did_nonblank'       ,'Q',MQ18,2);
    // RoxieKeyBuild.Mac_SK_Move_V2(phn+'@version@'+'::adl_segmentation'              ,'Q',MQ19,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::best.name_city_st'             ,'Q',MQ20,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::marketing.did'                 ,'Q',MQ21,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::marketing_noneq.did'           ,'Q',MQ22,2);
    RoxieKeyBuild.Mac_SK_Move_V2(pwn+'@version@'+'::best_supplemental::did'        ,'Q',MQ23,2);

        
    SHARED move_to_qa := 
    parallel( MQ01,MQ02,MQ03,MQ04,MQ05,MQ06,MQ07,MQ08,MQ09,MQ10,MQ11,MQ12,MQ13,MQ14,MQ15,MQ16,MQ17,MQ18/*,MQ19*/,MQ20,MQ21,MQ22,MQ23,MQ13f,MQ17f);
        


    EXPORT step1 := sequential(build_them,build_empty_keys)
                            :success(fileservices.sendemail(_control.MyInfo.EmailAddressNotify,'PRTE2_Watchdog.proc_build_keys step1 completed',workunit)),
                             failure(fileservices.sendemail(_control.MyInfo.EmailAddressNotify,'PRTE2_Watchdog.proc_build_keys step1 FAILED!!!',workunit));

    EXPORT step2 := sequential(move_to_built ,move_to_qa)
                            :success(fileservices.sendemail(_control.MyInfo.EmailAddressNotify,'PRTE2_Watchdog.proc_build_keys step2 completed',workunit)),
                             failure(fileservices.sendemail(_control.MyInfo.EmailAddressNotify,'PRTE2_Watchdog.proc_build_keys step2 FAILED!!!',workunit));

end;