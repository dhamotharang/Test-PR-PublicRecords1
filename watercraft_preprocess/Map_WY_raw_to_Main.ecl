import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

process_date := (string8)STD.Date.Today();
Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_WY_clean_in, watercraft.Layout_wy_new_2014, hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.Layout_wy_new_2014, wDatasetwithflag)

watercraft.Layout_Watercraft_Main_Base main_mapping_format(wDatasetwithflag L) := TRANSFORM
	IsValidPurDate									:= STD.DATE.IsValidDate((integer)L.PURCHASEDATE);
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	stringlib.StringFindReplace(IF(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
																														// IF(length(trim(L.HULL_ID,left, right)) = 12 and trim(L.year, left, right) = '0', trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM,left,right) <> '', L.STATEABREV +trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																																	// (trim(L.HULL_ID,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30]))),' ',''); 
	self.watercraft_key				     	:=	if(trim(L.YEAR,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
	                                     if(trim(L.HULL_ID,left,right) <> 'VARIOUS' and trim(L.HULL_ID,left,right) <> 'UNKNOWN' and trim(L.HULL_ID,left,right) <> '',
	                                     (trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30],
	                                     (trim(L.REG_NUM,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right) + trim(L.NAME,left,right))[1..30]));
	self.sequence_key				       	:=	IF(L.PURCHASEDATE <> '' AND IsValidPurDate,L.PURCHASEDATE,L.REG_DATE);
	self.state_origin				       	:=	'WY';
	self.source_code				       	:=	'AW';
	self.st_registration					 	:= trim(L.STATEABREV, left, right);
	self.county_registration				:=	L.COUNTY;
	self.registration_number				:=	trim(L.REG_NUM, left, right);
	self.hull_number						    :=	L.HULL_ID;
	self.propulsion_description			:=	L.PROP;
	self.vehicle_type_Description		:=	L.VEH_TYPE;
	self.fuel_description					  :=	L.FUEL;
	self.hull_type_description			:=	L.HULL;
	self.use_description					  :=	L.USE;
	self.watercraft_length					:=	L.TOTAL_INCH;
	self.model_year							    :=	if(L.YEAR <> '0', L.YEAR, '');
	self.watercraft_make_description	:=	L.MAKE;
	IsValidRegDate										:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	self.registration_date					  :=	If(IsValidRegDate,L.REG_DATE,'');
	self.purchase_date								:=	If(IsValidPurDate and L.PURCHASEDATE < process_date,L.PURCHASEDATE,'');
	self := L;
	self := [];
END;

EXPORT Map_WY_raw_to_Main := project(wDatasetwithflag, main_mapping_format(left));