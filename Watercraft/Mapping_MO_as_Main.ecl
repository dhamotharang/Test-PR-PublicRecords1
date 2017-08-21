import watercraft;

watercraft_color_desc(string3 code) := case(code, 	
'BGE'  => 'BEIGE',
'BLK'  => 'BLACK',
'BLU'  => 'BLUE',
'BRO'  => 'BROWN',
'BRZ'  => 'BRONZE',
'CAM'  => 'CAMOFLAGE',
'COM'  => 'COMBINATION',
'CPR'  => 'COPPER',
'CRM'  => 'CREAM',
'DBL'  => 'DARK BLUE',
'DGR'  => 'DARK GREEN',
'GLD'  => 'GOLD',
'GRN'  => 'GREEN',
'GRY'  => 'GRAY',
'LAV'  => 'LAVENDER',
'LBL'  => 'LIGHT BLUE',
'LGR'  => 'LIGHT GREEN',
'MAR'  => 'MAROON',
'MUL'  => 'MULBERRY',
'ONG'  => 'ORANGE',
'PLE'  => 'PURPLE',
'PNK'  => 'PINK',
'RED'  => 'RED',
'SIL'  => 'SILVER',
'TAN'  => 'TAN',
'TEA'  => 'TEAL',
'TRQ'  => 'TURQUOISE',
'WHI'  => 'WHITE',
'YEL'  => 'YELLOW',
'' );  
Watercraft.Macro_Clean_Hull_ID(watercraft.file_MO_clean_in, watercraft.Layout_MO_clean_in,hull_clean_in)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := transform


    self.watercraft_key				        :=	(trim(L.HULL_ID, left, right) + trim(L.MAKE,left, right) + trim(L.YEAR, left, right))[1..30];                                          
	self.sequence_key				        :=	if((trim(L.REG_DATE, left, right)<>''),L.REG_DATE,L.NAME);
	self.watercraft_id						:=	'';
	self.state_origin						:=	'MO';
	self.source_code						:=	'AW';
	self.st_registration					:=	L.STATEABREV;
	self.county_registration				:=	trim(L.county,left,right);
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
	self.watercraft_model_description		:=	L.MODEL_NUM;
	self.watercraft_width					:=	'';
	self.watercraft_weight					:=	'';
	self.watercraft_color_1_code			:=	L.COLOR[1..3];
	self.watercraft_color_1_description		:=	watercraft_color_desc(L.COLOR[1..3]);
	self.watercraft_color_2_code			:=	if((stringlib.stringfind(L.COLOR,'/',1)=4),L.COLOR[5..7],'');
	self.watercraft_color_2_description		:=	if((stringlib.stringfind(L.COLOR,'/',1)=4),watercraft_color_desc(L.COLOR[5..7]),'');
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
	self.registration_date					:=	if(L.REG_DATE = '19910926', '', L.REG_DATE);
	self.registration_expiration_date		:=	L.EXPIRE_YEAR;
	self.registration_status_code			:=	'';
	self.registration_status_description	:=	'';
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	'';
	self.transaction_type_code				:=	'';
	self.transaction_type_description		:=	'';
	self.title_state						:=	'';
	self.title_status_code					:=	'';
	self.title_status_description			:=	'';
	self.title_number						:=	L.TITLE;
	self.title_issue_date					:=	L.APPLICATION;
	self.title_type_code					:=	'';
	self.title_type_description				:=	'';
	self.additional_owner_count				:=	'';
	self.lien_1_indicator					:=	if((trim(L.LIEN_1,left,right)<>''),'Y','N');
	self.lien_1_name						:=	L.LIEN_1;
	self.lien_1_date						:=	L.LEIN_DATE_1;
	self.lien_1_address_1					:=	L.STREET_1;
	self.lien_1_address_2					:=	'';
	self.lien_1_city						:=	L.CITY_1;
	self.lien_1_state						:=	L.STATE_1;
	self.lien_1_zip							:=	L.ZIP_1;
	self.lien_2_indicator					:=	if((trim(L.LIEN_2,left,right)<>''),'Y','N');
	self.lien_2_name						:=	L.LIEN_2;
	self.lien_2_date						:=	L.LIEN_DATE_2;
	self.lien_2_address_1					:=	L.STREET_2;
	self.lien_2_address_2					:=	'';
	self.lien_2_city						:=	L.CITY_2;
	self.lien_2_state						:=	L.STATE_2;
	self.lien_2_zip							:=	L.ZIP_2;
	self.state_purchased					:=	map((L.NEW_USED='O')=>'',
													(L.NEW_USED='F')=>'',
													(L.NEW_USED='U')=>'MO',
													(L.NEW_USED='N')=>'MO',
													'');
	self.purchase_date						:=	L.PURCHASE_DATE;
	self.dealer								:=	L.DEALER_NUM;
	self.purchase_price						:=	'';
	self.new_used_flag						:=	map((L.NEW_USED='O')=>'N',
													(L.NEW_USED='F')=>'U',
													(L.NEW_USED='U')=>'U',
													(L.NEW_USED='N')=>'N',
													'');
	self.watercraft_status_code				:=	'';
	self.watercraft_status_description		:=	'';
	self.history_flag						:=	'';
	self.coastguard_flag					:=	'';
end;

export Mapping_MO_as_Main := project(hull_clean_in, main_mapping_format(left));