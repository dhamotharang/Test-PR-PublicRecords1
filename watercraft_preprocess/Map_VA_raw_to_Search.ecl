import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// translates va_01.mp Ab intio graph into ECL

process_date := (string8)STD.Date.Today();
Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_VA_clean_in, watercraft.Layout_VA, hull_clean_in)
file_VA_dedup := dedup(sort(hull_clean_in, reg_num, FIRST_NAME, MID, LAST_NAME),reg_num, FIRST_NAME, MID, LAST_NAME);

watercraft.Macro_Is_hull_id_in_MIC(file_VA_dedup, watercraft.Layout_VA, wDatasetwithflag)

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
																																	// trim(L.HULL_ID,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),'')))),' ',''); 
	self.watercraft_key			:=	if(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
	                                if(L.HULL_ID <> '',(trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right)
																			+ trim(L.NAME,left,right))[1..30], if(L.MAKE <> '' and trim(L.YEAR,left,right) = '0', L.REG_NUM, 
																			(trim(L.MAKE,left,right) + trim(L.YEAR,left,right) + trim(L.FIRST_NAME,left,right) + trim(L.MID,left,right)
																			+ trim(L.LAST_NAME,left,right))[1..30])));
	self.sequence_key				:=	trim(L.reg_date, left, right);
	self.state_origin				:=	'VA';
	self.source_code				:=	'AW';
	self.dppa_flag          :=  '';
	self.orig_name					:=	StringLib.StringCleanSpaces(IF(REGEXFIND('^&',L.FIRST_NAME) AND L.LAST_NAME <> '', L.LAST_NAME+' '+L.FIRST_NAME,
																														IF(REGEXFIND(' INC$',L.FIRST_NAME) AND NOT REGEXFIND('^T/A ',L.LAST_NAME), L.LAST_NAME+' '+L.FIRST_NAME,
																																L.FIRST_NAME+' '+L.MID+' '+L.LAST_NAME)));
	self.orig_name_type_code	:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first			:=	L.FIRST_NAME;
	self.orig_name_middle			:=	L.MID;
	self.orig_name_last				:=	L.LAST_NAME;
	self.orig_address_1				:=	L.ADDRESS_1;
	self.orig_address_2				:=	L.ADDRESS2;
	self.orig_city						:=	L.CITY;
	self.orig_state						:=	L.STATE;
	self.orig_zip							:=	L.ZIP;
	self.orig_fips						:=	L.FIPS;
	self.phone_1							:=	L.HOME_PHONE;
	self.phone_2							:=	L.WORK_PHONE;
	self.name_format					:= 'U';
	tempPrepAddress						:= IF(trim(L.ADDRESS_1) <> '' and trim(L.ADDRESS2) <> '', trim(L.ADDRESS_1)+' '+trim(L.ADDRESS2),trim(L.ADDRESS_1));
	tempPrepLastSitus					:= trim(L.CITY,left,right)
															+	IF(trim(L.CITY) <> '',', ','')
															+ trim(L.STATE,left,right)
															+	' ' + trim(StringLib.StringFindReplace(L.ZIP,'-',''),left,right);
	self.prep_address_situs		:= StringLib.StringCleanSpaces(tempPrepAddress);
	self.prep_address_last_situs	:= StringLib.StringCleanSpaces(tempPrepLastSitus);
	self := L;
	self := [];
END; 

EXPORT Map_VA_raw_to_Search := project(wDatasetwithflag,search_mapping_format(left))(orig_name <> '');