import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

process_date := (string8)STD.Date.Today();
Watercraft.Macro_Clean_Hull_ID(watercraft_preprocess.file_WA_clean_in, watercraft.Layout_wa, hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, watercraft.Layout_wa, wDatasetwithflag)

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
	self.watercraft_key			:=	if(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) >= '1972' and L.is_hull_id_in_MIC, trim(L.HULL_ID,left,right),
																				(trim(L.HULL_ID,left,right) + trim(StringLib.stringfilterout(L.MAKE,' '),left,right) + trim(L.YEAR,left,right) + trim(StringLib.stringfilterout(L.NAME,'  ,-/'),left,right))[1..30]);                               
	self.sequence_key				:=	trim(L.REG_DATE,left,right);
	self.state_origin				:=	'WA';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	ClnName2								:= IF(stringlib.stringfilterout(L.Reg_Owner_Name_2, '#-0123456789')= '', '', L.Reg_Owner_Name_2);
	tempName								:= IF(stringlib.stringfind(L.Reg_Owner_Name_2,',',1)>0, trim(L.name,left,right) +' AND ' + trim(ClnName2), 
																	                      trim(L.name,left,right) +' ' + trim(ClnName2));
	self.orig_name					:=	StringLib.StringCleanSpaces(tempName);
	self.orig_name_type_code				:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first			:=	L.FIRST_NAME;
	self.orig_name_middle			:=	L.MID;
	self.orig_name_last				:=	L.LAST_NAME;
	self.orig_address_1				:=	L.ADDRESS_1;
	self.orig_address_2				:=	L.REG_OWNER_ADDRESS_2;
	self.orig_city						:=	L.CITY;
	self.orig_state						:=	L.STATE;
	self.orig_zip							:=	L.ZIP;
	self.orig_fips						:=	L.FIPS;
	self.name_format					:= if(StringLib.stringfind(self.ORIG_NAME,',',1)!=0 , 'L' , 'U');
	tempPrepAddress						:= IF(trim(L.ADDRESS_1) <> '' and trim(L.REG_OWNER_ADDRESS_2) <> '', trim(L.ADDRESS_1)+' '+trim(L.REG_OWNER_ADDRESS_2),trim(L.ADDRESS_1));
	tempPrepLastSitus					:= trim(L.CITY,left,right)
																+	IF(trim(L.CITY) <> '',', ','')
																+ trim(L.STATE,left,right)
																+	' ' + trim(StringLib.StringFindReplace(L.ZIP,'-',''),left,right);
	self.prep_address_situs		:= StringLib.StringCleanSpaces(tempPrepAddress);
	self.prep_address_last_situs	:= StringLib.StringCleanSpaces(tempPrepLastSitus);
	self := L;
	self := [];
END; 

EXPORT Map_WA_raw_to_Search := project(wDatasetwithflag,search_mapping_format(left))(orig_name <> '');