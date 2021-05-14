import BIPV2;

EXPORT Build_All(
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
  ,pSampleProxids               = '[]'
	,pIsTesting                   = 'tools._Constants.IsDataland'

) :=
functionmacro

  import tools,BIPV2;
  
  // -- Generate Business Information Dataset
  ds_business_info := Marketing_List.Create_Business_Information_File(
                         pversion
                        ,pDataset_Best              
                        ,pDataset_Base              
                        ,pdca_base                  
                        ,peq_biz_base               
                        ,poshair_base               
                        ,pcortera_base              
                        ,pinfutor_base              
                        ,paccutrend_base            
                        ,pDebug 
                        ,pSampleProxids
                        ,pEmployees_Ranking         
                        ,pSales_Ranking             
                        ,pMrktg_BitMap              
                        ,pMrktg_Approved_Sources    
  );

  // -- Generate Business Contact Dataset
  ds_business_contact     := Marketing_List.Create_Business_Contact_File(pversion,pDataset_Crosswalk ,pMrktg_BitMap,,pWatchdog_best_Key,pHeader_Segs_Key,pCounty_Names,pCity_Names,pDebug,pSampleProxids);
  
  // -- reformat to output layout(above files have some extra fields for research)
  ds_business_info_out    := project(ds_business_info     ,Marketing_List.Layouts.business_information      );
  ds_business_contact_out := project(ds_business_contact  ,Marketing_List.Layouts.business_contact          );
  
  // -- Write out both files to disk
  output_business_info    := tools.macf_WriteFile(Marketing_List.Filenames(pversion).business_information.logical ,ds_business_info_out     ,pOverwrite := true);
  output_business_contact := tools.macf_WriteFile(Marketing_List.Filenames(pversion).business_contact.logical     ,ds_business_contact_out  ,pOverwrite := true);

  // -- Do Strata stats
  do_strata_stats         := Marketing_List.Strata_Stats(pversion,,,pIsTesting);

  return_result := sequential(

     output_business_info
    ,Marketing_List.Promote(pversion).new2built
    ,output_business_contact
    ,Marketing_List.Promote(pversion).new2built
    ,do_strata_stats
  
  ) : success(Marketing_List.Send_Emails(pversion).BuildSuccess) ,failure(Marketing_List.Send_Emails(pversion).BuildFailure);
  
  return return_result;

endmacro;