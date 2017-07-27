import watercraft;


title_status_desc(string1 code)
 := case(code,

'A' => 'ACTIVE',
'I' => 'INACTIVE',
'M' => 'MOVED-OUT-OF-STATE',
'T' => 'TERMINATED',

					'' );
					
					
registration_status_desc(string1 code)

:= case(code,

'A' => 'ACTIVE',
'E' => 'EXPIRED',
'T' => 'TRANSFERRED',
'X' => 'EXCHANGED',

'');

title_type_desc(string code)

:= case(code,

'DR' => 'DUAL REGISTRATION',
'GO' => 'GOVERNMENT',
'JK' => 'JUNK',
'NN' => 'NON-NEGOTIABLE',
'NR' => 'NON-RESIDENT',
'RC' => 'RECONSTRUCTED',
'RG' => 'REGULAR',
'SC' => 'SALVAGE CERTIFICATE', '');

dealer_desc(string code)


:= case(code,

'AA' => 'AUTO AUCTION',
'D' => 'DEALER - NEW & USED MV',
'DRV' => 'DEALER - RECREATIONAL VEHICLES',
'DTR' => 'DEALER - TRAILER',
'DUC' => 'DEALER - USED MV',
'F' => 'DEALER - MOTORCYCLES',
'LS' => 'LICENSE SERVICE',
'MFG' => 'MANUFACTURER',
'REP' => 'FINANCIAL INSTITUTION',
'TRS' => 'TRANSPORTER',
'WDR' => 'WRECKER, DISMANTLER, REBUILDER', '');


county_reg(string2 code)

:= case(code, 	

'BARB' => 'BARBOUR',
'BERK' => 'BERKELEY',
'BOON' => 'BOONE',
'BRAX' => 'BRAXTON',
'BROO' => 'BROOKE',
'CABE' => 'CABELL',
'CALH' => 'CALHOUN',
'CLAY' => 'CLAY',
'DODD' => 'DODDRIDGE',
'FAYE' => 'FAYETTE',
'GILM' => 'GILMER',
'GRAN' => 'GRANT',
'GREE' => 'GREENBRIER',
'HAMP' => 'HAMPSHIRE',
'HANC' => 'HANCOCK',
'HARD' => 'HARDY',
'HARR' => 'HARRISON',
'JACK' => 'JACKSON',
'JEFF' => 'JEFFERSON',
'KANA' => 'KANAWHA',
'LEWI' => 'LEWIS',
'LINC' => 'LINCOLN',
'LOGA' => 'LOGAN',
'MARI' => 'MARION',
'MARS' => 'MARSHALL',
'MASO' => 'MASON',
'MCDO' => 'MCDOWELL',
'MERC' => 'MERCER',
'MINE' => 'MINERAL',
'MING' => 'MINGO',
'MONO' => 'MONONGALIA',
'MONR' => 'MONROE',
'MORG' => 'MORGAN',
'NICH' => 'NICHOLAS',
'OHIO' => 'OHIO',
'OUT ' => 'OUT OF STATE',
'PEND' => 'PENDELTON',
'PLEA' => 'PLEASANTS',
'POCA' => 'POCAHONTAS',
'PRES' => 'PRESTON',
'PUTN' => 'PUTNUM',
'RALE' => 'RALEIGH',
'RAND' => 'RANDOLPH',
'RITC' => 'RITCHIE',
'ROAN' => 'ROANE',
'SUMM' => 'SUMMERS',
'TAYL' => 'TAYLOR',
'TUCK' => 'TUCKER',
'TYLE' => 'TYLER',
'UPSH' => 'UPSHUR',
'WAYN' => 'WAYNE',
'WEBS' => 'WEBSTER',
'WETZ' => 'WETZEL',
'WIRT' => 'WIRT',
'WOOD' => 'WOOD',
'WYOM' => 'WYOMING',

				'' );   


watercraft.Layout_Watercraft_Main_Base main_mapping_format(watercraft.file_WV_clean_in L) := transform


    self.watercraft_key				        :=	if(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12, trim(L.HULL_ID,left,right),
	                                            trim(L.title_num, left, right));                                 
	self.sequence_key				        :=	trim(L.REG_DATE, left, right);
	self.watercraft_id						:=	'';
	self.state_origin						:=	'WV';
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
	self.watercraft_model_description		:=	L.Model;
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
	self.registration_date					:=	if(L.REG_DATE = '19950318', '', L.REG_DATE);
	self.registration_expiration_date		:=	L.Reg_Expire;
	self.registration_status_code			:=	L.Status;
	self.registration_status_description	:=	registration_status_desc(L.Status);
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	'';
	self.transaction_type_code				:=	'';
	self.transaction_type_description		:=	'';
	self.title_state						:=	'';
	self.title_status_code					:=	L.Active;
	self.title_status_description			:=	title_status_desc(L.Active);
	self.title_number						:=	L.TITLE_NUM;
	self.title_issue_date					:=	L.TITLE_DATE;
	self.title_type_code					:=	L.Title_type;
	self.title_type_description				:=	title_type_desc(L.Title_type);
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
	self.dealer								:=	dealer_desc(L.Dealer_T);
	self.purchase_price						:=	'';
	self.new_used_flag						:=	'';
	self.watercraft_status_code				:=	'';
	self.watercraft_status_description		:=	'';
	self.history_flag						:=	'';
	self.coastguard_flag					:=	'';
    
  end;



export Mapping_WV_as_Main := project(watercraft.file_WV_clean_in, main_mapping_format(left));


	

	

