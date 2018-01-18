import doxie_build, doxie, codes, data_services;

den := doxie_build.Vehlic_Denormed_KeyBuilding;

ExtendedLayout :=
RECORD
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

ExtendedLayout getDecode(ExtendedLayout L, cdk R, STRING field) := 
transform
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

export Key_prep_Vehicles := INDEX(o15, 
                                  {sseq_no := seq_no}, 
                                  {o15}, 
                                  data_services.data_location.prefix() + 'thor_data400::key::'+doxie_build.buildstate+'vehiclefull'+thorlib.wuid());
