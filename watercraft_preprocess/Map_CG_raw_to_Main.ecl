import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// translates merchent_vessel.mp Ab intio graph into ECL 

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_CG_clean_in, watercraft.Layout_CG, hull_clean_in)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(hull_clean_in L) := TRANSFORM
	self.watercraft_key				:=	L.vessel_id;
	self.sequence_key			    :=	StringLib.StringCleanSpaces(trim(L.NAME,left,right)+trim(L.FIRST_NAME,left,right)+trim(L.MID,left,right)+trim(L.LAST_NAME,left,right));
	self.state_origin					:=	'US';
	self.source_code					:=	'CG';
	self.registration_number	:=	L.REG_NUM;
	self.hull_number					:=	if(trim(L.HULL_ID,left, right)<>trim(L.HULL_IDENTIFICATION_NUMBER_2,left, right),trim(L.HULL_ID+L.HULL_IDENTIFICATION_NUMBER_2,left, right),trim(L.HULL_ID,left, right));
	self.propulsion_description		:=	trim(L.PROPULSION_TYPE, left, right);
	self.vehicle_type_Description	:=	trim(L.VEH_TYPE, left, right);
	self.fuel_description					:=	MAP(REGEXFIND('^GAS',L.PROPULSION_TYPE) => 'GAS',
																				REGEXFIND('^DIESEL',L.PROPULSION_TYPE) => 'DIESEL','OTHER');
	self.hull_type_description		:=	L.HULL;
	self.use_description					:=	L.USE_1;
	self.watercraft_length				:=	L.TOTAL_INCH;
	self.model_year								:=	L.YEAR;
	self.watercraft_name					:=	L.NAME_OF_VESSEL;
	self.watercraft_make_description	:=	L.MAKE;
	self.watercraft_width							:=	(string)(integer4)(((decimal5_2)L.REGISTERED_BREADTH)*12.0);
	self.watercraft_weight						:=	(string)(integer4)(((decimal6_2)L.REGISTERED_NET_TONS)*2204.62);
	self.watercraft_hp_1							:=	L.Main_HP_Ahead;
	self.watercraft_hp_2							:=	L.Main_HP_Astern;
	self.registration_status_description	:=	L.COD_Status;
	self.coastguard_flag							:=	'Y';
	self := L;
	self := [];
END;

EXPORT Map_CG_raw_to_Main := project(hull_clean_in,main_mapping_format(left));