import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;

// translates  nd_phase01.mp Ab intio graph into ECL

county_reg(string2 code)
:= case(code, 	
'1' => 'ADAMS',
'2' => 'BARNES',
'3' => 'BENSON',
'4' => 'BILLINGS',
'5' => 'BOTTINEAU',
'6' => 'BOWMAN',
'7' => 'BURKE',
'8' => 'BURLEIGH',
'9' => 'CASS',
'10' => 'CAVALIER',
'11' => 'DICKEY',
'12' => 'DIVIDE',
'13' => 'DUNN',
'14' => 'EDDY',
'15' => 'EMMONS',
'16' => 'FOSTER',
'17' => 'GOLDEN VALLEY',
'18' => 'GRAND FORKS',
'19' => 'GRANT',
'20' => 'GRIGGS',
'21' => 'HETTINGER',
'22' => 'KIDDER',
'23' => 'LAMOURE',
'24' => 'LOGAN',
'25' => 'MCHENRY',
'26' => 'MCINTOSH',
'27' => 'MCKENZIE',
'28' => 'MCLEAN',
'29' => 'MERCER',
'30' => 'MORTON',
'31' => 'MOUNTRAIL',
'32' => 'NELSON',
'33' => 'OLIVER',
'34' => 'PEMBINA',
'35' => 'PIERCE',
'36' => 'RAMSEY',
'37' => 'RANSOM',
'38' => 'RENVILLE',
'39' => 'RICHLAND',
'40' => 'ROLETTE',
'41' => 'SARGENT',
'42' => 'SHERIDAN',
'43' => 'SIOUX',
'44' => 'SLOPE',
'45' => 'STARK',
'46' => 'STEELE',
'47' => 'STUTSMAN',
'48' => 'TOWNER',
'49' => 'TRAILL',
'50' => 'WALSH',
'51' => 'WARD',
'52' => 'WELLS',
'53' => 'WILLIAMS',
'54' => 'COUNTY UNKNOWN','');

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_ND_clean_in,Watercraft.layout_ND_20Q3,hull_clean_in)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := TRANSFORM
	// New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	StringLib.StringFindReplace(IF(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM) != '',L.STATEABREV + L.REG_NUM + IF(trim(L.year,left,right)<>'0',trim(L.year,left,right),''),
																																	// L.HULL_ID + IF(trim(L.year,left,right)<>'0',trim(L.year,left,right),''))),' ','');
	self.watercraft_key		:=	if(trim(L.YEAR,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, trim(L.HULL_ID,left,right),
	                             if(trim(L.HULL_ID,left,right) <> '',(trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30],
																	(trim(L.MAKE,left,right) + trim(L.YEAR, left, right) + trim(L.NAME,left,right))[1..30]));
	self.sequence_key			:=	trim(L.REG_DATE,left,right);
	self.state_origin			:=	'ND';
	self.source_code			:=	'AW';
	self.st_registration	:=	L.STATEDATA;
	self.county_registration	:=	county_reg(trim(L.county,left,right));
	self.registration_number	:=	trim(L.REG_NUM, left, right);
	self.hull_number					:=	L.hull_id;
	self.propulsion_description		:=	L.PROP;
	self.vehicle_type_Description	:=	L.VEH_TYPE;
	self.fuel_description					:=	L.FUEL;
	self.hull_type_description		:=	L.HULL;
	self.use_description					:=	L.USE_1;
	self.watercraft_length				:=	L.TOTAL_INCH;
	self.model_year								:=	L.YEAR;
	self.watercraft_make_description	:=	L.MAKE;
	self.watercraft_hp_1					:=	L.HP;
	IsValidRegDate								:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date				:=	If(IsValidRegDate,L.REG_DATE,'');
	self := L;
	self := [];
	END;

EXPORT Map_ND_raw_to_Main := project(hull_clean_in, main_mapping_format(left));