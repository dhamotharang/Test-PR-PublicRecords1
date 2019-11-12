﻿EXPORT dictIndexDef  ( string superkeyname)  := function
return case( trim(superkeyname) ,
'thor_data400::key::watchdog_qa' => 'dx_BestRecords.key_watchdog()',
'thor_data400::key::adl_segmentation_qa'                        =>   'header.key_ADL_segmentation()' ,                                
'thor_data400::key::ssn_bads_qa'                                =>   'Suppress.Key_SSN_Bad()' ,                                       
'thor_data400::key::watchdog_best.did_nonblank_qa'              =>   'Watchdog.key_watchdog_glb_nonblank_old()' ,                     
'thor_data400::key::watchdog_best.did_qa'                       =>   'watchdog.Key_Prep_Watchdog_GLB()' ,                             
'thor_data400::key::watchdog_best.name_city_st_qa'              =>   'Watchdog.Key_Best_Name_City_State()' ,                          
'thor_data400::key::watchdog_best.ssn_qa'                       =>   'watchdog.Key_Prep_Best_SSN()' ,                                 
'thor_data400::key::watchdog_best_nonen.did_nonblank_qa'        =>   'Watchdog.Key_Watchdog_GLB_nonExperian_nonblank_old()' ,         
'thor_data400::key::watchdog_best_nonen.did_qa'                 =>   'Watchdog.Key_Watchdog_GLB_nonExperian_old()' ,                  
'thor_data400::key::watchdog_best_nonen_noneq.did_nonblank_qa'  =>   'Watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax_nonblank_old()',
'thor_data400::key::watchdog_best_nonen_noneq.did_qa'           =>   'Watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax_old()' ,       
'thor_data400::key::watchdog_best_noneq.did_nonblank_qa'        =>   'Watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax_nonblank_old()',
'thor_data400::key::watchdog_best_noneq.did_qa'                 =>   'Watchdog.Key_Watchdog_GLB_nonEquifax_old()' ,                   
'thor_data400::key::watchdog_best_nonutil.did_nonblank_qa'      =>   'Watchdog.key_Prep_Watchdog_glb_nonutil_nonblank(true)' ,        
'thor_data400::key::watchdog_best_nonutil.did_qa'               =>   'watchdog.Key_Prep_Watchdog_GLB(true)' ,                         
'thor_data400::key::watchdog_best_supplemental::did_qa'         =>   'Watchdog.Key_Supplemental()' ,                                  
'thor_data400::key::watchdog_nonglb.did_nonblank_qa'            =>   'Watchdog.key_Prep_Watchdog_nonglb_nonblank(false)' ,            
'thor_data400::key::watchdog_nonglb.did_qa'                     =>   'watchdog.Key_Prep_Watchdog_nonglb(false)' ,                     
'thor_data400::key::watchdog_nonglb.teaser_qa'                  =>   'Watchdog.Key_Prep_Watchdog_teaser(false)' ,                     
'thor_data400::key::watchdog_nonglb_noneq.did_nonblank_qa'      =>   'Watchdog.key_Prep_Watchdog_nonglb_nonblank(true)' ,             
'thor_data400::key::watchdog_nonglb_noneq.did_qa'                 =>   'watchdog.Key_Prep_Watchdog_nonglb(true)' ,                      
'thor_data400::key::watchdog_nonglb_noneq.teaser_qa '          =>    'Watchdog.Key_Prep_Watchdog_teaser(true)' ,  
  'thor_data400::key::watchdog_best::fcra::nonen_did_qa' => 'Watchdog.Key_Watchdog_FCRA_nonEN()',
'thor_data400::key::watchdog_best::FCRA::nonEQ_did'                        =>   'Watchdog.Key_Watchdog_FCRA_nonEQ()' ,   
'thor_data400::key::watchdog_marketing.did_qa'         => 'watchdog.Key_Prep_Watchdog_marketing(false)',
'thor_data400::key::watchdog_marketing_noneq.did_qa' => 'watchdog.Key_Prep_Watchdog_marketing(true)',
 
											 '');
											 
end;