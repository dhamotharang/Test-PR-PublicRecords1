import watercraft;

county_reg(string2 code) := case(code,

'01' => 'DOUGLAS',
'02' => 'LANCASTER',
'03' => 'GAGE',
'04' => 'CUSTER',
'05' => 'DODGE',
'06' => 'SAUNDERS',
'07' => 'MADISON',
'08' => 'HALL',
'09' => 'BUFFALO',
'10' => 'PLATTE',
'11' => 'OTOE',
'12' => 'KNOX',
'13' => 'CEDAR',
'14' => 'ADAMS',
'15' => 'LINCOLN',
'16' => 'SEWARD',
'17' => 'YORK',
'18' => 'DAWSON',
'19' => 'RICHARDSON',
'20' => 'CASS',
'21' => 'SCOTTS BLUFF',
'22' => 'SALINE',
'23' => 'BOONE',
'24' => 'CUMING',
'25' => 'BUTLER',
'26' => 'ANTELOPE',
'27' => 'WAYNE',
'28' => 'HAMILTON',
'29' => 'WASHINGTON',
'30' => 'CLAY',
'31' => 'BURT',
'32' => 'THAYER',
'33' => 'JEFFERSON',
'34' => 'FILLMORE',
'35' => 'DIXON',
'36' => 'HOLT',
'37' => 'PHELPS',
'38' => 'FURNAS',
'39' => 'CHEYENNE',
'40' => 'PIERCE',
'41' => 'POLK',
'42' => 'NUCKOLLS',
'43' => 'COLFAX',
'44' => 'NEMAHA',
'45' => 'WEBSTER',
'46' => 'MERRICK',
'47' => 'VALLEY',
'48' => 'RED WILLOW',
'49' => 'HOWARD',
'50' => 'FRANKLIN',
'51' => 'HARLAN',
'52' => 'KEARNEY',
'53' => 'STANTON',
'54' => 'PAWNEE',
'55' => 'THURSTON',
'56' => 'SHERMAN',
'57' => 'JOHNSON',
'58' => 'NANCE',
'59' => 'SARPY',
'60' => 'FRONTIER',
'61' => 'SHERIDAN',
'62' => 'GREELEY',
'63' => 'BOYD',
'64' => 'MORRILL',
'65' => 'BOX BUTTE',
'66' => 'CHERRY',
'67' => 'HITCHCOCK',
'68' => 'KEITH',
'69' => 'DAWES',
'70' => 'DAKOTA',
'71' => 'KIMBALL',
'72' => 'CHASE',
'73' => 'GOSPER',
'74' => 'PERKINS',
'75' => 'BROWN',
'76' => 'DUNDY',
'77' => 'GARDEN',
'78' => 'DEUEL',
'79' => 'HAYES',
'80' => 'SIOUX',
'81' => 'ROCK',
'82' => 'KEYA PAHA',
'83' => 'GARFIELD',
'84' => 'WHEELER',
'85' => 'BANNER',
'86' => 'BLAINE',
'87' => 'LOGAN',
'88' => 'LOUP',
'89' => 'THOMAS',
'90' => 'MCPHERSON',
'91' => 'ARTHUR',
'92' => 'GRANT',
'93' => 'HOOKER', '');



watercraft_color_desc(string3 code)
:= case(code, 		  
'AME' => 'AMETHYST',
'BGE' => 'BEIGE',
'BLK' => 'BLACK',
'BLU' => 'BLUE',
'BRO' => 'BROWN',
'BRZ' => 'BRONZE',
'CAM' => 'CAMOUFLAGE',
'COL' => 'COLORED (USE WITH MUL)',
'COM' => 'CHROME (STAINLESS STEEL)',
'CPR' => 'COPPER',
'CRM' => 'CREAM',
'DBL' => 'DARK BLUE',
'DGR' => 'DARK GREEN',
'GLD' => 'GOLD',
'GRN' => 'GREEN',
'GRY' => 'GRAY',
'LAV' => 'LAVENDER',
'LBL' => 'LIGHT BLUE',
'LGR' => 'LIGHT GREEN',
'MAR' => 'MAROON',
'MUL' => 'MULTICOLORED',
'MVE' => 'MAUVE',
'ONG' => 'ORANGE',
'PLE' => 'PURPLE',
'PNK' => 'PINK',
'RED' => 'RED',
'SIL' => 'SILVER/ALUMINUM',
'SCN' => '',
'TAN' => 'TAN',
'TPE' => 'TAUPE',
'TRQ' => 'TURQUOISE',
'UNK' => 'UNKNOWN',
'YEL' => 'YELLOW', 
'WHI' => 'WHITE', '');

//need to add 'SCN'later
		  
file_NE_dedup := dedup(sort(watercraft.file_NE_clean_in, reg_date, reg_num), reg_date, reg_num);		  

Watercraft.Macro_Clean_Hull_ID(file_NE_dedup, watercraft.Layout_NE_clean_in,hull_clean_in)

Layout_NE_clean_temp := record

watercraft.Layout_NE_clean_in;
watercraft.Layout_MIC;

boolean is_hull_id_in_MIC;
    	
end;

Layout_NE_clean_temp main_mapping_temp(hull_clean_in L, watercraft.file_MIC R)

:= transform

self := L;
self := R;
self.is_hull_id_in_MIC := if(trim(L.hull_id, left, right)[1..3] = R.MIC, true, false);

end;

Mapping_NE_as_Main_temp := join(hull_clean_in, watercraft.file_MIC, trim(left.hull_id, left, right)[1..3] = right.MIC,
main_mapping_temp(left, right), left outer, lookup);



watercraft.Layout_Watercraft_Main_Base main_mapping_format(Mapping_NE_as_Main_temp L) := transform


    self.watercraft_key						:=	if(trim(L.YEAR, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, 
	                                            trim(L.HULL_ID, left, right), if(L.HULL_ID = '',
	                                            (trim(L.MAKE, left, right) + trim(L.YEAR, left, right) + trim(L.NAME, left, right))[1..30], (trim(L.HULL_ID, left, right) + 
												trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30]));
	self.sequence_key						:=	L.REG_DATE;
	self.watercraft_id						:=	'';
	self.state_origin						:=	'NE';
	self.source_code						:=	'AW';
	self.st_registration					:=	L.STATEABREV;
	self.county_registration				:=	county_reg(trim(L.county,left,right));
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
	self.watercraft_color_1_code			:=	L.COLOR;
	self.watercraft_color_1_description		:=	watercraft_color_desc(L.COLOR);
	self.watercraft_color_2_code			:=	L.Secondary_Color;
	self.watercraft_color_2_description		:=	watercraft_color_desc(L.Secondary_Color);
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
	self.registration_expiration_date		:=	'';
	self.registration_status_code			:=	'';
	self.registration_status_description	:=	'';
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	'';
	self.transaction_type_code				:=	'';
	self.transaction_type_description		:=	'';
	self.title_state						:=	L.TITLE_STATE;
	self.title_status_code					:=	'';
	self.title_status_description			:=	'';
	self.title_number						:=	L.Title_Number;
	self.title_issue_date					:=	L.Title_Date;
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



export Mapping_NE_as_Main := project(Mapping_NE_as_Main_temp, main_mapping_format(left));










