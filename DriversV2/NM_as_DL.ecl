import Ut, lib_stringlib, Drivers;

bad_names  := ['UNKNOWN','UNK','UNKN','NONE','N/A','UNAVAILABLE'];
bad_mnames := ['NMN','NMI'];

DriversV2.Layout_DL lTransform_NM_To_Common(Drivers.File_NM_Full pInput)
 := transform
	self.orig_state 			  := 'NM';
	self.dt_first_seen 			  := (unsigned8)pInput.append_process_date div 100;
	self.dt_last_seen 			  := (unsigned8)pInput.append_process_date div 100;
	self.dt_vendor_first_reported := (unsigned8)pInput.append_process_date div 100;
	self.dt_vendor_last_reported  := (unsigned8)pInput.append_process_date div 100;	
	self.name					  := trim(pInput.orig_NAME_FIRST)
								   + trim(' ' + pInput.orig_NAME_MIDDLE)
								   + trim(' ' + pInput.orig_NAME_LAST)
								   + trim(' ' + pInput.orig_NAME_SUFFIX);
	self.addr1					  := pInput.orig_ADDRESS_STREET;
	self.city 					  := pInput.orig_CITY;		                             
	self.state					  := pInput.orig_STATE;
	self.zip 					  := pInput.orig_ZIP_CODE_5;		                             
	self.dob 					  := (unsigned4)pInput.orig_DOB;
	self.sex_flag				  := case(pInput.orig_SEX,
								          '1' => 'M',
								          '2' => 'F',
								          'U'
								         );
	self.license_class 			  := pInput.orig_LIC_CLASS;
	self.license_type 			  := pInput.orig_LIC_TYPE;
	self.moxie_license_type 			  := pInput.orig_LIC_TYPE;
	self.restrictions 			  := lib_stringlib.stringlib.StringFindReplace(pInput.orig_RESTRICTIONS,' ','');
	self.expiration_date		  := (unsigned4)pInput.orig_Expire_Date; 
	self.lic_issue_date 		  := (unsigned4)pInput.orig_Issue_Date;
	self.lic_endorsement 		  := lib_stringlib.stringlib.StringFindReplace(pInput.orig_ENDORSEMENTS,' ','');
	self.motorcycle_code		  := if(lib_stringlib.stringlib.StringFind(pInput.orig_LIC_CLASS,'M',1)<>0,'ALSO','');
	self.dl_number 				  := pInput.orig_DRIVER_ID;
	self.height 				  := pInput.orig_HEIGHT;
	self.oos_previous_dl_number	  := pInput.orig_PREVIOUS_LICENSE;
	self.oos_previous_st		  := pInput.orig_PREVIOUS_STATE;
    self.eye_color				  := pInput.orig_EYE_COLOR;
	self.weight					  := pInput.orig_WEIGHT;
	self.title 					  := pInput.clean_name_prefix;
	self.fname 					  := if (trim(pInput.clean_name_first,left,right) in bad_names,'',pInput.clean_name_first);		                             
	self.mname 					  := if (trim(pInput.clean_name_middle,left,right) in bad_names + bad_mnames,'',pInput.clean_name_middle);		                             
	self.lname 					  := if (trim(pInput.clean_name_last,left,right) in bad_names,'',pInput.clean_name_last);		                             
	self.name_suffix 			  := pInput.clean_name_suffix;		                             
	self.cleaning_score 		  := pInput.clean_name_score;		                             
	self.prim_range 			  := pInput.clean_prim_range;		                             
	self.predir 				  := pInput.clean_predir;		                             
	self.prim_name 				  := pInput.clean_prim_name;		                             
	self.suffix 				  := pInput.clean_addr_suffix;		                             
	self.postdir 				  := pInput.clean_postdir;		                             
	self.unit_desig 			  := pInput.clean_unit_desig;		                             
	self.sec_range 				  := pInput.clean_sec_range;		                             
	self.p_city_name 			  := pInput.clean_p_city_name;		                             
	self.v_city_name 			  := pInput.clean_v_city_name;		                             
	self.st 				      := pInput.clean_st;		                             
	self.zip5 					  := pInput.clean_zip;		                             
	self.zip4 					  := pInput.clean_zip4;		                             
	self.cart 					  := pInput.clean_cart;		                             
	self.cr_sort_sz 			  := pInput.clean_cr_sort_sz;		                             
	self.lot 				      := pInput.clean_lot;		                             
	self.lot_order 			   	  := pInput.clean_lot_order;		                             
	self.dpbc 					  := pInput.clean_dpbc;		                             
	self.chk_digit 				  := pInput.clean_chk_digit;		                             
	self.rec_type 				  := pInput.clean_record_type;		                             
	self.ace_fips_st 			  := pInput.clean_ace_fips_st;		                             
	self.county 				  := pInput.clean_fipscounty;		                             
	self.geo_lat 				  := pInput.clean_geo_lat;		                             
	self.geo_long 				  := pInput.clean_geo_long;		                             
	self.msa 				      := pInput.clean_msa;		                             
	self.geo_blk 				  := pInput.clean_geo_blk;		                             
	self.geo_match 				  := pInput.clean_geo_match;		                             
	self.err_stat 				  := pInput.clean_err_stat;		                             
	self.issuance 				  := ''; // had to include explcitly because of...
    //self := pInput; //no go
end;

export NM_as_DL := project(Drivers.File_NM_Full, lTransform_NM_To_Common(left));