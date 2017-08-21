import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;

// translates fl_mz.mp Ab intio graph into ECL

county_reg(string2 code) := case(code, 	
'1'=>'DADE',
'2'=>'DUVAL',
'3'=>'HILLSBOROUGH',
'4'=>'PINELLAS',
'5'=>'POLK',
'6'=>'PALMBEACH',
'7'=>'ORANGE',
'8'=>'VOLUSIA',
'9'=>'ESCAMBIA',
'10'=>'BROWARD',
'11'=>'ALACHUA',
'12'=>'LAKE',
'13'=>'LEON',
'14'=>'MARION',
'15'=>'MANATEE',
'16'=>'SARASOTA',
'17'=>'SEMINOLE',
'18'=>'LEE',
'19'=>'BREVARD',
'20'=>'ST.JOHNS',
'21'=>'GADSDEN',
'22'=>'PUTNAM',
'23'=>'BAY',
'24'=>'ST.LUCIE',
'25'=>'JACKSON',
'26'=>'OSCEOLA',
'27'=>'HIGHLANDS',
'28'=>'PASCO',
'29'=>'COLUMBIA',
'30'=>'HARDEE',
'31'=>'SUWANEE',
'32'=>'INDIANRIVER',
'33'=>'SANTAROSA',
'34'=>'DESOTO',
'35'=>'MADISON',
'36'=>'WALTON',
'37'=>'TAYLOR',
'38'=>'MONROE',
'39'=>'LEVY',
'40'=>'HERNANDO',
'41'=>'NASSAU',
'42'=>'MARTIN',
'43'=>'OKALOOSA',
'44'=>'SUMPTER',
'45'=>'BRADFORD',
'46'=>'JEFFERSON',
'47'=>'CITRUS',
'48'=>'CLAY',
'49'=>'HENDRY',
'50'=>'WASHINGTON',
'51'=>'HOLMES',
'52'=>'BAKER',
'53'=>'CHARLOTTE',
'54'=>'DIXIE',
'55'=>'GILCHRIST',
'56'=>'HAMILTON',
'57'=>'OKEECHOBEE',
'58'=>'CALHOUN',
'59'=>'FRANKLIN',
'60'=>'GLADES',
'61'=>'FLAGLER',
'62'=>'LAFAYETTE',
'63'=>'UNION',
'64'=>'COLLIER',
'65'=>'WAKULLA',
'66'=>'GULF',
'67'=>'LIBERTY',
'68'=>'DMV',
'90'=>'DUPLICATE', '' ); 


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

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_FL_clean_in, Watercraft.layout_FL,hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, Watercraft.layout_FL,wDatasetwithflag)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := transform
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	stringlib.StringFindReplace(IF(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) >= '1972' and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
																													// L.STATEABREV+trim(L.REG_NUM,left,right)+trim(L.year,left,right)),' ','');                               
	self.watercraft_key			:=	if(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) >= '1972' and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
																 trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right));
	self.sequence_key				:=	trim(L.REG_DATE,left,right);
	self.state_origin				:=	'FL';
	self.source_code				:=	'AW';
	self.st_registration		:=	L.STATEABREV;
	self.county_registration	:=	county_reg(L.county);
	self.registration_number	:=	trim(L.REG_NUM, left, right);
	self.hull_number					:=	L.hull_id;
	self.propulsion_description		:=	L.PROP;
	self.vehicle_type_Description	:=	L.VEH_TYPE;
	self.fuel_description					:=	L.FUEL;
	self.hull_type_description		:=	L.HULL;
	self.use_description					:=	IF(trim(L.VEHICLE_USE)<>'',trim(L.USE_1,left,right) +'-'+
																		MAP((L.VEHICLE_USE='C')=>'POLICE',
																				(L.VEHICLE_USE='L')=>'LEASE',
																				(L.VEHICLE_USE='M')=>'COMMERCIAL',
																				(L.VEHICLE_USE='P')=>'PRIVATE',
																				(L.VEHICLE_USE='T')=>'TAXI',
																				(L.VEHICLE_USE='V')=>'VESSEL',
																				''),L.USE_1);
	self.watercraft_length			:=	L.TOTAL_INCH;
	self.model_year							:=	L.YEAR;
	self.watercraft_class_code				:=	L.VEHICLE_CLASS_CODE;
	self.watercraft_class_description		:=	map(L.VEHICLE_CLASS_CODE='100' => 'VESSELS',
																							L.VEHICLE_CLASS_CODE='101' => 'VESSEL DEALER CLASSIFICATION',
																							L.VEHICLE_CLASS_CODE='104' => 'VESSELS EXEMPT','');
	self.watercraft_make_description			:=	L.MAKE;
	self.watercraft_color_1_code					:=	L.MAJ_COLOR;
	self.watercraft_color_1_description		:=	watercraft_color_desc(L.MAJ_COLOR);
	self.watercraft_color_2_code					:=	L.MIN_COLOR;
	self.watercraft_color_2_description		:=	watercraft_color_desc(L.MIN_COLOR);
	IsValidRegDate												:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date								:=	If(IsValidRegDate,L.REG_DATE,'');
	IsValidExpireDate											:=	STD.DATE.IsValidDate((integer)L.REG_EXPIRE_DATE);
	self.registration_expiration_date			:=	If(IsValidExpireDate,L.REG_EXPIRE_DATE,'');
	self.registration_status_code					:=	L.REG_STUS_CODE;
	self.registration_status_description	:=	map((L.REG_STUS_CODE='A')=>'ACTIVE','');
	self.decal_number								:=	L.DECAL_NO;
	self.transaction_type_code			:=	L.TRANSFER_TYPE;
	self.transaction_type_description	:=	map((L.TRANSFER_TYPE='C')=>'COURT ORDER',
																						(L.TRANSFER_TYPE='E')=>'EXEMPT',
																						(L.TRANSFER_TYPE='G')=>'GIFT',
																						(L.TRANSFER_TYPE='I')=>'INHERITANCE',
																						(L.TRANSFER_TYPE='L')=>'LEASE',
																						(L.TRANSFER_TYPE='O')=>'OTHER',
																						(L.TRANSFER_TYPE='R')=>'REGULAR',
																						(L.TRANSFER_TYPE='T')=>'TRADE',
																						'');
	self.title_status_code					:=	L.TITLE_STATUS;	
	self.title_status_description		:=	map((L.TITLE_STATUS='CA')=>'CANCELLED',
																					(L.TITLE_STATUS='DE')=>'CERTIFICATE OF DESTRUCTION',
																					(L.TITLE_STATUS='DU')=>'DUPLICATE',
																					(L.TITLE_STATUS='JU')=>'UNKED',
																					(L.TITLE_STATUS='LM')=>'LIEN MAINT. ONLY',
																					(L.TITLE_STATUS='OR')=>'ORIGINAL - NEW',
																					(L.TITLE_STATUS='OU')=>'ORIGINAL - USED',
																					(L.TITLE_STATUS='RE')=>'REINSTATE',
																					(L.TITLE_STATUS='SD')=>'OLD',
																					(L.TITLE_STATUS='TC')=>'TITLE CORRECTION',
																					(L.TITLE_STATUS='TM')=>'TITLE MODIFICATION',
																					(L.TITLE_STATUS='TR')=>'TRANSFER',
																					'');
	self.title_number							:=	L.TITLE_NUMBER;
	IsValidTitleDate							:=	STD.DATE.IsValidDate((integer)L.TITLE_ISSUE_DATE);
	self.title_issue_date					:=	If(IsValidTitleDate,L.TITLE_ISSUE_DATE,'');	
	self.title_type_code					:=	L.TITLE_TYPE;
	self.title_type_description		:=	MAP((L.TITLE_TYPE='LC')=>'LAND CRAFT',
																				(L.TITLE_TYPE='WC')=>'WATER CRAFT',
																				'');
	self.additional_owner_count		:=	(STRING)IF((UNSIGNED8)L.LIEN_COUNT > 2, (unsigned8)L.LIEN_COUNT-2,0);
	self.lien_1_indicator					:=	if(L.LH1_CUST_NUMBER='0000000000','','Y');
	self.lien_1_name							:=	L.LH1_NAME;
	self.lien_1_date							:=	L.LH1_LIEN_DATE;
	self.lien_1_address_1					:=	L.LH1_ADDRESS;
	self.lien_1_address_2					:=	L.LH1_APT_NO;
	self.lien_1_city							:=	L.LH1_CITY;
	self.lien_1_state							:=	L.LH1_STATE;
	self.lien_1_zip								:=	L.LH1_ZIP;
	self.lien_2_indicator					:=	if(L.LH2_CUST_NUMBER='0000000000','','Y');
	self.lien_2_name							:=	L.LH2_NAME;
	self.lien_2_date						:=	L.LH2_LIEN_DATE;
	self.lien_2_address_1					:=	L.LH2_ADDRESS;
	self.lien_2_address_2					:=	L.LH2_APT_NO;
	self.lien_2_city						:=	L.LH2_CITY;
	self.lien_2_state						:=	L.LH2_STATE;
	self.lien_2_zip							:=	L.LH2_ZIP;
	self.dealer								:=	L.DEALER_LICENCE_NO;
	self	:= L;
	self	:= [];
  end;


EXPORT Map_FL_raw_to_Main := project(wDatasetwithflag, main_mapping_format(left));