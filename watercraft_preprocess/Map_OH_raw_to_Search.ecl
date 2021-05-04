import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// translates oh_phase01.mp Ab intio graph into ECL

process_date := (string8)STD.Date.Today();
Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_OH_clean_in, watercraft.layout_OH_20Q3, hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.layout_OH_20Q3, wDatasetwithflag)

Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(wDatasetwithflag L)
 :=  TRANSFORM
 	IsValidRegDate						:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
 	self.date_first_seen			:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_last_seen				:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	stringlib.StringFindReplace(IF(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
																														// IF(length(trim(L.HULL_ID,left, right)) = 12 and trim(L.year, left, right) = '0', trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM,left,right) <> '', trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																																	// (trim(L.HULL_ID,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30]))),' ',''); 
	self.watercraft_key			:=	if(trim(L.YEAR, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, 
																trim(L.HULL_ID, left, right), if(L.HULL_ID <> ''and trim(L.HULL_ID, left, right) <> 'UNKNOWN',
																(trim(L.HULL_ID, left, right) + trim(L.MAKE, left, right) + trim(L.YEAR, left, right))[1..30],
																(trim(L.MAKE, left, right) + trim(L.YEAR, left, right) + (trim(L.FIRST_NAME, left, right) + trim(L.MID, left, right)
																+ trim(L.LAST_NAME, left, right))[1..30])));
	self.sequence_key				:=	L.REG_DATE;
	self.state_origin				:=	'OH';
	self.source_code				:=	'AW';
	self.dppa_flag          :=  '';
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first		:=	L.FIRST_NAME;
	self.orig_name_middle		:=	L.MID;
	self.orig_name_last			:=	L.LAST_NAME;
	self.orig_address_1			:=	L.ADDRESS_1;
	self.orig_city					:=	L.CITY;
	self.orig_state					:=	L.STATE;
	self.orig_zip						:=	L.ZIP;
	self.orig_fips					:=	L.FIPS;
	self.name_format					:= 'P';
	tempPrepLastSitus					:= trim(L.CITY,left,right)
															+	IF(trim(L.CITY) <> '',', ','')
															+ trim(L.STATE,left,right)
															+	' ' + trim(StringLib.StringFindReplace(L.ZIP,'-',''),left,right);
	self.prep_address_situs		:= StringLib.StringCleanSpaces(L.ADDRESS_1);
	self.prep_address_last_situs	:= StringLib.StringCleanSpaces(tempPrepLastSitus);
	self := L;
	self := [];
END; 

EXPORT Map_OH_raw_to_Search := project(wDatasetwithflag(FIRST_NAME <> '' and LAST_NAME <> ''),search_mapping_format(left));