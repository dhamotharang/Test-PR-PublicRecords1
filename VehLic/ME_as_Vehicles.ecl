import ut, lib_stringlib;

string lFullZipFromSeparate(string pZip5, string pZip4)
 :=	pZip5
 +	if(pZip4 in ['0000','    ','9999'],
       '',
	   '-' + pZip4[1..4]
	  )
 ;

vehlic.Layout_Vehicles lMEFullToVehicles(Vehlic.Layout_ME_Full pInput) := transform
	self.orig_state:='ME';
	self.dt_first_seen := (unsigned8)(pInput.append_PROCESS_DATE[1..6]);
	self.dt_last_seen := (unsigned8)(pInput.append_PROCESS_DATE[1..6]);
	self.dt_vendor_first_reported:=(unsigned8)(pInput.append_PROCESS_DATE[1..6]);
	self.dt_vendor_last_reported:=(unsigned8)(pInput.append_PROCESS_DATE[1..6]);

	self.VEHICLE_NUMBERxBG1 := if(length(trim(pInput.orig_VEHICLE_VIN)) < 11 or 
								  lib_stringlib.stringlib.stringfilterout(pInput.orig_VEHICLE_VIN,'0') = '',
								  trim(pinput.orig_VEHICLE_VIN) + trim(pInput.orig_LAST_NAME) + trim(pInput.orig_FIRST_NAME) + trim(pInput.orig_MIDDLE_INITIAL),
								  pInput.orig_VEHICLE_VIN + pInput.orig_VIN_DUP_NUM
							     );
	self.ORIG_VIN := pInput.orig_VEHICLE_VIN;
	self.YEAR_MAKE 			:= pInput.orig_VEH_YEAR;
	self.MAKE_CODE 			:= pInput.orig_VEH_MAKE;
	// We'll derive here, so that VEHICLE_USE will be an "L" if we can assume the
	// the vehicle is leased.  CODES_V3 will have "Leased" for this entry.  Otherwise,
	// it will be blank.
	self.VEHICLE_USE		:= if(pInput.orig_LESSOR_NAME<>'' or pInput.orig_LESSEE_NAME<>'',
								  'L',
								  ''
								 );
	self.BODY_CODE 			:= pInput.orig_VEH_STYLE;							//See codes lookup
	self.MAJOR_COLOR_CODE 	:= pInput.orig_VEH_COLOR_1;	        	            //See codes lookup
	self.MINOR_COLOR_CODE 	:= pInput.orig_VEH_COLOR_2;	            	        //See codes lookup
	self.FUEL_TYPE 			:= pInput.orig_VEH_FUEL_TYPE;			            //See codes lookup
	self.ODOMETER_MILEAGE 	:= pInput.orig_REG_ODOMETER;

	self.LICENSE_PLATE_NUMBERxBG4 := if(pInput.orig_REG_PLATE<>'',
										pInput.orig_REG_PLATE,
										pInput.orig_VANITY_NEW_PLATE
									   );
	self.REGISTRATION_EXPIRATION_DATE := pInput.orig_EXPIRE_DATE;
	self.REGISTRATION_EFFECTIVE_DATE := pInput.orig_EFFECTIVE_DATE;
	
	self.TRUE_LICENSE_PLSTE_NUMBER := if(pInput.orig_REG_PLATE<>'',
										pInput.orig_REG_PLATE,
										pInput.orig_VANITY_NEW_PLATE
									   );
	self.REGISTRANT_1_CUSTOMER_TYPExBG5 := vehlic.getCusType(pInput.clean_reg_1_name_first, pInput.clean_reg_1_name_last, pInput.clean_reg_1_company_name);
	self.REG_1_CUSTOMER_NAME := if(pInput.clean_reg_1_company_name<>'',
								   pInput.orig_LAST_NAME + pInput.orig_FIRST_NAME + pInput.orig_MIDDLE_INITIAL + pInput.orig_SUFFIX + pInput.orig_COMPANY_EXTRA,
								   pInput.orig_FIRST_NAME + trim(' ' + pInput.orig_MIDDLE_INITIAL) + trim(' ' + pInput.orig_LAST_NAME) + trim(' ' + pInput.orig_SUFFIX)
								  );
	self.REG_1_DOB := if(pInput.orig_LAST_NAME<>'',
						 if(pInput.orig_DATE_OF_BIRTH not in ['000000000','99999999'],
							pInput.orig_DATE_OF_BIRTH,
							''
						   ),
						 ''
						);
	self.REG_1_STREET_ADDRESS := pInput.orig_ADDRESS_1 + pInput.orig_ADDRESS_2;
	self.REG_1_CITY := pInput.orig_TOWN;
	self.REG_1_STATE := pInput.orig_STATE;
	self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL := lFullZipFromSeparate(pInput.orig_ZIP_CODE,pInput.orig_ZIP_CODE_PLUS);
	self.REGISTRANT_2_CUSTOMER_TYPE := vehlic.getCusType(pInput.clean_reg_2_name_first, pInput.clean_reg_2_name_last, pInput.clean_reg_2_company_name);
	self.REG_2_CUSTOMER_NAME := if(pInput.clean_reg_2_company_name<>'',
								   pInput.orig_JOINT_LAST_NAME + pInput.orig_JOINT_FIRST_NAME + pInput.orig_MIDDLE_INITIAL + pInput.orig_JOINT_SUFFIX + pInput.orig_JOINT_COMPANY_EXTRA,
								   pInput.orig_JOINT_FIRST_NAME + trim(' ' + pInput.orig_JOINT_MID_INITIAL) + trim(' ' + pInput.orig_JOINT_LAST_NAME) + trim(' ' + pInput.orig_JOINT_SUFFIX)
								  );
	self.REG_2_DOB := if(pInput.orig_JOINT_LAST_NAME<>'',
						 if(pInput.orig_JOINT_DATE_OF_BIRTH not in ['000000000','99999999'],
							pInput.orig_JOINT_DATE_OF_BIRTH,
							''
						   ),
						 ''
						);
	self.TITLE_NUMBERxBG9 	:= pInput.orig_TITLE_NUM;
	self.LH_1_CUSTOMER_NAME := 'NOT AVAILABLE';
	self.LH_2_CUSTOMER_NAME := 'NOT AVAILABLE';
	self.reg_1_title 		:= pInput.clean_reg_1_name_title;
	self.reg_1_fname 		:= pInput.clean_reg_1_name_first;
	self.reg_1_mname 		:= pInput.clean_reg_1_name_middle;
	self.reg_1_lname 		:= pInput.clean_reg_1_name_last;
	self.reg_1_name_suffix 	:= pInput.clean_reg_1_name_suffix;
	self.reg_1_company_name := pInput.clean_reg_1_company_name;
	self.reg_2_title 		:= pInput.clean_reg_2_name_title;
	self.reg_2_fname 		:= pInput.clean_reg_2_name_first;
	self.reg_2_mname 		:= pInput.clean_reg_2_name_middle;
	self.reg_2_lname 		:= pInput.clean_reg_2_name_last;
	self.reg_2_name_suffix 	:= pInput.clean_reg_2_name_suffix;
	self.reg_2_company_name := pInput.clean_reg_2_company_name;
	self.reg_1_prim_range 	:= pInput.clean_reg_address_prim_range;
	self.reg_1_predir 		:= pInput.clean_reg_address_predir;
	self.reg_1_prim_name 	:= pInput.clean_reg_address_prim_name;
	self.reg_1_suffix 		:= pInput.clean_reg_address_addr_suffix;
	self.reg_1_postdir 		:= pInput.clean_reg_address_postdir;
	self.reg_1_unit_desig 	:= pInput.clean_reg_address_unit_desig;
	self.reg_1_sec_range 	:= pInput.clean_reg_address_sec_range;
	self.reg_1_p_city_name 	:= pInput.clean_reg_address_p_city_name;
	self.reg_1_v_city_name 	:= pInput.clean_reg_address_v_city_name;
	self.reg_1_state_2 		:= pInput.clean_reg_address_state;
	self.reg_1_zip5 		:= pInput.clean_reg_address_zip5;
	self.reg_1_zip4 		:= pInput.clean_reg_address_zip4;
	self.reg_2_prim_range 	:= if(pInput.clean_reg_2_name_last<>'',pInput.clean_reg_address_prim_range,'');
	self.reg_2_predir 		:= if(pInput.clean_reg_2_name_last<>'',pInput.clean_reg_address_predir,'');
	self.reg_2_prim_name 	:= if(pInput.clean_reg_2_name_last<>'',pInput.clean_reg_address_prim_name,'');
	self.reg_2_suffix 		:= if(pInput.clean_reg_2_name_last<>'',pInput.clean_reg_address_addr_suffix,'');
	self.reg_2_postdir 		:= if(pInput.clean_reg_2_name_last<>'',pInput.clean_reg_address_postdir,'');
	self.reg_2_unit_desig 	:= if(pInput.clean_reg_2_name_last<>'',pInput.clean_reg_address_unit_desig,'');
	self.reg_2_sec_range 	:= if(pInput.clean_reg_2_name_last<>'',pInput.clean_reg_address_sec_range,'');
	self.reg_2_p_city_name 	:= if(pInput.clean_reg_2_name_last<>'',pInput.clean_reg_address_p_city_name,'');
	self.reg_2_v_city_name 	:= if(pInput.clean_reg_2_name_last<>'',pInput.clean_reg_address_v_city_name,'');
	self.reg_2_state_2 		:= if(pInput.clean_reg_2_name_last<>'',pInput.clean_reg_address_state,'');
	self.reg_2_zip5 		:= if(pInput.clean_reg_2_name_last<>'',pInput.clean_reg_address_zip5,'');
	self.reg_2_zip4 		:= if(pInput.clean_reg_2_name_last<>'',pInput.clean_reg_address_zip4,'');
end;

export ME_as_Vehicles := project(vehlic.File_ME_Full, lMEFullToVehicles(left));