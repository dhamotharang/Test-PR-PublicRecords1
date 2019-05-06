IMPORT AccountMonitoring;

EXPORT config_UpdateSuperFiles(AccountMonitoring.types.productMask product_mask = 
                                 AccountMonitoring.types.productMask.allProducts,
                                 boolean GetAll = false 
                                ) := function



/*  Roxie Super key name vs Monitoring Superkey name. More categories and their superfiles 
     that fn_UpdateSuperFiles function should update can be added in this dataset. If there is a file that 
     is used by multiple products,just add all their product masks. 
     Example : AccountMonitoring.types.productMask.abc + 
               AccountMonitoring.types.productMask.xyz          
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
                   ],AccountMonitoring.layouts.UPDATE_SOURCE.roxie_monitor_superfile_layout);
                         
                              
   SuperfilesReturn := if(GetAll,Superfiles,Superfiles(AccountMonitoring.types.testPMBits(product_mask_supported, product_mask)));
return(SuperfilesReturn);
end;