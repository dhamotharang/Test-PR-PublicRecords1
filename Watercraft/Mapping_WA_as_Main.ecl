import lib_stringlib, watercraft,watercraft_preprocess;

county_reg(string2 code) := case(code,

'1' => 'ADAMS',
'2' => 'ASOTIN',
'3' => 'BENTON',
'4' => 'CHELAN',
'5' => 'CLALLAM',
'6' => 'CLARK',
'7' => 'COLUMBIA',
'8' => 'COWLITZ',
'9' => 'DOUGLAS',
'10' => 'FERRY',
'11' => 'FRANKLIN',
'12' => 'GARFIELD',
'13' => 'GRANT',
'14' => 'GRAYS HARBOR',
'15' => 'ISLAND',
'16' => 'JEFFERSON',
'17' => 'KING',
'18' => 'KITSAP',
'19' => 'KITTITAS',
'20' => 'KLICKITAT',
'21' => 'LEWIS',
'22' => 'LINCOLN',
'23' => 'MASON',
'24' => 'OKANOGAN',
'25' => 'PACIFIC',
'26' => 'PEND ORIELLE',
'27' => 'PIERCE',
'28' => 'SAN JUAN',
'29' => 'SKAGIT',
'30' => 'SKAMANIA',
'31' => 'SNOHOMISH',
'32' => 'SPOKANE',
'33' => 'STEVENS',
'34' => 'THURSTON',
'35' => 'WAHKIAKUM',
'36' => 'WALLA WALLA',
'37' => 'WHATCOM',
'38' => 'WHITMAN',
'39' => 'YAKIMA',
'40' => 'DOL/COUNTY 40',
'71' => 'DOL/MORTON',
'77' => 'DOL/PARKLAND' , '');

FUEL_desc(string fuel) 	:= case(fuel,
'D'	=> 'DIESEL',
'E'	=> 'ELECTRIC',
'G'	=> 'GAS',
'P'	=> 'PROPANE',
'S'	=> 'SAIL',
'X'	=> 'UNKNOWN', fuel);
	
HULL_desc(string hull)  	:= case(hull,
'A'	=> 'ALUMINUM',
'C'	=> 'CONCRETE',
'P'	=> 'PLASTIC',
'R'	=> 'RUBBER',
'S'	=> 'STEEL',
'W'	=> 'WOOD',
'X'=> 'UNKNOWN', hull);

PROP_desc(string prop) := case(prop,	
'D'	=> 'STERN',
'I'	=> 'INBOARD',
'J'	=> 'JET',
'O'	=> 'OUTBOARD',
'S'	=> 'SAIL',
'X'	=> 'OTHER',prop); 

USE_desc(string use) := case(use, 		
'C'	=> 'COMMERCIAL - PASSENGER'	,
'D'	=> 'DEALER'	,
'F'	=> 'COMMERCIAL - FISH'	,
'L'	=> 'RENTAL'	,
'M'	=> 'MANUFACTURER'	,
'P'	=> 'PLEASURE'	,
'X'	=> 'UNKNOWN',use); 

VEH_TYPE	(string VEH_TYPE ) := case(VEH_TYPE, 
'C'	=> 'CABIN',
'H'	=> 'HOUSEBOAT',
'J'	=> 'PWC',
'R'	=> 'RUNABOUT',
'S'	=> 'SAILBOAT',
'X'	=> 'OTHER',VEH_TYPE); 


Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.Map_WA_Update, watercraft.Layout_WA_clean_in,hull_clean_in)

watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.Layout_WA_clean_in, wDatasetwithflag)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := transform


    self.watercraft_key				        :=	if(length(trim(L.HULL_ID, left, right)) = 12 and trim(L.year, left, right) >= '1972' and L.is_hull_id_in_MIC, trim(L.HULL_ID, left, right),
										        (trim(L.HULL_ID,left, right) + trim(StringLib.stringfilterout(L.MAKE,' '),left, right) + trim(L.YEAR, left, right) + trim(StringLib.stringfilterout(L.NAME,'  ,-/'), left, right))[1..30]);                               
	self.sequence_key				        :=	trim(L.REG_DATE, left, right);
	self.watercraft_id						:=	'';
	self.state_origin						:=	'WA';
	self.source_code						:=	'AW';
	self.st_registration					:=	L.STATEABREV;
	self.county_registration				:=	county_reg(trim(L.County_of_Moorage,left,right));
	self.registration_number				:=	trim(L.REG_NUM, left, right);
	self.hull_number						:=	L.hull_id;
	self.propulsion_code					:=	'';
	self.propulsion_description				:=	PROP_desc(trim(L.PROP,left,right));
	self.vehicle_type_Code					:=	'';
	self.vehicle_type_Description			:=	VEH_TYPE(trim(L.VEH_TYPE,left,right));
	self.fuel_code							:=	'';
	self.fuel_description					:=	FUEL_desc(trim(L.FUEL,left,right));
	self.hull_type_code						:=	'';
	self.hull_type_description				:=	HULL_desc(trim(L.HULL,left,right));
	self.use_code							:=	'';
	self.use_description					:=	USE_desc(trim(L.USE,left,right));
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
	self.coast_guard_number					:=	'';
	self.registration_date					:=	L.REG_DATE;
	self.registration_expiration_date		:=	L.expiration_date;
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
	self.purchase_date						:=	l.purchase_year;
	self.dealer								:=	l.dealer_number; // code
	self.purchase_price						:=	l.purchase_cost;
	self.new_used_flag						:=	'';
	self.watercraft_status_code				:=	'';
	self.watercraft_status_description		:=	'';
	self.history_flag						:=	'';
	self.coastguard_flag					:=	'';
  
  end;



export Mapping_WA_as_Main := project(wDatasetwithflag, main_mapping_format(left));