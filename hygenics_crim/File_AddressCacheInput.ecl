  //combine the persist files	to create cache
	file_to_cache := dataset('~thor_data200::persist::crim::aocaddresscache',layout_temp_offender,flat)+     
                   dataset('~thor_data200::persist::crim::aocpancoraddresscache',layout_temp_offender,flat)+   
                   // dataset('~thor_data200::persist::crim::DOCAddresscache',layout_temp_offender,flat)+
                   dataset('~thor_data200::persist::crim::countyaddresscache',layout_temp_offender,flat)+       
                   dataset('~thor_data200::persist::crim::arrestaddresscache',layout_temp_offender,flat); 

 Generate_cache :=  project(file_to_cache(street_address_1+street_address_2 <> '' and geo_match <> '5' ),hygenics_crim.Layout_Address_cache);
 
EXPORT File_AddressCacheInput := Generate_cache;