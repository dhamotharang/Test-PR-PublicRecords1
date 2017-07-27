import Ut, lib_stringlib;

string8 lFixDate(string8 pDateIn)
 := if(pDateIn[5..8] in ['    ','0000'],
	   '',
	   pDateIn[5..8] + pDateIn[1..4]
	  );

Drivers.Layout_DL tMI_To_Common(Drivers.File_MI_Full pInput)
 := transform
    self.dt_first_seen 				:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.dt_last_seen 				:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.dt_vendor_first_reported 	:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.dt_vendor_last_reported 	:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.orig_state 				:= 'MI';

	self.dl_number 					:= if(pInput.orig_DLNum<>'',pInput.orig_DLNum,pInput.orig_PersonalIDNum);
	self.name						:= pInput.orig_NAME;
	self.dob 						:= (unsigned4)lFixDate(pInput.orig_DOB);
	self.sex_flag					:= if(pInput.orig_SEX = '4','M',
										  if(pInput.orig_SEX = '6','F',
											 pInput.orig_SEX
											)
										 );
	self.addr1						:= pInput.orig_Street;
	self.city 						:= pInput.orig_City;
	self.state						:= pInput.orig_State;
	self.zip 						:= pInput.orig_Zip;
//	self.orig_expiration_date		:= (unsigned4)lFixDate(pInput.orig_DLEXPIREDATE);
//	self.lic_issue_date 			:= (unsigned4)lFixDate(pInput.orig_DLISSUEDATE);
	//Fudge a bit...  if no DL number, assume it's an ID
	self.license_type 				:= if(pInput.orig_DLNum<>'','D','I');

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

export MI_as_DL := project(Drivers.File_MI_Full, tMI_To_Common(left));