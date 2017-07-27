import watercraft;


watercraft_citizen_desc(string1 code)
 := case(code,
					'N' => 'NO (NON-CITIZEN)',
					'Y' => 'YES (CITIZEN)',
					'' );


watercraft_color_desc(string3 code)

:= case(code, 	'BLK' => 'BLACK',
'BLU' => 'BLUE',
'BRN' => 'BROWN',
'GRN' => 'GREEN',
'GRY' => 'GREY',
'ORN' => 'ORANGE',
'PUR' => 'PURPLE',
'RED' => 'RED',
'TAN' => 'TAN',
'WHT' => 'WHITE',
'YEL' => 'YELLOW',
'' );   

reg_status_desc(string1 code)

:= case(code, 'A' => 'ACTIVE',
              'B' => 'INACTIVE', '');


watercraft.Macro_Is_hull_id_in_MIC(Watercraft.file_CT_clean_in, watercraft.Layout_CT_clean_in, wDatasetwithflag)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := transform


    self.watercraft_key				        :=	if(length(trim(L.HULL_ID, left, right)) = 12 and trim(L.year, left, right) >= '1972' and L.is_hull_id_in_MIC, trim(L.HULL_ID, left, right),
	                                            if(stringlib.stringfind(L.HULL_ID, 'UNKNOWN', 1) = 0, (trim(L.HULL_ID, left, right) + trim(regexreplace('UNKNOWN', L.MAKE, ''),left, right) + trim(L.YEAR, left, right))[1..30],
										        (trim(regexreplace('UNKNOWN', L.HULL_ID, ''), left, right) + trim(regexreplace('UNKNOWN', L.MAKE, ''),left, right) + trim(L.YEAR, left, right) + trim(L.NAME,left, right))[1..30]));                          
	self.sequence_key				        :=	trim(L.REG_DATE, left, right);
	self.watercraft_id						:=	'';
	self.state_origin						:=	'CT';
	self.source_code						:=	'AW';
	self.st_registration					:=	L.STATEABREV;
	self.county_registration				:=	L.county;
	self.registration_number				:=	trim(L.REG_NUM, left, right);
	self.hull_number						:=	L.hull_id;
	self.propulsion_code					:=	'';
	self.propulsion_description				:=	L.PROP;
	self.vehicle_type_Code					:=	'';
	self.vehicle_type_Description			:=	L.VEH_TYPE;
	self.fuel_code							:=	'';
	self.fuel_description					:=	L.FUEL;
	self.hull_type_code						:=	'';
	self.hull_type_description				:=	L.HULL;
	self.use_code							:=	'';
	self.use_description					:=	L.USE_1;
	self.watercraft_length					:=	L.TOTAL_INCH;
	self.model_year							:=	L.YEAR;
	self.watercraft_name					:=	'';
	self.watercraft_class_code				:=	'';
	self.watercraft_class_description		:=	'';
	self.watercraft_make_code				:=	'';
	self.watercraft_make_description		:=	L.MAKE;
	self.watercraft_model_code				:=	'';
	self.watercraft_model_description		:=	L.MODEL;
	self.watercraft_width					:=	'';
	self.watercraft_weight					:=	'';
	self.watercraft_color_1_code			:=	L.COLOR1;
	self.watercraft_color_1_description		:=	watercraft_color_desc(L.COLOR1);
	self.watercraft_color_2_code			:=	L.COLOR2;
	self.watercraft_color_2_description		:=	watercraft_color_desc(L.COLOR2);
	self.watercraft_toilet_code				:=	'';
	self.watercraft_toilet_description		:=	'';
	self.watercraft_number_of_engines		:=	'';
	self.watercraft_hp_1					:=	L.HP;
	self.watercraft_hp_2					:=	'';
	self.watercraft_hp_3					:=	'';
	self.engine_number_1					:=	'';
	self.engine_number_2					:=	'';
	self.engine_number_3					:=	'';
	self.engine_make_1						:=	'';
	self.engine_make_2						:=	'';
	self.engine_make_3						:=	'';
	self.engine_model_1						:=	'';
	self.engine_model_2						:=	'';
	self.engine_model_3						:=	'';
	self.engine_year_1						:=	'';
	self.engine_year_2						:=	'';
	self.engine_year_3						:=	'';
	self.coast_guard_documented_flag		:=	'';
	self.coast_guard_number					:=	'';
	self.registration_date					:=	L.REG_DATE;
	self.registration_expiration_date		:=	L.EXPIRATION;
	self.registration_status_code			:=	L.STATUS;
	self.registration_status_description	:=	reg_status_desc(L.STATUS);
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	'';
	self.transaction_type_code				:=	'';
	self.transaction_type_description		:=	'';
	self.title_state						:=	'';
	self.title_status_code					:=	'';
	self.title_status_description			:=	'';
	self.title_number						:=	'';
	self.title_issue_date					:=	'';
	self.title_type_code					:=	'';
	self.title_type_description				:=	'';
	self.additional_owner_count				:=	'';
	self.lien_1_indicator					:=	'';
	self.lien_1_name						:=	'';
	self.lien_1_date						:=	'';
	self.lien_1_address_1					:=	'';
	self.lien_1_address_2					:=	'';
	self.lien_1_city						:=	'';
	self.lien_1_state						:=	'';
	self.lien_1_zip							:=	'';
	self.lien_2_indicator					:=	'';
	self.lien_2_name						:=	'';
	self.lien_2_date						:=	'';
	self.lien_2_address_1					:=	'';
	self.lien_2_address_2					:=	'';
	self.lien_2_city						:=	'';
	self.lien_2_state						:=	'';
	self.lien_2_zip							:=	'';
	self.state_purchased					:=	'';
	self.purchase_date						:=	'';
	self.dealer								:=	'';
	self.purchase_price						:=	'';
	self.new_used_flag						:=	'';
	self.watercraft_status_code				:=	'';
	self.watercraft_status_description		:=	'';
	self.history_flag						:=	'';
	self.coastguard_flag					:=	'';
  
  end;



export Mapping_CT_as_Main := project(wDatasetwithflag, main_mapping_format(left));



