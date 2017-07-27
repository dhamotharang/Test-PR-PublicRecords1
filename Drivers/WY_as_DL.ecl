import Ut, lib_stringlib;

Drivers.Layout_DL tTransform_WY_To_Common(Drivers.Layout_WY_Full pInput)
 := transform
    self.dt_first_seen 				:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.dt_last_seen 				:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.dt_vendor_first_reported 	:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.dt_vendor_last_reported 	:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.orig_state 				:= 'WY';
	self.dl_number 					:= pInput.orig_DL_Number;
	self.name						:= lib_stringlib.stringlib.stringcleanspaces(pInput.orig_FIRST_NAME + pInput.orig_MIDDLE_NAME + pInput.orig_LAST_NAME);
	self.dob 						:= (unsigned4)pInput.orig_DOB;
	boolean lAddr2Filled			:= pInput.clean_zip_2 <> '';
	boolean lAddr2Better			:= if(lAddr2Filled,
										  if(pInput.clean_prim_name_1[1..6] = 'PO BOX',
										     true,
											 false
											),
										  false
										 );	
	self.addr1						:= if(lAddr2Better,pInput.orig_STREET_ADDRESS_2,pInput.orig_STREET_ADDRESS_1);
	self.city 						:= if(lAddr2Better,pInput.orig_CITY_2,pInput.orig_CITY_1);
	self.state						:= if(lAddr2Better,pInput.orig_STATE_2,pInput.orig_STATE_1);
	self.zip 						:= if(lAddr2Better,pInput.orig_ZIP_CODE_2,pInput.orig_ZIP_CODE_1);
	self.orig_expiration_date		:= (unsigned4)pInput.orig_EXPIRE_DATE;
	self.lic_issue_date 			:= (unsigned4)pInput.orig_ISSUE_DATE;
	// Following not provided, detailed here for info only (not omitted accidentally)
	self.orig_issue_date			:= 0;
	self.sex_flag					:= '';
	self.height						:= '';
	self.weight						:= '';
	self.license_type 				:= '';
	self.restrictions 				:= '';
	self.lic_endorsement 			:= '';
	self.attention_flag				:= '';
	// End omitted fields
	self.title 						:= pInput.clean_name_prefix;
	self.fname 						:= pInput.clean_name_first;		                             
	self.mname 						:= pInput.clean_name_middle;		                             
	self.lname 						:= pInput.clean_name_last;		                             
	self.name_suffix 				:= pInput.clean_name_suffix;		                             
	self.cleaning_score 			:= pInput.clean_name_score;		                             
	self.prim_range					:= if(lAddr2Better,pInput.clean_prim_range_2,   pInput.clean_prim_range_1);  
	self.predir 	    			:= if(lAddr2Better,pInput.clean_predir_2,       pInput.clean_predir_1);      
	self.prim_name 	    			:= if(lAddr2Better,pInput.clean_prim_name_2,    pInput.clean_prim_name_1);   
	self.suffix 	    			:= if(lAddr2Better,pInput.clean_addr_suffix_2,  pInput.clean_addr_suffix_1); 
	self.postdir 	    			:= if(lAddr2Better,pInput.clean_postdir_2,      pInput.clean_postdir_1);     
	self.unit_desig     			:= if(lAddr2Better,pInput.clean_unit_desig_2,   pInput.clean_unit_desig_1);  
	self.sec_range 	    			:= if(lAddr2Better,pInput.clean_sec_range_2,    pInput.clean_sec_range_1);   
	self.p_city_name    			:= if(lAddr2Better,pInput.clean_p_city_name_2,  pInput.clean_p_city_name_1); 
	self.v_city_name    			:= if(lAddr2Better,pInput.clean_v_city_name_2,  pInput.clean_v_city_name_1); 
	self.st 		    			:= if(lAddr2Better,pInput.clean_st_2,           pInput.clean_st_1);          
	self.zip5 		    			:= if(lAddr2Better,pInput.clean_zip_2,          pInput.clean_zip_1);         
	self.zip4 		    			:= if(lAddr2Better,pInput.clean_zip4_2,         pInput.clean_zip4_1);        
	self.cart 		    			:= if(lAddr2Better,pInput.clean_cart_2,         pInput.clean_cart_1);        
	self.cr_sort_sz     			:= if(lAddr2Better,pInput.clean_cr_sort_sz_2,   pInput.clean_cr_sort_sz_1);  
	self.lot 		    			:= if(lAddr2Better,pInput.clean_lot_2,          pInput.clean_lot_1);         
	self.lot_order 	    			:= if(lAddr2Better,pInput.clean_lot_order_2,    pInput.clean_lot_order_1);   
	self.dpbc 		    			:= if(lAddr2Better,pInput.clean_dpbc_2,         pInput.clean_dpbc_1);        
	self.chk_digit 	    			:= if(lAddr2Better,pInput.clean_chk_digit_2,    pInput.clean_chk_digit_1);   
	self.rec_type 	    			:= if(lAddr2Better,pInput.clean_record_type_2,  pInput.clean_record_type_1); 
	self.ace_fips_st    			:= if(lAddr2Better,pInput.clean_ace_fips_st_2,  pInput.clean_ace_fips_st_1); 
	self.county 	    			:= if(lAddr2Better,pInput.clean_fipscounty_2,   pInput.clean_fipscounty_1);  
	self.geo_lat 	    			:= if(lAddr2Better,pInput.clean_geo_lat_2,      pInput.clean_geo_lat_1);     
	self.geo_long 	    			:= if(lAddr2Better,pInput.clean_geo_long_2,     pInput.clean_geo_long_1);    
	self.msa 		    			:= if(lAddr2Better,pInput.clean_msa_2,          pInput.clean_msa_1);         
	self.geo_blk 	    			:= if(lAddr2Better,pInput.clean_geo_blk_2,      pInput.clean_geo_blk_1);     
	self.geo_match 	    			:= if(lAddr2Better,pInput.clean_geo_match_2,    pInput.clean_geo_match_1);   
	self.err_stat 	    			:= if(lAddr2Better,pInput.clean_err_stat_2,     pInput.clean_err_stat_1);    
	self.issuance 					:= ''; // had to include explcitly because no default for some reason
end;

export WY_as_DL := project(Drivers.File_WY_Full + Drivers.File_WY_Update, tTransform_WY_To_Common(left));