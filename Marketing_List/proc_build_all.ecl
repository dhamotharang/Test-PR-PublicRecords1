import BIPV2_Files,tools,BIPV2,BIPV2_ProxID,bipv2_build;
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
  ,pcontact_linkids_base        = 'Marketing_List.Source_Files().contacts_key'            
  ,pcontact_title_linkids_base  = 'Marketing_List.Source_Files().contact_Titles_key'      
  ,pEmployees_Ranking           = 'Marketing_List._Config().ds_sources_of_number_of_employees'
  ,pSales_Ranking               = 'Marketing_List._Config().ds_sources_of_sales_revenue'
  ,pMrktg_BitMap                = 'Marketing_List._Config().Marketing_Bitmap'
  ,pMrktg_Approved_Sources      = 'Marketing_List._Config().set_marketing_approved_sources'
  ,pDoSample                    = 'false'
  ,pDebug                       = 'false'
  ,pCompileTest                 = 'false'
) :=
functionmacro
  
  import workman,tools;
  
  build_name := Marketing_List._Config().name;
  
  ecl :=  '#workunit(\'name\', Marketing_List._Config().name + \'@version@ build\');\n\n#workunit(\'priority\',\'high\');\n'
                        + 'Marketing_List.Build_All('
                        + '\'@version@\'' + '\n'
                        + ',' + #TEXT(pDataset_Best              ) + '' + '\n'
                        + ',' + #TEXT(pDataset_Base              ) + '' + '\n'
                        + ',' + #TEXT(pdca_base                  ) + '' + '\n'
                        + ',' + #TEXT(peq_biz_base               ) + '' + '\n'
                        + ',' + #TEXT(poshair_base               ) + '' + '\n'
                        + ',' + #TEXT(pcortera_base              ) + '' + '\n'
                        + ',' + #TEXT(pinfutor_base              ) + '' + '\n'
                        + ',' + #TEXT(paccutrend_base            ) + '' + '\n'
                        + ',' + #TEXT(pcontact_linkids_base      ) + '' + '\n'
                        + ',' + #TEXT(pcontact_title_linkids_base) + '' + '\n'
                        + ',' + #TEXT(pEmployees_Ranking         ) + '' + '\n'
                        + ',' + #TEXT(pSales_Ranking             ) + '' + '\n'
                        + ',' + #TEXT(pMrktg_BitMap              ) + '' + '\n'
                        + ',' + #TEXT(pMrktg_Approved_Sources    ) + '' + '\n'
                        + ',' + #TEXT(pDoSample                  ) + '' + '\n'
                        + ',' + #TEXT(pDebug                     ) + '' + '\n'
                        + ');';
                        
  cluster := Marketing_List._Config().Groupname;
  
  Kick_Off_Build := Workman.mac_WorkMan(ecl ,pversion,cluster,1         ,1        ,pBuildName := build_name,pNotifyEmails := Marketing_List.Email_Notification_Lists().BuildSuccess
      ,pOutputFilename   := '~bipv2_build::' + pversion + '::workunit_history::Marketing_List'
      ,pOutputSuperfile  := '~bipv2_build::qa::workunit_history' 
      ,pCompileOnly      := pCompileTest
  );

  return Kick_Off_Build;
  
  
endmacro;
