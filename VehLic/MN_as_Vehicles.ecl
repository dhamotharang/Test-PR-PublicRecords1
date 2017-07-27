import ut;
raw := vehlic.File_MN_Raw;

string6 yyyymm(string year, string mo) := 
	map(year = '' or ((integer)year = 0 and (integer)mo = 0) => '',
		(integer)year < 30 => (string4)((integer)year + 2000) + intformat((integer)mo, 2, 1),
		(string4)((integer)year + 1900) + intformat((integer)mo, 2, 1));

string4	fFixYearMake(string pYearIn)
 :=	map((unsigned2)pYearIn = 0	=>	'',
		(unsigned2)pYearIn > 99	=>	pYearIn,
		(unsigned2)pYearIn <= ((unsigned2)(ut.GetDate[3..4])) + 1	=>	(string4)(2000 + (unsigned2)pYearIn),
		(string4)(1900 + (unsigned2)pYearIn)
	   )
 ;

integer min2(string d1, string d2) := 
	if((integer)d1 > 1900000 and (integer)d1 < (integer)d2 or
		(integer)d2 < 1900000, (integer)d1, (integer)d2);

vehlic.Layout_Vehicles tra(raw le) := transform
	self.orig_state:='MN';
	self.dt_first_seen := (unsigned8)(le.process_date[1..6]);
	self.dt_last_seen := (unsigned8)(le.process_date[1..6]);
	self.dt_vendor_first_reported:=(unsigned8)(le.process_date[1..6]);
	self.dt_vendor_last_reported:=(unsigned8)(le.process_date[1..6]);

	self.VEHICLE_NUMBERxBG1 := le.KEY_TITLE_INDEX_DATA;		                             
	self.ORIG_VIN := le.ID_NBR_VIN;		                             
	self.FIRST_REGISTRATION_DATE := ut.unDoJulian(min2(le.DATE_FIRST_SALE, le.date_transfer_veh));		                             
	self.YEAR_MAKE := fFixYearMake(le.YEAR_VEH_MODEL);		                             
	self.MAKE_CODE := le.NAME_VEH_MAKE;		                             
	self.VEHICLE_TYPE := le.CODE_VEH_CLASS;		                             //See codes lookup
	self.BODY_CODE := le.CODE_BODY_STYLE_VEH;		                         //See codes lookup
	self.MAJOR_COLOR_CODE := le.CODE_VEH_COLOR_1;		                     //See codes lookup
	self.MINOR_COLOR_CODE := le.CODE_VEH_COLOR_2;		                     //See codes lookup
	self.FUEL_TYPE := le.INDC_SPECIAL_FUEL_VEH;		                         //See codes lookup
	self.ODOMETER_STATUS := le.ODOMETER;		                             //See codes lookup
	self.ODOMETER_MILEAGE := le.ODOMETER_QUAN;

	self.JOINT_OWNERSHIP_CODExAND_OR := le.CODE_OWNERSHIP_CONJUNSTION_1;		                             
	self.LICENSE_PLATE_NUMBERxBG4 := le.ID_NBR_PLATE_VEH;	
		//CHECK THIS *****
	self.REGISTRATION_EXPIRATION_DATE := yyyymm(le.YEAR_REGIS_EXPRTN,le.DATE_MO_REGIS_EXPRTN);//	Year and Month only provided, no Day
	self.DECAL_NUMBER := le.ID_NBR_STICKER_VEH;		                             
	self.LICENSE_PLATE_CODE := '';
	self.title_Status_code := le.CODE_TYPE_TRANS;		                             
	self.TRUE_LICENSE_PLSTE_NUMBER := le.ID_NBR_PLATE_VEH;	
	self.REGISTRANT_1_CUSTOMER_TYPExBG5 := vehlic.getCusType(le.fname1, le.lname1, le.company1);
	self.REG_1_CUSTOMER_NAME := le.NAME_USER_DEPT_1;		                             
	self.REG_1_DOB := ut.unDoJulian((integer)le.DATE_BIRTH_USER_DEPT_1);	
	self.REG_1_SEX := le.TRAT_SEX_PRSNL_1;		                             //Registered owner's sex ("M" or "F")
	self.REG_1_MAIL_SUPPESSION_FLAG := map(le.INDC_RESTR_INFO_own_1 in ['1','2','3'] => 'Y',  // 1, 2, or 3 would be TRUE;  " " or 0 would be FALSE
										   le.INDC_RESTR_INFO_own_1 in ['','0'] => 'F', '');
	self.REG_1_ADDR_NON_DISCLOSURE_FLAG := map(le.INDC_RESTR_INFO_own_1 in ['1','2','3'] => 'Y',  // 1, 2, or 3 would be TRUE;  " " or 0 would be FALSE
										   le.INDC_RESTR_INFO_own_1 in ['','0'] => 'F', '');
	self.REG_1_STREET_ADDRESS := le.ADDR_USER_DEPT;		                             
	self.REG_1_CITY := le.CITY_USER_DEPT;		                             
	self.REG_1_STATE := if(ut.isNumeric(le.CODE_CO_USER_DEPT), 'MN', le.CODE_CO_USER_DEPT);	 //If numeric county code, then "MN", else value
//	self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL := le.USER_DEPT_ZIP9;		                             
	self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL := le.USER_DEPT_ZIP9[1..5] +
										   if(trim(le.USER_DEPT_ZIP9[6..9]) <> '0000' and trim(le.USER_DEPT_ZIP9[6..9]) <> '',
											  '-' + le.USER_DEPT_ZIP9[6..9],
											  ''
											  );		                             
//reformatted zip above
	self.REG_1_RESIDENCE_COUNTY := if(ut.isNumeric(le.CODE_CO_USER_DEPT), le.CODE_CO_USER_DEPT, '');	 //if numeric, else blank
	self.REGISTRANT_2_CUSTOMER_TYPE := vehlic.getCusType(le.fname2, le.lname2, le.company2);
	self.REG_2_CUSTOMER_NAME := le.NAME_USER_DEPT_2;		                             
	self.REG_2_DOB := ut.unDoJulian((integer)le.DATE_BIRTH_USER_DEPT_2);  //YYYYsss, where YYYY _may_ be correct year (Y2K problems abound) and sss appears to be the sequential day of year
	self.REG_2_SEX := le.TRAT_SEX_PRSNL_2;		                          //Registered owner's sex ("M" or "F")
	self.REG_2_MAIL_SUPPESSION_FLAG := map(le.INDC_RESTR_INFO_own_2 in ['1','2','3'] => 'Y',  // 1, 2, or 3 would be TRUE;  " " or 0 would be FALSE
										   le.INDC_RESTR_INFO_own_2 in ['','0'] => 'F', '');		                            
	self.REG_2_ADDR_NON_DISCLOSURE_FLAG := map(le.INDC_RESTR_INFO_own_2 in ['1','2','3'] => 'Y',  // 1, 2, or 3 would be TRUE;  " " or 0 would be FALSE
										   le.INDC_RESTR_INFO_own_2 in ['','0'] => 'F', '');		                            
	self.TITLE_NUMBERxBG9 := le.KEY_TITLE_INDEX_DATA;		                             
	self.LH_1_LIEN_DATE := ut.unDoJulian((integer)le.DATE_LIEN_1);	 //YYYYsss, where YYYY _may_ be correct year (Y2K problems abound) and sss appears to be the sequential day of year
	self.LH_1_CUSTOMER_NAME := le.NAME1_LIEN_1+ ' ' + le.NAME2_LIEN_1;		                             
	self.LH_1_STREET_ADDRESS := le.ADDR_LIEN_1;		                             
	self.LH_1_CITY := le.CITY_LIEN_1;		                             
	self.LH_1_STATE := le.STTE_LIEN_1;		                             
//	self.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL := le.LIEN_ZIP9_1;		     //May be a foreign zip code
	self.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL := le.LIEN_ZIP9_1[1..5] +
										   if(trim(le.LIEN_ZIP9_1[6..9]) <> '0000' and trim(le.LIEN_ZIP9_1[6..9]) <> '',
											  '-' + le.LIEN_ZIP9_1[6..9],
											  ''
											  );		                             
//reformatted zip above
	self.LH_2_LEIN_DATE := ut.unDoJulian((integer)le.DATE_LIEN_2);	 //YYYYsss, where YYYY _may_ be correct year (Y2K problems abound) and sss appears to be the sequential day of year
	self.LH_2_CUSTOMER_NAME := le.NAME1_LIEN_2 + ' ' + le.NAME2_LIEN_2;		                             
	self.LH_2_STREET_ADDRESS := le.ADDR_LIEN_2;		                             
	self.LH_2_CITY := le.CITY_LIEN_2;		                             
	self.LH_2_STATE := le.STTE_LIEN_2;		                             
//	self.LH_2_ZIP5_ZIP4_FOREIGN_POSTAL := le.LIEN_ZIP9_2;		     //May be a foreign zip code
	self.LH_2_ZIP5_ZIP4_FOREIGN_POSTAL := le.LIEN_ZIP9_2[1..5] +
										   if(trim(le.LIEN_ZIP9_2[6..9]) <> '0000' and trim(le.LIEN_ZIP9_2[6..9]) <> '',
											  '-' + le.LIEN_ZIP9_2[6..9],
											  ''
											  );		                             
//reformatted zip above
	self.own_2_company_name := le.company2;		                             
	self.reg_1_title := le.title1;		                             
	self.reg_1_fname := le.fname1;		                             
	self.reg_1_mname := le.mname1;		                             
	self.reg_1_lname := le.lname1;		                             
	self.reg_1_name_suffix := le.suffix1;		                             
	self.reg_1_company_name := le.company1;		                             
	self.reg_1_prim_range := le.prim_range;		                             
	self.reg_1_predir := le.predir;		                             
	self.reg_1_prim_name := le.prim_name;		                             
	self.reg_1_suffix := le.addr_suffix;		                             
	self.reg_1_postdir := le.postdir;		                             
	self.reg_1_unit_desig := le.unit_desig;		                             
	self.reg_1_sec_range := le.sec_range;		                             
	self.reg_1_p_city_name := le.p_city_name;		                             
	self.reg_1_v_city_name := le.v_city_name;		                             
	self.reg_1_state_2 := le.st;		                             
	self.reg_1_zip5 := le.zip5;		                             
	self.reg_1_zip4 := le.zip4;		                             
	self.reg_2_title := le.title2;		                             
	self.reg_2_fname := le.fname2;		                             
	self.reg_2_mname := le.mname2;		                             
	self.reg_2_lname := le.lname2;		                             
	self.reg_2_name_suffix := le.suffix2;	
//	self := le;
end;

export MN_as_Vehicles := project(raw, tra(left));