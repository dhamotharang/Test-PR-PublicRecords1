import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;

// translates  ks_phase01.mp Ab intio graph into ECL

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_KS_clean_in, watercraft.Layout_KS,hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.Layout_KS, wDatasetwithflag)
															
watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := transform
	// New watercraft_key logic will be implemented at a later date
	// self.watercraft_key	:=	stringlib.StringFindReplace(if(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
																												// if(L.HULL_ID = '', trim(L.Reg_num,left,right)+IF(trim(L.YEAR,left,right) <> '0',trim(L.YEAR,left,right),''), 
																													// (trim(L.HULL_ID,left,right) + IF(trim(L.YEAR,left,right) <> '0',trim(L.YEAR,left,right),''))[1..30])),' ','');
	self.watercraft_key			:=	if(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
	                               if(L.HULL_ID = '' or trim(L.YEAR,left,right) = '0' or L.make ='', trim(L.Reg_num,left,right), 
																	(trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30]));
	self.sequence_key				:=	trim(L.EXPIRATION_DATE,left,right);
	self.state_origin				:=	'KS';
	self.source_code				:=	'AW';
	self.st_registration			:=	L.STATEABREV;
	self.registration_number	:=	trim(L.REG_NUM,left,right);
	self.hull_number					:=	L.hull_id;
	self.propulsion_description		:=	L.PROP;
	self.vehicle_type_Description	:=	L.VEH_TYPE;
	self.fuel_description					:=	L.FUEL;
	self.hull_type_description		:=	L.HULL;
	self.use_description					:=	L.USE_1;
	self.watercraft_length				:=	L.TOTAL_INCH;
	self.model_year								:=	L.YEAR;
	self.watercraft_make_description	:=	L.MAKE;
	self.watercraft_toilet_code				:=	L.TOILET;
	self.watercraft_toilet_description	:=	case(L.TOILET, 'N'=> 'NO','Y'=>'YES', '');
	self.watercraft_hp_1						:=	L.HP;
	IsValidRegDate									:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date					:=	IF(IsValidRegDate,L.REG_DATE,'');
	IsValidExpireDate								:=	STD.DATE.IsValidDate((integer) L.EXPIRATION_DATE);
	self.registration_expiration_date	:=	IF(IsValidExpireDate,L.EXPIRATION_DATE,'');
	self.registration_status_code			:=	L.STATUS[1];
	self.registration_status_description	:=	case(L.STATUS[1], 'A' => 'ACTIVE', 'C' => 'CANCELLED','E' =>'EXPIRED','');
	self := L;
	self := [];
  end;

EXPORT Map_KS_raw_to_Main := project(wDatasetwithflag, main_mapping_format(left));