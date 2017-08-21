import watercraft, lib_stringlib;


county_reg(string3 code)

:= case(code, 	
'001' => 'ANDERSON',
'002' => 'ANDREWS',
'003' => 'ANGELINA',
'004' => 'ARANSAS',
'005' => 'ARCHER',
'006' => 'ARMSTRONG',
'007' => 'ALASCOSA',
'008' => 'AUSTIN',
'009' => 'BAILEY',
'010' => 'BANDERA',
'011' => 'BASTROP',
'012' => 'BAYLOR',
'013' => 'BEE',
'014' => 'BELL',
'015' => 'BEXAR',
'016' => 'BLANCO',
'017' => 'BORDEN',
'018' => 'BOSQUE',
'019' => 'BOWIE',
'020' => 'BRAZORIA',
'021' => 'BRAZOS',
'022' => 'BREWSTER',
'023' => 'BRISCOE',
'024' => 'BROOKS',
'025' => 'BROWN',
'026' => 'BURLESON',
'027' => 'BURNET',
'028' => 'CALDWELL',
'029' => 'CALHOUN',
'030' => 'CALLAHAN',
'031' => 'CAMERON',
'032' => 'CAMP',
'033' => 'CARSON',
'034' => 'CASS',
'035' => 'CASTRO',
'036' => 'CHAMBERS',
'037' => 'CHEROKEE',
'038' => 'CHILDRESS',
'039' => 'CLAY',
'040' => 'COCHRAN',
'041' => 'COKE',
'042' => 'COLEMAN',
'043' => 'COLLIN',
'044' => 'COLLINGSWORTH',
'045' => 'COLORADO',
'046' => 'COMAL',
'047' => 'COMANCHE',
'048' => 'CONCHO',
'049' => 'COOKE',
'050' => 'CORYELL',
'051' => 'COTTLE',
'052' => 'CRANE',
'053' => 'CROCKETT',
'054' => 'CROSBY',
'055' => 'CULBERSON',
'056' => 'DALLAM',
'057' => 'DALLAS',
'058' => 'DAWSON',
'059' => 'DEAF SMITH',
'060' => 'DELTA',
'061' => 'DENTON',
'062' => 'DEWITT',
'063' => 'DICKENS',
'064' => 'DIMMIT',
'065' => 'DONLEY',
'066' => 'DUVAL',
'067' => 'EASTLAND',
'068' => 'ECTOR',
'069' => 'EDWARDS',
'070' => 'ELLIS',
'071' => 'EL PASO',
'072' => 'ERATH',
'073' => 'FALLS',
'074' => 'FANNIN',
'075' => 'FAYETTE',
'076' => 'FISHER',
'077' => 'FLOYD',
'078' => 'FOARD',
'079' => 'FORT BEND',
'080' => 'FRANKLIN',
'081' => 'FREESTONE',
'082' => 'FRIO',
'083' => 'GAINES',
'084' => 'GALVESTON',
'085' => 'GARZA',
'086' => 'GILLESPIE',
'087' => 'GLASSCOCK',
'088' => 'GOLIAD',
'089' => 'GONZALES',
'090' => 'GRAY',
'091' => 'GRAYSON',
'092' => 'GREGG',
'093' => 'GRIMES',
'094' => 'GUADALUPE',
'095' => 'HALE',
'096' => 'HALL',
'097' => 'HAMILTON',
'098' => 'HANSFORD',
'099' => 'HARDEMAN',
'100' => 'HARDIN',
'101' => 'HARRIS',
'102' => 'HARRISON',
'103' => 'HARTLEY',
'104' => 'HASKELL',
'105' => 'HAYS',
'106' => 'HEMPHILL',
'107' => 'HENDERSON',
'108' => 'HIDALGO',
'109' => 'HILL',
'110' => 'HOCKLEY',
'111' => 'HOOD',
'112' => 'HOPKINS',
'113' => 'HOUSTON',
'114' => 'HOWARD',
'115' => 'HUDSPETH',
'116' => 'HUNT',
'117' => 'HUTCHINSON',
'118' => 'IRION',
'119' => 'JACK',
'120' => 'JACKSON',
'121' => 'JASPER',
'122' => 'JEFF DAVIS',
'123' => 'JEFFERSON',
'124' => 'JIM HOGG',
'125' => 'JIM WELLS',
'126' => 'JOHNSON',
'127' => 'JONES',
'128' => 'KAMES',
'129' => 'KAUFMAN',
'130' => 'KENDALL',
'131' => 'KENEDY',
'132' => 'KENT',
'133' => 'KERR',
'134' => 'KIMBLE',
'135' => 'KING',
'136' => 'KINNEY',
'137' => 'KLEBERG',
'138' => 'KNOX',
'139' => 'LAMAR',
'140' => 'LAMB',
'141' => 'LAMPASAS',
'142' => 'LASALLE',
'143' => 'LAVACA',
'144' => 'LEE',
'145' => 'LEON',
'146' => 'LIBERTY',
'147' => 'LIMESTONE',
'148' => 'LIPSCOMB',
'149' => 'LIVE OAK',
'150' => 'LLANO',
'151' => 'LOVING',
'152' => 'LUBBOCK',
'153' => 'LYNN',
'154' => 'MADISON',
'155' => 'MARION',
'156' => 'MARTIN',
'157' => 'MASON',
'158' => 'MATAGORDA',
'159' => 'MAVERICK',
'160' => 'MCCULLOCH',
'161' => 'MCLENNAN',
'162' => 'MCMULLEN',
'163' => 'MEDINA',
'164' => 'MENARD',
'165' => 'MIDLAND',
'166' => 'MILAM',
'167' => 'MILLS',
'168' => 'MITCHELL',
'169' => 'MONTAGUE',
'170' => 'MONTGOMERY',
'171' => 'MOORE',
'172' => 'MORRIS',
'173' => 'MOTLEY',
'174' => 'NACOGDOCHES',
'175' => 'NAVARRO',
'176' => 'NEWTON',
'177' => 'NOLAN',
'178' => 'NUECES',
'179' => 'OCHILTREE',
'180' => 'OLDHAM',
'181' => 'ORANGE',
'182' => 'PALO PINTO',
'183' => 'PANOLA',
'184' => 'PARKER',
'185' => 'PARMER',
'186' => 'PECOS',
'187' => 'POLK',
'188' => 'POTTER',
'189' => 'PRESIDIO',
'190' => 'RAINS',
'191' => 'RANDALL',
'192' => 'REAGAN',
'193' => 'REAL',
'194' => 'RED RIVER',
'195' => 'REEVES',
'196' => 'REFUGIO',
'197' => 'ROBERTS',
'198' => 'ROBERTSON',
'199' => 'ROCKWELL',
'200' => 'RUNNELS',
'201' => 'RUSK',
'202' => 'SABINE',
'203' => 'SAN AUGUSTINE',
'204' => 'SAN JACINTO',
'205' => 'SAN PATRICIO',
'206' => 'SAN SABA',
'207' => 'SCHLEICHER',
'208' => 'SCURRY',
'209' => 'SHACKLEFORD',
'210' => 'SHELBY',
'211' => 'SHERMAN',
'212' => 'SMITH',
'213' => 'SOMERVELL',
'214' => 'STARR',
'215' => 'STEPHENS',
'216' => 'STERLING',
'217' => 'STONEWALL',
'218' => 'SUTTON',
'219' => 'SWISHER',
'220' => 'TARRANT',
'221' => 'TAYLOR',
'222' => 'TERRELL',
'223' => 'TERRY',
'224' => 'THROCKMORTON',
'225' => 'TITUS',
'226' => 'TOM GREEN',
'227' => 'TRAVIS',
'228' => 'TRINITY',
'229' => 'TYLER',
'230' => 'UPSHUR',
'231' => 'UPTON',
'232' => 'UVALDE',
'233' => 'VAL VERDE',
'234' => 'VAN ZANDT',
'235' => 'VICTORIA',
'236' => 'WALKER',
'237' => 'WALLER',
'238' => 'WARD',
'239' => 'WASHINGTON',
'240' => 'WEBB',
'241' => 'WHARTON',
'242' => 'WHEELER',
'243' => 'WICHITA',
'244' => 'WILBARGER',
'245' => 'WILLACY',
'246' => 'WILLIAMSON',
'247' => 'WILSON',
'248' => 'WINKLER',
'249' => 'WISE',
'250' => 'WOOD',
'251' => 'YOAKUM',
'252' => 'YOUNG',
'253' => 'ZAPATA',
'254' => 'ZAVALA','');

tran_type_desc(string2 code)

:= case(code, 
'03' => 'DUPLICATE REGISTRATION',
'04' => 'RENEWAL',
'05' => 'RENEWAL/ADDRESS CHANGE',
'06' => 'STOLEN',
'08' => 'CORRECTION REGISTRATION',
'10' => 'ORIGINAL TITLE - NO REGISTRATION',
'11' => 'ORIGINAL TITLE - ORIGINAL REG. (NEW)',
'12' => 'ORIGINAL TITLE - ORIGINAL TRANSFER REG.',
'17' => 'ORIGINAL TITLE - TRANSFER/RENEWAL REG.',
'22' => 'TRANSFER TITLE - TRANSFER REG.',
'27' => 'TRANSFER TITLE - TRANSFER/RENEWAL REG.',
'30' => 'CERTIFIED COPY TITLE',
'38' => 'CORRECTION CERTIFIED COPY',
'40' => 'DUPLICATE NON-NEGOTIABLE TITLE',
'60' => 'DUPLICATE DECALS',
'66' => 'OWNER INFORMATION PRINT',
'80' => 'CORRECTION TITLE',
'88' => 'CORRECTION TITLE AND REGISTRATION',
'90' => 'REMOVE LIEN','');

Watercraft.Macro_Clean_Hull_ID(watercraft.file_TX_clean_in_pre20060330, watercraft.layout_TX_clean_in_pre20060330,hull_clean_in)

watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.layout_TX_clean_in_pre20060330, wDatasetwithflag)

string fFixHullID(string pHullIDIn)
 := lib_stringlib.StringLib.StringFilter(lib_stringlib.stringlib.stringtouppercase(pHullIDIn),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ ');

watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := transform


    self.watercraft_key				        :=	if(trim(L.YEAR, left, right) >= '1972' and length(trim(fFixHullID(L.HULL_ID),left, right)) = 12 and L.is_hull_id_in_MIC, 
	                                            trim(fFixHullID(L.HULL_ID), left, right), if(fFixHullID(L.HULL_ID) <> '' and trim(fFixHullID(L.HULL_ID), left, right) <> 'UNKN'and 
												trim(fFixHullID(L.HULL_ID), left, right) <> 'UNKNOWN' and trim(L.YEAR, left, right) <> '19',
	                                            (trim(fFixHullID(L.HULL_ID), left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30],
	                                            (trim(L.MAKE, left, right) + trim(L.YEAR, left, right) + trim(L.NAME, left, right))[1..30]));
	self.sequence_key				        :=	L.REG_DATE;
	self.watercraft_id						:=	'';
	self.state_origin						:=	'TX';
	self.source_code						:=	'AW';
	self.st_registration					:=	TRIM(L.STATEABREV, left, right);
	self.county_registration				:=	county_reg(L.county);
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
	self.model_year							:=	if(length(L.YEAR)< 4, L.Year_Built, L.YEAR);
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
	self.registration_expiration_date		:=	L.Next_Renewal_Date;
	self.registration_status_code			:=	'';
	self.registration_status_description	:=	'';
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	'';
	self.transaction_type_code				:=	L.Transaction_Code;
	self.transaction_type_description		:=	tran_type_desc(L.Transaction_Code);
	self.title_state						:=	'';
	self.title_status_code					:=	'';
	self.title_status_description			:=	'';
	self.title_number						:=	if(L.Title_Number<> 'NOT-TITLED', L.Title_Number, '');
	self.title_issue_date					:=	L.Title_Date;
	self.title_type_code					:=	'';
	self.title_type_description				:=	'';
	self.additional_owner_count				:=	'';
	self.lien_1_indicator					:=	if(L.Lien_Name <> '', 'Y', 'N');
	self.lien_1_name						:=	L.Lien_Name;
	self.lien_1_date						:=	L.Lien_Date;
	self.lien_1_address_1					:=	L.Lien_Address_1st_Line;
	self.lien_1_address_2					:=	L.Lien_Address_2nd_Line;
	self.lien_1_city						:=	L.Lien_City;
	self.lien_1_state						:=	L.Lien_State;
	self.lien_1_zip							:=	L.Lien_Zip;
	self.lien_2_indicator					:=	if(L.Second_Lien_Name <> '', 'Y', 'N');
	self.lien_2_name						:=	L.Second_Lien_Name;
	self.lien_2_date						:=	L.Second_Lien_Date;
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



export Mapping_TX_as_Main_pre20060330 := project(wDatasetwithflag, main_mapping_format(left));
