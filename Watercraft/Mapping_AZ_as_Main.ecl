import watercraft;


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

:= case(code, 	'AE' => 'APACHE',
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
'YI' => 'YAVAPAI', '' );  

eng_drv(string2 code)

:= case(code,   'IN' => 'INBOARD',
'NO' => 'NONE',
'OT' => 'OTHER',
'OU' => 'OUTBOARD',
'SD' => 'STERN DRIVE','');

fuelconv(string2 code) 

:= case(code, 'DI' => 'DIESEL',
'EL' => 'ELECTRIC',
'GA' => 'GAS',
'NO' => 'NONE',
'OT' => 'OTHER','');

Prop(string2 code)

:= case(code, 'AT' => 'AIR THRUST',
'MN' => 'MANUAL',
'OT' => 'OTHER',
'PR' => 'PROPELLER',
'SL' => 'SAIL',
'WJ' => 'WATERJET','');

useconv(string2 code)

:= case(code, 'CO' => 'COMMERCIAL',
'CP' => 'COMMERCIAL PASSENGER',
'DL' => 'DEALER/MANUFACTURER',
'GO' => 'GOVERNMENT',
'LI' => 'LIVERY',
'NP' => 'NONRESIDENT PLEASURE',
'RP' => 'RESIDENT PLEASURE','');

veh_typeconv(string2 code)

:= case(code, 'AB' => 'AIR BOAT',
'AS' => 'AUXILIARY SAIL',
'CM' => 'CABIN MOTORBOAT',
'HB' => 'HOUSEBOAT',
'IN' => 'INFLATABLE',
'OM' => 'OPEN MOTORBOAT',
'OT' => 'OTHER',
'PB' => 'PONTOON BOAT',
'PW' => 'PERSONAL WATERCRAFT','');

Watercraft.Macro_Clean_Hull_ID(watercraft.file_AZ_clean_in, watercraft.Layout_AZ_clean_in,hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.Layout_AZ_clean_in, wDatasetwithflag)


watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := transform


    self.watercraft_key				        :=	if(length(trim(L.HULL_ID, left, right)) = 12 and trim(L.year, left, right) >= '1972'
	                                            and trim(L.HULL_ID, left, right) <> '000000000000'and L.is_hull_id_in_MIC,trim(L.HULL_ID, left, right),
												if(trim(L.HULL_ID, left, right) = '000000000000' or trim(L.YEAR, left, right) = '1900' or
												L.MAKE = ''or trim(L.HULL_ID, left, right) ='NONE' , trim(L.REG_NUM, left, right), (trim(L.HULL_ID, left, right) + trim(L.MAKE,left, right) + trim(L.YEAR, left, right))[1..30]));                                          
	self.sequence_key				        :=	trim(L.REG_DATE, left, right);
	self.state_origin						:=	'AZ';
	self.source_code						:=	'AW';
	self.st_registration					:=	L.STATEABREV;
	self.county_registration				:=	if(length(trim(L.COUNTY))=2,county_reg(L.COUNTY), '');
	self.registration_number				:=	trim(L.REG_NUM, left, right);
	self.hull_number						:=	L.hull_id;
	self.propulsion_description				:=	if ( Prop(L.PROP) <> '',Prop(L.PROP),eng_drv(L.ENGINE_DRIVE));
	self.vehicle_type_Description			:=	veh_typeconv(L.VEH_TYPE);
	self.fuel_description					:=	fuelconv(L.FUEL);
	self.hull_type_description				:=	L.HULL;
	self.use_description					:=	useconv(L.USE_1);
	self.watercraft_length					:=	L.TOTAL_INCH;
	self.model_year							:=	L.YEAR;
	self.watercraft_make_description		:=	L.MAKE;
	self.registration_date					:=	L.REG_DATE;
	self.registration_status_code			:=	L.STATUS;
	self.registration_status_description	:=	reg_status_desc(L.STATUS);
	self.registration_expiration_date  := L.EXPIRATION_DATE;

	self                                    := [];
  end;



export Mapping_AZ_as_Main := project(wDatasetwithflag, main_mapping_format(left));

	


