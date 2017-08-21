import lib_stringlib, watercraft, watercraft_preprocess, ut;

// translates va_01.mp Ab intio graph into ECL

Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_VA_clean_in, watercraft.Layout_VA, hull_clean_in)

file_VA_filter  := hull_clean_in(Fips_Used <> '' or Fips_Docked <> '');

watercraft.Macro_Is_hull_id_in_MIC(file_VA_filter, watercraft.Layout_VA, wDatasetwithflag)

watercraft.Layout_Watercraft_Coastguard_Base main_mapping_format(wDatasetwithflag L) := TRANSFORM
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
	self.hull_identification_number        :=  L.HULL_ID;
	self.vessel_service_type               :=  L.USE_1;
	self.hailing_port                      :=  L.Fips_Used;
	self.home_port_name                    :=  L.Fips_Docked;
	self.propulsion_type                   :=  L.PROP;
	self	:= L;
	self	:= [];
END;

EXPORT Map_VA_raw_to_CoastGuard := project(wDatasetwithflag, main_mapping_format(left));