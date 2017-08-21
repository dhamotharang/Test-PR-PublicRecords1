import watercraft;

county_reg(string2 code) := case(code,

'01' => 'ADAMS',
'02' => 'ALCORN',
'03' => 'AMITE',
'04' => 'ATTALA',
'05' => 'BENTON',
'06' => 'BOLIVAR',
'07' => 'CALHOUN',
'08' => 'CARROLL',
'09' => 'CHICKASAW',
'10' => 'CHOCTAW',
'11' => 'CLAIBORNE',
'12' => 'CLARKE',
'13' => 'CLAY',
'14' => 'COAHOMA',
'15' => 'COPIAH',
'16' => 'COVINGTON',
'17' => 'DE SOTO',
'18' => 'FORREST',
'19' => 'FRANKLIN',
'20' => 'GEORGE',
'21' => 'GREENE',
'22' => 'GRENADA',
'23' => 'HANCOCK',
'24' => 'HARRISON',
'25' => 'HINDS',
'26' => 'HOLMES',
'27' => 'HUMPHREYS',
'28' => 'ISSAQUENA',
'29' => 'ITAWAMBA',
'30' => 'JACKSON',
'31' => 'JASPER',
'32' => 'JEFFERSON',
'33' => 'JEFFERSON DAVIS',
'34' => 'JONES',
'35' => 'KEMPER',
'36' => 'LAFAYETTE',
'37' => 'LAMAR',
'38' => 'LAUDERDALE',
'39' => 'LAWRENCE',
'40' => 'LEAKE',
'41' => 'LEE',
'42' => 'LEFLORE',
'43' => 'LINCOLN',
'44' => 'LOWNDES',
'45' => 'MADISON',
'46' => 'MARION',
'47' => 'MARSHALL',
'48' => 'MONROE',
'49' => 'MONTGOMERY',
'50' => 'NESHOBA',
'51' => 'NEWTON',
'52' => 'NOXUBEE',
'53' => 'OKTIBBEHA',
'54' => 'PANOLA',
'55' => 'PEARL RIVER',
'56' => 'PERRY ',
'57' => 'PIKE',
'58' => 'PONTOTOC',
'59' => 'PRENTISS',
'60' => 'QUITMAN',
'61' => 'RANKIN',
'62' => 'SCOTT',
'63' => 'SHARKEY',
'64' => 'SIMPSON',
'65' => 'SMITH',
'66' => 'STONE',
'67' => 'SUNFLOWER',
'68' => 'TALLAHATCHIE',
'69' => 'TATE',
'70' => 'TIPPAH',
'71' => 'TISHOMINGO',
'72' => 'TUNICA',
'73' => 'UNION',
'74' => 'WALTHALL',
'75' => 'WARREN',
'76' => 'WASHINGTON',
'77' => 'WAYNE',
'78' => 'WEBSTER',
'79' => 'WILKINSON',
'80' => 'WINSTON',
'81' => 'YALOBUSHA',
'82' => 'YAZOO',
'83' => 'OUT OF STATE', '');

Watercraft.Macro_Clean_Hull_ID(watercraft.file_MS_clean_in, watercraft.Layout_MS_clean_in,hull_clean_in)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := transform


    self.watercraft_key						:=	if(trim(L.YEAR, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12, trim(L.HULL_ID, left, right), if(L.HULL_ID = '',
	                                            (trim(L.MAKE, left, right) + trim(L.YEAR, left, right) + trim(L.FIRST_NAME, left, right) + trim(L.MID, left, right)
												+ trim(L.LAST_NAME, left, right))[1..30], (trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30]));
	self.sequence_key						:=	L.TRANSACTION_DATE;
	self.watercraft_id						:=	'';
	self.state_origin						:=	'MS';
	self.source_code						:=	'AW';
	self.st_registration					:=	L.STATEABREV;
	self.county_registration				:=	trim(L.county,left,right);
	self.registration_number				:=	trim(L.REG_NUM, left, right);
	self.hull_number						:=	L.hull_id;
	self.propulsion_code					:=	'';
	self.propulsion_description				:=	L.PROP;
	self.vehicle_type_Code					:=	'';
	self.vehicle_type_Description			:=	map( L.VEH_TYPE = 'OTHER' and L.BOAT_TYPE_CODE <> '' => L.BOAT_TYPE_CODE,
	                                            L.VEH_TYPE <> '' =>  L.VEH_TYPE,L.BOAT_TYPE_CODE);
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
	self.registration_expiration_date		:=	L.EXPIRATION_DATE;
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
	self.purchase_date						:=	'';
	self.dealer								:=	'';
	self.purchase_price						:=	'';
	self.new_used_flag						:=	'';
	self.watercraft_status_code				:=	'';
	self.watercraft_status_description		:=	L.STATUS;
	self.history_flag						:=	'';
	self.coastguard_flag					:=	'';
  
  end;



export Mapping_MS_as_Main := project(hull_clean_in, main_mapping_format(left));

		



	















































