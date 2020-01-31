import lib_stringlib, watercraft, watercraft_preprocess, ut, STD;

// translates mi_phase01_update.mp Ab intio graph into ECL

fIn_clean_raw := watercraft_preprocess.file_MI_clean_in;
process_date := (string8)STD.Date.Today();

Watercraft.Macro_Clean_Hull_ID(fIn_clean_raw, Watercraft.Layout_mi_new,hull_clean_in)

Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(hull_clean_in L):= TRANSFORM
	IsValidRegDate						:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
 	self.date_first_seen			:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_last_seen				:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	// New watercraft_key logic to be implemented at a later date
	// self.watercraft_key		:=	stringlib.StringFindReplace(IF(trim(L.year, left, right) >= '1972' and length(trim(L.HULL_ID,left, right)) = 12, trim(L.HULL_ID,left,right),
																													// IF(length(trim(L.HULL_ID,left, right)) = 12 and trim(L.year, left, right) = '0', trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM,left,right) <> '', L.STATEABREV+trim(L.REG_NUM,left,right)+IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''),
																																	// (trim(L.HULL_ID,left,right)+ IF(trim(L.YEAR,left,right)<>'0',trim(L.YEAR,left,right),''))[1..30]))),' ','');
	self.watercraft_key			:=	if(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, trim(L.HULL_ID,left,right),
																if(L.HULL_ID = '', trim(L.Reg_num,left,right), (trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right)
																	+ trim(L.NAME,left,right))[1..30]));
	self.sequence_key				:=	trim(L.reg_date,left,right);
	self.state_origin				:=	'MI';
	self.source_code				:=	'AW';
	self.dppa_flag					:=	'';
	self.orig_name					:=	L.NAME;
	self.orig_name_type_code	:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_address_1			:=	L.ADDRESS_1;
	self.orig_city					:=	L.CITY;
	self.orig_state					:=	L.STATE;
	self.orig_zip						:=	L.ZIP;
	self.orig_fips					:=	L.FIPS;
	self.name_format					:= 'U';
	self.prep_address_situs		:= StringLib.StringCleanSpaces(L.Address_1);
	tempPrepLastSitus					:= trim(L.CITY,left,right)
															+	IF(trim(L.CITY) <> '',', ','')
															+ trim(L.STATE,left,right)
															+	' ' + trim(StringLib.StringFindReplace(L.ZIP,'-',''),left,right);
	self.prep_address_last_situs	:= StringLib.StringCleanSpaces(tempPrepLastSitus);
	self := L;
	self := [];
  end; 

EXPORT Map_MI_raw_to_Search := project(hull_clean_in(Name <> ''),search_mapping_format(left));