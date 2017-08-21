Import Watercraft, ut;

File_Base := Watercraft.File_Base_Main_Prod;

//Clean spaces and uppercase
Watercraft.Layout_Watercraft_Main_Base CleanInput(File_Base pInput) := TRANSFORM
	SELF.sequence_key													:= ut.fnTrim2Upper(pInput.sequence_key);
	SELF.state_origin													:= ut.fnTrim2Upper(pInput.state_origin);
	SELF.st_registration											:= ut.fnTrim2Upper(pInput.st_registration);
	SELF.county_registration									:= ut.fnTrim2Upper(pInput.county_registration);
	SELF.propulsion_description								:= ut.fnTrim2Upper(pInput.propulsion_description);
	SELF.vehicle_type_description							:= ut.fnTrim2Upper(pInput.vehicle_type_description);
	SELF.fuel_description											:= ut.fnTrim2Upper(pInput.fuel_description);
	SELF.hull_type_description								:= ut.fnTrim2Upper(pInput.hull_type_description);
	SELF.use_description											:= ut.fnTrim2Upper(pInput.use_description);
	SELF.watercraft_name											:= ut.fnTrim2Upper(pInput.watercraft_name);
	SELF.watercraft_class_description					:= ut.fnTrim2Upper(pInput.watercraft_class_description);
	SELF.watercraft_make_description					:= ut.fnTrim2Upper(pInput.watercraft_make_description);
	SELF.watercraft_model_description					:= ut.fnTrim2Upper(pInput.watercraft_model_description);
	SELF.registration_status_description			:= ut.fnTrim2Upper(pInput.registration_status_description);
	SELF.transaction_type_description					:= ut.fnTrim2Upper(pInput.transaction_type_description);
	SELF.lien_1_name													:= ut.fnTrim2Upper(pInput.lien_1_name);
	SELF.lien_1_address_1											:= ut.fnTrim2Upper(pInput.lien_1_address_1);
	SELF.lien_1_address_2											:= ut.fnTrim2Upper(pInput.lien_1_address_2);
	SELF.lien_1_city													:= ut.fnTrim2Upper(pInput.lien_1_city);
	SELF.lien_1_state													:= ut.fnTrim2Upper(pInput.lien_1_state);
	SELF.lien_1_zip														:= ut.fnTrim2Upper(REGEXREPLACE('-',pInput.lien_1_zip,''));
	SELF.lien_2_name													:= ut.fnTrim2Upper(pInput.lien_2_name);
	SELF.lien_2_address_1											:= ut.fnTrim2Upper(pInput.lien_2_address_1);
	SELF.lien_2_address_2											:= ut.fnTrim2Upper(pInput.lien_2_address_2);
	SELF.lien_2_city													:= ut.fnTrim2Upper(pInput.lien_2_city);
	SELF.lien_2_state													:= ut.fnTrim2Upper(pInput.lien_2_state);
	SELF.lien_2_zip														:= ut.fnTrim2Upper(REGEXREPLACE('-',pInput.lien_2_zip,''));
	SELF.state_purchased											:= ut.fnTrim2Upper(pInput.state_purchased);
	SELF := pInput;
END;

CleanBase	:= project(File_Base,CleanInput(left));

EXPORT In_Watercraft_Base := enth(CleanBase,1000,1,1000000);
