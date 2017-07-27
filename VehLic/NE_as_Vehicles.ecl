import lib_stringlib;

l_NE_RegFiles := VehLic.File_NE_Reg;
l_NE_TtlFiles := VehLic.File_NE_Ttl;

l_NE_RegDistributed := distribute(l_NE_RegFiles, hash(orig_Title_Number));
l_NE_TtlDistributed := distribute(l_NE_TtlFiles, hash(orig_Title_Number));

string8 lYMDDashedToCYMD(string pDateIn)
 := pDateIn[1..4] + pDateIn[6..7] + pDateIn[9..10]
 ;

integer1 lCommaPos1(string pstringIn)
 := lib_stringlib.stringlib.stringfind(pStringIn,',',1)
 ;

integer1 lCommaPos2(string pstringIn)
 := lib_stringlib.stringlib.stringfind(pStringIn,',',2)
 ;

integer1 lCommaPos3(string pstringIn)
 := lib_stringlib.stringlib.stringfind(pStringIn,',',3)
 ;

string lLastName(string pStringIn)
 := if(lCommaPos1(pStringIn) <> 0,
	   trim(pStringIn[1 .. lCommaPos1(pStringIn)-1]),
	   trim(pStringIn)
	  )
 ;

string lFirstName(string pStringIn)
 := if(lCommaPos1(pStringIn) <> 0,
	   if(lCommaPos2(pStringIn) <> 0,
		  trim(pStringIn[lCommaPos1(pStringIn)+1 .. lCommaPos2(pStringIn)-1]),
		  trim(pStringIn[lCommaPos1(pStringIn)+1 .. length(pStringIn)])
		 ),
	   ''
	  )
 ;

string lMiddleName(string pStringIn)
 := if(lCommaPos1(pStringIn) <> 0,
	   if(lCommaPos2(pStringIn) <> 0,
		  if(lCommaPos3(pStringIn) <> 0,
			 trim(pStringIn[lCommaPos2(pStringIn)+1 .. lCommaPos3(pStringIn)-1]),
			 trim(pStringIn[lCommaPos2(pStringIn)+1 .. length(pStringIn)])
		    ),
		  ''
		 ),
	   ''
	  )
 ;

string lNameSuffix(string pStringIn)
 := if(lCommaPos3(pStringIn) <> 0,
	   trim(pStringIn[lCommaPos3(pStringIn)+1 .. length(pStringIn)]),
	   ''
	  )
 ;

string40 lCommaNameToFMLS(string pNameIn)
 := trim(lFirstName(pNameIn))
 +	trim(' ' + lMiddleName(pNameIn))
 +	trim(' ' + lLastName(pNameIn))
 +	trim(' ' + lNameSuffix(pNameIn))
 ;

VehLic.Layout_Vehicles lJoin_NE_RegTtl(l_NE_RegFiles pRegIn, l_NE_TtlFiles pTtlIn)
 := transform
	self.orig_state					:= 'NE';
	self.dt_first_seen 				:= if(pRegIn.append_Process_Date = '',(unsigned8)(pTtlIn.append_Process_Date[1..6]), (unsigned8)(pRegIn.append_Process_Date[1..6]));
	self.dt_last_seen 				:= if(pRegIn.append_Process_Date = '',(unsigned8)(pTtlIn.append_Process_Date[1..6]), (unsigned8)(pRegIn.append_Process_Date[1..6]));
	self.dt_vendor_first_reported	:= if(pRegIn.append_Process_Date = '',(unsigned8)(pTtlIn.append_Process_Date[1..6]), (unsigned8)(pRegIn.append_Process_Date[1..6]));
	self.dt_vendor_last_reported	:= if(pRegIn.append_Process_Date = '',(unsigned8)(pTtlIn.append_Process_Date[1..6]), (unsigned8)(pRegIn.append_Process_Date[1..6]));

	self.VEHICLE_NUMBERxBG1 := if(pTtlIn.orig_TITLE_NUMBER <> '',pTtlIn.orig_TITLE_NUMBER,pRegIn.orig_TITLE_NUMBER);
	self.ORIG_VIN			:= if(pTtlIn.orig_VIN <> '',pTtlIn.orig_VIN,pRegIn.orig_VIN);
	self.YEAR_MAKE 			:= if(pTtlIn.orig_MODEL_YEAR <> '',pTtlIn.orig_MODEL_YEAR,pRegIn.orig_MODEL_YEAR);
	self.MAKE_CODE 			:= if(pTtlIn.orig_MAKE_CODE <> '',pTtlIn.orig_MAKE_CODE,pRegIn.orig_MAKE_CODE);
	self.VEHICLE_TYPE 		:= if(pTtlIn.orig_VEHICLE_TYPE <> '',pTtlIn.orig_VEHICLE_TYPE,pRegIn.orig_VEHICLE_TYPE);
	self.VEHICLE_USE		:= if(pRegIn.orig_LEASE_CODE='L','L','');
	self.BODY_CODE 			:= if(pTtlIn.orig_BODY_STYLE_CODE <> '',pTtlIn.orig_BODY_STYLE_CODE,pRegIn.orig_BODY_STYLE_CODE);
	self.FUEL_TYPE 			:= pRegIn.orig_FUEL_TYPE;
	self.ODOMETER_STATUS 	:= pTtlIn.orig_ODOMETER_READING_TYPE;
	self.ODOMETER_MILEAGE 	:= pTtlIn.orig_ODOMETER_READING;
	self.MAJOR_COLOR_CODE	:= if(pTtlIn.orig_MAJOR_COLOR_CODE <> '',pTtlIn.orig_MAJOR_COLOR_CODE,pRegIn.orig_MAJOR_COLOR_CODE);
	self.MINOR_COLOR_CODE	:= if(pTtlIn.orig_MINOR_COLOR_CODE <> '',pTtlIn.orig_MINOR_COLOR_CODE,pRegIn.orig_MAJOR_COLOR_CODE);
	self.TITLE_NUMBERxBG9	:= if(pTtlIn.orig_TITLE_NUMBER <> '',pTtlIn.orig_TITLE_NUMBER,pRegIn.orig_TITLE_NUMBER);
	self.TITLE_ISSUE_DATE	:= lYMDDashedToCYMD(pTtlIn.orig_TITLE_ISSUE_DATE);
	self.LICENSE_PLATE_NUMBERxBG4	:= pRegIn.orig_LICENSE_PLATE_NUMBER;
	self.LICENSE_PLATE_CODE 		:= pRegIn.orig_LICENSE_PLATE_TYPE;
	self.TRUE_LICENSE_PLSTE_NUMBER 	:= pRegIn.orig_LICENSE_PLATE_NUMBER;
	self.PREVIOUS_TITLE_STATE 		:= pTtlIn.orig_PREVIOUS_TITLE_STATE;
	self.GROSS_WEIGHT				:= pRegIn.orig_WEIGHT;
	self.REGISTRATION_EFFECTIVE_DATE 	:= lYMDDashedToCYMD(pRegIn.orig_REGISTRATION_ISSUE_DATE);
	self.REGISTRATION_EXPIRATION_DATE 	:= lYMDDashedToCYMD(pRegIn.orig_REGISTRATION_EXPIRATION_DATE);
	self.BRAND_CODESx5 					:= if(pRegIn.orig_BRAND_CODE <> '',pRegIn.orig_BRAND_CODE,pTtlIn.orig_BRAND_CODE);
	self.JOINT_OWNERSHIP_CODExAND_OR	:= if(pTtlIn.orig_AND_FLAG='Y','AND',if(pTtlIn.orig_OR_FLAG='Y','OR',if(pTtlIn.orig_TOD_FLAG='Y','TOD','')));
	self.OWNER_1_CUSTOMER_TYPExBG3 		:= pTtlIn.orig_OWNER_1_TYPE;
	self.OWNER_2_CUSTOMER_TYPE	 		:= pTtlIn.orig_OWNER_2_TYPE;
	self.REGISTRANT_1_CUSTOMER_TYPExBG5	:= pRegIn.orig_REG_1_TYPE;
	self.REGISTRANT_2_CUSTOMER_TYPE		:= pRegIn.orig_REG_2_TYPE;
	self.OWN_1_CUSTOMER_NAME			:= if(pTtlIn.orig_OWNER_1_TYPE = 'I',lCommaNameToFMLS(pTtlIn.orig_OWNER_1_NAME),pTtlIn.orig_OWNER_1_NAME);
	self.OWN_1_STREET_ADDRESS 			:= trim(pTtlIn.orig_ADDRESS_1) + ' ' + pTtlIn.orig_ADDRESS_2;
	self.OWN_1_CITY 					:= pTtlIn.orig_CITY;
	self.OWN_1_STATE 					:= pTtlIn.orig_STATE;
	self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL := pTtlIn.orig_ZIPCODE + if(pTtlIn.orig_ZIPPLUS4 <> '0000' and pTtlIn.orig_ZIPPLUS4 <> '    ','-' + pTtlIn.orig_ZIPPLUS4,'');
	self.OWN_2_CUSTOMER_NAME			:= if(pTtlIn.orig_OWNER_2_TYPE = 'I',lCommaNameToFMLS(pTtlIn.orig_OWNER_2_NAME),pTtlIn.orig_OWNER_2_NAME);
	self.OWN_2_STREET_ADDRESS 			:= if(pTtlIn.orig_OWNER_2_NAME <> '',trim(pTtlIn.orig_ADDRESS_1) + ' ' + pTtlIn.orig_ADDRESS_2,'');
	self.OWN_2_CITY 					:= if(pTtlIn.orig_OWNER_2_NAME <> '',pTtlIn.orig_CITY,'');
	self.OWN_2_STATE 					:= if(pTtlIn.orig_OWNER_2_NAME <> '',pTtlIn.orig_STATE,'');
	self.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL := if(pTtlIn.orig_OWNER_2_NAME <> '',pTtlIn.orig_ZIPCODE + if(pTtlIn.orig_ZIPPLUS4 <> '0000' and pTtlIn.orig_ZIPPLUS4 <> '    ','-' + pTtlIn.orig_ZIPPLUS4,''),'');
	self.REG_1_CUSTOMER_NAME 			:= if(pRegIn.orig_REG_1_TYPE = 'I',lCommaNameToFMLS(pRegIn.orig_REG_1_NAME),pRegIn.orig_REG_1_NAME);
	self.REG_1_STREET_ADDRESS 			:= pRegIn.orig_REG_ADDRESS;
	self.REG_1_CITY 					:= pRegIn.orig_REG_CITY;
	self.REG_1_STATE 					:= pRegIn.orig_REG_STATE;
	self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL	:= pRegIn.orig_REG_ZIPCODE;
	self.REG_2_CUSTOMER_NAME 			:= if(pRegIn.orig_REG_2_TYPE = 'I',lCommaNameToFMLS(pRegIn.orig_REG_2_NAME),pRegIn.orig_REG_2_NAME);
	self.REG_2_STREET_ADDRESS 			:= if(PRegIn.orig_REG_2_NAME <> '',pRegIn.orig_REG_ADDRESS,'');
	self.REG_2_CITY 					:= if(PRegIn.orig_REG_2_NAME <> '',pRegIn.orig_REG_CITY,'');
	self.REG_2_STATE 					:= if(PRegIn.orig_REG_2_NAME <> '',pRegIn.orig_REG_STATE,'');
	self.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL	:= if(PRegIn.orig_REG_2_NAME <> '',pRegIn.orig_REG_ZIPCODE,'');
	self.LH_1_CUSTOMER_NAME				:= 'NOT AVAILABLE';
	self.TITLE_TYPE						:= pTtlIn.orig_TITLE_TYPE;

	self.own_1_title 	        := pTtlIn.clean_OWNER_1_name_prefix;
	self.own_1_fname 	        := pTtlIn.clean_OWNER_1_name_first;
	self.own_1_mname 	        := pTtlIn.clean_OWNER_1_name_middle;
	self.own_1_lname 	        := pTtlIn.clean_OWNER_1_name_last;
	self.own_1_name_suffix 	    := pTtlIn.clean_OWNER_1_name_suffix;
	self.own_1_company_name     := pTtlIn.append_OWNER_1_NAME_COMPANY;
	self.own_1_prim_range		:= pTtlIn.clean_OWNER_ADDRESS_prim_range;
	self.own_1_predir 	        := pTtlIn.clean_OWNER_ADDRESS_predir;
	self.own_1_prim_name 		:= pTtlIn.clean_OWNER_ADDRESS_prim_name;
	self.own_1_suffix 	        := pTtlIn.clean_OWNER_ADDRESS_addr_suffix;
	self.own_1_postdir 	        := pTtlIn.clean_OWNER_ADDRESS_postdir;
	self.own_1_unit_desig 	    := pTtlIn.clean_OWNER_ADDRESS_unit_desig;
	self.own_1_sec_range 	    := pTtlIn.clean_OWNER_ADDRESS_sec_range;
	self.own_1_p_city_name 	    := pTtlIn.clean_OWNER_ADDRESS_p_city_name;
	self.own_1_v_city_name 	    := pTtlIn.clean_OWNER_ADDRESS_v_city_name;
	self.own_1_state_2 	        := pTtlIn.clean_OWNER_ADDRESS_st;
	self.own_1_zip5 	        := pTtlIn.clean_OWNER_ADDRESS_zip;
	self.own_1_zip4 	        := pTtlIn.clean_OWNER_ADDRESS_zip4;
	self.own_1_county 	        := pTtlIn.clean_OWNER_ADDRESS_fipscounty;
	self.own_2_title 			:= pTtlIn.clean_OWNER_2_name_prefix;
	self.own_2_fname 			:= pTtlIn.clean_OWNER_2_name_first;
	self.own_2_mname 			:= pTtlIn.clean_OWNER_2_name_middle;
	self.own_2_lname 			:= pTtlIn.clean_OWNER_2_name_last;
	self.own_2_name_suffix 		:= pTtlIn.clean_OWNER_2_name_suffix;
	self.own_2_company_name 	:= pTtlIn.append_OWNER_2_NAME_COMPANY;
	self.own_2_prim_range		:= if(pTtlIn.orig_OWNER_2_NAME <> '',pTtlIn.clean_OWNER_ADDRESS_prim_range,'');
	self.own_2_predir 	        := if(pTtlIn.orig_OWNER_2_NAME <> '',pTtlIn.clean_OWNER_ADDRESS_predir,'');
	self.own_2_prim_name 		:= if(pTtlIn.orig_OWNER_2_NAME <> '',pTtlIn.clean_OWNER_ADDRESS_prim_name,'');
	self.own_2_suffix 	        := if(pTtlIn.orig_OWNER_2_NAME <> '',pTtlIn.clean_OWNER_ADDRESS_addr_suffix,'');
	self.own_2_postdir 	        := if(pTtlIn.orig_OWNER_2_NAME <> '',pTtlIn.clean_OWNER_ADDRESS_postdir,'');
	self.own_2_unit_desig 	    := if(pTtlIn.orig_OWNER_2_NAME <> '',pTtlIn.clean_OWNER_ADDRESS_unit_desig,'');
	self.own_2_sec_range 	    := if(pTtlIn.orig_OWNER_2_NAME <> '',pTtlIn.clean_OWNER_ADDRESS_sec_range,'');
	self.own_2_p_city_name 	    := if(pTtlIn.orig_OWNER_2_NAME <> '',pTtlIn.clean_OWNER_ADDRESS_p_city_name,'');
	self.own_2_v_city_name 	    := if(pTtlIn.orig_OWNER_2_NAME <> '',pTtlIn.clean_OWNER_ADDRESS_v_city_name,'');
	self.own_2_state_2 	        := if(pTtlIn.orig_OWNER_2_NAME <> '',pTtlIn.clean_OWNER_ADDRESS_st,'');
	self.own_2_zip5 	        := if(pTtlIn.orig_OWNER_2_NAME <> '',pTtlIn.clean_OWNER_ADDRESS_zip,'');
	self.own_2_zip4 	        := if(pTtlIn.orig_OWNER_2_NAME <> '',pTtlIn.clean_OWNER_ADDRESS_zip4,'');
	self.own_2_county 	        := if(pTtlIn.orig_OWNER_2_NAME <> '',pTtlIn.clean_OWNER_ADDRESS_fipscounty,'');
	self.reg_1_title 	        := pRegIn.clean_REG_1_name_prefix;
	self.reg_1_fname 	        := pRegIn.clean_REG_1_name_first;
	self.reg_1_mname 	        := pRegIn.clean_REG_1_name_middle;
	self.reg_1_lname 	        := pRegIn.clean_REG_1_name_last;
	self.reg_1_name_suffix 	    := pRegIn.clean_REG_1_name_suffix;
	self.reg_1_company_name     := pRegIn.append_REG_1_NAME_COMPANY;
	self.reg_1_prim_range		:= pRegIn.clean_REG_ADDRESS_prim_range;
	self.reg_1_predir 	        := pRegIn.clean_REG_ADDRESS_predir;
	self.reg_1_prim_name 		:= pRegIn.clean_REG_ADDRESS_prim_name;
	self.reg_1_suffix 	        := pRegIn.clean_REG_ADDRESS_addr_suffix;
	self.reg_1_postdir 	        := pRegIn.clean_REG_ADDRESS_postdir;
	self.reg_1_unit_desig 	    := pRegIn.clean_REG_ADDRESS_unit_desig;
	self.reg_1_sec_range 	    := pRegIn.clean_REG_ADDRESS_sec_range;
	self.reg_1_p_city_name 	    := pRegIn.clean_REG_ADDRESS_p_city_name;
	self.reg_1_v_city_name 	    := pRegIn.clean_REG_ADDRESS_v_city_name;
	self.reg_1_state_2 	        := pRegIn.clean_REG_ADDRESS_st;
	self.reg_1_zip5 	        := pRegIn.clean_REG_ADDRESS_zip;
	self.reg_1_zip4 	        := pRegIn.clean_REG_ADDRESS_zip4;
	self.reg_1_county 	        := pRegIn.clean_REG_ADDRESS_fipscounty;
	self.reg_2_title 			:= pRegIn.clean_REG_2_name_prefix;
	self.reg_2_fname 			:= pRegIn.clean_REG_2_name_first;
	self.reg_2_mname 			:= pRegIn.clean_REG_2_name_middle;
	self.reg_2_lname 			:= pRegIn.clean_REG_2_name_last;
	self.reg_2_name_suffix 		:= pRegIn.clean_REG_2_name_suffix;
	self.reg_2_company_name 	:= pRegIn.append_REG_2_NAME_COMPANY;
	self.reg_2_prim_range		:= if(pRegIn.orig_REG_2_NAME <> '',pRegIn.clean_REG_ADDRESS_prim_range,'');
	self.reg_2_predir 	        := if(pRegIn.orig_REG_2_NAME <> '',pRegIn.clean_REG_ADDRESS_predir,'');
	self.reg_2_prim_name 		:= if(pRegIn.orig_REG_2_NAME <> '',pRegIn.clean_REG_ADDRESS_prim_name,'');
	self.reg_2_suffix 	        := if(pRegIn.orig_REG_2_NAME <> '',pRegIn.clean_REG_ADDRESS_addr_suffix,'');
	self.reg_2_postdir 	        := if(pRegIn.orig_REG_2_NAME <> '',pRegIn.clean_REG_ADDRESS_postdir,'');
	self.reg_2_unit_desig 	    := if(pRegIn.orig_REG_2_NAME <> '',pRegIn.clean_REG_ADDRESS_unit_desig,'');
	self.reg_2_sec_range 	    := if(pRegIn.orig_REG_2_NAME <> '',pRegIn.clean_REG_ADDRESS_sec_range,'');
	self.reg_2_p_city_name 	    := if(pRegIn.orig_REG_2_NAME <> '',pRegIn.clean_REG_ADDRESS_p_city_name,'');
	self.reg_2_v_city_name 	    := if(pRegIn.orig_REG_2_NAME <> '',pRegIn.clean_REG_ADDRESS_v_city_name,'');
	self.reg_2_state_2 	        := if(pRegIn.orig_REG_2_NAME <> '',pRegIn.clean_REG_ADDRESS_st,'');
	self.reg_2_zip5 	        := if(pRegIn.orig_REG_2_NAME <> '',pRegIn.clean_REG_ADDRESS_zip,'');
	self.reg_2_zip4 	        := if(pRegIn.orig_REG_2_NAME <> '',pRegIn.clean_REG_ADDRESS_zip4,'');
	self.reg_2_county 	        := if(pRegIn.orig_REG_2_NAME <> '',pRegIn.clean_REG_ADDRESS_fipscounty,'');
end;

l_NE_Joined 
 := join(l_NE_RegDistributed, l_NE_TtlDistributed, 
		 left.orig_TITLE_NUMBER = right.orig_TITLE_NUMBER,
		 lJoin_NE_RegTtl(left, right),full outer,local);

export NE_as_Vehicles := l_NE_Joined : persist('Persist::Vehreg_NE_as_Vehicles');