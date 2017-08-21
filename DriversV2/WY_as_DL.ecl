import Ut, lib_stringlib, Drivers;

bad_names  := ['UNKNOWN','UNK','UNKN','NONE','N/A','UNAVAILABLE'];
bad_mnames := ['NMN','NMI'];

Layout_norm := record
  string1 addr_type;
  Drivers.Layout_WY_Full
end;

Layout_norm trfNormAddr(Drivers.Layout_WY_Full l, integer c) := transform
   self.addr_type             := choose(c, 'M','');
   self.orig_STREET_ADDRESS_1 := choose(c, l.orig_STREET_ADDRESS_1, l.orig_STREET_ADDRESS_2);
   self.orig_CITY_1 		  := choose(c, l.orig_CITY_1,           l.orig_CITY_2);
   self.orig_STATE_1		  := choose(c, l.orig_STATE_1,          l.orig_STATE_2);
   self.orig_ZIP_CODE_1 	  := choose(c, l.orig_ZIP_CODE_1,       l.orig_ZIP_CODE_2);
   self.clean_prim_range_1    := choose(c, l.clean_prim_range_1,    l.clean_prim_range_2);
   self.clean_predir_1        := choose(c, l.clean_predir_1,        l.clean_predir_2);
   self.clean_prim_name_1     := choose(c, l.clean_prim_name_1,     l.clean_prim_name_2);
   self.clean_addr_suffix_1   := choose(c, l.clean_addr_suffix_1,   l.clean_addr_suffix_2);
   self.clean_postdir_1       := choose(c, l.clean_postdir_1,       l.clean_postdir_2);
   self.clean_unit_desig_1    := choose(c, l.clean_unit_desig_1,    l.clean_unit_desig_2);
   self.clean_sec_range_1     := choose(c, l.clean_sec_range_1,     l.clean_sec_range_2);
   self.clean_p_city_name_1   := choose(c, l.clean_p_city_name_1,   l.clean_p_city_name_2);
   self.clean_v_city_name_1   := choose(c, l.clean_v_city_name_1,   l.clean_v_city_name_2);
   self.clean_st_1            := choose(c, l.clean_st_1,            l.clean_st_2);
   self.clean_zip_1           := choose(c, l.clean_zip_1,           l.clean_zip_2);
   self.clean_zip4_1          := choose(c, l.clean_zip4_1,          l.clean_zip4_2);
   self.clean_cart_1 		  := choose(c, l.clean_cart_1,          l.clean_cart_2);        
   self.clean_cr_sort_sz_1    := choose(c, l.clean_cr_sort_sz_1,    l.clean_cr_sort_sz_2);  
   self.clean_lot_1 		  := choose(c, l.clean_lot_1,           l.clean_lot_2);         
   self.clean_lot_order_1 	  := choose(c, l.clean_lot_order_1,     l.clean_lot_order_2);   
   self.clean_dpbc_1 		  := choose(c, l.clean_dpbc_1,          l.clean_dpbc_2);        
   self.clean_chk_digit_1 	  := choose(c, l.clean_chk_digit_1,     l.clean_chk_digit_2);   
   self.clean_record_type_1   := choose(c, l.clean_record_type_1,   l.clean_record_type_2); 
   self.clean_ace_fips_st_1   := choose(c, l.clean_ace_fips_st_1,   l.clean_ace_fips_st_2); 
   self.clean_fipscounty_1 	  := choose(c, l.clean_fipscounty_1,    l.clean_fipscounty_2);  
   self.clean_geo_lat_1 	  := choose(c, l.clean_geo_lat_1,       l.clean_geo_lat_2);     
   self.clean_geo_long_1 	  := choose(c, l.clean_geo_long_1,      l.clean_geo_long_2);    
   self.clean_msa_1 		  := choose(c, l.clean_msa_1,           l.clean_msa_2);         
   self.clean_geo_blk_1 	  := choose(c, l.clean_geo_blk_1,       l.clean_geo_blk_2);     
   self.clean_geo_match_1 	  := choose(c, l.clean_geo_match_1,     l.clean_geo_match_2);   
   self.clean_err_stat_1 	  := choose(c, l.clean_err_stat_1,      l.clean_err_stat_2);   
   self                       := l;
end;

norm_file := normalize(Drivers.File_WY_Full + Drivers.File_WY_Update, 
					   if(trim(left.clean_prim_range_2,left,right)  <> trim(left.clean_prim_range_1,left,right) and
						  trim(left.clean_predir_2,left,right)      <> trim(left.clean_predir_1,left,right) and
						  trim(left.clean_prim_name_2,left,right)   <> trim(left.clean_prim_name_1,left,right) and
						  trim(left.clean_addr_suffix_2,left,right) <> trim(left.clean_addr_suffix_1,left,right) and
						  trim(left.clean_postdir_2,left,right)     <> trim(left.clean_postdir_1,left,right) and
						  trim(left.clean_unit_desig_2,left,right)  <> trim(left.clean_unit_desig_1,left,right) and
						  trim(left.clean_sec_range_2,left,right)   <> trim(left.clean_sec_range_1,left,right) and
						  trim(left.clean_p_city_name_2,left,right) <> trim(left.clean_p_city_name_1,left,right) and
						  trim(left.clean_st_2,left,right)          <> trim(left.clean_st_1,left,right) and
						  trim(left.clean_zip_2,left,right)         <> trim(left.clean_zip_1,left,right) and
						  trim(left.clean_prim_name_2,left,right)   <> '' and
						  trim(left.clean_p_city_name_2,left,right) <> '' and
						  trim(left.clean_zip_2,left,right) <> '', 2, 1)
					   ,trfNormAddr(left, counter) 
					  );

DriversV2.Layout_DL_Extended tTransform_WY_To_Common(Layout_norm pInput)
 := transform
	self.orig_state 							:= 'WY';
	self.dt_first_seen 						:= (unsigned8)pInput.append_PROCESS_DATE div 100;
	self.dt_last_seen 						:= (unsigned8)pInput.append_PROCESS_DATE div 100;
	self.dt_vendor_first_reported := (unsigned8)pInput.append_PROCESS_DATE div 100;
	self.dt_vendor_last_reported  := (unsigned8)pInput.append_PROCESS_DATE div 100;
	self.dateReceived							:=	(integer)pInput.append_PROCESS_DATE;
	self.dl_number 								:= pInput.orig_DL_Number;
	self.name											:= lib_stringlib.stringlib.stringcleanspaces(pInput.orig_FIRST_NAME + pInput.orig_MIDDLE_NAME + pInput.orig_LAST_NAME);
	self.RawFullName							:= lib_stringlib.stringlib.stringcleanspaces(pInput.orig_FIRST_NAME + pInput.orig_MIDDLE_NAME + pInput.orig_LAST_NAME);
	self.dob 											:= (unsigned4)pInput.orig_DOB;
	//boolean lAddr2Filled	:= pInput.clean_zip_2 <> '';
	//boolean lAddr2Better	:= if(lAddr2Filled,
	//						      if(pInput.clean_prim_name_1[1..6] = 'PO BOX',
	//						         true,
	//						         false
	//						        ),
	//						      false
	//						     );	
	//self.addr1			:= if(lAddr2Better,pInput.orig_STREET_ADDRESS_2,pInput.orig_STREET_ADDRESS_1);
	//self.city 			:= if(lAddr2Better,pInput.orig_CITY_2,pInput.orig_CITY_1);
	//self.state			:= if(lAddr2Better,pInput.orig_STATE_2,pInput.orig_STATE_1);
	//self.zip 				:= if(lAddr2Better,pInput.orig_ZIP_CODE_2,pInput.orig_ZIP_CODE_1);
	self.addr_type          := pInput.addr_type;
	self.addr1				:= pInput.orig_STREET_ADDRESS_1;
	self.city 				:= pInput.orig_CITY_1;
	self.state				:= pInput.orig_STATE_1;
	self.zip 				:= pInput.orig_ZIP_CODE_1;
	self.expiration_date	:= (unsigned4)pInput.orig_EXPIRE_DATE;
	self.lic_issue_date 	:= (unsigned4)pInput.orig_ISSUE_DATE;
	// Following not provided, detailed here for info only (not omitted accidentally)
	self.orig_issue_date	:= 0;
	self.sex_flag			:= '';
	self.height				:= '';
	self.weight				:= '';
	self.OrigLicenseClass	:= 	pInput.orig_CODE_1 + 
														pInput.orig_CODE_2 + 
														pInput.orig_CODE_3 + 
														pInput.orig_CODE_4 + 
														pInput.orig_CODE_5 +
														pInput.orig_CODE_6 +
														pInput.orig_CODE_7 +
														pInput.orig_CODE_8;		
	self.OrigLicenseType	:= '';	
	self.license_type 		:= '';
	self.moxie_license_type 		:= '';
	self.restrictions 		:= '';
	self.lic_endorsement 	:= '';
	self.attention_flag		:= '';
	// End omitted fields
	self.title 				:= pInput.clean_name_prefix;
	self.fname 				:= if (trim(pInput.clean_name_first,left,right) in bad_names,'',pInput.clean_name_first);		                             
	self.mname 				:= if (trim(pInput.clean_name_middle,left,right) in bad_names + bad_mnames,'',pInput.clean_name_middle);	                             
	self.lname 				:= if (trim(pInput.clean_name_last,left,right) in bad_names,'',pInput.clean_name_last);		                             
	self.name_suffix 		:= pInput.clean_name_suffix;		                             
	self.cleaning_score 	:= pInput.clean_name_score;		                             
	self.prim_range			:= pInput.clean_prim_range_1;  
	self.predir 	    	:= pInput.clean_predir_1;      
	self.prim_name 	    	:= pInput.clean_prim_name_1;   
	self.suffix 	    	:= pInput.clean_addr_suffix_1; 
	self.postdir 	    	:= pInput.clean_postdir_1;     
	self.unit_desig     	:= pInput.clean_unit_desig_1;  
	self.sec_range 	    	:= pInput.clean_sec_range_1;   
	self.p_city_name    	:= pInput.clean_p_city_name_1; 
	self.v_city_name    	:= pInput.clean_v_city_name_1; 
	self.st 		    	:= pInput.clean_st_1;          
	self.zip5 		    	:= pInput.clean_zip_1;         
	self.zip4 		    	:= pInput.clean_zip4_1;        
	self.cart 		    	:= pInput.clean_cart_1;        
	self.cr_sort_sz     	:= pInput.clean_cr_sort_sz_1;  
	self.lot 		    	:= pInput.clean_lot_1;         
	self.lot_order 	    	:= pInput.clean_lot_order_1;   
	self.dpbc 		    	:= pInput.clean_dpbc_1;        
	self.chk_digit 	    	:= pInput.clean_chk_digit_1;   
	self.rec_type 	    	:= pInput.clean_record_type_1; 
	self.ace_fips_st    	:= pInput.clean_ace_fips_st_1; 
	self.county 	    	:= pInput.clean_fipscounty_1;  
	self.geo_lat 	    	:= pInput.clean_geo_lat_1;     
	self.geo_long 	    	:= pInput.clean_geo_long_1;    
	self.msa 		    	:= pInput.clean_msa_1;         
	self.geo_blk 	    	:= pInput.clean_geo_blk_1;     
	self.geo_match 	    	:= pInput.clean_geo_match_1;   
	self.err_stat 	    	:= pInput.clean_err_stat_1;    
	/*
	self.prim_range			:= if(lAddr2Better,pInput.clean_prim_range_2,   pInput.clean_prim_range_1);  
	self.predir 	    	:= if(lAddr2Better,pInput.clean_predir_2,       pInput.clean_predir_1);      
	self.prim_name 	    	:= if(lAddr2Better,pInput.clean_prim_name_2,    pInput.clean_prim_name_1);   
	self.suffix 	    	:= if(lAddr2Better,pInput.clean_addr_suffix_2,  pInput.clean_addr_suffix_1); 
	self.postdir 	    	:= if(lAddr2Better,pInput.clean_postdir_2,      pInput.clean_postdir_1);     
	self.unit_desig     	:= if(lAddr2Better,pInput.clean_unit_desig_2,   pInput.clean_unit_desig_1);  
	self.sec_range 	    	:= if(lAddr2Better,pInput.clean_sec_range_2,    pInput.clean_sec_range_1);   
	self.p_city_name    	:= if(lAddr2Better,pInput.clean_p_city_name_2,  pInput.clean_p_city_name_1); 
	self.v_city_name    	:= if(lAddr2Better,pInput.clean_v_city_name_2,  pInput.clean_v_city_name_1); 
	self.st 		    	:= if(lAddr2Better,pInput.clean_st_2,           pInput.clean_st_1);          
	self.zip5 		    	:= if(lAddr2Better,pInput.clean_zip_2,          pInput.clean_zip_1);         
	self.zip4 		    	:= if(lAddr2Better,pInput.clean_zip4_2,         pInput.clean_zip4_1);        
	self.cart 		    	:= if(lAddr2Better,pInput.clean_cart_2,         pInput.clean_cart_1);        
	self.cr_sort_sz     	:= if(lAddr2Better,pInput.clean_cr_sort_sz_2,   pInput.clean_cr_sort_sz_1);  
	self.lot 		    	:= if(lAddr2Better,pInput.clean_lot_2,          pInput.clean_lot_1);         
	self.lot_order 	    	:= if(lAddr2Better,pInput.clean_lot_order_2,    pInput.clean_lot_order_1);   
	self.dpbc 		    	:= if(lAddr2Better,pInput.clean_dpbc_2,         pInput.clean_dpbc_1);        
	self.chk_digit 	    	:= if(lAddr2Better,pInput.clean_chk_digit_2,    pInput.clean_chk_digit_1);   
	self.rec_type 	    	:= if(lAddr2Better,pInput.clean_record_type_2,  pInput.clean_record_type_1); 
	self.ace_fips_st    	:= if(lAddr2Better,pInput.clean_ace_fips_st_2,  pInput.clean_ace_fips_st_1); 
	self.county 	    	:= if(lAddr2Better,pInput.clean_fipscounty_2,   pInput.clean_fipscounty_1);  
	self.geo_lat 	    	:= if(lAddr2Better,pInput.clean_geo_lat_2,      pInput.clean_geo_lat_1);     
	self.geo_long 	    	:= if(lAddr2Better,pInput.clean_geo_long_2,     pInput.clean_geo_long_1);    
	self.msa 		    	:= if(lAddr2Better,pInput.clean_msa_2,          pInput.clean_msa_1);         
	self.geo_blk 	    	:= if(lAddr2Better,pInput.clean_geo_blk_2,      pInput.clean_geo_blk_1);     
	self.geo_match 	    	:= if(lAddr2Better,pInput.clean_geo_match_2,    pInput.clean_geo_match_1);   
	self.err_stat 	    	:= if(lAddr2Better,pInput.clean_err_stat_2,     pInput.clean_err_stat_1);    
	*/
	self.issuance 		    := ''; // had to include explcitly because no default for some reason
	self                    := pInput;     
end;

export WY_as_DL := project(norm_file, tTransform_WY_To_Common(left)) :persist(DriversV2.Constants.Cluster + 'Persist::DL2::DrvLic_WY_as_DL');