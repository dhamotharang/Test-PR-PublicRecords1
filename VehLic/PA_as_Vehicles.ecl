import ut, lib_stringlib;

lDaysInMonthSet := ['31','28','31','30','31','30','31','31','30','31','30','31'];

string2 fLastDayOfMonth(string2 pMonthString)
 := lDaysInMonthSet[(integer1)pMonthString];

string4 fYYtoCCYY(string2 pYYString)
 := if((integer2)pYYString > 25,
	   '19' + pYYString,
	   if(pYYString <> '',
		  '20' + pYYString,
		  ''
		 )
	  )
 ;

string8 fYMtoCYMD(string2 pYearString, string2 pMonthString)
 := if(pYearString='' or (integer4)pMonthString=0,
	   '',
	   fYYtoCCYY(pYearString)+pMonthString+fLastDayOfMonth(pMonthString)
	  );

string8 fYMDtoCYMD(string6 pDateIn)
 := if((integer4)pDateIn=0,
	   '',
	   fYYtoCCYY(pDateIn[1..2]) + pDateIn[3..6]
	  );

string fFixNumber(string pNumberIn)
 := if((integer4)pNumberIn = 0,
	   '',
	   trim((string)(integer4)pNumberIn,left,right)
	  );

Layout_Vehicles lPAFullToVehicles(Layout_PA_Full pInput)
 :=
  transform
	self.orig_state:='PA';
	self.dt_first_seen := (unsigned8)(pInput.append_PROCESS_DATE[1..6]);
	self.dt_last_seen := (unsigned8)(pInput.append_PROCESS_DATE[1..6]);
	self.dt_vendor_first_reported:=(unsigned8)(pInput.append_PROCESS_DATE[1..6]);
	self.dt_vendor_last_reported:=(unsigned8)(pInput.append_PROCESS_DATE[1..6]);

	self.VEHICLE_NUMBERxBG1 := if(length(trim(pInput.orig_VIN)) < 17
							   or lib_stringlib.stringlib.stringfilterout(pInput.orig_VIN,'0') = '',
								  trim(pinput.orig_VIN) + trim(pInput.orig_OWNER_NAME),
								  pInput.orig_VIN
							     );
	self.ORIG_VIN 			:= pInput.orig_VIN;
	self.YEAR_MAKE 			:= fYYtoCCYY(pInput.orig_MODEL_YEAR);
	self.MAKE_CODE			:= pInput.orig_MAKE_CODE;
	self.BODY_CODE			:= pInput.orig_BODY_TYPE;
	self.MODEL				:= pInput.orig_MODEL_CODE;
	// We'll derive here, so that VEHICLE_USE will be an "L" if we can assume the
	// the vehicle is leased.  CODES_V3 will have "Leased" for this entry.  Otherwise,
	// it will be blank.  Per specs, assume leased if LESSEE_NAME <> ''.
	self.VEHICLE_USE		:= if(pInput.orig_LESSEE_NAME <> '',
								  'L',
								  ''
								 );
	self.ODOMETER_STATUS	:= pInput.orig_ODOMETER_QUALIFIER;
	self.ODOMETER_MILEAGE 	:= fFixNumber(pInput.orig_CURRENT_ODOM_READING);
	self.LICENSE_PLATE_NUMBERxBG4 := pInput.orig_TAG;
	self.TRUE_LICENSE_PLSTE_NUMBER := pInput.orig_TAG;
	self.TITLE_NUMBERxBG9 	:= pInput.orig_TITLE_NUMBER;
	self.TITLE_ISSUE_DATE	:= fYMDtoCYMD(pInput.orig_TITLE_EST_DATE);

	self.REGISTRATION_EXPIRATION_DATE := fYMtoCYMD(pInput.orig_EXPIRATION_YEAR,pInput.orig_EXPIRATION_MONTH);
	self.LIEN_COUNTxBG10	:= fFixNumber(pInput.orig_LIEN_HOLDER_COUNT);
	self.OWNER_1_CUSTOMER_TYPExBG3 := if(pInput.orig_OWNER_NAME_CODE = 'C',
										 'B',
										 'I'
										),
	self.OWNER_2_CUSTOMER_TYPE := if(pInput.clean_OWNER1_NAME_last <> '',
									 'I',
									 ''
									);
	self.REGISTRANT_1_CUSTOMER_TYPExBG5   := if(pInput.orig_LESSEE_NAME_CODE = 'C',
												'B',
											    if(pInput.orig_LESSEE_NAME <> '',
												   'I',
												   self.OWNER_1_CUSTOMER_TYPExBG3
											      )
											   );
	self.REGISTRANT_2_CUSTOMER_TYPE := if(pInput.orig_LESSEE_NAME_CODE = 'C',
										  ' ',
										  if(pInput.orig_LESSEE_NAME <> '',
											 'I',
											 self.OWNER_2_CUSTOMER_TYPE
										    )
										 );
	self.OWN_1_CUSTOMER_NAME := pInput.orig_OWNER_NAME;
	self.OWN_1_STREET_ADDRESS := pInput.orig_OWNER_ADDRESS_1 + ' ' + pInput.orig_OWNER_ADDRESS_2;
	self.OWN_1_CITY			:= pInput.orig_OWNER_CITY;
	self.OWN_1_STATE		:= pInput.orig_OWNER_STATE;
	self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL := pInput.orig_OWNER_ZIP_CODE;
	self.REG_1_CUSTOMER_NAME := if(pInput.orig_LESSEE_NAME <> '',
								   pInput.orig_LESSEE_NAME,
								   pInput.orig_OWNER_NAME
								  );
	self.REG_1_STREET_ADDRESS := if(pInput.orig_LESSEE_NAME <> '',
									pInput.orig_LESSEE_ADDRESS_1,
									pInput.orig_OWNER_ADDRESS_1
								   );
	self.REG_1_CITY			:= if(pInput.orig_LESSEE_NAME <> '',
								  pInput.orig_LESSEE_CITY,
								  pInput.orig_OWNER_CITY
								 );
	self.REG_1_STATE		:= if(pInput.orig_LESSEE_NAME <> '',
								  pInput.orig_LESSEE_STATE,
								  pInput.orig_OWNER_STATE
								 );
	self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL := if(pInput.orig_LESSEE_NAME <> '',
											  pInput.orig_LESSEE_ZIP,
											  pInput.orig_OWNER_ZIP_CODE
											 );
	self.JOINT_OWNERSHIP_CODExAND_OR := if(pInput.orig_OWNER_NAME_CODE = 'C',
										   '',
										   if(lib_stringlib.stringlib.stringfind(pInput.orig_OWNER_NAME,'/',1) <> 0,
											  'AND',
											  if(lib_stringlib.stringlib.stringfind(pInput.orig_OWNER_NAME,'&',1) <> 0,
												 'OR',
												 ''
											    )
											 )
										  );
	self.GROSS_WEIGHT := fFixNumber(pInput.orig_GROSS_VEHICLE_WEIGHT_RATE);
	self.FUEL_TYPE := pInput.orig_FUEL_TYPE;
	self.NUMBER_OF_AXLES := fFixNumber(pInput.orig_NUMBER_OF_AXLES);
	self.NET_WEIGHT := fFixNumber(pInput.orig_UNLADEN_WEIGHT);

	self.own_1_title 		:= pInput.clean_OWNER1_NAME_prefix;
	self.own_1_fname 		:= pInput.clean_OWNER1_NAME_first;
	self.own_1_mname 		:= pInput.clean_OWNER1_NAME_middle;
	self.own_1_lname 		:= pInput.clean_OWNER1_NAME_last;
	self.own_1_name_suffix 	:= pInput.clean_OWNER1_NAME_suffix;
	self.own_1_company_name := pInput.clean_OWNER_NAME_COMPANY;
	self.own_2_title 		:= pInput.clean_OWNER2_NAME_prefix;
	self.own_2_fname 		:= pInput.clean_OWNER2_NAME_first;
	self.own_2_mname 		:= pInput.clean_OWNER2_NAME_middle;
	self.own_2_lname 		:= pInput.clean_OWNER2_NAME_last;
	self.own_2_name_suffix 	:= pInput.clean_OWNER2_NAME_suffix;
	self.own_1_prim_range 	:= pInput.clean_OWNER_address_prim_range;
	self.own_1_predir 		:= pInput.clean_OWNER_address_predir;
	self.own_1_prim_name 	:= pInput.clean_OWNER_address_prim_name;
	self.own_1_suffix 		:= pInput.clean_OWNER_address_addr_suffix;
	self.own_1_postdir 		:= pInput.clean_OWNER_address_postdir;
	self.own_1_unit_desig 	:= pInput.clean_OWNER_address_unit_desig;
	self.own_1_sec_range 	:= pInput.clean_OWNER_address_sec_range;
	self.own_1_p_city_name 	:= pInput.clean_OWNER_address_p_city_name;
	self.own_1_v_city_name 	:= pInput.clean_OWNER_address_v_city_name;
	self.own_1_state_2 		:= pInput.clean_OWNER_address_st;
	self.own_1_zip5 		:= pInput.clean_OWNER_address_zip;
	self.own_1_zip4 		:= pInput.clean_OWNER_address_zip4;
	self.own_2_prim_range 	:= if(pInput.clean_OWNER2_NAME_last='','',pInput.clean_OWNER_address_prim_range);
	self.own_2_predir 		:= if(pInput.clean_OWNER2_NAME_last='','',pInput.clean_OWNER_address_predir);
	self.own_2_prim_name 	:= if(pInput.clean_OWNER2_NAME_last='','',pInput.clean_OWNER_address_prim_name);
	self.own_2_suffix 		:= if(pInput.clean_OWNER2_NAME_last='','',pInput.clean_OWNER_address_addr_suffix);
	self.own_2_postdir 		:= if(pInput.clean_OWNER2_NAME_last='','',pInput.clean_OWNER_address_postdir);
	self.own_2_unit_desig 	:= if(pInput.clean_OWNER2_NAME_last='','',pInput.clean_OWNER_address_unit_desig);
	self.own_2_sec_range 	:= if(pInput.clean_OWNER2_NAME_last='','',pInput.clean_OWNER_address_sec_range);
	self.own_2_p_city_name 	:= if(pInput.clean_OWNER2_NAME_last='','',pInput.clean_OWNER_address_p_city_name);
	self.own_2_v_city_name 	:= if(pInput.clean_OWNER2_NAME_last='','',pInput.clean_OWNER_address_v_city_name);
	self.own_2_state_2 		:= if(pInput.clean_OWNER2_NAME_last='','',pInput.clean_OWNER_address_st);
	self.own_2_zip5 		:= if(pInput.clean_OWNER2_NAME_last='','',pInput.clean_OWNER_address_zip);
	self.own_2_zip4 		:= if(pInput.clean_OWNER2_NAME_last='','',pInput.clean_OWNER_address_zip4);
	self.reg_1_title 		:= pInput.clean_REG1_NAME_prefix;
	self.reg_1_fname 		:= pInput.clean_REG1_NAME_first;
	self.reg_1_mname 		:= pInput.clean_REG1_NAME_middle;
	self.reg_1_lname 		:= pInput.clean_REG1_NAME_last;
	self.reg_1_name_suffix 	:= pInput.clean_REG1_NAME_suffix;
	self.reg_1_company_name := pInput.clean_REG_NAME_company;
	self.reg_2_title 		:= pInput.clean_REG2_NAME_prefix;
	self.reg_2_fname 		:= pInput.clean_REG2_NAME_first;
	self.reg_2_mname 		:= pInput.clean_REG2_NAME_middle;
	self.reg_2_lname 		:= pInput.clean_REG2_NAME_last;
	self.reg_2_name_suffix 	:= pInput.clean_REG2_NAME_suffix;
	self.reg_1_prim_range 	:= pInput.clean_REG_address_prim_range;
	self.reg_1_predir 		:= pInput.clean_REG_address_predir;
	self.reg_1_prim_name 	:= pInput.clean_REG_address_prim_name;
	self.reg_1_suffix 		:= pInput.clean_REG_address_addr_suffix;
	self.reg_1_postdir 		:= pInput.clean_REG_address_postdir;
	self.reg_1_unit_desig 	:= pInput.clean_REG_address_unit_desig;
	self.reg_1_sec_range 	:= pInput.clean_REG_address_sec_range;
	self.reg_1_p_city_name 	:= pInput.clean_REG_address_p_city_name;
	self.reg_1_v_city_name 	:= pInput.clean_REG_address_v_city_name;
	self.reg_1_state_2 		:= pInput.clean_REG_address_st;
	self.reg_1_zip5 		:= pInput.clean_REG_address_zip;
	self.reg_1_zip4 		:= pInput.clean_REG_address_zip4;
	self.reg_2_prim_range 	:= if(pInput.clean_REG2_NAME_last='','',pInput.clean_REG_address_prim_range);
	self.reg_2_predir 		:= if(pInput.clean_REG2_NAME_last='','',pInput.clean_REG_address_predir);
	self.reg_2_prim_name 	:= if(pInput.clean_REG2_NAME_last='','',pInput.clean_REG_address_prim_name);
	self.reg_2_suffix 		:= if(pInput.clean_REG2_NAME_last='','',pInput.clean_REG_address_addr_suffix);
	self.reg_2_postdir 		:= if(pInput.clean_REG2_NAME_last='','',pInput.clean_REG_address_postdir);
	self.reg_2_unit_desig 	:= if(pInput.clean_REG2_NAME_last='','',pInput.clean_REG_address_unit_desig);
	self.reg_2_sec_range 	:= if(pInput.clean_REG2_NAME_last='','',pInput.clean_REG_address_sec_range);
	self.reg_2_p_city_name 	:= if(pInput.clean_REG2_NAME_last='','',pInput.clean_REG_address_p_city_name);
	self.reg_2_v_city_name 	:= if(pInput.clean_REG2_NAME_last='','',pInput.clean_REG_address_v_city_name);
	self.reg_2_state_2 		:= if(pInput.clean_REG2_NAME_last='','',pInput.clean_REG_address_st);
	self.reg_2_zip5 		:= if(pInput.clean_REG2_NAME_last='','',pInput.clean_REG_address_zip);
	self.reg_2_zip4 		:= if(pInput.clean_REG2_NAME_last='','',pInput.clean_REG_address_zip4);
  end
 ;

export PA_as_Vehicles := project(File_PA_Full, lPAFullToVehicles(left));