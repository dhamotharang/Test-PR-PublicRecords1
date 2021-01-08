import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// Translates ne_phase01_update.mp

county_reg(string2 code) := case(code,
'01' => 'DOUGLAS',
'02' => 'LANCASTER',
'03' => 'GAGE',
'04' => 'CUSTER',
'05' => 'DODGE',
'06' => 'SAUNDERS',
'07' => 'MADISON',
'08' => 'HALL',
'09' => 'BUFFALO',
'10' => 'PLATTE',
'11' => 'OTOE',
'12' => 'KNOX',
'13' => 'CEDAR',
'14' => 'ADAMS',
'15' => 'LINCOLN',
'16' => 'SEWARD',
'17' => 'YORK',
'18' => 'DAWSON',
'19' => 'RICHARDSON',
'20' => 'CASS',
'21' => 'SCOTTS BLUFF',
'22' => 'SALINE',
'23' => 'BOONE',
'24' => 'CUMING',
'25' => 'BUTLER',
'26' => 'ANTELOPE',
'27' => 'WAYNE',
'28' => 'HAMILTON',
'29' => 'WASHINGTON',
'30' => 'CLAY',
'31' => 'BURT',
'32' => 'THAYER',
'33' => 'JEFFERSON',
'34' => 'FILLMORE',
'35' => 'DIXON',
'36' => 'HOLT',
'37' => 'PHELPS',
'38' => 'FURNAS',
'39' => 'CHEYENNE',
'40' => 'PIERCE',
'41' => 'POLK',
'42' => 'NUCKOLLS',
'43' => 'COLFAX',
'44' => 'NEMAHA',
'45' => 'WEBSTER',
'46' => 'MERRICK',
'47' => 'VALLEY',
'48' => 'RED WILLOW',
'49' => 'HOWARD',
'50' => 'FRANKLIN',
'51' => 'HARLAN',
'52' => 'KEARNEY',
'53' => 'STANTON',
'54' => 'PAWNEE',
'55' => 'THURSTON',
'56' => 'SHERMAN',
'57' => 'JOHNSON',
'58' => 'NANCE',
'59' => 'SARPY',
'60' => 'FRONTIER',
'61' => 'SHERIDAN',
'62' => 'GREELEY',
'63' => 'BOYD',
'64' => 'MORRILL',
'65' => 'BOX BUTTE',
'66' => 'CHERRY',
'67' => 'HITCHCOCK',
'68' => 'KEITH',
'69' => 'DAWES',
'70' => 'DAKOTA',
'71' => 'KIMBALL',
'72' => 'CHASE',
'73' => 'GOSPER',
'74' => 'PERKINS',
'75' => 'BROWN',
'76' => 'DUNDY',
'77' => 'GARDEN',
'78' => 'DEUEL',
'79' => 'HAYES',
'80' => 'SIOUX',
'81' => 'ROCK',
'82' => 'KEYA PAHA',
'83' => 'GARFIELD',
'84' => 'WHEELER',
'85' => 'BANNER',
'86' => 'BLAINE',
'87' => 'LOGAN',
'88' => 'LOUP',
'89' => 'THOMAS',
'90' => 'MCPHERSON',
'91' => 'ARTHUR',
'92' => 'GRANT',
'93' => 'HOOKER', '');

watercraft_color_desc(string3 code)
:= case(code, 		  
'AME' => 'AMETHYST',
'BGE' => 'BEIGE',
'BLK' => 'BLACK',
'BLU' => 'BLUE',
'BRO' => 'BROWN',
'BRZ' => 'BRONZE',
'CAM' => 'CAMOUFLAGE',
'COL' => 'COLORED (USE WITH MUL)',
'COM' => 'CHROME (STAINLESS STEEL)',
'CPR' => 'COPPER',
'CRM' => 'CREAM',
'DBL' => 'DARK BLUE',
'DGR' => 'DARK GREEN',
'GLD' => 'GOLD',
'GRN' => 'GREEN',
'GRY' => 'GRAY',
'LAV' => 'LAVENDER',
'LBL' => 'LIGHT BLUE',
'LGR' => 'LIGHT GREEN',
'MAR' => 'MAROON',
'MUL' => 'MULTICOLORED',
'MVE' => 'MAUVE',
'ONG' => 'ORANGE',
'PLE' => 'PURPLE',
'PNK' => 'PINK',
'RED' => 'RED',
'SIL' => 'SILVER/ALUMINUM',
'SCN' => '',
'TAN' => 'TAN',
'TPE' => 'TAUPE',
'TRQ' => 'TURQUOISE',
'UNK' => 'UNKNOWN',
'YEL' => 'YELLOW', 
'WHI' => 'WHITE', '');

file_NE_dedup := dedup(sort(watercraft_preprocess.file_NE_clean_in, reg_date, reg_num), reg_date, reg_num);

Watercraft.Macro_Clean_Hull_ID(file_NE_dedup, watercraft.Layout_NE, hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.Layout_NE, wDatasetwithflag)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := TRANSFORM
	// New watercraft_key logic to be implemented at a later date
	// self.watercraft_key		:=	stringlib.StringFindReplace(IF(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right), 
																													// IF(length(trim(L.HULL_ID,left, right)) = 12 and trim(L.year, left, right) = '0', trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM,left,right) <> '', L.STATEABREV+trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																																	//trim(L.NAME,left,right)+IF(trim(L.MAKE,left,right)<>'',trim(L.MAKE,left,right),'')+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),'')))),' ','');
	self.watercraft_key		:=	if(trim(L.YEAR,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right), if(L.HULL_ID = '',
	                             (trim(L.MAKE,left,right) + trim(L.YEAR,left,right) + trim(L.NAME,left,right))[1..30], (trim(L.HULL_ID,left,right) + 
																trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30]));
	self.sequence_key			:=	IF(TRIM(L.REG_DATE) = '', L.TITLE_DATE, L.REG_DATE);
	self.state_origin			:=	'NE';
	self.source_code			:=	'AW';
	self.st_registration					:=	L.STATEABREV;
	self.county_registration			:=	county_reg(trim(L.county,left,right));
	self.registration_number			:=	trim(L.REG_NUM, left, right);
	self.hull_number							:=	L.hull_id;
	self.propulsion_description		:=	L.PROP;
	self.fuel_description					:=	L.FUEL;
	self.hull_type_description		:=	L.HULL;
	self.watercraft_length				:=	L.TOTAL_INCH;
	self.model_year								:=	L.YEAR;
	self.watercraft_make_description	:=	L.MAKE;
	self.watercraft_model_description	:= L.MODEL_DESC;
	//self.watercraft_color_1_code			:=	L.COLOR;
	self.watercraft_color_1_description	:=	L.COLOR;
	//self.watercraft_color_2_code				:=	L.Secondary_Color;
	self.watercraft_color_2_description	:=	L.SECONDARY_COLOR;
	IsValidRegDate											:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date							:=	If(IsValidRegDate,L.REG_DATE,'');
	IsValidExpireDate										:=	STD.DATE.IsValidDate((integer)L.REG_EXPIRE);
	self.registration_expiration_date		:=	IF(IsValidExpireDate,L.REG_EXPIRE,'');
	self.title_state										:=	L.TITLE_STATE;
	self.title_number										:=	L.TITLE_NUMBER;
	IsValidTitleDate										:=	STD.DATE.IsValidDate((integer)L.TITLE_DATE);
	self.title_issue_date								:=	If(IsValidTitleDate,L.TITLE_DATE,'');
	self.title_type_code								:=	L.TITLE_TYPE;
	self.title_type_description					:=	MAP(L.TITLE_TYPE = 'C' => 'CORRECTED TITLE',
																							L.TITLE_TYPE = 'D' => 'DUPLICATE TITLE',
																							L.TITLE_TYPE = 'N' => 'NON-TRANSFERABLE TITLE',
																							L.TITLE_TYPE = 'O' => 'ORIGINAL TITLE',
																							L.TITLE_TYPE = 'R' => 'REBUILD TITLE',
																							'');
	IsValidPurchase											:= STD.DATE.IsValidDate((integer)L.ACQUISITION);
	self.purchase_date									:= IF(IsValidPurchase, L.ACQUISITION,'');
	self := L;
	self := [];
END;

EXPORT Map_NE_raw_to_Main := project(wDatasetwithflag, main_mapping_format(left));