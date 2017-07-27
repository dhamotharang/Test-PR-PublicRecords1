import lib_stringlib;

Drivers.Layout_DL lTransform_WI_To_Common(Drivers.File_WI_Full pInput)
 := transform
    self.dt_first_seen 				:= (unsigned8)pInput.append_process_date div 100;
    self.dt_last_seen 				:= (unsigned8)pInput.append_process_date div 100;
    self.dt_vendor_first_reported 	:= (unsigned8)pInput.append_process_date div 100;
    self.dt_vendor_last_reported 	:= (unsigned8)pInput.append_process_date div 100;
    self.orig_state 				:= 'WI';
	self.name						:= trim(pInput.orig_FIRST_NAME)
									 + trim(' ' + pInput.orig_MIDDLE_INITIAL)
									 + trim(' ' + pInput.orig_LAST_NAME);
	self.addr1						:= pInput.orig_ADDRESS1;
	self.city 						:= pInput.orig_CITY;		                             
	self.state						:= pInput.orig_STATE;
	self.zip 						:= pInput.orig_ZIP_CODE;		                             
	self.dob 						:= (unsigned4)pInput.orig_DOB;
	self.sex_flag					:= pInput.orig_SEX;
	self.license_type 				:= pInput.append_LICENSE_TYPE;
	self.orig_expiration_date		:= (unsigned4)pInput.append_EXPIRATION_DATE;
	self.lic_issue_date 			:= (unsigned4)pInput.append_ISSUE_DATE;
	// Let's put both append_CLASSES and append_LICENSE_TYPE into the lic_endorsement
	// field and put both into the appropriate CODES_V3 table.  The codes do not
	// overlap and seem somewhat similar in use.
	self.lic_endorsement 			:= lib_stringlib.stringlib.StringFilterOut(pInput.append_CLASSES + pInput.append_ENDORSEMENTS,' D');
	self.dl_number 					:= pInput.orig_DL_NUMBER;
	self.title 						:= pInput.clean_name_prefix;
	self.fname 						:= pInput.clean_name_first;		                             
	self.mname 						:= pInput.clean_name_middle;		                             
	self.lname 						:= pInput.clean_name_last;		                             
	self.name_suffix 				:= pInput.clean_name_suffix;		                             
	self.cleaning_score 			:= pInput.clean_name_score;		                             
	self.prim_range 				:= pInput.clean_prim_range;		                             
	self.predir 					:= pInput.clean_predir;		                             
	self.prim_name 					:= pInput.clean_prim_name;		                             
	self.suffix 					:= pInput.clean_addr_suffix;		                             
	self.postdir 					:= pInput.clean_postdir;		                             
	self.unit_desig 				:= pInput.clean_unit_desig;		                             
	self.sec_range 					:= pInput.clean_sec_range;		                             
	self.p_city_name 				:= pInput.clean_p_city_name;		                             
	self.v_city_name 				:= pInput.clean_v_city_name;		                             
	self.st 						:= pInput.clean_st;		                             
	self.zip5 						:= pInput.clean_zip;		                             
	self.zip4 						:= pInput.clean_zip4;		                             
	self.cart 						:= pInput.clean_cart;		                             
	self.cr_sort_sz 				:= pInput.clean_cr_sort_sz;		                             
	self.lot 						:= pInput.clean_lot;		                             
	self.lot_order 					:= pInput.clean_lot_order;		                             
	self.dpbc 						:= pInput.clean_dpbc;		                             
	self.chk_digit 					:= pInput.clean_chk_digit;		                             
	self.rec_type 					:= pInput.clean_record_type;		                             
	self.ace_fips_st 				:= pInput.clean_ace_fips_st;		                             
	self.county 					:= pInput.clean_fipscounty;		                             
	self.geo_lat 					:= pInput.clean_geo_lat;		                             
	self.geo_long 					:= pInput.clean_geo_long;		                             
	self.msa 						:= pInput.clean_msa;		                             
	self.geo_blk 					:= pInput.clean_geo_blk;		                             
	self.geo_match 					:= pInput.clean_geo_match;		                             
	self.err_stat 					:= pInput.clean_err_stat;		                             
	self.issuance 					:= ''; // had to include explcitly because of...
end;

export WI_as_DL := project(Drivers.File_WI_Full, lTransform_WI_To_Common(left));