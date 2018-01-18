//WARNING: THIS KEY IS AN FCRA KEY...
import doxie_build, codes, doxie, data_services;

den := doxie_build.Vehlic_Denormed;

ExtendedLayout := RECORD
	den;
	string30 history_name := '';
	string30 major_color_name := '';
	string30 minor_color_name := '';
	string30 orig_state_name := '';
	string30 body_code_name := '';
	string30 fuel_type_name := '';
	string30 hull_material_type_name := '';
	string75 license_plate_code_name := '';
	string30 odometer_status_name := '';
	string30 title_status_code_name := '';
	string30 vehicle_type_name := '';
	string30 vehicle_use_name := '';
	string30 vessel_propulsion_type_name := '';
	string30 vessel_type_name := '';
	string30	lh_1_county_name := '';
	string30	lh_2_county_name := '';
	string30	lh_3_county_name := '';
END;

cdk := Codes.File_Codes_V3_In;

ExtendedLayout getHist(den L, cdk R) := transform
	self.history_name := R.long_desc;
	// fills in the blanks with 0
	self.vehicle_numberxbg1 := TRIM(L.vehicle_numberxbg1) + '00000000000000000000';
	self := L;
end;

o1 := join(den,cdk, right.file_name = (STRING35)'VEHICLE_REGISTRATION' AND 
				right.field_name= (STRING50)'HISTORY_FLAG' AND
				(string15)Left.history = right.code,
					getHist(LEFT,RIGHT),left outer, lookup);

ExtendedLayout getDecode(ExtendedLayout L, cdk R, STRING field) := transform
	self.major_color_name := IF(field = 'major_color_name', R.long_desc, L.major_color_name);
	self.minor_color_name := IF(field = 'minor_color_name', R.long_desc, L.minor_color_name);
	self.orig_state_name := IF(field = 'orig_state_name', R.long_desc, L.orig_state_name);
	self.body_code_name := IF(field = 'body_code_name', R.long_desc, L.body_code_name);
	self.fuel_type_name := IF(field = 'fuel_type_name', R.long_desc, L.fuel_type_name);
	self.hull_material_type_name := IF(field = 'hull_material_type_name', R.long_desc, L.hull_material_type_name);
	self.license_plate_code_name := IF(field = 'license_plate_code_name', R.long_desc, L.license_plate_code_name);
	self.odometer_status_name := IF(field = 'odometer_status_name', R.long_desc, L.odometer_status_name);
	self.title_status_code_name := IF(field = 'title_status_code_name', R.long_desc, L.title_status_code_name);
	self.vehicle_type_name := IF(field = 'vehicle_type_name', R.long_desc, L.vehicle_type_name);
	self.vehicle_use_name := IF(field = 'vehicle_use_name', R.long_desc, L.vehicle_use_name);
	self.vessel_propulsion_type_name := IF(field = 'vessel_propulsion_type_name', R.long_desc, L.vessel_propulsion_type_name);
	self.vessel_type_name := IF(field = 'vessel_type_name', R.long_desc, L.vessel_type_name);
	self := L;
end;

o2 := join(o1,cdk,	right.file_name = (STRING35)'VEHICLE_REGISTRATION' AND
				right.field_name= (STRING50)'MAJOR_COLOR_CODE' AND
				(string5)left.orig_state = right.field_name2 AND
				(string15)left.major_color_code = right.code,
			getDecode(LEFT, RIGHT, 'major_color_name'), left outer, lookup);
o3 := join(o2,cdk,	right.file_name = (STRING35)'VEHICLE_REGISTRATION' AND
				right.field_name= (STRING50)'MINOR_COLOR_CODE' AND
				(string5)left.orig_state = right.field_name2 AND
				(string15)left.minor_color_code = right.code,
			getDecode(LEFT,RIGHT, 'minor_color_name'),left outer, lookup);
o4 := join(o3,cdk,	right.file_name = (STRING35)'VEHICLE_REGISTRATION' AND
				right.field_name= (STRING50)'BODY_CODE' AND
				(string15)left.body_code = right.code,
			getDecode(LEFT,RIGHT,'body_code_name'),left outer, lookup);
o5 := join(o4,cdk,	right.file_name = (STRING35)'VEHICLE_REGISTRATION' AND
				right.field_name= (STRING50)'FUEL_TYPE' AND
				(string15)left.fuel_type = right.code,
			getDecode(LEFT,RIGHT,'fuel_type_name'),left outer, lookup);
o6 := join(o5,cdk,	right.file_name = (STRING35)'VEHICLE_REGISTRATION' AND
				right.field_name= (STRING50)'HULL_MATERIAL_TYPE' AND
				(string15)left.hull_material_type = right.code,
			getDecode(LEFT,RIGHT,'hull_material_type_name'),left outer, lookup);
o7 := join(o6,cdk,	right.file_name = (STRING35)'VEHICLE_REGISTRATION' AND
				right.field_name= (STRING50)'LICENSE_PLATE_CODE' AND
				(string15)left.license_plate_code = right.code,
			getDecode(LEFT,RIGHT,'license_plate_code_name'),left outer, lookup);
o8 := join(o7,cdk,	right.file_name = (STRING35)'VEHICLE_REGISTRATION' AND
				right.field_name= (STRING50)'ODOMETER_STATUS' AND
				(string15)left.odometer_status = right.code,
			getDecode(LEFT,RIGHT,'odometer_status_name'),left outer, lookup);
o9 := join(o8,cdk,	right.file_name = (STRING35)'VEHICLE_REGISTRATION' AND
				right.field_name= (STRING50)'TITLE_STATUS_CODE' AND
				(string15)left.title_status_code = right.code,
			getDecode(LEFT,RIGHT,'title_status_code_name'),left outer, lookup);
o10 := join(o9,cdk,	right.file_name = (STRING35)'VEHICLE_REGISTRATION' AND
				right.field_name= (STRING50)'VEHICLE_TYPE' AND
				(string15)left.vehicle_type = right.code,
			getDecode(LEFT,RIGHT,'vehicle_type_name'),left outer, lookup);
o11 := join(o10,cdk,right.file_name = (STRING35)'VEHICLE_REGISTRATION' AND
				right.field_name= (STRING50)'VEHICLE_USE' AND
				(string15)left.vehicle_use = right.code,
			getDecode(LEFT,RIGHT,'vehicle_use_name'),left outer, lookup);
o12 := join(o11,cdk,right.file_name = (STRING35)'VEHICLE_REGISTRATION' AND
				right.field_name= (STRING50)'VESSEL_PROPULSION_TYPE' AND
				(string15)left.vessel_propulsion_type = right.code,
			getDecode(LEFT,RIGHT,'vessel_propulsion_type_name'),left outer, lookup);
o13 := join(o12,cdk,right.file_name = (STRING35)'VEHICLE_REGISTRATION' AND
				right.field_name= (STRING50)'VESSEL_TYPE' AND
				(string15)left.vessel_type = right.code,
			getDecode(LEFT,RIGHT,'vessel_type_name'),left outer, lookup);
o14 := join(o13,cdk,right.file_name = (STRING35)'GENERAL' AND
				right.field_name= (STRING50)'STATE_LONG' AND
				(string15)left.orig_state = right.code,
			getDecode(LEFT,RIGHT,'orig_state_name'),left outer, lookup);


o14 map_lein_holder_county_names(o14 L) := transform
	self.lh_1_county_name := doxie.fl_counties((integer)L.lh_1_residence_county);
	self.lh_2_county_name := doxie.fl_counties((integer)L.lh_2_residence_county);
	self.lh_3_county_name := doxie.fl_counties((integer)L.lh_3_residence_county);
	self := L;
end;

o15 := project(o14,map_lein_holder_county_names(LEFT));

//Old name: 'thor_data400::key::'+doxie_build.buildstate+'vehiclefull_FCRA_'+doxie.Version_SuperKey);
export Key_Vehicles_FCRA := 
  // INDEX (o15, {sseq_no := seq_no}, 
         // {Best_Model_Year,Best_Make_Code,Best_Model_Code,
          // history, LIEN_COUNTxBG10,orig_vin,dt_first_seen, orig_state},
          // data_services.data_location.prefix() + 'thor_data400::key::vehicle::fcra::full_' + doxie.Version_SuperKey);
  INDEX (o15, {sseq_no := seq_no}, 
         {
          dt_first_seen, orig_state, source_code, orig_vin, LIEN_COUNTxBG10,
          own_1_fname, own_1_lname, own_1_did, own_1_ssn, 
          own_1_prim_range, own_1_predir, own_1_prim_name, own_1_suffix, own_1_postdir, 
          own_1_unit_desig, own_1_p_city_name, own_1_state_2, own_1_zip5, own_1_zip4, 
          own_2_fname, own_2_lname, own_2_did, own_2_ssn, 
          own_2_prim_range, own_2_predir, own_2_prim_name, own_2_suffix, own_2_postdir, 
          own_2_unit_desig, own_2_p_city_name, own_2_state_2, own_2_zip5, own_2_zip4, 
          reg_1_fname, reg_1_lname, reg_1_did, reg_1_ssn, 
          reg_1_prim_range, reg_1_predir, reg_1_prim_name, reg_1_suffix, reg_1_postdir,
          reg_1_unit_desig, reg_1_p_city_name, reg_1_state_2, reg_1_zip5, reg_1_zip4, 
          reg_2_fname, reg_2_lname, reg_2_did, reg_2_ssn, 
          reg_2_prim_range, reg_2_predir, reg_2_prim_name, reg_2_suffix, reg_2_postdir, 
          reg_2_unit_desig, reg_2_p_city_name, reg_2_state_2, reg_2_zip5, reg_2_zip4, 
					history, Best_Make_Code, Best_Model_Code, Best_Model_Year
         },
         data_services.data_location.prefix() + 'thor_data400::key::vehicle::fcra::full_' + doxie.Version_SuperKey);