import Ut, vehicleV2, vehlic;	
					// utilities library
NC_Full 	       := Vehlic.File_NC_Full;
NC_Nonupdating     := VehLic.File_NC_NonUpdating;
NC_Update 	       := Vehlic.File_NC_Update;


recordof(NC_Update) tformat(NC_Nonupdating L) := transform

self.TITLE_TYPE_CODE := '';
self.filler_3 := '';
self := L;

end;

nc_old := project(NC_Full + NC_Nonupdating, tformat(left));


string8 fDateWithoutDashes(string pDashedDate) := pDashedDate[7..10]
											    + pDashedDate[1..2]
											    + pDashedDate[4..5];
    
VehicleV2.Layout_NC_temp_module.Layout_NC_as_VehicleV2 NCToCommon(VehLic.Layout_NC_Update pLeft) := transform
	self.state_origin:='NC';
	self.dt_first_seen := (unsigned8)(pLeft.process_date[1..6]);
    self.dt_last_seen := (unsigned8)(pLeft.process_date[1..6]);
	self.dt_vendor_first_reported:=(unsigned8)(pLeft.process_date[1..6]);
	self.dt_vendor_last_reported:=(unsigned8)(pLeft.process_date[1..6]);
	self.ORIG_VIN := pLeft.VEHICLE_IDENTIFICATION;
	self.YEAR_MAKE := pLeft.MODEL_YEAR;
	self.MAKE_CODE := pLeft.MAKE_CODE;					//THOR cleanup, CODES_V3 lookup
	self.BODY_CODE := pLeft.BODY_STYLE;					//CODES_V3 lookup
	self.LICENSE_PLATE_NUMBERxBG4 := pLeft.PLATE_NUMBER;
    self.REGISTRATION_Effective_DATE := if((unsigned4)fDateWithoutDashes(pLeft.REGISTRATION_EXPIRATION_DATE)[1..6] > (unsigned4)fDateWithoutDashes(pLeft.REGISTRATION_ISSUE_DATE)[1..6], fDateWithoutDashes(pLeft.REGISTRATION_ISSUE_DATE), '');
	self.REGISTRATION_EXPIRATION_DATE := if((unsigned4)fDateWithoutDashes(pLeft.REGISTRATION_EXPIRATION_DATE)[1..6] > (unsigned4)fDateWithoutDashes(pLeft.REGISTRATION_ISSUE_DATE)[1..6], fDateWithoutDashes(pLeft.REGISTRATION_EXPIRATION_DATE), '');
	self.REGISTRATION_STATUS_CODE := pLeft.REGISTRATION_STATUS_CODE[1];
	self.TRUE_LICENSE_PLSTE_NUMBER := pLeft.PLATE_NUMBER;
	self.history := if( self.REGISTRATION_EXPIRATION_DATE < ut.GetDate[1..6] and (unsigned4)(self.registration_expiration_date[1..6]) <> 0,'E', '');						 
	self.REGISTRANT_1_CUSTOMER_type := map(trim(pLeft.owner1_name_first + pLeft.owner1_name_last) <> '' => 'I',trim(pLeft.owner1_company_name) <> '' => 'B','');
	self.REG_1_CUSTOMER_NAME := pLeft.orig_OWNER1_LAST_NAME + pLeft.orig_OWNER1_FIRST_NAME + pLeft.orig_OWNER1_MIDDLE_NAME + pLeft.orig_OWNER1_NAME_SUFFIX;
	self.REG_1_STREET_ADDRESS := pLeft.OWNER_RESIDENCE_MAIL_ADDRESS_1 + pLeft.OWNER_RESIDENCE_MAIL_ADDRESS_2;
	self.REG_1_CITY := pLeft.OWNER_RESIDENCE_MAIL_CITY;
	self.REG_1_STATE := pLeft.OWNER_RESIDENCE_MAIL_STATE;
	self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL := if(pLeft.orig_OWNER_ZIP_CODE[6..9] = '0000',
										      pLeft.orig_OWNER_ZIP_CODE[1..5],
											  pleft.orig_OWNER_ZIP_CODE[1..5] + '-' + pLeft.orig_OWNER_ZIP_CODE[6..9]);
	self.REG_2_CUSTOMER_NAME := pLeft.orig_OWNER2_LAST_NAME + pLeft.orig_OWNER2_FIRST_NAME + pLeft.orig_OWNER2_MIDDLE_NAME + pLeft.orig_OWNER2_NAME_SUFFIX;
	self.REGISTRANT_2_CUSTOMER_TYPE := if(trim(self.REG_2_CUSTOMER_NAME)<>'',
										  map(trim(pLeft.owner2_name_first + pLeft.owner2_name_last) <> '' => 'I',trim(pLeft.owner2_company_name) <> '' => 'B','U'),
										  ''
										 );
	self.REG_2_STREET_ADDRESS := if(trim(self.REG_2_CUSTOMER_NAME)<>'',
									pLeft.OWNER_RESIDENCE_MAIL_ADDRESS_1 + pLeft.OWNER_RESIDENCE_MAIL_ADDRESS_2,
									''
								   );
	self.REG_2_CITY := if(trim(self.REG_2_CUSTOMER_NAME)<>'',
						  pLeft.OWNER_RESIDENCE_MAIL_CITY,
						  ''
						 );
	self.REG_2_STATE := if(trim(self.REG_2_CUSTOMER_NAME)<>'',
						   pLeft.OWNER_RESIDENCE_MAIL_STATE,
						   ''
						  );
	self.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL := if(trim(self.REG_2_CUSTOMER_NAME)<>'',
											  if(pLeft.orig_OWNER_ZIP_CODE[6..9] = '0000',
										         pLeft.orig_OWNER_ZIP_CODE[1..5],
											     pleft.orig_OWNER_ZIP_CODE[1..5] + '-' + pLeft.orig_OWNER_ZIP_CODE[6..9]),
											  ''
											 );
	self.TITLE_NUMBERxBG9 	:= pLeft.TITLE_NUMBER;
	self.TITLE_ISSUE_DATE 	:= fDateWithoutDashes(pLeft.TITLE_TRANSFER_DATE);
	self.reg_1_title 		:= pLeft.owner1_name_title;
	self.reg_1_fname 		:= pLeft.owner1_name_first;
	self.reg_1_mname 		:= pLeft.owner1_name_middle;
	self.reg_1_lname 		:= pLeft.owner1_name_last;
	self.reg_1_name_suffix 	:= pLeft.owner1_name_suffix;
	self.reg_1_company_name := pLeft.owner1_company_name;
	self.reg_1_prim_range 	:= pLeft.owner_address_prim_range;		                             
	self.reg_1_predir 		:= pLeft.owner_address_predir;		                             
	self.reg_1_prim_name 	:= pLeft.owner_address_prim_name;		                             
	self.reg_1_suffix 		:= pLeft.owner_address_suffix;		                             
	self.reg_1_postdir 		:= pLeft.owner_address_postdir;		                             
	self.reg_1_unit_desig 	:= pLeft.owner_address_unit_desig;		                             
	self.reg_1_sec_range 	:= pLeft.owner_address_sec_range;		                             
	self.reg_1_p_city_name 	:= pLeft.owner_address_p_city_name;		                             
	self.reg_1_v_city_name 	:= pLeft.owner_address_v_city_name;		                             
	self.reg_1_state_2 		:= pLeft.owner_address_state;		                             
	self.reg_1_zip5 		:= pLeft.owner_address_zip5;
	self.reg_1_zip4 		:= pLeft.owner_address_zip4;		                             
	self.reg_1_county		:= pLeft.owner_address_county;
	self.reg_2_title 		:= pLeft.owner2_name_title;
	self.reg_2_fname 		:= pLeft.owner2_name_first;
	self.reg_2_mname 		:= pLeft.owner2_name_middle;
	self.reg_2_lname 		:= pLeft.owner2_name_last;
	self.reg_2_name_suffix 	:= pLeft.owner2_name_suffix;
	self.reg_2_company_name := pLeft.owner2_company_name;
	self.reg_2_prim_range 	:= if(trim(self.REG_2_CUSTOMER_NAME)<>'',
								  pLeft.owner_address_prim_range,
								  ''
								 );
	self.reg_2_predir 		:= if(trim(self.REG_2_CUSTOMER_NAME)<>'',
								  pLeft.owner_address_predir,
								  ''
								 );
	self.reg_2_prim_name 	:= if(trim(self.REG_2_CUSTOMER_NAME)<>'',
								  pLeft.owner_address_prim_name,
								  ''
								 );
	self.reg_2_suffix 		:= if(trim(self.REG_2_CUSTOMER_NAME)<>'',
								  pLeft.owner_address_suffix,
								  ''
								 );
	self.reg_2_postdir 		:= if(trim(self.REG_2_CUSTOMER_NAME)<>'',
								  pLeft.owner_address_postdir,
								  ''
								 );
	self.reg_2_unit_desig 	:= if(trim(self.REG_2_CUSTOMER_NAME)<>'',
								  pLeft.owner_address_unit_desig,
								  ''
								 );
	self.reg_2_sec_range 	:= if(trim(self.REG_2_CUSTOMER_NAME)<>'',
								  pLeft.owner_address_sec_range,
								  ''
								 );
	self.reg_2_p_city_name 	:= if(trim(self.REG_2_CUSTOMER_NAME)<>'',
								  pLeft.owner_address_p_city_name,
								  ''
								 );
	self.reg_2_v_city_name 	:= if(trim(self.REG_2_CUSTOMER_NAME)<>'',
								  pLeft.owner_address_v_city_name,
								  ''
								 );
	self.reg_2_state_2 		:= if(trim(self.REG_2_CUSTOMER_NAME)<>'',
								  pLeft.owner_address_state,
								  ''
								 );
	self.reg_2_zip5 		:= if(trim(self.REG_2_CUSTOMER_NAME)<>'',
								  pLeft.owner_address_zip5,
								  ''
								 );
	self.reg_2_zip4 		:= if(trim(self.REG_2_CUSTOMER_NAME)<>'',
								  pLeft.owner_address_zip4,
								  ''
								 );
	self.reg_2_county		:= if(trim(self.REG_2_CUSTOMER_NAME)<>'',
								  pLeft.owner_address_county,
								  ''
								 );
	
	self.source_code		:= 'DI';//change made to source code
end;

veh_NC := project(NC_old + NC_Update, NCToCommon(left));

//****** Join to VINA file and valid VIN

// change to join on vin_input in VINA file, since that is the value in the vehicle file that is searched in VINA app.

VehicleV2.Mac_validVIN(VehicleV2.Layout_NC_temp_module.Layout_NC_as_VehicleV2,veh_NC, validvin_out)

export NC_as_vehicleV2 := validvin_out: persist('~thor_data400::persist::NC_as_vehiclev2');	 

