import lib_stringlib;
/*
string fResequenceName(string pNameIn)
 := case(length(trim(lib_stringlib.stringlib.stringfilter(pNameIn,','))),
		 3 => pNameIn[(lib_stringlib.stringlib.stringfind(pNameIn,',',1)+1) .. (lib_stringlib.stringlib.stringfind(pNameIn,',',2)-1)]
			+ ' ' + pNameIn[(lib_stringlib.stringlib.stringfind(pNameIn,',',2)+1) .. (lib_stringlib.stringlib.stringfind(pNameIn,',',3)-1)]
			+ ' ' + pNameIn[1..(lib_stringlib.stringlib.stringfind(pNameIn,',',1)-1)] + ' ' + trim(pNameIn[(lib_stringlib.stringlib.stringfind(pNameIn,',',3)+1)..40]),
		 2 => pNameIn[(lib_stringlib.stringlib.stringfind(pNameIn,',',1)+1) .. (lib_stringlib.stringlib.stringfind(pNameIn,',',2)-1)]
			+ ' ' + trim(pNameIn[(lib_stringlib.stringlib.stringfind(pNameIn,',',2)+1)..40])
			+ ' ' + pNameIn[1 .. (lib_stringlib.stringlib.stringfind(pNameIn,',',1)-1)],
		 1 => pNameIn[(lib_stringlib.stringlib.stringfind(pNameIn,',',1)+1)..40]
			+ ' ' + pNameIn[1 .. (lib_stringlib.stringlib.stringfind(pNameIn,',',1)-1)],
		 pNameIn
		)
 ;

string fFixPersonName(string pNameIn)
 := fResequenceName(lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(pNameIn),left,right),' ',','))
 ;
*/
string fFixPersonName(string pNameIn)
 := trim(lib_stringlib.stringlib.stringfindreplace(lib_stringlib.stringlib.stringcleanspaces(pNameIn),',',' '))
 ;
 
string8 fFixDate(string pDateIn)
 :=
  if((integer8)pDateIn<>0,
     pDateIn,
	 ''
	)
 ;

boolean fValidName(string pNameIn)
 :=
  if(pNameIn<>'' and pNameIn[1..3]<>'NO ',
	 true,
	 false
	)
 ;

string10 fFixZipPlus4(string pZipIn)
 :=
  if(pZipIn[6..9] = '0000' or pZipIn[7..10] = '    ',
     pZipIn[1..5],
	 pZipIn[1..5] + '-' + pZipIn[6..9]
	)
 ;

vehlic.Layout_Vehicles tMTSourceToCommon(Layout_MT_Full pInput)
 :=
  transform
	self.orig_state:='MT';
	self.dt_first_seen 				:= (unsigned8)(pInput.append_PROCESS_DATE[1..6]);
    self.dt_last_seen 				:= (unsigned8)(pInput.append_PROCESS_DATE[1..6]);
	self.dt_vendor_first_reported	:= (unsigned8)(pInput.append_PROCESS_DATE[1..6]);
	self.dt_vendor_last_reported	:= (unsigned8)(pInput.append_PROCESS_DATE[1..6]);
	self.VEHICLE_NUMBERxBG1			:= ''; // let vehlic.vehicles_joined set it
	self.ORIG_VIN					:= pInput.orig_VIN;
	self.YEAR_MAKE					:= pInput.orig_VEHICLE_YEAR;
	self.MAKE_CODE					:= pInput.orig_VEHICLE_MAKE;
	self.MODEL						:= pInput.orig_VEHICLE_MODEL;
	self.BODY_CODE					:= pInput.orig_VEHICLE_BODY_STYLE;
	self.LICENSE_PLATE_NUMBERxBG4	:= pInput.orig_PLATE_NUMBER;
	self.LICENSE_PLATE_CODE			:= pInput.orig_PLATE_TYPE;
	self.TRUE_LICENSE_PLSTE_NUMBER	:= pInput.orig_PLATE_NUMBER;
	self.PLATE_ISSUE_DATE			:= fFixDate(pInput.orig_REGISTRATION_DATE);
	self.REGISTRATION_EXPIRATION_DATE := pInput.orig_PLATE_EXPIRATION_DATE;
	self.TITLE_NUMBERxBG9			:= pInput.orig_TITLE_NUMBER;
	self.TITLE_STATUS_CODE			:= pInput.orig_TITLE_STATUS;
	self.TITLE_ISSUE_DATE			:= fFixDate(pInput.orig_TITLE_DATE);
	self.ODOMETER_MILEAGE			:= pInput.orig_VEHICLE_ODOMETER;
	self.ODOMETER_STATUS			:= pInput.orig_VEHICLE_ODOMETER_INDICATOR;
	self.MAJOR_COLOR_CODE			:= pInput.orig_VEHICLE_MAJOR_COLOR;
	self.MINOR_COLOR_CODE			:= pInput.orig_VEHICLE_MINOR_COLOR;
	self.VEHICLE_TYPE				:= pInput.orig_VEHICLE_TYPE;
	self.FUEL_TYPE					:= pInput.orig_VEHICLE_FUEL_TYPE;
	
    self.LH_1_LIEN_DATE				:= pInput.orig_LIEN_FILE_DATE_1;
	self.LEIN_HOLDER_1_CUSTOMER_TYPE:= 'B';
	self.LH_1_CUSTOMER_NAME			:= pInput.orig_LIENHOLDER_NAME_1;
	self.LH_1_STREET_ADDRESS		:= trim(pInput.orig_LIENHOLDER_ADDRESS1_1) + trim(' ' + pInput.orig_LIENHOLDER_ADDRESS2_1);
	self.LH_1_CITY					:= pInput.orig_LIENHOLDER_CITY_1;
	self.LH_1_STATE					:= pInput.orig_LIENHOLDER_STATE_1;
	self.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL	:= pInput.orig_LIENHOLDER_ZIP_1;
    self.LH_2_LEIN_DATE				:= pInput.orig_LIEN_FILE_DATE_1;
	self.LEIN_HOLDER_2_CUSTOMER_TYPE:= 'B';
	self.LH_2_CUSTOMER_NAME			:= pInput.orig_LIENHOLDER_NAME_2;
	self.LH_2_STREET_ADDRESS		:= trim(pInput.orig_LIENHOLDER_ADDRESS1_2) + trim(' ' + pInput.orig_LIENHOLDER_ADDRESS2_2);
	self.LH_2_CITY					:= pInput.orig_LIENHOLDER_CITY_2;
	self.LH_2_STATE					:= pInput.orig_LIENHOLDER_STATE_2;
	self.LH_2_ZIP5_ZIP4_FOREIGN_POSTAL	:= pInput.orig_LIENHOLDER_ZIP_2;
	
	self.OWNER_1_CUSTOMER_TYPExBG3	:= if(fValidName(pInput.orig_OWNER_NAME_1),
										  if(pInput.orig_OWNER_NAME_TYPE_1='C',
											 'B',
											 'I'
											),
										  ''
										);
	self.OWN_1_CUSTOMER_NAME		:= if(pInput.append_OWNER_1_COMPANY_NAME<>'',
										  pInput.orig_OWNER_NAME_1,
	 									  fFixPersonName(pInput.orig_OWNER_NAME_1)
										 );
	self.OWN_1_STREET_ADDRESS		:= if(pInput.orig_OWNER_STREET_CITY_1<>'',
										  pInput.orig_OWNER_STREET_ADDRESS_1,
										  pInput.orig_OWNER_MAIL_ADDRESS_1
										 );
	self.OWN_1_CITY					:= if(pInput.orig_OWNER_STREET_CITY_1<>'',
										  pInput.orig_OWNER_STREET_CITY_1,
										  pInput.orig_OWNER_MAIL_CITY_1
										 );
	self.OWN_1_STATE				:= if(pInput.orig_OWNER_STREET_CITY_1<>'',
										  pInput.orig_OWNER_STREET_STATE_1,
										  pInput.orig_OWNER_MAIL_STATE_1
										 );
	self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL	:= if(pInput.orig_OWNER_STREET_CITY_1<>'',
											  fFixZipPlus4(pInput.orig_OWNER_STREET_ZIP_1),
											  fFixZipPlus4(pInput.orig_OWNER_MAIL_ZIP_1)
											 );
	self.OWNER_2_CUSTOMER_TYPE		:= if(fValidName(pInput.orig_OWNER_NAME_2),
										  if(pInput.orig_OWNER_NAME_TYPE_2='C',
											 'B',
											 'I'
											),
										  ''
										);
	self.OWN_2_CUSTOMER_NAME		:= if(pInput.append_OWNER_2_COMPANY_NAME<>'',
										  pInput.orig_OWNER_NAME_2,
	 									  fFixPersonName(pInput.orig_OWNER_NAME_2)
										 );
	self.OWN_2_STREET_ADDRESS		:= if(pInput.orig_OWNER_STREET_CITY_2<>'',
										  pInput.orig_OWNER_STREET_ADDRESS_2,
										  pInput.orig_OWNER_MAIL_ADDRESS_2
										 );
	self.OWN_2_CITY					:= if(pInput.orig_OWNER_STREET_CITY_2<>'',
										  pInput.orig_OWNER_STREET_CITY_2,
										  pInput.orig_OWNER_MAIL_CITY_2
										 );
	self.OWN_2_STATE				:= if(pInput.orig_OWNER_STREET_CITY_2<>'',
										  pInput.orig_OWNER_STREET_STATE_2,
										  pInput.orig_OWNER_MAIL_STATE_2
										 );
	self.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL	:= if(pInput.orig_OWNER_STREET_CITY_2<>'',
											  fFixZipPlus4(pInput.orig_OWNER_STREET_ZIP_2),
											  fFixZipPlus4(pInput.orig_OWNER_MAIL_ZIP_2)
											 );
	self.REGISTRANT_1_CUSTOMER_TYPExBG5	:= if(fValidName(pInput.orig_OWNER_NAME_3),
											  if(pInput.orig_OWNER_NAME_TYPE_3='C',
												 'B',
												 'I'
												),
											  ''
											 );
	self.REG_1_CUSTOMER_NAME		:= if(pInput.append_REG_1_COMPANY_NAME<>'',
										  pInput.orig_OWNER_NAME_3,
	 									  fFixPersonName(pInput.orig_OWNER_NAME_3)
										 );
	self.REG_1_STREET_ADDRESS		:= if(pInput.orig_OWNER_STREET_CITY_3<>'',
										  pInput.orig_OWNER_STREET_ADDRESS_3,
										  pInput.orig_OWNER_MAIL_ADDRESS_3
										 );
	self.REG_1_CITY					:= if(pInput.orig_OWNER_STREET_CITY_3<>'',
										  pInput.orig_OWNER_STREET_CITY_3,
										  pInput.orig_OWNER_MAIL_CITY_3
										 );
	self.REG_1_STATE				:= if(pInput.orig_OWNER_STREET_CITY_3<>'',
										  pInput.orig_OWNER_STREET_STATE_3,
										  pInput.orig_OWNER_MAIL_STATE_3
										 );
	self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL	:= if(pInput.orig_OWNER_STREET_CITY_3<>'',
											  fFixZipPlus4(pInput.orig_OWNER_STREET_ZIP_3),
											  fFixZipPlus4(pInput.orig_OWNER_MAIL_ZIP_3)
											 );
	self.REGISTRANT_2_CUSTOMER_TYPE	:= if(fValidName(pInput.orig_OWNER_NAME_4),
											  if(pInput.orig_OWNER_NAME_TYPE_4='C',
												 'B',
												 'I'
												),
											  ''
											 );
	self.REG_2_CUSTOMER_NAME		:= if(pInput.append_REG_2_COMPANY_NAME<>'',
										  pInput.orig_OWNER_NAME_4,
	 									  fFixPersonName(pInput.orig_OWNER_NAME_4)
										 );
	self.REG_2_STREET_ADDRESS		:= if(pInput.orig_OWNER_STREET_CITY_4<>'',
										  pInput.orig_OWNER_STREET_ADDRESS_4,
										  pInput.orig_OWNER_MAIL_ADDRESS_4
										 );
	self.REG_2_CITY					:= if(pInput.orig_OWNER_STREET_CITY_4<>'',
										  pInput.orig_OWNER_STREET_CITY_4,
										  pInput.orig_OWNER_MAIL_CITY_4
										 );
	self.REG_2_STATE				:= if(pInput.orig_OWNER_STREET_CITY_4<>'',
										  pInput.orig_OWNER_STREET_STATE_4,
										  pInput.orig_OWNER_MAIL_STATE_4
										 );
	self.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL	:= if(pInput.orig_OWNER_STREET_CITY_4<>'',
											  fFixZipPlus4(pInput.orig_OWNER_STREET_ZIP_4),
											  fFixZipPlus4(pInput.orig_OWNER_MAIL_ZIP_4)
											 );
	self.own_1_title 	        := pInput.clean_OWNER_1_name_prefix;
	self.own_1_fname 	        := pInput.clean_OWNER_1_name_first;
	self.own_1_mname 	    	:= pInput.clean_OWNER_1_name_middle;
	self.own_1_lname 	    	:= pInput.clean_OWNER_1_name_last;
	self.own_1_name_suffix 	    := pInput.clean_OWNER_1_name_suffix;
	self.own_1_company_name     := pInput.append_OWNER_1_COMPANY_NAME;
	self.own_1_prim_range		:= if(pInput.orig_OWNER_STREET_CITY_1='',
									  pInput.clean_OWNER_1_MAIL_ADDRESS_prim_range,
									  pInput.clean_OWNER_1_STREET_ADDRESS_prim_range
									 );
	self.own_1_predir      		:= if(pInput.orig_OWNER_STREET_CITY_1='',
									  pInput.clean_OWNER_1_MAIL_ADDRESS_predir,
									  pInput.clean_OWNER_1_STREET_ADDRESS_predir
									 );
	self.own_1_prim_name		:= if(pInput.orig_OWNER_STREET_CITY_1='',
									  pInput.clean_OWNER_1_MAIL_ADDRESS_prim_name,
									  pInput.clean_OWNER_1_STREET_ADDRESS_prim_name
									 );
	self.own_1_suffix	  		:= if(pInput.orig_OWNER_STREET_CITY_1='',
									  pInput.clean_OWNER_1_MAIL_ADDRESS_addr_suffix,
									  pInput.clean_OWNER_1_STREET_ADDRESS_addr_suffix
									 );
	self.own_1_postdir			:= if(pInput.orig_OWNER_STREET_CITY_1='',
									  pInput.clean_OWNER_1_MAIL_ADDRESS_postdir,
									  pInput.clean_OWNER_1_STREET_ADDRESS_postdir
									 );
	self.own_1_unit_desig		:= if(pInput.orig_OWNER_STREET_CITY_1='',
									  pInput.clean_OWNER_1_MAIL_ADDRESS_unit_desig,
									  pInput.clean_OWNER_1_STREET_ADDRESS_unit_desig
									 );
	self.own_1_sec_range		:= if(pInput.orig_OWNER_STREET_CITY_1='',
									  pInput.clean_OWNER_1_MAIL_ADDRESS_sec_range,
									  pInput.clean_OWNER_1_STREET_ADDRESS_sec_range
									 );
	self.own_1_p_city_name		:= if(pInput.orig_OWNER_STREET_CITY_1='',
									  pInput.clean_OWNER_1_MAIL_ADDRESS_p_city_name,
									  pInput.clean_OWNER_1_STREET_ADDRESS_p_city_name
									 );
	self.own_1_v_city_name		:= if(pInput.orig_OWNER_STREET_CITY_1='',
									  pInput.clean_OWNER_1_MAIL_ADDRESS_v_city_name,
									  pInput.clean_OWNER_1_STREET_ADDRESS_v_city_name
									 );
	self.own_1_state_2    		:= if(pInput.orig_OWNER_STREET_CITY_1='',
									  pInput.clean_OWNER_1_MAIL_ADDRESS_st,
									  pInput.clean_OWNER_1_STREET_ADDRESS_st
									 );
	self.own_1_zip5				:= if(pInput.orig_OWNER_STREET_CITY_1='',
									  pInput.clean_OWNER_1_MAIL_ADDRESS_zip,
									  pInput.clean_OWNER_1_STREET_ADDRESS_zip
									 );
	self.own_1_zip4      		:= if(pInput.orig_OWNER_STREET_CITY_1='',
									  pInput.clean_OWNER_1_MAIL_ADDRESS_zip4,
									  pInput.clean_OWNER_1_STREET_ADDRESS_zip4
									 );
	self.own_1_county			:= if(pInput.orig_OWNER_STREET_CITY_1='',
									  pInput.clean_OWNER_1_MAIL_ADDRESS_fipscounty,
									  pInput.clean_OWNER_1_STREET_ADDRESS_fipscounty
									 );
	self.own_2_title 	        := pInput.clean_OWNER_2_name_prefix;
	self.own_2_fname 	        := pInput.clean_OWNER_2_name_first;
	self.own_2_mname 	    	:= pInput.clean_OWNER_2_name_middle;
	self.own_2_lname 	    	:= pInput.clean_OWNER_2_name_last;
	self.own_2_name_suffix 	    := pInput.clean_OWNER_2_name_suffix;
	self.own_2_company_name     := pInput.append_OWNER_2_COMPANY_NAME;
	self.own_2_prim_range		:= if(pInput.orig_OWNER_STREET_CITY_2='',
									  pInput.clean_OWNER_2_MAIL_ADDRESS_prim_range,
									  pInput.clean_OWNER_2_STREET_ADDRESS_prim_range
									 );
	self.own_2_predir      		:= if(pInput.orig_OWNER_STREET_CITY_2='',
									  pInput.clean_OWNER_2_MAIL_ADDRESS_predir,
									  pInput.clean_OWNER_2_STREET_ADDRESS_predir
									 );
	self.own_2_prim_name		:= if(pInput.orig_OWNER_STREET_CITY_2='',
									  pInput.clean_OWNER_2_MAIL_ADDRESS_prim_name,
									  pInput.clean_OWNER_2_STREET_ADDRESS_prim_name
									 );
	self.own_2_suffix	  		:= if(pInput.orig_OWNER_STREET_CITY_2='',
									  pInput.clean_OWNER_2_MAIL_ADDRESS_addr_suffix,
									  pInput.clean_OWNER_2_STREET_ADDRESS_addr_suffix
									 );
	self.own_2_postdir			:= if(pInput.orig_OWNER_STREET_CITY_2='',
									  pInput.clean_OWNER_2_MAIL_ADDRESS_postdir,
									  pInput.clean_OWNER_2_STREET_ADDRESS_postdir
									 );
	self.own_2_unit_desig		:= if(pInput.orig_OWNER_STREET_CITY_2='',
									  pInput.clean_OWNER_2_MAIL_ADDRESS_unit_desig,
									  pInput.clean_OWNER_2_STREET_ADDRESS_unit_desig
									 );
	self.own_2_sec_range		:= if(pInput.orig_OWNER_STREET_CITY_2='',
									  pInput.clean_OWNER_2_MAIL_ADDRESS_sec_range,
									  pInput.clean_OWNER_2_STREET_ADDRESS_sec_range
									 );
	self.own_2_p_city_name		:= if(pInput.orig_OWNER_STREET_CITY_2='',
									  pInput.clean_OWNER_2_MAIL_ADDRESS_p_city_name,
									  pInput.clean_OWNER_2_STREET_ADDRESS_p_city_name
									 );
	self.own_2_v_city_name		:= if(pInput.orig_OWNER_STREET_CITY_2='',
									  pInput.clean_OWNER_2_MAIL_ADDRESS_v_city_name,
									  pInput.clean_OWNER_2_STREET_ADDRESS_v_city_name
									 );
	self.own_2_state_2    		:= if(pInput.orig_OWNER_STREET_CITY_2='',
									  pInput.clean_OWNER_2_MAIL_ADDRESS_st,
									  pInput.clean_OWNER_2_STREET_ADDRESS_st
									 );
	self.own_2_zip5				:= if(pInput.orig_OWNER_STREET_CITY_2='',
									  pInput.clean_OWNER_2_MAIL_ADDRESS_zip,
									  pInput.clean_OWNER_2_STREET_ADDRESS_zip
									 );
	self.own_2_zip4      		:= if(pInput.orig_OWNER_STREET_CITY_2='',
									  pInput.clean_OWNER_2_MAIL_ADDRESS_zip4,
									  pInput.clean_OWNER_2_STREET_ADDRESS_zip4
									 );
	self.own_2_county			:= if(pInput.orig_OWNER_STREET_CITY_2='',
									  pInput.clean_OWNER_2_MAIL_ADDRESS_fipscounty,
									  pInput.clean_OWNER_2_STREET_ADDRESS_fipscounty
									 );
	self.reg_1_title 	        := pInput.clean_REG_1_name_prefix;
	self.reg_1_fname 	        := pInput.clean_REG_1_name_first;
	self.reg_1_mname 	    	:= pInput.clean_REG_1_name_middle;
	self.reg_1_lname 	    	:= pInput.clean_REG_1_name_last;
	self.reg_1_name_suffix 	    := pInput.clean_REG_1_name_suffix;
	self.reg_1_company_name     := pInput.append_REG_1_COMPANY_NAME;
	self.reg_1_prim_range		:= if(pInput.orig_OWNER_STREET_CITY_3='',
									  pInput.clean_REG_1_MAIL_ADDRESS_prim_range,
									  pInput.clean_REG_1_STREET_ADDRESS_prim_range
									 );
	self.reg_1_predir      		:= if(pInput.orig_OWNER_STREET_CITY_3='',
									  pInput.clean_REG_1_MAIL_ADDRESS_predir,
									  pInput.clean_REG_1_STREET_ADDRESS_predir
									 );
	self.reg_1_prim_name		:= if(pInput.orig_OWNER_STREET_CITY_3='',
									  pInput.clean_REG_1_MAIL_ADDRESS_prim_name,
									  pInput.clean_REG_1_STREET_ADDRESS_prim_name
									 );
	self.reg_1_suffix	  		:= if(pInput.orig_OWNER_STREET_CITY_3='',
									  pInput.clean_REG_1_MAIL_ADDRESS_addr_suffix,
									  pInput.clean_REG_1_STREET_ADDRESS_addr_suffix
									 );
	self.reg_1_postdir			:= if(pInput.orig_OWNER_STREET_CITY_3='',
									  pInput.clean_REG_1_MAIL_ADDRESS_postdir,
									  pInput.clean_REG_1_STREET_ADDRESS_postdir
									 );
	self.reg_1_unit_desig		:= if(pInput.orig_OWNER_STREET_CITY_3='',
									  pInput.clean_REG_1_MAIL_ADDRESS_unit_desig,
									  pInput.clean_REG_1_STREET_ADDRESS_unit_desig
									 );
	self.reg_1_sec_range		:= if(pInput.orig_OWNER_STREET_CITY_3='',
									  pInput.clean_REG_1_MAIL_ADDRESS_sec_range,
									  pInput.clean_REG_1_STREET_ADDRESS_sec_range
									 );
	self.reg_1_p_city_name		:= if(pInput.orig_OWNER_STREET_CITY_3='',
									  pInput.clean_REG_1_MAIL_ADDRESS_p_city_name,
									  pInput.clean_REG_1_STREET_ADDRESS_p_city_name
									 );
	self.reg_1_v_city_name		:= if(pInput.orig_OWNER_STREET_CITY_3='',
									  pInput.clean_REG_1_MAIL_ADDRESS_v_city_name,
									  pInput.clean_REG_1_STREET_ADDRESS_v_city_name
									 );
	self.reg_1_state_2    		:= if(pInput.orig_OWNER_STREET_CITY_3='',
									  pInput.clean_REG_1_MAIL_ADDRESS_st,
									  pInput.clean_REG_1_STREET_ADDRESS_st
									 );
	self.reg_1_zip5				:= if(pInput.orig_OWNER_STREET_CITY_3='',
									  pInput.clean_REG_1_MAIL_ADDRESS_zip,
									  pInput.clean_REG_1_STREET_ADDRESS_zip
									 );
	self.reg_1_zip4      		:= if(pInput.orig_OWNER_STREET_CITY_3='',
									  pInput.clean_REG_1_MAIL_ADDRESS_zip4,
									  pInput.clean_REG_1_STREET_ADDRESS_zip4
									 );
	self.reg_1_county			:= if(pInput.orig_OWNER_STREET_CITY_3='',
									  pInput.clean_REG_1_MAIL_ADDRESS_fipscounty,
									  pInput.clean_REG_1_STREET_ADDRESS_fipscounty
									 );
	self.reg_2_title 	        := pInput.clean_REG_2_name_prefix;
	self.reg_2_fname 	        := pInput.clean_REG_2_name_first;
	self.reg_2_mname 	    	:= pInput.clean_REG_2_name_middle;
	self.reg_2_lname 	    	:= pInput.clean_REG_2_name_last;
	self.reg_2_name_suffix 	    := pInput.clean_REG_2_name_suffix;
	self.reg_2_company_name     := pInput.append_REG_2_COMPANY_NAME;
	self.reg_2_prim_range		:= if(pInput.orig_OWNER_STREET_CITY_4='',
									  pInput.clean_REG_2_MAIL_ADDRESS_prim_range,
									  pInput.clean_REG_2_STREET_ADDRESS_prim_range
									 );
	self.reg_2_predir      		:= if(pInput.orig_OWNER_STREET_CITY_4='',
									  pInput.clean_REG_2_MAIL_ADDRESS_predir,
									  pInput.clean_REG_2_STREET_ADDRESS_predir
									 );
	self.reg_2_prim_name		:= if(pInput.orig_OWNER_STREET_CITY_4='',
									  pInput.clean_REG_2_MAIL_ADDRESS_prim_name,
									  pInput.clean_REG_2_STREET_ADDRESS_prim_name
									 );
	self.reg_2_suffix	  		:= if(pInput.orig_OWNER_STREET_CITY_4='',
									  pInput.clean_REG_2_MAIL_ADDRESS_addr_suffix,
									  pInput.clean_REG_2_STREET_ADDRESS_addr_suffix
									 );
	self.reg_2_postdir			:= if(pInput.orig_OWNER_STREET_CITY_4='',
									  pInput.clean_REG_2_MAIL_ADDRESS_postdir,
									  pInput.clean_REG_2_STREET_ADDRESS_postdir
									 );
	self.reg_2_unit_desig		:= if(pInput.orig_OWNER_STREET_CITY_4='',
									  pInput.clean_REG_2_MAIL_ADDRESS_unit_desig,
									  pInput.clean_REG_2_STREET_ADDRESS_unit_desig
									 );
	self.reg_2_sec_range		:= if(pInput.orig_OWNER_STREET_CITY_4='',
									  pInput.clean_REG_2_MAIL_ADDRESS_sec_range,
									  pInput.clean_REG_2_STREET_ADDRESS_sec_range
									 );
	self.reg_2_p_city_name		:= if(pInput.orig_OWNER_STREET_CITY_4='',
									  pInput.clean_REG_2_MAIL_ADDRESS_p_city_name,
									  pInput.clean_REG_2_STREET_ADDRESS_p_city_name
									 );
	self.reg_2_v_city_name		:= if(pInput.orig_OWNER_STREET_CITY_4='',
									  pInput.clean_REG_2_MAIL_ADDRESS_v_city_name,
									  pInput.clean_REG_2_STREET_ADDRESS_v_city_name
									 );
	self.reg_2_state_2    		:= if(pInput.orig_OWNER_STREET_CITY_4='',
									  pInput.clean_REG_2_MAIL_ADDRESS_st,
									  pInput.clean_REG_2_STREET_ADDRESS_st
									 );
	self.reg_2_zip5				:= if(pInput.orig_OWNER_STREET_CITY_4='',
									  pInput.clean_REG_2_MAIL_ADDRESS_zip,
									  pInput.clean_REG_2_STREET_ADDRESS_zip
									 );
	self.reg_2_zip4      		:= if(pInput.orig_OWNER_STREET_CITY_4='',
									  pInput.clean_REG_2_MAIL_ADDRESS_zip4,
									  pInput.clean_REG_2_STREET_ADDRESS_zip4
									 );
	self.reg_2_county			:= if(pInput.orig_OWNER_STREET_CITY_4='',
									  pInput.clean_REG_2_MAIL_ADDRESS_fipscounty,
									  pInput.clean_REG_2_STREET_ADDRESS_fipscounty
									 );
end;

export MT_as_Vehicles := project(vehlic.File_MT_Full + vehlic.File_MT_Update, tMTSourceToCommon(left));