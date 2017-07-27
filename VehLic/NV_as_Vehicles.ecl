import Lib_StringLib;

string10 fZipFromZipPieces(string5 pZip5, string4 pZip4)
 := if((integer)pZip5 = 0,
	   '',
	   pZip5 + if((integer)pZip4 = 0,
				  '',
				  '-' + pZip4
				 )
	  )
 ;

string8 fMDCYtoCYMD(string8 pDateIn)
 := pDateIn[5..8] + pDateIn[1..4]
 ;

string4 fFixRegModelYear(string pYear)
 := if((integer2)(pYear) > (integer2)(Lib_StringLib.StringLib.GetDateYYYYMMDD()[1..4]) + 1,
	   '19' + pYear[3..4],
	   pYear
	  )
 ;

string5	fZipFromCityStateZip(string pCityStateZip)
 := if(regexfind('^([A-Z, ]+) ([A-Z]{2})  ([0-9]{5})([ ]*)$',pCityStateZip),
	   regexfind('^([A-Z, ]+) ([A-Z]{2})  ([0-9]{5})([ ]*)$',pCityStateZip,3),
	   ''
	  );

string2	fStateFromCityStateZip(string pCityStateZip)
 := if(regexfind('^([A-Z, ]+) ([A-Z]{2})  ([0-9]{5})([ ]*)$',pCityStateZip),
	   regexfind('^([A-Z, ]+) ([A-Z]{2})  ([0-9]{5})([ ]*)$',pCityStateZip,2),
	   ''
	  );

string	fCityFromCityStateZip(string pCityStateZip)
 := if(regexfind('^([A-Z, ]+) ([A-Z]{2})  ([0-9]{5})([ ]*)$',pCityStateZip),
	   regexfind('^([A-Z, ]+) ([A-Z]{2})  ([0-9]{5})([ ]*)$',pCityStateZip,1),
	   ''
	  );
	  
	  

VehLic.Layout_Vehicles tRegToCommonPre200502(VehLic.File_NV_Reg_Update_Pre_200502 pRegIn)
 :=
  transform
	self.orig_state						:= 'NV';
	self.dt_first_seen 					:= (unsigned8)(pRegIn.append_Process_Date[1..6]);
	self.dt_last_seen 					:= (unsigned8)(pRegIn.append_Process_Date[1..6]);
	self.dt_vendor_first_reported		:= (unsigned8)(pRegIn.append_Process_Date[1..6]);
	self.dt_vendor_last_reported		:= (unsigned8)(pRegIn.append_Process_Date[1..6]);

	self.VEHICLE_NUMBERxBG1 			:= if(pRegIn.orig_VEHICLE_VIN[13] <> ' ',pRegIn.orig_VEHICLE_VIN,(string)(hash(pRegIn.orig_VEHICLE_VIN,pRegIn.orig_REGISTRANT_1,pRegIn.orig_REGISTRANT_2)));
	self.ORIG_VIN						:= pRegIn.orig_VEHICLE_VIN;
	self.YEAR_MAKE 						:= fFixRegModelYear(pRegIn.orig_VEHICLE_YEAR);
	self.MAKE_CODE 						:= pRegIn.orig_VEHICLE_MAKE;
	self.BODY_CODE 						:= pRegIn.orig_VEHICLE_BODY;
	self.ODOMETER_MILEAGE 				:= trim(pRegIn.orig_ODOMETER_READING);
	self.PRICE							:= pRegIn.orig_VEHICLE_MSRP;
	self.REGISTRATION_EFFECTIVE_DATE 	:= fMDCYtoCYMD(pRegIn.orig_TRANSACTION_DATE);
	self.REGISTRATION_EXPIRATION_DATE 	:= fMDCYtoCYMD(pRegIn.orig_EXPIRATION_DATE);
	self.REGISTRANT_1_CUSTOMER_TYPExBG5	:= if(pRegIn.append_REG_1_NAME_COMPANY<>'',
											  'B',
											  if(pRegIn.orig_REGISTRANT_1<>'',
											     'I',
												 ' '
												)
											 );
	self.REGISTRANT_2_CUSTOMER_TYPE		:= if(pRegIn.append_REG_2_NAME_COMPANY<>'',
											  'B',
											  if(pRegIn.orig_REGISTRANT_2<>'',
											     'I',
												 ' '
												)
											 );
	self.REG_1_CUSTOMER_NAME			:= pRegIn.orig_REGISTRANT_1;
	self.REG_2_CUSTOMER_NAME			:= pRegIn.orig_REGISTRANT_2;
	self.REG_1_STREET_ADDRESS 			:= pRegIn.orig_ADDRESS;
	self.REG_1_CITY 					:= pRegIn.orig_CITY;
	self.REG_1_STATE 					:= pRegIn.orig_STATE;
	self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL	:= fZipFromZipPieces(pRegIn.orig_ZIP5,pRegIn.orig_ZIP4);
	self.REG_2_STREET_ADDRESS 			:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.orig_ADDRESS,'');
	self.REG_2_CITY 					:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.orig_CITY,'');
	self.REG_2_STATE 					:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.orig_STATE,'');
	self.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL	:= if(self.REG_2_CUSTOMER_NAME<>'',fZipFromZipPieces(pRegIn.orig_ZIP5,pRegIn.orig_ZIP4),'');
	self.reg_1_title 	        		:= pRegIn.clean_REG_1_name_prefix;
	self.reg_1_fname 	        		:= pRegIn.clean_REG_1_name_first;
	self.reg_1_mname 	        		:= pRegIn.clean_REG_1_name_middle;
	self.reg_1_lname 	        		:= pRegIn.clean_REG_1_name_last;
	self.reg_1_name_suffix 	    		:= pRegIn.clean_REG_1_name_suffix;
	self.reg_1_company_name     		:= pRegIn.append_REG_1_NAME_COMPANY;
	self.reg_2_title 					:= pRegIn.clean_REG_2_name_prefix;
	self.reg_2_fname 					:= pRegIn.clean_REG_2_name_first;
	self.reg_2_mname 					:= pRegIn.clean_REG_2_name_middle;
	self.reg_2_lname 					:= pRegIn.clean_REG_2_name_last;
	self.reg_2_name_suffix 				:= pRegIn.clean_REG_2_name_suffix;
	self.reg_2_company_name 			:= pRegIn.append_REG_2_NAME_COMPANY;
	self.reg_1_prim_range				:= pRegIn.clean_REG_ADDRESS_prim_range;
	self.reg_1_predir 	        		:= pRegIn.clean_REG_ADDRESS_predir;
	self.reg_1_prim_name 				:= pRegIn.clean_REG_ADDRESS_prim_name;
	self.reg_1_suffix 	        		:= pRegIn.clean_REG_ADDRESS_addr_suffix;
	self.reg_1_postdir 	        		:= pRegIn.clean_REG_ADDRESS_postdir;
	self.reg_1_unit_desig 	    		:= pRegIn.clean_REG_ADDRESS_unit_desig;
	self.reg_1_sec_range 	    		:= pRegIn.clean_REG_ADDRESS_sec_range;
	self.reg_1_p_city_name 	    		:= pRegIn.clean_REG_ADDRESS_p_city_name;
	self.reg_1_v_city_name 	    		:= pRegIn.clean_REG_ADDRESS_v_city_name;
	self.reg_1_state_2 	        		:= pRegIn.clean_REG_ADDRESS_st;
	self.reg_1_zip5 	        		:= pRegIn.clean_REG_ADDRESS_zip;
	self.reg_1_zip4 	        		:= pRegIn.clean_REG_ADDRESS_zip4;
	self.reg_1_county 	        		:= pRegIn.clean_REG_ADDRESS_fipscounty;
	self.reg_2_prim_range				:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_prim_range,'');
	self.reg_2_predir 	        		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_predir,'');
	self.reg_2_prim_name 				:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_prim_name,'');
	self.reg_2_suffix 	        		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_addr_suffix,'');
	self.reg_2_postdir 	        		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_postdir,'');
	self.reg_2_unit_desig 	    		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_unit_desig,'');
	self.reg_2_sec_range 	    		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_sec_range,'');
	self.reg_2_p_city_name 	    		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_p_city_name,'');
	self.reg_2_v_city_name 	    		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_v_city_name,'');
	self.reg_2_state_2 	        		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_st,'');
	self.reg_2_zip5 	        		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_zip,'');
	self.reg_2_zip4 	        		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_zip4,'');
	self.reg_2_county 	        		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_fipscounty,'');
  end
 ;
 
VehLic.Layout_Vehicles tRegToCommon(VehLic.File_NV_Reg_Update pRegIn)
 :=
  transform
	self.orig_state						:= 'NV';
	self.dt_first_seen 					:= (unsigned8)(pRegIn.append_Process_Date[1..6]);
	self.dt_last_seen 					:= (unsigned8)(pRegIn.append_Process_Date[1..6]);
	self.dt_vendor_first_reported		:= (unsigned8)(pRegIn.append_Process_Date[1..6]);
	self.dt_vendor_last_reported		:= (unsigned8)(pRegIn.append_Process_Date[1..6]);

	self.VEHICLE_NUMBERxBG1 			:= if(pRegIn.orig_VEHICLE_VIN[14] <> ' ',pRegIn.orig_VEHICLE_VIN[1..14],(string)(hash(pRegIn.orig_VEHICLE_VIN,pRegIn.orig_REGISTRANT_1,pRegIn.orig_REGISTRANT_2)));
	self.ORIG_VIN						:= pRegIn.orig_VEHICLE_VIN;
	self.YEAR_MAKE 						:= fFixRegModelYear(pRegIn.orig_VEHICLE_YEAR);
	self.MAKE_CODE 						:= pRegIn.orig_VEHICLE_MAKE;
	self.BODY_CODE 						:= pRegIn.orig_VEHICLE_BODY;
	self.ODOMETER_MILEAGE 				:= trim(pRegIn.orig_ODOMETER_READING);
	self.PRICE							:= pRegIn.orig_VEHICLE_MSRP[5..11];
	self.REGISTRATION_EFFECTIVE_DATE 	:= fMDCYtoCYMD(pRegIn.orig_TRANSACTION_DATE);
	self.REGISTRATION_EXPIRATION_DATE 	:= fMDCYtoCYMD(pRegIn.orig_EXPIRATION_DATE);
	self.REGISTRANT_1_CUSTOMER_TYPExBG5	:= if(pRegIn.append_REG_1_NAME_COMPANY<>'',
											  'B',
											  if(pRegIn.orig_REGISTRANT_1<>'',
											     'I',
												 ' '
												)
											 );
	self.REGISTRANT_2_CUSTOMER_TYPE		:= if(pRegIn.append_REG_2_NAME_COMPANY<>'',
											  'B',
											  if(pRegIn.orig_REGISTRANT_2<>'',
											     'I',
												 ' '
												)
											 );
	self.REG_1_CUSTOMER_NAME			:= pRegIn.orig_REGISTRANT_1;
	self.REG_2_CUSTOMER_NAME			:= pRegIn.orig_REGISTRANT_2;
	self.REG_1_STREET_ADDRESS 			:= pRegIn.orig_ADDRESS;
	self.REG_1_CITY 					:= pRegIn.orig_CITY;
	self.REG_1_STATE 					:= pRegIn.orig_STATE;
	self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL	:= fZipFromZipPieces(pRegIn.orig_ZIP5,pRegIn.orig_ZIP4);
	self.REG_2_STREET_ADDRESS 			:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.orig_ADDRESS,'');
	self.REG_2_CITY 					:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.orig_CITY,'');
	self.REG_2_STATE 					:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.orig_STATE,'');
	self.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL	:= if(self.REG_2_CUSTOMER_NAME<>'',fZipFromZipPieces(pRegIn.orig_ZIP5,pRegIn.orig_ZIP4),'');
	self.reg_1_title 	        		:= pRegIn.clean_REG_1_name_prefix;
	self.reg_1_fname 	        		:= pRegIn.clean_REG_1_name_first;
	self.reg_1_mname 	        		:= pRegIn.clean_REG_1_name_middle;
	self.reg_1_lname 	        		:= pRegIn.clean_REG_1_name_last;
	self.reg_1_name_suffix 	    		:= pRegIn.clean_REG_1_name_suffix;
	self.reg_1_company_name     		:= pRegIn.append_REG_1_NAME_COMPANY;
	self.reg_2_title 					:= pRegIn.clean_REG_2_name_prefix;
	self.reg_2_fname 					:= pRegIn.clean_REG_2_name_first;
	self.reg_2_mname 					:= pRegIn.clean_REG_2_name_middle;
	self.reg_2_lname 					:= pRegIn.clean_REG_2_name_last;
	self.reg_2_name_suffix 				:= pRegIn.clean_REG_2_name_suffix;
	self.reg_2_company_name 			:= pRegIn.append_REG_2_NAME_COMPANY;
	self.reg_1_prim_range				:= pRegIn.clean_REG_ADDRESS_prim_range;
	self.reg_1_predir 	        		:= pRegIn.clean_REG_ADDRESS_predir;
	self.reg_1_prim_name 				:= pRegIn.clean_REG_ADDRESS_prim_name;
	self.reg_1_suffix 	        		:= pRegIn.clean_REG_ADDRESS_addr_suffix;
	self.reg_1_postdir 	        		:= pRegIn.clean_REG_ADDRESS_postdir;
	self.reg_1_unit_desig 	    		:= pRegIn.clean_REG_ADDRESS_unit_desig;
	self.reg_1_sec_range 	    		:= pRegIn.clean_REG_ADDRESS_sec_range;
	self.reg_1_p_city_name 	    		:= pRegIn.clean_REG_ADDRESS_p_city_name;
	self.reg_1_v_city_name 	    		:= pRegIn.clean_REG_ADDRESS_v_city_name;
	self.reg_1_state_2 	        		:= pRegIn.clean_REG_ADDRESS_st;
	self.reg_1_zip5 	        		:= pRegIn.clean_REG_ADDRESS_zip;
	self.reg_1_zip4 	        		:= pRegIn.clean_REG_ADDRESS_zip4;
	self.reg_1_county 	        		:= pRegIn.clean_REG_ADDRESS_fipscounty;
	self.reg_2_prim_range				:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_prim_range,'');
	self.reg_2_predir 	        		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_predir,'');
	self.reg_2_prim_name 				:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_prim_name,'');
	self.reg_2_suffix 	        		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_addr_suffix,'');
	self.reg_2_postdir 	        		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_postdir,'');
	self.reg_2_unit_desig 	    		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_unit_desig,'');
	self.reg_2_sec_range 	    		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_sec_range,'');
	self.reg_2_p_city_name 	    		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_p_city_name,'');
	self.reg_2_v_city_name 	    		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_v_city_name,'');
	self.reg_2_state_2 	        		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_st,'');
	self.reg_2_zip5 	        		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_zip,'');
	self.reg_2_zip4 	        		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_zip4,'');
	self.reg_2_county 	        		:= if(self.REG_2_CUSTOMER_NAME<>'',pRegIn.clean_REG_ADDRESS_fipscounty,'');
  end
 ;

VehLic.Layout_Vehicles tTtlToCommon(VehLic.File_NV_Ttl_Update pTtlIn)
 :=
  transform
	self.orig_state						:= 'NV';
	self.dt_first_seen 					:= (unsigned8)(pTtlIn.append_Process_Date[1..6]);
	self.dt_last_seen 					:= (unsigned8)(pTtlIn.append_Process_Date[1..6]);
	self.dt_vendor_first_reported		:= (unsigned8)(pTtlIn.append_Process_Date[1..6]);
	self.dt_vendor_last_reported		:= (unsigned8)(pTtlIn.append_Process_Date[1..6]);

	self.VEHICLE_NUMBERxBG1 			:= if(pTtlIn.orig_VIN[13] <> ' ',pTtlIn.orig_VIN,(string)(hash(pTtlIn.orig_VIN,pTtlIn.orig_OWNER_NAME_OUT_1,pTtlIn.orig_OWNER_NAME_OUT_2)));
	self.ORIG_VIN						:= pTtlIn.orig_VIN;
	self.YEAR_MAKE 						:= pTtlIn.orig_VEHICLE_YEAR;
	self.MAKE_CODE 						:= pTtlIn.orig_VEHICLE_MAKE;
	self.MODEL 							:= pTtlIn.orig_VEHICLE_MODEL;
	self.BODY_CODE 						:= pTtlIn.orig_VEHICLE_BODY;
	self.ODOMETER_MILEAGE 				:= pTtlIn.orig_ODOMETER_READING;
	self.ODOMETER_STATUS				:= case(trim(pTtlIn.orig_ODOMETER_BRAND_CODE),
												'ACTUAL MILES'			=> 'A',
												'EXCEEDS MECH LIMITS'	=> 'E',
												'EXEMPT'				=> 'X',
												'EXEMPT WEIGHT'			=> 'W',
												'NOT ACTUAL MILES'		=> 'N',
												'UNKNOWN'				=> 'U',
												''
											   );
	self.PRICE							:= pTtlIn.orig_VEHICLE_MSRP;
	self.TITLE_NUMBERxBG9				:= pTtlIn.orig_TITLE_NUM_EMP_ID;
	self.TITLE_ISSUE_DATE			 	:= pTtlIn.orig_TITLE_ISSUE_DATE[7..10] + pTtlIn.orig_TITLE_ISSUE_DATE[1..2] + pTtlIn.orig_TITLE_ISSUE_DATE[4..5];
	self.TITLE_STATUS_CODE				:= pTtlIn.orig_TITLE_ISSUE_TYPE;  //"CH"ange, "DU"plicate, "OR"iginal
	self.PREVIOUS_TITLE_STATE			:= pTtlIn.orig_TITLE_PREV_ST;
	self.LH_1_CUSTOMER_NAME				:= pTtlIn.orig_LIENHOLDER_NAME;
	self.LH_1_STREET_ADDRESS			:= pTtlIn.orig_LIENHOLDER_ADDRESS;
	self.LH_1_CITY						:= if(pTtlIn.orig_LIENHOLDER_CITY_STATE_ZIP<>'',
											  fCityFromCityStateZip(pTtlIn.orig_LIENHOLDER_CITY_STATE_ZIP),
											  ''
											 );
	self.LH_1_STATE 					:= if(pTtlIn.orig_LIENHOLDER_CITY_STATE_ZIP<>'',
											  fStateFromCityStateZip(pTtlIn.orig_LIENHOLDER_CITY_STATE_ZIP),
											  ''
											 );
	self.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL	:= if(pTtlIn.orig_LIENHOLDER_CITY_STATE_ZIP<>'',
											  fZipFromCityStateZip(pTtlIn.orig_LIENHOLDER_CITY_STATE_ZIP),
											  ''
											 );
	self.OWNER_1_CUSTOMER_TYPExBG3		:= case(pTtlIn.append_OWNER_1_SLOT,
												1 => if(pTtlIn.append_NAME_1_COMPANY<>'',
														'B',
														'I'
													   ),
												2 => if(pTtlIn.append_NAME_2_COMPANY<>'',
														'B',
														'I'
													   ),
												3 => if(pTtlIn.append_NAME_3_COMPANY<>'',
														'B',
														'I'
													   ),
												4 => if(pTtlIn.append_NAME_4_COMPANY<>'',
														'B',
														'I'
													   ),
												''
											   );
	self.OWNER_2_CUSTOMER_TYPE			:= case(pTtlIn.append_OWNER_2_SLOT,
												1 => if(pTtlIn.append_NAME_1_COMPANY<>'',
														'B',
														'I'
													   ),
												2 => if(pTtlIn.append_NAME_2_COMPANY<>'',
														'B',
														'I'
													   ),
												3 => if(pTtlIn.append_NAME_3_COMPANY<>'',
														'B',
														'I'
													   ),
												4 => if(pTtlIn.append_NAME_4_COMPANY<>'',
														'B',
														'I'
													   ),
												''
											   );
	self.REGISTRANT_1_CUSTOMER_TYPExBG5	:= case(pTtlIn.append_REG_1_SLOT,
												1 => if(pTtlIn.append_NAME_1_COMPANY<>'',
														'B',
														'I'
													   ),
												2 => if(pTtlIn.append_NAME_2_COMPANY<>'',
														'B',
														'I'
													   ),
												3 => if(pTtlIn.append_NAME_3_COMPANY<>'',
														'B',
														'I'
													   ),
												4 => if(pTtlIn.append_NAME_4_COMPANY<>'',
														'B',
														'I'
													   ),
												''
											   );
	self.REGISTRANT_2_CUSTOMER_TYPE		:= case(pTtlIn.append_REG_2_SLOT,
												1 => if(pTtlIn.append_NAME_1_COMPANY<>'',
														'B',
														'I'
													   ),
												2 => if(pTtlIn.append_NAME_2_COMPANY<>'',
														'B',
														'I'
													   ),
												3 => if(pTtlIn.append_NAME_3_COMPANY<>'',
														'B',
														'I'
													   ),
												4 => if(pTtlIn.append_NAME_4_COMPANY<>'',
														'B',
														'I'
													   ),
												''
											   );
	self.OWN_1_CUSTOMER_NAME			:= case(pTtlIn.append_OWNER_1_SLOT,
												1 => pTtlIn.orig_OWNER_NAME_OUT_1,
												2 => pTtlIn.orig_OWNER_NAME_OUT_2,
												3 => pTtlIn.orig_OWNER_NAME_OUT_3,
												4 => pTtlIn.orig_OWNER_NAME_OUT_4,
												''
											   );
	self.OWN_2_CUSTOMER_NAME			:= case(pTtlIn.append_OWNER_2_SLOT,
												1 => pTtlIn.orig_OWNER_NAME_OUT_1,
												2 => pTtlIn.orig_OWNER_NAME_OUT_2,
												3 => pTtlIn.orig_OWNER_NAME_OUT_3,
												4 => pTtlIn.orig_OWNER_NAME_OUT_4,
												''
											   );
	self.REG_1_CUSTOMER_NAME			:= case(pTtlIn.append_REG_1_SLOT,
												1 => pTtlIn.orig_OWNER_NAME_OUT_1,
												2 => pTtlIn.orig_OWNER_NAME_OUT_2,
												3 => pTtlIn.orig_OWNER_NAME_OUT_3,
												4 => pTtlIn.orig_OWNER_NAME_OUT_4,
												''
											   );
	self.REG_2_CUSTOMER_NAME			:= case(pTtlIn.append_REG_2_SLOT,
												1 => pTtlIn.orig_OWNER_NAME_OUT_1,
												2 => pTtlIn.orig_OWNER_NAME_OUT_2,
												3 => pTtlIn.orig_OWNER_NAME_OUT_3,
												4 => pTtlIn.orig_OWNER_NAME_OUT_4,
												''
											   );
	boolean	lOwnerAddressIsRegAddress	:= if(pTtlIn.orig_OWNER_ADDRESS <> pTtlIn.orig_MAIL_ADDRESS and pTtlIn.orig_OWNER_ADDRESS <> pTtlIn.orig_LIENHOLDER_ADDRESS,
											  true,
											  false
											 );
	self.OWN_1_STREET_ADDRESS 			:= if(lOwnerAddressIsRegAddress,
											  if(pTtlIn.orig_MAIL_ADDRESS<>'',
												 pTtlIn.orig_MAIL_ADDRESS,
												 pTtlIn.orig_LIENHOLDER_ADDRESS
												),
											  pTtlIn.orig_OWNER_ADDRESS
											 );
	self.OWN_1_CITY 					:= if(lOwnerAddressIsRegAddress,
											  if(pTtlIn.orig_MAIL_ADDRESS<>'',
												 fCityFromCityStateZip(pTtlIn.orig_MAIL_CITY_STATE_ZIP),
												 fCityFromCityStateZip(pTtlIn.orig_LIENHOLDER_CITY_STATE_ZIP)
												),
											  fCityFromCityStateZip(pTtlIn.orig_OWNER_CITY_STATE_ZIP)
											 );
	self.OWN_1_STATE 					:= if(lOwnerAddressIsRegAddress,
											  if(pTtlIn.orig_MAIL_ADDRESS<>'',
												 fStateFromCityStateZip(pTtlIn.orig_MAIL_CITY_STATE_ZIP),
												 fStateFromCityStateZip(pTtlIn.orig_LIENHOLDER_CITY_STATE_ZIP)
												),
											  fStateFromCityStateZip(pTtlIn.orig_OWNER_CITY_STATE_ZIP)
											 );
	self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL	:= if(lOwnerAddressIsRegAddress,
											  if(pTtlIn.orig_MAIL_ADDRESS<>'',
												 fZipFromCityStateZip(pTtlIn.orig_MAIL_CITY_STATE_ZIP),
												 fZipFromCityStateZip(pTtlIn.orig_LIENHOLDER_CITY_STATE_ZIP)
												),
											  fZipFromCityStateZip(pTtlIn.orig_OWNER_CITY_STATE_ZIP)
											 );
	self.REG_2_STREET_ADDRESS 			:= if(lOwnerAddressIsRegAddress,
											  pTtlIn.orig_OWNER_ADDRESS,
											  ''
											 );
	self.REG_2_CITY 					:= if(lOwnerAddressIsRegAddress,
											  fCityFromCityStateZip(pTtlIn.orig_OWNER_CITY_STATE_ZIP),
											  ''
											 );
	self.REG_2_STATE 					:= if(lOwnerAddressIsRegAddress,
											  fStateFromCityStateZip(pTtlIn.orig_OWNER_CITY_STATE_ZIP),
											  ''
											 );
	self.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL	:= if(lOwnerAddressIsRegAddress,
											  fZipFromCityStateZip(pTtlIn.orig_OWNER_CITY_STATE_ZIP),
											  ''
											 );
	self.own_1_title 	        		:= case(pTtlIn.append_OWNER_1_SLOT,
												1 => pTtlIn.clean_NAME_1_prefix,
												2 => pTtlIn.clean_NAME_2_prefix,
												3 => pTtlIn.clean_NAME_3_prefix,
												4 => pTtlIn.clean_NAME_4_prefix,
												''
											   );
	self.own_1_fname 	        		:= case(pTtlIn.append_OWNER_1_SLOT,
												1 => pTtlIn.clean_NAME_1_first,
												2 => pTtlIn.clean_NAME_2_first,
												3 => pTtlIn.clean_NAME_3_first,
												4 => pTtlIn.clean_NAME_4_first,
												''
											   );
	self.own_1_mname 	        		:= case(pTtlIn.append_OWNER_1_SLOT,
												1 => pTtlIn.clean_NAME_1_middle,
												2 => pTtlIn.clean_NAME_2_middle,
												3 => pTtlIn.clean_NAME_3_middle,
												4 => pTtlIn.clean_NAME_4_middle,
												''
											   );
	self.own_1_lname 	        		:= case(pTtlIn.append_OWNER_1_SLOT,
												1 => pTtlIn.clean_NAME_1_last,
												2 => pTtlIn.clean_NAME_2_last,
												3 => pTtlIn.clean_NAME_3_last,
												4 => pTtlIn.clean_NAME_4_last,
												''
											   );
	self.own_1_name_suffix 	    		:= case(pTtlIn.append_OWNER_1_SLOT,
												1 => pTtlIn.clean_NAME_1_suffix,
												2 => pTtlIn.clean_NAME_2_suffix,
												3 => pTtlIn.clean_NAME_3_suffix,
												4 => pTtlIn.clean_NAME_4_suffix,
												''
											   );
	self.own_1_company_name     		:= case(pTtlIn.append_OWNER_1_SLOT,
												1 => pTtlIn.append_NAME_1_COMPANY,
												2 => pTtlIn.append_NAME_2_COMPANY,
												3 => pTtlIn.append_NAME_3_COMPANY,
												4 => pTtlIn.append_NAME_4_COMPANY,
												''
											   );
	self.own_2_title 	        		:= case(pTtlIn.append_OWNER_2_SLOT,
												1 => pTtlIn.clean_NAME_1_prefix,
												2 => pTtlIn.clean_NAME_2_prefix,
												3 => pTtlIn.clean_NAME_3_prefix,
												4 => pTtlIn.clean_NAME_4_prefix,
												''
											   );
	self.own_2_fname 	        		:= case(pTtlIn.append_OWNER_2_SLOT,
												1 => pTtlIn.clean_NAME_1_first,
												2 => pTtlIn.clean_NAME_2_first,
												3 => pTtlIn.clean_NAME_3_first,
												4 => pTtlIn.clean_NAME_4_first,
												''
											   );
	self.own_2_mname 	        		:= case(pTtlIn.append_OWNER_2_SLOT,
												1 => pTtlIn.clean_NAME_1_middle,
												2 => pTtlIn.clean_NAME_2_middle,
												3 => pTtlIn.clean_NAME_3_middle,
												4 => pTtlIn.clean_NAME_4_middle,
												''
											   );
	self.own_2_lname 	        		:= case(pTtlIn.append_OWNER_2_SLOT,
												1 => pTtlIn.clean_NAME_1_last,
												2 => pTtlIn.clean_NAME_2_last,
												3 => pTtlIn.clean_NAME_3_last,
												4 => pTtlIn.clean_NAME_4_last,
												''
											   );
	self.own_2_name_suffix 	    		:= case(pTtlIn.append_OWNER_2_SLOT,
												1 => pTtlIn.clean_NAME_1_suffix,
												2 => pTtlIn.clean_NAME_2_suffix,
												3 => pTtlIn.clean_NAME_3_suffix,
												4 => pTtlIn.clean_NAME_4_suffix,
												''
											   );
	self.own_2_company_name     		:= case(pTtlIn.append_OWNER_2_SLOT,
												1 => pTtlIn.append_NAME_1_COMPANY,
												2 => pTtlIn.append_NAME_2_COMPANY,
												3 => pTtlIn.append_NAME_3_COMPANY,
												4 => pTtlIn.append_NAME_4_COMPANY,
												''
											   );
	self.reg_1_title 	        		:= case(pTtlIn.append_REG_1_SLOT,
												1 => pTtlIn.clean_NAME_1_prefix,
												2 => pTtlIn.clean_NAME_2_prefix,
												3 => pTtlIn.clean_NAME_3_prefix,
												4 => pTtlIn.clean_NAME_4_prefix,
												''
											   );
	self.reg_1_fname 	        		:= case(pTtlIn.append_REG_1_SLOT,
												1 => pTtlIn.clean_NAME_1_first,
												2 => pTtlIn.clean_NAME_2_first,
												3 => pTtlIn.clean_NAME_3_first,
												4 => pTtlIn.clean_NAME_4_first,
												''
											   );
	self.reg_1_mname 	        		:= case(pTtlIn.append_REG_1_SLOT,
												1 => pTtlIn.clean_NAME_1_middle,
												2 => pTtlIn.clean_NAME_2_middle,
												3 => pTtlIn.clean_NAME_3_middle,
												4 => pTtlIn.clean_NAME_4_middle,
												''
											   );
	self.reg_1_lname 	        		:= case(pTtlIn.append_REG_1_SLOT,
												1 => pTtlIn.clean_NAME_1_last,
												2 => pTtlIn.clean_NAME_2_last,
												3 => pTtlIn.clean_NAME_3_last,
												4 => pTtlIn.clean_NAME_4_last,
												''
											   );
	self.reg_1_name_suffix 	    		:= case(pTtlIn.append_REG_1_SLOT,
												1 => pTtlIn.clean_NAME_1_suffix,
												2 => pTtlIn.clean_NAME_2_suffix,
												3 => pTtlIn.clean_NAME_3_suffix,
												4 => pTtlIn.clean_NAME_4_suffix,
												''
											   );
	self.reg_1_company_name     		:= case(pTtlIn.append_REG_1_SLOT,
												1 => pTtlIn.append_NAME_1_COMPANY,
												2 => pTtlIn.append_NAME_2_COMPANY,
												3 => pTtlIn.append_NAME_3_COMPANY,
												4 => pTtlIn.append_NAME_4_COMPANY,
												''
											   );
	self.reg_2_title 	        		:= case(pTtlIn.append_REG_2_SLOT,
												1 => pTtlIn.clean_NAME_1_prefix,
												2 => pTtlIn.clean_NAME_2_prefix,
												3 => pTtlIn.clean_NAME_3_prefix,
												4 => pTtlIn.clean_NAME_4_prefix,
												''
											   );
	self.reg_2_fname 	        		:= case(pTtlIn.append_REG_2_SLOT,
												1 => pTtlIn.clean_NAME_1_first,
												2 => pTtlIn.clean_NAME_2_first,
												3 => pTtlIn.clean_NAME_3_first,
												4 => pTtlIn.clean_NAME_4_first,
												''
											   );
	self.reg_2_mname 	        		:= case(pTtlIn.append_REG_2_SLOT,
												1 => pTtlIn.clean_NAME_1_middle,
												2 => pTtlIn.clean_NAME_2_middle,
												3 => pTtlIn.clean_NAME_3_middle,
												4 => pTtlIn.clean_NAME_4_middle,
												''
											   );
	self.reg_2_lname 	        		:= case(pTtlIn.append_REG_2_SLOT,
												1 => pTtlIn.clean_NAME_1_last,
												2 => pTtlIn.clean_NAME_2_last,
												3 => pTtlIn.clean_NAME_3_last,
												4 => pTtlIn.clean_NAME_4_last,
												''
											   );
	self.reg_2_name_suffix 	    		:= case(pTtlIn.append_REG_2_SLOT,
												1 => pTtlIn.clean_NAME_1_suffix,
												2 => pTtlIn.clean_NAME_2_suffix,
												3 => pTtlIn.clean_NAME_3_suffix,
												4 => pTtlIn.clean_NAME_4_suffix,
												''
											   );
	self.reg_2_company_name     		:= case(pTtlIn.append_REG_2_SLOT,
												1 => pTtlIn.append_NAME_1_COMPANY,
												2 => pTtlIn.append_NAME_2_COMPANY,
												3 => pTtlIn.append_NAME_3_COMPANY,
												4 => pTtlIn.append_NAME_4_COMPANY,
												''
											   );
	self.own_1_prim_range				:= if(lOwnerAddressIsRegAddress,
											  pTtlIn.clean_MAIL_ADDRESS_prim_range,
											  pTtlIn.clean_OWNER_ADDRESS_prim_range);
	self.own_1_predir 	        		:= if(lOwnerAddressIsRegAddress,
											  pTtlIn.clean_MAIL_ADDRESS_predir,
											  pTtlIn.clean_OWNER_ADDRESS_predir);
	self.own_1_prim_name 				:= if(lOwnerAddressIsRegAddress,
											  pTtlIn.clean_MAIL_ADDRESS_prim_name,
											  pTtlIn.clean_OWNER_ADDRESS_prim_name);
	self.own_1_suffix 	        		:= if(lOwnerAddressIsRegAddress,
											  pTtlIn.clean_MAIL_ADDRESS_addr_suffix,
											  pTtlIn.clean_OWNER_ADDRESS_addr_suffix);
	self.own_1_postdir 	        		:= if(lOwnerAddressIsRegAddress,
											  pTtlIn.clean_MAIL_ADDRESS_postdir,
											  pTtlIn.clean_OWNER_ADDRESS_postdir);
	self.own_1_unit_desig 	    		:= if(lOwnerAddressIsRegAddress,
											  pTtlIn.clean_MAIL_ADDRESS_unit_desig,
											  pTtlIn.clean_OWNER_ADDRESS_unit_desig);
	self.own_1_sec_range 	    		:= if(lOwnerAddressIsRegAddress,
											  pTtlIn.clean_MAIL_ADDRESS_sec_range,
											  pTtlIn.clean_OWNER_ADDRESS_sec_range);
	self.own_1_p_city_name 	    		:= if(lOwnerAddressIsRegAddress,
											  pTtlIn.clean_MAIL_ADDRESS_p_city_name,
											  pTtlIn.clean_OWNER_ADDRESS_p_city_name);
	self.own_1_v_city_name 	    		:= if(lOwnerAddressIsRegAddress,
											  pTtlIn.clean_MAIL_ADDRESS_v_city_name,
											  pTtlIn.clean_OWNER_ADDRESS_v_city_name);
	self.own_1_state_2 	        		:= if(lOwnerAddressIsRegAddress,
											  pTtlIn.clean_MAIL_ADDRESS_st,
											  pTtlIn.clean_OWNER_ADDRESS_st);
	self.own_1_zip5 	        		:= if(lOwnerAddressIsRegAddress,
											  pTtlIn.clean_MAIL_ADDRESS_zip,
											  pTtlIn.clean_OWNER_ADDRESS_zip);
	self.own_1_zip4 	        		:= if(lOwnerAddressIsRegAddress,
											  pTtlIn.clean_MAIL_ADDRESS_zip4,
											  pTtlIn.clean_OWNER_ADDRESS_zip4);
	self.own_1_county					:= if(lOwnerAddressIsRegAddress,
											  pTtlIn.clean_MAIL_ADDRESS_fipscounty,
											  pTtlIn.clean_OWNER_ADDRESS_fipscounty);
	self.own_2_prim_range				:= if(pTtlIn.append_OWNER_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_MAIL_ADDRESS_prim_range,
												 pTtlIn.clean_OWNER_ADDRESS_prim_range),
											  '');
	self.own_2_predir 	        		:= if(pTtlIn.append_OWNER_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_MAIL_ADDRESS_predir,
												 pTtlIn.clean_OWNER_ADDRESS_predir),
											  '');
	self.own_2_prim_name 				:= if(pTtlIn.append_OWNER_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_MAIL_ADDRESS_prim_name,
												 pTtlIn.clean_OWNER_ADDRESS_prim_name),
											  '');
	self.own_2_suffix 	        		:= if(pTtlIn.append_OWNER_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_MAIL_ADDRESS_addr_suffix,
												 pTtlIn.clean_OWNER_ADDRESS_addr_suffix),
											  '');
	self.own_2_postdir 	        		:= if(pTtlIn.append_OWNER_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_MAIL_ADDRESS_postdir,
												 pTtlIn.clean_OWNER_ADDRESS_postdir),
											  '');
	self.own_2_unit_desig 	    		:= if(pTtlIn.append_OWNER_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_MAIL_ADDRESS_unit_desig,
												 pTtlIn.clean_OWNER_ADDRESS_unit_desig),
											  '');
	self.own_2_sec_range 	    		:= if(pTtlIn.append_OWNER_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_MAIL_ADDRESS_sec_range,
												 pTtlIn.clean_OWNER_ADDRESS_sec_range),
											  '');
	self.own_2_p_city_name 	    		:= if(pTtlIn.append_OWNER_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_MAIL_ADDRESS_p_city_name,
												 pTtlIn.clean_OWNER_ADDRESS_p_city_name),
											  '');
	self.own_2_v_city_name 	    		:= if(pTtlIn.append_OWNER_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_MAIL_ADDRESS_v_city_name,
												 pTtlIn.clean_OWNER_ADDRESS_v_city_name),
											  '');
	self.own_2_state_2 	        		:= if(pTtlIn.append_OWNER_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_MAIL_ADDRESS_st,
												 pTtlIn.clean_OWNER_ADDRESS_st),
											  '');
	self.own_2_zip5 	        		:= if(pTtlIn.append_OWNER_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_MAIL_ADDRESS_zip,
												 pTtlIn.clean_OWNER_ADDRESS_zip),
											  '');
	self.own_2_zip4 	        		:= if(pTtlIn.append_OWNER_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_MAIL_ADDRESS_zip4,
												 pTtlIn.clean_OWNER_ADDRESS_zip4),
											  '');
	self.own_2_county 	        		:= if(pTtlIn.append_OWNER_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_MAIL_ADDRESS_fipscounty,
												 pTtlIn.clean_OWNER_ADDRESS_fipscounty),
											  '');
	self.reg_1_prim_range				:= if(pTtlIn.append_REG_1_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_prim_range,
												 pTtlIn.clean_MAIL_ADDRESS_prim_range),
											  '');
	self.reg_1_predir 	        		:= if(pTtlIn.append_REG_1_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_predir,
												 pTtlIn.clean_MAIL_ADDRESS_predir),
											  '');
	self.reg_1_prim_name 				:= if(pTtlIn.append_REG_1_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_prim_name,
												 pTtlIn.clean_MAIL_ADDRESS_prim_name),
											  '');
	self.reg_1_suffix 	        		:= if(pTtlIn.append_REG_1_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_addr_suffix,
												 pTtlIn.clean_MAIL_ADDRESS_addr_suffix),
											  '');
	self.reg_1_postdir 	        		:= if(pTtlIn.append_REG_1_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_postdir,
												 pTtlIn.clean_MAIL_ADDRESS_postdir),
											  '');
	self.reg_1_unit_desig 	    		:= if(pTtlIn.append_REG_1_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_unit_desig,
												 pTtlIn.clean_MAIL_ADDRESS_unit_desig),
											  '');
	self.reg_1_sec_range 	    		:= if(pTtlIn.append_REG_1_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_sec_range,
												 pTtlIn.clean_MAIL_ADDRESS_sec_range),
											  '');
	self.reg_1_p_city_name 	    		:= if(pTtlIn.append_REG_1_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_p_city_name,
												 pTtlIn.clean_MAIL_ADDRESS_p_city_name),
											  '');
	self.reg_1_v_city_name 	    		:= if(pTtlIn.append_REG_1_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_v_city_name,
												 pTtlIn.clean_MAIL_ADDRESS_v_city_name),
											  '');
	self.reg_1_state_2 	        		:= if(pTtlIn.append_REG_1_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_st,
												 pTtlIn.clean_MAIL_ADDRESS_st),
											  '');
	self.reg_1_zip5 	        		:= if(pTtlIn.append_REG_1_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_zip,
												 pTtlIn.clean_MAIL_ADDRESS_zip),
											  '');
	self.reg_1_zip4 	        		:= if(pTtlIn.append_REG_1_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_zip4,
												 pTtlIn.clean_MAIL_ADDRESS_zip4),
											  '');
	self.reg_1_county 	        		:= if(pTtlIn.append_REG_1_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_fipscounty,
												 pTtlIn.clean_MAIL_ADDRESS_fipscounty),
											  '');
	self.reg_2_prim_range				:= if(pTtlIn.append_REG_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_prim_range,
												 pTtlIn.clean_MAIL_ADDRESS_prim_range),
											  '');
	self.reg_2_predir 	        		:= if(pTtlIn.append_REG_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_predir,
												 pTtlIn.clean_MAIL_ADDRESS_predir),
											  '');
	self.reg_2_prim_name 				:= if(pTtlIn.append_REG_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_prim_name,
												 pTtlIn.clean_MAIL_ADDRESS_prim_name),
											  '');
	self.reg_2_suffix 	        		:= if(pTtlIn.append_REG_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_addr_suffix,
												 pTtlIn.clean_MAIL_ADDRESS_addr_suffix),
											  '');
	self.reg_2_postdir 	        		:= if(pTtlIn.append_REG_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_postdir,
												 pTtlIn.clean_MAIL_ADDRESS_postdir),
											  '');
	self.reg_2_unit_desig 	    		:= if(pTtlIn.append_REG_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_unit_desig,
												 pTtlIn.clean_MAIL_ADDRESS_unit_desig),
											  '');
	self.reg_2_sec_range 	    		:= if(pTtlIn.append_REG_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_sec_range,
												 pTtlIn.clean_MAIL_ADDRESS_sec_range),
											  '');
	self.reg_2_p_city_name 	    		:= if(pTtlIn.append_REG_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_p_city_name,
												 pTtlIn.clean_MAIL_ADDRESS_p_city_name),
											  '');
	self.reg_2_v_city_name 	    		:= if(pTtlIn.append_REG_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_v_city_name,
												 pTtlIn.clean_MAIL_ADDRESS_v_city_name),
											  '');
	self.reg_2_state_2 	        		:= if(pTtlIn.append_REG_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_st,
												 pTtlIn.clean_MAIL_ADDRESS_st),
											  '');
	self.reg_2_zip5 	        		:= if(pTtlIn.append_REG_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_zip,
												 pTtlIn.clean_MAIL_ADDRESS_zip),
											  '');
	self.reg_2_zip4 	        		:= if(pTtlIn.append_REG_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_zip4,
												 pTtlIn.clean_MAIL_ADDRESS_zip4),
											  '');
	self.reg_2_county 	        		:= if(pTtlIn.append_REG_2_SLOT <> 0,
											  if(lOwnerAddressIsRegAddress,
												 pTtlIn.clean_OWNER_ADDRESS_fipscounty,
												 pTtlIn.clean_MAIL_ADDRESS_fipscounty),
											  '');
  end
 ;

dRegAsVehiclesPre200502	:= project(VehLic.File_NV_Reg_Full + VehLic.File_NV_Reg_Update_Pre_200502,tRegToCommonPre200502(left));
dRegAsVehicles			:= project(VehLic.File_NV_Reg_Update,tRegToCommon(left));
dTtlAsVehicles			:= project(VehLic.File_NV_Ttl_Update,tTtlToCommon(left));

export NV_as_Vehicles := dRegAsVehiclesPre200502 + dRegAsVehicles + dTtlAsVehicles;