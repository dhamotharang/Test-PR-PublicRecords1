IMPORT AccountMonitoring;

EXPORT config_UpdateSuperFiles(AccountMonitoring.types.productMask product_mask = 
                                 AccountMonitoring.types.productMask.allProducts,
                                 boolean GetAll = false 
                                ) := function


//--------------------------------------------------------------------------------------------------------------------//
/*  Roxie Super key name vs Monitoring Superkey name. Currently 2 categories are available: 
    (1)PersonHeader (2)SBFE. More categories and their superfiles that this function should
     update can be added in this dataset. If there is a file that is used by multiple products       
*/
    
     Superfiles := DATASET([
                          {'thor_data400::key::header_qa','monitor::personheader',33554432},
                          {'thor_data400::key::sbfe::qa::linkids','monitor::sbfe::linkids',131072},
                          {'thor_data400::key::sbfe::qa::tradeline','monitor::sbfe::tradeline',131072},
                          {'thor_data400::key::sbfescoring::qa::scoringindex','monitor::sbfescoring::scoringindex',131072}
                         ],AccountMonitoring.layouts.UPDATE_SOURCE.roxie_monitor_superfile_layout);
                         
                              
   SuperfilesReturn := if(GetAll,Superfiles,Superfiles(AccountMonitoring.types.testPMBits(product_mask_supported, product_mask)));
return(SuperfilesReturn);
end;