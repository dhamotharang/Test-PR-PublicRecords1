import Ut, lib_stringlib;

string8 lCenturyFlagAndDateToCYMD(string1 pCenturyCode,string6 pYYMMDD)
 := if((integer4)pYYMMDD<>0,
	   case(pCenturyCode,'0' => '18',
						 '1' => '19',
						 '2' => '20',
						 '20'
		   )
	   + pYYMMDD,
	   ''
	  )
 ;

string3 lHeightFromInches(string2 pInches)
 :=	if((integer2)pInches = 0,
	   '',
	   intformat((integer)((integer)pInches / 12),1,1) + intformat((integer)((integer)pInches % 12),2,1)
	  )
 ;

Matrix_DL.Layout_Common lTransform_PA_To_Common(Matrix_DL.File_PA_Full pInput)
 :=
  transform
    self.dt_first_seen 				:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.dt_last_seen 				:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.dt_vendor_first_reported 	:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.dt_vendor_last_reported 	:= (unsigned8)pInput.append_PROCESS_DATE div 100;
    self.orig_state 				:= 'PA';
	self.dl_number 					:= pInput.orig_CUST_OLNO;
	self.name						:= pInput.orig_CUST_OPER_NAME;
	self.addr1						:= trim(trim(pInput.orig_CUST_OPER_ADDRESS,right) + ' ' + trim(pInput.orig_CUST_OPER_SEC_LN_ADDRESS,left,right),left);
	self.city 						:= pInput.orig_CUST_OPER_CITY;
	self.state						:= pInput.orig_CUST_OPER_ST;
	self.zip 						:= pInput.orig_CUST_ZIP_CODE[1..5];
	self.dob 						:= (unsigned4)lCenturyFlagAndDateToCYMD(pInput.orig_CUST_OPER_BIRTH_CENT,pInput.orig_CUST_OPER_BIRTH_DATE);
	self.sex_flag					:= pInput.orig_CUST_OPER_SEX_CODE;
	self.ssn						:= pInput.orig_CUST_SSN_NO;
	self.height						:= lHeightFromInches(pInput.orig_CUST_OPER_HGT);
	self.eye_color					:= pInput.orig_CUST_EYE_COLOR_CODE;
	self.attention_flag				:= pInput.orig_CUST_ORGAN_DONOR_TYPE;
	self.orig_expiration_date		:= (unsigned4)lCenturyFlagAndDateToCYMD(pInput.orig_CUST_PROD_EXPIRE_CENT,pInput.orig_CUST_PROD_EXPIRE_DATE);
	self.lic_issue_date 			:= (unsigned4)lCenturyFlagAndDateToCYMD(pInput.orig_CUST_PROD_ISSUE_CENT,pInput.orig_CUST_PROD_ISSUE_DATE);
	self.license_type 				:= pInput.orig_CUST_RCD_TYPE_CODE;
	self.restrictions				:= trim(pInput.orig_CUST_MED_RESTR_GRP,all);
	self.restrictions_delimited 	:= self.Restrictions[1] + 
									   if(self.Restrictions[2]<>' ',','+self.Restrictions[2],'') +
									   if(self.Restrictions[3]<>' ',','+self.Restrictions[3],'') + 
									   if(self.Restrictions[4]<>' ',','+self.Restrictions[4],'') +
									   if(self.Restrictions[5]<>' ',','+self.Restrictions[5],'') +
									   if(self.Restrictions[6]<>' ',','+self.Restrictions[6],'') + 
									   if(self.Restrictions[7]<>' ',','+self.Restrictions[7],'') + 
									   if(self.Restrictions[8]<>' ',','+self.Restrictions[8],'') + 
									   if(self.Restrictions[9]<>' ',','+self.Restrictions[9],'') +
									   if(self.Restrictions[10]<>' ',','+self.Restrictions[10],'');
	self.lic_endorsement			:= trim(pInput.orig_CUST_BUS_ENDORSE_CODE 	+
											pInput.orig_CUST_CDL_ENDORSE_CODE_1 +
											pInput.orig_CUST_CDL_ENDORSE_CODE_2 +
											pInput.orig_CUST_CDL_ENDORSE_CODE_3,
											all
										   );
	self.oos_previous_st			:= pInput.orig_CUST_SOR_CODE;
	self.oos_previous_dl_number		:= pInput.orig_CUST_SOR_DL_NO;

	self.title 						:= pInput.clean_OPER_NAME_prefix;
	self.fname 						:= pInput.clean_OPER_NAME_first;
	self.mname 						:= pInput.clean_OPER_NAME_middle;
	self.lname 						:= pInput.clean_OPER_NAME_last;
	self.name_suffix 				:= pInput.clean_OPER_NAME_suffix;
	self.cleaning_score 			:= pInput.clean_OPER_NAME_score;
	self.prim_range 				:= pInput.clean_OPER_ADDRESS_prim_range;
	self.predir 					:= pInput.clean_OPER_ADDRESS_predir;
	self.prim_name 					:= pInput.clean_OPER_ADDRESS_prim_name;
	self.suffix 					:= pInput.clean_OPER_ADDRESS_addr_suffix;
	self.postdir 					:= pInput.clean_OPER_ADDRESS_postdir;
	self.unit_desig 				:= pInput.clean_OPER_ADDRESS_unit_desig;
	self.sec_range 					:= pInput.clean_OPER_ADDRESS_sec_range;
	self.p_city_name 				:= pInput.clean_OPER_ADDRESS_p_city_name;
	self.v_city_name 				:= pInput.clean_OPER_ADDRESS_v_city_name;
	self.st 						:= pInput.clean_OPER_ADDRESS_st;
	self.zip5 						:= pInput.clean_OPER_ADDRESS_zip;
	self.zip4 						:= pInput.clean_OPER_ADDRESS_zip4;
	self.cart 						:= pInput.clean_OPER_ADDRESS_cart;
	self.cr_sort_sz 				:= pInput.clean_OPER_ADDRESS_cr_sort_sz;
	self.lot 						:= pInput.clean_OPER_ADDRESS_lot;
	self.lot_order 					:= pInput.clean_OPER_ADDRESS_lot_order;
	self.dpbc 						:= pInput.clean_OPER_ADDRESS_dpbc;
	self.chk_digit 					:= pInput.clean_OPER_ADDRESS_chk_digit;
	self.rec_type 					:= pInput.clean_OPER_ADDRESS_record_type;
	self.ace_fips_st 				:= pInput.clean_OPER_ADDRESS_ace_fips_st;
	self.county 					:= pInput.clean_OPER_ADDRESS_fipscounty;
	self.geo_lat 					:= pInput.clean_OPER_ADDRESS_geo_lat;
	self.geo_long 					:= pInput.clean_OPER_ADDRESS_geo_long;
	self.msa 						:= pInput.clean_OPER_ADDRESS_msa;
	self.geo_blk 					:= pInput.clean_OPER_ADDRESS_geo_blk;
	self.geo_match 					:= pInput.clean_OPER_ADDRESS_geo_match;
	self.err_stat 					:= pInput.clean_OPER_ADDRESS_err_stat;
	self.issuance					:= '';
  end
 ;

export PA_as_DL := project(Matrix_DL.File_PA_Full, lTransform_PA_To_Common(left));