import watercraft;

county_reg(string2 code)

:= case(code, 	'01'  => 'AUTAUGA',
                '02'  => 'BALDWIN',
                '03'  => 'BARBOUR',
                '04'  => 'BIBB',
                '05'  => 'BLOUNT',
                '06'  => 'BULLOCK',
                '07'  => 'BUTLER',
                '08'  => 'CALHOUN',
                '09'  => 'CHAMBERS',
                '10'  => 'CHEROKEE',
                '11'  => 'CHILTON',
                '12'  => 'CHOCTAW',
                '13'  => 'CLARKE',
                '14'  => 'CLAY',
                '15'  => 'CLEBURNE',
                '16'  => 'COFFEE',
                '17'  => 'COLBERT',
                '18'  => 'CONECUH',
                '19'  => 'COOSA',
                '20'  => 'COVINGTON',
                '21'  => 'CRENSHAW',
                '22'  => 'CULLMAN',
                '23'  => 'DALE',
                '24'  => 'DALLAS',
                '25'  => 'DEKALB',
                '26'  => 'ELMORE',
                '27'  => 'ESCAMBIA',
                '28'  => 'ETOWAH',
                '29'  => 'FAYETTE',
                '30'  => 'FRANKLIN',
                '31'  => 'GENEVA',
                '32'  => 'GREENE',
                '33'  => 'HALE',
                '34'  => 'HENRY',
                '35'  => 'HOUSTON',
                '36'  => 'JACKSON',
                '37'  => 'JEFFERSON',
                '38'  => 'LAMAR',
                '39'  => 'LAUDERDALE',
                '40'  => 'LAWRENCE',
                '41'  => 'LEE',
                '42'  => 'LIMESTONE',
                '43'  => 'LOWNDES',
                '44'  => 'MACON',
                '45'  => 'MADISON',
                '46'  => 'MARENGO',
                '47'  => 'MARION',
                '48'  => 'MARSHALL',
                '49'  => 'MOBILE',
                '50'  => 'MONROE',
                '51'  => 'MONTGOMERY',
                '52'  => 'MORGAN',
                '53'  => 'PERRY',
                '54'  => 'PICKENS',
                '55'  => 'PIKE',
                '56'  => 'RANDOLPH',
                '57'  => 'RUSSELL',
                '58'  => 'SHELBY',
                '59'  => 'ST. CLAIRE',
                '60'  => 'SUMTER',
                '61'  => 'TALLADEGA',
                '62'  => 'TALLAPOOSA',
                '63'  => 'TUSCALOOSA',
                '64'  => 'WALKER',
                '65'  => 'WASHINGTON',
                '66'  => 'WILCOX',
                '67'  => 'WINSTON',

				'' );   

Watercraft.Macro_Clean_Hull_ID(watercraft.file_CO_clean_in, watercraft.Layout_CO_clean_in,hull_clean_in)

//Fix Bad dates
BadDates := hull_clean_in(StringLib.stringfind(REG_DATE,'/',1) > 0);

GoodDates := hull_clean_in(StringLib.stringfind(REG_DATE,'/',1) = 0);

//Reformat BadDates to date standard for comparison
l_tempBase := record
	Watercraft.Layout_CO_clean_in;
	string8 tempDate := '';
end;

l_tempBase XformBadDates(BadDates pInput) := TRANSFORM
		tempMonth	:= pInput.REG_DATE[1..2];
		tempDay		:= pInput.REG_DATE[4..5];
		tempYr		:= pInput.REG_DATE[7..8]; //Partial year.  Issue to fix
		self.tempDate := tempyr+'??'+tempMonth+tempDay;
		self := pInput;
end;

TempFixDates := project(BadDates,XformBadDates(left));
dist_TempBadDate	:= distribute(TempFixDates,hash(hull_id));
dist_GoodDate	:= distribute(GoodDates,hash(hull_id));
		
//Join file with bad dates and file with good dates based on hull_id, use, make, first_name, last_name, address_1, and partial tempDate
Watercraft.Layout_CO_clean_in FixBadDate(dist_TempBadDate l, dist_GoodDate r) := TRANSFORM
	self.REG_DATE := r.REG_DATE;
	self := l;
	self := r;
end;

j_GoodRecsMatch := join(dist_TempBadDate, dist_GoodDate,
												left.hull_id = right.hull_id AND
												left.use_1 = right.use_1 AND
												left.make = right.make AND
												left.first_name = right.first_name AND
												left.last_name = right.last_name AND
												left.address_1 = right.address_1 AND
												left.tempDate[1..2]+left.tempDate[5..8] = right.reg_date[1..2]+right.reg_date[5..8],
												FixBadDate(left,right),inner,local);
												
out_GoodRecs := j_GoodRecsMatch + GoodDates;
dedupGoodRecs := dedup(out_GoodRecs); //Combine with ValidDate file to get all ValidDateRecords and dedup

//Find records that do not have a good date record match and standardize date with ?? to fill missing yr
 j_BadRecsNoMatch := join(dist_TempBadDate, dist_GoodDate,
												left.hull_id = right.hull_id AND
												left.use_1 = right.use_1 AND
												left.make = right.make AND
												left.first_name = right.first_name AND
												left.last_name = right.last_name AND
												left.address_1 = right.address_1 AND
												left.tempDate[5..8] = right.reg_date[5..8],
												transform(Watercraft.Layout_CO_clean_in, self.REG_DATE := left.tempDate,
																																						self := left),left only, local);
																																						
FixedDatesFile	:= dedupGoodRecs+j_BadRecsNoMatch;

watercraft.Layout_Watercraft_Main_Base main_mapping_format(FixedDatesFile L) := transform


  self.watercraft_key				        :=	(trim(L.HULL_ID, left, right) + trim(L.MAKE,left, right) + trim(L.YEAR, left, right))[1..30];                                          
	self.sequence_key				        :=	trim(L.REG_DATE, left, right);
	self.watercraft_id						:=	'';
	self.state_origin						:=	'CO';
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
	self.registration_date					:=	if(L.REG_DATE = '19910926', '', L.REG_DATE);
	self.registration_expiration_date		:=	'';
	self.registration_status_code			:=	'';
	self.registration_status_description	:=	'';
	self.registration_status_date			:=	'';
	self.registration_renewal_date			:=	'';
	self.decal_number						:=	'';
	self.transaction_type_code				:=	'';
	self.transaction_type_description		:=	'';
	self.title_state						:=	'';
	self.title_status_code					:=	'';
	self.title_status_description			:=	'';
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

export Mapping_CO_as_Main := project(FixedDatesFile, main_mapping_format(left));

