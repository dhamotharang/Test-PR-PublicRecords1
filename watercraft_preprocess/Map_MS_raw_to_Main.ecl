import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;

// translates  ms_phase01.mp Ab intio graph into ECL

county_reg(string2 code) := case(code,
'01' => 'ADAMS',
'02' => 'ALCORN',
'03' => 'AMITE',
'04' => 'ATTALA',
'05' => 'BENTON',
'06' => 'BOLIVAR',
'07' => 'CALHOUN',
'08' => 'CARROLL',
'09' => 'CHICKASAW',
'10' => 'CHOCTAW',
'11' => 'CLAIBORNE',
'12' => 'CLARKE',
'13' => 'CLAY',
'14' => 'COAHOMA',
'15' => 'COPIAH',
'16' => 'COVINGTON',
'17' => 'DE SOTO',
'18' => 'FORREST',
'19' => 'FRANKLIN',
'20' => 'GEORGE',
'21' => 'GREENE',
'22' => 'GRENADA',
'23' => 'HANCOCK',
'24' => 'HARRISON',
'25' => 'HINDS',
'26' => 'HOLMES',
'27' => 'HUMPHREYS',
'28' => 'ISSAQUENA',
'29' => 'ITAWAMBA',
'30' => 'JACKSON',
'31' => 'JASPER',
'32' => 'JEFFERSON',
'33' => 'JEFFERSON DAVIS',
'34' => 'JONES',
'35' => 'KEMPER',
'36' => 'LAFAYETTE',
'37' => 'LAMAR',
'38' => 'LAUDERDALE',
'39' => 'LAWRENCE',
'40' => 'LEAKE',
'41' => 'LEE',
'42' => 'LEFLORE',
'43' => 'LINCOLN',
'44' => 'LOWNDES',
'45' => 'MADISON',
'46' => 'MARION',
'47' => 'MARSHALL',
'48' => 'MONROE',
'49' => 'MONTGOMERY',
'50' => 'NESHOBA',
'51' => 'NEWTON',
'52' => 'NOXUBEE',
'53' => 'OKTIBBEHA',
'54' => 'PANOLA',
'55' => 'PEARL RIVER',
'56' => 'PERRY ',
'57' => 'PIKE',
'58' => 'PONTOTOC',
'59' => 'PRENTISS',
'60' => 'QUITMAN',
'61' => 'RANKIN',
'62' => 'SCOTT',
'63' => 'SHARKEY',
'64' => 'SIMPSON',
'65' => 'SMITH',
'66' => 'STONE',
'67' => 'SUNFLOWER',
'68' => 'TALLAHATCHIE',
'69' => 'TATE',
'70' => 'TIPPAH',
'71' => 'TISHOMINGO',
'72' => 'TUNICA',
'73' => 'UNION',
'74' => 'WALTHALL',
'75' => 'WARREN',
'76' => 'WASHINGTON',
'77' => 'WAYNE',
'78' => 'WEBSTER',
'79' => 'WILKINSON',
'80' => 'WINSTON',
'81' => 'YALOBUSHA',
'82' => 'YAZOO',
'83' => 'OUT OF STATE', '');

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_MS_clean_in, Watercraft.layout_ms_new, hull_clean_in)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := transform
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	stringlib.StringFindReplace(IF(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12, trim(L.HULL_ID,left,right),
																														// IF(length(trim(L.HULL_ID,left, right)) = 12 and trim(L.year, left, right) = '0', trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM,left,right) <> '', trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																																	// (trim(L.HULL_ID,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30]))),' ',''); 
  self.watercraft_key					:=	if(trim(L.YEAR,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, trim(L.HULL_ID,left,right), if(L.HULL_ID = '',
	                                    (trim(L.MAKE,left,right) + trim(L.YEAR,left,right) + trim(L.FIRST_NAME,left,right) + trim(L.MID,left,right)
																			+ trim(L.LAST_NAME,left,right))[1..30], (trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30]));
	self.sequence_key						:=	L.TRANSACTION_DATE;
	self.state_origin						:=	'MS';
	self.source_code						:=	'AW';
	self.st_registration				:=	L.STATEABREV;
	self.county_registration		:=	trim(L.county,left,right);
	self.registration_number		:=	trim(L.REG_NUM, left, right);
	self.hull_number						:=	L.hull_id;
	self.propulsion_description	:=	L.PROP;
	//DF-19984 - Layout change, BOAT_TYPE_CODE is deleted
	// self.vehicle_type_Description	:=	map(L.VEH_TYPE = 'OTHER' and L.BOAT_TYPE_CODE <> '' => L.BOAT_TYPE_CODE,
	                                      // L.BOAT_TYPE_CODE <> '' =>  L.BOAT_TYPE_CODE,L.VEH_TYPE);
	self.vehicle_type_Description := '';																			
	self.fuel_description					:=	L.FUEL;
	self.hull_type_description		:=	L.HULL;
	self.use_description					:=	L.USE_1;
	self.watercraft_length				:=	L.TOTAL_INCH;
	self.model_year								:=	L.YEAR;
	self.watercraft_make_description		:=	L.MAKE;
	IsValidRegDate											:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date							:=	If(IsValidRegDate,L.REG_DATE,'');
	IsValidExpireDate										:=	STD.DATE.IsValidDate((integer)L.EXPIRATION_DATE);
	self.registration_expiration_date		:=	If(IsValidExpireDate,L.EXPIRATION_DATE,'');
	//DF-19984 - Layout change, STATUS is deleted
	// self.watercraft_status_description	:=	L.STATUS;
	self.watercraft_status_description := '';
	self := L;
	self := [];
	end;

EXPORT Map_MS_raw_to_Main := project(hull_clean_in, main_mapping_format(left));