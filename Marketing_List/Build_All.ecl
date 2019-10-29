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
  ,pcontact_linkids_base        = 'Marketing_List.Source_Files().contacts_key'            
  ,pcontact_title_linkids_base  = 'Marketing_List.Source_Files().contact_Titles_key'      
  ,pEmployees_Ranking           = 'Marketing_List._Config().ds_sources_of_number_of_employees'
  ,pSales_Ranking               = 'Marketing_List._Config().ds_sources_of_sales_revenue'
  ,pMrktg_BitMap                = 'Marketing_List._Config().Marketing_Bitmap'
  ,pMrktg_Approved_Sources      = 'Marketing_List._Config().set_marketing_approved_sources'
  ,pDoSample                    = 'false'
  ,pDebug                       = 'false'


) :=
functionmacro

  import tools,BIPV2;
  
  ds_base := Marketing_List.Create_Business_Information_File(
               pDataset_Best              
              ,pDataset_Base              
              ,pdca_base                  
              ,peq_biz_base               
              ,poshair_base               
              ,pcortera_base              
              ,pinfutor_base              
              ,paccutrend_base            
              ,pEmployees_Ranking         
              ,pSales_Ranking             
              ,pMrktg_BitMap              
              ,pMrktg_Approved_Sources    
              ,pDoSample                  
              ,pDebug                     
  );

  output_base := tools.macf_WriteFile(Marketing_List.Filenames(pversion).business_information.logical ,ds_base  ,pOverwrite := true);

  return_result := sequential(

     output_base
    ,Marketing_List.Promote(pversion).new2built
    ,Marketing_List.Strata_Stats(pversion)
  
  ) : success(Marketing_List.Send_Emails(pversion).BuildSuccess) ,failure(Marketing_List.Send_Emails(pversion).BuildFailure);
  
  return return_result;

endmacro;