import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;

// translates ga_phase01.mp Ab intio graph into ECL

watercraft_class_desc(string1 code)
 := case(code,
'1'=> 'BOAT LENGTHS 16\' UP TO 25\'11\"',
'2'=> 'BOAT LENGTHS 26\' UP TO 39\'11\"',
'3'=> 'BOAT LENGTHS 40\' AND OVER',
'A'=> 'BOAT LENGTHS UP TO 15\'11\"',
'');

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
'1'=> 'YES',
'2'=> '',
'3'=> 'RECOVERED',
'Y'=> 'YES',
'N'=> 'NO','');


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
'');

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_GA_clean_in, Watercraft.Layout_GA_new14Q2, hull_clean_in)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := transform
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	stringlib.StringFindReplace(IF(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, trim(L.HULL_ID,left,right),
																														// IF(L.HULL_ID = '', trim(L.Reg_num,left,right) + IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																															// (trim(L.HULL_ID,left,right) +  IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30])),' ','');
	self.watercraft_key			:=	if(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, trim(L.HULL_ID,left,right),
	                               if(L.HULL_ID = '', trim(L.Reg_num,left,right), trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30]);
	self.sequence_key				:=	trim(L.reg_date,left,right);
	self.state_origin				:=	'GA';
	self.source_code				:=	'AW';
	self.st_registration		:=	L.STATEABREV;
	self.county_registration		:=	L.county;
	self.registration_number		:=	trim(L.REG_NUM, left, right);
	self.hull_number						:=	L.HULL_ID;
	self.propulsion_description		:=	L.PROP;
	self.vehicle_type_Description	:=	L.VEH_TYPE;
	self.fuel_description					:=	L.FUEL;
	self.hull_type_description		:=	L.HULL;
	self.use_description					:=	L.USE_1;
	self.watercraft_length				:=	L.TOTAL_INCH;
	self.model_year								:=	L.YEAR;
	self.watercraft_class_code		:=	L.LENGTH_CLASS;
	self.watercraft_class_description	:=	watercraft_class_desc(L.LENGTH_CLASS);
	self.watercraft_make_description	:=	L.MAKE;
	self.watercraft_toilet_code				:=	L.TOILET;
	self.watercraft_toilet_description	:=	case(L.TOILET,'1' => 'YES','2' => 'NO','');
	IsValidRegDate										:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date						:=	IF(IsValidRegDate,L.REG_DATE,'');
	IsValidExpireDate									:=	STD.DATE.IsValidDate((integer)L.REG_EXPIRE);
	self.registration_expiration_date	:=	If(IsValidExpireDate,L.REG_EXPIRE,'');
	self := L;
	self := [];
  end;

EXPORT Map_GA_raw_to_Main := project(hull_clean_in, main_mapping_format(left));