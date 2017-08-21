import Ut, lib_stringlib;

Drivers.Layout_DL lTransform_KY_To_Common(Drivers.File_KY_Full pInput)
 := transform
	self.dt_first_seen 				:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.dt_last_seen 				:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.dt_vendor_first_reported 	:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.dt_vendor_last_reported 	:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.orig_state 				:= 'KY';

	self.name						:= trim(pInput.orig_FIRST_NAME)
									 + trim(' ' + pInput.orig_MIDDLE_NAME)
									 + trim(' ' + pInput.orig_LAST_NAME);
	self.addr1						:= trim(pInput.orig_ADDRESS);
	self.city 						:= pInput.orig_CITY;		                             
	self.state						:= pInput.orig_STATE;
	self.zip 						:= pInput.orig_ZIP;		                             
	self.dob 						:= (unsigned4)pInput.orig_DOB;
	self.sex_flag					:= pInput.orig_SEX;
	self.orig_expiration_date			:= (unsigned4)pInput.orig_EXPIRATION_DATE;
	self.expiration_date			:= (unsigned4)pInput.orig_EXPIRATION_DATE;
	self.lic_issue_date 			:= (unsigned4)pInput.orig_ISSUE_DATE;
	self.dl_number 					:= pInput.orig_DL_NUMBER;
	self.height 					:= pInput.orig_HEIGHT;
	self.weight						:= pInput.orig_WEIGHT;
    self.eye_color					:= pInput.orig_EYE_COLOR;
	self.restrictions				:= pInput.orig_RESTRICTIONS;
	self.lic_endorsement			:= pInput.orig_ENDORSEMENTS;
	self.license_type				:= pInput.orig_LICENSE_CLASS;
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
	self.issuance 					:= ''; // has no default
end;

export KY_as_DL := project(Drivers.File_KY_Full	+	Drivers.File_KY_Update, lTransform_KY_To_Common(left));