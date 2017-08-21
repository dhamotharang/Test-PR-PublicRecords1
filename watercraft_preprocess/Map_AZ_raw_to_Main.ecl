import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;

// translates az_update.mp Ab intio graph into ECL

reg_status_desc(string2 code)
 := case(code,
'DC' => 'DUPLICATE CERT',
'DD' => 'DUPLICATE DECAL',
'FC' => 'FREE CERT',
'FD' => 'FREE DECAL',
'NR' => 'NEW REGISTRATION',
'RM' => 'MAIL-IN RENEWAL',
'RO' => 'ON-LINE RENEWAL',
'TO' => 'TRANSFER ONLY',
'TR' => 'TRANSFER AND RENEWAL',
'' );

county_reg(string2 code)
:= case(code,
'AE' => 'APACHE',
'CE' => 'COCHISE',
'CO' => 'COCONINO',
'GA' => 'GILA',
'GE' => 'GREENLEE',
'GM' => 'GRAHAM',
'LZ' => 'LA PAZ',
'MA' => 'MARICOPA',
'ME' => 'MOHAVE',
'NO' => 'NAVAJO',
'OS' => 'OUT OF STATE',
'PA' => 'PIMA',
'PL' => 'PINAL',
'SZ' => 'SANTA CRUZ',
'YA' => 'YUMA',
'YI' => 'YAVAPAI',
'' );  

eng_drv(string2 code)
:= case(code,
'IN' => 'INBOARD',
'NO' => 'NONE',
'OT' => 'OTHER',
'OU' => 'OUTBOARD',
'SD' => 'STERN DRIVE',
'PD' => 'POD DRIVE',
'');

fuelconv(string2 code) 
:= case(code,
'EL' => 'ELECTRIC',
'GA' => 'GAS',
'DI' => 'DIESEL',
'NO' => 'NONE',
'OT' => 'OTHER',
'');

Prop(string2 code)
:= case(code,
'AT' => 'AIR THRUST',
'MN' => 'MANUAL',
'OT' => 'OTHER',
'PR' => 'PROPELLER',
'SL' => 'SAIL',
'WJ' => 'WATERJET',
'PD' => 'POD DRIVE',
'');

useconv(string2 code)
:= case(code,
'CF' => 'COMMERCIAL FISHING',
'CH' => 'CHARTER FISHING',
'CO' => 'COMMERCIAL',
'CP' => 'COMMERCIAL PASSENGER',
'DL' => 'DEALER/MANUFACTURER',
'GO' => 'GOVERNMENT',
'LE' => 'LEASE',
'LI' => 'RENT/LIVERY',
'NP' => 'NONRESIDENT PLEASURE',
'RP' => 'RESIDENT PLEASURE',
'');

veh_typeconv(string2 code)
:= case(code,
'AB' => 'AIR BOAT',
'AS' => 'AUXILIARY SAIL',
'CM' => 'CABIN MOTORBOAT',
'HB' => 'HOUSEBOAT',
'IN' => 'INFLATABLE',
'OM' => 'OPEN MOTORBOAT',
'OT' => 'OTHER',
'PB' => 'PONTOON BOAT',
'PW' => 'PERSONAL WATERCRAFT',
'');

hull_cd(string2 code)
:= case(code,
'AL' => 'ALUMINUM',
'FI' => 'FIBERGLASS',
'OT' => 'OTHER',
'PL' => 'PLASTIC',
'RV' => 'RUBBER/VINYL/CANVAS',
'ST' => 'STEEL',
'WD' => 'WOOD',
'');

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_AZ_clean_in, Watercraft.layout_AZ_new,hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, Watercraft.layout_AZ_new, wDatasetwithflag)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := transform
	//New watercraft_key logic to be implemented at a later date 
	// self.watercraft_key	:=	stringlib.StringFindReplace(IF(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) >= '1972'
																												// and trim(L.HULL_ID,left,right) <> '000000000000'and L.is_hull_id_in_MIC,trim(L.HULL_ID, left, right),
																												// IF(trim(L.HULL_ID,left,right) = '000000000000' or trim(L.YEAR,left,right) = '1900'
																													// or trim(L.HULL_ID,left,right) = '' or length(trim(L.HULL_ID,left,right)) < 12,
																													// L.STATEABREV+trim(L.REG_NUM,left,right) + IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																													// (trim(L.HULL_ID,left,right) + IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30])),' ','');                                      
	self.watercraft_key			:=	IF(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) >= '1972'
	                               and trim(L.HULL_ID,left,right) <> '000000000000'and L.is_hull_id_in_MIC,trim(L.HULL_ID, left, right),
																	IF(trim(L.HULL_ID,left,right) = '000000000000' or trim(L.YEAR,left,right) = '1900' or
																		L.MAKE = ''or trim(L.HULL_ID,left,right) ='NONE' ,trim(L.REG_NUM,left,right), (trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30]));      
	self.sequence_key									:=	trim(L.REG_DATE,left,right);
	self.state_origin									:=	'AZ';
	self.source_code									:=	'AW';
	self.st_registration							:=	L.STATEABREV;
	self.county_registration					:=	if(length(trim(L.COUNTY))=2,county_reg(L.COUNTY), '');
	self.registration_number					:=	trim(L.REG_NUM, left, right);
	self.hull_number									:=	L.hull_id;
	self.propulsion_code							:= IF(length(trim(L.PROP,left,right)) = 2, L.PROP,'');
	self.propulsion_description				:=	IF(self.propulsion_code <> '',Prop(L.PROP),
																						IF(self.propulsion_code = '' AND L.PROP <> '',L.PROP, 
																								IF(length(trim(L.ENGINE_DRIVE,left,right)) = 2, eng_drv(L.ENGINE_DRIVE),'')));
	self.vehicle_type_code						:= IF(length(trim(L.VEH_TYPE,left,right)) = 2, L.VEH_TYPE,'');
	self.vehicle_type_Description			:= IF(self.vehicle_type_code <> '',veh_typeconv(L.VEH_TYPE),L.VEH_TYPE);
	self.fuel_code										:= IF(length(trim(L.FUEL,left,right)) = 2, L.FUEL,'');
	self.fuel_description							:= IF(self.fuel_code <> '',fuelconv(L.FUEL),L.FUEL);
	self.hull_type_code								:= IF(length(trim(L.HULL,left,right)) = 2, L.HULL,'');
	self.hull_type_description				:= IF(self.hull_type_code <> '',hull_cd(L.HULL),L.HULL);
	self.use_code											:= IF(length(trim(L.USE_1,left,right)) = 2, L.USE_1,'');
	self.use_description							:= IF(self.use_code <> '',useconv(L.USE_1),L.USE_1);
	self.watercraft_length						:=	L.TOTAL_INCH;
	self.model_year										:=	L.YEAR;
	self.watercraft_make_description	:=	L.MAKE;
	IsValidRegDate										:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date						:=	IF(IsValidRegDate,L.REG_DATE,'');
	self.registration_status_code			:=	L.STATUS;
	self.registration_status_description	:=	reg_status_desc(L.STATUS);
	self		:= L;
	self		:= [];
  end;

EXPORT Map_AZ_raw_to_Main := project(wDatasetwithflag, main_mapping_format(left));