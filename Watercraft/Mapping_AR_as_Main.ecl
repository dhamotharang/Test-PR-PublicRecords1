import watercraft;


county_reg(string2 code)

:= case(code, 	'1' => 'ARKANSAS',
'2' => 'ASHLEY',
'3' => 'BAXTER',
'4' => 'BENTON',
'5' => 'BOONE',
'6' => 'BRADLEY',
'7' => 'CALHOUN',
'8' => 'CARROLL',
'9' => 'CHICOT',
'10' => 'CLARK',
'11' => 'CLAY',
'12' => 'CLEBURNE',
'13' => 'CLEVELAND',
'14' => 'COLUMBIA',
'15' => 'CONWAY',
'16' => 'CRAIGHEAD',
'17' => 'CRAWFORD',
'18' => 'CRITTENDEN',
'19' => 'CROSS',
'20' => 'DALLAS',
'21' => 'DESHA',
'22' => 'DREW',
'23' => 'FAULKNER',
'24' => 'FRANKLIN',
'25' => 'FULTON',
'26' => 'GARLAND',
'27' => 'GRANT',
'28' => 'GREENE',
'29' => 'HEMPSTEAD',
'30' => 'HOT SPRING',
'31' => 'HOWARD',
'32' => 'INDEPENDENCE',
'33' => 'IZARD',
'34' => 'JACKSON',
'35' => 'JEFFERSON',
'36' => 'JOHNSON',
'37' => 'LAFAYETTE',
'38' => 'LAWRENCE',
'39' => 'LEE',
'40' => 'LINCOLN',
'41' => 'LITTLE RIVER',
'42' => 'LOGAN',
'43' => 'LONOKE',
'44' => 'MADISON',
'45' => 'MARION',
'46' => 'MILLER',
'47' => 'MISSISSIPPI',
'48' => 'MONROE',
'49' => 'MONTGOMERY',
'50' => 'NEVADA',
'51' => 'NEWTON',
'52' => 'OUACHITA',
'53' => 'PERRY',
'54' => 'PHILLIPS',
'55' => 'PIKE',
'56' => 'POINSETT',
'57' => 'POLK',
'58' => 'POPE',
'59' => 'PRAIRIE',
'60' => 'PULASKI',
'61' => 'RANDOLPH',
'62' => 'ST. FRANCIS',
'63' => 'SALINE',
'64' => 'SCOTT',
'65' => 'SEARCY',
'66' => 'SEBASTIAN',
'67' => 'SEVIER',
'68' => 'SHARP',
'69' => 'STONE',
'70' => 'UNION',
'71' => 'VAN BUREN',
'72' => 'WASHINGTON',
'73' => 'WHITE',
'74' => 'WOODRUFF',
'75' => 'YELL','' );   



watercraft.Layout_Watercraft_Main_Base main_mapping_format(watercraft.file_AR_clean_in L) := transform


    self.watercraft_key						:=	(trim(L.HULL_ID, left, right) + trim(L.MAKE,left, right) + trim(L.YEAR, left, right))[1..30];                                          
	self.sequence_key						:=	trim(L.REG_DATE, left, right);
	self.watercraft_id						:=	'';
	self.state_origin						:=	'AR';
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
	self.watercraft_length					:=	trim(L.TOTAL_INCH, left, right);
	self.model_year							:=	L.YEAR;
	self.watercraft_name					:=	'';
	self.watercraft_class_code				:=	'';
	self.watercraft_class_description		:=	trim(L.CONVLENGTH, left, right);
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
	self.watercraft_hp_1					:=	L.HP;
	self.watercraft_hp_2					:=	'';
	self.watercraft_hp_3					:=	'';
	self.engine_number_1					:=	L.SERIAL;
	self.engine_number_2					:=	'';
	self.engine_number_3					:=	'';
	self.engine_make_1						:=	L.MOTOR;
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



export Mapping_AR_as_Main := project(watercraft.file_AR_clean_in, main_mapping_format(left));


	


	
