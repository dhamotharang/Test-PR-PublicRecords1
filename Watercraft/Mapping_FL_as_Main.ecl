import watercraft;

county_reg(string2 code) := case(code, 	
'1'=>'Dade',
'2'=>'Duval',
'3'=>'Hillsborough',
'4'=>'Pinellas',
'5'=>'Polk',
'6'=>'PalmBeach',
'7'=>'Orange',
'8'=>'Volusia',
'9'=>'Escambia',
'10'=>'Broward',
'11'=>'Alachua',
'12'=>'Lake',
'13'=>'Leon',
'14'=>'Marion',
'15'=>'Manatee',
'16'=>'Sarasota',
'17'=>'Seminole',
'18'=>'Lee',
'19'=>'Brevard',
'20'=>'St.Johns',
'21'=>'Gadsden',
'22'=>'Putnam',
'23'=>'Bay',
'24'=>'St.Lucie',
'25'=>'Jackson',
'26'=>'Osceola',
'27'=>'Highlands',
'28'=>'Pasco',
'29'=>'Columbia',
'30'=>'Hardee',
'31'=>'Suwanee',
'32'=>'IndianRiver',
'33'=>'SantaRosa',
'34'=>'DeSoto',
'35'=>'Madison',
'36'=>'Walton',
'37'=>'Taylor',
'38'=>'Monroe',
'39'=>'Levy',
'40'=>'Hernando',
'41'=>'Nassau',
'42'=>'Martin',
'43'=>'Okaloosa',
'44'=>'Sumpter',
'45'=>'Bradford',
'46'=>'Jefferson',
'47'=>'Citrus',
'48'=>'Clay',
'49'=>'Hendry',
'50'=>'Washington',
'51'=>'Holmes',
'52'=>'Baker',
'53'=>'Charlotte',
'54'=>'Dixie',
'55'=>'Gilchrist',
'56'=>'Hamilton',
'57'=>'Okeechobee',
'58'=>'Calhoun',
'59'=>'Franklin',
'60'=>'Glades',
'61'=>'Flagler',
'62'=>'Lafayette',
'63'=>'Union',
'64'=>'Collier',
'65'=>'Wakulla',
'66'=>'Gulf',
'67'=>'Liberty',
'68'=>'DMV',
'90'=>'Duplicate', '' ); 


watercraft_color_desc(string3 code) := case(code, 	
'BGE'  => 'BEIGE',
'BLK'  => 'BLACK',
'BLU'  => 'BLUE',
'BRO'  => 'BROWN',
'BRZ'  => 'BRONZE',
'CAM'  => 'CAMOFLAGE',
'COM'  => 'COMBINATION',
'CPR'  => 'COPPER',
'CRM'  => 'CREAM',
'DBL'  => 'DARK BLUE',
'DGR'  => 'DARK GREEN',
'GLD'  => 'GOLD',
'GRN'  => 'GREEN',
'GRY'  => 'GRAY',
'LAV'  => 'LAVENDER',
'LBL'  => 'LIGHT BLUE',
'LGR'  => 'LIGHT GREEN',
'MAR'  => 'MAROON',
'MUL'  => 'MULBERRY',
'ONG'  => 'ORANGE',
'PLE'  => 'PURPLE',
'PNK'  => 'PINK',
'RED'  => 'RED',
'SIL'  => 'SILVER',
'TAN'  => 'TAN',
'TEA'  => 'TEAL',
'TRQ'  => 'TURQUOISE',
'WHI'  => 'WHITE',
'YEL'  => 'YELLOW',
'' );

Watercraft.Macro_Clean_Hull_ID(Watercraft.file_FL_clean_in, watercraft.Layout_FL_clean_in,hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.Layout_FL_clean_in, wDatasetwithflag)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := transform

	self.watercraft_key				:=	if(length(trim(L.HULL_ID, left, right)) = 12 and trim(L.year, left, right) >= '1972' and L.is_hull_id_in_MIC, trim(L.HULL_ID, left, right),
										(trim(L.HULL_ID,left, right) + trim(L.MAKE,left, right) + trim(L.YEAR, left, right)));                               
	self.sequence_key				:=	trim(L.REG_DATE, left, right);
	self.watercraft_id						:=	'';
	self.state_origin						:=	'FL';
	self.source_code						:=	'AW';
	self.st_registration					:=	L.STATEABREV;
	self.county_registration				:=	county_reg(L.county);
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
	self.use_description					:=	trim(L.USE_1, left, right) +'-'+
												map((L.VEHICLE_USE='C')=>'Police',
													(L.VEHICLE_USE='L')=>'Lease',
													(L.VEHICLE_USE='M')=>'Commercial',
													(L.VEHICLE_USE='P')=>'Private',
													(L.VEHICLE_USE='T')=>'Taxi',
													(L.VEHICLE_USE='V')=>'Vessel',
													'');
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
	self.watercraft_color_1_code			:=	L.MAJ_COLOR;
	self.watercraft_color_1_description		:=	watercraft_color_desc(L.MAJ_COLOR);
	self.watercraft_color_2_code			:=	L.MIN_COLOR;
	self.watercraft_color_2_description		:=	watercraft_color_desc(L.MIN_COLOR);
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
	self.registration_expiration_date		:=	L.REG_EXPIRE_DATE;
	self.registration_status_code			:=	L.REG_STUS_CODE;
	self.registration_status_description	:=	map((L.REG_STUS_CODE='A')=>'ACTIVE','');
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	L.LIC_PLATE_NUMBER;
	self.transaction_type_code				:=	L.TRANSFER_TYPE;
	self.transaction_type_description		:=	map((L.TRANSFER_TYPE='C')=>'Court Order',
												    (L.TRANSFER_TYPE='E')=>'Exempt',
												    (L.TRANSFER_TYPE='G')=>'Gift',
												    (L.TRANSFER_TYPE='I')=>'Inheritance',
												    (L.TRANSFER_TYPE='L')=>'Lease',
												    (L.TRANSFER_TYPE='O')=>'Other',
												    (L.TRANSFER_TYPE='R')=>'Regular',
												    (L.TRANSFER_TYPE='T')=>'Trade',
														'');
	self.title_state						:=	'';
	self.title_status_code					:=	L.TITLE_STATUS;	
	self.title_status_description			:=	map((L.TITLE_STATUS='CA')=>'Cancelled',
													(L.TITLE_STATUS='DE')=>'Certificate of Destruction',
 													(L.TITLE_STATUS='DU')=>'Duplicate',
 													(L.TITLE_STATUS='JU')=>'unked',
 													(L.TITLE_STATUS='LM')=>'Lien Maint. Only',
 													(L.TITLE_STATUS='OR')=>'Original - New',
  													(L.TITLE_STATUS='OU')=>'Original - Used',
  													(L.TITLE_STATUS='RE')=>'Reinstate',
  													(L.TITLE_STATUS='SD')=>'old',
  													(L.TITLE_STATUS='TC')=>'Title Correction',
  													(L.TITLE_STATUS='TM')=>'Title Modification',
  													(L.TITLE_STATUS='TR')=>'Transfer',
													'');
	self.title_number						:=	L.TITLE_NUMBER;
	self.title_issue_date					:=	L.TITLE_ISSUE_DATE;	
	self.title_type_code					:=	L.TITLE_TYPE;
	self.title_type_description				:=	map((L.TITLE_TYPE='LC')=>'Land Craft',
													(L.TITLE_TYPE='WC')=>'Water Craft',
													'');
	self.additional_owner_count				:=	(string)((unsigned8)L.LIEN_COUNT-2);
	self.lien_1_indicator					:=	if(L.LH1_CUST_NUMBER='0000000000','','Y');
	self.lien_1_name						:=	L.LH1_NAME;
	self.lien_1_date						:=	L.LH1_LIEN_DATE;
	self.lien_1_address_1					:=	L.LH1_ADDRESS;
	self.lien_1_address_2					:=	L.LH1_APT_NO;
	self.lien_1_city						:=	L.LH1_CITY;
	self.lien_1_state						:=	L.LH1_STATE;
	self.lien_1_zip							:=	L.LH1_ZIP;
	self.lien_2_indicator					:=	if(L.LH2_CUST_NUMBER='0000000000','','Y');
	self.lien_2_name						:=	L.LH2_NAME;
	self.lien_2_date						:=	L.LH2_LEIN_DATE;
	self.lien_2_address_1					:=	L.LH2_ADDRESS;
	self.lien_2_address_2					:=	L.LH2_APT_NO;
	self.lien_2_city						:=	L.LH2_CITY;
	self.lien_2_state						:=	L.LH2_STATE;
	self.lien_2_zip							:=	L.LH2_ZIP;
	self.state_purchased					:=	'';
	self.purchase_date						:=	'';
	self.dealer								:=	L.DEALER_LICENCE_NO;
	self.purchase_price						:=	'';
	self.new_used_flag						:=	'';
	self.watercraft_status_code				:=	'';
	self.watercraft_status_description		:=	'';
	self.history_flag						:=	'';      
	self.coastguard_flag					:=	'';
  
  end;



export Mapping_FL_as_Main := project(wDatasetwithflag, main_mapping_format(left));



