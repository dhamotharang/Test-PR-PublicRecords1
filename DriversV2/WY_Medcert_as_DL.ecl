IMPORT Ut, lib_stringlib, Drivers, DriversV2;

EXPORT WY_Medcert_as_DL(dataset(DriversV2.Layouts_DL_WY_In.Layout_WY_MedCert_Cleaned) pFile_WY_Input) := function

bad_names  := ['UNKNOWN','UNK','UNKN','NONE','N/A','UNAVAILABLE'];
bad_mnames := ['NMN','NMI'];

Layout_norm := RECORD
  STRING1 addr_type;
  DriversV2.Layouts_DL_WY_In.Layout_WY_MedCert_Temp
END;

Layout_norm trfNormAddr(DriversV2.Layouts_DL_WY_In.Layout_WY_MedCert_Cleaned l, INTEGER c) := TRANSFORM
   SELF.addr_type      := CHOOSE(c, 'M','P');
   SELF.STREET_ADDR    := CHOOSE(c, l.mailing_STREET_ADDR_1, l.phys_STREET_ADDR_2);
   SELF.CITY 		       := CHOOSE(c, l.mailing_CITY_1,        l.phys_CITY_2);
   SELF.STATE		       := CHOOSE(c, l.mailing_STATE_1,       l.phys_STATE_2);
   SELF.ZIP_CODE 	     := CHOOSE(c, l.mailing_ZIP_CODE_1,    l.phys_ZIP_CODE_2);
   SELF                := l;
END;

norm_file := NORMALIZE(pFile_WY_Input,
                       IF(TRIM(LEFT.phys_STREET_ADDR_2) != '' AND TRIM(LEFT.phys_CITY_2) != '' AND TRIM(LEFT.phys_ZIP_CODE_2) != '',2,1),
											 trfNormAddr(LEFT, COUNTER));

DriversV2.Layout_DL_Extended tTransform_WY_To_Common(Layout_norm pInput) := TRANSFORM
	SELF.orig_state 							:= 'WY';
	SELF.dt_first_seen 						:= (UNSIGNED8)pInput.append_PROCESS_DATE div 100;
	SELF.dt_last_seen 						:= (UNSIGNED8)pInput.append_PROCESS_DATE div 100;
	SELF.dt_vendor_first_reported := (UNSIGNED8)pInput.append_PROCESS_DATE div 100;
	SELF.dt_vendor_last_reported  := (UNSIGNED8)pInput.append_PROCESS_DATE div 100;
	SELF.dateReceived							:= (INTEGER)pInput.append_PROCESS_DATE;
	SELF.dl_number 								:= pInput.orig_DL_Number;
	SELF.name											:= lib_stringlib.stringlib.stringcleanspaces(TRIM(pInput.orig_FIRST_NAME) +' '+ TRIM(pInput.orig_MIDDLE_NAME)+' ' + TRIM(pInput.orig_LAST_NAME));
	SELF.RawFullName							:= lib_stringlib.stringlib.stringcleanspaces(TRIM(pInput.orig_FIRST_NAME) +' '+ TRIM(pInput.orig_MIDDLE_NAME)+' ' + TRIM(pInput.orig_LAST_NAME));
	SELF.dob 											:= (UNSIGNED4)pInput.orig_DOB;
	SELF.addr_type                := pInput.addr_type;
	SELF.addr1				            := pInput.STREET_ADDR;
	SELF.city 			            	:= pInput.CITY;
	SELF.state				            := pInput.STATE;
	SELF.zip 			              	:= pInput.ZIP_CODE;
	SELF.expiration_date	        := (UNSIGNED4)pInput.orig_EXPIRE_DATE;
	SELF.lic_issue_date 	        := (UNSIGNED4)pInput.orig_ISSUE_DATE;
	// Following not provided, detailed here for info only (not omitted accidentally)
	SELF.orig_issue_date	        := 0;
	SELF.sex_flag		            	:= '';
	SELF.height			            	:= '';
	SELF.weight			            	:= '';
	SELF.OrigLicenseClass	        := 	pInput.orig_CODE_1 + 
													        	pInput.orig_CODE_2 + 
													        	pInput.orig_CODE_3 + 
														        pInput.orig_CODE_4 + 
													        	pInput.orig_CODE_5 +
													        	pInput.orig_CODE_6 +
													        	pInput.orig_CODE_7 +
														        pInput.orig_CODE_8;		
	SELF.OrigLicenseType	        := '';	
	SELF.license_type 		        := '';
	SELF.moxie_license_type 	   	:= '';
	SELF.restrictions 		        := '';
	SELF.lic_endorsement        	:= '';
	SELF.attention_flag		        := '';
	// End omitted fields
	SELF.title 				            := pInput.clean_name_prefix;
	SELF.fname 				            := IF(TRIM(pInput.clean_name_first,left,right) in bad_names,'',pInput.clean_name_first);		                             
	SELF.mname 				            := IF(TRIM(pInput.clean_name_middle,left,right) in bad_names + bad_mnames,'',pInput.clean_name_middle);	                             
	SELF.lname 				            := IF(TRIM(pInput.clean_name_last,left,right) in bad_names,'',pInput.clean_name_last);		                             
	SELF.name_suffix 		          := pInput.clean_name_suffix;		                             
	SELF.cleaning_score         	:= pInput.clean_name_score;		                             
	SELF.prim_range		          	:= '';  
	SELF.predir 	    	          := '';       
	SELF.prim_name 	            	:= '';     
	SELF.suffix 	    	          := '';   
	SELF.postdir 	    	          := '';       
	SELF.unit_desig     	        := '';    
	SELF.sec_range 	      	      := '';     
	SELF.p_city_name    	        := '';   
	SELF.v_city_name            	:= '';   
	SELF.st 		                	:= '';            
	SELF.zip5 		    	          := '';           
	SELF.zip4 		              	:= '';          
	SELF.cart 		              	:= '';          
	SELF.cr_sort_sz             	:= '';    
	SELF.lot 		    	            := '';           
	SELF.lot_order 	    	        := '';     
	SELF.dpbc 		                := '';          
	SELF.chk_digit 	    	        := '';     
	SELF.rec_type 	    	        := '';   
	SELF.ace_fips_st    	        := '';   
	SELF.county 	    	          := '';    
	SELF.geo_lat 	              	:= '';       
	SELF.geo_long 	            	:= '';      
	SELF.msa 		    	            := '';           
	SELF.geo_blk 	                := '';       
	SELF.geo_match 	    	        := '';     
	SELF.err_stat 	    	        := '';      
	SELF.issuance 		            := ''; 
	SELF                          := pInput;     
END;

WY_Medcert_as_DL_mapper := PROJECT(norm_file, tTransform_WY_To_Common(LEFT));

return WY_Medcert_as_DL_mapper;

end;