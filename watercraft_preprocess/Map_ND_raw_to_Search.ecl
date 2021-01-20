import watercraft, watercraft_preprocess, ut, lib_StringLib, STD;

// translates  nd_phase01.mp Ab intio graph into ECL

fIn_clean_raw := watercraft_preprocess.file_ND_clean_in;
process_date := (string8)STD.Date.Today();

Watercraft.Macro_Clean_Hull_ID(fIn_clean_raw,Watercraft.layout_ND_20Q3,hull_clean_in)

Watercraft_preprocess.Layout_Watercraft_Search_Common search_mapping_format(hull_clean_in L)
 := TRANSFORM
	IsValidRegDate						:=	STD.DATE.IsValidDate((integer)L.REG_DATE);
 	self.date_first_seen			:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_last_seen				:=	IF(IsValidRegDate AND L.REG_DATE < process_date,L.REG_DATE,'');
	self.date_vendor_first_reported	:=	process_date;
	self.date_vendor_last_reported	:=	process_date;
	// New watercraft_key logic to be implemented at a later date
	// self.watercraft_key			:=	StringLib.StringFindReplace(IF(trim(L.year,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, trim(L.HULL_ID,left,right),
																															// IF(trim(L.REG_NUM) != '',L.STATEABREV + L.REG_NUM + IF(trim(L.year,left,right)<>'0',trim(L.year,left,right),''),
																																	// L.HULL_ID + IF(trim(L.year,left,right)<>'0',trim(L.year,left,right),''))),' ','');
	self.watercraft_key		:=	if(trim(L.YEAR,left,right) >= '1972' and length(trim(L.HULL_ID,left,right)) = 12, trim(L.HULL_ID,left,right),
	                             if(trim(L.HULL_ID,left,right) <> '',(trim(L.HULL_ID,left,right) + trim(L.MAKE,left,right) + trim(L.YEAR,left,right))[1..30],
																	(trim(L.MAKE,left,right) + trim(L.YEAR, left, right) + trim(L.NAME,left,right))[1..30]));
	self.sequence_key			:=	trim(L.REG_DATE,left,right);
	self.state_origin			:=	'ND';
	self.source_code			:=	'AW';
	self.dppa_flag        :=  '';
	self.orig_name				:=	L.NAME;
	self.orig_name_type_code	:=	'O';
	self.orig_name_type_description	:=	'OWNER';
	self.orig_name_first		:=	L.FIRST_NAME;
	self.orig_name_middle		:=	L.MID;
	self.orig_name_last			:=	L.LAST_NAME;
	self.orig_address_1			:=	L.ADDRESS_1;
	self.orig_city					:=	L.CITY;
	self.orig_state					:=	L.STATE;
	self.orig_zip						:=	L.ZIP;
	self.orig_fips					:=	L.FIPS;
	// is_valid_date						:= STD.DATE.IsValidDate((integer)L.OWNER_DOB);
	// self.dob								:=	IF(is_valid_date,L.OWNER_DOB,''); //Removed from layout DOPS-864
	self.name_format				:= 'U';
	tempPrepLastSitus				:= StringLib.StringCleanSpaces(trim(L.CITY,left,right)
																													+	IF(trim(L.CITY) <> '',', ','')
																													+ trim(L.STATE,left,right)
																													+	' ' + trim(StringLib.StringFilterOut(L.ZIP,'-'),left,right));
	self.prep_address_situs				:= StringLib.StringCleanSpaces(L.ADDRESS_1);
	self.prep_address_last_situs	:= tempPrepLastSitus;
	self		:= L;
	self		:= [];
END;

EXPORT Map_ND_raw_to_Search := project(hull_clean_in(Name <> ''),search_mapping_format(left));