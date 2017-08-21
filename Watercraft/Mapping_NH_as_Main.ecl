import watercraft;

watercraft_color_desc(string3 code)

:= case(code, 	

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

watercraft_toilet_desc(string1 code)

:= case(code, 

'N'  => 'TOILET NOT PRESENT',
'Y'  => 'TOILET PRESENT',
 '');


file_in := DEDUP(SORT(Watercraft.file_NH_clean_in,reg_num, reg_date), reg_num, reg_date);

Watercraft.Macro_Clean_Hull_ID(file_in, watercraft.Layout_NH_clean_in,hull_clean_in)

watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.Layout_NH_clean_in, wDatasetwithflag)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := transform


    self.watercraft_key				        :=	if(length(trim(L.HULL_ID, left, right)) = 12 and trim(L.year, left, right) >= '1972' and L.is_hull_id_in_MIC, trim(L.HULL_ID, left, right),
										        (trim(L.HULL_ID,left, right) + trim(L.MAKE,left, right) + trim(L.YEAR, left, right) + trim(L.FIRST_NAME,left, right) + trim(L.LAST_NAME,left, right) + trim(L.MID,left, right))[1..30]);                               
	self.sequence_key				        :=	trim(L.REG_DATE, left, right);
	self.watercraft_id						:=	'';
	self.state_origin						:=	'NH';
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
	self.watercraft_model_description		:=	'';
	self.watercraft_width					:=	'';
	self.watercraft_weight					:=	'';
	self.watercraft_color_1_code			:=	L.COLOR1;
	self.watercraft_color_1_description		:=	watercraft_color_desc(L.COLOR1);
	self.watercraft_color_2_code			:=	L.COLOR2;
	self.watercraft_color_2_description		:=	watercraft_color_desc(L.COLOR2);
	self.watercraft_toilet_code				:=	L.TOILET;
	self.watercraft_toilet_description		:=	watercraft_toilet_desc(L.TOILET);
	self.watercraft_number_of_engines		:=	IF(L.NUM_ENGINES='S', '1', IF(L.NUM_ENGINES='T', '2', ''));
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
	self.registration_expiration_date		:=	L.EXPIRE_DATE;
	self.registration_status_code			:=	'';
	self.registration_status_description	:=	'';
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	L.DECAL;
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
	self.purchase_price						:=	(STRING)(intEGER)L.LIST_PRICE;
	self.new_used_flag						:=	'';
	self.watercraft_status_code				:=	'';
	self.watercraft_status_description		:=	'';
	self.history_flag						:=	'';
	self.coastguard_flag					:=	'';
  
  end;



export Mapping_NH_as_Main := project(wDatasetwithflag, main_mapping_format(left));



	
