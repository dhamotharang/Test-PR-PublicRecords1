import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;

// translates mo_MJ.ksh* Ab intio graph into ECL

county_reg(string2 code) := case(code,
'001' => 'ADAIR',
'002' => 'ANDREW',
'003' => 'ATCHISON',
'004' => 'AUDRAIN',
'005' => 'BARRY',
'006' => 'BARTON',
'007' => 'BATES',
'008' => 'BENTON',
'009' => 'BOLLINGER',
'010' => 'BOONE',
'011' => 'BUCHANAN',
'012' => 'BUTLER',
'013' => 'CALDWELL',
'014' => 'CALLAWAY',
'015' => 'CAMDEN',
'016' => 'CAPE GIRARDEAU',
'017' => 'CARROLL',
'018' => 'CARTER',
'019' => 'CASS',
'020' => 'CEDAR',
'021' => 'CHARITON',
'022' => 'CHRISTIAN',
'023' => 'CLARK',
'024' => 'CLAY',
'025' => 'CLINTON',
'026' => 'COLE',
'027' => 'COOPER',
'028' => 'CRAWFORD',
'029' => 'DADE',
'030' => 'DALLAS',
'031' => 'DAVIESS',
'032' => 'DEKALB',
'033' => 'DENT',
'034' => 'DOUGLAS',
'035' => 'DUNKLIN',
'036' => 'FRANKLIN',
'037' => 'GASCONADE',
'038' => 'GENTRY',
'039' => 'GREENE',
'040' => 'GRUNDY',
'041' => 'HARRISON',
'042' => 'HENRY',
'043' => 'HICKORY',
'044' => 'HOLT',
'045' => 'HOWARD',
'046' => 'HOWELL',
'047' => 'IRON',
'048' => 'JACKSON',
'049' => 'JASPER',
'050' => 'JEFFERSON',
'051' => 'JOHNSON',
'052' => 'KNOX',
'053' => 'LACLEDE',
'054' => 'LAYAYETTE',
'055' => 'LAWRENCE',
'056' => 'LEWIS',
'057' => 'LINCOLN',
'058' => 'LINN',
'059' => 'LIVINGTON',
'060' => 'MCDONALD',
'061' => 'MACON',
'062' => 'MADISON',
'063' => 'MARIES',
'064' => 'MARION',
'065' => 'MERCER',
'066' => 'MILLER',
'067' => 'MISSISSIPPI',
'068' => 'MONITEAU',
'069' => 'MONROE',
'070' => 'MONTGOMERY',
'071' => 'MORGAN',
'072' => 'NEW MADRID',
'073' => 'NEWTON',
'074' => 'NODAWAY',
'075' => 'OREGON',
'076' => 'OSAGE',
'077' => 'OZARK',
'078' => 'PEMISCOT',
'079' => 'PERRY',
'080' => 'PETTIS',
'081' => 'PHELPS',
'082' => 'PIKE',
'083' => 'PLATTE',
'084' => 'POLK',
'085' => 'POLASKI',
'086' => 'PUTNAM',
'087' => 'RALLS',
'088' => 'RANDOLPH',
'089' => 'RAY',
'090' => 'REYNOLDS',
'091' => 'RIPLEY',
'092' => 'ST CHARLES',
'093' => 'ST CLAIR',
'094' => 'ST FRANCOIS',
'095' => 'STE GENEVIEVE',
'096' => 'ST LOUIS COUNTY',
'097' => 'SALINE',
'098' => 'SCHUYLER',
'099' => 'SCOTLAND',
'100' => 'SCOTT',
'101' => 'SHANNON',
'102' => 'SHELBY',
'103' => 'STODDARD',
'104' => 'STONE',
'105' => 'SULLIVAN',
'106' => 'TANEY',
'107' => 'TEXAS',
'108' => 'VERNON',
'109' => 'WARREN',
'110' => 'WASHINGTON',
'111' => 'WAYNE',
'112' => 'WEBSTER',
'113' => 'WORTH',
'114' => 'WRIGHT',
'115' => 'ST LOUIS',
'116' => 'KANSAS CITY',
'117' => 'OUT OF STATE',
'120' => 'OTHER', '' );


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
'ORG'  => 'ORANGE',
'ONG'  => 'ORANGE',
'PLE'  => 'PURPLE',
'PNK'  => 'PINK',
'RED'  => 'RED',
'SIL'  => 'SILVER',
'TAN'  => 'TAN',
'TEA'  => 'TEAL',
'TRQ'  => 'TURQUOISE',
'UNK'	 => 'UNKNOWN',
'WHI'  => 'WHITE',
'YEL'  => 'YELLOW',
'' );
  
Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_MO_clean_in, Watercraft.Layout_MO,hull_clean_in)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := transform
	// New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	stringlib.StringFindReplace(IF(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12, trim(L.HULL_ID,left,right),
																														// IF(length(trim(L.HULL_ID,left, right)) = 12 and trim(L.year, left, right) = '0', trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM,left,right) <> '', trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																																	// (trim(L.HULL_ID,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30]))),' ','');                                          
	self.watercraft_key			:=	(trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30];                                          
	self.sequence_key				:=	if((trim(L.REG_DATE, left, right)<>''),L.REG_DATE,L.APPLICATION);
	self.state_origin				:=	'MO';
	self.source_code				:=	'AW';
	self.st_registration			:=	L.STATEABREV;
	self.county_registration	:=	county_reg(L.county);
	self.registration_number	:=	trim(L.REG_NUM, left, right);
	self.hull_number					:=	L.hull_id;
	self.propulsion_description		:=	L.PROP;
	self.vehicle_type_Description	:=	L.VEH_TYPE;
	self.fuel_description					:=	L.FUEL;
	self.hull_type_description		:=	L.HULL;
	self.use_description					:=	L.USE_1;
	self.watercraft_length				:=	L.TOTAL_INCH;
	self.model_year								:=	L.YEAR;
	self.watercraft_make_description	:=	L.MAKE;
	self.watercraft_model_description	:=	L.MODEL_NUM;
	self.watercraft_color_1_code			:=	L.COLOR[1..3];
	self.watercraft_color_1_description	:=	watercraft_color_desc(L.COLOR[1..3]);
	self.watercraft_color_2_code			:=	if((stringlib.stringfind(L.COLOR,'/',1)=4),L.COLOR[5..7],'');
	self.watercraft_color_2_description	:=	if((stringlib.stringfind(L.COLOR,'/',1)=4),watercraft_color_desc(L.COLOR[5..7]),'');
	self.watercraft_hp_1							:=	L.HP;
	IsValidRegDate										:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date						:=	if(L.REG_DATE = '19910926', '', 
																					If(IsValidRegDate,L.REG_DATE,''));
	self.registration_expiration_date	:=	L.EXPIRE_YEAR;
	self.title_number									:=	L.TITLE;
	IsValidTitleDate									:=	STD.DATE.IsValidDate((integer)L.APPLICATION);
	self.title_issue_date							:=	If(IsValidTitleDate,L.APPLICATION,'');
	self.lien_1_indicator							:=	if((trim(L.LIEN_1,left,right)<>''),'Y','N');
	self.lien_1_name									:=	L.LIEN_1;
	IsValidLien1Date									:=	STD.DATE.IsValidDate((integer)L.LEIN_DATE_1);
	self.lien_1_date									:=	If(IsValidLien1Date,L.LEIN_DATE_1,'');
	self.lien_1_address_1							:=	L.STREET_1;
	self.lien_1_city									:=	L.CITY_1;
	self.lien_1_state									:=	L.STATE_1;
	self.lien_1_zip										:=	L.ZIP_1;
	self.lien_2_indicator							:=	if((trim(L.LIEN_2,left,right)<>''),'Y','N');
	self.lien_2_name									:=	L.LIEN_2;
	IsValidLien2Date									:=	STD.DATE.IsValidDate((integer)L.LIEN_DATE_2);
	self.lien_2_date									:=	If(IsValidLien2Date,L.LIEN_DATE_2,'');
	self.lien_2_address_1							:=	L.STREET_2;
	self.lien_2_city									:=	L.CITY_2;
	self.lien_2_state									:=	L.STATE_2;
	self.lien_2_zip										:=	L.ZIP_2;
	self.state_purchased							:=	map((L.NEW_USED='O')=>'',
																						(L.NEW_USED='F')=>'',
																						(L.NEW_USED='U')=>'MO',
																						(L.NEW_USED='N')=>'MO',
																						'');
	IsValidPurchaseDte								:=	STD.DATE.IsValidDate((integer)L.PURCHASE_DATE);
	self.purchase_date								:=	If(IsValidPurchaseDte,L.PURCHASE_DATE,'');
	self.dealer												:=	L.DEALER_NUM;
	self.new_used_flag								:=	map((L.NEW_USED='O')=>'N',
																						(L.NEW_USED='F')=>'U',
																						(L.NEW_USED='U')=>'U',
																						(L.NEW_USED='N')=>'N',
																						'');
	self	:= L;
	self	:= [];
  end;
	
EXPORT Map_MO_raw_to_Main := DEDUP(project(hull_clean_in, main_mapping_format(left)));