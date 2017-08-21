import Ut,lib_stringlib;
NM_Full := vehlic.File_NM_Full;

vehlic.Layout_Vehicles NMFullToCommon(Layout_NM_Full pInput) := transform
	self.orig_state:='NM';
	self.dt_first_seen := (unsigned8)(pInput.append_PROCESS_DATE[1..6]);
    self.dt_last_seen := (unsigned8)(pInput.append_PROCESS_DATE[1..6]);
	self.dt_vendor_first_reported:=(unsigned8)(pInput.append_PROCESS_DATE[1..6]);
	self.dt_vendor_last_reported:=(unsigned8)(pInput.append_PROCESS_DATE[1..6]);
// No title number, so we'll use the VIN unless it is invalid somehow
	self.VEHICLE_NUMBERxBG1 := if(length(trim(pInput.orig_VIN)) < 11 or 
								  lib_stringlib.stringlib.stringfilterout(pInput.orig_VIN,'0') = '',
								  trim(pInput.orig_VIN) + trim(pInput.orig_VIN_SUFFIX) + trim(pInput.orig_REG1_NAME_LAST) + trim(pInput.orig_REG2_NAME_FIRST),
								  pInput.orig_VIN + pInput.orig_VIN_SUFFIX 
							     );
	self.ORIG_VIN := pInput.orig_VIN;
	self.YEAR_MAKE := pInput.orig_MODEL_YEAR;
	self.MAKE_CODE := pInput.orig_MAKE;						//THOR cleanup, CODES_V3 lookup
	self.MODEL := pInput.orig_SERIES_MODEL;
	self.REGISTRATION_STATUS_CODE := pInput.orig_REG_STATUS;
	self.TITLE_STATUS_CODE := pInput.orig_TITLE_STATUS;
	self.TITLE_ISSUE_DATE := pInput.orig_TITLE_ISSUED_DATE;
	self.LICENSE_PLATE_NUMBERxBG4 := pInput.orig_PLATE_NUMBER;
	self.TRUE_LICENSE_PLSTE_NUMBER := pInput.orig_PLATE_NUMBER;
	self.REGISTRATION_EXPIRATION_DATE := pInput.orig_REG_EXPIRE_DATE;
	self.REGISTRATION_EFFECTIVE_DATE:=if( pInput.orig_REG_ISSUED_DATE='19010101','',pInput.orig_REG_ISSUED_DATE);
	self.PLATE_ISSUE_DATE := pInput.orig_REG_ISSUED_DATE;
	self.REGISTRANT_1_CUSTOMER_TYPExBG5 := map(trim(pInput.clean_REG1_NAME_last) <> '' => 'I',trim(pInput.orig_REG1_BUSINESS_NAME) <> '' => 'B','U');
	self.REG_1_CUSTOMER_NAME := if(pInput.orig_REG1_NAME_LAST <> '',
								   pInput.orig_REG1_NAME_FIRST + trim(' ' + pInput.orig_REG1_NAME_MIDDLE) + trim(' ' + pInput.orig_REG1_NAME_LAST),
								   pInput.orig_REG1_BUSINESS_NAME
								  );
	self.REG_1_STREET_ADDRESS := pInput.orig_REG_ADDRESS_STREET;
	self.REG_1_CITY := pInput.orig_REG_CITY;
	self.REG_1_STATE := pInput.orig_REG_STATE_CODE;
	self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL := if((integer) (pInput.orig_REG_ZIP_CODE) = 0,
										      '',
											  pInput.orig_REG_ZIP_CODE
											 );
	self.REG_1_DOB := pInput.orig_REG1_DOB;
	self.REGISTRANT_2_CUSTOMER_TYPE := if(trim(pInput.orig_REG2_NAME_LAST)<>'',
										  map(trim(pInput.clean_REG2_NAME_last) <> '' => 'I',trim(pInput.orig_REG2_BUSINESS_NAME) <> '' => 'B','U'),
										  ''
										 );
	self.REG_2_CUSTOMER_NAME := if(pInput.orig_REG2_NAME_LAST <> '',
								   pInput.orig_REG2_NAME_FIRST + trim(' ' + pInput.orig_REG2_NAME_MIDDLE) + trim(' ' + pInput.orig_REG2_NAME_LAST),
								   pInput.orig_REG2_BUSINESS_NAME
								  );
	self.REG_2_STREET_ADDRESS := if(trim(pInput.orig_REG2_NAME_LAST)<>'' or trim(pInput.orig_REG2_BUSINESS_NAME)<>'',
									pInput.orig_REG_ADDRESS_STREET,
									''
								   );
	self.REG_2_CITY := if(trim(pInput.orig_REG2_NAME_LAST)<>'' or trim(pInput.orig_REG2_BUSINESS_NAME)<>'',
						  pInput.orig_REG_CITY,
						  ''
						 );
	self.REG_2_STATE := if(trim(pInput.orig_REG2_NAME_LAST)<>'' or trim(pInput.orig_REG2_BUSINESS_NAME)<>'',
						   pInput.orig_REG_STATE_CODE,
						   ''
						  );
	self.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL := if(trim(pInput.orig_REG2_NAME_LAST)<>'' or trim(pInput.orig_REG2_BUSINESS_NAME)<>'',
											  if((integer) (pInput.orig_REG_ZIP_CODE) = 0,
												 '',
												 pInput.orig_REG_ZIP_CODE
												),
											  ''
											 );
	self.REG_2_DOB := pInput.orig_REG2_DOB;

	self.reg_1_title 		:= pInput.clean_REG1_NAME_prefix; 
	self.reg_1_fname 		:= pInput.clean_REG1_NAME_first;  
	self.reg_1_mname 		:= pInput.clean_REG1_NAME_middle; 
	self.reg_1_lname 		:= pInput.clean_REG1_NAME_last;   
	self.reg_1_name_suffix 	:= pInput.clean_REG1_NAME_suffix; 
	self.reg_1_company_name := pInput.orig_REG1_BUSINESS_NAME;  
	self.reg_1_prim_range 	:= pInput.clean_REG_ADDRESS_prim_range;     	                             
	self.reg_1_predir 		:= pInput.clean_REG_ADDRESS_predir;                                      
	self.reg_1_prim_name 	:= pInput.clean_REG_ADDRESS_prim_name;      	                             
	self.reg_1_suffix 		:= pInput.clean_REG_ADDRESS_addr_suffix;                                 
	self.reg_1_postdir 		:= pInput.clean_REG_ADDRESS_postdir;        	                             
	self.reg_1_unit_desig 	:= pInput.clean_REG_ADDRESS_unit_desig;     	                             
	self.reg_1_sec_range 	:= pInput.clean_REG_ADDRESS_sec_range;      	                             
	self.reg_1_p_city_name 	:= pInput.clean_REG_ADDRESS_p_city_name;		                             
	self.reg_1_v_city_name 	:= pInput.clean_REG_ADDRESS_v_city_name;		                             
	self.reg_1_state_2 		:= pInput.clean_REG_ADDRESS_st;                                          
	self.reg_1_zip5 		:= pInput.clean_REG_ADDRESS_zip;        
	self.reg_1_zip4 		:= pInput.clean_REG_ADDRESS_zip4;                                        
	self.reg_1_county		:= pInput.clean_REG_ADDRESS_fipscounty;

	self.reg_2_title 		:= pInput.clean_REG2_NAME_prefix; 
	self.reg_2_fname 		:= pInput.clean_REG2_NAME_first;  
	self.reg_2_mname 		:= pInput.clean_REG2_NAME_middle; 
	self.reg_2_lname 		:= pInput.clean_REG2_NAME_last;   
	self.reg_2_name_suffix 	:= pInput.clean_REG2_NAME_suffix; 
	self.reg_2_company_name := pInput.orig_REG2_BUSINESS_NAME;  
	self.reg_2_prim_range 	:= if(trim(pInput.orig_REG2_NAME_LAST)<>'',
								  pInput.clean_REG_ADDRESS_prim_range,
								  ''
								 );
	self.reg_2_predir 		:= if(trim(pInput.orig_REG2_NAME_LAST)<>'',
								  pInput.clean_REG_ADDRESS_predir,
								  ''
								 );
	self.reg_2_prim_name 	:= if(trim(pInput.orig_REG2_NAME_LAST)<>'',
								  pInput.clean_REG_ADDRESS_prim_name,
								  ''
								 );
	self.reg_2_suffix 		:= if(trim(pInput.orig_REG2_NAME_LAST)<>'',
								  pInput.clean_REG_ADDRESS_addr_suffix,
								  ''
								 );
	self.reg_2_postdir 		:= if(trim(pInput.orig_REG2_NAME_LAST)<>'',
								  pInput.clean_REG_ADDRESS_postdir,
								  ''
								 );
	self.reg_2_unit_desig 	:= if(trim(pInput.orig_REG2_NAME_LAST)<>'',
								  pInput.clean_REG_ADDRESS_unit_desig,
								  ''
								 );
	self.reg_2_sec_range 	:= if(trim(pInput.orig_REG2_NAME_LAST)<>'',
								  pInput.clean_REG_ADDRESS_sec_range,
								  ''
								 );
	self.reg_2_p_city_name 	:= if(trim(pInput.orig_REG2_NAME_LAST)<>'',
								  pInput.clean_REG_ADDRESS_p_city_name,
								  ''
								 );
	self.reg_2_v_city_name 	:= if(trim(pInput.orig_REG2_NAME_LAST)<>'',
								  pInput.clean_REG_ADDRESS_v_city_name,
								  ''
								 );
	self.reg_2_state_2 		:= if(trim(pInput.orig_REG2_NAME_LAST)<>'',
								  pInput.clean_REG_ADDRESS_st,
								  ''
								 );
	self.reg_2_zip5 		:= if(trim(pInput.orig_REG2_NAME_LAST)<>'',
								  pInput.clean_REG_ADDRESS_zip,
								  ''
								 );
	self.reg_2_zip4 		:= if(trim(pInput.orig_REG2_NAME_LAST)<>'',
								  pInput.clean_REG_ADDRESS_zip4,
								  ''
								 );
	self.reg_2_county		:= if(trim(pInput.orig_REG2_NAME_LAST)<>'',
								  pInput.clean_REG_ADDRESS_fipscounty,
								  ''
								 );
	self.LH_1_LIEN_DATE		:= pInput.orig_LIEN_FILE_DATE;
	self.LH_1_CUSTOMER_NAME := pInput.orig_LIENHOLDER_NAME;
    self.LH_1_STREET_ADDRESS := pInput.orig_LIENHOLDER_ADDRESS;
    self.LH_1_CITY 			:= pInput.orig_LIENHOLDER_CITY;
    self.LH_1_STATE 		:= pInput.orig_LIENHOLDER_STATE_CODE;
    self.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL := pInput.orig_LIENHOLDER_ZIP_CODE;
	self.LH_2_CUSTOMER_NAME := 'Not On File';
	self.LH_3_CUSTOMER_NAME := 'Not On File';
end;

export NM_as_Vehicles := project(NM_Full, NMFullToCommon(left));