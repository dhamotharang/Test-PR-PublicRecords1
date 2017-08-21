import watercraft;


county_reg(string1 code) :=

case(code, 

'01' => 'ADAMS',
'02' => 'ASHLAND',
'03' => 'BARRON',
'04' => 'BAYFIELD',
'05' => 'BROWN',
'06' => 'BUFFALO',
'07' => 'BURNETT',
'08' => 'CALUMET',
'09' => 'CHIPPEWA',
'10' => 'CLARK',
'11' => 'COLUMBIA',
'12' => 'CRAWFORD',
'13' => 'DANE',
'14' => 'DODGE',
'15' => 'DOOR',
'16' => 'DOUGLAS',
'17' => 'DUNN',
'18' => 'EAU CLAIRE',
'19' => 'FLORENCE',
'20' => 'FOND DU LAC',
'21' => 'FOREST',
'22' => 'GRANT',
'23' => 'GREEN',
'24' => 'GREEN LAKE',
'25' => 'IOWA',
'26' => 'IRON',
'27' => 'JACKSON',
'28' => 'JEFFERSON',
'29' => 'JUNEAU',
'30' => 'KENOSHA',
'31' => 'KEWAUNEE',
'32' => 'LA CROSSE',
'33' => 'LAFAYETTE',
'34' => 'LANGLADE',
'35' => 'LINCOLN',
'36' => 'MANITOWOC',
'37' => 'MARATHON',
'38' => 'MARINETTE',
'39' => 'MARQUETTE',
'40' => 'MENOMINEE',
'41' => 'MILWAUKEE',
'42' => 'MONROE',
'43' => 'OCONTO',
'44' => 'ONEIDA',
'45' => 'OUTAGAMIE',
'46' => 'OZAUKEE',
'47' => 'PEPIN',
'48' => 'PIERCE',
'49' => 'POLK',
'50' => 'PORTAGE',
'51' => 'PRICE',
'52' => 'RACINE',
'53' => 'RICHLAND',
'54' => 'ROCK',
'55' => 'RUSK',
'56' => 'ST CROIX',
'57' => 'SAUK',
'58' => 'SAWYER',
'59' => 'SHAWANO',
'60' => 'SHEBOYGAN',
'61' => 'TAYLOR',
'62' => 'TREMPEALEAU',
'63' => 'VERNON',
'64' => 'VILAS',
'65' => 'WALWORTH',
'66' => 'WASHBURN',
'67' => 'WASHINGTON',
'68' => 'WAUKESHA',
'69' => 'WAUPACA',
'70' => 'WAUSHARA',
'71' => 'WINNEBAGO',
'72' => 'WOOD', '');


reg_status_desc(string1 code) :=

case(code, 'A' => 'ACTIVE',
'B' => 'ABANDONED',
'D' => 'DOUBLE REGISTRATION',
'E' => 'EXPIRED',
'I' => 'INACTIVE',
'J' => 'JUNKED',
'M' => 'MOVED OUT-OF-STATE (MOS)',
'P' => 'PENDING',
'S' => 'SOLD', '');

propulsion_desc(string1 code) :=

case(code, '1' => 'OUTBOARD',
'2' => 'INBOARD',
'3' => 'INBOARD/STERNDRIVE',
'4' => 'AIRBOAT', '');


Watercraft.Macro_Clean_Hull_ID(watercraft.file_WI_clean_in, watercraft.Layout_WI_clean_in,hull_clean_in)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := transform


    self.watercraft_key						:=	trim(L.reg_num, left, right);
	self.sequence_key						:=	if(trim(L.reg_date, left, right)<>'',L.reg_DATE,L.LAST_TRANSACTION_DATE);
	self.watercraft_id						:=	'';
	self.state_origin						:=	'WI';
	self.source_code						:=	'AW';
	self.st_registration					:=	trim(L.STATEABREV, left, right);
	self.county_registration				:=	county_reg(L.COUNTY);
	self.registration_number				:=	trim(L.REG_NUM, left, right);
	self.hull_number						:=	L.hull_id;
	self.propulsion_code					:=	'';
	self.propulsion_description				:=	if(trim(L.ENGINE_TYPE) <> '',propulsion_desc(L.ENGINE_TYPE), L.PROP);
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
	self.watercraft_name					:=	L.BOATNAME;
	self.watercraft_class_code				:=	'';
	self.watercraft_class_description		:=	'';
	self.watercraft_make_code				:=	'';
	self.watercraft_make_description		:=	L.MAKE;
	self.watercraft_model_code				:=	'';
	self.watercraft_model_description		:=	L.MODEL;
	self.watercraft_width					:=	'';
	self.watercraft_weight					:=	'';
	self.watercraft_color_1_code			:=	'';
	self.watercraft_color_1_description		:=	'';
	self.watercraft_color_2_code			:=	'';
	self.watercraft_color_2_description		:=	'';
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
	self.engine_make_3						:=	'';
	self.engine_model_1						:=	'';
	self.engine_model_2						:=	'';
	self.engine_model_3						:=	'';
	self.engine_year_1						:=	'';
	self.engine_year_2						:=	'';
	self.engine_year_3						:=	'';
	self.coast_guard_documented_flag		:=	'';
	self.coast_guard_number					:=	L.CGID;
	self.registration_date					:=	L.REG_DATE;
	self.registration_expiration_date		:=	L.EXPIRE_YEAR;
	self.registration_status_code			:=	L.REG_STATUS;
	self.registration_status_description	:=	reg_status_desc(L.REG_STATUS);
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
	self.purchase_date						:=	L.PUR_DATE;
	self.dealer								:=	'';
	self.purchase_price						:=	'';
	self.new_used_flag						:=	'';
	self.watercraft_status_code				:=	'';
	self.watercraft_status_description		:=	'';
	self.history_flag						:=	'';
	self.coastguard_flag					:=	'Y';
  
  end;



export Mapping_WI_as_Main := project(hull_clean_in, main_mapping_format(left));


	

	


	

	

















































