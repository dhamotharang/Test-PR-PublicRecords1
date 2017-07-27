import watercraft, lib_stringlib;


watercraft_class_desc(string1 code)
 := case(code,
					'1'=> 'BOAT LENGTHS 16\' UP TO 25\'11\"',
'2'=> 'BOAT LENGTHS 26\' UP TO 39\'11\"',
'3'=> 'BOAT LENGTHS 40\' AND OVER',
'A'=> 'BOAT LENGTHS UP TO 15\'11\"',

					'' );

transaction_type_desc(string1 code)

:= case(code,

'1'=> 'ORIGINAL',
'2'=> 'RENEWAL',
'3'=> 'TRANSFER & RENEWAL',
'4'=> 'TRANSFER ONLY',
'5'=> 'DUPLICATE',
'7'=> 'MARINE TOILET', '');

title_status_desc(string1 code)

:= case(code, 

'1'=> 'Yes',
'2'=> '',
'3'=> 'Recovered','');


county_reg(string2 code)

:= case(code, 	'000'=> 'UNKNOWN',
'001'=> 'APPLING',
'002'=> 'ATKINSON',
'003'=> 'BACON',
'004'=> 'BAKER',
'005'=> 'BALDWIN',
'006'=> 'BANKS',
'007'=> 'BARROW',
'008'=> 'BARTOW',
'009'=> 'BEN HILL',
'010'=> 'BERRIEN',
'011'=> 'BIBB',
'012'=> 'BLECKLEY',
'013'=> 'BRANTLEY',
'014'=> 'BROOKS',
'015'=> 'BRYAN',
'016'=> 'BULLOCH',
'017'=> 'BURKE',
'018'=> 'BUTTS',
'019'=> 'CALHOUN',
'020'=> 'CAMDEN',
'021'=> 'CANDLER',
'022'=> 'CARROLL',
'023'=> 'CATOOSA',
'024'=> 'CHARLTON',
'025'=> 'CHATHAM',
'026'=> 'CHATTAHOOCHEE',
'027'=> 'CHATTOOGA',
'028'=> 'CHEROKEE',
'029'=> 'CLARKE',
'030'=> 'CLAY',
'031'=> 'CLAYTON',
'032'=> 'CLINCH',
'033'=> 'COBB',
'034'=> 'COFFEE',
'035'=> 'COLQUITT',
'036'=> 'COLUMBIA',
'037'=> 'COOK',
'038'=> 'COWETA',
'039'=> 'CRAWFORD',
'040'=> 'CRISP',
'041'=> 'DADE',
'042'=> 'DAWSON',
'043'=> 'DECATUR',
'044'=> 'DEKALB',
'045'=> 'DODGE',
'046'=> 'DOOLY',
'047'=> 'DOUGHERTY',
'048'=> 'DOUGLAS',
'049'=> 'EARLY',
'050'=> 'ECHOLS',
'051'=> 'EFFINGHAM',
'052'=> 'ELBERT',
'053'=> 'EMANUAL',
'054'=> 'EVANS',
'055'=> 'FANNIN',
'056'=> 'FAYETTE',
'057'=> 'FLOYD',
'058'=> 'FORSYTH',
'059'=> 'FRANKLIN',
'060'=> 'FULTON',
'061'=> 'GILMER',
'062'=> 'GLASCOCK',
'063'=> 'GLYNN',
'064'=> 'GORDON',
'065'=> 'GRADY',
'066'=> 'GREENE',
'067'=> 'GWINNETT',
'068'=> 'HABERSHAM',
'069'=> 'HALL',
'070'=> 'HANCOCK',
'071'=> 'HARALSON',
'072'=> 'HARRIS',
'073'=> 'HART',
'074'=> 'HEARD',
'075'=> 'HENRY',
'076'=> 'HOUSTON',
'077'=> 'IRWIN',
'078'=> 'JACKSON',
'079'=> 'JASPER',
'080'=> 'JEFF DAVIS',
'081'=> 'JEFFERSON',
'082'=> 'JENKINS',
'083'=> 'JOHNSON',
'084'=> 'JONES',
'085'=> 'LAMAR',
'086'=> 'LANIER',
'087'=> 'LAURENS',
'088'=> 'LEE',
'089'=> 'LIBERTY',
'090'=> 'LINCOLN',
'091'=> 'LONG',
'092'=> 'LOWNDES',
'093'=> 'LUMPKIN',
'094'=> 'MACON',
'095'=> 'MADISON',
'096'=> 'MARION',
'097'=> 'MCDUFFIE',
'098'=> 'MCINTOSH',
'099'=> 'MERIWETHER',
'100'=> 'MILLER',
'101'=> 'MITCHELL',
'102'=> 'MONROE',
'103'=> 'MONTGOMERY',
'104'=> 'MORGAN',
'105'=> 'MURRAY',
'106'=> 'MUSCOGEE',
'107'=> 'NEWTON',
'108'=> 'OCONEE',
'109'=> 'OGLETHORPE',
'110'=> 'PAULDING',
'111'=> 'PEACH',
'112'=> 'PICKENS',
'113'=> 'PIERCE',
'114'=> 'PIKE',
'115'=> 'POLK',
'116'=> 'PULASKI',
'117'=> 'PUTNAM',
'118'=> 'QUITMAN',
'119'=> 'RABUN',
'120'=> 'RANDOLPH',
'121'=> 'RICHMOND',
'122'=> 'ROCKDALE',
'123'=> 'SCHLEY',
'124'=> 'SCREVEN',
'125'=> 'SEMINOLE',
'126'=> 'SPALDING',
'127'=> 'STEPHENS',
'128'=> 'STEWART',
'129'=> 'SUMTER',
'130'=> 'TALBOT',
'131'=> 'TALIAFERRO',
'132'=> 'TATTNALL',
'133'=> 'TAYLOR',
'134'=> 'TELFAIR',
'135'=> 'TERRELL',
'136'=> 'THOMAS',
'137'=> 'TIFT',
'138'=> 'TOOMBS',
'139'=> 'TOWNS',
'140'=> 'TREUTLEN',
'141'=> 'TROUP',
'142'=> 'TURNER',
'143'=> 'TWIGGS',
'144'=> 'UNION',
'145'=> 'UPSON',
'146'=> 'WALKER',
'147'=> 'WALTON',
'148'=> 'WARE',
'149'=> 'WARREN',
'150'=> 'WASHINGTON',
'151'=> 'WAYNE',
'152'=> 'WEBSTER',
'153'=> 'WHEELER',
'154'=> 'WHITE',
'155'=> 'WHITFIELD',
'156'=> 'WILCOX',
'157'=> 'WILKES',
'158'=> 'WILKINSON',
'159'=> 'WORTH',
'160'=> 'OUT OF STATE',


				'' );   

string fFixHullID(string pHullIDIn) :=	lib_stringlib.StringLib.stringtouppercase(pHullIDIn);

watercraft.Layout_Watercraft_Main_Base main_mapping_format(watercraft.file_GA_clean_in L) := transform


    self.watercraft_key						:=	if(trim(L.year, left, right) >= '1972' and length(trim(fFixHullID(L.HULL_ID),left, right)) = 12, trim(fFixHullID(L.HULL_ID),left, right),
	                                            if(fFixHullID(L.HULL_ID) = '', trim(L.Reg_num, left, right), (trim(fFixHullID(L.HULL_ID), left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30]));
	self.sequence_key						:=	trim(L.reg_date, left, right);
	self.watercraft_id						:=	'';
	self.state_origin						:=	'GA';
	self.source_code						:=	'AW';
	self.st_registration					:=	L.STATEABREV;
	self.county_registration				:=	county_reg(trim(L.county,left,right));
	self.registration_number				:=	trim(L.REG_NUM, left, right);
	self.hull_number						:=	fFixHullID(L.HULL_ID);
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
	self.watercraft_class_code				:=	L.LENGTH_CLASS;
	self.watercraft_class_description		:=	watercraft_class_desc(L.LENGTH_CLASS);
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
	self.watercraft_toilet_code				:=	L.TOILET;
	self.watercraft_toilet_description		:=	case(L.TOILET,'1' => 'YES','2' => 'NO','');
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
	self.coast_guard_number					:=	L.CG_NUM;
	self.registration_date					:=	L.REG_DATE;
	self.registration_expiration_date		:=	L.REG_EXPIRE;
	self.registration_status_code			:=	'';
	self.registration_status_description	:=	'';
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	'';
	self.transaction_type_code				:=	L.TRANSACTION_TYPE;
	self.transaction_type_description		:=	transaction_type_desc(L.TRANSACTION_TYPE);
	self.title_state						:=	'';
	self.title_status_code					:=	L.STOLEN;
	self.title_status_description			:=	title_status_desc(L.STOLEN);
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



export Mapping_GA_as_Main := project(watercraft.file_GA_clean_in, main_mapping_format(left));



