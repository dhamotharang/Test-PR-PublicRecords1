import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;

//translates ar_sekhar_phase01_update.mp Ab intio graph into ECL to a common format for all raw files
// Cleaning will be done after all raw files are in one common format to eliminate multiple passes to the cleaner for each source

county_reg(string2 code)
:= case(code, 	'1' => 'ARKANSAS',
'2' => 'ASHLEY',
'3' => 'BAXTER',
'4' => 'BENTON',
'5' => 'BOONE',
'6' => 'BRADLEY',
'7' => 'CALHOUN',
'8' => 'CARROLL',
'9' => 'CHICOT',
'10' => 'CLARK',
'11' => 'CLAY',
'12' => 'CLEBURNE',
'13' => 'CLEVELAND',
'14' => 'COLUMBIA',
'15' => 'CONWAY',
'16' => 'CRAIGHEAD',
'17' => 'CRAWFORD',
'18' => 'CRITTENDEN',
'19' => 'CROSS',
'20' => 'DALLAS',
'21' => 'DESHA',
'22' => 'DREW',
'23' => 'FAULKNER',
'24' => 'FRANKLIN',
'25' => 'FULTON',
'26' => 'GARLAND',
'27' => 'GRANT',
'28' => 'GREENE',
'29' => 'HEMPSTEAD',
'30' => 'HOT SPRING',
'31' => 'HOWARD',
'32' => 'INDEPENDENCE',
'33' => 'IZARD',
'34' => 'JACKSON',
'35' => 'JEFFERSON',
'36' => 'JOHNSON',
'37' => 'LAFAYETTE',
'38' => 'LAWRENCE',
'39' => 'LEE',
'40' => 'LINCOLN',
'41' => 'LITTLE RIVER',
'42' => 'LOGAN',
'43' => 'LONOKE',
'44' => 'MADISON',
'45' => 'MARION',
'46' => 'MILLER',
'47' => 'MISSISSIPPI',
'48' => 'MONROE',
'49' => 'MONTGOMERY',
'50' => 'NEVADA',
'51' => 'NEWTON',
'52' => 'OUACHITA',
'53' => 'PERRY',
'54' => 'PHILLIPS',
'55' => 'PIKE',
'56' => 'POINSETT',
'57' => 'POLK',
'58' => 'POPE',
'59' => 'PRAIRIE',
'60' => 'PULASKI',
'61' => 'RANDOLPH',
'62' => 'ST. FRANCIS',
'63' => 'SALINE',
'64' => 'SCOTT',
'65' => 'SEARCY',
'66' => 'SEBASTIAN',
'67' => 'SEVIER',
'68' => 'SHARP',
'69' => 'STONE',
'70' => 'UNION',
'71' => 'VAN BUREN',
'72' => 'WASHINGTON',
'73' => 'WHITE',
'74' => 'WOODRUFF',
'75' => 'YELL','' );   

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_AR_clean_in, Watercraft.layout_AR,hull_clean_in)


watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := transform
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key				:=	stringlib.StringFindReplace(IF(trim(L.YEAR, left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, L.HULL_ID,
																															// IF(trim(L.YEAR, left,right) = '0' and length(trim(L.HULL_ID,left,right)) = 12, L.HULL_ID,
																																	// L.STATEABREV+L.REG_NUM+IF(trim(L.year,left,right)<>'0',trim(L.year,left,right),''))),' ','');                                          
	self.watercraft_key				:=	(trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30];                                          
	self.sequence_key					:=	trim(L.REG_DATE,left,right);
	self.state_origin					:=	'AR';
	self.source_code					:=	'AW';
	self.st_registration			:=	L.STATEABREV;
	self.county_registration	:=	county_reg(trim(L.county,left,right));
	self.registration_number	:=	trim(L.REG_NUM, left, right);
	self.hull_number					:=	L.hull_id;
	self.propulsion_description		:=	L.PROP;
	self.vehicle_type_Description	:=	L.VEH_TYPE;
	self.fuel_description					:=	L.FUEL;
	self.hull_type_description		:=	L.HULL;
	self.use_description					:=	L.USE_1;
	self.watercraft_length				:=	trim(L.TOTAL_INCH, left, right);
	self.model_year								:=	L.YEAR;
	self.watercraft_class_description		:=	trim(L.CONVLENGTH, left, right);
	self.watercraft_make_description		:=	L.MAKE;
	self.watercraft_hp_1					:=	L.HP;
	self.engine_number_1					:=	L.SERIAL;
	self.engine_make_1						:=	L.MOTOR;
	IsValidRegDate								:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date				:=	IF(IsValidRegDate,L.REG_DATE,'');
	IsValidExpireDate							:= STD.DATE.IsValidDate((integer)L.ExpireDate);
	self.registration_expiration_date := IF(IsValidExpireDate,L.ExpireDate,'');
	self := L;
	self := [];
 end;

EXPORT Map_AR_raw_to_Main := dedup(sort(project(hull_clean_in, main_mapping_format(left)),watercraft_key),ALL);