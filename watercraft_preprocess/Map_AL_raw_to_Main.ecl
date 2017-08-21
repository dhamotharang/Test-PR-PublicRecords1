import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;

// translates al_update.mp Ab intio graph into ECL

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

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_AL_clean_in, Watercraft.Layout_AL_fixed, hull_clean_in)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := transform
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key				:= stringlib.StringFindReplace(IF(trim(L.year,left right) >= '72' and length(trim(L.HULL_ID,left,right)) = 12,trim(L.HULL_ID),
																// IF(L.REG_NUM<> '', trim(L.REG_NUM)+IF(trim(L.year,left,right)<>'0',trim(L.year,left,right),''),
																	// trim(state_origin) + trim(L.DECAL_NUMBER) + IF(trim(L.MAKE)<>'',trim(L.MAKE),''))),' ','');
	self.watercraft_key			:=	(trim(L.HULL_ID, left, right) + trim(L.DECAL_NUMBER, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30];
	self.sequence_key				:=	trim(L.REG_DATE);
	self.state_origin						:=	'AL';
	self.source_code						:=	'AW';
	self.st_registration				:=	L.STATEABREV;
	self.county_registration		:=	county_reg(trim(L.county,left,right));
	self.registration_number		:=	trim(L.REG_NUM, left, right);
	self.hull_number						:=	L.hull_id;
	self.propulsion_description	:=	L.PROP;
	self.vehicle_type_Code				:=	L.VEH_TYPE;
	self.vehicle_type_Description	:=	if(trim(L.VEH_TYPE, left, right) = 'PWC', 'PERSONAL WATERCRAFT', L.VEH_TYPE);
	self.fuel_description					:=	L.FUEL;
	self.hull_type_description		:=	L.HULL;
	self.use_description					:=	L.USE_1;
	self.watercraft_length				:=	L.TOTAL_INCH;
	self.model_year								:=	L.YEAR;
	self.watercraft_class_code					:=	L.BOAT_CLASS;
	self.watercraft_class_description		:=	watercraft_class_desc(L.BOAT_CLASS);
	self.watercraft_make_description		:=	L.MAKE;
	self.watercraft_hp_1					:=	L.ENGINE_HP;
	self.engine_number_1					:=	L.ENGINE_NUM;
	self.engine_make_1						:=	L.ENGINE_MAKE;
	is_valid_Regdate									:= STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date						:=	IF(is_valid_Regdate,L.REG_DATE,'');
	is_valid_Expiredate								:= STD.DATE.IsValidDate((integer)L.REG_EXPIRE);
	self.registration_expiration_date	:=	IF(is_valid_Expiredate,L.REG_EXPIRE,'');
	is_valid_Renewaldate							:= STD.DATE.IsValidDate((integer)L.RENEWAL_DATE);
	self.registration_renewal_date		:=	IF(is_valid_Renewaldate,L.RENEWAL_DATE,'');
	self.decal_number									:=	L.DECAL_NUMBER;
	self := L;
	self := [];
  end;


EXPORT Map_AL_raw_to_Main := project(hull_clean_in, main_mapping_format(left));