IMPORT watercraft, watercraft_preprocess, ut, STD;

// translates  ct_phase01.mp Ab intio graph into ECL

watercraft_citizen_desc(string1 code)
:= case(code,
'N' => 'NO (NON-CITIZEN)',
'Y' => 'YES (CITIZEN)',
'');

watercraft_color_desc(string3 code)
:= case(code,
'BLK' => 'BLACK',
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
'');   

reg_status_desc(string1 code)
:= case(code,
'A' => 'ACTIVE',
'B' => 'INACTIVE', '');

sanitation_desc(string1 code)
:= case(code, '1' => 'TYPE I',
'2' => 'TYPE II',
'3' => 'TYPE III',
'4' => 'TYPE I + III',
'5' => 'TYPE II + III',
'6' => 'PORTABLE TOILET',
'7' => 'NONE',
'');

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_CT_clean_in, Watercraft.layout_CT_2015Q3,hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, Watercraft.layout_CT_2015Q3,wDatasetwithflag)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := transform
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	stringlib.StringFindReplace(if(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) >= '1972' and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
	                               // if(trim(L.HULL_ID,left,right) = '' or length(trim(L.HULL_ID,left,right)) < 12, trim(L.REG_NUM,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																		// (trim(L.HULL_ID,left,right) + trim(L.YEAR,left,right))[1..30])),' ','');
	self.watercraft_key			:=	IF(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) >= '1972' and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
	                                IF(stringlib.stringfind(L.HULL_ID, 'UNKNOWN', 1) = 0, (trim(L.HULL_ID,left,right) + trim(regexreplace('UNKNOWN', L.MAKE, ''),left,right) + trim(L.YEAR, left,right))[1..30],
																		(trim(regexreplace('UNKNOWN', L.HULL_ID, ''),left,right) + trim(regexreplace('UNKNOWN', L.MAKE, ''),left,right) + trim(L.YEAR,left,right) + trim(L.NAME,left,right))[1..30]));     
	self.sequence_key				:=	trim(L.REG_DATE,left,right);
	self.state_origin				:=	'CT';
	self.source_code				:=	'AW';
	self.st_registration				:=	L.STATEABREV;
	self.county_registration		:=	L.county;
	self.registration_number		:=	trim(L.REG_NUM, left, right);
	self.hull_number						:=	L.hull_id;
	self.propulsion_description		:=	L.PROP;
	self.vehicle_type_Description	:=	L.VEH_TYPE;
	self.fuel_description					:=	L.FUEL;
	self.hull_type_description		:=	L.HULL;
	self.use_description					:=	L.USE_1;
	self.watercraft_length				:=	L.TOTAL_INCH;
	self.model_year								:=	L.YEAR;
	self.watercraft_make_description	:=	L.MAKE;
	self.watercraft_model_description	:=	L.MODEL;
	self.watercraft_color_1_code			:=	'';
	self.watercraft_color_1_description		:=	STD.Str.FindReplace(TRIM(L.PRIMARY_COLOR,left,right),'UNKNOWN','');
	self.watercraft_color_2_code					:=	'';
	self.watercraft_color_2_description		:=	STD.Str.FindReplace(TRIM(L.SECONDARY_COLOR,left,right),'UNKNOWN','');
	self.watercraft_toilet_code						:=	L.SANITATION;
	self.watercraft_toilet_description		:=	sanitation_desc(L.SANITATION);
	self.watercraft_hp_1								:=	L.HP;
	self.coast_guard_number							:=	L.VESSEL_NUM;
	IsValidRegDate											:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date							:=	IF(IsValidRegDate,L.REG_DATE,'');
	IsValidExpireDate										:=	STD.DATE.IsValidDate((integer)L.EXPIRATION);
	self.registration_expiration_date		:=	IF(IsValidExpireDate,L.EXPIRATION,'');
	self.registration_status_code				:=	L.STATUS;
	self.registration_status_description	:=	reg_status_desc(L.STATUS);
	self.title_number										:=	L.TITLE_NUM;
	self.lien_1_name										:=	ut.CleanSpacesAndUpper(L.LIENHOLDER1_FIRSTNAME+' '+L.LIENHOLDER1_MIDDLENAME+' '+
																																L.LIENHOLDER1_LASTNAME+' '+L.LIENHOLDER1_SUFFIX);
	self.lien_1_address_1							:=	TRIM(L.LIENHOLDER1_ADDRESS1,left,right);
	self.lien_1_address_2							:=	TRIM(L.LIENHOLDER1_ADDRESS2,left,right);
	self.lien_1_city									:=	TRIM(L.LIENHOLDER1_CITY,left,right);
	self.lien_1_state									:=	TRIM(L.LIENHOLDER1_STATE,left,right);
	self.lien_1_zip										:=	TRIM(L.LIENHOLDER1_ZIP,left,right);
	self.lien_2_name									:=	ut.CleanSpacesAndUpper(L.LIENHOLDER1_ORG_NAME);
	self.dealer												:=	L.DEALER_NUM;
	self.purchase_price								:=	L.SALES_PRICE;
  self	:= L;
	self	:= [];
  end;

EXPORT Map_CT_raw_to_Main := project(wDatasetwithflag, main_mapping_format(left));