import lib_stringlib, watercraft, watercraft_preprocess, ut;

// Translates wi_01.mp

county_reg(string2 code) :=
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


propulsion_type(string1 code) :=
case(code, 
'1' => 'OUTBOARD',
'2' => 'INBOARD',
'3' => 'INBOARD/STERNDRIVE(I/O)',
'4' => 'AIRBOAT', '');


doc_certificate_status(string1 code) :=
case(code, 
'A' => 'AFFIDAVIT',
'C' => 'CERTIFICATE',
'G' => 'UNKNOWN',
'M' => 'MSO',
'N' => 'NOTARIZED STATEMENT',
'O' => 'OWNER',
'S' => 'SUPPORTING DOCUMENT (I.E. BILL OF SALE)',
'T' => 'TITLE',
'W' => 'WISCONSIN ASSIGNED', '');

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_WI_clean_in, watercraft.Layout_WI_new.common, hull_clean_in)

watercraft.Layout_Watercraft_Coastguard_Base main_mapping_format(hull_clean_in L) := transform
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	stringlib.StringFindReplace(IF(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12, trim(L.HULL_ID,left,right),
																														// IF(length(trim(L.HULL_ID,left, right)) = 12 and trim(L.year, left, right) = '0', trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM,left,right) <> '', L.STATEABREV +trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																																	// (trim(L.HULL_ID,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30]))),' ',''); 
	self.watercraft_key			:=	trim(L.REG_NUM,left,right);
	self.sequence_key				:=	if(trim(L.REG_DATE,left,right)<>'',L.REG_DATE,L.LAST_TRANSACTION_DATE);
	self.state_origin       :=  'WI';
	self.source_code        :=  'AW';
	self.vessel_database_key  := if(trim(L.FLEETID,left,right)= 'NULL', '', trim(L.FLEETID,left,right));
	self.name_of_vessel       :=  L.BOATNAME;
	self.hull_identification_number  :=  L.HULL_ID;
	self.vessel_service_type         :=  L.USE_1;
	self.home_port_name              :=  if(county_reg(L.COUNTY) <> '',county_reg(L.COUNTY) +'COUNTY', '');
	self.propulsion_type             :=  if(trim(L.ENGINE_TYPE) <> '',propulsion_type(L.ENGINE_TYPE), L.PROP);
//	self.doc_certificate_status      :=  doc_certificate_status(L.VERIFIED); //No longer codes
//Shortening long definitions in order to not have to change base layout
	tempVerify							:= ut.CleanSpacesAndUpper(L.VERIFIED);
	self.doc_certificate_status      := MAP(tempVerify = 'RECREATIONAL VEHICLE ITSELF' => 'REC VEHICLE',
																					tempVerify = 'REGISTRATION CERTIFICATE' => 'REGISTRATION',
																					tempVerify = 'SUPPORTING DOCUMENT/BILL OF SALE' => 'SUPPORT DOC',
																					tempVerify = '' => 'UNKNOWN',
																					tempVerify);
	self	:= L;
	self	:= [];
END;

EXPORT Map_WI_raw_to_CoastGuard := dedup(project(hull_clean_in, main_mapping_format(left)));