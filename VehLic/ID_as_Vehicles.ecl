import Ut,lib_stringlib;

ID_Full := vehlic.File_ID_Full(orig_LICENSE_PLATE_NUMBER[1..2]<>'HA' and orig_LICENSE_PLATE_NUMBER<>'HA');
ID_Update := vehlic.File_ID_Update(orig_LICENSE_PLATE_NUMBER[1..2]<>'HA' and orig_LICENSE_PLATE_NUMBER<>'HA');

string8 fMDYtoYMD(string pMDYDate) := pMDYDate[5..8]
									+ pMDYDate[1..2]
									+ pMDYDate[3..4]
								   ;
    
string8 fInsertDDinMMCCYY(string pMMCCYY)
 := pMMCCYY[3..6]
  + pMMCCYY[1..2]
  + case((integer)(pMMCCYY[1..2]),
		 01 => '31',
		 02 => '28',
		 03 => '31',
		 04 => '30',
		 05 => '31',
		 06 => '30',
		 07 => '31',
		 08 => '31',
		 09 => '30',
		 10 => '31',
		 11 => '30',
		 12 => '31',
		 '30'
		)
 ;

vehlic.Layout_Vehicles IDFullToCommon(Layout_ID_Full pInput) := transform
	self.orig_state:='ID';
	self.dt_first_seen := (unsigned8)(pInput.append_PROCESS_DATE[1..6]);
    self.dt_last_seen := (unsigned8)(pInput.append_PROCESS_DATE[1..6]);
	self.dt_vendor_first_reported:=(unsigned8)(pInput.append_PROCESS_DATE[1..6]);
	self.dt_vendor_last_reported:=(unsigned8)(pInput.append_PROCESS_DATE[1..6]);
// No title number, so we'll use the VIN unless it is invalid somehow
	self.VEHICLE_NUMBERxBG1 := if(length(trim(pInput.orig_VEHICLE_ID_NUMBER)) < 11 or 
								  lib_stringlib.stringlib.stringfilterout(pInput.orig_VEHICLE_ID_NUMBER,'0') = '',
								  trim(pinput.orig_VEHICLE_ID_NUMBER) + trim(pInput.orig_REG1_NAME),
								  pInput.orig_VEHICLE_ID_NUMBER + pInput.orig_VEHICLE_YEAR
							     );
	self.ORIG_VIN := pInput.orig_VEHICLE_ID_NUMBER;
	self.YEAR_MAKE := if(pInput.orig_VEHICLE_YEAR<>'XXXX',pInput.orig_VEHICLE_YEAR,'');
	self.MAKE_CODE := if(pInput.orig_MAKE<>'XXXX',pInput.orig_MAKE,'');						//THOR cleanup, CODES_V3 lookup
	self.BODY_CODE := pInput.orig_BODY;					//CODES_V3 lookup
	self.VEHICLE_TYPE := pInput.orig_SUBTYPE;
	self.LICENSE_PLATE_NUMBERxBG4 := pInput.orig_LICENSE_PLATE_NUMBER;
	self.TRUE_LICENSE_PLSTE_NUMBER := pInput.orig_LICENSE_PLATE_NUMBER;
	self.REGISTRATION_EXPIRATION_DATE := fInsertDDinMMCCYY(pInput.orig_EXPIRATION_DATE);
	self.REGISTRATION_EFFECTIVE_DATE := fMDYtoYMD(pInput.orig_ISSUE_DATE);
	self.PLATE_ISSUE_DATE := fMDYtoYMD(pInput.orig_ISSUE_DATE);
	self.REGISTRANT_1_CUSTOMER_TYPExBG5 := map(trim(pInput.clean_REG1_NAME_last) <> '' => 'I',trim(pInput.append_REG1_COMPANY_NAME) <> '' => 'B','U');
	self.REG_1_CUSTOMER_NAME := pInput.orig_REG1_NAME ;
	self.REG_1_STREET_ADDRESS := trim(trim(pInput.orig_REG1_ADDRESS1,left,right) + ' ' + trim(pInput.orig_REG1_ADDRESS2,left,right),left);
	self.REG_1_CITY := pInput.orig_REG1_CITY;
	self.REG_1_STATE := pInput.orig_REG1_STATE;
	self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL := if((integer) (pInput.orig_REG1_ZIP[6..9]) = 0,
										      pInput.orig_REG1_ZIP[1..5],
											  pInput.orig_REG1_ZIP[1..5] + '-' + pInput.orig_REG1_ZIP[6..9]);
    self.REG_1_RESIDENCE_COUNTY := pInput.orig_RESIDENCE_COUNTY;
	self.REG_2_CUSTOMER_NAME := pInput.orig_REG2_NAME;
	self.REGISTRANT_2_CUSTOMER_TYPE := if(trim(pInput.orig_REG2_NAME)<>'',
										  map(trim(pInput.clean_REG2_NAME_last) <> '' => 'I',trim(pInput.append_REG2_COMPANY_NAME) <> '' => 'B','U'),
										  ''
										 );
	self.REG_2_STREET_ADDRESS := if(trim(pInput.orig_REG2_NAME)<>'',
									trim(trim(pInput.orig_REG1_ADDRESS1,left,right) + ' ' + trim(pInput.orig_REG1_ADDRESS2,left,right),left),
									''
								   );
	self.REG_2_CITY := if(trim(pInput.orig_REG2_NAME)<>'',
						  pInput.orig_REG1_CITY,
						  ''
						 );
	self.REG_2_STATE := if(trim(pInput.orig_REG2_NAME)<>'',
						   pInput.orig_REG1_STATE,
						   ''
						  );
	self.REG_2_ZIP5_ZIP4_FOREIGN_POSTAL := if(trim(pInput.orig_REG2_NAME)<>'',
											  if((integer) (pInput.orig_REG1_ZIP[6..9]) = 0,
										         pInput.orig_REG1_ZIP[1..5],
											     pInput.orig_REG1_ZIP[1..5] + '-' + pInput.orig_REG1_ZIP[6..9]),
											  ''
											 );
    self.REG_2_RESIDENCE_COUNTY := if(trim(pInput.orig_REG2_NAME)<>'',
									  pInput.orig_RESIDENCE_COUNTY,
									  ''
									 );
	self.MAJOR_COLOR_CODE   := pInput.orig_MAJOR_COLOR;
	self.MINOR_COLOR_CODE   := if(pInput.orig_MINOR_COLOR <> pInput.orig_MAJOR_COLOR,
								  pInput.orig_MINOR_COLOR,
								  ''
								 );

	self.reg_1_title 		:= pInput.clean_REG1_NAME_prefix; 
	self.reg_1_fname 		:= pInput.clean_REG1_NAME_first;  
	self.reg_1_mname 		:= pInput.clean_REG1_NAME_middle; 
	self.reg_1_lname 		:= pInput.clean_REG1_NAME_last;   
	self.reg_1_name_suffix 	:= pInput.clean_REG1_NAME_suffix; 
	self.reg_1_company_name := pInput.append_REG1_COMPANY_NAME;  
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
	self.reg_2_company_name := pInput.append_REG2_COMPANY_NAME;  
	self.reg_2_prim_range 	:= if(trim(pInput.orig_REG2_NAME)<>'',
								  pInput.clean_REG_ADDRESS_prim_range,
								  ''
								 );
	self.reg_2_predir 		:= if(trim(pInput.orig_REG2_NAME)<>'',
								  pInput.clean_REG_ADDRESS_predir,
								  ''
								 );
	self.reg_2_prim_name 	:= if(trim(pInput.orig_REG2_NAME)<>'',
								  pInput.clean_REG_ADDRESS_prim_name,
								  ''
								 );
	self.reg_2_suffix 		:= if(trim(pInput.orig_REG2_NAME)<>'',
								  pInput.clean_REG_ADDRESS_addr_suffix,
								  ''
								 );
	self.reg_2_postdir 		:= if(trim(pInput.orig_REG2_NAME)<>'',
								  pInput.clean_REG_ADDRESS_postdir,
								  ''
								 );
	self.reg_2_unit_desig 	:= if(trim(pInput.orig_REG2_NAME)<>'',
								  pInput.clean_REG_ADDRESS_unit_desig,
								  ''
								 );
	self.reg_2_sec_range 	:= if(trim(pInput.orig_REG2_NAME)<>'',
								  pInput.clean_REG_ADDRESS_sec_range,
								  ''
								 );
	self.reg_2_p_city_name 	:= if(trim(pInput.orig_REG2_NAME)<>'',
								  pInput.clean_REG_ADDRESS_p_city_name,
								  ''
								 );
	self.reg_2_v_city_name 	:= if(trim(pInput.orig_REG2_NAME)<>'',
								  pInput.clean_REG_ADDRESS_v_city_name,
								  ''
								 );
	self.reg_2_state_2 		:= if(trim(pInput.orig_REG2_NAME)<>'',
								  pInput.clean_REG_ADDRESS_st,
								  ''
								 );
	self.reg_2_zip5 		:= if(trim(pInput.orig_REG2_NAME)<>'',
								  pInput.clean_REG_ADDRESS_zip,
								  ''
								 );
	self.reg_2_zip4 		:= if(trim(pInput.orig_REG2_NAME)<>'',
								  pInput.clean_REG_ADDRESS_zip4,
								  ''
								 );
	self.reg_2_county		:= if(trim(pInput.orig_REG2_NAME)<>'',
								  pInput.clean_REG_ADDRESS_fipscounty,
								  ''
								 );
	self.LH_1_CUSTOMER_NAME := 'Not On File';
	self.LH_2_CUSTOMER_NAME := 'Not On File';
	self.LH_3_CUSTOMER_NAME := 'Not On File';
end;

export ID_as_Vehicles := project(ID_Full + ID_Update,IDFullToCommon(left));