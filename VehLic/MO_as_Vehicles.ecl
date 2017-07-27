import ut;
reg := vehlic.File_MO_Reg;
ttl := vehlic.File_MO_Ttl;

reg_dist := distribute(reg, hash(title_no));
ttl_dist := distribute(ttl, hash(title));


string8 undoMMDDYY(string6 date) := 
	if(date = '000000', '',
	   vehlic.getCCYY(date[5..6]) +  date[1..4]);
string8 undoYYMMDD(string6 date) := 
	if(date = '000000', '',
       vehlic.getCCYY(date[1..2]) +  date[3..6]);

string8 decode_month(string yr, string code) := 
	map((yr = '' or (data)yr = x'0000') and (code = '' or (data)code = x'0000') => '',
		code = '#' => '',
		code = 'N' => '99991231',
		code = '*' => vehlic.getCCYY(yr) + '1231',
		vehlic.getCCYY(yr) + 
			case(code, 
				 'A' => '01', 'B' => '02', 'C' => '03', 'D' => '04', 'E' => '05', 'F' => '06',
				 'G' => '07', 'H' => '08', 'I' => '09', 'J' => '10', 'K' => '11', 'L' => '12',
				 '  ') + 
		'  ');

vehlic.Layout_Vehicles tra(reg le, ttl ri) := transform
	self.orig_state:='MO';
	self.dt_first_seen := if(le.process_Date = '',(unsigned8)(ri.process_date[1..6]), (unsigned8)(le.process_date[1..6]));
	self.dt_last_seen := if(le.process_Date = '',(unsigned8)(ri.process_date[1..6]), (unsigned8)(le.process_date[1..6]));
	self.dt_vendor_first_reported:=if(le.process_Date = '',(unsigned8)(ri.process_date[1..6]), (unsigned8)(le.process_date[1..6]));
	self.dt_vendor_last_reported:=if(le.process_Date = '',(unsigned8)(ri.process_date[1..6]), (unsigned8)(le.process_date[1..6]));

	self.LICENSE_PLATE_CODE := le.PLATE_TYPE_1;
	self.REG_2_ADDR_NON_DISCLOSURE_FLAG := le.suspended;

	self.VEHICLE_NUMBERxBG1 := if(ri.TITLE <> '', ri.TITLE, le.TITLE_NO);			
	self.ORIG_VIN :=if(ri.VIN <> '', ri.VIN, le.VIN);			
	self.FIRST_REGISTRATION_DATE :=if(ri.PUR_DATE <> '', undoMMDDYY(ri.PUR_DATE), undoYYMMDD(le.PURCHASE_DATE));			//Format Ttl = MMDDYY; Format Reg = YYMMDD
	self.YEAR_MAKE := vehlic.getCCYY( if(ri.MOD_YR <> '', ri.MOD_YR, le.YEAR));			//YY
	self.MAKE_CODE := if(ri.orig_MAKE <> '', ri.orig_MAKE, le.MAKE);			
	self.VEHICLE_TYPE := if(ri.orig_KOV <> '', ri.orig_KOV, le.KOV);			
	self.BODY_CODE := if(ri.orig_BODY_STYLE <> '', ri.orig_BODY_STYLE, le.orig_BODY_STYLE);			//? Varies widely.  Display code without lookup?
	self.FUEL_TYPE := if(ri.orig_TYPE_FUEL <> '', ri.orig_TYPE_FUEL, le.orig_FUEL);					//See Codes
	self.ODOMETER_STATUS := if(le.ODOMETER_FLAG <> '', le.ODOMETER_FLAG, ri.ODOMETER_IND);			//See Codes
	self.ODOMETER_MILEAGE := if(le.ODOMETER_READING <> '', le.ODOMETER_READING, ri.ODOMETER_READING);			
	self.NUMBER_OF_AXLES :=le.orig_AXLES;					
	self.HORSE_POWER := '';						
	self.OWNER_1_CUSTOMER_TYPExBG3 := vehlic.getCusType(ri.fname1, ri.lname1, ri.company1);//Populate; with "I" & "B" based on clean fields, "U" for Unknown
	self.OWN_1_CUSTOMER_NAME :=ri.orig_OWNER_NAME;						
	self.OWN_1_STREET_ADDRESS :=ri.orig_ADDRESS;						
	self.OWN_1_CITY :=ri.orig_CITY;						
	self.OWN_1_STATE :=ri.orig_STATE;						
	self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL :=ri.orig_ZIP_CODE;						
	self.OWN_1_RESIDENCE_COUNTY :=ri.orig_COUNTY_CODE;						
	self.LICENSE_PLATE_NUMBERxBG4 :=le.LIC_NO_1;						
	self.REGISTRATION_EFFECTIVE_DATE := '';						
	self.REGISTRATION_EXPIRATION_DATE := decode_month(le.EXPIR_YR_1, le.LIC_EXP_MM_CODE_1); //A = 01, B = 02,...L = 12. * Annual, N = Non-Expiring, # = blank
	self.TRUE_LICENSE_PLSTE_NUMBER :=le.LIC_NO_1;						
	self.REG_1_CUSTOMER_NAME :=le.orig_NAME;						
	self.REG_1_STREET_ADDRESS :=le.orig_ADDRESS;						
	self.REG_1_CITY :=le.orig_CITY;						
	self.REG_1_STATE :=le.orig_STATE;						
	self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL :=le.orig_ZIP_CODE;						
	self.REG_1_RESIDENCE_COUNTY :=le.orig_COUNTY;						
	self.TITLE_NUMBERxBG9 := if(ri.TITLE <> '', ri.TITLE, le.TITLE_NO);			
	self.TITLE_ISSUE_DATE :=undoMMDDYY(ri.ISS_DATE);						//Format Ttl = MMDDYY; Format Reg = YYMMDD
	self.TITLE_STATUS_CODE := map(le.orig_record_type = '2' or le.title_no = '' => 'Z',
								  ri.orig_TYPE <> '' => ri.orig_TYPE, 
								  le.TITLE_TYPE);			
	self.PREVIOUS_TITLE_STATE :=ri.PREV_STATE;						
	self.DEALER_LICENSE_NUMBER :=if(ri.DEALER_NO <> '', ri.DEALER_NO, le.DEALER_NUMBER);			
	self.BRAND_CODESx5 :=ri.BRAND_CODE;		
	self.LH_1_LIEN_DATE := if(ri.LIEN_DATE_1 <> '', undoMMDDYY(ri.LIEN_DATE_1), undoYYMMDD(le.LIEN_DATE_1));			//Format Ttl = MMDDYY; Format Reg = YYMMDD
	self.LH_1_CUSTOMER_NAME := if(ri.LIENHOLDER_NAME_1 <> '', ri.LIENHOLDER_NAME_1, le.LIEN_NAME_1);			
	self.LH_1_STREET_ADDRESS := if(ri.LIENHOLDER_ADDR_1 <> '', ri.LIENHOLDER_ADDR_1, le.LIEN_ADDR_1);			
	self.LH_1_CITY := if(ri.LIENHOLDER_CITY_1 <> '', ri.LIENHOLDER_CITY_1, le.LIEN_ADDR_1);			
	self.LH_1_STATE := if(ri.LIENHOLDER_STATE_1 <> '', ri.LIENHOLDER_STATE_1, le.LIEN_ST_1);			
	self.LH_1_ZIP5_ZIP4_FOREIGN_POSTAL := if(ri.LIENHOLDER_ZIP_1 <> '', ri.LIENHOLDER_ZIP_1, le.LIEN_ZIP_1);			
	self.LH_2_LEIN_DATE := if(ri.LIEN_DATE_2 <> '', undoMMDDYY(ri.LIEN_DATE_2), undoYYMMDD(le.LIEN_DATE_2));			//Format Ttl = MMDDYY; Format Reg = YYMMDD
	self.LH_2_CUSTOMER_NAME := if(ri.LIENHOLDER_NAME_2 <> '', ri.LIENHOLDER_NAME_2, le.LIEN_NAME_2);			
	self.LH_2_STREET_ADDRESS := if(ri.LIENHOLDER_ADDR_2 <> '', ri.LIENHOLDER_ADDR_2, le.LIEN_ADDR_2);			
	self.LH_2_CITY := if(ri.LIENHOLDER_CITY_2 <> '', ri.LIENHOLDER_CITY_2, le.LIEN_CITY_2);			
	self.LH_2_STATE := if(ri.LIENHOLDER_STATE_2 <> '', ri.LIENHOLDER_STATE_2, le.LIEN_ST_2);			
	self.LH_2_ZIP5_ZIP4_FOREIGN_POSTAL := if(ri.LIENHOLDER_ZIP_2 <> '', ri.LIENHOLDER_ZIP_2, le.LIEN_ZIP_2);			
	self.own_1_title :=ri.title1;						
	self.own_1_fname :=ri.fname1;						
	self.own_1_mname :=ri.mname1;						
	self.own_1_lname :=ri.lname1;						
	self.own_1_name_suffix :=ri.suffix1;						
	self.own_1_company_name :=ri.company1;						
	self.own_1_prim_range :=ri.prim_range;						
	self.own_1_predir :=ri.predir;						
	self.own_1_prim_name :=ri.prim_name;						
	self.own_1_suffix :=ri.addr_suffix;						
	self.own_1_postdir :=ri.postdir;						
	self.own_1_unit_desig :=ri.unit_desig;						
	self.own_1_sec_range :=ri.sec_range;						
	self.own_1_p_city_name :=ri.p_city_name;						
	self.own_1_v_city_name :=ri.v_city_name;						
	self.own_1_state_2 :=ri.st;						
	self.own_1_zip5 :=ri.zip;						
	self.own_1_zip4 :=ri.zip4;						
	self.own_1_county :=ri.county;						
	self.own_2_title :=ri.title2;						
	self.own_2_fname :=ri.fname2;						
	self.own_2_mname :=ri.mname2;						
	self.own_2_lname :=ri.lname2;						
	self.own_2_name_suffix :=ri.suffix2;						
	self.own_2_company_name :=ri.company2;						
	self.reg_1_title :=le.title1;						
	self.reg_1_fname :=le.fname1;						
	self.reg_1_mname :=le.mname1;						
	self.reg_1_lname :=le.lname1;						
	self.reg_1_name_suffix :=le.suffix1;						
	self.reg_1_company_name :=le.company1;						
	self.reg_1_prim_range :=le.prim_range;						
	self.reg_1_predir :=le.predir;						
	self.reg_1_prim_name :=le.prim_name;						
	self.reg_1_suffix :=le.addr_suffix;						
	self.reg_1_postdir :=le.postdir;						
	self.reg_1_unit_desig :=le.unit_desig;						
	self.reg_1_sec_range :=le.sec_range;						
	self.reg_1_p_city_name :=le.p_city_name;						
	self.reg_1_v_city_name :=le.v_city_name;						
	self.reg_1_state_2 :=le.st;						
	self.reg_1_zip5 :=le.zip;						
	self.reg_1_zip4 :=le.zip4;						
	self.reg_1_county :=le.county;						
	self.reg_2_title :=le.title2;						
	self.reg_2_fname :=le.fname2;						
	self.reg_2_mname :=le.mname2;						
	self.reg_2_lname :=le.lname2;						
	self.reg_2_name_suffix :=le.suffix2;						
	self.reg_2_company_name :=le.company2;						
	self.price :=le.NET_PRICE;
    self.history := if(self.TITLE_STATUS_CODE = 'Z','E','');
end;

jnd := join(reg_dist, ttl_Dist, 
			left.title_no = right.title,
			tra(left, right),
			full outer,
			local);

export MO_as_Vehicles := jnd : persist('Persist::VehReg_MO_as_Vehicles');