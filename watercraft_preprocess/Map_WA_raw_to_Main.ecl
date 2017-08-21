import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

county_reg(string2 code)
:= case(code,
'1' => 'ADAMS',
'2' => 'ASOTIN',
'3' => 'BENTON',
'4' => 'CHELAN',
'5' => 'CLALLAM',
'6' => 'CLARK',
'7' => 'COLUMBIA',
'8' => 'COWLITZ',
'9' => 'DOUGLAS',
'10' => 'FERRY',
'11' => 'FRANKLIN',
'12' => 'GARFIELD',
'13' => 'GRANT',
'14' => 'GRAYS HARBOR',
'15' => 'ISLAND',
'16' => 'JEFFERSON',
'17' => 'KING',
'18' => 'KITSAP',
'19' => 'KITTITAS',
'20' => 'KLICKITAT',
'21' => 'LEWIS',
'22' => 'LINCOLN',
'23' => 'MASON',
'24' => 'OKANOGAN',
'25' => 'PACIFIC',
'26' => 'PEND ORIELLE',
'27' => 'PIERCE',
'28' => 'SAN JUAN',
'29' => 'SKAGIT',
'30' => 'SKAMANIA',
'31' => 'SNOHOMISH',
'32' => 'SPOKANE',
'33' => 'STEVENS',
'34' => 'THURSTON',
'35' => 'WAHKIAKUM',
'36' => 'WALLA WALLA',
'37' => 'WHATCOM',
'38' => 'WHITMAN',
'39' => 'YAKIMA',
'40' => 'DOL/COUNTY 40',
'71' => 'DOL/MORTON',
'77' => 'DOL/PARKLAND' , '');

FUEL_desc(string fuel)
:= case(fuel,
'D'	=> 'DIESEL',
'E'	=> 'ELECTRIC',
'G'	=> 'GAS',
'P'	=> 'PROPANE',
'S'	=> 'SAIL',
'X'	=> 'UNKNOWN', fuel);

HULL_desc(string hull)
:= case(hull,
'A'	=> 'ALUMINUM',
'C'	=> 'CONCRETE',
'P'	=> 'PLASTIC',
'R'	=> 'RUBBER',
'S'	=> 'STEEL',
'W'	=> 'WOOD',
'X'=> 'UNKNOWN', hull);

PROP_desc(string prop)
:= case(prop,	
'D'	=> 'STERN',
'I'	=> 'INBOARD',
'J'	=> 'JET',
'O'	=> 'OUTBOARD',
'S'	=> 'SAIL',
'X'	=> 'OTHER',prop); 

USE_desc(string use)
:= case(use, 		
'C'	=> 'COMMERCIAL - PASSENGER'	,
'D'	=> 'DEALER'	,
'F'	=> 'COMMERCIAL - FISH'	,
'L'	=> 'RENTAL'	,
'M'	=> 'MANUFACTURER'	,
'P'	=> 'PLEASURE'	,
'X'	=> 'UNKNOWN',use); 

VEH_TYPE(string VEH_TYPE )
:= case(VEH_TYPE, 
'C'	=> 'CABIN',
'H'	=> 'HOUSEBOAT',
'J'	=> 'PWC',
'R'	=> 'RUNABOUT',
'S'	=> 'SAILBOAT',
'X'	=> 'OTHER',VEH_TYPE);

TRANSACTION_DESC(string TRANS_DESC)
:= case(TRANS_DESC,
'0'	=>	'NSF DHC TRANSACTIONS',
'1' =>	'ORIGINAL TITLE APPLICATION',
'2'	=>	'TRANSFER TITLE WITH CORRECTION AND REPLACEMENT',
'3'	=>	'TRANSFER WITH CORRECTION',
'4'	=>	'TRANSFER WITH REPLACEMENT',
'5'	=>	'TRANSFER',
'6'	=>	'REISSUE WITH CORRECTION AND REPLACEMENT',
'7'	=>	'REISSUE WITH CORRECTION',
'8'	=>	'REISSUE WITH REPLACEMENT',
'9'	=>	'REISSUE',
'10'	=>	'DUPLICATE WITH CORRECTION AND REPLACEMENT',
'11'	=>	'DUPLICATE WITH CORRECTION',
'12'	=>	'DUPLICATE WITH REPLACEMENT',
'13'	=>	'DUPLICATE',
'14'	=>	'CORRECTION WITH REPLACEMENT',
'15'	=>	'CORRECTED TITLE',
'16'	=>	'REPLACEMENT REGISTRATION',
'17'	=>	'PURGE',
'18'	=>	'REPRINT TITLE',
'19'	=>	'TITLE VERIFY UPDATE',
'20'	=>	'PIC AND/OR UBI CHANGE',
'21'	=>	'MISCELLANEOUS CORRECTION',
'22'	=>	'CORRECTION INDUSTRIES CORRECTION',
'23'	=>	'REPRINT RENEWAL',
'24'	=>	'REPRINT CORRECTION',
'25'	=>	'REPRINT RENEWAL, REPLACE REGISTRATION',
'27'	=>	'REPRINT CORRECTION, REPLACE REGISTRATION',
'30'	=>	'PREBILL RENEWAL',
'31'	=>	'MANUAL DUPLICATE REGISTRATION',
'32'	=>	'MANUAL RENEWAL',
'33'	=>	'MANUAL RENEWAL, REPLACE REGISTRATION',
'34'	=>	'MANUAL CORRECTION',
'35'	=>	'MANUAL REPLACEMENT REGISTRATION WITH NO RENEWAL',
'36'	=>	'MANUAL DUPLICATE REGISTRATION',
'37'	=>	'MANUAL REPLACE DECAL',
'38'	=>	'LEGAL OWNER ADDRESS CHANGE',
'39'	=>	'REGISTERED OWNER ADDRESS CHANGE',
'40'	=>	'CHARGE BACK (ON INTERNET RENEWAL TRANSACTIONS)',
'41'	=>	'INTERNET RENEWAL', TRANS_DESC);

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_WA_clean_in, watercraft.Layout_wa, hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.Layout_wa, wDatasetwithflag)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := TRANSFORM
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	stringlib.StringFindReplace(IF(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
																														// IF(length(trim(L.HULL_ID,left, right)) = 12 and trim(L.year, left, right) = '0', trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM,left,right) <> '', trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																																	// trim(L.HULL_ID,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),'')))),' ','');
	self.watercraft_key			:=	if(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) >= '1972' and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
																				(trim(L.HULL_ID,left,right) + trim(StringLib.stringfilterout(L.MAKE,' '),left,right) + trim(L.YEAR,left,right) + trim(StringLib.stringfilterout(L.NAME,'  ,-/'),left,right))[1..30]);                               
	self.sequence_key				:=	trim(L.REG_DATE,left,right);
	self.state_origin				:=	'WA';
	self.source_code				:=	'AW';
	self.st_registration			:=	L.STATEABREV;
	self.county_registration	:=	county_reg(trim(L.COUNTY_OF_MOORAGE,left,right));
	self.registration_number	:=	L.REG_NUM;
	self.hull_number					:=	L.HULL_ID;
	self.propulsion_description		:=	L.PROP;
	self.vehicle_type_Description	:=	L.VEH_TYPE;
	self.fuel_description					:=	L.FUEL;
	self.hull_type_description		:=	L.HULL;
	self.use_description					:=	L.USE;
	self.watercraft_length				:=	L.TOTAL_INCH;
	self.model_year								:=	L.YEAR;
	self.watercraft_make_description	:=	L.MAKE;
	ValidRegDate											:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date						:=	IF(ValidRegDate,L.REG_DATE,'');
	ValidExpireDate										:=	STD.DATE.IsValidDate((integer)L.EXPIRATION_DATE);
	self.registration_expiration_date	:=	L.EXPIRATION_DATE;//IF(ValidExpireDate,L.EXPIRATION_DATE,'');
	self.decal_number									:=	L.CURRENT_DECAL_NUMBER;
	self.transaction_type_code				:=	L.LAST_TRANSACTION_CODE;
	self.transaction_type_description	:=	TRANSACTION_DESC(TRIM(L.LAST_TRANSACTION_CODE,LEFT,RIGHT));
	self.title_number									:=	L.TITLE_NUMBER;
	self.additional_owner_count				:=	IF(stringlib.stringfind(L.Reg_Owner_Name_2,',',1)>0,'1','');
	self.purchase_date								:=	L.PURCHASE_YEAR;
	self.dealer												:=	L.DEALER_NUMBER; // code
	self.purchase_price								:=	L.PURCHASE_COST;
	self.watercraft_status_code				:=	IF(L.DESTROYED = '1', L.DESTROYED,
																					IF(L.STOLEN = '1', L.STOLEN,''));
	self.watercraft_status_description	:=	IF(L.DESTROYED = '1', 'DESTROYED',
																						IF(L.STOLEN = '1', 'STOLEN',''));
	self := L;
	self := [];
END;

EXPORT Map_WA_raw_to_Main := project(wDatasetwithflag, main_mapping_format(left));