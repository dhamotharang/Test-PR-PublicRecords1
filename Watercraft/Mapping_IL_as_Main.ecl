import watercraft;


county_reg(string3 code)

:= case(code, 	'001' => 'ADAMS',
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
'BGE' => 'BEIGE',
'BLK' => 'BLACK',
'BLU' => 'BLUE',
'BRO' => 'BROWN',
'BRZ' => 'BRONZE',
'COM' => 'CHROME OR STAINLESS STEEL',
'CPR' => 'COPPER',
'CRM' => 'CREAM OR IVORY',
'DBL' => 'DARK BLUE',
'DGR' => 'DARK GREEN',
'GLD' => 'GOLD',
'GRN' => 'GREEN',
'GRY' => 'GRAY',
'LAV' => 'LAVENDER',
'LBL' => 'LIGHT BLUE',
'LGR' => 'LIGHT GREEN',
'MAR' => 'MAROON OR BURGUNDY',
'ONG' => 'ORANGE',
'PLE' => 'PURPLE',
'PNK' => 'PINK',
'RED' => 'RED',
'SIL' => 'ALUMINUM OR SILVER',
'TAN' => 'TAN',
'TRQ' => 'TURQUOISE',
'WHI' => 'WHITE',
'YEL' => 'YELLOW', '');
		  
		  
		  
reg_status_desc(string7 code)

:= case(code, 

'(BLANK)' => 'REGISTRATION NOT ISSUED',
'A' => 'ORIGINAL REGISTRATION CARD ISSUED',
'C' => 'CORRECTED REGISTRATION CARD ISSUED',
'D' => 'DUPLICATE REGISTRATION CARD ISSUED',
'R' => 'CANCELLED REGISTRATION','');

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

title_status_desc(string7 code) 
:= case(code,
'(BLANK)' => 'TITLE NOT ISSUED',
'A' => 'ORIGINAL TITLE ISSUED',
'C' => 'CORRECTED TITLE ISSUED',
'D' => 'DUPLICATE TITLE ISSUED',
'R' => 'REVOKED TITLE',
'S' => 'SURRENDERED TITLE','');

title_type_desc(string1 code) 

:= case(code,
'N' =>	'NO JOINT TENANCY',
'Y' =>  'JOINT TENANCY', '');

Watercraft.Macro_Clean_Hull_ID(watercraft.file_IL_clean_in, watercraft.Layout_IL_clean_in,hull_clean_in)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := transform


    self.watercraft_key				        :=	if(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12, trim(L.HULL_ID,left, right),
	                                            (trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30]);                                          
	self.sequence_key				        :=	trim(L.REG_DATE, left, right);
	self.watercraft_id						:=	'';
	self.state_origin						:=	'IL';
	self.source_code						:=	'AW';
	self.st_registration					:=	L.STATEABREV;
	self.county_registration				:=	county_reg(trim(L.county,left,right));
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
	self.watercraft_class_code				:=	'';
	self.watercraft_class_description		:=	'';
	self.watercraft_make_code				:=	'';
	self.watercraft_make_description		:=	L.MAKE;
	self.watercraft_model_code				:=	'';
	self.watercraft_model_description		:=	'';
	self.watercraft_width					:=	'';
	self.watercraft_weight					:=	'';
	self.watercraft_color_1_code			:=	L.color1;
	self.watercraft_color_1_description		:=	watercraft_color_desc(L.color1);
	self.watercraft_color_2_code			:=	L.color2;
	self.watercraft_color_2_description		:=	watercraft_color_desc(L.color2);
	self.watercraft_toilet_code				:=	'';
	self.watercraft_toilet_description		:=	'';
	self.watercraft_number_of_engines		:=	'';
	self.watercraft_hp_1					:=	L.HORSEPOWER;
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
	self.coast_guard_documented_flag		:=	L.Coast_Guard_Documented;
	self.coast_guard_number					:=	'';
	self.registration_date					:=	L.REG_DATE;
	self.registration_expiration_date		:=	L.Expiration_Year;
	self.registration_status_code			:=	trim(L.Registration_Status,left, right);
	self.registration_status_description	:=	reg_status_desc(trim(L.Registration_Status, left, right));
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	'';
	self.transaction_type_code				:=	trim(L.Last_Transaction_Type, left, right);
	self.transaction_type_description		:=	transaction_type_desc(trim(L.Last_Transaction_Type, left, right));
	self.title_state						:=	'';
	self.title_status_code					:=	trim(L.Title_Status, left, right);
	self.title_status_description			:=	title_status_desc(trim(L.Title_Status, left, right));
	self.title_number						:=	trim(L.Title_Number,left, right);
	self.title_issue_date					:=	L.Title_Issue_Date;
	self.title_type_code					:=	trim(L.Joint_Tenancy_Indicator,left, right);
	self.title_type_description				:=	title_type_desc(trim(L.Joint_Tenancy_Indicator, left, right));
	self.additional_owner_count				:=	L.Number_Additional_Owners;
	self.lien_1_indicator					:=	if(L.Lienholder_Indicator = 'Y', 'YES (LIENHOLDER EXISTS)', '');
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
	self.purchase_date						:=	L.Purchase_Date;
	self.dealer								:=	'';
	self.purchase_price						:=	'';
	self.new_used_flag						:=	'';
	self.watercraft_status_code				:=	'';
	self.watercraft_status_description		:=	'';
	self.history_flag						:=	L.History_File_Indicator;
	self.coastguard_flag					:=	'';
	
end;



export Mapping_IL_as_Main := project(hull_clean_in, main_mapping_format(left));


	



