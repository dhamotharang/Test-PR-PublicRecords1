import BIPV2,bipv2_build;
EXPORT proc_build_all(
   pversion                     = 'BIPV2.KeySuffix'
  ,pDataset_Best                = 'Marketing_List.Source_Files().bip_best'
  ,pDataset_Base                = 'Marketing_List.Source_Files().bip_base'
  ,pdca_base                    = 'Marketing_List.Source_Files().dca'                  
  ,peq_biz_base                 = 'Marketing_List.Source_Files().eq_biz'               
  ,poshair_base                 = 'Marketing_List.Source_Files().oshair'               
  ,pcortera_base                = 'Marketing_List.Source_Files().cortera'              
  ,pinfutor_base                = 'Marketing_List.Source_Files().infutor'              
  ,paccutrend_base              = 'Marketing_List.Source_Files().accutrend'            
  ,pDataset_Crosswalk           = 'Marketing_List.Source_Files().crosswalk'
  ,pWatchdog_best_Key           = 'Marketing_List.Source_Files().key_watchdog_best'
  ,pHeader_Segs_Key             = 'Marketing_List.Source_Files().key_Header_segs'
  ,pCounty_Names                = 'Marketing_List.Source_Files().County_Names'
  ,pCity_Names                  = 'Marketing_List.Source_Files().City_names'
  ,pEmployees_Ranking           = 'Marketing_List._Config().ds_sources_of_number_of_employees'
  ,pSales_Ranking               = 'Marketing_List._Config().ds_sources_of_sales_revenue'
  ,pMrktg_BitMap                = 'Marketing_List._Config().Marketing_Bitmap'
  ,pMrktg_Approved_Sources      = 'Marketing_List._Config().set_marketing_approved_sources'
  ,pDebug                       = 'false'
  ,pCompileTest                 = 'false'
  ,pRun_in_Background           = 'true'                                       
) :=   
functionmacro
    
  build_name := Marketing_List._Config().name;
  
  ecl :=  '#workunit(\'name\', Marketing_List._Config().name + \' @version@ build\');\n\n#workunit(\'priority\',\'high\');\n'
                        + 'Marketing_List.Build_All('
                        + '\'@version@\'' + '\n'
                        + ',' + #TEXT(pDataset_Best          ) + '' + '\n'
                        + ',' + #TEXT(pDataset_Base          ) + '' + '\n'
                        + ',' + #TEXT(pdca_base              ) + '' + '\n'
                        + ',' + #TEXT(peq_biz_base           ) + '' + '\n'
                        + ',' + #TEXT(poshair_base           ) + '' + '\n'
                        + ',' + #TEXT(pcortera_base          ) + '' + '\n'
                        + ',' + #TEXT(pinfutor_base          ) + '' + '\n'
                        + ',' + #TEXT(paccutrend_base        ) + '' + '\n'
                        + ',' + #TEXT(pDataset_Crosswalk     ) + '' + '\n'
                        + ',' + #TEXT(pWatchdog_best_Key     ) + '' + '\n'
                        + ',' + #TEXT(pHeader_Segs_Key       ) + '' + '\n'
                        + ',' + #TEXT(pCounty_Names          ) + '' + '\n'
                        + ',' + #TEXT(pCity_Names            ) + '' + '\n'
                        + ',' + #TEXT(pEmployees_Ranking     ) + '' + '\n'
                        + ',' + #TEXT(pSales_Ranking         ) + '' + '\n'
                        + ',' + #TEXT(pMrktg_BitMap          ) + '' + '\n'
                        + ',' + #TEXT(pMrktg_Approved_Sources) + '' + '\n'
                        + ',' + #TEXT(pDebug                 ) + '' + '\n'
                        + ');';
                        
  cluster := Marketing_List._Config().Groupname;
  
  import Workman;
  
  Kick_Off_Build := Workman.mac_WorkMan(ecl ,pversion,cluster,1         ,1        ,pBuildName := build_name,pNotifyEmails := Marketing_List.Email_Notification_Lists().BuildSuccess
      ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::Marketing_List'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pCompileOnly      := pCompileTest
      ,pDont_Wait        := pRun_in_Background
  );

  return Kick_Off_Build;
  
endmacro;
