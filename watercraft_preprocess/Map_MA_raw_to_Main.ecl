import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;

// translates ma_phase01.mp Ab intio graph into ECL

watercraft_color_desc(string3 code)
:= case(code, 	
'AQU' => 'AQUA',
'BLA' => 'BLACK',
'BLU' => 'BLUE',
'BRO' => 'BROWN',
'GOL' => 'GOLD',
'GRA' => 'GRAY',
'GRE' => 'GREEN',
'MAR' => 'MAROON',
'NO' => 'NO COLOR',
'ORA' => 'ORANGE',
'OTH' => 'OTHER',
'PIN' => 'PINK',
'PUR' => 'PURPLE',
'RED' => 'RED',
'WHI' => 'WHITE',
'YEL' => 'YELLOW',
'' );   

searchpattern := '^(.*)-(.*)$';

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_MA_clean_in, Watercraft.Layout_MA_new, hull_clean_in)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := transform
	// New watercraft_key logic to be implemented at a later date
	// self.watercraft_key	:=	stringlib.StringFindReplace(IF(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, trim(L.HULL_ID,left,right),
																												// IF(L.HULL_ID = '', trim(L.REG_NUM,left,right) + IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																													// (trim(L.HULL_ID,left,right) + IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30])),' ','');                                        
	self.watercraft_key			:=	if(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, trim(L.HULL_ID,left,right),
	                               (trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30]);
	self.sequence_key				:=	trim(L.REG_DATE,left,right);
	self.state_origin				:=	'MA';
	self.source_code				:=	'AW';
	self.st_registration		:=	L.STATEABREV;
	self.county_registration	:=	L.county;
	self.registration_number	:=	trim(L.REG_NUM,left,right);
	self.hull_number					:=	L.hull_id;
	self.propulsion_description		:=	L.PROP;
	self.vehicle_type_Description	:=	L.VEH_TYPE;
	self.fuel_description					:=	L.FUEL;
	self.hull_type_description		:=	L.HULL;
	self.use_description					:=	L.USE_1;
	self.watercraft_length				:=	L.TOTAL_INCH;
	self.model_year								:=	L.YEAR;
	self.watercraft_class_code				:= trim(if(REGEXFIND(searchpattern, L.description)= true, regexreplace('BOAT REGISTRATION CLASS', REGEXFIND(searchpattern, L.description, 1) , ' '), ' '), left, right) ;
	self.watercraft_class_description	:= trim(REGEXFIND(searchpattern, L.description, 2), left, right);
	self.watercraft_make_description		:=	L.MAKE;
	self.watercraft_color_1_code			:=	L.COLOR_TYP_CODE_PRIMARY;
	self.watercraft_color_1_description		:=	watercraft_color_desc(L.COLOR_TYP_CODE_PRIMARY);
	self.watercraft_color_2_code			:=	L.COLOR_TYP_CODE_SECONDARY;
	self.watercraft_color_2_description		:=	watercraft_color_desc(L.COLOR_TYP_CODE_SECONDARY);
	self.watercraft_toilet_description		:=	L.PCTL_TYP_CODE;
	self.watercraft_hp_1					:=	if(L.HORSEPOWER = '0','',L.HORSEPOWER);
	self.engine_number_1					:=	map(length(TRIM(L.SERIAL_NUMBER,LEFT,RIGHT))=1 => '',
																				REGEXFIND('UNK |UNKNOWN |N\\A|NA |NULL|NONE ',L.SERIAL_NUMBER) => REGEXREPLACE('UNK |UNKNOWN |N\\A|NA |NULL|NONE ',L.SERIAL_NUMBER,''),
																				L.SERIAL_NUMBER);
	self.engine_make_1						:=	REGEXREPLACE('^,|\\|',L.ENG_MN_TYP_CODE,'');
	self.engine_year_1						:=	L.ENG_YEAR;
	IsValidRegDate											:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date							:=	If(IsValidRegDate,L.REG_DATE,'');
	IsValidExpireDate										:=	STD.DATE.IsValidDate((integer)L.EXPIRATION_DATE);
	self.registration_expiration_date		:=	If(IsValidExpireDate,L.EXPIRATION_DATE,'');
	self.registration_status_description	:=	L.STATUS;
	self := L;
	self := [];
  end;

EXPORT Map_MA_raw_to_Main := project(hull_clean_in, main_mapping_format(left));