import Ut, lib_stringlib;

/* Note: This contains a temporary fix to help rollup on dl_number.  See associated
         code in BRW_Make_FLDL_DID attribute, which blanks the dl_number on the way
		 out.
*/

string8 lMDYtoYMD(string pDate) := pDate[5..8] + pDate[1..4];

string8 lInsertDDinMMCCYY(string pMMCCYY)
 := pMMCCYY[3..6]
  + pMMCCYY[1..2]
  + case((integer)(pMMCCYY[1..2]),
		 01 => '31',
		 02 => '28',
		 03 => '31',
		 04 => '30',
		 05 => '31',
		 06 => '30',
		 07 => '31',
		 08 => '31',
		 09 => '30',
		 10 => '31',
		 11 => '30',
		 12 => '31',
		 '30'
		)
 ;

Drivers.Layout_DL lTransform_ID_To_Common(Drivers.File_ID_Full pInput)
 := transform
    self.dt_first_seen 				:= (unsigned8)pInput.append_process_date div 100;
    self.dt_last_seen 				:= (unsigned8)pInput.append_process_date div 100;
    self.dt_vendor_first_reported 	:= (unsigned8)pInput.append_process_date div 100;
    self.dt_vendor_last_reported 	:= (unsigned8)pInput.append_process_date div 100;
    self.orig_state 				:= 'ID';

	self.name						:= pInput.orig_NAME;
	self.addr1						:= pInput.orig_ADDRESS1 + trim(' ' + pInput.orig_ADDRESS2);
	self.city 						:= pInput.orig_CITY;
	self.state						:= pInput.orig_STATE;
	self.zip 						:= pInput.orig_ZIP_CODE[1..5];
	self.dob 						:= (unsigned4)lMDYtoYMD(pInput.orig_DOB);
	self.sex_flag					:= pInput.orig_SEX;
	self.license_type 				:= pInput.orig_LICENSE_CLASS;
	self.restrictions 				:= lib_stringlib.stringlib.StringFindReplace(pInput.orig_RESTRICTIONS,' ','');
	self.orig_expiration_date		:= (unsigned4)lInsertDDinMMCCYY(pInput.orig_EXPIRATION_DATE); //expiration_date is derived, doesn't get orig data
	self.lic_issue_date 			:= (unsigned4)lMDYtoYMD(pInput.orig_ISSUE_DATE);
	self.dl_number 					:= 'LNID:' + (string)hash(pInput.orig_state,pInput.orig_NAME,pInput.orig_DOB,pInput.orig_SEX);
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
//    self := pInput; //no go
end;

export ID_as_DL := project(Drivers.File_ID_Full, lTransform_ID_To_Common(left));