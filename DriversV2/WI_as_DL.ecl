import lib_stringlib, Drivers;

export WI_as_DL(dataset(Drivers.Layout_WI_Full) pFile_WI_Input) := function

//dWI := distribute(Drivers.File_WI_Full,hash(orig_dl_number)) + distribute(DriversV2.File_DL_WI_Update,hash(orig_dl_number));
dWI := distribute(pFile_WI_Input,hash(orig_dl_number));

// dWIOptOut := dedup(sort(dWI(orig_opt_out_code	=	'S'),orig_DL_NUMBER,-append_PROCESS_DATE,local),orig_DL_NUMBER,local);

// recordof(dWI) tremoveOptOut(dWI le, dWIOptOut ri) :=
// transform
	// self := le;
// end;

// dWIFinal := join( dWI,
									// dWIOptOut,
									// left.orig_DL_NUMBER = right.orig_DL_NUMBER and 
									// left.append_process_date<=right.append_process_date,
									// tremoveoptout(left,right),
									// left only,
									// local
								// );

bad_names  := ['UNKNOWN','UNK','UNKN','NONE','N/A','UNAVAILABLE'];
bad_mnames := ['NMN','NMI'];

DriversV2.Layout_DL_Extended lTransform_WI_To_Common(dWI pInput)
 := transform
	self.orig_state 		      		:= 'WI';
	self.dt_first_seen 		      	:= (unsigned8)pInput.append_process_date div 100;
	self.dt_last_seen 		     		:= (unsigned8)pInput.append_process_date div 100;
	self.dt_vendor_first_reported := (unsigned8)pInput.append_process_date div 100;
	self.dt_vendor_last_reported  := (unsigned8)pInput.append_process_date div 100;
	self.dateReceived							:= (integer)pInput.append_process_date;	
  self.name					      			:= trim(pInput.orig_FIRST_NAME)
																		+ trim(' ' + pInput.orig_MIDDLE_INITIAL)
																		+ trim(' ' + pInput.orig_LAST_NAME);
  self.RawFullName	      			:= trim(pInput.orig_FIRST_NAME)
																		+ trim(' ' + pInput.orig_MIDDLE_INITIAL)
																		+ trim(' ' + pInput.orig_LAST_NAME);																		
	self.addr1					  				:= pInput.orig_ADDRESS1;
	self.city 					  				:= pInput.orig_CITY;		                             
	self.state					 					:= pInput.orig_STATE;
	self.zip 					  					:= pInput.orig_ZIP_CODE;		                             
	self.dob 					  					:= (unsigned4)pInput.orig_DOB;
	self.sex_flag				  				:= pInput.orig_SEX;
	self.license_class 		  	    := pInput.append_CLASSES;
	self.license_type 		   	 	  := pInput.append_LICENSE_TYPE;
	self.OrigLicenseClass 			  := pInput.append_CLASSES;
	self.OrigLicenseType 		   		:= pInput.append_LICENSE_TYPE;	
	self.moxie_license_type 			:= pInput.append_LICENSE_TYPE;
	self.expiration_date	      	:= (unsigned4)pInput.append_EXPIRATION_DATE;
	self.lic_issue_date 	      	:= (unsigned4)pInput.append_ISSUE_DATE;
	// Let's put both append_CLASSES and append_LICENSE_TYPE into the lic_endorsement
	// field and put both into the appropriate CODES_V3 table.  The codes do not
	// overlap and seem somewhat similar in use.
	//self.lic_endorsement 	      := lib_stringlib.stringlib.StringFilterOut(pInput.append_CLASSES + pInput.append_ENDORSEMENTS,' D');
	self.lic_endorsement 	      	:= pInput.append_ENDORSEMENTS;
	self.dl_number 				  			:= pInput.orig_DL_NUMBER;
	self.title 					  				:= pInput.clean_name_prefix;
	self.fname 					  				:= if (trim(pInput.clean_name_first,left,right) in bad_names,'',pInput.clean_name_first);		                             
	self.mname 					  				:= if (trim(pInput.clean_name_middle,left,right) in bad_names + bad_mnames,'',pInput.clean_name_middle);		                             
	self.lname 					  				:= if (trim(pInput.clean_name_last,left,right) in bad_names,'',pInput.clean_name_last);		                             
	self.name_suffix 			  			:= pInput.clean_name_suffix;		                             
	self.cleaning_score 	      	:= pInput.clean_name_score;		                             
	self.prim_range 			  			:= pInput.clean_prim_range;		                             
	self.predir 				  				:= pInput.clean_predir;		                             
	self.prim_name 				  			:= pInput.clean_prim_name;		                             
	self.suffix 				  				:= pInput.clean_addr_suffix;		                             
	self.postdir 				  				:= pInput.clean_postdir;		                             
	self.unit_desig 			 				:= pInput.clean_unit_desig;		                             
	self.sec_range 				  			:= pInput.clean_sec_range;		                             
	self.p_city_name 			  			:= pInput.clean_p_city_name;		                             
	self.v_city_name 			  			:= pInput.clean_v_city_name;		                             
	self.st 					  					:= pInput.clean_st;		                             
	self.zip5 					  				:= pInput.clean_zip;		                             
	self.zip4 					  				:= pInput.clean_zip4;		                             
	self.cart 					  				:= pInput.clean_cart;		                             
	self.cr_sort_sz 			  			:= pInput.clean_cr_sort_sz;		                             
	self.lot 					  					:= pInput.clean_lot;		                             
	self.lot_order 				  			:= pInput.clean_lot_order;		                             
	self.dpbc 					  				:= pInput.clean_dpbc;		                             
	self.chk_digit 				 				:= pInput.clean_chk_digit;		                             
	self.rec_type 				  			:= pInput.clean_record_type;		                             
	self.ace_fips_st 			  			:= pInput.clean_ace_fips_st;		                             
	self.county 				  				:= pInput.clean_fipscounty;		                             
	self.geo_lat 				  				:= pInput.clean_geo_lat;		                             
	self.geo_long 				  			:= pInput.clean_geo_long;		                             
	self.msa 					  					:= pInput.clean_msa;		                             
	self.geo_blk 				  				:= pInput.clean_geo_blk;		                             
	self.geo_match 				  			:= pInput.clean_geo_match;		                             
	self.err_stat 				  			:= pInput.clean_err_stat;		                             
	self.issuance 				  			:= ''; // had to include explcitly because of...
	self.opt_out									:= pInput.orig_opt_out_code;
end;

WI_as_DL_mapper := project(dWI, lTransform_WI_To_Common(left));

return WI_as_DL_mapper;

end;
