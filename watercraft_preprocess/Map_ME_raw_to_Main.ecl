import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;

// translates me_phase01.mp Ab intio graph into ECL to a common format for all raw files

county_reg(string2 code) := 
case(code,
'1' => 'ANDROSCOGGIN',
'3' => 'AROOSTOOK',
'5' => 'CUMBERLAND',
'7' => 'FRANKLIN',
'9' => 'HANCOCK',
'11' => 'KENNEBEC',
'13' => 'KNOX',
'15' => 'LINCOLN',
'17' => 'OXFORD',
'19' => 'PENOBSCOT',
'21' => 'PISCATOAQUIS',
'23' => 'SAGADAHOC',
'25' => 'SOMERSET',
'27' => 'WALDO',
'29' => 'WASHINGTON',
'31' => 'YORK', '');

reg_status_desc(string2 code) := 
case(code,
'01' => 'Active',
'02' => 'Lost/Stolen',
'03' => 'Destroyed',
'04' => 'Transfer of Ownership',
'05' => 'Out of State',
'06' => 'Revoked',
'07' => 'Temporary Registration',
'08' => 'All Events Deleted','');

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_ME_clean_in, Watercraft.layout_me, hull_clean_in)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := transform
	// New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	StringLib.StringFindReplace(IF(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM) != '',L.STATEABREV + L.REG_NUM + IF(trim(L.year,left,right)<>'0',trim(L.year,left,right),''),
																																	// L.HULL_ID + IF(trim(L.year,left,right)<>'0',trim(L.year,left,right),''))),' ','');                                          
	self.watercraft_key			:=	if(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) >= '1972', trim(L.HULL_ID,left,right),
	                               (trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30]);                                          
	self.sequence_key				:=	trim(L.REG_DATE,left,right);
	self.state_origin				:=	'ME';
	self.source_code				:=	'AW';
	self.st_registration						:=	L.STATEABREV;
	self.county_registration				:=	L.county;
	self.registration_number				:=	trim(L.REG_NUM,left,right);
	self.hull_number								:=	L.hull_id;
	self.propulsion_description			:=	L.PROP;
	self.vehicle_type_Description		:=	L.VEH_TYPE;
//	self.fuel_description						:=	L.FUEL;
	self.hull_type_description			:=	L.HULL;
	self.use_description						:=	L.USE_1;
	self.watercraft_length					:=	L.TOTAL_INCH;
	self.model_year									:=	L.YEAR;
	self.watercraft_class_code				:=	'';
	self.watercraft_class_description	:=	L.CLASS;
	self.watercraft_make_description	:=	L.MAKE;
	self.watercraft_color_1_description		:=	L.COLOR;
	self.watercraft_hp_1									:=	L.HSP;
	IsValidRegDate												:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date								:=	If(IsValidRegDate,L.REG_DATE,'');
	IsValidExpireDate											:=	STD.DATE.IsValidDate((integer)L.EXPIRATION_DATE);
	self.registration_expiration_date			:=	If(IsValidExpireDate,L.EXPIRATION_DATE,'');
	self.registration_status_description	:=	L.VEHICLE_STATUS;
	self.transaction_type_description			:=	L.TRANSACTION_TYPE;
	self.additional_owner_count						:=	'';//IF(trim(L.SECONDARY_OWNER,left,right) <> '','1','');
	self := L;
	self := [];
	end;

EXPORT Map_ME_raw_to_Main := project(hull_clean_in, main_mapping_format(left));