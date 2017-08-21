import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// Translates or_phase01_mod_V002.ksh*

process_date := (string8)STD.Date.Today();
Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_OR_clean_in, Watercraft.layout_or_new_14q3, hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, Watercraft.layout_or_new_14q3, wDatasetwithflag)


Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(wDatasetwithflag L, integer1 C)
 :=  TRANSFORM
	IsValidRegDate					:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
	IsValidTitleDate				:=	STD.DATE.IsValidDate((integer)L.TITLE_ISSUE_DATE);
  self.date_first_seen		:=	If(L.REG_DATE <> '' AND IsValidRegDate, L.REG_DATE,
																If(IsValidTitleDate,L.TITLE_ISSUE_DATE,''));
	self.date_last_seen			:=	If(L.REG_DATE <> '' AND IsValidRegDate, L.REG_DATE,
																If(IsValidTitleDate,L.TITLE_ISSUE_DATE,''));
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	// New watercraft_key logic to be implemented at a later date
	// self.watercraft_key		:=	stringlib.StringFindReplace(IF(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right), 
																													// IF(length(trim(L.HULL_ID,left, right)) = 12 and trim(L.year, left, right) = '0', trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM,left,right) <> '', trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																																	//trim(L.NAME,left,right)+IF(trim(L.MAKE,left,right)<>'',trim(L.MAKE,left,right),'')+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),'')))),' ','');
	self.watercraft_key			:=	if(trim(L.YEAR, left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
	                               if(trim(L.HULL_ID,left,right) <> 'VARIOUS'and trim(L.HULL_ID,left,right) <> 'UNKNOWN',
																	trim(L.HULL_ID,left,right) + IF(L.MAKE = 'MANUFACTURER NOT SPECIFIE','',trim(L.MAKE,left,right)) + trim(L.YEAR,left,right),
																	trim(L.MAKE,left,right) + trim(L.YEAR,left,right) + trim(L.NAME,left,right)));
	self.sequence_key				:=	L.REG_DATE;
	self.state_origin				:=	'OR';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	choose(C,L.NAME, L.CO_OWNER);
	self.orig_name_type_code		:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_address_1			:=	L.ADDRESS_1;
	self.orig_city					:=	L.CITY;
	self.orig_state					:=	L.STATE;
	self.orig_zip						:=	L.ZIP;
	self.orig_fips					:=	choose(C, L.FIPS, '');
	self.name_format				:= 	'F';
	tempPrepLastSitus				:= trim(L.CITY,left,right)
															+	IF(trim(L.CITY) <> '',', ','')
															+ trim(L.STATE,left,right)
															+	' ' + trim(StringLib.StringFindReplace(L.ZIP,'-',''),left,right);
	self.prep_address_situs		:= StringLib.StringCleanSpaces(L.ADDRESS_1);
	self.prep_address_last_situs	:= StringLib.StringCleanSpaces(tempPrepLastSitus);
	self := L;
	self := [];
END;

//IF PUBLIC_ASSET_FLAG = 'NO', NAME AND ADDRESS CANNOT BE USED
EXPORT Map_OR_raw_to_Search := (normalize(wDatasetwithflag(PUBLIC_ASSET_FLAG <> 'NO'),2,search_mapping_format(left,counter)))
																(orig_name <> '');