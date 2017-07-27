import watercraft;


watercraft_color_desc(string3 code)

:= case(code, 	

'AQU' => 'AQUA',
'BLK' => 'BLACK',
'BLU' => 'BLUE',
'BRN' => 'BROWN',
'GOL' => 'GOLD',
'GRN' => 'GREEN',
'GRY' => 'GRAY',
'LBL' => 'LIGHT BLUE',
'LGN' => 'LIGHT GREEN',
'MRN' => 'MAROON',
'NCO' => 'NO COLOR',
'ORA' => 'ORANGE',
'OTH' => 'OTHER',
'PNK' => 'PINK',
'PUR' => 'PURPLE',
'RED' => 'RED',
'WHT' => 'WHITE',
'YEL' => 'YELLOW',
'SEL' => 'YELLOW',

'' );   


searchpattern := '^(.*)-(.*)$';

file_sort  := sort(watercraft.file_MA_clean_in,serial_number, ENG_MN_TYP_CODE, ENG_YEAR,SERIAL_NUMBER,HORSEPOWER);
file_dedup := dedup(file_sort,serial_number,ENG_MN_TYP_CODE, ENG_YEAR,SERIAL_NUMBER,HORSEPOWER);
 

watercraft.Layout_Watercraft_Main_Base main_mapping_format(file_dedup L) 

:= transform


    self.watercraft_key				        :=	if(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12, trim(L.HULL_ID,left, right),
	                                            (trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30]);                                          
	self.sequence_key				        :=	trim(L.REG_DATE, left, right);
	self.watercraft_id						:=	'';
	self.state_origin						:=	'MA';
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
	self.watercraft_class_code				:= trim(if(REGEXFIND(searchpattern, L.description)= true, regexreplace('Boat Registration Class', REGEXFIND(searchpattern, L.description, 1) , ' '), ' '), left, right) ;
	self.watercraft_class_description		:= trim(REGEXFIND(searchpattern, L.description, 2), left, right);
	self.watercraft_make_code				:=	'';
	self.watercraft_make_description		:=	L.MAKE;
	self.watercraft_model_code				:=	'';
	self.watercraft_model_description		:=	'';
	self.watercraft_width					:=	'';
	self.watercraft_weight					:=	'';
	self.watercraft_color_1_code			:=	L.COLOR_TYP_CODE_PRIMARI;
	self.watercraft_color_1_description		:=	watercraft_color_desc(L.COLOR_TYP_CODE_PRIMARI);
	self.watercraft_color_2_code			:=	L.COLOR_TYP_CODE_SECONDARY;
	self.watercraft_color_2_description		:=	watercraft_color_desc(L.COLOR_TYP_CODE_SECONDARY);
	self.watercraft_toilet_code				:=	'';
	self.watercraft_toilet_description		:=	'';
	self.watercraft_number_of_engines		:=	'';
	self.watercraft_hp_1					:=	'';
	self.watercraft_hp_2					:=	'';
	self.watercraft_hp_3					:=	'';
	self.engine_number_1					:=	'';
	self.engine_number_2					:=	'';
	self.engine_number_3					:=	'';
	self.engine_make_1						:=	'';
	self.engine_make_2						:=	'';
	self.engine_make_3						:=  '';
	self.engine_model_1						:=	'';
	self.engine_model_2						:=	'';
	self.engine_model_3						:=	'';
	self.engine_year_1						:=	'';
	self.engine_year_2						:=	'';
	self.engine_year_3						:=	'';
	self.coast_guard_documented_flag		:=	'';
	self.coast_guard_number					:=	'';
	self.registration_date					:=	L.REG_DATE;
	self.registration_expiration_date		:=	L.EXPIRATION_DATE;
	self.registration_status_code			:=	'';
	self.registration_status_description	:=	L.STATUS;
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


Mapping_MA_as_Main_temp := project(watercraft.file_MA_clean_in, main_mapping_format(left));


watercraft.Layout_Watercraft_Main_Base denorm_main(watercraft.Layout_Watercraft_Main_Base L, file_dedup R, integer1 C) 

:= transform

    self.watercraft_hp_1				:=	IF(C = 1, if(R.HORSEPOWER = '0','',R.HORSEPOWER), L.watercraft_hp_1);
	self.watercraft_hp_2				:=	IF(C = 2, if(R.HORSEPOWER = '0','',R.HORSEPOWER), L.watercraft_hp_2);
	self.watercraft_hp_3				:=	IF(C = 3, if(R.HORSEPOWER = '0','',R.HORSEPOWER), L.watercraft_hp_3);
	self.engine_number_1				:=	IF(C = 1, R.SERIAL_NUMBER, L.engine_number_1);
	self.engine_number_2				:=	IF(C = 2, R.SERIAL_NUMBER, L.engine_number_2);
	self.engine_number_3				:=	IF(C = 3, R.SERIAL_NUMBER, L.engine_number_3);
	self.engine_make_1					:=	IF(C = 1, R.ENG_MN_TYP_CODE, L.engine_make_1);
	self.engine_make_2					:=	IF(C = 2, R.ENG_MN_TYP_CODE, L.engine_make_2);
	self.engine_make_3					:=	IF(C = 3, R.ENG_MN_TYP_CODE, L.engine_make_3);
	self.engine_year_1					:=	IF(C = 1, R.ENG_YEAR, L.engine_year_1);
	self.engine_year_2					:=	IF(C = 2, R.ENG_YEAR, L.engine_year_2);
	self.engine_year_3					:=	IF(C = 3, R.ENG_YEAR, L.engine_year_3);
	self                                :=  L;

end;

export Mapping_MA_as_Main := DENORMALIZE(Mapping_MA_as_Main_temp, file_dedup,
                               LEFT.registration_number = RIGHT.reg_num,
                                DeNorm_main(LEFT,RIGHT,COUNTER));

								


	

