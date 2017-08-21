import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// translates va_01.mp Ab intio graph into ECL

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_VA_clean_in, watercraft.Layout_VA, hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.Layout_VA, wDatasetwithflag)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := TRANSFORM
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	stringlib.StringFindReplace(IF(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
																														// IF(length(trim(L.HULL_ID,left, right)) = 12 and trim(L.year, left, right) = '0', trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM,left,right) <> '', trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																																	// (trim(L.HULL_ID,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30]))),' ',''); 
	self.watercraft_key			:=	if(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
	                                if(L.HULL_ID <> '',(trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right)
																			+ trim(L.NAME,left,right))[1..30], if(L.MAKE <> '' and trim(L.YEAR,left,right) = '0', L.REG_NUM, 
																			(trim(L.MAKE,left,right) + trim(L.YEAR,left,right) + trim(L.FIRST_NAME,left,right) + trim(L.MID,left,right)
																			+ trim(L.LAST_NAME,left,right))[1..30])));
	self.sequence_key				:=	trim(L.reg_date, left, right);
	self.state_origin				:=	'VA';
	self.source_code				:=	'AW';
	self.st_registration			:=	L.STATEABREV;
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
	self.watercraft_number_of_engines	:=	if(L.NUM_MTRS <> '0', L.NUM_MTRS,'');
	self.watercraft_hp_1					:=	L.HP;
	self.engine_number_1					:=	L.ENGSERIAL;
	self.engine_make_1						:=	L.ENGINEMAKE;
	IsValidRegDate								:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date				:=	If(IsValidRegDate,L.REG_DATE,'');
	IsValidExpireDate							:=	STD.DATE.IsValidDate((integer)L.EXPIREDATE);
	self.registration_expiration_date	:=	If(IsValidExpireDate,L.EXPIREDATE,'');
	IsValidPurchDate							:=	STD.DATE.IsValidDate((integer)L.PURCH_DT);
	self.purchase_date						:=	If(IsValidPurchDate,L.PURCH_DT,'');
	self.purchase_price						:=	if(trim(L.BOAT_CST, left, right) <> '.00' , L.BOAT_CST, '');
	self := L;
	self := [];
END;

EXPORT Map_VA_raw_to_Main := project(wDatasetwithflag, main_mapping_format(left));