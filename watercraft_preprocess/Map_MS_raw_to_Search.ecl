import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;
// translates  ms_phase01.mp Ab intio graph into ECL 
// Name/Address cleaning will be done after all raw files are in one common format to eliminate multiple passes to the cleaner for each source

fIn_clean_raw := watercraft_preprocess.file_MS_clean_in;
process_date := (string8)STD.Date.Today();

Watercraft.Macro_Clean_Hull_ID(fIn_clean_raw,Watercraft.layout_ms_new,hull_clean_in)

Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(hull_clean_in L)
 := transform
	IsValidTransDate					:=	STD.DATE.IsValidDate((integer)L.TRANSACTION_DATE);
	self.date_first_seen			:=	If(IsValidTransDate,L.TRANSACTION_DATE,'');
	self.date_last_seen				:=	If(IsValidTransDate,L.TRANSACTION_DATE,'');
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	//New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	stringlib.StringFindReplace(IF(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12, trim(L.HULL_ID,left,right),
																														// IF(length(trim(L.HULL_ID,left, right)) = 12 and trim(L.year, left, right) = '0', trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM,left,right) <> '', trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																																	// (trim(L.HULL_ID,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30]))),' ',''); 
 self.watercraft_key			:=	if(trim(L.YEAR,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, trim(L.HULL_ID,left,right), if(L.HULL_ID = '',
	                               (trim(L.MAKE,left,right) + trim(L.YEAR,left,right) + trim(L.FIRST_NAME,left,right) + trim(L.MID,left,right)
																	+ trim(L.LAST_NAME,left,right))[1..30], (trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30]));
	self.sequence_key				:=	L.TRANSACTION_DATE;
	self.state_origin				:=	'MS';
	self.source_code				:=	'AW';
	self.dppa_flag          :=  '';
	self.orig_name					:=	L.NAME;
	self.orig_name_type_code	:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first			:=	L.FIRST_NAME;
	self.orig_name_middle			:=	L.MID;
	self.orig_name_last				:=	L.LAST_NAME;
	self.orig_name_suffix			:= L.SUFFIX;												//DF-19984 - Layout change, new field
	self.orig_address_1				:=	trim(L.ADDRESS_1, left, right);
	self.orig_city						:=	L.CITY;
	self.orig_state						:=	L.STATE;
	self.orig_zip							:=	L.ZIP;
	self.orig_fips						:=	L.FIPS;
	self.name_format					:= 'U';
	tempPrepLastSitus					:= StringLib.StringCleanSpaces(trim(L.CITY,left,right)
																													+	IF(trim(L.CITY) <> '',', ','')
																													+ trim(L.STATE,left,right)
																													+	' ' + trim(StringLib.StringFilterOut(L.ZIP,'-'),left,right));
	self.prep_address_situs				:= StringLib.StringCleanSpaces(L.ADDRESS_1);
	self.prep_address_last_situs	:= tempPrepLastSitus;
	self              := L;
	self							:= [];
  end; 

EXPORT Map_MS_raw_to_Search := project(hull_clean_in(Name <> ''),search_mapping_format(left));