import watercraft;


county_reg(string2 code)

:= case(code, 	
'1' => 'ADAMS',
'2' => 'BARNES',
'3' => 'BENSON',
'4' => 'BILLINGS',
'5' => 'BOTTINEAU',
'6' => 'BOWMAN',
'7' => 'BURKE',
'8' => 'BURLEIGH',
'9' => 'CASS',
'10' => 'CAVALIER',
'11' => 'DICKEY',
'12' => 'DIVIDE',
'13' => 'DUNN',
'14' => 'EDDY',
'15' => 'EMMONS',
'16' => 'FOSTER',
'17' => 'GOLDEN VALLEY',
'18' => 'GRAND FORKS',
'19' => 'GRANT',
'20' => 'GRIGGS',
'21' => 'HETTINGER',
'22' => 'KIDDER',
'23' => 'LAMOURE',
'24' => 'LOGAN',
'25' => 'MCHENRY',
'26' => 'MCINTOSH',
'27' => 'MCKENZIE',
'28' => 'MCLEAN',
'29' => 'MERCER',
'30' => 'MORTON',
'31' => 'MOUNTRAIL',
'32' => 'NELSON',
'33' => 'OLIVER',
'34' => 'PEMBINA',
'35' => 'PIERCE',
'36' => 'RAMSEY',
'37' => 'RANSOM',
'38' => 'RENVILLE',
'39' => 'RICHLAND',
'40' => 'ROLETTE',
'41' => 'SARGENT',
'42' => 'SHERIDAN',
'43' => 'SIOUX',
'44' => 'SLOPE',
'45' => 'STARK',
'46' => 'STEELE',
'47' => 'STUTSMAN',
'48' => 'TOWNER',
'49' => 'TRAILL',
'50' => 'WALSH',
'51' => 'WARD',
'52' => 'WELLS',
'53' => 'WILLIAMS',
'54' => 'COUNTY UNKNOWN','' );   


watercraft.Layout_Watercraft_Main_Base main_mapping_format(watercraft.file_ND_clean_in L) := transform


    self.watercraft_key						:=	if(trim(L.YEAR, left, right) >= '1972' and length(trim(L.HULL_ID, left, right)) = 12, trim(L.HULL_ID, left, right),
	                                            if(trim(L.HULL_ID, left, right) <> '' and trim(L.HULL_ID, left, right) <> '*', (trim(L.HULL_ID, left, right) 
												+ trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30], (trim(L.MAKE, left, right) + trim(L.YEAR, left, right) 
												+ trim(L.NAME, left, right))[1..30]));
	self.sequence_key						:=	trim(L.REG_DATE, left, right);
	self.watercraft_id						:=	'';
	self.state_origin						:=	'ND';
	self.source_code						:=	'AW';
	self.st_registration					:=	L.STATEDATA;
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
	self.registration_expiration_date		:=	L.EXPIRE_YEAR;
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



export Mapping_ND_as_Main := project(watercraft.file_ND_clean_in, main_mapping_format(left));


	

	



	



