import Lib_StringLib, Drivers;

export CT_as_DL(dataset(drivers.Layout_CT_Full) pFile_CT_Input)	:= function


fGetAddressToken(string pAddressIn, unsigned pToken)
 :=	choose(pToken,
		   pAddressIn[1..(lib_stringlib.StringLib.stringfind(pAddressIn,'@',1)-1)],
		   pAddressIn[(lib_stringlib.StringLib.stringfind(pAddressIn,'@',1)+1)..(lib_stringlib.StringLib.stringfind(pAddressIn,'@',2)-1)],
		   pAddressIn[(lib_stringlib.StringLib.stringfind(pAddressIn,'@',2)+1)..(lib_stringlib.StringLib.stringfind(pAddressIn,'@',3)-1)],
		   pAddressIn[(lib_stringlib.StringLib.stringfind(pAddressIn,'@',3)+1)..(lib_stringlib.StringLib.stringfind(pAddressIn,'@',4)-1)],
		   pAddressIn[(lib_stringlib.StringLib.stringfind(pAddressIn,'@',4)+1)..(lib_stringlib.StringLib.stringfind(pAddressIn,';',1)-1)],
		   ''
		  );

DriversV2.Layout_DL_Extended tCTAsDL(pFile_CT_Input pInput)
 :=
  transform
	self.dt_first_seen 						:=	(unsigned8)pInput.append_PROCESS_DATE div 100;
	self.dt_last_seen 						:=	(unsigned8)pInput.append_PROCESS_DATE div 100;
	self.dt_vendor_first_reported	:=	(unsigned8)pInput.append_PROCESS_DATE div 100;
	self.dt_vendor_last_reported 	:=	(unsigned8)pInput.append_PROCESS_DATE div 100;
	self.dateReceived							:=	(integer)pInput.append_PROCESS_DATE;
	self.orig_state 			    		:=	'CT';
	self.name											:=	lib_stringlib.StringLib.stringfindreplace(pInput.orig_NAME,'@',' ');
	self.RawFullName							:=	pInput.orig_NAME;
	self.addr1										:= 	fGetAddressToken(pInput.orig_MAILADDRESS,1) + ' ' + fGetAddressToken(pInput.orig_MAILADDRESS,2);
	self.city 										:= 	fGetAddressToken(pInput.orig_MAILADDRESS,3);
	self.state										:= 	fGetAddressToken(pInput.orig_MAILADDRESS,4);
	self.zip 											:= 	fGetAddressToken(pInput.orig_MAILADDRESS,5);
	self.dob 											:= 	(unsigned4)pInput.orig_DOB;
	self.sex_flag									:= 	case(pInput.orig_SEX,
																					'1' => 'M',
																					'2' => 'F',
																					'U'
																				 );
	self.license_class 				:=	if (pInput.orig_CLASSIFICATION[1] = 'M', '', pInput.orig_CLASSIFICATION[1]);
	self.license_type 				:=  '';
	self.OrigLicenseClass			:=	'';
	self.OrigLicenseType			:=  pInput.orig_CLASSIFICATION;	
	self.moxie_license_type 				:=	pInput.orig_CLASSIFICATION[1]
									+	if(pInput.orig_CLASSIFICATION[1] in ['A','B','C'],
										   pInput.orig_CDLSTATUS,
										   pInput.orig_NONCDLSTATUS
										  );
	self.restrictions 				:=	lib_stringlib.stringlib.StringFindReplace(pInput.orig_RESTRICTIONS,' ','');
	//self.orig_expiration_date		:=	(unsigned4)(pInput.orig_EXPIRE_DATE + pInput.orig_EXPIRE_DATE_DD);
	self.expiration_date		    :=	(unsigned4)(pInput.orig_EXPIRE_DATE + pInput.orig_EXPIRE_DATE_DD);
	self.lic_issue_date 			:=	(unsigned4)(pInput.orig_ISSUE_DATE + pInput.orig_ISSUE_DATE_DD);
	self.lic_endorsement 			:=	if (pInput.orig_CLASSIFICATION[1] = 'M',
	                                       lib_stringlib.stringlib.StringFindReplace(pInput.orig_ENDORSEMENTS,' ','') + 
										   pInput.orig_CLASSIFICATION[1],
										   if (pInput.orig_CLASSIFICATION[2] = 'M',
										       lib_stringlib.stringlib.StringFindReplace(pInput.orig_ENDORSEMENTS,' ','') + 
										       pInput.orig_CLASSIFICATION[2],
										       lib_stringlib.stringlib.StringFindReplace(pInput.orig_ENDORSEMENTS,' ',''))
										   );
	self.motorcycle_code			:=	if(pInput.orig_CLASSIFICATION[2] = 'M','ALSO','');
	self.dl_number 					:=	pInput.orig_DLNUMBER;
	self.height 					:=	pInput.orig_HEIGHT1 + pInput.orig_HEIGHT2;
	self.oos_previous_st			:=	pInput.orig_CANCELST;
	self.eye_color					:=	pInput.orig_EYE_COLOR;
	self.title 						:=	pInput.clean_name_prefix;
	self.fname 						:=	pInput.clean_name_first;		                             
	self.mname 						:=	pInput.clean_name_middle;		                             
	self.lname 						:=	pInput.clean_name_last;		                             
	self.name_suffix 				:=	pInput.clean_name_suffix;		                             
	self.cleaning_score 			:=	pInput.clean_name_score;		                             
	self.prim_range 				:=	pInput.clean_prim_range;		                             
	self.predir 					:=	pInput.clean_predir;		                             
	self.prim_name 					:=	pInput.clean_prim_name;		                             
	self.suffix 					:=	pInput.clean_addr_suffix;		                             
	self.postdir 					:=	pInput.clean_postdir;		                             
	self.unit_desig 				:=	pInput.clean_unit_desig;		                             
	self.sec_range 					:=	pInput.clean_sec_range;		                             
	self.p_city_name 				:=	pInput.clean_p_city_name;		                             
	self.v_city_name 				:=	pInput.clean_v_city_name;		                             
	self.st 						:=	pInput.clean_st;		                             
	self.zip5 						:=	pInput.clean_zip;		                             
	self.zip4 						:=	pInput.clean_zip4;		                             
	self.cart 						:=	pInput.clean_cart;		                             
	self.cr_sort_sz 				:=	pInput.clean_cr_sort_sz;		                             
	self.lot 						:=	pInput.clean_lot;		                             
	self.lot_order 					:=	pInput.clean_lot_order;		                             
	self.dpbc 						:=	pInput.clean_dpbc;		                             
	self.chk_digit 					:=	pInput.clean_chk_digit;		                             
	self.rec_type 					:=	pInput.clean_record_type;		                             
	self.ace_fips_st 				:=	pInput.clean_ace_fips_st;		                             
	self.county 					:=	pInput.clean_fipscounty;		                             
	self.geo_lat 					:=	pInput.clean_geo_lat;		                             
	self.geo_long 					:=	pInput.clean_geo_long;		                             
	self.msa 						:=	pInput.clean_msa;		                             
	self.geo_blk 					:=	pInput.clean_geo_blk;		                             
	self.geo_match 					:=	pInput.clean_geo_match;		                             
	self.err_stat 					:=	pInput.clean_err_stat;		                             
	self.issuance 					:=	''; // had to include explcitly because of...
	self.status             :=  pInput.orig_NONCDLSTATUS;
	self.CDL_Status         :=  pInput.orig_CDLSTATUS;
	SELF.orig_canceldate		:=	pInput.orig_canceldate;
	SELF.orig_origcdldate		:=	pInput.orig_origcdldate;
	//self							:=	pInput; //no go
end;

CT_as_DL	:=	project(pFile_CT_Input,tCTasDL(left));

return(CT_as_DL);
end;


