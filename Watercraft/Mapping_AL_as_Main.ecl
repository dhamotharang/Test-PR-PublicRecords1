import watercraft;


watercraft_class_desc(string1 code)
 := case(code,
					'0' => 'OTHERS',
					'1' => 'BOATS LESS THAN 16 FEET IN LENGTH',
					'2' => 'BOATS 16 - 25 FEET IN LENGTH',
					'3' => 'BOATS 26 - 39 FEET IN LENGTH',
					'4' => 'BOATS 40 FEET AND ABOVE',
					'5' => 'FIRST DEALER/DEMO BOATS',
					'6' => 'ADDITIONAL DEALER/DEMO BOATS',
					'' );



county_reg(string2 code)

:= case(code, 	'01'  => 'AUTAUGA',
                '02'  => 'BALDWIN',
                '03'  => 'BARBOUR',
                '04'  => 'BIBB',
                '05'  => 'BLOUNT',
                '06'  => 'BULLOCK',
                '07'  => 'BUTLER',
                '08'  => 'CALHOUN',
                '09'  => 'CHAMBERS',
                '10'  => 'CHEROKEE',
                '11'  => 'CHILTON',
                '12'  => 'CHOCTAW',
                '13'  => 'CLARKE',
                '14'  => 'CLAY',
                '15'  => 'CLEBURNE',
                '16'  => 'COFFEE',
                '17'  => 'COLBERT',
                '18'  => 'CONECUH',
                '19'  => 'COOSA',
                '20'  => 'COVINGTON',
                '21'  => 'CRENSHAW',
                '22'  => 'CULLMAN',
                '23'  => 'DALE',
                '24'  => 'DALLAS',
                '25'  => 'DEKALB',
                '26'  => 'ELMORE',
                '27'  => 'ESCAMBIA',
                '28'  => 'ETOWAH',
                '29'  => 'FAYETTE',
                '30'  => 'FRANKLIN',
                '31'  => 'GENEVA',
                '32'  => 'GREENE',
                '33'  => 'HALE',
                '34'  => 'HENRY',
                '35'  => 'HOUSTON',
                '36'  => 'JACKSON',
                '37'  => 'JEFFERSON',
                '38'  => 'LAMAR',
                '39'  => 'LAUDERDALE',
                '40'  => 'LAWRENCE',
                '41'  => 'LEE',
                '42'  => 'LIMESTONE',
                '43'  => 'LOWNDES',
                '44'  => 'MACON',
                '45'  => 'MADISON',
                '46'  => 'MARENGO',
                '47'  => 'MARION',
                '48'  => 'MARSHALL',
                '49'  => 'MOBILE',
                '50'  => 'MONROE',
                '51'  => 'MONTGOMERY',
                '52'  => 'MORGAN',
                '53'  => 'PERRY',
                '54'  => 'PICKENS',
                '55'  => 'PIKE',
                '56'  => 'RANDOLPH',
                '57'  => 'RUSSELL',
                '58'  => 'SHELBY',
                '59'  => 'ST. CLAIRE',
                '60'  => 'SUMTER',
                '61'  => 'TALLADEGA',
                '62'  => 'TALLAPOOSA',
                '63'  => 'TUSCALOOSA',
                '64'  => 'WALKER',
                '65'  => 'WASHINGTON',
                '66'  => 'WILCOX',
                '67'  => 'WINSTON',

				'' );   


watercraft.Layout_Watercraft_Main_Base main_mapping_format(watercraft.file_AL_clean_in L) := transform


    self.watercraft_key						:=	(trim(L.HULL_ID, left, right) + trim(L.DECAL_NUMBER, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30];
	self.sequence_key						:=	trim(L.REG_DATE, left, right);
	self.watercraft_id						:=	'';
	self.state_origin						:=	'AL';
	self.source_code						:=	'AW';
	self.st_registration					:=	L.STATEABREV;
	self.county_registration				:=	county_reg(trim(L.county,left,right));
	self.registration_number				:=	trim(L.REG_NUM, left, right);
	self.hull_number						:=	L.hull_id;
	self.propulsion_code					:=	'';
	self.propulsion_description				:=	L.PROP;
	self.vehicle_type_Code					:=	L.VEH_TYPE;
	self.vehicle_type_Description			:=	if(trim(L.VEH_TYPE, left, right) = 'PWC', 'PERSONAL WATERCRAFT', L.VEH_TYPE);
	self.fuel_code							:=	'';
	self.fuel_description					:=	L.FUEL;
	self.hull_type_code						:=	'';
	self.hull_type_description				:=	L.HULL;
	self.use_code							:=	'';
	self.use_description					:=	L.USE_1;
	self.watercraft_length					:=	L.TOTAL_INCH;
	self.model_year							:=	L.YEAR;
	self.watercraft_name					:=	'';
	self.watercraft_class_code				:=	L.BOAT_CLASS;
	self.watercraft_class_description		:=	watercraft_class_desc(L.BOAT_CLASS);
	self.watercraft_make_code				:=	'';
	self.watercraft_make_description		:=	L.MAKE;
	self.watercraft_model_code				:=	'';
	self.watercraft_model_description		:=	'';
	self.watercraft_width					:=	'';
	self.watercraft_weight					:=	'';
	self.watercraft_color_1_code			:=	'';
	self.watercraft_color_1_description		:=	'';
	self.watercraft_color_2_code			:=	'';
	self.watercraft_color_2_description		:=	'';
	self.watercraft_toilet_code				:=	'';
	self.watercraft_toilet_description		:=	'';
	self.watercraft_number_of_engines		:=	'';
	self.watercraft_hp_1					:=	L.ENGINE_HP;
	self.watercraft_hp_2					:=	'';
	self.watercraft_hp_3					:=	'';
	self.engine_number_1					:=	L.ENGINE_NUM;
	self.engine_number_2					:=	'';
	self.engine_number_3					:=	'';
	self.engine_make_1						:=	L.ENGINE_MAKE;
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
	self.registration_expiration_date		:=	L.REG_EXPIRE;
	self.registration_status_code			:=	'';
	self.registration_status_description	:=	'';
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	L.RENEWAL_DATE;
	self.decal_number						:=	L.DECAL_NUMBER;
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



export Mapping_AL_as_Main := project(watercraft.file_AL_clean_in, main_mapping_format(left));

