IMPORT AccountMonitoring;

EXPORT config_UpdateSuperFiles(AccountMonitoring.types.productMask product_mask = 
                                 AccountMonitoring.types.productMask.allProducts,
                                 boolean GetAll = false 
                                ) := function



/* This config file is based on the following layout: 
   
roxie_monitor_superfile_layout := RECORD
  STRING250 RoxieSuperFile;    // Name of the Roxie superfile.  
  STRING250 MonitorSuperFile;  // Name (unique portion of the name - without prefix and suffix) of the new superfile on thor that will contain the same data as the Roxie superfile. 
  UNSIGNED8 product_mask_supported; // The sum of all the product's product-masks that this superfile will be used for. 
end;

       
*/
    
     Superfiles := DATASET([
                    {
                     'thor_data400::key::header_qa',
                     'monitor::personheader', 
                     AccountMonitoring.types.productMask.personheader 
                    },
                    {
                      'thor_data400::key::sbfe::qa::linkids',
                      'monitor::sbfe::linkids',
                      AccountMonitoring.types.productMask.sbfe 
                    },
                    {
                     'thor_data400::key::sbfe::qa::tradeline',
                      'monitor::sbfe::tradeline', 
                      AccountMonitoring.types.productMask.sbfe 
                    },
                    {
                     'thor_data400::key::sbfescoring::qa::scoringindex',
                     'monitor::sbfescoring::scoringindex', 
                     AccountMonitoring.types.productMask.sbfe 
                    }
                    ,{
                       AccountMonitoring.product_files.Email.emailLexid_superfile,
                       AccountMonitoring.product_files.Email.emailLexid_for_superkey_monitor,
                       AccountMonitoring.types.productMask.email 
                    }
                    ,{
                       AccountMonitoring.product_files.Email.emailaddr_superfile,
                       AccountMonitoring.product_files.Email.emailaddr_for_superkey_monitor,
                       AccountMonitoring.types.productMask.email 
                    }
                    ,{
                       AccountMonitoring.product_files.Email.emailmain_superfile,
                       AccountMonitoring.product_files.Email.emailmain_for_superkey_monitor,
                       AccountMonitoring.types.productMask.email 
                    }
                   ],AccountMonitoring.layouts.UPDATE_SOURCE.roxie_monitor_superfile_layout);
                         
                              
   SuperfilesReturn := if(GetAll,Superfiles,Superfiles(AccountMonitoring.types.testPMBits(product_mask_supported, product_mask)));
  return(SuperfilesReturn);
end;