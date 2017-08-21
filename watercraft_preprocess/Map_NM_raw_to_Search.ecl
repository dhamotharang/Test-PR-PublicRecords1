import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;

fIn_clean_raw := watercraft_preprocess.file_NM_clean_in;
process_date := (string8)STD.Date.Today();

Watercraft.Macro_Clean_Hull_ID(fIn_clean_raw,Watercraft.layout_nm,hull_clean_in)
watercraft.Macro_Is_hull_id_in_MIC(hull_clean_in, Watercraft.layout_nm, wDatasetwithflag)

Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(wDatasetwithflag L) := TRANSFORM
	IsValidRegDate						:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
 	self.date_first_seen			:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_last_seen				:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	self.watercraft_key				      :=	StringLib.StringFindReplace(IF(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12 and L.is_hull_id_in_MIC, trim(L.HULL_ID,left, right),
																																		IF(length(trim(L.HULL_ID,left,right)) = 12 and trim(L.year,left,right) = '0', trim(L.HULL_ID,left,right),
																																			IF(trim(L.REG_NUM) != '' and L.REG_NUM != '00000000',L.REG_NUM + IF(trim(L.year,left,right)<>'0',trim(L.year,left,right),''),
																																					trim(L.MAKE,left,right) + trim(L.YEAR,left,right) + trim(L.NAME,left,right)))),' ','');
	self.sequence_key				        :=	L.REG_DATE;
	self.state_origin				        :=	'NM';
	self.source_code				        :=	'AW';
	self.dppa_flag                  :=  '';
	self.orig_name					        :=	StringLib.StringCleanSpaces(IF(L.SECONDARY_NAME <> '',L.NAME+' '+L.SECONDARY_NAME, L.NAME));
	self.orig_name_type_code		    :=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_address_1				      :=	L.ADDRESS_1;
	self.orig_city					        :=	L.CITY;
	self.orig_state					        :=	L.STATE;
	self.orig_zip					          :=	L.ZIP;
	self.orig_fips					        :=	L.FIPS;
	self.name_format								:=	'U';
	tempPrepLastSitus								:= StringLib.StringCleanSpaces(trim(L.City,left,right)
																																			+	IF(trim(L.City) <> '',', ','')
																																			+ trim(L.STATE,left,right)
																																			+	' ' + lib_stringlib.StringLib.StringFilter(trim(L.ZIP,left,right),'1234567890'));
	self.prep_address_situs				:= StringLib.StringCleanSpaces(L.Address_1);
	self.prep_address_last_situs	:= tempPrepLastSitus;
	self              := L;
	self							:= [];
 END; 

EXPORT Map_NM_raw_to_Search := project(wDatasetwithflag,search_mapping_format(left))(orig_name <> '');