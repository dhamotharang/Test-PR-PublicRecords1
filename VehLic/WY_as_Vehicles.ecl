import lib_stringlib;

d_WY_RegFiles := VehLic.File_WY_Reg;
d_WY_TtlFiles := VehLic.File_WY_Ttl;

d_WY_RegDistributed := distribute(d_WY_RegFiles, hash(orig_TITLE_NUMBER));
d_WY_TtlDistributed := distribute(d_WY_TtlFiles, hash(orig_TITLE_NUMBER));

string8 fYMDDashedToCYMD(string pDateIn)
 := if((integer2)(pDateIn[1..4]) <> 0,
	   pDateIn[1..4] + pDateIn[6..7] + pDateIn[9..10],
	   ''
	  )
 ;

string1 fCustomerType(string pLName, string pCompanyName)
 := if(pLName <> '',
	   'I',
	   if(pCompanyName<>'',
		  'B',
		  ''
		 )
	  )
 ;

VehLic.Layout_Vehicles lJoin_WY_RegTtl(d_WY_RegFiles pRegIn, d_WY_TtlFiles pTtlIn)
 := transform
	self.orig_state					:= 'WY';
	self.dt_first_seen 				:= if(pRegIn.append_Process_Date = '',(unsigned8)(pTtlIn.append_Process_Date[1..6]), (unsigned8)(pRegIn.append_Process_Date[1..6]));
	self.dt_last_seen 				:= if(pRegIn.append_Process_Date = '',(unsigned8)(pTtlIn.append_Process_Date[1..6]), (unsigned8)(pRegIn.append_Process_Date[1..6]));
	self.dt_vendor_first_reported	:= if(pRegIn.append_Process_Date = '',(unsigned8)(pTtlIn.append_Process_Date[1..6]), (unsigned8)(pRegIn.append_Process_Date[1..6]));
	self.dt_vendor_last_reported	:= if(pRegIn.append_Process_Date = '',(unsigned8)(pTtlIn.append_Process_Date[1..6]), (unsigned8)(pRegIn.append_Process_Date[1..6]));

	self.VEHICLE_NUMBERxBG1 := ''; // let vehlic.vehicles_joined set the value
	self.ORIG_VIN			:= if(pTtlIn.orig_VEHICLE_VIN <> '',pTtlIn.orig_VEHICLE_VIN,pRegIn.orig_VEHICLE_VIN);
	self.YEAR_MAKE 			:= if(pTtlIn.orig_VEHICLE_YEAR <> '',pTtlIn.orig_VEHICLE_YEAR,pRegIn.orig_VEHICLE_YEAR);
	self.MAKE_CODE 			:= if(pTtlIn.orig_VEHICLE_MAKE <> '',pTtlIn.orig_VEHICLE_MAKE,pRegIn.orig_VEHICLE_MAKE);
	self.BODY_CODE 			:= if(pTtlIn.orig_VEHICLE_BODY <> '',pTtlIn.orig_VEHICLE_BODY,pRegIn.orig_VEHICLE_BODY);
	self.FUEL_TYPE 			:= pRegIn.orig_VEHICLE_FUEL_TYPE;
	self.ODOMETER_STATUS 	:= pTtlIn.orig_ODOMETER_COMMENT;
	self.ODOMETER_MILEAGE 	:= pTtlIn.orig_ODOMETER_READING;
	self.MAJOR_COLOR_CODE	:= pRegIn.orig_VEHICLE_MAJOR_COLOR;
	self.MINOR_COLOR_CODE	:= pRegIn.orig_VEHICLE_MINOR_COLOR;
	self.TITLE_NUMBERxBG9	:= if(pTtlIn.orig_TITLE_NUMBER <> '',pTtlIn.orig_TITLE_NUMBER,pRegIn.orig_TITLE_NUMBER);
	self.TITLE_ISSUE_DATE	:= fYMDDashedToCYMD(pTtlIn.orig_ISSUE_DATE);
	self.LICENSE_PLATE_NUMBERxBG4		:= lib_stringlib.stringlib.stringfilterout(pRegIn.orig_PLATE_NUMBER,'-');
	self.LICENSE_PLATE_CODE 			:= pRegIn.orig_PLATE_ISSUE;
	self.TRUE_LICENSE_PLSTE_NUMBER 		:= lib_stringlib.stringlib.stringfilterout(pRegIn.orig_PLATE_NUMBER,'-');
	self.PREVIOUS_TITLE_STATE 			:= pTtlIn.orig_PRIOR_TITLE_STATE;
	self.GROSS_WEIGHT					:= pRegIn.orig_VEHICLE_WEIGHT;
	self.REGISTRATION_EFFECTIVE_DATE 	:= fYMDDashedToCYMD(pRegIn.orig_ISSUE_DATE);
	self.REGISTRATION_EXPIRATION_DATE 	:= fYMDDashedToCYMD(pRegIn.orig_END_DATE);
	self.BRAND_CODESx5 					:= pTtlIn.orig_BRANDED_FLAG;
	self.OWNER_1_CUSTOMER_TYPExBG3 		:= fCustomerType(pTtlIn.clean_OWN_1_NAME_last,pTtlIn.append_OWN_1_COMPANY_NAME);
	self.OWNER_2_CUSTOMER_TYPE	 		:= fCustomerType(pTtlIn.clean_OWN_2_NAME_last,pTtlIn.append_OWN_2_COMPANY_NAME);
	self.REGISTRANT_1_CUSTOMER_TYPExBG5	:= fCustomerType(pRegIn.clean_REG_1_NAME_last,pRegIn.append_REG_1_COMPANY_NAME);
	self.REGISTRANT_2_CUSTOMER_TYPE		:= fCustomerType(pRegIn.clean_REG_2_NAME_last,pRegIn.append_REG_2_COMPANY_NAME);
	self.OWN_1_CUSTOMER_NAME			:= if(pTtlIn.orig_OWNER_NAME_1[1..12] <> 'CREATED FROM',lib_stringlib.stringlib.stringfindreplace(pTtlIn.orig_OWNER_NAME_1,'*',' '),'');
	self.OWN_1_STREET_ADDRESS 			:= pTtlIn.orig_OWNER_ADDRESS;
	self.OWN_1_CITY 					:= pTtlIn.clean_OWN_ADDRESS_p_city_name;
	self.OWN_1_STATE 					:= pTtlIn.clean_OWN_ADDRESS_st;
	self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL := pTtlIn.clean_OWN_ADDRESS_zip;
	self.OWN_2_CUSTOMER_NAME			:= pTtlIn.orig_OWNER_NAME_2;
	self.OWN_2_STREET_ADDRESS 			:= '';
	self.OWN_2_CITY 					:= '';
	self.OWN_2_STATE 					:= '';
	self.OWN_2_ZIP5_ZIP4_FOREIGN_POSTAL := '';
	self.REG_1_CUSTOMER_NAME 			:= if(pRegIn.orig_REGISTRANT_NAME[1..12] <> 'CREATED FROM',lib_stringlib.stringlib.stringfindreplace(pRegIn.orig_REGISTRANT_NAME,'*',' '),'');
	self.REG_1_STREET_ADDRESS 			:= pRegIn.orig_REGISTRANT_ADDRESS;
	self.REG_1_CITY 					:= pRegIn.clean_REG_ADDRESS_p_city_name;
	self.REG_1_STATE 					:= pRegIn.clean_REG_ADDRESS_st;
	self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL	:= pRegIn.clean_REG_ADDRESS_zip;
	self.REG_2_CUSTOMER_NAME 			:= '';
	self.REG_2_STREET_ADDRESS 			:= '';
	self.REG_2_CITY 					:= '';
	self.REG_2_STATE 					:= '';
	self.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL	:= '';
	self.LH_1_CUSTOMER_NAME				:= 'NOT AVAILABLE';

	self.own_1_title 	        := pTtlIn.clean_OWN_1_name_prefix;
	self.own_1_fname 	        := pTtlIn.clean_OWN_1_name_first;
	self.own_1_mname 	        := pTtlIn.clean_OWN_1_name_middle;
	self.own_1_lname 	        := pTtlIn.clean_OWN_1_name_last;
	self.own_1_name_suffix 	    := pTtlIn.clean_OWN_1_name_suffix;
	self.own_1_company_name     := pTtlIn.append_OWN_1_COMPANY_NAME;
	self.own_1_prim_range		:= pTtlIn.clean_OWN_ADDRESS_prim_range;
	self.own_1_predir 	        := pTtlIn.clean_OWN_ADDRESS_predir;
	self.own_1_prim_name 		:= pTtlIn.clean_OWN_ADDRESS_prim_name;
	self.own_1_suffix 	        := pTtlIn.clean_OWN_ADDRESS_addr_suffix;
	self.own_1_postdir 	        := pTtlIn.clean_OWN_ADDRESS_postdir;
	self.own_1_unit_desig 	    := pTtlIn.clean_OWN_ADDRESS_unit_desig;
	self.own_1_sec_range 	    := pTtlIn.clean_OWN_ADDRESS_sec_range;
	self.own_1_p_city_name 	    := pTtlIn.clean_OWN_ADDRESS_p_city_name;
	self.own_1_v_city_name 	    := pTtlIn.clean_OWN_ADDRESS_v_city_name;
	self.own_1_state_2 	        := pTtlIn.clean_OWN_ADDRESS_st;
	self.own_1_zip5 	        := pTtlIn.clean_OWN_ADDRESS_zip;
	self.own_1_zip4 	        := pTtlIn.clean_OWN_ADDRESS_zip4;
	self.own_1_county 	        := pTtlIn.clean_OWN_ADDRESS_fipscounty;
	self.own_2_title 			:= pTtlIn.clean_OWN_2_name_prefix;
	self.own_2_fname 			:= pTtlIn.clean_OWN_2_name_first;
	self.own_2_mname 			:= pTtlIn.clean_OWN_2_name_middle;
	self.own_2_lname 			:= pTtlIn.clean_OWN_2_name_last;
	self.own_2_name_suffix 		:= pTtlIn.clean_OWN_2_name_suffix;
	self.own_2_company_name 	:= pTtlIn.append_OWN_2_COMPANY_NAME;
	self.own_2_prim_range		:= if(pTtlIn.clean_OWN_2_NAME_last<>'' or pTtlIn.append_OWN_2_COMPANY_NAME<>'',pTtlIn.clean_OWN_ADDRESS_prim_range,'');
	self.own_2_predir 	        := if(pTtlIn.clean_OWN_2_NAME_last<>'' or pTtlIn.append_OWN_2_COMPANY_NAME<>'',pTtlIn.clean_OWN_ADDRESS_predir,'');
	self.own_2_prim_name 		:= if(pTtlIn.clean_OWN_2_NAME_last<>'' or pTtlIn.append_OWN_2_COMPANY_NAME<>'',pTtlIn.clean_OWN_ADDRESS_prim_name,'');
	self.own_2_suffix 	        := if(pTtlIn.clean_OWN_2_NAME_last<>'' or pTtlIn.append_OWN_2_COMPANY_NAME<>'',pTtlIn.clean_OWN_ADDRESS_addr_suffix,'');
	self.own_2_postdir 	        := if(pTtlIn.clean_OWN_2_NAME_last<>'' or pTtlIn.append_OWN_2_COMPANY_NAME<>'',pTtlIn.clean_OWN_ADDRESS_postdir,'');
	self.own_2_unit_desig 	    := if(pTtlIn.clean_OWN_2_NAME_last<>'' or pTtlIn.append_OWN_2_COMPANY_NAME<>'',pTtlIn.clean_OWN_ADDRESS_unit_desig,'');
	self.own_2_sec_range 	    := if(pTtlIn.clean_OWN_2_NAME_last<>'' or pTtlIn.append_OWN_2_COMPANY_NAME<>'',pTtlIn.clean_OWN_ADDRESS_sec_range,'');
	self.own_2_p_city_name 	    := if(pTtlIn.clean_OWN_2_NAME_last<>'' or pTtlIn.append_OWN_2_COMPANY_NAME<>'',pTtlIn.clean_OWN_ADDRESS_p_city_name,'');
	self.own_2_v_city_name 	    := if(pTtlIn.clean_OWN_2_NAME_last<>'' or pTtlIn.append_OWN_2_COMPANY_NAME<>'',pTtlIn.clean_OWN_ADDRESS_v_city_name,'');
	self.own_2_state_2 	        := if(pTtlIn.clean_OWN_2_NAME_last<>'' or pTtlIn.append_OWN_2_COMPANY_NAME<>'',pTtlIn.clean_OWN_ADDRESS_st,'');
	self.own_2_zip5 	        := if(pTtlIn.clean_OWN_2_NAME_last<>'' or pTtlIn.append_OWN_2_COMPANY_NAME<>'',pTtlIn.clean_OWN_ADDRESS_zip,'');
	self.own_2_zip4 	        := if(pTtlIn.clean_OWN_2_NAME_last<>'' or pTtlIn.append_OWN_2_COMPANY_NAME<>'',pTtlIn.clean_OWN_ADDRESS_zip4,'');
	self.own_2_county 	        := if(pTtlIn.clean_OWN_2_NAME_last<>'' or pTtlIn.append_OWN_2_COMPANY_NAME<>'',pTtlIn.clean_OWN_ADDRESS_fipscounty,'');
	self.reg_1_title 	        := pRegIn.clean_REG_1_name_prefix;
	self.reg_1_fname 	        := pRegIn.clean_REG_1_name_first;
	self.reg_1_mname 	        := pRegIn.clean_REG_1_name_middle;
	self.reg_1_lname 	        := pRegIn.clean_REG_1_name_last;
	self.reg_1_name_suffix 	    := pRegIn.clean_REG_1_name_suffix;
	self.reg_1_company_name     := pRegIn.append_REG_1_COMPANY_NAME;
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
	self.reg_2_company_name 	:= pRegIn.append_REG_2_COMPANY_NAME;
	self.reg_2_prim_range		:= if(pRegIn.clean_REG_2_NAME_last<>'' or pRegIn.append_REG_2_COMPANY_NAME<>'',pRegIn.clean_REG_ADDRESS_prim_range,'');
	self.reg_2_predir 	        := if(pRegIn.clean_REG_2_NAME_last<>'' or pRegIn.append_REG_2_COMPANY_NAME<>'',pRegIn.clean_REG_ADDRESS_predir,'');
	self.reg_2_prim_name 		:= if(pRegIn.clean_REG_2_NAME_last<>'' or pRegIn.append_REG_2_COMPANY_NAME<>'',pRegIn.clean_REG_ADDRESS_prim_name,'');
	self.reg_2_suffix 	        := if(pRegIn.clean_REG_2_NAME_last<>'' or pRegIn.append_REG_2_COMPANY_NAME<>'',pRegIn.clean_REG_ADDRESS_addr_suffix,'');
	self.reg_2_postdir 	        := if(pRegIn.clean_REG_2_NAME_last<>'' or pRegIn.append_REG_2_COMPANY_NAME<>'',pRegIn.clean_REG_ADDRESS_postdir,'');
	self.reg_2_unit_desig 	    := if(pRegIn.clean_REG_2_NAME_last<>'' or pRegIn.append_REG_2_COMPANY_NAME<>'',pRegIn.clean_REG_ADDRESS_unit_desig,'');
	self.reg_2_sec_range 	    := if(pRegIn.clean_REG_2_NAME_last<>'' or pRegIn.append_REG_2_COMPANY_NAME<>'',pRegIn.clean_REG_ADDRESS_sec_range,'');
	self.reg_2_p_city_name 	    := if(pRegIn.clean_REG_2_NAME_last<>'' or pRegIn.append_REG_2_COMPANY_NAME<>'',pRegIn.clean_REG_ADDRESS_p_city_name,'');
	self.reg_2_v_city_name 	    := if(pRegIn.clean_REG_2_NAME_last<>'' or pRegIn.append_REG_2_COMPANY_NAME<>'',pRegIn.clean_REG_ADDRESS_v_city_name,'');
	self.reg_2_state_2 	        := if(pRegIn.clean_REG_2_NAME_last<>'' or pRegIn.append_REG_2_COMPANY_NAME<>'',pRegIn.clean_REG_ADDRESS_st,'');
	self.reg_2_zip5 	        := if(pRegIn.clean_REG_2_NAME_last<>'' or pRegIn.append_REG_2_COMPANY_NAME<>'',pRegIn.clean_REG_ADDRESS_zip,'');
	self.reg_2_zip4 	        := if(pRegIn.clean_REG_2_NAME_last<>'' or pRegIn.append_REG_2_COMPANY_NAME<>'',pRegIn.clean_REG_ADDRESS_zip4,'');
	self.reg_2_county 	        := if(pRegIn.clean_REG_2_NAME_last<>'' or pRegIn.append_REG_2_COMPANY_NAME<>'',pRegIn.clean_REG_ADDRESS_fipscounty,'');
end;

l_WY_Joined 
 := join(d_WY_RegDistributed, d_WY_TtlDistributed, 
		 left.orig_TITLE_NUMBER = right.orig_TITLE_NUMBER,
		 lJoin_WY_RegTtl(left, right),full outer,local);

export WY_as_Vehicles := l_WY_Joined : persist('Persist::Vehreg_WY_as_Vehicles');