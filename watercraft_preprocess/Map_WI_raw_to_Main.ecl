import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// Translates wi_01.mp

county_reg(string1 code) :=
case(code, 
'01' => 'ADAMS',
'02' => 'ASHLAND',
'03' => 'BARRON',
'04' => 'BAYFIELD',
'05' => 'BROWN',
'06' => 'BUFFALO',
'07' => 'BURNETT',
'08' => 'CALUMET',
'09' => 'CHIPPEWA',
'10' => 'CLARK',
'11' => 'COLUMBIA',
'12' => 'CRAWFORD',
'13' => 'DANE',
'14' => 'DODGE',
'15' => 'DOOR',
'16' => 'DOUGLAS',
'17' => 'DUNN',
'18' => 'EAU CLAIRE',
'19' => 'FLORENCE',
'20' => 'FOND DU LAC',
'21' => 'FOREST',
'22' => 'GRANT',
'23' => 'GREEN',
'24' => 'GREEN LAKE',
'25' => 'IOWA',
'26' => 'IRON',
'27' => 'JACKSON',
'28' => 'JEFFERSON',
'29' => 'JUNEAU',
'30' => 'KENOSHA',
'31' => 'KEWAUNEE',
'32' => 'LA CROSSE',
'33' => 'LAFAYETTE',
'34' => 'LANGLADE',
'35' => 'LINCOLN',
'36' => 'MANITOWOC',
'37' => 'MARATHON',
'38' => 'MARINETTE',
'39' => 'MARQUETTE',
'40' => 'MENOMINEE',
'41' => 'MILWAUKEE',
'42' => 'MONROE',
'43' => 'OCONTO',
'44' => 'ONEIDA',
'45' => 'OUTAGAMIE',
'46' => 'OZAUKEE',
'47' => 'PEPIN',
'48' => 'PIERCE',
'49' => 'POLK',
'50' => 'PORTAGE',
'51' => 'PRICE',
'52' => 'RACINE',
'53' => 'RICHLAND',
'54' => 'ROCK',
'55' => 'RUSK',
'56' => 'ST CROIX',
'57' => 'SAUK',
'58' => 'SAWYER',
'59' => 'SHAWANO',
'60' => 'SHEBOYGAN',
'61' => 'TAYLOR',
'62' => 'TREMPEALEAU',
'63' => 'VERNON',
'64' => 'VILAS',
'65' => 'WALWORTH',
'66' => 'WASHBURN',
'67' => 'WASHINGTON',
'68' => 'WAUKESHA',
'69' => 'WAUPACA',
'70' => 'WAUSHARA',
'71' => 'WINNEBAGO',
'72' => 'WOOD', '');


reg_status_desc(string1 code) :=
case(code, 'A' => 'ACTIVE',
'B' => 'ABANDONED',
'D' => 'DOUBLE REGISTRATION',
'E' => 'EXPIRED',
'I' => 'INACTIVE',
'J' => 'JUNKED',
'M' => 'MOVED OUT-OF-STATE (MOS)',
'P' => 'PENDING',
'S' => 'SOLD', '');

propulsion_desc(string1 code) :=
case(code, '1' => 'OUTBOARD',
'2' => 'INBOARD',
'3' => 'INBOARD/STERNDRIVE(I/O)',
'4' => 'AIRBOAT', '');

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_WI_clean_in, watercraft.Layout_WI_new.common, hull_clean_in)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := TRANSFORM
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	stringlib.StringFindReplace(IF(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12, trim(L.HULL_ID,left,right),
																														// IF(length(trim(L.HULL_ID,left, right)) = 12 and trim(L.year, left, right) = '0', trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM,left,right) <> '', L.STATEABREV +trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																																	// (trim(L.HULL_ID,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30]))),' ',''); 
	self.watercraft_key			:=	trim(L.REG_NUM,left,right);
	self.sequence_key				:=	if(trim(L.REG_DATE,left,right)<>'',L.REG_DATE,L.LAST_TRANSACTION_DATE);
	self.state_origin				:=	'WI';
	self.source_code				:=	'AW';
	self.st_registration			:=	trim(L.STATEABREV, left, right);
	self.county_registration	:=	county_reg(L.COUNTY);
	self.registration_number	:=	trim(L.REG_NUM, left, right);
	self.hull_number					:=	L.hull_id;
	self.propulsion_description		:=	if(trim(L.ENGINE_TYPE) <> '',propulsion_desc(L.ENGINE_TYPE), L.PROP);
	self.vehicle_type_Description	:=	L.VEH_TYPE;
	self.fuel_description					:=	L.FUEL;
	self.hull_type_description		:=	L.HULL;
	self.use_description					:=	L.USE_1;
	self.watercraft_length				:=	L.TOTAL_INCH;
	self.model_year								:=	L.YEAR;
	self.watercraft_name					:=	L.BOATNAME;
	self.watercraft_make_description	:=	L.MAKE;
	self.watercraft_model_description	:=	L.MODEL;
	self.coast_guard_number						:=	L.CGID;
	IsValidRegDate										:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date						:=	If(IsValidRegDate,L.REG_DATE,'');
	self.registration_expiration_date	:=	L.EXPIRE_YEAR;
	self.registration_status_code			:=	L.REG_STATUS;
	self.registration_status_description	:=	reg_status_desc(L.REG_STATUS);
	IsValidPurchDate											:=	STD.DATE.IsValidDate((integer)L.PUR_DATE);
	self.purchase_date										:=	L.PUR_DATE;
	self.coastguard_flag									:=	'Y';
	self := L;
	self := [];
END;

EXPORT Map_WI_raw_to_Main := project(hull_clean_in, main_mapping_format(left));