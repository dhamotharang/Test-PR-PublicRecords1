import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// Translates or_phase01_mod_V002.ksh*

county_reg(string2 code) := case(code,
'01' => 'BAKER',
'02' => 'BENTON',
'03' => 'CLACKAMAS',
'04' => 'CLATSOP',
'05' => 'COLUMBIA',
'06' => 'COOS',
'07' => 'CROOK',
'08' => 'CURRY',
'09' => 'DESCHUTES',
'10' => 'DOUGLAS',
'11' => 'GILLIAM',
'12' => 'GRANT',
'13' => 'HARNEY',
'14' => 'HOOD RIVER',
'15' => 'JACKSON',
'16' => 'JEFFERSON',
'17' => 'JOSEPHINE',
'18' => 'KLAMATH',
'19' => 'LAKE',
'20' => 'LANE',
'21' => 'LINCOLN',
'22' => 'LINN',
'23' => 'MALHEUR',
'24' => 'MARION',
'25' => 'MORROW',
'26' => 'MULTNOMAH',
'27' => 'POLK',
'28' => 'SHERMAN',
'29' => 'TILLAMOOK',
'30' => 'UMATILLA',
'31' => 'UNION',
'32' => 'WALLOWA',
'33' => 'WASCO',
'34' => 'WASHINGTON',
'35' => 'WHEELER',
'36' => 'YAMHILL', '');

VEH_TYPE_DESC(string2 code) := case(code,
'1' => 'OPEN BOAT',
'2' => 'CABIN CRUISER',
'3' => 'CRUISING HOUSEBOAT',
'4' => 'OTHER',
'5' => 'PERSONAL WATERCRAFT', '');

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_OR_clean_in, Watercraft.layout_or_new_14q3, hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, Watercraft.layout_or_new_14q3, wDatasetwithflag)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := TRANSFORM
	// New watercraft_key logic to be implemented at a later date
	// self.watercraft_key		:=	stringlib.StringFindReplace(IF(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right), 
																													// IF(length(trim(L.HULL_ID,left, right)) = 12 and trim(L.year, left, right) = '0', trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM,left,right) <> '', trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																																	//trim(L.NAME,left,right)+IF(trim(L.MAKE,left,right)<>'',trim(L.MAKE,left,right),'')+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),'')))),' ','');
	self.watercraft_key			:=	if(trim(L.YEAR, left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
	                               if(trim(L.HULL_ID,left,right) <> 'VARIOUS'and trim(L.HULL_ID,left,right) <> 'UNKNOWN',
																	trim(L.HULL_ID,left,right) + IF(L.MAKE = 'MANUFACTURER NOT SPECIFIE','',trim(L.MAKE,left,right)) + trim(L.YEAR,left,right),
																	trim(L.MAKE,left,right) + trim(L.YEAR,left,right) + trim(L.NAME,left,right)));
	self.sequence_key				:=	L.REG_DATE;
	self.state_origin				:=	'OR';
	self.source_code				:=	'AW';
	self.st_registration			:=	L.STATEABREV;
	self.county_registration	:=	county_reg(L.COUNTY);
	self.registration_number	:=	L.REG_NUM;
	self.hull_number					:=	L.HULL_ID;
	self.propulsion_description		:=	L.PROP;
	self.vehicle_type_Description	:=	L.VEH_TYPE;
	self.fuel_description					:=	L.FUEL;
	self.hull_type_description		:=	L.HULL;
	self.use_description					:=	L.USE_1;
	self.watercraft_length				:=	L.TOTAL_INCH;
	self.model_year								:=	If(L.YEAR <> '0', L.YEAR, '');
	self.watercraft_make_description	:=	IF(L.MAKE = 'MANUFACTURER NOT SPECIFIE','',L.MAKE);
	IsValidRegDate										:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date						:=	If(IsValidRegDate,L.REG_DATE,'');
	IsValidExpireDate									:=	STD.DATE.IsValidDate((integer)L.REG_EXPIRES_DATE);
	self.registration_expiration_date	:=	If(IsValidExpireDate,L.REG_EXPIRES_DATE,'');
	self.title_number									:=	TRIM(L.TITLE_NUMBER,LEFT,RIGHT);
	IsValidTitleDate									:=	STD.DATE.IsValidDate((integer)L.TITLE_ISSUE_DATE);
	self.title_issue_date							:=	If(IsValidTitleDate,L.TITLE_ISSUE_DATE,'');
	self.lien_1_indicator							:=	If(L.LIENHOLDER <> '', 'Y','');
	self.lien_1_name									:=	L.LIENHOLDER;
	IsValidPurDate										:=	STD.DATE.IsValidDate((integer)L.PURCHASE_DATE);
	self.purchase_date								:=	If(IsValidPurDate,L.PURCHASE_DATE,'');
	self := L;
	self := [];
END;

//IF PUBLIC_ASSET_FLAG = 'NO', NOT AVAILABLE FOR PUBLIC USE
EXPORT Map_OR_raw_to_Main := project(wDatasetwithflag(PUBLIC_ASSET_FLAG <> 'NO'), main_mapping_format(left));