

import watercraft;


county_reg(string3 code)

:= case(code, 	
'001' => 'ADAMS',
'002' => 'ALEXANDER',
'003' => 'BOND',
'004' => 'BOONE',
'005' => 'BROWN',
'006' => 'BUREAU',
'007' => 'CALHOUN',
'008' => 'CARROLL',
'009' => 'CASS',
'010' => 'CHAMPAIGN',
'011' => 'CHRISTIAN',
'012' => 'CLARK',
'013' => 'CLAY',
'014' => 'CLINTON',
'015' => 'COLES',
'016' => 'COOK',
'017' => 'CRAWFORD',
'018' => 'CUMBERLAND',
'019' => 'DEKALB',
'020' => 'DEWITT',
'021' => 'DOUGLAS',
'022' => 'DUPAGE',
'023' => 'EDGAR',
'024' => 'EDWARDS',
'025' => 'EFFINGHAM',
'026' => 'FAYETTE',
'027' => 'FORD',
'028' => 'FRANKLIN',
'029' => 'FULTON',
'030' => 'GALLATIN',
'031' => 'GREENE',
'032' => 'GRUNDY',
'033' => 'HAMILTON',
'034' => 'HANCOCK',
'035' => 'HARDIN',
'036' => 'HENDERSON',
'037' => 'HENRY',
'038' => 'IROQUOIS',
'039' => 'JACKSON',
'040' => 'JASPER',
'041' => 'JEFFERSON',
'042' => 'JERSEY',
'043' => 'JODAVIESS',
'044' => 'JOHNSON',
'045' => 'KANE',
'046' => 'KANKAKEE',
'047' => 'KENDALL',
'048' => 'KNOX',
'049' => 'LAKE',
'050' => 'LASALLE',
'051' => 'LAWRENCE',
'052' => 'LEE',
'053' => 'LIVINGSTON',
'054' => 'LOGAN',
'055' => 'MCDONOUGH',
'056' => 'MCHENRY',
'057' => 'MCLEAN',
'058' => 'MACON',
'059' => 'MACOUPIN',
'060' => 'MADISON',
'061' => 'MARION',
'062' => 'MARSHALL',
'063' => 'MASON',
'064' => 'MASSAC',
'065' => 'MENARD',
'066' => 'MERCER',
'067' => 'MONROE',
'068' => 'MONTGOMERY',
'069' => 'MORGAN',
'070' => 'MOULTRIE',
'071' => 'OGLE',
'072' => 'PEORIA',
'073' => 'PERRY',
'074' => 'PIATT',
'075' => 'PIKE',
'076' => 'POPE',
'077' => 'PULASKI',
'078' => 'PUTNAM',
'079' => 'RANDOLPH',
'080' => 'RICHLAND',
'081' => 'ROCKISLAND',
'082' => 'STCLAIR',
'083' => 'SALINE',
'084' => 'SANGAMON',
'085' => 'SCHUYLER',
'086' => 'SCOTT',
'087' => 'SHELBY',
'088' => 'STARK',
'089' => 'STEPHENSON',
'090' => 'TAZEWELL',
'091' => 'UNION',
'092' => 'VERMILION',
'093' => 'WABASH',
'094' => 'WARREN',
'095' => 'WASHINGTON',
'096' => 'WAYNE',
'097' => 'WHITE',
'098' => 'WHITESIDE',
'099' => 'WILL',
'100' => 'WILLIAMSON',
'101' => 'WINNEBAGO',
'102' => 'WOODFORD',
'103' => 'INDIANA',
'104' => 'IOWA',
'105' => 'KENTUCKY',
'106' => 'MICHIGAN',
'107' => 'MISSOURI',
'108' => 'WISCONSIN',
'109' => 'OTHER',
         
		  '' ); 
		  
watercraft_color_desc(string3 code)
:= case(code, 		  
'AME' => 'AMETHYST',
'BGE' => 'BEIGE',
'BLK' => 'BLACK',
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
'TAN' => 'TAN',
'TPE' => 'TAUPE',
'TRQ' => 'TURQUOISE',
'UNK' => 'UNKNOWN',
'BLU' => 'BLUE',
'TEA' => 'TEAL',
'WHI' => 'WHITE',
'YEL' => 'YELLOW', '');
		  
		  
		  
reg_status_desc(string1 code)

:= case(code, 

'A' => 'ABANDONED',
'F' => 'FOREIGN TRANSFER',
'H' => 'HOLD',
'J' => 'JUNKED/WRECK/DISMNTL',
'L' => 'PLATE TRANSFER',
'M' => 'MESSAGE',
'N' => 'NON SUFFICIENT FUNDS',
'S' => 'STOP',
'T' => 'TRANSFER PENDING',
'W' => 'WITHHOLD','');

transaction_type_desc(string2 code)
 := case(code,
'00' => 'MAINTENANCE ACTION',
'01' => 'NEW APPLICATION',
'02' => 'RENEWAL',
'03' => 'TRANSFER',
'04' => 'TRANSFER RENEWAL',
'05' => 'DUPLICATE REGISTRATION',
'06' => 'DUPLICATE TITLE',
'07' => 'DUPLICATE DECAL',
'08' => 'CORRECTED REGISTRATION',
'09' => 'CORRECTED TITLE',
'10' => 'SCRAP/JUNK/DESTROY',
'11' => 'CANCEL REGISTRATION',
'12' => 'REVOKE OR SURRENDER TITLE',
'13' => 'REINSTATEMENT OF SUSPENSION',
'14' => 'INSUFFICIENT FUNDS',
'15' => 'REINSTATEMENT OF CANCELLATION',
'16' => 'TITLE SEARCH',

					'' );

title_status_desc(string1 code) 
:= case(code,
'0' => 'TEMPORARY PERMIT',
'1' => 'TITLE & REG',
'2' => 'TITLE ONLY',
'4' => 'NO ALASKA TITLE',
'5' => 'BOAT REGISTRATION','');

title_type_desc(string1 code) 

:= case(code,
'A' => '(NO DECODING VALUE GIVEN)',
'P' => 'PRORATE',
'S' => 'SNOW MCH',
'Y' => 'YEAR TAB', '');

Watercraft.Macro_Clean_Hull_ID(watercraft.file_AK_clean_in, watercraft.Layout_AK_clean_in,hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.Layout_AK_clean_in, wDatasetwithflag)


watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := transform


    self.watercraft_key				        :=	if(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left, right),
	                                            (trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right) + L.last_NAME + L.first_name + L.mid)[1..30]);                                          
	self.sequence_key				        :=	if(L.DMVStatusDate1 > L.REG_DATE, L.DMVStatusDate1, L.REG_DATE);
	self.watercraft_id						:=	'';
	self.state_origin						:=	'AK';
	self.source_code						:=	'AW';
	self.st_registration					:=	trim(L.STATEABREV, left, right);
	self.county_registration				:=	L.county;
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
	self.watercraft_class_code				:=	L.ClassCode;
	self.watercraft_class_description		:=	case(L.ClassCode, 'B1'=> 'MOTORIZED BOATS', 'B2'=>'NON-MOTORIZED BOATS', '');
	self.watercraft_make_code				:=	'';
	self.watercraft_make_description		:=	L.MAKE;
	self.watercraft_model_code				:=	'';
	self.watercraft_model_description		:=	'';
	self.watercraft_width					:=	'';
	self.watercraft_weight					:=	if(L.Weight <> '00000', L.Weight,'');
	self.watercraft_color_1_code			:=	L.HullColor;
	self.watercraft_color_1_description		:=	watercraft_color_desc(L.HullColor);
	self.watercraft_color_2_code			:=	L.TrimColor;
	self.watercraft_color_2_description		:=	watercraft_color_desc(L.TrimColor);
	self.watercraft_toilet_code				:=	'';
	self.watercraft_toilet_description		:=	'';
	self.watercraft_number_of_engines		:=	'';
	self.watercraft_hp_1					:=	L.HP;
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
	self.registration_expiration_date		:=	L.RegYearExpire + L.RegMoExpire;
	self.registration_status_code			:=	L.DMVStatusCode;
	self.registration_status_description	:=	reg_status_desc(L.DMVStatusCode);
	self.registration_status_date			:=	L.DMVStatusDate1;
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	L.Reg_LicNum;
	self.transaction_type_code				:=	'';
	self.transaction_type_description		:=	'';
	self.title_state						:=	'';
	self.title_status_code					:=	'';
	self.title_status_description			:=	'';
	self.title_number						:=	L.Title_Num;
	self.title_issue_date					:=  '';
	self.title_type_code					:=	L.RegType;
	self.title_type_description				:=	title_type_desc(L.RegType);
	self.additional_owner_count				:=	'';
	self.lien_1_indicator					:=	'';
	self.lien_1_name						:=	'';
	self.lien_1_date						:=	'';
	self.lien_1_address_1					:=	L.LienAddress1;
	self.lien_1_address_2					:=	L.LienAddress2;
	self.lien_1_city						:=	L.LienCity;
	self.lien_1_state						:=	L.LienState;
	self.lien_1_zip							:=	L.LienZip +'-'+ L.LienZip4;
	self.lien_2_indicator					:=	'';
	self.lien_2_name						:=	'';
	self.lien_2_date						:=	'';
	self.lien_2_address_1					:=	'';
	self.lien_2_address_2					:=	'';
	self.lien_2_city						:=	'';
	self.lien_2_state						:=	'';
	self.lien_2_zip							:=	'';
	self.state_purchased					:=	'';
	self.purchase_date						:=	L.OwnershipDate1;
	self.dealer								:=	'';
	self.purchase_price						:=	'';
	self.new_used_flag						:=	'';
	self.watercraft_status_code				:=	'';
	self.watercraft_status_description		:=	'';
	self.history_flag						:=	'';
	self.coastguard_flag					:=	'';
	self.signatory                          := case(stringlib.StringToUpperCase(L.ConJuntnCode1), 'AND'=> 'YES', 'OR'=>'NO', '');
	
end;



export Mapping_AK_as_Main := project(wDatasetwithflag, main_mapping_format(left));


	

	
	



