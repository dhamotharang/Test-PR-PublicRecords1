string1 fOwnerType(string pLName, string pFName)
 :=
  if(pLName <> '',
	 if(pFName <> '',
		'I',
		'B'
	   ),
	 ''
	)
 ;

string10 fFixZipPlus4(string10 pZipIn)
 :=
  if(pZipIn[7..10] = '0000' or pZipIn[7..10] = '    ',
     pZipIn[1..5],
	 pZipIn
	)
 ;

vehlic.Layout_Vehicles tNDSourceToCommon(Layout_ND_Full pInput)
 :=
  transform
	self.orig_state:='ND';
	self.dt_first_seen 				:= (unsigned8)(pInput.append_PROCESS_DATE[1..6]);
    self.dt_last_seen 				:= (unsigned8)(pInput.append_PROCESS_DATE[1..6]);
	self.dt_vendor_first_reported	:= (unsigned8)(pInput.append_PROCESS_DATE[1..6]);
	self.dt_vendor_last_reported	:= (unsigned8)(pInput.append_PROCESS_DATE[1..6]);
	self.VEHICLE_NUMBERxBG1			:= pInput.orig_TITLE_NUMBER;
	self.ORIG_VIN					:= pInput.orig_VIN_NUMBER;
	self.YEAR_MAKE					:= pInput.orig_MODEL_YEAR;
	self.MAKE_CODE					:= pInput.orig_MAKE;
	self.BODY_CODE					:= pInput.orig_BODY_STYLE;
	self.MAKE_DESCRIPTION			:= pInput.orig_MAKE;
	self.MODEL_DESCRIPTION			:= pInput.orig_MODEL;
	self.BODY_STYLE_DESCRIPTION		:= pInput.orig_BODY_STYLE;
	self.LICENSE_PLATE_NUMBERxBG4	:= pInput.orig_LICENSE_NUMBER;
	self.DECAL_NUMBER				:= pInput.orig_DECAL_NUMBER;
	self.TRUE_LICENSE_PLSTE_NUMBER	:= pInput.orig_LICENSE_NUMBER;
	self.REGISTRATION_EXPIRATION_DATE := pInput.orig_EXPIRATION_DATE;
	self.TITLE_NUMBERxBG9			:= pInput.orig_TITLE_NUMBER;
	self.ODOMETER_MILEAGE			:= pInput.orig_ODOMETER_READING;
	self.PRICE						:= pInput.orig_PURCHASE_PRICE;
    self.LH_1_LIEN_DATE				:= pInput.orig_LIEN_DATE;
	self.LEIN_HOLDER_1_CUSTOMER_TYPE:= 'B';
	self.LH_1_CUSTOMER_NAME			:= pInput.orig_LIENHOLDER_NAME;
	self.LH_1_STREET_ADDRESS		:= trim(pInput.orig_LIENHOLDER_ADDRESS_1) + trim(' ' + pInput.orig_LIENHOLDER_ADDRESS_2);
	self.LH_1_CITY					:= pInput.orig_LIENHOLDER_CITY;
	self.LH_1_STATE					:= pInput.orig_LIENHOLDER_STATE;
	self.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL	:= pInput.orig_LIENHOLDER_ZIP;
	self.OWNER_1_CUSTOMER_TYPExBG3	:= if(pInput.orig_OWNER_1_LNAME<>'',
										  fOwnerType(pInput.orig_OWNER_1_LNAME,pInput.orig_OWNER_1_FNAME),
										  fOwnerType(pInput.orig_OWNER_2_LNAME,pInput.orig_OWNER_2_FNAME)
										 );
	self.OWN_1_CUSTOMER_NAME		:= if(pInput.orig_OWNER_1_LNAME<>'',
										  trim(pInput.orig_OWNER_1_FNAME,left,right) + trim(' ' + trim(pInput.orig_OWNER_1_LNAME,left,right)),
										  if(pInput.orig_LESSOR_LNAME<>'',
											 trim(pInput.orig_LESSOR_FNAME,left,right) + trim(' ' + trim(pInput.orig_LESSOR_LNAME,left,right)),
	 										 trim(pInput.orig_OWNER_2_FNAME,left,right) + trim(' ' + trim(pInput.orig_OWNER_2_LNAME,left,right))
											)
										 );
	self.OWN_1_STREET_ADDRESS		:= if(pInput.orig_OWNER_1_LNAME<>'',
										  trim(pInput.orig_OWNER_1_ADDRESS1,left,right) + trim(' ' + trim(pInput.orig_OWNER_1_ADDRESS2,left,right)),
										  if(pInput.orig_LESSOR_LNAME<>'',
											 trim(pInput.orig_LESSOR_ADDRESS1,left,right) + trim(' ' + trim(pInput.orig_LESSOR_ADDRESS2,left,right)),
	 										 trim(pInput.orig_OWNER_2_ADDRESS1,left,right) + trim(' ' + trim(pInput.orig_OWNER_2_ADDRESS2,left,right))
											)
										 );
	self.OWN_1_CITY					:= if(pInput.orig_OWNER_1_LNAME<>'',
										  pInput.orig_OWNER_1_CITY,
										  if(pInput.orig_LESSOR_LNAME<>'',
											 pInput.orig_LESSOR_CITY,
	 										 pInput.orig_OWNER_2_CITY
											)
										 );
	self.OWN_1_STATE				:= if(pInput.orig_OWNER_1_LNAME<>'',
										  pInput.orig_OWNER_1_STATE,
										  if(pInput.orig_LESSOR_LNAME<>'',
											 pInput.orig_LESSOR_STATE,
	 										 pInput.orig_OWNER_2_STATE
											)
										 );
	self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL	:= if(pInput.orig_OWNER_1_LNAME<>'',
											  fFixZipPlus4(pInput.orig_OWNER_1_ZIP),
											  if(pInput.orig_LESSOR_LNAME<>'',
												 fFixZipPlus4(pInput.orig_LESSOR_ZIP),
												 fFixZipPlus4(pInput.orig_OWNER_2_ZIP)
												)
											 );
	self.OWNER_2_CUSTOMER_TYPE		:= if(pInput.orig_LESSOR_LNAME<>'',
										  '',
										  fOwnerType(pInput.orig_OWNER_2_LNAME,pInput.orig_OWNER_2_FNAME)
										 );
	self.OWN_2_CUSTOMER_NAME		:= if(pInput.orig_LESSOR_LNAME<>'',
										  '',
										  trim(pInput.orig_OWNER_2_FNAME,left,right) + trim(' ' + trim(pInput.orig_OWNER_2_LNAME,left,right))
										 );
	self.OWN_2_STREET_ADDRESS		:= if(pInput.orig_LESSOR_LNAME<>'',
									      '',
										  trim(pInput.orig_OWNER_2_ADDRESS1,left,right) + trim(' ' + trim(pInput.orig_OWNER_2_ADDRESS2,left,right))
										 );
	self.OWN_2_CITY					:= if(pInput.orig_LESSOR_LNAME<>'',
										  '',
										  pInput.orig_OWNER_2_CITY
										 );
	self.OWN_2_STATE				:= if(pInput.orig_LESSOR_LNAME<>'',
										  '',
										  pInput.orig_OWNER_2_STATE
										 );
	self.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL	:= if(pInput.orig_LESSOR_LNAME<>'',
											  '',
											  fFixZipPlus4(pInput.orig_OWNER_2_ZIP)
											 );
	self.REGISTRANT_1_CUSTOMER_TYPExBG5	:= if(pInput.orig_LESSOR_LNAME<>'',
											  fOwnerType(pInput.orig_LESSEE_LNAME,pInput.orig_LESSEE_FNAME),
											  fOwnerType(pInput.orig_OWNER_1_LNAME,pInput.orig_OWNER_1_FNAME)
											 );
	self.REG_1_CUSTOMER_NAME		:= if(pInput.orig_LESSOR_LNAME<>'',
										  trim(pInput.orig_LESSEE_FNAME,left,right) + trim(' ' + trim(pInput.orig_LESSEE_LNAME,left,right)),
										  if(pInput.orig_OWNER_1_LNAME<>'',
											 trim(pInput.orig_OWNER_1_FNAME,left,right) + trim(' ' + trim(pInput.orig_OWNER_1_LNAME,left,right)),
	 										 trim(pInput.orig_OWNER_2_FNAME,left,right) + trim(' ' + trim(pInput.orig_OWNER_2_LNAME,left,right))
											)
										 );
	self.REG_1_STREET_ADDRESS		:= if(pInput.orig_LESSOR_LNAME<>'',
	 									  trim(pInput.orig_LESSEE_ADDRESS1,left,right) + trim(' ' + trim(pInput.orig_LESSEE_ADDRESS2,left,right)),
										  trim(pInput.orig_OWNER_1_ADDRESS1,left,right) + trim(' ' + trim(pInput.orig_OWNER_1_ADDRESS2,left,right))
										 );
	self.REG_1_CITY					:= if(pInput.orig_LESSOR_LNAME<>'',
	 									  pInput.orig_LESSEE_CITY,
										  pInput.orig_OWNER_1_CITY
										 );
	self.REG_1_STATE				:= if(pInput.orig_LESSOR_LNAME<>'',
	 									  pInput.orig_LESSEE_STATE,
										  pInput.orig_OWNER_1_STATE
										 );
	self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL	:= if(pInput.orig_LESSOR_LNAME<>'',
											  fFixZipPlus4(pInput.orig_LESSEE_ZIP),
											  fFixZipPlus4(pInput.orig_OWNER_1_ZIP)
											 );
	self.REGISTRANT_2_CUSTOMER_TYPE	:= if(pInput.orig_LESSOR_LNAME<>'',
										  '',
										  fOwnerType(pInput.orig_OWNER_2_LNAME,pInput.orig_OWNER_2_FNAME)
										 );
	self.REG_2_CUSTOMER_NAME		:= if(pInput.orig_LESSOR_LNAME<>'',
										  '',
										  trim(pInput.orig_OWNER_2_FNAME,left,right) + trim(' ' + trim(pInput.orig_OWNER_2_LNAME,left,right))
										 );
	self.REG_2_STREET_ADDRESS		:= if(pInput.orig_LESSOR_LNAME<>'',
									      '',
										  trim(pInput.orig_OWNER_2_ADDRESS1,left,right) + trim(' ' + trim(pInput.orig_OWNER_2_ADDRESS2,left,right))
										 );
	self.REG_2_CITY					:= if(pInput.orig_LESSOR_LNAME<>'',
										  '',
										  pInput.orig_OWNER_2_CITY
										 );
	self.REG_2_STATE				:= if(pInput.orig_LESSOR_LNAME<>'',
										  '',
										  pInput.orig_OWNER_2_STATE
										 );
	self.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL	:= if(pInput.orig_LESSOR_LNAME<>'',
											  '',
											  fFixZipPlus4(pInput.orig_OWNER_2_ZIP)
											 );
	self.own_1_title 	        := if(pInput.orig_OWNER_1_LNAME<>'',
									  pInput.clean_OWNER_1_name_prefix,
									  if(pInput.orig_LESSOR_LNAME<>'',
										 pInput.clean_LESSOR_name_prefix,
										 pInput.clean_OWNER_2_name_prefix
										)
									 );
	self.own_1_fname 	        := if(pInput.orig_OWNER_1_LNAME<>'',
									  pInput.clean_OWNER_1_name_first,
									  if(pInput.orig_LESSOR_LNAME<>'',
										 pInput.clean_LESSOR_name_first,
										 pInput.clean_OWNER_2_name_first
										)
									 );
	self.own_1_mname 	    	:= if(pInput.orig_OWNER_1_LNAME<>'',
									  pInput.clean_OWNER_1_name_middle,
									  if(pInput.orig_LESSOR_LNAME<>'',
										 pInput.clean_LESSOR_name_middle,
										 pInput.clean_OWNER_2_name_middle
										)
									 );
	self.own_1_lname 	    	:= if(pInput.orig_OWNER_1_LNAME<>'',
									  pInput.clean_OWNER_1_name_last,
									  if(pInput.orig_LESSOR_LNAME<>'',
										 pInput.clean_LESSOR_name_last,
										 pInput.clean_OWNER_2_name_last
										)
									 );
	self.own_1_name_suffix 	    := if(pInput.orig_OWNER_1_LNAME<>'',
									  pInput.clean_OWNER_1_name_suffix,
									  if(pInput.orig_LESSOR_LNAME<>'',
										 pInput.clean_LESSOR_name_suffix,
										 pInput.clean_OWNER_2_name_suffix
										)
									 );
	self.own_1_company_name     := if(pInput.orig_OWNER_1_LNAME<>'',
									  pInput.append_OWNER_1_name_company,
									  if(pInput.orig_LESSOR_LNAME<>'',
										 pInput.append_LESSOR_name_company,
										 pInput.append_OWNER_2_name_company
										)
									 );
	self.own_1_prim_range		:= if(pInput.orig_OWNER_1_LNAME<>'',
									  pInput.clean_OWNER_1_ADDRESS_prim_range,
									  if(pInput.orig_LESSOR_LNAME<>'',
										 pInput.clean_LESSOR_ADDRESS_prim_range,
										 pInput.clean_OWNER_2_ADDRESS_prim_range
										)
									 );
	self.own_1_predir      		:= if(pInput.orig_OWNER_1_LNAME<>'',
									  pInput.clean_OWNER_1_ADDRESS_predir,
									  if(pInput.orig_LESSOR_LNAME<>'',
										 pInput.clean_LESSOR_ADDRESS_predir,
										 pInput.clean_OWNER_2_ADDRESS_predir
										)
									 );
	self.own_1_prim_name		:= if(pInput.orig_OWNER_1_LNAME<>'',
									  pInput.clean_OWNER_1_ADDRESS_prim_name,
									  if(pInput.orig_LESSOR_LNAME<>'',
										 pInput.clean_LESSOR_ADDRESS_prim_name,
										 pInput.clean_OWNER_2_ADDRESS_prim_name
										)
									 );
	self.own_1_suffix	  		:= if(pInput.orig_OWNER_1_LNAME<>'',
									  pInput.clean_OWNER_1_ADDRESS_addr_suffix,
									  if(pInput.orig_LESSOR_LNAME<>'',
										 pInput.clean_LESSOR_ADDRESS_addr_suffix,
										 pInput.clean_OWNER_2_ADDRESS_addr_suffix
										)
									 );
	self.own_1_postdir			:= if(pInput.orig_OWNER_1_LNAME<>'',
									  pInput.clean_OWNER_1_ADDRESS_postdir,
									  if(pInput.orig_LESSOR_LNAME<>'',
										 pInput.clean_LESSOR_ADDRESS_postdir,
										 pInput.clean_OWNER_2_ADDRESS_postdir
										)
									 );
	self.own_1_unit_desig		:= if(pInput.orig_OWNER_1_LNAME<>'',
									  pInput.clean_OWNER_1_ADDRESS_unit_desig,
									  if(pInput.orig_LESSOR_LNAME<>'',
										 pInput.clean_LESSOR_ADDRESS_unit_desig,
										 pInput.clean_OWNER_2_ADDRESS_unit_desig
										)
									 );
	self.own_1_sec_range		:= if(pInput.orig_OWNER_1_LNAME<>'',
									  pInput.clean_OWNER_1_ADDRESS_sec_range,
									  if(pInput.orig_LESSOR_LNAME<>'',
										 pInput.clean_LESSOR_ADDRESS_sec_range,
										 pInput.clean_OWNER_2_ADDRESS_sec_range
										)
									 );
	self.own_1_p_city_name		:= if(pInput.orig_OWNER_1_LNAME<>'',
									  pInput.clean_OWNER_1_ADDRESS_p_city_name,
									  if(pInput.orig_LESSOR_LNAME<>'',
										 pInput.clean_LESSOR_ADDRESS_p_city_name,
										 pInput.clean_OWNER_2_ADDRESS_p_city_name
										)
									 );
	self.own_1_v_city_name		:= if(pInput.orig_OWNER_1_LNAME<>'',
									  pInput.clean_OWNER_1_ADDRESS_v_city_name,
									  if(pInput.orig_LESSOR_LNAME<>'',
										 pInput.clean_LESSOR_ADDRESS_v_city_name,
										 pInput.clean_OWNER_2_ADDRESS_v_city_name
										)
									 );
	self.own_1_state_2    		:= if(pInput.orig_OWNER_1_LNAME<>'',
									  pInput.clean_OWNER_1_ADDRESS_st,
									  if(pInput.orig_LESSOR_LNAME<>'',
										 pInput.clean_LESSOR_ADDRESS_st,
										 pInput.clean_OWNER_2_ADDRESS_st
										)
									 );
	self.own_1_zip5				:= if(pInput.orig_OWNER_1_LNAME<>'',
									  pInput.clean_OWNER_1_ADDRESS_zip,
									  if(pInput.orig_LESSOR_LNAME<>'',
										 pInput.clean_LESSOR_ADDRESS_zip,
										 pInput.clean_OWNER_2_ADDRESS_zip
										)
									 );
	self.own_1_zip4      		:= if(pInput.orig_OWNER_1_LNAME<>'',
									  pInput.clean_OWNER_1_ADDRESS_zip4,
									  if(pInput.orig_LESSOR_LNAME<>'',
										 pInput.clean_LESSOR_ADDRESS_zip4,
										 pInput.clean_OWNER_2_ADDRESS_zip4
										)
									 );
	self.own_1_county			:= if(pInput.orig_OWNER_1_LNAME<>'',
									  pInput.clean_OWNER_1_ADDRESS_fipscounty,
									  if(pInput.orig_LESSOR_LNAME<>'',
										 pInput.clean_LESSOR_ADDRESS_fipscounty,
										 pInput.clean_OWNER_2_ADDRESS_fipscounty
										)
									 );
	self.own_2_title 			:= if(pInput.orig_LESSOR_LNAME<>'',
									  '',
									  pInput.clean_OWNER_2_name_prefix
									 );
	self.own_2_fname 			:= if(pInput.orig_LESSOR_LNAME<>'',
									  '',
									  pInput.clean_OWNER_2_name_first
									 );
	self.own_2_mname 			:= if(pInput.orig_LESSOR_LNAME<>'',
									  '',
									  pInput.clean_OWNER_2_name_middle
									 );
	self.own_2_lname 			:= if(pInput.orig_LESSOR_LNAME<>'',
									  '',
									  pInput.clean_OWNER_2_name_last
									 );
	self.own_2_name_suffix 		:= if(pInput.orig_LESSOR_LNAME<>'',
									  '',
									  pInput.clean_OWNER_2_name_suffix
									 );
	self.own_2_company_name 	:= if(pInput.orig_LESSOR_LNAME<>'',
									  '',
									  pInput.append_OWNER_2_NAME_COMPANY
									 );
	self.own_2_prim_range		:= if(pInput.orig_LESSOR_LNAME<>'',
									  '',
									  pInput.clean_OWNER_2_ADDRESS_prim_range
									 );
	self.own_2_predir 	        := if(pInput.orig_LESSOR_LNAME<>'',
									  '',
									  pInput.clean_OWNER_2_ADDRESS_predir
									 );
	self.own_2_prim_name		:= if(pInput.orig_LESSOR_LNAME<>'',
									  '',
									  pInput.clean_OWNER_2_ADDRESS_prim_name
									 );
	self.own_2_suffix 	        := if(pInput.orig_LESSOR_LNAME<>'',
									  '',
									  pInput.clean_OWNER_2_ADDRESS_addr_suffix
									 );
	self.own_2_postdir 	        := if(pInput.orig_LESSOR_LNAME<>'',
									  '',
									  pInput.clean_OWNER_2_ADDRESS_postdir
									 );
	self.own_2_unit_desig 	    := if(pInput.orig_LESSOR_LNAME<>'',
									  '',
									  pInput.clean_OWNER_2_ADDRESS_unit_desig
									 );
	self.own_2_sec_range 	    := if(pInput.orig_LESSOR_LNAME<>'',
									  '',
									  pInput.clean_OWNER_2_ADDRESS_sec_range
									 );
	self.own_2_p_city_name 	    := if(pInput.orig_LESSOR_LNAME<>'',
									  '',
									  pInput.clean_OWNER_2_ADDRESS_p_city_name
									 );
	self.own_2_v_city_name 	    := if(pInput.orig_LESSOR_LNAME<>'',
									  '',
									  pInput.clean_OWNER_2_ADDRESS_v_city_name
									 );
	self.own_2_state_2 	        := if(pInput.orig_LESSOR_LNAME<>'',
									  '',
									  pInput.clean_OWNER_2_ADDRESS_st
									 );
	self.own_2_zip5 	        := if(pInput.orig_LESSOR_LNAME<>'',
									  '',
									  pInput.clean_OWNER_2_ADDRESS_zip
									 );
	self.own_2_zip4 	        := if(pInput.orig_LESSOR_LNAME<>'',
									  '',
									  pInput.clean_OWNER_2_ADDRESS_zip4
									 );
	self.own_2_county 	        := if(pInput.orig_LESSOR_LNAME<>'',
									  '',
									  pInput.clean_OWNER_2_ADDRESS_fipscounty
									 );
	self.reg_1_title 	        := if(pInput.orig_LESSOR_LNAME<>'',
	 								  pInput.clean_LESSEE_name_prefix,
									  pInput.clean_OWNER_1_name_prefix
									 );
	self.reg_1_fname 	        := if(pInput.orig_LESSOR_LNAME<>'',
	 								  pInput.clean_LESSEE_name_first,
									  pInput.clean_OWNER_1_name_first
									 );
	self.reg_1_mname 	        := if(pInput.orig_LESSOR_LNAME<>'',
	 								  pInput.clean_LESSEE_name_middle,
									  pInput.clean_OWNER_1_name_middle
									 );
	self.reg_1_lname 	        := if(pInput.orig_LESSOR_LNAME<>'',
	 								  pInput.clean_LESSEE_name_last,
									  pInput.clean_OWNER_1_name_last
									 );
	self.reg_1_name_suffix 	    := if(pInput.orig_LESSOR_LNAME<>'',
	 								  pInput.clean_LESSEE_name_suffix,
									  pInput.clean_OWNER_1_name_suffix
									 );
	self.reg_1_company_name     := if(pInput.orig_LESSOR_LNAME<>'',
	 								  pInput.append_LESSEE_name_company,
									  pInput.append_OWNER_1_name_company
									 );
	self.reg_1_prim_range		:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  pInput.clean_LESSEE_ADDRESS_prim_range,
									  pInput.clean_OWNER_1_ADDRESS_prim_range
									 );
	self.reg_1_predir			:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  pInput.clean_LESSEE_ADDRESS_predir,
									  pInput.clean_OWNER_1_ADDRESS_predir
									 );
	self.reg_1_prim_name		:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  pInput.clean_LESSEE_ADDRESS_prim_name,
									  pInput.clean_OWNER_1_ADDRESS_prim_name
									 );
	self.reg_1_suffix			:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  pInput.clean_LESSEE_ADDRESS_addr_suffix,
									  pInput.clean_OWNER_1_ADDRESS_addr_suffix
									 );
	self.reg_1_postdir			:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  pInput.clean_LESSEE_ADDRESS_postdir,
									  pInput.clean_OWNER_1_ADDRESS_postdir
									 );
	self.reg_1_unit_desig		:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  pInput.clean_LESSEE_ADDRESS_unit_desig,
									  pInput.clean_OWNER_1_ADDRESS_unit_desig
									 );
	self.reg_1_sec_range		:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  pInput.clean_LESSEE_ADDRESS_sec_range,
									  pInput.clean_OWNER_1_ADDRESS_sec_range
									 );
	self.reg_1_p_city_name		:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  pInput.clean_LESSEE_ADDRESS_p_city_name,
									  pInput.clean_OWNER_1_ADDRESS_p_city_name
									 );
	self.reg_1_v_city_name		:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  pInput.clean_LESSEE_ADDRESS_v_city_name,
									  pInput.clean_OWNER_1_ADDRESS_v_city_name
									 );
	self.reg_1_state_2			:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  pInput.clean_LESSEE_ADDRESS_st,
									  pInput.clean_OWNER_1_ADDRESS_st
									 );
	self.reg_1_zip5				:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  pInput.clean_LESSEE_ADDRESS_zip,
									  pInput.clean_OWNER_1_ADDRESS_zip
									 );
	self.reg_1_zip4				:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  pInput.clean_LESSEE_ADDRESS_zip4,
									  pInput.clean_OWNER_1_ADDRESS_zip4
									 );
	self.reg_1_county			:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  pInput.clean_LESSEE_ADDRESS_fipscounty,
									  pInput.clean_OWNER_1_ADDRESS_fipscounty
									 );
	self.reg_2_title			:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  '',
									  pInput.clean_OWNER_1_name_prefix
									 );
	self.reg_2_fname 			:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  '',
									  pInput.clean_OWNER_2_name_first
									 );
	self.reg_2_mname 			:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  '',
									  pInput.clean_OWNER_2_name_middle
									 );
	self.reg_2_lname 			:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  '',
									  pInput.clean_OWNER_2_name_last
									 );
	self.reg_2_name_suffix 		:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  '',
									  pInput.clean_OWNER_2_name_suffix
									 );
	self.reg_2_company_name 	:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  '',
									  pInput.append_OWNER_2_NAME_COMPANY
									 );
	self.reg_2_prim_range		:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  '',
									  pInput.clean_OWNER_2_ADDRESS_prim_range
									 );
	self.reg_2_predir 	        := if(pInput.orig_LESSOR_LNAME<>'',
	 								  '',
									  pInput.clean_OWNER_2_ADDRESS_predir
									 );
	self.reg_2_prim_name 		:= if(pInput.orig_LESSOR_LNAME<>'',
	 								  '',
									  pInput.clean_OWNER_2_ADDRESS_prim_name
									 );
	self.reg_2_suffix 	        := if(pInput.orig_LESSOR_LNAME<>'',
	 								  '',
									  pInput.clean_OWNER_2_ADDRESS_addr_suffix
									 );
	self.reg_2_postdir 	        := if(pInput.orig_LESSOR_LNAME<>'',
	 								  '',
									  pInput.clean_OWNER_2_ADDRESS_postdir
									 );
	self.reg_2_unit_desig 	    := if(pInput.orig_LESSOR_LNAME<>'',
	 								  '',
									  pInput.clean_OWNER_2_ADDRESS_unit_desig
									 );
	self.reg_2_sec_range 	    := if(pInput.orig_LESSOR_LNAME<>'',
	 								  '',
									  pInput.clean_OWNER_2_ADDRESS_sec_range
									 );
	self.reg_2_p_city_name 	    := if(pInput.orig_LESSOR_LNAME<>'',
	 								  '',
									  pInput.clean_OWNER_2_ADDRESS_p_city_name
									 );
	self.reg_2_v_city_name 	    := if(pInput.orig_LESSOR_LNAME<>'',
	 								  '',
									  pInput.clean_OWNER_2_ADDRESS_v_city_name
									 );
	self.reg_2_state_2 	        := if(pInput.orig_LESSOR_LNAME<>'',
	 								  '',
									  pInput.clean_OWNER_2_ADDRESS_st
									 );
	self.reg_2_zip5 	        := if(pInput.orig_LESSOR_LNAME<>'',
	 								  '',
									  pInput.clean_OWNER_2_ADDRESS_zip
									 );
	self.reg_2_zip4 	        := if(pInput.orig_LESSOR_LNAME<>'',
	 								  '',
									  pInput.clean_OWNER_2_ADDRESS_zip4
									 );
	self.reg_2_county 	        := if(pInput.orig_LESSOR_LNAME<>'',
	 								  '',
									  pInput.clean_OWNER_2_ADDRESS_fipscounty
									 );
end;

export ND_as_Vehicles := project(File_ND_Full + File_ND_Update, tNDSourceToCommon(left));