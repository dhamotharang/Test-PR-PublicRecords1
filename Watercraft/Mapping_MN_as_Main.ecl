import watercraft;


county_reg(string2 code)

:= case(code, 	
'01' => 'AITKIN',
'02' => 'ANOKA',
'03' => 'BECKER',
'04' => 'BELTRAMI',
'05' => 'BENTON',
'06' => 'BIG STONE',
'07' => 'BLUE EARTH',
'08' => 'BROWN',
'09' => 'CARLTON',
'10' => 'CARVER',
'11' => 'CASS',
'12' => 'CHIPPEWA',
'13' => 'CHISAGO',
'14' => 'CLAY',
'15' => 'CLEARWATER',
'16' => 'COOK',
'17' => 'COTTONWOOD',
'18' => 'CROW WING',
'19' => 'DAKOTA',
'20' => 'DODGE',
'21' => 'DOUGLAS',
'22' => 'FARIBAULT',
'23' => 'FILLMORE',
'24' => 'FREEBORN',
'25' => 'GOODHUE',
'26' => 'GRANT',
'27' => 'HENNEPIN',
'28' => 'HOUSTON',
'29' => 'HUBBARD',
'30' => 'ISANTI',
'31' => 'ITASCA',
'32' => 'JACKSON',
'33' => 'KANABEC',
'34' => 'KANDIYOHI',
'35' => 'KITTSON',
'36' => 'KOOCHCHING',
'37' => 'LAC QUI PARLE',
'38' => 'LAKE',
'39' => 'LAKE OF THE WOODS',
'40' => 'LE SUEUR',
'41' => 'LINCOLN',
'42' => 'LYON',
'43' => 'MAHNOMEN',
'44' => 'MARSHALL',
'45' => 'MARTIN',
'46' => 'MCLEOD',
'47' => 'MEEKER',
'48' => 'MILLE LACS',
'49' => 'MORRISON',
'50' => 'MOWER',
'51' => 'MURRAY',
'52' => 'NICOLLET',
'53' => 'NOBLES',
'54' => 'NORMAN',
'55' => 'OLMSTED',
'56' => 'OTTER TAIL',
'57' => 'PENNINGTON',
'58' => 'PINE',
'59' => 'PIPESTONE',
'60' => 'POLK',
'61' => 'POPE',
'62' => 'RAMSEY',
'63' => 'RED LAKE',
'64' => 'REDWOOD',
'65' => 'RENVILLE',
'66' => 'RICE',
'67' => 'ROCK',
'68' => 'ROSEAU',
'69' => 'ST LOUIS',
'70' => 'SCOTT',
'71' => 'SHERBURNE',
'72' => 'SIBLEY',
'73' => 'STEARNS',
'74' => 'STEELE',
'75' => 'STEVENS',
'76' => 'SWIFT',
'77' => 'TODD',
'78' => 'TRAVERSE',
'79' => 'WABASHA',
'80' => 'WADENA',
'81' => 'WASECA',
'82' => 'WASHINGTON',
'83' => 'WATONWAN',
'84' => 'WILKIN',
'85' => 'WINONA',
'86' => 'WRIGHT',
'87' => 'YELLOW MEDICINE','' );   


watercraft_toilet_desc(string1 code)

:= case(code,

'1' => 'BOAT HAS TOILET',
'2' => 'BOAT HAS NO TOILET',
'3' => 'USCG CERTIFIED','');



trans_type_desc(string1 code)

:= case(code, 
'A' => 'NEW REGISTRATION',
'B' => 'NEW TITLE',
'C' => 'RENEW TITLE',
'D' => 'RENEW',
'E' => 'TRANSFER',
'F' => 'REN/TRANSFER',
'G' => 'DUPLICATE', '');


watercraft_status_desc(string1 code)

:= case(code,

'0' => 'IN USE',
'1' => 'LOST',
'2' => 'STOLEN',
'3' => 'ABANDONED',
'4' => 'DESTROYED',
'5' => 'MOVED',
'6' => 'SOLD',
'7' => 'RETURNED CHECK',
'8' => 'CLEARED CHECK',
'9' => 'ANY OTHER', '');


title_status_desc(string1 code)

:= case(code,
'N' => 'TITLE EXISTS',
'Y' => 'NO TITLE', '');

dealer_desc(string1 code)

:= case(code,
'B' => 'DEALER/MANUFACTURER',
'N' => 'NOT A DEALER', '');

Watercraft.Macro_Clean_Hull_ID(watercraft.file_MN_clean_in, watercraft.Layout_MN_clean_in,hull_clean_in)

file_MN_dedup := dedup(sort(hull_clean_in, reg_date, reg_num), reg_date, reg_num);

Layout_MN_clean_temp := record

watercraft.Layout_MN_clean_in;
watercraft.Layout_MIC;

boolean is_hull_id;


boolean is_hull_id_in_MIC;
    	
end;

Layout_MN_clean_temp main_mapping_temp(file_MN_dedup L, watercraft.file_MIC R)

:= transform

self := L;
self := R;
self.is_hull_id := if(L.HULL_ID <> '' and trim(L.HULL_ID, left, right) <> 'UNKNOWN' and trim(L.HULL_ID, left, right) <> '************' 
                   and trim(L.HULL_ID, LEFT, RIGHT) <> '000000000000', true, false);
self.is_hull_id_in_MIC := if(trim(L.hull_id, left, right)[1..3] = R.MIC, true, false);

end;

Mapping_MN_as_Main_temp := join(file_MN_dedup, watercraft.file_MIC, trim(left.hull_id, left, right)[1..3] = right.MIC,
main_mapping_temp(left, right), left outer, lookup);




watercraft.Layout_Watercraft_Main_Base main_mapping_format(Mapping_MN_as_Main_temp L) := transform


    self.watercraft_key						:=	if(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left, right),
	                                            if(L.is_HULL_ID, (trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30],
												if(L.make = ''or trim(L.year, left, right) = '0', trim(L.REG_NUM, left, right), (trim(L.MAKE, left, right) + trim(L.YEAR, left, right) 
												+ trim(L.NAME, left, right))[1..30])));
	self.sequence_key						:=	trim(L.reg_date, left, right);
	self.watercraft_id						:=	'';
	self.state_origin						:=	'MN';
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
	self.model_year							:=	if(L.YEAR <> '0', L.YEAR, '');
	self.watercraft_name					:=	'';
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
	self.watercraft_toilet_code				:=	L.TOILET;
	self.watercraft_toilet_description		:=	watercraft_toilet_desc(L.TOILET);
	self.watercraft_number_of_engines		:=	'';
	self.watercraft_hp_1					:=	L.HP;
	self.watercraft_hp_2					:=	L.HP2;
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
	self.registration_expiration_date		:=	L.EXPDATE;
	self.registration_status_code			:=	'';
	self.registration_status_description	:=	'';
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	'';
	self.transaction_type_code				:=	L.TRANSTYPE;
	self.transaction_type_description		:=	TRANS_TYPE_DESC(L.TRANSTYPE);
	self.title_state						:=	'';
	self.title_status_code					:=  L.TITLE;
	self.title_status_description			:=	title_status_desc(L.TITLE);
	self.title_number						:=	L.TITLEID;
	self.title_issue_date					:=	L.TITLEDATE;
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
	self.dealer								:=	dealer_desc(L.DEALERIND);
	self.purchase_price						:=	'';
	self.new_used_flag						:=	'';
	self.watercraft_status_code				:=	L.STATUS;
	self.watercraft_status_description		:=	watercraft_status_desc(L.STATUS);
	self.history_flag						:=	'';
	self.coastguard_flag					:=	'';
    
  end;



export Mapping_MN_as_Main := project(Mapping_MN_as_Main_temp, main_mapping_format(left));

