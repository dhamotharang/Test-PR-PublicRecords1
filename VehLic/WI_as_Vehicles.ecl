import ut;

sDaysInMonthSet := ['31','28','31','30','31','30','31','31','30','31','30','31'];

string2 lLastDayOfMonth(string2 pMonthString)
 := sDaysInMonthSet[(integer1)pMonthString];

string8 lYMtoYMD(string4 pYearString, string2 pMonthString)
 := if((integer4)pYearString=0 or (integer4)pMonthString=0,
	   '',
	   pYearString+pMonthString+lLastDayOfMonth(pMonthString)
	  );

vehlic.layout_vehicles tAsVehicles(vehlic.File_WI_Full pInput)
 :=
  transform 
	self.orig_state 					:=	'WI';
	self.VEHICLE_NUMBERxBG1 			:=	pInput.Title_Number;
	self.ORIG_VIN 						:=	pInput.Vehicle_ID_Number;
	self.YEAR_MAKE 						:=	pInput.Vehicle_Year;
	self.MAKE_CODE 						:=	pInput.Vehicle_Make;
	self.VEHICLE_TYPE 					:=	pInput.Vehicle_Type;
	self.BODY_CODE 						:=	pInput.Body_Style;
	self.VEHICLE_USE 					:=	map(pInput.Taxi_Cab = 'T' => 'T',
												pInput.Police_Vehicle = 'T' => 'C',
												''
											   );
	self.ODOMETER_STATUS 				:=	pInput.Reading_Status;
	self.ODOMETER_DATE 					:=	(string8)ut.Date_MMDDYY_i2(pInput.reading_date);
	self.ODOMETER_MILEAGE 				:=	pInput.Mileage_Reading;
	self.GROSS_WEIGHT 					:=	intformat((unsigned8)pInput.Gross_Weight,6,1);
	self.MH_COUNTY_CODE 				:=	pInput.County_Code;
	self.OWNER_1_CUSTOMER_TYPExBG3 		:=	MAP(pInput.owner_name='' => '',
												pInput.owner_company='' => 'I',
												'B'
											   );
	self.OWN_1_CUSTOMER_NAME 			:=	pInput.Owner_Name;
	self.OWN_1_STREET_ADDRESS 			:=	pInput.Owner_Street_Address;
	self.OWN_1_CITY 					:=	pInput.Owner_Post_Office;
	self.OWN_1_ZIP5_ZIP4_FOREIGN_POSTAL :=	if(pInput.Owner_Name <> '',pInput.Owner_Zip_Code,'');
	self.LICENSE_PLATE_NUMBERxBG4 		:=	regexreplace('^0*', pInput.Plate_Number, '');
    self.REGISTRATION_EFFECTIVE_DATE    :=  if(pInput.process_data[5..6] > ut.GetDate[3..4],'19','20') + pInput.process_data[5..6] + pInput.process_data[1..4];
    self.FIRST_REGISTRATION_DATE        :=  if(pInput.Base_Year < '40','20','19') + pInput.Base_Year + '0000';
	self.REGISTRATION_EXPIRATION_DATE 	:=	lYMtoYMD(pInput.Registration_Expiration_Year,pInput.Registration_Expiration_Month);
	self.VEHICLE_CLASS_CODE 			:=	pInput.Plate_Type;
	self.REGISTRANT_1_CUSTOMER_TYPExBG5 :=	map(pInput.Lessee_Name = '' => '',
												pInput.lessee_company='' => 'I',
												'B'
											   );
	self.REG_1_CUSTOMER_NAME 			:=	pInput.Lessee_Name;
	self.REG_1_STREET_ADDRESS 			:=	pInput.Lessee_Street_Address;
	self.REG_1_CITY 					:=	pInput.Lessee_Post_Office;
	self.REG_1_ZIP5_ZIP4_FOREIGN_POSTAL :=	if(pInput.Lessee_Name <> '',pInput.Lessee_Zip_Code,'');
	self.TITLE_NUMBERxBG9 				:=	pInput.Title_Number;
	self.BRAND_CODESx5 					:=	map(pInput.Taxi_Cab = 'T' => 'T',
												pInput.Police_Vehicle = 'T' => 'C',
												pInput.Flood_Damage = 'T' => 'W',
												pInput.Manufacturer_Buy_Back = 'T' => 'N',
												pInput.Previous_Salvage = 'T' => 'R',
												pInput.Replica_Vehicle = 'T' => 'L',
												''
											   );
	self.own_1_title 					:=	pInput.owner_title;
	self.own_1_fname 					:=	pInput.owner_fname;
	self.own_1_mname 					:=	pInput.owner_mname;
	self.own_1_lname 					:=	pInput.owner_lname;
	self.own_1_name_suffix 				:=	pInput.owner_suffix;
	self.own_1_company_name 			:=	pInput.owner_company;
	self.own_1_prim_range 				:=	pInput.owner_prim_range;
	self.own_1_predir 					:=	pInput.owner_predir;
	self.own_1_prim_name 				:=	pInput.owner_prim_name;
	self.own_1_suffix 					:=	pInput.owner_addr_suffix;
	self.own_1_postdir 					:=	pInput.owner_postdir;
	self.own_1_unit_desig 				:=	pInput.owner_unit_desig;
	self.own_1_sec_range 				:=	pInput.owner_sec_range;
	self.own_1_p_city_name 				:=	if(pInput.Owner_Name <> '',pInput.owner_p_city_name,'');
	self.own_1_v_city_name 				:=	if(pInput.Owner_Name <> '',pInput.owner_v_city_name,'');
	self.own_1_state_2 					:=	if(pInput.Owner_Name <> '',pInput.owner_st,'');
	self.own_1_zip5 					:=	if(pInput.Owner_Name <> '',pInput.owner_zip,'');
	self.own_1_zip4 					:=	if(pInput.Owner_Name <> '',pInput.owner_zip4,'');
	self.own_1_county 					:=	if(pInput.Owner_Name <> '',pInput.owner_county,'');
	self.reg_1_title 					:=	pInput.lessee_title;
	self.reg_1_fname 					:=	pInput.lessee_fname;
	self.reg_1_mname 					:=	pInput.lessee_mname;
	self.reg_1_lname 					:=	pInput.lessee_lname;
	self.reg_1_name_suffix 				:=	pInput.lessee_suffix;
	self.reg_1_company_name 			:=	pInput.lessee_company;
	self.reg_1_prim_range 				:=	pInput.lessee_prim_range;
	self.reg_1_predir 					:=	pInput.lessee_predir;
	self.reg_1_prim_name 				:=	pInput.lessee_prim_name;
	self.reg_1_suffix 					:=	pInput.lessee_addr_suffix;
	self.reg_1_postdir 					:=	pInput.lessee_postdir;
	self.reg_1_unit_desig 				:=	pInput.lessee_unit_desig;
	self.reg_1_sec_range 				:=	pInput.lessee_sec_range;
	self.reg_1_p_city_name 				:=	if(pInput.Lessee_Name <> '',pInput.lessee_p_city_name,'');
	self.reg_1_v_city_name 				:=	if(pInput.Lessee_Name <> '',pInput.lessee_v_city_name,'');
	self.reg_1_state_2 					:=	if(pInput.Lessee_Name <> '',pInput.lessee_st,'');
	self.reg_1_zip5 					:=	if(pInput.Lessee_Name <> '',pInput.lessee_zip,'');
	self.reg_1_zip4 					:=	if(pInput.Lessee_Name <> '',pInput.lessee_zip4,'');
	self.reg_1_county 					:=	if(pInput.Lessee_Name <> '',pInput.lessee_county,'');
	self.vrid 							:=	0;
	self.dt_first_seen					:=	(unsigned6)(pInput.process_date[1..6]);
	self.dt_last_seen					:=	(unsigned6)(pInput.process_date[1..6]);
	self.dt_vendor_first_reported		:=	(unsigned6)(pInput.process_date[1..6]);
	self.dt_vendor_last_reported		:=	(unsigned6)(pInput.process_date[1..6]);
  end
 ;

export WI_as_Vehicles	:=	project(vehlic.File_WI_Full,tAsVehicles(left));
